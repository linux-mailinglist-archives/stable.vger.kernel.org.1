Return-Path: <stable+bounces-88634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA8A9B26D1
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C9B42824D9
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42B818E354;
	Mon, 28 Oct 2024 06:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vZihIvwq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DF815B10D;
	Mon, 28 Oct 2024 06:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097777; cv=none; b=ARHZtY21j+XXFzrKs1g6AAWcZ9GXxjZlTQOReHkrAF6lyXD6/ICGTjVkBulx+wDaqognUZIYEe6E+SZE2KGyYDDdQmjo6/p6i2L7CnMFiYSqOkVbnIABGZMPvvZB9yPTe6gy9BBlgJkhGOR9yUPWCwRuW97Y3I+IdANeFQjd4yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097777; c=relaxed/simple;
	bh=bDXbRl1GNlRJ9FqrpG5IEKYxtxg2lwvTs/ijsgw497c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yv2EfaSlelKoG8PxxyaaP8wMeHGRoizwCaV9K9G1aEuOSSf+WLJto3RUkogNvZZGS5KBFbTggDwYisbmU4qxSlbg/h74dxUL9SZcsY/SFflhox2vHqYmybTEV7CF3P5YWJMe+uv0+H1Rh86TuK8B6p+DaRNmC6hTzjrQPq9D0Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vZihIvwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26B7C4CEC3;
	Mon, 28 Oct 2024 06:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097776;
	bh=bDXbRl1GNlRJ9FqrpG5IEKYxtxg2lwvTs/ijsgw497c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vZihIvwqSXR32TEzSJWqdpr9TjkNzyhFWUZwuzygMUhTa3tmjjeldlV7svMlVizPm
	 ydYhj28ISWEjSrOFYgw+q9cXc/Lu0M4s+5fk8adWZTS0wsEugEE81gX1Di54ZicIt+
	 aDslBQ1Pjgno2R4sCB9h4OodrqB+JrgqfDqMhEVA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 105/208] XHCI: Separate PORT and CAPs macros into dedicated file
Date: Mon, 28 Oct 2024 07:24:45 +0100
Message-ID: <20241028062309.244654187@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062306.649733554@linuxfoundation.org>
References: <20241028062306.649733554@linuxfoundation.org>
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

From: Frank Li <Frank.Li@nxp.com>

[ Upstream commit c35ba0ac48355df1d11fcce85945f76c42d250ac ]

Split the PORT and CAPs macro definitions into a separate file to
facilitate sharing with other files without the need to include the entire
xhci.h.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20240124152525.3910311-2-Frank.Li@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 705e3ce37bcc ("usb: dwc3: core: Fix system suspend on TI AM62 platforms")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-caps.h |  85 ++++++++++++
 drivers/usb/host/xhci-port.h | 176 +++++++++++++++++++++++
 drivers/usb/host/xhci.h      | 262 +----------------------------------
 3 files changed, 264 insertions(+), 259 deletions(-)
 create mode 100644 drivers/usb/host/xhci-caps.h
 create mode 100644 drivers/usb/host/xhci-port.h

