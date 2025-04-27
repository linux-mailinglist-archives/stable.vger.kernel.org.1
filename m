Return-Path: <stable+bounces-136789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E22A9E3CB
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 17:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90FA3B3E9A
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 15:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327C61C862E;
	Sun, 27 Apr 2025 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjhlHiwn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72716155C97;
	Sun, 27 Apr 2025 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745768754; cv=none; b=Sl7HP+oQtysoDDCQ/9NbuEPqmxKSBKEJehcnDQqOXkH6I6tBg5581Wnvnz9Qt9GO20bcFr1vTFbEF+rCxcmOI/BpVbMQz30B/4bEXf5SxKPP8t0/Xp/uahc6AO8OqVNSWJfs7MK4RJi5q4KvAOlnvjjlT6ha+4HItTbSBMSYKa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745768754; c=relaxed/simple;
	bh=LufHX8cplyfE6bc3Dn2Ou09jkpw5XXBf57Zw6V2jIiA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R0WIyApAfBaujMdWSFp22f5RNOrJ4jsa9YAeqD2XD86XW/6B8oG55x0eToOlmnSTHDi365UnxxgxOio2yW+L1EzqV4oUpAd5nbmm/NDWg2jEXIkJRhABDVoWrO3DDzhK2OO0hNfoQWVxiauQkaYwvIAvoGCxv3P0RrftcNwJusM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjhlHiwn; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-30572effb26so3439542a91.0;
        Sun, 27 Apr 2025 08:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745768751; x=1746373551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7H3CGfdKeQmA85O5UdRYRS4BFpY8FBaukpxGzuJa2pw=;
        b=SjhlHiwn7mRUazhZbkRyR3rAct5zo/dqCmun/QeXos/V6ltI75pUHtWCDL5DL5i0hJ
         qhEDZqpqNrUKufuzjgOjtTq8AixYo44UpaEy2ne6zbsUqua26B7MkkeB64ZQyCTfdbB1
         NO3v6BXWmcQeJkUhIP/C03R6jC4aKR90Q8vic5CG6n1W4YedCKYPoECq4zlwVHVeeaei
         m/nwEfPU4LqHhRuOg01pnnP7Ul3k7chVc3umgu69nRoSZFw7w4C7tCAemYmR77cIFHPf
         cUEqjkU36BFDNnTtNDa/B3hh17/+FgaCzjbH9iYRd1u3DAXOyvYOqDvgdizhQZZYedvk
         reCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745768751; x=1746373551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7H3CGfdKeQmA85O5UdRYRS4BFpY8FBaukpxGzuJa2pw=;
        b=IvcRtM4ohXei5lx8oNGgh/f2jseaaDpIj6a5WgRd9xfSQmR7/Z7P3E/I79i31sSEtQ
         2vnFDHcVgFzcUcjML0gBPqY/EUBYpzwLpCKDoxj6+YHOiq8WxGytykoQxmeNKrNfzDqW
         xgtPYcxclzdXzQ1CBmkW2FkBRomKiPz/o2Pl8Qc7wKnrLDzia7PLCSI2uHcjI6taqMtf
         z5EhZfyXUmIyIke59Ze5F3tY7CjxAwiaJnk6CEOvULhQFahI08qVXICQVAHKIhA5a0cy
         19R1+ZV3lOKVTqGZjL4qks6SWZs0Ue4uK2045MqEDC6Cd15KTT700MFT7+baEmQo41Gk
         SV8w==
X-Forwarded-Encrypted: i=1; AJvYcCUxo8WzlNMfJE/1waDgptJ5apY5ESZJSGmnt85QtsbcWpaO/yTPON8/pHLEK6KdH53itnYzorWwhVpEt80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz9DmGnk7YlpfjeZ0BMmhpSkB3kvOa5IYMUb1vkLWjuiZDBmnT
	5sA52sLDcZxtz/7Pq+xZQgsn21aWn7Dv6bIWycIFecYqiCKwyIdC1dXj04cu
X-Gm-Gg: ASbGnctK8wLd6rRjBqEOQHIJDWAJIdq8KgWp49+NYUQBaye6m/IONzB4AyNVvGfzV76
	6z4Nlj3OnsPKrHVdug7oBn7rl8vOaCCeK9IUWeViZVBgXbfsww4rY9OFjaUjQb3Lp3F45Z7Z1K3
	pJXkyQHrQMtQs9D/TAmueByLFfmqh/exbevbOPEqRV4KrTUvV/y2C6ZYAOYAmjvXvq7SOj7bNRC
	cK+w3Mw1BaghCH1K09LAhr1ln/M4hPRnKIuAiCcE1HSOH3nMqKYPdCe6i7FFlxZ454zDiVfHaaU
	skYv4iIC96uOXHRrCHMLF74dZie1vKO6e1jCyDw1
