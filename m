Return-Path: <stable+bounces-37014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9C089C411
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 252E0B2D17C
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAE982D7A;
	Mon,  8 Apr 2024 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aBxswcf9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B7F7C086;
	Mon,  8 Apr 2024 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583003; cv=none; b=mH1He3Pc75RsnqVFrMK9k4A3jO2rTLP2+2nq+pLDMNZikUr7nqgqZvHEh1mAVsIeHlhvAKvIVTNaMPTzOdzYd3wJfBW8DVdRbDzv2KyWDoB7GWtpIWQRUrunTaYXh4l56uMuVphAu2Ysp6t7og+vP2ZqNn29KU725z9uoADwOxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583003; c=relaxed/simple;
	bh=ecM3NJ23WkidpP1rabDBVj/UQt+drTokJA3IBqoe+NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orq+yu2l338ijSQPr0TF/sbqkyCxkgwPbO+XgFt762tPSmWFM25gdC7sVn8M9EaUmSjpRaXsPeAnmc+fM9Xr7JJIizvHe0NWwiMUpoOJbHaL67oqfQ8iuC7c8KkJxPUYYWvkXHUEbIofQ44ru3WxtAjs7xu9lMb2WryCRr1Cnz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aBxswcf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79312C433C7;
	Mon,  8 Apr 2024 13:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583002;
	bh=ecM3NJ23WkidpP1rabDBVj/UQt+drTokJA3IBqoe+NE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aBxswcf9vG4Hf3BnKFalHUJB4SxE8TsAWGhIEU3pGWp4RbJZvKVxI5DA004XdGz3n
	 U8oI1OU+RSgRd5dkoxqaYWz1sVwU3rK70mUp05UBeKECt3jsXkFIsDnCjmI5da1ej8
	 r8rQGoppJPyNBDrd4J3BmRIRaZJv8gpEmhT9N4qk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.15 197/690] NFS: Move generic FS show macros to global header
Date: Mon,  8 Apr 2024 14:51:03 +0200
Message-ID: <20240408125406.690490650@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 9d2d48bbbdabf7b2f029369c4f926d133c1d47ad ]

Refactor: Surface useful show_ macros for use by other trace
subsystems.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs4trace.h        |  67 ++++++---------------
 fs/nfs/nfstrace.h         |  80 +++++--------------------
 include/trace/events/fs.h | 122 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+), 113 deletions(-)
 create mode 100644 include/trace/events/fs.h

diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 39a45bb7d4311..afbecdb8fa21b 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -11,6 +11,8 @@
 #include <linux/tracepoint.h>
 #include <trace/events/sunrpc_base.h>
 
+#include <trace/events/fs.h>
+
 TRACE_DEFINE_ENUM(EPERM);
 TRACE_DEFINE_ENUM(ENOENT);
 TRACE_DEFINE_ENUM(EIO);
@@ -314,19 +316,6 @@ TRACE_DEFINE_ENUM(NFS4ERR_RESET_TO_PNFS);
 		{ NFS4ERR_RESET_TO_MDS, "RESET_TO_MDS" }, \
 		{ NFS4ERR_RESET_TO_PNFS, "RESET_TO_PNFS" })
 
