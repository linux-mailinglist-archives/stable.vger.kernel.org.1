Return-Path: <stable+bounces-136788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD869A9E3C1
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 17:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307D8177B63
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 15:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6551A5BA6;
	Sun, 27 Apr 2025 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv9oeUZ/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4412635280;
	Sun, 27 Apr 2025 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745767860; cv=none; b=jwLRE9dGLi8g2PVLOi5iDk6mN0XguIYrvL/m5Owvn4gWziZdnI7kABFhsUFMue+EckVjnJtz/pbQv4m5bnPiSNd+WjHgBaxwgvtW6H4M0LsFJb64T4Pa4ItQjMPCngfLWu9J6vWABVRlaoiR1xkdOY976NkYCusU4jWlU8yI9ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745767860; c=relaxed/simple;
	bh=edPLn501f0ij89POdqKIVj6Bny2sztnFljJiPHHgJ2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XY+szBotRd05K3LLkJogolr7hqb6d4G2S20T3yz0QZtQNx41lBu0KHtmnHzOBLDgxtfwKfzk65hkvZzhC7Gs2wByLdn89DLOva2QAKzwx2ICwk0ymDyxV1BDg+pWll3osV3juSl8WPQtTmKl3sWhOb2T8id+aPxYu8CRgALLkQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hv9oeUZ/; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-af590aea813so4760002a12.0;
        Sun, 27 Apr 2025 08:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745767858; x=1746372658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lu0Qpy32cRnk6C00xSOjQCLbKsFc+72PU0/zEKOJ4OM=;
        b=Hv9oeUZ/hFJhHeGXxkkwYxgHOdILUjo4k7Y6YMoIV7zcrNVyYBBu73b2iQV7co/Amt
         sHX/+3TqbJIXG6pR8IS747T9+3vDFzKT6W3DIFw69CamHgG/xuJHvP/QVwpNmogvd8Dx
         fiJbQkAU/ktDtpVLt19Yx7X+A/+9/nBtLo9bAxQa1TJl+f72v8rRyiz4Kwdjga6WNXxz
         gQia5ALBnIxyd7AD8dMBDnLSwMBlF79ISDEXxNMkq7AUQ6/yCslPwoUg3bPdwftjSwZh
         m4pKpyOQA/gp0GkqMTd76KBES0MrT/L5AWEL4HAcd59zdsz8oXhoZ8t+hqE24UwI9A+4
         84bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745767858; x=1746372658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lu0Qpy32cRnk6C00xSOjQCLbKsFc+72PU0/zEKOJ4OM=;
        b=XS+mWxRiynx3O++D284jRtiOJ+07dSQtN0wXZQ1mUMEb9FfZKca0HBzjIxn+4K8DWM
         1vdzEq8fmt/3bb7s+9ttaab8+vrAauP0QjDAQMAwif/iilUGbI7PyoEzlK4Iex9UrmEi
         1LCwJ0IFHdbRboEE6mUhmlShxn54wSpRWibmJDpBM/3c5pHpcZvZaM4u3zACDObqvsWR
         lHqLnBuDzpF+lES5K7sa6PkUW9iV64WTQ/RGK3du51SKbkEol1dsacPA5y8H1UVWNsWp
         B7kj64p6hLuK2WQhkyzP6aWDgcmEudY+qs2TjehEnrUDAjajJwKfrGhcWKYSO/Ovxp/X
         zIxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJYj4UJTe649DCZZUNXDe30X+uoKiTMSMZahjq4Bio2UBe6dJkq1wzpverz5VQPVPUkxd4cPm/Yt8uzzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu59xGwmIV7G5h0lQ01/V3rhOjMVXJThDbaQi4/Z+gfrPI/sOC
	JzyzS+obtHRzMyujFgDAzjgx8LJE/mYu4U3Kj4acPbj0Kcgh66QjogIjDsxp
