Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862C67697DC
	for <lists+stable@lfdr.de>; Mon, 31 Jul 2023 15:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjGaNlI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 31 Jul 2023 09:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjGaNlH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 31 Jul 2023 09:41:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5F71708
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 06:41:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3CED61156
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 13:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A08C433C7;
        Mon, 31 Jul 2023 13:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690810865;
        bh=Hj1VYcKSA6+SV2Ce2RzIqD16QSB4/PxoNnIY+v3aDGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F6dPMwfJyl3tdvC/scMrDL+njURq21SbHpicWmAs6zy5Z+DwTBAxfwBL8hJZdTADc
         Oq9hJOS2D7rH7yx4wXmnjYPyff5htq+zhClosObCWHr3NZDJqGaDqwt5DJQYmM+66z
         BohQLcDgX9Ev7amV3g8nlbI/+RmVfu+DPDMB65Xk=
Date:   Mon, 31 Jul 2023 15:41:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     stable@vger.kernel.org, juan.hao@nxp.com,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH] dma-buf: keep the signaling time of merged fences v3
Message-ID: <2023073148-bobsled-yeah-11ec@gregkh>
References: <20230731124726.480878-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230731124726.480878-1-christian.koenig@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 31, 2023 at 02:47:26PM +0200, Christian König wrote:
> Some Android CTS is testing if the signaling time keeps consistent
> during merges.
> 
> v2: use the current time if the fence is still in the signaling path and
> the timestamp not yet available.
> v3: improve comment, fix one more case to use the correct timestamp
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/20230630120041.109216-1-christian.koenig@amd.com
> Cc: <stable@vger.kernel.org> # v6.0+
> ---
>  drivers/dma-buf/dma-fence-unwrap.c | 26 ++++++++++++++++++++++----
>  drivers/dma-buf/dma-fence.c        |  5 +++--
>  drivers/gpu/drm/drm_syncobj.c      |  2 +-
>  include/linux/dma-fence.h          |  2 +-
>  4 files changed, 27 insertions(+), 8 deletions(-)


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
