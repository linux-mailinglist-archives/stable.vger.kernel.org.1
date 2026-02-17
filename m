Return-Path: <stable+bounces-216796-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BDuOGxklGkFDgIAu9opvQ
	(envelope-from <stable+bounces-216796-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 13:51:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 753EB14C1E1
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 13:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96E0530364D0
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 12:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4472935581C;
	Tue, 17 Feb 2026 12:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZcPEgEeo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091E235580C
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771332693; cv=none; b=MxAMsNSK8E1roNW15Sb7XUpsb1w/Ap5mqfsZhOdA8f1+0sTrMdLUkh2mSOLEGu86+Cx227a24UKExdE/oBaYBNmiYLJ8RBjLwP0kq8z6+4LfH+IY1prj+xdvvNKy+npyPjMTTDs2kw41HSQRa073SccVLj9i4GJw6ZPOePfqYcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771332693; c=relaxed/simple;
	bh=/bX7fb3Cr0DFwxvGQ4mvt7zNB8L7tKV8y5krlxH5h1s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ry+hbDkXMBzuN2ozw0SVMu5y0u+u0ez2mpV53A2aflp0Wue/fbEr7Hz1VJghsUFro59DfeiNX/VUHXUsUnjsy1xzNOrCgFQJ1/oIbY0y9ov9wzamDBNYfvAqb6i6yqMKZD84Q/ApblBGVI1dyqqWkiymORJtqYX/E2f4XhdLGfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZcPEgEeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C10C19423;
	Tue, 17 Feb 2026 12:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771332692;
	bh=/bX7fb3Cr0DFwxvGQ4mvt7zNB8L7tKV8y5krlxH5h1s=;
	h=Subject:To:Cc:From:Date:From;
	b=ZcPEgEeoo2EzXOcJ4Sepvz5DfQYLvO1dU2QEajgoxqep84VlCvKY0VFIegkbuCF0n
	 5CWfZ5yWC/0GDy1vvI3p0Hfrpj220oJZ5y994CH1Tvr7E6tUCz324RGKKv9dj9Jc3A
	 JuD5pLeNPux7AM2dsjQK2z+8+Z4ArwAiY8fDWjys=
Subject: FAILED: patch "[PATCH] f2fs: fix IS_CHECKPOINTED flag inconsistency issue caused by" failed to apply to 6.12-stable tree
To: yangyongpeng@xiaomi.com,chao@kernel.org,jaegeuk@kernel.org,liujinbao1@xiaomi.com,shengyong1@xiaomi.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Feb 2026 13:51:29 +0100
Message-ID: <2026021729-asparagus-duration-50da@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216796-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,xiaomi.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 753EB14C1E1
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 7633a7387eb4d0259d6bea945e1d3469cd135bbc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026021729-asparagus-duration-50da@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7633a7387eb4d0259d6bea945e1d3469cd135bbc Mon Sep 17 00:00:00 2001
From: Yongpeng Yang <yangyongpeng@xiaomi.com>
Date: Tue, 6 Jan 2026 20:12:11 +0800
Subject: [PATCH] f2fs: fix IS_CHECKPOINTED flag inconsistency issue caused by
 concurrent atomic commit and checkpoint writes

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

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index d378549010e6..99e425e8c00a 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1786,8 +1786,13 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool *submitted
 		goto redirty_out;
 	}
 
-	if (atomic && !test_opt(sbi, NOBARRIER))
-		fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
+	if (atomic) {
+		if (!test_opt(sbi, NOBARRIER))
+			fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
+		if (IS_INODE(folio))
+			set_dentry_mark(folio,
+				f2fs_need_dentry_mark(sbi, ino_of_node(folio)));
+	}
 
 	/* should add to global list before clearing PAGECACHE status */
 	if (f2fs_in_warm_node_list(sbi, folio)) {
@@ -1928,8 +1933,9 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 					if (is_inode_flag_set(inode,
 								FI_DIRTY_INODE))
 						f2fs_update_inode(inode, folio);
-					set_dentry_mark(folio,
-						f2fs_need_dentry_mark(sbi, ino));
+					if (!atomic)
+						set_dentry_mark(folio,
+							f2fs_need_dentry_mark(sbi, ino));
 				}
 				/* may be written by other thread */
 				if (!folio_test_dirty(folio))


