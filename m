Return-Path: <stable+bounces-94021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8FD9D2880
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5131F23175
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DBE1CF5D6;
	Tue, 19 Nov 2024 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBJp1HgQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B4E1CCEE1
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027607; cv=none; b=HmZEJyBhSy4H/3ixdSX5AFmyHVHVX7w6CP5MRoodgsm/PQutWMKrp7crhpxs3yxUwjHhPaIoKah5iOfMtTadlcpnkvrlNM6LUKo+EnRgHQbv9aVq28nOxKLJVwLBdvyy5SkSMsO1bbmDtBCxvw3kzEG3YDCMn6ch8vmGcgzq1Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027607; c=relaxed/simple;
	bh=CIlXVWzBa1K6Oy2N6R7ROsM3dnzb8LN71tzdjS8GoxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dklr6IAbxCOIcOuy9WnNX6WrB7QdwVeLYZ0RmXoaFt/3Q7NplS0gnkvlR1ih6pOddzjBTqWDCSUq2N/znGk97KuGcsjqX3e0nTIVaTMzYW5AWXlV3QAz73Fy6S9umKyxQZ5EKE2J+LvSFyPZMHRyQAkc8UJ+uuQ8Rqavhin1PiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBJp1HgQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0F1C4CECF;
	Tue, 19 Nov 2024 14:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732027606;
	bh=CIlXVWzBa1K6Oy2N6R7ROsM3dnzb8LN71tzdjS8GoxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IBJp1HgQ16kM/u64OgYpH+rAXx6WStKPIeVFp4CJLenhnlWMzN9KL2+2qaHsPIv+H
	 v46ogyj0bokDhv8aXQtsgojCTv10HrNIOaSpzTXMfAkchcR1rz5FGx+aGxdmjME6P5
	 d/LIAmhrhKg8QYjH5/E0P1BupQG8opBP9b99oOAqaKF6H7JpstKVzzGdfll8ZTnHyl
	 jGplzrAayaXuTQ/oTufcfS3rQi2tKNQP8j6r2ZKFWa2JqJ2d0GTmXQa0FZff8Koc8+
	 o34WnArYM8bGp3CzzurByxIVrvRO8WTMRpYekjCRD3rE35nY0ZcQPf5Z8VW2edbbde
	 TkdNftvtk5WsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bin Lan <bin.lan.cn@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] leds: mlxreg: Use devm_mutex_init() for mutex initialization
Date: Tue, 19 Nov 2024 09:46:45 -0500
Message-ID: <20241119083919.2490177-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241119083919.2490177-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: efc347b9efee1c2b081f5281d33be4559fa50a16

WARNING: Author mismatch between patch and upstream commit:
Backport author: Bin Lan <bin.lan.cn@windriver.com>
Commit author: George Stark <gnstark@salutedevices.com>


Status in newer kernel trees:
6.11.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 07:43:38.458373754 -0500
+++ /tmp/tmp.8Ym27M0bF0	2024-11-19 07:43:38.452657083 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit efc347b9efee1c2b081f5281d33be4559fa50a16 ]
+
 In this driver LEDs are registered using devm_led_classdev_register()
 so they are automatically unregistered after module's remove() is done.
 led_classdev_unregister() calls module's led_set_brightness() to turn off
@@ -8,15 +10,17 @@
 Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
 Link: https://lore.kernel.org/r/20240411161032.609544-8-gnstark@salutedevices.com
 Signed-off-by: Lee Jones <lee@kernel.org>
+[ Resolve minor conflicts to fix CVE-2024-42129 ]
+Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
 ---
- drivers/leds/leds-mlxreg.c | 14 +++++---------
- 1 file changed, 5 insertions(+), 9 deletions(-)
+ drivers/leds/leds-mlxreg.c | 16 +++++-----------
+ 1 file changed, 5 insertions(+), 11 deletions(-)
 
 diff --git a/drivers/leds/leds-mlxreg.c b/drivers/leds/leds-mlxreg.c
-index 5595788d98d20..1b70de72376cc 100644
+index 39210653acf7..b1510cd32e47 100644
 --- a/drivers/leds/leds-mlxreg.c
 +++ b/drivers/leds/leds-mlxreg.c
-@@ -256,6 +256,7 @@ static int mlxreg_led_probe(struct platform_device *pdev)
+@@ -257,6 +257,7 @@ static int mlxreg_led_probe(struct platform_device *pdev)
  {
  	struct mlxreg_core_platform_data *led_pdata;
  	struct mlxreg_led_priv_data *priv;
@@ -24,7 +28,7 @@
  
  	led_pdata = dev_get_platdata(&pdev->dev);
  	if (!led_pdata) {
-@@ -267,26 +268,21 @@ static int mlxreg_led_probe(struct platform_device *pdev)
+@@ -268,28 +269,21 @@ static int mlxreg_led_probe(struct platform_device *pdev)
  	if (!priv)
  		return -ENOMEM;
  
@@ -39,11 +43,13 @@
  	return mlxreg_led_config(priv);
  }
  
--static void mlxreg_led_remove(struct platform_device *pdev)
+-static int mlxreg_led_remove(struct platform_device *pdev)
 -{
 -	struct mlxreg_led_priv_data *priv = dev_get_drvdata(&pdev->dev);
 -
 -	mutex_destroy(&priv->access_lock);
+-
+-	return 0;
 -}
 -
  static struct platform_driver mlxreg_led_driver = {
@@ -51,7 +57,10 @@
  	    .name = "leds-mlxreg",
  	},
  	.probe = mlxreg_led_probe,
--	.remove_new = mlxreg_led_remove,
+-	.remove = mlxreg_led_remove,
  };
  
  module_platform_driver(mlxreg_led_driver);
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.6.y:
    

