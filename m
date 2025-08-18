Return-Path: <stable+bounces-171644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0805B2B1B5
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 21:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8621884A92
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 19:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4D242056;
	Mon, 18 Aug 2025 19:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arnlu8yF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2FE3451B3
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545563; cv=none; b=r6zbDRMgGKyW5mtzm6HMrnKVduizTjXD3rbD7v7syrbOSynkm0LwC2frGb5F/lnVtzzMaKmAj62gEMMLcSLJZGWPr1IlaY/ugEgosvhT6Kg6UdbB9U31DaLh/dM72o2udmo+X7j/kOw8dB8wmtwLZstrKxGdJl7AtvFMvPyJrOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545563; c=relaxed/simple;
	bh=TWW8AoEKESt3V156h8uwdI0eaQnMi+ot9YfTms1OMXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWwjmL1j9el2Bgaw+/IIJSakmsMsSuPOWxXQvyURtrqLCQUINyR9U62Ml4AJKdfmMhflI019FZ0M4cQwziDoSv0YTHVfv2XhW3kDo/Ilam+uch+Xct9TqVWimM9FZQ7/2e/vYLTm8iOe+tRGHXu8zdOHoGvMY+7Rse984VIYM1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arnlu8yF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D816BC4CEEB;
	Mon, 18 Aug 2025 19:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755545563;
	bh=TWW8AoEKESt3V156h8uwdI0eaQnMi+ot9YfTms1OMXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=arnlu8yFCwgU923ICpRTnztVd8NOdFmGJD/2mzpswJoBISHJuQREVPmK0gx6uvGQT
	 XdkNq40yQIqHpYV//LvxgzPcLzi06RvXOSzPxIKDgXy4NneyBHhu6fDhIjSf1qyX37
	 Xt/6lR42/OwduyjWj+2sK1aLEvtRBXvioEBrZE6EMHmxd8hOYX88vpP4gTSfSS/k8H
	 oXKb8DL+liFG5b+2L/HgA67Gtb1B8bdrxu6zWXHkJY8TkS5T/qsJmPoA93yWRhFt5N
	 DyozAzOUPiOA5rR6w7Tw/BPwAokwHnOHADJNj1+T2zH34/JhSd9iloF68cVdiPwtn0
	 n3tFzOktAuHdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] USB: typec: Use str_enable_disable-like helpers
Date: Mon, 18 Aug 2025 15:32:39 -0400
Message-ID: <20250818193240.50566-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081830-selected-dandelion-46ec@gregkh>
References: <2025081830-selected-dandelion-46ec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 13b3af26a41538e5051baedba8678eba521a27d3 ]

Replace ternary (condition ? "enable" : "disable") syntax with helpers
from string_choices.h because:
1. Simple function call with one argument is easier to read.  Ternary
   operator has three arguments and with wrapping might lead to quite
   long code.
2. Is slightly shorter thus also easier to read.
3. It brings uniformity in the text - same string.
4. Allows deduping by the linker, which results in a smaller binary
   file.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20250114-str-enable-disable-usb-v1-3-c8405df47c19@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 1e61f6ab0878 ("usb: typec: fusb302: cache PD RX state")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/class.c                     |  7 +++---
 drivers/usb/typec/tcpm/fusb302.c              | 24 +++++++++----------
 .../typec/tcpm/qcom/qcom_pmic_typec_pdphy.c   |  3 ++-
 .../tcpm/qcom/qcom_pmic_typec_pdphy_stub.c    |  3 ++-
 .../typec/tcpm/qcom/qcom_pmic_typec_port.c    |  4 +++-
 drivers/usb/typec/tcpm/tcpm.c                 |  7 +++---
 6 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 5c75634b8fa3..c9c3dea8ba07 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -10,6 +10,7 @@
 #include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/usb/pd_vdo.h>
 #include <linux/usb/typec_mux.h>
 #include <linux/usb/typec_retimer.h>
@@ -354,7 +355,7 @@ active_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct typec_altmode *alt = to_typec_altmode(dev);
 
