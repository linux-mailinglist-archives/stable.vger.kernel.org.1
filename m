Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D72D79BADC
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378706AbjIKWgn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239004AbjIKOJW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:09:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42EDCF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:09:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AB1C433C7;
        Mon, 11 Sep 2023 14:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441357;
        bh=EAt7e+up0DX7Djs1TryMLYgKJzmlfeQCdgtYXU09g10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S64+dlQWF2STwMDnVqelE3P1iMmT5pChFwJsO8p1Pp8vEQveU5JzED1JiLufU6kvG
         6xkytRj8tMK+IT/XSJzIHFD+MwQtz9rZ6QcxFPzUfTEesAoQoQkM85jFUAJdLi6jII
         oU7TliUXbeOtreh6YtyZkioLJ3g+B6M3SRnfqAfg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 385/739] clk: qcom: gcc-sc8280xp: fix runtime PM imbalance on probe errors
Date:   Mon, 11 Sep 2023 15:43:04 +0200
Message-ID: <20230911134701.946550193@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan+linaro@kernel.org>

[ Upstream commit 10192ab375c39c58d39cba028d9685cefe1ca3c2 ]

Make sure to decrement the runtime PM usage count before returning in
case RCG dynamic frequency switch initialisation fails.

Fixes: 2a541abd9837 ("clk: qcom: gcc-sc8280xp: Add runtime PM")
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20230718132902.21430-5-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-sc8280xp.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
index 3e1a62fa3a074..4d1133406ae05 100644
--- a/drivers/clk/qcom/gcc-sc8280xp.c
+++ b/drivers/clk/qcom/gcc-sc8280xp.c
@@ -7539,8 +7539,8 @@ static int gcc_sc8280xp_probe(struct platform_device *pdev)
 
 	regmap = qcom_cc_map(pdev, &gcc_sc8280xp_desc);
 	if (IS_ERR(regmap)) {
-		pm_runtime_put(&pdev->dev);
-		return PTR_ERR(regmap);
+		ret = PTR_ERR(regmap);
+		goto err_put_rpm;
 	}
 
 	/*
@@ -7561,11 +7561,19 @@ static int gcc_sc8280xp_probe(struct platform_device *pdev)
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks, ARRAY_SIZE(gcc_dfs_clocks));
 	if (ret)
-		return ret;
+		goto err_put_rpm;
 
 	ret = qcom_cc_really_probe(pdev, &gcc_sc8280xp_desc, regmap);
+	if (ret)
+		goto err_put_rpm;
+
 	pm_runtime_put(&pdev->dev);
 
+	return 0;
+
+err_put_rpm:
+	pm_runtime_put_sync(&pdev->dev);
+
 	return ret;
 }
 
-- 
2.40.1



