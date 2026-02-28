Return-Path: <stable+bounces-220166-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GYMJiMto2me+AQAu9opvQ
	(envelope-from <stable+bounces-220166-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:00:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2A81C54EF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F69731EE1EF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BAB49690F;
	Sat, 28 Feb 2026 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qg7ZG1E2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED97496908;
	Sat, 28 Feb 2026 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300074; cv=none; b=ZYyrjjK5cD7nAmvwvM+uWMBzhwbSGBOUcAMLIlN5IHlSVRzmpbWKo3EW/AhM0NW9aF+aM9OB+maOg+EKncWMg6afMqNczgtYX98HrBhB0XKMMlqou2DXlgcSh4BFZK3K0JL6H2aJ4nNKQikTzv5sZxm1whpBv6w9BiuT5ISLGHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300074; c=relaxed/simple;
	bh=JqjnUMKlVgixfHjEdpBSAggZsMoLdZspUbOL62UOxns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UvDpOsLenOv8LpHWql4smI5tXMYppFkTH6AaWJppTba+AljYyHQvS5A3qdgDb/KbtM6DHk+DCvhOX7UQNnvZczhdcqp/DlY/HxwfQrOKjy2wFnZ0D4lXTUZx6Rp97ZhXbY53rID9K5RNnhyIZLsOBifR6u1P0Ror0ALZ7Xr8z9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qg7ZG1E2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309BFC19425;
	Sat, 28 Feb 2026 17:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300073;
	bh=JqjnUMKlVgixfHjEdpBSAggZsMoLdZspUbOL62UOxns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qg7ZG1E2saEPW3niEDpZ3fgZx0yxac4NY73887q1z7KrgnNNHhYDAmA2B3J2ecsTd
	 Eh6Dy5pf8DuaC7QDuVr1JkuWePCsUY7P3X/SbSZVfcdq9ThO7Xj/FAgcgfaJXyJUcZ
	 h35NzTOvFdRyCEMj1T1gDtWcrw05ciNBsDxNfUPG/qy/WOxToSDC4jFJk3WeFHH0Kf
	 /eOdclNhIBL8LqpuzeW4BYXGy56ojRKYysCq1vB307EesjnqosUe0515t+NC2Tktdt
	 T8YBkGYPBC+B6/dW6s58NfQqxJSeDtrIwy60AUhC6U41vdY+FkvNF175MMZakDK997
	 NJeWCEOp/6mfw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luke Wang <ziniu.wang_1@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 088/844] block: decouple secure erase size limit from discard size limit
Date: Sat, 28 Feb 2026 12:20:01 -0500
Message-ID: <20260228173244.1509663-89-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220166-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kernel.dk:email]
X-Rspamd-Queue-Id: 1E2A81C54EF
X-Rspamd-Action: no action

From: Luke Wang <ziniu.wang_1@nxp.com>

[ Upstream commit ee81212f74a57c5d2b56cf504f40d528dac6faaf ]

Secure erase should use max_secure_erase_sectors instead of being limited
by max_discard_sectors. Separate the handling of REQ_OP_SECURE_ERASE from
REQ_OP_DISCARD to allow each operation to use its own size limit.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-merge.c | 21 +++++++++++++++++----
 block/blk.h       |  6 +++++-
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index d3115d7469df0..bf8faadb0bd46 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -158,8 +158,9 @@ static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
 	return bio;
 }
 
-struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
-		unsigned *nsegs)
+static struct bio *__bio_split_discard(struct bio *bio,
+		const struct queue_limits *lim, unsigned *nsegs,
+		unsigned int max_sectors)
 {
 	unsigned int max_discard_sectors, granularity;
 	sector_t tmp;
@@ -169,8 +170,7 @@ struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
 
 	granularity = max(lim->discard_granularity >> 9, 1U);
 
-	max_discard_sectors =
-		min(lim->max_discard_sectors, bio_allowed_max_sectors(lim));
+	max_discard_sectors = min(max_sectors, bio_allowed_max_sectors(lim));
 	max_discard_sectors -= max_discard_sectors % granularity;
 	if (unlikely(!max_discard_sectors))
 		return bio;
@@ -194,6 +194,19 @@ struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
 	return bio_submit_split(bio, split_sectors);
 }
 
+struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
+		unsigned *nsegs)
+{
+	unsigned int max_sectors;
+
+	if (bio_op(bio) == REQ_OP_SECURE_ERASE)
+		max_sectors = lim->max_secure_erase_sectors;
+	else
+		max_sectors = lim->max_discard_sectors;
+
+	return __bio_split_discard(bio, lim, nsegs, max_sectors);
+}
+
 static inline unsigned int blk_boundary_sectors(const struct queue_limits *lim,
 						bool is_atomic)
 {
diff --git a/block/blk.h b/block/blk.h
index e4c433f62dfc7..4cd5a91346d8a 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -208,10 +208,14 @@ static inline unsigned int blk_queue_get_max_sectors(struct request *rq)
 	struct request_queue *q = rq->q;
 	enum req_op op = req_op(rq);
 
-	if (unlikely(op == REQ_OP_DISCARD || op == REQ_OP_SECURE_ERASE))
+	if (unlikely(op == REQ_OP_DISCARD))
 		return min(q->limits.max_discard_sectors,
 			   UINT_MAX >> SECTOR_SHIFT);
 
+	if (unlikely(op == REQ_OP_SECURE_ERASE))
+		return min(q->limits.max_secure_erase_sectors,
+			   UINT_MAX >> SECTOR_SHIFT);
+
 	if (unlikely(op == REQ_OP_WRITE_ZEROES))
 		return q->limits.max_write_zeroes_sectors;
 
-- 
2.51.0


