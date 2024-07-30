Return-Path: <stable+bounces-64668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9538D94215E
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 22:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A791C23FD6
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 20:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D6318CC1B;
	Tue, 30 Jul 2024 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isv1i6/E"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC85018CBE5
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722370427; cv=none; b=OexhZ9dI7pNTcI6+6V0M3yTbcSXjklsXP8LnM+yYwtYyEISZb14gir+ZfWVTL9CxFFByD9Sgs/5qpCvq/jmWb93ahnAsZqvjB9pBHSVAGz73O+5h2UWs2uLKGCw5Wn4bywguAWjkLbJvw3N4qXdOawNulMA/6WKKOGOY5wZzDs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722370427; c=relaxed/simple;
	bh=qT00zwkYKJgoOxVY+BeA/YOxYgQaa4TKzMRCAlXSilM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DAaR3AnqD43u/0skgEY2siqqYmFky/fzivVrRLBbDen7W4qNOi4h8o3R+U+iNmjl9bZAzQOSxqjQFjH0YXRGRym86xYb73OPC6/SXf2AC62PTaVIoLUghEQW59D2cpRgAO626KZjCv3MMn/exfZI5/zAMxzh68ZONJI4K1UHiZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isv1i6/E; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428243f928cso9751645e9.3
        for <stable@vger.kernel.org>; Tue, 30 Jul 2024 13:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722370424; x=1722975224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xXBOk6u7M6ky2TJSBluwduZrSddYhgFxG2c5cgfXD8k=;
        b=isv1i6/Epi3PEAN2w/FObMhBJdYfKAv0ASGFqK379eI6sB6+qBMYx6OnU1sQnPZGxu
         jGNJT9lWcz6/HWKmWMqPxzkX/9/hAXGsMkRcLvnCLpwPjjMNUJIysYJlaZhmcZV55AH6
         +0Ol3gGFv0lDsCRj8qInU9nfNFYlnq1L+QHOZwwGUMP0ompiFdjZt8g+okLpmpCBV3vk
         pVyg3qHUOPYVoq+rnA5XfJi+RTN2IXLzD6/66hOfXSzPYi75WWVJ6NUvkNNOwWQpkEFf
         xi4GejnLGYzdGaxXDciN0M7WYAXAJRjtBT10ewUA2IM9M4tZzfuy2bg0tBxFpAjkxw1+
         6Aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722370424; x=1722975224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXBOk6u7M6ky2TJSBluwduZrSddYhgFxG2c5cgfXD8k=;
        b=UrFrf9cHV5UxAu0iSZUth0945CcVApDHENp/m/WkPVlqlvQF84mo2/K/zQOVoe8Ea7
         CJr7XtblmDiVGEZvpssGJAi0bme6EWWZjEtdAWGJeYKEB54oceoHccNZK900Qhfb7nRw
         bsmCpUwYsqOjCfBUad6rw4d6nYMSo1tbvmm7SK/yJ9sa14eB5Kc0iKolVzL43hMWCUEX
         iYZlHEv2FoUR5CeYrL1Nyu/ouPwVFy9VhbLgB6JdgCloBbFdzZaOS8HMpbWQicJMM8Wt
         g9iQT+Oqj1N28i8BqDFC3qkZL+etvFWQ19s1CQV7qIvenboS4pEfvM5WCPwOhkVeEA+5
         2Xiw==
X-Gm-Message-State: AOJu0YyOVnHHN9CeQujqVrHTiTQMjkyvAfgUg83r9kvV/w2X7ULzsMlJ
	bJfV7EeICGKI6ni5Z4/zZke4GTAsEj4K9PAh6T+34ftbruZ6FVnsupQxOtVe
X-Google-Smtp-Source: AGHT+IG6RnNUmcE8SRkRazzvViDEzBmKx/cfzBb40ZZKy4IHiHDgrlpiJoWjnfE/K5nhecrF4Gc99w==
X-Received: by 2002:a05:600c:4f4b:b0:426:64a2:5375 with SMTP id 5b1f17b1804b1-42811d80105mr83466395e9.1.1722370423392;
        Tue, 30 Jul 2024 13:13:43 -0700 (PDT)
