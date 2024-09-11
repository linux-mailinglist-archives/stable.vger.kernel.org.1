Return-Path: <stable+bounces-75901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65893975A0A
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 20:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E9B28C7B2
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 18:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01A71AE035;
	Wed, 11 Sep 2024 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2qvIMzY"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82B61A7AD2;
	Wed, 11 Sep 2024 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726078199; cv=none; b=hb+5zprp3WTQMCAHNh3Qnh+czpOFB6kkoJYPCaS5hTbVoWHOIreaqefd7PQgitwKuND4OpG6VW7Vx8MBu9HinTOJxGBUaG6Uhj5nVpMTtmkKIvVZDEw5xM15WvX9eCykWvPP4JR6vX79//NzfJuko1yp+Y3aFkG8GgWy7UJj2Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726078199; c=relaxed/simple;
	bh=t70OeUTPl2Hdc8vLGhMSBtVwCkdkMR0JsnyjS2GNsAc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bNgFmKr6PS+Ex4q0cfaYEangxskjp2hXQS7D/3885YldgZ/gYDODrmlqYH7n5aFZUEQ1S/SG8lcRPbOC9/N4+rMBsygxLFlNsojt/a5xJJKuOdp29GzHg3dXOREYcfuF8N8q4TUmyFmwKtOdT5RsVelvhdwUWmh7s5wUK/0XC1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2qvIMzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC9FC4CEC0;
	Wed, 11 Sep 2024 18:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726078199;
	bh=t70OeUTPl2Hdc8vLGhMSBtVwCkdkMR0JsnyjS2GNsAc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=q2qvIMzYmdwsOs/n5Y9KRsjyYolmc+I+asb8nY4g+jh9t4K8HMgVQ4c3t02X2UxwW
	 Wx9E5Pb8uTCiXd+NUd/ucIsuB4h3UXgqys2jgIIQh+JHUnuiV7ZXtlU7LMhgXwOO/M
	 5SQzYsOxfWM9rbz+DdmGx0JoiVgorZy3n1u4GbGpiJ8ruUTvhbd8FgACUyftHzh3TR
	 3Dxo1PFFp95CBfspFYF6p0aaaMg8bAsmBivqueyPczALrh2rBhABPcdFnbYKQm0fQq
	 AhYmaHgDzIsDglr/5IafcOx2w7bfIuJ/GpXz1qEKB5oezpA3CU/snUCJwLsm2Gl3ea
	 sFLBOplnrJ42w==
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kernel@sberdevices.ru, oxffffaa@gmail.com, Stable@vger.kernel.org
In-Reply-To: <20240911142425.598631-1-avkrasnov@salutedevices.com>
References: <20240911142425.598631-1-avkrasnov@salutedevices.com>
Subject: Re: [PATCH v1] ASoC: meson: axg-card: fix 'use-after-free'
Message-Id: <172607819595.127216.9881900790170289531.b4-ty@kernel.org>
Date: Wed, 11 Sep 2024 19:09:55 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Wed, 11 Sep 2024 17:24:25 +0300, Arseniy Krasnov wrote:
> Buffer 'card->dai_link' is reallocated in 'meson_card_reallocate_links()',
> so move 'pad' pointer initialization after this function when memory is
> already reallocated.
> 
> Kasan bug report:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in axg_card_add_link+0x76c/0x9bc
> Read of size 8 at addr ffff000000e8b260 by task modprobe/356
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: axg-card: fix 'use-after-free'
      commit: 4f9a71435953f941969a4f017e2357db62d85a86

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


