Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528C7771997
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 07:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjHGFvj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 01:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjHGFvh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 01:51:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245411708
        for <stable@vger.kernel.org>; Sun,  6 Aug 2023 22:51:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6E21614AD
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 05:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D34C433C8;
        Mon,  7 Aug 2023 05:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691387495;
        bh=Wf5Z0fFLqqSIJ5ZONfSVKK3v4jEC+Ehx6aDxf75caQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GCZ4thkAyOpvFxkKOkf8yDsyLgdRhHO+fUsJ/YiwFYXxSQUn+auR30R3PmChYkUlE
         5tzML9D3mK+TrDerTlIVMobguyGwDgI2FK6dx/LngjFYkwWl6I8a9NJCO64/ihjmrX
         BwpcZPhps1jcM8hc2btj+aoVCNKyG8zqOSU18NWs=
Date:   Mon, 7 Aug 2023 07:51:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     tiancyin <tianci.yin@amd.com>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] Revert "drm/amd/display: Remove Phantom Pipe Check
 When Calculating K1 and K2"
Message-ID: <2023080727-constant-recreate-8742@gregkh>
References: <20230807021812.2797828-1-tianci.yin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807021812.2797828-1-tianci.yin@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 07, 2023 at 10:18:12AM +0800, tiancyin wrote:
> This reverts commit a2ef3163c3604788abdc060cab74c95ed44fec1a.
> ---
>  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> index f5fa7abd97fc..2f4afe40f3e6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> @@ -1165,6 +1165,10 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
>  	unsigned int odm_combine_factor = 0;
>  	bool two_pix_per_container = false;
>  
> +	// For phantom pipes, use the same programming as the main pipes
> +	if (pipe_ctx->stream->mall_stream_config.type == SUBVP_PHANTOM) {
> +		stream = pipe_ctx->stream->mall_stream_config.paired_stream;
> +	}
>  	two_pix_per_container = optc2_is_two_pixels_per_containter(&stream->timing);
>  	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
>  
> -- 
> 2.34.1
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
