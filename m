Return-Path: <stable+bounces-114078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A78CBA2A7D1
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 12:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5E7E1880663
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 11:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F4E22A4D3;
	Thu,  6 Feb 2025 11:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tp80hfoX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37622288F0;
	Thu,  6 Feb 2025 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738842291; cv=none; b=tBcED4bY1v9U5h6iOMkSOFqpMKY+W15OwnFW9YFDNBRmEKcz9HeXGsFKCP4BV4fLrraHFVEyWYBu6QU3E7gzTFjINUXkFI5fBZ1PVVPtPcYnnzt51yssMr3yfAboRAlkGgWoRyi43qSyWRKa+UbWKyQS+YC92eVyvp6rmUcbplA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738842291; c=relaxed/simple;
	bh=pzErxoyKw8+3z5Crq9j2Kk/upn/oJmYrtq+rGOblMhQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZO5dK9ki6H0LEQfbOHUvdvkeWPhmL5UI6DjwkzOlfM4Y/qc5IXzpWAC6Md6Yz2LT8I7V/2bwaX78gTkRcgiD4+nB3L4WAYVuRB0iar4KLxVOBkhOOx2U2XaZbib3ogUeS5iWrSZR7FjJiRNLmOkwke8lhREccPpsDRTgTEzpjVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tp80hfoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE489C4CEDD;
	Thu,  6 Feb 2025 11:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738842291;
	bh=pzErxoyKw8+3z5Crq9j2Kk/upn/oJmYrtq+rGOblMhQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Tp80hfoXAAtUIcwBrLvPE7lq1i8Tq+vi5/YB/L3mRBDVWoR0NOjxAKoBdKPgKgFdp
	 hJeS7bItmPnE4O/w9t2zlxBFLvsBN6t44nUek3hQfH0ggtzFpq5PsboQE+euSMFIFY
	 PN1zILy6DSsg4eOX8tJID3xe4FyvxEy0UVVOhUOIRCNPmD5npKV2/cILH+9J/6rDCE
	 gM5lVfcputgXmSfgbeuBHuj/dHG1P49ldObVXd8cWddHM33g/QCqh+VT5ecAP520E7
	 J0hGyDiwyJzfH/ZjxZxXN/kSILj4cvovvT9a4CcAmqfNWND3zgsdZb4a508BqYfXzm
	 pI+a0zBq8sz6Q==
From: Mark Brown <broonie@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
 mazziesaccount@gmail.com, Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250202200512.24490-1-jiashengjiangcool@gmail.com>
References: <20250202200512.24490-1-jiashengjiangcool@gmail.com>
Subject: Re: [PATCH] regmap-irq: Add missing kfree()
Message-Id: <173884228956.34610.14512182044398612042.b4-ty@kernel.org>
Date: Thu, 06 Feb 2025 11:44:49 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Sun, 02 Feb 2025 20:05:12 +0000, Jiasheng Jiang wrote:
> Add kfree() for "d->main_status_buf" in the error-handling path to prevent
> a memory leak.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap-irq: Add missing kfree()
      commit: 32ffed055dcee17f6705f545b069e44a66067808

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


