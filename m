Return-Path: <stable+bounces-216800-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EB8IHRklGkFDgIAu9opvQ
	(envelope-from <stable+bounces-216800-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 13:52:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD3014C1F1
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 13:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6AEFE300698B
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 12:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC88355049;
	Tue, 17 Feb 2026 12:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ua0oNIJ2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5459D35504D
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 12:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771332707; cv=none; b=WCxX/7UsGQoTDvmtcT4T16n+FALI+nhCgGFPQzIhinXTu8b/n4lWUvYLsw7P9eZlB+csuOuFKG0suuQu+Ab+Vbve/CbbsBI7YoG5wMi3Qe9WXR0kkVghgruyxx+WFuy9taX+MEnXN07lSbSgAJUdNfLatg9fkdxPB6aqOqv9hSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771332707; c=relaxed/simple;
	bh=H9yYYUpMB+UDGjy/fZz2yOqGVmvQcfPqyf/ONc/I3Po=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E8AflCfUJFlaGHymH9Hg3tXBvlaOYyRY1R01ZdbcUIbLj+M+2QhjE1ZXycDedqteTXRw7bDYR4juFgFGn0qg7dXc2Q6DBvDsThEaEOb7n9qYOvA9Kw9y43dqU8og0zhnn4CD6pjIW2hMdDbaE6PvDIFvuUD8XlCjtH2dpoQ6V8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ua0oNIJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6886EC4CEF7;
	Tue, 17 Feb 2026 12:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771332706;
	bh=H9yYYUpMB+UDGjy/fZz2yOqGVmvQcfPqyf/ONc/I3Po=;
	h=Subject:To:Cc:From:Date:From;
	b=Ua0oNIJ2B3cJTGSlmxEonxJR/Dd/jk3RoFTQ920FFpm0a8B6zFX+7NR+l3v6mrTgw
	 BZeZepY+8tE75pNhSdrNUP9ya8K++DFblmUPp31OFUlt0LsHbKa4/Wq3gcPtIExg+M
	 BPy6jTXGIuabv6MT82cena9PRsqyfKL7qS+Gomww=
Subject: FAILED: patch "[PATCH] f2fs: fix IS_CHECKPOINTED flag inconsistency issue caused by" failed to apply to 5.10-stable tree
To: yangyongpeng@xiaomi.com,chao@kernel.org,jaegeuk@kernel.org,liujinbao1@xiaomi.com,shengyong1@xiaomi.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Feb 2026 13:51:33 +0100
Message-ID: <2026021733-aluminum-salutary-e3d3@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216800-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xiaomi.com:email,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFD3014C1F1
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7633a7387eb4d0259d6bea945e1d3469cd135bbc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026021733-aluminum-salutary-e3d3@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


