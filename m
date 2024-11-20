Return-Path: <stable+bounces-94387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0789D3C3D
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9ED1F25ADE
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 13:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173E21A9B42;
	Wed, 20 Nov 2024 13:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="najRmnP8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AAA1A0BD6
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107889; cv=none; b=YWcX1lSms0Rmx1eQtCM/tIz2zRM0MolpKuRg9ktJC3ukRhJ27/k1R5uiBTGKdtulIbBLzE/henwEzLQlxjPMATgC9QgachkX0Yxup1Mwq7oH7IQiewcuEDbqbIf03rM67/kvFrj0F+2S8vl6lhhaCK8J14k8Vst2g9ERntWhmZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107889; c=relaxed/simple;
	bh=5RaQhiUrgvQ5HsIG3BNpExRZDKxOith1NEn6UOtKkBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQOoc6Kw1tfz86AZumY/uImxPKpnyQfNOm6zjtoKhRRPZUeiGVn6myJMn14CdTxWZ8Wz0UwATVPRPYBnUKSPiKJ0NsisYIHd/Jk8l3JlcfdpbCZU2wD5JcXbDOZ8DNyZAYppWvQ01IpmeV65QOx0vObrcjz5a4mWRtCIMWeNZfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=najRmnP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC151C4CECD;
	Wed, 20 Nov 2024 13:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732107889;
	bh=5RaQhiUrgvQ5HsIG3BNpExRZDKxOith1NEn6UOtKkBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=najRmnP89Vj/Zgv8HI4Kb5Gvh5zRAvOqjv18QjFPjZGTJoKVmbGUBbXpwbTi+Uai0
	 eRhikviwYyvgCgN49PfhHy2WIY1/TU2XTK8Tdf/AuG8c7I7MLCBOVzvI25kRtOgaVw
	 5oXngHVtKy9QixxcVsHlVrQ0Tcn2xGlKrjfDrCyCJ7MlbSLpWiS0LT1tA+QkEhZaTY
	 Q+QPQAXfH9MSs5vt5wD0zxbkEQGxWjeKQgLGZHuEoyKDNBCjVZs1yHq23dHyrq+Yen
	 7Dj0giu8pZXgmZMLuiG12jjSTWstxzos/UHuJEyUhqTF2tr7W7DapiyaBtrIjw3Hnr
	 RejLBkfkNwZtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 6.1.y 1/3] null_blk: Remove usage of the deprecated ida_simple_xx() API
Date: Wed, 20 Nov 2024 08:04:47 -0500
Message-ID: <20241120074550-187de7518df15aa6@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241120032841.28236-2-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 95931a245b44ee04f3359ec432e73614d44d8b38

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


Status in newer kernel trees:
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: b2b02202f87d)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-20 07:40:44.222155724 -0500
+++ /tmp/tmp.aIhRvR57Io	2024-11-20 07:40:44.215907652 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 95931a245b44ee04f3359ec432e73614d44d8b38 ]
+
 ida_alloc() and ida_free() should be preferred to the deprecated
 ida_simple_get() and ida_simple_remove().
 
@@ -6,15 +8,16 @@
 Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
 Link: https://lore.kernel.org/r/bf257b1078475a415cdc3344c6a750842946e367.1705222845.git.christophe.jaillet@wanadoo.fr
 Signed-off-by: Jens Axboe <axboe@kernel.dk>
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
  drivers/block/null_blk/main.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)
 
 diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
-index 9f7695f00c2db..36755f263e8ec 100644
+index 4d78b5583dc6..f58778b57375 100644
 --- a/drivers/block/null_blk/main.c
 +++ b/drivers/block/null_blk/main.c
-@@ -1840,7 +1840,7 @@ static void null_del_dev(struct nullb *nullb)
+@@ -1764,7 +1764,7 @@ static void null_del_dev(struct nullb *nullb)
  
  	dev = nullb->dev;
  
@@ -23,8 +26,8 @@
  
  	list_del_init(&nullb->list);
  
-@@ -2174,7 +2174,7 @@ static int null_add_dev(struct nullb_device *dev)
- 	blk_queue_flag_set(QUEUE_FLAG_NONROT, nullb->q);
+@@ -2103,7 +2103,7 @@ static int null_add_dev(struct nullb_device *dev)
+ 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, nullb->q);
  
  	mutex_lock(&lock);
 -	rv = ida_simple_get(&nullb_indexes, 0, 0, GFP_KERNEL);
@@ -32,3 +35,6 @@
  	if (rv < 0) {
  		mutex_unlock(&lock);
  		goto out_cleanup_zone;
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

