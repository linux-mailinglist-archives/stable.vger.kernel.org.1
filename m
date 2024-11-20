Return-Path: <stable+bounces-94386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890A89D3C5D
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 781ADB2CC8C
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 13:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5931A7AF5;
	Wed, 20 Nov 2024 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dN1lJj90"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40801A0BD6
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107887; cv=none; b=d0ld8EFKez6FplxNafKvtwGNgs0CE2QcK28wPnbxIxAdOu/DVamFiMQxLVnOggOXtRFKBDUxzsas1iECpzVPmddcgH9GIFl45ySn9iqOm+TcQixKPxRUkjoPfkjM2DRElKIlH2G0IymWcTUhx08y/wpWXen5aURbV7yaGBMP3ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107887; c=relaxed/simple;
	bh=JSCRrJ0vGVECMvPCy8VRRiFu+2CcgLz0qMvswZ0czHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S30XxF9F4YgaOp7+zkqLmEetV9+xRWZDGT5D3dwazpc+qDXL5usa/b8t0h13dKaGML92/fADHt8NZyNsN7JZXggpOfoB0oW+jXszEloNvEYQxLdHmZ7hojK3kqqrDPF6lqabZibSleg8N+XzuIxdLH1gTfP77FTfc9dwWiQ9AjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dN1lJj90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E579DC4CECD;
	Wed, 20 Nov 2024 13:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732107887;
	bh=JSCRrJ0vGVECMvPCy8VRRiFu+2CcgLz0qMvswZ0czHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dN1lJj90MCHYeUOs2Vn+uOalPTqqZBuW1YPc0ceE/GIuxG3nXmwVPOAsyTspxvvFX
	 tdl0EdO5RyHM9gcGrt2COQogYdvMU0ZovtnCmc3eKOROaupsDNUXSUs0EIkksRJA0B
	 +uAleqsrK6x93+sZCTEnq18sTRSSsR6zXDxwY2g3WRKDLJutWtknJjpFy1s5Dxx2I9
	 Gf2BuI7ibQlcLi5y7D866KkcSapM7YPbUlmtrSZOefSQRy1czYJmruXdbUzIImEp+5
	 V+CGR8qvwMamMKQTypdDxS0Q65xz6sLE5dbaVH7B75rYfG9z9EaYgGb1O2DkU3/Uw9
	 sWenKN7S4iRMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 6.1.y 3/3] null_blk: Fix return value of nullb_device_power_store()
Date: Wed, 20 Nov 2024 08:04:45 -0500
Message-ID: <20241120075627-fc65c1ac85b00e8f@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241120032841.28236-4-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: d9ff882b54f99f96787fa3df7cd938966843c418

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Damien Le Moal <dlemoal@kernel.org>


Status in newer kernel trees:
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: e0aba0c6d521)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-20 07:50:08.726024900 -0500
+++ /tmp/tmp.mzeJOcYvZi	2024-11-20 07:50:08.723707071 -0500
@@ -1,3 +1,5 @@
+commit d9ff882b54f99f96787fa3df7cd938966843c418 upstream.
+
 When powering on a null_blk device that is not already on, the return
 value ret that is initialized to be count is reused to check the return
 value of null_add_dev(), leading to nullb_device_power_store() to return
@@ -10,15 +12,17 @@
 Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
 Link: https://lore.kernel.org/r/20240527043445.235267-1-dlemoal@kernel.org
 Signed-off-by: Jens Axboe <axboe@kernel.dk>
+Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
  drivers/block/null_blk/main.c | 1 +
  1 file changed, 1 insertion(+)
 
 diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
-index eb023d2673693..631dca2e4e844 100644
+index e838eed4aacf..e66cace433cb 100644
 --- a/drivers/block/null_blk/main.c
 +++ b/drivers/block/null_blk/main.c
-@@ -494,6 +494,7 @@ static ssize_t nullb_device_power_store(struct config_item *item,
+@@ -470,6 +470,7 @@ static ssize_t nullb_device_power_store(struct config_item *item,
  
  		set_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
  		dev->power = newp;
@@ -26,3 +30,6 @@
  	} else if (dev->power && !newp) {
  		if (test_and_clear_bit(NULLB_DEV_FL_UP, &dev->flags)) {
  			dev->power = newp;
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

