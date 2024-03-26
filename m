Return-Path: <stable+bounces-32322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B933488C417
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 14:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7D21C3EFD3
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 13:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC31874E26;
	Tue, 26 Mar 2024 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGSCkqSH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D35182A3;
	Tue, 26 Mar 2024 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460886; cv=none; b=PPxN3GU3TY+yQ7RT2dIz34gFeP4C9TdHww4hnHbo1ytBJWZOE0mnTo26N127jZym19llu01ooAS9E5SFrYoh38r2RbDibi/tS392CGlhL+Kj+w4hgHKgqEJGm0CX07/k/BotgDcKKGjlteuds3BBiBMFjCZg2wbuMpIv5iCOtVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460886; c=relaxed/simple;
	bh=Mf7S0QL6QfNmAISo8wK42t8xEgi0jhNKtPnbAz0+JOY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CF+y5qk1FBem1swVfmIOPtFiLAZWJYmtIrPHeb8tMYUkyfnD495c870GnJt+MBrOCFaZfaqesy6f/1tFIvfXx84JJI1fGrD/i3XPYMaTFW9qOI9B+VhhgGzwuRKxFiRY8moEOHfkslBGoy2LHrANRtEC44tArve6Tt8b0sw1Xzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGSCkqSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEB4C433F1;
	Tue, 26 Mar 2024 13:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711460886;
	bh=Mf7S0QL6QfNmAISo8wK42t8xEgi0jhNKtPnbAz0+JOY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uGSCkqSHBrUfw2urzBrRRMlwRrVVZTER9xCyWeGV8Zim8udchEwSkfT2Yu6wGXyB6
	 catGe+NjWIcGQOBHsPJq2l+UghAxRa7iuWf3HJhB1tABMkKpXkKdbVtslGa01SAPAP
	 XOHeGnRbVpnN/OHDoYfjZ3UlxpYc+5fiPg5pOUMRaP60AHMm8jM6JBKGckz2nlB8BN
	 zPR6ddz0uffaY7e78Xj1MZU+mGptH991bm8K0J74p80R3HLpKXdGOOXPQCRjN1xO6W
	 Gkvvl8utWaS/HhI6s/zZY2Ea9+izLwVlhx/DFvz+GdQSGwxemrMbxBT0Fbzh9dwNQX
	 a6n0wyw/UyySQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, tiwai@suse.de, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, pierre-louis.bossart@linux.intel.com, 
 kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com, 
 stable@vger.kernel.org
In-Reply-To: <20240321130814.4412-1-peter.ujfalusi@linux.intel.com>
References: <20240321130814.4412-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH 00/17] ASoC: SOF: ipc4/Intel: Fix delay reporting (for
 6.9 / 6.8)
Message-Id: <171146088355.91885.8636516846579782107.b4-ty@kernel.org>
Date: Tue, 26 Mar 2024 13:48:03 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 21 Mar 2024 15:07:57 +0200, Peter Ujfalusi wrote:
> The current version of delay reporting code can report incorrect
> values when paired with a firmware which enables this feature.
> 
> Unfortunately there are several smaller issues that needed to be addressed
> to correct the behavior:
> 
> Wrong information was used for the host side of counter
> For MTL/LNL used incorrect (in a sense that it was verified only on MTL)
> link side counter function.
> The link side counter needs compensation logic if pause/resume is used.
> The offset values were not refreshed from firmware.
> Finally, not strictly connected, but the ALSA buffer size needs to be
> constrained to avoid constant xrun from media players (like mpv)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/17] ASoC: SOF: Add dsp_max_burst_size_in_ms member to snd_sof_pcm_stream
        commit: fb9f8125ed9d9b8e11f309a7dbfbe7b40de48fba
[02/17] ASoC: SOF: ipc4-topology: Save the DMA maximum burst size for PCMs
        commit: 842bb8b62cc6f3546d61eb63115b32ebc6dd4a87
[03/17] ASoC: SOF: Intel: hda-pcm: Use dsp_max_burst_size_in_ms to place constraint
        commit: fe76d2e75a6da97edd2b4ec5cfb9efd541be087a
[04/17] ASoC: SOF: Intel: hda: Implement get_stream_position (Linear Link Position)
        commit: 67b182bea08a8d1092b91b57aefdfe420fce1634
[05/17] ASoC: SOF: Intel: mtl/lnl: Use the generic get_stream_position callback
        commit: 4374f698d7d9f849b66f3fa8f7a64f0bc1a53d7f
[06/17] ASoC: SOF: Introduce a new callback pair to be used for PCM delay reporting
        commit: ce2faa9a180c1984225689b6b1cb26045f8b7470
[07/17] ASoC: SOF: Intel: Set the dai/host get frame/byte counter callbacks
        commit: fd6f6a0632bc891673490bf4a92304172251825c
[08/17] ASoC: SOF: ipc4-pcm: Use the snd_sof_pcm_get_dai_frame_counter() for pcm_delay
        commit: 37679a1bd372c8308a3faccf3438c9df642565b3
[09/17] ASoC: SOF: Intel: hda-common-ops: Do not set the get_stream_position callback
        commit: 4ab6c38c664442c1fc9911eb3c5c6953d3dbcca5
[10/17] ASoC: SOF: Remove the get_stream_position callback
        commit: 07007b8ac42cffc23043d00e56b0f67a75dc4b22
[11/17] ASoC: SOF: ipc4-pcm: Move struct sof_ipc4_timestamp_info definition locally
        commit: 31d2874d083ba6cc2a4f4b26dab73c3be1c92658
[12/17] ASoC: SOF: ipc4-pcm: Combine the SOF_IPC4_PIPE_PAUSED cases in pcm_trigger
        commit: 55ca6ca227bfc5a8d0a0c2c5d6e239777226a604
[13/17] ASoC: SOF: ipc4-pcm: Invalidate the stream_start_offset in PAUSED state
        commit: 3ce3bc36d91510389955b47e36ea4c4e94fcbdd3
[14/17] ASoC: SOF: sof-pcm: Add pointer callback to sof_ipc_pcm_ops
        commit: 77165bd955d55114028b06787a530b8f9220e4b0
[15/17] ASoC: SOF: ipc4-pcm: Correct the delay calculation
        commit: 0ea06680dfcb4464ac6c05968433d060efb44345
[16/17] ALSA: hda: Add pplcllpl/u members to hdac_ext_stream
        commit: f9eeb6bb13fb5d7af1ea5b74a10b1f8ead962540
[17/17] ASoC: SOF: Intel: hda: Compensate LLP in case it is not reset
        commit: 1abc2642588e06f6180b3fbb21968cf5d0ba9e5f

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