diff --git a/drivers/usb/host/xhci-caps.h b/drivers/usb/host/xhci-caps.h
new file mode 100644
index 0000000000000..9e94cebf4a56d
--- /dev/null
+++ b/drivers/usb/host/xhci-caps.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* hc_capbase bitmasks */
+/* bits 7:0 - how long is the Capabilities register */
+#define HC_LENGTH(p)		XHCI_HC_LENGTH(p)
+/* bits 31:16	*/
+#define HC_VERSION(p)		(((p) >> 16) & 0xffff)
+
+/* HCSPARAMS1 - hcs_params1 - bitmasks */
+/* bits 0:7, Max Device Slots */
+#define HCS_MAX_SLOTS(p)	(((p) >> 0) & 0xff)
+#define HCS_SLOTS_MASK		0xff
+/* bits 8:18, Max Interrupters */
+#define HCS_MAX_INTRS(p)	(((p) >> 8) & 0x7ff)
+/* bits 24:31, Max Ports - max value is 0x7F = 127 ports */
+#define HCS_MAX_PORTS(p)	(((p) >> 24) & 0x7f)
+
+/* HCSPARAMS2 - hcs_params2 - bitmasks */
+/* bits 0:3, frames or uframes that SW needs to queue transactions
+ * ahead of the HW to meet periodic deadlines */
+#define HCS_IST(p)		(((p) >> 0) & 0xf)
+/* bits 4:7, max number of Event Ring segments */
+#define HCS_ERST_MAX(p)		(((p) >> 4) & 0xf)
+/* bits 21:25 Hi 5 bits of Scratchpad buffers SW must allocate for the HW */
+/* bit 26 Scratchpad restore - for save/restore HW state - not used yet */
+/* bits 27:31 Lo 5 bits of Scratchpad buffers SW must allocate for the HW */
+#define HCS_MAX_SCRATCHPAD(p)   ((((p) >> 16) & 0x3e0) | (((p) >> 27) & 0x1f))
+
+/* HCSPARAMS3 - hcs_params3 - bitmasks */
+/* bits 0:7, Max U1 to U0 latency for the roothub ports */
+#define HCS_U1_LATENCY(p)	(((p) >> 0) & 0xff)
+/* bits 16:31, Max U2 to U0 latency for the roothub ports */
+#define HCS_U2_LATENCY(p)	(((p) >> 16) & 0xffff)
+
+/* HCCPARAMS - hcc_params - bitmasks */
+/* true: HC can use 64-bit address pointers */
+#define HCC_64BIT_ADDR(p)	((p) & (1 << 0))
+/* true: HC can do bandwidth negotiation */
+#define HCC_BANDWIDTH_NEG(p)	((p) & (1 << 1))
+/* true: HC uses 64-byte Device Context structures
+ * FIXME 64-byte context structures aren't supported yet.
+ */
+#define HCC_64BYTE_CONTEXT(p)	((p) & (1 << 2))
+/* true: HC has port power switches */
+#define HCC_PPC(p)		((p) & (1 << 3))
+/* true: HC has port indicators */
+#define HCS_INDICATOR(p)	((p) & (1 << 4))
+/* true: HC has Light HC Reset Capability */
+#define HCC_LIGHT_RESET(p)	((p) & (1 << 5))
+/* true: HC supports latency tolerance messaging */
+#define HCC_LTC(p)		((p) & (1 << 6))
+/* true: no secondary Stream ID Support */
+#define HCC_NSS(p)		((p) & (1 << 7))
+/* true: HC supports Stopped - Short Packet */
+#define HCC_SPC(p)		((p) & (1 << 9))
+/* true: HC has Contiguous Frame ID Capability */
+#define HCC_CFC(p)		((p) & (1 << 11))
+/* Max size for Primary Stream Arrays - 2^(n+1), where n is bits 12:15 */
+#define HCC_MAX_PSA(p)		(1 << ((((p) >> 12) & 0xf) + 1))
+/* Extended Capabilities pointer from PCI base - section 5.3.6 */
+#define HCC_EXT_CAPS(p)		XHCI_HCC_EXT_CAPS(p)
+
+#define CTX_SIZE(_hcc)		(HCC_64BYTE_CONTEXT(_hcc) ? 64 : 32)
+
+/* db_off bitmask - bits 0:1 reserved */
+#define	DBOFF_MASK	(~0x3)
+
+/* run_regs_off bitmask - bits 0:4 reserved */
+#define	RTSOFF_MASK	(~0x1f)
+
+/* HCCPARAMS2 - hcc_params2 - bitmasks */
+/* true: HC supports U3 entry Capability */
+#define	HCC2_U3C(p)		((p) & (1 << 0))
+/* true: HC supports Configure endpoint command Max exit latency too large */
+#define	HCC2_CMC(p)		((p) & (1 << 1))
+/* true: HC supports Force Save context Capability */
+#define	HCC2_FSC(p)		((p) & (1 << 2))
+/* true: HC supports Compliance Transition Capability */
+#define	HCC2_CTC(p)		((p) & (1 << 3))
+/* true: HC support Large ESIT payload Capability > 48k */
+#define	HCC2_LEC(p)		((p) & (1 << 4))
+/* true: HC support Configuration Information Capability */
+#define	HCC2_CIC(p)		((p) & (1 << 5))
+/* true: HC support Extended TBC Capability, Isoc burst count > 65535 */
+#define	HCC2_ETC(p)		((p) & (1 << 6))
diff --git a/drivers/usb/host/xhci-port.h b/drivers/usb/host/xhci-port.h
new file mode 100644
index 0000000000000..f19efb966d180
--- /dev/null
+++ b/drivers/usb/host/xhci-port.h
@@ -0,0 +1,176 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* PORTSC - Port Status and Control Register - port_status_base bitmasks */
+/* true: device connected */
+#define PORT_CONNECT	(1 << 0)
+/* true: port enabled */
+#define PORT_PE		(1 << 1)
+/* bit 2 reserved and zeroed */
+/* true: port has an over-current condition */
+#define PORT_OC		(1 << 3)
+/* true: port reset signaling asserted */
+#define PORT_RESET	(1 << 4)
+/* Port Link State - bits 5:8
+ * A read gives the current link PM state of the port,
+ * a write with Link State Write Strobe set sets the link state.
+ */
+#define PORT_PLS_MASK	(0xf << 5)
+#define XDEV_U0		(0x0 << 5)
+#define XDEV_U1		(0x1 << 5)
+#define XDEV_U2		(0x2 << 5)
+#define XDEV_U3		(0x3 << 5)
+#define XDEV_DISABLED	(0x4 << 5)
+#define XDEV_RXDETECT	(0x5 << 5)
+#define XDEV_INACTIVE	(0x6 << 5)
+#define XDEV_POLLING	(0x7 << 5)
+#define XDEV_RECOVERY	(0x8 << 5)
+#define XDEV_HOT_RESET	(0x9 << 5)
+#define XDEV_COMP_MODE	(0xa << 5)
+#define XDEV_TEST_MODE	(0xb << 5)
+#define XDEV_RESUME	(0xf << 5)
+
+/* true: port has power (see HCC_PPC) */
+#define PORT_POWER	(1 << 9)
+/* bits 10:13 indicate device speed:
+ * 0 - undefined speed - port hasn't be initialized by a reset yet
+ * 1 - full speed
+ * 2 - low speed
+ * 3 - high speed
+ * 4 - super speed
+ * 5-15 reserved
+ */
+#define DEV_SPEED_MASK		(0xf << 10)
+#define	XDEV_FS			(0x1 << 10)
+#define	XDEV_LS			(0x2 << 10)
+#define	XDEV_HS			(0x3 << 10)
+#define	XDEV_SS			(0x4 << 10)
+#define	XDEV_SSP		(0x5 << 10)
+#define DEV_UNDEFSPEED(p)	(((p) & DEV_SPEED_MASK) == (0x0<<10))
+#define DEV_FULLSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_FS)
+#define DEV_LOWSPEED(p)		(((p) & DEV_SPEED_MASK) == XDEV_LS)
+#define DEV_HIGHSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_HS)
+#define DEV_SUPERSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_SS)
+#define DEV_SUPERSPEEDPLUS(p)	(((p) & DEV_SPEED_MASK) == XDEV_SSP)
+#define DEV_SUPERSPEED_ANY(p)	(((p) & DEV_SPEED_MASK) >= XDEV_SS)
+#define DEV_PORT_SPEED(p)	(((p) >> 10) & 0x0f)
+
+/* Bits 20:23 in the Slot Context are the speed for the device */
+#define	SLOT_SPEED_FS		(XDEV_FS << 10)
+#define	SLOT_SPEED_LS		(XDEV_LS << 10)
+#define	SLOT_SPEED_HS		(XDEV_HS << 10)
+#define	SLOT_SPEED_SS		(XDEV_SS << 10)
+#define	SLOT_SPEED_SSP		(XDEV_SSP << 10)
+/* Port Indicator Control */
+#define PORT_LED_OFF	(0 << 14)
+#define PORT_LED_AMBER	(1 << 14)
+#define PORT_LED_GREEN	(2 << 14)
+#define PORT_LED_MASK	(3 << 14)
+/* Port Link State Write Strobe - set this when changing link state */
+#define PORT_LINK_STROBE	(1 << 16)
+/* true: connect status change */
+#define PORT_CSC	(1 << 17)
+/* true: port enable change */
+#define PORT_PEC	(1 << 18)
+/* true: warm reset for a USB 3.0 device is done.  A "hot" reset puts the port
+ * into an enabled state, and the device into the default state.  A "warm" reset
+ * also resets the link, forcing the device through the link training sequence.
+ * SW can also look at the Port Reset register to see when warm reset is done.
+ */
+#define PORT_WRC	(1 << 19)
+/* true: over-current change */
+#define PORT_OCC	(1 << 20)
+/* true: reset change - 1 to 0 transition of PORT_RESET */
+#define PORT_RC		(1 << 21)
+/* port link status change - set on some port link state transitions:
+ *  Transition				Reason
+ *  ------------------------------------------------------------------------------
+ *  - U3 to Resume			Wakeup signaling from a device
+ *  - Resume to Recovery to U0		USB 3.0 device resume
+ *  - Resume to U0			USB 2.0 device resume
+ *  - U3 to Recovery to U0		Software resume of USB 3.0 device complete
+ *  - U3 to U0				Software resume of USB 2.0 device complete
+ *  - U2 to U0				L1 resume of USB 2.1 device complete
+ *  - U0 to U0 (???)			L1 entry rejection by USB 2.1 device
+ *  - U0 to disabled			L1 entry error with USB 2.1 device
+ *  - Any state to inactive		Error on USB 3.0 port
+ */
+#define PORT_PLC	(1 << 22)
+/* port configure error change - port failed to configure its link partner */
+#define PORT_CEC	(1 << 23)
+#define PORT_CHANGE_MASK	(PORT_CSC | PORT_PEC | PORT_WRC | PORT_OCC | \
+				 PORT_RC | PORT_PLC | PORT_CEC)
+
+
+/* Cold Attach Status - xHC can set this bit to report device attached during
+ * Sx state. Warm port reset should be perfomed to clear this bit and move port
+ * to connected state.
+ */
+#define PORT_CAS	(1 << 24)
+/* wake on connect (enable) */
+#define PORT_WKCONN_E	(1 << 25)
+/* wake on disconnect (enable) */
+#define PORT_WKDISC_E	(1 << 26)
+/* wake on over-current (enable) */
+#define PORT_WKOC_E	(1 << 27)
+/* bits 28:29 reserved */
+/* true: device is non-removable - for USB 3.0 roothub emulation */
+#define PORT_DEV_REMOVE	(1 << 30)
+/* Initiate a warm port reset - complete when PORT_WRC is '1' */
+#define PORT_WR		(1 << 31)
+
+/* We mark duplicate entries with -1 */
+#define DUPLICATE_ENTRY ((u8)(-1))
+
+/* Port Power Management Status and Control - port_power_base bitmasks */
+/* Inactivity timer value for transitions into U1, in microseconds.
+ * Timeout can be up to 127us.  0xFF means an infinite timeout.
+ */
+#define PORT_U1_TIMEOUT(p)	((p) & 0xff)
+#define PORT_U1_TIMEOUT_MASK	0xff
+/* Inactivity timer value for transitions into U2 */
+#define PORT_U2_TIMEOUT(p)	(((p) & 0xff) << 8)
+#define PORT_U2_TIMEOUT_MASK	(0xff << 8)
+/* Bits 24:31 for port testing */
+
+/* USB2 Protocol PORTSPMSC */
+#define	PORT_L1S_MASK		7
+#define	PORT_L1S_SUCCESS	1
+#define	PORT_RWE		(1 << 3)
+#define	PORT_HIRD(p)		(((p) & 0xf) << 4)
+#define	PORT_HIRD_MASK		(0xf << 4)
+#define	PORT_L1DS_MASK		(0xff << 8)
+#define	PORT_L1DS(p)		(((p) & 0xff) << 8)
+#define	PORT_HLE		(1 << 16)
+#define PORT_TEST_MODE_SHIFT	28
+
+/* USB3 Protocol PORTLI  Port Link Information */
+#define PORT_RX_LANES(p)	(((p) >> 16) & 0xf)
+#define PORT_TX_LANES(p)	(((p) >> 20) & 0xf)
+
+/* USB2 Protocol PORTHLPMC */
+#define PORT_HIRDM(p)((p) & 3)
+#define PORT_L1_TIMEOUT(p)(((p) & 0xff) << 2)
+#define PORT_BESLD(p)(((p) & 0xf) << 10)
+
+/* use 512 microseconds as USB2 LPM L1 default timeout. */
+#define XHCI_L1_TIMEOUT		512
+
+/* Set default HIRD/BESL value to 4 (350/400us) for USB2 L1 LPM resume latency.
+ * Safe to use with mixed HIRD and BESL systems (host and device) and is used
+ * by other operating systems.
+ *
+ * XHCI 1.0 errata 8/14/12 Table 13 notes:
+ * "Software should choose xHC BESL/BESLD field values that do not violate a
+ * device's resume latency requirements,
+ * e.g. not program values > '4' if BLC = '1' and a HIRD device is attached,
+ * or not program values < '4' if BLC = '0' and a BESL device is attached.
+ */
+#define XHCI_DEFAULT_BESL	4
+
+/*
+ * USB3 specification define a 360ms tPollingLFPSTiemout for USB3 ports
+ * to complete link training. usually link trainig completes much faster
+ * so check status 10 times with 36ms sleep in places we need to wait for
+ * polling to complete.
+ */
+#define XHCI_PORT_POLLING_LFPS_TIME  36
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 7754ed55d220b..f2190d121233b 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -23,6 +23,9 @@
 #include	"xhci-ext-caps.h"
 #include "pci-quirks.h"
 