X-Google-Smtp-Source: AGHT+IHq2GiUl5vh/UvTDKS1xTbiflFzANxoGSTrV8i3Ib/1ucPJH61yRREAPJwoNXjzQr/QYwNVuA==
X-Received: by 2002:a17:90b:520f:b0:2f9:c139:b61f with SMTP id 98e67ed59e1d1-309f8d9b077mr14393324a91.14.1745768751500;
        Sun, 27 Apr 2025 08:45:51 -0700 (PDT)
Received: from pop-os.. ([49.207.200.116])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef061acdsm7150108a91.16.2025.04.27.08.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 08:45:51 -0700 (PDT)
From: Aditya Dutt <duttaditya18@gmail.com>
To: stable@vger.kernel.org
Cc: Dave Kleikamp <dave.kleikamp@oracle.com>,
	Dave Kleikamp <shaggy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	jfs-discussion@lists.sourceforge.net,
	skhan@linuxfoundation.org,
	Manas Ghandat <ghandatmanas@gmail.com>,
	syzbot+ccb458b6679845ee0bae@syzkaller.appspotmail.com,
	Aditya Dutt <duttaditya18@gmail.com>
Subject: [PATCH 5.15.y] jfs: define xtree root and page independently
Date: Sun, 27 Apr 2025 21:15:39 +0530
Message-Id: <20250427154539.96678-1-duttaditya18@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Kleikamp <dave.kleikamp@oracle.com>

[ Upstream commit a779ed754e52d582b8c0e17959df063108bd0656 ]

In order to make array bounds checking sane, provide a separate
definition of the in-inode xtree root and the external xtree page.

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Tested-by: Manas Ghandat <ghandatmanas@gmail.com>
(cherry picked from commit a779ed754e52d582b8c0e17959df063108bd0656)
Closes: https://syzkaller.appspot.com/bug?extid=ccb458b6679845ee0bae
Reported-by: syzbot+ccb458b6679845ee0bae@syzkaller.appspotmail.com
Signed-off-by: Aditya Dutt <duttaditya18@gmail.com>
---
I am sending this as per the suggestion by Greg to submit backports for
all the relevant stable trees:
https://lore.kernel.org/stable/2025042210-stylized-nearest-ea59@gregkh/
This patch has been applied in >= 6.12
and has been backported to 6.6: 2ff51719ec615e1b373c1811443efe93594c41a9
I have already sent a mail for 6.1:
https://lore.kernel.org/stable/20250427153045.90396-1-duttaditya18@gmail.com/

syzbot checked the patch against 5.15.y and confirmed that the
reproducer did not trigger any issues. check here:
https://lore.kernel.org/lkml/67fea0bf.050a0220.186b78.0006.GAE@google.com/

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
index c72e97f06579..0e7d2662f202 100644
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
index 6c8680d3907a..3a547e0b934f 100644
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
@@ -1710,7 +1710,7 @@ static void xtLog(struct jfs_log * log, struct tblock * tblk, struct lrd * lrd,
 
 	if (tlck->type & tlckBTROOT) {
 		lrd->log.redopage.type |= cpu_to_le16(LOG_BTROOT);
-		p = &JFS_IP(ip)->i_xtroot;
+		p = (xtpage_t *) &JFS_IP(ip)->i_xtroot;
 		if (S_ISDIR(ip->i_mode))
 			lrd->log.redopage.type |=
 			    cpu_to_le16(LOG_DIR_XTREE);
diff --git a/fs/jfs/jfs_xtree.c b/fs/jfs/jfs_xtree.c
index 3148e9b35f3b..34db519933b4 100644
--- a/fs/jfs/jfs_xtree.c
+++ b/fs/jfs/jfs_xtree.c
@@ -1224,7 +1224,7 @@ xtSplitRoot(tid_t tid,
 	struct xtlock *xtlck;
 	int rc;
 
-	sp = &JFS_IP(ip)->i_xtroot;
+	sp = (xtpage_t *) &JFS_IP(ip)->i_xtroot;
 
 	INCREMENT(xtStat.split);
 
@@ -3059,7 +3059,7 @@ static int xtRelink(tid_t tid, struct inode *ip, xtpage_t * p)
  */
 void xtInitRoot(tid_t tid, struct inode *ip)
 {
-	xtpage_t *p;
+	xtroot_t *p;
 
 	/*
 	 * acquire a transaction lock on the root
diff --git a/fs/jfs/jfs_xtree.h b/fs/jfs/jfs_xtree.h
index 5f51be8596b3..dc9b5f8d6385 100644
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
2.34.1


