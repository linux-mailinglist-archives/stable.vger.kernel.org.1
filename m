Return-Path: <stable+bounces-26399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DFF870E68
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCAA51C20325
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F63F78B4C;
	Mon,  4 Mar 2024 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GMLMRIGE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C236011193;
	Mon,  4 Mar 2024 21:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588619; cv=none; b=fmH0KJjfQlYV4ghPf1igwxnmQoUuYVNjRVeLjQGGKCfub2zxVmIZ158nLtgfpgPmMciUnTLRdKPqsaeSVIlvFI4JE0V/qX0oPKJk36j3ZHSNCkd9eS52h2WuJf9AivKUqAKMYo0kvMJ0OjhPtX0icr5hpxt9B79FFzfAYK2P7Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588619; c=relaxed/simple;
	bh=uNCW96ZtPMSrUZ7XS00YYNXVWU/e+j4oqFP2cHVs0vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfP8YNAOdsRRkQw3dMlRAN5AhNnANgyT1lIRhHCtgfC7RqmNFYRSjpbn/Kh0ZLYM3ueHLguuHT7RNgKj9FDGZ8obB93u4AHaeyqzAPEjiJ8QpFvqOdYtqr4RClc+M1gtdl3agEdM41wKkrfl2uoAiPivp0yzQvxTljBaueWW5Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GMLMRIGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE97C433F1;
	Mon,  4 Mar 2024 21:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588619;
	bh=uNCW96ZtPMSrUZ7XS00YYNXVWU/e+j4oqFP2cHVs0vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GMLMRIGEbPIPZER1sqz6s01OhjLwC46qwBMmugVrdFdDc8mqgg95/mqu3WG153NyV
	 fRda1DYgbOtSqfihvqOV7GTCRp/BjQZ5/nb+MvZpiG80Ml4CXBUYiw6QaMDTjlN5gg
	 GWBZ14PSsjElATaQPz4fxGEAMWAr/NUv5BqfdNT4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Elson Roy Serrao <quic_eserrao@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 015/215] usb: gadget: Properly configure the device for remote wakeup
Date: Mon,  4 Mar 2024 21:21:18 +0000
Message-ID: <20240304211557.494961961@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211556.993132804@linuxfoundation.org>
References: <20240304211556.993132804@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Elson Roy Serrao <quic_eserrao@quicinc.com>

[ Upstream commit b93c2a68f3d9dc98ec30dcb342ae47c1c8d09d18 ]

The wakeup bit in the bmAttributes field indicates whether the device
is configured for remote wakeup. But this field should be allowed to
set only if the UDC supports such wakeup mechanism. So configure this
field based on UDC capability. Also inform the UDC whether the device
is configured for remote wakeup by implementing a gadget op.

Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
Link: https://lore.kernel.org/r/1679694482-16430-2-git-send-email-quic_eserrao@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/composite.c | 18 ++++++++++++++++++
 drivers/usb/gadget/configfs.c  |  3 +++
 drivers/usb/gadget/udc/core.c  | 27 +++++++++++++++++++++++++++
 drivers/usb/gadget/udc/trace.h |  5 +++++
 include/linux/usb/composite.h  |  2 ++
 include/linux/usb/gadget.h     |  8 ++++++++
 6 files changed, 63 insertions(+)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index cb0a4e2cdbb73..247cca46cdfae 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -511,6 +511,19 @@ static u8 encode_bMaxPower(enum usb_device_speed speed,
 		return min(val, 900U) / 8;
 }
 
