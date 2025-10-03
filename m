Return-Path: <stable+bounces-183234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73861BB7308
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 16:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154A0485F26
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 14:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D558620F08D;
	Fri,  3 Oct 2025 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJThiqq2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906C51E515;
	Fri,  3 Oct 2025 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759502014; cv=none; b=UIBhJIfUDlnBlFJouwWQi+R8dOwo3t3GXR4xJ/Pe8iGbVr2Z2YZJO7atwEQIZ2ccGWY5AA4AFRY+2v+lOg9J3vbkpJlmbfdk+ZrcSyCrDGwDnoAmu2H+S+HAMoYdH7g4LKY9ORFSinkesayvWoBJP5O/ufHJxzFyF44SoRrlvGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759502014; c=relaxed/simple;
	bh=Ol9QmzDRQIdGFburmMnhzuufrNXKQBUmjDyAxdEnvGE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YcBcVTdsFV/0NBw4CeqE0j68KBj8KKTwEuuAdfvky67z02W6KslMxT6o6rMjN/6iKfGwPUd5Co2MDpPVgx/giioqkTpKdCwt4CNMW0tncUts3fsRcRm03/rit+BpNB40dGv0/7hF2PeHfsDMBQeNBt1zaeqY6GFcoRxkWGPAi/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJThiqq2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A41C4CEF7;
	Fri,  3 Oct 2025 14:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759502014;
	bh=Ol9QmzDRQIdGFburmMnhzuufrNXKQBUmjDyAxdEnvGE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KJThiqq2eEs9iEFwn87i9xQi4/vJt5PzAim7p4K5KjqdSWti7gkWEsmWG8Xsxj6K7
	 JVDks33iWQvMwhLBftea02s5BxOd9gMXe1mTqxuPuZV3qmzrU5h+WNCoP5j3SAH1Bt
	 QNJF8fKm9QtJlWjndr7RHIReoiD7F0MrNRuds3Vgc6LOnnIyQG63HNuexTYnOab+en
	 tQnnKlBvEdamp0pXHK+lqj5IxWvRiamCLZtQ5lrIhsVyF5gzyQsxWm0ZI7NxZiqMJA
	 bpfkKWTz325LfA7QWOoZN6AONWUAvjzM3pSKMGkqMwlwtwrYu6THtn719gwWK8QjC7
	 +OnXJn2lrKivQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 pierre-louis.bossart@linux.dev, stable@vger.kernel.org
In-Reply-To: <20251002125322.15692-1-peter.ujfalusi@linux.intel.com>
References: <20251002125322.15692-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH v2 0/3] ASoC: SOF: ipc4/Intel: Fix the host buffer
 constraint
Message-Id: <175950201207.87242.17861945407345006882.b4-ty@kernel.org>
Date: Fri, 03 Oct 2025 15:33:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Thu, 02 Oct 2025 15:53:19 +0300, Peter Ujfalusi wrote:
> Changes since v1:
> - SHAs for Fixes tag corrected (sorry)
> 
> The size of the DSP host buffer was incorrectly defined as 2ms while
> it is 4ms and the ChainDMA PCMs are using 5ms as host facing buffer.
> 
> The constraint will be set against the period time rather than the buffer
> time to make sure that application will not face with xruns when the
> DMA bursts to refill the host buffer.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: SOF: ipc4-topology: Correct the minimum host DMA buffer size
      commit: a7fe5ff832d61d9393095bc3dd5f06f4af7da3c1
[2/3] ASoC: SOF: ipc4-topology: Account for different ChainDMA host buffer size
      commit: 3dcf683bf1062d69014fe81b90d285c7eb85ca8a
[3/3] ASoC: SOF: Intel: hda-pcm: Place the constraint on period time instead of buffer time
      commit: 45ad27d9a6f7c620d8bbc80be3bab1faf37dfa0a

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