Received: from laptop.. (52.red-83-52-244.dynamicip.rima-tde.net. [83.52.244.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280573fd83sm227148385e9.19.2024.07.30.13.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 13:13:43 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: stable@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Manas Ghandat <ghandatmanas@gmail.com>,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>,
	syzbot+6b1d79dad6cc6b3eef41@syzkaller.appspotmail.com
Subject: [PATCH 6.1.y] jfs: define xtree root and page independently
Date: Tue, 30 Jul 2024 22:13:15 +0200
Message-Id: <20240730201315.19917-1-sergio.collado@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Dave Kleikamp <dave.kleikamp@oracle.com>

[ Upstream commit a779ed754e52d582b8c0e17959df063108bd0656 ]

In order to make array bounds checking sane, provide a separate
definition of the in-inode xtree root and the external xtree page.

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Tested-by: Manas Ghandat <ghandatmanas@gmail.com>
(cherry picked from commit a779ed754e52d582b8c0e17959df063108bd0656)
Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
Reported-by: syzbot+6b1d79dad6cc6b3eef41@syzkaller.appspotmail.com
---
 fs/jfs/jfs_dinode.h |  2 +-
 fs/jfs/jfs_imap.c   |  6 +++---
 fs/jfs/jfs_incore.h |  2 +-
 fs/jfs/jfs_txnmgr.c |  4 ++--
 fs/jfs/jfs_xtree.c  |  4 ++--
 fs/jfs/jfs_xtree.h  | 37 +++++++++++++++++++++++--------------
 6 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/fs/jfs/jfs_dinode.h b/fs/jfs/jfs_dinode.h
index 6b231d0d0071..603aae17a693 100644
--- a/fs/jfs/jfs_dinode.h
+++ b/fs/jfs/jfs_dinode.h
@@ -96,7 +96,7 @@ struct dinode {
 #define di_gengen	u._file._u1._imap._gengen
 
 			union {
-				xtpage_t _xtroot;
+				xtroot_t _xtroot;
 				struct {
 					u8 unused[16];	/* 16: */
 					dxd_t _dxd;	/* 16: */
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index ac42f8ee553f..794072cdf192 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -670,7 +670,7 @@ int diWrite(tid_t tid, struct inode *ip)
 		 * This is the special xtree inside the directory for storing
 		 * the directory table
 		 */
-		xtpage_t *p, *xp;
+		xtroot_t *p, *xp;
 		xad_t *xad;
 
 		jfs_ip->xtlid = 0;
@@ -684,7 +684,7 @@ int diWrite(tid_t tid, struct inode *ip)
 		 * copy xtree root from inode to dinode:
 		 */
 		p = &jfs_ip->i_xtroot;
-		xp = (xtpage_t *) &dp->di_dirtable;
+		xp = (xtroot_t *) &dp->di_dirtable;
 		lv = ilinelock->lv;
 		for (n = 0; n < ilinelock->index; n++, lv++) {
 			memcpy(&xp->xad[lv->offset], &p->xad[lv->offset],
@@ -713,7 +713,7 @@ int diWrite(tid_t tid, struct inode *ip)
 	 *	regular file: 16 byte (XAD slot) granularity
 	 */
 	if (type & tlckXTREE) {
-		xtpage_t *p, *xp;
+		xtroot_t *p, *xp;
 		xad_t *xad;
 
 		/*
diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
index 721def69e732..dd4264aa9bed 100644
--- a/fs/jfs/jfs_incore.h
+++ b/fs/jfs/jfs_incore.h
@@ -66,7 +66,7 @@ struct jfs_inode_info {
 	lid_t	xtlid;		/* lid of xtree lock on directory */
 	union {
 		struct {
-			xtpage_t _xtroot;	/* 288: xtree root */
+			xtroot_t _xtroot;	/* 288: xtree root */
 			struct inomap *_imap;	/* 4: inode map header	*/
 		} file;
 		struct {
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index ce4b4760fcb1..dccc8b3f1045 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -783,7 +783,7 @@ struct tlock *txLock(tid_t tid, struct inode *ip, struct metapage * mp,
 			if (mp->xflag & COMMIT_PAGE)
 				p = (xtpage_t *) mp->data;
 			else
-				p = &jfs_ip->i_xtroot;
+				p = (xtpage_t *) &jfs_ip->i_xtroot;
 			xtlck->lwm.offset =
 			    le16_to_cpu(p->header.nextindex);
 		}
@@ -1676,7 +1676,7 @@ static void xtLog(struct jfs_log * log, struct tblock * tblk, struct lrd * lrd,
 
 	if (tlck->type & tlckBTROOT) {
 		lrd->log.redopage.type |= cpu_to_le16(LOG_BTROOT);
-		p = &JFS_IP(ip)->i_xtroot;
+		p = (xtpage_t *) &JFS_IP(ip)->i_xtroot;
 		if (S_ISDIR(ip->i_mode))
 			lrd->log.redopage.type |=
 			    cpu_to_le16(LOG_DIR_XTREE);
diff --git a/fs/jfs/jfs_xtree.c b/fs/jfs/jfs_xtree.c
index 2d304cee884c..5ee618d17e77 100644
--- a/fs/jfs/jfs_xtree.c
+++ b/fs/jfs/jfs_xtree.c
@@ -1213,7 +1213,7 @@ xtSplitRoot(tid_t tid,
 	struct xtlock *xtlck;
 	int rc;
 
-	sp = &JFS_IP(ip)->i_xtroot;
+	sp = (xtpage_t *) &JFS_IP(ip)->i_xtroot;
 
 	INCREMENT(xtStat.split);
 
@@ -2098,7 +2098,7 @@ int xtAppend(tid_t tid,		/* transaction id */
  */
 void xtInitRoot(tid_t tid, struct inode *ip)
 {
-	xtpage_t *p;
+	xtroot_t *p;
 
 	/*
 	 * acquire a transaction lock on the root
diff --git a/fs/jfs/jfs_xtree.h b/fs/jfs/jfs_xtree.h
index 142caafc73b1..15da4e16d8b2 100644
--- a/fs/jfs/jfs_xtree.h
+++ b/fs/jfs/jfs_xtree.h
@@ -65,24 +65,33 @@ struct xadlist {
 #define XTPAGEMAXSLOT	256
 #define XTENTRYSTART	2
 
-/*
- *	xtree page:
- */
-typedef union {
-	struct xtheader {
-		__le64 next;	/* 8: */
-		__le64 prev;	/* 8: */
+struct xtheader {
+	__le64 next;	/* 8: */
+	__le64 prev;	/* 8: */
 
-		u8 flag;	/* 1: */
-		u8 rsrvd1;	/* 1: */
-		__le16 nextindex;	/* 2: next index = number of entries */
-		__le16 maxentry;	/* 2: max number of entries */
-		__le16 rsrvd2;	/* 2: */
+	u8 flag;	/* 1: */
+	u8 rsrvd1;	/* 1: */
+	__le16 nextindex;	/* 2: next index = number of entries */
+	__le16 maxentry;	/* 2: max number of entries */
+	__le16 rsrvd2;	/* 2: */
 
-		pxd_t self;	/* 8: self */
-	} header;		/* (32) */
+	pxd_t self;	/* 8: self */
+};
 
+/*
+ *	xtree root (in inode):
+ */
+typedef union {
+	struct xtheader header;
 	xad_t xad[XTROOTMAXSLOT];	/* 16 * maxentry: xad array */
+} xtroot_t;
+
+/*
+ *	xtree page:
+ */
+typedef union {
+	struct xtheader header;
+	xad_t xad[XTPAGEMAXSLOT];	/* 16 * maxentry: xad array */
 } xtpage_t;
 
 /*
-- 
2.39.2


