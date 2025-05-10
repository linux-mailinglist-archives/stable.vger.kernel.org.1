Return-Path: <stable+bounces-143074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6B9AB20DF
	for <lists+stable@lfdr.de>; Sat, 10 May 2025 03:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7620B1B668F2
	for <lists+stable@lfdr.de>; Sat, 10 May 2025 01:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8042676EC;
	Sat, 10 May 2025 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmH7q6xM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8852676CD;
	Sat, 10 May 2025 01:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746841791; cv=none; b=Gw2rOGuDLKLvpfAstWtDYaDA5uPz75nQZWlJNiz2ZtwewB3X4rE7R7YuYBLPxf1vl5yewLgL+ziCZsKgLXYznAypr2gV2KCTdfGB8CCmqR9ZBbzy3Zm4pygrkXfZsE8BTEf7GFbk0bBlcd1VrO34XBiaEyoRQjUdONHtcAX0y9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746841791; c=relaxed/simple;
	bh=RHr+I39kLwtbgreyeFB+nShG6YSzl7Gd7g3dqVME7HE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=McQN0W2Hb9HAOyvXIMTGVofxqxS5JPwBgTFaBxdmnH180h8rdTuBu9dZZq/tOjyZ7H4dIRAb/5wtKoYK2xamjj81gkQcYatEObNsaJxQAjAMcqPgFkUFs/N2mwvJhBofpG+ehrtvoUacK3OuXJ6GCESrwiqPVEp6Q7eN/Qjdu6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmH7q6xM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698D2C4CEEE;
	Sat, 10 May 2025 01:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746841790;
	bh=RHr+I39kLwtbgreyeFB+nShG6YSzl7Gd7g3dqVME7HE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EmH7q6xMJqHQeQby/L3IQxh6hQJC34tJno6iuVALGs+6DOMqYlUgHanmK/CcUZ5YI
	 UoRXzRBnmkzXMa8+FIEJYWT7hXge2YON5ls9AIgViG1TrPUwxOLBqKLl8PwWnsfzXm
	 6XQH0TJ1BI5/qv6IDxjfpWu29uzKz4m0r9EbYLrC1AdFXiObgYRewuQ2q3GTLQhDIr
	 ftnsRF5Iy5B+tY4z3PmQFMzIRnvlZBWF0XIknAdyDZwkEF0N0LMZUJsSMTk9ENvJMs
	 /3XQIe8/7wqPuDalhTDE3xS/9NjXUcn1WDucHT+Ckm2IVsZr49cfXnZxWvwu6vK/xI
	 D5xjD44qOHfTw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 pierre-louis.bossart@linux.dev, stable@vger.kernel.org, 
 liam.r.girdwood@intel.com
In-Reply-To: <20250509085951.15696-1-peter.ujfalusi@linux.intel.com>
References: <20250509085951.15696-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: ipc4-pcm: Delay reporting is only supported
 for playback direction
Message-Id: <174684178804.47320.6060366096083840838.b4-ty@kernel.org>
Date: Sat, 10 May 2025 10:49:48 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Fri, 09 May 2025 11:59:51 +0300, Peter Ujfalusi wrote:
> The firmware does not provide any information for capture streams via the
> shared pipeline registers.
> 
> To avoid reporting invalid delay value for capture streams to user space
> we need to disable it.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc4-pcm: Delay reporting is only supported for playback direction
      commit: 98db16f314b3a0d6e5acd94708ea69751436467f

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


