Return-Path: <stable+bounces-77165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99535985986
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3E5284549
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0B21A303F;
	Wed, 25 Sep 2024 11:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEWeEhWi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA73186289;
	Wed, 25 Sep 2024 11:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264361; cv=none; b=D0CRfbVLlG6weWEVpVBhEyWeXzlowZ4gOoRlpeb1ybAZ983Vm/agSbxwE2exl6eXI4YYLqLSskRxgGJfjyFHbkc1AdoFK3rbsoGwz3S8mLXMKKiAX/urC2zlYreZhs0CgPH4KoyBULAfu83RUpvFRcxMd0IXXaoTaMgGzdylTAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264361; c=relaxed/simple;
	bh=t3kZ2mC0WHLQzVHQ7DFGA/qiG5jdhOk8qzbT0y53czo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yu6dbEa8RhneF3mnmm/PGk5AljtVB5U9S/b4RzJY+6GrtYqsoTfMYXzkPkQqS4zmzRZJod11Pl+8msoM5v21001m7kQ6+iLdgIEg9RKacOSeWEgDas4to2DDzQHWPAIjyyMLFqo2FB1qSOnzT/DPvX0rHy6BGmb91hgHjqlZkhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEWeEhWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A2BC4CEC3;
	Wed, 25 Sep 2024 11:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264361;
	bh=t3kZ2mC0WHLQzVHQ7DFGA/qiG5jdhOk8qzbT0y53czo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KEWeEhWioseJNQsV05IVr79un+kUFL2KXKUx7Yh5OPwjEWDiG1ELzngaHzEL2iP7Z
	 FQ8QjiAyKDKTrSLbZD5JQ3PRgEy7+PyjtnI6g6UEhKSNPl2Hfktxcvw4XAwF6ADSRn
	 da1SVfbClH+vnjuMzeEWEq4Y/8z5+Qt/UCd2ig2XdNQUjkeDEb5NWOuLhtaBNF24A4
	 DpmIQhEVAB5y73/m02Q8cQMMj4uJeWUoV6wHsRUaxsjPGllpuRivFJjx/Fift5jpgz
	 pdPb8oLs9kNxSln6HH43uQP1b9w7yAkNKESt46t2UNd0XFlJaEGQxlxvGNDyZiELYd
	 wWHNgg6n4PTZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Puranjay Mohan <pjy@amazon.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 067/244] nvme: fix metadata handling in nvme-passthrough
Date: Wed, 25 Sep 2024 07:24:48 -0400
Message-ID: <20240925113641.1297102-67-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Puranjay Mohan <pjy@amazon.com>

[ Upstream commit 7c2fd76048e95dd267055b5f5e0a48e6e7c81fd9 ]

On an NVMe namespace that does not support metadata, it is possible to
send an IO command with metadata through io-passthru. This allows issues
like [1] to trigger in the completion code path.
nvme_map_user_request() doesn't check if the namespace supports metadata
before sending it forward. It also allows admin commands with metadata to
be processed as it ignores metadata when bdev == NULL and may report
success.

Reject an IO command with metadata when the NVMe namespace doesn't
support it and reject an admin command if it has metadata.

[1] https://lore.kernel.org/all/mb61pcylvnym8.fsf@amazon.com/

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Puranjay Mohan <pjy@amazon.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/ioctl.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index f1d58e70933f5..15c93ce07e263 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2017-2021 Christoph Hellwig.
  */
 #include <linux/bio-integrity.h>
+#include <linux/blk-integrity.h>
 #include <linux/ptrace.h>	/* for force_successful_syscall_return */
 #include <linux/nvme_ioctl.h>
 #include <linux/io_uring/cmd.h>
@@ -119,9 +120,14 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	struct request_queue *q = req->q;
 	struct nvme_ns *ns = q->queuedata;
 	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
+	bool supports_metadata = bdev && blk_get_integrity(bdev->bd_disk);
+	bool has_metadata = meta_buffer && meta_len;
 	struct bio *bio = NULL;
 	int ret;
 
+	if (has_metadata && !supports_metadata)
+		return -EINVAL;
+
 	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		struct iov_iter iter;
 
@@ -143,15 +149,15 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		goto out;
 
 	bio = req->bio;
-	if (bdev) {
+	if (bdev)
 		bio_set_dev(bio, bdev);
-		if (meta_buffer && meta_len) {
-			ret = bio_integrity_map_user(bio, meta_buffer, meta_len,
-						     meta_seed);
-			if (ret)
-				goto out_unmap;
-			req->cmd_flags |= REQ_INTEGRITY;
-		}
+
+	if (has_metadata) {
+		ret = bio_integrity_map_user(bio, meta_buffer, meta_len,
+					     meta_seed);
+		if (ret)
+			goto out_unmap;
+		req->cmd_flags |= REQ_INTEGRITY;
 	}
 
 	return ret;
-- 
2.43.0


