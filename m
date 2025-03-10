Return-Path: <stable+bounces-121639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B439A589EB
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 02:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9139188C778
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 01:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DEB13665A;
	Mon, 10 Mar 2025 01:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwxVReVX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F0BD2FB;
	Mon, 10 Mar 2025 01:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741569960; cv=none; b=ZvNQtUANaAo21LgLKRz91aJzwo56w/R00857brd6M2eIXaFZVX9kVZ98dqvwNYooMXwv66DsWvJM6ULBUgDM/pE8FLpJ+DPFu6Espgq3/dtSEL1hugDoBEVcqCXAzOHR/b1txA3xdeRD/s3gV5CGzEDTuDW0hGITVTOK1WhZnGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741569960; c=relaxed/simple;
	bh=21ARpi5tKdj+kmbCqs9cj2F3scXjxAV2QCeF6f4bMJs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jJwxK9+Pj85ALCxEjRACIklBk0t/xSFMGhWHvOkp5DSh60nlb/txMDWbkEUUF7UuxlPj9ZA7+sODTThCmAKPViHSBp/TWGHnceuxx7BHSduiNRinw3BILCN7hZXqK1bUM66Ego3sNb3qkLGV1BMhWsdnabR/O9Nvfc+vlXkhAXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwxVReVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18665C4CEE5;
	Mon, 10 Mar 2025 01:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741569960;
	bh=21ARpi5tKdj+kmbCqs9cj2F3scXjxAV2QCeF6f4bMJs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uwxVReVXYhl7dfhrmAXLaoScmjsH0L2n3TLHsmhicYSqo/Zw/eRmzoGZGcE0V4qdp
	 HjHp0ofao7Sh7LC3aWAYCxmWGLpTV3wiQnRJZAyeAXUXW9+Ev+SD/5gSY+OUbVEZky
	 XAMFP+z+XE2lemeVr8mHZgHEcdxGSwoQOthCVkHlXq52/7sqXbGp1JPSDTR4J/8c+7
	 vDr3PqSysUPKGWACi323Gxs2rOo41XB1KCa/eLmAhRHEwGiIMS+/qEQhMVtnUFFeE8
	 1L6PsdYOFB3RJLGgVSJ9d5qz3amOe/QN5YTOJqwHH5eW+3llhlQz9rjrywhlPJKgVh
	 WlHntVTfu4S2Q==
From: Mark Brown <broonie@kernel.org>
To: Thomas Mizrahi <thomasmizra@gmail.com>
Cc: linux-sound@vger.kernel.org, mario.limonciello@amd.com, 
 stable@vger.kernel.org
In-Reply-To: <20250308041303.198765-1-thomasmizra@gmail.com>
References: <20250308041303.198765-1-thomasmizra@gmail.com>
Subject: Re: [PATCH] ASoC: amd: yc: Support mic on another Lenovo ThinkPad
 E16 Gen 2 model
Message-Id: <174156995713.2353078.3829741267392862517.b4-ty@kernel.org>
Date: Mon, 10 Mar 2025 01:25:57 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-42535

On Sat, 08 Mar 2025 01:06:28 -0300, Thomas Mizrahi wrote:
> The internal microphone on the Lenovo ThinkPad E16 model requires a
> quirk entry to work properly. This was fixed in a previous patch (linked
> below), but depending on the specific variant of the model, the product
> name may be "21M5" or "21M6".
> 
> The following patch fixed this issue for the 21M5 variant:
>   https://lore.kernel.org/all/20240725065442.9293-1-tiwai@suse.de/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Support mic on another Lenovo ThinkPad E16 Gen 2 model
      commit: 0704a15b930cf97073ce091a0cd7ad32f2304329

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


