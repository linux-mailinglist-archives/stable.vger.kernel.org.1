Return-Path: <stable+bounces-198137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E449FC9CBFA
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 20:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CADE3A88EA
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 19:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1AE2DC332;
	Tue,  2 Dec 2025 19:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3BGezD0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5822DAFAE
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 19:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764703269; cv=none; b=fwSARQWSTnoJfonjj21UDPF1z4s6oTPWcDpnbhB9dGZUa5PaJDnIDrO6sYnbXB8/PVR+5RU+c6lPBaOK+naPiPI3A+6IV98xgeUFtj46RHBjijqyNxXsBRlERAk5+U4UhmIzjSlbye/82nCNUAiegY8i71QYnqyY4n99LOaC3dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764703269; c=relaxed/simple;
	bh=glrz2gaROrDIHt6+YWgOzKfpl0/EkX0ssbDeH2BVvhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrZGsyOrTz6lTccWBMhNj32fCxUQ1hD/X9pVDXuhPENvBeIh4KlmOeqDEhE/Uht32YDEbexoj7V0lHHs1PQ6STzjkxP2K7zF1aHOWuMZIMqd7/puv5x7QLJKdnSXFeJHHPinmvd94rwIRlvQDxdhA1n0ujhU8XVthGbF69yq2Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3BGezD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4D7C4CEF1;
	Tue,  2 Dec 2025 19:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764703269;
	bh=glrz2gaROrDIHt6+YWgOzKfpl0/EkX0ssbDeH2BVvhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z3BGezD03RielnwM6wTtMjrNmSMw0GHMiFd9e0ZBu1nrPcQ7DAGQ+4AenIKoK3lMA
	 DL1H1HzoB44Zvv1xN/30KtKjMataQbmBdJ4qJ9i4Hs3Q7vs1HUTh/V5T3NTmAeJ/Wu
	 NtQwMbii+PRtrD5fnghybTaDTcithjeMjhGZ+JTp9Q1UQnspGgNjOKY9r1+7qyDZz0
	 HAL/zOT6giFHn8NBaid3RpTW2SDwAUFal3QON1qKYNJzka6/Z5FATy25USAC8d/DxY
	 NboSocp+Tkdg2fXhGeZ7IJvM5KDK/7c240N1QK1ac8+nLTSh6Q9JwdCdCxijirsKOR
	 K/ZAD8GuoB/yg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tristram Ha <tristram.ha@microchip.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] net: dsa: microchip: Do not execute PTP driver code for unsupported switches
Date: Tue,  2 Dec 2025 14:20:58 -0500
Message-ID: <20251202192100.2403411-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025120246-talcum-rectangle-f99d@gregkh>
References: <2025120246-talcum-rectangle-f99d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristram Ha <tristram.ha@microchip.com>

[ Upstream commit 6ed3472173c575cd8aaed6c62eb74f7728404ee6 ]

The PTP driver code only works for certain KSZ switches like KSZ9477,
KSZ9567, LAN937X and their varieties.  This code is enabled by kernel
configuration CONFIG_NET_DSA_MICROCHIP_KSZ_PTP.  As the DSA driver is
common to work with all KSZ switches this PTP code is not appropriate
for other unsupported switches.  The ptp_capable indication is added to
the chip data structure to signal whether to execute those code.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
Link: https://patch.msgid.link/20241218020240.70601-1-Tristram.Ha@microchip.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 0f80e21bf622 ("net: dsa: microchip: Free previously initialized ports on init failures")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/microchip/ksz_common.c | 40 +++++++++++++++++++-------
 drivers/net/dsa/microchip/ksz_common.h |  1 +
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 5cfbb62058852..664e3114a5bd0 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1342,6 +1342,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.supports_rgmii = {false, false, true},
 		.internal_phy = {true, true, false},
 		.gbit_capable = {false, false, true},
+		.ptp_capable = true,
 		.wr_table = &ksz8563_register_set,
 		.rd_table = &ksz8563_register_set,
 	},
@@ -1553,6 +1554,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy	= {true, true, true, true,
 				   true, false, false},
 		.gbit_capable	= {true, true, true, true, true, true, true},
+		.ptp_capable = true,
 		.wr_table = &ksz9477_register_set,
 		.rd_table = &ksz9477_register_set,
 	},
@@ -1680,6 +1682,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.supports_rgmii = {false, false, true},
 		.internal_phy = {true, true, false},
 		.gbit_capable = {true, true, true},
