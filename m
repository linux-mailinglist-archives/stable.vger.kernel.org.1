Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421B3755173
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjGPT4e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjGPT4d (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:56:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA0E1B4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:56:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41E1D60EB6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585BBC433C7;
        Sun, 16 Jul 2023 19:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537389;
        bh=VaHn9j9LJHFjUAoW75KxO4W/zyvUtVwZford8A5jHMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eNodYSMJVcCUPtk19EKDcKRuqCFfgfmHe5d39SY5yMURmYGTCGD7Mf99tG+Uln9Sy
         JzsSsO6M5PILxsiCu3zxEWhfPQpWblBbovz1h+UK7W4YGE3Ob2nfkfT8//A1+gager
         5FGsI5c4+j+SRpqo5HSvPkFoz/Lh4s3SlIERnTuQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 078/800] thermal/drivers/qcom/tsens-v0_1: Add mdm9607 correction offsets
Date:   Sun, 16 Jul 2023 21:38:51 +0200
Message-ID: <20230716194950.916995218@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Stephan Gerhold <stephan.gerhold@kernkonzept.com>

[ Upstream commit b6f739da0070c36655118618a173a59fa14c7adc ]

According to the msm-3.18 vendor kernel from Qualcomm, mdm9607 needs
"correction factors" to adjust for additional offsets observed after the
factory calibration values in the fuses [1, 2].

The fixed offsets should be applied unless there is a special
calibration mode value that indicates that no offsets are needed [3].

Note that the new calibration mode values are called differently in this
patch compared to the vendor kernel:
  - TSENS_TWO_POINT_CALIB_N_WA        -> ONE_PT_CALIB2_NO_OFFSET
  - TSENS_TWO_POINT_CALIB_N_OFFSET_WA -> TWO_PT_CALIB_NO_OFFSET
This is because close inspection of the calibration function [3] reveals
that TSENS_TWO_POINT_CALIB_N_WA is actually a "one point" calibration
because the if statements skip all "point2" related code for it.

[1]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/commit/d9d2db1b82bf3f72f5de0803d55e6849eb5b671e
[2]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/commit/d75aef53a760e8ff7bac54049d00c8b2ee1b193e
[3]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LE.UM.4.3.2.r1-04200-9x07/drivers/thermal/msm-tsens.c#L2987-3136

Fixes: a2149ab815fc ("thermal/drivers/qcom/tsens-v0_1: Add support for MDM9607")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230508-msm8909-tsens-v5-3-5eb632235ba7@kernkonzept.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/qcom/tsens-v0_1.c | 11 +++++++++++
 drivers/thermal/qcom/tsens.c      | 16 +++++++++++++++-
 drivers/thermal/qcom/tsens.h      |  4 ++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index e89a0da4b4e14..e9ce7b62b3818 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -277,6 +277,17 @@ static int __init init_9607(struct tsens_priv *priv)
 	for (i = 0; i < priv->num_sensors; ++i)
 		priv->sensor[i].slope = 3000;
 
+	priv->sensor[0].p1_calib_offset = 1;
+	priv->sensor[0].p2_calib_offset = 1;
+	priv->sensor[1].p1_calib_offset = -4;
+	priv->sensor[1].p2_calib_offset = -2;
+	priv->sensor[2].p1_calib_offset = 4;
+	priv->sensor[2].p2_calib_offset = 8;
+	priv->sensor[3].p1_calib_offset = -3;
+	priv->sensor[3].p2_calib_offset = -5;
+	priv->sensor[4].p1_calib_offset = -4;
+	priv->sensor[4].p2_calib_offset = -4;
+
 	return init_common(priv);
 }
 
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 1c457b55efb39..9dd5e4b709117 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -134,10 +134,12 @@ int tsens_read_calibration(struct tsens_priv *priv, int shift, u32 *p1, u32 *p2,
 			p1[i] = p1[i] + (base1 << shift);
 		break;
 	case TWO_PT_CALIB:
+	case TWO_PT_CALIB_NO_OFFSET:
 		for (i = 0; i < priv->num_sensors; i++)
 			p2[i] = (p2[i] + base2) << shift;
 		fallthrough;
 	case ONE_PT_CALIB2:
+	case ONE_PT_CALIB2_NO_OFFSET:
 		for (i = 0; i < priv->num_sensors; i++)
 			p1[i] = (p1[i] + base1) << shift;
 		break;
@@ -149,6 +151,18 @@ int tsens_read_calibration(struct tsens_priv *priv, int shift, u32 *p1, u32 *p2,
 		}
 	}
 
+	/* Apply calibration offset workaround except for _NO_OFFSET modes */
+	switch (mode) {
+	case TWO_PT_CALIB:
+		for (i = 0; i < priv->num_sensors; i++)
+			p2[i] += priv->sensor[i].p2_calib_offset;
+		fallthrough;
+	case ONE_PT_CALIB2:
+		for (i = 0; i < priv->num_sensors; i++)
+			p1[i] += priv->sensor[i].p1_calib_offset;
+		break;
+	}
+
 	return mode;
 }
 
@@ -254,7 +268,7 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 
 		if (!priv->sensor[i].slope)
 			priv->sensor[i].slope = SLOPE_DEFAULT;
-		if (mode == TWO_PT_CALIB) {
+		if (mode == TWO_PT_CALIB || mode == TWO_PT_CALIB_NO_OFFSET) {
 			/*
 			 * slope (m) = adc_code2 - adc_code1 (y2 - y1)/
 			 *	temp_120_degc - temp_30_degc (x2 - x1)
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 433eba370998c..1cd8f4fe0971f 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -10,6 +10,8 @@
 #define ONE_PT_CALIB		0x1
 #define ONE_PT_CALIB2		0x2
 #define TWO_PT_CALIB		0x3
+#define ONE_PT_CALIB2_NO_OFFSET	0x6
+#define TWO_PT_CALIB_NO_OFFSET	0x7
 #define CAL_DEGC_PT1		30
 #define CAL_DEGC_PT2		120
 #define SLOPE_FACTOR		1000
@@ -57,6 +59,8 @@ struct tsens_sensor {
 	unsigned int			hw_id;
 	int				slope;
 	u32				status;
+	int				p1_calib_offset;
+	int				p2_calib_offset;
 };
 
 /**
-- 
2.39.2



