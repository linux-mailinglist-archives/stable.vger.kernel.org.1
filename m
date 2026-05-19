Return-Path: <stable+bounces-249588-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mISCCztnDGpXggUAu9opvQ
	(envelope-from <stable+bounces-249588-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 15:35:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E669457FC99
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 15:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2F7F3015856
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640A8348C65;
	Tue, 19 May 2026 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eau0cman"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AA0348C51;
	Tue, 19 May 2026 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197624; cv=none; b=MlcVZfBVHKZKUHXnWtrmUpkXGT1wNp8qMWgj0auYS2iFGnsJsSaNXlqfPx22dZuo9Bwz+P6Dg5f916ntK5V2h+tla3/q8u5dWnkA0DnwiQGlaLMvJz4OTqAMve4FHuLRqjIT/cSKpJpV0W8ZrER+9MJZYE9UMBG0W/qbDo19IF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197624; c=relaxed/simple;
	bh=JxQkTyZSRlzMs7ib8qBrrp+DMXE6y2eWvhI1wckhkbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YdA5RLfDGSJW5vWCyEnZszrVBPZftn6Q53x9deU571Z7GEo9V3c7n9C4a4f+JrxKsqdI+6sXD8HNvPC37AH+YWPb78gz9ucRzZietvuT5iWbkhCalSXp01qAe/J/gXxVUE6DITmS8xkrcgBuDEyKbD1RgPzZQWmUT0mMhGFUuik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eau0cman; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D31C2BCB3;
	Tue, 19 May 2026 13:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779197623;
	bh=JxQkTyZSRlzMs7ib8qBrrp+DMXE6y2eWvhI1wckhkbU=;
	h=From:To:Cc:Subject:Date:From;
	b=Eau0cmanZKHslnj0CVI8LxPTFGCh1FTLiuC+Lkq1wU6hXTEkwm3YjuIn13sBtWjTU
	 5k+RRgEs8l1OjQqtmCeVW6GFmcWX6zZs2+HnvOx4PEGYX259ZNIPI0FTwxEj8onqAj
	 +RXegkCMlEwSyn7oFbe6erQM01UBm2ucDcfDEV3jv0+Vxs4jFFBF53fBL7TOC8Haam
	 jeIPjJESRmjSJcflE3K6FL5vNeZ8Q63KLJ5B03EYRgXAhHoVgZmKLwfxU5yEOWbOSK
	 l9aAnt+zDwBdIG8b3mNwWnGUe9gWji6Qz0n3KOlgA2spnUYYs7J6kFWFu1S2rRvO3p
	 /wc8VgON+0C5Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] kho: fix order calculation for kho_unpreserve_pages()
Date: Tue, 19 May 2026 15:33:30 +0200
Message-ID: <20260519133332.2498092-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249588-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pratyush@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E669457FC99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

Commit 91e74fa8b1bc ("kho: make sure preservations do not span multiple
NUMA nodes") made sure preservations from kho_preserve_pages() do not
span multiple NUMA nodes. If they do, the order is reduced and tried
again.

The same logic was not implemented for kho_unpreserve_pages(). This can
result in unpreserve calculating a different order than preserve, and
thus not actually unpreserving the pages.

Fix this by moving the order calculation logic to
__kho_preserve_pages_order() and use it from both preserve and
unpreserve paths.

Move __kho_unpreserve() down to avoid having a forward declaration. Its
users are further down in the file anyway. Also, it results in grouping
for all the page-level preservation and unpreservation functions. This
unfortunately makes the diff hard to read, but the main change in
__kho_unpreserve() is to call __kho_preserve_pages_order() instead of
open-coding the order calculation.

Fixes: 91e74fa8b1bc ("kho: make sure preservations do not span multiple NUMA nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 56 +++++++++++++++++-------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 4fde8325c49f..11855e275397 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -357,20 +357,6 @@ int kho_radix_walk_tree(struct kho_radix_tree *tree,
 }
 EXPORT_SYMBOL_GPL(kho_radix_walk_tree);
 
-static void __kho_unpreserve(struct kho_radix_tree *tree,
-			     unsigned long pfn, unsigned long end_pfn)
-{
-	unsigned int order;
-
-	while (pfn < end_pfn) {
-		order = min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
-
-		kho_radix_del_page(tree, pfn, order);
-
-		pfn += 1 << order;
-	}
-}
-
 /* For physically contiguous 0-order pages. */
 static void kho_init_pages(struct page *page, unsigned long nr_pages)
 {
@@ -855,6 +841,37 @@ void kho_unpreserve_folio(struct folio *folio)
 }
 EXPORT_SYMBOL_GPL(kho_unpreserve_folio);
 
+static unsigned int __kho_preserve_pages_order(unsigned long start_pfn,
+					       unsigned long end_pfn)
+{
+	unsigned int order = min(count_trailing_zeros(start_pfn),
+				 ilog2(end_pfn - start_pfn));
+
+	/*
+	 * Make sure all the pages in a single preservation are in the same NUMA
+	 * node. The restore machinery can not cope with a preservation spanning
+	 * multiple NUMA nodes.
+	 */
+	while (pfn_to_nid(start_pfn) != pfn_to_nid(start_pfn + (1UL << order) - 1))
+		order--;
+
+	return order;
+}
+
+static void __kho_unpreserve(struct kho_radix_tree *tree,
+			     unsigned long pfn, unsigned long end_pfn)
+{
+	unsigned int order;
+
+	while (pfn < end_pfn) {
+		order = __kho_preserve_pages_order(pfn, end_pfn);
+
+		kho_radix_del_page(tree, pfn, order);
+
+		pfn += 1 << order;
+	}
+}
+
 /**
  * kho_preserve_pages - preserve contiguous pages across kexec
  * @page: first page in the list.
@@ -880,16 +897,7 @@ int kho_preserve_pages(struct page *page, unsigned long nr_pages)
 	}
 
 	while (pfn < end_pfn) {
-		unsigned int order =
-			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
-
-		/*
-		 * Make sure all the pages in a single preservation are in the
-		 * same NUMA node. The restore machinery can not cope with a
-		 * preservation spanning multiple NUMA nodes.
-		 */
-		while (pfn_to_nid(pfn) != pfn_to_nid(pfn + (1UL << order) - 1))
-			order--;
+		unsigned int order = __kho_preserve_pages_order(pfn, end_pfn);
 
 		err = kho_radix_add_page(tree, pfn, order);
 		if (err) {

base-commit: b1378127003b61930ce30064328640503ad3ef6d
-- 
2.54.0.563.g4f69b47b94-goog


