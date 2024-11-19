Return-Path: <stable+bounces-94031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88259D288E
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 320C0B2ADF8
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED461CF5F9;
	Tue, 19 Nov 2024 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljBNctYY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD011CEACB
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027627; cv=none; b=HwlaBM1XD3sR8u6CEeLWIT8aNdKAs8iPrVQdbNUnX4mEL0x2cOqfh1pMxPhtI/qUSCpasLaSqD2gG8VawRvZvs175Bk6MZ40ylvZrlcH6JXqdzymGlq4hL/40Zn8mZTufIKxsPShMaTRiDzkDMmaHKe9t9KQJEAGCqdYSKCa1ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027627; c=relaxed/simple;
	bh=fjylV1LJJEi9tJYf8nZijcWr6fhmlv8CM/os/eua8/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RI+N4rteLuqpGvAXI0JcQ5Fu4Gx0hj3kML4Brdbt8k/XkauB/rrqpYD6A1HQ4362/lR5Qh6y44AKrjoXXfNKXasnLjgnn8yMTM9bd0UYUQX7VZTaQZcrNRDS+0eKKuZobIumZ8gz7I/kD+6Ne9IZDiWNfSaNgj00TWPrc8ZS1Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljBNctYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1CDC4CECF;
	Tue, 19 Nov 2024 14:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732027627;
	bh=fjylV1LJJEi9tJYf8nZijcWr6fhmlv8CM/os/eua8/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ljBNctYYZkVjOEl04mXJow3zt7dl6H6XRnB3EIpafrJ0Af6Uq5gTIM9bcmYPuY5Cb
	 5OhNTze31/OSq7zKz5GR2+JjxZOZUmbaopr/iuuA7jDlUthrbIlxKnjpWDuSVwMdfb
	 Rm7jiRoIJeRY4LtPaw9rgnn2S8mNK7Jd/1JdjX6i814SAT+cwb7dM4WXltxSXqlhdC
	 QqTx8LqXRA15O8NQMQTxh2hKiKIz9nHUWqLcjvAxmDVGiLQmiQc2B2QTssYsLmCpqu
	 wY/9wdVKd1TtLQTU1m/AoauLbcmpZJH59A42ORTzio/gAfkB2hD2wpXSnqOGQtacJW
	 HtXldaxfreF4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 2/2] null_blk: fix null-ptr-dereference while configuring 'power' and 'submit_queues'
Date: Tue, 19 Nov 2024 09:47:05 -0500
Message-ID: <20241119082719.4034054-3-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241119082719.4034054-3-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: a2db328b0839312c169eb42746ec46fc1ab53ed2

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Yu Kuai <yukuai3@huawei.com>


Status in newer kernel trees:
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: aaadb755f2d6)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 07:54:23.312797547 -0500
+++ /tmp/tmp.yAelMilevi	2024-11-19 07:54:23.307193909 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit a2db328b0839312c169eb42746ec46fc1ab53ed2 ]
+
 Writing 'power' and 'submit_queues' concurrently will trigger kernel
 panic:
 
@@ -49,15 +51,17 @@
 Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
 Link: https://lore.kernel.org/r/20240523153934.1937851-1-yukuai1@huaweicloud.com
 Signed-off-by: Jens Axboe <axboe@kernel.dk>
+Signed-off-by: Sasha Levin <sashal@kernel.org>
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
  drivers/block/null_blk/main.c | 40 +++++++++++++++++++++++------------
  1 file changed, 26 insertions(+), 14 deletions(-)
 
 diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
-index 5d56ad4ce01a1..eb023d2673693 100644
+index f58778b57375..e838eed4aacf 100644
 --- a/drivers/block/null_blk/main.c
 +++ b/drivers/block/null_blk/main.c
-@@ -413,13 +413,25 @@ static int nullb_update_nr_hw_queues(struct nullb_device *dev,
+@@ -392,13 +392,25 @@ static int nullb_update_nr_hw_queues(struct nullb_device *dev,
  static int nullb_apply_submit_queues(struct nullb_device *dev,
  				     unsigned int submit_queues)
  {
@@ -85,7 +89,7 @@
  }
  
  NULLB_DEVICE_ATTR(size, ulong, NULL);
-@@ -468,28 +480,31 @@ static ssize_t nullb_device_power_store(struct config_item *item,
+@@ -444,28 +456,31 @@ static ssize_t nullb_device_power_store(struct config_item *item,
  	if (ret < 0)
  		return ret;
  
@@ -122,25 +126,25 @@
  }
  
  CONFIGFS_ATTR(nullb_device_, power);
-@@ -1932,15 +1947,12 @@ static int null_add_dev(struct nullb_device *dev)
- 	nullb->q->queuedata = nullb;
+@@ -2102,15 +2117,12 @@ static int null_add_dev(struct nullb_device *dev)
  	blk_queue_flag_set(QUEUE_FLAG_NONROT, nullb->q);
+ 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, nullb->q);
  
 -	mutex_lock(&lock);
  	rv = ida_alloc(&nullb_indexes, GFP_KERNEL);
 -	if (rv < 0) {
 -		mutex_unlock(&lock);
 +	if (rv < 0)
- 		goto out_cleanup_disk;
+ 		goto out_cleanup_zone;
 -	}
 +
  	nullb->index = rv;
  	dev->index = rv;
 -	mutex_unlock(&lock);
  
- 	if (config_item_name(&dev->group.cg_item)) {
- 		/* Use configfs dir name as the device name */
-@@ -1969,9 +1981,7 @@ static int null_add_dev(struct nullb_device *dev)
+ 	blk_queue_logical_block_size(nullb->q, dev->blocksize);
+ 	blk_queue_physical_block_size(nullb->q, dev->blocksize);
+@@ -2134,9 +2146,7 @@ static int null_add_dev(struct nullb_device *dev)
  	if (rv)
  		goto out_ida_free;
  
@@ -150,7 +154,7 @@
  
  	pr_info("disk %s created\n", nullb->disk_name);
  
-@@ -2020,7 +2030,9 @@ static int null_create_dev(void)
+@@ -2185,7 +2195,9 @@ static int null_create_dev(void)
  	if (!dev)
  		return -ENOMEM;
  
@@ -160,3 +164,6 @@
  	if (ret) {
  		null_free_dev(dev);
  		return ret;
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

