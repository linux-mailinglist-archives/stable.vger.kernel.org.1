Return-Path: <stable+bounces-232958-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI35Br47zmmAmAYAu9opvQ
	(envelope-from <stable+bounces-232958-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:49:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 844393872EF
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0363B30B3AFA
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 09:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7023DBD62;
	Thu,  2 Apr 2026 09:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anKMnXC0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE93D3AA4E4
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123056; cv=none; b=IF7iBKhxkmSpyMKAsnZcE8jcs+AWKBAQuyVjxqP07agRNvyU1BimiVDbOgW622ao5YjmFNT0olVvLUceC5eD2rN3trrXuFnjJNJzK+OX7b57nB/ri9yCBLM6C5/G/eGFAfXUb/mGhEGp6ccBri9c+d0XyKbIdMuNjhq1CCpqa7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123056; c=relaxed/simple;
	bh=ld4vEBoarSlIT7OFMTIUbe5OFEt29JLwOkrBDv4i7lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CE/5mShdr+YC6ggDWOfd8Q/8BZOpeRoJQ1gSiMsadoQegL6ehqLcMoUw5DYSK5T273n/w22FC7N8sPVN+PFzP6tHonBHVq2yv+3XD0cC9nZoONrwcVEs+cv86iZ59RAtx6rX88uSCnRTs4uva7VRSQl4/Xf+W1zrH5fYCDwCbU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anKMnXC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403ABC116C6;
	Thu,  2 Apr 2026 09:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775123055;
	bh=ld4vEBoarSlIT7OFMTIUbe5OFEt29JLwOkrBDv4i7lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=anKMnXC01vb6R0u8Fl4LaaXA1CjoD8lX7xywZ0g3gFSgF9n92oIvRe6+tT7Km42Qt
	 8QK9jzt/i+6I8/DB92uhZENwqDIC775pNMzDhpfVVWytLATz15uKP1cRH+FXwOT3iG
	 EHhWIRP0TLiVW2FHFRoaRgQVw1WulgiZGUfJOK/nyTdtqmBJKHPg8gxXEUiciphguB
	 zqYrZvKvDyrlbBkoWZF7X4OpIKoGT3QhZilOhrpqHFydL2FGo1OmHABLS2C5VACnym
	 2ZiN/XL6+/AMK1VTPyG/C16yDaXAxbDjAvqkQo1fgodiscI/x9nSz3IW8aydRZ8Gfp
	 ueBLASOCg2OCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Long Li <leo.lilong@huawei.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19.y 1/3] xfs: factor out xfs_attr3_node_entry_remove
Date: Thu,  2 Apr 2026 05:44:10 -0400
Message-ID: <20260402094412.717776-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033022-mumps-pronto-1d74@gregkh>
References: <2026033022-mumps-pronto-1d74@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-232958-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 844393872EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Long Li <leo.lilong@huawei.com>

[ Upstream commit ce4e789cf3561c9fac73cc24445bfed9ea0c514b ]

