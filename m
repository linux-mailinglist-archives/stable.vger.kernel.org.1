Return-Path: <stable+bounces-205092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BD9CF8D9D
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 15:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ED6130351E0
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 14:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C41313E21;
	Tue,  6 Jan 2026 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bIP74egh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03765312837
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767710543; cv=none; b=DjDAVDohZHWb/lff1c9/n2LWNN4GfghNn9K/h9S9FTcOATN1W5N+llr7rNAl/pR3o24YVqB6uAZPQVikA4lgZnFAlnMCcDC3XbFyFSFvUNBe8eLYaAxhwwuidcUuTlxS+O3GfEPG6Pj60nWCmZ7BQgTLJYzEarmxNSWjsDXYpCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767710543; c=relaxed/simple;
	bh=MeScSkJ3B1FUIHaLUt6iAfohlU5t5e5juEuMz8oWftQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFz0nDjO8Pf1xg3WBz1YVKb9Z2V8kbHD1xddqJIetwYx18izlshphYIrt1SOF6mJgF6ycYnKPqHy2T5eYd9VxhFXMZSbDSnANDP5x5ZVrPJ8ZIMb1Ttc2FP/KOXfzDFjg4Ux8AhOLzVuJeDwPGWqbZxn0fcW3KjgfX9x4Rl2I/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bIP74egh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D147C116C6;
	Tue,  6 Jan 2026 14:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767710541;
	bh=MeScSkJ3B1FUIHaLUt6iAfohlU5t5e5juEuMz8oWftQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bIP74eghgtu57G4c3+F5N1GW8VNodCDHb6vHpPDvL+x2sy5cDrJcoS5gbqUffo9Ld
	 hERKepA0OzcGiyBEYB4oQPKhSWVCE8REqBN2bHv59KdWDRk8afPNv5tD9V1zuIatDi
	 WPDvU2CnN63ZwL6jxstk+O+RSFLYhoQTx0O5g+oY=
Date: Tue, 6 Jan 2026 15:42:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: stable@vger.kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
	patches@opensource.cirrus.com
Subject: Re: [PATCH RESEND] Revert "gpio: swnode: don't use the swnode's name
 as the key for GPIO lookup"
Message-ID: <2026010637-slightly-regulator-76d9@gregkh>
References: <20260106111838.1360888-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106111838.1360888-1-ckeepax@opensource.cirrus.com>

On Tue, Jan 06, 2026 at 11:18:38AM +0000, Charles Keepax wrote:
> This reverts commit 25decf0469d4c91d90aa2e28d996aed276bfc622.

For 6.18?  There is no such commit in that branch :(

Shouldn't it be e5d527be7e6984882306b49c067f1fec18920735?

> 
> This software node change doesn't actually fix any current issues
> with the kernel, it is an improvement to the lookup process rather
> than fixing a live bug. It also causes a couple of regressions with
> shipping laptops, which relied on the label based lookup.
> 
> There is a fix for the regressions in mainline, the first 5 patches
> of [1]. However, those patches are fairly substantial changes and
> given the patch causing the regression doesn't actually fix a bug
> it seems better to just revert it in stable.
> 
> CC: stable@vger.kernel.org # 6.18
> Link: https://lore.kernel.org/linux-sound/20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org/ [1]
> Closes: https://github.com/thesofproject/linux/issues/5599
> Closes: https://github.com/thesofproject/linux/issues/5603
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> This fix for the software node lookups is also required on 6.18 stable,
> see the discussion for 6.12/6.17 in [2] for why we are doing a revert
> rather than backporting the other fixes. The "full" fixes are merged in
> 6.19 so this should be the last kernel we need to push this revert onto.

Can you resend with the proper commit id in it?

thanks,

greg k-h

