Return-Path: <stable+bounces-37269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A28689C424
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D501C2221A
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E0085635;
	Mon,  8 Apr 2024 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ScOrdvgy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B486E7D09F;
	Mon,  8 Apr 2024 13:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583742; cv=none; b=aG8uqjZcbqdSCrEF9Dri8xXFbgdA5LuXOYheDLXJT0iXBuicYP+eiZ0rb0I8puugJvlKDzzHl69MkTpN10Cl9PJDvRWnANfq1vKsonuacGujKXDToKPatWckYXERrrwvcQw84u8LFxk4wE//pYnXtsVrXDsVSZCxtd3/SxoyueM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583742; c=relaxed/simple;
	bh=8g56lPKiOB3SEM8Po7b16KovNgr4hedlD9V8WW1XSDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhNBzO4dcNLQFHCHJRAkvezw/OxFJLwh0+/AwKUJjonHItovhhG2M2kc5ArHpVQgRxhGda9fM/ELPX/OAUKONnSCV2biF0GOQiruVOXxGr5kHgXmRXwY1HSVdiphTyz8cmkTBrBJRKGj2xDsjVe39XhKaA6reiWUgdr82VX+bic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ScOrdvgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5DEC433C7;
	Mon,  8 Apr 2024 13:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583742;
	bh=8g56lPKiOB3SEM8Po7b16KovNgr4hedlD9V8WW1XSDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ScOrdvgyL3oK7vEfcWnM9S5U4j9WpdYAnFWSaGQFMG2RTDwS7jP/EDz0HlToJQgsy
	 I/+VCmkXrWFfJBeHEc1hoI2HYALGQe7jziPBGR3mPPAH49xQkUpn4UP0ndQbtQz8YL
	 chbFAMS4U6yk3FQ1I3oStH/qCD0ySZ6YdoaTPvl4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 280/690] NFSD: Remove CONFIG_NFSD_V3
Date: Mon,  8 Apr 2024 14:52:26 +0200
Message-ID: <20240408125409.749685691@linuxfoundation.org>
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

[ Upstream commit 5f9a62ff7d2808c7b56c0ec90f3b7eae5872afe6 ]

Eventually support for NFSv2 in the Linux NFS server is to be
deprecated and then removed.

However, NFSv2 is the "always supported" version that is available
as soon as CONFIG_NFSD is set.  Before NFSv2 support can be removed,
we need to choose a different "always supported" version.

This patch removes CONFIG_NFSD_V3 so that NFSv3 is always supported,
as NFSv2 is today. When NFSv2 support is removed, NFSv3 will become
the only "always supported" NFS version.

The defconfigs still need to be updated to remove CONFIG_NFSD_V3=y.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/Kconfig       |  2 +-
 fs/nfsd/Kconfig  | 12 +-----------
 fs/nfsd/Makefile |  3 +--
 fs/nfsd/nfsfh.c  |  4 ----
 fs/nfsd/nfsfh.h  | 20 --------------------
 fs/nfsd/nfssvc.c |  2 --
 fs/nfsd/vfs.c    |  9 ---------
 fs/nfsd/vfs.h    |  2 --
 8 files changed, 3 insertions(+), 51 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 971339ecc1a2b..9ea9614107a48 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -344,7 +344,7 @@ config LOCKD
 
 config LOCKD_V4
 	bool
-	depends on NFSD_V3 || NFS_V3
+	depends on NFSD || NFS_V3
 	depends on FILE_LOCKING
 	default y
 
diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index 6e9ea4ee0f737..b83a6e3bf8080 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -35,18 +35,9 @@ config NFSD_V2_ACL
 	bool
 	depends on NFSD
 
-config NFSD_V3
-	bool "NFS server support for NFS version 3"
-	depends on NFSD
-	help
-	  This option enables support in your system's NFS server for
-	  version 3 of the NFS protocol (RFC 1813).
-
-	  If unsure, say Y.
-
 config NFSD_V3_ACL
 	bool "NFS server support for the NFSv3 ACL protocol extension"
-	depends on NFSD_V3
+	depends on NFSD
 	select NFSD_V2_ACL
 	help
 	  Solaris NFS servers support an auxiliary NFSv3 ACL protocol that
@@ -70,7 +61,6 @@ config NFSD_V3_ACL
 config NFSD_V4
 	bool "NFS server support for NFS version 4"
 	depends on NFSD && PROC_FS
-	select NFSD_V3
 	select FS_POSIX_ACL
 	select SUNRPC_GSS
 	select CRYPTO
diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
index 3f0983e93a998..805c06d5f1b4b 100644
--- a/fs/nfsd/Makefile
+++ b/fs/nfsd/Makefile
@@ -12,9 +12,8 @@ nfsd-y			+= trace.o
 
 nfsd-y 			+= nfssvc.o nfsctl.o nfsproc.o nfsfh.o vfs.o \
 			   export.o auth.o lockd.o nfscache.o nfsxdr.o \
-			   stats.o filecache.o
+			   stats.o filecache.o nfs3proc.o nfs3xdr.o
 nfsd-$(CONFIG_NFSD_V2_ACL) += nfs2acl.o
-nfsd-$(CONFIG_NFSD_V3)	+= nfs3proc.o nfs3xdr.o
 nfsd-$(CONFIG_NFSD_V3_ACL) += nfs3acl.o
 nfsd-$(CONFIG_NFSD_V4)	+= nfs4proc.o nfs4xdr.o nfs4state.o nfs4idmap.o \
 			   nfs4acl.o nfs4callback.o nfs4recover.o
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 145208bcb9bd4..c29baa03dfafd 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -611,8 +611,6 @@ fh_update(struct svc_fh *fhp)
 	return nfserr_serverfault;
 }
 
