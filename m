Return-Path: <stable+bounces-192928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4223C462D8
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 12:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D733BA9C9
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 11:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC4D309EFC;
	Mon, 10 Nov 2025 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvkX4q0u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941CD3090FB;
	Mon, 10 Nov 2025 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773292; cv=none; b=LtDSdObewxBzkLoEnEtX5MBCW1+9Xo8DHPFvOLe0VWzl1CV+lrDkrmsJqymju3zINmIF3kStqg0HIepz6/FIgar/dKfFDf9gimgpxMl+G38SaoRwrC6yrpFAQNVPHTEgrlf2vKM7cCurwGKNJcBlWQcnXELeDFRhgTX+k2Pi9O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773292; c=relaxed/simple;
	bh=OFYqhoFHCb9z5lCtrXzvza23SjBkOyj647ogbswGaTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbbBnLo47CZziRWsc5AlMtfTaHH/xFOpzxBkK2ZRVG3XWQ6fjoc+KyC7MQsey8CBQ5WFaCwRcupTgKW10q+hCvMoNl+yaQvI4zK0MqVildsYk5OyisAVVxixL85/h4IRqGvBFdr0f0w1kwomBKFX281GZMxzdl5HuCiLHYvbVsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvkX4q0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC239C116D0;
	Mon, 10 Nov 2025 11:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762773292;
	bh=OFYqhoFHCb9z5lCtrXzvza23SjBkOyj647ogbswGaTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jvkX4q0uZa2PNO7Dp+T2n35s2PVi9VO5jrQESLJzDRpNaNRPS9NZz/oPkQ9TFL/mu
	 2C0rq89OGbb+D6Hc0ts9/XKL4RWMCUsBK1cRBIXXRa9Og8VC5pDYoyx/3xY1vVppj6
	 oVedrJPnfWcMLVa7Sn926N3s201A9lLYWmTf/JnpA4YrZZhh8hhORaMQ/BFdylW2Ay
	 Y+lo/40Kizd6MnK6KgXlfmhNTYeiHfUxa6VJB/rTwoh772psPCFe12MbEzj1/K8NEp
	 ISD8LKJA6z0WJis8TRKlECghOR6gX79Ko9UfTyqTxB4okbFla7pGyVNcEtGvJcFJoa
	 jiW1XtMy2PKxQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vIPrI-0000000007Y-0whP;
	Mon, 10 Nov 2025 12:14:52 +0100
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ryan Mann <rmann@ndigital.com>,
	Andreas Messer <andi@bastelmap.de>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/8] USB: serial: ftdi_sio: match on interface number for jtag
Date: Mon, 10 Nov 2025 12:12:05 +0100
Message-ID: <20251110111212.32702-2-johan@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110111212.32702-1-johan@kernel.org>
References: <20251110111212.32702-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some FTDI devices have the first port reserved for JTAG and have been
using a dedicated quirk to prevent binding to it.

As can be inferred directly or indirectly from the commit messages,
almost all of these devices are dual port devices which means that the
more recently added macro for matching on interface number can be used
instead (and some such devices do so already).

This avoids probing interfaces that will never be bound and cleans up
the match table somewhat.

Note that the JTAG quirk is kept for quad port devices, which would
otherwise require three match entries.

Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 72 ++++++++++++-----------------------
 1 file changed, 24 insertions(+), 48 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index b37fa31f5694..9993a5123344 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -628,10 +628,8 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(FTDI_VID, FTDI_IBS_PEDO_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_IBS_PROD_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_TAVIR_STK500_PID) },