-#define show_open_flags(flags) \
-	__print_flags(flags, "|", \
-		{ O_CREAT, "O_CREAT" }, \
-		{ O_EXCL, "O_EXCL" }, \
-		{ O_TRUNC, "O_TRUNC" }, \
-		{ O_DIRECT, "O_DIRECT" })
-
-#define show_fmode_flags(mode) \
-	__print_flags(mode, "|", \
-		{ ((__force unsigned long)FMODE_READ), "READ" }, \
-		{ ((__force unsigned long)FMODE_WRITE), "WRITE" }, \
-		{ ((__force unsigned long)FMODE_EXEC), "EXEC" })
-
 #define show_nfs_fattr_flags(valid) \
 	__print_flags((unsigned long)valid, "|", \
 		{ NFS_ATTR_FATTR_TYPE, "TYPE" }, \
@@ -796,8 +785,8 @@ DECLARE_EVENT_CLASS(nfs4_open_event,
 
 		TP_STRUCT__entry(
 			__field(unsigned long, error)
-			__field(unsigned int, flags)
-			__field(unsigned int, fmode)
+			__field(unsigned long, flags)
+			__field(unsigned long, fmode)
 			__field(dev_t, dev)
 			__field(u32, fhandle)
 			__field(u64, fileid)
@@ -815,7 +804,7 @@ DECLARE_EVENT_CLASS(nfs4_open_event,
 
 			__entry->error = -error;
 			__entry->flags = flags;
-			__entry->fmode = (__force unsigned int)ctx->mode;
+			__entry->fmode = (__force unsigned long)ctx->mode;
 			__entry->dev = ctx->dentry->d_sb->s_dev;
 			if (!IS_ERR_OR_NULL(state)) {
 				inode = state->inode;
@@ -845,15 +834,15 @@ DECLARE_EVENT_CLASS(nfs4_open_event,
 		),
 
 		TP_printk(
-			"error=%ld (%s) flags=%d (%s) fmode=%s "
+			"error=%ld (%s) flags=%lu (%s) fmode=%s "
 			"fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"name=%02x:%02x:%llu/%s stateid=%d:0x%08x "
 			"openstateid=%d:0x%08x",
 			 -__entry->error,
 			 show_nfsv4_errors(__entry->error),
 			 __entry->flags,
-			 show_open_flags(__entry->flags),
-			 show_fmode_flags(__entry->fmode),
+			 show_fs_fcntl_open_flags(__entry->flags),
+			 show_fs_fmode_flags(__entry->fmode),
 			 MAJOR(__entry->dev), MINOR(__entry->dev),
 			 (unsigned long long)__entry->fileid,
 			 __entry->fhandle,
@@ -907,7 +896,7 @@ TRACE_EVENT(nfs4_cached_open,
 		TP_printk(
 			"fmode=%s fileid=%02x:%02x:%llu "
 			"fhandle=0x%08x stateid=%d:0x%08x",
-			__entry->fmode ?  show_fmode_flags(__entry->fmode) :
+			__entry->fmode ?  show_fs_fmode_flags(__entry->fmode) :
 					  "closed",
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
@@ -955,7 +944,7 @@ TRACE_EVENT(nfs4_close,
 			"fhandle=0x%08x openstateid=%d:0x%08x",
 			-__entry->error,
 			show_nfsv4_errors(__entry->error),
-			__entry->fmode ?  show_fmode_flags(__entry->fmode) :
+			__entry->fmode ?  show_fs_fmode_flags(__entry->fmode) :
 					  "closed",
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
@@ -964,24 +953,6 @@ TRACE_EVENT(nfs4_close,
 		)
 );
 
-TRACE_DEFINE_ENUM(F_GETLK);
-TRACE_DEFINE_ENUM(F_SETLK);
-TRACE_DEFINE_ENUM(F_SETLKW);
-TRACE_DEFINE_ENUM(F_RDLCK);
-TRACE_DEFINE_ENUM(F_WRLCK);
-TRACE_DEFINE_ENUM(F_UNLCK);
-
-#define show_lock_cmd(type) \
-	__print_symbolic((int)type, \
-		{ F_GETLK, "GETLK" }, \
-		{ F_SETLK, "SETLK" }, \
-		{ F_SETLKW, "SETLKW" })
-#define show_lock_type(type) \
-	__print_symbolic((int)type, \
-		{ F_RDLCK, "RDLCK" }, \
-		{ F_WRLCK, "WRLCK" }, \
-		{ F_UNLCK, "UNLCK" })
-
 DECLARE_EVENT_CLASS(nfs4_lock_event,
 		TP_PROTO(
 			const struct file_lock *request,
@@ -994,8 +965,8 @@ DECLARE_EVENT_CLASS(nfs4_lock_event,
 
 		TP_STRUCT__entry(
 			__field(unsigned long, error)
-			__field(int, cmd)
-			__field(char, type)
+			__field(unsigned long, cmd)
+			__field(unsigned long, type)
 			__field(loff_t, start)
 			__field(loff_t, end)
 			__field(dev_t, dev)
@@ -1028,8 +999,8 @@ DECLARE_EVENT_CLASS(nfs4_lock_event,
 			"stateid=%d:0x%08x",
 			-__entry->error,
 			show_nfsv4_errors(__entry->error),
-			show_lock_cmd(__entry->cmd),
-			show_lock_type(__entry->type),
+			show_fs_fcntl_cmd(__entry->cmd),
+			show_fs_fcntl_lock_type(__entry->type),
 			(long long)__entry->start,
 			(long long)__entry->end,
 			MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -1064,8 +1035,8 @@ TRACE_EVENT(nfs4_set_lock,
 
 		TP_STRUCT__entry(
 			__field(unsigned long, error)
-			__field(int, cmd)
-			__field(char, type)
+			__field(unsigned long, cmd)
+			__field(unsigned long, type)
 			__field(loff_t, start)
 			__field(loff_t, end)
 			__field(dev_t, dev)
@@ -1104,8 +1075,8 @@ TRACE_EVENT(nfs4_set_lock,
 			"stateid=%d:0x%08x lockstateid=%d:0x%08x",
 			-__entry->error,
 			show_nfsv4_errors(__entry->error),
-			show_lock_cmd(__entry->cmd),
-			show_lock_type(__entry->type),
+			show_fs_fcntl_cmd(__entry->cmd),
+			show_fs_fcntl_lock_type(__entry->type),
 			(long long)__entry->start,
 			(long long)__entry->end,
 			MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -1222,7 +1193,7 @@ DECLARE_EVENT_CLASS(nfs4_set_delegation_event,
 
 		TP_printk(
 			"fmode=%s fileid=%02x:%02x:%llu fhandle=0x%08x",
-			show_fmode_flags(__entry->fmode),
+			show_fs_fmode_flags(__entry->fmode),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 69fa637a4aba8..918237677a383 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -11,20 +11,9 @@
 #include <linux/tracepoint.h>
 #include <linux/iversion.h>
 
+#include <trace/events/fs.h>
 #include <trace/events/sunrpc_base.h>
 
-#define nfs_show_file_type(ftype) \
-	__print_symbolic(ftype, \
-			{ DT_UNKNOWN, "UNKNOWN" }, \
-			{ DT_FIFO, "FIFO" }, \
-			{ DT_CHR, "CHR" }, \
-			{ DT_DIR, "DIR" }, \
-			{ DT_BLK, "BLK" }, \
-			{ DT_REG, "REG" }, \
-			{ DT_LNK, "LNK" }, \
-			{ DT_SOCK, "SOCK" }, \
-			{ DT_WHT, "WHT" })
-
 #define nfs_show_cache_validity(v) \
 	__print_flags(v, "|", \
 			{ NFS_INO_INVALID_DATA, "INVALID_DATA" }, \
@@ -131,7 +120,7 @@ DECLARE_EVENT_CLASS(nfs_inode_event_done,
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
 			__entry->type,
-			nfs_show_file_type(__entry->type),
+			show_fs_dirent_type(__entry->type),
 			(unsigned long long)__entry->version,
 			(long long)__entry->size,
 			__entry->cache_validity,
@@ -222,7 +211,7 @@ TRACE_EVENT(nfs_access_exit,
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
 			__entry->type,
-			nfs_show_file_type(__entry->type),
+			show_fs_dirent_type(__entry->type),
 			(unsigned long long)__entry->version,
 			(long long)__entry->size,
 			__entry->cache_validity,
@@ -233,21 +222,6 @@ TRACE_EVENT(nfs_access_exit,
 		)
 );
 
-#define show_lookup_flags(flags) \
-	__print_flags(flags, "|", \
-			{ LOOKUP_FOLLOW, "FOLLOW" }, \
-			{ LOOKUP_DIRECTORY, "DIRECTORY" }, \
-			{ LOOKUP_AUTOMOUNT, "AUTOMOUNT" }, \
-			{ LOOKUP_PARENT, "PARENT" }, \
-			{ LOOKUP_REVAL, "REVAL" }, \
-			{ LOOKUP_RCU, "RCU" }, \
-			{ LOOKUP_OPEN, "OPEN" }, \
-			{ LOOKUP_CREATE, "CREATE" }, \
-			{ LOOKUP_EXCL, "EXCL" }, \
-			{ LOOKUP_RENAME_TARGET, "RENAME_TARGET" }, \
-			{ LOOKUP_EMPTY, "EMPTY" }, \
-			{ LOOKUP_DOWN, "DOWN" })
-
 DECLARE_EVENT_CLASS(nfs_lookup_event,
 		TP_PROTO(
 			const struct inode *dir,
@@ -274,7 +248,7 @@ DECLARE_EVENT_CLASS(nfs_lookup_event,
 		TP_printk(
 			"flags=0x%lx (%s) name=%02x:%02x:%llu/%s",
 			__entry->flags,
-			show_lookup_flags(__entry->flags),
+			show_fs_lookup_flags(__entry->flags),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
 			__get_str(name)
@@ -320,7 +294,7 @@ DECLARE_EVENT_CLASS(nfs_lookup_event_done,
 			"error=%ld (%s) flags=0x%lx (%s) name=%02x:%02x:%llu/%s",
 			-__entry->error, nfs_show_status(__entry->error),
 			__entry->flags,
-			show_lookup_flags(__entry->flags),
+			show_fs_lookup_flags(__entry->flags),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
 			__get_str(name)
@@ -342,30 +316,6 @@ DEFINE_NFS_LOOKUP_EVENT_DONE(nfs_lookup_exit);
 DEFINE_NFS_LOOKUP_EVENT(nfs_lookup_revalidate_enter);
 DEFINE_NFS_LOOKUP_EVENT_DONE(nfs_lookup_revalidate_exit);
 
-#define show_open_flags(flags) \
-	__print_flags(flags, "|", \
-		{ O_WRONLY, "O_WRONLY" }, \
-		{ O_RDWR, "O_RDWR" }, \
-		{ O_CREAT, "O_CREAT" }, \
-		{ O_EXCL, "O_EXCL" }, \
-		{ O_NOCTTY, "O_NOCTTY" }, \
-		{ O_TRUNC, "O_TRUNC" }, \
-		{ O_APPEND, "O_APPEND" }, \
-		{ O_NONBLOCK, "O_NONBLOCK" }, \
-		{ O_DSYNC, "O_DSYNC" }, \
-		{ O_DIRECT, "O_DIRECT" }, \
-		{ O_LARGEFILE, "O_LARGEFILE" }, \
-		{ O_DIRECTORY, "O_DIRECTORY" }, \
-		{ O_NOFOLLOW, "O_NOFOLLOW" }, \
-		{ O_NOATIME, "O_NOATIME" }, \
-		{ O_CLOEXEC, "O_CLOEXEC" })
-
-#define show_fmode_flags(mode) \
-	__print_flags(mode, "|", \
-		{ ((__force unsigned long)FMODE_READ), "READ" }, \
-		{ ((__force unsigned long)FMODE_WRITE), "WRITE" }, \
-		{ ((__force unsigned long)FMODE_EXEC), "EXEC" })
-
 TRACE_EVENT(nfs_atomic_open_enter,
 		TP_PROTO(
 			const struct inode *dir,
@@ -377,7 +327,7 @@ TRACE_EVENT(nfs_atomic_open_enter,
 
 		TP_STRUCT__entry(
 			__field(unsigned long, flags)
-			__field(unsigned int, fmode)
+			__field(unsigned long, fmode)
 			__field(dev_t, dev)
 			__field(u64, dir)
 			__string(name, ctx->dentry->d_name.name)
@@ -387,15 +337,15 @@ TRACE_EVENT(nfs_atomic_open_enter,
 			__entry->dev = dir->i_sb->s_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__entry->flags = flags;
-			__entry->fmode = (__force unsigned int)ctx->mode;
+			__entry->fmode = (__force unsigned long)ctx->mode;
 			__assign_str(name, ctx->dentry->d_name.name);
 		),
 
 		TP_printk(
 			"flags=0x%lx (%s) fmode=%s name=%02x:%02x:%llu/%s",
 			__entry->flags,
-			show_open_flags(__entry->flags),
-			show_fmode_flags(__entry->fmode),
+			show_fs_fcntl_open_flags(__entry->flags),
+			show_fs_fmode_flags(__entry->fmode),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
 			__get_str(name)
@@ -415,7 +365,7 @@ TRACE_EVENT(nfs_atomic_open_exit,
 		TP_STRUCT__entry(
 			__field(unsigned long, error)
 			__field(unsigned long, flags)
-			__field(unsigned int, fmode)
+			__field(unsigned long, fmode)
 			__field(dev_t, dev)
 			__field(u64, dir)
 			__string(name, ctx->dentry->d_name.name)
@@ -426,7 +376,7 @@ TRACE_EVENT(nfs_atomic_open_exit,
 			__entry->dev = dir->i_sb->s_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__entry->flags = flags;
-			__entry->fmode = (__force unsigned int)ctx->mode;
+			__entry->fmode = (__force unsigned long)ctx->mode;
 			__assign_str(name, ctx->dentry->d_name.name);
 		),
 
@@ -435,8 +385,8 @@ TRACE_EVENT(nfs_atomic_open_exit,
 			"name=%02x:%02x:%llu/%s",
 			-__entry->error, nfs_show_status(__entry->error),
 			__entry->flags,
-			show_open_flags(__entry->flags),
-			show_fmode_flags(__entry->fmode),
+			show_fs_fcntl_open_flags(__entry->flags),
+			show_fs_fmode_flags(__entry->fmode),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
 			__get_str(name)
@@ -469,7 +419,7 @@ TRACE_EVENT(nfs_create_enter,
 		TP_printk(
 			"flags=0x%lx (%s) name=%02x:%02x:%llu/%s",
 			__entry->flags,
-			show_open_flags(__entry->flags),
+			show_fs_fcntl_open_flags(__entry->flags),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
 			__get_str(name)
@@ -506,7 +456,7 @@ TRACE_EVENT(nfs_create_exit,
 			"error=%ld (%s) flags=0x%lx (%s) name=%02x:%02x:%llu/%s",
 			-__entry->error, nfs_show_status(__entry->error),
 			__entry->flags,
-			show_open_flags(__entry->flags),
+			show_fs_fcntl_open_flags(__entry->flags),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
 			__get_str(name)
diff --git a/include/trace/events/fs.h b/include/trace/events/fs.h
new file mode 100644
index 0000000000000..738b97f22f365
--- /dev/null
+++ b/include/trace/events/fs.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Display helpers for generic filesystem items
+ *
+ * Author: Chuck Lever <chuck.lever@oracle.com>
+ *
+ * Copyright (c) 2020, Oracle and/or its affiliates.
+ */
+
+#include <linux/fs.h>
+
+#define show_fs_dirent_type(x) \
+	__print_symbolic(x, \
+		{ DT_UNKNOWN,		"UNKNOWN" }, \
+		{ DT_FIFO,		"FIFO" }, \
+		{ DT_CHR,		"CHR" }, \
+		{ DT_DIR,		"DIR" }, \
+		{ DT_BLK,		"BLK" }, \
+		{ DT_REG,		"REG" }, \
+		{ DT_LNK,		"LNK" }, \
+		{ DT_SOCK,		"SOCK" }, \
+		{ DT_WHT,		"WHT" })
+
+#define show_fs_fcntl_open_flags(x) \
+	__print_flags(x, "|", \
+		{ O_WRONLY,		"O_WRONLY" }, \
+		{ O_RDWR,		"O_RDWR" }, \
+		{ O_CREAT,		"O_CREAT" }, \
+		{ O_EXCL,		"O_EXCL" }, \
+		{ O_NOCTTY,		"O_NOCTTY" }, \
+		{ O_TRUNC,		"O_TRUNC" }, \
+		{ O_APPEND,		"O_APPEND" }, \
+		{ O_NONBLOCK,		"O_NONBLOCK" }, \
+		{ O_DSYNC,		"O_DSYNC" }, \
+		{ O_DIRECT,		"O_DIRECT" }, \
+		{ O_LARGEFILE,		"O_LARGEFILE" }, \
+		{ O_DIRECTORY,		"O_DIRECTORY" }, \
+		{ O_NOFOLLOW,		"O_NOFOLLOW" }, \
+		{ O_NOATIME,		"O_NOATIME" }, \
+		{ O_CLOEXEC,		"O_CLOEXEC" })
+
+#define __fmode_flag(x)	{ (__force unsigned long)FMODE_##x, #x }
+#define show_fs_fmode_flags(x) \
+	__print_flags(x, "|", \
+		__fmode_flag(READ), \
+		__fmode_flag(WRITE), \
+		__fmode_flag(EXEC))
+
+#ifdef CONFIG_64BIT
+#define show_fs_fcntl_cmd(x) \
+	__print_symbolic(x, \
+		{ F_DUPFD,		"DUPFD" }, \
+		{ F_GETFD,		"GETFD" }, \
+		{ F_SETFD,		"SETFD" }, \
+		{ F_GETFL,		"GETFL" }, \
+		{ F_SETFL,		"SETFL" }, \
+		{ F_GETLK,		"GETLK" }, \
+		{ F_SETLK,		"SETLK" }, \
+		{ F_SETLKW,		"SETLKW" }, \
+		{ F_SETOWN,		"SETOWN" }, \
+		{ F_GETOWN,		"GETOWN" }, \
+		{ F_SETSIG,		"SETSIG" }, \
+		{ F_GETSIG,		"GETSIG" }, \
+		{ F_SETOWN_EX,		"SETOWN_EX" }, \
+		{ F_GETOWN_EX,		"GETOWN_EX" }, \
+		{ F_GETOWNER_UIDS,	"GETOWNER_UIDS" }, \
+		{ F_OFD_GETLK,		"OFD_GETLK" }, \
+		{ F_OFD_SETLK,		"OFD_SETLK" }, \
+		{ F_OFD_SETLKW,		"OFD_SETLKW" })
+#else /* CONFIG_64BIT */
+#define show_fs_fcntl_cmd(x) \
+	__print_symbolic(x, \
+		{ F_DUPFD,		"DUPFD" }, \
+		{ F_GETFD,		"GETFD" }, \
+		{ F_SETFD,		"SETFD" }, \
+		{ F_GETFL,		"GETFL" }, \
+		{ F_SETFL,		"SETFL" }, \
+		{ F_GETLK,		"GETLK" }, \
+		{ F_SETLK,		"SETLK" }, \
+		{ F_SETLKW,		"SETLKW" }, \
+		{ F_SETOWN,		"SETOWN" }, \
+		{ F_GETOWN,		"GETOWN" }, \
+		{ F_SETSIG,		"SETSIG" }, \
+		{ F_GETSIG,		"GETSIG" }, \
+		{ F_GETLK64,		"GETLK64" }, \
+		{ F_SETLK64,		"SETLK64" }, \
+		{ F_SETLKW64,		"SETLKW64" }, \
+		{ F_SETOWN_EX,		"SETOWN_EX" }, \
+		{ F_GETOWN_EX,		"GETOWN_EX" }, \
+		{ F_GETOWNER_UIDS,	"GETOWNER_UIDS" }, \
+		{ F_OFD_GETLK,		"OFD_GETLK" }, \
+		{ F_OFD_SETLK,		"OFD_SETLK" }, \
+		{ F_OFD_SETLKW,		"OFD_SETLKW" })
+#endif /* CONFIG_64BIT */
+
+#define show_fs_fcntl_lock_type(x) \
+	__print_symbolic(x, \
+		{ F_RDLCK,		"RDLCK" }, \
+		{ F_WRLCK,		"WRLCK" }, \
+		{ F_UNLCK,		"UNLCK" })
+
+#define show_fs_lookup_flags(flags) \
+	__print_flags(flags, "|", \
+		{ LOOKUP_FOLLOW,	"FOLLOW" }, \
+		{ LOOKUP_DIRECTORY,	"DIRECTORY" }, \
+		{ LOOKUP_AUTOMOUNT,	"AUTOMOUNT" }, \
+		{ LOOKUP_EMPTY,		"EMPTY" }, \
+		{ LOOKUP_DOWN,		"DOWN" }, \
+		{ LOOKUP_MOUNTPOINT,	"MOUNTPOINT" }, \
+		{ LOOKUP_REVAL,		"REVAL" }, \
+		{ LOOKUP_RCU,		"RCU" }, \
+		{ LOOKUP_OPEN,		"OPEN" }, \
+		{ LOOKUP_CREATE,	"CREATE" }, \
+		{ LOOKUP_EXCL,		"EXCL" }, \
+		{ LOOKUP_RENAME_TARGET,	"RENAME_TARGET" }, \
+		{ LOOKUP_PARENT,	"PARENT" }, \
+		{ LOOKUP_NO_SYMLINKS,	"NO_SYMLINKS" }, \
+		{ LOOKUP_NO_MAGICLINKS,	"NO_MAGICLINKS" }, \
+		{ LOOKUP_NO_XDEV,	"NO_XDEV" }, \
+		{ LOOKUP_BENEATH,	"BENEATH" }, \
+		{ LOOKUP_IN_ROOT,	"IN_ROOT" }, \
+		{ LOOKUP_CACHED,	"CACHED" })
-- 
2.43.0




