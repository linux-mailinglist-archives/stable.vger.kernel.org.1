Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216AE755171
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjGPT4b (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjGPT4a (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:56:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D301BC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:56:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0C1C60E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB3AC433C7;
        Sun, 16 Jul 2023 19:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537384;
        bh=y92wTh43TLzAS8/drqeuh4s4SC6zdj7TZPpWh34ZJl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y0i1ZzYE1hMkQ53eEIbgQJBozTEfXKLKwlMds7E2qxKw0kvOzdyAZf8GZbEV6PoOy
         BKkS+U96QjdLfGfYFxEPeqTxDhP3w2/HCp/ZdBjT5SWb6kxFx+bzo3nh/78OxSyNI6
         LOoikjlJkD9iDSE2ncb9ziAL8D2L063U6HkrzPbY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 076/800] thermal/drivers/qcom/tsens-v0_1: Add support for MSM8226
Date:   Sun, 16 Jul 2023 21:38:49 +0200
Message-ID: <20230716194950.869253518@linuxfoundation.org>
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

From: Matti Lehtimäki <matti.lehtimaki@gmail.com>

[ Upstream commit 598e1afca47fdbb302ce8d288b06bcc8728efc6c ]

The MSM8226 TSENS IP has 6 thermal sensors in a TSENS v0.1 block.
The thermal sensors use non-standard slope values.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Luca Weiss <luca@z3ntu.xyz>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230507201225.89694-4-matti.lehtimaki@gmail.com
Stable-dep-of: 6812d1dfbca9 ("thermal/drivers/qcom/tsens-v0_1: Fix mdm9607 slope values")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/qcom/tsens-v0_1.c | 27 ++++++++++++++++++++++++++-
 drivers/thermal/qcom/tsens.c      |  3 +++
 drivers/thermal/qcom/tsens.h      |  2 +-
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index e89c6f39a3aea..ad57ab94546b0 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -243,6 +243,18 @@ static int calibrate_8974(struct tsens_priv *priv)
 	return 0;
 }
 
+static int __init init_8226(struct tsens_priv *priv)
+{
+	priv->sensor[0].slope = 2901;
+	priv->sensor[1].slope = 2846;
+	priv->sensor[2].slope = 3038;
+	priv->sensor[3].slope = 2955;
+	priv->sensor[4].slope = 2901;
+	priv->sensor[5].slope = 2846;
+
+	return init_common(priv);
+}
+
 static int __init init_8939(struct tsens_priv *priv) {
 	priv->sensor[0].slope = 2911;
 	priv->sensor[1].slope = 2789;
@@ -258,7 +270,7 @@ static int __init init_8939(struct tsens_priv *priv) {
 	return init_common(priv);
 }
 
-/* v0.1: 8916, 8939, 8974, 9607 */
+/* v0.1: 8226, 8916, 8939, 8974, 9607 */
 
 static struct tsens_features tsens_v0_1_feat = {
 	.ver_major	= VER_0_1,
@@ -313,6 +325,19 @@ static const struct tsens_ops ops_v0_1 = {
 	.get_temp	= get_temp_common,
 };
 
+static const struct tsens_ops ops_8226 = {
+	.init		= init_8226,
+	.calibrate	= tsens_calibrate_common,
+	.get_temp	= get_temp_common,
+};
+
+struct tsens_plat_data data_8226 = {
+	.num_sensors	= 6,
+	.ops		= &ops_8226,
+	.feat		= &tsens_v0_1_feat,
+	.fields	= tsens_v0_1_regfields,
+};
+
 static const struct tsens_ops ops_8916 = {
 	.init		= init_common,
 	.calibrate	= calibrate_8916,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index d3218127e617d..1c457b55efb39 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1095,6 +1095,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,mdm9607-tsens",
 		.data = &data_9607,
+	}, {
+		.compatible = "qcom,msm8226-tsens",
+		.data = &data_8226,
 	}, {
 		.compatible = "qcom,msm8916-tsens",
 		.data = &data_8916,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index dba9cd38f637c..433eba370998c 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -635,7 +635,7 @@ int get_temp_common(const struct tsens_sensor *s, int *temp);
 extern struct tsens_plat_data data_8960;
 
 /* TSENS v0.1 targets */
-extern struct tsens_plat_data data_8916, data_8939, data_8974, data_9607;
+extern struct tsens_plat_data data_8226, data_8916, data_8939, data_8974, data_9607;
 
 /* TSENS v1 targets */
 extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956;
-- 
2.39.2



