Return-Path: <stable+bounces-94385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C081A9D3C53
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0193B253C7
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 13:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A4B1A76B0;
	Wed, 20 Nov 2024 13:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjYD8gIQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BAD1A0BD6
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107885; cv=none; b=um9vn5JsOvDLZW4/xNKak9+GQ2lLyMAldO5G1dRmLTo9AAMkgfNIQk9oI80PvhUZY23R8I0wHvAKi1cb6+87yTfnRWJ6bHToS+18lIonZOfhGF8jdM54+g3xY71mi/Ofv0qk/cv8aY1xzgTApp6zNytpMmzP8KNBEF2TCbc9tls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107885; c=relaxed/simple;
	bh=Gq3OgpnTmOw9W3Wzm2iG2NY5WM83X/LOuUvL6tswVDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHtv/LWuFG6ANMU6fyChY1WUUy9GGuEUEZ953kSRgRpsIrG61QPiSTnxVedeGeoFXtTJGys+vb9T7qiyWBUPTeoCys5o74jXXt4oAJN1lbRdF91f+5Ns534DS1K/prohYWqJYfB4ntiAeHGtsF7wWyGN8AasZp11zoH1iOEbTdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjYD8gIQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F0DC4CECD;
	Wed, 20 Nov 2024 13:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732107885;
	bh=Gq3OgpnTmOw9W3Wzm2iG2NY5WM83X/LOuUvL6tswVDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DjYD8gIQ+dwSWjGAwqWA7olUvr90SC3N4kTIrxZjqIbkET+wnAy0iHDCfnZhZu84i
	 H9wZnEOr4hogGdrKFF28M/ddCkJHP4PNeK6sWLcF0+s4DhPtegNIre432800j6T/vY
	 0e5lvtNjrtxWcJGZAypOGMVGJiR94FM1BdUcueOoec26pj5YGv+/LzmuCBSclRoHFR
	 TgVwiPfoCCeT9sEBlK92YCYYNBdxziRVh1+MWIcOpINZXWDP8I1YgxSAOWbtPBYLFq
	 9wevEd3rzSWUze97YiszeBq6NkvG9v09dHsHnqRMGj4/zzzjuriKGNmIzZEHtpYm5k
	 wIhTlDHwYQcVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 6.1.y 2/3] null_blk: fix null-ptr-dereference while configuring 'power' and 'submit_queues'
Date: Wed, 20 Nov 2024 08:04:43 -0500
Message-ID: <20241120075007-139c6304cdd13a4f@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241120032841.28236-3-xiangyu.chen@eng.windriver.com>
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
--- -	2024-11-20 07:45:51.467026214 -0500
+++ /tmp/tmp.d9kjHboEiG	2024-11-20 07:45:51.459443624 -0500
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

