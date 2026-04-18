Return-Path: <stable+bounces-238589-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6E1SE2uK42kDIQEAu9opvQ
	(envelope-from <stable+bounces-238589-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 15:43:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DF84213DA
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 15:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC790307E363
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 13:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302B337D138;
	Sat, 18 Apr 2026 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+CmtZqq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1EB37D120
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 13:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776519594; cv=none; b=sLHmdeDfN8+wcd8pVipPs0e0Dz7t99lqJcqhCVTKZGb0iH1AVzNmj/wBVK66vgvR3ByWNwbpoyxBNn6Pjd2FZqv4m3Rosed0r5T9swbALFmaAvPSJBs69a8lbPfBjT8rfCcma9FfrrHnPaViCM+A1oqxy8lxXW8ZpQGGJ/FOr+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776519594; c=relaxed/simple;
	bh=1f6nG6admbT1hTed5lqeiJcXQUkVRDolHMiHMqRxswM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r4Z7U+HCnpDFJwORWofj/8/vrfcj46aZz4GxLfQacv4/MzngYKtBdbIG1SA3cA2Py9wti6zU2KMaxX6qPOXbAZmyazqUQPwrxCMCnrI/EMHsQmFKQOo4GtHT7JTbTfr9aEJacG8rEyqZCzRFX5QwJRHLktLUKIuZVftOXz2wTk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+CmtZqq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso16434985e9.2
        for <stable@vger.kernel.org>; Sat, 18 Apr 2026 06:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776519591; x=1777124391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ykLQ37lVo2XTzU7ACqvXY0l0gwcbJX9ZLKIe6Ak88bQ=;
        b=B+CmtZqqO23QoU8z+NuSK7sGzhzJKv10oppNHISrQ/vtUhivwO3oBLiqltJgNDMtnw
         32GdLRCBJ6KnDnNCxPthPEmV9xH4bd5yqVK64RdHq5JlczBM0fNbE3j371hFHOokUby1
         PduzG+bD23m0nhMRZqBlvwk0hYepcsVpVKM6Z/XsH24uKwOR0OT30ZddU2rt+gKFixVl
         7u9vOgeoS4uW+Q/v2c0zyfAZtRvyGalKzQjQf8fvmXw8+feiAVEecr/In3KB+jN2MiSx
         7uVXygbFjwQBuQpm1+L+xyjLE395O3WL+sD/FukbApxTNM53nmdQPlndRwk/gCEjBrb8
         Mn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776519591; x=1777124391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykLQ37lVo2XTzU7ACqvXY0l0gwcbJX9ZLKIe6Ak88bQ=;
        b=coFbygJqtkDJNcA4pk+5EqOQHh/I79tKjbnQP5MAsfBWyJXCDy2zve5qcc0XQh0hPy
         YOS8wSzRF120JERUITRgoQwLKvcqThf3huYT+hhP83lrxR6B7KVlInh72fHXieB8KFWy
         iEpZwrPTGGajm002ZsmXq/ywpokAnJeteC1S3EW0zsUjNARv67t2LaNtouJciwfpHr5m
         CktjI321vxuyKFMPwj6+NAHb+lcJAVotuOu+A2k+LbBmmajpu3AOqj0N3mpLbxO6Cwi6
         2OxyszCTHD3m3MZQWvrlapmYMQaIMtYJxYMCL2Y7VpJAXo25dTAx/ZuDqBvAMto+5Gvc
         rmTQ==
X-Forwarded-Encrypted: i=1; AFNElJ8X6TlsmDu0qviQCowxWEog1t/da289k49RMuNVClythQQBBIyI4WLW7q0xbypeo/JFrj3C2gA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUtQADS4gRe6LNq3v7AWl/4ca8ELsEcqAGFzj0ZVd9yCalDTik
	LCBwgcm9NQFhhXdTP13M8xc8YbPyF4adXsozr5KvAGj8wgFuvq6PQa0=
X-Gm-Gg: AeBDiesMhLbBHFb1DB/SpN9SH4MYUiTIzAhAtFDLnsx9t7+LbpreC0ZksLWGXXd4N43
	09xWVk00Ueh4VobJxtAQNxr2i6jrJ5+mtjbZNQWcxHqv9DJHrduCuM+raDUsylQcRaWDnoxIrsd
	6GAZEltzgLjTMfylPwFQYcGvkDxkSXPg9l446YxAF+mGlfTbIgSO5eLKtNqz88s1io4rcJByga4
	S/fbprC+Io9araJhop+AA+sanIWA1yOmqXDckKQT8cDVPwyqCoKD1JbKMzjxfNOMtNuECiMeeLl
	TUmoR7YrsD2EyWLrtbtc5a3lkpNfETeZI85FzUV4UG5Lr+dl4f0DMCPjFJZhFMc++gUL8O0Sn09
	3bmIthsT8uMWQ19klb+0cow8BplxOGtAau8rByIQnqdeM8h1tqJft+pbUSDB8jaVYBQ40JwNvl8
	YXbyVkyMxI6ScX2dsC
X-Received: by 2002:a05:600c:8183:b0:486:fd5c:2b35 with SMTP id 5b1f17b1804b1-488fb750809mr100708065e9.13.1776519590572;
        Sat, 18 Apr 2026 06:39:50 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb135asm14644971f8f.6.2026.04.18.06.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 06:39:50 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org,
	stable@vger.kernel.org,
	syzbot+a19ca73b21fe8bc69101@syzkaller.appspotmail.com,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] hfs: validate bitmap record offset in hfs_bmap_alloc
