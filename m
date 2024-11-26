Return-Path: <stable+bounces-95543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9258B9D9A8A
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 16:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4253B24676
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 15:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CCF1D63F6;
	Tue, 26 Nov 2024 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oC7fK0B6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39691D63ED
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732635563; cv=none; b=uwEuxc5XS3iUa9nQTJC+0/Od/s5nJRXRCgGFgLKo7cQl0XfOL+vaIaGeAMnP9tE1fMCpJw1tXR3qfo+y7FTRZiBEwuIViYmwb7gkpbx2EzJJ1NmslYEAQkKBAQbB2r3erqfmoYRi39Ru66/10Fy5FLUnqZBOK+XkckIi1+y3dls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732635563; c=relaxed/simple;
	bh=Z7OHjMQRElac9mXz1nBlwNijmFw6Rqbacvx8XZSAZsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWdzNy7BPfmG2LJOFNmADhaQEhm7UBwIWeBQC8AD9rmGZA+B6d/1LPUbwrG1j05byEJ65Z24FNNcRXdEZ61oLDplI/ESdtHvRyKfhDPZA37Ia2vu8ycqvPZbL/66bwsV8C0VCfit2BJlXBvSThtIEQHGv7QIJNSkBEoqG+8Evfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oC7fK0B6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E549C4CECF;
	Tue, 26 Nov 2024 15:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732635563;
	bh=Z7OHjMQRElac9mXz1nBlwNijmFw6Rqbacvx8XZSAZsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oC7fK0B6oQCn6GfgHLixH6S31j9JAG4Y45sYWLNWf2urfPFNOq8sSfUkW4xz+ZjpS
	 k+ax0oKWOC3k+cPbXGo0YtVjpduKGtx4MpuwszxDt9pK00u5q4cn7ICbXDH/1hBJ6l
	 QwvGqhN7KbvsSrkzCpHxfj75pS9Ohia8hAJSQjZ9prSDvgBQhcRBFBP2RZDjlnBD31
	 Zv2XOobT9AUPU4AH8tRdBdvcS2NoWDVJD/+RBlJZYb8S2AUZfe1OGSnmOr4ml4zRPY
	 qONuWuhHvbinB+hmvXtEE04cbTgoaWb6+BuisB9jmw1j5lx0SPk8ACEYaNu44IaWPV
	 7xGLagOu3qFVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bin Lan <bin.lan.cn@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] nvme: apple: fix device reference counting
Date: Tue, 26 Nov 2024 10:39:21 -0500
Message-ID: <20241126082217-0e17438d43960efa@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241126074657.2003279-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: b9ecbfa45516182cd062fecd286db7907ba84210

WARNING: Author mismatch between patch and upstream commit:
Backport author: Bin Lan <bin.lan.cn@windriver.com>
Commit author: Keith Busch <kbusch@kernel.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-26 08:18:41.504993466 -0500
+++ /tmp/tmp.6GPhqxSP1X	2024-11-26 08:18:41.496411675 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit b9ecbfa45516182cd062fecd286db7907ba84210 ]
+
 Drivers must call nvme_uninit_ctrl after a successful nvme_init_ctrl.
 Split the allocation side out to make the error handling boundary easier
 to navigate. The apple driver had been doing this wrong, leaking the
@@ -6,15 +8,17 @@
 Reviewed-by: Christoph Hellwig <hch@lst.de>
 Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
 Signed-off-by: Keith Busch <kbusch@kernel.org>
+[ Resolve minor conflicts ]
+Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
 ---
  drivers/nvme/host/apple.c | 27 ++++++++++++++++++++++-----
  1 file changed, 22 insertions(+), 5 deletions(-)
 
 diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
-index dd6ec0865141a..c43ada920c3b2 100644
+index 596bb11eeba5..396eb9437659 100644
 --- a/drivers/nvme/host/apple.c
 +++ b/drivers/nvme/host/apple.c
-@@ -1388,7 +1388,7 @@ static void devm_apple_nvme_mempool_destroy(void *data)
+@@ -1387,7 +1387,7 @@ static void devm_apple_nvme_mempool_destroy(void *data)
  	mempool_destroy(data);
  }
  
@@ -23,7 +27,7 @@
  {
  	struct device *dev = &pdev->dev;
  	struct apple_nvme *anv;
-@@ -1396,7 +1396,7 @@ static int apple_nvme_probe(struct platform_device *pdev)
+@@ -1395,7 +1395,7 @@ static int apple_nvme_probe(struct platform_device *pdev)
  
  	anv = devm_kzalloc(dev, sizeof(*anv), GFP_KERNEL);
  	if (!anv)
@@ -32,7 +36,7 @@
  
  	anv->dev = get_device(dev);
  	anv->adminq.is_adminq = true;
-@@ -1516,10 +1516,26 @@ static int apple_nvme_probe(struct platform_device *pdev)
+@@ -1515,10 +1515,26 @@ static int apple_nvme_probe(struct platform_device *pdev)
  		goto put_dev;
  	}
  
@@ -51,7 +55,7 @@
 +	if (IS_ERR(anv))
 +		return PTR_ERR(anv);
 +
- 	anv->ctrl.admin_q = blk_mq_alloc_queue(&anv->admin_tagset, NULL, NULL);
+ 	anv->ctrl.admin_q = blk_mq_init_queue(&anv->admin_tagset);
  	if (IS_ERR(anv->ctrl.admin_q)) {
  		ret = -ENOMEM;
 -		goto put_dev;
@@ -60,7 +64,7 @@
  	}
  
  	nvme_reset_ctrl(&anv->ctrl);
-@@ -1527,8 +1543,9 @@ static int apple_nvme_probe(struct platform_device *pdev)
+@@ -1526,8 +1542,9 @@ static int apple_nvme_probe(struct platform_device *pdev)
  
  	return 0;
  
@@ -72,3 +76,6 @@
  	return ret;
  }
  
+-- 
+2.34.1
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

