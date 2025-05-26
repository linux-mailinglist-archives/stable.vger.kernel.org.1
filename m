Return-Path: <stable+bounces-146385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F47AC4312
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 18:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146123BC49A
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 16:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6F0212D9D;
	Mon, 26 May 2025 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GA/WHMXH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B9A189F43;
	Mon, 26 May 2025 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748277171; cv=none; b=Q97n9dMOgBCEjR262O6JqBMXzkh1v4d/zkipN8oNGsEMdMAaFeaNdyhs/2JqKI9rZ4L4apJjwegA8EutKkYhvWv40piW1DeOx8q8wQSWiSNvQHfEDsKcCP2LllPF4FRjAFjImFKxxFSMwWK+Z8YsVizDJYHyEJiu8ctLKz6hJ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748277171; c=relaxed/simple;
	bh=Ma4os761GkGp+z0N7aFWeKTjkpegTOmlJdFuosSu/YA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P2WgVS0sdPFCfPXj2LZ3PKFDetc30DMpiLvhtPf0soqYDaGd0mW2sfNsoTTZsBTTscckQxvbC7KI0lmwj3nuLGnpAi99byrvqXyYrigN2iWai5RUAib3RJxkzQyhFQvLBmZU8uJYo9pzv5nxcb6NLS5FFkVXmR4C0HwB/bvFNS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GA/WHMXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C3DC4CEE7;
	Mon, 26 May 2025 16:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748277171;
	bh=Ma4os761GkGp+z0N7aFWeKTjkpegTOmlJdFuosSu/YA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GA/WHMXH0oGAx2dVXyrdQITMd1nESFLgiq3B0RTvY02lDlaWzFRVPbsW6gY+hMU0B
	 SXSsqEtxZILrDoAABBDskuv3mEZWHTiQn/Ms74/pTOt1tJvb4gXwvIAMFT9v9s1jgA
	 TMEmLlhRQA5ylVvZZuqikwh/ZwVmnqwW7RzIOMg65WOZGr1EkmRbaxX+RasUZjsATz
	 JrS9hBmgwwRzMOpa1+vp1SWWkcIVzRJdfVHGcDNiLZ7YAbOK8IjkhcbmLrKIYw3FSc
	 sLf5068WG/mM9gnv7YdU8s5gGDv2pkg3y3z94KhGYD4uiaDijcKyfISrQ4RTPoh8yq
	 z1TuCsJb37vzA==
From: Mark Brown <broonie@kernel.org>
To: Linux Sound ML <linux-sound@vger.kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>
Cc: Simon Trimmer <simont@opensource.cirrus.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 patches@opensource.cirrus.com, stable@vger.kernel.org
In-Reply-To: <20250523154151.1252585-1-perex@perex.cz>
References: <20250523154151.1252585-1-perex@perex.cz>
Subject: Re: [PATCH] firmware: cs_dsp: Fix OOB memory read access in KUnit
 test (ctl cache)
Message-Id: <174827716968.619234.9293902804072849882.b4-ty@kernel.org>
Date: Mon, 26 May 2025 17:32:49 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Fri, 23 May 2025 17:41:51 +0200, Jaroslav Kysela wrote:
> KASAN reported out of bounds access - cs_dsp_ctl_cache_init_multiple_offsets().
> The code uses mock_coeff_template.length_bytes (4 bytes) for register value
> allocations. But later, this length is set to 8 bytes which causes
> test code failures.
> 
> As fix, just remove the lenght override, keeping the original value 4
> for all operations.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] firmware: cs_dsp: Fix OOB memory read access in KUnit test (ctl cache)
      commit: f4ba2ea57da51d616b689c4b8826c517ff5a8523

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