Date: Sat, 18 Apr 2026 13:39:49 +0000
Message-ID: <20260418133949.1713416-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238589-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.894];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable,a19ca73b21fe8bc69101];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:mid,talencesecurity.com:email,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: B8DF84213DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hfs_bmap_alloc() retrieves the bitmap record from the header node
using hfs_brec_lenoff() but does not validate the returned offset
and length before using them to compute page pointers.  On a crafted
HFS image with corrupted B-tree data, the offset can exceed the node
size, causing an out-of-bounds page access.

Additionally, when the bitmap has node 0 bit incorrectly unset,
hfs_bmap_alloc() calls hfs_bnode_create(tree, 0) for the already-
hashed header node, triggering a WARN_ON and returning the existing
node without incrementing its reference count.

Port the fixes already applied to HFS+ (commits d8a73cc46c84 and
738d5a51864e) to the HFS side:

1. Move is_bnode_offset_valid() and check_and_correct_requested_length()
   from bnode.c to btree.h so they can be used by btree.c.

2. Validate the record offset and length in hfs_bmap_alloc() before
   computing page pointers, preventing out-of-bounds access.

3. Return ERR_PTR(-EEXIST) from hfs_bnode_create() when the node is
   already hashed, properly signaling filesystem corruption to callers.

Reported-by: syzbot+a19ca73b21fe8bc69101@syzkaller.appspotmail.com
Tested-by: syzbot+a19ca73b21fe8bc69101@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/hfs/bnode.c | 44 +-------------------------------------------
 fs/hfs/btree.c |  6 ++++++
 fs/hfs/btree.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 43 deletions(-)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index 13d58c51fc46b..26c2e65ab5935 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -15,48 +15,6 @@
 
 #include "btree.h"
 
-static inline
-bool is_bnode_offset_valid(struct hfs_bnode *node, u32 off)
-{
-	bool is_valid = off < node->tree->node_size;
-
-	if (!is_valid) {
-		pr_err("requested invalid offset: "
-		       "NODE: id %u, type %#x, height %u, "
-		       "node_size %u, offset %u\n",
-		       node->this, node->type, node->height,
-		       node->tree->node_size, off);
-	}
-
-	return is_valid;
-}
-
-static inline
-u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
-{
-	unsigned int node_size;
-
-	if (!is_bnode_offset_valid(node, off))
-		return 0;
-
-	node_size = node->tree->node_size;
-
-	if ((off + len) > node_size) {
-		u32 new_len = node_size - off;
-
-		pr_err("requested length has been corrected: "
-		       "NODE: id %u, type %#x, height %u, "
-		       "node_size %u, offset %u, "
-		       "requested_len %u, corrected_len %u\n",
-		       node->this, node->type, node->height,
-		       node->tree->node_size, off, len, new_len);
-
-		return new_len;
-	}
-
-	return len;
-}
-
 void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len)
 {
 	struct page *page;
@@ -518,7 +476,7 @@ struct hfs_bnode *hfs_bnode_create(struct hfs_btree *tree, u32 num)
 	if (node) {
 		pr_crit("new node %u already hashed?\n", num);
 		WARN_ON(1);
-		return node;
+		return ERR_PTR(-EEXIST);
 	}
 	node = __hfs_bnode_create(tree, num);
 	if (!node)
diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 2eb37a2f64e86..e8bc24c8baf1a 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -304,6 +304,12 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 	len = hfs_brec_lenoff(node, 2, &off16);
 	off = off16;
 
+	if (!is_bnode_offset_valid(node, off)) {
+		hfs_bnode_put(node);
+		return ERR_PTR(-EIO);
+	}
+	len = check_and_correct_requested_length(node, off, len);
+
 	off += node->page_offset;
 	pagep = node->page + (off >> PAGE_SHIFT);
 	data = kmap_local_page(*pagep);
diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
index 99be858b24465..6032b14b1639d 100644
--- a/fs/hfs/btree.h
+++ b/fs/hfs/btree.h
@@ -85,6 +85,48 @@ struct hfs_find_data {
 };
 
 
+static inline
+bool is_bnode_offset_valid(struct hfs_bnode *node, u32 off)
+{
+	bool is_valid = off < node->tree->node_size;
+
+	if (!is_valid) {
+		pr_err("requested invalid offset: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %u\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off);
+	}
+
+	return is_valid;
+}
+
+static inline
+u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
+{
+	unsigned int node_size;
+
+	if (!is_bnode_offset_valid(node, off))
+		return 0;
+
+	node_size = node->tree->node_size;
+
+	if ((off + len) > node_size) {
+		u32 new_len = node_size - off;
+
+		pr_err("requested length has been corrected: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %u, "
+		       "requested_len %u, corrected_len %u\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len, new_len);
+
+		return new_len;
+	}
+
+	return len;
+}
+
 /* btree.c */
 extern struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id,
 					btree_keycmp keycmp);
-- 
2.47.3


