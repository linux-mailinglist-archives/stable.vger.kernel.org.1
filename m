Return-Path: <stable+bounces-83342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A565998496
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 13:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCD6282A55
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 11:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1608F1C3F13;
	Thu, 10 Oct 2024 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ex7U2jk4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD41A1C2DC8;
	Thu, 10 Oct 2024 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558849; cv=none; b=oZlEYKmWazZYkCyyzu0SMcg3WDgKZGwehbXMob8KzVTQhog6bYt060D9UPT9wOc8Dnx2k0z7bo8ZCz6HWVpNRoikPn/PWMBMrxYtyjU07VkMoqbuMJFzLnK2EHdPKIIYruCP7VBjfHmCLEhXaIf5lcqtVvPxG/M9hJMsYxGBq/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558849; c=relaxed/simple;
	bh=Xkcwtb0WrnxptNevR20ESVve7MqObs8X2QnVhJ8ogb8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lYxuZh6BF4/6K9CnCchs8qnYiuXhALZhKGT4V8YuhyAjoH1lpCocAEg/YlkX2C5hZcBsGeS4ViZa9nIEKIzajp0GZjAlrjGu+rqLZYGuKO4KZ9RtmQVcqcgCflWWIeioioc47o4a+3Xk+jMo7HQpRTtwkKkSx+vWEu3cKF/KtgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ex7U2jk4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A5CC4CEC5;
	Thu, 10 Oct 2024 11:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728558849;
	bh=Xkcwtb0WrnxptNevR20ESVve7MqObs8X2QnVhJ8ogb8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ex7U2jk477p6hZdg9nxjjM4IaQodev13qL6nKjaAlX575f8y1Wq7wXAW0MkOEQkqm
	 BdCrnr7tCULO2QmQQRPyDgs9yfFIYxrPblJE6DnlF5o4TdeLG1Kwc08LnXLcLGxUc/
	 ED6KZaVh+YdOKD4MQMVoe3h4vE6p9FcOVVQsT/qjoVm7PCV6eZKtCMu+c57BxvlBau
	 1MYAJ/xdHWm3C9jSshsY6zwqfEiXl6sRIkN4ycvWNj3rEAzziYAiQ74ioKiHqjL35T
	 6PDiDsuLqgLgcULBTBW9MKhGH2LCNgIyXcERliLLmoV5u+L/vAI2rGSNjB0pL72YSi
	 85HA9jRDHaHRQ==
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Benjamin Bara <bbara93@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Bara <benjamin.bara@skidata.com>, 
 stable@vger.kernel.org
In-Reply-To: <20241008-tegra-dapm-v2-1-5e999cb5f0e7@skidata.com>
References: <20241008-tegra-dapm-v2-1-5e999cb5f0e7@skidata.com>
Subject: Re: [PATCH v2] ASoC: dapm: avoid container_of() to get component
Message-Id: <172855884665.3258793.1116462601049800083.b4-ty@kernel.org>
Date: Thu, 10 Oct 2024 12:14:06 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Tue, 08 Oct 2024 13:36:14 +0200, Benjamin Bara wrote:
> The current implementation does not work for widgets of DAPMs without
> component, as snd_soc_dapm_to_component() requires it. If the widget is
> directly owned by the card, e.g. as it is the case for the tegra
> implementation, the call leads to UB. Therefore directly access the
> component of the widget's DAPM to be able to check if a component is
> available.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dapm: avoid container_of() to get component
      commit: 3fe9f5882cf71573516749b0bb687ef88f470d1d

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


