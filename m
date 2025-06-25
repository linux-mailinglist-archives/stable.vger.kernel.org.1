Return-Path: <stable+bounces-158516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E4DAE7B2A
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 11:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 924007B8207
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 08:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F6A28751F;
	Wed, 25 Jun 2025 08:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q7YlPFLO"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A178D27991E;
	Wed, 25 Jun 2025 08:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841858; cv=none; b=mZnp9nweFTUJdnVpVv8OoJn8NBYCWIJvogBOQLsYbHtOFO3GmHBrnJg6kCGiGQIYNIODaIhJmRqr7j5GzysfEVeDVhLB+VX/BPPK+1mKQsp51/T+WftUhCk6MpaBeNwyXDj11RNr3t1amHFJO3pmHDJFqGpxfLfTKj72R6chBjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841858; c=relaxed/simple;
	bh=fi5YapQ9Kln2zL1QkQAG+6zgvddysRgUMivrVhC8/kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r50Wrzcc8DxAVIKb1TnwRCVawArpKjLSL18imaxy0+VgK6dAyZVmiwm1h+2JGOzUki6xHrcIJcm439BzSQbvEHNUG19hLeA2+9btn6JLuGRQQdPNtj6RBR6rgHnXfkTbE7GJRZ+lsB9YAZ+solE07HdFtDWCBFn4/CklSaZTqjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q7YlPFLO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ha5n2uh4Bnevt+6vesOVroSnzMdljnXGep41cNvK9JY=; b=Q7YlPFLOlMbSvWXcp1RW7gYtEJ
	zolAZE8VKf7ZTyPlnvTu/EBaMckp3hN945UFQP7/Y/HFEZzycbuOZrsOGMCGOeQTo+cQXmoLuaa9z
	2wZXZgsYy/84lkjjB9bHhxUhheOV5sDwCYusr2CuhlI0c0TFEJ51PTtVvaQiEME8Qj00AvIzvNDBZ
	BcjjRLBGAr1MpNjaKHBaREDG0sIpz7itlqRWt2YC6dUSBE3WRUgCi/AauMA8NuahZAnN2hbqVGmMY
	qwHnyyIOiOOxfygXHlZPDQPH6BFrwZHhrprzeneGCdRabZGV26v7oIG2aBsWWLv0PNNnIAh+anM5x
	wXK7QCBA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uULwg-00000008wcE-32p5;
	Wed, 25 Jun 2025 08:57:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 44994308983; Wed, 25 Jun 2025 10:57:30 +0200 (CEST)
Date: Wed, 25 Jun 2025 10:57:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	bp@alien8.de, mingo@kernel.org, chao.gao@intel.com,
	Alison Schofield <alison.schofield@intel.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Eric Biggers <ebiggers@google.com>, Rik van Riel <riel@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] [v2] x86/fpu: Delay instruction pointer fixup until
 after warning
Message-ID: <20250625085730.GD1613200@noisy.programming.kicks-ass.net>
References: <20250624210148.97126F9E@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624210148.97126F9E@davehans-spike.ostc.intel.com>

On Tue, Jun 24, 2025 at 02:01:48PM -0700, Dave Hansen wrote:
> 
> Changes from v1:
>  * Fix minor typos
>  * Use the more generic and standard ex_handler_default(). Had the
>    original code used this helper, the bug would not have been there
>    in the first place.

Doesn't this here typically go under the --- with the diffstat etc?

> --
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Right now, if XRSTOR fails a console message like this is be printed:
> 
> 	Bad FPU state detected at restore_fpregs_from_fpstate+0x9a/0x170, reinitializing FPU registers.
> 
> However, the text location (...+0x9a in this case) is the instruction
> *AFTER* the XRSTOR. The highlighted instruction in the "Code:" dump
> also points one instruction late.
> 
> The reason is that the "fixup" moves RIP up to pass the bad XRSTOR and
> keep on running after returning from the #GP handler. But it does this
> fixup before warning.
> 
> The resulting warning output is nonsensical because it looks like the
> non-FPU-related instruction is #GP'ing.
> 
> Do not fix up RIP until after printing the warning. Do this by using
> the more generic and standard ex_handler_default().
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Fixes: d5c8028b4788 ("x86/fpu: Reinitialize FPU registers if restoring FPU state fails")
> Acked-by: Alison Schofield <alison.schofield@intel.com>
> Cc: stable@vger.kernel.org
> Cc: Eric Biggers <ebiggers@google.com>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Chang S. Bae <chang.seok.bae@intel.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

