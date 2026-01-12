Return-Path: <stable+bounces-208124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFA4D134AC
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 15:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7AB331B4A09
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 14:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F76D2E36F3;
	Mon, 12 Jan 2026 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4fs6REk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EE52E2DF2
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228025; cv=none; b=HWrdMOt2ohcpSBkAo32L1IuClNtfVt7oc9VBOz3KWcmlB4qBV0hguPIIbDcJ7reg5BVF03Hc7xZ5w0k3LQWBNF8Ry4R6AeqQCnu300+ju9KpVcPBkoaSE4JWh8PDvtxfDG1Nk9y7K1FqH1FCQyzx5kadWXBUfC00iaHzTp8NSQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228025; c=relaxed/simple;
	bh=DyuCAWxa7tyAfDVCjTdwRz4h5bM2YcvG4FteVl8ncdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bt/HaH3eFPXksSCctULl6Jjmrncpr4j8sn3GrQJa+cCK4InoQmr3OSuiYRmLvQZ4ua/kCeaAxLwrxy2berDAY9g1hh9VaokwOsTN8+spAN3EYhLEHvBjmEpBnzoMF8Zf8bRQxBIFg3xuy1qtL48PY6eiji7wxQK35mSmC/LsEno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4fs6REk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7EBC19421;
	Mon, 12 Jan 2026 14:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768228024;
	bh=DyuCAWxa7tyAfDVCjTdwRz4h5bM2YcvG4FteVl8ncdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t4fs6REkSvKEQEQfRnxmLE0rhJUjifZY43jihQdnFWlo5QFSTRkru1Cu1LXRxifrd
	 XjyAcMYoP6qzEpAAuVzC5Xa/brlQ+9Cfvb8JufobhaLYfdFc+4aIY+4qv41IMnS5zp
	 9jfevjcRz7mq/4yN8MtK+WQWz+hweQCtk2fNTvUy2V45vkulFUFsMqV3p2bxq88rpd
	 DrCt53rP33ypGojR75BP+2mdjjV9OhC+Z5lhVliWefhR9jKXrJE0n3c076T4EbaAsL
	 gn+IixtUiAV/KN8NfM47i3/MBfZdpnFW6c1am+eAZCL4cPuDpeKVIHxiSA4gJurgBN
	 qg3vzgkp5Lfvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] nfs_common: factor out nfs_errtbl and nfs_stat_to_errno
Date: Mon, 12 Jan 2026 09:27:00 -0500
Message-ID: <20260112142701.711948-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260112142701.711948-1-sashal@kernel.org>
References: <2026011222-giggle-goofiness-bbd1@gregkh>
 <20260112142701.711948-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@kernel.org>

[ Upstream commit 4806ded4c14c5e8fdc6ce885d83221a78c06a428 ]

Common nfs_stat_to_errno() is used by both fs/nfs/nfs2xdr.c and
fs/nfs/nfs3xdr.c

Will also be used by fs/nfsd/localio.c

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neilb@suse.de>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Stable-dep-of: c6c209ceb87f ("NFSD: Remove NFSERR_EAGAIN")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/Kconfig             |   1 +
 fs/nfs/nfs2xdr.c           |  70 +-----------------------
 fs/nfs/nfs3xdr.c           | 108 +++++++------------------------------
 fs/nfs/nfs4xdr.c           |   4 +-
 fs/nfs_common/Makefile     |   2 +
 fs/nfs_common/common.c     |  67 +++++++++++++++++++++++
 fs/nfsd/Kconfig            |   1 +
 include/linux/nfs_common.h |  16 ++++++
 8 files changed, 109 insertions(+), 160 deletions(-)
 create mode 100644 fs/nfs_common/common.c
 create mode 100644 include/linux/nfs_common.h

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 2d99f5e7a686b..baa8c0bbd0b0a 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -5,6 +5,7 @@ config NFS_FS
 	select CRC32
 	select LOCKD
 	select SUNRPC
+	select NFS_COMMON
 	select NFS_ACL_SUPPORT if NFS_V3_ACL
 	help
 	  Choose Y here if you want to access files residing on other
diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
index c190938142960..6e75c6c2d2347 100644
--- a/fs/nfs/nfs2xdr.c
+++ b/fs/nfs/nfs2xdr.c
@@ -22,14 +22,12 @@
 #include <linux/nfs.h>
 #include <linux/nfs2.h>
 #include <linux/nfs_fs.h>
