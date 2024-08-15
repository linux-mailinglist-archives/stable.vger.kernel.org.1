Return-Path: <stable+bounces-69241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA66C953AA4
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 21:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DDD01F23BCC
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 19:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7567710F;
	Thu, 15 Aug 2024 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5ZfmP8J"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6926256B72
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 19:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723749062; cv=none; b=AeXLJqQax9MeQniwEtVhGQEphLBsl1sPtXcqsves8Jw/5PKO7uuGJl3SHwkmUzPFcTtoJD4QqRNt9p4H+1jlkaXviqaZPdisBQ9be+PucNuTLRkkFXEon7QE6AqKx54rNP4RYQ5iYpEMAgahGnrmyiMGnngs1FD/eqynXUasAXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723749062; c=relaxed/simple;
	bh=IvqiAKfSVYJv0+vHHR6tnTLJ+5hBsObUakXHw8ISKdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=V6pVPCTQKMikI/pmDSwNzlfaivtEreUNXLEbpz8FXd97ATHok7vbDQPfE3XW6NjSRXAulV0TNrDck6fIOQ0I+Tc6IvWjyLHmPObC6QviRCmPvI8Iyb0o2pKjWAuHBAIUNxSffs1smi1pDDbFhLqqPuxhVbQcmSQ+rUrXrX4eMro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5ZfmP8J; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-367990aaef3so687470f8f.0
        for <stable@vger.kernel.org>; Thu, 15 Aug 2024 12:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723749058; x=1724353858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wzku6EqezrhV/Q1Jipsbt19i41hvIhfl+s6YKEhDhTI=;
        b=E5ZfmP8JZxTEaaGJv/uJ2Exr/7z+5spXwzvj5/J7c5TnHzgfB8Y5kEdVxo37ysUq2t
         03sHKqBjy7mV0cnA9N2T5xwsbSC8C4qXrYJWrhnqfc8dc1Y9Avqnsg2rrulVqjb9vw7c
         lCCIcNQAVXYzntaYLxCdYnad3IH9JJY1vE5V3d7h/lB5bw4m7FHvUe3u909WMZ52ku79
         xcOiDp74v3Bgf9JKiJi0sEthB0T+iMHbzI69jbXQYrOn73VNgMOIvQjRvkEBMUEHayS8
         oJBMnVmBJWe3u9xEBLrFDxCPeEFTLP2cctS4+XivlRKPCfqsaDtshRTTBljA4CKI6ZHA
         XMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723749058; x=1724353858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wzku6EqezrhV/Q1Jipsbt19i41hvIhfl+s6YKEhDhTI=;
        b=wxEpkbtJdn6u1gihvlgF3NT7rX+IW05zATCUwWSvu3byXQUbzTaayFMT2PbmOm6h8a
         hFjgPLr1f9WmwoxoeHlkhHeKXPfVXyrKCqnWlIg9yStZqJOlFbBQHYATepZy0rUUvCQL
         DoKmnp/jJIB7mMuHORe8cWt1vob/BvBCJilL1G72H6atAXoZy8I7bPlWDltX2Q3rdYCa
         4EFbBY/D3axHOoq25TbhGX6t9S2suftIBzTPqCJAGlsJd6+CXSkmzerj29cjCI11pUs9
         Hm0A5WoQ0slIa0FsDMZMWdLovatGLQ7HxOqVEYFddTcBajotYBoiHp2qW3yY85xFM/OL
         UhLA==
X-Gm-Message-State: AOJu0YwjgXexLB/693oXxb1s6n7PvKCRA5oCIvO9bW8Zi+pks/zu7C1h
	EeD6uCnwaVqtZvv2Gn4XS3p3yVOng9s1+dkpLeLkk0fD50/x4vf9OmSafUVv
X-Google-Smtp-Source: AGHT+IHiVgV0zFMQ13way+COh1ffrR+TuDlypF9+LtJeEGw2clSGESWqowQb3iQYb3Itp2FfMw43Ew==
X-Received: by 2002:adf:e841:0:b0:368:420e:b790 with SMTP id ffacd0b85a97d-371943289e7mr217621f8f.14.1723749058112;
        Thu, 15 Aug 2024 12:10:58 -0700 (PDT)
Received: from laptop.. (117.red-83-52-251.dynamicip.rima-tde.net. [83.52.251.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded180dcsm56393475e9.4.2024.08.15.12.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 12:10:57 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: stable@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Manas Ghandat <ghandatmanas@gmail.com>,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
Subject: [PATCH 6.6.y] jfs: define xtree root and page independently
Date: Thu, 15 Aug 2024 21:10:47 +0200
Message-Id: <20240815191047.9737-1-sergio.collado@gmail.com>
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
index 4bc589c4dcca..82d88dcf0ea6 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -673,7 +673,7 @@ int diWrite(tid_t tid, struct inode *ip)
 		 * This is the special xtree inside the directory for storing
 		 * the directory table
 		 */
-		xtpage_t *p, *xp;
+		xtroot_t *p, *xp;
 		xad_t *xad;
 
 		jfs_ip->xtlid = 0;
@@ -687,7 +687,7 @@ int diWrite(tid_t tid, struct inode *ip)
 		 * copy xtree root from inode to dinode:
 		 */
 		p = &jfs_ip->i_xtroot;
-		xp = (xtpage_t *) &dp->di_dirtable;
+		xp = (xtroot_t *) &dp->di_dirtable;
 		lv = ilinelock->lv;
 		for (n = 0; n < ilinelock->index; n++, lv++) {
 			memcpy(&xp->xad[lv->offset], &p->xad[lv->offset],
@@ -716,7 +716,7 @@ int diWrite(tid_t tid, struct inode *ip)
 	 *	regular file: 16 byte (XAD slot) granularity
 	 */
 	if (type & tlckXTREE) {
-		xtpage_t *p, *xp;
+		xtroot_t *p, *xp;
 		xad_t *xad;
 
 		/*
diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
index d3c35068cb76..10934f9a11be 100644
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

base-commit: 99fd042016c7489192d05ff21a10620c2142301d
-- 
2.39.2


