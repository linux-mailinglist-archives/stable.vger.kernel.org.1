Return-Path: <stable+bounces-152300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74730AD3AF8
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 16:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B4C27AF130
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 14:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2002BD5B6;
	Tue, 10 Jun 2025 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PI9OD33N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECF22248BD;
	Tue, 10 Jun 2025 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749565001; cv=none; b=iV2di4BWkU4cZkNdukYUod7bp6dKSAWDgLOCvhf+FjNkFtiarGihT4WTG15ulY08zQfxasKWT5/tDo7mJDh7Li/IKi7cjll6CGNGCGG0FPYpG6fIjYQiaLI4u6uNpr9q1kmcFXLQTUcoBm1/D+kZV9LhOF9jkitAblw5dY6SBCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749565001; c=relaxed/simple;
	bh=xzjkJXy5nV12SXSVlGCVriM090em/5m6G36M0RvdZnU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HBisKkk8JmI1e409wAQCYkAl09oBbP0GfP2yreoLeniaa+cTgM5Y/vpSvDJ69Avnwddda9ehhfnywpPkEx98jydMthkeIht51LfWUomRLN1UJ7vMOu/L+i8/w5kORaM4//R/kS++5aB5X2GqOjYOr1Z225GAP3f2I4pWgSo/4Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PI9OD33N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3360C4CEF1;
	Tue, 10 Jun 2025 14:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749565000;
	bh=xzjkJXy5nV12SXSVlGCVriM090em/5m6G36M0RvdZnU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PI9OD33Nff5Z58Y9xqxk+aTeRsPO5ykdw0lzLY2KdlEJud4eaIvJLOxJ54ElWfXmy
	 JtzOXWFfln2LcPRCCsSW92Jmv7xvgI4tG2vIctS9GcuN+SGp8YWg0+YqmctcjZnMnA
	 M9sDfaGfa5LE45rUqnLI+pdTMYsLkdmwkWcQ09TP1uxhn41DzhVS826AHq+NupzZ0y
	 5+WAwQ3mC3HZwMXNmeqSUNqDOR6xiiPdisyXCifmaq9aqQ1g88+Gp3Kfm4n3HT40uO
	 J6bmC6ULP+Mf1XHzQ5R3bns/v57SgZn0+a8ZpnlYM92z1DxoCyyCys1Qfi2uvvjwfQ
	 eGeIdUWWwSqVQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: stable@vger.kernel.org, Liam Girdwood <liam.r.girdwood@intel.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250610103225.1475-2-thorsten.blum@linux.dev>
References: <20250610103225.1475-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] ASoC: sdw_utils: Fix potential NULL pointer deref in
 is_sdca_endpoint_present()
Message-Id: <174956499773.45975.12052046970647716420.b4-ty@kernel.org>
Date: Tue, 10 Jun 2025 15:16:37 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Tue, 10 Jun 2025 12:32:16 +0200, Thorsten Blum wrote:
> Check the return value of kzalloc() and exit early to avoid a potential
> NULL pointer dereference.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sdw_utils: Fix potential NULL pointer deref in is_sdca_endpoint_present()
      commit: 6325766d69900d1aa9733fc7572456fc4427b708

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


