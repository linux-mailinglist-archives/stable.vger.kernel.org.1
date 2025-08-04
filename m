Return-Path: <stable+bounces-166474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE136B1A0D5
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 14:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15B4175BEE
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 12:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A057248F7D;
	Mon,  4 Aug 2025 12:08:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AAE1EF39E
	for <stable@vger.kernel.org>; Mon,  4 Aug 2025 12:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754309300; cv=none; b=i4Kg5f2Qnsdawbopm1tzPBpLRxf6JKsotyeJ+kp15QoVESO5U6H9vgGxwGL9LfvJZGNwM7hTH5dxkscCG4P8UB2G6D3rK1inBngn/apyDpB8n6yMowp+sSjFH5wGTHTyN99Rteo0vl5pwSBikVYFZlpdbKjIuiivUbAVlg0ioyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754309300; c=relaxed/simple;
	bh=SyKcYzeHWn+awX3tWPW/C2hz6Bm5rrFSl3BpBZ0hj9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wb7KIGVRbvvRYU5QABLnGUQ3WlCfoQB5+oBqib9FSzWdN1yYiKYZFaD3HJtdijcO1+XaiNMD3LebEvHWa0Kbl2QoG0ptWR20LFNUlssv1boIPCpJ6DgjOeoPRCVO5wfEk7g4tanvkCNBWxSyBf/8CEPLl2lSltQ7cG5mt+t3nac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407B1C4CEE7;
	Mon,  4 Aug 2025 12:08:18 +0000 (UTC)
Date: Mon, 4 Aug 2025 13:08:15 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Waiman Long <llong@redhat.com>, Gu Bowen <gubowen5@huawei.com>,
	stable@vger.kernel.org, linux-mm@kvack.org,
	Lu Jialin <lujialin4@huawei.com>, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] mm: Fix possible deadlock in console_trylock_spinning
Message-ID: <aJCir5Wh362XzLSx@arm.com>
References: <20250730094914.566582-1-gubowen5@huawei.com>
 <20250801153303.cee42dcfc94c63fb5026bba0@linux-foundation.org>
 <5ca375cd-4a20-4807-b897-68b289626550@redhat.com>
 <20250801205323.70c2fabe5f64d2fb7c64fd94@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801205323.70c2fabe5f64d2fb7c64fd94@linux-foundation.org>

On Fri, Aug 01, 2025 at 08:53:23PM -0700, Andrew Morton wrote:
> On Fri, 1 Aug 2025 23:09:31 -0400 Waiman Long <llong@redhat.com> wrote:
> > > There have been a few kmemleak locking fixes lately.
> > >
> > > I believe this fix is independent from the previous ones:
> > >
> > > https://lkml.kernel.org/r/20250731-kmemleak_lock-v1-1-728fd470198f@debian.org

That's a similar bug in another part of the kmemleak code but fixed
differently (which I actually prefer if feasible).

> > > https://lkml.kernel.org/r/20250728190248.605750-1-longman@redhat.com

That's a soft lockup, unrelated to the printk deadlock.

> > I believe that __printk_safe_enter()/_printk_safe_exit() are for printk 
> > internal use only. The proper API to use should be 
> > printk_deferred_enter()/printk_deferred_exit() if we want to deferred 
> > the printing. Since kmemleak_lock will have been acquired with irq 
> > disabled, it meets the condition that printk_deferred_*() APIs can be used.
> 
> Gotcha, thanks.
> 
> kmemleak;c:__lookup_object() has a lot of callers.  I hope you're
> correct that all have local irqs enabled, but I'll ask Gu to verify
> that then please send along a new patch which uses
> printk_deferred_enter()?

__lookup_object() must be called with kmemleak_lock held (unless we have
a bug in kmemleak).

Using printk_deferred_enter() is more convenient, though I think some of
these places can defer the printing with something similar to the first
patch above from Breno.

For __lookup_object(), we could move the warning outside the lock but
this function would have to lock the respective object, return it and
somehow inform the caller that it was an error and the object needs
unlocking. Given that this is a very rare/never event (only happens if
someone messes up the kmemleak_alloc/free calls), I'd say the
printk_deferred_enter() works best.

We have delete_object_part() which calls kmemleak_warn() with the
kmemleak_lock held. The warning can be moved outside similar to Breno's
patch.

We have a kmemleak_stop() -> kmemleak_warn() called in __link_object()
with the kmemleak_lock held. We could also use the printk deferring here
as well. That's another rare corner case.

The patch should add a code comment on why printk deferring is used in
case others will wonder in the future.

I'm surprised we haven't seen these until recently. Has printk always
allocated memory?

-- 
Catalin

