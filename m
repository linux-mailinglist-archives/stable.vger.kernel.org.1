Return-Path: <stable+bounces-138485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D77FDAA18A3
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A049C2849
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B4125393E;
	Tue, 29 Apr 2025 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wvBAP/6Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA152243371;
	Tue, 29 Apr 2025 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949402; cv=none; b=YLnfYCcyQS7D9GgSCGTYmgmISGS4JL9RzUL+rr+ahFqjrMeyTEqSgvuuKXME/dRhySxBcIRfaHn1Oyciaoa+geA++LylJP/KDJjafLpstZ/wAX9eNIlJDNvqLZXOGMvgM06IlFbrbaO7PGoZgW/+xy+9gsGVr7MuNqcQuS17ilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949402; c=relaxed/simple;
	bh=3zF6LXlrUL2fjCKF8goNIzJl+OvWIVk6ico+tS5PK4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSaBqW7sc88ipqcluzMKKsWQdEDme7nCOKq1vlKa4qy9eQqZgHXVY83I9Cs/+KnTaUUglEBVBYaRmA2ue4BxkaJZfnBA9mTcF7SAP+FcwWag15Fz7GYGrL4i6jNcuVwhAk7qncoRz7BGXhOi86V128dIS7BvhhH6Cw7hIEYWwzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wvBAP/6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4A6C4CEE3;
	Tue, 29 Apr 2025 17:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949402;
	bh=3zF6LXlrUL2fjCKF8goNIzJl+OvWIVk6ico+tS5PK4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wvBAP/6ZRXVIhkRWXPP/1W7iCbHFzMdnjthEocBkJE4Ntsxe7/9JECBfb2l4gzdMx
	 Kr9TgJssgSiiLQRa3fRKXQLExCTQ8qG34qQLcW4GfmXowD/pEE5WukPw4lhD1eOyuh
	 wDyRlGShvBF+FUVxtogRCNnufVorq9aNSJm+N04g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Ehrenreich <michideep@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.15 307/373] USB: serial: ftdi_sio: add support for Abacus Electrics Optical Probe
Date: Tue, 29 Apr 2025 18:43:04 +0200
Message-ID: <20250429161135.744676224@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ehrenreich <michideep@gmail.com>

commit b399078f882b6e5d32da18b6c696cc84b12f90d5 upstream.

Abacus Electrics makes optical probes for interacting with smart meters
over an optical interface.

At least one version uses an FT232B chip (as detected by ftdi_sio) with
a custom USB PID, which needs to be added to the list to make the device
work in a plug-and-play fashion.

Signed-off-by: Michael Ehrenreich <michideep@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/ftdi_sio.c     |    2 ++
 drivers/usb/serial/ftdi_sio_ids.h |    5 +++++
 2 files changed, 7 insertions(+)

--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1071,6 +1071,8 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 1) },
 	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 2) },
 	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 3) },
+	/* Abacus Electrics */
+	{ USB_DEVICE(FTDI_VID, ABACUS_OPTICAL_PROBE_PID) },
 	{ }					/* Terminating entry */
 };
 
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -436,6 +436,11 @@
 #define LINX_FUTURE_2_PID   0xF44C	/* Linx future device */
 
 /*
+ * Abacus Electrics
+ */
+#define ABACUS_OPTICAL_PROBE_PID	0xf458 /* ABACUS ELECTRICS Optical Probe */
+
+/*
  * Oceanic product ids
  */
 #define FTDI_OCEANIC_PID	0xF460  /* Oceanic dive instrument */