+#include "xhci-port.h"
+#include "xhci-caps.h"
+
 /* max buffer size for trace and debug messages */
 #define XHCI_MSG_MAX		500
 
@@ -63,90 +66,6 @@ struct xhci_cap_regs {
 	/* Reserved up to (CAPLENGTH - 0x1C) */
 };
 
-/* hc_capbase bitmasks */
-/* bits 7:0 - how long is the Capabilities register */
-#define HC_LENGTH(p)		XHCI_HC_LENGTH(p)
-/* bits 31:16	*/
-#define HC_VERSION(p)		(((p) >> 16) & 0xffff)
-
-/* HCSPARAMS1 - hcs_params1 - bitmasks */
-/* bits 0:7, Max Device Slots */
-#define HCS_MAX_SLOTS(p)	(((p) >> 0) & 0xff)
-#define HCS_SLOTS_MASK		0xff
-/* bits 8:18, Max Interrupters */
-#define HCS_MAX_INTRS(p)	(((p) >> 8) & 0x7ff)
-/* bits 24:31, Max Ports - max value is 0x7F = 127 ports */
-#define HCS_MAX_PORTS(p)	(((p) >> 24) & 0x7f)
-
-/* HCSPARAMS2 - hcs_params2 - bitmasks */
-/* bits 0:3, frames or uframes that SW needs to queue transactions
- * ahead of the HW to meet periodic deadlines */
-#define HCS_IST(p)		(((p) >> 0) & 0xf)
-/* bits 4:7, max number of Event Ring segments */
-#define HCS_ERST_MAX(p)		(((p) >> 4) & 0xf)
-/* bits 21:25 Hi 5 bits of Scratchpad buffers SW must allocate for the HW */
-/* bit 26 Scratchpad restore - for save/restore HW state - not used yet */
-/* bits 27:31 Lo 5 bits of Scratchpad buffers SW must allocate for the HW */
-#define HCS_MAX_SCRATCHPAD(p)   ((((p) >> 16) & 0x3e0) | (((p) >> 27) & 0x1f))
-
-/* HCSPARAMS3 - hcs_params3 - bitmasks */
-/* bits 0:7, Max U1 to U0 latency for the roothub ports */
-#define HCS_U1_LATENCY(p)	(((p) >> 0) & 0xff)
-/* bits 16:31, Max U2 to U0 latency for the roothub ports */
-#define HCS_U2_LATENCY(p)	(((p) >> 16) & 0xffff)
-
-/* HCCPARAMS - hcc_params - bitmasks */
-/* true: HC can use 64-bit address pointers */
-#define HCC_64BIT_ADDR(p)	((p) & (1 << 0))
-/* true: HC can do bandwidth negotiation */
-#define HCC_BANDWIDTH_NEG(p)	((p) & (1 << 1))
-/* true: HC uses 64-byte Device Context structures
- * FIXME 64-byte context structures aren't supported yet.
- */
-#define HCC_64BYTE_CONTEXT(p)	((p) & (1 << 2))
-/* true: HC has port power switches */
-#define HCC_PPC(p)		((p) & (1 << 3))
-/* true: HC has port indicators */
-#define HCS_INDICATOR(p)	((p) & (1 << 4))
-/* true: HC has Light HC Reset Capability */
-#define HCC_LIGHT_RESET(p)	((p) & (1 << 5))
-/* true: HC supports latency tolerance messaging */
-#define HCC_LTC(p)		((p) & (1 << 6))
-/* true: no secondary Stream ID Support */
-#define HCC_NSS(p)		((p) & (1 << 7))
-/* true: HC supports Stopped - Short Packet */
-#define HCC_SPC(p)		((p) & (1 << 9))
-/* true: HC has Contiguous Frame ID Capability */
-#define HCC_CFC(p)		((p) & (1 << 11))
-/* Max size for Primary Stream Arrays - 2^(n+1), where n is bits 12:15 */
-#define HCC_MAX_PSA(p)		(1 << ((((p) >> 12) & 0xf) + 1))
-/* Extended Capabilities pointer from PCI base - section 5.3.6 */
-#define HCC_EXT_CAPS(p)		XHCI_HCC_EXT_CAPS(p)
-
-#define CTX_SIZE(_hcc)		(HCC_64BYTE_CONTEXT(_hcc) ? 64 : 32)
-
-/* db_off bitmask - bits 0:1 reserved */
-#define	DBOFF_MASK	(~0x3)
-
-/* run_regs_off bitmask - bits 0:4 reserved */
-#define	RTSOFF_MASK	(~0x1f)
-
-/* HCCPARAMS2 - hcc_params2 - bitmasks */
-/* true: HC supports U3 entry Capability */
-#define	HCC2_U3C(p)		((p) & (1 << 0))
-/* true: HC supports Configure endpoint command Max exit latency too large */
-#define	HCC2_CMC(p)		((p) & (1 << 1))
-/* true: HC supports Force Save context Capability */
-#define	HCC2_FSC(p)		((p) & (1 << 2))
-/* true: HC supports Compliance Transition Capability */
-#define	HCC2_CTC(p)		((p) & (1 << 3))
-/* true: HC support Large ESIT payload Capability > 48k */
-#define	HCC2_LEC(p)		((p) & (1 << 4))
-/* true: HC support Configuration Information Capability */
-#define	HCC2_CIC(p)		((p) & (1 << 5))
-/* true: HC support Extended TBC Capability, Isoc burst count > 65535 */
-#define	HCC2_ETC(p)		((p) & (1 << 6))
-
 /* Number of registers per port */
 #define	NUM_PORT_REGS	4
 
