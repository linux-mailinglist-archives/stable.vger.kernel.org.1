Return-Path: <stable+bounces-239249-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALCnAsxY5mlQvAEAu9opvQ
	(envelope-from <stable+bounces-239249-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:48:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E194300A8
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 50E0734A37ED
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE8B30EF90;
	Mon, 20 Apr 2026 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ccrfN8Jt"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5082F90E0
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776696829; cv=none; b=M+ypHZ5nmcIuIC1/VY52HWYe8BlXXeQJU8XxsVUWGC10B1o5V1kwL29BP1L1+eF7GKSiKM1Oq7V9DehGo+3XtQi19zrYt3EVmNBrCxz3BDBkHgVq05A/5gjTl6eUrMkRfFZ4vV13SdkC0bicatqQ9ea+QOycLn3kB3sFCCHJkYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776696829; c=relaxed/simple;
	bh=51LSZk/sBr8REOokOifLnp3bhLmu1TaF7ODI6e62FAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=draadfuv+eGYntWzbdGsise8+wWMSmJfKF1QCBFg4txRAh6oo0XeWAZdGRjvhMIJKX1doMhodzCP2XHVFT6uVreE8PKlGvFEEAB9iPVp8XnWKIFo3+hqDSJKX5PQM6OIjNI4uUprW+0Ddcn2X6eK2js110F96hLLhuKTW5wAFoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ccrfN8Jt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=1xi0l/w05GB884QRRT58/1iLywMbuoXQtqHfaOLTDwM=; b=ccrfN8JtnpwexnvQgyA4X5b6jt
	rPNhm6B3HDHcZVSu581S3PsGmU38XvqPLZAprZXpPUV1tl14m1ehmsaXr7VL6KCMVU0oFMYFYspGc
	DiglfIlNnkzgqFz5Mckd8qDmMcj/NJAvJTqHgNEYq88elHKw9KSFuj46nxAHMW+76ME4lw9KvMwzn
	udopoEZyg7SQjB/OBvCo+fZnXxKwJWwSWJDkSwRqcTqjBaImi4PdMbQyfNk65vVQn3d7Ys8+yihCg
	40fcIFuuPHWrhBZS6/BSyCaqfNSVABvtvBSm6sUtCQoqKSRP86tCU7RURuvqXKBjfdanVk9UC8Yz0
	kB23rK5g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEq0P-00000008aWA-20vd;
	Mon, 20 Apr 2026 14:53:45 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Google Big Sleep <big-sleep-vuln-reports+bigsleep-501448199@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y] mm: call ->free_folio() directly in folio_unmap_invalidate()
Date: Mon, 20 Apr 2026 15:53:43 +0100
Message-ID: <20260420145343.2046992-1-willy@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026042002-idealness-evade-7213@gregkh>
References: <2026042002-idealness-evade-7213@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-239249-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable,bigsleep-501448199];
	NEURAL_HAM(-0.00)[-0.976];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,infradead.org:email,infradead.org:dkim,infradead.org:mid,linux-foundation.org:email,suse.cz:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06E194300A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We can only call filemap_free_folio() if we have a reference to (or hold a
lock on) the mapping.  Otherwise, we've already removed the folio from the
mapping so it no longer pins the mapping and the mapping can be removed,
causing a use-after-free when accessing mapping->a_ops.

Follow the same pattern as __remove_mapping() and load the free_folio
function pointer before dropping the lock on the mapping.  That lets us
make filemap_free_folio() static as this was the only caller outside
filemap.c.

Link: https://lore.kernel.org/20260413184314.3419945-1-willy@infradead.org
Fixes: fb7d3bc41493 ("mm/filemap: drop streaming/uncached pages when writeback completes")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reported-by: Google Big Sleep <big-sleep-vuln-reports+bigsleep-501448199@google.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jan Kara <jack@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 615d9bb2ccad42f9e21d837431e401db2e471195)
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c  | 3 ++-
 mm/internal.h | 1 -
 mm/truncate.c | 6 +++++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d8d9c0f0beb6..76bbfa69aca0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -233,7 +233,8 @@ void __filemap_remove_folio(struct folio *folio, void *shadow)
 	page_cache_delete(mapping, folio, shadow);
 }
 
-void filemap_free_folio(struct address_space *mapping, struct folio *folio)
+static void filemap_free_folio(const struct address_space *mapping,
+		struct folio *folio)
 {
 	void (*free_folio)(struct folio *);
 	int refs = 1;
diff --git a/mm/internal.h b/mm/internal.h
index 9e0577413087..f046099d8eff 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -401,7 +401,6 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
 unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
-void filemap_free_folio(struct address_space *mapping, struct folio *folio);
 int truncate_inode_folio(struct address_space *mapping, struct folio *folio);
 bool truncate_inode_partial_folio(struct folio *folio, loff_t start,
 		loff_t end);
diff --git a/mm/truncate.c b/mm/truncate.c
index fb5c20b57bd4..6bbe22ae3ab8 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -574,6 +574,7 @@ EXPORT_SYMBOL(invalidate_mapping_pages);
 static int invalidate_complete_folio2(struct address_space *mapping,
 					struct folio *folio)
 {
+	void (*free_folio)(struct folio *);
 	if (folio->mapping != mapping)
 		return 0;
 
@@ -590,9 +591,12 @@ static int invalidate_complete_folio2(struct address_space *mapping,
 	xa_unlock_irq(&mapping->i_pages);
 	if (mapping_shrinkable(mapping))
 		inode_add_lru(mapping->host);
+	free_folio = mapping->a_ops->free_folio;
 	spin_unlock(&mapping->host->i_lock);
 
-	filemap_free_folio(mapping, folio);
+	if (free_folio)
+		free_folio(folio);
+	folio_put_refs(folio, folio_nr_pages(folio));
 	return 1;
 failed:
 	xa_unlock_irq(&mapping->i_pages);
-- 
2.47.3


