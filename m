Return-Path: <stable+bounces-169941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CED1EB29DDE
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DABD2A49D0
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 09:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708B830DEC8;
	Mon, 18 Aug 2025 09:28:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B6530C366
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.23.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509300; cv=none; b=iWKYMyYhs1mK4j+kBugg4fvs4ErLDNUEhhTpidZrAC4MJ8q7KPkfJOkFuN4Fm5qXF3jfsAny1UzFgts1XMyobcx+i6q/AZ4LKa+oqM6JnlF/zCZ/2wnExH2f3YjLJMWQpMtTOocn8NEpQbHmUbiDlIBFPS7SjEwT89PtyPJYF9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509300; c=relaxed/simple;
	bh=wkxXxM55u6xiafcEX1i5/qPwViPKndBguofdjqgnuic=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EyTJoUrio1CxxxYx9zsf5tPwEsw8RLvQnU9Nh0f9427CQiWLZMqeVYGA9oxAzCeUZgwO3gc4nnnTrgswAyfsdIetmqSoQYpQbnLPY+8maZqXMljL0/Cx0A8+hVkHxyixFWOVnGnWE8/XEOfBCfCx5amt/rrCZSUX0ODNP69S0XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.23.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
	by 156.147.23.51 with ESMTP; 18 Aug 2025 18:28:16 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO localhost.localdomain) (10.178.31.96)
	by 156.147.1.121 with ESMTP; 18 Aug 2025 18:28:16 +0900
X-Original-SENDERIP: 10.178.31.96
X-Original-MAILFROM: chanho.min@lge.com
From: Chanho Min <chanho.min@lge.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@netapp.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chanho Min <chanho.min@lge.com>
Subject: [PATCH] NFS: Fix up commit deadlocks
Date: Mon, 18 Aug 2025 18:28:05 +0900
Message-Id: <20250818092805.38743-1-chanho.min@lge.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 133a48abf6ecc535d7eddc6da1c3e4c972445882 ]

If O_DIRECT bumps the commit_info rpcs_out field, then that could lead
to fsync() hangs. The fix is to ensure that O_DIRECT calls
nfs_commit_end().

Cc: stable@vger.kernel.org # 5.4
Fixes: 723c921e7dfc ("sched/wait, fs/nfs: Convert wait_on_atomic_t() usage to the new wait_var_event() API")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
[ chanho: Backports to v5.4.y ]
Signed-off-by: Chanho Min <chanho.min@lge.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/direct.c        | 2 +-
 fs/nfs/write.c         | 9 ++++++---
 include/linux/nfs_fs.h | 1 +
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 0682037f972be..32dc176ea1aba 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -700,7 +700,7 @@ static void nfs_direct_commit_complete(struct nfs_commit_data *data)
 		nfs_unlock_and_release_request(req);
 	}
 
-	if (atomic_dec_and_test(&cinfo.mds->rpcs_out))
+	if (nfs_commit_end(cinfo.mds))
 		nfs_direct_write_complete(dreq);
 }
 
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 10ce264a64567..c9895316fc070 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1658,10 +1658,13 @@ static void nfs_commit_begin(struct nfs_mds_commit_info *cinfo)
 	atomic_inc(&cinfo->rpcs_out);
 }
 
-static void nfs_commit_end(struct nfs_mds_commit_info *cinfo)
+bool nfs_commit_end(struct nfs_mds_commit_info *cinfo)
 {
-	if (atomic_dec_and_test(&cinfo->rpcs_out))
+	if (atomic_dec_and_test(&cinfo->rpcs_out)) {
 		wake_up_var(&cinfo->rpcs_out);
+		return true;
+	}
+	return false;
 }
 
 void nfs_commitdata_release(struct nfs_commit_data *data)
@@ -1756,6 +1759,7 @@ void nfs_init_commit(struct nfs_commit_data *data,
 	data->res.fattr   = &data->fattr;
 	data->res.verf    = &data->verf;
 	nfs_fattr_init(&data->fattr);
+	nfs_commit_begin(cinfo->mds);
 }
 EXPORT_SYMBOL_GPL(nfs_init_commit);
 
@@ -1801,7 +1805,6 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 
 	/* Set up the argument struct */
 	nfs_init_commit(data, head, NULL, cinfo);
-	atomic_inc(&cinfo->mds->rpcs_out);
 	return nfs_initiate_commit(NFS_CLIENT(inode), data, NFS_PROTO(inode),
 				   data->mds_ops, how, 0);
 }
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 49cf5c855cbe5..a96b116cc9224 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -549,6 +549,7 @@ extern int nfs_wb_page_cancel(struct inode *inode, struct page* page);
 extern int  nfs_commit_inode(struct inode *, int);
 extern struct nfs_commit_data *nfs_commitdata_alloc(bool never_fail);
 extern void nfs_commit_free(struct nfs_commit_data *data);
+bool nfs_commit_end(struct nfs_mds_commit_info *cinfo);
 
 static inline int
 nfs_have_writebacks(struct inode *inode)

