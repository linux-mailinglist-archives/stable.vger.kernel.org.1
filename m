Return-Path: <stable+bounces-53218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F0190D1C2
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6268BB27793
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C40018A938;
	Tue, 18 Jun 2024 13:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JKSZMBCV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219E816CD3C;
	Tue, 18 Jun 2024 13:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715677; cv=none; b=BEVLs1g+T7MY75HP7pXhoMMMUEXPqoIiR1AlbUiVEt3j/FeyoWZPso+LbL2Sv53QfLeY6rMV4gOe5ukkT3QguZYMivvu7vdrwoJ11+1qViz8ELhwsnJrp/EVxHkiYqLsar/YEKdapDNssFrFHSDWcc1ykaj3PkqvVmXbCua2UcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715677; c=relaxed/simple;
	bh=5spOvKZWiLBbjv066k5XDC7oUFvYECm+q+GHsJXeO0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wi1gQ+Wnvrxbs80hC/eggImYDOJ/XQF3B0P10uVX7CS2xyLmLD7pIkZ4Xslje4AaavpchVoFQ4x1Uys90sF2p2T2iFoYrzUfA6UUTDZHDV/6rRRIsaoIktoM+XQTytnhXke8/EmeM6w5hJ6DyduhNv6T1lWPhRA0cflO/j+vbc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JKSZMBCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF6CC32786;
	Tue, 18 Jun 2024 13:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715677;
	bh=5spOvKZWiLBbjv066k5XDC7oUFvYECm+q+GHsJXeO0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JKSZMBCV6hxUj0u7jNvu8tV2wbCUD4ZehdzysEiPsbMxaxvMps7zrW2EWz1deAHvX
	 eEC7qR3K5D9UERTJ4sExZKEr9WOg1io+tMGYBxu9mGVFvLiw0691d+ovr8DyYQimk/
	 o7V2yC9V8+xft8mKnJn1dj78b7tI1wbyotDI/q38=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	NeilBrown <neilb@suse.de>,
	"J. Bruce Fields" <bfields@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 390/770] NFSD: move filehandle format declarations out of "uapi".
Date: Tue, 18 Jun 2024 14:34:03 +0200
Message-ID: <20240618123422.332951546@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.de>

[ Upstream commit ef5825e3cf0d0af657f5fb4dd86d750ed42fee0a ]

A small part of the declaration concerning filehandle format are
currently in the "uapi" include directory:
   include/uapi/linux/nfsd/nfsfh.h

There is a lot more to the filehandle format, including "enum fid_type"
and "enum nfsd_fsid" which are not exported via "uapi".

This small part of the filehandle definition is of minimal use outside
of the kernel, and I can find no evidence that an other code is using
it. Certainly nfs-utils and wireshark (The most likely candidates) do not
use these declarations.

So move it out of "uapi" by copying the content from
  include/uapi/linux/nfsd/nfsfh.h
into
  fs/nfsd/nfsfh.h

A few unnecessary "#include" directives are not copied, and neither is
the #define of fh_auth, which is annotated as being for userspace only.

The copyright claims in the uapi file are identical to those in the nfsd
file, so there is no need to copy those.

The "__u32" style integer types are only needed in "uapi".  In
kernel-only code we can use the more familiar "u32" style.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfsfh.h                 |  97 ++++++++++++++++++++++++++-
 fs/nfsd/vfs.c                   |   1 +
 include/uapi/linux/nfsd/nfsfh.h | 115 --------------------------------
 3 files changed, 97 insertions(+), 116 deletions(-)
 delete mode 100644 include/uapi/linux/nfsd/nfsfh.h

diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 6106697adc04b..ad47f16676a8c 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -10,9 +10,104 @@
 
 #include <linux/crc32.h>
 #include <linux/sunrpc/svc.h>
-#include <uapi/linux/nfsd/nfsfh.h>
 #include <linux/iversion.h>
 #include <linux/exportfs.h>
