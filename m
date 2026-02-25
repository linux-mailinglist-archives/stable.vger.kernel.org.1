Return-Path: <stable+bounces-219177-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KC+kDqdvnmkvVQQAu9opvQ
	(envelope-from <stable+bounces-219177-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:42:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A8419140F
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8923C303E4A3
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A9C2BE029;
	Wed, 25 Feb 2026 03:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBoAtppL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0ED2BDC13
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 03:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771990949; cv=none; b=K0+b3TDKh8ZkUq8gzk98SXoSS5CzsqsxzRFkFxRUE/SbFid6GeA8E94DRHNYmM3D+nr2hVCbMi4TaHGwH/1di1pqUCseq7LvvlgQYfiOdytltxdRi5w8Jgn7edECxm9f8Y7+ZbZFsMVZYl2CFUxFdx45xs5Bdr3mU3CxqQHExKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771990949; c=relaxed/simple;
	bh=LkHwemKWjnwkHBom2agN2rR/+akoNW3zaiT1WHoCsq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=koBU9kAe54blv5DCau6j0Q/te66bfnn0nG3gqaH/++OuFQjPzT3Xcuyflas0UwziYA84g5pBE/f4rmanblzWEaNG3NMPhZvTbeT9upcQfqOORqNRyu0PfY/alsRAq1ob8pV/ep+MfMpEJSnJrutYp9U37TvUTlf6RpzYEnLwsgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBoAtppL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39150C19421;
	Wed, 25 Feb 2026 03:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771990948;
	bh=LkHwemKWjnwkHBom2agN2rR/+akoNW3zaiT1WHoCsq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oBoAtppLfzm3ok66jYnvEhvHunzffHKqEy1L0RDoIms1WWmPKS/R5/wDBU1UNCJi/
	 7yvLtd85RwlDR9NAcLh+UoQzVpFERJrqQtPWaB+Aiw13S39gpzcC1UtbAHta3BMl9Q
	 AtWw+sgzDMeQ0XZ4noc7TYB04e5QAY1vwoVZtR3wRs+fl0A6lR62g9tGt7ZGO4cLjk
	 rLdHew8XGdcVBgh8mw06FQS/oR/mh9AKGXM8leLin9K0MjpCswelO3+IWbWwZL0qlG
	 dRhCRO8WGkzqHc1Zx6Gjfo+LRlBdZlhyXf9MtqXFrtflwEY8F8hVh9q2NgP6KWvP4j
	 MugUKsIifKgTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/5] ext4: get rid of ppath in ext4_ext_create_new_leaf()
Date: Tue, 24 Feb 2026 22:42:22 -0500
Message-ID: <20260225034225.3893579-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225034225.3893579-1-sashal@kernel.org>
References: <2026022428-ranged-scrabble-b28b@gregkh>
 <20260225034225.3893579-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-219177-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,msgid.link:url,suse.cz:email]
X-Rspamd-Queue-Id: A7A8419140F
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
Stable-dep-of: 79b592e8f1b4 ("ext4: drop extent cache when splitting extent fails")
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


