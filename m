Return-Path: <stable+bounces-124534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FCBA63496
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 08:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41EC71709D1
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 07:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CC018B463;
	Sun, 16 Mar 2025 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ep29VpqG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E992F32
	for <stable@vger.kernel.org>; Sun, 16 Mar 2025 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742111498; cv=none; b=sXYuae8DlLNsnM3T+zAO+6GQNzhWRwyXbfRwE7yUV4vMc8qdc06NrHyOc60o5xwg+nHyP/SamR3EACgQ1CaNyD2zPJ1ltLPsWp7rQh3GNtq7sCpDvcYoIe+A54yAcbfswSp2iaEU7ZjXlwXYgbY6hAPFLatyjdpAnuxBWzBqT6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742111498; c=relaxed/simple;
	bh=z3y90wXXz++LwrdS8xJ4wk38VVtUycBZkWwNWNNq25M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZpFjGQq7uffHn7JHIWDct0VHEO5uBpR+aQ0TEEqQ5V19E+R3Qv9t4x2dFT8sCxPThZm0Cjy6ONhB8+nIEcdjp9S14WhzWfOp4b24s9wIz5j/s7mJXUoSlSbmuYaQ3AWVCs5uNZQILzySW/qckDgx67b3VT8vRXiEGcJK3IafYd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ep29VpqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE23C4CEDD;
	Sun, 16 Mar 2025 07:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742111497;
	bh=z3y90wXXz++LwrdS8xJ4wk38VVtUycBZkWwNWNNq25M=;
	h=Subject:To:Cc:From:Date:From;
	b=Ep29VpqGyy+Pvpc56YKWiBQP0goThgKex5avdDv9NPbJ2Bxwh+UbU+eHIb75zB4bs
	 r4B5pF8SAMNwyxFdEA/+tNLDFIvV9tglFLdEoF/bV8MIGaqIW8PRbRJjbyWhOwuoW+
	 IDCm605hA2ph2FHemgm+q1snX+yBy613PSBBE2DU=
Subject: FAILED: patch "[PATCH] net: phy: nxp-c45-tja11xx: add TJA112XB SGMII PCS restart" failed to apply to 6.6-stable tree
To: andrei.botila@oss.nxp.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 16 Mar 2025 08:50:19 +0100
Message-ID: <2025031619-crazed-stock-31a5@gregkh>
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
git cherry-pick -x 48939523843e4813e78920f54937944a8787134b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025031619-crazed-stock-31a5@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 48939523843e4813e78920f54937944a8787134b Mon Sep 17 00:00:00 2001
From: Andrei Botila <andrei.botila@oss.nxp.com>
Date: Tue, 4 Mar 2025 18:06:14 +0200
Subject: [PATCH] net: phy: nxp-c45-tja11xx: add TJA112XB SGMII PCS restart
 errata

TJA1120B/TJA1121B can achieve a stable operation of SGMII after
a startup event by putting the SGMII PCS into power down mode and
restart afterwards.

It is necessary to put the SGMII PCS into power down mode and back up.

Cc: stable@vger.kernel.org
Fixes: f1fe5dff2b8a ("net: phy: nxp-c45-tja11xx: add TJA1120 support")
Signed-off-by: Andrei Botila <andrei.botila@oss.nxp.com>
Link: https://patch.msgid.link/20250304160619.181046-3-andrei.botila@oss.nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 709d6c9f7cba..e9fc54517449 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -114,6 +114,9 @@
 #define MII_BASIC_CONFIG_RMII		0x5
 #define MII_BASIC_CONFIG_MII		0x4
 
+#define VEND1_SGMII_BASIC_CONTROL	0xB000
+#define SGMII_LPM			BIT(11)
+
 #define VEND1_SYMBOL_ERROR_CNT_XTD	0x8351
 #define EXTENDED_CNT_EN			BIT(15)
 #define VEND1_MONITOR_STATUS		0xAC80
@@ -1598,11 +1601,11 @@ static int nxp_c45_set_phy_mode(struct phy_device *phydev)
 	return 0;
 }
 
-/* Errata: ES_TJA1120 and ES_TJA1121 Rev. 1.0 — 28 November 2024 Section 3.1 */
+/* Errata: ES_TJA1120 and ES_TJA1121 Rev. 1.0 — 28 November 2024 Section 3.1 & 3.2 */
 static void nxp_c45_tja1120_errata(struct phy_device *phydev)
 {
+	bool macsec_ability, sgmii_ability;
 	int silicon_version, sample_type;
-	bool macsec_ability;
 	int phy_abilities;
 	int ret = 0;
 
@@ -1619,6 +1622,7 @@ static void nxp_c45_tja1120_errata(struct phy_device *phydev)
 	phy_abilities = phy_read_mmd(phydev, MDIO_MMD_VEND1,
 				     VEND1_PORT_ABILITIES);
 	macsec_ability = !!(phy_abilities & MACSEC_ABILITY);
+	sgmii_ability = !!(phy_abilities & SGMII_ABILITY);
 	if ((!macsec_ability && silicon_version == 2) ||
 	    (macsec_ability && silicon_version == 1)) {
 		/* TJA1120/TJA1121 PHY configuration errata workaround.
@@ -1639,6 +1643,18 @@ static void nxp_c45_tja1120_errata(struct phy_device *phydev)
 
 		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x0);
 		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0);
+
+		if (sgmii_ability) {
+			/* TJA1120B/TJA1121B SGMII PCS restart errata workaround.
+			 * Put SGMII PCS into power down mode and back up.
+			 */
+			phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+					 VEND1_SGMII_BASIC_CONTROL,
+					 SGMII_LPM);
+			phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+					   VEND1_SGMII_BASIC_CONTROL,
+					   SGMII_LPM);
+		}
 	}
 }
 


