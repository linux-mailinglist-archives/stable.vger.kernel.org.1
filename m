Return-Path: <stable+bounces-166703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7D5B1C79A
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 16:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FCBA7A83DE
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 14:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C5F28C5BF;
	Wed,  6 Aug 2025 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoW9t/8L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E0B38FB9
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754490442; cv=none; b=BdUutVA3QNw6+6vmP6xeNzBt+Cin2hBz+uxyp/A+LvU1sm5lqWjnIY8VuFOZplSqb2xShrvTmtF8Hm1e3mcuHuEwtaLJwpQRGm2GYntSAKCwd7cjMzkDvXS1U5aAggXIvFrqu8UIxCNWDAnVz2RBmAoyhzwTpCVtoK++dCPlrbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754490442; c=relaxed/simple;
	bh=ZGr+jEv9FRCKPkg7vaCKkIT4md9W6Y7/qdO1PFFaA64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ntzA3hkLkXE+vLS/E1Er0ESr5X+3LzHgTl9cmNOybv3XW/1lx8SiYCYoubhtD8IR37H+QymgfnNikFKGbAtlr1bZqg0aPnK2W1cf0EcfIo4je3CzrT00dTqOqSMFTrbCnvFIsG8PA1q05hUnI7KU9rd22ZJZgHk2zOYMvGZKfXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoW9t/8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC61AC4CEEB;
	Wed,  6 Aug 2025 14:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754490442;
	bh=ZGr+jEv9FRCKPkg7vaCKkIT4md9W6Y7/qdO1PFFaA64=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eoW9t/8LTvJ8Ynl4Cj7n71g99gF4xCXqB9fgJQvztXANA91WhOoAnu7d/x6iPmK3D
	 DDihwnWoy0EQVyLcEJW5xFLS2lEOj7oVbDj4u4qQ7PzIHfubabJOP0IteuLpwKZkIP
	 ee2f49JVPYmNbPrZubvDnpLGjeI4OZRFx44he4NNMgw+LewwN/7oHuEIPs6Z8J40Oo
	 8KNKCbVUw/Ph7Grnr5rRXS3FVQ1DL55mjFVpwFJnBTXrPLf4dELLMaya/htXE2r3Qn
	 eehedp/0jgdix50nBgfa5muzYe7qqv+0ElPBplMXmyYshr46XheJzyANeJW0Fx59ku
	 AbafmDwlU4TdA==
