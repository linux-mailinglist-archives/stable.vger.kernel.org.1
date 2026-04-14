Return-Path: <stable+bounces-237722-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFR2GMrQ3WndjgkAu9opvQ
	(envelope-from <stable+bounces-237722-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 07:29:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3F43F5BB9
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 07:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCB923050A09
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 05:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154BC3016FC;
	Tue, 14 Apr 2026 05:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eTWUDFFS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2542609EE;
	Tue, 14 Apr 2026 05:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776144548; cv=none; b=mKor2VM61D+DiFbbf273Dn6Sr4xu1EdWi9oddxXsgxLbuyjxbEqhbaMR5ULFT5ILdKR8qZFoxJed3CDUheby8809B5sJ61pVd5V4P78LBDCkuO2hcpSQvU6ygBEd3EvGjJ2vb9q1y8G9Sy1ve+QMaqlXFJvuJvEXp/66zcwvQ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776144548; c=relaxed/simple;
	bh=xlEdkVdMa4iOBWlrkbL+RlGQs9sd8YfrjdIg+Jw/NIQ=;
	h=Date:To:From:Subject:Message-Id; b=Da/ZPyNYRkLdRep7ueqo6WqxPEcWLxRFsftgV2dpZ5Stqvz26xQzzC0tcwY8BfMA7goAlVZwyDGV8Jdsv5T7Y8QyPPqAIM851MPCOeXPuHBLKteXqSTpL1t7R4hgbDEJqKOV9jddkMD+Q7ccjgxBNQxiJ/WjKnFdxfWeq3h0wa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eTWUDFFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6364FC2BCB5;
	Tue, 14 Apr 2026 05:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1776144548;
	bh=xlEdkVdMa4iOBWlrkbL+RlGQs9sd8YfrjdIg+Jw/NIQ=;
	h=Date:To:From:Subject:From;
	b=eTWUDFFSyipnDCu+lgWdpE9/lxPq8Sse+fWF2JUABYz1bF/yaP1fBGjJX3aB3NbhB
	 TfMNsbmKeiaVHBtRzg22xQ+WTn7EgQcVc5ilBMM22bMux8BA7zkA/0F+77SQ/ju1pl
	 eQ5+avQL0Qu2cPNo0KRcFS1/cqeJPWGuDsmabn10=
Date: Mon, 13 Apr 2026 22:29:01 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,jack@suse.cz,big-sleep-vuln-reports+bigsleep-501448199@google.com,axboe@kernel.dk,willy@infradead.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-call-free_folio-directly-in-folio_unmap_invalidate.patch added to mm-hotfixes-unstable branch
Message-Id: <20260414052907.6364FC2BCB5@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237722-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,bigsleep-501448199];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,linux-foundation.org:dkim,linux-foundation.org:email,kernel.dk:email]
X-Rspamd-Queue-Id: 9C3F43F5BB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch titled
     Subject: mm: call ->free_folio() directly in folio_unmap_invalidate()
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-call-free_folio-directly-in-folio_unmap_invalidate.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-call-free_folio-directly-in-folio_unmap_invalidate.patch

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
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: mm: call ->free_folio() directly in folio_unmap_invalidate()
Date: Mon, 13 Apr 2026 19:43:11 +0100

We can only call filemap_free_folio() if we have a reference to (or hold a
lock on) the mapping.  Otherwise, we've already removed the folio from the
mapping so it no longer pins the mapping and the mapping can be removed,
causing a use-after-free when accessing mapping->a_ops.

Follow the same pattern as __remove_mapping() and load the free_folio
function pointer before dropping the lock on the mapping.  That lets us
make filemap_free_folio() static as this was the only caller outside
filemap.c.

Link: https://lkml.kernel.org/r/20260413184314.3419945-1-willy@infradead.org
Fixes: 4a9e23159fd3 (mm/truncate: add folio_unmap_invalidate() helper)
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reported-by: Google Big Sleep <big-sleep-vuln-reports+bigsleep-501448199@google.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jan Kara <jack@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/filemap.c  |    3 ++-
 mm/internal.h |    1 -
 mm/truncate.c |    6 +++++-
 3 files changed, 7 insertions(+), 3 deletions(-)

--- a/mm/filemap.c~mm-call-free_folio-directly-in-folio_unmap_invalidate
+++ a/mm/filemap.c
@@ -228,7 +228,8 @@ void __filemap_remove_folio(struct folio
 	page_cache_delete(mapping, folio, shadow);
 }
 
-void filemap_free_folio(struct address_space *mapping, struct folio *folio)
+static void filemap_free_folio(const struct address_space *mapping,
+		struct folio *folio)
 {
 	void (*free_folio)(struct folio *);
 
--- a/mm/internal.h~mm-call-free_folio-directly-in-folio_unmap_invalidate
+++ a/mm/internal.h
@@ -540,7 +540,6 @@ unsigned find_lock_entries(struct addres
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
 unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
-void filemap_free_folio(struct address_space *mapping, struct folio *folio);
 int truncate_inode_folio(struct address_space *mapping, struct folio *folio);
 bool truncate_inode_partial_folio(struct folio *folio, loff_t start,
 		loff_t end);
--- a/mm/truncate.c~mm-call-free_folio-directly-in-folio_unmap_invalidate
+++ a/mm/truncate.c
@@ -622,6 +622,7 @@ static int folio_launder(struct address_
 int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
 			   gfp_t gfp)
 {
+	void (*free_folio)(struct folio *);
 	int ret;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
@@ -648,9 +649,12 @@ int folio_unmap_invalidate(struct addres
 	xa_unlock_irq(&mapping->i_pages);
 	if (mapping_shrinkable(mapping))
 		inode_lru_list_add(mapping->host);
+	free_folio = mapping->a_ops->free_folio;
 	spin_unlock(&mapping->host->i_lock);
 
-	filemap_free_folio(mapping, folio);
+	if (free_folio)
+		free_folio(folio);
+	folio_put_refs(folio, folio_nr_pages(folio));
 	return 1;
 failed:
 	xa_unlock_irq(&mapping->i_pages);
_

Patches currently in -mm which might be from willy@infradead.org are

mm-call-free_folio-directly-in-folio_unmap_invalidate.patch


