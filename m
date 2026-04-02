Return-Path: <stable+bounces-232959-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CM06J8E7zmmAmAYAu9opvQ
	(envelope-from <stable+bounces-232959-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:49:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B9C3872FE
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61207306B394
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 09:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A783DBD78;
	Thu,  2 Apr 2026 09:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsbFGJPK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B733DC4A5
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123057; cv=none; b=HianlIpgT7w15joXwJBXs6sh7bunNHC/lXP5gv8aEk5GEoLe7b2/STb+CJathscD5MY4CfZfHWRIuE8+Zq46RZ7nTMzRvCn09ABN4HAgUW64O4TvPdwDgZ0uOP5b59m5wbfCAEMt1829c64YGl8yomC8B6QBG9AHDNzhWyIGSjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123057; c=relaxed/simple;
	bh=+00BIrAerFUvQ18UX7rHzZ9yZj08PKkjYIesRPrZxmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nve3pUO6EjFBS0D3YmkuIzVqFKXE+qaN5o0u+NX/FB2E9MGpmB+F2rRdJq2uWWSJQnWHxprnt/mSPQIwBxQqbLoL2hlvjqpPvVwiP/nMcVVO67AaILoXUslYixKe1/yDmG6Uo/F8j+UGqoQyll4qzBF4ZBfnrKVRZUbuhtZ4ni4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsbFGJPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196F4C19423;
	Thu,  2 Apr 2026 09:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775123056;
	bh=+00BIrAerFUvQ18UX7rHzZ9yZj08PKkjYIesRPrZxmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gsbFGJPKna9ggSiOGwBW/rTWTinoHOHW3MlKcgn+RcFgGL64aZ0CMgbI5+vmy2rxQ
	 2tCWPVX5gwmepLf6AIA2vT/W51k15GDOJEmHpcR14P8mb4Ma2bhkxbkzRiX6mWaV1l
	 7zFY6lnJXc41f4ku8Cq9/2IGwx9qhGfq1Py0S10Y+Dcx3s9DbT8kcrzFMBe1rBwgbh
	 Z+y7K3XmoRUkGgIbI8fgwkS/vgwh0wVt/409UUY3Vb50wXkfKIapi/oUmbdYO0aE0f
	 Zzh9s5TW5ChLDg9gFXfvbkrQXllyntAiCOsEUMA4162heSBZ5QJyzxMSF9IvxsHffY
	 Jad0T4k5+atJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Long Li <leo.lilong@huawei.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19.y 2/3] xfs: factor out xfs_attr3_leaf_init
Date: Thu,  2 Apr 2026 05:44:11 -0400
Message-ID: <20260402094412.717776-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402094412.717776-1-sashal@kernel.org>
References: <2026033022-mumps-pronto-1d74@gregkh>
 <20260402094412.717776-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232959-lists,stable=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 56B9C3872FE
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


