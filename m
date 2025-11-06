Return-Path: <stable+bounces-192609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AACCC3B2D2
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 14:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303981882A98
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 13:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B4A32C934;
	Thu,  6 Nov 2025 13:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XWtX5WTa"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E6C22422A;
	Thu,  6 Nov 2025 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435046; cv=none; b=mAs84CwLSmw1arzavWhcIhRdnDMCF2c/9PFgbYQSBZZ21H5G6W+5iLSB6LODB/xhl3rZaWM/UfBP66QdnqxTY2rlWwwY/b2CSLD9onPi/d3FcMQ5cvGt7ReVxdTi4nIzOjm7MB71U1rnlXD3y/X9jagWrQ3XQz5z2g0DuOmEEZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435046; c=relaxed/simple;
	bh=IXa1i3A8NXJiYQDWMNHOGhYgHY3CQC49HK3blIHgKSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpa4ahaIAu/fwAesIpy0O+wKT78u5K2jTGi8pvtOU4kslbVIarz1v7Bqq0kyiQlZYFjfLVmwPUxK8Szq6MZTKj1Or0k+8/AHbwaSgEoQo9wRJNxTDFo/h4kyENDY7+sVJfAO7K0TfJgK4p8b2bveakXwWnWrSlGx+wD86Gjj/pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=XWtX5WTa; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=H6vP8RSVqf2hz8E0hIyEhAsuLZ2rzeEouiAOCljNqeA=; b=XWtX5WTa0nHt5ZnaEzkeBwasMR
	6BvVzz7LGAfgV1efz2CTzCELc2AbNwM3P0HoR1oLzNlyf2yY/AC6f9Mxfn6YbSOydx/Zj6go+YSnD
	D9S8BnZCPUKHn/WoAjmBvXbr6GUZ4a4z5awgWyI7Ed6E1oIGF0tSim3h8FMbREh4C7qGVMlYAV+Dq
	s2VOAWrPUXBuF0L8y2xJAc9Wuz7t7dk5bXNw1NN7sqfHBgvVbQhPMP5W4eqmsW3rHrim8jfIAUAP2
	zsHtkU456aaEqzcyj1J4KsXrgVuQVOqxxpQI0+sdtfz4BB5obbu47bkXh4AyQbB6oNwoJWGrAe1RT
	5dmk1T+g==;
Received: from [186.208.74.26] (helo=[192.168.18.14])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vGzrc-0030NS-46; Thu, 06 Nov 2025 14:17:20 +0100
Message-ID: <3aaf35bc-3595-45af-bd20-aaa5c9401959@igalia.com>
Date: Thu, 6 Nov 2025 10:17:16 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "drm/amd/display: change dc stream color settings only in
 atomic commit" has been added to the 6.17-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20251104235338.370388-1-sashal@kernel.org>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20251104235338.370388-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sasha,

Same here, can you backport the previous related commit (2f9c63883730 
"drm/amd/display: update color on atomic commit time" [1])  too?
Otherwise, the commit below alone will cause regressions.

Thanks,

Melissa

[1] 
https://github.com/torvalds/linux/commit/2f9c63883730a0bfecb086e6e59246933f936ca1

