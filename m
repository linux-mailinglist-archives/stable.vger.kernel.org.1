Return-Path: <stable+bounces-242626-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UcqkBJyP9mmvWQIAu9opvQ
	(envelope-from <stable+bounces-242626-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 01:58:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E96AE4B3B40
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 01:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E187B3001FBC
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 23:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32770287257;
	Sat,  2 May 2026 23:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDQ6Hk/o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA90E5474F
	for <stable@vger.kernel.org>; Sat,  2 May 2026 23:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777766293; cv=none; b=Clp3kKA5UaR0qffp/xOK46wegpQhAd+BwEpIMgJR/5b4CoIZeTHKTO0mBw8mGGNxVYhEmWlk6BFkGQGbpISJuh2GKvIG1qwWhGNPmD5EAmRcZjK9jx59Iszag+AFZ/VuTag7f6TLuanHQOJQlHOH92G/kj23M2d5M6pyaJiXAWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777766293; c=relaxed/simple;
	bh=pc/cW4p0pN2S1WiPQVHNPjA770AiyScG/MswEPkqoeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7cOnhxcop9/jcX8GaTCQ6Xh++TYTXgelbJSSOM6IImSoY+8FCt+IuaAoZelS5HCmhxKDKSQIoeKJ1TMe1hCwS/Nri+2iEbDxFCenyg4A9rfKFvpEvTT5mqjhiCrDo/3EdXzZE6WSo7TvZNNGYqTOGp/u8KfIdCLOY0TbM0XKr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDQ6Hk/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD91C19425;
	Sat,  2 May 2026 23:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777766292;
	bh=pc/cW4p0pN2S1WiPQVHNPjA770AiyScG/MswEPkqoeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CDQ6Hk/oD4oS7i/2Qt1u4mfmyry2hsNg3W3wBjqyMJwEbdNd0kzOvEHn2yLLjFjO6
	 LUWBTbruti6Jpvk+06GA7Xj0+4Z9zAItifYcuo2b0WFu7/oZeBQrN7meSpyI2udN4I
	 upjkidsHwTkbpXtgRt4ZHSWWDYM44PSik3q4MZg3y+mSvmPLS0PdZHi4U5jRWu6k0G
	 /9Q6MLB3EgBWDS/3RjhHCytcCazL6FhIWdIw74ke3L913xcqivD+lkgDVWF16yRI0+
	 s+mH1hRk5vnqQ+tZhNbjkgWsd9nCCrphqIEaE62o+vG5e9p/0rM1fVsmhJSRzATslX
	 IyzbJOkuCKy4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Naman Jain <namjain@linux.microsoft.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] block: relax pgmap check in bio_add_page for compatible zone device pages
Date: Sat,  2 May 2026 19:57:59 -0400
Message-ID: <20260502235759.921576-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050150-reheat-spinout-eedf@gregkh>
References: <2026050150-reheat-spinout-eedf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E96AE4B3B40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242626-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,kernel.dk:email]

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
index 15e444b2fcc12..dc6a9b0fab369 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -134,6 +134,8 @@ int bio_integrity_add_page(struct bio *bio, struct page *page,
 		struct bio_vec *bv = &bip->bip_vec[bip->bip_vcnt - 1];
 		bool same_page = false;
 
+		if (!zone_device_pages_compatible(bv->bv_page, page))
+			return 0;
 		if (bvec_try_merge_hw_page(q, bv, page, len, offset,
 					   &same_page)) {
 			bip->bip_iter.bi_size += len;
diff --git a/block/bio.c b/block/bio.c
index b197abbaebc46..14aefb1905454 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1098,11 +1098,15 @@ int bio_add_page(struct bio *bio, struct page *page,
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
index 67915b04b3c17..676c91c19940d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -102,6 +102,25 @@ static inline bool biovec_phys_mergeable(struct request_queue *q,
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


