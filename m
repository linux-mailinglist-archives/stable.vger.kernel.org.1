Return-Path: <stable+bounces-244896-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM5VA4Wo/mm1ugAAu9opvQ
	(envelope-from <stable+bounces-244896-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 05:22:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 753094FDDA8
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 05:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A5A13019828
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 03:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EC73603D3;
	Sat,  9 May 2026 03:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEWeaxX2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9874B2628D
	for <stable@vger.kernel.org>; Sat,  9 May 2026 03:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778296952; cv=none; b=CGmGQSba4fwohHki2l5xbJwx4h7NdPgCsRJ5pb089xYrrXp4duMnfRd7NbZwC/yjTiCgS6zdk2wq0jQyTVhZRK2YN4Q1kXcIB00K9QSUA3dAXIy8zzO/19g04bJnnkN6VpxnBnH/dKyPJIigGwVPpQ6mHJ15W9VI3f5sDEpLEwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778296952; c=relaxed/simple;
	bh=xYC5APhpuXuJMhAQGgy1Ki95P4Mp/kkir11f7iCKv1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=noZnGoSmY+WzD4bTYrJwWQlMpFfgtlm+rcHnB5oBjoTUwGC8Q1JXavgYeT3XMlLg9ZHlfPeeZB3z07udlFm2okITLt/WFjKA0dsS2i1nsjcTQg1w2lpzLd6GH1hHxMxfi9fY3f1/DJQbCGlHfgHZnPep2BXfxxZDSkmnuBBUK34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEWeaxX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE87C2BCB0;
	Sat,  9 May 2026 03:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778296951;
	bh=xYC5APhpuXuJMhAQGgy1Ki95P4Mp/kkir11f7iCKv1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CEWeaxX2XCHeZRH9MrxlcIUywJYdLdilNpZn144pv7gDqN2sS7UX7OqVV82d2NBb3
	 +jtIusk+3/PfDH/u0tYEkuR3223NwtKeyz//LSONozCYS8WVa/qc+9tYVy952wPPcZ
	 YapmpCRgmMAJwqNpCRjYWpz4T+YP3c7ttpfPPGyBLb9OW0yhXwzWt1EYSKOUfQ4ecg
	 7vjzKGV9F8ruPrvv8nXaqPU2M6oYnQZqjBdDabX3WT0FJgPrtVMoEksOoDw6TpgiDL
	 vVDQRaJdLRGo00Zatc82mp4CiQWHEFB2cW6jdDoOPAA3CWODEP4LX4niGg5eHKpVTi
	 Uu3E64zdnWEaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] erofs: tidy up z_erofs_lz4_handle_overlap()
Date: Fri,  8 May 2026 23:22:28 -0400
Message-ID: <20260509032229.3064816-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050413-commute-discourse-5f47@gregkh>
References: <2026050413-commute-discourse-5f47@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 753094FDDA8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244896-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit 9ae77198d4815c63fc8ebacc659c71d150d1e51b ]

 - Add some useful comments to explain inplace I/Os and decompression;

 - Rearrange the code to get rid of one unnecessary goto.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Stable-dep-of: 21e161de2dc6 ("erofs: fix unsigned underflow in z_erofs_lz4_handle_overlap()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/decompressor.c | 85 ++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 39 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 354762c9723f9..2f4cef67cf640 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -105,44 +105,58 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_decompress_req *rq,
 	return kaddr ? 1 : 0;
 }
 
