Return-Path: <stable+bounces-172354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D915B31496
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 12:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0301EB01A88
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 09:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26282F363D;
	Fri, 22 Aug 2025 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RbOtnopX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283822F066B;
	Fri, 22 Aug 2025 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856244; cv=none; b=PRBSXqzsZWDrhQCs7C4W2eilsMuTKZ8pUlJH08pvZuop0Xaq8+UZLRRGRTePicwwrBjyaNA7JBO2CC8aBKIjYzxasX6ir0c2FWzSoFmSbJ3F5BpkUzzYCrgjl/KqIejwDLK7OU8ri9suXsBV0iQAtQhzLVqj4nDJeMhAnNmq+l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856244; c=relaxed/simple;
	bh=eyrAb1VUDVoeKfWWx0W8w9LcS8EBxW+2XIe2ZnaxtBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7WY0C4KO7TYdvYAXgtldeb6KCFjbMvHMcijNYZFrqVhD8zyANmlQOIycOMWPEAYyVw8vmPdIFGhZLeWS+jRMPWJc4YunHfPhB3jnuHDT1tQ330OKxv597wQx/YFCVAd3bWf9Xj/YKUv9K2aAwyPF7E+slDPYQ4dgW7SU4iHiaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RbOtnopX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2276AC4CEED;
	Fri, 22 Aug 2025 09:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755856243;
	bh=eyrAb1VUDVoeKfWWx0W8w9LcS8EBxW+2XIe2ZnaxtBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RbOtnopXpGjxwDqAYpaYmbxlrrEn0Xk6uUPUlSDpAv4i/c72CUjb/Fy+geEAyadDG
	 vHNKerwnQ/Yp0zcvXsixVzSa5t+itVXxfRrRJaNQd1OKUpgR06vZEjQ0+yn56K9dVX
	 Gom1A8RkPbYbKmvvenILPSEOAZumbO7F0Teq+2i4=
Date: Fri, 22 Aug 2025 11:50:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, prarit@redhat.com,
	x86@kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6.6 RESEND 2/2] x86/irq: Plug vector setup race
Message-ID: <2025082244-halves-enjoyment-9417@gregkh>
References: <20250822033825.1096753-1-ruanjinjie@huawei.com>
 <20250822033825.1096753-3-ruanjinjie@huawei.com>
 <2025082243-urging-outdoors-aa35@gregkh>
 <9fa1c126-00f1-95db-93a0-cee52a70062e@huawei.com>
 <2025082249-gigolo-limeade-b44e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025082249-gigolo-limeade-b44e@gregkh>

On Fri, Aug 22, 2025 at 11:48:56AM +0200, Greg KH wrote:
> On Fri, Aug 22, 2025 at 05:25:56PM +0800, Jinjie Ruan wrote:
> > 
> > 
> > On 2025/8/22 16:57, Greg KH wrote:
> > > On Fri, Aug 22, 2025 at 03:38:25AM +0000, Jinjie Ruan wrote:
> > >> From: Thomas Gleixner <tglx@linutronix.de>
> > >>
> > >> commit ce0b5eedcb753697d43f61dd2e27d68eb5d3150f upstream.
> > >>
> > 
> > [...]
> > 
> > >>  
> > >>  /*
> > >> @@ -273,7 +308,9 @@ DEFINE_IDTENTRY_IRQ(common_interrupt)
> > >>  	/* entry code tells RCU that we're not quiescent.  Check it. */
> > >>  	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
> > >>  
> > >> -	call_irq_handler(vector, regs);
> > >> +	if (unlikely(!call_irq_handler(vector, regs)))
> > >> +		apic_eoi();
> > >> +
> > > 
> > > This chunk does not look correct.  The original commit did not have
> > > this, so why add it here?  Where did it come from?
> > > 
> > > The original patch said:
> > > 	-       if (unlikely(call_irq_handler(vector, regs)))
> > > 	+       if (unlikely(!call_irq_handler(vector, regs)))
> > > 
> > > And was not an if statement.
> > > 
> > > So did you forget to backport something else here?  Why is this not
> > > identical to what the original was?
> > 
> > The if statement is introduced in commit 1b03d82ba15e ("x86/irq: Install
> > posted MSI notification handler") which is a patch in patch set
> > https://lore.kernel.org/all/20240423174114.526704-1-jacob.jun.pan@linux.intel.com/,
> > but it seems to be a performance optimization patch set, and this patch
> > includes additional modifications. The context conflict is merely a
> > simple refactoring, but the cost of the entire round of this patch set
> > is too high.
> 
> Why is it "too high"?  We almost NEVER want to deviate from what is in
> mainline, as every time wo do that it adds the potential for bugs AND it
> increases our maintance burden (i.e. later patches will not apply.)
> 
> For a kernel that has to live as long as this one does, we need to try
> to stick to what is in mainline as close as possible.  Otherwise it
> becomes unworkable.

Also, I will push back, why not just use 6.12.y to resolve this issue
instead?  Why are you stuck on 6.6.y for now, and what are you going to
do with those systems once 6.6.y goes end-of-life?  Why postpone the
inevitable?

thanks,

greg k-h

