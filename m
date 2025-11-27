Return-Path: <stable+bounces-197543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8293C903F9
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 22:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADDE64E01F5
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 21:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC9230E0C0;
	Thu, 27 Nov 2025 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puBVSC1G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E3C191F66;
	Thu, 27 Nov 2025 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764280336; cv=none; b=ADtJ6SoG5DCoV2cldcbUTOrjsTzUSwJAGjteYT1WTPx8jRXPXf1nxt3Q+aQ156lsRj4GpXAJnHMh30eBiw6c/JM42Rge0shLDCPyHdRAF51NKSpnZsQ9WBtQPO8il7nDV3421/scCGW9oVhCafnJZGB5cBL8Yled8ZsYIA+aB5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764280336; c=relaxed/simple;
	bh=s1MznjwddcvkyO/j6phzRLVMMLlMAlckSJZwNlQswHs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W8c7ABPiRbCvG1JLbChmVM65BnXWroi89U6lIYg5C2gkkBg2zX3Gznwi5zSP3RJY4qGUmPIZxcR/pUncogd71KrC1H8cvQzawa6opeodD1EnZQxMarLQRJL3IaAInsqYntpFXYMDPMpTuiYel/iU1BpaCsJtXDCVdQv6pZmf73I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puBVSC1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CCBC4CEF8;
	Thu, 27 Nov 2025 21:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764280336;
	bh=s1MznjwddcvkyO/j6phzRLVMMLlMAlckSJZwNlQswHs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=puBVSC1Gb8rsNL4G4nt2htaQTEx9hthvo9CJ3FESXRxHBhFf2/mpyK2elLMefrUwH
	 0vWLTjNVpnnGsI5l/mmQ8w8K/5GD0PvTrYwPvuDohtdjWMfuz7ktFKDmOnfhGjZtYt
	 zD7scSAqUlrmKbqULdGhQOb37WRc7iUcXSx8HB+2wBAK2TBodDcMIo9c91JaJIVukI
	 Fg3eGFoDN1gFInKhJ7cLuIG8UkiUyZTyGiWS/ZCNt+n3yygy9IGVsmHe/XHsv9iyz5
	 7RljZHkPXispBIAXoBRsTK1MZ+XhyuAqxMreioHUiLyl4+7cl2rkBPnSP88LoGdSZb
	 Jl3BuF09wBwiw==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srini@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20251127135057.2216-1-johan@kernel.org>
References: <20251127135057.2216-1-johan@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: wcd939x: fix regmap leak on probe
 failure
Message-Id: <176428033461.177680.12682432432005950288.b4-ty@kernel.org>
Date: Thu, 27 Nov 2025 21:52:14 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Thu, 27 Nov 2025 14:50:57 +0100, Johan Hovold wrote:
> The soundwire regmap that may be allocated during probe is not freed on
> late probe failures.
> 
> Add the missing error handling.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd939x: fix regmap leak on probe failure
      commit: 86dc090f737953f16f8dc60c546ae7854690d4f6

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


