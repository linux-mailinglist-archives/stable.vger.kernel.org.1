Return-Path: <stable+bounces-94023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4A29D288D
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CEE9B2A5E7
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718CC1CC8AB;
	Tue, 19 Nov 2024 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHGbe29K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A291C4608
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027611; cv=none; b=DOj3c42GX3ndC5dsikZGFugej6Oe59L0bhx8p2j/W0vo6c+OGf0tUfXDR+AU4jQHuGwGjGsHTQwnOWwqxda5naawlMmbxnvRVtEShmMfDHFVPSJ/TE+KnYvoeusSgRVCjai7p+VM1R1zWI6DPop+4wI6WGyHXWnzc5y9/ntfo1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027611; c=relaxed/simple;
	bh=LgNCR3YUpbCxbr5+iDU7xCGz4oENUqXhLWsjCTpMOK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXHVFtCo7fzmKdlD+zTlKQ9Whh8QDg0OxUdmT9dx79EmP+ZVf/aP2pP0V4I95sMrHTIQq/vuPlgQJowWS+lWj2UkgkdVHQrIMry/VcvsVBKGk7Pq4olNPldN/BtxOR+wxzM8GbeU8+Z4EiuQy8sw1c4SgBObMTb7l+YSCLfgYOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHGbe29K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C72C4CECF;
	Tue, 19 Nov 2024 14:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732027611;
	bh=LgNCR3YUpbCxbr5+iDU7xCGz4oENUqXhLWsjCTpMOK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KHGbe29KEHiLFA1lXJAnQWI9NLJ2HNKuXuloTlK9ImnhyLcTjhfUweXpYybWG343m
	 sQ6WELF9MD1c7XNjFGcLw69V398IZRAn66Svk9saI9IvXA1tsCAuRKbNg8wbbElWM5
	 GjBIrj+EKWR5FOqxtEagmpDoAW3Pw8kPgCLTcNH4zbO1RbkGidFcIuVcd6ACu+/4cg
	 XCyepou6uBBebk9bnyuPwfCjXRF9kIOnCvUI8RziYD0m1ivVJ4xn1OfvDFOqyAeaRZ
	 Y7ZXhYu7P7rxB4COP8WwQLI7jD3xYJjbbXxnAWxo3YYm1JGWnoTbv1xdWj9dRlevCs
	 YSQECBN/PG7Bw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 1/2] null_blk: Remove usage of the deprecated ida_simple_xx() API
Date: Tue, 19 Nov 2024 09:46:49 -0500
Message-ID: <20241119082719.4034054-2-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241119082719.4034054-2-xiangyu.chen@eng.windriver.com>
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
--- -	2024-11-19 07:44:28.325681660 -0500
+++ /tmp/tmp.6gBkpSJI36	2024-11-19 07:44:28.319958074 -0500
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

