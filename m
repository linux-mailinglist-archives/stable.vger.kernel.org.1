Return-Path: <stable+bounces-135744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AB1A99041
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F091B87CE9
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D66F28CF5A;
	Wed, 23 Apr 2025 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hlj4m+XN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD6F266B4B;
	Wed, 23 Apr 2025 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420730; cv=none; b=lBEYQajbfibod1Owa/JRBhSMBI8jcXDDIB8LOi0Yzx5CI9m1k/3rCImh0z1mqhoIl77nsrR9Dna7tyQ67Em7eNAqT3i6TI2v0FdlFsf6Zw2Z2VHycgCe0eBM2iovDIDqho5SeK+fhjJiH6MZpgUTow5L2ysDTN+pz6WGlrokD2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420730; c=relaxed/simple;
	bh=V4JJbyn4KCUxBsV89MP/7VfjmILy7/+3YYQcaZJIwEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNVASFvg78wO9ToQmQVTRwRmTaDOHdJw6V2dseaZiBj9H0TGuG+zFyhmOX96qIM5v2MskzqmYESXRneG2v1LgLPUog/Y3mXX4xWDScFJdUzX+vweHE+S/v+jxf2kxl0eN+kshyVpJh7C1rvT64xbIP+5foYDyH9oNTIeoqPdfLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hlj4m+XN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A9FC4CEE2;
	Wed, 23 Apr 2025 15:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745420729;
	bh=V4JJbyn4KCUxBsV89MP/7VfjmILy7/+3YYQcaZJIwEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hlj4m+XN2fHqCY8TQcHkyPPXl3l+8gK1xM7vaZp1DyZhTODVvPKlNSQFtFoGBn8Nd
	 pgyq2JGvm3btRD5HhoVVCyezBDnr26bL40C2kwEzeCwy5FebwoVuD5ZT6CMJM1am1a
	 n674oXyg/Kj7LGVE35BAp1qOtGSuB+uc8NHQisqs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Biggers <ebiggers@google.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 117/241] nfs: add missing selections of CONFIG_CRC32
Date: Wed, 23 Apr 2025 16:43:01 +0200
Message-ID: <20250423142625.363551465@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142620.525425242@linuxfoundation.org>
References: <20250423142620.525425242@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

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
index 64d420e3c4758..8fd1011f7d628 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -368,6 +368,7 @@ config GRACE_PERIOD
 config LOCKD
 	tristate
 	depends on FILE_LOCKING
+	select CRC32
 	select GRACE_PERIOD
 
 config LOCKD_V4
diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index d3f76101ad4b9..07932ce9246c1 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -2,6 +2,7 @@
 config NFS_FS
 	tristate "NFS client support"
 	depends on INET && FILE_LOCKING && MULTIUSER
+	select CRC32
 	select LOCKD
 	select SUNRPC
 	select NFS_COMMON
@@ -196,7 +197,6 @@ config NFS_USE_KERNEL_DNS
 config NFS_DEBUG
 	bool
 	depends on NFS_FS && SUNRPC_DEBUG
-	select CRC32
 	default y
 
 config NFS_DISABLE_UDP_SUPPORT
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index fae2c7ae4acc2..59bb4d0338f39 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -899,18 +899,11 @@ u64 nfs_timespec_to_change_attr(const struct timespec64 *ts)
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
index 792d3fed1b45f..731a88f6313eb 100644
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
index 876152a91f122..5103c2f4d2253 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -267,7 +267,6 @@ static inline bool fh_fsid_match(const struct knfsd_fh *fh1,
 	return true;
 }
 
-#ifdef CONFIG_CRC32
 /**
  * knfsd_fh_hash - calculate the crc32 hash for the filehandle
  * @fh - pointer to filehandle
@@ -279,12 +278,6 @@ static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
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
index 9ad727ddfedb3..0906a0b40c6aa 100644
--- a/include/linux/nfs.h
+++ b/include/linux/nfs.h
@@ -55,7 +55,6 @@ enum nfs3_stable_how {
 	NFS_INVALID_STABLE_HOW = -1
 };
 
-#ifdef CONFIG_CRC32
 /**
  * nfs_fhandle_hash - calculate the crc32 hash for the filehandle
  * @fh - pointer to filehandle
@@ -67,10 +66,4 @@ static inline u32 nfs_fhandle_hash(const struct nfs_fh *fh)
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




