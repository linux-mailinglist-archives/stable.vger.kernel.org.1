Return-Path: <stable+bounces-113567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CF8A29311
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C35D188A0DE
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7035119F121;
	Wed,  5 Feb 2025 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FzagkJQA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D38118952C;
	Wed,  5 Feb 2025 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767401; cv=none; b=MmvJD+lRDgkLZagoLwjBwbo2oinowJxqAVHAdS7pJTZ1n5olE07TAkH4pLNdR20d3oqit2NO1g7Q2Os+ZapT6pqFSYUMLrKy4OptWLSAE2vIgsYYRit+x89RCTxHgfKImBj3/1SUqU8FbzPqHrQlHScDgsIo55I4+ca2LzAuf6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767401; c=relaxed/simple;
	bh=RMdDh5FgUuS+EtpqtLjvpEqpyKVsd9MKkdQgIelj7Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TlnYh3stPfCIQysvv+DkcSQ78iobn72BN5sPme8xKBuk269Npnx02KaoKNQ9Xa1IdGX/e23FN25T1TnKdjE/F/htoh3lTsaHJ0uLUlcVIi3qLRNRn/keO5h/9fMw3uIlSQjwPSMGybp4XVFxK39jm385EzMrduqQyjHg1LLXC7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FzagkJQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908F8C4CED1;
	Wed,  5 Feb 2025 14:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738767401;
	bh=RMdDh5FgUuS+EtpqtLjvpEqpyKVsd9MKkdQgIelj7Gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FzagkJQAxa1SeosyzyIq9ULPvz4Wm1NKh6WCCmIV5bPmADeBP3be5VcIpbhzwKvH+
	 DjO53cdQK2th9NEd7W9ojHeBjGp+pGwIIuHWOl0z4eQl/MlTrHRUiusZjh3jM7u8MG
	 7oddADKjQFjv9dYGzf8vhNGcVgy3wwbH1peCVAk0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 452/590] nfs: fix incorrect error handling in LOCALIO
Date: Wed,  5 Feb 2025 14:43:27 +0100
Message-ID: <20250205134512.558375734@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Snitzer <snitzer@kernel.org>

[ Upstream commit ead11ac50ad4b8ef1b64806e962ea984862d96ad ]

nfs4_stat_to_errno() expects a NFSv4 error code as an argument and
returns a POSIX errno.

The problem is LOCALIO is passing nfs4_stat_to_errno() the POSIX errno
return values from filp->f_op->read_iter(), filp->f_op->write_iter()
and vfs_fsync_range().

So the POSIX errno that nfs_local_pgio_done() and
nfs_local_commit_done() are passing to nfs4_stat_to_errno() are
failing to match any NFSv4 error code, which results in
nfs4_stat_to_errno() defaulting to returning -EREMOTEIO. This causes
assertions in upper layers due to -EREMOTEIO not being a valid NFSv4
error code.

Fix this by updating nfs_local_pgio_done() and nfs_local_commit_done()
to use the new nfs_localio_errno_to_nfs4_stat() to map a POSIX errno
to an NFSv4 error code.

Care was taken to factor out nfs4_errtbl_common[] to avoid duplicating
the same NFS error to errno table. nfs4_errtbl_common[] is checked
first by both nfs4_stat_to_errno and nfs_localio_errno_to_nfs4_stat
before they check their own more specialized tables (nfs4_errtbl[] and
nfs4_errtbl_localio[] respectively).

While auditing the associated error mapping tables, the (ab)use of -1
for the last table entry was removed in favor of using ARRAY_SIZE to
iterate the nfs_errtbl[] and nfs4_errtbl[]. And 'errno_NFSERR_IO' was
removed because it caused needless obfuscation.

Fixes: 70ba381e1a431 ("nfs: add LOCALIO support")
Reported-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/localio.c           |  4 +-
 fs/nfs_common/common.c     | 89 +++++++++++++++++++++++++++++++++-----
 include/linux/nfs_common.h |  3 +-
 3 files changed, 82 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 637528e6368ef..21b2b38fae9f3 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -331,7 +331,7 @@ nfs_local_pgio_done(struct nfs_pgio_header *hdr, long status)
 		hdr->res.op_status = NFS4_OK;
 		hdr->task.tk_status = 0;
 	} else {
-		hdr->res.op_status = nfs4_stat_to_errno(status);
+		hdr->res.op_status = nfs_localio_errno_to_nfs4_stat(status);
 		hdr->task.tk_status = status;
 	}
 }
