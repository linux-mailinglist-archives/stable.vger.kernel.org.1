Return-Path: <stable+bounces-95405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CD19D89EC
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 17:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78030B35EF7
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 15:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967391A0AF0;
	Mon, 25 Nov 2024 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W46bbe0t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B68171CD
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548055; cv=none; b=ZYF+z2BOKD6H5xkfP2RL7gQiExmRx9+D/fmrmBb5lUU8exKAmYvhOridI/piS9rk5ZtmzZAJ0IgyUYjKrftfBhT9IPgow46hfzpkM+8aPVnUR1KbgRh+73TbkVWxBCeVfCE+Ey812jASu5/gwuYdIP1fo9Q7FBeabwLDyWMBvnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548055; c=relaxed/simple;
	bh=4rf8QBCKithi+ZXSHktBS9Ztvq5S63Q2UkPeoq5QBgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUgPEbHtpM4TPbaknuR66nyLTdxi93ggAIlEJ0r2BS4bZ+fr/21sNvIalK2vnn43G6hFayRlPvt/cc94j3Ib/5GwCeeg24pWrL3N3pVK3OigwX3j3ygAf7UELpMZX6X5e8jjfnZxuMCjSERL96Akj4LtvT/ETDTKxaoQNImIu4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W46bbe0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE61FC4CECE;
	Mon, 25 Nov 2024 15:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732548055;
	bh=4rf8QBCKithi+ZXSHktBS9Ztvq5S63Q2UkPeoq5QBgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W46bbe0tVBOubGjwYVr5Q+y+5v3A4iK9w6E6niOuOX5No3Yyiax9iJ1Z5U8SZLab6
	 WZqv+zZZfV5t0cVjzjt6oGM49oCRdxulOwMlnPtr5Ir1Vkz4GCY8F1+nhziXhQIgSb
	 OjfzW8+jEXzKCBR5xVX9tWP+XWzg4MCZWT8j9Npx6XfMcqnas0UZRd0CGNJJzS+vyd
	 d2f7oSor5np6ylyQlSu2b3UQs9+gl6Q4ZkZ4W3gEHrqB7JBrrAqGrNsJ0eFXwWUosZ
	 6iQy8K18Oy5gtgedodWoU9AmWMaSk1OjNBHZnNLcNw+ymDjfvznIK8PoMIeFV31Fqt
	 M/u5wLJfkhsug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hagar Hemdan <hagarhem@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15] nvme: fix metadata handling in nvme-passthrough
Date: Mon, 25 Nov 2024 10:20:53 -0500
Message-ID: <20241125093357-74d00b123736e0f6@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241125121009.17855-3-hagarhem@amazon.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 7c2fd76048e95dd267055b5f5e0a48e6e7c81fd9

WARNING: Author mismatch between patch and upstream commit:
Backport author: Hagar Hemdan <hagarhem@amazon.com>
Commit author: Puranjay Mohan <pjy@amazon.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: dc522d2bc1d0)
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-25 09:29:38.258591926 -0500
+++ /tmp/tmp.0u02oo9u0B	2024-11-25 09:29:38.252792033 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 7c2fd76048e95dd267055b5f5e0a48e6e7c81fd9 ]
+
 On an NVMe namespace that does not support metadata, it is possible to
 send an IO command with metadata through io-passthru. This allows issues
 like [1] to trigger in the completion code path.
@@ -17,58 +19,43 @@
 Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
 Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
 Signed-off-by: Keith Busch <kbusch@kernel.org>
+[ Move the changes from nvme_map_user_request() to nvme_submit_user_cmd()
+  to make it work on 5.15 ]
+Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
 ---
- drivers/nvme/host/ioctl.c | 22 ++++++++++++++--------
- 1 file changed, 14 insertions(+), 8 deletions(-)
+ drivers/nvme/host/ioctl.c | 7 ++++++-
+ 1 file changed, 6 insertions(+), 1 deletion(-)
 
 diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
-index 850f81e08e7d8..1d769c842fbf5 100644
+index 7397fad4c96f..22ff0e617b8f 100644
 --- a/drivers/nvme/host/ioctl.c
 +++ b/drivers/nvme/host/ioctl.c
-@@ -4,6 +4,7 @@
-  * Copyright (c) 2017-2021 Christoph Hellwig.
-  */
- #include <linux/bio-integrity.h>
-+#include <linux/blk-integrity.h>
- #include <linux/ptrace.h>	/* for force_successful_syscall_return */
- #include <linux/nvme_ioctl.h>
- #include <linux/io_uring/cmd.h>
-@@ -119,9 +120,14 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
- 	struct request_queue *q = req->q;
+@@ -61,11 +61,16 @@ static int nvme_submit_user_cmd(struct request_queue *q,
+ 	bool write = nvme_is_write(cmd);
  	struct nvme_ns *ns = q->queuedata;
  	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
 +	bool supports_metadata = bdev && blk_get_integrity(bdev->bd_disk);
 +	bool has_metadata = meta_buffer && meta_len;
+ 	struct request *req;
  	struct bio *bio = NULL;
+ 	void *meta = NULL;
  	int ret;
  
 +	if (has_metadata && !supports_metadata)
-+		return -EINVAL;
-+
- 	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
- 		struct iov_iter iter;
- 
-@@ -143,15 +149,15 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
- 		goto out;
- 
- 	bio = req->bio;
--	if (bdev) {
-+	if (bdev)
- 		bio_set_dev(bio, bdev);
--		if (meta_buffer && meta_len) {
--			ret = bio_integrity_map_user(bio, meta_buffer, meta_len,
--						     meta_seed);
--			if (ret)
--				goto out_unmap;
--			req->cmd_flags |= REQ_INTEGRITY;
--		}
++			return -EINVAL;
 +
-+	if (has_metadata) {
-+		ret = bio_integrity_map_user(bio, meta_buffer, meta_len,
-+					     meta_seed);
-+		if (ret)
-+			goto out_unmap;
-+		req->cmd_flags |= REQ_INTEGRITY;
- 	}
- 
- 	return ret;
+ 	req = nvme_alloc_request(q, cmd, 0);
+ 	if (IS_ERR(req))
+ 		return PTR_ERR(req);
+@@ -82,7 +87,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
+ 		bio = req->bio;
+ 		if (bdev)
+ 			bio_set_dev(bio, bdev);
+-		if (bdev && meta_buffer && meta_len) {
++		if (has_metadata) {
+ 			meta = nvme_add_user_metadata(bio, meta_buffer, meta_len,
+ 					meta_seed, write);
+ 			if (IS_ERR(meta)) {
+-- 
+2.40.1
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

