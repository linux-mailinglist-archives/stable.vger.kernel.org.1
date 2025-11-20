Return-Path: <stable+bounces-195239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 236ECC730ED
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 10:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A107930263
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 09:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C32C31BC84;
	Thu, 20 Nov 2025 09:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DV3Hw/Vd"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015393191C3;
	Thu, 20 Nov 2025 09:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763629944; cv=none; b=PAkpynbN6FE/AnSpaNZ8xqlkZEP1yL+zPgeBQ01PFeBtWOcPSz91Hl/dhIcMUa2bS/MHUqrzKkNmb1SYinld6JES0NTyarQvuQA5m2QAh+lht7bwrvSGMjlSnuazIUpbs4TMwAp4UIwYRd/iQi8na3/X5xdjrbLANhSVJIpNHOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763629944; c=relaxed/simple;
	bh=Fr95gr2MS+4E19O9tKTmnf7ACBsyrmSMrq1dJf/vZk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NS6SRlk4Jke34PHLtuHzolvojUHJdWPduLbCxF+FXNNaRWRoDZg59npH3eyBIGNf+tPWNktQwoQ+RsUYVSZo4bFjxFYqV4Kvl0BPZPR3COH+49s3qqUflowPyja/OWp1KOBtexpo+zRLiM3l3aYEHI8foXYeAf3zIZOdt2dufyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DV3Hw/Vd; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 500531A1C28;
	Thu, 20 Nov 2025 09:12:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 244286068C;
	Thu, 20 Nov 2025 09:12:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CA66910371C08;
	Thu, 20 Nov 2025 10:12:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763629939; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6PmstxobF6Y4mA2z1PMwswOGcY6Z1dVMYzIEo3cJgeM=;
	b=DV3Hw/VdLCIYqVARSkaBflhiYbE1MhDD7RoQswQDkztPcjY8ml0iDrzh54PQ/n5M8Ccii1
	tkgTF5pPsZxbX/hvF8k/S8gCPtstIvfAxw9L+aRxksKvIMBR3t7jyTL6okx4rljViEMyOZ
	Xblox8LGo6MkL58eoPD0gRO3PPUc6T3lNupq0qBB6w6gCWPbxqJP9QZ3q/M5OIFgP7ORmU
	GqcpQ6bPrDpcj2qk3qyoxRXu/1bY68Xn/p45mx1HUkzOdEC434CD6zFYfyFvDzREtMB1tT
	bSxS+A3Rl86KL1X2RvAZFYqIahhmk2XTD5nPfoLe3IjC9PRjGUL7fvt3ojhPnA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 20 Nov 2025 10:12:04 +0100
Subject: [PATCH net v6 5/5] net: dsa: microchip: Fix symetry in
 ksz_ptp_msg_irq_{setup/free}()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-ksz-fix-v6-5-891f80ae7f8f@bootlin.com>
References: <20251120-ksz-fix-v6-0-891f80ae7f8f@bootlin.com>
In-Reply-To: <20251120-ksz-fix-v6-0-891f80ae7f8f@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

The IRQ numbers created through irq_create_mapping() are only assigned
to ptpmsg_irq[n].num at the end of the IRQ setup. So if an error occurs
between their creation and their assignment (for instance during the
request_threaded_irq() step), we enter the error path and fail to
release the newly created virtual IRQs because they aren't yet assigned
to ptpmsg_irq[n].num.

Move the mapping creation to ksz_ptp_msg_irq_setup() to ensure symetry
with what's released by ksz_ptp_msg_irq_free().
In the error path, move the irq_dispose_mapping to the out_ptp_msg label
so it will be called only on created IRQs.

Cc: stable@vger.kernel.org
Fixes: cc13ab18b201 ("net: dsa: microchip: ptp: enable interrupt for timestamping")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index c8bfbe5e2157323ecf29149d1907b77e689aa221..997e4a76d0a68448b0ebc76169150687bbc79673 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1093,19 +1093,19 @@ static int ksz_ptp_msg_irq_setup(struct ksz_port *port, u8 n)
 	static const char * const name[] = {"pdresp-msg", "xdreq-msg",
 					    "sync-msg"};
 	const struct ksz_dev_ops *ops = port->ksz_dev->dev_ops;
+	struct ksz_irq *ptpirq = &port->ptpirq;
 	struct ksz_ptp_irq *ptpmsg_irq;
 
 	ptpmsg_irq = &port->ptpmsg_irq[n];
+	ptpmsg_irq->num = irq_create_mapping(ptpirq->domain, n);
+	if (!ptpmsg_irq->num)
+		return -EINVAL;
 
 	ptpmsg_irq->port = port;
 	ptpmsg_irq->ts_reg = ops->get_port_addr(port->num, ts_reg[n]);
 
 	strscpy(ptpmsg_irq->name, name[n]);
 
-	ptpmsg_irq->num = irq_find_mapping(port->ptpirq.domain, n);
-	if (ptpmsg_irq->num < 0)
-		return ptpmsg_irq->num;
-
 	return request_threaded_irq(ptpmsg_irq->num, NULL,
 				    ksz_ptp_msg_thread_fn, IRQF_ONESHOT,
 				    ptpmsg_irq->name, ptpmsg_irq);
@@ -1135,9 +1135,6 @@ int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 	if (!ptpirq->domain)
 		return -ENOMEM;
 
-	for (irq = 0; irq < ptpirq->nirqs; irq++)
-		irq_create_mapping(ptpirq->domain, irq);
-
 	ptpirq->irq_num = irq_find_mapping(port->pirq.domain, PORT_SRC_PTP_INT);
 	if (!ptpirq->irq_num) {
 		ret = -EINVAL;
@@ -1159,12 +1156,11 @@ int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 
 out_ptp_msg:
 	free_irq(ptpirq->irq_num, ptpirq);
-	while (irq--)
+	while (irq--) {
 		free_irq(port->ptpmsg_irq[irq].num, &port->ptpmsg_irq[irq]);
-out:
-	for (irq = 0; irq < ptpirq->nirqs; irq++)
 		irq_dispose_mapping(port->ptpmsg_irq[irq].num);
-
+	}
+out:
 	irq_domain_remove(ptpirq->domain);
 
 	return ret;

-- 
2.51.1


