Return-Path: <stable+bounces-234986-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGs+Ih+m1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-234986-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:01:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 179413C2319
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DD1131391EC
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28D534B19F;
	Wed,  8 Apr 2026 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2t+Or+Gy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53B933121F;
	Wed,  8 Apr 2026 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674275; cv=none; b=a7Xlw3JrACrBakUuMxOIMRALSCepWYqH+2iEVJQ0VDAd7ijiHBw6Npxw4NG+cjZ8so+UBH2EwYdeOg+CiwdRuBXeHr0bF6zUdzRKkY7S6qp9825xCnukLH9ijDJz6SatyK6vMJuJSL0iXT2dRh2kBbADDZ/ewbkyYEH6nPknOHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674275; c=relaxed/simple;
	bh=NWK0l7qDse4O2nPSWFcVTFTg2ulekRmnQz7ZnzA9aHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKDz5Esdbxbf1MyaYeymYR/dPxlIfcTLHzR9YlFs5RlrAA3qc9loFSRyQRQr5aD5iU0krTnxZzqi+/MBQPTWsvCQqmTyiNY9F9JHhTKd7OopPlH5ypZioFUb7vMNBdnUN5wXLQUKoj6AL8xvFvUyuT57xufpwFymjtoUTZCBSGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2t+Or+Gy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334AFC19421;
	Wed,  8 Apr 2026 18:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674275;
	bh=NWK0l7qDse4O2nPSWFcVTFTg2ulekRmnQz7ZnzA9aHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2t+Or+GymlNqPIUV7R1BAkx2kj3AkDmJrrgebv+iGaoT53lyPSPTTA4hE3TXszYzc
	 BZINnpDv//P49zvYSZA/0cefONE87FCumAdXemv/mEu0GffJnXzxlR1xMzbewYVsdS
	 fx550irUZFHJHXZKU0Hy2P4dNSbd0+QyFTAHTE7k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Long Li <leo.lilong@huawei.com>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 006/311] xfs: factor out xfs_attr3_node_entry_remove
Date: Wed,  8 Apr 2026 20:00:06 +0200
Message-ID: <20260408175939.642692276@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234986-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 179413C2319
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Long Li <leo.lilong@huawei.com>

[ Upstream commit ce4e789cf3561c9fac73cc24445bfed9ea0c514b ]

Factor out wrapper xfs_attr3_node_entry_remove function, which
exported for external use.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Long Li <leo.lilong@huawei.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Stable-dep-of: b854e1c4eff3 ("xfs: close crash window in attr dabtree inactivation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/libxfs/xfs_da_btree.c |   53 ++++++++++++++++++++++++++++++++++---------
 fs/xfs/libxfs/xfs_da_btree.h |    2 +
 2 files changed, 44 insertions(+), 11 deletions(-)

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
@@ -1555,6 +1554,38 @@ xfs_da3_node_remove(
 }
 
 /*
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
+/*
  * Unbalance the elements between two intermediate nodes,
  * move all Btree elements from one node into another.
  */
--- a/fs/xfs/libxfs/xfs_da_btree.h
+++ b/fs/xfs/libxfs/xfs_da_btree.h
@@ -184,6 +184,8 @@ int	xfs_da3_split(xfs_da_state_t *state)
 int	xfs_da3_join(xfs_da_state_t *state);
 void	xfs_da3_fixhashpath(struct xfs_da_state *state,
 			    struct xfs_da_state_path *path_to_to_fix);
+void	xfs_attr3_node_entry_remove(struct xfs_trans *tp, struct xfs_inode *dp,
+			    struct xfs_buf *bp, int index);
 
 /*
  * Routines used for finding things in the Btree.



