Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08A679F19F
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 21:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjIMTDr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 15:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjIMTDq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 15:03:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDFC170F
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 12:03:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E33EC433C9;
        Wed, 13 Sep 2023 19:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694631822;
        bh=l9+c5knDSZPCm5dL6TEhsWOHUQ3XDzecoFCE1rDDx7w=;
        h=Subject:To:Cc:From:Date:From;
        b=mnTjUqI+wxlCalQSWvRs2jHKDJpJEuMLwkvPZII/oPWZOrjrAxO/0T76R8bzE8pwB
         vAixr1UWdq+aD1t8+O5rVJOe9yVbaaCPzQSyIx0xgcVNA3ruMquTTqgg/ONr2Aq6aZ
         RFDMQLQVKRHnKEN+u3MXSwZL5zRYYt9uTpgylS04=
Subject: FAILED: patch "[PATCH] clk: qcom: turingcc-qcs404: fix missing resume during probe" failed to apply to 5.4-stable tree
To:     johan+linaro@kernel.org, andersson@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 13 Sep 2023 21:03:35 +0200
Message-ID: <2023091335-rubbed-whole-cf19@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x a9f71a033587c9074059132d34c74eabbe95ef26
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091335-rubbed-whole-cf19@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

a9f71a033587 ("clk: qcom: turingcc-qcs404: fix missing resume during probe")
72cfc73f4663 ("clk: qcom: use devm_pm_runtime_enable and devm_pm_clk_create")
ce8c195e652f ("clk: qcom: lpasscc: Introduce pm autosuspend for SC7180")
8d4025943e13 ("clk: qcom: camcc-sc7180: Use runtime PM ops instead of clk ones")
a2d8f507803e ("clk: qcom: Add support to LPASS AUDIO_CC Glitch Free Mux clocks")
4ee9fe3e292b ("clk: qcom: lpass-sc7180: Disentangle the two clock devices")
7635622b77b5 ("clk: qcom: lpasscc-sc7810: Use devm in probe")
15d09e830bbc ("clk: qcom: camcc: Add camera clock controller driver for SC7180")
d2249bf25c56 ("clk: qcom: lpass: Correct goto target in lpass_core_sc7180_probe()")
edab812d802d ("clk: qcom: lpass: Add support for LPASS clock controller for SC7180")
ecd2bacfbbc4 ("clk: qcom: Add ipq apss pll driver")
8def929c4097 ("clk: qcom: Add modem clock controller driver for SC7180")
253dc75a0bb8 ("clk: qcom: Add video clock controller driver for SC7180")
745ff069a49c ("clk: qcom: Add graphics clock controller driver for SC7180")
dd3d06622138 ("clk: qcom: Add display clock controller driver for SC7180")
17269568f726 ("clk: qcom: Add Global Clock controller (GCC) driver for SC7180")
6cdef2738db0 ("clk: qcom: Add Q6SSTOP clock controller for QCS404")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a9f71a033587c9074059132d34c74eabbe95ef26 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Tue, 18 Jul 2023 15:29:02 +0200
Subject: [PATCH] clk: qcom: turingcc-qcs404: fix missing resume during probe

Drivers that enable runtime PM must make sure that the controller is
runtime resumed before accessing its registers to prevent the power
domain from being disabled.

Fixes: 892df0191b29 ("clk: qcom: Add QCS404 TuringCC")
Cc: stable@vger.kernel.org      # 5.2
Cc: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20230718132902.21430-9-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/drivers/clk/qcom/turingcc-qcs404.c b/drivers/clk/qcom/turingcc-qcs404.c
index 43184459228f..2cd288d6c3e4 100644
--- a/drivers/clk/qcom/turingcc-qcs404.c
+++ b/drivers/clk/qcom/turingcc-qcs404.c
@@ -125,11 +125,22 @@ static int turingcc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret)
+		return ret;
+
 	ret = qcom_cc_probe(pdev, &turingcc_desc);
 	if (ret < 0)
-		return ret;
+		goto err_put_rpm;
+
+	pm_runtime_put(&pdev->dev);
 
 	return 0;
+
+err_put_rpm:
+	pm_runtime_put_sync(&pdev->dev);
+
+	return ret;
 }
 
 static const struct dev_pm_ops turingcc_pm_ops = {

