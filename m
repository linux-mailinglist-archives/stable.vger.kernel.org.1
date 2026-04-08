Return-Path: <stable+bounces-234434-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMTMEDWi1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234434-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:45:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C143C16DB
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC9D93082AB2
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356583537EF;
	Wed,  8 Apr 2026 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mhKdR+eN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39B83D4129;
	Wed,  8 Apr 2026 18:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672850; cv=none; b=jmUS/+hrCFJMwZBp85uEwWk7Rz2eb1l48K2r847BkmKVbNyMsJaiRrNOQGEg3tFlM+StnuRPnsYocSXtKVlSj3OyGaDnXTpwXrGNM1xlUk54oUpR6qOCDDrKzEZniIHs/uXULAuCsYMIIf7R+cKpHJ6vDctjGkgyG4afyv8mQZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672850; c=relaxed/simple;
	bh=HIM1rxevO2VGdOddG+iublYCMXC1QgGKm7TVthoAzfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPIl6E9FBs6Km+LciKKC2fIC+HsTLPjBPvuRGiKZLjttvQVCAr8CLfbXivalaMZ4cB4+uxdYf+3kxIUZ5cJMQJ7ihltyzdJHCr2ZG60NtMkO2cXKhySANS/ajo7J8eWVZyDo8eCFen/rZYAgNEFxnnz/reDuDS7BYyUrPzoSny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mhKdR+eN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF76C19421;
	Wed,  8 Apr 2026 18:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672849;
	bh=HIM1rxevO2VGdOddG+iublYCMXC1QgGKm7TVthoAzfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mhKdR+eNoqeslZseZ47Cypyke/qTorcO9OVo0FgDnUC1YNHB7DxpkT6j0HV1FzFXL
	 Sp6FMzyYMix0YHSYtZmecrkA5h/N3mFSDo5VNcpif+T2v7Sm31K7BCp7BrIUsSEk6/
	 kcxbey5CO6sICw/CxvWNrUPwITEnKGIR7XPKXr9A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Price <anprice@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Ruohan Lan <ruohanlan@aliyun.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 139/160] gfs2: Improve gfs2_consist_inode() usage
Date: Wed,  8 Apr 2026 20:03:46 +0200
Message-ID: <20260408175918.376987838@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175913.177092714@linuxfoundation.org>
References: <20260408175913.177092714@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,redhat.com,aliyun.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-234434-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,aliyun.com:email]
X-Rspamd-Queue-Id: B7C143C16DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/dir.c   | 31 +++++++++++++++++--------------
 fs/gfs2/glops.c | 34 ++++++++++++++++++++--------------
 fs/gfs2/xattr.c | 28 ++++++++++++++++------------
 3 files changed, 53 insertions(+), 40 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 3a2a10d6d43d1..c252400e59994 100644
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
index 4a169c60bce65..2ec0b6871ae94 100644
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
index 2117011c8c577..27b9dd1179c26 100644
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
2.53.0




