Return-Path: <stable+bounces-194559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38360C50407
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 02:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B10318880D0
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 01:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99352296BBA;
	Wed, 12 Nov 2025 01:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BzDhQnKz"
X-Original-To: stable@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB371FDA;
	Wed, 12 Nov 2025 01:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912572; cv=none; b=TYiXmHk99RSjGOYpUY/B7PTO7hweG0uQWb71NW6yIPgwD3zuDzVElWcU4uqZmcaveo83DhKAts7lbt0NSr315tZC3Vbf1+ugNeqHI6vbH5YSMSHYQhWTdyIcBwHFlmD89LX2Lg9BE/F8cwZ/h/UUT5YeaQuN74b9xNu6LdlTcAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912572; c=relaxed/simple;
	bh=EQuHflPWFcb/ZRSV7TFyHxG4Ej/+gcTcTQMvhukl158=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vAiJ3v7iWLGvzTmnCVxzu01dFs+X/6rrD/SV50jVtYdAug2r47a+lytzJVEZYYITYdociqLs+cmWQCL/fWSCAUaptBCsdkWxnCZOtZVgxwriAFbC7tt3aL3MSec7JTozlfzGAMpiqpXyxwBTAXpkhNp2jJyPVYhDFB6r5BsBa+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BzDhQnKz; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762912560; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=UBuA1/Lj8w03kZCEoicnR0iXOgCaZCHxQwdHH9zt7bc=;
	b=BzDhQnKzhDjqDiCIpETYX4PvC6yPEudgbQB2Uz/eafJTCEqOhIX82c+mXcwnIZwB7by/KuYVKmcEC7fNklhvAytYrCdZ0pRl14+OrTfwvXYb9o5+P+FSccSbwtOv/jUP0ykGfKJFNxIaaAs3aHpLYnEhjv5HC+1IWfaHjGShA8o=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WsENh76_1762912548 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Nov 2025 09:56:00 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Andrew Morton <akpm@linux-foundation.org>,  Chris
 Li <chrisl@kernel.org>,  Kemeng Shi <shikemeng@huaweicloud.com>,  Nhat
 Pham <nphamcs@gmail.com>,  Baoquan He <bhe@redhat.com>,  Barry Song
 <baohua@kernel.org>,  linux-kernel@vger.kernel.org,  Kairui Song
 <kasong@tencent.com>,  stable@vger.kernel.org
Subject: Re: [PATCH] mm, swap: fix potential UAF issue for VMA readahead
In-Reply-To: <20251111-swap-fix-vma-uaf-v1-1-41c660e58562@tencent.com> (Kairui
	Song's message of "Tue, 11 Nov 2025 21:36:08 +0800")
References: <20251111-swap-fix-vma-uaf-v1-1-41c660e58562@tencent.com>
Date: Wed, 12 Nov 2025 09:55:48 +0800
Message-ID: <87ldkchv4r.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Kairui Song <ryncsn@gmail.com> writes:

> From: Kairui Song <kasong@tencent.com>
>
> Since commit 78524b05f1a3 ("mm, swap: avoid redundant swap device
> pinning"), the common helper for allocating and preparing a folio in the
> swap cache layer no longer tries to get a swap device reference
> internally, because all callers of __read_swap_cache_async are already
> holding a swap entry reference. The repeated swap device pinning isn't
> needed on the same swap device.
>
> Caller of VMA readahead is also holding a reference to the target
> entry's swap device, but VMA readahead walks the page table, so it might
> encounter swap entries from other devices, and call
> __read_swap_cache_async on another device without holding a reference to
> it.
>
> So it is possible to cause a UAF when swapoff of device A raced with
> swapin on device B, and VMA readahead tries to read swap entries from
> device A. It's not easy to trigger, but in theory, it could cause real
> issues.
>
> Make VMA readahead try to get the device reference first if the swap
> device is a different one from the target entry.
>
> Cc: stable@vger.kernel.org
> Fixes: 78524b05f1a3 ("mm, swap: avoid redundant swap device pinning")
> Suggested-by: Huang Ying <ying.huang@linux.alibaba.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
> Sending as a new patch instead of V2 because the approach is very
> different.
>
> Previous patch:
> https://lore.kernel.org/linux-mm/20251110-revert-78524b05f1a3-v1-1-88313f2b9b20@tencent.com/
> ---
>  mm/swap_state.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 0cf9853a9232..da0481e163a4 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -745,6 +745,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
>  
>  	blk_start_plug(&plug);
>  	for (addr = start; addr < end; ilx++, addr += PAGE_SIZE) {
> +		struct swap_info_struct *si = NULL;
>  		softleaf_t entry;
>  
>  		if (!pte++) {
> @@ -759,8 +760,19 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
>  			continue;
>  		pte_unmap(pte);
>  		pte = NULL;
> +		/*
> +		 * Readahead entry may come from a device that we are not
> +		 * holding a reference to, try to grab a reference, or skip.
> +		 */
> +		if (swp_type(entry) != swp_type(targ_entry)) {
> +			si = get_swap_device(entry);
> +			if (!si)
> +				continue;
> +		}
>  		folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
>  						&page_allocated, false);
> +		if (si)
> +			put_swap_device(si);
>  		if (!folio)
>  			continue;
>  		if (page_allocated) {

Personally, I prefer to call put_swap_device() after all swap operations
on the swap entry, that is, after possible swap_read_folio() and
folio_put() in the loop to make it easier to follow the
get/put_swap_device() rule.  But I understand that it will make

if (!folio)
        continue;

to use 'goto' and introduce more change.  So, it's up to you to decide
whether to do that.

Otherwise, LGTM, Thanks for doing this!  Feel free to add my

Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>

in the future versions.

---
Best Regards,
Huang, Ying

