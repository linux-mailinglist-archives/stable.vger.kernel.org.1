Return-Path: <stable+bounces-273616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eTVBBfOsVGoCpQMAu9opvQ
	(envelope-from <stable+bounces-273616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 11:16:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 991A3749312
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 11:16:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=shutemov.name header.s=fm3 header.b="v A8o/S5";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=TFo790AH;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273616-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-273616-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7FFF302CB5D
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 09:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B223E023E;
	Mon, 13 Jul 2026 09:16:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9C21F3B8A;
	Mon, 13 Jul 2026 09:16:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934174; cv=none; b=XXllsdd7fMAGHNocT3pdco0GvWMVpLkyvM1EKCGrciWdRx+msi+KA5QYJi2Z7AaglYyR55qqbbpBKhB1knBO+jujIwMRTgYzQf+LQevX16/Qs4UY5VRWHoS2NDm2Cz5MlIjFSPfQeZINZW9M+0tKVMg1JD+fU+ef4RtJSNADC5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934174; c=relaxed/simple;
	bh=IkY9qdEXxW023gLy8Ol6hI6jJsla6Cf0nxrWo+iMdWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isY2Zyc2zbBeWlsN2iPeAHxRrX6dd3dUU6wzE8zZLL0oOkdkUNSd2zX5k4kGIeE4ERufpK0m1uN2+aCGoKMkyjXIySGuvCIfTu6DgDWnMKdd585j/6ahXMP68lhR/5Ss8rsgg9KEH4Cemae2lcdcHTzyzm4hKLVFH44sCuIO5Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=vA8o/S5w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TFo790AH; arc=none smtp.client-ip=202.12.124.138
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailflow.stl.internal (Postfix) with ESMTP id DE09C130006F;
	Mon, 13 Jul 2026 05:16:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 13 Jul 2026 05:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1783934169; x=
	1783941369; bh=FCkZsKklgMbU6h9abQ6OltJgVod+mMJ6I9NuFl07crE=; b=v
	A8o/S5wjGfuAgn5RhOgfrmYAlz3mbA2So1IHVCi27GwvRKYj9htmwUfwI5+AXo9I
	Q6TPSq81L/cD10OOZ4JBSoYfpv8Sb2KWl6kg+ZIN9aNUj+bPoEJAuIJCVKvVQ7BB
	2XxKlKf1551RseQEwxhXWq7NyAhYms7TmDWQrUbGFWOMEJxv5yFrmh8OAcdaq8Nr
	lwXsxyenkxcpsOrQnIcEZv62dGx9Zesj8jhAXWTeE78LNjbsMTjC2DHJ2EXl3JNw
	ki1VRBeJ4qN6tpAa6m/aItvsgU2/+7qTrU2rQwUdiPSQ8gn8LolhTXVoGx8UzFdK
	w/qyHQdIp+ACXjaOnPhoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783934169; x=1783941369; bh=FCkZsKklgMbU6h9abQ6OltJgVod+mMJ6I9N
	uFl07crE=; b=TFo790AHrbMrEAeD+u9Ujo6VAqBl+PcuHvL6kVgUhg80RhT40CW
	I434epKkdMyZc5lxHucvMzoUXKJ9ETeI5lx2/OWk9NsI7BQXdYecrXQKaMOOGr2U
	6UD5rscJBy0UdFX/ALb5joTFfTG346VXXnnfyDyeUgB6j7L46I1/3yFLEr4l4Crt
	TrgDot5U82bBGetwaPvDpbpWewO7n96knXSBAF/nxmdyYmPtl1+ZgDw6wokYCXS5
	SMHbehOi15KrFTofN5hA0avmJ090rNEruQNVQB6Trn0olnVT3QghuQCopIvLqRxA
	FVxewWgJhMuCKLnBPN3aPMZ6bMP4mgxHzFA==
X-ME-Sender: <xms:2KxUaljYRAUm7jx40lulj3o3nP-3TOUXhQDXjmvPfCmwNDA5AVfBrA>
    <xme:2KxUagIRWteYr14R5vZQP84HAflPxwa-XiDKL_H3C_qgbJZACMFc2QKUiD_eFN9Ju
    4ZOW2S91xEuP6dj2BUDaZcairG23G_JBlND1tx1D4NUOzSKsRm6F64>
X-ME-Received: <xmr:2KxUarm7qtDEIbYHj_lkg8rtqBUMRNw-q_DpR63Xht7DeLHEO4dPuH0aSwuYig>
X-ME-Proxy-Cause: dmFkZTFpjGdNNNZHzGyOsdRvDPmeJOQXKVkSAGkVkGu2fgkSNH3LPYHy7jTW74F8XTcZMN
    pZOVvcgJ+Y2ro8jUVfaKG2GvwSRocHCxj1NBpBmzqT0PqPZGUf35cYRjjGRlf7xtPBQo79
    S2YpLr/uIyOMja5s20SZDYXrnf6/JmuwdWfBW9Ausgb8a1y23Uh5MhJy0rVWusMomPtDQy
    HoYfVDeI0uyhJELu+w/u8JjhXRpkOzm8cHmofWyU9N8Jkt+UZoeOszkEc/bznIX/j52CyN
    DnYnxzAw2QGZHf2JqNj15t2eH0Tq79P32xEyaXxftEXZLDjV+HDxE2DHl980eZv+SDvyL0
    DAyyQUJTIqFFpOUbjO2ZEj0Q5NzFu5S9D9YBTUfxqCJQkQHk7zA+FKFcF+N5NeDAxAf4Wp
    9x0wtrrHRCVkXQsD0Ge3lKGAqFzCmgg63XL+yXZW4aF/kwMQCzHBGsVZzJ3RMAHae8vAOT
    cKTqIqVNuw4Eg0btbXjxE46sp89qetqvz51qZnFjPgoygwcsEuAv9Kmn6bYf+rnjeIksDp
    jASmzHM5WdLXnkHkyUuYN69TW7zlSjq5I0AEFAVT3eItlAepbh1i31vpJ1q27xE4YjK8aE
    Ezsqw+7zIVkd7JwKlbfyPdOXUBaVWUB53d6o9tx2EWQmoxHlZOMv5r+PJwow
X-ME-Proxy: <xmx:2KxUakS5foqvcfbRw_fXzPqbyeP-ytEe6mya6PcjVMrPPNvo03W_NA>
    <xmx:2axUamYZH2jletZqspcy07f7C_r6pcIbjXdUD8DCjNTzzKq3vGIO_w>
    <xmx:2axUakjdimjyCbalVpIVhR-Vc7_UPrK4AgRCtYGyJOMFZUanhJwPqQ>
    <xmx:2axUanWO_EadNZolmxWW8HUZooWR4WkgL-YNakoUR47YMaa_ZvsKvQ>
    <xmx:2axUavUc8ZCcJdraIcWd0QMCuyKoZY3Z0aMsrjHro4IGr9Q6-SPMy67o>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 05:16:08 -0400 (EDT)
Date: Mon, 13 Jul 2026 10:16:07 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: akpm@linux-foundation.org, usama.anjum@collabora.com, 
	peterx@redhat.com, liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, 
	jannh@google.com, pfalcato@suse.de, david@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, shuah@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3] fs/proc/task_mmu: fix PAGEMAP_SCAN written state for
 PMD holes