-#ifdef CONFIG_NFSD_V3
-
 /**
  * fh_fill_pre_attrs - Fill in pre-op attributes
  * @fhp: file handle to be updated
@@ -673,8 +671,6 @@ void fh_fill_post_attrs(struct svc_fh *fhp)
 			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
 }
 
-#endif /* CONFIG_NFSD_V3 */
-
 /*
  * Release a file handle.
  */
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 434930d8a946e..fb9d358a267e5 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -90,7 +90,6 @@ typedef struct svc_fh {
 						 * operation
 						 */
 	int			fh_flags;	/* FH flags */
-#ifdef CONFIG_NFSD_V3
 	bool			fh_post_saved;	/* post-op attrs saved */
 	bool			fh_pre_saved;	/* pre-op attrs saved */
 
@@ -107,7 +106,6 @@ typedef struct svc_fh {
 	/* Post-op attributes saved in fh_unlock */
 	struct kstat		fh_post_attr;	/* full attrs after operation */
 	u64			fh_post_change; /* nfsv4 change; see above */
-#endif /* CONFIG_NFSD_V3 */
 } svc_fh;
 #define NFSD4_FH_FOREIGN (1<<0)
 #define SET_FH_FLAG(c, f) ((c)->fh_flags |= (f))
@@ -283,8 +281,6 @@ static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
 }
 #endif
 
-#ifdef CONFIG_NFSD_V3
-
 /**
  * fh_clear_pre_post_attrs - Reset pre/post attributes
  * @fhp: file handle to be updated
@@ -327,22 +323,6 @@ static inline u64 nfsd4_change_attribute(struct kstat *stat,
 extern void fh_fill_pre_attrs(struct svc_fh *fhp);
 extern void fh_fill_post_attrs(struct svc_fh *fhp);
 
-#else /* !CONFIG_NFSD_V3 */
-
-static inline void fh_clear_pre_post_attrs(struct svc_fh *fhp)
-{
-}
-
-static inline void fh_fill_pre_attrs(struct svc_fh *fhp)
-{
-}
-
-static inline void fh_fill_post_attrs(struct svc_fh *fhp)
-{
-}
-
-#endif /* !CONFIG_NFSD_V3 */
-
 
 /*
  * Lock a file handle/inode
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 2f74be98ff2d9..011c556caa1e7 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -117,9 +117,7 @@ static struct svc_stat	nfsd_acl_svcstats = {
 
 static const struct svc_version *nfsd_version[] = {
 	[2] = &nfsd_version2,
-#if defined(CONFIG_NFSD_V3)
 	[3] = &nfsd_version3,
-#endif
 #if defined(CONFIG_NFSD_V4)
 	[4] = &nfsd_version4,
 #endif
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 4d07a506164b0..00e956bdefaae 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -32,9 +32,7 @@
 #include <linux/writeback.h>
 #include <linux/security.h>
 
-#ifdef CONFIG_NFSD_V3
 #include "xdr3.h"
-#endif /* CONFIG_NFSD_V3 */
 
 #ifdef CONFIG_NFSD_V4
 #include "../internal.h"
@@ -616,7 +614,6 @@ __be32 nfsd4_vfs_fallocate(struct svc_rqst *rqstp, struct svc_fh *fhp,
 }
 #endif /* defined(CONFIG_NFSD_V4) */
 
-#ifdef CONFIG_NFSD_V3
 /*
  * Check server access rights to a file system object
  */
@@ -728,7 +725,6 @@ nfsd_access(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *access, u32 *suppor
  out:
 	return error;
 }
-#endif /* CONFIG_NFSD_V3 */
 
 int nfsd_open_break_lease(struct inode *inode, int access)
 {
@@ -1121,7 +1117,6 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
 	return err;
 }
 
-#ifdef CONFIG_NFSD_V3
 /**
  * nfsd_commit - Commit pending writes to stable storage
  * @rqstp: RPC request being processed
@@ -1199,7 +1194,6 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, u64 offset,
 out:
 	return err;
 }
-#endif /* CONFIG_NFSD_V3 */
 
 static __be32
 nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *resfhp,
@@ -1389,8 +1383,6 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 					rdev, resfhp);
 }
 
-#ifdef CONFIG_NFSD_V3
-
 /*
  * NFSv3 and NFSv4 version of nfsd_create
  */
@@ -1556,7 +1548,6 @@ do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	err = nfserrno(host_err);
 	goto out;
 }
-#endif /* CONFIG_NFSD_V3 */
 
 /*
  * Read a symlink. On entry, *lenp must contain the maximum path length that
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 2c43d10e3cab4..ccb87b2864f64 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -68,7 +68,6 @@ __be32		nfsd_create_locked(struct svc_rqst *, struct svc_fh *,
 __be32		nfsd_create(struct svc_rqst *, struct svc_fh *,
 				char *name, int len, struct iattr *attrs,
 				int type, dev_t rdev, struct svc_fh *res);
-#ifdef CONFIG_NFSD_V3
 __be32		nfsd_access(struct svc_rqst *, struct svc_fh *, u32 *, u32 *);
 __be32		do_nfsd_create(struct svc_rqst *, struct svc_fh *,
 				char *name, int len, struct iattr *attrs,
@@ -76,7 +75,6 @@ __be32		do_nfsd_create(struct svc_rqst *, struct svc_fh *,
 				u32 *verifier, bool *truncp, bool *created);
 __be32		nfsd_commit(struct svc_rqst *rqst, struct svc_fh *fhp,
 				u64 offset, u32 count, __be32 *verf);
-#endif /* CONFIG_NFSD_V3 */
 #ifdef CONFIG_NFSD_V4
 __be32		nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			    char *name, void **bufp, int *lenp);
-- 
2.43.0




