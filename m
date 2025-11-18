Return-Path: <stable+bounces-195116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 505F9C6A95C
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 17:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC1853A177B
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 16:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ABE393DFC;
	Tue, 18 Nov 2025 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EaSM13NS"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83636393DDB
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482419; cv=none; b=i0W4jxnjlKLVmSZlUnDZN8znz0WDyYONrhZDRsCK/tdI7GpZz810cAMdrhwuQ4d3vbF6TviH6eDus6n7VlQxbT4G0ku+WI4Hqw6775yDlqU8Q/vJ6B/6/kxG/Uj5eCEDHulEzqCxDhfTcY7S0/Q/2/GN1XazCkPhE9Mr1jzQ0FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482419; c=relaxed/simple;
	bh=JKG7ORh0GrfzPZKhd8BwrONka+21F0NTRO36+Y19Bl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aGS39jP1VuuKG63pUSIulvDIIrEiO4AJJrWNc+hfETz6eFsJ/cpH6KscTYcVdutGjre6rVL4SB0QfZuDTfOyrOahNIEbQrHs35K43KWw15QqMRQgkOl08uOju4yzzsX4GKmABalpG7iI2xQOsXYGHsgzMe7yLLcCN/scn0mPc8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EaSM13NS; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C1F9B4E41763;
	Tue, 18 Nov 2025 16:13:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 978C9606FE;
	Tue, 18 Nov 2025 16:13:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1022A10371967;
	Tue, 18 Nov 2025 17:13:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763482414; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DsPkhyYnMypR+gij9b9x1NWJrYAuKKcCEr8gfS22WWg=;
	b=EaSM13NSxzUSiw6oiO5BPK2xwe1DIumrnsWGakYdew/ovPOPu1R2oymUUHs4nKGmu4juCt
	BH8z2LdB8DJihf2rFU28N6memRw1fayopNYUiFCcvnP+vVUJYfEb1Om2/vUFj+Q3Gae2eB
	bAUwlVshqTJVXhXat+M09h76BbmXeTgE1KBUegaxI/YPp/ToStlIO3bXmwUlI3r03/szYD
	e2CNhrxv2aFZShXgZbeWpU4PaFQJM0w442VwaLP4zDyU41qyI6Q0CPWQ16HN9RNVtSbf/b
	OkX6TnPbMDdt2CBqQlp2/omGytu+QhifScX3pR2b+IHwrcbKEHW477Ya8cgZmA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Tue, 18 Nov 2025 17:13:25 +0100
Subject: [PATCH net v5 4/5] net: dsa: microchip: Free previously
 initialized ports on init failures
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-ksz-fix-v5-4-8e9c7f56618d@bootlin.com>
References: <20251118-ksz-fix-v5-0-8e9c7f56618d@bootlin.com>
In-Reply-To: <20251118-ksz-fix-v5-0-8e9c7f56618d@bootlin.com>
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

If a port interrupt setup fails after at least one port has already been
successfully initialized, the gotos miss some resource releasing:
- the already initialized PTP IRQs aren't released
- the already initialized port IRQs aren't released if the failure
occurs in ksz_pirq_setup().

Merge out_ptpirq, out_pirq and out_girq into a single label that
releases all IRQ resources for all initialized ports.
Free the port IRQ inside the initialization loop when
ksz_ptp_irq_setup() fails, since the error path only iterates over the
'fully' initialized ports.

Cc: stable@vger.kernel.org
Fixes: c9cd961c0d43 ("net: dsa: microchip: lan937x: add interrupt support for port phy link")
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 49827ac770e6fcc9e4a1a11e8814cdd90b17473e..1cb4f35edb49ba4f35ec3ae80fe1699d31540d96 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3036,12 +3036,14 @@ static int ksz_setup(struct dsa_switch *ds)
 		dsa_switch_for_each_user_port(dp, dev->ds) {
 			ret = ksz_pirq_setup(dev, dp->index);
 			if (ret)
-				goto out_girq;
+				goto port_release;
 
 			if (dev->info->ptp_capable) {
 				ret = ksz_ptp_irq_setup(ds, dp->index);
-				if (ret)
-					goto out_pirq;
+				if (ret) {
+					ksz_irq_free(&dev->ports[dp->index].pirq);
+					goto port_release;
+				}
 			}
 		}
 	}
@@ -3051,7 +3053,7 @@ static int ksz_setup(struct dsa_switch *ds)
 		if (ret) {
 			dev_err(dev->dev, "Failed to register PTP clock: %d\n",
 				ret);
-			goto out_ptpirq;
+			goto port_release;
 		}
 	}
 
@@ -3074,17 +3076,15 @@ static int ksz_setup(struct dsa_switch *ds)
 out_ptp_clock_unregister:
 	if (dev->info->ptp_capable)
 		ksz_ptp_clock_unregister(ds);
-out_ptpirq:
-	if (dev->irq > 0 && dev->info->ptp_capable)
-		dsa_switch_for_each_user_port(dp, dev->ds)
-			ksz_ptp_irq_free(ds, dp->index);
-out_pirq:
-	if (dev->irq > 0)
-		dsa_switch_for_each_user_port_continue_reverse(dp, dev->ds)
+port_release:
+	if (dev->irq > 0) {
+		dsa_switch_for_each_user_port_continue_reverse(dp, dev->ds) {
+			if (dev->info->ptp_capable)
+				ksz_ptp_irq_free(ds, dp->index);
 			ksz_irq_free(&dev->ports[dp->index].pirq);
-out_girq:
-	if (dev->irq > 0)
+		}
 		ksz_irq_free(&dev->girq);
+	}
 
 	return ret;
 }

-- 
2.51.1


