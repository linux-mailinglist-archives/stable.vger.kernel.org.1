Return-Path: <stable+bounces-191524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A30C1621D
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 18:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C629C1C24591
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 17:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F713093BF;
	Tue, 28 Oct 2025 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PF67Dnuf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD8B19F115;
	Tue, 28 Oct 2025 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672356; cv=none; b=KhzcLsy3qrqWfGkFjgL0LM52weRnlI/aVHm2FOlSuGJ2WbBiWCpKVypSTQ9ZP3S8AQA+mH3OFqEvkDrLol+uGg03vG7p7fTsBUkgvnrcom7h8KycaNngQr/c8elrMUWHqMOZoO6tuzRz/hPd/qLLRIxKY0P+Xs9ehdL1zinyxBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672356; c=relaxed/simple;
	bh=binFKUzNgc6GbOBMxDNuiC7fUBQq9iWleyN6ZWs2rr4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FnlmYi2v1QETVp7o3QLqaPK8DNQo3Yx7D9Ozn0gyaT0YzqSHe37ugZD99Q09Kca+3IrfUCamJ31pyJ8V06iz7tipdvJTqS1DowkTq/wRhKHrbEhvdJkSpwUYQtU9b4HSoXEdP3opGEVr2LlMBYJu1r21SgY1QKlvVfySx9tgZSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PF67Dnuf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7C8C4CEE7;
	Tue, 28 Oct 2025 17:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761672355;
	bh=binFKUzNgc6GbOBMxDNuiC7fUBQq9iWleyN6ZWs2rr4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PF67Dnuf0oU5VxJBsTSfcb7sBNwTrVlOH2x/t9DKAwSc1bkOjcKKzosMr1bIOQAC4
	 25/vku5+FVhSzricBSeAnL08vFctIndY3sAR6nnbgW0+wfd5ieymM/L6DRey0jEDDH
	 yDJtfQ53AcUHBjWvd+FYTZixermQwMChdP+HR13R+rARCae+xy3rBsdFcCDSx9dsZX
	 TN9Hpf3Hq0jvYQT9Wpv02Mqth6qZWX8skdEOOEsVu9EiGmaD/VVBv+xX2m1TFeTfgE
	 thy5pn7XaRte/EAv6wTXHZqgd7niEACDUe1xpq54fL/WOI0CrDVBkHXiMCFheXVeil
	 foIBlruHjkhuQ==
From: Mark Brown <broonie@kernel.org>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, 
 Shawn Guo <shawnguo@kernel.org>, stable@vger.kernel.org
In-Reply-To: <20251024082344.2188895-1-shawnguo2@yeah.net>
References: <20251024082344.2188895-1-shawnguo2@yeah.net>
Subject: Re: [PATCH] regmap: irq: Correct documentation of wake_invert flag
Message-Id: <176167235402.170678.3885969966135731658.b4-ty@kernel.org>
Date: Tue, 28 Oct 2025 17:25:54 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Fri, 24 Oct 2025 16:23:44 +0800, Shawn Guo wrote:
> Per commit 9442490a0286 ("regmap: irq: Support wake IRQ mask inversion")
> the wake_invert flag is to support enable register, so cleared bits are
> wake disabled.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: irq: Correct documentation of wake_invert flag
      commit: 48cbf50531d8eca15b8a811717afdebb8677de9b

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


