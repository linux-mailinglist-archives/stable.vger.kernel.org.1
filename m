Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF8F789C66
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 10:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjH0Iz3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 04:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjH0IzC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 04:55:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FBFA3
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 01:54:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62E8E62A62
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 08:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7532DC433C8;
        Sun, 27 Aug 2023 08:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693126498;
        bh=X2jlcvmDhMhiuQi0w1b5m5JVjT7lezYm4dF8/XOQMuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=knhAmTisyG2o/Ux2EDgpqGzKqNUcm6x1lMA2cMhrkXuCtp11iagPZHVkrFG3dci1+
         TLkqU17GndOSVekW/yacEFJzCx5MLABmlTeygfOyIaxBILiiATpIiob5wEIi77e2ld
         9LvwApLstP/JIHziEDHI7B7bj6D53+dKv4ZDlTqs=
Date:   Sun, 27 Aug 2023 10:54:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     stable@vger.kernel.org, yibin.ding@unisoc.com,
        ulf.hansson@linaro.org
Subject: Re: [PATCH 4.19] mmc: block: Fix in_flight[issue_type] value error
Message-ID: <2023082745-commodore-subdued-84a8@gregkh>
References: <2023082118-donation-clench-604d@gregkh>
 <9aa71735-a941-dc24-e04b-529d6092e340@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9aa71735-a941-dc24-e04b-529d6092e340@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 23, 2023 at 08:12:32PM +0300, Adrian Hunter wrote:
> From: Yibin Ding <yibin.ding@unisoc.com>
> 
> commit 4b430d4ac99750ee2ae2f893f1055c7af1ec3dc5 upstream.
> 
> For a completed request, after the mmc_blk_mq_complete_rq(mq, req)
> function is executed, the bitmap_tags corresponding to the
> request will be cleared, that is, the request will be regarded as
> idle. If the request is acquired by a different type of process at
> this time, the issue_type of the request may change. It further
> caused the value of mq->in_flight[issue_type] to be abnormal,
> and a large number of requests could not be sent.
> 
> p1:					      p2:
> mmc_blk_mq_complete_rq
>   blk_mq_free_request
> 					      blk_mq_get_request
> 					        blk_mq_rq_ctx_init
> mmc_blk_mq_dec_in_flight
>   mmc_issue_type(mq, req)
> 
> This strategy can ensure the consistency of issue_type
> before and after executing mmc_blk_mq_complete_rq.
> 
> Fixes: 81196976ed94 ("mmc: block: Add blk-mq support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yibin Ding <yibin.ding@unisoc.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Link: https://lore.kernel.org/r/20230802023023.1318134-1-yunlong.xing@unisoc.com
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> (cherry picked from commit 4b430d4ac99750ee2ae2f893f1055c7af1ec3dc5)
> (backport to 4.19.y)
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/block.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Now queued up, thanks.

greg k-h
