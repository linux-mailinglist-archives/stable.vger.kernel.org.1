Return-Path: <stable+bounces-22011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B2C85D9AF
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF472B2482C
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5617994B;
	Wed, 21 Feb 2024 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dimt/ojO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B302763FE;
	Wed, 21 Feb 2024 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521654; cv=none; b=WBH5Nbu2spsY2ZSiHzbR/yaVWGqaGZiREHPCb4XxQZQZQh7+9mo6ZEiZaaBN5HkoZMfsexPg/Q12s7kgpY2x0jBU5s+E2nUWFyIjz4YrqiMaEsmhZdA/BrhLlgsS1qed2UtsPOQMnu23q20rNG9SqjcjeSCsZTBfMApQOUdovUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521654; c=relaxed/simple;
	bh=2Cray4e2mIxdOeO+E9OMSosVPxqN+++uL6Te6bKWGvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9GkRLaugee2zd4hezg9k/Aa4Kq4WIaY1bmcSUdTEde9kOG7+Ia5siqpmCqULeEp9/JDoYvqXAuRC1GAvxPCtrJdhUkcvPKvTmQrA/ppmXjZkfEkG1s6sAbd1LwSLBS/1dOVMRC6ds+DlNmPF6su0Aox4ukDtI76E7mjN3fd9KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dimt/ojO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915EEC433C7;
	Wed, 21 Feb 2024 13:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708521654;
	bh=2Cray4e2mIxdOeO+E9OMSosVPxqN+++uL6Te6bKWGvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dimt/ojOnygsdlIKTi9Qi9dpkn/uY1rU5JgE7oJ1If2TkDdCuUZ8Hb5OToyAM9uO7
	 blULtEkcAvVVvexCV/oDYqfc+htb2ER8bifFYo+Yce+YLv+eqKcu8wX4hv+EhazxQK
	 Z7t5U2+Af06E2i3pEtVlfzbdpwDACErdsY0ACBpU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Henrie <alexhenrie24@gmail.com>,
	Jiri Kosina <jkosina@suse.cz>,
	Aseda Aboagye <aaboagye@chromium.org>
Subject: [PATCH 4.19 142/202] HID: apple: Add support for the 2021 Magic Keyboard
Date: Wed, 21 Feb 2024 14:07:23 +0100
Message-ID: <20240221125936.298626839@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125931.742034354@linuxfoundation.org>
References: <20240221125931.742034354@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Henrie <alexhenrie24@gmail.com>

commit 0cd3be51733febb4f8acb92bcf55b75fe824dd05 upstream.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Cc: Aseda Aboagye <aaboagye@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-apple.c  |    4 ++++
 drivers/hid/hid-ids.h    |    1 +
 drivers/hid/hid-quirks.c |    1 +
 3 files changed, 6 insertions(+)

--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -599,6 +599,10 @@ static const struct hid_device_id apple_
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY),
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021),
+		.driver_data = APPLE_HAS_FN },
+	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021),
+		.driver_data = APPLE_HAS_FN },
 
 	{ }
 };
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -176,6 +176,7 @@
 #define USB_DEVICE_ID_APPLE_IRCONTROL3	0x8241
 #define USB_DEVICE_ID_APPLE_IRCONTROL4	0x8242
 #define USB_DEVICE_ID_APPLE_IRCONTROL5	0x8243
+#define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021   0x029c
 
 #define USB_VENDOR_ID_ASUS		0x0486
 #define USB_DEVICE_ID_ASUS_T91MT	0x0185
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -301,6 +301,7 @@ static const struct hid_device_id hid_ha
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021) },
 #endif
 #if IS_ENABLED(CONFIG_HID_APPLEIR)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL) },



