Return-Path: <stable+bounces-98003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662B89E2737
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E1CAB3B462
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056D31F890E;
	Tue,  3 Dec 2024 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0s3v5/Hc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B706C1F76DD;
	Tue,  3 Dec 2024 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242469; cv=none; b=UnwGLnFjCiHq32jR3yTbpbzaEcYlWOGrIhdbBkaTS+zx6SRD+UxNGLhugVUBnQ+eQewFT6r2SKlrT9r53zLgqO47mgnQawLJgCMlisSRC1n6OY1JqjshNopZ39jPV9uu344ActcL+crWiy50VTa5ElvILDNliGwYD2x6jKV2C4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242469; c=relaxed/simple;
	bh=9Li6QILJb63jTUgkVrZN84ATbIQ/GAonl3MKUpS+Jus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1Xyc4PvDjE/Trocrhlkhu4Q6wxklMYkuYT+axMAuMCmIEoU3jCTkK4c95mLhhxHb9B+zRyN2RvIJK2NXI0WSLfWy2IMiOejS31nyDNEwQZdHSlkbEPHRuGlVsiSiEBU+WYxA/XKMAWSF6zvAJJ+fY3qyvPEzDOCM/RH5tQz8y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0s3v5/Hc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AD0C4CED6;
	Tue,  3 Dec 2024 16:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733242469;
	bh=9Li6QILJb63jTUgkVrZN84ATbIQ/GAonl3MKUpS+Jus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0s3v5/Hcnn1GQMsWwb8Y31Mglj5WPqEPxf0G7ArenmCpWiCHrJ2NEN/pgh/7lFivz
	 4UJGQz9axrLtapHe97+yeVklbBWwk91KyLmvZrsiKkwxKwyM5gV8GiieMk5mRDGl2j
	 ngU007yywD5JKyfNxG09/4spxsyTl8ZPm1pJepMI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Filip Brozovic <fbrozovic@gmail.com>,
	stable <stable@kernel.org>
Subject: [PATCH 6.12 712/826] serial: 8250_fintek: Add support for F81216E
Date: Tue,  3 Dec 2024 15:47:19 +0100
Message-ID: <20241203144811.534349585@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filip Brozovic <fbrozovic@gmail.com>

commit 166105c9030a30ba08574a9998afc7b60bc72dd7 upstream.

The F81216E is a LPC/eSPI to 4 UART Super I/O and is mostly compatible with
the F81216H, but does not support RS-485 auto-direction delays on any port.

Signed-off-by: Filip Brozovic <fbrozovic@gmail.com>
Cc: stable <stable@kernel.org>
Link: https://lore.kernel.org/r/20241110111703.15494-1-fbrozovic@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_fintek.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -21,6 +21,7 @@
 #define CHIP_ID_F81866 0x1010
 #define CHIP_ID_F81966 0x0215
 #define CHIP_ID_F81216AD 0x1602
+#define CHIP_ID_F81216E 0x1617
 #define CHIP_ID_F81216H 0x0501
 #define CHIP_ID_F81216 0x0802
 #define VENDOR_ID1 0x23
@@ -158,6 +159,7 @@ static int fintek_8250_check_id(struct f
 	case CHIP_ID_F81866:
 	case CHIP_ID_F81966:
 	case CHIP_ID_F81216AD:
+	case CHIP_ID_F81216E:
 	case CHIP_ID_F81216H:
 	case CHIP_ID_F81216:
 		break;
@@ -181,6 +183,7 @@ static int fintek_8250_get_ldn_range(str
 		return 0;
 
 	case CHIP_ID_F81216AD:
+	case CHIP_ID_F81216E:
 	case CHIP_ID_F81216H:
 	case CHIP_ID_F81216:
 		*min = F81216_LDN_LOW;
@@ -250,6 +253,7 @@ static void fintek_8250_set_irq_mode(str
 		break;
 
 	case CHIP_ID_F81216AD:
+	case CHIP_ID_F81216E:
 	case CHIP_ID_F81216H:
 	case CHIP_ID_F81216:
 		sio_write_mask_reg(pdata, FINTEK_IRQ_MODE, IRQ_SHARE,
@@ -263,7 +267,8 @@ static void fintek_8250_set_irq_mode(str
 static void fintek_8250_set_max_fifo(struct fintek_8250 *pdata)
 {
 	switch (pdata->pid) {
-	case CHIP_ID_F81216H: /* 128Bytes FIFO */
+	case CHIP_ID_F81216E: /* 128Bytes FIFO */
+	case CHIP_ID_F81216H:
 	case CHIP_ID_F81966:
 	case CHIP_ID_F81866:
 		sio_write_mask_reg(pdata, FIFO_CTRL,
@@ -297,6 +302,7 @@ static void fintek_8250_set_termios(stru
 		goto exit;
 
 	switch (pdata->pid) {
+	case CHIP_ID_F81216E:
 	case CHIP_ID_F81216H:
 		reg = RS485;
 		break;
@@ -346,6 +352,7 @@ static void fintek_8250_set_termios_hand
 	struct fintek_8250 *pdata = uart->port.private_data;
 
 	switch (pdata->pid) {
+	case CHIP_ID_F81216E:
 	case CHIP_ID_F81216H:
 	case CHIP_ID_F81966:
 	case CHIP_ID_F81866:
@@ -438,6 +445,11 @@ static void fintek_8250_set_rs485_handle
 			uart->port.rs485_supported = fintek_8250_rs485_supported;
 		break;
 
+	case CHIP_ID_F81216E: /* F81216E does not support RS485 delays */
+		uart->port.rs485_config = fintek_8250_rs485_config;
+		uart->port.rs485_supported = fintek_8250_rs485_supported;
+		break;
+
 	default: /* No RS485 Auto direction functional */
 		break;
 	}