Factor out wrapper xfs_attr3_node_entry_remove function, which
exported for external use.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Long Li <leo.lilong@huawei.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Stable-dep-of: b854e1c4eff3 ("xfs: close crash window in attr dabtree inactivation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_da_btree.c | 53 ++++++++++++++++++++++++++++--------
 fs/xfs/libxfs/xfs_da_btree.h |  2 ++
 2 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index 90f7fc219fccc..d85bca22d6857 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -1506,21 +1506,20 @@ xfs_da3_fixhashpath(
 }
 
 /*
- * Remove an entry from an intermediate node.
+ * Internal implementation to remove an entry from an intermediate node.
  */
 STATIC void
-xfs_da3_node_remove(
-	struct xfs_da_state	*state,
-	struct xfs_da_state_blk	*drop_blk)
+__xfs_da3_node_remove(
+	struct xfs_trans	*tp,
+	struct xfs_inode	*dp,
+	struct xfs_da_geometry  *geo,
+	struct xfs_da_state_blk *drop_blk)
 {
 	struct xfs_da_intnode	*node;
 	struct xfs_da3_icnode_hdr nodehdr;
 	struct xfs_da_node_entry *btree;
 	int			index;
 	int			tmp;
-	struct xfs_inode	*dp = state->args->dp;
-
-	trace_xfs_da_node_remove(state->args);
 
 	node = drop_blk->bp->b_addr;
 	xfs_da3_node_hdr_from_disk(dp->i_mount, &nodehdr, node);
@@ -1536,17 +1535,17 @@ xfs_da3_node_remove(
 		tmp  = nodehdr.count - index - 1;
 		tmp *= (uint)sizeof(xfs_da_node_entry_t);
 		memmove(&btree[index], &btree[index + 1], tmp);
-		xfs_trans_log_buf(state->args->trans, drop_blk->bp,
+		xfs_trans_log_buf(tp, drop_blk->bp,
 		    XFS_DA_LOGRANGE(node, &btree[index], tmp));
 		index = nodehdr.count - 1;
 	}
 	memset(&btree[index], 0, sizeof(xfs_da_node_entry_t));
-	xfs_trans_log_buf(state->args->trans, drop_blk->bp,
+	xfs_trans_log_buf(tp, drop_blk->bp,
 	    XFS_DA_LOGRANGE(node, &btree[index], sizeof(btree[index])));
 	nodehdr.count -= 1;
 	xfs_da3_node_hdr_to_disk(dp->i_mount, node, &nodehdr);
-	xfs_trans_log_buf(state->args->trans, drop_blk->bp,
-	    XFS_DA_LOGRANGE(node, &node->hdr, state->args->geo->node_hdr_size));
+	xfs_trans_log_buf(tp, drop_blk->bp,
+	    XFS_DA_LOGRANGE(node, &node->hdr, geo->node_hdr_size));
 
 	/*
 	 * Copy the last hash value from the block to propagate upwards.
@@ -1554,6 +1553,38 @@ xfs_da3_node_remove(
 	drop_blk->hashval = be32_to_cpu(btree[index - 1].hashval);
 }
 
+/*
+ * Remove an entry from an intermediate node.
+ */
+STATIC void
+xfs_da3_node_remove(
+	struct xfs_da_state	*state,
+	struct xfs_da_state_blk	*drop_blk)
+{
+	trace_xfs_da_node_remove(state->args);
+
+	__xfs_da3_node_remove(state->args->trans, state->args->dp,
+			state->args->geo, drop_blk);
+}
+
+/*
+ * Remove an entry from an intermediate attr node at the specified index.
+ */
+void
+xfs_attr3_node_entry_remove(
+	struct xfs_trans	*tp,
+	struct xfs_inode	*dp,
+	struct xfs_buf		*bp,
+	int			index)
+{
+	struct xfs_da_state_blk blk = {
+		.index		= index,
+		.bp		= bp,
+	};
+
+	__xfs_da3_node_remove(tp, dp, dp->i_mount->m_attr_geo, &blk);
+}
+
 /*
  * Unbalance the elements between two intermediate nodes,
  * move all Btree elements from one node into another.
diff --git a/fs/xfs/libxfs/xfs_da_btree.h b/fs/xfs/libxfs/xfs_da_btree.h
index 354d5d65043e4..afcf2d3c7a21c 100644
--- a/fs/xfs/libxfs/xfs_da_btree.h
+++ b/fs/xfs/libxfs/xfs_da_btree.h
@@ -184,6 +184,8 @@ int	xfs_da3_split(xfs_da_state_t *state);
 int	xfs_da3_join(xfs_da_state_t *state);
 void	xfs_da3_fixhashpath(struct xfs_da_state *state,
 			    struct xfs_da_state_path *path_to_to_fix);
+void	xfs_attr3_node_entry_remove(struct xfs_trans *tp, struct xfs_inode *dp,
+			    struct xfs_buf *bp, int index);
 
 /*
  * Routines used for finding things in the Btree.
-- 
2.53.0


