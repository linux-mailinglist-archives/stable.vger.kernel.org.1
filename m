Return-Path: <stable+bounces-163464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF43B0B62E
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 14:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71333BA865
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 12:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9391F2BBB;
	Sun, 20 Jul 2025 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvzWUlFD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CEE2F50;
	Sun, 20 Jul 2025 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753015792; cv=none; b=UcebZgLyA0Ff7VWP0JqRJMfI1nNFFFu1lR1oDgtiLxjQp60ssxuNHg4RY95J7+Ch8bSk8BKQJLm4UMJD2jCxEvgrxvv4okDN7f+LIZBGcMWTv4jF/By+30KGdKnViVsWzvAg3s/4NjvSRUGsyvvES22MiuOOI8ew6CHooRSgddM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753015792; c=relaxed/simple;
	bh=oxFpdknoeX5Vw+UUVKkbtToVxydEtk2SgKvQHO4LClA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FgHcLw7L0lzeJeakZehX1J1GdO74neqbSP+a7+oN9kAOpC0SS1uzqODo/+hK8X/zcSxYf2e0OFtgaQw6Db2Xb4TK8VntKslwFV3GXlu4L1SArK+5I3fig8KluHVYeENo8zLFEdcf9pvkaFB/W65S7PDCj29EMK4knm+OfmOApNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvzWUlFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B65C4CEE7;
	Sun, 20 Jul 2025 12:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753015792;
	bh=oxFpdknoeX5Vw+UUVKkbtToVxydEtk2SgKvQHO4LClA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GvzWUlFD5xtVgR4UOIIYcFPe2ZprorZ8ZGG+bXlshclLbKYjwp40Eg+C4sLajjrPF
	 62cjZW0idnISxvQ1FVr8yi5SwGi8whd368XgEGRjERcAJpoda4/InBqp++bc+oiprP
	 TUNIg4pzl2ymi4ELcsDptVd4Qwx6Qpx/8y4lzwxVqXpYBvKflp6UGoLqw/09r8NjF0
	 3hrHJuRsZeCpJZKlMcDFamJD0HAcI5gPUdV77NNlGOJqhZ5U2QK0DVfUPBftiZCNz8
	 +Bi7NqFynEo+emRFifeUKiBT7xs+qy0IzOV6Ey5Ktu/yVMF+342ZWb4fjfua438tja
	 g7AqvYW8liYCw==
Message-ID: <18a71fc3-dd01-4335-9655-716c87048530@kernel.org>
Date: Sun, 20 Jul 2025 07:49:50 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] [PATCH] drm/amd/display: fix initial backlight
 brightness calculation
To: Lauri Tirkkonen <lauri@hacktheplanet.fi>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Wayne Lin <wayne.lin@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <aHn33vgj8bM4s073@hacktheplanet.fi>
 <d92458bf-fc2b-47bf-b664-9609a3978646@kernel.org>
 <aHpb4ZTZ5FoOBUrZ@hacktheplanet.fi>
 <46de4f2a-8836-42cd-a621-ae3e782bf253@kernel.org>
 <aHru-sP7S2ufH7Im@hacktheplanet.fi>
 <664c5661-0fa8-41db-b55d-7f1f58e40142@kernel.org>
 <aHr--GxhKNj023fg@hacktheplanet.fi>
 <f12cfe85-3597-4cf7-9236-3e00f16c3c38@kernel.org>
 <cc7a41dc-066a-41c8-a271-7e4c92088d65@kernel.org>
 <aHy4Ols-BZ3_UgQQ@hacktheplanet.fi> <aHy4tohvbwd1HpxI@hacktheplanet.fi>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aHy4tohvbwd1HpxI@hacktheplanet.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/20/25 4:36 AM, Lauri Tirkkonen wrote:
> DIV_ROUND_CLOSEST(x, 100) returns either 0 or 1 if 0<x<=100, so the
> division needs to be performed after the multiplication and not the
> other way around, to properly scale the value.
> 
> Fixes: 6c56c8ec6f97 ("drm/amd/display: Fix default DC and AC levels")
> Signed-off-by: Lauri Tirkkonen <lauri@hacktheplanet.fi>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f58fa5da7fe5..8a5b5dfad1ab 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4941,9 +4941,9 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
>   	caps = &dm->backlight_caps[aconnector->bl_idx];
>   	if (get_brightness_range(caps, &min, &max)) {
>   		if (power_supply_is_system_supplied() > 0)
> -			props.brightness = (max - min) * DIV_ROUND_CLOSEST(caps->ac_level, 100);
> +			props.brightness = DIV_ROUND_CLOSEST((max - min) * caps->ac_level, 100);
>   		else
> -			props.brightness = (max - min) * DIV_ROUND_CLOSEST(caps->dc_level, 100);
> +			props.brightness = DIV_ROUND_CLOSEST((max - min) * caps->dc_level, 100);
>   		/* min is zero, so max needs to be adjusted */
>   		props.max_brightness = max - min;
>   		drm_dbg(drm, "Backlight caps: min: %d, max: %d, ac %d, dc %d\n", min, max,

Thanks! The change makes sense.  Besides Greg's comments can you please 
send out of the regression thread?  IMO This should be it's own patch 
thread.

