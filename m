Return-Path: <stable+bounces-192496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 997FDC3571B
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 12:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C707E4FB5AB
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 11:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A4D3126A9;
	Wed,  5 Nov 2025 11:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqAyiaES"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBC3311966;
	Wed,  5 Nov 2025 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343037; cv=none; b=SUj2ZtQ3NsEtSihEHlWEhTsYPymhjbVXOwfwOik/xMqBUnrS1Z9tYjgAJtqunnl2xjYfHWsNTj4ju3vpM3b1l2kLjDoPyhIdbEdDaqME31bRcrCb4GfWrdIW9JojP47tFPovPcHtFxw6ob2yjOr4c7O8F/VBtu4StpBv/VrrOKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343037; c=relaxed/simple;
	bh=h5JX3/zpTeIOt3QvO8xPfAmXdUV111BC7ul7odjpy8g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L5LCDQ52n4wEq9ddCfk6q/Th4pAqpqzsIyd4wKvw5bZ1Q4VYbYqxGaTowIbJiGiK4aMXViFlejqrFPTqEh/R2/s1FxsjH3B7Z7SM/6dKyvmq7flJaJlUGH8DxD3GTCU/Yalcmr0UImFTFTNI9Dt2H8c9a1cbxrx+Kq792Qd21UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqAyiaES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63684C4CEFB;
	Wed,  5 Nov 2025 11:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762343037;
	bh=h5JX3/zpTeIOt3QvO8xPfAmXdUV111BC7ul7odjpy8g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FqAyiaES98kXi1OrgibIUTRYTfb5hCvjSxJ6eKiVYeAC2pqgpGe/cBn0D5F32CFN/
	 TbRpf3jYSnErMqs45SzhzzV7ghM8THjYCDSdYRJZWPXuMeUeZa1PG+F/AtiKZ1rjD4
	 pQygPzli+y7OPajLBXzuhZGXXpq78V01uXu4F9Bs0lAcj4PG4yc97SuRvaTcwy2rK7
	 BXrZhrzjfOxZGYOMcgfLwKr9f/m9bqDqSKmAE+Pxy0TO1o34dbeqYXbFRzPm1OKy4A
	 GYmdTdMbGP25BsU++WmDrl2T4QuiiL8zF5r/mvuC29wKrpYarNlDaRgIkIS9xZtZOd
	 XmVFbKA4BLGZQ==
From: Mark Brown <broonie@kernel.org>
To: support.opensource@diasemi.com, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, Claudiu <claudiu.beznea@tuxon.dev>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
In-Reply-To: <20251104114914.2060603-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251104114914.2060603-1-claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v2] ASoC: da7213: Use component driver suspend/resume
Message-Id: <176234303429.2251668.15736114321268671077.b4-ty@kernel.org>
Date: Wed, 05 Nov 2025 11:43:54 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Tue, 04 Nov 2025 13:49:14 +0200, Claudiu wrote:
> Since snd_soc_suspend() is invoked through snd_soc_pm_ops->suspend(),
> and snd_soc_pm_ops is associated with the soc_driver (defined in
> sound/soc/soc-core.c), and there is no parent-child relationship between
> the soc_driver and the DA7213 codec driver, the power management subsystem
> does not enforce a specific suspend/resume order between the DA7213 driver
> and the soc_driver.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: da7213: Use component driver suspend/resume
      commit: 249d96b492efb7a773296ab2c62179918301c146

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