@@ -292,181 +211,6 @@ struct xhci_op_regs {
 #define CONFIG_CIE		(1 << 9)
 /* bits 10:31 - reserved and should be preserved */
 
-/* PORTSC - Port Status and Control Register - port_status_base bitmasks */
-/* true: device connected */
-#define PORT_CONNECT	(1 << 0)
-/* true: port enabled */
-#define PORT_PE		(1 << 1)
-/* bit 2 reserved and zeroed */
-/* true: port has an over-current condition */
-#define PORT_OC		(1 << 3)
-/* true: port reset signaling asserted */
-#define PORT_RESET	(1 << 4)
-/* Port Link State - bits 5:8
- * A read gives the current link PM state of the port,
- * a write with Link State Write Strobe set sets the link state.
- */
-#define PORT_PLS_MASK	(0xf << 5)
-#define XDEV_U0		(0x0 << 5)
-#define XDEV_U1		(0x1 << 5)
-#define XDEV_U2		(0x2 << 5)
-#define XDEV_U3		(0x3 << 5)
-#define XDEV_DISABLED	(0x4 << 5)
-#define XDEV_RXDETECT	(0x5 << 5)
-#define XDEV_INACTIVE	(0x6 << 5)
-#define XDEV_POLLING	(0x7 << 5)
-#define XDEV_RECOVERY	(0x8 << 5)
-#define XDEV_HOT_RESET	(0x9 << 5)
-#define XDEV_COMP_MODE	(0xa << 5)
-#define XDEV_TEST_MODE	(0xb << 5)
-#define XDEV_RESUME	(0xf << 5)
-
-/* true: port has power (see HCC_PPC) */
-#define PORT_POWER	(1 << 9)
-/* bits 10:13 indicate device speed:
- * 0 - undefined speed - port hasn't be initialized by a reset yet
- * 1 - full speed
- * 2 - low speed
- * 3 - high speed
- * 4 - super speed
- * 5-15 reserved
- */
-#define DEV_SPEED_MASK		(0xf << 10)
-#define	XDEV_FS			(0x1 << 10)
-#define	XDEV_LS			(0x2 << 10)
-#define	XDEV_HS			(0x3 << 10)
-#define	XDEV_SS			(0x4 << 10)
-#define	XDEV_SSP		(0x5 << 10)
-#define DEV_UNDEFSPEED(p)	(((p) & DEV_SPEED_MASK) == (0x0<<10))
-#define DEV_FULLSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_FS)
-#define DEV_LOWSPEED(p)		(((p) & DEV_SPEED_MASK) == XDEV_LS)
-#define DEV_HIGHSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_HS)
-#define DEV_SUPERSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_SS)
-#define DEV_SUPERSPEEDPLUS(p)	(((p) & DEV_SPEED_MASK) == XDEV_SSP)
-#define DEV_SUPERSPEED_ANY(p)	(((p) & DEV_SPEED_MASK) >= XDEV_SS)
-#define DEV_PORT_SPEED(p)	(((p) >> 10) & 0x0f)
-
-/* Bits 20:23 in the Slot Context are the speed for the device */
-#define	SLOT_SPEED_FS		(XDEV_FS << 10)
-#define	SLOT_SPEED_LS		(XDEV_LS << 10)
-#define	SLOT_SPEED_HS		(XDEV_HS << 10)
-#define	SLOT_SPEED_SS		(XDEV_SS << 10)
-#define	SLOT_SPEED_SSP		(XDEV_SSP << 10)
-/* Port Indicator Control */
-#define PORT_LED_OFF	(0 << 14)
-#define PORT_LED_AMBER	(1 << 14)
-#define PORT_LED_GREEN	(2 << 14)
-#define PORT_LED_MASK	(3 << 14)
-/* Port Link State Write Strobe - set this when changing link state */
-#define PORT_LINK_STROBE	(1 << 16)
-/* true: connect status change */
-#define PORT_CSC	(1 << 17)
-/* true: port enable change */
-#define PORT_PEC	(1 << 18)
-/* true: warm reset for a USB 3.0 device is done.  A "hot" reset puts the port
- * into an enabled state, and the device into the default state.  A "warm" reset
- * also resets the link, forcing the device through the link training sequence.
- * SW can also look at the Port Reset register to see when warm reset is done.
- */
-#define PORT_WRC	(1 << 19)
-/* true: over-current change */
-#define PORT_OCC	(1 << 20)
-/* true: reset change - 1 to 0 transition of PORT_RESET */
-#define PORT_RC		(1 << 21)
-/* port link status change - set on some port link state transitions:
- *  Transition				Reason
- *  ------------------------------------------------------------------------------
- *  - U3 to Resume			Wakeup signaling from a device
- *  - Resume to Recovery to U0		USB 3.0 device resume
- *  - Resume to U0			USB 2.0 device resume
- *  - U3 to Recovery to U0		Software resume of USB 3.0 device complete
- *  - U3 to U0				Software resume of USB 2.0 device complete
- *  - U2 to U0				L1 resume of USB 2.1 device complete
- *  - U0 to U0 (???)			L1 entry rejection by USB 2.1 device
- *  - U0 to disabled			L1 entry error with USB 2.1 device
- *  - Any state to inactive		Error on USB 3.0 port
- */
-#define PORT_PLC	(1 << 22)
-/* port configure error change - port failed to configure its link partner */
-#define PORT_CEC	(1 << 23)
-#define PORT_CHANGE_MASK	(PORT_CSC | PORT_PEC | PORT_WRC | PORT_OCC | \
-				 PORT_RC | PORT_PLC | PORT_CEC)
-
-
-/* Cold Attach Status - xHC can set this bit to report device attached during
- * Sx state. Warm port reset should be perfomed to clear this bit and move port
- * to connected state.
- */
-#define PORT_CAS	(1 << 24)
-/* wake on connect (enable) */
-#define PORT_WKCONN_E	(1 << 25)
-/* wake on disconnect (enable) */
-#define PORT_WKDISC_E	(1 << 26)
-/* wake on over-current (enable) */
-#define PORT_WKOC_E	(1 << 27)
-/* bits 28:29 reserved */
-/* true: device is non-removable - for USB 3.0 roothub emulation */
-#define PORT_DEV_REMOVE	(1 << 30)
-/* Initiate a warm port reset - complete when PORT_WRC is '1' */
-#define PORT_WR		(1 << 31)
-
-/* We mark duplicate entries with -1 */
-#define DUPLICATE_ENTRY ((u8)(-1))
-
-/* Port Power Management Status and Control - port_power_base bitmasks */
-/* Inactivity timer value for transitions into U1, in microseconds.
- * Timeout can be up to 127us.  0xFF means an infinite timeout.
- */
-#define PORT_U1_TIMEOUT(p)	((p) & 0xff)
-#define PORT_U1_TIMEOUT_MASK	0xff
-/* Inactivity timer value for transitions into U2 */
-#define PORT_U2_TIMEOUT(p)	(((p) & 0xff) << 8)
-#define PORT_U2_TIMEOUT_MASK	(0xff << 8)
-/* Bits 24:31 for port testing */
-
-/* USB2 Protocol PORTSPMSC */
-#define	PORT_L1S_MASK		7
-#define	PORT_L1S_SUCCESS	1
-#define	PORT_RWE		(1 << 3)
-#define	PORT_HIRD(p)		(((p) & 0xf) << 4)
-#define	PORT_HIRD_MASK		(0xf << 4)
-#define	PORT_L1DS_MASK		(0xff << 8)
-#define	PORT_L1DS(p)		(((p) & 0xff) << 8)
-#define	PORT_HLE		(1 << 16)
-#define PORT_TEST_MODE_SHIFT	28
-
-/* USB3 Protocol PORTLI  Port Link Information */
-#define PORT_RX_LANES(p)	(((p) >> 16) & 0xf)
-#define PORT_TX_LANES(p)	(((p) >> 20) & 0xf)
-
-/* USB2 Protocol PORTHLPMC */
-#define PORT_HIRDM(p)((p) & 3)
-#define PORT_L1_TIMEOUT(p)(((p) & 0xff) << 2)
-#define PORT_BESLD(p)(((p) & 0xf) << 10)
-
-/* use 512 microseconds as USB2 LPM L1 default timeout. */
-#define XHCI_L1_TIMEOUT		512
-
-/* Set default HIRD/BESL value to 4 (350/400us) for USB2 L1 LPM resume latency.
- * Safe to use with mixed HIRD and BESL systems (host and device) and is used
- * by other operating systems.
- *
- * XHCI 1.0 errata 8/14/12 Table 13 notes:
- * "Software should choose xHC BESL/BESLD field values that do not violate a
- * device's resume latency requirements,
- * e.g. not program values > '4' if BLC = '1' and a HIRD device is attached,
- * or not program values < '4' if BLC = '0' and a BESL device is attached.
- */
-#define XHCI_DEFAULT_BESL	4
-
-/*
- * USB3 specification define a 360ms tPollingLFPSTiemout for USB3 ports
- * to complete link training. usually link trainig completes much faster
- * so check status 10 times with 36ms sleep in places we need to wait for
- * polling to complete.
- */
-#define XHCI_PORT_POLLING_LFPS_TIME  36
-
 /**
  * struct xhci_intr_reg - Interrupt Register Set
  * @irq_pending:	IMAN - Interrupt Management Register.  Used to enable
-- 
2.43.0




