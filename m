Return-Path: <stable+bounces-96032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B9C9E03F6
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93D89B44DF6
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 13:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58831202F60;
	Mon,  2 Dec 2024 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEWcJ3CM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B4A201265;
	Mon,  2 Dec 2024 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733145042; cv=none; b=Tslmiz4rpkyj54Uk8/DQwkGfpzM02jvNuUV2CqhFrr4H3crBcLpNKXiNwbvmFGltNypojaYa5TH+3IfChoDnY5SAPMFgfZ25SKGZbs25z2OzxL1zR0+mTxDky8xqcfaVw8aQoJHnd7p+jLeZw2a8VEsil1xV75b7Njg+p/ITTBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733145042; c=relaxed/simple;
	bh=3tiAqnkKOWIQaS7R8YbvHlIUKPzlFD5LsXwIXtzSv+I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Pt2Yh7e+/uaC/H9f3M7Azx52kc/BLzdOZ01jUtxAuyIweWGXhi35mmvzdoPDKLHMnfJf1BEOrSH/wOuWVQ84FPRZUikLPmbgFhPLFvqMwNjNL9XbtIgR54AmOPcZqd3rqV/3WxDl0Z/RRET6CRAkaMIC85AwXO0ClkKaytNVrjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEWcJ3CM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6095C4CED1;
	Mon,  2 Dec 2024 13:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733145041;
	bh=3tiAqnkKOWIQaS7R8YbvHlIUKPzlFD5LsXwIXtzSv+I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rEWcJ3CMvOfRy/NBMnuPfENj+7T/USZ1XSGYY5iAUBSllJC3yjEmkW4lgScBcnfiO
	 O0+5zDKBx8VCVB9BtENgaX3GBgvUhUFplKlRk0jhBCszu5knq8Qp3dCHbFHyJRRNZt
	 BWZ6xYEuwb8x0GAbxt+vhSBc7K7EBsZCLPXVm837Yy0CRZNvw2CvOsK2elRg2AydN6
	 bEx+WwMM8Xds7LsYf4cpFj+D+KZlT46hUHsTrA1WpFqCDrTNc7XH1sW6WpdcFGp26K
	 zO4aAg1PuZDBrJnbH/9erRyymvQkzr3sZXP+3HGhwgN/KHKjJn8Yen/vVoYuZ1ihNm
	 fDPy9zvLjawzg==
From: Mark Brown <broonie@kernel.org>
To: Cosmin Tanislav <demonsingur@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20241128131625.363835-1-demonsingur@gmail.com>
References: <20241128131625.363835-1-demonsingur@gmail.com>
Subject: Re: [PATCH v4] regmap: detach regmap from dev on regmap_exit
Message-Id: <173314504067.36876.13726432422221168577.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 13:10:40 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 28 Nov 2024 15:16:23 +0200, Cosmin Tanislav wrote:
> At the end of __regmap_init(), if dev is not NULL, regmap_attach_dev()
> is called, which adds a devres reference to the regmap, to be able to
> retrieve a dev's regmap by name using dev_get_regmap().
> 
> When calling regmap_exit, the opposite does not happen, and the
> reference is kept until the dev is detached.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: detach regmap from dev on regmap_exit
      commit: 3061e170381af96d1e66799d34264e6414d428a7

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


