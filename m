Return-Path: <stable+bounces-245783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCq4GuREA2ri2QEAu9opvQ
	(envelope-from <stable+bounces-245783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:19:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E955237C6
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E563630D63B0
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBC7360EE7;
	Tue, 12 May 2026 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i5VcPB+/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF3B30674C
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595863; cv=none; b=fVKt5meQrmdNC1whhgTHdMsRNJPpEPcRaVgpRlaSAcTgr1zMOzWybkYe6rGFzeOmBRQwZQWie+V6nO4MzKGlhPhx2FGk1DVFspiXelJFXWoapMXuENEUP6jF2GQe0jHR3AElPSqHzeieucR+N9WltB5v/L3jqWQDKwv5omlxN+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595863; c=relaxed/simple;
	bh=YEzkWmkGXIgxIPinRqqDUSJMk59Wywe5n+YyCQlLtOo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pcCZ/gM3wdeONzw/0xidwgWEUrunTbw7OMToa6TJlwim5nrCoNWDjebUzaU0ocBulwQSvOMQFmL0g8we7s7LT4yGxLtuBImyFV78vli0tkYEVHMiIfBiZNu1G+br5b4vZs3U7ljrtFuYvA9KGJ9OBr2+xuOmaE2QyiYJAH+H3OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i5VcPB+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4E0C2BCB0;
	Tue, 12 May 2026 14:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778595862;
	bh=YEzkWmkGXIgxIPinRqqDUSJMk59Wywe5n+YyCQlLtOo=;
	h=Subject:To:Cc:From:Date:From;
	b=i5VcPB+/tMmtcbHYMgnmjQcFpr16ndjOO1P6qLeupFxfdydbB1lTZZTHuA8ugsMgl
	 zNmqk7Qyw+GjFJVikZ/uZmu+gei3CFOiFBcBHU6cpytG/I+4UXefz2vjQcQhsaskXn
	 RHwrBxEfo4SyybeL0C6kM9PZ1gY9g97hxQAeR13Q=
Subject: FAILED: patch "[PATCH] f2fs: fix fsck inconsistency caused by FGGC of node block" failed to apply to 6.1-stable tree
To: yangyongpeng@xiaomi.com,chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:24:17 +0200
Message-ID: <2026051217-shortlist-cartwheel-01b0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 05E955237C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245783-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vm:email,xiaomi.com:email,linuxfoundation.org:dkim,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c3e238bd1f56993f205ef83889d406dfeaf717a8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051217-shortlist-cartwheel-01b0@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c3e238bd1f56993f205ef83889d406dfeaf717a8 Mon Sep 17 00:00:00 2001
From: Yongpeng Yang <yangyongpeng@xiaomi.com>
Date: Wed, 18 Mar 2026 16:45:34 +0800
Subject: [PATCH] f2fs: fix fsck inconsistency caused by FGGC of node block

During FGGC node block migration, fsck may incorrectly treat the
migrated node block as fsync-written data.

The reproduction scenario:
root@vm:/mnt/f2fs# seq 1 2048 | xargs -n 1 ./test_sync // write inline inode and sync
root@vm:/mnt/f2fs# rm -f 1
root@vm:/mnt/f2fs# sync
root@vm:/mnt/f2fs# f2fs_io gc_range // move data block in sync mode and not write CP
  SPO, "fsck --dry-run" find inode has already checkpointed but still
  with DENT_BIT_SHIFT set

The root cause is that GC does not clear the dentry mark and fsync mark
during node block migration, leading fsck to misinterpret them as
user-issued fsync writes.

In BGGC mode, node block migration is handled by f2fs_sync_node_pages(),
which guarantees the dentry and fsync marks are cleared before writing.

This patch move the set/clear of the fsync|dentry marks into
__write_node_folio to make the logic clearer, and ensures the
fsync|dentry mark is cleared in FGGC.

Cc: stable@kernel.org
Fixes: da011cc0da8c ("f2fs: move node pages only in victim section during GC")
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 630fd3b43a08..c7499cb52745 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1727,9 +1727,10 @@ static struct folio *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 	return last_folio;
 }
 
-static bool __write_node_folio(struct folio *folio, bool atomic, bool *submitted,
-				struct writeback_control *wbc, bool do_balance,
-				enum iostat_type io_type, unsigned int *seq_id)
+static bool __write_node_folio(struct folio *folio, bool atomic, bool do_fsync,
+				bool *submitted, struct writeback_control *wbc,
+				bool do_balance, enum iostat_type io_type,
+				unsigned int *seq_id)
 {
 	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
 	nid_t nid;
@@ -1802,6 +1803,8 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool *submitted
 	if (atomic && !test_opt(sbi, NOBARRIER))
 		fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
 
+	set_dentry_mark(folio, false);
+	set_fsync_mark(folio, do_fsync);
 	if (IS_INODE(folio) && (atomic || is_fsync_dnode(folio)))
 		set_dentry_mark(folio,
 				f2fs_need_dentry_mark(sbi, ino_of_node(folio)));
@@ -1868,7 +1871,7 @@ static int f2fs_write_single_node_folio(struct folio *node_folio, int sync_mode,
 		goto out_folio;
 	}
 
-	if (!__write_node_folio(node_folio, false, NULL,
+	if (!__write_node_folio(node_folio, false, false, NULL,
 				&wbc, false, FS_GC_NODE_IO, NULL))
 		err = -EAGAIN;
 	goto release_folio;
@@ -1915,6 +1918,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 		for (i = 0; i < nr_folios; i++) {
 			struct folio *folio = fbatch.folios[i];
 			bool submitted = false;
+			bool do_fsync = false;
 
 			if (unlikely(f2fs_cp_error(sbi))) {
 				f2fs_folio_put(last_folio, false);
@@ -1945,11 +1949,8 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 
 			f2fs_folio_wait_writeback(folio, NODE, true, true);
 
-			set_fsync_mark(folio, 0);
-			set_dentry_mark(folio, 0);
-
 			if (!atomic || folio == last_folio) {
-				set_fsync_mark(folio, 1);
+				do_fsync = true;
 				percpu_counter_inc(&sbi->rf_node_block_count);
 				if (IS_INODE(folio)) {
 					if (is_inode_flag_set(inode,
@@ -1966,8 +1967,9 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 
 			if (!__write_node_folio(folio, atomic &&
 						folio == last_folio,
-						&submitted, wbc, true,
-						FS_NODE_IO, seq_id)) {
+						do_fsync, &submitted,
+						wbc, true, FS_NODE_IO,
+						seq_id)) {
 				f2fs_folio_put(last_folio, false);
 				folio_batch_release(&fbatch);
 				ret = -EIO;
@@ -2167,10 +2169,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 			if (!folio_clear_dirty_for_io(folio))
 				goto continue_unlock;
 
-			set_fsync_mark(folio, 0);
-			set_dentry_mark(folio, 0);
-
-			if (!__write_node_folio(folio, false, &submitted,
+			if (!__write_node_folio(folio, false, false, &submitted,
 					wbc, do_balance, io_type, NULL)) {
 				folio_batch_release(&fbatch);
 				ret = -EIO;


