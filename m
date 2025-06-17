Return-Path: <stable+bounces-154283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC97ADD8B5
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64BBE4A13B6
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD0D2DFF38;
	Tue, 17 Jun 2025 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xdoNEN62"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A5E8F54;
	Tue, 17 Jun 2025 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178692; cv=none; b=li5eIOz//RntYyP6/V23BbAQxA6C28zc3/KrTgAndNGclNZC5kcNiJ3yOSj3Sg9bnL/V5x4/nYJ57yvwnpJeKFEcXM5p7n6SBgfGQ/iTbZsFQZuqVvYskKtZkQZs3TbuSU5Cwqt4uuoDtZIYJuOIImM/8dubUgZ8DJsisITCJt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178692; c=relaxed/simple;
	bh=4MEVU+P2Kf2lemKxHb/QdkqBFSQ5JCVOwbbdsWDn9VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c54yAIPeEFgVGDT4yOVccJCz+dS8LRj5Lhdr+9VcVFRSRwDuB+bJEgZ1Jc53z/9wIXnYy/8AeFeoU8s0aLTSU2EvMs9A8w5imBJDioFvpl3x3CoXNEOyRfQplzh0TwWONwOy/5NOSFT+fKoIw7B+TQtO7TLJgQlWZpbO/pQ6VaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xdoNEN62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B055C4CEE3;
	Tue, 17 Jun 2025 16:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750178692;
	bh=4MEVU+P2Kf2lemKxHb/QdkqBFSQ5JCVOwbbdsWDn9VI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xdoNEN62b7JgL/k886kX1dIw57uoYj+EXvFCYU9/FcOELjfIxvj5+4HdI+oPyE1TD
	 3MiSNxpPIc4dcH0sUQSIo4WiO/p/xsfNDvkDubYFt37ccBg0LSx0sKaFV4WLsFdCjF
	 GQ2W7db8OzeMm+UjS2hiGMNxVv4SJSH/VQVGJCIs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Junhao He <hejunhao3@huawei.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 525/780] coresight: Fixes devices owner field for registered using coresight_init_driver()
Date: Tue, 17 Jun 2025 17:23:53 +0200
Message-ID: <20250617152512.892996141@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junhao He <hejunhao3@huawei.com>

[ Upstream commit 9f52aecc952ddf307571517d5c91136c8c4e87c9 ]

The coresight_init_driver() of the coresight-core module is called from
the sub coresgiht device (such as tmc/stm/funnle/...) module. It calls
amba_driver_register() and Platform_driver_register(), which are macro
functions that use the coresight-core's module to initialize the caller's
owner field.  Therefore, when the sub coresight device calls
coresight_init_driver(), an incorrect THIS_MODULE value is captured.

The sub coesgiht modules can be removed while their callbacks are
running, resulting in a general protection failure.

Add module parameter to coresight_init_driver() so can be called
with the module of the callback.

Fixes: 075b7cd7ad7d ("coresight: Add helpers registering/removing both AMBA and platform drivers")
Signed-off-by: Junhao He <hejunhao3@huawei.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20240918035327.9710-1-hejunhao3@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-catu.c       | 2 +-
 drivers/hwtracing/coresight/coresight-core.c       | 6 +++---
 drivers/hwtracing/coresight/coresight-cpu-debug.c  | 3 ++-
 drivers/hwtracing/coresight/coresight-funnel.c     | 3 ++-
 drivers/hwtracing/coresight/coresight-replicator.c | 3 ++-
 drivers/hwtracing/coresight/coresight-stm.c        | 2 +-
 drivers/hwtracing/coresight/coresight-tmc-core.c   | 2 +-
 drivers/hwtracing/coresight/coresight-tpiu.c       | 2 +-
 include/linux/coresight.h                          | 2 +-
 9 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index fa170c966bc3b..96cb48b140afa 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -702,7 +702,7 @@ static int __init catu_init(void)
 {
 	int ret;
 
-	ret = coresight_init_driver("catu", &catu_driver, &catu_platform_driver);
+	ret = coresight_init_driver("catu", &catu_driver, &catu_platform_driver, THIS_MODULE);
 	tmc_etr_set_catu_ops(&etr_catu_buf_ops);
 	return ret;
 }
diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index fb43ef6a3b1f0..dabec7073aeda 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1585,17 +1585,17 @@ module_init(coresight_init);
 module_exit(coresight_exit);
 
 int coresight_init_driver(const char *drv, struct amba_driver *amba_drv,
-			  struct platform_driver *pdev_drv)
+			  struct platform_driver *pdev_drv, struct module *owner)
 {
 	int ret;
 
-	ret = amba_driver_register(amba_drv);
+	ret = __amba_driver_register(amba_drv, owner);
 	if (ret) {
 		pr_err("%s: error registering AMBA driver\n", drv);
 		return ret;
 	}
 
-	ret = platform_driver_register(pdev_drv);
+	ret = __platform_driver_register(pdev_drv, owner);
 	if (!ret)
 		return 0;
 
diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index 342c3aaf414dd..a871d997330b0 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -774,7 +774,8 @@ static struct platform_driver debug_platform_driver = {
 
 static int __init debug_init(void)
 {
-	return coresight_init_driver("debug", &debug_driver, &debug_platform_driver);
+	return coresight_init_driver("debug", &debug_driver, &debug_platform_driver,
+				     THIS_MODULE);
 }
 
 static void __exit debug_exit(void)
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 0541712b2bcb6..124fc2e26cfb1 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -433,7 +433,8 @@ static struct amba_driver dynamic_funnel_driver = {
 
 static int __init funnel_init(void)
 {
-	return coresight_init_driver("funnel", &dynamic_funnel_driver, &funnel_driver);
+	return coresight_init_driver("funnel", &dynamic_funnel_driver, &funnel_driver,
+				     THIS_MODULE);
 }
 
 static void __exit funnel_exit(void)
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index ee7ee79f6cf77..572dcd2bac16d 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -438,7 +438,8 @@ static struct amba_driver dynamic_replicator_driver = {
 
 static int __init replicator_init(void)
 {
-	return coresight_init_driver("replicator", &dynamic_replicator_driver, &replicator_driver);
+	return coresight_init_driver("replicator", &dynamic_replicator_driver, &replicator_driver,
+				     THIS_MODULE);
 }
 
 static void __exit replicator_exit(void)
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 26f9339f38b93..527347e4d16c5 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -1058,7 +1058,7 @@ static struct platform_driver stm_platform_driver = {
 
 static int __init stm_init(void)
 {
-	return coresight_init_driver("stm", &stm_driver, &stm_platform_driver);
+	return coresight_init_driver("stm", &stm_driver, &stm_platform_driver, THIS_MODULE);
 }
 
 static void __exit stm_exit(void)
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index a7814e8e657b2..455b1c9b15682 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -1060,7 +1060,7 @@ static struct platform_driver tmc_platform_driver = {
 
 static int __init tmc_init(void)
 {
-	return coresight_init_driver("tmc", &tmc_driver, &tmc_platform_driver);
+	return coresight_init_driver("tmc", &tmc_driver, &tmc_platform_driver, THIS_MODULE);
 }
 
 static void __exit tmc_exit(void)
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 97ef36f03ec20..3e01592884280 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -318,7 +318,7 @@ static struct platform_driver tpiu_platform_driver = {
 
 static int __init tpiu_init(void)
 {
-	return coresight_init_driver("tpiu", &tpiu_driver, &tpiu_platform_driver);
+	return coresight_init_driver("tpiu", &tpiu_driver, &tpiu_platform_driver, THIS_MODULE);
 }
 
 static void __exit tpiu_exit(void)
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index d79a242b271d6..cfcf6e4707ed9 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -723,7 +723,7 @@ coresight_find_output_type(struct coresight_platform_data *pdata,
 			   union coresight_dev_subtype subtype);
 
 int coresight_init_driver(const char *drv, struct amba_driver *amba_drv,
-			  struct platform_driver *pdev_drv);
+			  struct platform_driver *pdev_drv, struct module *owner);
 
 void coresight_remove_driver(struct amba_driver *amba_drv,
 			     struct platform_driver *pdev_drv);
-- 
2.39.5




