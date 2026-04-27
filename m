Return-Path: <stable+bounces-241322-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIplHohg72mHAwEAu9opvQ
	(envelope-from <stable+bounces-241322-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:11:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 94932473319
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA73A3004904
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 13:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2C63B388F;
	Mon, 27 Apr 2026 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="WYhD6sYA"
X-Original-To: stable@vger.kernel.org
Received: from mail3-164.sinamail.sina.com.cn (mail3-164.sinamail.sina.com.cn [202.108.3.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4074E2248A3
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777295493; cv=none; b=JKzLXBgcwQZXzmpRIlLoPPpf3b1wkkw6aIcDls1xXVvd2DkaDIYWvMxWI0nVETprq5GhkMBHQQcSot0YjDLGiebmF/VNQTX8CwVCLtgMdCFK5Xmwd8r6NkYU6aatuzQwx5YDguUVmLYDjd9zSfAL6vnAcFabO4BQJmWYqtmIDA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777295493; c=relaxed/simple;
	bh=Md59SUDwq9l3OZ7Eklvq7jCkq6T3YQgxWmjUTNvfDlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iw/zikjnkPaDXpbnlh78b7/w9T5UclTtY8Xjbsf4wTkfE5X28mRSzOcMsCX086D9bun+vlqAxz51I+soRI0hl0V5G6y+Qoaap9h3Ym5VZBCnmZfGplwif4UM1gFtLZCg/3GNIH1/t2xiQKJpT/gB4H+BPSQAF0NqlUb5wejlkvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=WYhD6sYA; arc=none smtp.client-ip=202.108.3.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1777295488;
	bh=WVuuF2jz56tmxYMe69EKoYQDXvB3b59uemRr8IPDXCI=;
	h=From:Subject:Date:Message-ID;
	b=WYhD6sYAJGwEw+zG2WZxxi8H9C29KOdnTwyLu+BHnDU4hCC3J9jzbbM6lsJmA8wse
	 plOAsOZR/pGsZS/ZDamINu1+F1IkPpCFXIN1T6/Rc3jz4LOQxHMX9IEeSgtaDQCaYI
	 EsjC/XZ2b7mRRlrB5dwXAW/3aztBpA1cs1qi8cb4=
X-SMAIL-HELO: xiaomi-ThinkCentre-M760t.mioffice.cn
Received: from unknown (HELO xiaomi-ThinkCentre-M760t.mioffice.cn)([114.247.175.249])
	by sina.com (10.54.253.32) with ESMTP
	id 69EF607A000074C0; Mon, 27 Apr 2026 21:11:24 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=monty_pavel@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 1614214456648
X-SMAIL-UIID: 216C67930993494A97DC2758639D7A0E-20260427-211124-1
From: Yongpeng Yang <monty_pavel@sina.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Yongpeng Yang <monty_pavel@sina.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] f2fs: fix incorrect FI_NO_EXTENT handling in __destroy_extent_node()
Date: Mon, 27 Apr 2026 21:10:51 +0800
Message-ID: <20260427131050.1526593-2-monty_pavel@sina.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 94932473319
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241322-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[sina.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.sourceforge.net,xiaomi.com,sina.com,vger.kernel.org];
	DKIM_TRACE(0.00)[sina.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[monty_pavel@sina.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sina.com:dkim,sina.com:mid,xiaomi.com:email]

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

When __destroy_extent_node() sets the inode flag FI_NO_EXTENT, it does
not reset the length of the largest extent to 0 and update the inode
folio. Since modifications to the extent tree are disallowed afterward,
the cached largest extent may become stale. This can trigger the
following error in xfstests generic/388:

F2FS-fs (dm-0): sanity_check_extent_cache: inode (ino=1761) extent info [220057, 57, 6] is incorrect, run fsck to fix

In the f2fs_drop_inode path, __destroy_extent_node() does not need to
guarantee that et->node_cnt is 0, because concurrency with writeback
is expected in this path, and writeback may update the extent cache.

This patch reverts commit ed78aeebef05 ("f2fs: fix node_cnt race between
extent node destroy and writeback"), and remove the unnecessary zero
check of et->node_cnt.

Fixes: ed78aeebef05 ("f2fs: fix node_cnt race between extent node destroy and writeback")
Cc: stable@vger.kernel.org
Reported-by: Chao Yu <chao@kernel.org>
Suggested-by: Chao Yu <chao@kernel.org>
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
v2:
- Revert all changes of previous commit ed78aeebef05 and fix xfstests bug.
---
 fs/f2fs/extent_cache.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 87169fd29d89..129eed892a66 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -119,10 +119,9 @@ static bool __may_extent_tree(struct inode *inode, enum extent_type type)
 	if (!__init_may_extent_tree(inode, type))
 		return false;
 
-	if (is_inode_flag_set(inode, FI_NO_EXTENT))
-		return false;
-
 	if (type == EX_READ) {
+		if (is_inode_flag_set(inode, FI_NO_EXTENT))
+			return false;
 		if (is_inode_flag_set(inode, FI_COMPRESSED_FILE) &&
 				 !f2fs_sb_has_readonly(F2FS_I_SB(inode)))
 			return false;
@@ -645,14 +644,10 @@ static unsigned int __destroy_extent_node(struct inode *inode,
 
 	while (atomic_read(&et->node_cnt)) {
 		write_lock(&et->lock);
-		if (!is_inode_flag_set(inode, FI_NO_EXTENT))
-			set_inode_flag(inode, FI_NO_EXTENT);
 		node_cnt += __free_extent_tree(sbi, et, nr_shrink);
 		write_unlock(&et->lock);
 	}
 
-	f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
-
 	return node_cnt;
 }
 
@@ -691,12 +686,12 @@ static void __update_extent_tree_range(struct inode *inode,
 
 	write_lock(&et->lock);
 
-	if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
-		write_unlock(&et->lock);
-		return;
-	}
-
 	if (type == EX_READ) {
+		if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
+			write_unlock(&et->lock);
+			return;
+		}
+
 		prev = et->largest;
 		dei.len = 0;
 
-- 
2.43.0


