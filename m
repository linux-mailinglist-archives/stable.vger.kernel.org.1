Return-Path: <stable+bounces-38811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FAF8A1089
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE10F28ADED
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6CB14830D;
	Thu, 11 Apr 2024 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1CxvZw7e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A72014C591;
	Thu, 11 Apr 2024 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831659; cv=none; b=sCNgRu+gynflcNbqeD7mb/t8BAAZNHIhvqCZ0VybHVTs+3QwAtBlY8gMKpoy6GdpitHaiIa9Vl3sTXXpccM8thSPYbHBxIUIvHDphBvcc8OX/4CdGMY65kyHfQTVkClNhH6znVZswtBe5YOrUHXWTWItFwWzP2ue/9JLoxZA9v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831659; c=relaxed/simple;
	bh=LZAxHTXHbQO5PSNeHAdTwZlEqNOkNn/BZDB+xRpbgWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1coMM7A/OmlmH9egHST7Bv+vCeeV1FxmtCQZ5l3CfqCETJfx9BlWXUfetNrI9j+G7UMJ2ooR8P7FvjAc/KFKpEdoW6CJ/Ct0qS0vKlDO9Ps51pThLvDcVaOT0V7+5HJtjfwuwH4rLJ9863EicxOLsQGuXq5VVpzkiL0RVNNXg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1CxvZw7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109C2C43390;
	Thu, 11 Apr 2024 10:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831659;
	bh=LZAxHTXHbQO5PSNeHAdTwZlEqNOkNn/BZDB+xRpbgWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1CxvZw7eJ4Z10m1JztUifHNFevFlzWCVOJYzE3BN915NmLZNWfmniyv1fCOplAp6T
	 vgmG1/P5YZ0ZKFQNxNtPa1Lxi1wYMK3D4Odd3WdTz/MQ+Tj3+HsL0DFFRer7U4cVM/
	 oDMdhu6RlJrWWRygnGDsuWCN7Kw4Rq+gDDHelv9k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josef Bacik <josef@toxicpanda.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 083/294] nfs: fix UAF in direct writes
Date: Thu, 11 Apr 2024 11:54:06 +0200
Message-ID: <20240411095438.184938749@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>
References: <20240411095435.633465671@linuxfoundation.org>
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

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 17f46b803d4f23c66cacce81db35fef3adb8f2af ]

In production we have been hitting the following warning consistently

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 17 PID: 1800359 at lib/refcount.c:28 refcount_warn_saturate+0x9c/0xe0
Workqueue: nfsiod nfs_direct_write_schedule_work [nfs]
RIP: 0010:refcount_warn_saturate+0x9c/0xe0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __warn+0x9f/0x130
 ? refcount_warn_saturate+0x9c/0xe0
 ? report_bug+0xcc/0x150
 ? handle_bug+0x3d/0x70
 ? exc_invalid_op+0x16/0x40
 ? asm_exc_invalid_op+0x16/0x20
 ? refcount_warn_saturate+0x9c/0xe0
 nfs_direct_write_schedule_work+0x237/0x250 [nfs]
 process_one_work+0x12f/0x4a0
 worker_thread+0x14e/0x3b0
 ? ZSTD_getCParams_internal+0x220/0x220
 kthread+0xdc/0x120
 ? __btf_name_valid+0xa0/0xa0
 ret_from_fork+0x1f/0x30

This is because we're completing the nfs_direct_request twice in a row.

The source of this is when we have our commit requests to submit, we
process them and send them off, and then in the completion path for the
commit requests we have

if (nfs_commit_end(cinfo.mds))
	nfs_direct_write_complete(dreq);

However since we're submitting asynchronous requests we sometimes have
one that completes before we submit the next one, so we end up calling
complete on the nfs_direct_request twice.

The only other place we use nfs_generic_commit_list() is in
__nfs_commit_inode, which wraps this call in a

nfs_commit_begin();
nfs_commit_end();

Which is a common pattern for this style of completion handling, one
that is also repeated in the direct code with get_dreq()/put_dreq()
calls around where we process events as well as in the completion paths.

Fix this by using the same pattern for the commit requests.

Before with my 200 node rocksdb stress running this warning would pop
every 10ish minutes.  With my patch the stress test has been running for
several hours without popping.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/direct.c        | 11 +++++++++--
 fs/nfs/write.c         |  2 +-
 include/linux/nfs_fs.h |  1 +
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 5d86ffa72ceab..499519f0f6ecd 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -678,10 +678,17 @@ static void nfs_direct_commit_schedule(struct nfs_direct_req *dreq)
 	LIST_HEAD(mds_list);
 
 	nfs_init_cinfo_from_dreq(&cinfo, dreq);
+	nfs_commit_begin(cinfo.mds);
 	nfs_scan_commit(dreq->inode, &mds_list, &cinfo);
 	res = nfs_generic_commit_list(dreq->inode, &mds_list, 0, &cinfo);
-	if (res < 0) /* res == -ENOMEM */
-		nfs_direct_write_reschedule(dreq);
+	if (res < 0) { /* res == -ENOMEM */
+		spin_lock(&dreq->lock);
+		if (dreq->flags == 0)
+			dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
+		spin_unlock(&dreq->lock);
+	}
+	if (nfs_commit_end(cinfo.mds))
+		nfs_direct_write_complete(dreq);
 }
 
 static void nfs_direct_write_clear_reqs(struct nfs_direct_req *dreq)
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index d3cd099ffb6e1..4cf0606919794 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1637,7 +1637,7 @@ static int wait_on_commit(struct nfs_mds_commit_info *cinfo)
 				       !atomic_read(&cinfo->rpcs_out));
 }
 
-static void nfs_commit_begin(struct nfs_mds_commit_info *cinfo)
+void nfs_commit_begin(struct nfs_mds_commit_info *cinfo)
 {
 	atomic_inc(&cinfo->rpcs_out);
 }
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index e39342945a80b..7488864589a7a 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -553,6 +553,7 @@ extern int nfs_wb_page_cancel(struct inode *inode, struct page* page);
 extern int  nfs_commit_inode(struct inode *, int);
 extern struct nfs_commit_data *nfs_commitdata_alloc(void);
 extern void nfs_commit_free(struct nfs_commit_data *data);
+void nfs_commit_begin(struct nfs_mds_commit_info *cinfo);
 bool nfs_commit_end(struct nfs_mds_commit_info *cinfo);
 
 static inline int
-- 
2.43.0




