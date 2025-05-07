Return-Path: <stable+bounces-141966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58975AAD4E1
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 07:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFEA24C1B5A
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 05:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74FD1DF247;
	Wed,  7 May 2025 05:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhdBIQxe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6311DED5F;
	Wed,  7 May 2025 05:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746594719; cv=none; b=UmA4z+u5e+dWBSs+NriQEW+K6bMIbRY9XOB0b3f5Jv2pwVMX5svUfTcAnxAuPKleCOLFMlgRW8Q6uELrQBzwTAzqESSo8ZiemWsoj87tyZpgkfdLrhsqjNBJPIzBnHM/Boz1Q035WVUBeymy7E4/Vilap/pw1xpYA5+CY12k50o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746594719; c=relaxed/simple;
	bh=y46Bo0fq6ATx2ZWFjSMtCL1bTyU6UOGHBJIa/IU+dcw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k80vodRld+HFycVOAKuSLB6QxVo3OG1+Oe+uL9YMHNLzT5qG5DFulgGJCArPBqrZ2p2pr024UPkFnGJVKwVOG7lrIdRnmbtSBCYFiH8lPgxGT6Vl9Yvp+5/JcOibW5wDuIztiMUMqipy/nSbVXBnGvLESLODsjn/kEAliWOR7ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhdBIQxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19D1C4CEE9;
	Wed,  7 May 2025 05:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746594719;
	bh=y46Bo0fq6ATx2ZWFjSMtCL1bTyU6UOGHBJIa/IU+dcw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FhdBIQxe2yJ13wbwHq8QLKv67Lz2kqORJMPgRHRwl6Lm9AUg+PK0cYHP9IIeDzDfH
	 j6Zl9bHFdzxepXb7ZRnxAVJc2EuF9BtWIZ5/uAOFXRWtD9rQylZxDkM5aCzvUUWyz2
	 wXx77UDCMPtU2JTzlDC/sPpQMegvuIlerXYIJq+pTTRFj+VtbhvLo2grUr4egFywta
	 cqnhb3J6oRSqYghOXsqHzHXAyQtOkPeSWr0Ckfn8T1Qucl1tFueYsd3WZJLPDegjD6
	 8wUy2gpE0yEuRtC1AzafOCVRVAmFcMz4BIlh8zOBQNO1e6Pd21YE4FpAV8rQsYNFee
	 riySWWjX85Bwg==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, yung-chuan.liao@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, pierre-louis.bossart@linux.dev, 
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com, 
 venkataprasad.potturu@amd.com, Mario.Limonciello@amd.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20250506120823.3621604-1-Vijendar.Mukunda@amd.com>
References: <20250506120823.3621604-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 1/3] ASoC: amd: amd_sdw: Fix unlikely uninitialized
 variable use in create_sdw_dailinks()
Message-Id: <174659471540.4169088.2896331168566981958.b4-ty@kernel.org>
Date: Wed, 07 May 2025 14:11:55 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Tue, 06 May 2025 17:37:22 +0530, Vijendar Mukunda wrote:
> Initialize current_be_id to 0 in AMD legacy stack(NO DSP enabled) SoundWire
> generic machine driver code to handle the unlikely case when there are no
> devices connected to a DAI.
> 
> In this case create_sdw_dailink() would return without touching the passed
> pointer to current_be_id.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: amd: amd_sdw: Fix unlikely uninitialized variable use in create_sdw_dailinks()
      commit: 4d87ae7508cb7ff58fd0bcecc6e9491f42f987f8
[2/3] ASoC: amd: sof_amd_sdw: Fix unlikely uninitialized variable use in create_sdw_dailinks()
      commit: 6b83ba4bc3ecb915476d688c9f00f3be57b49a0c
[3/3] ASoC: amd: sof_amd_sdw: add logic to get cpu_pin_id for ACP7.0/ACP7.1 platforms
      commit: ad6d689e776478113aeef7bfb0e4222b1ff2a986

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


