Return-Path: <stable+bounces-128785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE810A7F17A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 01:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614D9189A0C9
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 23:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D763B22F16F;
	Mon,  7 Apr 2025 23:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaAMTv//"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BC622F150;
	Mon,  7 Apr 2025 23:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069744; cv=none; b=aj2rg3KvZb9akm0MSXdfONxQJsEz8qD1GQmtMphtbh8VRbGxpFLtBS3lQWUQcjMnOtih3v+E4G+1pO5KWF6FV+sLTnzBGXKxWT5Hsi2DhVnKSFtR5tiVmLQDH0gTlN5BhQ4mXxnsT2zL7pjUQXAetEFoRch1fy8sxcUwGnzOzy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069744; c=relaxed/simple;
	bh=T0uspW9/Ijqx9P00GZoH0tE07HGZVNdU1ou9cmIkz+0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BcWoFHgvWOZDyp6hm9DXdNZWa3n7x5zcE9Oc61FncrlcbLMNLWIe3mUI7X2p3Fu5LxHzQlBhLt3h54H1UccbkVQTBr5PeXyTztWP5o8fwD//9EC3tDeNJ4AER3v3BsWGwtIAC2BCErvHCkOQv46JMet+vB61hx3ZIE/Pr7WOeSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaAMTv//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADA1C4CEE8;
	Mon,  7 Apr 2025 23:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744069744;
	bh=T0uspW9/Ijqx9P00GZoH0tE07HGZVNdU1ou9cmIkz+0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FaAMTv//1bvpfmnnXE/c+6MV+xGOt059drXvmSI0izHMC3uCnbVNqLvRRsoJ7GNgW
	 UvvdokKRc24ZTyb9u7VyhwEUVy4JrIWax3jlbiNKHGxGkf8ojztEGZU0sYebpaDDk9
	 qbInLfnq8wBv2csv7M0sIXxe340ZViCuKxJofzco82K3iq0N5qDm7h1fkrrGIPrcbl
	 R6TF9UXUgB+wgw/N6a0SXrPgdaRnZ9zrHRCpgiPdnDXYhKPk5PYylyMWOGGtAGUPJa
	 Cnh6LDnzo3szF5gv6fSDN8j7gkD+lHTaNDTqOC1ZFoeXJr8it3BIZdhgKe0KQkyGoi
	 UEP0oJQsovNqA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 pierre-louis.bossart@linux.dev, liam.r.girdwood@intel.com, 
 stable@vger.kernel.org, simont@opensource.cirrus.com
In-Reply-To: <20250404133213.4658-1-peter.ujfalusi@linux.intel.com>
References: <20250404133213.4658-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH for v6.15] ASoC: Intel: sof_sdw: Add quirk for Asus
 Zenbook S16
Message-Id: <174406974197.1344763.13984039161281380994.b4-ty@kernel.org>
Date: Tue, 08 Apr 2025 00:49:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Fri, 04 Apr 2025 16:32:13 +0300, Peter Ujfalusi wrote:
> Asus laptops with sound PCI subsystem ID 1043:1f43 have the DMICs
> connected to the host instead of the CS42L43 so need the
> SOC_SDW_CODEC_MIC quirk.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof_sdw: Add quirk for Asus Zenbook S16
      commit: dfcf3dde45df383f2695c3d3475fec153d2c7dbe

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


