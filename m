Return-Path: <stable+bounces-268232-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Sqa8AGJ3PGploQgAu9opvQ
	(envelope-from <stable+bounces-268232-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 02:33:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1136C1FD3
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 02:33:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b="o/xEAecB";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268232-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268232-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED7DB3045DFB
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 00:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE791317166;
	Thu, 25 Jun 2026 00:33:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF25F327BEC;
	Thu, 25 Jun 2026 00:33:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782347611; cv=none; b=RNL62ciRAWBjQ/Cb04asKd5gq4phCf+m38hnvNmH0tsLCKPV24gXt2ksnZvyXeTyeJzSQPrW4IdqI7mC7OcJpmeuS6KLmv03XeYQn9FxycFplpqAhiS4BzM7BXcpYuksZdgzFThZ20vLgYvFYcultE8PtSRxvnyrKoqbhw6dMmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782347611; c=relaxed/simple;
	bh=JuPC2NwHR8p7UCHAMp+5wPB1BpecNAnCCEwlcPzOpMI=;
	h=Date:To:From:Subject:Message-Id; b=uhzK0+gp8YYLt0dLUXuEkxJevfUwa4ZAboacEJcxMDDEM5TaN5zETShO5nnE7xrOlH5SMelYb17WIl9ik1bsym9500slyoCXHH6Vgfo2rfRbHTmVU75R+QWK3KhN94OP26ecLXn6QdknJFDV06OEV1itwOkuFXSrsW2PP9JTCNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=o/xEAecB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800D61F000E9;
	Thu, 25 Jun 2026 00:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782347600;
	bh=WwrEgTb38eyQw+Y8zddZYjuF/WVHCGKJC5HUzhITnIE=;
	h=Date:To:From:Subject;
	b=o/xEAecBq78bHhOCGeyLR879mW+RiERsn8jrnpiM3nUfx+TCjm7O2lvCFunIVQwu0
	 UkNw4PE5ZFFy0YoN8FgRFMK4gLdXn/WiLsC0Adi/EKmSIRqFQUZtdmV4HIU5GGob8c
	 64uzwoxa/8YbcK0JpX2qv0ONctigCUwV13r0qZ4c=
Date: Wed, 24 Jun 2026 17:33:20 -0700
To: mm-commits@vger.kernel.org,ziy@nvidia.com,willy@infradead.org,vbabka@kernel.org,surenb@google.com,stable@vger.kernel.org,rppt@kernel.org,mhocko@suse.com,luizcap@redhat.com,ljs@kernel.org,liam@infradead.org,jackmanb@google.com,hannes@cmpxchg.org,david@redhat.com,david@kernel.org,ketan.kishore@oss.qualcomm.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-page_ext-add-count-limit-to-page_ext_iter_next-to-prevent-invalid-pfn-access.patch added to mm-hotfixes-unstable branch
Message-Id: <20260625003320.800D61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268232-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:ziy@nvidia.com,m:willy@infradead.org,m:vbabka@kernel.org,m:surenb@google.com,m:stable@vger.kernel.org,m:rppt@kernel.org,m:mhocko@suse.com,m:luizcap@redhat.com,m:ljs@kernel.org,m:liam@infradead.org,m:jackmanb@google.com,m:hannes@cmpxchg.org,m:david@redhat.com,m:david@kernel.org,m:ketan.kishore@oss.qualcomm.com,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E1136C1FD3


The patch titled
     Subject: mm: page_ext: add count limit to page_ext_iter_next to prevent invalid PFN access
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-page_ext-add-count-limit-to-page_ext_iter_next-to-prevent-invalid-pfn-access.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-page_ext-add-count-limit-to-page_ext_iter_next-to-prevent-invalid-pfn-access.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via various
branches at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there most days

------------------------------------------------------
From: Ketan <ketan.kishore@oss.qualcomm.com>
Subject: mm: page_ext: add count limit to page_ext_iter_next to prevent invalid PFN access
Date: Tue, 23 Jun 2026 02:48:04 +0530

The page_ext iteration API does not validate if the PFN still belongs to a
valid section while advancing the iterator.  When dynamically adding
memory in the hotplug path, it can lead to a NULL pointer dereference
during page_ext_lookup at the boundary of the last valid section when
iterator count equals __pgcount.

The for_each_page_ext() macro calls page_ext_iter_next() as its loop
increment.  for_each_page_ext() does a "__page_ext =
page_ext_iter_next(&__iter)" at the end.  This causes page_ext_iter_next()
to increment iter->index past __pgcount and call page_ext_lookup(start_pfn
+ __pgcount).  During memory hotplug (online), the PFN at start_pfn +
__pgcount may belong to a section that has not yet been initialized,
causing page_ext_lookup() to trigger a NULL pointer dereference.

[   14.555124][  T846] Call trace:
[   14.555125][  T846]  lookup_page_ext+0x6c/0x108 (P)
[   14.555127][  T846]  page_ext_lookup+0x30/0x3c
[   14.555129][  T846]  __reset_page_owner+0x11c/0x260
[   14.571201][  T846]  __free_pages_ok+0x5e8/0x8e0
[   14.571204][  T846]  __free_pages_core+0x78/0xf0
[   14.571206][  T846]  generic_online_page+0x14/0x24
[   14.597782][  T846]  online_pages+0x178/0x30c
[   14.597784][  T846]  memory_block_change_state+0x284/0x32c
[   14.597787][  T846]  memory_subsys_online+0x4c/0x64
[   14.597789][  T846]  device_online+0x88/0xb0
[   14.597791][  T846]  online_memory_block+0x30/0x40
[   14.597793][  T846]  walk_memory_blocks+0xac/0xe8
[   14.597794][  T846]  add_memory_resource+0x280/0x298
[   14.656161][  T846]  add_memory+0x60/0x98

Move the iteration boundary enforcement inside the iterator functions, so
callers cannot inadvertently access beyond the requested range.

Link: https://lore.kernel.org/20260623-page_ext-v3-1-a89799a5367c@oss.qualcomm.com
Fixes: 9039b9096ea2 ("mm: page_owner: use new iteration API")
Signed-off-by: Ketan Kishore <ketan.kishore@oss.qualcomm.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Acked-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Luiz Capitulino <luizcap@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/page_ext.h |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

--- a/include/linux/page_ext.h~mm-page_ext-add-count-limit-to-page_ext_iter_next-to-prevent-invalid-pfn-access
+++ a/include/linux/page_ext.h
@@ -120,14 +120,18 @@ struct page_ext_iter {
  * page_ext_iter_begin() - Prepare for iterating through page extensions.
  * @iter: page extension iterator.
  * @pfn: PFN of the page we're interested in.
+ * @count: maximum number of page extensions to return.
  *
  * Must be called with RCU read lock taken.
  *
  * Return: NULL if no page_ext exists for this page.
  */
 static inline struct page_ext *page_ext_iter_begin(struct page_ext_iter *iter,
-						unsigned long pfn)
+		unsigned long pfn, unsigned long count)
 {
+	if (!count)
+		return NULL;
+
 	iter->index = 0;
 	iter->start_pfn = pfn;
 	iter->page_ext = page_ext_lookup(pfn);
@@ -138,19 +142,22 @@ static inline struct page_ext *page_ext_
 /**
  * page_ext_iter_next() - Get next page extension
  * @iter: page extension iterator.
+ * @count: maximum number of page extensions to return.
  *
  * Must be called with RCU read lock taken.
  *
  * Return: NULL if no next page_ext exists.
  */
-static inline struct page_ext *page_ext_iter_next(struct page_ext_iter *iter)
+static inline struct page_ext *page_ext_iter_next(struct page_ext_iter *iter,
+		unsigned long count)
 {
 	unsigned long pfn;
 
 	if (WARN_ON_ONCE(!iter->page_ext))
 		return NULL;
 
-	iter->index++;
+	if (++iter->index >= count)
+		return NULL;
 	pfn = iter->start_pfn + iter->index;
 
 	if (page_ext_iter_next_fast_possible(pfn))
@@ -183,9 +190,9 @@ static inline struct page_ext *page_ext_
  * IMPORTANT: must be called with RCU read lock taken.
  */
 #define for_each_page_ext(__page, __pgcount, __page_ext, __iter) \
-	for (__page_ext = page_ext_iter_begin(&__iter, page_to_pfn(__page));\
-		__page_ext && __iter.index < __pgcount;          \
-		__page_ext = page_ext_iter_next(&__iter))
+	for (__page_ext = page_ext_iter_begin(&__iter, page_to_pfn(__page), __pgcount); \
+		__page_ext; \
+		__page_ext = page_ext_iter_next(&__iter, __pgcount))
 
 #else /* !CONFIG_PAGE_EXTENSION */
 struct page_ext;
_

Patches currently in -mm which might be from ketan.kishore@oss.qualcomm.com are

mm-page_ext-add-count-limit-to-page_ext_iter_next-to-prevent-invalid-pfn-access.patch


