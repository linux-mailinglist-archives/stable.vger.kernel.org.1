Return-Path: <stable+bounces-200455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD93FCAF9FE
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 11:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67A66305C4E1
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 10:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8388329B22F;
	Tue,  9 Dec 2025 10:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKZeyFp2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396711E9906;
	Tue,  9 Dec 2025 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765275712; cv=none; b=eXRoeXa8HtiRJATAsV26qRtJ9QxD7XvKFjtKMkOH+gcRZ+BGqsLaBy6LKMgaiQ9sM2P/XLdxXTL36F2bu/Ghfp1q3GFVCyfudwdmTa5cRhAEIZ2MmIUUbgI2Xq4JO79frj6W5ltlf1rvtsviI3vdae+PeViFnJxJ6qK6+ON7goQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765275712; c=relaxed/simple;
	bh=OZhOz4cU8KwL/ErlN0YhJbk6yqoUwfwH1An1my3Wv4w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NI6D+GgOf9Yq9+DeCHb1UCXtY+BGoHHDf4cDprzn5IGSVpMVKXoBSixo00jhwHO6t3uRBD6EFQNZ5J7QFgFfdLuYV7laG5YsH4le33X4aefdUq3OICurIIg1amSJWuZ7KxcX/pC2yLphfA1Vr8SuCGf6mmcrZwzb+GaXdL6Igp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKZeyFp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58169C4CEF5;
	Tue,  9 Dec 2025 10:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765275711;
	bh=OZhOz4cU8KwL/ErlN0YhJbk6yqoUwfwH1An1my3Wv4w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mKZeyFp2mopZlgW9Dx8T3brSlDxVHKGjOPZC3QA0JIapVdo8ySeBZ/2Ysbbt2cs6h
	 AfCSAhulsfdfclQB4JTAfqm8i6t6g7PiP4ZeUACNO2nr1QenrTbwRBW5sfNqak8r1H
	 agMCeZLwZfvNYhDmSPrB6mAPPiMAkSWJayQAhBy4tMuvMg7folceSHD5onVtkcDcqe
	 TaMB60PjeZ5FgEqhpe226cCW0JOubvnn+lOE/ImvxhNQyntf2+xKz+922TtRQQh+JI
	 /e3Ql4Q75DIxLtNUjnTT8rM8M5CcXj7tX132o2wIfFLNNvFgmcwFb1Ja2o90h62oQh
	 0DH/VEKIreMeg==
From: Mark Brown <broonie@kernel.org>
To: David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Stefan Binding <sbinding@opensource.cirrus.com>, 
 Eric Naim <dnaim@cachyos.org>
Cc: stable@vger.kernel.org, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
In-Reply-To: <20251206193813.56955-1-dnaim@cachyos.org>
References: <20251206193813.56955-1-dnaim@cachyos.org>
Subject: Re: [PATCH] ASoC: cs35l41: Always return 0 when a subsystem ID is
 found
Message-Id: <176527570492.622854.8355694414573165459.b4-ty@kernel.org>
Date: Tue, 09 Dec 2025 19:21:44 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Sun, 07 Dec 2025 03:38:12 +0800, Eric Naim wrote:
> When trying to get the system name in the _HID path, after successfully
> retrieving the subsystem ID the return value isn't set to 0 but instead
> still kept at -ENODATA, leading to a false negative:
> 
> [   12.382507] cs35l41 spi-VLV1776:00: Subsystem ID: VLV1776
> [   12.382521] cs35l41 spi-VLV1776:00: probe with driver cs35l41 failed with error -61
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l41: Always return 0 when a subsystem ID is found
      commit: b0ff70e9d4fe46cece25eb97b9b9b0166624af95

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


