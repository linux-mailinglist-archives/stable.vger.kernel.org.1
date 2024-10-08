Return-Path: <stable+bounces-82334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2074F994C39
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB1C1F22E3B
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C261CCB32;
	Tue,  8 Oct 2024 12:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtOVeuAA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F50B1DE4FA;
	Tue,  8 Oct 2024 12:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391911; cv=none; b=bDZlxfOeTF7CWbNeFRZYMNam9j7pG3oy1BKBQve4yuBOVmBZrxYMeVevquEcbUYt9VD3c49eFgrzn2AhW79YmR/AuD7W3Pqh62wwB3yV3fKsNKKUi/UUf+v8vIOkIjoRwoTNwL0ZqzeGlKZW/YVsK9OoRkLXiSgOFbEawWdFCVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391911; c=relaxed/simple;
	bh=YE2XRtzRZkns41fz+Cy8hJ39gj24A9rMJ9r/7gXSnZc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eXlSvmn8CN27BL4FJuwMYHrvjIG+4y8tn+PwCWtGfW1R8MKXhDoAiUBGiTQlNKsB6MPAEBwWLjl1wZ7MH9AaGtrBY0DxFM8fBfi3RbDgU580eow2+40ujnJemQIyARlhM/T1gmLuheAwNFymTe/WX+IBtvL90rOYx9wBSw83420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtOVeuAA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8EDC4CEC7;
	Tue,  8 Oct 2024 12:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728391911;
	bh=YE2XRtzRZkns41fz+Cy8hJ39gj24A9rMJ9r/7gXSnZc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jtOVeuAA7sZesMakms482PV2/c0HplW8mwBPCxqrrO3Ykbh6H4nfOnBFcOhfb6Qbu
	 eJS+3UEM/DMS9PdY6ooDccNHenaYJA2hUheX0vmZ9pt66iXTFX6LpDw1deQw9LSgNR
	 YfTwpG06A7IcqVosg5YV4WopXm3VOaqaoTatlmmuOJRqiedA2NYJl94v/9PlqNV+vT
	 gcm9gIPbZfMNT4L4A5urADcZY6SJmBrTENVKn5EVRQWb6tKFouFeitc1ShqYdJJfKn
	 td/gbxdMeMWzJo//eMN2UU+P0p6dZtnESAbbQq77UFDR+i+TFGredQ6AX/AHG8Hxzx
	 yJGIr6kokfKUg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 stable@vger.kernel.org, pierre-louis.bossart@linux.dev
In-Reply-To: <20241008060710.15409-1-peter.ujfalusi@linux.intel.com>
References: <20241008060710.15409-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH for 6.12] ASoC: SOF: Intel: hda-loader: do not wait for
 HDaudio IOC
Message-Id: <172839190833.2607981.9233557897493329826.b4-ty@kernel.org>
Date: Tue, 08 Oct 2024 13:51:48 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Tue, 08 Oct 2024 09:07:10 +0300, Peter Ujfalusi wrote:
> Commit 9ee3f0d8c999 ("ASOC: SOF: Intel: hda-loader: only wait for
> HDaudio IOC for IPC4 devices") removed DMA wait for IPC3 case.
> Proceed and remove the wait for IPC4 devices as well.
> 
> There is no dependency to IPC version in the load logic and
> checking the firmware status is a sufficient check in case of
> errors.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Intel: hda-loader: do not wait for HDaudio IOC
      commit: 9814c1447f9cc67c9e88e0a4423de3a496078360

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


