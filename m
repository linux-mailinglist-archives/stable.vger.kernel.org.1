Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC267A392F
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbjIQTqL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239995AbjIQTpo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:45:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7C0103
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:45:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16A6C433C8;
        Sun, 17 Sep 2023 19:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979939;
        bh=Dc/PP+qRafiMYzgPkSHf9AXyGzVXhJaKYcN8FWxKtjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uF1DsGA+kgZI/pENyVJMG6HkPZzBmZpld52PbuD2cL/mWz0qOxfO474HzOpBT4gjy
         g18grftVZtUgOWi1xcmrNKj2Zg9T1rkakkDj5VECPAewXav3kqvxqSpaogHTsuqgBd
         cfzdNYQt/dbL41vh6XwHekcsnuKjVmQ/3HPwpaYs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.5 051/285] clk: qcom: q6sstop-qcs404: fix missing resume during probe
Date:   Sun, 17 Sep 2023 21:10:51 +0200
Message-ID: <20230917191053.448740115@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan+linaro@kernel.org>

commit 97112c83f4671a4a722f99a53be4e91fac4091bc upstream.

Drivers that enable runtime PM must make sure that the controller is
runtime resumed before accessing its registers to prevent the power
domain from being disabled.

Fixes: 6cdef2738db0 ("clk: qcom: Add Q6SSTOP clock controller for QCS404")
Cc: stable@vger.kernel.org      # 5.5
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20230718132902.21430-7-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/qcom/q6sstop-qcs404.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/drivers/clk/qcom/q6sstop-qcs404.c
+++ b/drivers/clk/qcom/q6sstop-qcs404.c
@@ -174,21 +174,32 @@ static int q6sstopcc_qcs404_probe(struct
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


