const path = require('path');
const webpack = require('webpack');

module.exports = {
  node: { fs: 'empty' },
  devtool: 'source-map',
  module: {
    rules: [
      {
        test: /\.js$/,
        loader: 'babel-loader',
        include: [path.resolve('src'), path.resolve('test')],
        options: {
          cacheDirectory: true
        }
      }
    ]
  },
  // always emit one chunk only
  plugins: [new webpack.optimize.LimitChunkCountPlugin({ maxChunks: 0 })]
};
