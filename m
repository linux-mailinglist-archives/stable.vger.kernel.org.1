Return-Path: <stable+bounces-136368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD52AA99325
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F115B9223BC
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB063289379;
	Wed, 23 Apr 2025 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RTeh3e8F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9682B289367;
	Wed, 23 Apr 2025 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422362; cv=none; b=i0rog+adV3qOtmJjV1mcuaMeHewMxSf93umJR+Gs3k+rW07hvxkNwzgOCa9bdOKKzeqQc3kYG/DEYE4fZdMQIWdRBj0/tj9qhTnyNBCIUu49+r7j4f3r2zKUXmQxiyeZeppYgXmHFZOAr+fOATLV1QWJ23Kwj4w4qh7XdobfhvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422362; c=relaxed/simple;
	bh=lunaUtI3flMIZkykppOwAPvJ7hT69ShANh9z/svMX2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEF+jh8XJm1Xl5Tdo5Wo0XAtFUv2bV3IwD42LsVpu0NzD26LRtZOjrZ1K5OTQrDicLR5dO5p0JZXV2CTuNZ6Y5eqI8b83dH9RwBWpgqZuwr1IW8t1w3G0KUQVU3t1DhRk4Lyh0f7z0gzLa8mdsgxDoYEre4PAg1eWvTxKpCfXYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RTeh3e8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF03C4CEE2;
	Wed, 23 Apr 2025 15:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745422362;
	bh=lunaUtI3flMIZkykppOwAPvJ7hT69ShANh9z/svMX2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RTeh3e8F1VdWiLjMuj4JGu7v3D2pLIttCTgrLutG4DlrcgH/Yy0mGDPydkaLI4lOh
	 2y/NVVfyq7VbG+q+5gHCng9uHyr6RPu2ZPgD0hETZuXSjLe27Vulwsp9Fbc87mz8Ti
	 ezjrTqMTGGU6b0uWdsXJINV/o6v0tQ44Wweb/q8s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Biggers <ebiggers@google.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 306/393] nfs: add missing selections of CONFIG_CRC32
Date: Wed, 23 Apr 2025 16:43:22 +0200
Message-ID: <20250423142655.973763322@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit cd35b6cb46649750b7dbd0df0e2d767415d8917b ]

nfs.ko, nfsd.ko, and lockd.ko all use crc32_le(), which is available
only when CONFIG_CRC32 is enabled.  But the only NFS kconfig option that
selected CONFIG_CRC32 was CONFIG_NFS_DEBUG, which is client-specific and
did not actually guard the use of crc32_le() even on the client.

The code worked around this bug by only actually calling crc32_le() when
CONFIG_CRC32 is built-in, instead hard-coding '0' in other cases.  This
avoided randconfig build errors, and in real kernels the fallback code
was unlikely to be reached since CONFIG_CRC32 is 'default y'.  But, this
really needs to just be done properly, especially now that I'm planning
to update CONFIG_CRC32 to not be 'default y'.

Therefore, make CONFIG_NFS_FS, CONFIG_NFSD, and CONFIG_LOCKD select
CONFIG_CRC32.  Then remove the fallback code that becomes unnecessary,
as well as the selection of CONFIG_CRC32 from CONFIG_NFS_DEBUG.

Fixes: 1264a2f053a3 ("NFS: refactor code for calculating the crc32 hash of a filehandle")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Acked-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/Kconfig           | 1 +
 fs/nfs/Kconfig       | 2 +-
 fs/nfs/internal.h    | 7 -------
 fs/nfs/nfs4session.h | 4 ----
 fs/nfsd/Kconfig      | 1 +
 fs/nfsd/nfsfh.h      | 7 -------
 include/linux/nfs.h  | 7 -------
 7 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 02a9237807a77..85ae4953f2d7b 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -365,6 +365,7 @@ config GRACE_PERIOD
 config LOCKD
 	tristate
 	depends on FILE_LOCKING
+	select CRC32
 	select GRACE_PERIOD
 
 config LOCKD_V4
diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 7df2503cef6c3..2d99f5e7a686b 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -2,6 +2,7 @@
 config NFS_FS
 	tristate "NFS client support"
 	depends on INET && FILE_LOCKING && MULTIUSER
