Return-Path: <stable+bounces-176032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7B8B36B19
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D223A9858C2
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F2532A3C8;
	Tue, 26 Aug 2025 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ad2Ne+KY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6192934DCC1;
	Tue, 26 Aug 2025 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218607; cv=none; b=NuQMpdEAurGi5fNCdO7eHjb3HwEc3Hxg+Qv2k9BVftsZXDtbq0ahQ1ro+sIjNo9KWm5AqFNrFiRSyEUpQRih0x4zUwkaaT5PDm9gla+kfto6zGeScq/sDzqLJcktX7Pobi/Q4rzXSf7V3yV1EbOTWNHfMtlPCUKyS+qbWiLu9Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218607; c=relaxed/simple;
	bh=K4epvN9WHQNwwGp9/Sl4MA92mBW+hmNADKCKDjh2uJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nge6GSxsx6qJ+TCJx64p6u0jA7JKZvjiPdw+dJRUX682+/3hcRqVyOFbQATfM8RcAQGecs0kOms3dfGEqpVbT6s8th9xOW8+Ogyg3TFW+wQJvQ4trT+qvfPfAraGEBMOMwU/PVuJOT6PIBg97DHPGCFKRCFAJTVM+8ja15IPSEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ad2Ne+KY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3E3C4CEF1;
	Tue, 26 Aug 2025 14:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756218607;
	bh=K4epvN9WHQNwwGp9/Sl4MA92mBW+hmNADKCKDjh2uJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ad2Ne+KYGPrH6g7Jk5S6fyLNLpJxXtrsAAAGjyhPXS6icX1Punqjj8ywXV7owPF5Z
	 1YQb1BPTk0MzBPyq12eBQLm2IzhAf4A51P20Mh6NywaSpDqwLShbRgGcUMeVnHP1RU
	 k03h6AYZhzqmYFizN/lzshTpswNv6pub+vi22Ym0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Chen <peter.chen@nxp.com>,
	Jun Li <jun.li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 065/403] usb: chipidea: udc: add new API ci_hdrc_gadget_connect
Date: Tue, 26 Aug 2025 13:06:31 +0200
Message-ID: <20250826110907.874786249@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110905.607690791@linuxfoundation.org>
References: <20250826110905.607690791@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Chen <peter.chen@nxp.com>

[ Upstream commit d16ab536aad208421c5ed32cdcb01b5ab6aa1f19 ]

This API is used enable device function, it is called at below
situations:
- VBUS is connected during boots up
- Hot plug occurs during runtime

Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Jun Li <jun.li@nxp.com>
Stable-dep-of: b7a62611fab7 ("usb: chipidea: add USB PHY event")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/chipidea/udc.c | 63 +++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index a6ce6b89b271..e9ef6271e20d 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1533,6 +1533,33 @@ static const struct usb_ep_ops usb_ep_ops = {
 /******************************************************************************
  * GADGET block
  *****************************************************************************/
+/**
+ * ci_hdrc_gadget_connect: caller makes sure gadget driver is binded
+ */
+static void ci_hdrc_gadget_connect(struct usb_gadget *_gadget, int is_active)
+{
+	struct ci_hdrc *ci = container_of(_gadget, struct ci_hdrc, gadget);
+
+	if (is_active) {
+		pm_runtime_get_sync(&_gadget->dev);
+		hw_device_reset(ci);
+		hw_device_state(ci, ci->ep0out->qh.dma);
+		usb_gadget_set_state(_gadget, USB_STATE_POWERED);
+		usb_udc_vbus_handler(_gadget, true);
+	} else {
+		usb_udc_vbus_handler(_gadget, false);
+		if (ci->driver)
+			ci->driver->disconnect(&ci->gadget);
+		hw_device_state(ci, 0);
+		if (ci->platdata->notify_event)
+			ci->platdata->notify_event(ci,
+			CI_HDRC_CONTROLLER_STOPPED_EVENT);
+		_gadget_stop_activity(&ci->gadget);
+		pm_runtime_put_sync(&_gadget->dev);
+		usb_gadget_set_state(_gadget, USB_STATE_NOTATTACHED);
+	}
+}
+
 static int ci_udc_vbus_session(struct usb_gadget *_gadget, int is_active)
 {
 	struct ci_hdrc *ci = container_of(_gadget, struct ci_hdrc, gadget);
@@ -1549,26 +1576,8 @@ static int ci_udc_vbus_session(struct usb_gadget *_gadget, int is_active)
 		usb_phy_set_charger_state(ci->usb_phy, is_active ?
 			USB_CHARGER_PRESENT : USB_CHARGER_ABSENT);
 
-	if (gadget_ready) {
-		if (is_active) {
-			pm_runtime_get_sync(&_gadget->dev);
-			hw_device_reset(ci);
-			hw_device_state(ci, ci->ep0out->qh.dma);
-			usb_gadget_set_state(_gadget, USB_STATE_POWERED);
-			usb_udc_vbus_handler(_gadget, true);
-		} else {
-			usb_udc_vbus_handler(_gadget, false);
-			if (ci->driver)
-				ci->driver->disconnect(&ci->gadget);
-			hw_device_state(ci, 0);
-			if (ci->platdata->notify_event)
-				ci->platdata->notify_event(ci,
-				CI_HDRC_CONTROLLER_STOPPED_EVENT);
-			_gadget_stop_activity(&ci->gadget);
-			pm_runtime_put_sync(&_gadget->dev);
-			usb_gadget_set_state(_gadget, USB_STATE_NOTATTACHED);
-		}
-	}
+	if (gadget_ready)
+		ci_hdrc_gadget_connect(_gadget, is_active);
 
 	return 0;
 }
@@ -1794,18 +1803,10 @@ static int ci_udc_start(struct usb_gadget *gadget,
 		return retval;
 	}
 
-	pm_runtime_get_sync(&ci->gadget.dev);
-	if (ci->vbus_active) {
-		hw_device_reset(ci);
-	} else {
+	if (ci->vbus_active)
+		ci_hdrc_gadget_connect(gadget, 1);
+	else
 		usb_udc_vbus_handler(&ci->gadget, false);
-		pm_runtime_put_sync(&ci->gadget.dev);
-		return retval;
-	}
-
-	retval = hw_device_state(ci, ci->ep0out->qh.dma);
-	if (retval)
-		pm_runtime_put_sync(&ci->gadget.dev);
 
 	return retval;
 }
-- 
2.39.5