On 04/11/2025 20:53, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>
>      drm/amd/display: change dc stream color settings only in atomic commit
>
> to the 6.17-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>       drm-amd-display-change-dc-stream-color-settings-only.patch
> and it can be found in the queue-6.17 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
>
> commit 87fe0b67d6d8340123e563e7156fbdf070a2954d
> Author: Melissa Wen <mwen@igalia.com>
> Date:   Thu Sep 11 14:21:20 2025 -0300
>
>      drm/amd/display: change dc stream color settings only in atomic commit
>      
>      [ Upstream commit 51cb93aa0c4a9bb126b76f6e9fd640d88de25cee ]
>      
>      Don't update DC stream color components during atomic check. The driver
>      will continue validating the new CRTC color state but will not change DC
>      stream color components. The DC stream color state will only be
>      programmed at commit time in the `atomic_setup_commit` stage.
>      
>      It fixes gamma LUT loss reported by KDE users when changing brightness
>      quickly or changing Display settings (such as overscan) with nightlight
>      on and HDR. As KWin can do a test commit with color settings different
>      from those that should be applied in a non-test-only commit, if the
>      driver changes DC stream color state in atomic check, this state can be
>      eventually HW programmed in commit tail, instead of the respective state
>      set by the non-blocking commit.
>      
>      Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4444
>      Reported-by: Xaver Hugl <xaver.hugl@gmail.com>
>      Signed-off-by: Melissa Wen <mwen@igalia.com>
>      Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index d66c9609efd8d..60eb2c2c79b77 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -11105,7 +11105,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   	if (dm_new_crtc_state->base.color_mgmt_changed ||
>   	    dm_old_crtc_state->regamma_tf != dm_new_crtc_state->regamma_tf ||
>   	    drm_atomic_crtc_needs_modeset(new_crtc_state)) {
> -		ret = amdgpu_dm_update_crtc_color_mgmt(dm_new_crtc_state);
> +		ret = amdgpu_dm_check_crtc_color_mgmt(dm_new_crtc_state, true);
>   		if (ret)
>   			goto fail;
>   	}
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index c18a6b43c76f6..42801caf57b69 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -1037,6 +1037,8 @@ void amdgpu_dm_init_color_mod(void);
>   int amdgpu_dm_create_color_properties(struct amdgpu_device *adev);
>   int amdgpu_dm_verify_lut_sizes(const struct drm_crtc_state *crtc_state);
>   int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc);
> +int amdgpu_dm_check_crtc_color_mgmt(struct dm_crtc_state *crtc,
> +				    bool check_only);
>   int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
>   				      struct drm_plane_state *plane_state,
>   				      struct dc_plane_state *dc_plane_state);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index c0dfe2d8b3bec..d4739b6334c24 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -566,12 +566,11 @@ static int __set_output_tf(struct dc_transfer_func *func,
>   	return res ? 0 : -ENOMEM;
>   }
>   
> -static int amdgpu_dm_set_atomic_regamma(struct dc_stream_state *stream,
> +static int amdgpu_dm_set_atomic_regamma(struct dc_transfer_func *out_tf,
>   					const struct drm_color_lut *regamma_lut,
>   					uint32_t regamma_size, bool has_rom,
>   					enum dc_transfer_func_predefined tf)
>   {
> -	struct dc_transfer_func *out_tf = &stream->out_transfer_func;
>   	int ret = 0;
>   
>   	if (regamma_size || tf != TRANSFER_FUNCTION_LINEAR) {
> @@ -885,33 +884,33 @@ int amdgpu_dm_verify_lut_sizes(const struct drm_crtc_state *crtc_state)
>   }
>   
>   /**
> - * amdgpu_dm_update_crtc_color_mgmt: Maps DRM color management to DC stream.
> + * amdgpu_dm_check_crtc_color_mgmt: Check if DRM color props are programmable by DC.
>    * @crtc: amdgpu_dm crtc state
> + * @check_only: only check color state without update dc stream
>    *
> - * With no plane level color management properties we're free to use any
> - * of the HW blocks as long as the CRTC CTM always comes before the
> - * CRTC RGM and after the CRTC DGM.
> - *
> - * - The CRTC RGM block will be placed in the RGM LUT block if it is non-linear.
> - * - The CRTC DGM block will be placed in the DGM LUT block if it is non-linear.
> - * - The CRTC CTM will be placed in the gamut remap block if it is non-linear.
> + * This function just verifies CRTC LUT sizes, if there is enough space for
> + * output transfer function and if its parameters can be calculated by AMD
> + * color module. It also adjusts some settings for programming CRTC degamma at
> + * plane stage, using plane DGM block.
>    *
>    * The RGM block is typically more fully featured and accurate across
>    * all ASICs - DCE can't support a custom non-linear CRTC DGM.
>    *
>    * For supporting both plane level color management and CRTC level color
> - * management at once we have to either restrict the usage of CRTC properties
> - * or blend adjustments together.
> + * management at once we have to either restrict the usage of some CRTC
> + * properties or blend adjustments together.
>    *
>    * Returns:
> - * 0 on success. Error code if setup fails.
> + * 0 on success. Error code if validation fails.
>    */
> -int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
> +
> +int amdgpu_dm_check_crtc_color_mgmt(struct dm_crtc_state *crtc,
> +				    bool check_only)
>   {
>   	struct dc_stream_state *stream = crtc->stream;
>   	struct amdgpu_device *adev = drm_to_adev(crtc->base.state->dev);
>   	bool has_rom = adev->asic_type <= CHIP_RAVEN;
> -	struct drm_color_ctm *ctm = NULL;
> +	struct dc_transfer_func *out_tf;
>   	const struct drm_color_lut *degamma_lut, *regamma_lut;
>   	uint32_t degamma_size, regamma_size;
>   	bool has_regamma, has_degamma;
> @@ -940,6 +939,14 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
>   	crtc->cm_has_degamma = false;
>   	crtc->cm_is_degamma_srgb = false;
>   
> +	if (check_only) {
> +		out_tf = kvzalloc(sizeof(*out_tf), GFP_KERNEL);
> +		if (!out_tf)
> +			return -ENOMEM;
> +	} else {
> +		out_tf = &stream->out_transfer_func;
> +	}
> +
>   	/* Setup regamma and degamma. */
>   	if (is_legacy) {
>   		/*
> @@ -954,8 +961,8 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
>   		 * inverse color ramp in legacy userspace.
>   		 */
>   		crtc->cm_is_degamma_srgb = true;
> -		stream->out_transfer_func.type = TF_TYPE_DISTRIBUTED_POINTS;
> -		stream->out_transfer_func.tf = TRANSFER_FUNCTION_SRGB;
> +		out_tf->type = TF_TYPE_DISTRIBUTED_POINTS;
> +		out_tf->tf = TRANSFER_FUNCTION_SRGB;
>   		/*
>   		 * Note: although we pass has_rom as parameter here, we never
>   		 * actually use ROM because the color module only takes the ROM
> @@ -963,16 +970,12 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
>   		 *
>   		 * See more in mod_color_calculate_regamma_params()
>   		 */
> -		r = __set_legacy_tf(&stream->out_transfer_func, regamma_lut,
> +		r = __set_legacy_tf(out_tf, regamma_lut,
>   				    regamma_size, has_rom);
> -		if (r)
> -			return r;
>   	} else {
>   		regamma_size = has_regamma ? regamma_size : 0;
> -		r = amdgpu_dm_set_atomic_regamma(stream, regamma_lut,
> +		r = amdgpu_dm_set_atomic_regamma(out_tf, regamma_lut,
>   						 regamma_size, has_rom, tf);
> -		if (r)
> -			return r;
>   	}
>   
>   	/*
> @@ -981,6 +984,43 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
>   	 * have to place the CTM in the OCSC in that case.
>   	 */
>   	crtc->cm_has_degamma = has_degamma;
> +	if (check_only)
> +		kvfree(out_tf);
> +
> +	return r;
> +}
> +
> +/**
> + * amdgpu_dm_update_crtc_color_mgmt: Maps DRM color management to DC stream.
> + * @crtc: amdgpu_dm crtc state
> + *
> + * With no plane level color management properties we're free to use any
> + * of the HW blocks as long as the CRTC CTM always comes before the
> + * CRTC RGM and after the CRTC DGM.
> + *
> + * - The CRTC RGM block will be placed in the RGM LUT block if it is non-linear.
> + * - The CRTC DGM block will be placed in the DGM LUT block if it is non-linear.
> + * - The CRTC CTM will be placed in the gamut remap block if it is non-linear.
> + *
> + * The RGM block is typically more fully featured and accurate across
> + * all ASICs - DCE can't support a custom non-linear CRTC DGM.
> + *
> + * For supporting both plane level color management and CRTC level color
> + * management at once we have to either restrict the usage of CRTC properties
> + * or blend adjustments together.
> + *
> + * Returns:
> + * 0 on success. Error code if setup fails.
> + */
> +int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
> +{
> +	struct dc_stream_state *stream = crtc->stream;
> +	struct drm_color_ctm *ctm = NULL;
> +	int ret;
> +
> +	ret = amdgpu_dm_check_crtc_color_mgmt(crtc, false);
> +	if (ret)
> +		return ret;
>   
>   	/* Setup CRTC CTM. */
>   	if (crtc->base.ctm) {


