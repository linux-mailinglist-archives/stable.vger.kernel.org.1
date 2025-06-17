Return-Path: <stable+bounces-154240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D38FADD96A
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5804A1B5B
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00212E8E10;
	Tue, 17 Jun 2025 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ihvo39j/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD8F2EA147;
	Tue, 17 Jun 2025 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178551; cv=none; b=A4R6/3b1exsgdknpVOFYV5iRzRKuTFkPQacSQQPxSp2wTnotmz7DXesud+85MDuFuq2H2gBfMghUcPtrLcoMTcWp6ZNoefOrMBE1m2fDRGoKRRz8s2bJf3ry+lEyxUrA2tQ/ahcSjCMoyckzEAs3Uf7Wmu4fTY5ohfJZWPBW8xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178551; c=relaxed/simple;
	bh=1kK1xeb325LPqOgROAjIO4CYZor1W3NJvrtHTLkQWqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBj+KgkHrM3iqQGVjUxt1F7K9rA3qqmspKPIwlR2SketJFUAGM2oeMwbMUZA48tVqb8olFVX+DoLimbV9OrGNiaugdKo9k2c1tpq785/8Tbm/OqL4RDCld43mQtpkf+L27WAhF/BgAjB/x7FEdDnx4Y3bBn0kz9emDeACaD9SK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ihvo39j/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB53C4CEE3;
	Tue, 17 Jun 2025 16:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750178551;
	bh=1kK1xeb325LPqOgROAjIO4CYZor1W3NJvrtHTLkQWqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ihvo39j/ghln2vtnsyX0RLrLLqbxkhcghVzvNiNnh7wB59k86/XR2SQtZM1K0dGg2
	 Kfc64yLFWNv9PO6miTouTKE28mGgngrDkj5TNjrD0pkGkKVxlG096DFTWHf4inbXwj
	 G4ny2PtLu5v9W7zFETmM0hFn8UXHNToAplVGWqLc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>,
	Peter Chen <peter.chen@kernel.org>
Subject: [PATCH 6.12 494/512] usb: cdnsp: Fix issue with detecting USB 3.2 speed
Date: Tue, 17 Jun 2025 17:27:40 +0200
Message-ID: <20250617152439.645651762@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pawel Laszczak <pawell@cadence.com>

commit 2852788cfbe9ca1ab68509d65804413871f741f9 upstream.

Patch adds support for detecting SuperSpeedPlus Gen1 x2 and
SuperSpeedPlus Gen2 x2 speed.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/PH7PR07MB95387AD98EDCA695FECE52BADD96A@PH7PR07MB9538.namprd07.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/cdns3/cdnsp-gadget.c |    3 ++-
 drivers/usb/cdns3/cdnsp-gadget.h |    4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -28,7 +28,8 @@
 unsigned int cdnsp_port_speed(unsigned int port_status)
 {
 	/*Detect gadget speed based on PORTSC register*/
-	if (DEV_SUPERSPEEDPLUS(port_status))
+	if (DEV_SUPERSPEEDPLUS(port_status) ||
+	    DEV_SSP_GEN1x2(port_status) || DEV_SSP_GEN2x2(port_status))
 		return USB_SPEED_SUPER_PLUS;
 	else if (DEV_SUPERSPEED(port_status))
 		return USB_SPEED_SUPER;
--- a/drivers/usb/cdns3/cdnsp-gadget.h
+++ b/drivers/usb/cdns3/cdnsp-gadget.h
@@ -285,11 +285,15 @@ struct cdnsp_port_regs {
 #define XDEV_HS			(0x3 << 10)
 #define XDEV_SS			(0x4 << 10)
 #define XDEV_SSP		(0x5 << 10)
+#define XDEV_SSP1x2		(0x6 << 10)
+#define XDEV_SSP2x2		(0x7 << 10)
 #define DEV_UNDEFSPEED(p)	(((p) & DEV_SPEED_MASK) == (0x0 << 10))
 #define DEV_FULLSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_FS)
 #define DEV_HIGHSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_HS)
 #define DEV_SUPERSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_SS)
 #define DEV_SUPERSPEEDPLUS(p)	(((p) & DEV_SPEED_MASK) == XDEV_SSP)
+#define DEV_SSP_GEN1x2(p)	(((p) & DEV_SPEED_MASK) == XDEV_SSP1x2)
+#define DEV_SSP_GEN2x2(p)	(((p) & DEV_SPEED_MASK) == XDEV_SSP2x2)
 #define DEV_SUPERSPEED_ANY(p)	(((p) & DEV_SPEED_MASK) >= XDEV_SS)
 #define DEV_PORT_SPEED(p)	(((p) >> 10) & 0x0f)
 /* Port Link State Write Strobe - set this when changing link state */



