Return-Path: <stable+bounces-154823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9170FAE0D53
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 21:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0EC1C20A8F
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 19:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5761B22B585;
	Thu, 19 Jun 2025 19:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adUJ4rok"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBFC1A238D;
	Thu, 19 Jun 2025 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750360057; cv=none; b=LDmcWb9RTZ2LEKW5DgBYL4/b0071yHr4cOYr/7amTUZ3qRyhk/aj9UGu88PzpLXbv9dYDbRl8mo6CAMKxjBgaF/W2wzb/vN2WJARqFaGHhBLh6N98SUQNZq6NjQxnL6ixN5QT8MI5g4aLkqwVx2vfduYDTnmOHiduDUPXRU+q2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750360057; c=relaxed/simple;
	bh=dibH5wDjyn5Zb1B4FCcc/AiyaYSHKBFKlPjRvmfNeBA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J8OYUnpJ2Oc3VzcKsAs+ZPB6dBwiZY4mKKhgOKtPPTcL4NN+WfFHmJTwQYHk6xDTaz/rukqR8haX/tH7t1Yk05Tlr01ZJ7ZMtlJQLqTv1Z6ppwcxHW/ztKC+LQeF8Ipa1VBEqX6CCx1Wvi0QyhyqYfBed0rA4ZukzoYGf1+aIZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adUJ4rok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D258C4CEED;
	Thu, 19 Jun 2025 19:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750360056;
	bh=dibH5wDjyn5Zb1B4FCcc/AiyaYSHKBFKlPjRvmfNeBA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=adUJ4rok9YQYiXnNK6U7o8itoBFKGfyv+/ORUNkpLhuclhUL3wgE5ZNFcMvTP6xwX
	 d4D7tstkQ9BMwJq9aWdAk9mndGtUFApGMiKO5rRyMhQKmG+qSa+aPKtl8j0RoK62iT
	 hc9mvxqcRMJ8PelRBbps5ZPlhQKpKrVbiyDtizYRKyUU0VdSa4FBZlEztsaTDqHlQx
	 AwKoId1ofLZP4WQSqSil2n839660RvdqJJ4fXaN+U2PqO57jV3j308/LSA8VS48aQm
	 Mv8zAkthsENlXmi6/VG7wUToOAmB2cWoYpXw3gO8POya/XU11MIlucn9HYs2w754tq
	 YQC0ycmLx7Vqw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 pierre-louis.bossart@linux.dev, stable@vger.kernel.org
In-Reply-To: <20250619104705.26057-1-peter.ujfalusi@linux.intel.com>
References: <20250619104705.26057-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: sof-function-topology-lib: Print out the
 unsupported dmic count
Message-Id: <175036005483.540225.2904640601416826643.b4-ty@kernel.org>
Date: Thu, 19 Jun 2025 20:07:34 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-08c49

On Thu, 19 Jun 2025 13:47:05 +0300, Peter Ujfalusi wrote:
> It is better to print out the non supported num_dmics than printing that
> it is not matching with 2 or 4.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof-function-topology-lib: Print out the unsupported dmic count
      commit: 16ea4666bbb7f5bd1130fa2d75631ccf8b62362e

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


