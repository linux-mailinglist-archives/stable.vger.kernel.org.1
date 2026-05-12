Return-Path: <stable+bounces-245779-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHzYC9tEA2ri2QEAu9opvQ
	(envelope-from <stable+bounces-245779-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:18:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF335237AF
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8967A31AC184
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA863AB49A;
	Tue, 12 May 2026 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zif/6P/m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7EF30674C
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595851; cv=none; b=iVlgLkcRUOswsS2l3GShvUIjbomNHh23tVF/vM34rpRq+Il3DyvHsaqHvxTXz8d2HgCcmgXYPCXLcS01xRpQWk4rt/+ZlqA7bGa3frIEQPy+jU00Xy/CHrUI5tCAj2B0W3FOak7A6GL3FDT7UJdHHMB0dM04M6RGDAtgqmk1U7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595851; c=relaxed/simple;
	bh=rZ1tOOHVf539mu2QYSjbIvKYjOJyxbhqcSD+etgx3HM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PdDDg2ROox9iIf4vbThlXfjVTTTOftVFw4QN1AHMdqQHcur1ngX/fukyUBmpbBVmSaVKc2EBZBnUt6OBbOj8AwtazMtTsSFyVowQk+l1fppas7J+XbP4N7TfR4Id+tlhq71w0k9IMc58Y6cbx2X9sTzGznR1JoQ7udF11yjKcVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zif/6P/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402E2C2BCB0;
	Tue, 12 May 2026 14:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778595851;
	bh=rZ1tOOHVf539mu2QYSjbIvKYjOJyxbhqcSD+etgx3HM=;
	h=Subject:To:Cc:From:Date:From;
	b=zif/6P/m49adkQqzar8vElz8Epb+SalwSXro2vDIY/MQ8C8gypUXn4GNv8Sc8F78t
	 ZmQVtNA8kho/YIH2eHUewExzJZPze2pr+78jS9UhO1X+lw4osfg9bkkrlEhXvj7eN+
	 pPDW+/CHzFgmYvWVqopIC4veJBP8HSIf0BfIId+Q=
Subject: FAILED: patch "[PATCH] f2fs: fix inline data not being written to disk in writeback" failed to apply to 5.15-stable tree
To: yangyongpeng@xiaomi.com,chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:24:06 +0200
Message-ID: <2026051206-kudos-jawless-4dcf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9DF335237AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245779-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vm:email,xiaomi.com:email,linuxfoundation.org:dkim,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x fe9b8b30b97102859a9102be7bd2a09803bd90bd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051206-kudos-jawless-4dcf@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fe9b8b30b97102859a9102be7bd2a09803bd90bd Mon Sep 17 00:00:00 2001
From: Yongpeng Yang <yangyongpeng@xiaomi.com>
Date: Wed, 18 Mar 2026 16:46:35 +0800
Subject: [PATCH] f2fs: fix inline data not being written to disk in writeback
 path

When f2fs_fiemap() is called with `fileinfo->fi_flags` containing the
FIEMAP_FLAG_SYNC flag, it attempts to write data to disk before
retrieving file mappings via filemap_write_and_wait(). However, there is
an issue where the file does not get mapped as expected. The following
scenario can occur:

root@vm:/mnt/f2fs# dd if=/dev/zero of=data.3k bs=3k count=1
root@vm:/mnt/f2fs# xfs_io data.3k -c "fiemap -v 0 4096"
data.3k:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..5]:          0..5                 6 0x307

The root cause of this issue is that f2fs_write_single_data_page() only
calls f2fs_write_inline_data() to copy data from the data folio to the
inode folio, and it clears the dirty flag on the data folio. However, it
does not mark the data folio as writeback. When
__filemap_fdatawait_range() checks for folios with the writeback flag,
it returns early, causing f2fs_fiemap() to report that the file has no
mapping.

To fix this issue, the solution is to call
f2fs_write_single_node_folio() in f2fs_inline_data_fiemap() when
getting fiemap with FIEMAP_FLAG_SYNC flags. This patch ensures that the
inode folio is written back and the writeback process completes before
proceeding.

Cc: stable@kernel.org
Fixes: 9ffe0fb5f3bb ("f2fs: handle inline data operations")
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index df4cdf804376..39b97621456a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3946,6 +3946,8 @@ int f2fs_sanity_check_node_footer(struct f2fs_sb_info *sbi,
 					enum node_type ntype, bool in_irq);
 struct folio *f2fs_get_inode_folio(struct f2fs_sb_info *sbi, pgoff_t ino);
 struct folio *f2fs_get_xnode_folio(struct f2fs_sb_info *sbi, pgoff_t xnid);
+int f2fs_write_single_node_folio(struct folio *node_folio, int sync_mode,
+			bool mark_dirty, enum iostat_type io_type);
 int f2fs_move_node_folio(struct folio *node_folio, int gc_type);
 void f2fs_flush_inline_data(struct f2fs_sb_info *sbi);
 int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 86d2abbb40ff..62a8a1192a41 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -814,6 +814,15 @@ int f2fs_inline_data_fiemap(struct inode *inode,
 		goto out;
 	}
 
+	if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC) {
+		err = f2fs_write_single_node_folio(ifolio, true, false, FS_NODE_IO);
+		if (err)
+			return err;
+		ifolio = f2fs_get_inode_folio(F2FS_I_SB(inode), inode->i_ino);
+		if (IS_ERR(ifolio))
+			return PTR_ERR(ifolio);
+		f2fs_folio_wait_writeback(ifolio, NODE, true, true);
+	}
 	ilen = min_t(size_t, MAX_INLINE_DATA(inode), i_size_read(inode));
 	if (start >= ilen)
 		goto out;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c7499cb52745..a9cd2803e681 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1843,7 +1843,7 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool do_fsync,
 	return false;
 }
 
-static int f2fs_write_single_node_folio(struct folio *node_folio, int sync_mode,
+int f2fs_write_single_node_folio(struct folio *node_folio, int sync_mode,
 			bool mark_dirty, enum iostat_type io_type)
 {
 	int err = 0;


