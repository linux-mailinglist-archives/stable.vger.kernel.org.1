Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C19879F1C5
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 21:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjIMTLL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 15:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjIMTLL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 15:11:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233771999
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 12:11:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3B8C433C7;
        Wed, 13 Sep 2023 19:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694632266;
        bh=N3F/rTqXy38K/OzZNI1pVJNLif1DjiR0MrBhUMQzlkE=;
        h=Subject:To:Cc:From:Date:From;
        b=zEqtb8jNelWKxcmMh7bOzdaS2IobneHypryDPsqw9YSv+DlKkzCFJsEc4hJ8TbDx2
         kuLlZ60aJP0ggNzXgI2fdcvrXmqE7XjKS8HA3cFTtt/H0rs3yecssTx32O4MOSujtb
         U/nNtTy814mLFGsRpwWLCkesI+BXzUdP6dVBDGHk=
Subject: FAILED: patch "[PATCH] clk: qcom: mss-sc7180: fix missing resume during probe" failed to apply to 5.10-stable tree
To:     johan+linaro@kernel.org, andersson@kernel.org,
        quic_tdas@quicinc.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 13 Sep 2023 21:11:03 +0200
Message-ID: <2023091302-payer-bless-094d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e2349da0fa7ca822cda72f427345b95795358fe7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091302-payer-bless-094d@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

e2349da0fa7c ("clk: qcom: mss-sc7180: fix missing resume during probe")
72cfc73f4663 ("clk: qcom: use devm_pm_runtime_enable and devm_pm_clk_create")
ce8c195e652f ("clk: qcom: lpasscc: Introduce pm autosuspend for SC7180")
8d4025943e13 ("clk: qcom: camcc-sc7180: Use runtime PM ops instead of clk ones")
a2d8f507803e ("clk: qcom: Add support to LPASS AUDIO_CC Glitch Free Mux clocks")
4ee9fe3e292b ("clk: qcom: lpass-sc7180: Disentangle the two clock devices")
7635622b77b5 ("clk: qcom: lpasscc-sc7810: Use devm in probe")
15d09e830bbc ("clk: qcom: camcc: Add camera clock controller driver for SC7180")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e2349da0fa7ca822cda72f427345b95795358fe7 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Tue, 18 Jul 2023 15:29:01 +0200
Subject: [PATCH] clk: qcom: mss-sc7180: fix missing resume during probe

Drivers that enable runtime PM must make sure that the controller is
runtime resumed before accessing its registers to prevent the power
domain from being disabled.

Fixes: 8def929c4097 ("clk: qcom: Add modem clock controller driver for SC7180")
Cc: stable@vger.kernel.org      # 5.7
Cc: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20230718132902.21430-8-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/drivers/clk/qcom/mss-sc7180.c b/drivers/clk/qcom/mss-sc7180.c
index 5a1407440662..d106bc65470e 100644
--- a/drivers/clk/qcom/mss-sc7180.c
+++ b/drivers/clk/qcom/mss-sc7180.c
@@ -87,11 +87,22 @@ static int mss_sc7180_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret)
+		return ret;
+
 	ret = qcom_cc_probe(pdev, &mss_sc7180_desc);
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
 
 static const struct dev_pm_ops mss_sc7180_pm_ops = {

