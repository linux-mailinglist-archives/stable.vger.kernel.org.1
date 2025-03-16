Return-Path: <stable+bounces-124533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41500A63495
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 08:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8EE1892587
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 07:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B0218B463;
	Sun, 16 Mar 2025 07:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X2q5RbOm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F9D2F32
	for <stable@vger.kernel.org>; Sun, 16 Mar 2025 07:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742111479; cv=none; b=DmVZ7i0QV2fmbUUa+7rRSVG5TEsJ5uONzdXlHl8/BgQT9c60W/9VCaGorbyBq7h6/g/5tQV9ZnwFLLdcSaudJXW3orxBpUpn0HgIzsAP1i4VaWL/sSLAkHhAvnrAGQnAwuP+LTNwHp4pEwCgjuC/cEj9/OgpHahqJJgtarUMjPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742111479; c=relaxed/simple;
	bh=SrqKSYsk7JKAs4308YNIjXLmJ47eN6EPjG7UUVd3RyM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uUE5BCIu+HeT2+eVLQYND7SUqggqV2h7ZQDTzgs0TijQIwhTNaFIf9LX5cEoIRpS6oGaIrk6iQ1Tpr5zt1YEKRHjofJ3ivcrR1tKYf663jKufOrU8XaKJWO/ZR9OrjOpAsaK2tIFmAazyJideZjYSxhhjF77dBojI51bh9yvktI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X2q5RbOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0716EC4CEE9;
	Sun, 16 Mar 2025 07:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742111478;
	bh=SrqKSYsk7JKAs4308YNIjXLmJ47eN6EPjG7UUVd3RyM=;
	h=Subject:To:Cc:From:Date:From;
	b=X2q5RbOm++DE7gumpQPSCVKam5iSet/cRXGXbghXiRktS/VNRQ1n7hcE+k4VL1ANt
	 Xv4mtNjDLbEZgc/eyPo4JmpRgO3nO6l23gA9Jwl+xf8Fb8QpT0yoLyBsJSsmu9tmsu
	 /oEkG2VmXE6p/ka9iGIG/joL5Hs7kc0atg9WxkEc=
Subject: FAILED: patch "[PATCH] net: phy: nxp-c45-tja11xx: add TJA112X PHY configuration" failed to apply to 6.6-stable tree
To: andrei.botila@oss.nxp.com,andrew@lunn.ch,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 16 Mar 2025 08:49:59 +0100
Message-ID: <2025031659-impeach-flatworm-db02@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x a07364b394697d2e0baffeb517f41385259aa484
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025031659-impeach-flatworm-db02@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a07364b394697d2e0baffeb517f41385259aa484 Mon Sep 17 00:00:00 2001
From: Andrei Botila <andrei.botila@oss.nxp.com>
Date: Tue, 4 Mar 2025 18:06:13 +0200
Subject: [PATCH] net: phy: nxp-c45-tja11xx: add TJA112X PHY configuration
 errata

The most recent sillicon versions of TJA1120 and TJA1121 can achieve
full silicon performance by putting the PHY in managed mode.

It is necessary to apply these PHY writes before link gets established.
Application of this fix is required after restart of device and wakeup
from sleep.

Cc: stable@vger.kernel.org
Fixes: f1fe5dff2b8a ("net: phy: nxp-c45-tja11xx: add TJA1120 support")
Signed-off-by: Andrei Botila <andrei.botila@oss.nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250304160619.181046-2-andrei.botila@oss.nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 34231b5b9175..709d6c9f7cba 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -22,6 +22,11 @@
 #define PHY_ID_TJA_1103			0x001BB010
 #define PHY_ID_TJA_1120			0x001BB031
 
+#define VEND1_DEVICE_ID3		0x0004
+#define TJA1120_DEV_ID3_SILICON_VERSION	GENMASK(15, 12)
+#define TJA1120_DEV_ID3_SAMPLE_TYPE	GENMASK(11, 8)
+#define DEVICE_ID3_SAMPLE_TYPE_R	0x9
+
 #define VEND1_DEVICE_CONTROL		0x0040
 #define DEVICE_CONTROL_RESET		BIT(15)
 #define DEVICE_CONTROL_CONFIG_GLOBAL_EN	BIT(14)
@@ -1593,6 +1598,50 @@ static int nxp_c45_set_phy_mode(struct phy_device *phydev)
 	return 0;
 }
 
+/* Errata: ES_TJA1120 and ES_TJA1121 Rev. 1.0 — 28 November 2024 Section 3.1 */
+static void nxp_c45_tja1120_errata(struct phy_device *phydev)
+{
+	int silicon_version, sample_type;
+	bool macsec_ability;
+	int phy_abilities;
+	int ret = 0;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_DEVICE_ID3);
+	if (ret < 0)
+		return;
+
+	sample_type = FIELD_GET(TJA1120_DEV_ID3_SAMPLE_TYPE, ret);
+	if (sample_type != DEVICE_ID3_SAMPLE_TYPE_R)
+		return;
+
+	silicon_version = FIELD_GET(TJA1120_DEV_ID3_SILICON_VERSION, ret);
+
+	phy_abilities = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+				     VEND1_PORT_ABILITIES);
+	macsec_ability = !!(phy_abilities & MACSEC_ABILITY);
+	if ((!macsec_ability && silicon_version == 2) ||
+	    (macsec_ability && silicon_version == 1)) {
+		/* TJA1120/TJA1121 PHY configuration errata workaround.
+		 * Apply PHY writes sequence before link up.
+		 */
+		if (!macsec_ability) {
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x4b95);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0xf3cd);
+		} else {
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x89c7);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0893);
+		}
+
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x0476, 0x58a0);
+
+		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, 0x8921, 0xa3a);
+		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, 0x89F1, 0x16c1);
+
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x0);
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0);
+	}
+}
+
 static int nxp_c45_config_init(struct phy_device *phydev)
 {
 	int ret;
@@ -1609,6 +1658,9 @@ static int nxp_c45_config_init(struct phy_device *phydev)
 	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 1);
 	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 2);
 
+	if (phy_id_compare(phydev->phy_id, PHY_ID_TJA_1120, GENMASK(31, 4)))
+		nxp_c45_tja1120_errata(phydev);
+
 	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PHY_CONFIG,
 			 PHY_CONFIG_AUTO);
 


