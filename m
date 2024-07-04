Return-Path: <stable+bounces-58063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F9F927972
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 17:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0774B214D0
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 15:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E091B14EC;
	Thu,  4 Jul 2024 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQjKScyD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D2A1B143F;
	Thu,  4 Jul 2024 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105323; cv=none; b=HqUhVM50EWuFHJCABN5BQ5f1wqrlJeLr78ivZu3YNbjraavCl+ukDyP52ZX1ehEJMO4KcsmGTy+PooWtqtdDkXZa2ppQCJQ92gNVzghLjubL3G+PLv941MX1tTVX9+G4nu+EQgYFM9nk0a60RaoyrnGRUjPUJb+qF4xqw5Nawj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105323; c=relaxed/simple;
	bh=7UHlyrvutroT0e2Bj7J6khcsqqDlXY5x61RtVzZzXig=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uSFtyLkdGl01dauiK90AjEmgDTP4sFm/cZLNAQoRgU8gWrCEB+tJJQz/e/vMCeh094uWDtdF6uJ4siHyA2MNoEAaUZ2DbF0Uu16dgEwG7iGz3SC+t3fUoM86svLB3230z+RZpLIvglpWLc02QtvYE1mAAwTu4p8a8DexP8iZevw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQjKScyD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5053FC4AF0E;
	Thu,  4 Jul 2024 15:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720105322;
	bh=7UHlyrvutroT0e2Bj7J6khcsqqDlXY5x61RtVzZzXig=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bQjKScyD1701uwvQqGnFVg7mzBu9pxrhpdV3QMhVuITH0B1wLcQ4zdzicCpAesTtX
	 6OmZ21c3HGM7kkifugPF/TEwyg0ovTj3tXWta2AMWCLzToj4CzfuBRa/nnVDmmPZMY
	 LKnZnY2rvXjpccQpGSUjJJHRxYN6f4azWNb+stt3RZtdfhMnMHz8EQbrCgv272RkW+
	 kQ+Ae3z62q4QamcxQPd4nYrik7uo39mj1eDPKHEi5YNZQA8kzoADO1yFH/iKaeWCzv
	 hQZvsZHvryVNPcHOZ8EsSaXtNznYtbbdaEgvbByKqWzkRJU1m9FJGToZO9yrQ3dEo8
	 2hm+bhdzwwtLQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: stable@vger.kernel.org
In-Reply-To: <20240701122616.414158-1-krzysztof.kozlowski@linaro.org>
References: <20240701122616.414158-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: wcd939x: Fix typec mux and switch leak
 during device removal
Message-Id: <172010532104.64240.18084031474568618131.b4-ty@kernel.org>
Date: Thu, 04 Jul 2024 16:02:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 01 Jul 2024 14:26:16 +0200, Krzysztof Kozlowski wrote:
> Driver does not unregister typec structures (typec_mux_dev and
> typec_switch_desc) during removal leading to leaks.  Fix this by moving
> typec registering parts to separate function and using devm interface to
> release them.  This also makes code a bit simpler:
>  - Smaller probe() function with less error paths and no #ifdefs,
>  - No need to store typec_mux_dev and typec_switch_desc in driver state
>    container structure.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd939x: Fix typec mux and switch leak during device removal
      commit: 9f3ae72c5dbca9ba558c752f1ef969ed6908be01

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