Message-ID: <08d968d7-66e6-415c-91fe-9ea6c8e60c67@kernel.org>
Date: Wed, 6 Aug 2025 09:27:20 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/discovery: fix fw based ip discovery
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20250730155900.22657-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250730155900.22657-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/2025 10:59 AM, Alex Deucher wrote:
> We only need the fw based discovery table for sysfs.  No
> need to parse it.  Additionally parsing some of the board
> specific tables may result in incorrect data on some boards.
> just load the binary and don't parse it on those boards.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4441
> Fixes: 80a0e8282933 ("drm/amdgpu/discovery: optionally use fw based ip discovery")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 72 ++++++++++---------
>   2 files changed, 41 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index efe98ffb679a4..b2538cff222ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2570,9 +2570,6 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
>   
>   	adev->firmware.gpu_info_fw = NULL;
>   
> -	if (adev->mman.discovery_bin)
> -		return 0;
> -
>   	switch (adev->asic_type) {
>   	default:
>   		return 0;
> @@ -2594,6 +2591,8 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
>   		chip_name = "arcturus";
>   		break;
>   	case CHIP_NAVI12:
> +		if (adev->mman.discovery_bin)
> +			return 0;
>   		chip_name = "navi12";
>   		break;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 81b3443c8d7f4..27bd7659961e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2555,40 +2555,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   
>   	switch (adev->asic_type) {
>   	case CHIP_VEGA10:
> -	case CHIP_VEGA12:
> -	case CHIP_RAVEN:
> -	case CHIP_VEGA20:
> -	case CHIP_ARCTURUS:
> -	case CHIP_ALDEBARAN:
> -		/* this is not fatal.  We have a fallback below
> -		 * if the new firmwares are not present. some of
> -		 * this will be overridden below to keep things
> -		 * consistent with the current behavior.
> +		/* This is not fatal.  We only need the discovery
> +		 * binary for sysfs.  We don't need it for a
> +		 * functional system.
>   		 */
> -		r = amdgpu_discovery_reg_base_init(adev);
> -		if (!r) {
> -			amdgpu_discovery_harvest_ip(adev);
> -			amdgpu_discovery_get_gfx_info(adev);
> -			amdgpu_discovery_get_mall_info(adev);
> -			amdgpu_discovery_get_vcn_info(adev);
> -		}
> -		break;
> -	default:
> -		r = amdgpu_discovery_reg_base_init(adev);
> -		if (r) {
> -			drm_err(&adev->ddev, "discovery failed: %d\n", r);
> -			return r;
> -		}
> -
> -		amdgpu_discovery_harvest_ip(adev);
> -		amdgpu_discovery_get_gfx_info(adev);
> -		amdgpu_discovery_get_mall_info(adev);
> -		amdgpu_discovery_get_vcn_info(adev);
> -		break;
> -	}
> -
> -	switch (adev->asic_type) {
> -	case CHIP_VEGA10:
> +		amdgpu_discovery_init(adev);
>   		vega10_reg_base_init(adev);
>   		adev->sdma.num_instances = 2;
>   		adev->gmc.num_umc = 4;
> @@ -2611,6 +2582,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		adev->ip_versions[DCI_HWIP][0] = IP_VERSION(12, 0, 0);
>   		break;
>   	case CHIP_VEGA12:
> +		/* This is not fatal.  We only need the discovery
> +		 * binary for sysfs.  We don't need it for a
> +		 * functional system.
> +		 */
> +		amdgpu_discovery_init(adev);
>   		vega10_reg_base_init(adev);
>   		adev->sdma.num_instances = 2;
>   		adev->gmc.num_umc = 4;
> @@ -2633,6 +2609,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		adev->ip_versions[DCI_HWIP][0] = IP_VERSION(12, 0, 1);
>   		break;
>   	case CHIP_RAVEN:
> +		/* This is not fatal.  We only need the discovery
> +		 * binary for sysfs.  We don't need it for a
> +		 * functional system.
> +		 */
> +		amdgpu_discovery_init(adev);
>   		vega10_reg_base_init(adev);
>   		adev->sdma.num_instances = 1;
>   		adev->vcn.num_vcn_inst = 1;
> @@ -2674,6 +2655,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		}
>   		break;
>   	case CHIP_VEGA20:
> +		/* This is not fatal.  We only need the discovery
> +		 * binary for sysfs.  We don't need it for a
> +		 * functional system.
> +		 */
> +		amdgpu_discovery_init(adev);
>   		vega20_reg_base_init(adev);
>   		adev->sdma.num_instances = 2;
>   		adev->gmc.num_umc = 8;
> @@ -2697,6 +2683,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		adev->ip_versions[DCI_HWIP][0] = IP_VERSION(12, 1, 0);
>   		break;
>   	case CHIP_ARCTURUS:
> +		/* This is not fatal.  We only need the discovery
> +		 * binary for sysfs.  We don't need it for a
> +		 * functional system.
> +		 */
> +		amdgpu_discovery_init(adev);
>   		arct_reg_base_init(adev);
>   		adev->sdma.num_instances = 8;
>   		adev->vcn.num_vcn_inst = 2;
> @@ -2725,6 +2716,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		adev->ip_versions[UVD_HWIP][1] = IP_VERSION(2, 5, 0);
>   		break;
>   	case CHIP_ALDEBARAN:
> +		/* This is not fatal.  We only need the discovery
> +		 * binary for sysfs.  We don't need it for a
> +		 * functional system.
> +		 */
> +		amdgpu_discovery_init(adev);
>   		aldebaran_reg_base_init(adev);
>   		adev->sdma.num_instances = 5;
>   		adev->vcn.num_vcn_inst = 2;
> @@ -2751,6 +2747,16 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 1, 0);
>   		break;
>   	default:
> +		r = amdgpu_discovery_reg_base_init(adev);
> +		if (r) {
> +			drm_err(&adev->ddev, "discovery failed: %d\n", r);
> +			return r;
> +		}
> +
> +		amdgpu_discovery_harvest_ip(adev);
> +		amdgpu_discovery_get_gfx_info(adev);
> +		amdgpu_discovery_get_mall_info(adev);
> +		amdgpu_discovery_get_vcn_info(adev);
>   		break;
>   	}
>   