-	return sprintf(buf, "%s\n", alt->active ? "yes" : "no");
+	return sprintf(buf, "%s\n", str_yes_no(alt->active));
 }
 
 static ssize_t active_store(struct device *dev, struct device_attribute *attr,
@@ -630,7 +631,7 @@ static ssize_t supports_usb_power_delivery_show(struct device *dev,
 {
 	struct typec_partner *p = to_typec_partner(dev);
 
-	return sprintf(buf, "%s\n", p->usb_pd ? "yes" : "no");
+	return sprintf(buf, "%s\n", str_yes_no(p->usb_pd));
 }
 static DEVICE_ATTR_RO(supports_usb_power_delivery);
 
@@ -1688,7 +1689,7 @@ static ssize_t vconn_source_show(struct device *dev,
 	struct typec_port *port = to_typec_port(dev);
 
 	return sprintf(buf, "%s\n",
-		       port->vconn_role == TYPEC_SOURCE ? "yes" : "no");
+		       str_yes_no(port->vconn_role == TYPEC_SOURCE));
 }
 static DEVICE_ATTR_RW(vconn_source);
 
diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index e2fe479e16ad..f15c63d3a8f4 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/types.h>
 #include <linux/usb.h>
 #include <linux/usb/typec.h>
@@ -733,7 +734,7 @@ static int tcpm_set_vconn(struct tcpc_dev *dev, bool on)
 
 	mutex_lock(&chip->lock);
 	if (chip->vconn_on == on) {
-		fusb302_log(chip, "vconn is already %s", on ? "On" : "Off");
+		fusb302_log(chip, "vconn is already %s", str_on_off(on));
 		goto done;
 	}
 	if (on) {
@@ -746,7 +747,7 @@ static int tcpm_set_vconn(struct tcpc_dev *dev, bool on)
 	if (ret < 0)
 		goto done;
 	chip->vconn_on = on;
-	fusb302_log(chip, "vconn := %s", on ? "On" : "Off");
+	fusb302_log(chip, "vconn := %s", str_on_off(on));
 done:
 	mutex_unlock(&chip->lock);
 
@@ -761,7 +762,7 @@ static int tcpm_set_vbus(struct tcpc_dev *dev, bool on, bool charge)
 
 	mutex_lock(&chip->lock);
 	if (chip->vbus_on == on) {
-		fusb302_log(chip, "vbus is already %s", on ? "On" : "Off");
+		fusb302_log(chip, "vbus is already %s", str_on_off(on));
 	} else {
 		if (on)
 			ret = regulator_enable(chip->vbus);
@@ -769,15 +770,14 @@ static int tcpm_set_vbus(struct tcpc_dev *dev, bool on, bool charge)
 			ret = regulator_disable(chip->vbus);
 		if (ret < 0) {
 			fusb302_log(chip, "cannot %s vbus regulator, ret=%d",
-				    on ? "enable" : "disable", ret);
+				    str_enable_disable(on), ret);
 			goto done;
 		}
 		chip->vbus_on = on;
-		fusb302_log(chip, "vbus := %s", on ? "On" : "Off");
+		fusb302_log(chip, "vbus := %s", str_on_off(on));
 	}
 	if (chip->charge_on == charge)
-		fusb302_log(chip, "charge is already %s",
-			    charge ? "On" : "Off");
+		fusb302_log(chip, "charge is already %s", str_on_off(charge));
 	else
 		chip->charge_on = charge;
 
@@ -854,16 +854,16 @@ static int tcpm_set_pd_rx(struct tcpc_dev *dev, bool on)
 	ret = fusb302_pd_set_auto_goodcrc(chip, on);
 	if (ret < 0) {
 		fusb302_log(chip, "cannot turn %s auto GCRC, ret=%d",
-			    on ? "on" : "off", ret);
+			    str_on_off(on), ret);
 		goto done;
 	}
 	ret = fusb302_pd_set_interrupts(chip, on);
 	if (ret < 0) {
 		fusb302_log(chip, "cannot turn %s pd interrupts, ret=%d",
-			    on ? "on" : "off", ret);
+			    str_on_off(on), ret);
 		goto done;
 	}
-	fusb302_log(chip, "pd := %s", on ? "on" : "off");
+	fusb302_log(chip, "pd := %s", str_on_off(on));
 done:
 	mutex_unlock(&chip->lock);
 
