Return-Path: <stable+bounces-220165-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGLCDRkto2me+AQAu9opvQ
	(envelope-from <stable+bounces-220165-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:59:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A41961C54E0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31E2831E8749
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519064968FD;
	Sat, 28 Feb 2026 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdKLnf89"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136604968F6;
	Sat, 28 Feb 2026 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300073; cv=none; b=k9NV819wTEOCQvPOEacDaYJgHS8RL9ERg3QHFUMGRM08TiPIzvx6RkwnFy5qILuywfpefXl+rkwNXHdir6Bs5rmzi8X+2qKxi+tsyAK2/ERkqffUmLmS3GzXsjH9zJEtVOy6Mr1ke1GWwEI6vc+ZaRn2D69/t4KRmr4koFbfQB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300073; c=relaxed/simple;
	bh=UMjfOwNikfLmdobeqAcJ09rP1M4uJMBjOepfIEYUQSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTMNK/kBa/SYzMw7kycdUvU+0fp491+OkqtgUV3WJ+YfHfpo2+xlEnGqcldiUIGJl4k0brzMQPm9DPL2Z1QDC2ev1+5LPisxMqB1k/emDEkFTyInt/+NgwCAtQWtsHDGy2Q2g8sJlS/5yvDfj6psrrCrm7ONwdTcWpSVFvIivN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdKLnf89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298F0C19423;
	Sat, 28 Feb 2026 17:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300072;
	bh=UMjfOwNikfLmdobeqAcJ09rP1M4uJMBjOepfIEYUQSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tdKLnf89/dVryuSAIsdjMXBjar0icx+LHS8h7jZOpZ+3ws0myiXfhr10h8lUCtO5w
	 Ca83YJUW/YCfg+iPtLwt8fwKg0SbnvD+qUZXxeG10/vkhUqNFsAn7MUgXCJTuRkZ0I
	 W8Ec6/1fYeGzn95ErcUvqnu9tBPizFgXpJheiLRz0b2GHMdkE04l6z5LE46j2fVFwX
	 f9LBUJAgXZUiiADNjDQGUOCLMEVtpoR0utFJ/nk/aAttEulgIwY6xOOXAwNaDNcWaQ
	 8/4HkBIUBpTDz6xJh838o8xrIo5YuBwhd32Shx5/pdPpiMivgnv+E8bF2xyZukyaga
	 BoCqw4A/dhiEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yu Kuai <yukuai@fnnas.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Hannes Reinecke <hare@suse.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 087/844] blk-mq-sched: unify elevators checking for async requests
Date: Sat, 28 Feb 2026 12:20:00 -0500
Message-ID: <20260228173244.1509663-88-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220165-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,suse.de:email,fnnas.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A41961C54E0
X-Rspamd-Action: no action

From: Yu Kuai <yukuai@fnnas.com>

[ Upstream commit 1db61b0afdd7e8aa9289c423fdff002603b520b5 ]

bfq and mq-deadline consider sync writes as async requests and only
reserve tags for sync reads by async_depth, however, kyber doesn't
consider sync writes as async requests for now.

Consider the case there are lots of dirty pages, and user use fsync to
flush dirty pages. In this case sched_tags can be exhausted by sync writes
and sync reads can stuck waiting for tag. Hence let kyber follow what
mq-deadline and bfq did, and unify async requests checking for all
elevators.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bfq-iosched.c   | 2 +-
 block/blk-mq-sched.h  | 5 +++++
 block/kyber-iosched.c | 2 +-
 block/mq-deadline.c   | 2 +-
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 6e54b1d3d8bc2..9e9d081e86bb2 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -697,7 +697,7 @@ static void bfq_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 	unsigned int limit, act_idx;
 
 	/* Sync reads have full depth available */
-	if (op_is_sync(opf) && !op_is_write(opf))
+	if (blk_mq_is_sync_read(opf))
 		limit = data->q->nr_requests;
 	else
 		limit = bfqd->async_depths[!!bfqd->wr_busy_queues][op_is_sync(opf)];
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 02c40a72e9598..5678e15bd33c4 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -137,4 +137,9 @@ static inline void blk_mq_set_min_shallow_depth(struct request_queue *q,
 						depth);
 }
 
+static inline bool blk_mq_is_sync_read(blk_opf_t opf)
+{
+	return op_is_sync(opf) && !op_is_write(opf);
+}
+
 #endif
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index c1b36ffd19ceb..2b3f5b8959af0 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -556,7 +556,7 @@ static void kyber_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 	 * We use the scheduler tags as per-hardware queue queueing tokens.
 	 * Async requests can be limited at this stage.
 	 */
-	if (!op_is_sync(opf)) {
+	if (!blk_mq_is_sync_read(opf)) {
 		struct kyber_queue_data *kqd = data->q->elevator->elevator_data;
 
 		data->shallow_depth = kqd->async_depth;
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 3e3719093aec7..29d00221fbea6 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -495,7 +495,7 @@ static void dd_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 	struct deadline_data *dd = data->q->elevator->elevator_data;
 
 	/* Do not throttle synchronous reads. */
-	if (op_is_sync(opf) && !op_is_write(opf))
+	if (blk_mq_is_sync_read(opf))
 		return;
 
 	/*
-- 
2.51.0


