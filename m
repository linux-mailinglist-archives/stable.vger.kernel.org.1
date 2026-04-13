Return-Path: <stable+bounces-236156-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH2KMy8S3WkOZQkAu9opvQ
	(envelope-from <stable+bounces-236156-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:56:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B67D3EE3A3
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0392A308BA11
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E410286D5E;
	Mon, 13 Apr 2026 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKRCHqa5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C82B34AAE3
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 15:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776095428; cv=none; b=lWkyI7guPcdX69MHDdRTdTLbYoKeejU4PQR/q319Ds9C27vkzWRQqR2XGXyPdcELqjvap4iEVOQsyBpmqN8/AAwrJs5Cimr5pYUMufqJzE9AELyINqtczk5xJ52y6O3Gey6zgznTkNAQW03j8e0TQlM5I8eLABMxsNFfj3e/Iz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776095428; c=relaxed/simple;
	bh=AwUXWiewaZAf+lwmiX6rI190tzA0UItU80mB3bPpnso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCjZUX89pMxBLEjXJduYMbXwnMhSOM5D7iMVb7QOcj7ZsDOFpsLR2dVPAfJsUCfXlIiAJa1JXVuClCguzEKom0djxySQFRj8TEjchw6Su8a2WS3DdBzSGf/pV/LSCRbScOBLP/FvpgLRguTqPoYBlAw593JCtW+HNzt86TDInIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKRCHqa5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E849C2BCAF;
	Mon, 13 Apr 2026 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776095427;
	bh=AwUXWiewaZAf+lwmiX6rI190tzA0UItU80mB3bPpnso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hKRCHqa5z64QRdqvOEB1WZQYyEdON+HQinEtHRgJC51UeqYkPbsm9f6EK8mJwJxwX
	 +obFffJryuYXLsbZ5qlKB7OTKlOg00Ugu+gqeQJsrNczqjcLZMy1wO6NUayk5S0R1H
	 rMq6T8a86h9Nh4rvCFNsEBmTWA8L8nWLSlxgF+5Ixe9Tn+Kh1j6TUsL7zWdSQSsW9W
	 RAq/X6tvrqjbhi6BUDPBmzQqU4MQsk77QB4Q6XAAs3/qgBiUL5Io0Q7c+7jRnyZ5GR
	 i9oHec3GKo6dtbS2xfonELv/FHx3BpHc3bvKgULk2nQ2HuU68CGbQ6SqHnT90/zmy8
	 XP9IU0bBfp+KQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Joseph Qi <jiangqi903@gmail.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Changwei Ge <gechangwei@live.cn>,
	Jun Piao <piaojun@huawei.com>,
	Heming Zhao <heming.zhao@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] ocfs2: add inline inode consistency check to ocfs2_validate_inode_block()
Date: Mon, 13 Apr 2026 11:50:23 -0400
Message-ID: <20260413155025.3145781-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026041353-swimmer-skied-a346@gregkh>
References: <2026041353-swimmer-skied-a346@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[yandex.ru,syzkaller.appspotmail.com,linux.alibaba.com,gmail.com,fasheh.com,evilplan.org,oracle.com,live.cn,huawei.com,suse.com,linux-foundation.org,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-236156-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,c16daba279a1161acfb0];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B67D3EE3A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit a2b1c419ff72ec62ff5831684e30cd1d4f0b09ee ]

In 'ocfs2_validate_inode_block()', add an extra check whether an inode
with inline data (i.e.  self-contained) has no clusters, thus preventing
an invalid inode from being passed to 'ocfs2_evict_inode()' and below.

Link: https://lkml.kernel.org/r/20251023141650.417129-1-dmantipov@yandex.ru
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Reported-by: syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c16daba279a1161acfb0
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Joseph Qi <jiangqi903@gmail.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Cc: Heming Zhao <heming.zhao@suse.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 7bc5da4842be ("ocfs2: fix out-of-bounds write in ocfs2_write_end_inline")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index bc8f32fab964c..f42fa45ccd67d 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1416,6 +1416,14 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 		goto bail;
 	}
 
+	if ((le16_to_cpu(di->i_dyn_features) & OCFS2_INLINE_DATA_FL) &&
+	    le32_to_cpu(di->i_clusters)) {
+		rc = ocfs2_error(sb, "Invalid dinode %llu: %u clusters\n",
+				 (unsigned long long)bh->b_blocknr,
+				 le32_to_cpu(di->i_clusters));
+		goto bail;
+	}
+
 	rc = 0;
 
 bail:
-- 
2.53.0


