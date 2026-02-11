Return-Path: <stable+bounces-215730-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL/4DhHRi2lnbgAAu9opvQ
	(envelope-from <stable+bounces-215730-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 01:45:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 877091205D0
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 01:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D6DD3042090
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 00:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A35520D4FC;
	Wed, 11 Feb 2026 00:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ogz/RM0G"
X-Original-To: stable@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE21120010A
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 00:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770770700; cv=none; b=luQ230YmZ+1CkiYQKbS7UlMe2WVH7xD0+3CWaEf3gaNfr4TWnfAkIL7nU1QYl2G/Wc2pBHTtzh/O/Rm/9a4DZZLWyENZGzSuxVJFx79cRBk2V0GYnQLaQJO73KgihBtQ1WEQipTVjNi+jiwfkEL5Ixs/3OyW5fCyInBe1YRTtEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770770700; c=relaxed/simple;
	bh=PviNywCNhcmo7ZyYGvWUsyHlqd0Zo71vo1Jf0aFixyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYj4T4WKNfAqV2GUxRemPSml8YO5Nj0SJP5lSyxJB6A837en4HTZUr7xH1Gwiy+Sam5DdEbn2kTELAhjp0hSyUIfYWDf/EmhaxxBQMrF1AXJeB2KfTcLuS0ZLFt1yOrF6/IGbQ6fVzyiiU15fy9R6mw4C21C+sAZfTdB4UiG4cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ogz/RM0G; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770770696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3aJnr/OplGPAFmy1GI/fCChhGWEtuYa5I8f+gitr6E=;
	b=ogz/RM0Gal0DKCePsJrRFYXBUFaCmlyOfJSgqV5bM5gS/PpkBBMe5t9pa8uNMEdmwTjj6S
	ClJRpQ2A8D1XL/Rsioh9iFckh6maXSSEWcYoeV0oKgDFFelSResKvN41xh9IF6rawrwXsi
	fVKzTqjA03Olw1uOiaVy+WE6WvHe8mc=
From: Usama Arif <usama.arif@linux.dev>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Wupeng Ma <mawupeng1@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2] mm/hugetlb: Restore failed global reservations to subpool
Date: Tue, 10 Feb 2026 16:44:44 -0800
Message-ID: <20260211004449.3731199-1-usama.arif@linux.dev>
In-Reply-To: <20260116204037.2270096-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-215730-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 877091205D0
X-Rspamd-Action: no action

On Fri, 16 Jan 2026 15:40:36 -0500 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> Commit a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
> fixed an underflow error for hstate->resv_huge_pages caused by
> incorrectly attributing globally requested pages to the subpool's
> reservation.
> 
> Unfortunately, this fix also introduced the opposite problem, which would
> leave spool->used_hpages elevated if the globally requested pages could
> not be acquired. This is because while a subpool's reserve pages only
> accounts for what is requested and allocated from the subpool, its
> "used" counter keeps track of what is consumed in total, both from the
> subpool and globally. Thus, we need to adjust spool->used_hpages in the
> other direction, and make sure that globally requested pages are
> uncharged from the subpool's used counter.
> 
> Each failed allocation attempt increments the used_hpages counter by
> how many pages were requested from the global pool. Ultimately, this
> renders the subpool unusable, as used_hpages approaches the max limit.
> 
> The issue can be reproduced as follows:
> 1. Allocate 4 hugetlb pages
> 2. Create a hugetlb mount with max=4, min=2
> 3. Consume 2 pages globally
> 4. Request 3 pages from the subpool (2 from subpool + 1 from global)
> 	4.1 hugepage_subpool_get_pages(spool, 3) succeeds.
> 		used_hpages += 3
> 	4.2 hugetlb_acct_memory(h, 1) fails: no global pages left
> 		used_hpages -= 2
> 5. Subpool now has used_hpages = 1, despite not being able to
>    successfully allocate any hugepages. It believes it can now only
>    allocate 3 more hugepages, not 4.
> 
> Repeating this process will ultimately render the subpool unable to
> allocate any hugepages, since it believes that it is using the maximum
> number of hugepages that the subpool has been allotted.
> 
> The underflow issue that the original commit fixes still remains fixed
> as well.
> 
> Fixes: a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Cc: stable@vger.kernel.org
> ---
> v1 --> v2
> - Moved "unsigned long flags" definition into the if statement it is used in
> - Separated fix patch from cleanup patches for easier backporting for stable.
> 
>  mm/hugetlb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Makes sense. Without this, used_hpages would keep on leaking if
hugetlb_acct_memory fails.

Acked-by: Usama Arif <usama.arif@linux.dev>

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 5a147026633f..e48ff0c771f8 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6713,6 +6713,15 @@ long hugetlb_reserve_pages(struct inode *inode,
>  		 */
>  		hugetlb_acct_memory(h, -gbl_resv);
>  	}
> +	/* Restore used_hpages for pages that failed global reservation */
> +	if (gbl_reserve && spool) {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&spool->lock, flags);
> +		if (spool->max_hpages != -1)
> +			spool->used_hpages -= gbl_reserve;
> +		unlock_or_release_subpool(spool, flags);
> +	}
>  out_uncharge_cgroup:
>  	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
>  					    chg * pages_per_huge_page(h), h_cg);
> 
> base-commit: c1a60bf0f6df5c8a6cb6840a0d2fb0e9caf9f7cc
> -- 
> 2.47.3
> 

