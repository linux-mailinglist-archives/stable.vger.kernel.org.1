Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374337A7B3F
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbjITLud (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjITLuc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:50:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B903CF
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:50:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B384C433C7;
        Wed, 20 Sep 2023 11:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210624;
        bh=XoQTHGpvO6ZjXek3Qb1TMzZGJn8jYY0lHhd4QOVXcOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cNUGOQoFbXVC03XJA42mkUAMD/HJZVw2LsdsawCafG71+T2hxFLs1uD9JeAlUnKfW
         JnASEFNUQrY2/DTvlEfSgt3wdc0ZEFUxWGxJDtSdmOmQD9TbFNBth1ecQtLAliCv4c
         9bfBgDLqRTDWOBeMAma02RQwzm/RvTw9LAaux6lc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bryan ODonoghue <bryan.odonoghue@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 127/211] usb: typec: qcom-pmic-typec: register drm_bridge
Date:   Wed, 20 Sep 2023 13:29:31 +0200
Message-ID: <20230920112849.748257984@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 4b3cd783808bb327d931bbb1324d6c367443b721 ]

The current approach to handling DP on bridge-enabled platforms requires
a chain of DP bridges up to the USB-C connector. Register a last DRM
bridge for such chain.

Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20230817150824.14371-3-dmitry.baryshkov@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm/Kconfig                |  1 +
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 37 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
index 5d393f520fc2f..0b2993fef564b 100644
--- a/drivers/usb/typec/tcpm/Kconfig
+++ b/drivers/usb/typec/tcpm/Kconfig
@@ -79,6 +79,7 @@ config TYPEC_WCOVE
 config TYPEC_QCOM_PMIC
 	tristate "Qualcomm PMIC USB Type-C Port Controller Manager driver"
 	depends on ARCH_QCOM || COMPILE_TEST
+	depends on DRM || DRM=n
 	help
 	  A Type-C port and Power Delivery driver which aggregates two
 	  discrete pieces of silicon in the PM8150b PMIC block: the
diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
index 9b467a346114e..273b4811b4ac8 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
@@ -17,6 +17,9 @@
 #include <linux/usb/role.h>
 #include <linux/usb/tcpm.h>
 #include <linux/usb/typec_mux.h>
+
+#include <drm/drm_bridge.h>
+
 #include "qcom_pmic_typec_pdphy.h"
 #include "qcom_pmic_typec_port.h"
 
@@ -33,6 +36,7 @@ struct pmic_typec {
 	struct pmic_typec_port	*pmic_typec_port;
 	bool			vbus_enabled;
 	struct mutex		lock;		/* VBUS state serialization */
+	struct drm_bridge	bridge;
 };
 
 #define tcpc_to_tcpm(_tcpc_) container_of(_tcpc_, struct pmic_typec, tcpc)
@@ -146,6 +150,35 @@ static int qcom_pmic_typec_init(struct tcpc_dev *tcpc)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_DRM)
+static int qcom_pmic_typec_attach(struct drm_bridge *bridge,
+				     enum drm_bridge_attach_flags flags)
+{
+	return flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR ? 0 : -EINVAL;
+}
+
+static const struct drm_bridge_funcs qcom_pmic_typec_bridge_funcs = {
+	.attach = qcom_pmic_typec_attach,
+};
+
+static int qcom_pmic_typec_init_drm(struct pmic_typec *tcpm)
+{
+	tcpm->bridge.funcs = &qcom_pmic_typec_bridge_funcs;
+#ifdef CONFIG_OF
+	tcpm->bridge.of_node = of_get_child_by_name(tcpm->dev->of_node, "connector");
+#endif
+	tcpm->bridge.ops = DRM_BRIDGE_OP_HPD;
+	tcpm->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
+
+	return devm_drm_bridge_add(tcpm->dev, &tcpm->bridge);
+}
+#else
+static int qcom_pmic_typec_init_drm(struct pmic_typec *tcpm)
+{
+	return 0;
+}
+#endif
+
 static int qcom_pmic_typec_probe(struct platform_device *pdev)
 {
 	struct pmic_typec *tcpm;
@@ -208,6 +241,10 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 	mutex_init(&tcpm->lock);
 	platform_set_drvdata(pdev, tcpm);
 
+	ret = qcom_pmic_typec_init_drm(tcpm);
+	if (ret)
+		return ret;
+
 	tcpm->tcpc.fwnode = device_get_named_child_node(tcpm->dev, "connector");
 	if (!tcpm->tcpc.fwnode)
 		return -EINVAL;
-- 
2.40.1



