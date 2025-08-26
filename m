Return-Path: <stable+bounces-175400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE119B3682E
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC3F1C21173
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC74352089;
	Tue, 26 Aug 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gPlwf3oT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FEE352061;
	Tue, 26 Aug 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216938; cv=none; b=TrOQwmWvpTUZvbKMiw4y5wTy5bvgaDPaT6SNLEr5c0xdWjAMcTu5UN8nF0meBDXg/iv19y776F8IERhFF3pXPriZbhWIhQOzUUsW531ctwMxhU94DLvFR5fbXCyixGiJirWqXyusjmWnhA6qHkhuXbe364wX2FEGWIqtIOdWkR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216938; c=relaxed/simple;
	bh=OFzU6erFCcr9kmG1vUcqZuySdA74Z4vXRBoZSsH/1Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOYYsQEqVhgmymXwm3OFDmGr8XT9QF8RA3P3axrO8uNUkmijvmym5JPNS7e+6z/aTA5ag87IpYJh9YflQ9GHPBr82RuhAd7/o1islrxDtLiAvSdCj2+H5hmLwU8pWfcGnGus9d6Uz4a2U45agymdC9BKjRY/zd93hjbifIBjGdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gPlwf3oT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF339C4CEF1;
	Tue, 26 Aug 2025 14:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216938;
	bh=OFzU6erFCcr9kmG1vUcqZuySdA74Z4vXRBoZSsH/1Og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gPlwf3oTJZ0DdMkXPeCU21Lf7lOPT3Aaa7mQEVcX/QYwy1Z/B34EqYFfCMSBn3EBt
	 UBGlmhUPzUNO7Hl6AzH4b9dJMgrplffVM1YEF/pcRs/xdOziHKwzeq3HkSSD5sO3J6
	 Uv0Z961RF1MuGVJPkoOpmPjlkB4klI5EJn3ujGWU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 598/644] media: venus: Add support for SSR trigger using fault injection
Date: Tue, 26 Aug 2025 13:11:29 +0200
Message-ID: <20250826111001.362903801@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/qcom/venus/core.c  |   15 ++++++++++++++-
 drivers/media/platform/qcom/venus/dbgfs.c |    9 +++++++++
 drivers/media/platform/qcom/venus/dbgfs.h |   13 +++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -263,6 +263,19 @@ static void venus_assign_register_offset
 	}
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
@@ -319,7 +332,7 @@ static int venus_probe(struct platform_d
 	mutex_init(&core->lock);
 	INIT_DELAYED_WORK(&core->work, venus_sys_error_handler);
 
-	ret = devm_request_threaded_irq(dev, core->irq, hfi_isr, hfi_isr_thread,
+	ret = devm_request_threaded_irq(dev, core->irq, hfi_isr, venus_isr_thread,
 					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
 					"venus", core);
 	if (ret)
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
 