+void check_remote_wakeup_config(struct usb_gadget *g,
+				struct usb_configuration *c)
+{
+	if (USB_CONFIG_ATT_WAKEUP & c->bmAttributes) {
+		/* Reset the rw bit if gadget is not capable of it */
+		if (!g->wakeup_capable && g->ops->set_remote_wakeup) {
+			WARN(c->cdev, "Clearing wakeup bit for config c.%d\n",
+			     c->bConfigurationValue);
+			c->bmAttributes &= ~USB_CONFIG_ATT_WAKEUP;
+		}
+	}
+}
+
 static int config_buf(struct usb_configuration *config,
 		enum usb_device_speed speed, void *buf, u8 type)
 {
@@ -959,6 +972,11 @@ static int set_config(struct usb_composite_dev *cdev,
 		power = min(power, 500U);
 	else
 		power = min(power, 900U);
+
+	if (USB_CONFIG_ATT_WAKEUP & c->bmAttributes)
+		usb_gadget_set_remote_wakeup(gadget, 1);
+	else
+		usb_gadget_set_remote_wakeup(gadget, 0);
 done:
 	if (power <= USB_SELF_POWER_VBUS_MAX_DRAW)
 		usb_gadget_set_selfpowered(gadget);
diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 4dcf29577f8f1..b94aec6227c51 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -1376,6 +1376,9 @@ static int configfs_composite_bind(struct usb_gadget *gadget,
 		if (gadget_is_otg(gadget))
 			c->descriptors = otg_desc;
 
+		/* Properly configure the bmAttributes wakeup bit */
+		check_remote_wakeup_config(gadget, c);
+
 		cfg = container_of(c, struct config_usb_cfg, c);
 		if (!list_empty(&cfg->string_list)) {
 			i = 0;
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index c40f2ecbe1b8c..0edd9e53fc5a1 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -525,6 +525,33 @@ int usb_gadget_wakeup(struct usb_gadget *gadget)
 }
 EXPORT_SYMBOL_GPL(usb_gadget_wakeup);
 
+/**
+ * usb_gadget_set_remote_wakeup - configures the device remote wakeup feature.
+ * @gadget:the device being configured for remote wakeup
+ * @set:value to be configured.
+ *
+ * set to one to enable remote wakeup feature and zero to disable it.
+ *
+ * returns zero on success, else negative errno.
+ */
+int usb_gadget_set_remote_wakeup(struct usb_gadget *gadget, int set)
+{
+	int ret = 0;
+
+	if (!gadget->ops->set_remote_wakeup) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	ret = gadget->ops->set_remote_wakeup(gadget, set);
+
+out:
+	trace_usb_gadget_set_remote_wakeup(gadget, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_set_remote_wakeup);
+
 /**
  * usb_gadget_set_selfpowered - sets the device selfpowered feature.
  * @gadget:the device being declared as self-powered
diff --git a/drivers/usb/gadget/udc/trace.h b/drivers/usb/gadget/udc/trace.h
index abdbcb1bacb0b..a5ed26fbc2dad 100644
--- a/drivers/usb/gadget/udc/trace.h
+++ b/drivers/usb/gadget/udc/trace.h
@@ -91,6 +91,11 @@ DEFINE_EVENT(udc_log_gadget, usb_gadget_wakeup,
 	TP_ARGS(g, ret)
 );
 
+DEFINE_EVENT(udc_log_gadget, usb_gadget_set_remote_wakeup,
+	TP_PROTO(struct usb_gadget *g, int ret),
+	TP_ARGS(g, ret)
+);
+
 DEFINE_EVENT(udc_log_gadget, usb_gadget_set_selfpowered,
 	TP_PROTO(struct usb_gadget *g, int ret),
 	TP_ARGS(g, ret)
diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
index 43ac3fa760dbe..9783b9107d76b 100644
--- a/include/linux/usb/composite.h
+++ b/include/linux/usb/composite.h
@@ -412,6 +412,8 @@ extern int composite_dev_prepare(struct usb_composite_driver *composite,
 extern int composite_os_desc_req_prepare(struct usb_composite_dev *cdev,
 					 struct usb_ep *ep0);
 void composite_dev_cleanup(struct usb_composite_dev *cdev);
+void check_remote_wakeup_config(struct usb_gadget *g,
+				struct usb_configuration *c);
 
 static inline struct usb_composite_driver *to_cdriver(
 		struct usb_gadget_driver *gdrv)
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index dc3092cea99e9..5bec668b41dcd 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -309,6 +309,7 @@ struct usb_udc;
 struct usb_gadget_ops {
 	int	(*get_frame)(struct usb_gadget *);
 	int	(*wakeup)(struct usb_gadget *);
+	int	(*set_remote_wakeup)(struct usb_gadget *, int set);
 	int	(*set_selfpowered) (struct usb_gadget *, int is_selfpowered);
 	int	(*vbus_session) (struct usb_gadget *, int is_active);
 	int	(*vbus_draw) (struct usb_gadget *, unsigned mA);
@@ -383,6 +384,8 @@ struct usb_gadget_ops {
  * @connected: True if gadget is connected.
  * @lpm_capable: If the gadget max_speed is FULL or HIGH, this flag
  *	indicates that it supports LPM as per the LPM ECN & errata.
+ * @wakeup_capable: True if gadget is capable of sending remote wakeup.
+ * @wakeup_armed: True if gadget is armed by the host for remote wakeup.
  * @irq: the interrupt number for device controller.
  * @id_number: a unique ID number for ensuring that gadget names are distinct
  *
@@ -444,6 +447,8 @@ struct usb_gadget {
 	unsigned			deactivated:1;
 	unsigned			connected:1;
 	unsigned			lpm_capable:1;
+	unsigned			wakeup_capable:1;
+	unsigned			wakeup_armed:1;
 	int				irq;
 	int				id_number;
 };
@@ -600,6 +605,7 @@ static inline int gadget_is_otg(struct usb_gadget *g)
 #if IS_ENABLED(CONFIG_USB_GADGET)
 int usb_gadget_frame_number(struct usb_gadget *gadget);
 int usb_gadget_wakeup(struct usb_gadget *gadget);
+int usb_gadget_set_remote_wakeup(struct usb_gadget *gadget, int set);
 int usb_gadget_set_selfpowered(struct usb_gadget *gadget);
 int usb_gadget_clear_selfpowered(struct usb_gadget *gadget);
 int usb_gadget_vbus_connect(struct usb_gadget *gadget);
@@ -615,6 +621,8 @@ static inline int usb_gadget_frame_number(struct usb_gadget *gadget)
 { return 0; }
 static inline int usb_gadget_wakeup(struct usb_gadget *gadget)
 { return 0; }
+static inline int usb_gadget_set_remote_wakeup(struct usb_gadget *gadget, int set)
+{ return 0; }
 static inline int usb_gadget_set_selfpowered(struct usb_gadget *gadget)
 { return 0; }
 static inline int usb_gadget_clear_selfpowered(struct usb_gadget *gadget)
-- 
2.43.0




