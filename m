Return-Path: <stable+bounces-246285-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNzhF2VrA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246285-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:03:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE8A5269BF
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4280D3079E63
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F780349AF5;
	Tue, 12 May 2026 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MBis32nZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3424343D9D;
	Tue, 12 May 2026 18:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608833; cv=none; b=VoAfBoRXEAadGJ0yBNr4Lv7zMcHMd3RchVsrkjfsqthvF+hBbAEwm6ICfMBRIq3D97xfmkVsnFi28+Lxib3RBIkc85//HFZ+4CZBG3CbGV5nd0dAjCpltK7eLIy400DE3tWNFLNAc5qm6+tyS5S9+fPXfmj9YenzsY6TMh50aUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608833; c=relaxed/simple;
	bh=i8ZetFbii4PMyzDIdPhn9ia72e6Ql5AdXtZBVG06kcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dODHJASfLwEy5nDPvSBZGv80lB19YKRY7vf4MFy4uuVlDifv+GmCyIMCOdVUFA0S+0Jhb6PhjNXncDj1mwfahoowT/fEBwAiVlvcndWLsHE5xbz5jfyVDSnMRSjdoIauK30pApT3ym6TKMufAItOmvw2gWeI2XxPjy4wkDrSeJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MBis32nZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD08C2BCB0;
	Tue, 12 May 2026 18:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608832;
	bh=i8ZetFbii4PMyzDIdPhn9ia72e6Ql5AdXtZBVG06kcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MBis32nZdKzvTAg8haGXka4l6utqZqlArmRvb2t4EvcZ+hFDWFtPQPVgFEmkdR1Eq
	 cyl8JMFSlO7CimdgoBhcluATxx+GY9dKO6kKNigjTJ3YFwGgM1u6F/ffuDcIHsLEhp
	 osEJGhV2iqSsQK/AiztOGs+ZAZN5hTrECk/Qe+aM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.18 232/270] f2fs: fix fsck inconsistency caused by FGGC of node block
Date: Tue, 12 May 2026 19:40:33 +0200
Message-ID: <20260512173943.328456726@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3EE8A5269BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246285-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,xiaomi.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

commit c3e238bd1f56993f205ef83889d406dfeaf717a8 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/node.c |   27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1709,9 +1709,10 @@ continue_unlock:
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
@@ -1783,6 +1784,8 @@ static bool __write_node_folio(struct fo
 	if (atomic && !test_opt(sbi, NOBARRIER))
 		fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
 
+	set_dentry_mark(folio, false);
+	set_fsync_mark(folio, do_fsync);
 	if (IS_INODE(folio) && (atomic || is_fsync_dnode(folio)))
 		set_dentry_mark(folio,
 				f2fs_need_dentry_mark(sbi, ino_of_node(folio)));
@@ -1849,7 +1852,7 @@ int f2fs_write_single_node_folio(struct
 		goto out_folio;
 	}
 
-	if (!__write_node_folio(node_folio, false, NULL,
+	if (!__write_node_folio(node_folio, false, false, NULL,
 				&wbc, false, FS_GC_NODE_IO, NULL))
 		err = -EAGAIN;
 	goto release_folio;
@@ -1896,6 +1899,7 @@ retry:
 		for (i = 0; i < nr_folios; i++) {
 			struct folio *folio = fbatch.folios[i];
 			bool submitted = false;
+			bool do_fsync = false;
 
 			if (unlikely(f2fs_cp_error(sbi))) {
 				f2fs_folio_put(last_folio, false);
@@ -1926,11 +1930,8 @@ continue_unlock:
 
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
@@ -1947,8 +1948,9 @@ continue_unlock:
 
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
@@ -2148,10 +2150,7 @@ write_node:
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



