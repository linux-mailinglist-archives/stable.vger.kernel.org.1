Return-Path: <stable+bounces-55784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B59916DC9
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 18:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB431C23172
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 16:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6167171E7D;
	Tue, 25 Jun 2024 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pZ/R2Q18"
X-Original-To: stable@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68F816FF33;
	Tue, 25 Jun 2024 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719331685; cv=none; b=V7X/TBScixR71XUfHixejmwUoJsK9ciebpGnsvPd9DIozhHhtBdTXI7oXX3vv07YD4tth9w/pLq49STXuG3jRm4aO7orgeQczzlM0C7u0DBaiDJAj5mvQOnhFyjffZsG+2Djokm7HXZoP9nrjJpjHDyoynOZSiBeEy01iMSOxvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719331685; c=relaxed/simple;
	bh=YFQd4AGBmj/dBhWp9vE7IpteCEtWvtn5T0veylKLQsQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jcyxPKk4zWKRic5IKNTZTAz+/2Ktx2+eycwWEdk7vhlxTeJibSJgr8FB3VPQbMvImUmlXLdKu+7ToOj4ZZaSGkbTSLSWJRkyqD39ahoaJGhCUfTq+rviPH0JvLgWxf8oS4CoJzTpgL4wG0wxso1omANPnkC+dmlwIpg3g+ma2PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pZ/R2Q18; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45PG7h84089051;
	Tue, 25 Jun 2024 11:07:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719331663;
	bh=urAGycXTBoHdLtPtjfxHTcGyuwKBYenkT3TbkTOFkAk=;
	h=From:To:CC:Subject:Date;
	b=pZ/R2Q18HcSnlwK24ZMqS5X8GOW/1K66pkaCb90lP/QSzT+xUYvy24N6/blAUrZxw
	 mYcxtdMAB73BIgdtA5ugVTDiAcw1rrdv0NbB7tRWn6GOMtl679zxZlS0sHme1/Dt8y
	 zRtP2ut+/UPZ2AL/BiQfS/v0LIcFQh2QguM6YMU4=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45PG7hx2069246
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Jun 2024 11:07:43 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jun 2024 11:07:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jun 2024 11:07:43 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45PG7dxE122229;
	Tue, 25 Jun 2024 11:07:40 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <vigneshr@ti.com>, <nm@ti.com>, <tony@atomide.com>
CC: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ronald.wahl@raritan.com>, <thomas.richard@bootlin.com>,
        <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v2] serial: 8250_omap: Fix Errata i2310 with RX FIFO level check
Date: Tue, 25 Jun 2024 21:37:25 +0530
Message-ID: <20240625160725.2102194-1-u-kumar1@ti.com>
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

Errata i2310[0] says, Erroneous timeout can be triggered,
if this Erroneous interrupt is not cleared then it may leads
to storm of interrupts.

Commit 9d141c1e6157 ("serial: 8250_omap: Implementation of Errata i2310")
which added the workaround but missed ensuring RX FIFO is really empty
before applying the errata workaround as recommended in the errata text.
Fix this by adding back check for UART_OMAP_RX_LVL to be 0 for
workaround to take effect.

[0] https://www.ti.com/lit/pdf/sprz536 page 23

Fixes: 9d141c1e6157 ("serial: 8250_omap: Implementation of Errata i2310")
Cc: stable@vger.kernel.org
Reported-by: Vignesh Raghavendra <vigneshr@ti.com>
Closes: https://lore.kernel.org/all/e96d0c55-0b12-4cbf-9d23-48963543de49@ti.com/
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Testlogs
https://gist.github.com/uditkumarti/4f5120f203a238fbebe411eb82b63753

Changelog:
Changes in v2
- Update commit message, subject, Fixes tag
link to v1:
https://lore.kernel.org/all/20240625051338.2761599-1-u-kumar1@ti.com/

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


