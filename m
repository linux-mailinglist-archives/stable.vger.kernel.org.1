Return-Path: <stable+bounces-95404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2E79D8911
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 16:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9735B16213A
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 15:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986251ADFEA;
	Mon, 25 Nov 2024 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbV6mTzz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58090171CD
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548053; cv=none; b=pfh+KG7/22hiDA5XeMoAfdjOKxXRnSIfnuELIr2aRyXUE+ev+6w9PfBj68D1K4ec4z5cOCI6i9LBnIvzDyGhBvsjy9DmMIEvQTTNeYnm/1VqtebHiu/WDnLq7MwakRAtAFkseTG4NP8Nr1/QZ7eCRmnbV3VQwkF0VOlKAZRdKEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548053; c=relaxed/simple;
	bh=QIO+LYZ0Poz5Aj4rfgh6+xbynh8dHxRhQQ6BzBdAOSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jk8ieWgQA4noSt+hdg6VmDW0bI+m/LGxArsXOX6Y8fRpQx2ZHnkX0OKPLK1YRCxlyvBQ1CQVz0eo78dUzos5Ak7W5VeQXd2mb4qQu/MiQW1Lef4TrAiCQncIl7CNUYF4YZxVJ7cbEsndbk57g5wXmFR7xxRGaT7YhsvNjpTGDo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbV6mTzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B419CC4CECE;
	Mon, 25 Nov 2024 15:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732548053;
	bh=QIO+LYZ0Poz5Aj4rfgh6+xbynh8dHxRhQQ6BzBdAOSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WbV6mTzzKm1N+Ozz1CSEtcSFk98dNK97X86yg8I3dFDAjsouJM9V/lLE5BwQcgOjN
	 ZguF+JzznqVwcERWtsgnW1uZkEiF+5B3gtfV6yV9FuooDIPWCKrSRHghovQVEgulMV
	 U+P3OQmOsg1AdLhfTgDF0yylXrJgUJgRUtNtB+BlvLVzZvilfmR/cZ2CUcVBeo6nJg
	 UcJ+Ap2hlksF2AMdELIb5kDtYIG6GJsv2gEjX2t9g6ccC7gnr5wWcQndxNeDbQR8YY
	 6qV5NZDJiuFjUM3HX3lNMTvlZL9cCkEDBiO3c3AaFMDzTYxBg1wSIcF7zony2d7hZY
	 8vecM9onQlQqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bin Lan <bin.lan.cn@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] platform/x86: x86-android-tablets: Unregister devices in reverse order
Date: Mon, 25 Nov 2024 10:20:51 -0500
Message-ID: <20241125085646-f5b2acf19b273ca8@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241125080625.386037-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 3de0f2627ef849735f155c1818247f58404dddfe

WARNING: Author mismatch between patch and upstream commit:
Backport author: Bin Lan <bin.lan.cn@windriver.com>
Commit author: Hans de Goede <hdegoede@redhat.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-25 08:51:45.872698411 -0500
+++ /tmp/tmp.lymTd90W4F	2024-11-25 08:51:45.865383382 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 3de0f2627ef849735f155c1818247f58404dddfe ]
+
 Not all subsystems support a device getting removed while there are
 still consumers of the device with a reference to the device.
 
@@ -45,15 +47,17 @@
 
 Signed-off-by: Hans de Goede <hdegoede@redhat.com>
 Link: https://lore.kernel.org/r/20240406125058.13624-1-hdegoede@redhat.com
+[ Resolve minor conflicts ]
+Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
 ---
- drivers/platform/x86/x86-android-tablets/core.c | 8 ++++----
- 1 file changed, 4 insertions(+), 4 deletions(-)
+ drivers/platform/x86/x86-android-tablets/core.c | 6 +++---
+ 1 file changed, 3 insertions(+), 3 deletions(-)
 
 diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
-index a3415f1c0b5f8..6559bb4ea7305 100644
+index a0fa0b6859c9..63a348af83db 100644
 --- a/drivers/platform/x86/x86-android-tablets/core.c
 +++ b/drivers/platform/x86/x86-android-tablets/core.c
-@@ -278,25 +278,25 @@ static void x86_android_tablet_remove(struct platform_device *pdev)
+@@ -230,20 +230,20 @@ static void x86_android_tablet_remove(struct platform_device *pdev)
  {
  	int i;
  
@@ -72,14 +76,11 @@
  	kfree(pdevs);
  	kfree(buttons);
  
--	for (i = 0; i < spi_dev_count; i++)
-+	for (i = spi_dev_count - 1; i >= 0; i--)
- 		spi_unregister_device(spi_devs[i]);
- 
- 	kfree(spi_devs);
- 
 -	for (i = 0; i < i2c_client_count; i++)
 +	for (i = i2c_client_count - 1; i >= 0; i--)
  		i2c_unregister_device(i2c_clients[i]);
  
  	kfree(i2c_clients);
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

