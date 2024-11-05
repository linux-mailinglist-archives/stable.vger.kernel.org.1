Return-Path: <stable+bounces-89889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332AF9BD28D
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC18F2816BD
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8904E1DD0CF;
	Tue,  5 Nov 2024 16:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcQsoc+Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AF71DC182;
	Tue,  5 Nov 2024 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824698; cv=none; b=Xw2hvJyT2HgzEdw/z455U/Q2k6nQ2TEMSX2WhZ4a8732lBQEk1sSR6n4TJsy1L1Vi19wl7atE1HbaD7+/w6VHjQQ9dCqGoK/hMWUH4gdhf4Mfq8z0LmxZXip3CVBsvnHpPyR9wFJg/BFPpApIHlU03kKRSpL6NJJ3wzOxqo31f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824698; c=relaxed/simple;
	bh=ORqsYWN5LTjtakU/Jqc07JENFyXvLrJpzmnmxASVu2s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jNgp1QsUP/Nh5+77GHlnQQYYd3EPCwYlvWwQtDKpxbo+YqjSrYuuZAX/Gly85HdH6X26ACD2dMDIM6WI8eZ1GLnqPQTWp/whBmzptOxLKERWi8BVrDoX6y9wEEZ//7iygj2FZvzJ8pcd2D0YWhdDaSiqPs1t3cUxlUl6P6N5bMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcQsoc+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FC7C4CECF;
	Tue,  5 Nov 2024 16:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730824697;
	bh=ORqsYWN5LTjtakU/Jqc07JENFyXvLrJpzmnmxASVu2s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IcQsoc+ZlOob79/Aq4GrbYbKFOPUdjUPE6tvazHlPbhagLe5aA4F/23d/di/cpNmz
	 2rrrPxUEVR6CSq3+7pZKQxMA5IVuQKZXpc7DE9m1G72rDWlxWw5dCGBgJ26fFvlj2/
	 oMmt1H3JqxWlIAMkvZbUGg7N4ZjgF9CMgEoZIA6WU4VpRJS4w9KWl8hsH8RLRIVzI5
	 mSukbLYLeoboLOXbkGgZ+gGFw98ve4gFfgycyPH6ewy030uakhHlscspqWaiB2pkUv
	 dSsJNwhQI6L/4r8NOGKip0bqbWMw9DCstV3zRktQWujAXSyJuKjfPhkNN0PTDB9ZFi
	 zwJ5sOi09HxYw==
From: Mark Brown <broonie@kernel.org>
To: support.opensource@diasemi.com, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 baijiaju1990@gmail.com, stable@vger.kernel.org
In-Reply-To: <20240930101216.23723-1-chenqiuji666@gmail.com>
References: <20240930101216.23723-1-chenqiuji666@gmail.com>
Subject: Re: [PATCH] ASoC: codecs: Fix atomicity violation in
 snd_soc_component_get_drvdata()
Message-Id: <173082469577.77847.18367085097740716832.b4-ty@kernel.org>
Date: Tue, 05 Nov 2024 16:38:15 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Mon, 30 Sep 2024 18:12:16 +0800, Qiu-ji Chen wrote:
> An atomicity violation occurs when the validity of the variables
> da7219->clk_src and da7219->mclk_rate is being assessed. Since the entire
> assessment is not protected by a lock, the da7219 variable might still be
> in flux during the assessment, rendering this check invalid.
> 
> To fix this issue, we recommend adding a lock before the block
> if ((da7219->clk_src == clk_id) && (da7219->mclk_rate == freq)) so that
> the legitimacy check for da7219->clk_src and da7219->mclk_rate is
> protected by the lock, ensuring the validity of the check.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Fix atomicity violation in snd_soc_component_get_drvdata()
      commit: 1157733344651ca505e259d6554591ff156922fa

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


