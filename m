Return-Path: <stable+bounces-37077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7189589C332
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA2D1F22199
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55F981720;
	Mon,  8 Apr 2024 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sMfXyrRr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40CF8120F;
	Mon,  8 Apr 2024 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583186; cv=none; b=h6ajc5PVAYC13Odq9lvehwyr4zm4lod1YK395Rwsw12MthJgG8CthUdZwMcj0CUiGGGIYAHS1nBfi5la5UPyx2B7/dfkSuffrJyILZEIzugPKhzSeJ5r6y3Ij7UVa6MTtVN+e9PiRgiLoabMs4jFEzTyeRB07MWEXajokDe8cCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583186; c=relaxed/simple;
	bh=uYX9CIpYMOj6v+skSJY9IhaWbE5/PmOkAo7+GNFAPNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCskAlVtOUthC9PsYor2kHs2XV0RkOooH6cAr7jgYtUzQyaKLB26bQLi4sOXHijOTVF5ygMmKiJ1oBfTfgtgdEqTtHTVGEWMdXiJjNgvC9gOiQi0iOD87Gxehs6TDIpUtoNhNFKI5TTWoOVztzDMrW1XQJd91yiBHPSvioSdnTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sMfXyrRr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14D2C433F1;
	Mon,  8 Apr 2024 13:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583186;
	bh=uYX9CIpYMOj6v+skSJY9IhaWbE5/PmOkAo7+GNFAPNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sMfXyrRrEHWIc750Rt4erC42d0obIAXUquQgDS7gEW64ZJXvZaQx+hVLW9APWQvIq
	 WpUy6gJTKzzvY3ZuXIjn8mFFPlPS+69Q8H9eNTcrlLAGu+I/YWg5aHPTRMDleVKRBp
	 Icz99WRlfBOudzqoHJIOVDJWr3MSEcB2QC1G45Fk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 220/690] fanotify: record old and new parent and name in FAN_RENAME event
Date: Mon,  8 Apr 2024 14:51:26 +0200
Message-ID: <20240408125407.517385615@linuxfoundation.org>
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

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 3982534ba5ce45e890b2f5ef5e7372c1accd14c7 ]

In the special case of FAN_RENAME event, we record both the old
and new parent and name.

Link: https://lore.kernel.org/r/20211129201537.1932819-9-amir73il@gmail.com
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/notify/fanotify/fanotify.c | 42 +++++++++++++++++++++++++++++++----
 include/uapi/linux/fanotify.h |  2 ++
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 5f184b2d6ea7c..db81eab905442 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -592,21 +592,28 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *dir,
 							__kernel_fsid_t *fsid,
 							const struct qstr *name,
 							struct inode *child,
+							struct dentry *moved,
 							unsigned int *hash,
 							gfp_t gfp)
 {
 	struct fanotify_name_event *fne;
 	struct fanotify_info *info;
 	struct fanotify_fh *dfh, *ffh;
+	struct inode *dir2 = moved ? d_inode(moved->d_parent) : NULL;
+	const struct qstr *name2 = moved ? &moved->d_name : NULL;
 	unsigned int dir_fh_len = fanotify_encode_fh_len(dir);
+	unsigned int dir2_fh_len = fanotify_encode_fh_len(dir2);
 	unsigned int child_fh_len = fanotify_encode_fh_len(child);
 	unsigned long name_len = name ? name->len : 0;
+	unsigned long name2_len = name2 ? name2->len : 0;
 	unsigned int len, size;
 
 	/* Reserve terminating null byte even for empty name */
-	size = sizeof(*fne) + name_len + 1;
+	size = sizeof(*fne) + name_len + name2_len + 2;
 	if (dir_fh_len)
 		size += FANOTIFY_FH_HDR_LEN + dir_fh_len;
+	if (dir2_fh_len)
+		size += FANOTIFY_FH_HDR_LEN + dir2_fh_len;
 	if (child_fh_len)
 		size += FANOTIFY_FH_HDR_LEN + child_fh_len;
 	fne = kmalloc(size, gfp);
@@ -623,6 +630,11 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *dir,
 		len = fanotify_encode_fh(dfh, dir, dir_fh_len, hash, 0);
 		fanotify_info_set_dir_fh(info, len);
 	}
+	if (dir2_fh_len) {
+		dfh = fanotify_info_dir2_fh(info);
+		len = fanotify_encode_fh(dfh, dir2, dir2_fh_len, hash, 0);
+		fanotify_info_set_dir2_fh(info, len);
+	}
 	if (child_fh_len) {
 		ffh = fanotify_info_file_fh(info);
 		len = fanotify_encode_fh(ffh, child, child_fh_len, hash, 0);
@@ -632,11 +644,22 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *dir,
 		fanotify_info_copy_name(info, name);
 		*hash ^= full_name_hash((void *)name_len, name->name, name_len);
 	}
+	if (name2_len) {
+		fanotify_info_copy_name2(info, name2);
+		*hash ^= full_name_hash((void *)name2_len, name2->name,
+					name2_len);
+	}
 
 	pr_debug("%s: size=%u dir_fh_len=%u child_fh_len=%u name_len=%u name='%.*s'\n",
 		 __func__, size, dir_fh_len, child_fh_len,
 		 info->name_len, info->name_len, fanotify_info_name(info));
 
+	if (dir2_fh_len) {
+		pr_debug("%s: dir2_fh_len=%u name2_len=%u name2='%.*s'\n",
+			 __func__, dir2_fh_len, info->name2_len,
+			 info->name2_len, fanotify_info_name2(info));
+	}
+
 	return &fne->fae;
 }
 
@@ -692,6 +715,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	struct inode *dirid = fanotify_dfid_inode(mask, data, data_type, dir);
 	const struct path *path = fsnotify_data_path(data, data_type);
 	struct mem_cgroup *old_memcg;
+	struct dentry *moved = NULL;
 	struct inode *child = NULL;
 	bool name_event = false;
 	unsigned int hash = 0;
@@ -727,6 +751,15 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		} else if ((mask & ALL_FSNOTIFY_DIRENT_EVENTS) || !ondir) {
 			name_event = true;
 		}
+
+		/*
+		 * In the special case of FAN_RENAME event, we record both
+		 * old and new parent+name.
+		 * 'dirid' and 'file_name' are the old parent+name and
+		 * 'moved' has the new parent+name.
+		 */
+		if (mask & FAN_RENAME)
+			moved = fsnotify_data_dentry(data, data_type);
 	}
 
 	/*
@@ -748,9 +781,9 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	} else if (fanotify_is_error_event(mask)) {
 		event = fanotify_alloc_error_event(group, fsid, data,
 						   data_type, &hash);
-	} else if (name_event && (file_name || child)) {
-		event = fanotify_alloc_name_event(id, fsid, file_name, child,
-						  &hash, gfp);
+	} else if (name_event && (file_name || moved || child)) {
+		event = fanotify_alloc_name_event(dirid, fsid, file_name, child,
+						  moved, &hash, gfp);
 	} else if (fid_mode) {
 		event = fanotify_alloc_fid_event(id, fsid, &hash, gfp);
 	} else {
@@ -860,6 +893,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_OPEN_EXEC != FS_OPEN_EXEC);
 	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
 	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
+	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
 
 	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 20);
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 60f73639a896a..9d0e2dc5767b5 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -28,6 +28,8 @@
 
 #define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
 
+#define FAN_RENAME		0x10000000	/* File was renamed */
+
 #define FAN_ONDIR		0x40000000	/* Event occurred against dir */
 
 /* helper events */
-- 
2.43.0




