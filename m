Return-Path: <stable+bounces-194593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 295E6C51974
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 11:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55DC3188A9F4
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 10:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D6A2798EA;
	Wed, 12 Nov 2025 10:11:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E1B29A326
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 10:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942298; cv=none; b=mZouULu33GguvSaT6UPIKf22naaW7mYgtz/RLTpOoQOIt5TR26x99RJH7tqxXaE3QoVbfJXGniQC5HoX/Zh40k51ePQsZfpT8Lks0I8dHb3n89eIdAnIlBykE4QYh/nPmKHWpPdgvZLcyRWLkmtqz2R/TFkQUqnq9mhfB+J3qPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942298; c=relaxed/simple;
	bh=NCNXZ7EMg7YV6XHRPLwpZKUABPyf2sZYb/CbdpQER1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dDMTSKb46jVGmaUbt888nKDGPDRI898UARcDZ6wA3cfB9JOIH3uzy7mmLs/5DfTeuTYKArKNCuQszLVgBXmGPCrF6KBb4OLKTBUnE0cEJUOG76L4f96ZilYtkfd9PZ+BqECEbTDoiazHB0+LkuZ5DyyodB5C3DYc6ljYvSUu+4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vJ7ov-0007eK-6d; Wed, 12 Nov 2025 11:11:21 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vJ7ou-0003ub-0c;
	Wed, 12 Nov 2025 11:11:20 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vJ7ou-0000000F580-0TN0;
	Wed, 12 Nov 2025 11:11:20 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	stable@vger.kernel.org
Subject: [PATCH net v1 1/1] net: dsa: microchip: lan937x: Fix RGMII delay tuning
Date: Wed, 12 Nov 2025 11:11:19 +0100
Message-ID: <20251112101119.3594611-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

Correct RGMII delay application logic in lan937x_set_tune_adj().

The function was missing `data16 &= ~PORT_TUNE_ADJ` before setting the
new delay value. This caused the new value to be bitwise-OR'd with the
existing PORT_TUNE_ADJ field instead of replacing it.

For example, when setting the RGMII 2 TX delay on port 4, the
intended TUNE_ADJUST value of 0 (RGMII_2_TX_DELAY_2NS) was
incorrectly OR'd with the default 0x1B (from register value 0xDA3),
leaving the delay at the wrong setting.

This patch adds the missing mask to clear the field, ensuring the
correct delay value is written. Physical measurements on the RGMII TX
lines confirm the fix, showing the delay changing from ~1ns (before
change) to ~2ns.

While testing on i.MX 8MP showed this was within the platform's timing
tolerance, it did not match the intended hardware-characterized value.

Fixes: b19ac41faa3f ("net: dsa: microchip: apply rgmii tx and rx delay in phylink mac config")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/lan937x_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index b1ae3b9de3d1..5a1496fff445 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -540,6 +540,7 @@ static void lan937x_set_tune_adj(struct ksz_device *dev, int port,
 	ksz_pread16(dev, port, reg, &data16);
 
 	/* Update tune Adjust */
+	data16 &= ~PORT_TUNE_ADJ;
 	data16 |= FIELD_PREP(PORT_TUNE_ADJ, val);
 	ksz_pwrite16(dev, port, reg, data16);
 
-- 
2.47.3


