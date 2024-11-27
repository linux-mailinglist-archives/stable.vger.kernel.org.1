Return-Path: <stable+bounces-95643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 150249DAB8F
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 17:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6042812A0
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 16:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FC5200B83;
	Wed, 27 Nov 2024 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvK3/o6Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9977E288D1
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724119; cv=none; b=o4utAMs2YpoOJwbhLClvgGfBdoVT8jMIgX/jxktodoCR1zHYP5r7goHn45lHhOg/sgfrmzY0j6iPxTfmASyouBpONOfk0031wW9GdzzVJKopx2S6vx+dpwF1sjmYeJziHksrYscp0FRDt03epAoaCjWCGyGJF0+j3NGjv6gquZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724119; c=relaxed/simple;
	bh=5gD0OsgmwyycJNp8tsNRpyx7eJURXZ3mKwfd5mEbQws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvnCSn62Q76Xo9aAB1hzvimEnVxzBAFHKJzB3Di/cBw980cUtW9t/k0P0JuvnEoRGT2lTZw79zsmKsE1KYMvd4UXbkmJ/EqK3kKrz1vr4DGWJCvjaa1+f/MRHDvlVFr2j6ci87HZp3JnIUleJaPp3Fmgn740X9uztYUHpn3EraU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvK3/o6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2620C4CECC;
	Wed, 27 Nov 2024 16:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732724119;
	bh=5gD0OsgmwyycJNp8tsNRpyx7eJURXZ3mKwfd5mEbQws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kvK3/o6QDw5FaxA6Y9NR4Zlj3bRRQqNX5UCvkHvyb4grwYJSxh+wy7uk29xyno9fa
	 LTxctl+N9LtUQ6WxuVDCiN0iJwZZDakNAcHuGPqqiUJB528OBDBx4rCD3W0c8ndDL1
	 N/mFzNGHqY0vJeZM+GGLiMXfpkJaVmT92RXqFLXPcNfP9K5oVhyUsycoZLHdTveGLo
	 IVlq+bOQz+pBIE+Cce93cIJcBl8Epfc2RESR5+8TlDeW1u/wEZ+tMoKyqo3uvOhIWj
	 RDMK8t5eTpYmKDNHpGyRzc4QZIb4d81UAQa9d3zd61N0kCjVB623K5JG43dae5kNpv
	 N6x6IwuJVApGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bin Lan <bin.lan.cn@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] dm: fix a crash if blk_alloc_disk fails
Date: Wed, 27 Nov 2024 11:15:17 -0500
Message-ID: <20241127110426-e70645fe55ffbc36@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241127060354.2695746-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: fed13a5478680614ba97fc87e71f16e2e197912e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Bin Lan <bin.lan.cn@windriver.com>
Commit author: Mikulas Patocka <mpatocka@redhat.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: d7aec2a06730)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-27 09:24:16.233428906 -0500
+++ /tmp/tmp.Jz2z3Kr0Gz	2024-11-27 09:24:16.224663135 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit fed13a5478680614ba97fc87e71f16e2e197912e ]
+
 If blk_alloc_disk fails, the variable md->disk is set to an error value.
 cleanup_mapped_device will see that md->disk is non-NULL and it will
 attempt to access it, causing a crash on this statement
@@ -8,23 +10,27 @@
 Closes: https://marc.info/?l=dm-devel&m=172824125004329&w=2
 Cc: stable@vger.kernel.org
 Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
+Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
 ---
  drivers/md/dm.c | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)
 
 diff --git a/drivers/md/dm.c b/drivers/md/dm.c
-index ff4a6b570b764..19230404d8c2b 100644
+index 5dd0a42463a2..f45427291ea6 100644
 --- a/drivers/md/dm.c
 +++ b/drivers/md/dm.c
-@@ -2290,8 +2290,10 @@ static struct mapped_device *alloc_dev(int minor)
+@@ -2077,8 +2077,10 @@ static struct mapped_device *alloc_dev(int minor)
  	 * override accordingly.
  	 */
- 	md->disk = blk_alloc_disk(NULL, md->numa_node_id);
--	if (IS_ERR(md->disk))
-+	if (IS_ERR(md->disk)) {
+ 	md->disk = blk_alloc_disk(md->numa_node_id);
+-	if (!md->disk)
++	if (!md->disk){
 +		md->disk = NULL;
  		goto bad;
 +	}
  	md->queue = md->disk->queue;
  
  	init_waitqueue_head(&md->wait);
+-- 
+2.34.1
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

