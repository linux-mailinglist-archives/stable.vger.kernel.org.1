Return-Path: <stable+bounces-2206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8007F8336
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02EBA28765A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B16364C1;
	Fri, 24 Nov 2023 19:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gI85qag+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455202E853;
	Fri, 24 Nov 2023 19:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6EEC433C8;
	Fri, 24 Nov 2023 19:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853313;
	bh=U+nT6abLimyrYx9zYGt+u/1/NkqDmX8UD4i83qy0SDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gI85qag+B5w4p+WCN+jB6A87nKaGq9K67Kf3A3NOURe1ghOWs/VItMQ+3R/0lnEkD
	 /ZttLq5cUsd8VkxrS+YeW97JBc9vkpPcyKE8YczLen1eeNrlNahkDHs++XcKEWYIIf
	 5kwNWnkeve3xvM1vwuSiBH+uRZRrd0zGAtB0UuRI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Dave Chinner <dchinner@redhat.com>,
	Dave Chinner <david@fromorbit.com>,
	Leah Rumancik <leah.rumancik@gmail.com>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 139/297] xfs: refactor buffer cancellation table allocation
Date: Fri, 24 Nov 2023 17:53:01 +0000
Message-ID: <20231124172005.127469527@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
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

From: Darrick J. Wong <djwong@kernel.org>

[ Upstream commit 2723234923b3294dbcf6019c288c87465e927ed4 ]

Move the code that allocates and frees the buffer cancellation tables
used by log recovery into the file that actually uses the tables.  This
is a precursor to some cleanups and a memory leak fix.

( backport: dependency of 8db074bd84df5ccc88bff3f8f900f66f4b8349fa )

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_log_recover.h | 14 +++++-----
 fs/xfs/xfs_buf_item_recover.c   | 47 +++++++++++++++++++++++++++++++++
 fs/xfs/xfs_log_priv.h           |  3 ---
 fs/xfs/xfs_log_recover.c        | 32 +++++++---------------
 4 files changed, 64 insertions(+), 32 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_log_recover.h b/fs/xfs/libxfs/xfs_log_recover.h
