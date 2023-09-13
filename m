Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B006179F1C2
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 21:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjIMTKi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 15:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjIMTKi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 15:10:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8251999
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 12:10:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F61C433C8;
        Wed, 13 Sep 2023 19:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694632234;
        bh=1QXCFxBoh3NlnzgWiDD+lmaMBHTKUw4WFWvJUlcahRM=;
        h=Subject:To:Cc:From:Date:From;
        b=SBwhMTo7dASifMcm0YGblYCZTBTjdWQH19enr7JCrt7ryF+FogmC0SK/JAlXUhiWE
         OusLbZEkZ0KKLDfK6RdxEYNxhU0q6h5vQYTHTpzVJ6ijmpofh1nUyrau2uZHcUsY1/
         hkaJkg93MryaPRtG75ICd5VfFGH8EOMoZkPM00ZM=
Subject: FAILED: patch "[PATCH] clk: qcom: q6sstop-qcs404: fix missing resume during probe" failed to apply to 5.10-stable tree
To:     johan+linaro@kernel.org, andersson@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 13 Sep 2023 21:10:30 +0200
Message-ID: <2023091329-grudging-engraver-d7b5@gregkh>
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
git cherry-pick -x 97112c83f4671a4a722f99a53be4e91fac4091bc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091329-grudging-engraver-d7b5@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

97112c83f467 ("clk: qcom: q6sstop-qcs404: fix missing resume during probe")
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

From 97112c83f4671a4a722f99a53be4e91fac4091bc Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Tue, 18 Jul 2023 15:29:00 +0200
Subject: [PATCH] clk: qcom: q6sstop-qcs404: fix missing resume during probe

Drivers that enable runtime PM must make sure that the controller is
runtime resumed before accessing its registers to prevent the power
domain from being disabled.

Fixes: 6cdef2738db0 ("clk: qcom: Add Q6SSTOP clock controller for QCS404")
Cc: stable@vger.kernel.org      # 5.5
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20230718132902.21430-7-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/drivers/clk/qcom/q6sstop-qcs404.c b/drivers/clk/qcom/q6sstop-qcs404.c
index 780074e05841..26e2d63614ac 100644
--- a/drivers/clk/qcom/q6sstop-qcs404.c
+++ b/drivers/clk/qcom/q6sstop-qcs404.c
@@ -174,21 +174,32 @@ static int q6sstopcc_qcs404_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret)
+		return ret;
+
 	q6sstop_regmap_config.name = "q6sstop_tcsr";
 	desc = &tcsr_qcs404_desc;
 
 	ret = qcom_cc_probe_by_index(pdev, 1, desc);
 	if (ret)
-		return ret;
+		goto err_put_rpm;
 
 	q6sstop_regmap_config.name = "q6sstop_cc";
 	desc = &q6sstop_qcs404_desc;
 
 	ret = qcom_cc_probe_by_index(pdev, 0, desc);
 	if (ret)
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
 
 static const struct dev_pm_ops q6sstopcc_pm_ops = {

