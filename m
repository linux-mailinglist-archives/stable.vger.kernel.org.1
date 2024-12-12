Return-Path: <stable+bounces-101585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE359EED57
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B8B16B070
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF80222D45;
	Thu, 12 Dec 2024 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VEsKotv8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C38221D9C;
	Thu, 12 Dec 2024 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018079; cv=none; b=Vev+UOBonoxvf9wXj7hm8WwUnZqvdoW+rACaNICtHU9s9Bd+W8iZGyhJ+xqeE6w7ypiuXbhoq1dhLt5MoCa2sgbD880RK4GLi5sPIZatKGX4/x9GqrjDl4BPb+f9HrQj05GX1IVuZ3k+L962JkKBzY4Jn468Sekft810omssxE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018079; c=relaxed/simple;
	bh=3eu4yW9ORv/sISNAbWOvKHizPbtQTOI9bCPqbCvAtCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZZ9umaOXBqsipwjzxP0eHm10Wk86hDLlFudnJpeKyOxeS1vtTV+Y0H7iJRdaO6iO9d6iJNI9wEL5g+1k3hPAj+y2jrX05xd5yQOLo3KVw+D1ogHnRWGbZ5URFCVhymu8DY8k4lwl8wpLa7MDhy9P1ZmYS1HFwc2ffHvfTh35Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VEsKotv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4122FC4CECE;
	Thu, 12 Dec 2024 15:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734018078;
	bh=3eu4yW9ORv/sISNAbWOvKHizPbtQTOI9bCPqbCvAtCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VEsKotv8A3RoBCLStSckmbwkq2SJBK9W8trXsvxObRzjvJJg1peR7rcqgZPaWgoUt
	 2CxE0pAljmSPLNJCQdK7sDxULhlXSliV8NssjHSht2RSk3oenQgVuz7DDAyQlVArj6
	 sarMZIMYEs+XMAxhwrCJmWuQ7rgGtdJHwHJfe5AE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Ralph Boehme <slow@samba.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 161/356] fs/smb/client: Implement new SMB3 POSIX type
Date: Thu, 12 Dec 2024 15:58:00 +0100
Message-ID: <20241212144250.998688088@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
References: <20241212144244.601729511@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ralph Boehme <slow@samba.org>

commit 6a832bc8bbb22350f7ffe6ecb2d36f261bb96023 upstream.

Fixes special files against current Samba.

On the Samba server:

insgesamt 20
131958 brw-r--r--  1 root  root  0, 0 15. Nov 12:04 blockdev
131965 crw-r--r--  1 root  root  1, 1 15. Nov 12:04 chardev
131966 prw-r--r--  1 samba samba    0 15. Nov 12:05 fifo
131953 -rw-rwxrw-+ 2 samba samba    4 18. Nov 11:37 file
131953 -rw-rwxrw-+ 2 samba samba    4 18. Nov 11:37 hardlink
131957 lrwxrwxrwx  1 samba samba    4 15. Nov 12:03 symlink -> file
131954 -rwxrwxr-x+ 1 samba samba    0 18. Nov 15:28 symlinkoversmb

Before:

ls: cannot access '/mnt/smb3unix/posix/blockdev': No data available
ls: cannot access '/mnt/smb3unix/posix/chardev': No data available
ls: cannot access '/mnt/smb3unix/posix/symlinkoversmb': No data available
ls: cannot access '/mnt/smb3unix/posix/fifo': No data available
ls: cannot access '/mnt/smb3unix/posix/symlink': No data available
total 16
     ? -????????? ? ?    ?     ?            ? blockdev
     ? -????????? ? ?    ?     ?            ? chardev
     ? -????????? ? ?    ?     ?            ? fifo
131953 -rw-rwxrw- 2 root samba 4 Nov 18 11:37 file
131953 -rw-rwxrw- 2 root samba 4 Nov 18 11:37 hardlink
     ? -????????? ? ?    ?     ?            ? symlink
     ? -????????? ? ?    ?     ?            ? symlinkoversmb

After:

