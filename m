Return-Path: <stable+bounces-160091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97353AF7DD7
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 18:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF965430A4
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 16:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E106253359;
	Thu,  3 Jul 2025 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDHWDJfW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A97824C076;
	Thu,  3 Jul 2025 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751560043; cv=none; b=ilvLaAUxBa8bzUVtw2nQGXbrdL++fMfbwkns6GLEhuMv2cYgFbAovp6OnxC0bp7sNtuaJca/so4ztHah0EF8P2GyceOBLaXoP6C6soBa2BRj6i7iLEckv4063qTCyJW3wvnl4Kio2lgysEAa05qiJsQjk0DiDSnDGLgHb9ddLBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751560043; c=relaxed/simple;
	bh=og5UM6+3IUqt5euyDL1Y0k7zkQnakgCEzf/aZtuERmI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qZd6Awy9JNyOsbmPUyZsvgRYcaDOMsQ6bJzjTTxIor2Uar6lz73y1W3Q+5pip95YIt0ZTqIrjqOWK62Dm+rCxEJJS955r0f7KUg84aLBC+NoFs3Mk1uqtVepn52WTGgCKciYy4k5jLgQWwLX1gTni385XVksOL/a8oXrvCTNrYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDHWDJfW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C542DC4CEE3;
	Thu,  3 Jul 2025 16:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751560042;
	bh=og5UM6+3IUqt5euyDL1Y0k7zkQnakgCEzf/aZtuERmI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WDHWDJfWf92fUVNIQrYC/GWQOz/6LDEJ/enqnw82SETP9/1dOuEEQK1cDh+tvnQif
	 tDdp0DWgoZCaSIyLdde6a+z7c1+0Kz5lPa+u66Acd18HZe1fkfafUUh9bu6eFq+rP4
	 XnDqwYG9ZuM2fw4KoKCBYGAupbMUh8LoPkG6sLyKwKnYqs7OO6ToxKMvrVhyBw+iw3
	 hKc+4bxco1516ZJSZSQwKEIlnAuRsIO9dyleeHBfJ3zt0gHl8YMGStuoXjiLFq1zyW
	 mzqU5wfktGgjKRKLsDvOCH7+5Z+4l3z+jTvuLOjDDghUIBHZkk6doKAMnUjV+KnzVi
	 uDxH6awj6DZcg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250703103549.16558-1-mani@kernel.org>
References: <20250703103549.16558-1-mani@kernel.org>
Subject: Re: [PATCH] regulator: gpio: Fix the out-of-bounds access to
 drvdata::gpiods
Message-Id: <175156004152.634143.17330857635962840361.b4-ty@kernel.org>
Date: Thu, 03 Jul 2025 17:27:21 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Thu, 03 Jul 2025 16:05:49 +0530, Manivannan Sadhasivam wrote:
> drvdata::gpiods is supposed to hold an array of 'gpio_desc' pointers. But
> the memory is allocated for only one pointer. This will lead to
> out-of-bounds access later in the code if 'config::ngpios' is > 1. So
> fix the code to allocate enough memory to hold 'config::ngpios' of GPIO
> descriptors.
> 
> While at it, also move the check for memory allocation failure to be below
> the allocation to make it more readable.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: gpio: Fix the out-of-bounds access to drvdata::gpiods
      commit: c9764fd88bc744592b0604ccb6b6fc1a5f76b4e3

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


