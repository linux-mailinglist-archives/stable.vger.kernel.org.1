Return-Path: <stable+bounces-84476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D72E99D05E
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F342847A6
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070C41B0137;
	Mon, 14 Oct 2024 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wPYXgPza"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76573BBF2;
	Mon, 14 Oct 2024 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918142; cv=none; b=CRC9r86of7Wl2L9VTFfy3gbOo/zSsR1/0926qQmjco+OQcMruGYUv5XJhWIp0HEt/HHguJQfEupuLzPK4tgdSPCgVP6dxiuAxR7XTcG9B6ggFGFwD7nS79f9U2PjmLoRyYHz2qYEOpwWhtMBt6ci36jpT30QC7Yu+c6ns1ZDiqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918142; c=relaxed/simple;
	bh=IQ+q3coEPoMnyTujt3sVcMLPv91YRXGwMcl6ILAZB4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRiKrz99ajW/nk8WIr7IIRZjrV86GP6/AHLk27s3pFERKVhSOwEcj54c1Vp87NdWjf7p6pNCVzQbUzRGm04Rk2ttQRLqaqgcZOpUWofiytmr9dk8C14aAeC/DxnruQZmbU/9Xs9jonwEHbO3P6LNmKxp6wTa+EL/vIPhi9lYjMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wPYXgPza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC64C4CEC3;
	Mon, 14 Oct 2024 15:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918142;
	bh=IQ+q3coEPoMnyTujt3sVcMLPv91YRXGwMcl6ILAZB4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wPYXgPzahKGf4fEdpxeTQaKAuz7R2fbDhBc5qaD5KklnTni6tyDFsuPq39IsXR96i
	 d13RBORY397LoW/V9uoMCuiuFPj3IwAhdPJ37dN+s3pUFNM1e+nlT59i3AgxppFLmD
	 0GyzBXoicPtN3K2CZUZwQEXz0ykCZTXxmm5u8xSI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	wangzijie <wangzijie1@honor.com>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Yunlei He <heyunlei@hihonor.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 236/798] f2fs: reduce expensive checkpoint trigger frequency
Date: Mon, 14 Oct 2024 16:13:10 +0200
Message-ID: <20241014141227.191987045@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao@kernel.org>

[ Upstream commit aaf8c0b9ae042494cb4585883b15c1332de77840 ]

We may trigger high frequent checkpoint for below case:
1. mkdir /mnt/dir1; set dir1 encrypted
2. touch /mnt/file1; fsync /mnt/file1
3. mkdir /mnt/dir2; set dir2 encrypted
4. touch /mnt/file2; fsync /mnt/file2
...

Although, newly created dir and file are not related, due to
commit bbf156f7afa7 ("f2fs: fix lost xattrs of directories"), we will
trigger checkpoint whenever fsync() comes after a new encrypted dir
created.

In order to avoid such performance regression issue, let's record an
entry including directory's ino in global cache whenever we update
directory's xattr data, and then triggerring checkpoint() only if
xattr metadata of target file's parent was updated.

This patch updates to cover below no encryption case as well:
1) parent is checkpointed
2) set_xattr(dir) w/ new xnid
3) create(file)
4) fsync(file)

Fixes: bbf156f7afa7 ("f2fs: fix lost xattrs of directories")
Reported-by: wangzijie <wangzijie1@honor.com>
Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Tested-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Reported-by: Yunlei He <heyunlei@hihonor.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h              |  2 ++
 fs/f2fs/file.c              |  3 +++
 fs/f2fs/xattr.c             | 14 ++++++++++++--
 include/trace/events/f2fs.h |  3 ++-
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2b540d87859e0..dc637dfb1ead2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -284,6 +284,7 @@ enum {
 	APPEND_INO,		/* for append ino list */
 	UPDATE_INO,		/* for update ino list */
 	TRANS_DIR_INO,		/* for transactions dir ino list */
+	XATTR_DIR_INO,		/* for xattr updated dir ino list */
 	FLUSH_INO,		/* for multiple device flushing */
 	MAX_INO_ENTRY,		/* max. list */
 };
@@ -1137,6 +1138,7 @@ enum cp_reason_type {
 	CP_FASTBOOT_MODE,
 	CP_SPEC_LOG_NUM,
 	CP_RECOVER_DIR,
+	CP_XATTR_DIR,
 };
 
 enum iostat_type {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 62f2521cd955e..6ce8997fc61e0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -217,6 +217,9 @@ static inline enum cp_reason_type need_do_checkpoint(struct inode *inode)
 		f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
 							TRANS_DIR_INO))
 		cp_reason = CP_RECOVER_DIR;
+	else if (f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
+							XATTR_DIR_INO))
+		cp_reason = CP_XATTR_DIR;
 
 	return cp_reason;
 }
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 6ee71a2faa75f..65437c18e01d3 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -629,6 +629,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 			const char *name, const void *value, size_t size,
 			struct page *ipage, int flags)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_xattr_entry *here, *last;
 	void *base_addr, *last_base_addr;
 	int found, newsize;
@@ -772,9 +773,18 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	if (index == F2FS_XATTR_INDEX_ENCRYPTION &&
 			!strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT))
 		f2fs_set_encrypted_inode(inode);
-	if (S_ISDIR(inode->i_mode))
-		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
 
+	if (!S_ISDIR(inode->i_mode))
+		goto same;
+	/*
+	 * In restrict mode, fsync() always try to trigger checkpoint for all
+	 * metadata consistency, in other mode, it triggers checkpoint when
+	 * parent's xattr metadata was updated.
+	 */
+	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
+		set_sbi_flag(sbi, SBI_NEED_CP);
+	else
+		f2fs_add_ino_entry(sbi, inode->i_ino, XATTR_DIR_INO);
 same:
 	if (is_inode_flag_set(inode, FI_ACL_MODE)) {
 		inode->i_mode = F2FS_I(inode)->i_acl_mode;
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 5f58684f6107a..9f0883e9ab3eb 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -138,7 +138,8 @@ TRACE_DEFINE_ENUM(EX_READ);
 		{ CP_NODE_NEED_CP,	"node needs cp" },		\
 		{ CP_FASTBOOT_MODE,	"fastboot mode" },		\
 		{ CP_SPEC_LOG_NUM,	"log type is 2" },		\
-		{ CP_RECOVER_DIR,	"dir needs recovery" })
+		{ CP_RECOVER_DIR,	"dir needs recovery" },		\
+		{ CP_XATTR_DIR,		"dir's xattr updated" })
 
 #define show_shutdown_mode(type)					\
 	__print_symbolic(type,						\
-- 
2.43.0




