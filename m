Return-Path: <stable+bounces-192658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D576CC3DE5F
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 00:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77EAC188D56A
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 23:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F057350D41;
	Thu,  6 Nov 2025 23:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzYK5h5Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80E9305977;
	Thu,  6 Nov 2025 23:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762473246; cv=none; b=HMO6ZtOXGkGV1f3sVfhb8hFpTbT2crIgcyQPW7iCLTjnG5gD3LYuHOObuN/gvoo8zxeEBL29NmcOp2Vk35qHE0wvANNgSSZpTnS7fyptIOw2mBBrN3XMjtH/j1Lyb3H9MULb4TgSHpcpbCZ//LQZrbxWwsFXvPeSBlQp/iFBdr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762473246; c=relaxed/simple;
	bh=maD/WMVtrp8XNJtZ1CrVa7WYQitVdDle2A0gK09VGGg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aMXsscyGq2HPqv2kFjsod5qC8S2Jw9U/Qi0ETVBG0Ow3ZEsura+oTuTjOXulf5eTsW875zdCm4KOmzcwvbswMpLhAh6x3Vy+cqfdilhvDundvctrcioeNgUEIaLkCv4R3fUvjRL9n1gUMRUko/EgnHnLyJmmFWqGN17pT7oT/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzYK5h5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BF2C116C6;
	Thu,  6 Nov 2025 23:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762473246;
	bh=maD/WMVtrp8XNJtZ1CrVa7WYQitVdDle2A0gK09VGGg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TzYK5h5ZbzlnlFEsk51aWhJEXa8ijdu6JLalqQU8froCJsYWW0dkpoWRsYy1uj4WM
	 /NUYy1mFtbTdeSqGmnDzFq7OHDB6RlVZMTdduXqtF9QJfhJgRMzr6P/3RoRyr0aI3h
	 UZXNbiyftfFOYxteE3urk/145tmeBZ4aocbS0YImlblR3tfS9XHfVyeY8Pan/dztqx
	 htn1hPzKEL57Wmyn1vjAnVf+GwvHZSzAvCYV3QdeQ1IuapTCj7a53DD8u+usfKlW/b
	 2QSFXhYdJ/ePyNLKdx9Gx5mbroRBtEGCnWO4qqfCV4UfuNSNrAuJZEdhjxpFFv3/B9
	 1cEmn+LDnM1Nw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Stefan Binding <sbinding@opensource.cirrus.com>, 
 Niranjan H Y <niranjan.hy@ti.com>, Peter Zijlstra <peterz@infradead.org>, 
 Shuming Fan <shumingf@realtek.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20251029071804.8425-1-linmq006@gmail.com>
References: <20251029071804.8425-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: sdw_utils: fix device reference leak in
 is_sdca_endpoint_present()
Message-Id: <176247324119.2482911.14469764077776354194.b4-ty@kernel.org>
Date: Thu, 06 Nov 2025 23:54:01 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Wed, 29 Oct 2025 15:17:58 +0800, Miaoqian Lin wrote:
> The bus_find_device_by_name() function returns a device pointer with an
> incremented reference count, but the original code was missing put_device()
> calls in some return paths, leading to reference count leaks.
> 
> Fix this by ensuring put_device() is called before function exit after
>   bus_find_device_by_name() succeeds
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sdw_utils: fix device reference leak in is_sdca_endpoint_present()
      commit: 1a58d865f423f4339edf59053e496089075fa950

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


