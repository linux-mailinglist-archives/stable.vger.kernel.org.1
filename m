Return-Path: <stable+bounces-55134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 946D1915E0A
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 07:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5A21F22D4B
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 05:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C47143C77;
	Tue, 25 Jun 2024 05:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m2FTDB2f"
X-Original-To: stable@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CAB143C5A;
	Tue, 25 Jun 2024 05:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719292449; cv=none; b=o3CQvikM5NHX31TgTmg8sj3T4R/L4evk4Eyn1nCj3dcyajBIvrZNobbtIVJtTZ1nAJ12ZwcENDKHMSqw1SFJXn+3rA1CFu6SbiZ0Bv4DT5mPdX73u1CcK26biDyHjyWmlLVOxhRzQt9XG5Hi1QAO2X5VKps9FcDtzMUJFtKtObo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719292449; c=relaxed/simple;
	bh=BBjidLX4wCJ4bJu2ERUDqOPmnH03v0e8Y5wWJjYUxYE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gkbAOBD3/UGD+mjcLyEw0ZHIcP+g0hN18mdfpP9r/9AMva5R6+LJk9kUuRmRaBfr9nbIyEVUaOBiJ1/EY7m2JFewfCZRua4eQw9wG8vrCPqjJp+yxCmNrZxc4oHS9/4h4S7OLJvXRc145vDE9T0NByILyG/OYB8DvsT0XjDFOaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=m2FTDB2f; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45P5Dmct022509;
	Tue, 25 Jun 2024 00:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719292428;
	bh=fBU2x+vbwdBiGXkNVPBk+/aEoIBCo6MAZ+TjymLS+k4=;
	h=From:To:CC:Subject:Date;
	b=m2FTDB2fZKp8ZSJ02RWTjAa72p/vf4hefYht21EQCVgQbCyjGc8H12bx3w1oYhtLZ
	 8BoXhoHi1+mjXsDARClnfZtSyus8+Kk32QHoIZiqu7xPaIuvecQ65/YSmTiN5Q6RPj
	 dC3vPlmnExxRKtBWwjDnVDYOqh3JEYZ+VKpDDBI4=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45P5DmT0092945
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Jun 2024 00:13:48 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jun 2024 00:13:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jun 2024 00:13:48 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45P5Dig5042615;
	Tue, 25 Jun 2024 00:13:44 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <vigneshr@ti.com>, <nm@ti.com>, <tony@atomide.com>
CC: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ronald.wahl@raritan.com>, <thomas.richard@bootlin.com>,
        <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <ilpo.jarvinen@linux.intel.com>,
        Udit Kumar
	<u-kumar1@ti.com>, <stable@vger.kernel.org>
Subject: [PATCH] serial: 8250_omap: Implementation of Errata i2310 adding fifo level check
Date: Tue, 25 Jun 2024 10:43:38 +0530
Message-ID: <20240625051338.2761599-1-u-kumar1@ti.com>
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
to storm of interrupts.

This patch adding fifo empty check before applying errata.

[0] https://www.ti.com/lit/pdf/sprz536 page 23

Fixes: b67e830d38fa ("serial: 8250: 8250_omap: Fix possible interrupt storm on K3 SoCs")
Cc: stable@vger.kernel.org
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
This is check is added on top of errata implementation v3 patch 
https://lore.kernel.org/all/20240619105903.165434-1-u-kumar1@ti.com/


 drivers/tty/serial/8250/8250_omap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index ddac0a13cf84..1af9aed99c65 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -672,7 +672,8 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
 	 * https://www.ti.com/lit/pdf/sprz536
 	 */
 	if (priv->habit & UART_RX_TIMEOUT_QUIRK &&
-		(iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT) {
+	    (iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT &&
+	    serial_port_in(port, UART_OMAP_RX_LVL) == 0) {
 		unsigned char efr2, timeout_h, timeout_l;
 
 		efr2 = serial_in(up, UART_OMAP_EFR2);
-- 
2.34.1


