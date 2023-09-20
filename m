Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0F67A7A2A
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbjITLNS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjITLNR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:13:17 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC729E
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:13:11 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3CDBF5C009B;
        Wed, 20 Sep 2023 07:13:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 20 Sep 2023 07:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1695208386; x=1695294786; bh=Iy
        oUrb2E/wdG2Z6CTe+KIRXfqzJpMi+7OXZNtyCYm5I=; b=Wr5etgd3AfGPZb4Ife
        C4Vf0ytKHjtix5iJ74MdeOuW4fLTas8ZCFbbWF0Ce5PJCIA9ZCMDOqYVh4+bRgzb
        xv19Rh5VNuGljp8YTfNbpZMNiYp/+J2ErjZ31oa6IrMy9Z6HifjDSozTjcXPlGaF
        0i9+a4LpphawNhJpo2/25cosOA7VLhOd67e1HwUv6uGRkDNLFJDTzyRyWrTywCzj
        jq3LPNvDCPHA4WC6svQRrnmt5d4OxKLnp9EGmaMoAUn0bNbG1BNDt2gVGWP5wKnl
        /1wCgMVBB8+cbfkGT1NsDp2JE9pcLRefdQVfx/YcSEF+rYbQGM+KfmCSaPBMg3Dy
        eJ9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695208386; x=1695294786; bh=IyoUrb2E/wdG2
        Z6CTe+KIRXfqzJpMi+7OXZNtyCYm5I=; b=ROVxQryxUhdtKc5RV1/1yqIqOQmNW
        GuTl1DxgG1alRwgS1On3krrsWoALwlkJVbO+znEw9khD8NjdnRyBFQeMy+cbEbHw
        /GjHLO8xo0b/DJuAr9A6EUj8IrHnX9yDG2k2BPg0/VRkd+vAoOuUzd2FtmtyQXr6
        G/ZPbjU19UqgUtR2o71U3oZAo6EOABL12lBcQ43b7wFz88AVL9JYI6iXrBKQSCuO
        G0xy5gYMNYuS/stnucCERSbUtLE/V5yrg+5NGbvJ3lJR0WSayCyboH3U5L1UbF56
        TM/nKDBfu7lR7xmL6dY+BRTpTyrYUVGpwQed7RZ7HrPOz8EU33v300i3Q==
X-ME-Sender: <xms:wdMKZah15wMhlz7Etu_JIuREMu1fAAehU_QmCeB_jbbwgSrjJOB-_Q>
    <xme:wdMKZbAkGAxKuQpQlXWbDxhxs0bvfDGJyJyPZnvnqbWM62pT0omAlmEus8aoEicS9
    0raUQqUN3P9HA>
X-ME-Received: <xmr:wdMKZSEX3kC2hiVcHsNZ-gUm4b9ERCp6S16T2uEnAQ2L3g1BCdFZw0bBzUBU0JtPNGZtIIrTV3w0p8SwxXdF0i8vyoFBUHISRYwim9Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekfedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepleeite
    evieefteelfeehveegvdetveehgffhvdejffdvleevhfffgeffffejlefgnecuffhomhgr
    ihhnpehfrhgvvgguvghskhhtohhprdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:wtMKZTTrplw4AHALt7AaYdHwKOU1qXwpn5PRMmNChsgK_Ne-I4YA6A>
    <xmx:wtMKZXyhlpI-rf0JrnshVvDVxBNqJGHRX10NEycOlDBZEq6cfq8mRw>
    <xmx:wtMKZR7GbqY-UjDb7SeC62CR8cs9lud36DJqADSk7VgQPEAvUpmoLg>
    <xmx:wtMKZZush_xZH_7BFzY8ts5q76XEERhLtBlkxZ013k3_hU-aztUKzQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Sep 2023 07:13:05 -0400 (EDT)
Date:   Wed, 20 Sep 2023 13:13:03 +0200
From:   Greg KH <greg@kroah.com>
To:     Melissa Wen <mwen@igalia.com>
Cc:     stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 5.10.y] drm/amd/display: enable cursor degamma for DCN3+
 DRM legacy gamma
Message-ID: <2023092056-parrot-angular-6156@gregkh>
References: <2023091622-outpost-audio-2222@gregkh>
 <20230919165936.1256007-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919165936.1256007-1-mwen@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Sep 19, 2023 at 03:59:36PM -0100, Melissa Wen wrote:
> For DRM legacy gamma, AMD display manager applies implicit sRGB degamma
> using a pre-defined sRGB transfer function. It works fine for DCN2
> family where degamma ROM and custom curves go to the same color block.
> But, on DCN3+, degamma is split into two blocks: degamma ROM for
> pre-defined TFs and `gamma correction` for user/custom curves and
> degamma ROM settings doesn't apply to cursor plane. To get DRM legacy
> gamma working as expected, enable cursor degamma ROM for implict sRGB
> degamma on HW with this configuration.
> 
> Cc: stable@vger.kernel.org
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2803
> Fixes: 96b020e2163f ("drm/amd/display: check attr flag before set cursor degamma on DCN3+")
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit 57a943ebfcdb4a97fbb409640234bdb44bfa1953)
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Both now queued up, thanks.

greg k-h
