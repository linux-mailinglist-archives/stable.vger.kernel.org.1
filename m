Return-Path: <stable+bounces-273445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lmcVMoPqUmrUVQMAu9opvQ
	(envelope-from <stable+bounces-273445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 03:14:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F307435FB
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 03:14:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=hEVOCcC5;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273445-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-273445-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67C163018C30
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 01:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24A51F09A5;
	Sun, 12 Jul 2026 01:14:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D627B1D416C
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 01:14:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783818879; cv=none; b=oVoDgvbTF4Aw3ZLkMqVHzf46x9n6+/KLlVH0uT4FN+vwUcOFXcwVlOTIXlthQ3YtKUlO6dferonD1b8tfO1OWMjx0XaE98yABIAWzaOqrOvnXg7jy1tPLVwOdu33hG9NJeFATQfmdjq3pottCTCop38v4FTXEazZCqbfko09f1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783818879; c=relaxed/simple;
	bh=GLdRNrfBScn58W+OaBAZaSME4KiOO6jA15XhdGdqKdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TXhk3FWigQvn7B3VtYKIEuvbRECr+SE6gVBNWZIGlSfUNqrkx4wK0H5glnB5GFtdmTJ1JOiYfwNXIqkpJpR5XnXkLPy3J7GsmZIPQU8UuQ+4L8ZTPRhKP6kC435zLinftdKM3lp3TK4xXOOwAYkewyjqMDd6X7DzGpAQaVL1tjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hEVOCcC5; arc=none smtp.client-ip=91.218.175.178
Message-ID: <88169a4d-157a-4307-8e21-554b122fb411@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783818865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xAdjGXolE8bZ9ddc0fiq07hvqt0bNR4iJP1GyPcJcxw=;
	b=hEVOCcC5p/m7fKRTTlL+957hsqizSlFDzP0U7kz0kjxO2y6Vkr1espBueyl+xR6rd4ZKxj
	+G+rnXvSaRl0IeWXg76dM1iONq3w5TwjRVeMLSUjwEHWkfdKRTtdg2fm7qT4opDapYquP0
	V2jHXAvWyeqWQKdWd18SQtEK3qW/QOU=
Date: Sun, 12 Jul 2026 09:14:12 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] fs/proc/task_mmu: fix PAGEMAP_SCAN written state for
 PMD holes
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: akpm@linux-foundation.org, usama.anjum@collabora.com, peterx@redhat.com,
 liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, jannh@google.com,
 pfalcato@suse.de, david@kernel.org, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, shuah@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, kernel-team@meta.com
References: <20260709121629.205562-1-kirill@shutemov.name>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20260709121629.205562-1-kirill@shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:kirill@shutemov.name,m:akpm@linux-foundation.org,m:usama.anjum@collabora.com,m:peterx@redhat.com,m:liam@infradead.org,m:ljs@kernel.org,m:vbabka@kernel.org,m:jannh@google.com,m:pfalcato@suse.de,m:david@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:shuah@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:stable@vger.kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zenghui.yu@linux.dev,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-273445-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenghui.yu@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,vger.kernel.org:from_smtp,sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55F307435FB

Hi Kiryl,

On 7/9/26 8:16 PM, Kiryl Shutsemau wrote:
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> 
> PAGEMAP_SCAN reports an unpopulated PTE in a uffd-wp VMA as written, but
> a range with no page table at all -- a PMD hole -- is skipped:
> pagemap_scan_pte_hole() tests p->cur_vma_category, which never carries
> PAGE_IS_WRITTEN, so the hole is neither reported nor (under
> PM_SCAN_WP_MATCHING) armed.
> 
> MADV_DONTNEED has fill-with-zeros semantics: it changes the contents of
> the range to zeroes (a subsequent read maps the zero page), which write
> tracking must report as written. An anonymous THP is write-protected in
> place as a huge PMD, so a full-PMD MADV_DONTNEED clears it to pmd_none --
> a hole -- and the zeroing goes unreported. A write-tracking
> checkpoint/migration tool (e.g. CRIU) then treats the range as unchanged
> and keeps its previous contents, so after restore or live migration the
> process reads stale data instead of zeroes -- data corruption.
> 
> Report a hole in a non-hugetlb uffd-wp VMA as written, matching the
> pte_none handling in pagemap_page_category(); the existing
> PM_SCAN_WP_MATCHING path then arms it via uffd_wp_range().
> 
> hugetlb is excluded: pagemap_hugetlb_category() reports an empty hugetlb
> entry (huge_pte_none) as not-written, unlike pagemap_page_category(),
> which reports pte_none as written. pagemap_scan_pte_hole() fires for a
> hugetlb slot only when it has no page table; keeping that not-written
> matches how an allocated-but-empty hugetlb entry reads, so the hole and
> the empty-entry cases agree within the VMA.
> 
> Add a pagemap_ioctl selftest covering the anon-THP PMD-hole case.
> 
> Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260707151349.92143-1-kirill@shutemov.name
> Fixes: 2bad466cc9d9 ("mm/uffd: UFFD_FEATURE_WP_UNPOPULATED")
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Assisted-by: Claude:claude-fable-5
> ---
> 
> Changes since v2 [1], addressing Andrew's review:
>   - Describe the user-visible effect: MADV_DONTNEED has fill-with-zeros
>     semantics, so the range must be reported written; otherwise a
>     checkpoint/migration tool (CRIU) keeps stale data and the process
>     reads corrupted contents after restore. Add Reported-by/Closes.
>   - Reword the hugetlb carve-out to rest on the category functions:
>     pagemap_hugetlb_category() reads an empty hugetlb entry as
>     not-written, unlike pagemap_page_category().
>   - Drop the redundant MADV_COLLAPSE fallback #define; it is in
>     <asm-generic/mman-common.h> and used directly by other mm selftests.

I hit the following compilation error on mm-new:

[root@localhost mm]# make
  CC       pagemap_ioctl
pagemap_ioctl.c: In function 'unpopulated_thp_hole_test':
pagemap_ioctl.c:1130:31: error: 'MADV_COLLAPSE' undeclared (first use in this function); did you mean 'MADV_COLD'?
 1130 |  if (madvise(mem, hpage_size, MADV_COLLAPSE) ||
      |                               ^~~~~~~~~~~~~
      |                               MADV_COLD
pagemap_ioctl.c:1130:31: note: each undeclared identifier is reported only once for each function it appears in
make: *** [../lib.mk:225: /root/code/mm/tools/testing/selftests/mm/pagemap_ioctl] Error 1

Could you consider addressing it like fd5295afae91 ("selftests/mm:
hmm-tests: include linux/mman.h to access MADV_COLLAPSE")?

Thanks,
Zenghui

