Return-Path: <stable+bounces-244902-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IP2GbWq/mkyuwAAu9opvQ
	(envelope-from <stable+bounces-244902-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 05:32:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2F84FDE17
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 05:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE4C1301D4E1
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 03:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D322701C4;
	Sat,  9 May 2026 03:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPB9YZ4W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CE626F2AF
	for <stable@vger.kernel.org>; Sat,  9 May 2026 03:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778297522; cv=none; b=MbtT90Uq4ZzXjKERSjEzcu7SMa691PyDc2s290+tFE9UGffc2GTfLyxEIsVzhiKvvNaYdFSsrRyjyiOWgG/vtf1M0pCbAeKOnCuIyhhGTLfmeQaeQeTsxhCUKE5MxyT5tKGM3CiVYz4IB5QwdXBslbtD/zJacXH4ERgoP+ja+e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778297522; c=relaxed/simple;
	bh=DhF2SyPyoEYDuSiXmm61gYptSs2pqgs9Fd7EHbEC0UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UznRi4V123drCsaxqIvdIJdJY7yO6E3Gh4hiocYGrPhRAGSeM8DME11xCVwNvgvQbyLDxY4XvN6q/oa2Lk9EP0ivUBQSR2oRqdsi9KrmU7k2yw/mn21MvBGck+engsi8GciTvaGmpwxZYR7M+2lyAyH6yfeAUK46RHHjSwMusks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPB9YZ4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DAEC2BCB8;
	Sat,  9 May 2026 03:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778297522;
	bh=DhF2SyPyoEYDuSiXmm61gYptSs2pqgs9Fd7EHbEC0UQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DPB9YZ4Wc/4+40abeARib1tNdgH2lrhMWCRnSP5/DS4VXS4DFuhfE4HryhNjZB2S1
	 mA5g93K6gXPn0UYIuptP7pfR3La4pIO3H6SArGxjMLqtddxx46pPETmHbg2XqX7PrO
	 JLgndmj4LTvGEdGyLrwjSpECy/S9CuxVyn3GHHuI4w/dEsfwd2MHLG/XKwiNHvdhsS
	 tbDNb6INcx9/+U5JcasJ/1E5YP3pBrSfo5i8FQYjEERq3WCYYywq/jA1jxASoWYttn
	 uTkfI09YsRfu7jMUWcRYUX+mdf7l/NifKd1AL082R94T8gCuK3bn1gSaREctTPAG//
	 qDFUvX9JB0oJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] erofs: tidy up z_erofs_lz4_handle_overlap()
Date: Fri,  8 May 2026 23:31:58 -0400
Message-ID: <20260509033159.3082967-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509033159.3082967-1-sashal@kernel.org>
References: <2026050414-copied-panther-40d1@gregkh>
 <20260509033159.3082967-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DF2F84FDE17
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
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-244902-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
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
index 04614c6ee9ed3..7415949a80b32 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -112,44 +112,58 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_decompress_req *rq,
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
@@ -157,20 +171,13 @@ static void *z_erofs_lz4_handle_overlap(struct z_erofs_decompress_req *rq,
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


