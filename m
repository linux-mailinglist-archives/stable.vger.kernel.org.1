Return-Path: <stable+bounces-104517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E11679F4F61
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 16:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D95C47A62BF
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 15:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A981F708B;
	Tue, 17 Dec 2024 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQvUqy9q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22418148850;
	Tue, 17 Dec 2024 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734449136; cv=none; b=R4Yslsy7OMyeX+K/apewiClpNzdkV1MnTMSuj9uK/4la0iY+XPP7OHLXVNfLPYmcm/nrHAbM4ywZWWMO0rhOgcccIt72uftCpCCmWWesSGeaZkznbKXV419Ev3CsFDnrdxvr/870xTvfF6EL01hEbotswCnis5ucECxEtLFE5lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734449136; c=relaxed/simple;
	bh=n59nbDdqjazWBSEs+6H0xYs7GJ7Na4HGlhRT4smb0+A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WB23+nJ8t00C2ZO6/GCFcxYkkLLFJGE2jjphYCXohmyGD8LAhc8OcGZUMc+qz+frSNtITnDnMl1BUgTarQd9+p2+4pidRHAa4Dr85/3LzMR9T60aOs1kW063IXwHbzVOVTEN2Aujtb9UXeKRcnVjgsA2dfTd16GkicwS8E/iS+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQvUqy9q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E2EC4CED3;
	Tue, 17 Dec 2024 15:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734449136;
	bh=n59nbDdqjazWBSEs+6H0xYs7GJ7Na4HGlhRT4smb0+A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MQvUqy9q2HOh9O3oU7OjSHWlcI+o823pZYwBpBi7uH9bSAgGJLXY/krOYVOzkgBR/
	 bqgwBvze5GYu4x9/+BGN+MuhYOP958bm+Xl7yKj4HJEvQVwGNkWQg7rDSz+7un60dr
	 HglD3OhxEh2s3YHneDBZ3KIpLFt3GYUgp55vgvTxOF7+MwGkQd2vP2xdz3SNqz3F6N
	 SckXLXmodBJNrf1ovOF5dF+t368p5AfC64s0YeT0gaOZqGv1KTQmQ1d7gACz1Q27Ik
	 SloPEFZQs7q7Lum+UchXAI552LgmgyJpW34qKOza+QVABXXMs2KdamlI/wF1uDa3NB
	 5ZcZBEtr99w/A==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 pierre-louis.bossart@linux.dev, liam.r.girdwood@intel.com, 
 stable@vger.kernel.org
In-Reply-To: <20241217091019.31798-1-peter.ujfalusi@linux.intel.com>
References: <20241217091019.31798-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH for v6.13-rc] ASoC: SOF: Intel: hda-dai: Do not release
 the link DMA on STOP
Message-Id: <173444913362.64908.13186494458287422900.b4-ty@kernel.org>
Date: Tue, 17 Dec 2024 15:25:33 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 17 Dec 2024 11:10:19 +0200, Peter Ujfalusi wrote:
> The linkDMA should not be released on stop trigger since a stream re-start
> might happen without closing of the stream. This leaves a short time for
> other streams to 'steal' the linkDMA since it has been released.
> 
> This issue is not easy to reproduce under normal conditions as usually
> after stop the stream is closed, or the same stream is restarted, but if
> another stream got in between the stop and start, like this:
> aplay -Dhw:0,3 -c2 -r48000 -fS32_LE /dev/zero -d 120
> CTRL+z
> aplay -Dhw:0,0 -c2 -r48000 -fS32_LE /dev/zero -d 120
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Intel: hda-dai: Do not release the link DMA on STOP
      commit: e8d0ba147d901022bcb69da8d8fd817f84e9f3ca

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


