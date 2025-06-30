Return-Path: <stable+bounces-158936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EF2AEDB55
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 13:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C307F3AE40B
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 11:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E9121A455;
	Mon, 30 Jun 2025 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAo0Y5cq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD2C25CC64;
	Mon, 30 Jun 2025 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751283616; cv=none; b=ZXaLQ/+CjczC0RmXu4f/DCax0wPio7h8BWsNc+hEVHHjf32Tu9Op4a3Y6X38/pOoCT4OdF1UZvfN2VtbDq7/AA6Uozmc0wo/23cwVkdlg1rqCOZLvY13GkgrMeIaeScOCHFpgdnnD06huC8X6NtbQEMQ6ejx2xriBD2bU7BPrFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751283616; c=relaxed/simple;
	bh=LKlH+AYR76n8DFV4IF91R80s3PE0sUN7OOb+h3R9KXk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hCt3Y5hpNcOb7uNlN+yu0QLJ1MCk6ReslxZdB9M41zxS0BLslqhWzFXMWBZ7CIxVKgRoT2fZu72gg6oSrQFKfeMfKky9C1jiQCI1hjjCEpEfYT1xrl2inS18QmEl+w+jyew28L2pZ3zSmP5MFvB2iJ7fVSaw1ZejxVE58uUxjxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAo0Y5cq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AD6C4CEEF;
	Mon, 30 Jun 2025 11:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751283615;
	bh=LKlH+AYR76n8DFV4IF91R80s3PE0sUN7OOb+h3R9KXk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jAo0Y5cqO51tfTQigwo/NJEQq0+QcIu5+mlpcu0SMFAZZ2yGxDbGbaZIFrUtIDPMJ
	 hFc66SForMUorqbW7VZnUx/qAfQQ9GId2+gvcywLPsbvbTl5TFaCRBA3pJKI8qC0kO
	 x5fP/1sUfiCTGj7xUQBSbF8FN828Qd8Mpy4skxpShSR1l4CNP7ekmRUJ2dhdVJ3chY
	 worfYae5O+OWwC3+6UO2Uvzm0HKJiQu2s+cKz3Hz2Iwc2O9bPdL/ruIEkSby3PxnF4
	 cj/2720wx/4l1dT4bv62fHmRRwcAcdiDHYy2XL14kHRszO7JvFm/jy30I+zcCLhUmS
	 5fgVjHT9YMVNg==
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Arun Raghavan <arun@arunraghavan.net>
Cc: Fabio Estevam <festevam@gmail.com>, 
 Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Pieterjan Camerlynck <p.camerlynck@televic.com>, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Arun Raghavan <arun@asymptotic.io>, 
 stable@vger.kernel.org
In-Reply-To: <20250626130858.163825-1-arun@arunraghavan.net>
References: <20250626130858.163825-1-arun@arunraghavan.net>
Subject: Re: [PATCH v4] ASoC: fsl_sai: Force a software reset when starting
 in consumer mode
Message-Id: <175128361295.28563.443890248287811390.b4-ty@kernel.org>
Date: Mon, 30 Jun 2025 12:40:12 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Thu, 26 Jun 2025 09:08:25 -0400, Arun Raghavan wrote:
> On an imx8mm platform with an external clock provider, when running the
> receiver (arecord) and triggering an xrun with xrun_injection, we see a
> channel swap/offset. This happens sometimes when running only the
> receiver, but occurs reliably if a transmitter (aplay) is also
> concurrently running.
> 
> It seems that the SAI loses track of frame sync during the trigger stop
> -> trigger start cycle that occurs during an xrun. Doing just a FIFO
> reset in this case does not suffice, and only a software reset seems to
> get it back on track.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Force a software reset when starting in consumer mode
      commit: dc78f7e59169d3f0e6c3c95d23dc8e55e95741e2

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


