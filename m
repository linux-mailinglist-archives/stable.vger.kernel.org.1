Return-Path: <stable+bounces-111160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF2CA21E88
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 15:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C973A3B91
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 14:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C083C1DE8BE;
	Wed, 29 Jan 2025 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNyli/nq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9581922F5;
	Wed, 29 Jan 2025 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159392; cv=none; b=XwvwtK9ysF7WVkOuruMYigmXMBxEAwjVG24AP1Xx8xTVBtLNO5M5q0XdxFUfqOWvSdWmcMa3NY2nAnWVyU29oGopecUZFjubMulRtSHAJ24zq+3oVk18wcdzFRSKovWfV+zfhDEvIR2PeAKRzALoew9WXZL79IEVpifyDxprFow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159392; c=relaxed/simple;
	bh=ejmx90QDrdlnGXjSHEzRHCyNdzPysUK94aN4rehrB4c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a8tldop8ANuKZ36FGNQSfCN6LT5vpAvL3wr+WRjHIfiuPAYokSYpa2hfOmDN8bkhlxhnYT6qlqE/nKPmRP+PiD0d5F4ctDqTiw/C5vz88li1fhUVd60sbFWr36ON6FXPk8EW5hdTnxM9q5vbAIEWcBwIDtuYo/g6fUXgXjw9P2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNyli/nq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CC7C4CED1;
	Wed, 29 Jan 2025 14:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738159392;
	bh=ejmx90QDrdlnGXjSHEzRHCyNdzPysUK94aN4rehrB4c=;
	h=From:To:Cc:Subject:Date:From;
	b=PNyli/nqU3cFq++y26Pq24VQvTGrYSSmNybIkOJq8UvmFfudrQnpRFaJvlWawDM6H
	 fba2KJ/hdeUfDyUWkgVwhkzUo60r6p/KHL1Fy8zQU0BPbbniU1YNg3N/12PostKw8s
	 7jdV3qac72bWIyVMju9dPCt/shexG8tvc1jTAQfvdqdKyk3lzYuT/cgYGUOawUV5o8
	 001WVYOiYZryrgnAaRpHpi2QVwz/h6hgijFPki15U87fnigeTYpWjBEKQf7n36oTOX
	 64XYIyoI9A5Fw/5bgTWFQknyTX8lOlBnPEEaHXL6qU/uPvCmBNHRwtJIZ5iVOD83B4
	 wf3n8dWbN7Kyw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	jirislaby@kernel.org,
	arnd@kernel.org,
	crescentcy.hsieh@moxa.com,
	peterz@infradead.org,
	dlemoal@kernel.org,
	schnelle@linux.ibm.com,
	linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 1/8] serial: 8250_pci: Resolve WCH vendor ID ambiguity
Date: Wed, 29 Jan 2025 07:59:21 -0500
Message-Id: <20250129125930.1273051-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 16076ca3a1565491bcb28689e555d569a39391c7 ]

There are two sites of the same brand: wch.cn and wch-ic.com.
They are property of the same company, but it appears that they
managed to get two different PCI vendor IDs. Rename them accordingly
using standard pattern, i.e. PCI_VENDOR_ID_...

While at it, move to PCI_VDEVICE() in the ID tables.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20241204031114.1029882-2-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_pci.c | 82 +++++++++++++++---------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 6709b6a5f3011..82fba431a95cf 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -64,23 +64,23 @@
 #define PCIE_DEVICE_ID_NEO_2_OX_IBM	0x00F6
 #define PCI_DEVICE_ID_PLX_CRONYX_OMEGA	0xc001
 #define PCI_DEVICE_ID_INTEL_PATSBURG_KT 0x1d3d
-#define PCI_VENDOR_ID_WCH		0x4348
-#define PCI_DEVICE_ID_WCH_CH352_2S	0x3253
-#define PCI_DEVICE_ID_WCH_CH353_4S	0x3453
-#define PCI_DEVICE_ID_WCH_CH353_2S1PF	0x5046
-#define PCI_DEVICE_ID_WCH_CH353_1S1P	0x5053
-#define PCI_DEVICE_ID_WCH_CH353_2S1P	0x7053
-#define PCI_DEVICE_ID_WCH_CH355_4S	0x7173
+#define PCI_VENDOR_ID_WCHCN		0x4348
+#define PCI_DEVICE_ID_WCHCN_CH352_2S	0x3253
+#define PCI_DEVICE_ID_WCHCN_CH353_4S	0x3453
+#define PCI_DEVICE_ID_WCHCN_CH353_2S1PF	0x5046
+#define PCI_DEVICE_ID_WCHCN_CH353_1S1P	0x5053
+#define PCI_DEVICE_ID_WCHCN_CH353_2S1P	0x7053
+#define PCI_DEVICE_ID_WCHCN_CH355_4S	0x7173
 #define PCI_VENDOR_ID_AGESTAR		0x5372
 #define PCI_DEVICE_ID_AGESTAR_9375	0x6872
 #define PCI_DEVICE_ID_BROADCOM_TRUMANAGE 0x160a
 #define PCI_DEVICE_ID_AMCC_ADDIDATA_APCI7800 0x818e
 
