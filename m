Return-Path: <stable+bounces-114148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1F7A2AED8
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 18:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2443B3A513D
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D8217799F;
	Thu,  6 Feb 2025 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0/ztFnA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3302D166F06;
	Thu,  6 Feb 2025 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738863003; cv=none; b=XaS4wgr+5UZR2NfOKduBOicOwvfa5cMjJydm8FJp35h7AUSm4m0rrQbzJmBhr0CDKr6fHZNTxo/HS/3FD5xUkvQhhQRxnaFVlRmOhOv4NOERyb+EODwtWsJm1cEqpu5GimgNin6pQKg5ihLdCU6qi0D3eQj0o+RuBdYC9Xxs+XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738863003; c=relaxed/simple;
	bh=8zkQnnn8nU1MmRsCzCYYK3VH4SIh+3//v4kiq/Jfib8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=atHcsQABHAlmUhpRqDhe7B7/ny0offCH1oi52IkHnMWHSA/RUGjh+bUKbU7HIKU8UBngpKAnLhaDGVAdMClCNxxgsrWQv7V30YLX00AQpfpAlrkTdJhwLYaKBqIgSyO7y4pysfVQof881j40uR43TiUpVMLl7X08e2Tq7JUOUNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0/ztFnA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A65C4CEDD;
	Thu,  6 Feb 2025 17:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738863002;
	bh=8zkQnnn8nU1MmRsCzCYYK3VH4SIh+3//v4kiq/Jfib8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=o0/ztFnAbco6KwmleKSrRLkfPY93TUA9RBd6h6HML+mwl6+ZaqA701y+ii3C42Cr0
	 kSXjk2Imj6qmxaWy2kRZNNR9Am7VjP7E4955BQi1R72lAoH0b9TA1oNBqtUVADxDy5
	 8iWAAFNne0RlKYxAHOyoaA1GlGpHPiebCg30kVvIyNhVT/FMilYkaroMWgQFTNMYhT
	 ACT8Rubj/JSLwoh5rAy/U8Fuu5LSrI6lQ2FKEMzLVkJCM21EDc8LYGMSi+BH7LnEqn
	 Wr/tjsYwrtYVk3P1OG5Sr2fzV5joTt10DPiAlwJcocB/HczHJ/eZYygtoo/8cb7a6k
	 EEZO2U19F8hsg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 pierre-louis.bossart@linux.dev, liam.r.girdwood@intel.com, 
 cujomalainey@chromium.org, daniel.baluta@nxp.com, stable@vger.kernel.org
In-Reply-To: <20241107134308.23844-1-peter.ujfalusi@linux.intel.com>
References: <20241107134308.23844-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH v2 0/2] ASoC: SOF: Correct sps->stream and cstream
 nullity management
Message-Id: <173886300019.325569.12850386648132801056.b4-ty@kernel.org>
Date: Thu, 06 Feb 2025 17:30:00 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 07 Nov 2024 15:43:06 +0200, Peter Ujfalusi wrote:
> Changes since v1:
> - Cc stable
> 
> The nullity of sps->cstream needs to be checked in sof_ipc_msg_data()
> and not assume that it is not NULL.
> The sps->stream must be cleared to NULL on close since this is used
> as a check to see if we have active PCM stream.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: stream-ipc: Check for cstream nullity in sof_ipc_msg_data()
      commit: d8d99c3b5c485f339864aeaa29f76269cc0ea975
[2/2] ASoC: SOF: pcm: Clear the susbstream pointer to NULL on close
      commit: 46c7b901e2a03536df5a3cb40b3b26e2be505df6

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


