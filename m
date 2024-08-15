Return-Path: <stable+bounces-69232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27945953A38
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 20:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDFF828321F
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 18:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE4753E24;
	Thu, 15 Aug 2024 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLI64Had"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1423D64A8F
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723747010; cv=none; b=W1D1mMGqRWiwbhdOha6nzlbWdsIF7hUeuiBIty42VrupNwsq2XL9Wh9y1WMkqm9Mw2JdBn8jGWdk4wLZPtL3ZcbrakZZUo7WlEebZGdWqZOybK+Wjht3P/NlDH59sVAA/Ps2FCvVT41RdrCI6KjDpjGJTzjsne1VfWo12qe8+sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723747010; c=relaxed/simple;
	bh=CH3Q4mZC1NmlZIsFwg6vDRv9m2p5wKSARo25MCdeeZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dnsOva1yx0wOEWajSI3OuGYb8HOzhou+hez728Yc6sTNTd/6yJckSCdCJE5H15T2rJTgMfJMkRwYYGUbGNiLz9N4GRSdwFGvBbFPhrnOvEB/pZIOq+L4HJ6q4O7/p8pKgfdhaOdkTMUo0HGTesQUdWxRR1zjpjdh/9hCsPZBC5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLI64Had; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428243f928fso11887605e9.0
        for <stable@vger.kernel.org>; Thu, 15 Aug 2024 11:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723747007; x=1724351807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zt76OlTMgOTV1PjOkL70MRE2Kp+dw68kf6to76VKlEc=;
        b=SLI64HadNQCa0zbN7vrCahx6Ju7JQpErjVUS8mG5eLEuYtMdHitu+ocj3luFOe55zT
         lQO2gbbIASBVnEOyxNsh9grPERTO9khX5IsrNq4qVy+wFm7rkngs8q5ATKcwbVgVxPFh
         YXbUdPvC72kiCOaoLBMIhFi6x+xbdAUgKj4Bf6nOgQx+PgpYkg3OJ+qTGF+hSvWSuvMr
         iOuNWpmxsk+Ami8X0pB7SpcFbhe06AD9u//jos85FWqlEwkdWKzZGmhhqhNzwn1KOKBW
         7fdaPW0XaCxOZRw+DbPm8yMYFCQrusPtxjk5gLDTYVGv37bHKVc85/AIEV7RPjjCKDhY
         k/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723747007; x=1724351807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zt76OlTMgOTV1PjOkL70MRE2Kp+dw68kf6to76VKlEc=;
        b=rYpS8qCKyvmcnlhSMfs/GozMVB15Hoszr2bCLbpmbZ/ADkt6LZ2EqDhxsdVU3BVM38
         Y823kGvIUJIeJJ71jc9rDYMONbBGt4RjoqpYn/QodBS0LUYxxt8S5Ny40Qqq5mmbXD1+
         AHh5DTQBe3GjWvIHOfm0+cMZLrH0bEvT/Or4uUMh0UXqkLZDSpBXKY2+hESjCo82OSQ8
         1DORdWbtmgdCnKvV0vG9UiBsR2HKtqSb6wUlc7QdH+P0UI0HzP1hp3CH8VGehxh4/oTv
         hxWYW7+WgrZx/DFTRMX3aT0lDdm0tlg1w5oq8vRP+VPVwZFdvXIvJL2dsTRi59J1qCgX
         Fpdg==
X-Gm-Message-State: AOJu0YyVvNN9/BsK91wwEF4THCM+rLz1Qb/qxGsQ+t02WWzkiHq7gCH+
	gAD/uXZshSpYHef8ECvf0gGkXMF0MtIsVjIVX2SDE68UCYUpSbLfwg3oKJdt
X-Google-Smtp-Source: AGHT+IH9UZSAnhCsMx9MvtdFjJC2LyfA9DQa3xzW6lHppJmeOQJX0mqL4ZkOF/cyhNCCsNgC4raxBw==
X-Received: by 2002:a05:600c:4aa9:b0:426:62c5:4731 with SMTP id 5b1f17b1804b1-429ed7d648cmr2248045e9.29.1723747006711;
        Thu, 15 Aug 2024 11:36:46 -0700 (PDT)
Received: from laptop.. (117.red-83-52-251.dynamicip.rima-tde.net. [83.52.251.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded19839sm57949905e9.6.2024.08.15.11.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 11:36:46 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: stable@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Manas Ghandat <ghandatmanas@gmail.com>,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
Subject: [PATCH 6.2.y] jfs: define xtree root and page independently
Date: Thu, 15 Aug 2024 20:36:41 +0200
Message-Id: <20240815183641.7875-1-sergio.collado@gmail.com>
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
index 390cbfce391f..85918c0d852b 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -669,7 +669,7 @@ int diWrite(tid_t tid, struct inode *ip)
 		 * This is the special xtree inside the directory for storing
 		 * the directory table
 		 */
-		xtpage_t *p, *xp;
+		xtroot_t *p, *xp;
 		xad_t *xad;
 
 		jfs_ip->xtlid = 0;
@@ -683,7 +683,7 @@ int diWrite(tid_t tid, struct inode *ip)
 		 * copy xtree root from inode to dinode:
 		 */
 		p = &jfs_ip->i_xtroot;
-		xp = (xtpage_t *) &dp->di_dirtable;
+		xp = (xtroot_t *) &dp->di_dirtable;
 		lv = ilinelock->lv;
 		for (n = 0; n < ilinelock->index; n++, lv++) {
 			memcpy(&xp->xad[lv->offset], &p->xad[lv->offset],
@@ -712,7 +712,7 @@ int diWrite(tid_t tid, struct inode *ip)
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
index ffd4feece078..997cc1b9e628 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -778,7 +778,7 @@ struct tlock *txLock(tid_t tid, struct inode *ip, struct metapage * mp,
 			if (mp->xflag & COMMIT_PAGE)
 				p = (xtpage_t *) mp->data;
 			else
-				p = &jfs_ip->i_xtroot;
+				p = (xtpage_t *) &jfs_ip->i_xtroot;
 			xtlck->lwm.offset =
 			    le16_to_cpu(p->header.nextindex);
 		}
@@ -1671,7 +1671,7 @@ static void xtLog(struct jfs_log * log, struct tblock * tblk, struct lrd * lrd,
 
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
index ad7592191d76..0f6cf5a1ce75 100644
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

base-commit: 46df6964c1a9eb72027710f626cb1c6bfb5d58c9
-- 
2.39.2


