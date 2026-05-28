Return-Path: <stable+bounces-256191-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QD4rM6qqGGoomAgAu9opvQ
	(envelope-from <stable+bounces-256191-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:50:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE005F9B02
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E74F230BAECC
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5A83346BE;
	Thu, 28 May 2026 20:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EZ3y2cwR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6372F1FEC;
	Thu, 28 May 2026 20:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001010; cv=none; b=jlnHCilPcqggfRR2cuwfuEMgmxeXHN0nCC1dPyHGwm9rGuukak6EPZkdmwrpl2sFXma7wbsbsOIl4r79zE3cs/W7t1P8V8poPlSicz9R6243wiSpwR4vYaYf6sbKtlkbIsivT1HRAmzaa7MN8jXuZTYE1WQb1ABBGiHZQW3Hd6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001010; c=relaxed/simple;
	bh=J4hmnCncWnM4P/fTbW57lJ+cUDQKv0OdXPHek8jZtks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYLt56TCaIABfRnFc4B2TZc0ck2Ax3V/w61h3IDbN71PMl4XZZ2k0XFFLpbbAiVBq1aycYEys+tTUgKYvIHOhSdeqSFKkO9QrJvKoSJn13OQCUcgzJN+foLZM5lOUHwa5pmwk5phsgusgXJaveoCJqjB9+ws222J39oDibMTEuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EZ3y2cwR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02051F000E9;
	Thu, 28 May 2026 20:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001009;
	bh=4LSMAmVzI0yOuef46q2xcsXwWHhw4tsoZODr5r179JA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EZ3y2cwRLgdzcapOaIrkujUN0MlX2iac511OvolvoK93PSynFiSjrs/m8aqN68hOZ
	 zr0OCPYTcgR4ls3YDSSKmqHEerJRzA52gjLzcrkb5FdoFgyNGvklFb/7MFGkn6M/KT
	 voLru3LQoMH8yglT7tg2Xgp/mTTofBB+KYCVAM28=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Casey Chen <cachen@purestorage.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 211/272] block: recompute nr_integrity_segments in blk_insert_cloned_request
Date: Thu, 28 May 2026 21:49:45 +0200
Message-ID: <20260528194635.133506341@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256191-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,kernel.dk:email,purestorage.com:email]
X-Rspamd-Queue-Id: 9DE005F9B02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Casey Chen <cachen@purestorage.com>

[ Upstream commit 2c6e6a18a37b905cb584eb0dda3ae482162a81ca ]

blk_insert_cloned_request() already recomputes nr_phys_segments
against the bottom queue, because "the queue settings related to
segment counting may differ from the original queue." The exact same
reasoning applies to integrity segments: a stacked driver's underlying
queue can have tighter virt_boundary_mask, seg_boundary_mask, or
max_segment_size than the top queue, in which case
blk_rq_count_integrity_sg() against the bottom queue produces a
different count than the cached rq->nr_integrity_segments inherited
from the source request by blk_rq_prep_clone().

When the cached count is lower than the bottom queue's actual count,
blk_rq_map_integrity_sg() trips

	BUG_ON(segments > rq->nr_integrity_segments);

on dispatch. The same families of stacked setups that motivated the
existing nr_phys_segments recompute -- dm-multipath fanning out to
nvme-rdma in particular -- can produce this.

Mirror the nr_phys_segments handling: when the request carries
integrity, recompute nr_integrity_segments against the bottom queue
and reject the request if it exceeds the bottom queue's
max_integrity_segments. blk_rq_count_integrity_sg() and
queue_max_integrity_segments() are both already available via
<linux/blk-integrity.h>, which blk-mq.c includes.

This closes a latent gap in the stacking contract and brings the
integrity-segment accounting in line with the existing
phys-segment accounting.

Fixes: 76c313f658d2 ("blk-integrity: improved sg segment mapping")
Signed-off-by: Casey Chen <cachen@purestorage.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://patch.msgid.link/20260511212230.27511-1-cachen@purestorage.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1891863dcba17..5bfaa8e4b9cf6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3215,6 +3215,25 @@ blk_status_t blk_insert_cloned_request(struct request *rq)
 		return BLK_STS_IOERR;
 	}
 
+	/*
+	 * Integrity segment counting depends on the same queue limits
+	 * (virt_boundary_mask, seg_boundary_mask, max_segment_size) that
+	 * vary across stacked queues, so recompute against the bottom
+	 * queue just like nr_phys_segments above.
+	 */
+	if (blk_integrity_rq(rq) && rq->bio) {
+		unsigned short max_int_segs = queue_max_integrity_segments(q);
+
+		rq->nr_integrity_segments =
+			blk_rq_count_integrity_sg(rq->q, rq->bio);
+		if (rq->nr_integrity_segments > max_int_segs) {
+			printk(KERN_ERR "%s: over max integrity segments limit. (%u > %u)\n",
+				__func__, rq->nr_integrity_segments,
+				max_int_segs);
+			return BLK_STS_IOERR;
+		}
+	}
+
 	if (q->disk && should_fail_request(q->disk->part0, blk_rq_bytes(rq)))
 		return BLK_STS_IOERR;
 
-- 
2.53.0




