Return-Path: <stable+bounces-183116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BBBBB49F4
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 19:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D3019E18CA
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 17:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5AC267F59;
	Thu,  2 Oct 2025 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEy8atGb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0B942A99;
	Thu,  2 Oct 2025 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759424812; cv=none; b=nMmpcH2I0UtqlImfFYyBByz/ev7hVh6XFh7hUOR5FaubYdEm2CYJNhF/647qfUXA96fOLXos/2QHh2OTxN95EGCHuRM+YaCodFinXfyiu8PQ0CKEIcx/LxUXEZPotDe5hL75AdcA9lNy7jf8gdBWlnkRpHi0NB0KQLQ0vqcUV9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759424812; c=relaxed/simple;
	bh=dwVkhKhLIiB6QxbtpaCKR8DZDQkW6idXBeZOw16TMtM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ax8uxkDd8IGh1oOVWqObOULzXjTzSd1RXEHSh1mgHoROBiGJJSaLGyI/MvrJqGxiwQgojzKcSCbpng5k/XL8W8eLQhuVrfD5dkHsZ6KB5pm6DQ1hF99YsWsIqyUgtw6i4z3fwxMsPrniq5KYpeIuA9U4VJqeBVry1XwJNJYVIgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEy8atGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295C1C4CEF9;
	Thu,  2 Oct 2025 17:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759424812;
	bh=dwVkhKhLIiB6QxbtpaCKR8DZDQkW6idXBeZOw16TMtM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EEy8atGb6vEJJ24yrR3BIT/Z5apmhPZhrldQyO8zbCeSCcE7L9HfjXDFKywLskuqw
	 rQveccKNoAzVgflSNNL4kvgAar5LR+9SAcmHm2ONbNv8lqe51CXOevF1SMAVht7Pm+
	 1fvU3lLMRi+Gtcv0pTiDUb7n/wn57wUTx+Qff5WCe9idq4X/WsxMHmzJzKqNTK59gM
	 iHEezThP4b472+zlgcIkbLjd3XbppUCF9MXLVf7/PnAPKCkeN5o+VoTjmlkeP1xktC
	 HzLvOp4SbeysFRrG7LV3JkXNHPVN/dDoahPf7W9Ua/MNPg8sruTA4JdgmbMxZ4uwnT
	 F3ZxENRg0W8Cw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 pierre-louis.bossart@linux.dev, stable@vger.kernel.org
In-Reply-To: <20251002074719.2084-1-peter.ujfalusi@linux.intel.com>
References: <20251002074719.2084-1-peter.ujfalusi@linux.intel.com>
Subject: Re: (subset) [PATCH 0/5] ASoC: SOF: ipc4: Fixes for delay
 reporting
Message-Id: <175942481090.110990.10424405956515498290.b4-ty@kernel.org>
Date: Thu, 02 Oct 2025 18:06:50 +0100
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

[1/5] ASoC: SOF: ipc4-pcm: fix delay calculation when DSP resamples
      commit: bcd1383516bb5a6f72b2d1e7f7ad42c4a14837d1
[2/5] ASoC: SOF: ipc4-pcm: fix start offset calculation for chain DMA
      commit: bace10b59624e6bd8d68bc9304357f292f1b3dcf

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