@@ -669,7 +669,7 @@ nfs_local_commit_done(struct nfs_commit_data *data, int status)
 		data->task.tk_status = 0;
 	} else {
 		nfs_reset_boot_verifier(data->inode);
-		data->res.op_status = nfs4_stat_to_errno(status);
+		data->res.op_status = nfs_localio_errno_to_nfs4_stat(status);
 		data->task.tk_status = status;
 	}
 }
diff --git a/fs/nfs_common/common.c b/fs/nfs_common/common.c
index 34a115176f97e..af09aed09fd27 100644
--- a/fs/nfs_common/common.c
+++ b/fs/nfs_common/common.c
@@ -15,7 +15,7 @@ static const struct {
 	{ NFS_OK,		0		},
 	{ NFSERR_PERM,		-EPERM		},
 	{ NFSERR_NOENT,		-ENOENT		},
-	{ NFSERR_IO,		-errno_NFSERR_IO},
+	{ NFSERR_IO,		-EIO		},
 	{ NFSERR_NXIO,		-ENXIO		},
 /*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
 	{ NFSERR_ACCES,		-EACCES		},
@@ -45,7 +45,6 @@ static const struct {
 	{ NFSERR_SERVERFAULT,	-EREMOTEIO	},
 	{ NFSERR_BADTYPE,	-EBADTYPE	},
 	{ NFSERR_JUKEBOX,	-EJUKEBOX	},
-	{ -1,			-EIO		}
 };
 
 /**
@@ -59,26 +58,29 @@ int nfs_stat_to_errno(enum nfs_stat status)
 {
 	int i;
 
-	for (i = 0; nfs_errtbl[i].stat != -1; i++) {
+	for (i = 0; i < ARRAY_SIZE(nfs_errtbl); i++) {
 		if (nfs_errtbl[i].stat == (int)status)
 			return nfs_errtbl[i].errno;
 	}
-	return nfs_errtbl[i].errno;
+	return -EIO;
 }
 EXPORT_SYMBOL_GPL(nfs_stat_to_errno);
 
 /*
  * We need to translate between nfs v4 status return values and
  * the local errno values which may not be the same.
+ *
+ * nfs4_errtbl_common[] is used before more specialized mappings
+ * available in nfs4_errtbl[] or nfs4_errtbl_localio[].
  */
 static const struct {
 	int stat;
 	int errno;
-} nfs4_errtbl[] = {
+} nfs4_errtbl_common[] = {
 	{ NFS4_OK,		0		},
 	{ NFS4ERR_PERM,		-EPERM		},
 	{ NFS4ERR_NOENT,	-ENOENT		},
-	{ NFS4ERR_IO,		-errno_NFSERR_IO},
+	{ NFS4ERR_IO,		-EIO		},
 	{ NFS4ERR_NXIO,		-ENXIO		},
 	{ NFS4ERR_ACCESS,	-EACCES		},
 	{ NFS4ERR_EXIST,	-EEXIST		},
@@ -98,15 +100,20 @@ static const struct {
 	{ NFS4ERR_BAD_COOKIE,	-EBADCOOKIE	},
 	{ NFS4ERR_NOTSUPP,	-ENOTSUPP	},
 	{ NFS4ERR_TOOSMALL,	-ETOOSMALL	},
-	{ NFS4ERR_SERVERFAULT,	-EREMOTEIO	},
 	{ NFS4ERR_BADTYPE,	-EBADTYPE	},
-	{ NFS4ERR_LOCKED,	-EAGAIN		},
 	{ NFS4ERR_SYMLINK,	-ELOOP		},
-	{ NFS4ERR_OP_ILLEGAL,	-EOPNOTSUPP	},
 	{ NFS4ERR_DEADLOCK,	-EDEADLK	},
+};
+
+static const struct {
+	int stat;
+	int errno;
+} nfs4_errtbl[] = {
+	{ NFS4ERR_SERVERFAULT,	-EREMOTEIO	},
+	{ NFS4ERR_LOCKED,	-EAGAIN		},
+	{ NFS4ERR_OP_ILLEGAL,	-EOPNOTSUPP	},
 	{ NFS4ERR_NOXATTR,	-ENODATA	},
 	{ NFS4ERR_XATTR2BIG,	-E2BIG		},
-	{ -1,			-EIO		}
 };
 
 /*
@@ -116,7 +123,14 @@ static const struct {
 int nfs4_stat_to_errno(int stat)
 {
 	int i;
-	for (i = 0; nfs4_errtbl[i].stat != -1; i++) {
+
+	/* First check nfs4_errtbl_common */
+	for (i = 0; i < ARRAY_SIZE(nfs4_errtbl_common); i++) {
+		if (nfs4_errtbl_common[i].stat == stat)
+			return nfs4_errtbl_common[i].errno;
+	}
+	/* Then check nfs4_errtbl */
+	for (i = 0; i < ARRAY_SIZE(nfs4_errtbl); i++) {
 		if (nfs4_errtbl[i].stat == stat)
 			return nfs4_errtbl[i].errno;
 	}
@@ -132,3 +146,56 @@ int nfs4_stat_to_errno(int stat)
 	return -stat;
 }
 EXPORT_SYMBOL_GPL(nfs4_stat_to_errno);
+
+/*
+ * This table is useful for conversion from local errno to NFS error.
+ * It provides more logically correct mappings for use with LOCALIO
+ * (which is focused on converting from errno to NFS status).
+ */
+static const struct {
+	int stat;
+	int errno;
+} nfs4_errtbl_localio[] = {
+	/* Map errors differently than nfs4_errtbl */
+	{ NFS4ERR_IO,		-EREMOTEIO	},
+	{ NFS4ERR_DELAY,	-EAGAIN		},
+	{ NFS4ERR_FBIG,		-E2BIG		},
+	/* Map errors not handled by nfs4_errtbl */
+	{ NFS4ERR_STALE,	-EBADF		},
+	{ NFS4ERR_STALE,	-EOPENSTALE	},
+	{ NFS4ERR_DELAY,	-ETIMEDOUT	},
+	{ NFS4ERR_DELAY,	-ERESTARTSYS	},
+	{ NFS4ERR_DELAY,	-ENOMEM		},
+	{ NFS4ERR_IO,		-ETXTBSY	},
+	{ NFS4ERR_IO,		-EBUSY		},
+	{ NFS4ERR_SERVERFAULT,	-ESERVERFAULT	},
+	{ NFS4ERR_SERVERFAULT,	-ENFILE		},
+	{ NFS4ERR_IO,		-EUCLEAN	},
+	{ NFS4ERR_PERM,		-ENOKEY		},
+};
+
+/*
+ * Convert an errno to an NFS error code for LOCALIO.
+ */
+__u32 nfs_localio_errno_to_nfs4_stat(int errno)
+{
+	int i;
+
+	/* First check nfs4_errtbl_common */
+	for (i = 0; i < ARRAY_SIZE(nfs4_errtbl_common); i++) {
+		if (nfs4_errtbl_common[i].errno == errno)
+			return nfs4_errtbl_common[i].stat;
+	}
+	/* Then check nfs4_errtbl_localio */
+	for (i = 0; i < ARRAY_SIZE(nfs4_errtbl_localio); i++) {
+		if (nfs4_errtbl_localio[i].errno == errno)
+			return nfs4_errtbl_localio[i].stat;
+	}
+	/* If we cannot translate the error, the recovery routines should
+	 * handle it.
+	 * Note: remaining NFSv4 error codes have values > 10000, so should
+	 * not conflict with native Linux error codes.
+	 */
+	return NFS4ERR_SERVERFAULT;
+}
+EXPORT_SYMBOL_GPL(nfs_localio_errno_to_nfs4_stat);
diff --git a/include/linux/nfs_common.h b/include/linux/nfs_common.h
index 5fc02df882521..a541c3a028875 100644
--- a/include/linux/nfs_common.h
+++ b/include/linux/nfs_common.h
@@ -9,9 +9,10 @@
 #include <uapi/linux/nfs.h>
 
 /* Mapping from NFS error code to "errno" error code. */
-#define errno_NFSERR_IO EIO
 
 int nfs_stat_to_errno(enum nfs_stat status);
 int nfs4_stat_to_errno(int stat);
 
+__u32 nfs_localio_errno_to_nfs4_stat(int errno);
+
 #endif /* _LINUX_NFS_COMMON_H */
-- 
2.39.5




