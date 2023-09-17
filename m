Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407C97A392E
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239992AbjIQTqK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239969AbjIQTph (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:45:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD05EE7
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:45:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3565C433C8;
        Sun, 17 Sep 2023 19:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979932;
        bh=Z5vACDYnhDiJvy+1UfnUT7QZfxfG31KrBRMU2TrcjGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tYaTt8tJ7ZVkJ2icfxlEyaZc8dcAmS2Nvw2bOz07YyJ1M7P7TGuDIOVqZ7Ce96Kl8
         Z7ZR1sH8XeOFqZ9pUmejilUuQu/2sHMK0xQrV5+2ch45MFkrvMNqTg/4VzPzHJsH3K
         ZeCzTUUNTR7Of8QTr69mQeJtRO8SYn/uS3IIlui4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.5 049/285] clk: qcom: dispcc-sm8550: fix runtime PM imbalance on probe errors
Date:   Sun, 17 Sep 2023 21:10:49 +0200
Message-ID: <20230917191053.375624870@linuxfoundation.org>
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

commit acaf1b3296a504d4a61b685f78baae771421608d upstream.

Make sure to decrement the runtime PM usage count before returning in
case regmap initialisation fails.

Fixes: 90114ca11476 ("clk: qcom: add SM8550 DISPCC driver")
Cc: stable@vger.kernel.org      # 6.3
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20230718132902.21430-4-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/qcom/dispcc-sm8550.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/drivers/clk/qcom/dispcc-sm8550.c
+++ b/drivers/clk/qcom/dispcc-sm8550.c
@@ -1761,8 +1761,10 @@ static int disp_cc_sm8550_probe(struct p
 		return ret;
 
 	regmap = qcom_cc_map(pdev, &disp_cc_sm8550_desc);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		goto err_put_rpm;
+	}
 
 	clk_lucid_evo_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
 	clk_lucid_evo_pll_configure(&disp_cc_pll1, regmap, &disp_cc_pll1_config);
@@ -1777,9 +1779,16 @@ static int disp_cc_sm8550_probe(struct p
 	regmap_update_bits(regmap, 0xe054, BIT(0), BIT(0));
 
 	ret = qcom_cc_really_probe(pdev, &disp_cc_sm8550_desc, regmap);
+	if (ret)
+		goto err_put_rpm;
 
 	pm_runtime_put(&pdev->dev);
 
+	return 0;
+
+err_put_rpm:
+	pm_runtime_put_sync(&pdev->dev);
+
 	return ret;
 }
 


