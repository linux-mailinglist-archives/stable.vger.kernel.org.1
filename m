Return-Path: <stable+bounces-77950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C116998845F
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDEE21C23180
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 12:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5634D18BC26;
	Fri, 27 Sep 2024 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="okA63Mf+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1366718BC33;
	Fri, 27 Sep 2024 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727440006; cv=none; b=cfvYqu0nv7mph8F3GGTH8DvzYDKk1sMw1xoBTwubeiGqmClVHW3LNkZFt7iMWp5PY3mW3tul2y4AywIqRvJ5YLsNXQNYrBFIZ4yd3ElaHiBuQACDUI2XVzChkgLFNErW4cdBlj2dcDaa2BA3A9gSfgOu0vLrD7achvA7YXbCeHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727440006; c=relaxed/simple;
	bh=YTw9Q8oI28GVkBaWJrqEPrc/D79QRjdVp0shAvuRXfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JmXLo6H6Yj6919VrGapcd6yD8imseCrew1Ql0eT4thFrJUeVO15nO+ytMe1jyPV/xnvKX2erb7BkhGScFs7KDxeabNnXFGp6w0yG0mX/wS1ZR8cRjr5gNakwCQEzQC8TwQuZvXZOjZagRUyvDzJ3h/6fyp8MPI6Jvs5+E32f0xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=okA63Mf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DABC4CEC4;
	Fri, 27 Sep 2024 12:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727440006;
	bh=YTw9Q8oI28GVkBaWJrqEPrc/D79QRjdVp0shAvuRXfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=okA63Mf+TkGYW0juthqmUT54Vo9aIYMYaVqeQ8XSRgEQBRCbLtGpDlBjTQsXw37Rt
	 ea21ZsWPFbDRSNnCsB6YM8KqhB9sgHXLwMTqWeC7O6CqyciKyS4JNx7PXl68sAVoWj
	 yHyWLljFDPctWxKj6GVTg9z17icWSwxLHTSasnT8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Junhao Xie <bigfoot@classfun.cn>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.6 53/54] USB: serial: pl2303: add device id for Macrosilicon MS3020
Date: Fri, 27 Sep 2024 14:23:45 +0200
Message-ID: <20240927121721.939595689@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927121719.714627278@linuxfoundation.org>
References: <20240927121719.714627278@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junhao Xie <bigfoot@classfun.cn>

commit 7d47d22444bb7dc1b6d768904a22070ef35e1fc0 upstream.

Add the device id for the Macrosilicon MS3020 which is a
PL2303HXN based device.

Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/pl2303.c |    1 +
 drivers/usb/serial/pl2303.h |    4 ++++
 2 files changed, 5 insertions(+)

--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -118,6 +118,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(SMART_VENDOR_ID, SMART_PRODUCT_ID) },
 	{ USB_DEVICE(AT_VENDOR_ID, AT_VTKIT3_PRODUCT_ID) },
 	{ USB_DEVICE(IBM_VENDOR_ID, IBM_PRODUCT_ID) },
+	{ USB_DEVICE(MACROSILICON_VENDOR_ID, MACROSILICON_MS3020_PRODUCT_ID) },
 	{ }					/* Terminating entry */
 };
 
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -171,3 +171,7 @@
 /* Allied Telesis VT-Kit3 */
 #define AT_VENDOR_ID		0x0caa
 #define AT_VTKIT3_PRODUCT_ID	0x3001
+
+/* Macrosilicon MS3020 */
+#define MACROSILICON_VENDOR_ID		0x345f
+#define MACROSILICON_MS3020_PRODUCT_ID	0x3020



