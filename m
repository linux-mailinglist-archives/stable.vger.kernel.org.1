Return-Path: <stable+bounces-229007-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADptCLdYwWnbSQQAu9opvQ
	(envelope-from <stable+bounces-229007-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:13:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BD62F6046
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E89C303BDD6
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BD6388E52;
	Mon, 23 Mar 2026 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RZTA1ReQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADBC38837F;
	Mon, 23 Mar 2026 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277763; cv=none; b=eIvfCf/SLk9jCVqwHlsEfOIJeGOtUxVATm5ZGdCyIjPZCrEYpk7vFs6ysL2l7yEtF1QuJjOvrgpOfR7mcvmKh4+UuidXgnW7gK1q18Y8I/X+Cn7pet2s3azH8y+awzauPRR4/AnJ7CX4SKaEimwpphI37mw3uL1hXbY0LXr2pZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277763; c=relaxed/simple;
	bh=rubOrBp2FyFGs8jlxGLodKLJVWXv2L4THOIlm3JAKAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3iNnQs8prUAdNFcKSMbGNpdsIRQLMgZM94kDNM7Xb+qLdw7tS5WVb+6DqQnGK3ElRRCobYk1DkX3cnODi/vlnMKueTFcUhnSoV0ExIiGO89LUJ/E6efTa8bhhwJg3De3SyFitVt9Qw2gzGYzCdH/FQPbWdwWo3WSrBiGQvbTy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RZTA1ReQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EF6C4CEF7;
	Mon, 23 Mar 2026 14:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277763;
	bh=rubOrBp2FyFGs8jlxGLodKLJVWXv2L4THOIlm3JAKAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RZTA1ReQhXOfSVJ2YS8h6Zw/dy6OLYuPjjrcVgBvAKbMeFZ6XVEPz2bHF7SLCGXZ8
	 6P+9qUBxizM497S8cO33FbBaeSpTgbCFFQS2ZO80n3fq9E0Hh/MyLvoxY1Gln1q40V
	 HNivL1vOyF79Ag6dNBcLVHZaCEI9lNVLjsy+ocSg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 052/567] ext4: get rid of ppath in ext4_convert_unwritten_extents_endio()
Date: Mon, 23 Mar 2026 14:39:32 +0100
Message-ID: <20260323134535.098284737@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229007-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 20BD62F6046
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 8d5ad7b08f9234bc92b9567cfe52e521df5f6626 ]

The use of path and ppath is now very confusing, so to make the code more
readable, pass path between functions uniformly, and get rid of ppath.

To get rid of the ppath in ext4_convert_unwritten_extents_endio(), the
following is done here:

 * Free the extents path when an error is encountered.
 * Its caller needs to update ppath if it uses ppath.

No functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://patch.msgid.link/20240822023545.1994557-20-libaokun@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: feaf2a80e78f ("ext4: don't set EXT4_GET_BLOCKS_CONVERT when splitting before submitting I/O")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 27bacfa7d492c..8eb004700437e 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3753,12 +3753,11 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 				 allocated);
 }
 
-static int ext4_convert_unwritten_extents_endio(handle_t *handle,
-						struct inode *inode,
-						struct ext4_map_blocks *map,
-						struct ext4_ext_path **ppath)
+static struct ext4_ext_path *
+ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
+				     struct ext4_map_blocks *map,
+				     struct ext4_ext_path *path)
 {
-	struct ext4_ext_path *path = *ppath;
 	struct ext4_extent *ex;
 	ext4_lblk_t ee_block;
 	unsigned int ee_len;
@@ -3788,24 +3787,19 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
 #endif
 		path = ext4_split_convert_extents(handle, inode, map, path,
 						EXT4_GET_BLOCKS_CONVERT, NULL);
-		if (IS_ERR(path)) {
-			*ppath = NULL;
-			return PTR_ERR(path);
-		}
+		if (IS_ERR(path))
+			return path;
 
 		path = ext4_find_extent(inode, map->m_lblk, path, 0);
-		if (IS_ERR(path)) {
-			*ppath = NULL;
-			return PTR_ERR(path);
-		}
-		*ppath = path;
+		if (IS_ERR(path))
+			return path;
 		depth = ext_depth(inode);
 		ex = path[depth].p_ext;
 	}
 
 	err = ext4_ext_get_access(handle, inode, path + depth);
 	if (err)
-		goto out;
+		goto errout;
 	/* first mark the extent as initialized */
 	ext4_ext_mark_initialized(ex);
 
@@ -3816,9 +3810,15 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
 
 	/* Mark modified extent as dirty */
 	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
-out:
+	if (err)
+		goto errout;
+
 	ext4_ext_show_leaf(inode, path);
-	return err;
+	return path;
+
+errout:
+	ext4_free_ext_path(path);
+	return ERR_PTR(err);
 }
 
 static int
@@ -3946,10 +3946,13 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 	}
 	/* IO end_io complete, convert the filled extent to written */
 	if (flags & EXT4_GET_BLOCKS_CONVERT) {
-		err = ext4_convert_unwritten_extents_endio(handle, inode, map,
-							   ppath);
-		if (err < 0)
+		*ppath = ext4_convert_unwritten_extents_endio(handle, inode,
+							      map, *ppath);
+		if (IS_ERR(*ppath)) {
+			err = PTR_ERR(*ppath);
+			*ppath = NULL;
 			goto out2;
+		}
 		ext4_update_inode_fsync_trans(handle, inode, 1);
 		goto map_out;
 	}
-- 
2.51.0




