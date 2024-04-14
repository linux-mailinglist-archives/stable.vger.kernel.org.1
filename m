Return-Path: <stable+bounces-36590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 860EF89C087
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4292F281CB9
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F916F53D;
	Mon,  8 Apr 2024 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pyBXyRq6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F262E62C;
	Mon,  8 Apr 2024 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581770; cv=none; b=R6ltCYgVtBbaTfNbujZeN9TjBlhm/OIlpl8paNZnvd1PsSiGDJUX1W6bqDa+U3EOjD+5LQFp1zMYx4wz55XFunZKV8BrphnThZkNF3+ZhGsLSRnyMCA8neooaatAQRn65hAKDWwXWlk20nrty0vxeKzL85nkdelMYciYmCjGmWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581770; c=relaxed/simple;
	bh=4XtemMhZkLhNAemwR9EnIKAbcXjU3G4S2srWNHtbTUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzXW7VCllOwsMe0ZJM2o+/Tsgs1v8cNM+BXUy4QSSe5M5aDAvXApNvFD0MyR6B02CCc1A3pg97gMVCGZIN8HCtZDHeSqCEQu5n6IJxBAvRQF+p/8D/dbyHfAx1dPmKOZdC4xBf/9lDzFOH4wSYopT6O/nVZPqpaUfOYpg6nhInk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pyBXyRq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3E6C433C7;
	Mon,  8 Apr 2024 13:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712581770;
	bh=4XtemMhZkLhNAemwR9EnIKAbcXjU3G4S2srWNHtbTUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pyBXyRq6qaKsQ0FPEpuPMtSNRZ2fp8WhLCvtsqef/S/vo5+p8z/wXeYl4HXZANRKv
	 pasAJ181jAsB42ZsmJim/mP9X9ViNOk82cmsAr0PoATqADJ2Et/ExkaYOObzFZmcoh
	 J6ejBBfkilO4asyozb7+vBN8erfTgWVKUDIjMUEw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josef Bacik <josef@toxicpanda.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 081/690] nfs: fix UAF in direct writes
Date: Mon,  8 Apr 2024 14:49:07 +0200
Message-ID: <20240408125402.439173529@linuxfoundation.org>
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
index bbe2a5cc49f68..3185899676adf 100644
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
index 4231d51fc1add..3d06bad2760da 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1644,7 +1644,7 @@ static int wait_on_commit(struct nfs_mds_commit_info *cinfo)
 				       !atomic_read(&cinfo->rpcs_out));
 }
 
-static void nfs_commit_begin(struct nfs_mds_commit_info *cinfo)
+void nfs_commit_begin(struct nfs_mds_commit_info *cinfo)
 {
 	atomic_inc(&cinfo->rpcs_out);
 }
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 5ddc30405f7f4..886bfa99a6af4 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -588,6 +588,7 @@ extern int nfs_wb_page_cancel(struct inode *inode, struct page* page);
 extern int  nfs_commit_inode(struct inode *, int);
 extern struct nfs_commit_data *nfs_commitdata_alloc(void);
 extern void nfs_commit_free(struct nfs_commit_data *data);
+void nfs_commit_begin(struct nfs_mds_commit_info *cinfo);
 bool nfs_commit_end(struct nfs_mds_commit_info *cinfo);
 
 static inline int
-- 
2.43.0