insgesamt 21
131958 brw-r--r-- 1 root root  0, 0 15. Nov 12:04 blockdev
131965 crw-r--r-- 1 root root  1, 1 15. Nov 12:04 chardev
131966 prw-r--r-- 1 root samba    0 15. Nov 12:05 fifo
131953 -rw-rwxrw- 2 root samba    4 18. Nov 11:37 file
131953 -rw-rwxrw- 2 root samba    4 18. Nov 11:37 hardlink
131957 lrwxrwxrwx 1 root samba    4 15. Nov 12:03 symlink -> file
131954 lrwxrwxr-x 1 root samba   23 18. Nov 15:28 symlinkoversmb -> mnt/smb3unix/posix/file

Cc: stable@vger.kernel.org
Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Ralph Boehme <slow@samba.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cifsproto.h |    1 
 fs/smb/client/inode.c     |   89 +++++++++++++++++++++++++++++++++++++++++-----
 fs/smb/client/readdir.c   |   35 ++++++++----------
 fs/smb/client/reparse.c   |   84 ++++++++++++++++++++++++++-----------------
 4 files changed, 149 insertions(+), 60 deletions(-)

--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -684,6 +684,7 @@ int parse_reparse_point(struct reparse_d
 int cifs_sfu_make_node(unsigned int xid, struct inode *inode,
 		       struct dentry *dentry, struct cifs_tcon *tcon,
 		       const char *full_path, umode_t mode, dev_t dev);
+umode_t wire_mode_to_posix(u32 wire);
 
 #ifdef CONFIG_CIFS_DFS_UPCALL
 static inline int get_dfs_path(const unsigned int xid, struct cifs_ses *ses,
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -663,6 +663,84 @@ static int cifs_sfu_mode(struct cifs_fat
 #endif
 }
 
+#define POSIX_TYPE_FILE    0
+#define POSIX_TYPE_DIR     1
+#define POSIX_TYPE_SYMLINK 2
+#define POSIX_TYPE_CHARDEV 3
+#define POSIX_TYPE_BLKDEV  4
+#define POSIX_TYPE_FIFO    5
+#define POSIX_TYPE_SOCKET  6
+
+#define POSIX_X_OTH      0000001
+#define POSIX_W_OTH      0000002
+#define POSIX_R_OTH      0000004
+#define POSIX_X_GRP      0000010
+#define POSIX_W_GRP      0000020
+#define POSIX_R_GRP      0000040
+#define POSIX_X_USR      0000100
+#define POSIX_W_USR      0000200
+#define POSIX_R_USR      0000400
+#define POSIX_STICKY     0001000
+#define POSIX_SET_GID    0002000
+#define POSIX_SET_UID    0004000
+
+#define POSIX_OTH_MASK      0000007
+#define POSIX_GRP_MASK      0000070
+#define POSIX_USR_MASK      0000700
+#define POSIX_PERM_MASK     0000777
+#define POSIX_FILETYPE_MASK 0070000
+
+#define POSIX_FILETYPE_SHIFT 12
+
+static u32 wire_perms_to_posix(u32 wire)
+{
+	u32 mode = 0;
+
+	mode |= (wire & POSIX_X_OTH) ? S_IXOTH : 0;
+	mode |= (wire & POSIX_W_OTH) ? S_IWOTH : 0;
+	mode |= (wire & POSIX_R_OTH) ? S_IROTH : 0;
+	mode |= (wire & POSIX_X_GRP) ? S_IXGRP : 0;
+	mode |= (wire & POSIX_W_GRP) ? S_IWGRP : 0;
+	mode |= (wire & POSIX_R_GRP) ? S_IRGRP : 0;
+	mode |= (wire & POSIX_X_USR) ? S_IXUSR : 0;
+	mode |= (wire & POSIX_W_USR) ? S_IWUSR : 0;
+	mode |= (wire & POSIX_R_USR) ? S_IRUSR : 0;
+	mode |= (wire & POSIX_STICKY) ? S_ISVTX : 0;
+	mode |= (wire & POSIX_SET_GID) ? S_ISGID : 0;
+	mode |= (wire & POSIX_SET_UID) ? S_ISUID : 0;
+
+	return mode;
+}
+
+static u32 posix_filetypes[] = {
+	S_IFREG,
+	S_IFDIR,
+	S_IFLNK,
+	S_IFCHR,
+	S_IFBLK,
+	S_IFIFO,
+	S_IFSOCK
+};
+
+static u32 wire_filetype_to_posix(u32 wire_type)
+{
+	if (wire_type >= ARRAY_SIZE(posix_filetypes)) {
+		pr_warn("Unexpected type %u", wire_type);
+		return 0;
+	}
+	return posix_filetypes[wire_type];
+}
+
+umode_t wire_mode_to_posix(u32 wire)
+{
+	u32 wire_type;
+	u32 mode;
+
+	wire_type = (wire & POSIX_FILETYPE_MASK) >> POSIX_FILETYPE_SHIFT;
+	mode = (wire_perms_to_posix(wire) | wire_filetype_to_posix(wire_type));
+	return (umode_t)mode;
+}
+
 /* Fill a cifs_fattr struct with info from POSIX info struct */
 static void smb311_posix_info_to_fattr(struct cifs_fattr *fattr,
 				       struct cifs_open_info_data *data,
@@ -699,20 +777,13 @@ static void smb311_posix_info_to_fattr(s
 	fattr->cf_bytes = le64_to_cpu(info->AllocationSize);
 	fattr->cf_createtime = le64_to_cpu(info->CreationTime);
 	fattr->cf_nlink = le32_to_cpu(info->HardLinks);
-	fattr->cf_mode = (umode_t) le32_to_cpu(info->Mode);
+	fattr->cf_mode = wire_mode_to_posix(le32_to_cpu(info->Mode));
 
 	if (cifs_open_data_reparse(data) &&
 	    cifs_reparse_point_to_fattr(cifs_sb, fattr, data))
 		goto out_reparse;
 
-	fattr->cf_mode &= ~S_IFMT;
-	if (fattr->cf_cifsattrs & ATTR_DIRECTORY) {
-		fattr->cf_mode |= S_IFDIR;
-		fattr->cf_dtype = DT_DIR;
-	} else { /* file */
-		fattr->cf_mode |= S_IFREG;
-		fattr->cf_dtype = DT_REG;
-	}
+	fattr->cf_dtype = S_DT(fattr->cf_mode);
 
 out_reparse:
 	if (S_ISLNK(fattr->cf_mode)) {
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -241,31 +241,28 @@ cifs_posix_to_fattr(struct cifs_fattr *f
 	fattr->cf_nlink = le32_to_cpu(info->HardLinks);
 	fattr->cf_cifsattrs = le32_to_cpu(info->DosAttributes);
 
-	/*
-	 * Since we set the inode type below we need to mask off
-	 * to avoid strange results if bits set above.
-	 * XXX: why not make server&client use the type bits?
-	 */
-	fattr->cf_mode = le32_to_cpu(info->Mode) & ~S_IFMT;
+	if (fattr->cf_cifsattrs & ATTR_REPARSE)
+		fattr->cf_cifstag = le32_to_cpu(info->ReparseTag);
+
+	/* The Mode field in the response can now include the file type as well */
+	fattr->cf_mode = wire_mode_to_posix(le32_to_cpu(info->Mode));
+	fattr->cf_dtype = S_DT(le32_to_cpu(info->Mode));
+
+	switch (fattr->cf_mode & S_IFMT) {
+	case S_IFLNK:
+	case S_IFBLK:
+	case S_IFCHR:
+		fattr->cf_flags |= CIFS_FATTR_NEED_REVAL;
+		break;
+	default:
+		break;
+	}
 
 	cifs_dbg(FYI, "posix fattr: dev %d, reparse %d, mode %o\n",
 		 le32_to_cpu(info->DeviceId),
 		 le32_to_cpu(info->ReparseTag),
 		 le32_to_cpu(info->Mode));
 
-	if (fattr->cf_cifsattrs & ATTR_DIRECTORY) {
-		fattr->cf_mode |= S_IFDIR;
-		fattr->cf_dtype = DT_DIR;
-	} else {
-		/*
-		 * mark anything that is not a dir as regular
-		 * file. special files should have the REPARSE
-		 * attribute and will be marked as needing revaluation
-		 */
-		fattr->cf_mode |= S_IFREG;
-		fattr->cf_dtype = DT_REG;
-	}
-
 	sid_to_id(cifs_sb, &parsed.owner, fattr, SIDOWNER);
 	sid_to_id(cifs_sb, &parsed.group, fattr, SIDGROUP);
 }
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -730,44 +730,60 @@ out:
 	fattr->cf_dtype = S_DT(fattr->cf_mode);
 }
 
-bool cifs_reparse_point_to_fattr(struct cifs_sb_info *cifs_sb,
-				 struct cifs_fattr *fattr,
-				 struct cifs_open_info_data *data)
+static bool posix_reparse_to_fattr(struct cifs_sb_info *cifs_sb,
+				   struct cifs_fattr *fattr,
+				   struct cifs_open_info_data *data)
 {
 	struct reparse_posix_data *buf = data->reparse.posix;
-	u32 tag = data->reparse.tag;
 
-	if (tag == IO_REPARSE_TAG_NFS && buf) {
-		if (le16_to_cpu(buf->ReparseDataLength) < sizeof(buf->InodeType))
+
+	if (buf == NULL)
+		return true;
+
+	if (le16_to_cpu(buf->ReparseDataLength) < sizeof(buf->InodeType)) {
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	switch (le64_to_cpu(buf->InodeType)) {
+	case NFS_SPECFILE_CHR:
+		if (le16_to_cpu(buf->ReparseDataLength) != sizeof(buf->InodeType) + 8) {
+			WARN_ON_ONCE(1);
 			return false;
-		switch (le64_to_cpu(buf->InodeType)) {
-		case NFS_SPECFILE_CHR:
-			if (le16_to_cpu(buf->ReparseDataLength) != sizeof(buf->InodeType) + 8)
-				return false;
-			fattr->cf_mode |= S_IFCHR;
-			fattr->cf_rdev = reparse_mkdev(buf->DataBuffer);
-			break;
-		case NFS_SPECFILE_BLK:
-			if (le16_to_cpu(buf->ReparseDataLength) != sizeof(buf->InodeType) + 8)
-				return false;
-			fattr->cf_mode |= S_IFBLK;
-			fattr->cf_rdev = reparse_mkdev(buf->DataBuffer);
-			break;
-		case NFS_SPECFILE_FIFO:
-			fattr->cf_mode |= S_IFIFO;
-			break;
-		case NFS_SPECFILE_SOCK:
-			fattr->cf_mode |= S_IFSOCK;
-			break;
-		case NFS_SPECFILE_LNK:
-			fattr->cf_mode |= S_IFLNK;
-			break;
-		default:
+		}
+		fattr->cf_mode |= S_IFCHR;
+		fattr->cf_rdev = reparse_mkdev(buf->DataBuffer);
+		break;
+	case NFS_SPECFILE_BLK:
+		if (le16_to_cpu(buf->ReparseDataLength) != sizeof(buf->InodeType) + 8) {
 			WARN_ON_ONCE(1);
 			return false;
 		}
-		goto out;
+		fattr->cf_mode |= S_IFBLK;
+		fattr->cf_rdev = reparse_mkdev(buf->DataBuffer);
+		break;
+	case NFS_SPECFILE_FIFO:
+		fattr->cf_mode |= S_IFIFO;
+		break;
+	case NFS_SPECFILE_SOCK:
+		fattr->cf_mode |= S_IFSOCK;
+		break;
+	case NFS_SPECFILE_LNK:
+		fattr->cf_mode |= S_IFLNK;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return false;
 	}
+	return true;
+}
+
+bool cifs_reparse_point_to_fattr(struct cifs_sb_info *cifs_sb,
+				 struct cifs_fattr *fattr,
+				 struct cifs_open_info_data *data)
+{
+	u32 tag = data->reparse.tag;
+	bool ok;
 
 	switch (tag) {
 	case IO_REPARSE_TAG_INTERNAL:
@@ -787,15 +803,19 @@ bool cifs_reparse_point_to_fattr(struct
 	case IO_REPARSE_TAG_LX_BLK:
 		wsl_to_fattr(data, cifs_sb, tag, fattr);
 		break;
+	case IO_REPARSE_TAG_NFS:
+		ok = posix_reparse_to_fattr(cifs_sb, fattr, data);
+		if (!ok)
+			return false;
+		break;
 	case 0: /* SMB1 symlink */
 	case IO_REPARSE_TAG_SYMLINK:
-	case IO_REPARSE_TAG_NFS:
 		fattr->cf_mode |= S_IFLNK;
 		break;
 	default:
 		return false;
 	}
-out:
+
 	fattr->cf_dtype = S_DT(fattr->cf_mode);
 	return true;
 }