Message-ID: <alSqkTahOx9uc2Uc@thinkstation>
References: <20260709121629.205562-1-kirill@shutemov.name>
 <88169a4d-157a-4307-8e21-554b122fb411@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88169a4d-157a-4307-8e21-554b122fb411@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[shutemov.name:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:zenghui.yu@linux.dev,m:akpm@linux-foundation.org,m:usama.anjum@collabora.com,m:peterx@redhat.com,m:liam@infradead.org,m:ljs@kernel.org,m:vbabka@kernel.org,m:jannh@google.com,m:pfalcato@suse.de,m:david@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:shuah@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:stable@vger.kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[shutemov.name];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kirill@shutemov.name,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-273616-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[shutemov.name:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kirill@shutemov.name,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,thinkstation:mid,collabora.com:email,shutemov.name:from_mime,shutemov.name:dkim,sashiko.dev:url,messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 991A3749312

On Sun, Jul 12, 2026 at 09:14:12AM +0800, Zenghui Yu wrote:
> Hi Kiryl,
> 
> On 7/9/26 8:16 PM, Kiryl Shutsemau wrote:
> > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> > 
> > PAGEMAP_SCAN reports an unpopulated PTE in a uffd-wp VMA as written, but
> > a range with no page table at all -- a PMD hole -- is skipped:
> > pagemap_scan_pte_hole() tests p->cur_vma_category, which never carries
> > PAGE_IS_WRITTEN, so the hole is neither reported nor (under
> > PM_SCAN_WP_MATCHING) armed.
> > 
> > MADV_DONTNEED has fill-with-zeros semantics: it changes the contents of
> > the range to zeroes (a subsequent read maps the zero page), which write
> > tracking must report as written. An anonymous THP is write-protected in
> > place as a huge PMD, so a full-PMD MADV_DONTNEED clears it to pmd_none --
> > a hole -- and the zeroing goes unreported. A write-tracking
> > checkpoint/migration tool (e.g. CRIU) then treats the range as unchanged
> > and keeps its previous contents, so after restore or live migration the
> > process reads stale data instead of zeroes -- data corruption.
> > 
> > Report a hole in a non-hugetlb uffd-wp VMA as written, matching the
> > pte_none handling in pagemap_page_category(); the existing
> > PM_SCAN_WP_MATCHING path then arms it via uffd_wp_range().
> > 
> > hugetlb is excluded: pagemap_hugetlb_category() reports an empty hugetlb
> > entry (huge_pte_none) as not-written, unlike pagemap_page_category(),
> > which reports pte_none as written. pagemap_scan_pte_hole() fires for a
> > hugetlb slot only when it has no page table; keeping that not-written
> > matches how an allocated-but-empty hugetlb entry reads, so the hole and
> > the empty-entry cases agree within the VMA.
> > 
> > Add a pagemap_ioctl selftest covering the anon-THP PMD-hole case.
> > 
> > Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/patchset/20260707151349.92143-1-kirill@shutemov.name
> > Fixes: 2bad466cc9d9 ("mm/uffd: UFFD_FEATURE_WP_UNPOPULATED")
> > Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > Assisted-by: Claude:claude-fable-5
> > ---
> > 
> > Changes since v2 [1], addressing Andrew's review:
> >   - Describe the user-visible effect: MADV_DONTNEED has fill-with-zeros
> >     semantics, so the range must be reported written; otherwise a
> >     checkpoint/migration tool (CRIU) keeps stale data and the process
> >     reads corrupted contents after restore. Add Reported-by/Closes.
> >   - Reword the hugetlb carve-out to rest on the category functions:
> >     pagemap_hugetlb_category() reads an empty hugetlb entry as
> >     not-written, unlike pagemap_page_category().
> >   - Drop the redundant MADV_COLLAPSE fallback #define; it is in
> >     <asm-generic/mman-common.h> and used directly by other mm selftests.
> 
> I hit the following compilation error on mm-new:
> 
> [root@localhost mm]# make
>   CC       pagemap_ioctl
> pagemap_ioctl.c: In function 'unpopulated_thp_hole_test':
> pagemap_ioctl.c:1130:31: error: 'MADV_COLLAPSE' undeclared (first use in this function); did you mean 'MADV_COLD'?
>  1130 |  if (madvise(mem, hpage_size, MADV_COLLAPSE) ||
>       |                               ^~~~~~~~~~~~~
>       |                               MADV_COLD
> pagemap_ioctl.c:1130:31: note: each undeclared identifier is reported only once for each function it appears in
> make: *** [../lib.mk:225: /root/code/mm/tools/testing/selftests/mm/pagemap_ioctl] Error 1
> 
> Could you consider addressing it like fd5295afae91 ("selftests/mm:
> hmm-tests: include linux/mman.h to access MADV_COLLAPSE")?

Yep, will send v4.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

