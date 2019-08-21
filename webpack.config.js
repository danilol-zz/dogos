const path = require('path');
const webpack = require('webpack');

module.exports = env => {
  const production = env && env.production || false;

  function debuggerEnabled(prod) {
    return prod ? false : true
  };

  return {
    module: {
        rules: [
            {
                test: /\.html$/,
                exclude: /node_modules/,
                loader: 'file-loader?name=[name].[ext]'
            },
            {
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                use: [
                    { loader: 'elm-hot-webpack-loader'},
                    { loader: 'elm-webpack-loader',
                        options: {
                            cwd: __dirname,
                            debug: debuggerEnabled(production)
                        }
                    }
                ]
            }
        ]
    },


    plugins: [
        new webpack.HotModuleReplacementPlugin(),
    ],

    mode: 'development',

    devServer: {
        proxy: {
          '/dog/api': {
            target: 'https://dog.ceo/api',
            pathRewrite: {'^/dog/api' : ''},
            changeOrigin: true
          }
        },
        inline: true,
        hot: true,
        compress: true,
        stats: 'errors-only',
        historyApiFallback: true,
    }
  };
};
