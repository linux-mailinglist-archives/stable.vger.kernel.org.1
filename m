Return-Path: <stable+bounces-240291-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LSqDHx86GmsKwIAu9opvQ
	(envelope-from <stable+bounces-240291-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 09:45:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 384E044316D
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 09:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A867E3017535
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 07:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0D940DFAC;
	Wed, 22 Apr 2026 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="ul7hvzDl"
X-Original-To: stable@vger.kernel.org
Received: from r3-11.sinamail.sina.com.cn (r3-11.sinamail.sina.com.cn [202.108.3.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFBF372B39
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 07:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776843887; cv=none; b=aeyXRrCWWVSz3gOXJHJdUKQl1mb+nMx2Bh1T/OZ/JPx383wfTq1ITFdAesV8gi9CjY84xeUPBACFIRRRvnrubPlPo/Gc9yZuSKbM8vTiRkk0zcLScMQMY/xvXFgCJ4lTKXsmZM5KX4zFPuC81XIuOxZWh/JLHYoCmJERHHAjG8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776843887; c=relaxed/simple;
	bh=Q/vPyDNU4tVLgowah1+pWi5OOtimwd4Pjl50kBI+/xE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=huQFU25fJlTqkb9YC9cDMhNoKx5WyuMQsV1AgI/1oa640jfMZr2JpQDkIyqfuHMSvLYGbasaqEpMhkaOXtzPmURDk1Lkc+l2CoRm/OgsmutECxba9Tbi+y/SaaLpTJRDKLyHGaL8fzejo4XIgK8tinMeLwnVif5JDRwUsbb3g4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=ul7hvzDl; arc=none smtp.client-ip=202.108.3.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1776843883;
	bh=H1trmsrQHG+SXv8TcNk649lze8L80j1LOKIwDN+ZgaY=;
	h=From:Subject:Date:Message-ID;
	b=ul7hvzDlV42UKEU5kuI0neL1bIvsZcP4rB00+MMtBqZsekqGhYKezIDNUshN0rjGc
	 SkwJTbnGfGu9F3Sz/GNk8SvkpM5HCL6MTssFrHFcarnRPlBGuyk4+e6BBWWCxq09xo
	 y4D2wT+FgX+WRq6UaCBjIRK2NaDl4eQSJ5fsQGac=
X-SMAIL-HELO: xiaomi-ThinkCentre-M760t.mioffice.cn
Received: from unknown (HELO xiaomi-ThinkCentre-M760t.mioffice.cn)([114.247.175.249])
	by sina.com (10.54.253.34) with ESMTP
	id 69E87B1A00000156; Wed, 22 Apr 2026 15:39:08 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=monty_pavel@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 7173206291732
X-SMAIL-UIID: 14C6B3A440BA462DBDF0DAFF2F44DA75-20260422-153908-1
From: Yongpeng Yang <monty_pavel@sina.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Yongpeng Yang <monty_pavel@sina.com>,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: fix incorrect FI_NO_EXTENT handling in __destroy_extent_node()
Date: Wed, 22 Apr 2026 15:35:26 +0800
Message-ID: <20260422073525.2063784-2-monty_pavel@sina.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240291-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sina.com:dkim,sina.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,xiaomi.com:email]
X-Rspamd-Queue-Id: 384E044316D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: yangyongpeng <yangyongpeng@xiaomi.com>

When __destroy_extent_node() sets the inode flag FI_NO_EXTENT, it does
not reset the length of the largest extent to 0 and update the inode
folio. Since modifications to the extent tree are disallowed afterward,
the cached largest extent may become stale. This can trigger the
following error in xfstests generic/388:

F2FS-fs (dm-0): sanity_check_extent_cache: inode (ino=1761) extent info [220057, 57, 6] is incorrect, run fsck to fix

In the f2fs_drop_inode path, __destroy_extent_node() does not need to
guarantee that et->node_cnt is 0, because concurrency with writeback
is expected in this path, and writeback may update the extent cache.

This patch updates __destroy_extent_node() to avoid setting the inode
flag FI_NO_EXTENT, and to remove the check zero of et->node_cnt.

Fixes: ed78aeebef05 ("f2fs: fix node_cnt race between extent node destroy and writeback")
Cc: stable@vger.kernel.org
Reported-by: Chao Yu <chao@kernel.org>
Suggested-by: Chao Yu <chao@kernel.org>
Signed-off-by: yangyongpeng <yangyongpeng@xiaomi.com>
---
 fs/f2fs/extent_cache.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 87169fd29d89..3adbead27953 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -645,14 +645,10 @@ static unsigned int __destroy_extent_node(struct inode *inode,
 
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
 
-- 
2.43.0


