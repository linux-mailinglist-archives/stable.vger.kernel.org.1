Return-Path: <stable+bounces-241267-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGGVNEAd72ml6wAAu9opvQ
	(envelope-from <stable+bounces-241267-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 10:24:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3471C46F046
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 10:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C60B3017C29
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D38E39A7E9;
	Mon, 27 Apr 2026 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="dSRwL5Ze"
X-Original-To: stable@vger.kernel.org
Received: from n169-111.mail.139.com (n169-111.mail.139.com [120.232.169.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57A92D8376
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777278073; cv=none; b=nL5yj/hht/fxw7nyQUIFTDvDhTCh10egr4h2lrb6H9PAPwkvZlXOFoi++PbSFVL4zco6bmX5LodITGwnUfsqJCVthzv3x0E1dPh4X/YjZeIsG0eFGILeZHeM7wJpRosz+VbHj27eKyoXR05fBhS2M4Nh36aQ5aUfc1ZOXX6bg5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777278073; c=relaxed/simple;
	bh=vtBYq/w5nRz41XCWKAhvk4+TVHirr60LaIIWADbLUL0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Lp2e8UHfLUqNBC5lswYJAsmsmXz2H8Z/GxWmQOSWv70lXUQwGWgVtHM3pLYXXp/aCzgNxQzq35eBFB2t/hxN4u+mDdmWHBY31ds3dsSVNW0RDpc8g1FVIeVCYTIcDh//xTk680GmAwTwdMK4nqasga/K+H2ZgjxtuVlF+UC4VBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=dSRwL5Ze; arc=none smtp.client-ip=120.232.169.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=dSRwL5ZeO5dSKQNchItQ70zp0wp/EZj/LFk73xzqD2na9tWxyS0eyKd2KStwZ2L9eId7yMS+++zSm
	 oidRb9j+zmFHAXRj30s3w7QqWklzCKGqzCA03vMgY3gNVJxX/nY384E98Sx1GsQC0OIELeoDJ39+7w
	 iLKUFahC63pgl1Kk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from China-Mobile-Kernel-Team (unknown[223.104.40.155])
	by rmsmtp-lg-appmail-11-12089 (RichMail) with SMTP id 2f3969ef1c69de3-764a6;
	Mon, 27 Apr 2026 16:20:59 +0800 (CST)
X-RM-TRANSID:2f3969ef1c69de3-764a6
From: Leon Chen <leonchen.oss@139.com>
To: guazhang@redhat.com,
	ming.lei@redhat.com,
	axboe@kernel.dk,
	stable@vger.kernel.org
Subject: [PATCH 6.1.y] blk-mq: fix NULL dereference on q->elevator in blk_mq_elv_switch_none
Date: Mon, 27 Apr 2026 16:20:57 +0800
Message-Id: <20260427082057.9619-1-leonchen.oss@139.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3471C46F046
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241267-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[139.com];
	NEURAL_SPAM(0.00)[0.094];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonchen.oss@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[139.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dk:email,139.com:mid,139.com:email]

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 245165658e1c9f95c0fecfe02b9b1ebd30a1198a ]

After grabbing q->sysfs_lock, q->elevator may become NULL because of
elevator switch.

Fix the NULL dereference on q->elevator by checking it with lock.

Reported-by: Guangwu Zhang <guazhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20230616132354.415109-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Leon Chen <leonchen.oss@139.com>
---
 block/blk-mq.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f480b6ddba5e..8a9d9e3db166 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4732,9 +4732,6 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 {
 	struct blk_mq_qe_pair *qe;
 
-	if (!q->elevator)
-		return true;
-
 	qe = kmalloc(sizeof(*qe), GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY);
 	if (!qe)
 		return false;
@@ -4742,6 +4739,12 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 	/* q->elevator needs protection from ->sysfs_lock */
 	mutex_lock(&q->sysfs_lock);
 
+	/* the check has to be done with holding sysfs_lock */
+	if (!q->elevator) {
+		kfree(qe);
+		goto unlock;
+	}
+
 	INIT_LIST_HEAD(&qe->node);
 	qe->q = q;
 	qe->type = q->elevator->type;
@@ -4756,6 +4759,7 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 	 */
 	__module_get(qe->type->elevator_owner);
 	elevator_switch(q, NULL);
+unlock:
 	mutex_unlock(&q->sysfs_lock);
 
 	return true;
-- 
2.35.3



