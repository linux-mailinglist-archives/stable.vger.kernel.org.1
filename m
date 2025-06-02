Return-Path: <stable+bounces-149472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A68CACB307
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136361946D04
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BDC2397AA;
	Mon,  2 Jun 2025 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yAPq2i4V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14401E0DD8;
	Mon,  2 Jun 2025 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874064; cv=none; b=LmmbLv2A72dpcXDPTeG3uUjEw/YzYL1mq4HpJ28Cea4Dey5AXXC9XLHGmD+7GIBzR0CfT0Iy142PnjNQRCMJkFkx3HbeKCksygHAoOC+gJsPfxRjL8nBx5WZU1lAZpz6EV/KGpVJOogZRw4+6iR9eKrxdPlgVwNDMH0hce8YgwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874064; c=relaxed/simple;
	bh=+63fiWr73XY87sKUYh0qUJbtFfH7c90B5gErEpaNCrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Smt8eBV13Ylv5OySBtLpw0fay8yLUBiTGkl8jSTJmtYQT3lIhSnj8Uf/H2f9nxsaemrBinNqpjIdalX5+Lur+ChGahQSZScBOreCWshxz/OrxH5yBABuI+gHfkV7fjTv0g/IXUWX9/Ka7E4N97zeiBPxBnqF9PmIMobb88/BuaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yAPq2i4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1263FC4CEEB;
	Mon,  2 Jun 2025 14:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748874064;
	bh=+63fiWr73XY87sKUYh0qUJbtFfH7c90B5gErEpaNCrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yAPq2i4V/gDSWRBAJauUVpPUiAKz0OP1lTZbDrL7kGYyplczdTgvxp5aNcw57BIaY
	 wAo5eR7ZGwrBF3uJTCLResTH+cK+F3HcaISG/hTGaJ+8JneLeos5J1/tMJ8cjoVs/N
	 ofRnBadehueMnXMnhfwRmd95hBa5gFrvRUlF6L5o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 346/444] pinctrl: qcom: switch to devm_register_sys_off_handler()
Date: Mon,  2 Jun 2025 15:46:50 +0200
Message-ID: <20250602134354.980439144@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
References: <20250602134340.906731340@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

[ Upstream commit 41e452e6933d14146381ea25cff5e4d1ac2abea1 ]

Error-handling paths in msm_pinctrl_probe() don't call
a function required to unroll restart handler registration,
unregister_restart_handler(). Instead of adding calls to this function,
switch the msm pinctrl code into using devm_register_sys_off_handler().

Fixes: cf1fc1876289 ("pinctrl: qcom: use restart_notifier mechanism for ps_hold")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://lore.kernel.org/20250513-pinctrl-msm-fix-v2-2-249999af0fc1@oss.qualcomm.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 4714d60f9ab9c..ed70767ca0f0c 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -43,7 +43,6 @@
  * @pctrl:          pinctrl handle.
  * @chip:           gpiochip handle.
  * @desc:           pin controller descriptor
- * @restart_nb:     restart notifier block.
  * @irq:            parent irq for the TLMM irq_chip.
  * @intr_target_use_scm: route irq to application cpu using scm calls
  * @lock:           Spinlock to protect register resources as well
@@ -63,7 +62,6 @@ struct msm_pinctrl {
 	struct pinctrl_dev *pctrl;
 	struct gpio_chip chip;
 	struct pinctrl_desc desc;
-	struct notifier_block restart_nb;
 
 	int irq;
 
@@ -1424,10 +1422,9 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	return 0;
 }
 
-static int msm_ps_hold_restart(struct notifier_block *nb, unsigned long action,
-			       void *data)
+static int msm_ps_hold_restart(struct sys_off_data *data)
 {
-	struct msm_pinctrl *pctrl = container_of(nb, struct msm_pinctrl, restart_nb);
+	struct msm_pinctrl *pctrl = data->cb_data;
 
 	writel(0, pctrl->regs[0] + PS_HOLD_OFFSET);
 	mdelay(1000);
@@ -1438,7 +1435,11 @@ static struct msm_pinctrl *poweroff_pctrl;
 
 static void msm_ps_hold_poweroff(void)
 {
-	msm_ps_hold_restart(&poweroff_pctrl->restart_nb, 0, NULL);
+	struct sys_off_data data = {
+		.cb_data = poweroff_pctrl,
+	};
+
+	msm_ps_hold_restart(&data);
 }
 
 static void msm_pinctrl_setup_pm_reset(struct msm_pinctrl *pctrl)
@@ -1448,9 +1449,11 @@ static void msm_pinctrl_setup_pm_reset(struct msm_pinctrl *pctrl)
 
 	for (i = 0; i < pctrl->soc->nfunctions; i++)
 		if (!strcmp(func[i].name, "ps_hold")) {
-			pctrl->restart_nb.notifier_call = msm_ps_hold_restart;
-			pctrl->restart_nb.priority = 128;
-			if (register_restart_handler(&pctrl->restart_nb))
+			if (devm_register_sys_off_handler(pctrl->dev,
+							  SYS_OFF_MODE_RESTART,
+							  128,
+							  msm_ps_hold_restart,
+							  pctrl))
 				dev_err(pctrl->dev,
 					"failed to setup restart handler.\n");
 			poweroff_pctrl = pctrl;
@@ -1552,8 +1555,6 @@ void msm_pinctrl_remove(struct platform_device *pdev)
 	struct msm_pinctrl *pctrl = platform_get_drvdata(pdev);
 
 	gpiochip_remove(&pctrl->chip);
-
-	unregister_restart_handler(&pctrl->restart_nb);
 }
 EXPORT_SYMBOL(msm_pinctrl_remove);
 
-- 
2.39.5




