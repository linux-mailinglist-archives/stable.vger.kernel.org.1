Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5145B79E1DC
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 10:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjIMITj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 04:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjIMITi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 04:19:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EC0193
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 01:19:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0B8C433C8;
        Wed, 13 Sep 2023 08:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694593172;
        bh=ZHtUM2cgekQyd9YvWDqy/Dy1SbNbH4CGXG8FQCWGIFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C3uwE7h8JJIQof1/uV7d5TOy9qwd26j0FCGzZ6EHkj/2D2wGiPzt5dlyriBf4eo6o
         AQmnWDMfzZscaIcIi8D6XQrrxXdlcathnY2PKhDYsiU0GExEw2hy1xDPbcjfm18M85
         TlRuUzB4FvEGZNS36IZUhu7QbwH0ImlHsaLflbkM=
Date:   Wed, 13 Sep 2023 10:19:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/3] stable-6.4 io_uring patches
Message-ID: <2023091309-unshaken-purple-62d0@gregkh>
References: <cover.1694479828.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694479828.git.asml.silence@gmail.com>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Sep 12, 2023 at 02:55:21PM +0100, Pavel Begunkov wrote:
> Recently failed to apply io_uring stable-6.4 patches.
> 
> Jens Axboe (1):
>   io_uring: cleanup io_aux_cqe() API
> 
> Pavel Begunkov (2):
>   io_uring/net: don't overflow multishot accept
>   io_uring/net: don't overflow multishot recv
> 
>  io_uring/io_uring.c | 4 +++-
>  io_uring/io_uring.h | 2 +-
>  io_uring/net.c      | 9 ++++-----
>  io_uring/poll.c     | 4 ++--
>  io_uring/timeout.c  | 4 ++--
>  5 files changed, 12 insertions(+), 11 deletions(-)
> 

Thanks for this, but 6.4.y just went end-of-life.

I've queued up all the other backports you submitted, many thanks for
those!

greg k-h