+		.ptp_capable = true,
 	},
 
 	[KSZ8567] = {
@@ -1715,6 +1718,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 				   true, false, false},
 		.gbit_capable	= {false, false, false, false, false,
 				   true, true},
+		.ptp_capable = true,
 	},
 
 	[KSZ9567] = {
@@ -1747,6 +1751,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy	= {true, true, true, true,
 				   true, false, false},
 		.gbit_capable	= {true, true, true, true, true, true, true},
+		.ptp_capable = true,
 	},
 
 	[LAN9370] = {
@@ -1775,6 +1780,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.supports_rmii = {false, false, false, false, true},
 		.supports_rgmii = {false, false, false, false, true},
 		.internal_phy = {true, true, true, true, false},
+		.ptp_capable = true,
 	},
 
 	[LAN9371] = {
@@ -1803,6 +1809,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.supports_rmii = {false, false, false, false, true, true},
 		.supports_rgmii = {false, false, false, false, true, true},
 		.internal_phy = {true, true, true, true, false, false},
+		.ptp_capable = true,
 	},
 
 	[LAN9372] = {
@@ -1835,6 +1842,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 				   true, true, false, false},
 		.internal_phy	= {true, true, true, true,
 				   false, false, true, true},
+		.ptp_capable = true,
 	},
 
 	[LAN9373] = {
@@ -1867,6 +1875,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 				   true, true, false, false},
 		.internal_phy	= {true, true, true, false,
 				   false, false, true, true},
+		.ptp_capable = true,
 	},
 
 	[LAN9374] = {
@@ -1899,6 +1908,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 				   true, true, false, false},
 		.internal_phy	= {true, true, true, true,
 				   false, false, true, true},
+		.ptp_capable = true,
 	},
 };
 EXPORT_SYMBOL_GPL(ksz_switch_chips);
@@ -2556,16 +2566,21 @@ static int ksz_setup(struct dsa_switch *ds)
 			if (ret)
 				goto out_girq;
 
-			ret = ksz_ptp_irq_setup(ds, dp->index);
-			if (ret)
-				goto out_pirq;
+			if (dev->info->ptp_capable) {
+				ret = ksz_ptp_irq_setup(ds, dp->index);
+				if (ret)
+					goto out_pirq;
+			}
 		}
 	}
 
-	ret = ksz_ptp_clock_register(ds);
-	if (ret) {
-		dev_err(dev->dev, "Failed to register PTP clock: %d\n", ret);
-		goto out_ptpirq;
+	if (dev->info->ptp_capable) {
+		ret = ksz_ptp_clock_register(ds);
+		if (ret) {
+			dev_err(dev->dev, "Failed to register PTP clock: %d\n",
+				ret);
+			goto out_ptpirq;
+		}
 	}
 
 	ret = ksz_mdio_register(dev);
@@ -2585,9 +2600,10 @@ static int ksz_setup(struct dsa_switch *ds)
 	return 0;
 
 out_ptp_clock_unregister:
-	ksz_ptp_clock_unregister(ds);
+	if (dev->info->ptp_capable)
+		ksz_ptp_clock_unregister(ds);
 out_ptpirq:
-	if (dev->irq > 0)
+	if (dev->irq > 0 && dev->info->ptp_capable)
 		dsa_switch_for_each_user_port(dp, dev->ds)
 			ksz_ptp_irq_free(ds, dp->index);
 out_pirq:
@@ -2606,11 +2622,13 @@ static void ksz_teardown(struct dsa_switch *ds)
 	struct ksz_device *dev = ds->priv;
 	struct dsa_port *dp;
 
-	ksz_ptp_clock_unregister(ds);
+	if (dev->info->ptp_capable)
+		ksz_ptp_clock_unregister(ds);
 
 	if (dev->irq > 0) {
 		dsa_switch_for_each_user_port(dp, dev->ds) {
-			ksz_ptp_irq_free(ds, dp->index);
+			if (dev->info->ptp_capable)
+				ksz_ptp_irq_free(ds, dp->index);
 
 			ksz_irq_free(&dev->ports[dp->index].pirq);
 		}
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 4ee518f8addc4..36f2fd77619fc 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -86,6 +86,7 @@ struct ksz_chip_data {
 	bool supports_rgmii[KSZ_MAX_NUM_PORTS];
 	bool internal_phy[KSZ_MAX_NUM_PORTS];
 	bool gbit_capable[KSZ_MAX_NUM_PORTS];
+	bool ptp_capable;
 	const struct regmap_access_table *wr_table;
 	const struct regmap_access_table *rd_table;
 };
-- 
2.51.0