-#define PCIE_VENDOR_ID_WCH		0x1c00
-#define PCIE_DEVICE_ID_WCH_CH382_2S1P	0x3250
-#define PCIE_DEVICE_ID_WCH_CH384_4S	0x3470
-#define PCIE_DEVICE_ID_WCH_CH384_8S	0x3853
-#define PCIE_DEVICE_ID_WCH_CH382_2S	0x3253
+#define PCI_VENDOR_ID_WCHIC		0x1c00
+#define PCI_DEVICE_ID_WCHIC_CH382_2S1P	0x3250
+#define PCI_DEVICE_ID_WCHIC_CH384_4S	0x3470
+#define PCI_DEVICE_ID_WCHIC_CH384_8S	0x3853
+#define PCI_DEVICE_ID_WCHIC_CH382_2S	0x3253
 
 #define PCI_DEVICE_ID_MOXA_CP102E	0x1024
 #define PCI_DEVICE_ID_MOXA_CP102EL	0x1025
@@ -2777,80 +2777,80 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 	},
 	/* WCH CH353 1S1P card (16550 clone) */
 	{
-		.vendor         = PCI_VENDOR_ID_WCH,
-		.device         = PCI_DEVICE_ID_WCH_CH353_1S1P,
+		.vendor         = PCI_VENDOR_ID_WCHCN,
+		.device         = PCI_DEVICE_ID_WCHCN_CH353_1S1P,
 		.subvendor      = PCI_ANY_ID,
 		.subdevice      = PCI_ANY_ID,
 		.setup          = pci_wch_ch353_setup,
 	},
 	/* WCH CH353 2S1P card (16550 clone) */
 	{
-		.vendor         = PCI_VENDOR_ID_WCH,
-		.device         = PCI_DEVICE_ID_WCH_CH353_2S1P,
+		.vendor         = PCI_VENDOR_ID_WCHCN,
+		.device         = PCI_DEVICE_ID_WCHCN_CH353_2S1P,
 		.subvendor      = PCI_ANY_ID,
 		.subdevice      = PCI_ANY_ID,
 		.setup          = pci_wch_ch353_setup,
 	},
 	/* WCH CH353 4S card (16550 clone) */
 	{
-		.vendor         = PCI_VENDOR_ID_WCH,
-		.device         = PCI_DEVICE_ID_WCH_CH353_4S,
+		.vendor         = PCI_VENDOR_ID_WCHCN,
+		.device         = PCI_DEVICE_ID_WCHCN_CH353_4S,
 		.subvendor      = PCI_ANY_ID,
 		.subdevice      = PCI_ANY_ID,
 		.setup          = pci_wch_ch353_setup,
 	},
 	/* WCH CH353 2S1PF card (16550 clone) */
 	{
-		.vendor         = PCI_VENDOR_ID_WCH,
-		.device         = PCI_DEVICE_ID_WCH_CH353_2S1PF,
+		.vendor         = PCI_VENDOR_ID_WCHCN,
+		.device         = PCI_DEVICE_ID_WCHCN_CH353_2S1PF,
 		.subvendor      = PCI_ANY_ID,
 		.subdevice      = PCI_ANY_ID,
 		.setup          = pci_wch_ch353_setup,
 	},
 	/* WCH CH352 2S card (16550 clone) */
 	{
-		.vendor		= PCI_VENDOR_ID_WCH,
-		.device		= PCI_DEVICE_ID_WCH_CH352_2S,
+		.vendor		= PCI_VENDOR_ID_WCHCN,
+		.device		= PCI_DEVICE_ID_WCHCN_CH352_2S,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.setup		= pci_wch_ch353_setup,
 	},
 	/* WCH CH355 4S card (16550 clone) */
 	{
-		.vendor		= PCI_VENDOR_ID_WCH,
-		.device		= PCI_DEVICE_ID_WCH_CH355_4S,
+		.vendor		= PCI_VENDOR_ID_WCHCN,
+		.device		= PCI_DEVICE_ID_WCHCN_CH355_4S,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.setup		= pci_wch_ch355_setup,
 	},
 	/* WCH CH382 2S card (16850 clone) */
 	{
-		.vendor         = PCIE_VENDOR_ID_WCH,
-		.device         = PCIE_DEVICE_ID_WCH_CH382_2S,
+		.vendor         = PCI_VENDOR_ID_WCHIC,
+		.device         = PCI_DEVICE_ID_WCHIC_CH382_2S,
 		.subvendor      = PCI_ANY_ID,
 		.subdevice      = PCI_ANY_ID,
 		.setup          = pci_wch_ch38x_setup,
 	},
 	/* WCH CH382 2S1P card (16850 clone) */
 	{
-		.vendor         = PCIE_VENDOR_ID_WCH,
-		.device         = PCIE_DEVICE_ID_WCH_CH382_2S1P,
+		.vendor         = PCI_VENDOR_ID_WCHIC,
+		.device         = PCI_DEVICE_ID_WCHIC_CH382_2S1P,
 		.subvendor      = PCI_ANY_ID,
 		.subdevice      = PCI_ANY_ID,
 		.setup          = pci_wch_ch38x_setup,
 	},
 	/* WCH CH384 4S card (16850 clone) */
 	{
-		.vendor         = PCIE_VENDOR_ID_WCH,
-		.device         = PCIE_DEVICE_ID_WCH_CH384_4S,
+		.vendor         = PCI_VENDOR_ID_WCHIC,
+		.device         = PCI_DEVICE_ID_WCHIC_CH384_4S,
 		.subvendor      = PCI_ANY_ID,
 		.subdevice      = PCI_ANY_ID,
 		.setup          = pci_wch_ch38x_setup,
 	},
 	/* WCH CH384 8S card (16850 clone) */
 	{
-		.vendor         = PCIE_VENDOR_ID_WCH,
-		.device         = PCIE_DEVICE_ID_WCH_CH384_8S,
+		.vendor         = PCI_VENDOR_ID_WCHIC,
+		.device         = PCI_DEVICE_ID_WCHIC_CH384_8S,
 		.subvendor      = PCI_ANY_ID,
 		.subdevice      = PCI_ANY_ID,
 		.init           = pci_wch_ch38x_init,
@@ -3927,11 +3927,11 @@ static const struct pci_device_id blacklist[] = {
 
 	/* multi-io cards handled by parport_serial */
 	/* WCH CH353 2S1P */
-	{ PCI_DEVICE(0x4348, 0x7053), 0, 0, REPORT_CONFIG(PARPORT_SERIAL), },
+	{ PCI_VDEVICE(WCHCN, 0x7053), REPORT_CONFIG(PARPORT_SERIAL), },
 	/* WCH CH353 1S1P */
-	{ PCI_DEVICE(0x4348, 0x5053), 0, 0, REPORT_CONFIG(PARPORT_SERIAL), },
+	{ PCI_VDEVICE(WCHCN, 0x5053), REPORT_CONFIG(PARPORT_SERIAL), },
 	/* WCH CH382 2S1P */
-	{ PCI_DEVICE(0x1c00, 0x3250), 0, 0, REPORT_CONFIG(PARPORT_SERIAL), },
+	{ PCI_VDEVICE(WCHIC, 0x3250), REPORT_CONFIG(PARPORT_SERIAL), },
 
 	/* Intel platforms with MID UART */
 	{ PCI_VDEVICE(INTEL, 0x081b), REPORT_8250_CONFIG(MID), },
@@ -6004,27 +6004,27 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	 * WCH CH353 series devices: The 2S1P is handled by parport_serial
 	 * so not listed here.
 	 */
-	{	PCI_VENDOR_ID_WCH, PCI_DEVICE_ID_WCH_CH353_4S,
+	{	PCI_VENDOR_ID_WCHCN, PCI_DEVICE_ID_WCHCN_CH353_4S,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0, pbn_b0_bt_4_115200 },
 
-	{	PCI_VENDOR_ID_WCH, PCI_DEVICE_ID_WCH_CH353_2S1PF,
+	{	PCI_VENDOR_ID_WCHCN, PCI_DEVICE_ID_WCHCN_CH353_2S1PF,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0, pbn_b0_bt_2_115200 },
 
-	{	PCI_VENDOR_ID_WCH, PCI_DEVICE_ID_WCH_CH355_4S,
+	{	PCI_VENDOR_ID_WCHCN, PCI_DEVICE_ID_WCHCN_CH355_4S,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0, pbn_b0_bt_4_115200 },
 
-	{	PCIE_VENDOR_ID_WCH, PCIE_DEVICE_ID_WCH_CH382_2S,
+	{	PCI_VENDOR_ID_WCHIC, PCI_DEVICE_ID_WCHIC_CH382_2S,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0, pbn_wch382_2 },
 
-	{	PCIE_VENDOR_ID_WCH, PCIE_DEVICE_ID_WCH_CH384_4S,
+	{	PCI_VENDOR_ID_WCHIC, PCI_DEVICE_ID_WCHIC_CH384_4S,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0, pbn_wch384_4 },
 
-	{	PCIE_VENDOR_ID_WCH, PCIE_DEVICE_ID_WCH_CH384_8S,
+	{	PCI_VENDOR_ID_WCHIC, PCI_DEVICE_ID_WCHIC_CH384_8S,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0, pbn_wch384_8 },
 	/*
-- 
2.39.5


