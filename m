Return-Path: <stable+bounces-93346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A89379CD8B9
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7191F23479
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F64185924;
	Fri, 15 Nov 2024 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cACvrOBy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AF9186294;
	Fri, 15 Nov 2024 06:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653614; cv=none; b=e8G+Lvvt/JdrNeazx5KT6wwdtKJVtY9uLzcIg0WBSm34q2TBe34rkZ0JI83SZ7A/m08RQQbFrhApSCggKlnjKlIJt1DPPyk0xXdcbrOWPv0xdoIlZsVxqNoG4wzLUbDDowJeZtleZUEQ6/+IR7SWU89/cGXtA0dFrZ+Y8B5jir4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653614; c=relaxed/simple;
	bh=Ydl4gN1iky5uDy+G1xKFYNhEX6+c1J0G+g6im9nmpuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qf7hoWncG+KLWaaVsSgbkTGMIWExsacJxqGLs7sIDX1mLUE4MOTpIjHTmCD1fI8PZPS7eCUzdLg5GH9ujOdGn9SYmVyT2KR2XzpuENia/4/qKsVGFViaT4Z1IMIV1LDSPCPiGDjodSOtny70peYBFJfRpSHQVNWMKJNkTo54o4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cACvrOBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D48DC4CECF;
	Fri, 15 Nov 2024 06:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653613;
	bh=Ydl4gN1iky5uDy+G1xKFYNhEX6+c1J0G+g6im9nmpuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cACvrOByPfWuz/L3MmbT0aOq+0OQJKL3zzWEvGH+/SAkpbyDD2dnOHPo5t+KQacw8
	 iRuwMROp5E2BaaGhjTPRrYn1iwBDXwQF5WlKP4SYl45+7URJM+t7PsveNstAWq2aYn
	 P9b1FMcxuXFVy+/aKF0nD66satdx2pm44MWk1FCQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kenneth Albanowski <kenalba@chromium.org>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 25/39] HID: multitouch: Add quirk for Logitech Bolt receiver w/ Casa touchpad
Date: Fri, 15 Nov 2024 07:38:35 +0100
Message-ID: <20241115063723.518110882@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063722.599985562@linuxfoundation.org>
References: <20241115063722.599985562@linuxfoundation.org>
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

From: Kenneth Albanowski <kenalba@chromium.org>

[ Upstream commit 526748b925185e95f1415900ee13c2469d4b64cc ]

The Logitech Casa Touchpad does not reliably send touch release signals
when communicating through the Logitech Bolt wireless-to-USB receiver.

Adjusting the device class to add MT_QUIRK_NOT_SEEN_MEANS_UP to make
sure that no touches become stuck, MT_QUIRK_FORCE_MULTI_INPUT is not
needed, but harmless.

Linux does not have information on which devices are connected to the
Bolt receiver, so we have to enable this for the entire device.

Signed-off-by: Kenneth Albanowski <kenalba@chromium.org>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h        | 1 +
 drivers/hid/hid-multitouch.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index f3b183a7b7fa4..f1c106f5e90b9 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -859,6 +859,7 @@
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1	0xc539
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_1	0xc53f
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_POWERPLAY	0xc53a
+#define USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER	0xc548
 #define USB_DEVICE_ID_SPACETRAVELLER	0xc623
 #define USB_DEVICE_ID_SPACENAVIGATOR	0xc626
 #define USB_DEVICE_ID_DINOVO_DESKTOP	0xc704
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index c2d79b2d6cdd2..bf9cad7112592 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2140,6 +2140,10 @@ static const struct hid_device_id mt_devices[] = {
 		HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_LOGITECH,
 			USB_DEVICE_ID_LOGITECH_CASA_TOUCHPAD) },
+	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU,
+		HID_DEVICE(BUS_USB, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_LOGITECH,
+			USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER) },
 
 	/* MosArt panels */
 	{ .driver_data = MT_CLS_CONFIDENCE_MINUS_ONE,
-- 
2.43.0




