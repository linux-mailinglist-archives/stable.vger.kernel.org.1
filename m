Return-Path: <stable+bounces-270450-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7TQ8NHBmRmr4SgsAu9opvQ
	(envelope-from <stable+bounces-270450-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 15:24:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CA56F84BA
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 15:23:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=GiDlhvXB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270450-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-270450-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C2943004630
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 13:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CF142E8E5;
	Thu,  2 Jul 2026 13:09:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB8F26E165
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:09:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997747; cv=none; b=MQEQOwUkaJvRzJ6BjjUpIFbSQj1NkO1ObyFWLt7PwBuToQhKTrbUwlPObEPmHwCGJMbQGqTemM4qHDuLhWSU4dgYLC62x0lrjG/nU0SR1G/bN2dEkDx69llXg0f/7o745PgFdxOTCH5mJFf27zn1e5cp2o/qAlzQiAM05cBPchY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997747; c=relaxed/simple;
	bh=jUS9MQQyjSNdg5l6rtzQF8dOhux0UzX3nscLJMR+7BM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rYJKBU7G4CMFSpBjTOkXBk0o0sE6T5ip2nQk43jXJsQ7kPAH4J/08un3Z0qVMToHpbXUC64j0/l0pR0tfqVYA/saoVDXEEzWr3ChqbQzsSRABK2rPHPfAi4TK9VcKQT23C+Iwq1ccktM/rYN6moi7PzvMaGHkyw8zomsmqvT4VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GiDlhvXB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE3E1F00A3A;
	Thu,  2 Jul 2026 13:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782997744;
	bh=+dKXuFwjhuPtQ9JVEMLUGR0hghHjXXKQa8ZIAa49M3o=;
	h=Subject:To:Cc:From:Date;
	b=GiDlhvXB+/xWdkM1J+N0h41VqL2DlrcN1rGwfZpH1/uy+WImjnspEVJ2mikeGfEAN
	 UDzwLZOBHjvjXxP8w/hDntSvnrJazQAO26A9y1dRKnagyQ4A3J9VUixPLj1pTXGhZ0
	 Eunpv8h4IPraxoyngA9YHIrelHAM5UOhwhD4l6E4=
Subject: FAILED: patch "[PATCH] f2fs: validate orphan inode entry count" failed to apply to 6.1-stable tree
To: qwjhust@gmail.com,chao@kernel.org,jaegeuk@kernel.org,qiwenjie@xiaomi.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:09:02 +0200
Message-ID: <2026070202-reptile-shriek-5d21@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270450-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,xiaomi.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:qwjhust@gmail.com,m:chao@kernel.org,m:jaegeuk@kernel.org,m:qiwenjie@xiaomi.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2CA56F84BA


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 846c499a65816d13f1186e3090e825e8bb8bcb8b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070202-reptile-shriek-5d21@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 846c499a65816d13f1186e3090e825e8bb8bcb8b Mon Sep 17 00:00:00 2001
From: Wenjie Qi <qwjhust@gmail.com>
Date: Tue, 26 May 2026 13:35:57 +0800
Subject: [PATCH] f2fs: validate orphan inode entry count

f2fs_recover_orphan_inodes() trusts the orphan block entry_count when
replaying orphan inodes from the checkpoint pack. A corrupted entry_count
larger than F2FS_ORPHANS_PER_BLOCK makes the recovery loop read past the
ino[] array and interpret footer or following data as inode numbers.

On a crafted image, mounting an unpatched kernel can drive orphan recovery
into f2fs_bug_on() and panic the kernel. Validate entry_count before
consuming entries so corrupted checkpoint data fails the mount with
-EFSCORRUPTED and requests fsck instead.

Set ERROR_INCONSISTENT_ORPHAN as well, so the corruption reason can be
recorded in the superblock s_errors[] field. This gives fsck a persistent
hint even though mount-time orphan recovery failure may leave no chance to
persist SBI_NEED_FSCK through a checkpoint.

Cc: stable@kernel.org
Fixes: 127e670abfa7 ("f2fs: add checkpoint operations")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index c00a6b6ebcbd..064f5b537423 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -943,6 +943,7 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	for (i = 0; i < orphan_blocks; i++) {
 		struct folio *folio;
 		struct f2fs_orphan_block *orphan_blk;
+		unsigned int entry_count;
 
 		folio = f2fs_get_meta_folio(sbi, start_blk + i);
 		if (IS_ERR(folio)) {
@@ -951,7 +952,18 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 		}
 
 		orphan_blk = folio_address(folio);
-		for (j = 0; j < le32_to_cpu(orphan_blk->entry_count); j++) {
+		entry_count = le32_to_cpu(orphan_blk->entry_count);
+		if (entry_count > F2FS_ORPHANS_PER_BLOCK) {
+			f2fs_err(sbi, "invalid orphan inode entry count %u",
+				 entry_count);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_handle_error(sbi, ERROR_INCONSISTENT_ORPHAN);
+			err = -EFSCORRUPTED;
+			f2fs_folio_put(folio, true);
+			goto out;
+		}
+
+		for (j = 0; j < entry_count; j++) {
 			nid_t ino = le32_to_cpu(orphan_blk->ino[j]);
 
 			err = recover_orphan_inode(sbi, ino);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 829a59399dac..bb2b6cd5d507 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -107,6 +107,7 @@ enum f2fs_error {
 	ERROR_CORRUPTED_XATTR,
 	ERROR_INVALID_NODE_REFERENCE,
 	ERROR_INCONSISTENT_NAT,
+	ERROR_INCONSISTENT_ORPHAN,
 	ERROR_MAX,
 };
 