@@ -1531,7 +1531,7 @@ static void fusb302_irq_work(struct work_struct *work)
 	if (interrupt & FUSB_REG_INTERRUPT_VBUSOK) {
 		vbus_present = !!(status0 & FUSB_REG_STATUS0_VBUSOK);
 		fusb302_log(chip, "IRQ: VBUS_OK, vbus=%s",
-			    vbus_present ? "On" : "Off");
+			    str_on_off(vbus_present));
 		if (vbus_present != chip->vbus_present) {
 			chip->vbus_present = vbus_present;
 			tcpm_vbus_change(chip->tcpm_port);
@@ -1562,7 +1562,7 @@ static void fusb302_irq_work(struct work_struct *work)
 	if ((interrupt & FUSB_REG_INTERRUPT_COMP_CHNG) && intr_comp_chng) {
 		comp_result = !!(status0 & FUSB_REG_STATUS0_COMP);
 		fusb302_log(chip, "IRQ: COMP_CHNG, comp=%s",
-			    comp_result ? "true" : "false");
+			    str_true_false(comp_result));
 		if (comp_result) {
 			/* cc level > Rd_threshold, detach */
 			chip->cc1 = TYPEC_CC_OPEN;
diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
index 726423684bae..18303b34594b 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
@@ -12,6 +12,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/usb/pd.h>
 #include <linux/usb/tcpm.h>
 #include "qcom_pmic_typec.h"
@@ -418,7 +419,7 @@ static int qcom_pmic_typec_pdphy_set_pd_rx(struct tcpc_dev *tcpc, bool on)
 
 	spin_unlock_irqrestore(&pmic_typec_pdphy->lock, flags);
 
-	dev_dbg(pmic_typec_pdphy->dev, "set_pd_rx: %s\n", on ? "on" : "off");
+	dev_dbg(pmic_typec_pdphy->dev, "set_pd_rx: %s\n", str_on_off(on));
 
 	return ret;
 }
diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy_stub.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy_stub.c
index df79059cda67..8fac171778da 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy_stub.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy_stub.c
@@ -12,6 +12,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/usb/pd.h>
 #include <linux/usb/tcpm.h>
 #include "qcom_pmic_typec.h"
@@ -38,7 +39,7 @@ static int qcom_pmic_typec_pdphy_stub_set_pd_rx(struct tcpc_dev *tcpc, bool on)
 	struct pmic_typec *tcpm = tcpc_to_tcpm(tcpc);
 	struct device *dev = tcpm->dev;
 
-	dev_dbg(dev, "set_pd_rx: %s\n", on ? "on" : "off");
+	dev_dbg(dev, "set_pd_rx: %s\n", str_on_off(on));
 
 	return 0;
 }
diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
index c37dede62e12..4fc83dcfae64 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
@@ -13,6 +13,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/usb/tcpm.h>
 #include <linux/usb/typec_mux.h>
 #include <linux/workqueue.h>
@@ -562,7 +563,8 @@ static int qcom_pmic_typec_port_set_vconn(struct tcpc_dev *tcpc, bool on)
 	spin_unlock_irqrestore(&pmic_typec_port->lock, flags);
 
 	dev_dbg(dev, "set_vconn: orientation %d control 0x%08x state %s cc %s vconn %s\n",
-		orientation, value, on ? "on" : "off", misc_to_vconn(misc), misc_to_cc(misc));
+		orientation, value, str_on_off(on), misc_to_vconn(misc),
+		misc_to_cc(misc));
 
 	return ret;
 }
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index aa2fa720af15..43e3dac5129f 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -21,6 +21,7 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/string_choices.h>
 #include <linux/usb.h>
 #include <linux/usb/pd.h>
 #include <linux/usb/pd_ado.h>
@@ -874,8 +875,8 @@ static int tcpm_enable_auto_vbus_discharge(struct tcpm_port *port, bool enable)
 
 	if (port->tcpc->enable_auto_vbus_discharge) {
 		ret = port->tcpc->enable_auto_vbus_discharge(port->tcpc, enable);
-		tcpm_log_force(port, "%s vbus discharge ret:%d", enable ? "enable" : "disable",
-			       ret);
+		tcpm_log_force(port, "%s vbus discharge ret:%d",
+			       str_enable_disable(enable), ret);
 		if (!ret)
 			port->auto_vbus_discharge_enabled = enable;
 	}
@@ -4429,7 +4430,7 @@ static void tcpm_unregister_altmodes(struct tcpm_port *port)
 
 static void tcpm_set_partner_usb_comm_capable(struct tcpm_port *port, bool capable)
 {
-	tcpm_log(port, "Setting usb_comm capable %s", capable ? "true" : "false");
+	tcpm_log(port, "Setting usb_comm capable %s", str_true_false(capable));
 
 	if (port->tcpc->set_partner_usb_comm_capable)
 		port->tcpc->set_partner_usb_comm_capable(port->tcpc, capable);
-- 
2.50.1