-	{ USB_DEVICE(FTDI_VID, FTDI_TIAO_UMPA_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(FTDI_VID, FTDI_NT_ORIONLXM_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, FTDI_TIAO_UMPA_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, FTDI_NT_ORIONLXM_PID, 1) },
 	{ USB_DEVICE(FTDI_VID, FTDI_NT_ORIONLX_PLUS_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_NT_ORION_IO_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_NT_ORIONMX_PID) },
@@ -842,24 +840,17 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(FTDI_VID, FTDI_ELSTER_UNICOM_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_PROPOX_JTAGCABLEII_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_PROPOX_ISPCABLEIII_PID) },
-	{ USB_DEVICE(FTDI_VID, CYBER_CORTEX_AV_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, CYBER_CORTEX_AV_PID, 1) },
 	{ USB_DEVICE_INTERFACE_NUMBER(OLIMEX_VID, OLIMEX_ARM_USB_OCD_PID, 1) },
 	{ USB_DEVICE_INTERFACE_NUMBER(OLIMEX_VID, OLIMEX_ARM_USB_OCD_H_PID, 1) },
 	{ USB_DEVICE_INTERFACE_NUMBER(OLIMEX_VID, OLIMEX_ARM_USB_TINY_PID, 1) },
 	{ USB_DEVICE_INTERFACE_NUMBER(OLIMEX_VID, OLIMEX_ARM_USB_TINY_H_PID, 1) },
