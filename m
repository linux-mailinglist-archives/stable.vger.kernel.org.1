Return-Path: <stable+bounces-140557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B19B7AAA9E4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C871882E52
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58272C0322;
	Mon,  5 May 2025 22:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLfYLvMS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B0B361957;
	Mon,  5 May 2025 22:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485150; cv=none; b=tIxl4tatgmEJkgptOVTqYYi73Og0Edh7hlGOsFyjdqFNYVdeco/ti5aOJZaCP7bapGu1ATEM8WdJhX5SgN3oHK8v/V04SDlrc9ma5mgp9jLvzD9VQY6as0j0BptSQSvQWlFpAn6KCwY2EY8J+3i8RlSqjH7UvdWIFseF2ziX878=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485150; c=relaxed/simple;
	bh=GFMjn6D0dDQc53/uChYc+vwTz+Ryp4pSn9tW/6DfemY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HiDU/5SZxOl5yPDYPip3pVxMxUOFLgRYFgwqNSzHCetmG7eMd2v3mtoHnuq+0litUInRBiO/0YAtf0NRkio8LCLs661A6mI+QVKjcFz0n4YCNpJWEWoRlflSuVt4c6+ILGtta+zkOK56N5OlkjAgy/jImgCEkZ37PpanKlNLD7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLfYLvMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2923C4CEF1;
	Mon,  5 May 2025 22:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485148;
	bh=GFMjn6D0dDQc53/uChYc+vwTz+Ryp4pSn9tW/6DfemY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sLfYLvMS5BKVdl2LxBrfIUJ71dkdDLassUDf68Im+Gj+3fKRtICoEWMmCkkjaEZS6
	 XspWMxalxH+Y+fnkTCCrpu4Lqzwd3mKXjJ+3NXoI3Oj8lqnd9MlLxThdtpo/jVQY7k
	 Td0pFCy7lmNrhUVKzVBjtyvv6TetXPAlWAh50kN4600lep7pkK3J/Weeu+QocWcy+Y
	 7r7UwAc/m2f/U5qOcuuJ3BIcJfK0R2bO4a61/5wCLmVLOoBV2JR9Wvb/ilwyV5IJYz
	 36FjQzgTWdgpmfy29KEnefFRLx/9aQi2UgPUxFHEYGpaQ5/mO7mARItYq6iWcHevrU
	 tiz1vWVVgGN1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	krzk@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 185/486] soc: samsung: include linux/array_size.h where needed
Date: Mon,  5 May 2025 18:34:21 -0400
Message-Id: <20250505223922.2682012-185-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 4c57930f68d90e0d52c396d058cfa9ed8447a6c4 ]

This does not necessarily get included through asm/io.h:

drivers/soc/samsung/exynos3250-pmu.c:120:18: error: use of undeclared identifier 'ARRAY_SIZE'
  120 |         for (i = 0; i < ARRAY_SIZE(exynos3250_list_feed); i++) {
      |                         ^
drivers/soc/samsung/exynos5250-pmu.c:162:18: error: use of undeclared identifier 'ARRAY_SIZE'
  162 |         for (i = 0; i < ARRAY_SIZE(exynos5_list_both_cnt_feed); i++) {
      |                         ^

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20250305211446.43772-1-arnd@kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/samsung/exynos-asv.c     | 1 +
 drivers/soc/samsung/exynos-chipid.c  | 1 +
 drivers/soc/samsung/exynos-pmu.c     | 1 +
 drivers/soc/samsung/exynos-usi.c     | 1 +
 drivers/soc/samsung/exynos3250-pmu.c | 1 +
 drivers/soc/samsung/exynos5250-pmu.c | 1 +
 drivers/soc/samsung/exynos5420-pmu.c | 1 +
 7 files changed, 7 insertions(+)

diff --git a/drivers/soc/samsung/exynos-asv.c b/drivers/soc/samsung/exynos-asv.c
index 97006cc3b9461..8e681f5195264 100644
--- a/drivers/soc/samsung/exynos-asv.c
+++ b/drivers/soc/samsung/exynos-asv.c
@@ -9,6 +9,7 @@
  * Samsung Exynos SoC Adaptive Supply Voltage support
  */
 
+#include <linux/array_size.h>
 #include <linux/cpu.h>
 #include <linux/device.h>
 #include <linux/energy_model.h>
diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index bba8d86ae1bb0..dedfe6d0fb3f3 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -12,6 +12,7 @@
  * Samsung Exynos SoC Adaptive Supply Voltage and Chip ID support
  */
 
+#include <linux/array_size.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/mfd/syscon.h>
diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index dd5256e5aae1a..c40313886a012 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -5,6 +5,7 @@
 //
 // Exynos - CPU PMU(Power Management Unit) support
 
+#include <linux/array_size.h>
 #include <linux/arm-smccc.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
diff --git a/drivers/soc/samsung/exynos-usi.c b/drivers/soc/samsung/exynos-usi.c
index 114352695ac2b..5a93a68dba87f 100644
--- a/drivers/soc/samsung/exynos-usi.c
+++ b/drivers/soc/samsung/exynos-usi.c
@@ -6,6 +6,7 @@
  * Samsung Exynos USI driver (Universal Serial Interface).
  */
 
+#include <linux/array_size.h>
 #include <linux/clk.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
diff --git a/drivers/soc/samsung/exynos3250-pmu.c b/drivers/soc/samsung/exynos3250-pmu.c
index 30f230ed1769c..4bad12a995422 100644
--- a/drivers/soc/samsung/exynos3250-pmu.c
+++ b/drivers/soc/samsung/exynos3250-pmu.c
@@ -5,6 +5,7 @@
 //
 // Exynos3250 - CPU PMU (Power Management Unit) support
 
+#include <linux/array_size.h>
 #include <linux/soc/samsung/exynos-regs-pmu.h>
 #include <linux/soc/samsung/exynos-pmu.h>
 
diff --git a/drivers/soc/samsung/exynos5250-pmu.c b/drivers/soc/samsung/exynos5250-pmu.c
index 7a2d50be6b4ac..2ae5c3e1b07a3 100644
--- a/drivers/soc/samsung/exynos5250-pmu.c
+++ b/drivers/soc/samsung/exynos5250-pmu.c
@@ -5,6 +5,7 @@
 //
 // Exynos5250 - CPU PMU (Power Management Unit) support
 
+#include <linux/array_size.h>
 #include <linux/soc/samsung/exynos-regs-pmu.h>
 #include <linux/soc/samsung/exynos-pmu.h>
 
diff --git a/drivers/soc/samsung/exynos5420-pmu.c b/drivers/soc/samsung/exynos5420-pmu.c
index 6fedcd78cb451..58a2209795f78 100644
--- a/drivers/soc/samsung/exynos5420-pmu.c
+++ b/drivers/soc/samsung/exynos5420-pmu.c
@@ -5,6 +5,7 @@
 //
 // Exynos5420 - CPU PMU (Power Management Unit) support
 
+#include <linux/array_size.h>
 #include <linux/pm.h>
 #include <linux/soc/samsung/exynos-regs-pmu.h>
 #include <linux/soc/samsung/exynos-pmu.h>
-- 
2.39.5


