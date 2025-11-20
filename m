Return-Path: <stable+bounces-195236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6B5C730F9
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 10:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 191F030406
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 09:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E936A314D31;
	Thu, 20 Nov 2025 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DB6hxTh3"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF903126B0;
	Thu, 20 Nov 2025 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763629939; cv=none; b=MLEhhrqpcYlpdx4yaNfXKszP9LBnYPxldrjC4fBOgd0/JJAKSJNj+Kx5Esy/7IlUwVOg6hepLaN6SEsqYVvPAL4wKwtbihA+pMafNiL5k3Gx7c1Kwl+usgvCW/vEHC6BCnj0DqZ7jyf0VPTlAaSOIvn8Ux8MJcQccyr0QVapssA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763629939; c=relaxed/simple;
	bh=AEmkrFjqifoQnRxMtvLlTc3t/RLufAY+GpBg7zW6NZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hWrNRjlbAQzRlz6j4q/7HhfYTAvGdh/2GP6Zl9TocMmmaKx7kTgsESYTtx015JFSxSlG0DRvDkFF4JwlUalK1aPvV+SyIv9Cl/mbBmQm5Ox87GdMrICnAWwFBo0QKX65rfmM09+9benjgjPe3hiD38DyWicnNcLaFU+d73N2MoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DB6hxTh3; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D1BB6C111B2;
	Thu, 20 Nov 2025 09:11:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 255576068C;
	Thu, 20 Nov 2025 09:12:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D2ECA10371C0B;
	Thu, 20 Nov 2025 10:12:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763629934; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PtjJwnZbSztJ0ylhjAx5WuFm6ywuzKa2m4FJNifI2/U=;
	b=DB6hxTh3ch+YWeDlN8YahCmb1mUPG3v428civqRVeubz+jt45GH4H6C5M8vSWgUV0Jw9fH
	eUTm0D1IoOMEkOZKJpAqdE7swG2XoCsRLRmPh/3EN3ypUHi361m2JnV8r65wae7P0FbWnX
	E5B5/IiHDjBjJmiWZk3gmz9bTR+GC3NmkgvPriHra6nPzNBwph2UDTWCycPz/+TEP2cFzm
	jzh+nHILmIWly/bJhKX5p0/kudhQndzsCCWyS+weTdK+Oh3ofyUC/5MBM5Vzqk2LzjxoRR
	m4gRHx+4WJlbxR8mWSpqMRiohn6BgmhtCFeeanfVou9arsMYVT/7UBekA/mmyw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 20 Nov 2025 10:12:01 +0100
Subject: [PATCH net v6 2/5] net: dsa: microchip: ptp: Fix checks on
 irq_find_mapping()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-ksz-fix-v6-2-891f80ae7f8f@bootlin.com>
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

irq_find_mapping() returns a positive IRQ number or 0 if no IRQ is found
but it never returns a negative value. However, during the PTP IRQ setup,
we verify that its returned value isn't negative.

Fix the irq_find_mapping() check to enter the error path when 0 is
returned. Return -EINVAL in such case.

Cc: stable@vger.kernel.org
Fixes: cc13ab18b201 ("net: dsa: microchip: ptp: enable interrupt for timestamping")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 35fc21b1ee48a47daa278573bfe8749c7b42c731..c8bfbe5e2157323ecf29149d1907b77e689aa221 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1139,8 +1139,8 @@ int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 		irq_create_mapping(ptpirq->domain, irq);
 
 	ptpirq->irq_num = irq_find_mapping(port->pirq.domain, PORT_SRC_PTP_INT);
-	if (ptpirq->irq_num < 0) {
-		ret = ptpirq->irq_num;
+	if (!ptpirq->irq_num) {
+		ret = -EINVAL;
 		goto out;
 	}
 

-- 
2.51.1


