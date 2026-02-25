Return-Path: <stable+bounces-219162-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEBnBlJnnmmWVAQAu9opvQ
	(envelope-from <stable+bounces-219162-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:06:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E8D1911C9
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50C76300D74D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C35128DB46;
	Wed, 25 Feb 2026 03:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7riUkrB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EE4433B3
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 03:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771988816; cv=none; b=Uew1T8qFvKMkm9s8MUsTr7F68R5J05x5mpyX/2rWcgE6KabbLnKbZYZ441j/Sqg8IKyzmcyR6zOZk1wATbLCmuJUgZCzDbggdP0PBZ5uOG7t7WZYNJXUd6NBQd96a6H027G2Pxv+YYuAHT1lhkXcjxs6ny6NrF4zLrjaP4ezKN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771988816; c=relaxed/simple;
	bh=Ku/0vfbbULoUvcMDQOn95brfJkmSv7AtWE/kDhzqBqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BP7QXlqYVw1NmQqKTUqmR0hBSqq9QXMTaTTJlx0wzEycKVvdhaCd9E9EVnM3u1qwtqvW3ERWMOpiQBeZLsigIS8YHjIZHEJ1peNwEz3VcZ1tJpXFk+OGLGxTKjYAstvsIFvYpLPxr3w/i9TQ25EA2AJSp2uQxv2y7ao6Alx+les=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7riUkrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7C0C19422;
	Wed, 25 Feb 2026 03:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771988816;
	bh=Ku/0vfbbULoUvcMDQOn95brfJkmSv7AtWE/kDhzqBqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t7riUkrBwBi/6Q3mJ3w2xUtDj/YImzIrYGHh6dKMuNPVLgd2AaogekTmByfqsvI4D
	 ztTcckAO7SS6cRq9dtDfgp8PTcj7F/BruZAD3jFtnJSEWndQOBsCGeDuanqQTMWHbM
	 WkX8KqE2OKIDIYpdDZ9iuNlp2t42aFe2YR9slKVa3+PKi8ae42D0t0racgQZL1mK1Q
	 C8epfOaOllZv+k3unKXpZp4mzs7gt9+0PlnIzAKjOzyJWxUOU1ouMv9RWBdSOnyLDL
	 HAsQujpkZvrkPXPIAogWXEiEES/GF/Yipcq6eye49ssieAGGQY+moaStd3SHBbaFAB
	 DVHY+X0KhJqRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/7] ext4: get rid of ppath in ext4_ext_create_new_leaf()
Date: Tue, 24 Feb 2026 22:06:47 -0500
Message-ID: <20260225030652.3846997-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225030652.3846997-1-sashal@kernel.org>
References: <2026022413-broken-enchanted-0ce7@gregkh>
 <20260225030652.3846997-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219162-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,suse.cz:email,huawei.com:email]
X-Rspamd-Queue-Id: E7E8D1911C9
X-Rspamd-Action: no action

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit a000bc8678cc2bb10a5b80b4e991e77c7b4612fd ]

The use of path and ppath is now very confusing, so to make the code more
readable, pass path between functions uniformly, and get rid of ppath.

To get rid of the ppath in ext4_ext_create_new_leaf(), the following is
done here:

 * Free the extents path when an error is encountered.
 * Its caller needs to update ppath if it uses ppath.

No functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://patch.msgid.link/20240822023545.1994557-14-libaokun@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 6d882ea3b093 ("ext4: drop extent cache after doing PARTIAL_VALID1 zeroout")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 9644a9203152c..27db7c752dafd 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1392,13 +1392,12 @@ static int ext4_ext_grow_indepth(handle_t *handle, struct inode *inode,
  * finds empty index and adds new leaf.
  * if no free index is found, then it requests in-depth growing.
  */
-static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
-				    unsigned int mb_flags,
-				    unsigned int gb_flags,
-				    struct ext4_ext_path **ppath,
-				    struct ext4_extent *newext)
+static struct ext4_ext_path *
+ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
+			 unsigned int mb_flags, unsigned int gb_flags,
+			 struct ext4_ext_path *path,
+			 struct ext4_extent *newext)
 {
-	struct ext4_ext_path *path = *ppath;
 	struct ext4_ext_path *curp;
 	int depth, i, err = 0;
 
@@ -1419,28 +1418,25 @@ static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
 		 * entry: create all needed subtree and add new leaf */
 		err = ext4_ext_split(handle, inode, mb_flags, path, newext, i);
 		if (err)
-			goto out;
+			goto errout;
 
 		/* refill path */
 		path = ext4_find_extent(inode,
 				    (ext4_lblk_t)le32_to_cpu(newext->ee_block),
 				    path, gb_flags);
-		if (IS_ERR(path))
-			err = PTR_ERR(path);
+		return path;
 	} else {
 		/* tree is full, time to grow in depth */
 		err = ext4_ext_grow_indepth(handle, inode, mb_flags);
 		if (err)
-			goto out;
+			goto errout;
 
 		/* refill path */
 		path = ext4_find_extent(inode,
 				   (ext4_lblk_t)le32_to_cpu(newext->ee_block),
 				    path, gb_flags);
-		if (IS_ERR(path)) {
-			err = PTR_ERR(path);
-			goto out;
-		}
+		if (IS_ERR(path))
+			return path;
 
 		/*
 		 * only first (depth 0 -> 1) produces free space;
@@ -1452,9 +1448,11 @@ static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
 			goto repeat;
 		}
 	}
-out:
-	*ppath = IS_ERR(path) ? NULL : path;
-	return err;
+	return path;
+
+errout:
+	ext4_free_ext_path(path);
+	return ERR_PTR(err);
 }
 
 /*
@@ -2097,11 +2095,14 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 	 */
 	if (gb_flags & EXT4_GET_BLOCKS_METADATA_NOFAIL)
 		mb_flags |= EXT4_MB_USE_RESERVED;
-	err = ext4_ext_create_new_leaf(handle, inode, mb_flags, gb_flags,
-				       ppath, newext);
-	if (err)
+	path = ext4_ext_create_new_leaf(handle, inode, mb_flags, gb_flags,
+					path, newext);
+	if (IS_ERR(path)) {
+		*ppath = NULL;
+		err = PTR_ERR(path);
 		goto cleanup;
-	path = *ppath;
+	}
+	*ppath = path;
 	depth = ext_depth(inode);
 	eh = path[depth].p_hdr;
 
-- 
2.51.0


