Return-Path: <stable+bounces-195235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9900C730E1
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 10:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2C9E6351BB7
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 09:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7379314A62;
	Thu, 20 Nov 2025 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GyAEBqR7"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA19311C30
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 09:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763629938; cv=none; b=ryQv9P6b4Sytaxi0rvQ6mSMFuhEmtgxHNEOPeDdPouMxwO7bF/1uOWxKMV8FGYZu3GcI2J/EXmlVCTY1OsnukVhwXPuudirr8B/IPypLdgVTfg7QB9kYbHmZ9QklZJ99QHxlV7NdHNiyLEUZFdmeCPj6Z3qdjgkrUwExaw3FMzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763629938; c=relaxed/simple;
	bh=/TAZ0MNDd7KPjWRWFfY6/kmUBIYyi1aJS8Zgiq7UBLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z+jrX0ZoftZ0ni2thqmIX7Wjh7ECBnhslwg2bSelA0rosyX3ARP5pUpvCv5Owv/l/FIwRkxdBNf3tovSG/nfRYU0PK0kmZVEKSgocegz0qoPH6L8BPqp45htcnYDprOAE+2QFPABhztzmeOvmNNldI3k7E8Eg1rgWcJGMhcrv0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GyAEBqR7; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C97684E417E5;
	Thu, 20 Nov 2025 09:12:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A047E6068C;
	Thu, 20 Nov 2025 09:12:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9170F10371A64;
	Thu, 20 Nov 2025 10:12:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763629932; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2tUIB0M+kOJqzAWgjucjSvzqi0jzDm+l3AVxpf2oZb4=;
	b=GyAEBqR7/BS4ttKqtMj1qkAe0WewyugViNk8DjpI7PRdd5dAXkNp0vldtcYIqIcqAvJdql
	Yn50tp6XzAnD6RgKJin6wDozg7rA5YkzurGqb+QqVCgt/Q9HS40+vf4eWX4H89LvgRJ8cf
	bavUGRF3wikFuk8oCc2xHpSC5CWlB+Xyll88nu/HP9Hn5NAsSwwS/PRYxHf4COH3Qa/BPf
	plyWSUSHFOn2UFAyrn9wiKTGlxby41bTX4tM2eQRLnCThZF+2dzNz/0LsYoRsIHt7s9q7b
	eZOx3adQs6wtewU4DATp9b+nD0AwSAW0/0hESBFm1cdBH8bpweN+9vL9SBFGSA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 20 Nov 2025 10:12:00 +0100
Subject: [PATCH net v6 1/5] net: dsa: microchip: common: Fix checks on
 irq_find_mapping()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-ksz-fix-v6-1-891f80ae7f8f@bootlin.com>
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
but it never returns a negative value. However, on each
irq_find_mapping() call, we verify that the returned value isn't
negative.

Fix the irq_find_mapping() checks to enter error paths when 0 is
returned. Return -EINVAL in such cases.

CC: stable@vger.kernel.org
Fixes: c9cd961c0d43 ("net: dsa: microchip: lan937x: add interrupt support for port phy link")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 98cfb42b7257b8e3b4b5cce4bbf97def64537370..b17d29dda612ce00ce2e52fbe16c54bd6516c417 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2585,8 +2585,8 @@ static int ksz_irq_phy_setup(struct ksz_device *dev)
 
 			irq = irq_find_mapping(dev->ports[port].pirq.domain,
 					       PORT_SRC_PHY_INT);
-			if (irq < 0) {
-				ret = irq;
+			if (!irq) {
+				ret = -EINVAL;
 				goto out;
 			}
 			ds->user_mii_bus->irq[phy] = irq;
@@ -2950,8 +2950,8 @@ static int ksz_pirq_setup(struct ksz_device *dev, u8 p)
 	snprintf(pirq->name, sizeof(pirq->name), "port_irq-%d", p);
 
 	pirq->irq_num = irq_find_mapping(dev->girq.domain, p);
-	if (pirq->irq_num < 0)
-		return pirq->irq_num;
+	if (!pirq->irq_num)
+		return -EINVAL;
 
 	return ksz_irq_common_setup(dev, pirq);
 }

-- 
2.51.1


