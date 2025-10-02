Return-Path: <stable+bounces-183118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E153ABB4B72
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 19:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91401C0658
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 17:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79258271451;
	Thu,  2 Oct 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jB+b+D9e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9FB4501A;
	Thu,  2 Oct 2025 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759426759; cv=none; b=DZkVs5Y//GMHNsdCl9LDyeV9H2y0RVI7CjdFIp6k2MumDrcUzfT04JO8esyxZl8JWgAzAIa6sR92hW35zTKhvAt2SIFPVw22/JHlc+AqD4gfT+38HHymSBooAcemsCBO+vDEwjETFgkWXHcDfPnZZ/jjirnYmgIWagW9I17eHYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759426759; c=relaxed/simple;
	bh=eSu7h8gG4CxZG3OKOVHnu6scMj4gMSiYftHvfkr1vNU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sTTys/Da1vmgORjy25zq0BIUVtgDTEinXCQNpsZgPY+j4Etgsm87lhfKkF9HNRwPrvNoc3964/O1HAXuZLTsz1MZ8XmLt53JKVUJjcCEXykjs8723JiwmvvA2b/J32qaahGp6gmdaqKq5Ei5AqbIpJ+djhFUPoUcFf8MFwWI8QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jB+b+D9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BF0C4CEF4;
	Thu,  2 Oct 2025 17:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759426758;
	bh=eSu7h8gG4CxZG3OKOVHnu6scMj4gMSiYftHvfkr1vNU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jB+b+D9epLt9jG2+sspVpP8SXjrbz2w7yrKrbTC9TBb97i/4Bpei4uVukssgrgOXF
	 fs0+lsg2t+zxfNPegHo/yCAZ7WYBKK3yEM/c/ca5fUgGvA/YytFmTLKvLpev4jL6sx
	 iXkM0iimoe3pV5dkNqLf07IacIPCsw5duq6aV4bIPTdO0Bl0dbiE4Wt4/fWq8BnTKV
	 ipqyDFhWSbljIq7YKJVlQPEoJ3hsPKsmrHFbyFI61+Mx2fvMjZ/jOkUGRzI4ZoKMgs
	 UFAcDCKw8Mwc3dNdcTmH5qduwu4pG3TFTSO91rvdkncMfaHsM7tTtkiqQ4yMpyvy3T
	 gE8gq9JY/q2VQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 pierre-louis.bossart@linux.dev, stable@vger.kernel.org
In-Reply-To: <20251002080538.4418-1-peter.ujfalusi@linux.intel.com>
References: <20251002080538.4418-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH 0/3] ASoC: SOF: ipc4/Intel: Fix the host buffer
 constraint
Message-Id: <175942675632.119208.2155963068461075221.b4-ty@kernel.org>
Date: Thu, 02 Oct 2025 18:39:16 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Thu, 02 Oct 2025 11:05:35 +0300, Peter Ujfalusi wrote:
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


