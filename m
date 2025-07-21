Return-Path: <stable+bounces-163492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934DAB0BABE
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 04:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBBDE17C427
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 02:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67242214A94;
	Mon, 21 Jul 2025 02:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBavyu9Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CFE1E3772;
	Mon, 21 Jul 2025 02:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064449; cv=none; b=p5xXJY0MyjBlcaHWaEDAlojhZtuz9Jd9pOGYYjQ1OGrsU3CBV5MP59w3Im2ISJwYtJfnTGU0xeYn6YdMK5sBONnlzSIicQtGZdW2uaPKPIDPWb0B6cA2zF2NCTZb34OSmj8LkE4ZIP8PHfw0DWrZV8JXBOTmpBdVQnsow2Uozuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064449; c=relaxed/simple;
	bh=5jb/stM65I+0aJAhwVu6+xUzsAk79UL5kdDuxBOv+RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drP79X8mPGI4wkIVDTnMO2yr4jkDGo3YC/hTyBal+lTf9rgcBxt0v6E2Z5wLRFfK+QU4IBI/kIQxqcg6dlLpp7ULzSDQKDx+WVTIiCpr4VdcDluybf02qW7m5uSboHYDrcji2Sx66xFh69riVzgvyR63YggiW9p7kYJ2XU+fBJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBavyu9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB18C4CEE7;
	Mon, 21 Jul 2025 02:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753064448;
	bh=5jb/stM65I+0aJAhwVu6+xUzsAk79UL5kdDuxBOv+RQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eBavyu9YloMUuBvSPrBaFBPIz8Ja0Y04OudwJ4HnqGLBVcn/jX4waGNzeN8A70QCC
	 8AriE4rCaeFZNiznwfNSYbvnXW1dLv8n6iUtMR208TVHb2h+wwe+4o0CNknpNjwRtE
	 GKOSkLio5a9PQ8QXcVcxuoTCJSQbnm/kpeBToR6PZbPmFrhtuaJ7IFXRZvBhawpydQ
	 uEpyi1Wpxz23XQPeDTy3WtgjyzFjBlJLaSK/9vi9VH5naFQNdlJdgouER5+p5br//i
	 Wk+1PHuFTOILbYdT9ptYcN+OwF4d7w+rp1G5fjUySGqald8WwMS9wjJg7l+7C1+th9
	 Ke8VIO8hVd2FQ==
Message-ID: <0f094c4b-d2a3-42cd-824c-dc2858a5618d@kernel.org>
Date: Sun, 20 Jul 2025 21:20:46 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] [PATCH v2] drm/amd/display: fix initial backlight
 brightness calculation
To: Lauri Tirkkonen <lauri@hacktheplanet.fi>, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Wayne Lin <wayne.lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <aH2Q_HJvxKbW74vU@hacktheplanet.fi>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aH2Q_HJvxKbW74vU@hacktheplanet.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/20/25 7:59 PM, Lauri Tirkkonen wrote:
> DIV_ROUND_CLOSEST(x, 100) returns either 0 or 1 if 0<x<=100, so the
> division needs to be performed after the multiplication and not the
> other way around, to properly scale the value.
> 
> Fixes: 8b5f3a229a70 ("drm/amd/display: Fix default DC and AC levels")
> Signed-off-by: Lauri Tirkkonen <lauri@hacktheplanet.fi>
> Cc: stable@vger.kernel.org

Thanks so much!

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

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


