Return-Path: <stable+bounces-138366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 101DBAA17AA
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022B61BC51F8
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB99F21ABC1;
	Tue, 29 Apr 2025 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SV4J/fwZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ABB2517AF;
	Tue, 29 Apr 2025 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949007; cv=none; b=Sye4nYPOfmXJoPXVGxV6NPEunw/C8RdaQAnw0FL5mLNhkl3ZMQNej/kKACU1Ym+9e/2EICCUvLQnsAqeMvSma1dyBKaNnnHt9RtqZUh8lHypm4dLvZ+8LBQBQzjnvZVuq+xeVQUgCoua6sLNrNjM8Eq3qDxACy0LiFe7nRYfWTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949007; c=relaxed/simple;
	bh=MB0tV4c4yw3C5CaRAbtC3+TkPWwIxYtC5BAhGnf6JZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAEyPYsnn4AEqyuB+LGRw7A+jYqao+RWCUzMKwcIxXWM+miUdpXfkWNQrXaCTIkTQCpMDAXCTzp39EQWDkDyzrKoAmuEbFMjtdZ2VR4qKSh/x9pGdBctw+LkxUPRoATx7VjDEavJgdw0Pp/JdY8nI6TZbSEO+v0uEahHWPaxQt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SV4J/fwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4E2C4CEE9;
	Tue, 29 Apr 2025 17:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949007;
	bh=MB0tV4c4yw3C5CaRAbtC3+TkPWwIxYtC5BAhGnf6JZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SV4J/fwZlL3vlVAClqFikd0gSvYyS4T5GoB6RDFaMB3udUkYSwRNtdOiDJnZ6YAQX
	 pgRtoREfohDN1WzzSOH/yecaB5mwoQmWnHFK7v9wS+jZ4DTwNQJtkzusb5U1SlzPnQ
	 284gI1eSoVCPhp6OJjoXN1TS/H7pkTy3X0vVOAiQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 159/373] nfs: move nfs_fhandle_hash to common include file
Date: Tue, 29 Apr 2025 18:40:36 +0200
Message-ID: <20250429161129.682999897@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 692018327b5ff..243d7e69e5115 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -769,27 +769,12 @@ u64 nfs_timespec_to_change_attr(const struct timespec64 *ts)
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
index b06375e88e589..ceb70a926b95e 100644
--- a/include/linux/nfs.h
+++ b/include/linux/nfs.h
@@ -10,6 +10,7 @@
 
 #include <linux/sunrpc/msg_prot.h>
 #include <linux/string.h>
+#include <linux/crc32.h>
 #include <uapi/linux/nfs.h>
 
 /*
@@ -44,4 +45,23 @@ enum nfs3_stable_how {
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




