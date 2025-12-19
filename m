Return-Path: <stable+bounces-203097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0F8CD0377
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 15:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61F4730B4FFB
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 14:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A91328B73;
	Fri, 19 Dec 2025 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gq9MzjsZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2490D329C5F;
	Fri, 19 Dec 2025 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766153381; cv=none; b=XJfWbDZ2FBvI8lTqqSahdskjmw5DZifAsEnPWeUykejJl2wxYHYwxbAlGYBOHCza53puMdvTGLvfSmFi6CWGvEKTwpgQE6yPTe3DhxA93e2jlI8PGR1F3YeMXtGPyiNsb1gzbWghyqNi17CjcLiLbBQJ+7S1SlHlD61XwVymAc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766153381; c=relaxed/simple;
	bh=3Y1mJw5AklsR4Q1u7kodeIcaXTuzWdVqNRFxY89/6k8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BV16LmGdJRmI3m9kqD8FxmH05OqjqXnH2+6H+tZcKi284JueHFcOcPys2P5D7G3uq8JhOL0C8pfxjbCvPxetLMjMNwkEF+5Hos5azLLdBCzk4HfRcR1fq17AZsxrCLhTOkEauI1GQ/H2R1LRRT1CtyecxcusnVu2RfNIh45ZEXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gq9MzjsZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE50DC116C6;
	Fri, 19 Dec 2025 14:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766153380;
	bh=3Y1mJw5AklsR4Q1u7kodeIcaXTuzWdVqNRFxY89/6k8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gq9MzjsZ2vluG3wCnt80FsizP9rDQ2dbS5hFkOtd6u/hPOWXSf/lcU/hxWvQAk8Q3
	 Dx5khi7k8ngDEI8XtMga6LcCDRt+ASCyK+ksid4Mg2HMnUzHGMO0a1Mghg8XAmmg1b
	 ZzpjzmOG9ycrNSHIJGkrMHjNh3GpoaEwgIDiNtsy4lgakJ0f6iWl547DeOnUvuyY7c
	 nO4AVcE7H12cgZDp5yZ985XKQFrt3B6TfkoqlD2gOO5NKe7O9Y/0Fm0O2HGR2ZXwbN
	 ssXLeez9m5hk1ALpTMtb2gr2ySdsIJFQukXEdYcLD6QmM8WSWjhYwm2sYB5Rn4YMWC
	 EYXXlikO78Ktw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 pierre-louis.bossart@linux.dev, seppo.ingalsuo@linux.intel.com, 
 stable@vger.kernel.org
In-Reply-To: <20251217143945.2667-1-peter.ujfalusi@linux.intel.com>
References: <20251217143945.2667-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH v3 0/8] ASoC: SOF: ipoc4: Support for generic bytes
 controls
Message-Id: <176615337870.412520.14252524036895395324.b4-ty@kernel.org>
Date: Fri, 19 Dec 2025 14:09:38 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Wed, 17 Dec 2025 16:39:37 +0200, Peter Ujfalusi wrote:
> Changes since v2:
> - correct the fixes tag for the second path
> 
> Changes since v1:
> - correct SHAs for fixes tags
> - add Cc stable tag
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/8] ASoC: SOF: ipc4-control: If there is no data do not send bytes update
      commit: 2fa74713744dc5e908fff851c20f5f89fd665fb7
[2/8] ASoC: SOF: ipc4-topology: Correct the allocation size for bytes controls
      commit: a653820700b81c9e6f05ac23b7969ecec1a18e85
[3/8] ASoC: SOF: ipc4-control: Use the correct size for scontrol->ipc_control_data
      commit: c1876fc33c5976837e4c73719c7582617efc6919
[4/8] ASoC: SOF: ipc4-control: Keep the payload size up to date
      commit: ebcfdbe4add923dfb690e6fb9d158da87ae0b6bf
[5/8] ASoC: SOF: ipc4-topology: Set initial param_id for bytes control type
      commit: 2fdde18a2cb1631c01e4ab87d949564c7d134dd8
[6/8] ASoC: SOF: ipc4: Support for sending payload along with LARGE_CONFIG_GET
      commit: d96cb0b86d6e8bbbbfa425771606f6c1aebc318e
[7/8] ASoC: SOF: ipc4: Add definition for generic bytes control
      commit: 7fd8c216c422c5d42addc3e46d5d26630ff646d1
[8/8] ASoC: SOF: ipc4-control: Add support for generic bytes control
      commit: 2a28b5240f2b328495c6565d277f438dbc583d61

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


