Return-Path: <stable+bounces-95398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A23E9D890C
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 16:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204A1285B07
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 15:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3191AF0B6;
	Mon, 25 Nov 2024 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAsclNjI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAC5171CD
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 15:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548042; cv=none; b=t3OpQL0idBoztSxzlTkzFGVEoHLJlkE+B5JGJ/hmKgGSeLtvPqJEoAWhieJ9oEPXKBMin0seR1kBWKRuDK0zJyHMoC/VM9mXPDElCg+1SlzRIQ121YnFSGQmM4gbFmUXo6Ut3a4NyffDR2/PHt133ZYeXLJO7IItXBemYXX+VnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548042; c=relaxed/simple;
	bh=7n2jhmXPDZcGQZp1rIbYPSSzc+G6ViFku7xGP1i1Hw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnQSDY0Dg6XOnr1UTIPakT67X3XN5e2QRaj+hhw5a7+ad/jak6s3ZEgIKJ9Kt2CFwqTrrAVgHjBvpr7SuQYrrCWsyLmFf80h3HB8KNUedRN2cQHKEYrY5b4mYK3xIL8I2EnIy3IJf6TA1OliiUojdQsVRBfRXGRvt+2CPRn7ehU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAsclNjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F45C4CECE;
	Mon, 25 Nov 2024 15:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732548040;
	bh=7n2jhmXPDZcGQZp1rIbYPSSzc+G6ViFku7xGP1i1Hw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DAsclNjIsex6p2QDf520fu5ypJ36VkY/zjMVekNEbIxeCQNYJWfmLZVSPecU0RR+1
	 xdKJ9hnsFzhTEPaqXao4sYXu5UJY0IfCadcjq9WertXj7JPT6hzkIZeAlDYl/2UHe3
	 H6q+nmYrEKSWpyWD1s7eiunBmMmQXJ45yZLIPIbFdTKi7jgrVMhWenEucHkH1P5kpX
	 cnRHwOmL81xFVIw87UHzYInIzDE2eKhDCWEcK1e96uh7h0MmV1v91x9rGHkVbde/Ht
	 1u4Ebb7tCH/E2nO8HKtV1jvfoKB43a82XzUwbmgAn8poX5OYniGu4B1RVfOUBWpB8P
	 mAR8VDVkiZFAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 2/2] fpga: manager: add owner module and take its refcount
Date: Mon, 25 Nov 2024 10:20:39 -0500
Message-ID: <20241125101254-d0692ef1c2bf7efc@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241125053816.1914594-3-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 4d4d2d4346857bf778fafaa97d6f76bb1663e3c9

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Marco Pagani <marpagan@redhat.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 2da62a139a62)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-25 10:08:25.352634693 -0500
+++ /tmp/tmp.mxHKcERVgS	2024-11-25 10:08:25.345028939 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 4d4d2d4346857bf778fafaa97d6f76bb1663e3c9 ]
+
 The current implementation of the fpga manager assumes that the low-level
 module registers a driver for the parent device and uses its owner pointer
 to take the module's refcount. This approach is problematic since it can
@@ -26,6 +28,8 @@
 Acked-by: Xu Yilun <yilun.xu@intel.com>
 Link: https://lore.kernel.org/r/20240305192926.84886-1-marpagan@redhat.com
 Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
+Signed-off-by: Sasha Levin <sashal@kernel.org>
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
  Documentation/driver-api/fpga/fpga-mgr.rst | 34 +++++----
  drivers/fpga/fpga-mgr.c                    | 82 +++++++++++++---------
@@ -33,7 +37,7 @@
  3 files changed, 89 insertions(+), 53 deletions(-)
 
 diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
-index 49c0a95126532..8d2b79f696c1f 100644
+index 49c0a9512653..8d2b79f696c1 100644
 --- a/Documentation/driver-api/fpga/fpga-mgr.rst
 +++ b/Documentation/driver-api/fpga/fpga-mgr.rst
 @@ -24,7 +24,8 @@ How to support a new FPGA device
@@ -109,7 +113,7 @@
  .. kernel-doc:: drivers/fpga/fpga-mgr.c
     :functions: fpga_mgr_unregister
 diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
-index 06651389c5926..0f4035b089a2e 100644
+index 8efa67620e21..0c71d91ba7f6 100644
 --- a/drivers/fpga/fpga-mgr.c
 +++ b/drivers/fpga/fpga-mgr.c
 @@ -664,20 +664,16 @@ static struct attribute *fpga_mgr_attrs[] = {
@@ -141,12 +145,12 @@
   */
  struct fpga_manager *fpga_mgr_get(struct device *dev)
  {
--	struct device *mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev,
+-	struct device *mgr_dev = class_find_device(fpga_mgr_class, NULL, dev,
 -						   fpga_mgr_dev_match);
 +	struct fpga_manager *mgr;
 +	struct device *mgr_dev;
 +
-+	mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev, fpga_mgr_dev_match);
++	mgr_dev = class_find_device(fpga_mgr_class, NULL, dev, fpga_mgr_dev_match);
  	if (!mgr_dev)
  		return ERR_PTR(-ENODEV);
  
@@ -167,9 +171,9 @@
 +	struct fpga_manager *mgr;
 +	struct device *mgr_dev;
  
--	dev = class_find_device_by_of_node(&fpga_mgr_class, node);
+-	dev = class_find_device_by_of_node(fpga_mgr_class, node);
 -	if (!dev)
-+	mgr_dev = class_find_device_by_of_node(&fpga_mgr_class, node);
++	mgr_dev = class_find_device_by_of_node(fpga_mgr_class, node);
 +	if (!mgr_dev)
  		return ERR_PTR(-ENODEV);
  
@@ -337,7 +341,7 @@
  static void fpga_mgr_dev_release(struct device *dev)
  {
 diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
-index 54f63459efd6e..0d4fe068f3d8a 100644
+index 54f63459efd6..0d4fe068f3d8 100644
 --- a/include/linux/fpga/fpga-mgr.h
 +++ b/include/linux/fpga/fpga-mgr.h
 @@ -201,6 +201,7 @@ struct fpga_manager_ops {
@@ -393,3 +397,6 @@
 +			 struct module *owner);
  
  #endif /*_LINUX_FPGA_MGR_H */
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

