Return-Path: <stable+bounces-90111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 293979BE67E
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4993B23E4C
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F9A1D416E;
	Wed,  6 Nov 2024 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jslXvER8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA061DF743;
	Wed,  6 Nov 2024 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894461; cv=none; b=O+toWSOBAbmFkOkSYdEyby2cVwrHSLTs199gzZ7mcgon23OgLIOU60bgFt9xVjRmyOLGUEJiulKRcGM6iGZNFF2jjclCKBPReladY5vLDQqi/SXMKaC6HOccp2TC5wpRzdFYlIbeoiNa+G/hjpyqP2Dc6ijUKrTwayl4bO8UhME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894461; c=relaxed/simple;
	bh=RE0lcdwDdIX6buDrsczw7DnwP7RjJHNVqjW3F50NMMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4owtVYmLidJBpAMxwsBwcbY2IlTQjob6I8Vpm5cJ22N1831h+2ePPeJ9KFDLSa2YhzfpO1zTJu6bvCS4yrQc+oHKjLvr2Cgcy3X0HNnuBCSOkPvz3gMtpzgMWeB6Wdlc0m+ZdBD9T7m/n0CVaCcJxJqyZsLbRBt90mZ4FbzGaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jslXvER8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253D6C4CED3;
	Wed,  6 Nov 2024 12:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730894461;
	bh=RE0lcdwDdIX6buDrsczw7DnwP7RjJHNVqjW3F50NMMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jslXvER8LdZSdf6sw+vrVl1/xWWP82jzEAIhRnBEO8RnWE0Jb2Z2FdC2w1Kq76jAi
	 dw5aeaAnF2tv7Xkv4zxA/yN19LzrOJBZ4aFIWG2PFU2IRSkWvE3RiBqrJgMTnaJRRM
	 +AtPWWXngaVkaUBT1ZOsHztVZt9cv7Hy8npl4F7DtlsGziUzxUa5kS3tNQ+HYFqezO
	 CIJRkLTf5PJD6MjDgLcGeZP/nXOkSDzyEU2yg9XRvazuI7KEVlj/AOZJQCLRslXIzt
	 rC5COtE2vUMCDKezPsJSICgOUzPsaBdqj3FM1m/MOnIqFCwBaKVCqMwnaYUrxEDI70
	 Kn5KqnVT/w3lQ==
Date: Wed, 6 Nov 2024 07:00:58 -0500
From: Sasha Levin <sashal@kernel.org>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org, cs@tuxedo.de, Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: FAILED: Patch "ALSA: hda/realtek: Fix headset mic on TUXEDO
 Gemini 17 Gen3" failed to apply to v6.1-stable tree
Message-ID: <ZytaejmvQo3NkUrP@sashalap>
References: <20241106021124.182205-1-sashal@kernel.org>
 <dc0af563-59d2-4176-ad15-fa93cf5c99d2@tuxedocomputers.com>
 <a7ab1da8-5fe8-4f46-bf18-bfc8d6fa3e6f@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a7ab1da8-5fe8-4f46-bf18-bfc8d6fa3e6f@tuxedocomputers.com>

On Wed, Nov 06, 2024 at 10:23:14AM +0100, Werner Sembach wrote:
>Am 06.11.24 um 10:19 schrieb Werner Sembach:
>>Hi,
>>
>>Am 06.11.24 um 03:11 schrieb Sasha Levin:
>>>The patch below does not apply to the v6.1-stable tree.
>>>If someone wants it applied there, or to any other stable or longterm
>>>tree, then please email the backport, including the original git commit
>>>id to <stable@vger.kernel.org>.
>>
>>Applying 33affa7fb46c0c07f6c49d4ddac9dd436715064c (ALSA: 
>>hda/realtek: Add quirks for some Clevo laptops) first and then 
>>0b04fbe886b4274c8e5855011233aaa69fec6e75 (ALSA: hda/realtek: Fix 
>>headset mic on TUXEDO Gemini 17 Gen3) and 
>>e49370d769e71456db3fbd982e95bab8c69f73e8 (ALSA: hda/realtek: Fix 
>>headset mic on TUXEDO Stellaris 16 Gen6 mb1) makes everything work 
>>without alteration.
>>
>>The first one is just missing the cc stable tag, probably by accident.
>>
>>Should I alter the 2nd and 3rd commit or should I send a patchset 
>>that includes the first one?
>
>Sorry just realized that for 5.15 it's a different patch that is 
>missing for e49370d769e71456db3fbd982e95bab8c69f73e8 to cleanly apply
>
>I will just alter the patches

It applies, but fails to build:

In file included from sound/pci/hda/patch_realtek.c:21:
sound/pci/hda/patch_realtek.c:9530:59: error: 'ALC2XX_FIXUP_HEADSET_MIC' undeclared here (not in a function); did you mean 'ALC283_FIXUP_HEADSET_MIC'?
  9530 |         SND_PCI_QUIRK(0x1d05, 0x1387, "TongFang GMxIXxx", ALC2XX_FIXUP_HEADSET_MIC),
       |                                                           ^~~~~~~~~~~~~~~~~~~~~~~~
./include/sound/core.h:465:50: note: in definition of macro 'SND_PCI_QUIRK'
   465 |         {_SND_PCI_QUIRK_ID(vend, dev), .value = (val), .name = (xname)}
       |                                                  ^~~
make[3]: *** [scripts/Makefile.build:289: sound/pci/hda/patch_realtek.o] Error 1

-- 
Thanks,
Sasha

