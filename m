Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA95771996
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 07:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjHGFvV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 01:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjHGFvU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 01:51:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229731703
        for <stable@vger.kernel.org>; Sun,  6 Aug 2023 22:51:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2678614BA
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 05:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9520C433C8;
        Mon,  7 Aug 2023 05:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691387478;
        bh=VWN/fpp68UamOpmnPxda5kLHMSes9C57Gow9+1Yyf/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rvWPxk7Uv2BQ0Fm2nHxH2ffBfD+hTEVDK6KuZEJ3pm/htsYzay7fQJV+vTMs9PggE
         Spckd620vIUUTkaiG4U2xZA1RpT79t+kOh9QvmowVbV3zbEdnqW3Rx4jT534MDtBNf
         YsRU4twUsAWNyJQ013Yfn6UDrhuyBEddPl/RQ5dk=
Date:   Mon, 7 Aug 2023 07:51:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     tiancyin <tianci.yin@amd.com>
Cc:     stable@vger.kernel.org,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 6.1.y 01/10] drm/amd/display: Handle virtual hardware
 detect
Message-ID: <2023080752-crazy-cider-ef9e@gregkh>
References: <20230807022055.2798020-1-tianci.yin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807022055.2798020-1-tianci.yin@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 07, 2023 at 10:20:46AM +0800, tiancyin wrote:
> From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> 
> If virtual hardware is detected, there is no reason to run the full
> dc_commit_streams process, and DC can return true immediately.
> 
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 8f9c60ed6f8b..9b7ddd0e10a5 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1942,6 +1942,9 @@ enum dc_status dc_commit_streams(struct dc *dc,
>  	struct pipe_ctx *pipe;
>  	bool handle_exit_odm2to1 = false;
>  
> +	if (dc->ctx->dce_environment == DCE_ENV_VIRTUAL_HW)
> +		return res;
> +
>  	if (!streams_changed(dc, streams, stream_count))
>  		return res;
>  
> -- 
> 2.34.1
> 

For this whole series:

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

Please fix up and resend.
