Return-Path: <stable+bounces-233146-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEMPNpJWz2llvQYAu9opvQ
	(envelope-from <stable+bounces-233146-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 07:56:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9416D391484
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 07:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89AAC308E48E
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 05:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922EE352C4F;
	Fri,  3 Apr 2026 05:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="QLcXtchu"
X-Original-To: stable@vger.kernel.org
Received: from out30-82.freemail.mail.aliyun.com (out30-82.freemail.mail.aliyun.com [115.124.30.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CA3346FB0
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 05:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775195577; cv=none; b=Bd/ZOuLHryoFWSJN+xwwSNxIXCBV4ygXlBYiI503JFZB0s8onKfPZJPlYgMevdemkMtCw2Y38pMrSyVL0Z9q0llV2PMQMOVSgdrdycZlqxxCZVE7UZt/tBGQvOjk+pLwun7Na3Y7cAsbXfARmweYVdcQ55S/1Cevq3sMvn3XxsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775195577; c=relaxed/simple;
	bh=K+1Vk/EScwzbYzFH2PwVne4ZUe89t9TnyUXhoOtmmeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oPbLuRQLeKCwm0KWCeVQJHIWqJHOBibIFMpPDHqReN7h+HXXhYMgN/qgVLNs+IA89j4L/qEmK4MIhSQYXPsDhunwPIQUa9KH+sinrVi2PhJeXS6fQP50cZq2ZqSUPfi5g1P8c0qp29X9OxlmHS0pAT7Ni6hJ6eDuI2GL3tkbkYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=QLcXtchu; arc=none smtp.client-ip=115.124.30.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1775195569; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=F14/zbN3MzqJprfKOVCmDvcD1KixWC33CEkNXyYB7Nc=;
	b=QLcXtchuAAMcsm3fszXJo5+b9sKtKvqhdXaZyC5pzhSV31GYNiiTlQc6FtldIOrnTbN5QUmIqc+ABXNyj4pJ14bp2RksBhrtjL9xanxIrFjLQIW8RM5uRAmlPEM1s/n25znmxo6ks1Kh6g9vadX1CRl6KwJ48QM/ODrY1ni3/4U=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07357557|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.031584-0.000368737-0.968047;FP=10562964253813786066|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=ruohanlan@aliyun.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---0X0JIJ0c_1775195566;
Received: from Ubuntu24(mailfrom:ruohanlan@aliyun.com fp:SMTPD_---0X0JIJ0c_1775195566 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Apr 2026 13:52:49 +0800
From: Ruohan Lan <ruohanlan@aliyun.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: gfs2@lists.linux.dev,
	Andrew Price <anprice@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Ruohan Lan <ruohanlan@aliyun.com>
Subject: [PATCH 6.6.y 1/2] gfs2: Improve gfs2_consist_inode() usage
Date: Fri,  3 Apr 2026 13:51:53 +0800
Message-ID: <20260403055154.4206-1-ruohanlan@aliyun.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[aliyun.com,reject];
	R_DKIM_ALLOW(-0.20)[aliyun.com:s=s1024];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[aliyun.com];
	TAGGED_FROM(0.00)[bounces-233146-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[aliyun.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruohanlan@aliyun.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.linux.dev,redhat.com,aliyun.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9416D391484
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Andrew Price <anprice@redhat.com>

[ Upstream commit 10398ef57aa189153406c110f5957145030f08fe ]

gfs2_consist_inode() logs an error message with the source file and line
number. When we jump before calling it, the line number becomes less
useful as it no longer relates to the source of the error. To aid
troubleshooting, replace the gotos with the gfs2_consist_inode() calls
so that the error messages are more informative.

Signed-off-by: Andrew Price <anprice@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Ruohan Lan <ruohanlan@aliyun.com>
---
 fs/gfs2/dir.c   | 31 +++++++++++++++++--------------
 fs/gfs2/glops.c | 34 ++++++++++++++++++++--------------
 fs/gfs2/xattr.c | 28 ++++++++++++++++------------
 3 files changed, 53 insertions(+), 40 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 3a2a10d6d43d..c252400e5999 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -562,15 +562,18 @@ static struct gfs2_dirent *gfs2_dirent_scan(struct inode *inode, void *buf,
 	int ret = 0;
 
 	ret = gfs2_dirent_offset(GFS2_SB(inode), buf);
-	if (ret < 0)
-		goto consist_inode;
-
+	if (ret < 0) {
+		gfs2_consist_inode(GFS2_I(inode));
+		return ERR_PTR(-EIO);
+	}
 	offset = ret;
 	prev = NULL;
 	dent = buf + offset;
 	size = be16_to_cpu(dent->de_rec_len);
-	if (gfs2_check_dirent(GFS2_SB(inode), dent, offset, size, len, 1))
-		goto consist_inode;
+	if (gfs2_check_dirent(GFS2_SB(inode), dent, offset, size, len, 1)) {
+		gfs2_consist_inode(GFS2_I(inode));
+		return ERR_PTR(-EIO);
+	}
 	do {
 		ret = scan(dent, name, opaque);
 		if (ret)
@@ -582,8 +585,10 @@ static struct gfs2_dirent *gfs2_dirent_scan(struct inode *inode, void *buf,
 		dent = buf + offset;
 		size = be16_to_cpu(dent->de_rec_len);
 		if (gfs2_check_dirent(GFS2_SB(inode), dent, offset, size,
-				      len, 0))
-			goto consist_inode;
+				      len, 0)) {
+			gfs2_consist_inode(GFS2_I(inode));
+			return ERR_PTR(-EIO);
+		}
 	} while(1);
 
 	switch(ret) {
@@ -597,10 +602,6 @@ static struct gfs2_dirent *gfs2_dirent_scan(struct inode *inode, void *buf,
 		BUG_ON(ret > 0);
 		return ERR_PTR(ret);
 	}
-
-consist_inode:
-	gfs2_consist_inode(GFS2_I(inode));
-	return ERR_PTR(-EIO);
 }
 
 static int dirent_check_reclen(struct gfs2_inode *dip,
@@ -609,14 +610,16 @@ static int dirent_check_reclen(struct gfs2_inode *dip,
 	const void *ptr = d;
 	u16 rec_len = be16_to_cpu(d->de_rec_len);
 
-	if (unlikely(rec_len < sizeof(struct gfs2_dirent)))
-		goto broken;
+	if (unlikely(rec_len < sizeof(struct gfs2_dirent))) {
+		gfs2_consist_inode(dip);
+		return -EIO;
+	}
 	ptr += rec_len;
 	if (ptr < end_p)
 		return rec_len;
 	if (ptr == end_p)
 		return -ENOENT;
-broken:
+
 	gfs2_consist_inode(dip);
 	return -EIO;
 }
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 4a169c60bce6..2ec0b6871ae9 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -412,10 +412,14 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	struct inode *inode = &ip->i_inode;
 	bool is_new = inode->i_state & I_NEW;
 
-	if (unlikely(ip->i_no_addr != be64_to_cpu(str->di_num.no_addr)))
-		goto corrupt;
-	if (unlikely(!is_new && inode_wrong_type(inode, mode)))
-		goto corrupt;
+	if (unlikely(ip->i_no_addr != be64_to_cpu(str->di_num.no_addr))) {
+		gfs2_consist_inode(ip);
+		return -EIO;
+	}
+	if (unlikely(!is_new && inode_wrong_type(inode, mode))) {
+		gfs2_consist_inode(ip);
+		return -EIO;
+	}
 	ip->i_no_formal_ino = be64_to_cpu(str->di_num.no_formal_ino);
 	inode->i_mode = mode;
 	if (is_new) {
@@ -451,26 +455,28 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	/* i_diskflags and i_eattr must be set before gfs2_set_inode_flags() */
 	gfs2_set_inode_flags(inode);
 	height = be16_to_cpu(str->di_height);
-	if (unlikely(height > sdp->sd_max_height))
-		goto corrupt;
+	if (unlikely(height > sdp->sd_max_height)) {
+		gfs2_consist_inode(ip);
+		return -EIO;
+	}
 	ip->i_height = (u8)height;
 
 	depth = be16_to_cpu(str->di_depth);
-	if (unlikely(depth > GFS2_DIR_MAX_DEPTH))
-		goto corrupt;
+	if (unlikely(depth > GFS2_DIR_MAX_DEPTH)) {
+		gfs2_consist_inode(ip);
+		return -EIO;
+	}
 	ip->i_depth = (u8)depth;
 	ip->i_entries = be32_to_cpu(str->di_entries);
 
-	if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_size(ip))
-		goto corrupt;
-
+	if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_size(ip)) {
+		gfs2_consist_inode(ip);
+		return -EIO;
+	}
 	if (S_ISREG(inode->i_mode))
 		gfs2_set_aops(inode);
 
 	return 0;
-corrupt:
-	gfs2_consist_inode(ip);
-	return -EIO;
 }
 
 /**
diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
index 2117011c8c57..27b9dd1179c2 100644
--- a/fs/gfs2/xattr.c
+++ b/fs/gfs2/xattr.c
@@ -96,30 +96,34 @@ static int ea_foreach_i(struct gfs2_inode *ip, struct buffer_head *bh,
 		return -EIO;
 
 	for (ea = GFS2_EA_BH2FIRST(bh);; prev = ea, ea = GFS2_EA2NEXT(ea)) {
-		if (!GFS2_EA_REC_LEN(ea))
-			goto fail;
+		if (!GFS2_EA_REC_LEN(ea)) {
+			gfs2_consist_inode(ip);
+			return -EIO;
+		}
 		if (!(bh->b_data <= (char *)ea && (char *)GFS2_EA2NEXT(ea) <=
-						  bh->b_data + bh->b_size))
-			goto fail;
-		if (!gfs2_eatype_valid(sdp, ea->ea_type))
-			goto fail;
+						  bh->b_data + bh->b_size)) {
+			gfs2_consist_inode(ip);
+			return -EIO;
+		}
+		if (!gfs2_eatype_valid(sdp, ea->ea_type)) {
+			gfs2_consist_inode(ip);
+			return -EIO;
+		}
 		error = ea_call(ip, bh, ea, prev, data);
 		if (error)
 			return error;
 
 		if (GFS2_EA_IS_LAST(ea)) {
 			if ((char *)GFS2_EA2NEXT(ea) !=
-			    bh->b_data + bh->b_size)
-				goto fail;
+			    bh->b_data + bh->b_size) {
+				gfs2_consist_inode(ip);
+				return -EIO;
+			}
 			break;
 		}
 	}
 
 	return error;
-
-fail:
-	gfs2_consist_inode(ip);
-	return -EIO;
 }
 
 static int ea_foreach(struct gfs2_inode *ip, ea_call_t ea_call, void *data)
-- 
2.43.0