+#include <linux/nfs_common.h>
 #include "nfstrace.h"
 #include "internal.h"
 
 #define NFSDBG_FACILITY		NFSDBG_XDR
 
-/* Mapping from NFS error code to "errno" error code. */
-#define errno_NFSERR_IO		EIO
-
 /*
  * Declare the space requirements for NFS arguments and replies as
  * number of 32bit-words
@@ -64,8 +62,6 @@
 #define NFS_readdirres_sz	(1+NFS_pagepad_sz)
 #define NFS_statfsres_sz	(1+NFS_info_sz)
 
-static int nfs_stat_to_errno(enum nfs_stat);
-
 /*
  * Encode/decode NFSv2 basic data types
  *
@@ -1054,70 +1050,6 @@ static int nfs2_xdr_dec_statfsres(struct rpc_rqst *req, struct xdr_stream *xdr,
 	return nfs_stat_to_errno(status);
 }
 
-
-/*
- * We need to translate between nfs status return values and
- * the local errno values which may not be the same.
- */
-static const struct {
-	int stat;
-	int errno;
-} nfs_errtbl[] = {
-	{ NFS_OK,		0		},
-	{ NFSERR_PERM,		-EPERM		},
-	{ NFSERR_NOENT,		-ENOENT		},
-	{ NFSERR_IO,		-errno_NFSERR_IO},
-	{ NFSERR_NXIO,		-ENXIO		},
-/*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
-	{ NFSERR_ACCES,		-EACCES		},
-	{ NFSERR_EXIST,		-EEXIST		},
-	{ NFSERR_XDEV,		-EXDEV		},
-	{ NFSERR_NODEV,		-ENODEV		},
-	{ NFSERR_NOTDIR,	-ENOTDIR	},
-	{ NFSERR_ISDIR,		-EISDIR		},
-	{ NFSERR_INVAL,		-EINVAL		},
-	{ NFSERR_FBIG,		-EFBIG		},
-	{ NFSERR_NOSPC,		-ENOSPC		},
-	{ NFSERR_ROFS,		-EROFS		},
-	{ NFSERR_MLINK,		-EMLINK		},
-	{ NFSERR_NAMETOOLONG,	-ENAMETOOLONG	},
-	{ NFSERR_NOTEMPTY,	-ENOTEMPTY	},
-	{ NFSERR_DQUOT,		-EDQUOT		},
-	{ NFSERR_STALE,		-ESTALE		},
-	{ NFSERR_REMOTE,	-EREMOTE	},
-#ifdef EWFLUSH
-	{ NFSERR_WFLUSH,	-EWFLUSH	},
-#endif
-	{ NFSERR_BADHANDLE,	-EBADHANDLE	},
-	{ NFSERR_NOT_SYNC,	-ENOTSYNC	},
-	{ NFSERR_BAD_COOKIE,	-EBADCOOKIE	},
-	{ NFSERR_NOTSUPP,	-ENOTSUPP	},
-	{ NFSERR_TOOSMALL,	-ETOOSMALL	},
-	{ NFSERR_SERVERFAULT,	-EREMOTEIO	},
-	{ NFSERR_BADTYPE,	-EBADTYPE	},
-	{ NFSERR_JUKEBOX,	-EJUKEBOX	},
-	{ -1,			-EIO		}
-};
-
-/**
- * nfs_stat_to_errno - convert an NFS status code to a local errno
- * @status: NFS status code to convert
- *
- * Returns a local errno value, or -EIO if the NFS status code is
- * not recognized.  This function is used jointly by NFSv2 and NFSv3.
- */
-static int nfs_stat_to_errno(enum nfs_stat status)
-{
-	int i;
-
-	for (i = 0; nfs_errtbl[i].stat != -1; i++) {
-		if (nfs_errtbl[i].stat == (int)status)
-			return nfs_errtbl[i].errno;
-	}
-	dprintk("NFS: Unrecognized nfs status value: %u\n", status);
-	return nfs_errtbl[i].errno;
-}
-
 #define PROC(proc, argtype, restype, timer)				\
 [NFSPROC_##proc] = {							\
 	.p_proc	    =  NFSPROC_##proc,					\
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index 60f032be805ae..4ae01c10b7e28 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -21,14 +21,13 @@
 #include <linux/nfs3.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfsacl.h>
+#include <linux/nfs_common.h>
+
 #include "nfstrace.h"
 #include "internal.h"
 
 #define NFSDBG_FACILITY		NFSDBG_XDR
 
-/* Mapping from NFS error code to "errno" error code. */
-#define errno_NFSERR_IO		EIO
-
 /*
  * Declare the space requirements for NFS arguments and replies as
  * number of 32bit-words
@@ -91,8 +90,6 @@
 				NFS3_pagepad_sz)
 #define ACL3_setaclres_sz	(1+NFS3_post_op_attr_sz)
 
-static int nfs3_stat_to_errno(enum nfs_stat);
-
 /*
  * Map file type to S_IFMT bits
  */
@@ -1406,7 +1403,7 @@ static int nfs3_xdr_dec_getattr3res(struct rpc_rqst *req,
 out:
 	return error;
 out_default:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -1445,7 +1442,7 @@ static int nfs3_xdr_dec_setattr3res(struct rpc_rqst *req,
 out:
 	return error;
 out_status:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -1495,7 +1492,7 @@ static int nfs3_xdr_dec_lookup3res(struct rpc_rqst *req,
 	error = decode_post_op_attr(xdr, result->dir_attr, userns);
 	if (unlikely(error))
 		goto out;
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -1537,7 +1534,7 @@ static int nfs3_xdr_dec_access3res(struct rpc_rqst *req,
 out:
 	return error;
 out_default:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -1578,7 +1575,7 @@ static int nfs3_xdr_dec_readlink3res(struct rpc_rqst *req,
 out:
 	return error;
 out_default:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -1658,7 +1655,7 @@ static int nfs3_xdr_dec_read3res(struct rpc_rqst *req, struct xdr_stream *xdr,
 out:
 	return error;
 out_status:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -1728,7 +1725,7 @@ static int nfs3_xdr_dec_write3res(struct rpc_rqst *req, struct xdr_stream *xdr,
 out:
 	return error;
 out_status:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -1795,7 +1792,7 @@ static int nfs3_xdr_dec_create3res(struct rpc_rqst *req,
 	error = decode_wcc_data(xdr, result->dir_attr, userns);
 	if (unlikely(error))
 		goto out;
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -1835,7 +1832,7 @@ static int nfs3_xdr_dec_remove3res(struct rpc_rqst *req,
 out:
 	return error;
 out_status:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -1881,7 +1878,7 @@ static int nfs3_xdr_dec_rename3res(struct rpc_rqst *req,
 out:
 	return error;
 out_status:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -1926,7 +1923,7 @@ static int nfs3_xdr_dec_link3res(struct rpc_rqst *req, struct xdr_stream *xdr,
 out:
 	return error;
 out_status:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /**
@@ -2101,7 +2098,7 @@ static int nfs3_xdr_dec_readdir3res(struct rpc_rqst *req,
 	error = decode_post_op_attr(xdr, result->dir_attr, rpc_rqst_userns(req));
 	if (unlikely(error))
 		goto out;
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -2167,7 +2164,7 @@ static int nfs3_xdr_dec_fsstat3res(struct rpc_rqst *req,
 out:
 	return error;
 out_status:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -2243,7 +2240,7 @@ static int nfs3_xdr_dec_fsinfo3res(struct rpc_rqst *req,
 out:
 	return error;
 out_status:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -2304,7 +2301,7 @@ static int nfs3_xdr_dec_pathconf3res(struct rpc_rqst *req,
 out:
 	return error;
 out_status:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -2350,7 +2347,7 @@ static int nfs3_xdr_dec_commit3res(struct rpc_rqst *req,
 out:
 	return error;
 out_status:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 #ifdef CONFIG_NFS_V3_ACL
@@ -2416,7 +2413,7 @@ static int nfs3_xdr_dec_getacl3res(struct rpc_rqst *req,
 out:
 	return error;
 out_default:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 static int nfs3_xdr_dec_setacl3res(struct rpc_rqst *req,
@@ -2435,76 +2432,11 @@ static int nfs3_xdr_dec_setacl3res(struct rpc_rqst *req,
 out:
 	return error;
 out_default:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 #endif  /* CONFIG_NFS_V3_ACL */
 
-
-/*
- * We need to translate between nfs status return values and
- * the local errno values which may not be the same.
- */
-static const struct {
-	int stat;
-	int errno;
-} nfs_errtbl[] = {
-	{ NFS_OK,		0		},
-	{ NFSERR_PERM,		-EPERM		},
-	{ NFSERR_NOENT,		-ENOENT		},
-	{ NFSERR_IO,		-errno_NFSERR_IO},
-	{ NFSERR_NXIO,		-ENXIO		},
-/*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
-	{ NFSERR_ACCES,		-EACCES		},
-	{ NFSERR_EXIST,		-EEXIST		},
-	{ NFSERR_XDEV,		-EXDEV		},
-	{ NFSERR_NODEV,		-ENODEV		},
-	{ NFSERR_NOTDIR,	-ENOTDIR	},
-	{ NFSERR_ISDIR,		-EISDIR		},
-	{ NFSERR_INVAL,		-EINVAL		},
-	{ NFSERR_FBIG,		-EFBIG		},
-	{ NFSERR_NOSPC,		-ENOSPC		},
-	{ NFSERR_ROFS,		-EROFS		},
-	{ NFSERR_MLINK,		-EMLINK		},
-	{ NFSERR_NAMETOOLONG,	-ENAMETOOLONG	},
-	{ NFSERR_NOTEMPTY,	-ENOTEMPTY	},
-	{ NFSERR_DQUOT,		-EDQUOT		},
-	{ NFSERR_STALE,		-ESTALE		},
-	{ NFSERR_REMOTE,	-EREMOTE	},
-#ifdef EWFLUSH
-	{ NFSERR_WFLUSH,	-EWFLUSH	},
-#endif
-	{ NFSERR_BADHANDLE,	-EBADHANDLE	},
-	{ NFSERR_NOT_SYNC,	-ENOTSYNC	},
-	{ NFSERR_BAD_COOKIE,	-EBADCOOKIE	},
-	{ NFSERR_NOTSUPP,	-ENOTSUPP	},
-	{ NFSERR_TOOSMALL,	-ETOOSMALL	},
-	{ NFSERR_SERVERFAULT,	-EREMOTEIO	},
-	{ NFSERR_BADTYPE,	-EBADTYPE	},
-	{ NFSERR_JUKEBOX,	-EJUKEBOX	},
-	{ -1,			-EIO		}
-};
-
-/**
- * nfs3_stat_to_errno - convert an NFS status code to a local errno
- * @status: NFS status code to convert
- *
- * Returns a local errno value, or -EIO if the NFS status code is
- * not recognized.  This function is used jointly by NFSv2 and NFSv3.
- */
-static int nfs3_stat_to_errno(enum nfs_stat status)
-{
-	int i;
-
-	for (i = 0; nfs_errtbl[i].stat != -1; i++) {
-		if (nfs_errtbl[i].stat == (int)status)
-			return nfs_errtbl[i].errno;
-	}
-	dprintk("NFS: Unrecognized nfs status value: %u\n", status);
-	return nfs_errtbl[i].errno;
-}
-
-
 #define PROC(proc, argtype, restype, timer)				\
 [NFS3PROC_##proc] = {							\
 	.p_proc      = NFS3PROC_##proc,					\
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index deec76cf5afea..a9d57fcdf9b40 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -52,6 +52,7 @@
 #include <linux/nfs.h>
 #include <linux/nfs4.h>
 #include <linux/nfs_fs.h>
+#include <linux/nfs_common.h>
 
 #include "nfs4_fs.h"
 #include "nfs4trace.h"
@@ -63,9 +64,6 @@
 
 #define NFSDBG_FACILITY		NFSDBG_XDR
 
-/* Mapping from NFS error code to "errno" error code. */
-#define errno_NFSERR_IO		EIO
-
 struct compound_hdr;
 static int nfs4_stat_to_errno(int);
 static void encode_layoutget(struct xdr_stream *xdr,
diff --git a/fs/nfs_common/Makefile b/fs/nfs_common/Makefile
index 119c75ab9fd08..e58b01bb8dda6 100644
--- a/fs/nfs_common/Makefile
+++ b/fs/nfs_common/Makefile
@@ -8,3 +8,5 @@ nfs_acl-objs := nfsacl.o
 
 obj-$(CONFIG_GRACE_PERIOD) += grace.o
 obj-$(CONFIG_NFS_V4_2_SSC_HELPER) += nfs_ssc.o
+
+obj-$(CONFIG_NFS_COMMON) += common.o
diff --git a/fs/nfs_common/common.c b/fs/nfs_common/common.c
new file mode 100644
index 0000000000000..a4ee95da2174e
--- /dev/null
+++ b/fs/nfs_common/common.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/module.h>
+#include <linux/nfs_common.h>
+
+/*
+ * We need to translate between nfs status return values and
+ * the local errno values which may not be the same.
+ */
+static const struct {
+	int stat;
+	int errno;
+} nfs_errtbl[] = {
+	{ NFS_OK,		0		},
+	{ NFSERR_PERM,		-EPERM		},
+	{ NFSERR_NOENT,		-ENOENT		},
+	{ NFSERR_IO,		-errno_NFSERR_IO},
+	{ NFSERR_NXIO,		-ENXIO		},
+/*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
+	{ NFSERR_ACCES,		-EACCES		},
+	{ NFSERR_EXIST,		-EEXIST		},
+	{ NFSERR_XDEV,		-EXDEV		},
+	{ NFSERR_NODEV,		-ENODEV		},
+	{ NFSERR_NOTDIR,	-ENOTDIR	},
+	{ NFSERR_ISDIR,		-EISDIR		},
+	{ NFSERR_INVAL,		-EINVAL		},
+	{ NFSERR_FBIG,		-EFBIG		},
+	{ NFSERR_NOSPC,		-ENOSPC		},
+	{ NFSERR_ROFS,		-EROFS		},
+	{ NFSERR_MLINK,		-EMLINK		},
+	{ NFSERR_NAMETOOLONG,	-ENAMETOOLONG	},
+	{ NFSERR_NOTEMPTY,	-ENOTEMPTY	},
+	{ NFSERR_DQUOT,		-EDQUOT		},
+	{ NFSERR_STALE,		-ESTALE		},
+	{ NFSERR_REMOTE,	-EREMOTE	},
+#ifdef EWFLUSH
+	{ NFSERR_WFLUSH,	-EWFLUSH	},
+#endif
+	{ NFSERR_BADHANDLE,	-EBADHANDLE	},
+	{ NFSERR_NOT_SYNC,	-ENOTSYNC	},
+	{ NFSERR_BAD_COOKIE,	-EBADCOOKIE	},
+	{ NFSERR_NOTSUPP,	-ENOTSUPP	},
+	{ NFSERR_TOOSMALL,	-ETOOSMALL	},
+	{ NFSERR_SERVERFAULT,	-EREMOTEIO	},
+	{ NFSERR_BADTYPE,	-EBADTYPE	},
+	{ NFSERR_JUKEBOX,	-EJUKEBOX	},
+	{ -1,			-EIO		}
+};
+
+/**
+ * nfs_stat_to_errno - convert an NFS status code to a local errno
+ * @status: NFS status code to convert
+ *
+ * Returns a local errno value, or -EIO if the NFS status code is
+ * not recognized.  This function is used jointly by NFSv2 and NFSv3.
+ */
+int nfs_stat_to_errno(enum nfs_stat status)
+{
+	int i;
+
+	for (i = 0; nfs_errtbl[i].stat != -1; i++) {
+		if (nfs_errtbl[i].stat == (int)status)
+			return nfs_errtbl[i].errno;
+	}
+	return nfs_errtbl[i].errno;
+}
+EXPORT_SYMBOL_GPL(nfs_stat_to_errno);
diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index 05c10f70456cc..75a3e5407a87d 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -8,6 +8,7 @@ config NFSD
 	select LOCKD
 	select SUNRPC
 	select EXPORTFS
+	select NFS_COMMON
 	select NFS_ACL_SUPPORT if NFSD_V2_ACL
 	select NFS_ACL_SUPPORT if NFSD_V3_ACL
 	depends on MULTIUSER
diff --git a/include/linux/nfs_common.h b/include/linux/nfs_common.h
new file mode 100644
index 0000000000000..3395c4a4d3720
--- /dev/null
+++ b/include/linux/nfs_common.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This file contains constants and methods used by both NFS client and server.
+ */
+#ifndef _LINUX_NFS_COMMON_H
+#define _LINUX_NFS_COMMON_H
+
+#include <linux/errno.h>
+#include <uapi/linux/nfs.h>
+
+/* Mapping from NFS error code to "errno" error code. */
+#define errno_NFSERR_IO EIO
+
+int nfs_stat_to_errno(enum nfs_stat status);
+
+#endif /* _LINUX_NFS_COMMON_H */
-- 
2.51.0


