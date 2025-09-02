Return-Path: <stable+bounces-177002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 848B3B3FEDB
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8767517195B
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 11:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8CD30274D;
	Tue,  2 Sep 2025 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSMpTUTd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29985301463;
	Tue,  2 Sep 2025 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813879; cv=none; b=FOXFIIs1RzC1RvIw7gOu6xxCZzExIiURPipG9FH5c4IVhENSPKRJGcddcNWpq4gw9Oi3aO4K+s11m61BAXfgecVmgiruY7LokMEyGd1H3fwiUsw8ZQvGS3gxWUWOsoXhzWMhllVn1EJaV+dVPOK1+FWpI4M7ITf7hf/PSeXA+h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813879; c=relaxed/simple;
	bh=qTDpFch4LkA9UA5PXyvDt5kiITs7nPC16vgsVaS1+Q8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ml9i9pcKm8b9UKhmeDLIyu8CMMNd0BfEueUhNIEat1E44pv0mNWtTohQSsd+CjAtL/zz1Zn03+rsIpaACPiehj/AjwJjA0N1WbiZaSTP3PQhaG2ex+wUTD/NYdCy+3HRhDWoNMiPew6MEcTTm0YciRDDeAV48/5fparuemfa15U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSMpTUTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D588AC4CEF5;
	Tue,  2 Sep 2025 11:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756813878;
	bh=qTDpFch4LkA9UA5PXyvDt5kiITs7nPC16vgsVaS1+Q8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PSMpTUTdOWKsj86z2NHvthCcrc9VS+Fcdm/OLibjY7dZ2O3ta3s54HIb/ym4jY1SX
	 PuqrYiOFv9Ehukfo3EtKWFrQfESXpsXWeizF3/p8zcH0Yj+l6igXG+6jqcRZ1s85Vp
	 0RrpMtQAuxedYAoGPXTfj9xTopV5XIxyDegdhqP2QPJYyrMHZlXjnbu2vGpcocbtPW
	 RrbHHFXP5f9bwTLVmpqsqHhWlLAWdVNumSVt1LJItLsGA4NRZ4TAgj8jk7k1MvmULJ
	 C9k9U2bbaH5WCSzRVNRorv/wdQguHvKxfmeS66KGBe0CGC8DwVWQLUWwmL4Et7ROry
	 OpQxUpjOjBP+w==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Takashi Iwai <tiwai@suse.com>, 
 Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
 stable@vger.kernel.org
In-Reply-To: <20250901151518.3197941-1-mstrozek@opensource.cirrus.com>
References: <20250901151518.3197941-1-mstrozek@opensource.cirrus.com>
Subject: Re: [PATCH v2] ASoC: SDCA: Add quirk for incorrect function types
 for 3 systems
Message-Id: <175681387544.70970.16206640959939066441.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 12:51:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Mon, 01 Sep 2025 16:15:07 +0100, Maciej Strozek wrote:
> Certain systems have CS42L43 DisCo that claims to conform to version 0.6.28
> but uses the function types from the 1.0 spec. Add a quirk as a workaround.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SDCA: Add quirk for incorrect function types for 3 systems
      commit: 28edfaa10ca1b370b1a27fde632000d35c43402c

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


