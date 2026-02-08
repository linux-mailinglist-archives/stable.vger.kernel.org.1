Return-Path: <stable+bounces-214845-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2rweHUbth2n0fAQAu9opvQ
	(envelope-from <stable+bounces-214845-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 02:56:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 883DF107944
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 02:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77F753004DB2
	for <lists+stable@lfdr.de>; Sun,  8 Feb 2026 01:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F9B308F28;
	Sun,  8 Feb 2026 01:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0aJTX17I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2062F22A7E4;
	Sun,  8 Feb 2026 01:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770515774; cv=none; b=Hikk8U5VL+4nD/P+CIMt8hr1tcZksp5yswhlEgzbus8aauD5ItNtt32VEwGR04ju3zZYy3ClGcgAxjwIdoCfoxFK/CPHp4nysaheQDB4LVD5D93PTh8RuEbYvYnS08c4FK16jvd/E8oaXTd4STRYNYln6Ih3rP95sDpXIRcitHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770515774; c=relaxed/simple;
	bh=qhT1YKDCoWAuQ/fbU+Jzft0KtxWaMjItJpa4qonB32w=;
	h=Date:To:From:Subject:Message-Id; b=lzwU25oCmJoy7KRBc2Ia19Sxl/Ebuh9nDmOtfuR28euqEapTKOMEfgf7Wmv7TfcVc7DND1GRChyxbf01IJBTSrtdejry/iaz7qD5R7u+2e7e+NreQAKfIohf7ktzPk0jEXiP02CisRskMhzfJ8tpMJYbHTASc4TA8dRCyZpGbZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0aJTX17I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76245C116D0;
	Sun,  8 Feb 2026 01:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1770515773;
	bh=qhT1YKDCoWAuQ/fbU+Jzft0KtxWaMjItJpa4qonB32w=;
	h=Date:To:From:Subject:From;
	b=0aJTX17Ii1LkYvrnwraMEyOiEFw4D2Tzij8J68TZ6use8Gqsq6q+yYbIKO2ab4SI6
	 AoutnVbhAlZng8b0+SoHd2z8Mvtbcrunzm6gSvMRVkiaPjs0iUGzkdEBXKwXXd2wqO
	 UTPYqL/Ta4GYHWkgBFMP8fB2B5PGm1Tt7Cyaakb8=
Date: Sat, 07 Feb 2026 17:56:12 -0800
To: mm-commits@vger.kernel.org,ziy@nvidia.com,vbabka@suse.cz,surenb@google.com,stable@vger.kernel.org,ryncsn@gmail.com,mhocko@suse.com,jackmanb@google.com,hughd@google.com,hannes@cmpxchg.org,chrisl@kernel.org,mikhail.v.gavrilov@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [to-be-updated] mm-page_alloc-clear-page-private-in-split_page-for-tail-pages.patch removed from -mm tree
Message-Id: <20260208015613.76245C116D0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214845-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,nvidia.com,suse.cz,google.com,gmail.com,suse.com,cmpxchg.org,kernel.org,linux-foundation.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,nvidia.com:email,cmpxchg.org:email]
X-Rspamd-Queue-Id: 883DF107944
X-Rspamd-Action: no action


The quilt patch titled
     Subject: mm/page_alloc: clear page->private in split_page() for tail pages
has been removed from the -mm tree.  Its filename was
     mm-page_alloc-clear-page-private-in-split_page-for-tail-pages.patch

This patch was dropped because an updated version will be issued

------------------------------------------------------
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: mm/page_alloc: clear page->private in split_page() for tail pages
Date: Fri, 6 Feb 2026 22:40:17 +0500

When vmalloc allocates high-order pages and splits them via split_page(),
tail pages may retain stale page->private values from previous use by the
buddy allocator.

This causes a use-after-free in the swap subsystem. The swap code uses
vmalloc_to_page() to get struct page pointers for swap_map, then uses
page->private to track swap count continuations. In add_swap_count_
continuation(), the condition "if (!page_private(head))" assumes fresh
pages have page->private == 0, but tail pages from split_page() may have
non-zero stale values.

When page->private accidentally contains a value like SWP_CONTINUED (32),
swap_count_continued() incorrectly assumes the continuation list is valid
and iterates over uninitialized page->lru, which may contain LIST_POISON
values from a previous list_del(), causing a crash:

  KASAN: maybe wild-memory-access in range [0xdead000000000100-0xdead000000000107]
  RIP: 0010:__do_sys_swapoff+0x1151/0x1860

Fix this by clearing page->private for tail pages in split_page(). Note
that we don't touch page->lru to avoid breaking split_free_page() which
may have the head page on a list.

Link: https://lkml.kernel.org/r/20260206174017.128673-1-mikhail.v.gavrilov@gmail.com
Fixes: 3b8000ae185c ("mm/vmalloc: huge vmalloc backing pages should be split rather than compound")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kairui Song <ryncsn@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/page_alloc.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/mm/page_alloc.c~mm-page_alloc-clear-page-private-in-split_page-for-tail-pages
+++ a/mm/page_alloc.c
@@ -3129,9 +3129,14 @@ void split_page(struct page *page, unsig
 
 	VM_WARN_ON_PAGE(!page_count(page), page);
 
-	for (i = 1; i < (1 << order); i++)
+	for (i = 1; i < (1 << order); i++) {
 		set_page_refcounted(page + i);
-
+		/*
+		 * Tail pages may have stale page->private from buddy
+		 * allocator or previous use. Clear it.
+		 */
+		set_page_private(page + i, 0);
+	}
 	__split_page(page, order);
 }
 EXPORT_SYMBOL_GPL(split_page);
_

Patches currently in -mm which might be from mikhail.v.gavrilov@gmail.com are