index ff69a00008176..b8b65a6e9b1ec 100644
--- a/fs/xfs/libxfs/xfs_log_recover.h
+++ b/fs/xfs/libxfs/xfs_log_recover.h
@@ -108,12 +108,6 @@ struct xlog_recover {
 
 #define ITEM_TYPE(i)	(*(unsigned short *)(i)->ri_buf[0].i_addr)
 
-/*
- * This is the number of entries in the l_buf_cancel_table used during
- * recovery.
- */
-#define	XLOG_BC_TABLE_SIZE	64
-
 #define	XLOG_RECOVER_CRCPASS	0
 #define	XLOG_RECOVER_PASS1	1
 #define	XLOG_RECOVER_PASS2	2
@@ -126,5 +120,13 @@ int xlog_recover_iget(struct xfs_mount *mp, xfs_ino_t ino,
 		struct xfs_inode **ipp);
 void xlog_recover_release_intent(struct xlog *log, unsigned short intent_type,
 		uint64_t intent_id);
+void xlog_alloc_buf_cancel_table(struct xlog *log);
+void xlog_free_buf_cancel_table(struct xlog *log);
+
+#ifdef DEBUG
+void xlog_check_buf_cancel_table(struct xlog *log);
+#else
+#define xlog_check_buf_cancel_table(log) do { } while (0)
+#endif
 
 #endif	/* __XFS_LOG_RECOVER_H__ */
diff --git a/fs/xfs/xfs_buf_item_recover.c b/fs/xfs/xfs_buf_item_recover.c
index e04e44ef14c6d..dc099b2f4984c 100644
--- a/fs/xfs/xfs_buf_item_recover.c
+++ b/fs/xfs/xfs_buf_item_recover.c
@@ -23,6 +23,15 @@
 #include "xfs_dir2.h"
 #include "xfs_quota.h"
 
+/*
+ * This is the number of entries in the l_buf_cancel_table used during
+ * recovery.
+ */
+#define	XLOG_BC_TABLE_SIZE	64
+
+#define XLOG_BUF_CANCEL_BUCKET(log, blkno) \
+	((log)->l_buf_cancel_table + ((uint64_t)blkno % XLOG_BC_TABLE_SIZE))
+
 /*
  * This structure is used during recovery to record the buf log items which
  * have been canceled and should not be replayed.
@@ -1003,3 +1012,41 @@ const struct xlog_recover_item_ops xlog_buf_item_ops = {
 	.commit_pass1		= xlog_recover_buf_commit_pass1,
 	.commit_pass2		= xlog_recover_buf_commit_pass2,
 };
+
+#ifdef DEBUG
+void
+xlog_check_buf_cancel_table(
+	struct xlog	*log)
+{
+	int		i;
+
+	for (i = 0; i < XLOG_BC_TABLE_SIZE; i++)
+		ASSERT(list_empty(&log->l_buf_cancel_table[i]));
+}
+#endif
+
+void
+xlog_alloc_buf_cancel_table(
+	struct xlog	*log)
+{
+	int		i;
+
+	ASSERT(log->l_buf_cancel_table == NULL);
+
+	log->l_buf_cancel_table = kmem_zalloc(XLOG_BC_TABLE_SIZE *
+						 sizeof(struct list_head),
+						 0);
+	for (i = 0; i < XLOG_BC_TABLE_SIZE; i++)
+		INIT_LIST_HEAD(&log->l_buf_cancel_table[i]);
+}
+
+void
+xlog_free_buf_cancel_table(
+	struct xlog	*log)
+{
+	if (!log->l_buf_cancel_table)
+		return;
+
+	kmem_free(log->l_buf_cancel_table);
+	log->l_buf_cancel_table = NULL;
+}
diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index f3d68ca39f45c..03393595676f4 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -454,9 +454,6 @@ struct xlog {
 	struct rw_semaphore	l_incompat_users;
 };
 
-#define XLOG_BUF_CANCEL_BUCKET(log, blkno) \
-	((log)->l_buf_cancel_table + ((uint64_t)blkno % XLOG_BC_TABLE_SIZE))
-
 /*
  * Bits for operational state
  */
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 581aeb288b32b..18d8eebc2d445 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -3248,7 +3248,7 @@ xlog_do_log_recovery(
 	xfs_daddr_t	head_blk,
 	xfs_daddr_t	tail_blk)
 {
-	int		error, i;
+	int		error;
 
 	ASSERT(head_blk != tail_blk);
 
@@ -3256,37 +3256,23 @@ xlog_do_log_recovery(
 	 * First do a pass to find all of the cancelled buf log items.
 	 * Store them in the buf_cancel_table for use in the second pass.
 	 */
-	log->l_buf_cancel_table = kmem_zalloc(XLOG_BC_TABLE_SIZE *
-						 sizeof(struct list_head),
-						 0);
-	for (i = 0; i < XLOG_BC_TABLE_SIZE; i++)
-		INIT_LIST_HEAD(&log->l_buf_cancel_table[i]);
+	xlog_alloc_buf_cancel_table(log);
 
 	error = xlog_do_recovery_pass(log, head_blk, tail_blk,
 				      XLOG_RECOVER_PASS1, NULL);
-	if (error != 0) {
-		kmem_free(log->l_buf_cancel_table);
-		log->l_buf_cancel_table = NULL;
-		return error;
-	}
+	if (error != 0)
+		goto out_cancel;
+
 	/*
 	 * Then do a second pass to actually recover the items in the log.
 	 * When it is complete free the table of buf cancel items.
 	 */
 	error = xlog_do_recovery_pass(log, head_blk, tail_blk,
 				      XLOG_RECOVER_PASS2, NULL);
-#ifdef DEBUG
-	if (!error) {
-		int	i;
-
-		for (i = 0; i < XLOG_BC_TABLE_SIZE; i++)
-			ASSERT(list_empty(&log->l_buf_cancel_table[i]));
-	}
-#endif	/* DEBUG */
-
-	kmem_free(log->l_buf_cancel_table);
-	log->l_buf_cancel_table = NULL;
-
+	if (!error)
+		xlog_check_buf_cancel_table(log);
+out_cancel:
+	xlog_free_buf_cancel_table(log);
 	return error;
 }
 
-- 
2.42.0




