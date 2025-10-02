Return-Path: <stable+bounces-183120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBC5BB4B78
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 19:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D79519E5944
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 17:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0743272E72;
	Thu,  2 Oct 2025 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+PLctcC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C38B4501A;
	Thu,  2 Oct 2025 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759426763; cv=none; b=a1GviiVBX95HAF3N2AYB5xO09dJUzuYERHu3061Sv85kB4b7dZf3sgGxCTdIlw3lOAa+YCiEucPtfR2Gv2QCUlwbstwYYa0N5HzgDq5lDUxKgDr0oF7q+eemhOziV2GzRK/sfGKtFGVz2SAgbkefUBiw1z9JznodwQIT88KTW0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759426763; c=relaxed/simple;
	bh=QpmkHyV7gyhmpVXXFzectXRxStvRI6N5IWkvU7snil8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RI+Aqh01lT4LYXcqBM+RdniApAY3x622XAOLHk5PEjQyjXstCsZfsELE7Dnyoq1i0qiGSIh8Mdm3W7LhvTTnQwrGrU8MRLfwaenV4GXltc/G1xc+dJNqgTq9umt8zNGrppP4vtHEydincrLAsdKSbIyk7lom3qs6C31rAeVmP7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+PLctcC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FA1C4CEF5;
	Thu,  2 Oct 2025 17:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759426763;
	bh=QpmkHyV7gyhmpVXXFzectXRxStvRI6N5IWkvU7snil8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=K+PLctcCHb8nDzUao4wsqnoype8kltwXT/97jQZVY4SkW50R19eplgGvQzFNAlyFh
	 GnOorLPMog4VdkcNOJ2rmwrft3mBeEKNGHUr5l86jVXg8cxrtlu3+PTmKwbYwJkRJg
	 21U9witzzoFWBmURLTt3Lh4KV6WodurlrJl/RQbZnmJTX1caeaRvI4PmE2OFFnsiCs
	 lw95rUC1Jqyy+lJJW/Q6KwsGFQ2JVOyRmdzAubFXGjPYBbNxtWJ/OLB1N9wouAxgu/
	 AlyttTtl0qp9+cbW/eo5kvBbdIQPd+7qZzl/Kirvo1Cu90tLkz4/ICwxRgT3u0DGen
	 l9bICtok1S5hA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 pierre-louis.bossart@linux.dev, stable@vger.kernel.org
In-Reply-To: <20251002135752.2430-1-peter.ujfalusi@linux.intel.com>
References: <20251002135752.2430-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH v3 0/3] ASoC: SOF: ipc4/Intel: Fix the host buffer
 constraint
Message-Id: <175942676123.119208.2828941345407015839.b4-ty@kernel.org>
Date: Thu, 02 Oct 2025 18:39:21 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Thu, 02 Oct 2025 16:57:49 +0300, Peter Ujfalusi wrote:
> CHanges since v2:
> - SHA fix for the last commit, tripple checked them
> 
> Changes since v1:
> - SHAs for Fixes tag corrected (sorry)
> 
> The size of the DSP host buffer was incorrectly defined as 2ms while
> it is 4ms and the ChainDMA PCMs are using 5ms as host facing buffer.
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


