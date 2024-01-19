Return-Path: <stable+bounces-12259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9808327B6
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 11:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9111C22C4B
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 10:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8786F3EA60;
	Fri, 19 Jan 2024 10:33:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899A93527A
	for <stable@vger.kernel.org>; Fri, 19 Jan 2024 10:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705660393; cv=none; b=lO97CCjv9u4cO/htkE5jHn1/Tl5o0lAuo3dHsOP805v+SmdawpHHvzakh1d+pXDPW/iWL6f0e1/PUovgAT27Bta0RCp64bAlTtJB5I3EKjgYVSAriz8TbbV/C1M7qzuWjaxhC+LkU955OIYQHEl5CGNPIkos6KnCeF7Eji+zrAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705660393; c=relaxed/simple;
	bh=6U/bSHAE4Hf6miMJRtpLd1lfeFMcNoDfzxPaC63ZR9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSWnhOZBuw3Ugo7oaciYZRKNZvLD8Ky8UU+fxze7SXiAOr2t94JacldLsNnt9/RHYXwL0FiMeErP+fdZsGCpp9kFQPWtnd4BDQ4t2VSPLbUErZDuhrPXg7cBT1q+9zzVFtSW9vHFMswMz8pcblYOxngDtrVHhxiy11bW/cUpteU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD8C21042;
	Fri, 19 Jan 2024 02:33:53 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.47.176])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3E173F73F;
	Fri, 19 Jan 2024 02:33:05 -0800 (PST)
Date: Fri, 19 Jan 2024 10:32:59 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	kernel-team@android.com, stable@vger.kernel.org, robh@kernel.org,
	james.morse@arm.com
Subject: Re: [PATCH 0/2] arm64: fix+cleanup for
 ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
Message-ID: <ZapP24LCd5ijy8Li@FVFF77S0Q05N>
References: <20240116110221.420467-1-mark.rutland@arm.com>
 <170557561037.3200718.6656632532505785315.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170557561037.3200718.6656632532505785315.b4-ty@kernel.org>

On Thu, Jan 18, 2024 at 12:02:26PM +0000, Will Deacon wrote:
> On Tue, 16 Jan 2024 11:02:19 +0000, Mark Rutland wrote:
> > While testing an unrelated patch on the arm64 for-next/core branch, I
> > spotted an issue in the ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
> > workaround. The first patch fixes that issue, and the second patch
> > cleans up the remaining logic.
> > 
> > The issue has existed since the workaround was introduced in commit:
> > 
> > [...]
> 
> Cheers, I picked these up, but you might need to shepherd them
> through -stable, so please keep an eye out for any "failed to apply"
> mails.
> 
> Talking of which, the original workaround didn't make it to any kernels
> before 6.1:
> 
> [5.15] https://lore.kernel.org/r/2023100743-evasion-figment-fbcc@gregkh
> [5.10] https://lore.kernel.org/r/2023100745-statute-component-dd0f@gregkh

From a quick look, these failed because we forgot to backport some prior errata
workarounds (which are still missing from stable), and backported others
out-of-order relative to mainline, so every subsequent backport is likely to
hit a massive text conflict in the diff.

I'll have a go at backorting the missing pieces in-order to get this closer to
mainline. I suspect that'll take a short while...

Going forwards, we should check that errata patches are CC'd to stable
appropriately when we merge them in the arm64 tree, and we should make sure
those are successfully backported in-order.

Mark.

> 
> Please can you or Rob have a crack at that?
> 
> [1/2] arm64: entry: fix ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
>       https://git.kernel.org/arm64/c/832dd634bd1b
> [2/2] arm64: entry: simplify kernel_exit logic
>       https://git.kernel.org/arm64/c/da59f1d051d5
> 
> Cheers,
> -- 
> Will
> 
> https://fixes.arm64.dev
> https://next.arm64.dev
> https://will.arm64.dev

