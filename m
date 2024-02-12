Return-Path: <stable+bounces-19489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A5C851F7D
	for <lists+stable@lfdr.de>; Mon, 12 Feb 2024 22:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8E31F216C2
	for <lists+stable@lfdr.de>; Mon, 12 Feb 2024 21:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147694D5A1;
	Mon, 12 Feb 2024 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4RZVVPq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF3B4D584;
	Mon, 12 Feb 2024 21:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772934; cv=none; b=XJduA8VkuFPixZPFJvQfeU8NedV2DjqwhVFhQQTrlILdSsiVzFvMEt0MWBYqOW3TedExprrbhlPvo5SSLRtLvmd2dGNETrZ/2PeOKmVEB5ciGmBJGEP5HzbX2nV+4Sq6v3EKaaCu79iTKwa4pK5Rk36uulWbza4IK4DfyA8wNQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772934; c=relaxed/simple;
	bh=y2iLG0GQmpYJsdLmgkXsj9hiys9+uUHJH94V7RjpizA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XZwLwc5X2gEFrEwzjtzEo/Ckge2v2DPaY0JaR7bz0x+o2rql78tY8ybIqe6dRYi8qjgXDtNWp//qViPjYgtqRW3s9j4Ut2U9znjxTsGJ+02ICyZCBkFhGIoesEHEC8YcTirKuLqqRWVjeiEFMy9H0CZU9SYCMoPhgxy3oWebv/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4RZVVPq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C76C43390;
	Mon, 12 Feb 2024 21:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707772934;
	bh=y2iLG0GQmpYJsdLmgkXsj9hiys9+uUHJH94V7RjpizA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=m4RZVVPq1QGp85ewCwpCVn7qNgnLPNRaTK8gROHssMUgf+NNIvNxrN4lC0IazDAGW
	 WZHePeRKV9IXp6Ojy9/meY4tMTECtYpEdtUfQHK4hC233ettFrt5fwC88EUf4BaWDG
	 TZ/DTrTp7sal7p6WAf5KOLDTtTLSl0NQvPlPRJriA1YUj/EjPlj2CFjALTMerzVHT+
	 YyqYDW/fHD1Dz17FukZdrRuSkqhPsuszWdQzWtzkdxQwBH2V3v0NAyDtxh9FrIeDYt
	 rjYLsroxAaULMZln5h8/zL0fX9ANyYzLlOpdJ4gwY1OHNf+Awslg9vglaKM0mqsMpm
	 b9NXyixrygbDg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Attila_T=C5=91k=C3=A9s?= <attitokes@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20240210193638.144028-1-attitokes@gmail.com>
References: <20240210193638.144028-1-attitokes@gmail.com>
Subject: Re: [PATCH] ASoC: amd: yc: Fix non-functional mic on Lenovo 82UU
Message-Id: <170777293259.73793.11135148439756356388.b4-ty@kernel.org>
Date: Mon, 12 Feb 2024 21:22:12 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-a684c

On Sat, 10 Feb 2024 21:36:38 +0200, Attila Tőkés wrote:
> Like many other models, the Lenovo 82UU (Yoga Slim 7 Pro 14ARH7)
> needs a quirk entry for the internal microphone to function.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Fix non-functional mic on Lenovo 82UU
      commit: f7fe85b229bc30cb5dc95b4e9015a601c9e3a8cd

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


