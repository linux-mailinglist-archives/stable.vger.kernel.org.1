Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BED76B998
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 18:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjHAQZI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 12:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjHAQZH (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 12:25:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AD010DB
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:25:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5550561600
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 16:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4DFC433C8;
        Tue,  1 Aug 2023 16:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690907105;
        bh=LoKNJ2BMyi/OtcoBw7epACKA0HU0cM4zgizJ4cGtTXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jQXpUgKGI9/NSHbCFYQLtO/ql3CpoYIe66plI0haGDwNQBfq9KVWZB1ZzZ1WQLazJ
         8DPavaOIw0BV0aEQgLixfOmVmgENoLqFJs0Ytpq30T32F2YKvc0/h+G2RK3WnoCeY6
         4jsH+L8OMEef+Dg5GbSJcooSXz0Nc1JhQDq9pXNM=
Date:   Tue, 1 Aug 2023 18:25:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     stable@vger.kernel.org, juan.hao@nxp.com,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] drm/imx/ipuv3: Fix front porch adjustment upon hactive
 aligning
Message-ID: <2023080150-crystal-uncanny-6de1@gregkh>
References: <20230801145353.515136-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230801145353.515136-1-christian.koenig@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 01, 2023 at 04:53:53PM +0200, Christian König wrote:
> From: Alexander Stein <alexander.stein@ew.tq-group.com>
> 
> When hactive is not aligned to 8 pixels, it is aligned accordingly and
> hfront porch needs to be reduced the same amount. Unfortunately the front
> porch is set to the difference rather than reducing it. There are some
> Samsung TVs which can't cope with a front porch of instead of 70.
> 
> Fixes: 94dfec48fca7 ("drm/imx: Add 8 pixel alignment fix")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> Link: https://lore.kernel.org/r/20230515072137.116211-1-alexander.stein@ew.tq-group.com
> [p.zabel@pengutronix.de: Fixed subject]
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Link: https://patchwork.freedesktop.org/patch/msgid/20230515072137.116211-1-alexander.stein@ew.tq-group.com
> ---
>  drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
