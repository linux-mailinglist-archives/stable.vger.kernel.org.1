Return-Path: <stable+bounces-35273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87292894337
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 19:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7654B20BAB
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CC8482DF;
	Mon,  1 Apr 2024 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZaJAbUbJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3784147A5D;
	Mon,  1 Apr 2024 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990860; cv=none; b=K334lyglckyt/EKP7e18SSHr6cnINMNP6E/yC6EM1HAJq34CWDHL3AuvRhhkUdu3Th4LBY3rOp3OzdrmpZ4fyJszyD7/36qDq/lCXaLBrV4oJFaJsP5htAifOkwf+2RKK+tOBYYLwks7nT8ADzm0BM5tVqxvImkP2fstb2SQ2co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990860; c=relaxed/simple;
	bh=fXfpDw7NdompVa4c+S+GbYL9e2NlkA8hgW2qGtA99YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZKnYdDrkmmXczZyEQ5/trD4FbBEvbIaJTrnwl36tf3We1ks5PrrG9YEc6MyH+iUXbXEwqURqYZNsgP+wpzpcWU8AF3Gs+Y3CdFyX9W05yR8H8gsD1ghAhd9oqQ023Uvq+uzMSklDPzjPcDDFBnYzrMe4NRVkmbbtm9AGSBK60U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZaJAbUbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE70C433F1;
	Mon,  1 Apr 2024 17:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990860;
	bh=fXfpDw7NdompVa4c+S+GbYL9e2NlkA8hgW2qGtA99YI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZaJAbUbJIpDRKVgFsWsctHj6MIhxlAAwaBAdBTkGCNTpqZnxJp89hfjTGD3vm5kad
	 R/LScq7GNCJSb9EKn1zfc+ZQqpHnZWz/TGinjLGiUxsl/8CF9eXVD+N/MGaOmKQuJi
	 ggMlkwmYlSK3v5Oax0LMnmHztOfsMdCVWYGHFsNU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Vogelbacher <daniel@chaospixel.com>,
	Johan Hovold <johan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 059/272] USB: serial: ftdi_sio: add support for GMC Z216C Adapter IR-USB
Date: Mon,  1 Apr 2024 17:44:09 +0200
Message-ID: <20240401152532.401358820@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
References: <20240401152530.237785232@linuxfoundation.org>
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

From: Daniel Vogelbacher <daniel@chaospixel.com>

[ Upstream commit 3fb7bc4f3a98c48981318b87cf553c5f115fd5ca ]

The GMC IR-USB adapter cable utilizes a FTDI FT232R chip.

Add VID/PID for this adapter so it can be used as serial device via
ftdi_sio.

Signed-off-by: Daniel Vogelbacher <daniel@chaospixel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c     | 2 ++
 drivers/usb/serial/ftdi_sio_ids.h | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index fe2173e37b061..248cbc9c48fd1 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1077,6 +1077,8 @@ static const struct usb_device_id id_table_combined[] = {
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
 	{ USB_DEVICE(FTDI_VID, FTDI_FALCONIA_JTAG_UNBUF_PID),
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	/* GMC devices */
+	{ USB_DEVICE(GMC_VID, GMC_Z216C_PID) },
 	{ }					/* Terminating entry */
 };
 
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index 21a2b5a25fc09..5ee60ba2a73cd 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -1606,3 +1606,9 @@
 #define UBLOX_VID			0x1546
 #define UBLOX_C099F9P_ZED_PID		0x0502
 #define UBLOX_C099F9P_ODIN_PID		0x0503
+
+/*
+ * GMC devices
+ */
+#define GMC_VID				0x1cd7
+#define GMC_Z216C_PID			0x0217 /* GMC Z216C Adapter IR-USB */
-- 
2.43.0




