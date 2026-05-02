Return-Path: <stable+bounces-242624-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMW2IA2J9mkUWAIAu9opvQ
	(envelope-from <stable+bounces-242624-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 01:30:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F03E64B3A60
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 01:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2F4C3008514
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 23:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF962F25F5;
	Sat,  2 May 2026 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1myPiXR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F93C3128B2
	for <stable@vger.kernel.org>; Sat,  2 May 2026 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777764616; cv=none; b=fHAH23LCAHsfNqESK2aj7iBoOb3iJFrGRP9wuFrpBUXMPxuRgbizQmzMaNWflDLtZGWlsAFQm2TCL5QrOId8QI33GPvC+Pbmg5ghF7/ZOHjRgQCb1HhAoPSZ4w1FA+KRbtoEoqyTyXrU+UES0SgNZ+KY+T4yWK2QCmgE3QR6a2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777764616; c=relaxed/simple;
	bh=03cksnxuqjHRMr787oTx/fQYgc8VBb8lCDrrKxpzS9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohmlRM3+nv1HJ5voCM2bD5c/4+5XF9hpnxyS6HmNpFNqmg0GI1H6UqgWCJCoyJE9eq78X/LrrDxmUzIWwG/8nBCZN0o+BjkcbyAQ8bYyvBLFvuh224mBOx1fZheX5Wa7wv/3wKAtBoz4XvWyQdyMvr1ql03cES8P0+j43ZCuePc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1myPiXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53A6C19425;
	Sat,  2 May 2026 23:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777764616;
	bh=03cksnxuqjHRMr787oTx/fQYgc8VBb8lCDrrKxpzS9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D1myPiXRxOY/s3FqhNoCEijEt/tA7BfB60tXD/y6983PuEjwij+DC7nYBCkopXDt/
	 7NreavGf2jY6vwNgPl5/5M6tqTbcPSuUYqgD9EAR5PdvJEevdlTgs40VqDDCdgItf3
	 hM0XE6IGSd6JSaWhsRjhTwuTXtoQOCgwYoPI4MjhY+/Y91iOmdimhW4SXxBep51DVg
	 C5UfiHMpIzFgCAgSaXMGjBxjPsaE22qYuvhL3+s9D85Sb33FSQcKpro/InHK2BRv63
	 OZR3wHc7GZ5YajDMCnKZTCqPPAFEaoKCcQZZeRhedDwXnhHoeu5oasl9jdzJh2djJr
	 coDvNoVdwZXqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Naman Jain <namjain@linux.microsoft.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] block: relax pgmap check in bio_add_page for compatible zone device pages
Date: Sat,  2 May 2026 19:30:00 -0400
Message-ID: <20260502233000.914887-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050149-moonlike-issue-7246@gregkh>
References: <2026050149-moonlike-issue-7246@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F03E64B3A60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242624-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:email]

From: Naman Jain <namjain@linux.microsoft.com>

[ Upstream commit 41c665aae2b5dbecddddcc8ace344caf630cc7a4 ]

bio_add_page() and bio_integrity_add_page() reject pages from different
dev_pagemaps entirely, returning 0 even when those pages have compatible
DMA mapping requirements. This forces callers to start a new bio when
buffers span pgmap boundaries, even though the pages could safely coexist
as separate bvec entries.

This matters for guests where memory is registered through
devm_memremap_pages() with MEMORY_DEVICE_GENERIC in multiple calls,
creating separate dev_pagemaps for each chunk. When a direct I/O buffer
spans two such chunks, bio_add_page() rejects the second page, forcing an
unnecessary bio split or I/O failure.

Introduce zone_device_pages_compatible() in blk.h to check whether two
pages can coexist in the same bio as separate bvec entries. The block DMA
iterator (blk_dma_map_iter_start) caches the P2PDMA mapping state from the
first segment and applies it to all others, so P2PDMA pages from different
pgmaps must not be mixed, and neither must P2PDMA and non-P2PDMA pages.
All other combinations (MEMORY_DEVICE_GENERIC pages from different pgmaps,
or MEMORY_DEVICE_GENERIC with normal RAM) use the same dma_map_phys path
and are safe.

Replace the blanket zone_device_pages_have_same_pgmap() rejection with
zone_device_pages_compatible(), while keeping
zone_device_pages_have_same_pgmap() as a merge guard.
Pages from different pgmaps can be added as separate bvec entries but
must not be coalesced into the same segment, as that would make
it impossible to recover the correct pgmap via page_pgmap().

Fixes: 49580e690755 ("block: add check when merging zone device pages")
Cc: stable@vger.kernel.org
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://patch.msgid.link/20260410153414.4159050-3-namjain@linux.microsoft.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ restructured combined `if` into explicit `bv` block ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio-integrity.c |  2 ++
 block/bio.c           | 14 +++++++++-----
 block/blk.h           | 19 +++++++++++++++++++
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 456026c4a3c96..6641ecbf69678 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -167,6 +167,8 @@ int bio_integrity_add_page(struct bio *bio, struct page *page,
 		struct bio_vec *bv = &bip->bip_vec[bip->bip_vcnt - 1];
 		bool same_page = false;
 
+		if (!zone_device_pages_compatible(bv->bv_page, page))
+			return 0;
 		if (bvec_try_merge_hw_page(q, bv, page, len, offset,
 					   &same_page)) {
 			bip->bip_iter.bi_size += len;
diff --git a/block/bio.c b/block/bio.c
index b919f3fa2f2d4..a081e2ddf9cf8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1155,11 +1155,15 @@ int bio_add_page(struct bio *bio, struct page *page,
 	if (bio->bi_iter.bi_size > UINT_MAX - len)
 		return 0;
 
-	if (bio->bi_vcnt > 0 &&
-	    bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
-				page, len, offset, &same_page)) {
-		bio->bi_iter.bi_size += len;
-		return len;
+	if (bio->bi_vcnt > 0) {
+		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
+
+		if (!zone_device_pages_compatible(bv->bv_page, page))
+			return 0;
+		if (bvec_try_merge_page(bv, page, len, offset, &same_page)) {
+			bio->bi_iter.bi_size += len;
+			return len;
+		}
 	}
 
 	if (bio->bi_vcnt >= bio->bi_max_vecs)
diff --git a/block/blk.h b/block/blk.h
index e7d7c5c636524..8af4f7101c8a8 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -124,6 +124,25 @@ static inline bool biovec_phys_mergeable(struct request_queue *q,
 	return true;
 }
 
+/*
+ * Check if two pages from potentially different zone device pgmaps can
+ * coexist as separate bvec entries in the same bio.
+ *
+ * The block DMA iterator (blk_dma_map_iter_start) caches the P2PDMA mapping
+ * state from the first segment and applies it to all subsequent segments, so
+ * P2PDMA pages from different pgmaps must not be mixed in the same bio.
+ *
+ * Other zone device types (FS_DAX, GENERIC) use the same dma_map_phys() path
+ * as normal RAM.  PRIVATE and COHERENT pages never appear in bios.
+ */
+static inline bool zone_device_pages_compatible(const struct page *a,
+						const struct page *b)
+{
+	if (is_pci_p2pdma_page(a) || is_pci_p2pdma_page(b))
+		return zone_device_pages_have_same_pgmap(a, b);
+	return true;
+}
+
 static inline bool __bvec_gap_to_prev(const struct queue_limits *lim,
 		struct bio_vec *bprv, unsigned int offset)
 {
-- 
2.53.0


