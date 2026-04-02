Return-Path: <stable+bounces-232971-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XF34CW1CzmmSmQYAu9opvQ
	(envelope-from <stable+bounces-232971-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 12:18:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A89D238797D
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 12:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 358283093E33
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 10:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40893DDDB9;
	Thu,  2 Apr 2026 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Am+CyJxw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A799B3DD53F
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775124658; cv=none; b=iPMGoojfLhLAJuBM8fu7Idi+5y71ziTzygN/Azo4d0CnueKOTQbYa6y4QrADIBz3BWTzXXWX2qJEans9FVNngiX/Qt0IjH/aDZ1K3OO7VDW9WSwHIt4OwQPSWSs783zzC9wEtb/H3Hy/zt6bTgL1fW8E/ZExCswWvbiMIe/8/o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775124658; c=relaxed/simple;
	bh=+00BIrAerFUvQ18UX7rHzZ9yZj08PKkjYIesRPrZxmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J96rPK/dVurVPu/h44HGs0RcOANQCRoOsG6nZ7a7km/HzlkhEbeTHJMr59T4CMkch2NsjieqTDk7+nFcD5rNq7nMOOe6JcBzsLTWQXcNwi1v8U/bInyfJcKht8Pv0qlSYvidRWX18+/h+g4+xTMsUnhN2b/4qgtka3GYFZFKyuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Am+CyJxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE102C19423;
	Thu,  2 Apr 2026 10:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775124658;
	bh=+00BIrAerFUvQ18UX7rHzZ9yZj08PKkjYIesRPrZxmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Am+CyJxwcChslzcYLvHDghhheuQK5XGlHRd6lBxIjyuKNu43q/3k4+19PBDKCM2Ge
	 KuEI9oMi6MycYBXHFL0MYHhmZ+EnaF/MJidebEWLVd3QD9tIWJB6+dCxe/C77uqtIq
	 fOlixvvstY47GsFffhxWZ7uNUoPSmAmlav7+Z1AGYvcM2MB5yhx7H7UBwCXw8hAjtx
	 1iRC50jpWzbDSruLKp8IjXb8mMulkh4HRtEQwiFHBJG6fb5VL7RnOl+9EEA7skPmbJ
	 HHWJBnpAgMotZo29acBxPNjOIHN/52xZJGs+F8RMiwKvwUarc2g3zPAcgy4srVQR6/
	 3DZNFW+QKXikA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Long Li <leo.lilong@huawei.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] xfs: factor out xfs_attr3_leaf_init
Date: Thu,  2 Apr 2026 06:10:54 -0400
Message-ID: <20260402101055.771010-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402101055.771010-1-sashal@kernel.org>
References: <2026033024-poach-sequester-14e1@gregkh>
 <20260402101055.771010-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232971-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: A89D238797D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Long Li <leo.lilong@huawei.com>

[ Upstream commit e65bb55d7f8c2041c8fdb73cd29b0b4cad4ed847 ]

Factor out wrapper xfs_attr3_leaf_init function, which exported for
external use.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Long Li <leo.lilong@huawei.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Stable-dep-of: b854e1c4eff3 ("xfs: close crash window in attr dabtree inactivation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_attr_leaf.c | 22 ++++++++++++++++++++++
 fs/xfs/libxfs/xfs_attr_leaf.h |  3 +++
 2 files changed, 25 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index b858e3c2ad50a..7a9fe22c2b69b 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -1316,6 +1316,28 @@ xfs_attr3_leaf_create(
 	return 0;
 }
 
+/*
+ * Reinitialize an existing attr fork block as an empty leaf, and attach
+ * the buffer to tp.
+ */
+int
+xfs_attr3_leaf_init(
+	struct xfs_trans	*tp,
+	struct xfs_inode	*dp,
+	xfs_dablk_t		blkno)
+{
+	struct xfs_buf		*bp = NULL;
+	struct xfs_da_args	args = {
+		.trans		= tp,
+		.dp		= dp,
+		.owner		= dp->i_ino,
+		.geo		= dp->i_mount->m_attr_geo,
+	};
+
+	ASSERT(tp != NULL);
+
+	return xfs_attr3_leaf_create(&args, blkno, &bp);
+}
 /*
  * Split the leaf node, rebalance, then add the new entry.
  *
diff --git a/fs/xfs/libxfs/xfs_attr_leaf.h b/fs/xfs/libxfs/xfs_attr_leaf.h
index 589f810eedc0d..deb62b544ac54 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.h
+++ b/fs/xfs/libxfs/xfs_attr_leaf.h
@@ -86,6 +86,9 @@ int	xfs_attr3_leaf_list_int(struct xfs_buf *bp,
 /*
  * Routines used for shrinking the Btree.
  */
+
+int	xfs_attr3_leaf_init(struct xfs_trans *tp, struct xfs_inode *dp,
+				xfs_dablk_t blkno);
 int	xfs_attr3_leaf_toosmall(struct xfs_da_state *state, int *retval);
 void	xfs_attr3_leaf_unbalance(struct xfs_da_state *state,
 				       struct xfs_da_state_blk *drop_blk,
-- 
2.53.0


