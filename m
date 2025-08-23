Return-Path: <stable+bounces-172549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0263CB326BB
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 05:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B220D5867B2
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 03:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F1F205E26;
	Sat, 23 Aug 2025 03:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwTYVlMt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE31FECAD
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 03:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755921291; cv=none; b=OtBHJzSnFa7sBx84blkBveTqFn1ywvjHdP+M44MpxI1bixaRN+yoL4FV+hPKFp6FiHTcDC848gbLzGlSoxdYdUN3VVEV5CDewF0TVgOuCeRyi3xI3Xf4ZQVEbqDHEiXWOS71wWytiJcQV15H49k4DSU3UzM/lws+qQRXJeKTgvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755921291; c=relaxed/simple;
	bh=t1iPZJC3/npInDLtqcm5zdfteBCCRi4BHmWFjGM6yeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRdHhekvXakzGL7bTL+ZS7di8xOGHEm1OJuH3rX35N4+SAeodAzo2Zjflmt4qCPiZqf3wT6h9PjpWikePlXCLBuxM6Q4tT0iB3/j467jgTv44jfIjmSjOgqpAwrCpuZLLfgUjax34wNcy4W/lYEuUBcAEZksRseCrC39mgcU9eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwTYVlMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31264C4CEE7;
	Sat, 23 Aug 2025 03:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755921290;
	bh=t1iPZJC3/npInDLtqcm5zdfteBCCRi4BHmWFjGM6yeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VwTYVlMts5jPYreW13viG9l5nsheHStlxad6fvMjon8gFFJbL+zvMCKcear2PYbXJ
	 euaQa3TGcAHZD1hAw1ZLV3/lEUm+Lvlq2sSjWHyzt6+gn00uBlN/6bcND7syGk9Q39
	 3VsN3IvA0XAcF62IBpRnq/yfFM+/GDX73ZjLDos2WhosIs8NNuNoF4Y3cUwBgTx5Do
	 aNnMrQG+d+k/R78dzaaiYTirf7s+V/Nd5R7nTdBrHmrWCskirb8mJzPmq3vkAFoNJP
	 u4FK99UR9GUOqTaLLLYHGl636lARnJ1GjOZHVd84mkYvu2SK01kvlSca8UMFyfKn7a
	 t3y/hhbTari/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] media: venus: Add support for SSR trigger using fault injection
Date: Fri, 22 Aug 2025 23:54:47 -0400
Message-ID: <20250823035448.1818703-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082151-mummified-annoying-20b6@gregkh>
References: <2025082151-mummified-annoying-20b6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dikshita Agarwal <quic_dikshita@quicinc.com>

[ Upstream commit 748b080f21678f2988b0da2d2b396a6f928d9b2c ]

Here we introduce a new fault injection for SSR trigger.

To trigger the SSR:
 echo 100 >  /sys/kernel/debug/venus/fail_ssr/probability
 echo 1 >  /sys/kernel/debug/venus/fail_ssr/times

Co-developed-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Stable-dep-of: 3200144a2fa4 ("media: venus: protect against spurious interrupts during probe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/venus/core.c  | 15 ++++++++++++++-
 drivers/media/platform/qcom/venus/dbgfs.c |  9 +++++++++
 drivers/media/platform/qcom/venus/dbgfs.h | 13 +++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index b8bbd9d71b79..a40b0a817e19 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -220,6 +220,19 @@ static void venus_assign_register_offsets(struct venus_core *core)
 	core->wrapper_base = core->base + WRAPPER_BASE;
 }
 
+static irqreturn_t venus_isr_thread(int irq, void *dev_id)
+{
+	struct venus_core *core = dev_id;
+	irqreturn_t ret;
+
+	ret = hfi_isr_thread(irq, dev_id);
+
+	if (ret == IRQ_HANDLED && venus_fault_inject_ssr())
+		hfi_core_trigger_ssr(core, HFI_TEST_SSR_SW_ERR_FATAL);
+
+	return ret;
+}
+
 static int venus_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -276,7 +289,7 @@ static int venus_probe(struct platform_device *pdev)
 	mutex_init(&core->lock);
 	INIT_DELAYED_WORK(&core->work, venus_sys_error_handler);
 
-	ret = devm_request_threaded_irq(dev, core->irq, hfi_isr, hfi_isr_thread,
+	ret = devm_request_threaded_irq(dev, core->irq, hfi_isr, venus_isr_thread,
 					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
 					"venus", core);
 	if (ret)
diff --git a/drivers/media/platform/qcom/venus/dbgfs.c b/drivers/media/platform/qcom/venus/dbgfs.c
index 52de47f2ca88..726f4b730e69 100644
--- a/drivers/media/platform/qcom/venus/dbgfs.c
+++ b/drivers/media/platform/qcom/venus/dbgfs.c
@@ -4,13 +4,22 @@
  */
 
 #include <linux/debugfs.h>
+#include <linux/fault-inject.h>
 
 #include "core.h"
 
+#ifdef CONFIG_FAULT_INJECTION
+DECLARE_FAULT_ATTR(venus_ssr_attr);
+#endif
+
 void venus_dbgfs_init(struct venus_core *core)
 {
 	core->root = debugfs_create_dir("venus", NULL);
 	debugfs_create_x32("fw_level", 0644, core->root, &venus_fw_debug);
+
+#ifdef CONFIG_FAULT_INJECTION
+	fault_create_debugfs_attr("fail_ssr", core->root, &venus_ssr_attr);
+#endif
 }
 
 void venus_dbgfs_deinit(struct venus_core *core)
diff --git a/drivers/media/platform/qcom/venus/dbgfs.h b/drivers/media/platform/qcom/venus/dbgfs.h
index b7b621a8472f..c87c1355d039 100644
--- a/drivers/media/platform/qcom/venus/dbgfs.h
+++ b/drivers/media/platform/qcom/venus/dbgfs.h
@@ -4,8 +4,21 @@
 #ifndef __VENUS_DBGFS_H__
 #define __VENUS_DBGFS_H__
 
+#include <linux/fault-inject.h>
+
 struct venus_core;
 
+#ifdef CONFIG_FAULT_INJECTION
+extern struct fault_attr venus_ssr_attr;
+static inline bool venus_fault_inject_ssr(void)
+{
+	return should_fail(&venus_ssr_attr, 1);
+}
+#else
+static inline bool venus_fault_inject_ssr(void) { return false; }
+#endif
+
+
 void venus_dbgfs_init(struct venus_core *core);
 void venus_dbgfs_deinit(struct venus_core *core);
 
-- 
2.50.1


