Return-Path: <stable+bounces-208306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D2175D1BBD4
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 00:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D717303BFCB
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 23:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B35636BCE0;
	Tue, 13 Jan 2026 23:38:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from MTA-08-4.privateemail.com (mta-08-4.privateemail.com [198.54.122.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C3B36B075;
	Tue, 13 Jan 2026 23:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.122.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768347524; cv=none; b=HXLBzy4jvbueXRu2N6fg6VLwESOks2Mro56359hQxsAsDnfi7FKQHsuFpmE2tT+HQifGP/hg58I4pZv/95GkHvxYzFT29GJcO6Uw0WjIQ85qKZukk+pBrLb//P20+2QKtKyjUa7gUSEOcD2wcOHJx4NF1B/Q1eI+OFarN1aoIEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768347524; c=relaxed/simple;
	bh=WB3bP7F4W/KUYt6cXm8bDzC6b9+gvFcmU2yR/wyQDJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e5BWjyFJd/XFOEI3XpxPrMuyBouQTvLlAA8kfbpmPWaoNbo4PxGnSgCGtXCsHKXKb1G8We2bOzvAGEmywjrMd8nNBvJypzkguBl/23uMe2T/0R4cE/R/9WUVpXs2VX1qGufKgimb5a2spFfFh/2Dnf1WcQdaoI7vXtTkJx17ZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=effective-light.com; spf=pass smtp.mailfrom=effective-light.com; arc=none smtp.client-ip=198.54.122.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=effective-light.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=effective-light.com
Received: from mta-08.privateemail.com (localhost [127.0.0.1])
	by mta-08.privateemail.com (Postfix) with ESMTP id 4drQg01N69z3hhTl;
	Tue, 13 Jan 2026 18:38:36 -0500 (EST)
Received: from localhost.localdomain (bras-base-toroon4332w-grc-38-70-55-47-65.dsl.bell.ca [70.55.47.65])
	by mta-08.privateemail.com (Postfix) with ESMTPA;
	Tue, 13 Jan 2026 18:38:23 -0500 (EST)
From: Hamza Mahfooz <someguy@effective-light.com>
To: netdev@vger.kernel.org
Cc: Hamza Mahfooz <someguy@effective-light.com>,
	stable@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: sfp: add potron quirk to the H-COM SPP425H-GAB4 SFP+ Stick
Date: Tue, 13 Jan 2026 18:29:57 -0500
Message-ID: <20260113232957.609642-1-someguy@effective-light.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This is another one of those XGSPON ONU sticks that's using the
X-ONU-SFPP internally, thus it also requires the potron quirk to avoid tx
faults. So, add an entry for it in sfp_quirks[].

Cc: stable@vger.kernel.org
Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
 drivers/net/phy/sfp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 84bef5099dda..47f095bd91ce 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -519,6 +519,8 @@ static const struct sfp_quirk sfp_quirks[] = {
 
 	SFP_QUIRK_F("HALNy", "HL-GSFP", sfp_fixup_halny_gsfp),
 
+	SFP_QUIRK_F("H-COM", "SPP425H-GAB4", sfp_fixup_potron),
+
 	// HG MXPD-483II-F 2.5G supports 2500Base-X, but incorrectly reports
 	// 2600MBd in their EERPOM
 	SFP_QUIRK_S("HG GENUINE", "MXPD-483II", sfp_quirk_2500basex),
-- 
2.52.0


