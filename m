Return-Path: <stable+bounces-93916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0399D1F64
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 05:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807CF2812C0
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 04:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80B414C5AA;
	Tue, 19 Nov 2024 04:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMqubGiz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8789A1459F6
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 04:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731991013; cv=none; b=CVnLAt48obaMVe4ipht63xFFl9s77tYgZj2WGK1vE59RFUK419ikDVk4QmUICAgqxBevef4ZcQCbLVXVEkvKJJnCSeaA/eC4q9zqeOeKvPfkILwd+wRgLmoDu2gmfBoyOOomOpBiJ6oOMGrRzfRdtPPznvpCB61wqjS70+ljNyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731991013; c=relaxed/simple;
	bh=HDi1fwLwvFo4b37ngWJqW6WGorAgxc/xerIUfvPSeGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfiGAtrkI9TAPPLBvJn5qw/TrP2XisPSlXPYLRY7tOJ4cZzVpABd36N0UWbtc2xVgJPj1kl7oU/Oo5Dg4r37e8XMc7gVvZ5gT6+ohad/Cy8sZgE+ooB0k4q/eTqhDg8Ryn3HueIwWRj3gKB8AK2YW64YEFiF1hww2xwi6HALgUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMqubGiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8AEC4CECF;
	Tue, 19 Nov 2024 04:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731991013;
	bh=HDi1fwLwvFo4b37ngWJqW6WGorAgxc/xerIUfvPSeGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BMqubGizujIT0pssCZe+vDUJaJlSLVE/OW/2UTlPVbaelEhe2CHAuly2wAXHpZVEc
	 4KK7ro+QenrUIUL+iUqgmUDc1zX7CzaFkJLtEFLWhm5gNIi8GVbkRUHvixl3vS7tFI
	 VvUoyOubC8hp2Rix1NHcbBiyyr4XD5gHHvOZLJvGf6cZuJGpddHkkIH3fTOf2Anffi
	 MwNKWyvBNzT4DuizaXLrXobJfvmPaxyB5/hMQqhdffP6SENFXuIg7Mv+pXGXGjn1Xt
	 KJlDKnLNrbFz34HFt5+dSL/Wr+WhvMrOEzIDR7m7eqChgiEJtM9tv4Da+R9rFR5kog
	 kNaJilTqDZSzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] gpiolib: cdev: Fix use after free in lineinfo_changed_notify
Date: Mon, 18 Nov 2024 23:36:51 -0500
Message-ID: <20241118084523.2544274-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118084523.2544274-1-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 02f6b0e1ec7e0e7d059dddc893645816552039da

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Zhongqiu Han <quic_zhonhan@quicinc.com>

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (exact SHA1)                        |
| 6.6.y           |  Present (different SHA1: 95ca7c90eaf5)      |
| 6.1.y           |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-18 16:31:52.602756021 -0500
+++ /tmp/tmp.fT2zVEHAD2	2024-11-18 16:31:52.593493881 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 02f6b0e1ec7e0e7d059dddc893645816552039da ]
+
 The use-after-free issue occurs as follows: when the GPIO chip device file
 is being closed by invoking gpio_chrdev_release(), watched_lines is freed
 by bitmap_free(), but the unregistration of lineinfo_changed_nb notifier
@@ -41,24 +43,26 @@
 Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
 Link: https://lore.kernel.org/r/20240505141156.2944912-1-quic_zhonhan@quicinc.com
 Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
  drivers/gpio/gpiolib-cdev.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
-index fea149ae77741..46a45093d4d0d 100644
+index 55f640ef3fee..897d20996a8c 100644
 --- a/drivers/gpio/gpiolib-cdev.c
 +++ b/drivers/gpio/gpiolib-cdev.c
-@@ -2799,11 +2799,11 @@ static int gpio_chrdev_release(struct inode *inode, struct file *file)
+@@ -2860,9 +2860,9 @@ static int gpio_chrdev_release(struct inode *inode, struct file *file)
  	struct gpio_chardev_data *cdev = file->private_data;
  	struct gpio_device *gdev = cdev->gdev;
  
 -	bitmap_free(cdev->watched_lines);
- 	blocking_notifier_chain_unregister(&gdev->device_notifier,
- 					   &cdev->device_unregistered_nb);
- 	blocking_notifier_chain_unregister(&gdev->line_state_notifier,
+ 	blocking_notifier_chain_unregister(&gdev->notifier,
  					   &cdev->lineinfo_changed_nb);
 +	bitmap_free(cdev->watched_lines);
- 	gpio_device_put(gdev);
+ 	put_device(&gdev->dev);
  	kfree(cdev);
  
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

