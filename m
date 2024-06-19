Return-Path: <stable+bounces-53823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7518D90E8DE
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 12:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B8C1F217AC
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3D3135A58;
	Wed, 19 Jun 2024 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s8pUEesR"
X-Original-To: stable@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F33513211E;
	Wed, 19 Jun 2024 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718794785; cv=none; b=gcNLPbmtsTpnI+w0nCuYj2cCpDpbqRdo5qCZ0BNDnCVMsoOyInGGBxv8gKam6cg2zO5I08n0FJaS4Gi+CvpKkBse3Sx6bDyRF0NSA52Pyt3HD3C6XF5pRgSngq3LN1ZheskxTVpRH4gzlvKWiSpKLAFQ0XwnibWJtG4clsSJnSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718794785; c=relaxed/simple;
	bh=/vfOnndZfejtIjb7e80KeoWWOgBV9A26jTwVuCxtQFs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JnPzNE0X0/PKBZxCii4g+91EbjuDF41RmJlvS9AbTRyG/MXX/EOQuEjvClWLBBTTblJsx94dGQ9iHItAe0B/jOrBt4vudEvyPc+aU3Vb4MF01tLNRsyQtgGoyLP43M0Dclly6o9XmJGJFpQa9TkI3P8ixrvQmYEJda8oSj53ei8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=s8pUEesR; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45JAxHZD037469;
	Wed, 19 Jun 2024 05:59:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718794757;
	bh=0TIJJzknXePVmSmptrCrvtKE4z/WNxe6G74dTzh8fxM=;
	h=From:To:CC:Subject:Date;
	b=s8pUEesRILN4TNWVxQo2In/WhLuS3RTB/P2vHK/jIRPj6U9Ioc2F9R+9ftWkwpd5L
	 0w3+BqGpivN9TDZP9xCF/qgdurzpMQ9AImLCFTZqqUWlaaY12XYbkblvL/3jY7zWX/
	 dsl/cQEbRl95sYzVUxGFRjy8a+Nyzx7s6EqnGgYE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45JAxHWh106223
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Jun 2024 05:59:17 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Jun 2024 05:59:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Jun 2024 05:59:17 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45JAxDSJ070686;
	Wed, 19 Jun 2024 05:59:13 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <vigneshr@ti.com>, <nm@ti.com>, <tony@atomide.com>
CC: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ronald.wahl@raritan.com>, <thomas.richard@bootlin.com>,
        <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <ilpo.jarvinen@linux.intel.com>,
        Udit Kumar
	<u-kumar1@ti.com>, <stable@vger.kernel.org>
Subject: [PATCH v3] serial: 8250_omap: Implementation of Errata i2310
Date: Wed, 19 Jun 2024 16:29:03 +0530
Message-ID: <20240619105903.165434-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

As per Errata i2310[0], Erroneous timeout can be triggered,
if this Erroneous interrupt is not cleared then it may leads
to storm of interrupts, therefore apply Errata i2310 solution.

[0] https://www.ti.com/lit/pdf/sprz536 page 23

Fixes: b67e830d38fa ("serial: 8250: 8250_omap: Fix possible interrupt storm on K3 SoCs")
Cc: stable@vger.kernel.org
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Change logs
Changes in v3:
- CC stable in commit message
Link to v2:
https://lore.kernel.org/all/20240617052253.2188140-1-u-kumar1@ti.com/

Changes in v2:
- Added Fixes Tag and typo correction in commit message
- Corrected bit position to UART_OMAP_EFR2_TIMEOUT_BEHAVE
Link to v1
https://lore.kernel.org/all/20240614061314.290840-1-u-kumar1@ti.com/

 drivers/tty/serial/8250/8250_omap.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 170639d12b2a..ddac0a13cf84 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -115,6 +115,10 @@
 /* RX FIFO occupancy indicator */
 #define UART_OMAP_RX_LVL		0x19
 
+/* Timeout low and High */
+#define UART_OMAP_TO_L                 0x26
+#define UART_OMAP_TO_H                 0x27
+
 /*
  * Copy of the genpd flags for the console.
  * Only used if console suspend is disabled
@@ -663,13 +667,24 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
 
 	/*
 	 * On K3 SoCs, it is observed that RX TIMEOUT is signalled after
-	 * FIFO has been drained, in which case a dummy read of RX FIFO
-	 * is required to clear RX TIMEOUT condition.
+	 * FIFO has been drained or erroneously.
+	 * So apply solution of Errata i2310 as mentioned in
+	 * https://www.ti.com/lit/pdf/sprz536
 	 */
 	if (priv->habit & UART_RX_TIMEOUT_QUIRK &&
-	    (iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT &&
-	    serial_port_in(port, UART_OMAP_RX_LVL) == 0) {
-		serial_port_in(port, UART_RX);
+		(iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT) {
+		unsigned char efr2, timeout_h, timeout_l;
+
+		efr2 = serial_in(up, UART_OMAP_EFR2);
+		timeout_h = serial_in(up, UART_OMAP_TO_H);
+		timeout_l = serial_in(up, UART_OMAP_TO_L);
+		serial_out(up, UART_OMAP_TO_H, 0xFF);
+		serial_out(up, UART_OMAP_TO_L, 0xFF);
+		serial_out(up, UART_OMAP_EFR2, UART_OMAP_EFR2_TIMEOUT_BEHAVE);
+		serial_in(up, UART_IIR);
+		serial_out(up, UART_OMAP_EFR2, efr2);
+		serial_out(up, UART_OMAP_TO_H, timeout_h);
+		serial_out(up, UART_OMAP_TO_L, timeout_l);
 	}
 
 	/* Stop processing interrupts on input overrun */
-- 
2.34.1


