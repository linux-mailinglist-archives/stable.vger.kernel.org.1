Return-Path: <stable+bounces-95420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF459D89F8
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 17:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04532854AB
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 16:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058391B4144;
	Mon, 25 Nov 2024 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QImu4VOJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90D12500D2
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732551053; cv=none; b=swE6LftJQtifFs01aYkSj804BXjcJq7xUZqIMFXJEUkRs3vinBGXoNBGd7hdPFDTNgE0LpjtTMKnSw0b0QUSbNwYvSbdvuIPOPW068xQIUN2xmkQItdWlBK7+6/Ngv9OxnBMOXrV6PUPcsMJ0F52NuHnuN+Q1Ux5v0nMC1tj6JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732551053; c=relaxed/simple;
	bh=TA4doo2AXg8dLnBPcQsK7KAGivF3rTE2xMpZE/BQbKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXP5H1CErdcjacsGp2Iiy7F2rrPBZkAw8yslvIbH2Uva0Mo3RW+5pHz0B4W8eQwJ83eJyzxhkwOcvniWM84wDqee2Kjq1C6bac1P6BlIUciTNcBsjYLUNE9U3pOnWXDyYpXsDmLKsHH5tY4ELjSZgihYNzK5F1G+Q6Q+B/C1FCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QImu4VOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46FEC4CECE;
	Mon, 25 Nov 2024 16:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732551053;
	bh=TA4doo2AXg8dLnBPcQsK7KAGivF3rTE2xMpZE/BQbKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QImu4VOJ5rU6eC1igkiftsKr0s2/fGjBEhARs8x5gLL0QszVkw4ho9yk2FfAjdGlM
	 YBeyOBVGgfnZdKuFwm/ZmoB61VSb5Y1elR2MdihmxI8fj4ZAbAiK+a6fGpY0+ntGKS
	 Qkh8pJsfIONfHEG+zUqnKiqM0nx+mNCH0chr3brCEL91VsWhwrZkS4cS8IfCYh6kTA
	 U7IwBqdB0bJej/qQiWq/TyOCfltVc4yOsNmXsWN6WxWLNYRIzZfYj65aUX3V0F42p7
	 xS5hY8s81969ErWr9RFgxzEt7+FMYRCwCyfcSb2EElvgqdzTQdOP2PtDI2sGCqOS6P
	 oNsQ5toWQeT3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hagar Hemdan <hagarhem@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4] nvme: fix metadata handling in nvme-passthrough
Date: Mon, 25 Nov 2024 11:10:51 -0500
Message-ID: <20241125103237-56c51e72f46ec086@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241125135334.3822-1-hagarhem@amazon.com>
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
5.10.y | Not found
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-25 10:29:11.090159886 -0500
+++ /tmp/tmp.n0e8JIvoqt	2024-11-25 10:29:11.084066265 -0500
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
+  to make it work on 5.4 ]
+Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
 ---
- drivers/nvme/host/ioctl.c | 22 ++++++++++++++--------
- 1 file changed, 14 insertions(+), 8 deletions(-)
+ drivers/nvme/host/core.c | 7 ++++++-
+ 1 file changed, 6 insertions(+), 1 deletion(-)
 
-diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
-index 850f81e08e7d8..1d769c842fbf5 100644
---- a/drivers/nvme/host/ioctl.c
-+++ b/drivers/nvme/host/ioctl.c
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
+diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
+index 0676637e1eab..a841fd4929ad 100644
+--- a/drivers/nvme/host/core.c
++++ b/drivers/nvme/host/core.c
+@@ -921,11 +921,16 @@ static int nvme_submit_user_cmd(struct request_queue *q,
+ 	bool write = nvme_is_write(cmd);
  	struct nvme_ns *ns = q->queuedata;
- 	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
-+	bool supports_metadata = bdev && blk_get_integrity(bdev->bd_disk);
+ 	struct gendisk *disk = ns ? ns->disk : NULL;
++	bool supports_metadata = disk && blk_get_integrity(disk);
 +	bool has_metadata = meta_buffer && meta_len;
+ 	struct request *req;
  	struct bio *bio = NULL;
+ 	void *meta = NULL;
  	int ret;
  
 +	if (has_metadata && !supports_metadata)
 +		return -EINVAL;
 +
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
-+
-+	if (has_metadata) {
-+		ret = bio_integrity_map_user(bio, meta_buffer, meta_len,
-+					     meta_seed);
-+		if (ret)
-+			goto out_unmap;
-+		req->cmd_flags |= REQ_INTEGRITY;
- 	}
- 
- 	return ret;
+ 	req = nvme_alloc_request(q, cmd, 0, NVME_QID_ANY);
+ 	if (IS_ERR(req))
+ 		return PTR_ERR(req);
+@@ -940,7 +945,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
+ 			goto out;
+ 		bio = req->bio;
+ 		bio->bi_disk = disk;
+-		if (disk && meta_buffer && meta_len) {
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
| stable/linux-5.4.y        |  Success    |  Success   |

