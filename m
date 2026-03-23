Return-Path: <stable+bounces-229920-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDJmLDJxwWkQTQQAu9opvQ
	(envelope-from <stable+bounces-229920-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:58:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 567C02F935D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 911043115B60
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4772C3BC675;
	Mon, 23 Mar 2026 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zOJ+gXQ4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007883BED2C;
	Mon, 23 Mar 2026 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283219; cv=none; b=jd8UuWg+uJ1KOT7BmIUfJEvu5PR1E+eXFkYY7gVnkHt+6FzDDYOEebAACqhX4s4enjV+SARZuxK4CpiJNsUkDvyesR7UEZmZ9NsxKF8I7zUHDk6u6P/AfnnKGODZCBcRHsSpUIdoKfxKfG1H2HBuDbDa3oHCNZnfHnXgydxFsTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283219; c=relaxed/simple;
	bh=dw2jx2clebVI7Thz6aHcY/dSUzKafN1mQhURgx0Gt1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Alc/Kx49fU3mSWxVfp6VFkUoh4n3ZD3GFFxRdTWmK7sZVxAjN2kJojnD7G6tWdKEoFOA8gy6WUS3n8wdBJyOlqO8omkKZw2YD1VcOXndiG32cpWfoJdALZ8VRBBaYwi8kBPQ0KExJKQok8cixzM9/MSysFjR4Oho5aP3BkrhMTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zOJ+gXQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42157C2BC9E;
	Mon, 23 Mar 2026 16:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774283218;
	bh=dw2jx2clebVI7Thz6aHcY/dSUzKafN1mQhURgx0Gt1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zOJ+gXQ4uXNfM9jIpSO/PGB240AhR8C5aSX/8LKJBZ2OdfEQGG/jEv+XXrtimNGoC
	 qgGD7aHoN1SQmMHnVYXlEwiccV+R9XY6A9uOWcnX2SyGU4h97hJ7vQBYBK2dQnG6tn
	 r8xjPaFqOm0FRMtaJ2YTaLVBgphLMzAxgJdN/Lrc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.1 446/481] USB: serial: f81232: fix incomplete serial port generation
Date: Mon, 23 Mar 2026 14:47:08 +0100
Message-ID: <20260323134536.084086033@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229920-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 567C02F935D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>

commit cd644b805da8a253198718741bf363c4c58862ff upstream.

The Fintek F81532A/534A/535/536 family relies on the
F81534A_CTRL_CMD_ENABLE_PORT (116h) register during initialization to
both determine serial port status and control port creation. If the
driver experiences fast load/unload cycles, the device state may becomes
unstable, resulting in the incomplete generation of serial ports.

Performing a dummy read operation on the register prior to the initial
write command resolves the issue. This clears the device's stale internal
state. Subsequent write operations will correctly generate all serial
ports.

This patch also removes the retry loop in f81534a_ctrl_set_register()
because the stale state has been fixed.

Tested on: HygonDM1SLT(Hygon C86 3250 8-core Processor)

Signed-off-by: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/f81232.c |   77 ++++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 30 deletions(-)

--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -70,7 +70,6 @@ MODULE_DEVICE_TABLE(usb, combined_id_tab
 #define F81232_REGISTER_REQUEST		0xa0
 #define F81232_GET_REGISTER		0xc0
 #define F81232_SET_REGISTER		0x40
-#define F81534A_ACCESS_REG_RETRY	2
 
 #define SERIAL_BASE_ADDRESS		0x0120
 #define RECEIVE_BUFFER_REGISTER		(0x00 + SERIAL_BASE_ADDRESS)
@@ -822,36 +821,31 @@ static void f81232_lsr_worker(struct wor
 static int f81534a_ctrl_set_register(struct usb_interface *intf, u16 reg,
 					u16 size, void *val)
 {
-	struct usb_device *dev = interface_to_usbdev(intf);
-	int retry = F81534A_ACCESS_REG_RETRY;
-	int status;
-
-	while (retry--) {
-		status = usb_control_msg_send(dev,
-					      0,
-					      F81232_REGISTER_REQUEST,
-					      F81232_SET_REGISTER,
-					      reg,
-					      0,
-					      val,
-					      size,
-					      USB_CTRL_SET_TIMEOUT,
-					      GFP_KERNEL);
-		if (status) {
-			status = usb_translate_errors(status);
-			if (status == -EIO)
-				continue;
-		}
-
-		break;
-	}
-
-	if (status) {
-		dev_err(&intf->dev, "failed to set register 0x%x: %d\n",
-				reg, status);
-	}
+	return usb_control_msg_send(interface_to_usbdev(intf),
+						0,
+						F81232_REGISTER_REQUEST,
+						F81232_SET_REGISTER,
+						reg,
+						0,
+						val,
+						size,
+						USB_CTRL_SET_TIMEOUT,
+						GFP_KERNEL);
+}
 
-	return status;
+static int f81534a_ctrl_get_register(struct usb_interface *intf, u16 reg,
+					u16 size, void *val)
+{
+	return usb_control_msg_recv(interface_to_usbdev(intf),
+						0,
+						F81232_REGISTER_REQUEST,
+						F81232_GET_REGISTER,
+						reg,
+						0,
+						val,
+						size,
+						USB_CTRL_GET_TIMEOUT,
+						GFP_KERNEL);
 }
 
 static int f81534a_ctrl_enable_all_ports(struct usb_interface *intf, bool en)
@@ -867,6 +861,29 @@ static int f81534a_ctrl_enable_all_ports
 	 * bit 0~11	: Serial port enable bit.
 	 */
 	if (en) {
+		/*
+		 * The Fintek F81532A/534A/535/536 family relies on the
+		 * F81534A_CTRL_CMD_ENABLE_PORT (116h) register during
+		 * initialization to both determine serial port status and
+		 * control port creation.
+		 *
+		 * If the driver experiences fast load/unload cycles, the
+		 * device state may becomes unstable, resulting in the
+		 * incomplete generation of serial ports.
+		 *
+		 * Performing a dummy read operation on the register prior
+		 * to the initial write command resolves the issue.
+		 *
+		 * This clears the device's stale internal state. Subsequent
+		 * write operations will correctly generate all serial ports.
+		 */
+		status = f81534a_ctrl_get_register(intf,
+						F81534A_CTRL_CMD_ENABLE_PORT,
+						sizeof(enable),
+						enable);
+		if (status)
+			return status;
+
 		enable[0] = 0xff;
 		enable[1] = 0x8f;
 	}



