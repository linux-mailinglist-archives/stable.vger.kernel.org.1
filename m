Return-Path: <stable+bounces-83920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3DD99CD30
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A885281F31
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD031AB526;
	Mon, 14 Oct 2024 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qc30m/L8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92501AAE25;
	Mon, 14 Oct 2024 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916194; cv=none; b=O9GzKcWZo59V9f6TxnCYFs8I9W+MUWzRbYUj+2FomPUVpwx/H0WjUrcL3OqRMHWET3Qs1lCGtIA897vUiUZkkY0Tfq/DYvYk3j5VW7NVuUyj4vRIs/7ZbhQX3ejRn/ucnZR2kHqw7/oZZsUUXBNT7mkwnPz/lkegeZqkh880934=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916194; c=relaxed/simple;
	bh=zLEGeiYnpglF2klfNYvvPsgpwrywZyXjoFXhAlw/uAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPglOt88eLCs58XUVIhOEJ46OXTTtFfv9icbY/cU+VADFOgQcCbXe9PtNeTMaHA2SiVfuIIvbFoTR/GL8lvHdfSlauXtN1bp+Fhnv61tlQolfKuf3NPmpUJikJNLujAiSFVpR8mc55Timp8INisqdmKcyIcAJlEZpr3yZzV6Rn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qc30m/L8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF61EC4CEC3;
	Mon, 14 Oct 2024 14:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728916194;
	bh=zLEGeiYnpglF2klfNYvvPsgpwrywZyXjoFXhAlw/uAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qc30m/L8NZGEDbrry7fsW/s0qV8s8wGGQA5mjnNYDOpCEElHdTOi1K3IaWZLbwrI/
	 zFqhSuuhkOroqcboEN9nQS+iwIDQqrcBMUZkXWtcEFeg/eAuzN259xwiThW85kOtNR
	 XRRv5zg385pJjsHFwvePeBn5VXPnp1MX4tWwOEiI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 093/214] net: phy: aquantia: remove usage of phy_set_max_speed
Date: Mon, 14 Oct 2024 16:19:16 +0200
Message-ID: <20241014141048.624804207@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141044.974962104@linuxfoundation.org>
References: <20241014141044.974962104@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abhishek Chauhan <quic_abchauha@quicinc.com>

[ Upstream commit 8f61d73306c62e3c0e368cf6051330f4593415f6 ]

Remove the use of phy_set_max_speed in phy driver as the
function is mainly used in MAC driver to set the max
speed.

Instead use get_features to fix up Phy PMA capabilities for
AQR111, AQR111B0, AQR114C and AQCS109

Fixes: 038ba1dc4e54 ("net: phy: aquantia: add AQR111 and AQR111B0 PHY ID")
Fixes: 0974f1f03b07 ("net: phy: aquantia: remove false 5G and 10G speed ability for AQCS109")
Fixes: c278ec644377 ("net: phy: aquantia: add support for AQR114C PHY ID")
Link: https://lore.kernel.org/all/20240913011635.1286027-1-quic_abchauha@quicinc.com/T/
Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://patch.msgid.link/20241001224626.2400222-3-quic_abchauha@quicinc.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/aquantia/aquantia_main.c | 37 ++++++++++++------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 1bb39664a5cb1..c33a5ef34ba03 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -537,12 +537,6 @@ static int aqcs109_config_init(struct phy_device *phydev)
 	if (!ret)
 		aqr107_chip_info(phydev);
 
-	/* AQCS109 belongs to a chip family partially supporting 10G and 5G.
-	 * PMA speed ability bits are the same for all members of the family,
-	 * AQCS109 however supports speeds up to 2.5G only.
-	 */
-	phy_set_max_speed(phydev, SPEED_2500);
-
 	return aqr107_set_downshift(phydev, MDIO_AN_VEND_PROV_DOWNSHIFT_DFLT);
 }
 
@@ -744,6 +738,18 @@ static int aqr115c_get_features(struct phy_device *phydev)
 	return 0;
 }
 
+static int aqr111_get_features(struct phy_device *phydev)
+{
+	/* PHY supports speeds up to 5G with autoneg. PMA capabilities
+	 * are not useful.
+	 */
+	aqr115c_get_features(phydev);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+			 phydev->supported);
+
+	return 0;
+}
+
 static int aqr113c_config_init(struct phy_device *phydev)
 {
 	int ret;
@@ -780,15 +786,6 @@ static int aqr107_probe(struct phy_device *phydev)
 	return aqr_hwmon_probe(phydev);
 }
 
-static int aqr111_config_init(struct phy_device *phydev)
-{
-	/* AQR111 reports supporting speed up to 10G,
-	 * however only speeds up to 5G are supported.
-	 */
-	phy_set_max_speed(phydev, SPEED_5000);
-
-	return aqr107_config_init(phydev);
-}
 
 static struct phy_driver aqr_driver[] = {
 {
@@ -866,6 +863,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_sset_count	= aqr107_get_sset_count,
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
+	.get_features   = aqr115c_get_features,
 	.link_change_notify = aqr107_link_change_notify,
 	.led_brightness_set = aqr_phy_led_brightness_set,
 	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
@@ -878,7 +876,7 @@ static struct phy_driver aqr_driver[] = {
 	.name		= "Aquantia AQR111",
 	.probe		= aqr107_probe,
 	.get_rate_matching = aqr107_get_rate_matching,
-	.config_init	= aqr111_config_init,
+	.config_init	= aqr107_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
@@ -890,6 +888,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_sset_count	= aqr107_get_sset_count,
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
+	.get_features   = aqr111_get_features,
 	.link_change_notify = aqr107_link_change_notify,
 	.led_brightness_set = aqr_phy_led_brightness_set,
 	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
@@ -902,7 +901,7 @@ static struct phy_driver aqr_driver[] = {
 	.name		= "Aquantia AQR111B0",
 	.probe		= aqr107_probe,
 	.get_rate_matching = aqr107_get_rate_matching,
-	.config_init	= aqr111_config_init,
+	.config_init	= aqr107_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
@@ -914,6 +913,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_sset_count	= aqr107_get_sset_count,
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
+	.get_features   = aqr111_get_features,
 	.link_change_notify = aqr107_link_change_notify,
 	.led_brightness_set = aqr_phy_led_brightness_set,
 	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
@@ -1023,7 +1023,7 @@ static struct phy_driver aqr_driver[] = {
 	.name           = "Aquantia AQR114C",
 	.probe          = aqr107_probe,
 	.get_rate_matching = aqr107_get_rate_matching,
-	.config_init    = aqr111_config_init,
+	.config_init    = aqr107_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr    = aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
@@ -1035,6 +1035,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_sset_count = aqr107_get_sset_count,
 	.get_strings    = aqr107_get_strings,
 	.get_stats      = aqr107_get_stats,
+	.get_features   = aqr111_get_features,
 	.link_change_notify = aqr107_link_change_notify,
 	.led_brightness_set = aqr_phy_led_brightness_set,
 	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
-- 
2.43.0




