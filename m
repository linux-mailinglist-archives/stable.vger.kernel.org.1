Return-Path: <stable+bounces-242493-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOheL5f19GlPGAIAu9opvQ
	(envelope-from <stable+bounces-242493-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 20:48:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCEC4AEF27
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 20:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7215300F1AA
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 18:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FDF346E46;
	Fri,  1 May 2026 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aii+LDrK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7CC31E859
	for <stable@vger.kernel.org>; Fri,  1 May 2026 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777661331; cv=none; b=SL8pFo4N4J8p8MllgDw0+HW4tz6eXcyGCGpZYQFD0fLynYwxHg6SkuiugagYqbzopigjvFzAym/4+Cn4UoN5gJjtF7frnraeJHWNIFV3M558lt4PTx6gpGkimueE5FsSOeU2Y1LfMlK83BxNwhJMXcufBGR5GKgp8NpCXXdAVI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777661331; c=relaxed/simple;
	bh=gYnb7Jq9ftgMwuQd4K5MxKy484unnCjE/r0RYBunGuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZV4S0KrojEXoPeRCvdbBw09RRUCdbqqNjSq9B+RjCJrllxYwPlMxZB1uYrPcAAr+7zxgItr4TtOTmiOyq4ZdqVQ0Vt7Xlo+BYcXusZ9SHcCLMSEX6+CwwaWr1VOY0yU+U9MUSHtn2F85nVKxSjatvlpTHAUtknymdSqJ3qVgZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aii+LDrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CD3C2BCB4;
	Fri,  1 May 2026 18:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777661330;
	bh=gYnb7Jq9ftgMwuQd4K5MxKy484unnCjE/r0RYBunGuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aii+LDrKzg4yNB+JItzvJIqgFkwN1Pws5S6jjLtyjpX/mP5q06eHOLNk4kXKOWbYH
	 hJoBjzCiDlVjbmO+1E7ct8jTz8Umh7lLFKSXLieW5vd6dZjwtERfjl1SbNRxM+KP5N
	 rS1xhG5PtxGdLw30zAReh6fI4Jc+9fJo6ZG7p/yvid6UdH1pwNqxlHI95cOsUCCISl
	 2jWLqtwq7kDOFL44HqpJOYYD9T5h0V+4XTDeR7bUiF79aI0SUBYUttQER9z/u0ow/D
	 /atIPs8+5bNH3tZafK8wk2NSNYovt4acAJ1DdJY561z/w9HyBD1GzoMRvZx8ev3MPd
	 kHbiScaMiQ/ig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	Junrui Luo <moonafterrain@outlook.com>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] erofs: fix the out-of-bounds nameoff handling for trailing dirents
Date: Fri,  1 May 2026 14:48:48 -0400
Message-ID: <20260501184848.3924034-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050132-undercoat-undercoat-0f5b@gregkh>
References: <2026050132-undercoat-undercoat-0f5b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1DCEC4AEF27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,gmail.com,outlook.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242493-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alibaba.com:email,outlook.com:email,sashiko.dev:url]

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit d18a3b5d337fa412a38e776e6b4b857a58836575 ]

Currently we already have boundary-checks for nameoffs, but the trailing
dirents are special since the namelens are calculated with strnlen()
with unchecked nameoffs.

If a crafted EROFS has a trailing dirent with nameoff >= maxsize,
maxsize - nameoff can underflow, causing strnlen() to read past the
directory block.

nameoff0 should also be verified to be a multiple of
`sizeof(struct erofs_dirent)` as well [1].

[1] https://sashiko.dev/#/patchset/20260416063511.3173774-1-hsiangkao%40linux.alibaba.com

Fixes: 3aa8ec716e52 ("staging: erofs: add directory operations")
Fixes: 33bac912840f ("staging: erofs: keep corrupted fs from crashing kernel in erofs_readdir()")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Reported-by: Junrui Luo <moonafterrain@outlook.com>
Closes: https://lore.kernel.org/r/A0FD7E0F-7558-49B0-8BC8-EB1ECDB2479A@outlook.com
Cc: stable@vger.kernel.org
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
[ replaced upstream `bsz` with `PAGE_SIZE` and `sizeof(*de)` with `sizeof(struct erofs_dirent)` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/dir.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index eee9b0b31b639..ac140587505b5 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -37,20 +37,18 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 		nameoff = le16_to_cpu(de->nameoff);
 		de_name = (char *)dentry_blk + nameoff;
 
-		/* the last dirent in the block? */
-		if (de + 1 >= end)
-			de_namelen = strnlen(de_name, maxsize - nameoff);
-		else
+		/* non-trailing dirent in the directory block? */
+		if (de + 1 < end)
 			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
+		else if (maxsize <= nameoff)
+			goto err_bogus;
+		else
+			de_namelen = strnlen(de_name, maxsize - nameoff);
 
-		/* a corrupted entry is found */
-		if (nameoff + de_namelen > maxsize ||
-		    de_namelen > EROFS_NAME_LEN) {
-			erofs_err(dir->i_sb, "bogus dirent @ nid %llu",
-				  EROFS_I(dir)->nid);
-			DBG_BUGON(1);
-			return -EFSCORRUPTED;
-		}
+		/* a corrupted entry is found (including negative namelen) */
+		if (!in_range32(de_namelen, 1, EROFS_NAME_LEN) ||
+		    nameoff + de_namelen > maxsize)
+			goto err_bogus;
 
 		debug_one_dentry(d_type, de_name, de_namelen);
 		if (!dir_emit(ctx, de_name, de_namelen,
@@ -62,6 +60,10 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 	}
 	*ofs = maxsize;
 	return 0;
+err_bogus:
+	erofs_err(dir->i_sb, "bogus dirent @ nid %llu", EROFS_I(dir)->nid);
+	DBG_BUGON(1);
+	return -EFSCORRUPTED;
 }
 
 static int erofs_readdir(struct file *f, struct dir_context *ctx)
@@ -95,8 +97,8 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 
 		nameoff = le16_to_cpu(de->nameoff);
 
-		if (nameoff < sizeof(struct erofs_dirent) ||
-		    nameoff >= PAGE_SIZE) {
+		if (!nameoff || nameoff >= PAGE_SIZE ||
+		    (nameoff % sizeof(struct erofs_dirent))) {
 			erofs_err(dir->i_sb,
 				  "invalid de[0].nameoff %u @ nid %llu",
 				  nameoff, EROFS_I(dir)->nid);
-- 
2.53.0


