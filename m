Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5382C6FA5DB
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbjEHKNt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbjEHKNh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:13:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39AB22F58
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:13:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A99D62428
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F507C433EF;
        Mon,  8 May 2023 10:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540810;
        bh=/lAsQmWa93y1/iPWwyBwlZ1Uz4b/QRa/wBsOKLMC9Ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M6F1Aj8hdqAPLhmJAngPzMtmitZXkEmLiS3URgm3oUOlI7edwio3YFH8fe7SWuibr
         ixipcEoMlYiPqUmtzx1Wvpt6bpiyFbWdSvDyelIgMNrT0stZMPHZGjSbFkoQ6EEOT1
         uWX2RJ6cN6A2HeZ3nyR7fmAQUcA7Um9VXq921FsE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 506/611] clk: qcom: lpasscc-sc7280: Skip qdsp6ss clock registration
Date:   Mon,  8 May 2023 11:45:48 +0200
Message-Id: <20230508094438.509595629@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>

[ Upstream commit 4fc1c2d9a2b7a394f3b873aae5e03bffd8b5cd31 ]

The qdsp6ss memory region is being shared by ADSP remoteproc device and
lpasscc clock device, hence causing memory conflict.
To avoid this, when qdsp6ss clocks are being enabled in remoteproc driver,
skip qdsp6ss clock registration if "qcom,adsp-pil-mode" is enabled and
also assign max_register value.

Fixes: 4ab43d171181 ("clk: qcom: Add lpass clock controller driver for SC7280")
Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230407092255.119690-3-quic_mohs@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/lpasscc-sc7280.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc-sc7280.c
index 5c1e17bd0d763..8486d7135ab10 100644
--- a/drivers/clk/qcom/lpasscc-sc7280.c
+++ b/drivers/clk/qcom/lpasscc-sc7280.c
@@ -118,14 +118,18 @@ static int lpass_cc_sc7280_probe(struct platform_device *pdev)
 		goto destroy_pm_clk;
 	}
 
-	lpass_regmap_config.name = "qdsp6ss";
-	desc = &lpass_qdsp6ss_sc7280_desc;
-
-	ret = qcom_cc_probe_by_index(pdev, 0, desc);
-	if (ret)
-		goto destroy_pm_clk;
+	if (!of_property_read_bool(pdev->dev.of_node, "qcom,adsp-pil-mode")) {
+		lpass_regmap_config.name = "qdsp6ss";
+		lpass_regmap_config.max_register = 0x3f;
+		desc = &lpass_qdsp6ss_sc7280_desc;
+
+		ret = qcom_cc_probe_by_index(pdev, 0, desc);
+		if (ret)
+			goto destroy_pm_clk;
+	}
 
 	lpass_regmap_config.name = "top_cc";
+	lpass_regmap_config.max_register = 0x4;
 	desc = &lpass_cc_top_sc7280_desc;
 
 	ret = qcom_cc_probe_by_index(pdev, 1, desc);
-- 
2.39.2



