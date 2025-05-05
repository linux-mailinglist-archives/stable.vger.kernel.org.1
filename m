Return-Path: <stable+bounces-139980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758D6AAA356
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954C63AAE79
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A045127934A;
	Mon,  5 May 2025 22:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHX8xMlX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565842F0BB5;
	Mon,  5 May 2025 22:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483819; cv=none; b=t/6eejXR1bC7CQRlGcUwW0CJHyFGobOY8zu+YdYGlSnLINjSX/0Vmpwx18jzNaFXLL8OEIbWRhxqeBzNAwmBOlv1sjBYT+mLFTaZuMlaYwCrNf7M7CfB57z5YTiVaT77uiJRhncSvq0jCR1Jsmv56XFPkme3oEOZWcYV7DjDcig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483819; c=relaxed/simple;
	bh=PFmrl+mIJ8+7TyIIyqvSWh7WdwcJauVosWlhP18xpy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RVrFPsicvpOi6jwzXmNjoAJAF6yNl05BR9V+OVcMsNYcUEGYIzPSNZpxBQGDvI45+NrwrbsE0ges+U+koiz73EjV2iBRbZ8kmq5PPIUWtun25TWAJbhmUoNAoLOaCuVWiq/j9JBap1by2PcKmsda65lK805bQnbrQ6wh/TUd0dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHX8xMlX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A643C4CEE4;
	Mon,  5 May 2025 22:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483819;
	bh=PFmrl+mIJ8+7TyIIyqvSWh7WdwcJauVosWlhP18xpy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qHX8xMlX0sT7mFA+2odRnVnJVdCSdwKSWirhuCZzIxLwCU3a9IbLMSDMLCZLCM+A5
	 bgJOee0rykHf7lUQxH9BzSphhI6TwBdVDuRvbAIOzahBGrzag6eF1b4pJ8BFRC4HFI
	 RYwbyuyjBTUxmzRW2pCPns5Tu75n7bDJTImwP7dl4MqcZvkDctdx2CBob50SDSqU7f
	 2N0BOpOkDYAj9dxAEpjYfCzo/6F6UMhIkiR0vx5nh83nh/rpamEP9WYshWAzqvVM5d
	 7g/nNYkbUZMmHnWXHDOy4A+sNd06mgJhcAelQFb2uK2P/pQWT7rZzqiA0Lobg49mKH
	 tvC/Q64Ou0kRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	krzk@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 233/642] soc: samsung: include linux/array_size.h where needed
Date: Mon,  5 May 2025 18:07:29 -0400
Message-Id: <20250505221419.2672473-233-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 95294462ff211..99c5f9c80101b 100644
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


