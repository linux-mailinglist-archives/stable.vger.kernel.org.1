Return-Path: <stable+bounces-164499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E845B0FA3D
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 20:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3737D54076A
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 18:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0D5225A37;
	Wed, 23 Jul 2025 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1mRiNne"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF60F21421D
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 18:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753295010; cv=none; b=cQvHR0XBkeZNx2YS2sFJaDJZp2N3eqt0aDjNtXubblrO3QG5KftUt1qG3MzNo22NM8bfSt0apOkGvxgzjOECK/FCOIVFOt/jL1gKMZPRT+T/sk7rHONk37Aj/RWeKgrpDJ/0ar2jTXyJROCTHFOResiVDLCheN4MmolgV0sPY70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753295010; c=relaxed/simple;
	bh=TZj0F7YLGd/BoOU359y6vT9r1tCi3dr7yh5cDQ0maDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cV3ViA05gsFi0/Ho+zmx6oRyjUFLsUs3i16NI4W8Q+gTAe0oqmMzSs52b/irSdKFQg+EbwxIeFwvWaV1UPOQkMoJPehahRrT2A5EI6GO2Aq8nXVaPN2sjpThUYsUVfINNaFoqOCDwOHo1ggi7suR2f2yLWcgijZCLQ4NbBXYAqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1mRiNne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41788C4CEE7;
	Wed, 23 Jul 2025 18:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753295009;
	bh=TZj0F7YLGd/BoOU359y6vT9r1tCi3dr7yh5cDQ0maDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b1mRiNneuG9YQEjMwYPxFY4zymmL7BWxjahVWYlSm15CcjsnLaq2cK48cinlU9Mv8
	 knMv7E9+yCONumw4s3MOJIHWR/YUNOJwj8yB6M6UyOji/2loNwcycJhFMxzOIZWeLt
	 35Kyewl+4dZCbw2NyukWO63LjLB5qReEb52LSbI/iGft486BppS2sxsSO4xsjMv7qd
	 dVgK/N0lULKw3N+AU4VdJcRhgWUGrFlUmdQ1WUzTwoPb4IzIuTw7CwAFrkO5BQde1L
	 TMoNkYlJvUlvP7n+f5n5T7CmTa3BnCTn9vKRa7fsfDUG166jrbgQXFGPtde96M/NuN
	 EdqrdJq7phvOw==
Date: Wed, 23 Jul 2025 14:23:26 -0400
From: Sasha Levin <sashal@kernel.org>
To: Daniel Dadap <ddadap@nvidia.com>
Cc: stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 5.15.y] ALSA: hda: Add missing NVIDIA HDA codec IDs
Message-ID: <aIEonpWtKY_hy9T7@lappy>
References: <2025071244-canon-whacky-600c@gregkh>
 <20250723141042.1090223-1-sashal@kernel.org>
 <aIER3X-61j_VVKkr@ddadap-lakeline.nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aIER3X-61j_VVKkr@ddadap-lakeline.nvidia.com>

On Wed, Jul 23, 2025 at 11:46:21AM -0500, Daniel Dadap wrote:
>On Wed, Jul 23, 2025 at 10:10:42AM -0400, Sasha Levin wrote:
>> From: Daniel Dadap <ddadap@nvidia.com>
>>
>> [ Upstream commit e0a911ac86857a73182edde9e50d9b4b949b7f01 ]
>>
>> Add codec IDs for several NVIDIA products with HDA controllers to the
>> snd_hda_id_hdmi[] patch table.
>>
>> Signed-off-by: Daniel Dadap <ddadap@nvidia.com>
>> Cc: <stable@vger.kernel.org>
>> Link: https://patch.msgid.link/aF24rqwMKFWoHu12@ddadap-lakeline.nvidia.com
>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>> [ change patch_tegra234_hdmi function calls to patch_tegra_hdmi ]
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  sound/pci/hda/patch_hdmi.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
>> index 81025d45306d3..fcd7d94afc5d5 100644
>> --- a/sound/pci/hda/patch_hdmi.c
>> +++ b/sound/pci/hda/patch_hdmi.c
>> @@ -4364,6 +4364,8 @@ HDA_CODEC_ENTRY(0x10de002d, "Tegra186 HDMI/DP0", patch_tegra_hdmi),
>>  HDA_CODEC_ENTRY(0x10de002e, "Tegra186 HDMI/DP1", patch_tegra_hdmi),
>>  HDA_CODEC_ENTRY(0x10de002f, "Tegra194 HDMI/DP2", patch_tegra_hdmi),
>>  HDA_CODEC_ENTRY(0x10de0030, "Tegra194 HDMI/DP3", patch_tegra_hdmi),
>> +HDA_CODEC_ENTRY(0x10de0033, "SoC 33 HDMI/DP",	patch_tegra_hdmi),
>> +HDA_CODEC_ENTRY(0x10de0035, "SoC 35 HDMI/DP",	patch_tegra_hdmi),
>
>I tested a modified snd-hda-codec-hdmi.ko which patched one of these to
>patch_tegra_hdmi instead of patch_tegra234_hdmi, and it still worked
>correctly as far as I could tell with a few brief checks. However, it
>seems like patch_nvhdmi might be a better match, at least based on how
>it seems to behave with DP MST, so if we don't decide to drop the codec
>entries for 0x10de0033 and 0x10de0035 in the older branches it might be
>good to use patch_nvhdmi.

Hmm...

I've used patch_tegra_hdmi because from my understanding of the code,
Tegra SoCs require explicit format notification through NVIDIA AFG
scratch registers. The key mechanism is in tegra_hdmi_set_format() which
writes the HDA format to NVIDIA_SET_SCRATCH0_BYTE[0-1] and toggles
NVIDIA_SCRATCH_VALID (bit 30) in NVIDIA_SET_SCRATCH0_BYTE3.

patch_nvhdmi doesn't seem to deal with this at all.

>It probably does make more sense to drop the SoC codec entries for the
>backports, the more I think about it. It makes sense to backport dGPU
>codec entries since somebody could put an add-in-board into an existing
>system running an LTS kernel, but for new SoCs you'd want the kernel to
>be recent enough to support all of the hardware on the system. Notably,
>we don't seem to have backported HDA codec entries for other SoCs like
>the T234 that patch_tegra234_hdmi was added for in the first place.

On our end we'd prefer to keep this align with upstream as much as
possible: it will make future patches easier to apply without manual
modifications.

If leaving them in there is harmless (and only unnecessary), I'd rather
just leave it there.

-- 
Thanks,
Sasha

