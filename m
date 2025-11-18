Return-Path: <stable+bounces-195114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F106C6A92C
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 17:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0706365902
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 16:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F140377EB3;
	Tue, 18 Nov 2025 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B42aIL7x"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C253730EE;
	Tue, 18 Nov 2025 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482416; cv=none; b=iN1JuuQQGeOv2wXfU6P3eKzpz1DWPIbI2FjRixolwBgiCZ1gT1Q+YMlyLxE8kcAf53UXDT56xgbdXq5qa6KfH+S49TbcnrYk386bFkU7FrKO/GRFIgRNle0nrryBTAoN3l/ID5nYcRVKVtA3xoYSpgjp4gXJo+m2XS2GKVSB59w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482416; c=relaxed/simple;
	bh=AEmkrFjqifoQnRxMtvLlTc3t/RLufAY+GpBg7zW6NZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WrCnThmcmxxaB53b+CQIwjPM1JUNqE4DSsKji0ssWyuHeX2vR1daK7cIT++VklFNj3gcW54oc9TMKOHcXn2O9a5Ods4AbFSWOEAA76L8lUXTTfK9upziFYn952zrJhrOUqbCxl3YXt77Ot1ARNimLcWhiCcZThUBAqmRevU8GMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B42aIL7x; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 247B04E4175D;
	Tue, 18 Nov 2025 16:13:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EE6A6606FE;
	Tue, 18 Nov 2025 16:13:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F263C10371605;
	Tue, 18 Nov 2025 17:13:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763482411; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PtjJwnZbSztJ0ylhjAx5WuFm6ywuzKa2m4FJNifI2/U=;
	b=B42aIL7xyojyioHuEIQM7P9blZcRUYLY3tIFmwjtpLaCFqOjHY2E2B5u5+fYcfstjgXJhZ
	OqXsQ1yZSugH9rPiIlydOj3uRMu3h/LO/2BuhEig/2P0V7C+rPDg9vdJbZhAeFZW850gO9
	3AVJHiY6TTS+pUhREA6QK2mP840gmrDl8YkCfKS1seePHRYATunlM4THyAx57V+VzayXli
	tbFnKxo2WZGQCMT9BaQI9taCVW6iSPZp+UnFdGAqlWhOUsR58gE+jhK1N8DtlV+gENeI76
	AnifmqtHAuSxPvVA34MWTLAF1AHVmtsOFHcdkN37F1Fp2AlRjk+9+mQtQ3sQ/g==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Tue, 18 Nov 2025 17:13:23 +0100
Subject: [PATCH net v5 2/5] net: dsa: microchip: ptp: Fix checks on
 irq_find_mapping()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-ksz-fix-v5-2-8e9c7f56618d@bootlin.com>
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


