Return-Path: <stable+bounces-233189-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zTHGL3fTz2kQ1AYAu9opvQ
	(envelope-from <stable+bounces-233189-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 16:49:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB56F3955E0
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 16:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C49C300DDD4
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 14:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A093C65F4;
	Fri,  3 Apr 2026 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="RPdRSQmD"
X-Original-To: stable@vger.kernel.org
Received: from r3-19.sinamail.sina.com.cn (r3-19.sinamail.sina.com.cn [202.108.3.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406A72C0F8C
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775227747; cv=none; b=NKO+wL2Oc5U61vHsxsaQ4F5DaGe0NtgkoYpZJIE5m9oJ+nNL4/KnKP/QRQpUdjei84xFFD0ZZnOasTYlsIS3tkkUV/zSSlQX3fHz8Tm1EteKW+n5RI8GuUBT/HKrxMk4GBg03i03Gy8dfJrZEh9F/CNZNOaDKwcjBE/BLeUq700=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775227747; c=relaxed/simple;
	bh=kpNZ2tRFPauJ4iloa3xD+hYwiSlmHMBTOPYT8u0TuXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ezg2yH70RNoXr2ltf5iW48sNfEVv3xvZ/gzklUWnlzNfrYmI2qzi1oal1NHWfVmzYsN5ohGtksH2t+Wqs886yV4GlNRIJ5LI04v+rF+uBQyFAP4m7XaDyOpZxNYre+eh/Jo4c7i3pk4As7RiKHX311X3Fc5mdEBCX9CnCXkcKl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=RPdRSQmD; arc=none smtp.client-ip=202.108.3.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1775227742;
	bh=AF4nYcla3VpIRuqQdqNpWrxZwQFtoeEwcSNMCzgIhlc=;
	h=From:Subject:Date:Message-ID;
	b=RPdRSQmDVKjG1fycWJT7BPTbKisJQQOwPwY5mmpsZ/BlrlQ47uGk4z8ed6qHJdfxg
	 sZCfonEk/KRXByFtRjwsr+6jVlf72fI3+wclWaRQ2ssNzBLfOv6sryMKYeavxpDtxN
	 kTehbFiQmX0nn175De4l/cjgPqAUJQcICAF5AGVw=
X-SMAIL-HELO: xiaomi-ThinkCentre-M760t.mioffice.cn
Received: from unknown (HELO xiaomi-ThinkCentre-M760t.mioffice.cn)([114.247.175.249])
	by sina.com (10.54.253.32) with ESMTP
	id 69CFD21400004103; Fri, 3 Apr 2026 22:43:34 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=monty_pavel@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 3632074456635
X-SMAIL-UIID: 1A2EBCEA659143209B1AED43C96B5EFB-20260403-224334-1
From: Yongpeng Yang <monty_pavel@sina.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Yongpeng Yang <monty_pavel@sina.com>,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: fix node_cnt race between extent node destroy and writeback
Date: Fri,  3 Apr 2026 22:40:17 +0800
Message-ID: <20260403144015.221811-3-monty_pavel@sina.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233189-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB56F3955E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

f2fs_destroy_extent_node() does not set FI_NO_EXTENT before clearing
extent nodes. When called from f2fs_drop_inode() with I_SYNC set,
concurrent kworker writeback can insert new extent nodes into the same
extent tree, racing with the destroy and triggering f2fs_bug_on() in
__destroy_extent_node(). The scenario is as follows:

drop inode                            writeback
 - iput
  - f2fs_drop_inode  // I_SYNC set
   - f2fs_destroy_extent_node
    - __destroy_extent_node
     - while (node_cnt) {
        write_lock(&et->lock)
        __free_extent_tree
        write_unlock(&et->lock)
                                       - __writeback_single_inode
                                        - f2fs_outplace_write_data
                                         - f2fs_update_read_extent_cache
                                          - __update_extent_tree_range
                                           // FI_NO_EXTENT not set,
                                           // insert new extent node
       } // node_cnt == 0, exit while
     - f2fs_bug_on(node_cnt)  // node_cnt > 0

Additionally, __update_extent_tree_range() only checks FI_NO_EXTENT for
EX_READ type, leaving EX_BLOCK_AGE updates completely unprotected.

This patch set FI_NO_EXTENT under et->lock in __destroy_extent_node(),
consistent with other callers (__update_extent_tree_range and
__drop_extent_tree) and check FI_NO_EXTENT for both EX_READ and
EX_BLOCK_AGE tree.

Fixes: 3fc5d5a182f6 ("f2fs: fix to shrink read extent node in batches")
Cc: stable@vger.kernel.org
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/f2fs/extent_cache.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 0ed84cc065a7..87169fd29d89 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -119,9 +119,10 @@ static bool __may_extent_tree(struct inode *inode, enum extent_type type)
 	if (!__init_may_extent_tree(inode, type))
 		return false;
 
+	if (is_inode_flag_set(inode, FI_NO_EXTENT))
+		return false;
+
 	if (type == EX_READ) {
-		if (is_inode_flag_set(inode, FI_NO_EXTENT))
-			return false;
 		if (is_inode_flag_set(inode, FI_COMPRESSED_FILE) &&
 				 !f2fs_sb_has_readonly(F2FS_I_SB(inode)))
 			return false;
@@ -644,6 +645,8 @@ static unsigned int __destroy_extent_node(struct inode *inode,
 
 	while (atomic_read(&et->node_cnt)) {
 		write_lock(&et->lock);
+		if (!is_inode_flag_set(inode, FI_NO_EXTENT))
+			set_inode_flag(inode, FI_NO_EXTENT);
 		node_cnt += __free_extent_tree(sbi, et, nr_shrink);
 		write_unlock(&et->lock);
 	}
@@ -688,12 +691,12 @@ static void __update_extent_tree_range(struct inode *inode,
 
 	write_lock(&et->lock);
 
-	if (type == EX_READ) {
-		if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
-			write_unlock(&et->lock);
-			return;
-		}
+	if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
+		write_unlock(&et->lock);
+		return;
+	}
 
+	if (type == EX_READ) {
 		prev = et->largest;
 		dei.len = 0;
 
-- 
2.43.0


