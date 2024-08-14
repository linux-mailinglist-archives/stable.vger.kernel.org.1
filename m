Return-Path: <stable+bounces-67716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48661952456
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 22:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA391C2103B
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 20:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66EA1C5795;
	Wed, 14 Aug 2024 20:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBmGe4RC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDA7210FB;
	Wed, 14 Aug 2024 20:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668986; cv=none; b=GRDtZGpERktr/4kb8fSObhj8QjgY3JAS1pLYsCyqjP/Ajrj20tFMxUI/6XRsYp9gehnmdSrFO843bR5knez3dyzKUGmfpmNtrLEPh4FVvW2KO0oWGCd8q0E7HZ8uhk0fjCjVh8aPTJsR6DRl7RFWY3SXGXQn35ktu/vwe8gDDvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668986; c=relaxed/simple;
	bh=ToKZGCbRFgMoTJWEPcWJCk1aKa6A1fV+A+HwVlMNNNE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nSB9ekIPvEDMpeiNrJLg5aM0Sq+an2LwOal5cqxjqSSbooYrYu491hg5VX8ClTjjBmIuiAnfqW9qLQUJOVuDwWWwDicoz74E3xzqyJtP9kmQtj5rTktUUv3L20XJ0pl7VG35VzSRRJJ/tl03iTTgHdSEUBlUQpE86gNdCwk34XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBmGe4RC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D71C116B1;
	Wed, 14 Aug 2024 20:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723668986;
	bh=ToKZGCbRFgMoTJWEPcWJCk1aKa6A1fV+A+HwVlMNNNE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oBmGe4RCevhmKPnTxa+UmErKVrFo/QP9KBanRlk2ru/mgYd/H4PIfcCz6LY/ZtFoD
	 QlQwUSqU7yYvUMrNLu89fP6RVH7xlMqKqycjrmDQizexYBCosWFUqxpMmHRLoUYve0
	 52B+hvobMG1jRrK1LkuVjd6gH+EFViBsqbYINDAZEkdmWNLMra5yMkkpFoR03ZUiom
	 k+CCtUhs0+/cW/BvqDvH5juPDowJLuPGdsrUibVh+eH9DM54ZYNv3wOBQ0bdKLIGQf
	 ysAKu3QjVRKjXfXvGaOEYxShgGikq66WShutdrL1A0EHW0ldLYHG/5FWIuHkxifzj3
	 XxCsXSuRXcY2w==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Prasad Kumpatla <quic_pkumpatl@quicinc.com>, 
 Mohammad Rafi Shaik <quic_mohs@quicinc.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: stable@vger.kernel.org, Alexey Klimov <alexey.klimov@linaro.org>
In-Reply-To: <20240806114913.40022-1-krzysztof.kozlowski@linaro.org>
References: <20240806114913.40022-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: wcd937x: Fix missing de-assert of reset
 GPIO
Message-Id: <172366898385.334805.11696453398895382213.b4-ty@kernel.org>
Date: Wed, 14 Aug 2024 21:56:23 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 06 Aug 2024 13:49:13 +0200, Krzysztof Kozlowski wrote:
> The device never comes online from a reset/shutdown state, because the
> driver de-asserts reset GPIO when requesting it but then, at the end of
> probe() through wcd937x_reset(), leaves it asserted.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd937x: Fix missing de-assert of reset GPIO
      commit: 2251db28edcc70b7ee8a8c6bcbaecf752b3ea5ec

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


