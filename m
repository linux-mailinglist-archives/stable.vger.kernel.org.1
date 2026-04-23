Return-Path: <stable+bounces-240430-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPrxMhXE6WkAjwIAu9opvQ
	(envelope-from <stable+bounces-240430-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 09:02:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2385744DCDA
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 09:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A8E2301A143
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 07:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865EB3DC4BF;
	Thu, 23 Apr 2026 07:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pkJ6PgbO"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6869E3D9029;
	Thu, 23 Apr 2026 07:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776927760; cv=none; b=AWHOf11fJHJydZPpacM9ijwzn2xr85s3PKoI4OuPRIfazpuFko1zFPfBLSih0/ttrUpFx++wXyHtCEkxw7d/GDBERNIooUSkr+4jXc4bhQDHkwL4eb5LJ3SFYWqAHaDcJ0jkw+vHLmA4kmXsuzhWyxLSHffSnprNQDenMyzHttI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776927760; c=relaxed/simple;
	bh=NKyRsoHy8+u6GlWkxqR0tmoYRU16SzCWFRaiDfvxP/c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YL5aXs5kXtW3VY6JvQ1+0vLAqo97tU7a/YeYmeeOe1r4rheQXtkpDq5jr8cIeZMTP3/+Fj3Z3XMYb4RPUYslqXQsu4gljy6wlJL7oA7lZb0TL3a53XZAYDe/1r/OQ3coUpjcJIAEqE/ZUkZqlbyUJwNuo5cBxmobVc5r95su004=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pkJ6PgbO; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=UP
	ZREBmoHaCiqhO8OolVXNN5y0f1XjeBuqwVCXDbkrg=; b=pkJ6PgbOdCCsONPAJ8
	GeV6i5qPQCvaasIQ1nvrMUBTsioxsYQCUc6ztilZgVDZgp4kL+hdHM0NWBqu+inc
	n8PYKPZf2E29smLs+Hts6WxaGv9DEbKdh76pVwb8+uEJVJD5LYtVWPvwlaIyAf60
	FI3JVexxZ6HulxWF9OvRhlZ2E=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCnlSbnw+lpIysTBQ--.5955S2;
	Thu, 23 Apr 2026 15:01:59 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	Robert Garcia <rob_garcia@163.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.15.y] fs/ntfs3: Add more attributes checks in mi_enum_attr()
Date: Thu, 23 Apr 2026 15:01:59 +0800
Message-Id: <20260423070159.3246415-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnlSbnw+lpIysTBQ--.5955S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr17KFWUtFW8JF48tFWUurg_yoWrJw1kpF
	4Yy3y3A3yY9FnFkrsrKF4rZayft34fKFyUGFy2vrnIkF1aqr17Wr98trW0vryfuw4DGFZY
	krs0ka1fAwnrJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMg4S9UUUUU=
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbC5ggAa2npw+gqLAAA3o
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240430-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,163.com,vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob_garcia@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2385744DCDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 013ff63b649475f0ee134e2c8d0c8e65284ede50 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
[ Overflow check deleted to keep context consistent. ]
Signed-off-by: Robert Garcia <rob_garcia@163.com>
---
 fs/ntfs3/record.c | 63 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index cef53583f9a1..7965bea0b2c8 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -193,8 +193,9 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 {
 	const struct MFT_REC *rec = mi->mrec;
 	u32 used = le32_to_cpu(rec->used);
-	u32 t32, off, asize;
+	u32 t32, off, asize, prev_type;
 	u16 t16;
+	u64 data_size, alloc_size, tot_size;
 
 	if (!attr) {
 		u32 total = le32_to_cpu(rec->total);
@@ -213,6 +214,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		if (!is_rec_inuse(rec))
 			return NULL;
 
+		prev_type = 0;
 		attr = Add2Ptr(rec, off);
 	} else {
 		/* Check if input attr inside record. */
@@ -226,6 +228,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 			return NULL;
 		}
 
+		prev_type = le32_to_cpu(attr->type);
 		attr = Add2Ptr(attr, asize);
 		off += asize;
 	}
@@ -245,7 +248,11 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 
 	/* 0x100 is last known attribute for now. */
 	t32 = le32_to_cpu(attr->type);
-	if ((t32 & 0xf) || (t32 > 0x100))
+	if (!t32 || (t32 & 0xf) || (t32 > 0x100))
+		return NULL;
+
+	/* attributes in record must be ordered by type */
+	if (t32 < prev_type)
 		return NULL;
 
 	/* Check overflow and boundary. */
@@ -254,16 +261,15 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 
 	/* Check size of attribute. */
 	if (!attr->non_res) {
+		/* Check resident fields. */
 		if (asize < SIZEOF_RESIDENT)
 			return NULL;
 
 		t16 = le16_to_cpu(attr->res.data_off);
-
 		if (t16 > asize)
 			return NULL;
 
-		t32 = le32_to_cpu(attr->res.data_size);
-		if (t16 + t32 > asize)
+		if (t16 + le32_to_cpu(attr->res.data_size) > asize)
 			return NULL;
 
 		if (attr->name_len &&
@@ -274,21 +280,52 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		return attr;
 	}
 
-	/* Check some nonresident fields. */
-	if (attr->name_len &&
-	    le16_to_cpu(attr->name_off) + sizeof(short) * attr->name_len >
-		    le16_to_cpu(attr->nres.run_off)) {
+	/* Check nonresident fields. */
+	if (attr->non_res != 1)
+		return NULL;
+
+	t16 = le16_to_cpu(attr->nres.run_off);
+	if (t16 > asize)
+		return NULL;
+
+	t32 = sizeof(short) * attr->name_len;
+	if (t32 && le16_to_cpu(attr->name_off) + t32 > t16)
+		return NULL;
+
+	/* Check start/end vcn. */
+	if (le64_to_cpu(attr->nres.svcn) > le64_to_cpu(attr->nres.evcn) + 1)
+		return NULL;
+
+	data_size = le64_to_cpu(attr->nres.data_size);
+	if (le64_to_cpu(attr->nres.valid_size) > data_size)
 		return NULL;
-	}
 
-	if (attr->nres.svcn || !is_attr_ext(attr)) {
+	alloc_size = le64_to_cpu(attr->nres.alloc_size);
+	if (data_size > alloc_size)
+		return NULL;
+
+	t32 = mi->sbi->cluster_mask;
+	if (alloc_size & t32)
+		return NULL;
+
+	if (!attr->nres.svcn && is_attr_ext(attr)) {
+		/* First segment of sparse/compressed attribute */
+		if (asize + 8 < SIZEOF_NONRESIDENT_EX)
+			return NULL;
+
+		tot_size = le64_to_cpu(attr->nres.total_size);
+		if (tot_size & t32)
+			return NULL;
+
+		if (tot_size > alloc_size)
+			return NULL;
+	} else {
 		if (asize + 8 < SIZEOF_NONRESIDENT)
 			return NULL;
 
 		if (attr->nres.c_unit)
 			return NULL;
-	} else if (asize + 8 < SIZEOF_NONRESIDENT_EX)
-		return NULL;
+	}
 
 	return attr;
 }
-- 
2.34.1


