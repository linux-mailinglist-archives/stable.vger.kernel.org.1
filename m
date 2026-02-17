Return-Path: <stable+bounces-216847-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIwGEvaGlGmWFQIAu9opvQ
	(envelope-from <stable+bounces-216847-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 16:19:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 998FE14D860
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 16:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2589302FA97
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 15:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6B4274FD0;
	Tue, 17 Feb 2026 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6KHxEij"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E175274658
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771341549; cv=none; b=rAZvJiyXT+4hzfd/FQUhI6yBn/A+H7LDdQgV9pERsxc56lK9EOsScnjNQ96md0jfSsLt8X98bZ6u54llfZzn+TQYj5v+ILXPZhmuwiHZPfz55Iir9IiPCM/hJ+zS2BuVkJKTsQQIlHmWUZMDSrXLvNECEKwvz+zOGhAlHYWecq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771341549; c=relaxed/simple;
	bh=TDkbTbE45fGYAJVx1U/aETC3oczh5GpYgT371dGfUp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ec0hN4c2BEnbZZvKxADGsEQwvEL91AW+pEfL0Sa5TBC2zTnMl4bvwiFO1YZQqs8E1HrvcQ8B+y5bkqNsahQI6MylqumduKBVJo2LijG0BSXM1waYwSSY1u25Z7+Vc0fQK0v7o96ZCTQann2daAGv6ZcY6DdaJ+vfL5si6y6CO7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6KHxEij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9C7C4CEF7;
	Tue, 17 Feb 2026 15:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771341548;
	bh=TDkbTbE45fGYAJVx1U/aETC3oczh5GpYgT371dGfUp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u6KHxEijCrPFmV54eK8QFYwprcWjLCCtI9gSjf7ya6syv92O4TfzohK7g9XZvDp7T
	 g+lO14QO6t0shs9UunD2jyQrErU1pqQZDX+IqgsCb254tSdHJ+DC6/I7MRRycF03bU
	 Nu3K97m7bmw1kZvGDW3Q0UDRwcO+JpyYOvSjyVvfWERs7X4AlkyqkjyO2IZqpyyzYo
	 3kKEgp934yf9ioyirVmF1texKZrWloIax15wmIW3+0vaNz66qle+40yJDvMt9nuAK/
	 prnY/t5QV+mEj79jBwI9TEjDNXH6qykipwcQfeQZpULAe0Hkwxd4qhNDYKgrPziFFk
	 0qULAOA9fWCOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
	stable@kernel.org,
	Sheng Yong <shengyong1@xiaomi.com>,
	Jinbao Liu <liujinbao1@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] f2fs: fix IS_CHECKPOINTED flag inconsistency issue caused by concurrent atomic commit and checkpoint writes
Date: Tue, 17 Feb 2026 10:19:06 -0500
Message-ID: <20260217151906.3676334-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026021729-asparagus-duration-50da@gregkh>
References: <2026021729-asparagus-duration-50da@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-216847-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 998FE14D860
X-Rspamd-Action: no action

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

[ Upstream commit 7633a7387eb4d0259d6bea945e1d3469cd135bbc ]

During SPO tests, when mounting F2FS, an -EINVAL error was returned from
f2fs_recover_inode_page. The issue occurred under the following scenario

Thread A                                     Thread B
f2fs_ioc_commit_atomic_write
 - f2fs_do_sync_file // atomic = true
  - f2fs_fsync_node_pages
    : last_folio = inode folio
    : schedule before folio_lock(last_folio) f2fs_write_checkpoint
                                              - block_operations// writeback last_folio
                                              - schedule before f2fs_flush_nat_entries
    : set_fsync_mark(last_folio, 1)
    : set_dentry_mark(last_folio, 1)
    : folio_mark_dirty(last_folio)
    - __write_node_folio(last_folio)
      : f2fs_down_read(&sbi->node_write)//block
                                              - f2fs_flush_nat_entries
                                                : {struct nat_entry}->flag |= BIT(IS_CHECKPOINTED)
                                              - unblock_operations
                                                : f2fs_up_write(&sbi->node_write)
                                             f2fs_write_checkpoint//return
      : f2fs_do_write_node_page()
f2fs_ioc_commit_atomic_write//return
                                             SPO

Thread A calls f2fs_need_dentry_mark(sbi, ino), and the last_folio has
already been written once. However, the {struct nat_entry}->flag did not
have the IS_CHECKPOINTED set, causing set_dentry_mark(last_folio, 1) and
write last_folio again after Thread B finishes f2fs_write_checkpoint.

After SPO and reboot, it was detected that {struct node_info}->blk_addr
was not NULL_ADDR because Thread B successfully write the checkpoint.

This issue only occurs in atomic write scenarios. For regular file
fsync operations, the folio must be dirty. If
block_operations->f2fs_sync_node_pages successfully submit the folio
write, this path will not be executed. Otherwise, the
f2fs_write_checkpoint will need to wait for the folio write submission
to complete, as sbi->nr_pages[F2FS_DIRTY_NODES] > 0. Therefore, the
situation where f2fs_need_dentry_mark checks that the {struct
nat_entry}->flag /wo the IS_CHECKPOINTED flag, but the folio write has
already been submitted, will not occur.

Therefore, for atomic file fsync, sbi->node_write should be acquired
through __write_node_folio to ensure that the IS_CHECKPOINTED flag
correctly indicates that the checkpoint write has been completed.

Fixes: 608514deba38 ("f2fs: set fsync mark only for the last dnode")
Cc: stable@kernel.org
Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
Signed-off-by: Jinbao Liu <liujinbao1@xiaomi.com>
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ folio => page ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 720768d574ae6..1f4f68e56d432 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1713,8 +1713,13 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 		goto redirty_out;
 	}
 
-	if (atomic && !test_opt(sbi, NOBARRIER))
-		fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
+	if (atomic) {
+		if (!test_opt(sbi, NOBARRIER))
+			fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
+		if (IS_INODE(page))
+			set_dentry_mark(page,
+				f2fs_need_dentry_mark(sbi, ino_of_node(page)));
+	}
 
 	/* should add to global list before clearing PAGECACHE status */
 	if (f2fs_in_warm_node_list(sbi, page)) {
@@ -1869,8 +1874,9 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 					if (is_inode_flag_set(inode,
 								FI_DIRTY_INODE))
 						f2fs_update_inode(inode, page);
-					set_dentry_mark(page,
-						f2fs_need_dentry_mark(sbi, ino));
+					if (!atomic)
+						set_dentry_mark(page,
+							f2fs_need_dentry_mark(sbi, ino));
 				}
 				/* may be written by other thread */
 				if (!PageDirty(page))
-- 
2.51.0


