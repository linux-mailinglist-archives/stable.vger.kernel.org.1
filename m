Return-Path: <stable+bounces-181730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6BFBA00A8
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 16:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573274E320E
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 14:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615822DCBEC;
	Thu, 25 Sep 2025 14:33:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3804D2D9EF6
	for <stable@vger.kernel.org>; Thu, 25 Sep 2025 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758810808; cv=none; b=tFPeNqpnB5BN3ZDlVB2fjg4vFqoKKPQqFBsVljA/7XVwxjTd91Lw/f6p3fPdDNpn3LhcG7TuMOQYDeEGUq+MhhYwopckM7OCudn720Xlrr2ofcDfTC0g+IeJFTucZ4PnNUGTBOfgb/elljcn4yOvIHJQxamzAFPBAcuFfE7oezo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758810808; c=relaxed/simple;
	bh=YU71KaHSj1oQn1ZFA4zoYSiOj4YqDob4Rg6GLDXfdcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itVd1uMEuWO0I1DDduwt8yzz2Nh/v1d6JEvzLw5sChVp33gWSrb/TF84yYXq7RzYUPXrE+IUvbb0BChttQKtIUXrUha8WqC4SMowmTNwBVslE97PefDVuuzWWeWKpaMIHrnZ5/8pcKyM9O5w2GTcVxOsDdZowltp2EiDBHTGXHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0449CC4CEF5;
	Thu, 25 Sep 2025 14:33:24 +0000 (UTC)
Date: Thu, 25 Sep 2025 15:33:22 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: Gu Bowen <gubowen5@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Waiman Long <llong@redhat.com>, stable@vger.kernel.org,
	linux-mm@kvack.org, John Ogness <john.ogness@linutronix.de>,
	Lu Jialin <lujialin4@huawei.com>
Subject: Re: [PATCH v5] mm: Fix possible deadlock in kmemleak
Message-ID: <aNVSsmY86yi-cV_e@arm.com>
References: <20250822073541.1886469-1-gubowen5@huawei.com>
 <5ohuscufoavyezhy6n5blotk4hovyd2e23pfqylrfwhpu45nby@jxwe6jmkwdzb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ohuscufoavyezhy6n5blotk4hovyd2e23pfqylrfwhpu45nby@jxwe6jmkwdzb>

On Fri, Sep 19, 2025 at 03:37:27AM -0700, Breno Leitao wrote:
> On Fri, Aug 22, 2025 at 03:35:41PM +0800, Gu Bowen wrote:
> > To solve this problem, switch to printk_safe mode before printing warning
> > message, this will redirect all printk()-s to a special per-CPU buffer,
> > which will be flushed later from a safe context (irq work), and this
> > deadlock problem can be avoided.
> 
> I am still thinking about this problem, given I got another deadlock
> issue that I was not able to debug further given I do not have the
> crashdump.

Do you have some kernel log? I thought we covered all cases in
kmemleak.c (well, might have missed some).

> Should we have a wrapper around raw_spin_lock_irqsave(kmemleak_lock,
> flags), that would defer printk at all? 
> 
> Then, we can simply replace the raw_spin_lock_irqsave() by the helper,
> avoiding spreading these printk_deferred_enter() in the kmemleak code.
> 
> For instance, something as this completely untested code, just to show
> the idea.
> 
> 	void kmemleak_lock(unsigned long *flags) {
> 		printk_deferred_enter();
> 		raw_spin_lock_irqsave(&kmemleak_lock, flags);
> 	}
> 
> 	void kmemleak_lock(unsigned long flags) {
> 		raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
> 		printk_deferred_exit();
> 	}

The way we added the printk deferring recently is around the actual
printk() calls. Given that you can't get an interrupt under
raw_spin_lock_irqsave(), I don't think printk_deferred_exit() would
trigger a console flush. So we could simply add them around those
kmemleak_warn() or pr_*() calls rather than together with the spinlocks.
But we do need to be able to reproduce the problem and show that any
potential patch fixes it.

-- 
Catalin

