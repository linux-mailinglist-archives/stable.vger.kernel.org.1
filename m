Return-Path: <stable+bounces-188310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4F0BF51C1
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 09:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2474465A4D
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 07:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D89428CF5F;
	Tue, 21 Oct 2025 07:49:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4425D299929
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032991; cv=none; b=mnsKsFI7Zr8N7vdYxX62qr5WDTfxzVrQpv9u0kFF8oxJzg4ja0EKUmxz8ebm/i/ksBwKqLKiyAXidnvHu1VwlNlPsEmzEiseWz8Zpt0y+sMC/st3M7/4tOVYHq8FYMEIc+9/S+MC1uvfJMc1QKFnaENPyx2JpXtAw4+BrdPcuf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032991; c=relaxed/simple;
	bh=i9umFpVj3RMNqoGjHUhbGQ/qX5kyHsqAU+M5PTEXSK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVS3hmSdqtuBD1+bRuEQ5nG6p+CIy68cQDNwkz7+DKPV2sd/7pyn7qkQ3qAt2h6ndJ580JkafQIgj9vXxgZwlSoXdJuqoIAKEgO48AZpG8Abc7gpgLZUCGZJULP9+XYXd7128ZNdZvn/mDH+nKuakcapRVubs94ymVM1IUTJvfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 21 Oct 2025 16:34:46 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Tue, 21 Oct 2025 16:34:46 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: Chris Li <chrisl@kernel.org>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] mm, swap: do not perform synchronous discard during
 allocation
Message-ID: <aPc3lmbJEVTXoV6h@yjaykim-PowerEdge-T330>
References: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
 <20251007-swap-clean-after-swap-table-p1-v1-1-74860ef8ba74@tencent.com>
 <CACePvbWs3hFWt0tZc4jbvFN1OXRR5wvNXiMjBBC4871wQjtqMw@mail.gmail.com>
 <CAMgjq7BD6SOgALj2jv2SVtNjWLJpT=1UhuaL=qxvDCMKUy68Hw@mail.gmail.com>
 <CACePvbVEGgtTqkMPqsf69C7qUD52yVcC56POed8Pdt674Pn68A@mail.gmail.com>
 <CACePvbWu0P+8Sv-sS7AnG+ESdnJdnFE_teC9NF9Rkn1HegQ9_Q@mail.gmail.com>
 <CAMgjq7BJcxGzrnr+EeO6_ZC7dAn0_WmWn8DX8gSPfyYiY4S3Ug@mail.gmail.com>
 <CAMgjq7CsYhEjvtN85XGkrONYAJxve7gG593TFeOGV-oax++kWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7CsYhEjvtN85XGkrONYAJxve7gG593TFeOGV-oax++kWA@mail.gmail.com>

> > Thanks, I was composing a reply on this and just saw your new comment.
> > I agree with this.
> 
> Hmm, it turns out modifying V1 to handle non-order 0 allocation
> failure also has some minor issues. Every mTHP SWAP allocation failure
> will have a slight higher overhead due to the discard check. V1 is
> fine since it only checks discard for order 0, and order 0 alloc
> failure is uncommon and usually means OOM already.

Looking at the original proposed patch.

 +	spin_lock(&swap_avail_lock);
 +	plist_for_each_entry_safe(si, next, &swap_avail_heads[nid], avail_lists[nid]) {
 +		spin_unlock(&swap_avail_lock);
 +		if (get_swap_device_info(si)) {
 +			if (si->flags & SWP_PAGE_DISCARD)
 +				ret = swap_do_scheduled_discard(si);
 +			put_swap_device(si);
 +		}
 +		if (ret)
 +			break;

if ret is true and we break, 
wouldn’t that cause spin_unlock to run without the lock being held?

 +		spin_lock(&swap_avail_lock);
 +	}
 +	spin_unlock(&swap_avail_lock); <- unlocked without lock grab.
 +
 +	return ret;
 +}

> I'm not saying V1 is the final solution, but I think maybe we can just
> keep V1 as it is? That's easier for a stable backport too, and this is
> doing far better than what it was like. The sync discard was added in
> 2013 and the later added percpu cluster at the same year never treated
> it carefully. And the discard during allocation after recent swap
> allocator rework has been kind of broken for a while.
> 
> To optimize it further in a clean way, we have to reverse the
> allocator's handling order of the plist and fast / slow path. Current
> order is local_lock -> fast -> slow (plist).
> We can walk the plist first, then do the fast / slow path: plist (or
> maybe something faster than plist but handles the priority) ->
> local_lock -> fast -> slow (bonus: this is more friendly to RT kernels

I think the idea is good, but when approaching it that way, 
I am curious about rotation handling.

In the current code, rotation is always done when traversing the plist in the slow path.
If we traverse the plist first, how should rotation be handled?

1. Do a naive rotation at plist traversal time. 
(But then fast path might allocate from an si we didn’t select.)
2. Rotate when allocating in the slow path. 
(But between releasing swap_avail_lock, we might access an si that wasn’t rotated.)

Both cases could break rotation behavior — what do you think?

> too I think). That way we don't need to rewalk the plist after
> releasing the local_lock and save a lot of trouble. I remember I
> discussed with Youngjun on this sometime ago in the mail list, I know

Recapping your earlier idea: cache only the swap device per cgroup in percpu, 
and keep the cluster inside the swap device.
Applied to swap tiers, cache only the percpu si per tier, 
and keep the cluster in the swap device.
This seems to fit well with your previous suggestion.

However, since we shifted from per-cgroup swap priority to swap tier, 
and will re-submit RFC for swap tier, we’ll need to revisit the discussion.

Youngjun Park