+	select CRC32
 	select LOCKD
 	select SUNRPC
 	select NFS_ACL_SUPPORT if NFS_V3_ACL
@@ -194,7 +195,6 @@ config NFS_USE_KERNEL_DNS
 config NFS_DEBUG
 	bool
 	depends on NFS_FS && SUNRPC_DEBUG
-	select CRC32
 	default y
 
 config NFS_DISABLE_UDP_SUPPORT
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index a92b234ae0870..ca49d999159eb 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -859,18 +859,11 @@ u64 nfs_timespec_to_change_attr(const struct timespec64 *ts)
 	return ((u64)ts->tv_sec << 30) + ts->tv_nsec;
 }
 
-#ifdef CONFIG_CRC32
 static inline u32 nfs_stateid_hash(const nfs4_stateid *stateid)
 {
 	return ~crc32_le(0xFFFFFFFF, &stateid->other[0],
 				NFS4_STATEID_OTHER_SIZE);
 }
-#else
-static inline u32 nfs_stateid_hash(nfs4_stateid *stateid)
-{
-	return 0;
-}
-#endif
 
 static inline bool nfs_error_is_fatal(int err)
 {
diff --git a/fs/nfs/nfs4session.h b/fs/nfs/nfs4session.h
index 351616c61df54..f9c291e2165cd 100644
--- a/fs/nfs/nfs4session.h
+++ b/fs/nfs/nfs4session.h
@@ -148,16 +148,12 @@ static inline void nfs4_copy_sessionid(struct nfs4_sessionid *dst,
 	memcpy(dst->data, src->data, NFS4_MAX_SESSIONID_LEN);
 }
 
-#ifdef CONFIG_CRC32
 /*
  * nfs_session_id_hash - calculate the crc32 hash for the session id
  * @session - pointer to session
  */
 #define nfs_session_id_hash(sess_id) \
 	(~crc32_le(0xFFFFFFFF, &(sess_id)->data[0], sizeof((sess_id)->data)))
-#else
-#define nfs_session_id_hash(session) (0)
-#endif
 #else /* defined(CONFIG_NFS_V4_1) */
 
 static inline int nfs4_init_session(struct nfs_client *clp)
diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index 43b88eaf0673a..05c10f70456cc 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -4,6 +4,7 @@ config NFSD
 	depends on INET
 	depends on FILE_LOCKING
 	depends on FSNOTIFY
+	select CRC32
 	select LOCKD
 	select SUNRPC
 	select EXPORTFS
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 40426f899e760..f1420d3510d2e 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -263,7 +263,6 @@ static inline bool fh_fsid_match(const struct knfsd_fh *fh1,
 	return true;
 }
 
-#ifdef CONFIG_CRC32
 /**
  * knfsd_fh_hash - calculate the crc32 hash for the filehandle
  * @fh - pointer to filehandle
@@ -275,12 +274,6 @@ static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
 {
 	return ~crc32_le(0xFFFFFFFF, fh->fh_raw, fh->fh_size);
 }
-#else
-static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
-{
-	return 0;
-}
-#endif
 
 /**
  * fh_clear_pre_post_attrs - Reset pre/post attributes
diff --git a/include/linux/nfs.h b/include/linux/nfs.h
index ceb70a926b95e..095a95c1fae82 100644
--- a/include/linux/nfs.h
+++ b/include/linux/nfs.h
@@ -46,7 +46,6 @@ enum nfs3_stable_how {
 	NFS_INVALID_STABLE_HOW = -1
 };
 
-#ifdef CONFIG_CRC32
 /**
  * nfs_fhandle_hash - calculate the crc32 hash for the filehandle
  * @fh - pointer to filehandle
@@ -58,10 +57,4 @@ static inline u32 nfs_fhandle_hash(const struct nfs_fh *fh)
 {
 	return ~crc32_le(0xFFFFFFFF, &fh->data[0], fh->size);
 }
-#else /* CONFIG_CRC32 */
-static inline u32 nfs_fhandle_hash(const struct nfs_fh *fh)
-{
-	return 0;
-}
-#endif /* CONFIG_CRC32 */
 #endif /* _LINUX_NFS_H */
-- 
2.39.5