-	{ USB_DEVICE(FIC_VID, FIC_NEO1973_DEBUG_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(FTDI_VID, FTDI_OOCDLINK_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(FTDI_VID, LMI_LM3S_DEVEL_BOARD_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(FTDI_VID, LMI_LM3S_EVAL_BOARD_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(FTDI_VID, LMI_LM3S_ICDI_BOARD_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(FTDI_VID, FTDI_TURTELIZER_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE_INTERFACE_NUMBER(FIC_VID, FIC_NEO1973_DEBUG_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, FTDI_OOCDLINK_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, LMI_LM3S_DEVEL_BOARD_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, LMI_LM3S_EVAL_BOARD_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, LMI_LM3S_ICDI_BOARD_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, FTDI_TURTELIZER_PID, 1) },
 	{ USB_DEVICE(RATOC_VENDOR_ID, RATOC_PRODUCT_ID_USB60F) },
 	{ USB_DEVICE(RATOC_VENDOR_ID, RATOC_PRODUCT_ID_SCU18) },
 	{ USB_DEVICE(FTDI_VID, FTDI_REU_TINY_PID) },
@@ -901,17 +892,14 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(ATMEL_VID, STK541_PID) },
 	{ USB_DEVICE(DE_VID, STB_PID) },
 	{ USB_DEVICE(DE_VID, WHT_PID) },
-	{ USB_DEVICE(ADI_VID, ADI_GNICE_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(ADI_VID, ADI_GNICEPLUS_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE_INTERFACE_NUMBER(ADI_VID, ADI_GNICE_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ADI_VID, ADI_GNICEPLUS_PID, 1) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MICROCHIP_VID, MICROCHIP_USB_BOARD_PID,
 					USB_CLASS_VENDOR_SPEC,
 					USB_SUBCLASS_VENDOR_SPEC, 0x00) },
 	{ USB_DEVICE_INTERFACE_NUMBER(ACTEL_VID, MICROSEMI_ARROW_SF2PLUS_BOARD_PID, 2) },
 	{ USB_DEVICE(JETI_VID, JETI_SPC1201_PID) },
-	{ USB_DEVICE(MARVELL_VID, MARVELL_SHEEVAPLUG_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE_INTERFACE_NUMBER(MARVELL_VID, MARVELL_SHEEVAPLUG_PID, 1) },
 	{ USB_DEVICE(LARSENBRUSGAARD_VID, LB_ALTITRACK_PID) },
 	{ USB_DEVICE(GN_OTOMETRICS_VID, AURICAL_USB_PID) },
 	{ USB_DEVICE(FTDI_VID, PI_C865_PID) },
@@ -934,10 +922,8 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(PI_VID, PI_1016_PID) },
 	{ USB_DEVICE(KONDO_VID, KONDO_USB_SERIAL_PID) },
 	{ USB_DEVICE(BAYER_VID, BAYER_CONTOUR_CABLE_PID) },
-	{ USB_DEVICE(FTDI_VID, MARVELL_OPENRD_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(FTDI_VID, TI_XDS100V2_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, MARVELL_OPENRD_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, TI_XDS100V2_PID, 1) },
 	{ USB_DEVICE(FTDI_VID, HAMEG_HO820_PID) },
 	{ USB_DEVICE(FTDI_VID, HAMEG_HO720_PID) },
 	{ USB_DEVICE(FTDI_VID, HAMEG_HO730_PID) },
@@ -946,18 +932,14 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(FTDI_VID, MJSG_SR_RADIO_PID) },
 	{ USB_DEVICE(FTDI_VID, MJSG_HD_RADIO_PID) },
 	{ USB_DEVICE(FTDI_VID, MJSG_XM_RADIO_PID) },
-	{ USB_DEVICE(FTDI_VID, XVERVE_SIGNALYZER_ST_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(FTDI_VID, XVERVE_SIGNALYZER_SLITE_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(FTDI_VID, XVERVE_SIGNALYZER_SH2_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, XVERVE_SIGNALYZER_ST_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, XVERVE_SIGNALYZER_SLITE_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, XVERVE_SIGNALYZER_SH2_PID, 1) },
 	{ USB_DEVICE(FTDI_VID, XVERVE_SIGNALYZER_SH4_PID),
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
 	{ USB_DEVICE(FTDI_VID, SEGWAY_RMP200_PID) },
 	{ USB_DEVICE(FTDI_VID, ACCESIO_COM4SM_PID) },
-	{ USB_DEVICE(IONICS_VID, IONICS_PLUGCOMPUTER_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE_INTERFACE_NUMBER(IONICS_VID, IONICS_PLUGCOMPUTER_PID, 1) },
 	{ USB_DEVICE(FTDI_VID, FTDI_CHAMSYS_24_MASTER_WING_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_CHAMSYS_PC_WING_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_CHAMSYS_USB_DMX_PID) },
@@ -972,15 +954,12 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(FTDI_VID, FTDI_CINTERION_MC55I_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_FHE_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_DOTEC_PID) },
-	{ USB_DEVICE(QIHARDWARE_VID, MILKYMISTONE_JTAGSERIAL_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(ST_VID, ST_STMCLT_2232_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE_INTERFACE_NUMBER(QIHARDWARE_VID, MILKYMISTONE_JTAGSERIAL_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ST_VID, ST_STMCLT_2232_PID, 1) },
 	{ USB_DEVICE(ST_VID, ST_STMCLT_4232_PID),
 		.driver_info = (kernel_ulong_t)&ftdi_stmclite_quirk },
 	{ USB_DEVICE(FTDI_VID, FTDI_RF_R106) },
-	{ USB_DEVICE(FTDI_VID, FTDI_DISTORTEC_JTAG_LOCK_PICK_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, FTDI_DISTORTEC_JTAG_LOCK_PICK_PID, 1) },
 	{ USB_DEVICE(FTDI_VID, FTDI_LUMEL_PD12_PID) },
 	/* Crucible Devices */
 	{ USB_DEVICE(FTDI_VID, FTDI_CT_COMET_PID) },
@@ -1055,8 +1034,7 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(ICPDAS_VID, ICPDAS_I7561U_PID) },
 	{ USB_DEVICE(ICPDAS_VID, ICPDAS_I7563U_PID) },
 	{ USB_DEVICE(WICED_VID, WICED_USB20706V2_PID) },
-	{ USB_DEVICE(TI_VID, TI_CC3200_LAUNCHPAD_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE_INTERFACE_NUMBER(TI_VID, TI_CC3200_LAUNCHPAD_PID, 1) },
 	{ USB_DEVICE(CYPRESS_VID, CYPRESS_WICED_BT_USB_PID) },
 	{ USB_DEVICE(CYPRESS_VID, CYPRESS_WICED_WL_USB_PID) },
 	{ USB_DEVICE(AIRBUS_DS_VID, AIRBUS_DS_P8GR) },
@@ -1076,10 +1054,8 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(UBLOX_VID, UBLOX_C099F9P_ODIN_PID) },
 	{ USB_DEVICE_INTERFACE_NUMBER(UBLOX_VID, UBLOX_EVK_M101_PID, 2) },
 	/* FreeCalypso USB adapters */
-	{ USB_DEVICE(FTDI_VID, FTDI_FALCONIA_JTAG_BUF_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(FTDI_VID, FTDI_FALCONIA_JTAG_UNBUF_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, FTDI_FALCONIA_JTAG_BUF_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, FTDI_FALCONIA_JTAG_UNBUF_PID, 1) },
 	/* GMC devices */
 	{ USB_DEVICE(GMC_VID, GMC_Z216C_PID) },
 	/* Altera USB Blaster 3 */
-- 
2.51.0


