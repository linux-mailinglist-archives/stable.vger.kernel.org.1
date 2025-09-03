Return-Path: <stable+bounces-177582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A529B4184B
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 10:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647015E617E
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 08:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35D62EA46B;
	Wed,  3 Sep 2025 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uP5iM6ne"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7B42E7631
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887730; cv=none; b=VxnEqWmdUySDavRPmWS6hP5BK7xAGs9UnY/SzJdVfARPHOPGojt12Yw7IfDJsxJB6cSuGFoPhTVzTaHcBP/QMzQFPxyTEErzBKIiWRCLwXRe3XqhTlcxz+SdLHirh4D6yS8K8d/OT9AACVwbgcsyOrPV6wh0tXOT9nqziS5CmJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887730; c=relaxed/simple;
	bh=RUl8GJ69bqWBKIxbeo9sb4KKT8/NNELShyEvZp7LHII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkboc88BOX9KmXrzFHglV6CrAbAKHVKh6NpUTh+W30GiM1NIVdNaCcYznKUbToQdRz6C1egVH0+CeHgsvDGCZLKNP6LnefCPubckPJBTxaUvsbmW4lk5ZsKenGwPj+dj6gTT4VETVb3d0xsc5OIrVrvSzF0FZBREAZeq55pM31U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uP5iM6ne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84757C4CEF0;
	Wed,  3 Sep 2025 08:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756887730;
	bh=RUl8GJ69bqWBKIxbeo9sb4KKT8/NNELShyEvZp7LHII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uP5iM6neycpKNa0iVZ5ocFoNLjijKoI3Kar5Ne3kIZiOEJh1GWue/QqmYnIeP1+tg
	 2BMrE6sp5STWqDbx4+kla6Pp3/kDN8f0ETrPoB8aiuX4Fe3slTxJgjNcCKkmXWFZIQ
	 5fNEko0tYhs4GUBbyYpDwViQEF+3oZaA65kG0UpM=
Date: Wed, 3 Sep 2025 10:22:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: jinfeng.wang.cn@windriver.com
Cc: d-gole@ti.com, ronald.wahl@legrand.com, broonie@kernel.org,
	matthew.gerlach@altera.com, khairul.anuar.romli@altera.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.6 1/2] Revert "spi: cadence-quadspi: fix cleanup of
 rx_chan on failure paths"
Message-ID: <2025090339-pursuable-gradient-4781@gregkh>
References: <20250903075815.1034962-1-jinfeng.wang.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903075815.1034962-1-jinfeng.wang.cn@windriver.com>

On Wed, Sep 03, 2025 at 03:58:14PM +0800, jinfeng.wang.cn@windriver.com wrote:
> From: Jinfeng Wang <jinfeng.wang.cn@windriver.com>
> 
> This reverts commit 1af6d1696ca40b2d22889b4b8bbea616f94aaa84.

What is the upstream commit id for this?

> There is cadence-qspi ff8d2000.spi: Unbalanced pm_runtime_enable! error
> without this revert.
> 
> After reverting commit cdfb20e4b34a ("spi: spi-cadence-quadspi: Fix pm runtime unbalance")
> and commit 1af6d1696ca4 ("spi: cadence-quadspi: fix cleanup of rx_chan on failure paths"),
> Unbalanced pm_runtime_enable! error does not appear.
> 
> These two commits are backported from upstream commit b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance")
> and commit 04a8ff1bc351 ("spi: cadence-quadspi: fix cleanup of rx_chan on failure paths").
> 
> The commit 04a8ff1bc351 ("spi: cadence-quadspi: fix cleanup of rx_chan on failure paths")
> fix commit b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance").
> 
> The commit b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance") fix
> commit 86401132d7bb ("spi: spi-cadence-quadspi: Fix missing unwind goto warnings").
> 
> The commit 86401132d7bb ("spi: spi-cadence-quadspi: Fix missing unwind goto warnings") fix
> commit 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support").

I am sorry, but I can not parse any of this.

> 6.6.y only backport commit b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance")
> and commit 04a8ff1bc351 ("spi: cadence-quadspi: fix cleanup of rx_chan on failure paths"),
> but does not backport commit 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support")
> and commit 86401132d7bb ("spi: spi-cadence-quadspi: Fix missing unwind goto warnings").
> And the backport of commit b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance")
> differs with the original patch. So there is Unbalanced pm_runtime_enable error.
> 
> If revert the backport for commit b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance")
> and commit 04a8ff1bc351 ("spi: cadence-quadspi: fix cleanup of rx_chan on failure paths"), there is no error.
> If backport commit 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support") and
> commit 86401132d7bb ("spi: spi-cadence-quadspi: Fix missing unwind goto warnings"), there
> is hang during booting. I didn't find the cause of the hang.

Is this hang also in newer kernels?  Why is this only an issue in older
kernels?

thanks,

greg k-h

