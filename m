Return-Path: <stable+bounces-95409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6908A9D8915
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 16:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6E828798E
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 15:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D052A1946B9;
	Mon, 25 Nov 2024 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMgnKJ8b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913611A0AF0
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548063; cv=none; b=dbCeDtYHoDI1gn2K4w357fhEuFvGl/OHYTZELRPboSSNoPVgB48+2SB2b6VFxBnjPd1f670tZFodiCmIrUm1vsRrmiKRrHguB63LEigWaKYaXRNzS7mHhmbkTIWYY0kFWP3IRzknRW5VKEfwEbWw7dopZ18KmRNyujc4A2GlDug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548063; c=relaxed/simple;
	bh=H4JdO0vn6ObeZ2sdG9a/XT221SkOJV3pVWTMcvp4dFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYuxpywdONEvdYgkY1QuHqeoLfSHneZKOeWu8Dpz1EuP0hVhpeQULFO3dRe4o/ag1LPmQYhFzwkUOLYk9LkkPvjrvd0ueQX+F+WE9Ye5+opFQu6J5zKlPevbqBTlyIquJCdccYKWKaHDjsG5ikGbCgwpQJJWdkw8IG1KbViJH38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMgnKJ8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2709C4CECE;
	Mon, 25 Nov 2024 15:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732548063;
	bh=H4JdO0vn6ObeZ2sdG9a/XT221SkOJV3pVWTMcvp4dFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sMgnKJ8bzfkil5TUkGgAdkpiZUpzGJVAVN38nc9hgb5r6E9KNUqkF/fNYQ3qGeaDV
	 r3Tl9pJNpB5hhBsSH2R5Wj9dJ0p3/h28sTXW7IvQKFrQYGHCYorpm+dgc5gNny4nul
	 0jlAd5pzz34zIFdwgVX+QMDMYztLqPPfhbk4hLBzRU7Q2HLqNS87lsZHpsm6jauyX+
	 fYiAhkyEswPvSifk0M4Ky05zlercjfgDtsFwiq26afOWoWSlm3SdBMT6HZ5cgYLO//
	 LYVJJ/i3W3UwBj22sC0XDxoO6tIbhn1Zq2TEArtL8y5a8xI8VFuljKSpiw8tlNx3+B
	 eH36u+NqJ9T+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hagar Hemdan <hagarhem@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] nvme: fix metadata handling in nvme-passthrough
Date: Mon, 25 Nov 2024 10:21:01 -0500
Message-ID: <20241125091115-1e5beddb52e92d87@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241125121009.17855-1-hagarhem@amazon.com>
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

Note: The patch differs from the upstream commit:
---
--- -	2024-11-25 09:06:29.684296893 -0500
+++ /tmp/tmp.HYbr9SsqPk	2024-11-25 09:06:29.676688323 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 7c2fd76048e95dd267055b5f5e0a48e6e7c81fd9 ]
+
 On an NVMe namespace that does not support metadata, it is possible to
 send an IO command with metadata through io-passthru. This allows issues
 like [1] to trigger in the completion code path.
@@ -17,29 +19,32 @@
 Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
 Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
 Signed-off-by: Keith Busch <kbusch@kernel.org>
+[ Minor changes to make it work on 6.6 ]
+Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
 ---
- drivers/nvme/host/ioctl.c | 22 ++++++++++++++--------
- 1 file changed, 14 insertions(+), 8 deletions(-)
+ drivers/nvme/host/ioctl.c | 8 +++++++-
+ 1 file changed, 7 insertions(+), 1 deletion(-)
 
 diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
-index 850f81e08e7d8..1d769c842fbf5 100644
+index 875dee6ecd40..19a7f0160618 100644
 --- a/drivers/nvme/host/ioctl.c
 +++ b/drivers/nvme/host/ioctl.c
-@@ -4,6 +4,7 @@
+@@ -3,6 +3,7 @@
+  * Copyright (c) 2011-2014, Intel Corporation.
   * Copyright (c) 2017-2021 Christoph Hellwig.
   */
- #include <linux/bio-integrity.h>
 +#include <linux/blk-integrity.h>
  #include <linux/ptrace.h>	/* for force_successful_syscall_return */
  #include <linux/nvme_ioctl.h>
- #include <linux/io_uring/cmd.h>
-@@ -119,9 +120,14 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
+ #include <linux/io_uring.h>
+@@ -171,10 +172,15 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
  	struct request_queue *q = req->q;
  	struct nvme_ns *ns = q->queuedata;
  	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
 +	bool supports_metadata = bdev && blk_get_integrity(bdev->bd_disk);
 +	bool has_metadata = meta_buffer && meta_len;
  	struct bio *bio = NULL;
+ 	void *meta = NULL;
  	int ret;
  
 +	if (has_metadata && !supports_metadata)
@@ -48,27 +53,15 @@
  	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
  		struct iov_iter iter;
  
-@@ -143,15 +149,15 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
- 		goto out;
- 
- 	bio = req->bio;
--	if (bdev) {
-+	if (bdev)
+@@ -198,7 +204,7 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
+ 	if (bdev)
  		bio_set_dev(bio, bdev);
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
  
- 	return ret;
+-	if (bdev && meta_buffer && meta_len) {
++	if (has_metadata) {
+ 		meta = nvme_add_user_metadata(req, meta_buffer, meta_len,
+ 				meta_seed);
+ 		if (IS_ERR(meta)) {
+-- 
+2.40.1
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

