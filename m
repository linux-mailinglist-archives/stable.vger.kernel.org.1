Return-Path: <stable+bounces-219171-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIfAB+9onmmzVAQAu9opvQ
	(envelope-from <stable+bounces-219171-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:13:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8848B191225
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6368A3058459
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B1C28D8DF;
	Wed, 25 Feb 2026 03:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Erk5dKu/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E100A433B3
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 03:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771989228; cv=none; b=a2h09yRsd7Ls3J7+e2QCEVdjp3ce4ebDuhXIjpol5WKTtu+d6KG1BD8+olDKnW3cmq5cHJMjo1r4SzIIfz/ipkY+qQQv3gRld4I+CVg1hZHpMLYYIKqwjWoToUr8UD3EmQ2d9GkPZplrLwBNKjaOybyYiqqEhPsuS+RxSjnVSaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771989228; c=relaxed/simple;
	bh=PYdxQ6iLvNujtsZ88ZwqG0JWuit5xwART9o8u+lbqYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Las6ivt9KyFO+49/BMRpxgukDsZSf/eyz4qg8SbUCS+vsznfQiYOvnySwk8s8/F1tP9I82VQhIAMez7rC7oTxAevfNlTowqxOOeHIlgZzcPLyxssTCB0jLoeyU7o0+aCFLtPqKX3LpTKzQV1wUvnSGNURAbHIsTshlb4K3pGX04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Erk5dKu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C22C116D0;
	Wed, 25 Feb 2026 03:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771989227;
	bh=PYdxQ6iLvNujtsZ88ZwqG0JWuit5xwART9o8u+lbqYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Erk5dKu/LhnoVDywVWhoDvMTdJjxhd6CdXyapEYNHU7fEIObeQCYxK5EcFf/WuV6f
	 3e5hdMlSquMh8O4jzA7rRbFxwpPTV4zSAST6GHuLusIwuqxi3zRxDmFuBG9PAcKZL6
	 riFB5QCxRIrurZL6a1Rkjl5DqHeGsr0Aa6RET9Y52AU5lnoCHZc9l6hJv69wZa90y1
	 8Vs3w/jDQIY8JO60IARWVw3vJyiEAGvWiR9imHGQ7hAcHZAqx+TFFUa0GTNNuqGH5X
	 HdTl8lFUm9D7osv8V/FfePejsVz8GiZQYI5DD0A2TT2h36A9Wie5HEzE+UULZgJ+az
	 OScyw36NlBbmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/7] ext4: get rid of ppath in ext4_ext_create_new_leaf()
Date: Tue, 24 Feb 2026 22:13:39 -0500
Message-ID: <20260225031343.3858545-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225031343.3858545-1-sashal@kernel.org>
References: <2026022439-revered-giddily-d324@gregkh>
 <20260225031343.3858545-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219171-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 8848B191225
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
Stable-dep-of: 1bf6974822d1 ("ext4: don't zero the entire extent if EXT4_EXT_DATA_PARTIAL_VALID1")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 1285b8edd62fc..37113982a3329 100644
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


