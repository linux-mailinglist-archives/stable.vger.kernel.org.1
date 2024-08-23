Return-Path: <stable+bounces-70074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AD595D963
	for <lists+stable@lfdr.de>; Sat, 24 Aug 2024 00:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3DF21F234DD
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 22:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A802F1C8FB3;
	Fri, 23 Aug 2024 22:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDMHd7MU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C94195;
	Fri, 23 Aug 2024 22:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724453827; cv=none; b=Eq18eduEzdLbk+11ZbD3esiOitxQ+HYgrqgqvJk41mXkcNWKiGbCCo5HsAMVgUi+DV69BQIqYX6UGzPJqM3bs84rJk6/2812g7G0pHc37IT6fkuPkFQ4AQKJO+zgfPHgFI/cjVD2uXbZEDKXt+Jin3Gu0NfIN6KoeIcwCx4Q/qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724453827; c=relaxed/simple;
	bh=YEWlAW8EptzlDgh1PYX50kGePpNqMzTDiwHO2I5Gl2k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F4H08RSbn47PEAq0qe7dl67fN7QbcQ4pOL15QxjKGfrJ6RWrCKqkHX86tmywdPXrCa8rWbSc3NHJDjZK4hVzD041fHo/AMqPAMpijw6h5E5OY7neLkxccUnLMnaJ++tFkyllyng1Nn0cbsbtJgZCxvGMp90CNGXlTgJVSZv0lUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDMHd7MU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA751C32786;
	Fri, 23 Aug 2024 22:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724453827;
	bh=YEWlAW8EptzlDgh1PYX50kGePpNqMzTDiwHO2I5Gl2k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gDMHd7MUyLQN+4VWO6M6ZxUMojaZYC+CQLngo6j60NPuhhoi5GQO/LmfpGXA06vYN
	 OL1HGk6wEJpCWVLIJV5T72eeZUcA8F7IPoUWrHmeRoFjvwj4DZGxzPmpVqX47mQULM
	 rNWR7pAIkWHHghTtdeHHyPS6DBvseCwFknvv/4tEh4lwOX/G3tBbWrPu3NMe7J1gEQ
	 c1Hf/EdxqLa/UT4NmOL+co9xdrZpq2h022oPHlCaiFb+WLQ4ZhsgIIEjuxoFzyMFMw
	 zg3YWuQzE5QpFVAcA0JFeG+jf14+/ln+Y2Vx5BpOQg0xxujKoB8y/jzravjl14u2sL
	 cHzke2vv9lyog==
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20240823074217.14653-1-hdegoede@redhat.com>
References: <20240823074217.14653-1-hdegoede@redhat.com>
Subject: Re: [PATCH 6.11 regression fix] ASoC: Intel: Boards: Fix NULL
 pointer deref in BYT/CHT boards harder
Message-Id: <172445382406.842154.866595904815365634.b4-ty@kernel.org>
Date: Fri, 23 Aug 2024 23:57:04 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Fri, 23 Aug 2024 09:42:17 +0200, Hans de Goede wrote:
> Since commit 13f58267cda3 ("ASoC: soc.h: don't create dummy Component
> via COMP_DUMMY()") dummy codecs declared like this:
> 
> SND_SOC_DAILINK_DEF(dummy,
>         DAILINK_COMP_ARRAY(COMP_DUMMY()));
> 
> expand to:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: Boards: Fix NULL pointer deref in BYT/CHT boards harder
      commit: 0cc65482f5b03ac2b1c240bc34665e43ea2d71bb

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


