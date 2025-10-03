Return-Path: <stable+bounces-183233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E80BB7305
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 16:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A0819E6EDE
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 14:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A105A1EA7DB;
	Fri,  3 Oct 2025 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHbsza24"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488D91D88D0;
	Fri,  3 Oct 2025 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759502012; cv=none; b=u3qORatxc7F08yaLUqo9o/7Y6Rx97F7K85DvCVsF+K6V2sCJeX2MaZs3CHX4C5DXwlBVqyn1+cJutaE+NM4FfCG0BePMUyi6cURsU4xlQSRBZ8nZzgQ6zamLikD+4kqJS71Sr3QIPDdjvLnLtmv3GdXDX7G6hxCAQcUF5mN22zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759502012; c=relaxed/simple;
	bh=djI0Kh+ORCZeLxIIhCgIsJOK0W/b/aBQv/JlF6T2L1Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PQl+IDcKL5PThIaY7XPq7Z0HWrN0dkUG894rL5jBH90TrSGLRsOMxKqZIlJWnIRix66mlNySv+/STWdBlJRojzOCLPzFEX5+UPfC0/BKPamPO3Hm2Fpu9dNf8gr7WJllmxTI+owB+t+tPILssN7Y4Af4xBSSJZi3teoZSg1IKUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHbsza24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA7FC4CEF5;
	Fri,  3 Oct 2025 14:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759502011;
	bh=djI0Kh+ORCZeLxIIhCgIsJOK0W/b/aBQv/JlF6T2L1Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HHbsza247QAwQy//u5plfACpJ4TisIlDKqTgylQHDYD/OoAl4b9dYKtsw0IIJWOjs
	 HAVSsKmMBHhSGBUQC1/5GfcwjwRv4Ko99miqOHH+4e7gFKRlQPa8uGKg7nBg7HVfp2
	 nbowxlzwVA6eug83Rg5xrAB2/BkULdgZGMEkTUG7c4XlJxUpy0EzJBcC+KqTYVjU5S
	 JHOEAZDa7VzAS6EBR01MxkVCvAdY4wW8w2ky3qfcEjQqd8/raJwiv4J66DrT11u9au
	 +tnG0RTXuMhE4Ri/aJh47qFxlpXBDYQJ3kxYl0NIx0qQm3eYmH2zs8H89T/HwXpr73
	 F9f9CGk++nbpw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 pierre-louis.bossart@linux.dev, stable@vger.kernel.org
In-Reply-To: <20251002074719.2084-1-peter.ujfalusi@linux.intel.com>
References: <20251002074719.2084-1-peter.ujfalusi@linux.intel.com>
Subject: Re: (subset) [PATCH 0/5] ASoC: SOF: ipc4: Fixes for delay
 reporting
Message-Id: <175950200983.87242.15474178381084349453.b4-ty@kernel.org>
Date: Fri, 03 Oct 2025 15:33:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Thu, 02 Oct 2025 10:47:14 +0300, Peter Ujfalusi wrote:
> With SRC in the firmware processing pipeline the FE and BE rate
> can be different, the sample counters on the two side of the DSP
> counts in different rate domain and they will drift apart.
> The counters should be moved to the same rate domain to be
> usable for delay calculation.
> 
> The ChainDMA offset value was incorrect since the host buffer size
> and the trigger to start the chain is misunderstood initially.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[3/5] ASoC: SOF: sof-audio: add dev_dbg_ratelimited wrapper
      commit: 18dbff48a1ea58100f9fa6886cfef286a96a5fb0
[4/5] ASoC: SOF: ipc4-pcm: do not report invalid delay values
      commit: a4b8152c09a832b089864e5e209a479bb0fb5cc9
[5/5] ASoC: SOF: Intel: Read the LLP via the associated Link DMA channel
      commit: aaab61de1f1e44a2ab527e935474e2e03a0f6b08

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


