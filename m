Return-Path: <stable+bounces-2917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E33F27FC07F
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 18:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75A1CB21372
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 17:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC4239ADF;
	Tue, 28 Nov 2023 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7WcGKCK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B09839AC7
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 17:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD56C433C7;
	Tue, 28 Nov 2023 17:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701193645;
	bh=bDt071erLT9bqXvQLkQlZpysK3yPXDzuHNctSH1FSC0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=G7WcGKCKn7yGsoXwbOAM+pHeOWQGJz1QNXf4MfqqVelYmMe7g6mdsCOOeEsA1f78s
	 GrxZCmEWaDv9spKonBmSYfjeA9Sgp+JRNJTdYWCo1I9XV5u0Dn6VNya2Zp3JklTSFt
	 QqMSU5ZYFq/a6imm45go70KU1yHGUYLPli8KeBYj0A1ym0rxjVo/9a28QZfjVl0yzw
	 INuibXZkhlYCOh2PTkULMW3Waogyt2JusnwCarikSDaO87nmjEs074DiItvsSOoQel
	 LzVP/U4EnZ3ESYGjB2hCHqUh9XmDwsbyyzn1+PMxIVcGODm22LiYy2WCUZ62IvbuOU
	 gZSpQmK/UHTbA==
From: Mark Brown <broonie@kernel.org>
To: Malcolm Hart <malcolm@5harts.com>
Cc: Sven Frotscher <sven.frotscher@gmail.com>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <871qcbszh0.fsf@5harts.com>
References: <875y1nt1bx.fsf@5harts.com> <871qcbszh0.fsf@5harts.com>
Subject: Re: [PATCH] sound: soc: amd: yc: Fix non-functional mic on ASUS
 E1504FA
Message-Id: <170119364376.61148.2092062519841116796.b4-ty@kernel.org>
Date: Tue, 28 Nov 2023 17:47:23 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Mon, 27 Nov 2023 20:36:00 +0000, Malcolm Hart wrote:
> This patch adds ASUSTeK COMPUTER INC  "E1504FA" to the quirks file acp6x-mach.c
> to enable microphone array on ASUS Vivobook GO 15.
> I have this laptop and can confirm that the patch succeeds in enabling the
> microphone array.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] sound: soc: amd: yc: Fix non-functional mic on ASUS E1504FA
      commit: 03910b4da940871f7cb8ed84837bd4b5ff9366bc

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