+#include <linux/nfs4.h>
+
+
+/*
+ * This is the old "dentry style" Linux NFSv2 file handle.
+ *
+ * The xino and xdev fields are currently used to transport the
+ * ino/dev of the exported inode.
+ */
+struct nfs_fhbase_old {
+	u32		fb_dcookie;	/* dentry cookie - always 0xfeebbaca */
+	u32		fb_ino;		/* our inode number */
+	u32		fb_dirino;	/* dir inode number, 0 for directories */
+	u32		fb_dev;		/* our device */
+	u32		fb_xdev;
+	u32		fb_xino;
+	u32		fb_generation;
+};
+
+/*
+ * This is the new flexible, extensible style NFSv2/v3/v4 file handle.
+ *
+ * The file handle starts with a sequence of four-byte words.
+ * The first word contains a version number (1) and three descriptor bytes
+ * that tell how the remaining 3 variable length fields should be handled.
+ * These three bytes are auth_type, fsid_type and fileid_type.
+ *
+ * All four-byte values are in host-byte-order.
+ *
+ * The auth_type field is deprecated and must be set to 0.
+ *
+ * The fsid_type identifies how the filesystem (or export point) is
+ *    encoded.
+ *  Current values:
+ *     0  - 4 byte device id (ms-2-bytes major, ls-2-bytes minor), 4byte inode number
+ *        NOTE: we cannot use the kdev_t device id value, because kdev_t.h
+ *              says we mustn't.  We must break it up and reassemble.
+ *     1  - 4 byte user specified identifier
+ *     2  - 4 byte major, 4 byte minor, 4 byte inode number - DEPRECATED
+ *     3  - 4 byte device id, encoded for user-space, 4 byte inode number
+ *     4  - 4 byte inode number and 4 byte uuid
+ *     5  - 8 byte uuid
+ *     6  - 16 byte uuid
+ *     7  - 8 byte inode number and 16 byte uuid
+ *
+ * The fileid_type identified how the file within the filesystem is encoded.
+ *   The values for this field are filesystem specific, exccept that
+ *   filesystems must not use the values '0' or '0xff'. 'See enum fid_type'
+ *   in include/linux/exportfs.h for currently registered values.
+ */
+struct nfs_fhbase_new {
+	union {
+		struct {
+			u8		fb_version_aux;	/* == 1, even => nfs_fhbase_old */
+			u8		fb_auth_type_aux;
+			u8		fb_fsid_type_aux;
+			u8		fb_fileid_type_aux;
+			u32		fb_auth[1];
+		/*	u32		fb_fsid[0]; floating */
+		/*	u32		fb_fileid[0]; floating */
+		};
+		struct {
+			u8		fb_version;	/* == 1, even => nfs_fhbase_old */
+			u8		fb_auth_type;
+			u8		fb_fsid_type;
+			u8		fb_fileid_type;
+			u32		fb_auth_flex[]; /* flexible-array member */
+		};
+	};
+};
+
+struct knfsd_fh {
+	unsigned int	fh_size;	/* significant for NFSv3.
+					 * Points to the current size while building
+					 * a new file handle
+					 */
+	union {
+		struct nfs_fhbase_old	fh_old;
+		u32			fh_pad[NFS4_FHSIZE/4];
+		struct nfs_fhbase_new	fh_new;
+	} fh_base;
+};
+
+#define ofh_dcookie		fh_base.fh_old.fb_dcookie
+#define ofh_ino			fh_base.fh_old.fb_ino
+#define ofh_dirino		fh_base.fh_old.fb_dirino
+#define ofh_dev			fh_base.fh_old.fb_dev
+#define ofh_xdev		fh_base.fh_old.fb_xdev
+#define ofh_xino		fh_base.fh_old.fb_xino
+#define ofh_generation		fh_base.fh_old.fb_generation
+
+#define	fh_version		fh_base.fh_new.fb_version
+#define	fh_fsid_type		fh_base.fh_new.fb_fsid_type
+#define	fh_auth_type		fh_base.fh_new.fb_auth_type
+#define	fh_fileid_type		fh_base.fh_new.fb_fileid_type
+#define	fh_fsid			fh_base.fh_new.fb_auth_flex
 
 static inline __u32 ino_t_to_u32(ino_t ino)
 {
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 2c493937dd5ec..05b5f7e241e70 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -244,6 +244,7 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * returned. Otherwise the covered directory is returned.
  * NOTE: this mountpoint crossing is not supported properly by all
  *   clients and is explicitly disallowed for NFSv3
+ *      NeilBrown <neilb@cse.unsw.edu.au>
  */
 __be32
 nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
diff --git a/include/uapi/linux/nfsd/nfsfh.h b/include/uapi/linux/nfsd/nfsfh.h
deleted file mode 100644
index e29e8accc4f4d..0000000000000
--- a/include/uapi/linux/nfsd/nfsfh.h
+++ /dev/null
@@ -1,115 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * This file describes the layout of the file handles as passed
- * over the wire.
- *
- * Copyright (C) 1995, 1996, 1997 Olaf Kirch <okir@monad.swb.de>
- */
-
-#ifndef _UAPI_LINUX_NFSD_FH_H
-#define _UAPI_LINUX_NFSD_FH_H
-
-#include <linux/types.h>
-#include <linux/nfs.h>
-#include <linux/nfs2.h>
-#include <linux/nfs3.h>
-#include <linux/nfs4.h>
-
-/*
- * This is the old "dentry style" Linux NFSv2 file handle.
- *
- * The xino and xdev fields are currently used to transport the
- * ino/dev of the exported inode.
- */
-struct nfs_fhbase_old {
-	__u32		fb_dcookie;	/* dentry cookie - always 0xfeebbaca */
-	__u32		fb_ino;		/* our inode number */
-	__u32		fb_dirino;	/* dir inode number, 0 for directories */
-	__u32		fb_dev;		/* our device */
-	__u32		fb_xdev;
-	__u32		fb_xino;
-	__u32		fb_generation;
-};
-
-/*
- * This is the new flexible, extensible style NFSv2/v3/v4 file handle.
- *
- * The file handle starts with a sequence of four-byte words.
- * The first word contains a version number (1) and three descriptor bytes
- * that tell how the remaining 3 variable length fields should be handled.
- * These three bytes are auth_type, fsid_type and fileid_type.
- *
- * All four-byte values are in host-byte-order.
- *
- * The auth_type field is deprecated and must be set to 0.
- *
- * The fsid_type identifies how the filesystem (or export point) is
- *    encoded.
- *  Current values:
- *     0  - 4 byte device id (ms-2-bytes major, ls-2-bytes minor), 4byte inode number
- *        NOTE: we cannot use the kdev_t device id value, because kdev_t.h
- *              says we mustn't.  We must break it up and reassemble.
- *     1  - 4 byte user specified identifier
- *     2  - 4 byte major, 4 byte minor, 4 byte inode number - DEPRECATED
- *     3  - 4 byte device id, encoded for user-space, 4 byte inode number
- *     4  - 4 byte inode number and 4 byte uuid
- *     5  - 8 byte uuid
- *     6  - 16 byte uuid
- *     7  - 8 byte inode number and 16 byte uuid
- *
- * The fileid_type identified how the file within the filesystem is encoded.
- *   The values for this field are filesystem specific, exccept that
- *   filesystems must not use the values '0' or '0xff'. 'See enum fid_type'
- *   in include/linux/exportfs.h for currently registered values.
- */
-struct nfs_fhbase_new {
-	union {
-		struct {
-			__u8		fb_version_aux;	/* == 1, even => nfs_fhbase_old */
-			__u8		fb_auth_type_aux;
-			__u8		fb_fsid_type_aux;
-			__u8		fb_fileid_type_aux;
-			__u32		fb_auth[1];
-			/*	__u32		fb_fsid[0]; floating */
-			/*	__u32		fb_fileid[0]; floating */
-		};
-		struct {
-			__u8		fb_version;	/* == 1, even => nfs_fhbase_old */
-			__u8		fb_auth_type;
-			__u8		fb_fsid_type;
-			__u8		fb_fileid_type;
-			__u32		fb_auth_flex[]; /* flexible-array member */
-		};
-	};
-};
-
-struct knfsd_fh {
-	unsigned int	fh_size;	/* significant for NFSv3.
-					 * Points to the current size while building
-					 * a new file handle
-					 */
-	union {
-		struct nfs_fhbase_old	fh_old;
-		__u32			fh_pad[NFS4_FHSIZE/4];
-		struct nfs_fhbase_new	fh_new;
-	} fh_base;
-};
-
-#define ofh_dcookie		fh_base.fh_old.fb_dcookie
-#define ofh_ino			fh_base.fh_old.fb_ino
-#define ofh_dirino		fh_base.fh_old.fb_dirino
-#define ofh_dev			fh_base.fh_old.fb_dev
-#define ofh_xdev		fh_base.fh_old.fb_xdev
-#define ofh_xino		fh_base.fh_old.fb_xino
-#define ofh_generation		fh_base.fh_old.fb_generation
-
-#define	fh_version		fh_base.fh_new.fb_version
-#define	fh_fsid_type		fh_base.fh_new.fb_fsid_type
-#define	fh_auth_type		fh_base.fh_new.fb_auth_type
-#define	fh_fileid_type		fh_base.fh_new.fb_fileid_type
-#define	fh_fsid			fh_base.fh_new.fb_auth_flex
-
-/* Do not use, provided for userspace compatiblity. */
-#define	fh_auth			fh_base.fh_new.fb_auth
-
-#endif /* _UAPI_LINUX_NFSD_FH_H */
-- 
2.43.0