-static void *z_erofs_lz4_handle_overlap(struct z_erofs_decompress_req *rq,
+static void *z_erofs_lz4_handle_overlap(const struct z_erofs_decompress_req *rq,
 			void *inpage, void *out, unsigned int *inputmargin,
 			int *maptype, bool may_inplace)
 {
-	unsigned int oend, omargin, total, i;
+	unsigned int oend, omargin, cnt, i;
 	struct page **in;
-	void *src, *tmp;
-
-	if (rq->inplace_io) {
-		oend = rq->pageofs_out + rq->outputsize;
-		omargin = PAGE_ALIGN(oend) - oend;
-		if (rq->partial_decoding || !may_inplace ||
-		    omargin < LZ4_DECOMPRESS_INPLACE_MARGIN(rq->inputsize))
-			goto docopy;
+	void *src;
 
+	/*
+	 * If in-place I/O isn't used, for example, the bounce compressed cache
+	 * can hold data for incomplete read requests. Just map the compressed
+	 * buffer as well and decompress directly.
+	 */
+	if (!rq->inplace_io) {
+		if (rq->inpages <= 1) {
+			*maptype = 0;
+			return inpage;
+		}
+		kunmap_local(inpage);
+		src = erofs_vm_map_ram(rq->in, rq->inpages);
+		if (!src)
+			return ERR_PTR(-ENOMEM);
+		*maptype = 1;
+		return src;
+	}
+	/*
+	 * Then, deal with in-place I/Os. The reasons why in-place I/O is useful
+	 * are: (1) It minimizes memory footprint during the I/O submission,
+	 * which is useful for slow storage (including network devices and
+	 * low-end HDDs/eMMCs) but with a lot inflight I/Os; (2) If in-place
+	 * decompression can also be applied, it will reuse the unique buffer so
+	 * that no extra CPU D-cache is polluted with temporary compressed data
+	 * for extreme performance.
+	 */
+	oend = rq->pageofs_out + rq->outputsize;
+	omargin = PAGE_ALIGN(oend) - oend;
+	if (!rq->partial_decoding && may_inplace &&
+	    omargin >= LZ4_DECOMPRESS_INPLACE_MARGIN(rq->inputsize)) {
 		for (i = 0; i < rq->inpages; ++i)
 			if (rq->out[rq->outpages - rq->inpages + i] !=
 			    rq->in[i])
-				goto docopy;
-		kunmap_local(inpage);
-		*maptype = 3;
-		return out + ((rq->outpages - rq->inpages) << PAGE_SHIFT);
-	}
-
-	if (rq->inpages <= 1) {
-		*maptype = 0;
-		return inpage;
+				break;
+		if (i >= rq->inpages) {
+			kunmap_local(inpage);
+			*maptype = 3;
+			return out + ((rq->outpages - rq->inpages) << PAGE_SHIFT);
+		}
 	}
-	kunmap_local(inpage);
-	src = erofs_vm_map_ram(rq->in, rq->inpages);
-	if (!src)
-		return ERR_PTR(-ENOMEM);
-	*maptype = 1;
-	return src;
-
-docopy:
-	/* Or copy compressed data which can be overlapped to per-CPU buffer */
-	in = rq->in;
+	/*
+	 * If in-place decompression can't be applied, copy compressed data that
+	 * may potentially overlap during decompression to a per-CPU buffer.
+	 */
 	src = z_erofs_get_gbuf(rq->inpages);
 	if (!src) {
 		DBG_BUGON(1);
@@ -150,20 +164,13 @@ static void *z_erofs_lz4_handle_overlap(struct z_erofs_decompress_req *rq,
 		return ERR_PTR(-EFAULT);
 	}
 
-	tmp = src;
-	total = rq->inputsize;
-	while (total) {
-		unsigned int page_copycnt =
-			min_t(unsigned int, total, PAGE_SIZE - *inputmargin);
-
+	for (i = 0, in = rq->in; i < rq->inputsize; i += cnt, ++in) {
+		cnt = min_t(u32, rq->inputsize - i, PAGE_SIZE - *inputmargin);
 		if (!inpage)
 			inpage = kmap_local_page(*in);
-		memcpy(tmp, inpage + *inputmargin, page_copycnt);
+		memcpy(src + i, inpage + *inputmargin, cnt);
 		kunmap_local(inpage);
 		inpage = NULL;
-		tmp += page_copycnt;
-		total -= page_copycnt;
-		++in;
 		*inputmargin = 0;
 	}
 	*maptype = 2;
-- 
2.53.0