X-Gm-Gg: ASbGnct0syVP6tWyEZ26zmOFz7cKPtWrPa08m2XCrmH2fIBZOkeKgs4FZZMCGQBtzUN
	NXXqpFlW5jJ0epJeMpC5mBfpbkKA2vOwUzxOC9hfPiPZOvZL4Zo23fSJzBNmSakqD1YTd1VGLo7
	IZ9EoV8kODZ01F11iwIdVpfRD9cqqYlE/ge4uLxmKHexHYoy8ttm5jSJsldvjZXAOt6xv1pY9e5
	qpjeE0Mi9JEYjvCBYscLUzfR+3gi9SDOCiGOxO5zLHxnOVb0EzuzelgIxHbMYBazREJctgKli1W
	wKSpcYXniJYWwfrNwdy3p8tX3P7DHh9ItQsx9EAX
X-Google-Smtp-Source: AGHT+IE/AIPDBZfGFz35irHOS6OjtJ7DIKKb7ayqgzlXDAwBQDxaFEfBWXiyKUieJQy7r8AAx0p9Cw==
X-Received: by 2002:a17:903:985:b0:221:751f:cfbe with SMTP id d9443c01a7336-22dbf95a2b7mr150173215ad.19.1745767858142;
        Sun, 27 Apr 2025 08:30:58 -0700 (PDT)
Received: from pop-os.. ([49.207.200.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4db99d3sm65549225ad.53.2025.04.27.08.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 08:30:57 -0700 (PDT)
From: Aditya Dutt <duttaditya18@gmail.com>
To: stable@vger.kernel.org
Cc: Dave Kleikamp <dave.kleikamp@oracle.com>,
	Dave Kleikamp <shaggy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	jfs-discussion@lists.sourceforge.net,
	skhan@linuxfoundation.org,
	Manas Ghandat <ghandatmanas@gmail.com>,
	syzbot+7cb897779f3c479d0615@syzkaller.appspotmail.com,
	syzbot+6b1d79dad6cc6b3eef41@syzkaller.appspotmail.com,
	syzbot+67f714a53ce18d5b542e@syzkaller.appspotmail.com,
	syzbot+e829cfdd0de521302df4@syzkaller.appspotmail.com,
	Aditya Dutt <duttaditya18@gmail.com>
Subject: [PATCH 6.1.y] jfs: define xtree root and page independently
Date: Sun, 27 Apr 2025 21:00:45 +0530
Message-Id: <20250427153045.90396-1-duttaditya18@gmail.com>
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
Closes: https://syzkaller.appspot.com/bug?extid=7cb897779f3c479d0615
Closes: https://syzkaller.appspot.com/bug?extid=6b1d79dad6cc6b3eef41
Closes: https://syzkaller.appspot.com/bug?extid=67f714a53ce18d5b542e
Closes: https://syzkaller.appspot.com/bug?extid=e829cfdd0de521302df4
Reported-by: syzbot+7cb897779f3c479d0615@syzkaller.appspotmail.com
Reported-by: syzbot+6b1d79dad6cc6b3eef41@syzkaller.appspotmail.com
Reported-by: syzbot+67f714a53ce18d5b542e@syzkaller.appspotmail.com
Reported-by: syzbot+e829cfdd0de521302df4@syzkaller.appspotmail.com
Signed-off-by: Aditya Dutt <duttaditya18@gmail.com>
---
I am sending this as per the suggestion by Greg to submit backports for
all the relevant stable trees:
https://lore.kernel.org/stable/2025042210-stylized-nearest-ea59@gregkh/
I will send one more mail for 5.15.
This patch has been applied in >= 6.12
and has been backported to 6.6: 2ff51719ec615e1b373c1811443efe93594c41a9

syzbot checked the patch against 6.1.y and confirmed that the
reproducer did not trigger any issues. check here:
https://lore.kernel.org/all/680e4455.050a0220.3b8549.0082.GAE@google.com/

I also tested the patch manually using the C reproducer:
https://syzkaller.appspot.com/text?tag=ReproC&x=15b291ef680000
(given in the syzkaller dashboard link)

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
index 155f66812934..9adb29e7862c 100644
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
2.34.1


