Return-Path: <stable+bounces-137210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ADEAA1252
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29BF23B2A25
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542FA126BF7;
	Tue, 29 Apr 2025 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RwYU48Td"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE46215060;
	Tue, 29 Apr 2025 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945392; cv=none; b=RAG2XUeoJUucLPiRAxL00NLk4vh9fhFVUUEBBSRZGG5iBEgv7J4M9K0I7emVX/SmRz/sKVoA4O601N5kmxGnnKXV4GXlIr8BlCsRkp7fkYE/sX0o7WiHTR8dqrw6yi/831TXiPXTprf2bhaO0L3qYRhTVm315PsksSq4e9aXY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945392; c=relaxed/simple;
	bh=NgGXARZUv0/23C2O4XkRAxnjkXuWlYKb9e0xnBYZLW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hoOEPLiJtvFP99levbH3HgumrV7ooOgzp04IeE22Ua3xJqNLDC3iDiFgdHqXeLMs1VKX/xU/1/0A6hr9IwV+j19OTgqGJwrmNXk6rl/VilKdvdaToWIh4IWzbETvjeoQQKyxQ2clRpZRucWQCk0mFV2gsF883nux1ClC2rjrSjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RwYU48Td; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96135C4CEE3;
	Tue, 29 Apr 2025 16:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745945391;
	bh=NgGXARZUv0/23C2O4XkRAxnjkXuWlYKb9e0xnBYZLW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RwYU48TdOwwul7/vfFKpYSgD6yydP/TTpVgW0TsIqVMs8V3mRx8La0GJtDOFtsmVW
	 syQyspEmrjINMZw99eyJo7cBSTwBInCiTaP9VsNnc09fisljX65I9df1Rcw9Zo1oA7
	 jlm/HG0WgAY3T7tNxQqphEeK6YsjCfbWF/uVj+5w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 097/179] nfs: move nfs_fhandle_hash to common include file
Date: Tue, 29 Apr 2025 18:40:38 +0200
Message-ID: <20250429161053.321027287@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161049.383278312@linuxfoundation.org>
References: <20250429161049.383278312@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit e59fb6749ed833deee5b3cfd7e89925296d41f49 ]

lockd needs to be able to hash filehandles for tracepoints. Move the
nfs_fhandle_hash() helper to a common nfs include file.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: cd35b6cb4664 ("nfs: add missing selections of CONFIG_CRC32")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/internal.h   | 15 ---------------
 include/linux/nfs.h | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index e8b692d41b26e..5c9166357ae7c 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -721,27 +721,12 @@ u64 nfs_timespec_to_change_attr(const struct timespec *ts)
 }
 
 #ifdef CONFIG_CRC32
-/**
- * nfs_fhandle_hash - calculate the crc32 hash for the filehandle
- * @fh - pointer to filehandle
- *
- * returns a crc32 hash for the filehandle that is compatible with
- * the one displayed by "wireshark".
- */
-static inline u32 nfs_fhandle_hash(const struct nfs_fh *fh)
-{
-	return ~crc32_le(0xFFFFFFFF, &fh->data[0], fh->size);
-}
 static inline u32 nfs_stateid_hash(const nfs4_stateid *stateid)
 {
 	return ~crc32_le(0xFFFFFFFF, &stateid->other[0],
 				NFS4_STATEID_OTHER_SIZE);
 }
 #else
-static inline u32 nfs_fhandle_hash(const struct nfs_fh *fh)
-{
-	return 0;
-}
 static inline u32 nfs_stateid_hash(nfs4_stateid *stateid)
 {
 	return 0;
diff --git a/include/linux/nfs.h b/include/linux/nfs.h
index 0dc7ad38a0da4..a8b62a08e784f 100644
--- a/include/linux/nfs.h
+++ b/include/linux/nfs.h
@@ -10,6 +10,7 @@
 
 #include <linux/sunrpc/msg_prot.h>
 #include <linux/string.h>
+#include <linux/crc32.h>
 #include <uapi/linux/nfs.h>
 
 /*
@@ -52,4 +53,23 @@ enum nfs3_stable_how {
 	/* used by direct.c to mark verf as invalid */
 	NFS_INVALID_STABLE_HOW = -1
 };
+
+#ifdef CONFIG_CRC32
+/**
+ * nfs_fhandle_hash - calculate the crc32 hash for the filehandle
+ * @fh - pointer to filehandle
+ *
+ * returns a crc32 hash for the filehandle that is compatible with
+ * the one displayed by "wireshark".
+ */
+static inline u32 nfs_fhandle_hash(const struct nfs_fh *fh)
+{
+	return ~crc32_le(0xFFFFFFFF, &fh->data[0], fh->size);
+}
+#else /* CONFIG_CRC32 */
+static inline u32 nfs_fhandle_hash(const struct nfs_fh *fh)
+{
+	return 0;
+}
+#endif /* CONFIG_CRC32 */
 #endif /* _LINUX_NFS_H */
-- 
2.39.5




