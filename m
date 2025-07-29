Return-Path: <stable+bounces-165066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C01B14EEB
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 15:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961A24E713E
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 13:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71154C98;
	Tue, 29 Jul 2025 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSKgRMIq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC96433D9;
	Tue, 29 Jul 2025 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753797506; cv=none; b=EGG90g/9zA6G+sISkGJa4kSNqk52jz6+sD+C2B3uZy9Jpto7P5Yy5gXwIwQsHyMIOawvyz9l/kPiIIjiBoyMsTfRwN8EexhfJnGtxsC8KwgK9wYsgvas1JERlMJuwxIKTQsRoZcdQlRIoPB07kf244L5+s8MM0CzzprexJyKr4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753797506; c=relaxed/simple;
	bh=vPvAtP/sZ8lnXkjd3m445006NQb0CN8eBY920jsV5KY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FxcosvmnlFuoxfQ5pVOMDhxySPZZTbF+NNDyo4DC528fb2UrB5NMBCcV1p9nc08aiRdDFMRzL/g2p5DL3VTGvFq/JtqrWRs7rBI6+om17NnjLcOdGT2eIByMASg9QM0+lm4kZlrW5VUlaiMnogCNEoyvojuBf/QyUlPYfvUfXRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSKgRMIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C175AC4CEF4;
	Tue, 29 Jul 2025 13:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753797506;
	bh=vPvAtP/sZ8lnXkjd3m445006NQb0CN8eBY920jsV5KY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bSKgRMIqPhZpMa+TAhyEKbmJdGD0Q13iQOyqMDLVyQjVkUqaUlJO6uYI41jHqmNr5
	 x3j4Wl8r3ymygUJXzbbAIYz4JHcZusIey0IeyA6IA19eJzZREB6ov9cHySRSv1fjbM
	 WocQF6C2ZlcTnHSvXyOTeA3DqMOh68IR9lSUUOKqck7+7CAjBPN5B2Oysn+LKr+lww
	 H26qMroub8PwBjn5QHNKvLvRtqfPo/VNMqehD1wa5oSbnbgcis6EeHarZA6FoEXD3J
	 bQ4GCYhMARlcYh/6+qas/FmHcZqoVKNjfuy4TY3IG7swiJdYYFfiXlNPADO1OcWovI
	 PKmhCDOB9PEJw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com, stable@vger.kernel.org, 
 Bard Liao <bard.liao@intel.com>, sound-open-firmware@alsa-project.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250725190254.1081184-1-usama.anjum@collabora.com>
References: <20250725190254.1081184-1-usama.anjum@collabora.com>
Subject: Re: [PATCH v1] ASoC: SOF: amd: acp-loader: Use GFP_KERNEL for DMA
 allocations in resume context
Message-Id: <175379750250.39357.9621820715781114394.b4-ty@kernel.org>
Date: Tue, 29 Jul 2025 14:58:22 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Sat, 26 Jul 2025 00:02:54 +0500, Muhammad Usama Anjum wrote:
> Replace GFP_ATOMIC with GFP_KERNEL for dma_alloc_coherent() calls. This
> change improves memory allocation reliability during firmware loading,
> particularly during system resume when memory pressure is high. Because
> of using GFP_KERNEL, reclaim can happen which can reduce the probability
> of failure.
> 
> Fixes memory allocation failures observed during system resume with
> fragmented memory conditions.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: amd: acp-loader: Use GFP_KERNEL for DMA allocations in resume context
      commit: eb3bb145280b6c857a748731a229698e4a7cf37b

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


