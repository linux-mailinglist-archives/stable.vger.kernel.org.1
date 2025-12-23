Return-Path: <stable+bounces-203315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B00CD9BA9
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 16:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4771A3032710
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 15:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E554828727C;
	Tue, 23 Dec 2025 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b="CDV/8891";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PUqnhElF"
X-Original-To: stable@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B630286D5D;
	Tue, 23 Dec 2025 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766502217; cv=none; b=RqHo0VfZL473KkzWLsQ32Iwf4bdDBiscfHpBobhVnDWHx8MHHLNRIoo7eAMU7voIGETQ+ju/oQCKR7ce2CbimCM35I65VSyHgxqPl8Rhm1cNNjm89S4xqU2u6ALXFtvpf6cBfpFjncB08XXBxFp4ZIQp75rGWXzsBTROY0LFZBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766502217; c=relaxed/simple;
	bh=Y8h2u4IEUHAPn/mDroZpxYRKFzvRZI7gsgCOWisMxMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E0wZZB0kT80XMtL3ktKId5VRIVOy/S4Brq9T1X3Ioflz/pKE5TWCIYHt7UruCCEGm3sSZc0M95lX8GFryvl7T6kz4puC6UNVQjBKCaA1I4KomSwqi0YVF9Ms8W1JwipDt9ZIvlOc+hzhQwpts+Y5A//5ttPSh8StpTwXp9j3j1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=beims.me; spf=pass smtp.mailfrom=beims.me; dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b=CDV/8891; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PUqnhElF; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=beims.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=beims.me
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 3C2B2EC0108;
	Tue, 23 Dec 2025 10:03:33 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 23 Dec 2025 10:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beims.me; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1766502213; x=1766588613; bh=l+VjmMpqeoXGTdow4O/go
	ELngynUtd1mvs6oU6B69Iw=; b=CDV/8891CofWQWPqwYChTmHxoYzVHnsoY6MrQ
	3/URfht+XVI9IhW8rqu3xgnOcweSKd6Ie8cL+GQN3ni1vENjAPoFEa9XMCADgdfP
	YTlvKjta6InrF3U7rzMrfiU1WhPZY/8kcvCVEaWH8eq707QXb9J24jKuNNr9UFnf
	mrqspHvjelSrzScyOF9bgL+NfQCVEaksih126ozwDDfXCq35PEdlAOhv34/GQIhL
	UNo/8yJx3zoRN7OknSPvCFB+Hy8xHoNO1CDCehFwLW6Ktb6vCYTkD7a6IWbeHBqR
	SxMOYkWhEMXleYPhPlES7FGEOs4+neZjMh8nDbnh5QFu6tLEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766502213; x=1766588613; bh=l+VjmMpqeoXGTdow4O/goELngynUtd1mvs6
	oU6B69Iw=; b=PUqnhElF83bqeU43vdBA1Fly2kzVcoNBeLKYPcj9poDqObPhum6
	A2QKkevf1KyLn3U8e7jcOoZ/Kp43E2X4YFaJyrnQC9n3LwCm6Dd0S0yXgduc3osm
	oUC6gEni/+dtuK9tif6z/4IiS0+27VNaeJSOzhCo1VKG55R1Fq2WLBfc5pFCpuXP
	qZfAMf29fPvx+V446FZOTgkuy4mdoc9yIsb7VBFQZIafrVLy1hR+/PkIK67eTPBT
	aWfH//RdqdhBehZNCBhAuz8bf+S7V+io1ioiADsHEjg7e9Y+MIqRiwof9I1+xxld
	2dn7KLOi3Kv6DdG3CM00XC+rrV5eYePx+Zw==
X-ME-Sender: <xms:RK9KaY6aof43jCLbXSsdN8LOhnx2I9FN4py5cDz3ttVwaPRq-zDlcQ>
    <xme:RK9KafGpEmuYjq7OpiZF16goaKDRZQzLHJLmIfaTjzbxK5f-yWTkTH9Xod4f5lzhC
    wA7Gt5sNxBdhcms-ZsWpSnCgJ5b5QDOhS7wYHPaQ4GIP4G4KBJQ5g>
X-ME-Received: <xmr:RK9Kaa1pNyPZ_WC8_22yux42EgQwK2-7Z7OvokiRxoaS3nHF_yOnhklvHkSgCobXQdIn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeitddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftrghfrggvlhcuuegv
    ihhmshcuoehrrghfrggvlhessggvihhmshdrmhgvqeenucggtffrrghtthgvrhhnpeegje
    dvhfetlefhveeljefhtefhjeejffdutefhvdeludfhgfeutdetheeggeekgeenucffohhm
    rghinhepnhigphdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehrrghfrggvlhessggvihhmshdrmhgvpdhnsggprhgtphhtthhopedu
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhkohhulheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhr
    ghdprhgtphhtthhopehshhgrfihnghhuoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshdrhhgruhgvrhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepkhgvrhhn
    vghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopehfvghsthgvvhgrmhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhphhihsehlihhsthhsrdhinhhf
    rhgruggvrggurdhorhhgpdhrtghpthhtohepihhmgieslhhishhtshdrlhhinhhugidrug
    gvvhdprhgtphhtthhopehrrghfrggvlhdrsggvihhmshesthhorhgruggvgidrtghomh
X-ME-Proxy: <xmx:RK9KacqrI9d4KmL_0975qBKl1XfaZyVNZTg4v1Z-yPiGk4ZzTXWE3A>
    <xmx:RK9KaXM0OxMBqlCIDiVmQrrwagF_FzsiAsTwQ27ZeL6gA3OoqbOxDQ>
    <xmx:RK9KaeUmObZlQ8h3-imcqqfQVMf_cWjfpxaW9GOl4hUqWlJbs2Ex7Q>
    <xmx:RK9KaaveHqM9h8nHqSTumXpXiimXjRFkOTvS0JSw17O9CwjYSHDhFQ>
    <xmx:Ra9Kad522RH4sJuvJUdZqhFBxfez1fV4qGTD5o5ugPPV_vvZm_UAXa-O>
Feedback-ID: idc214666:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Dec 2025 10:03:30 -0500 (EST)
From: Rafael Beims <rafael@beims.me>
To: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-phy@lists.infradead.org,
	imx@lists.linux.dev,
	Rafael Beims <rafael.beims@toradex.com>,
	Sahaj Sarup <sahaj.sarup@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] phy: freescale: imx8m-pcie: assert phy reset during power on
Date: Tue, 23 Dec 2025 12:02:54 -0300
Message-ID: <20251223150254.1075221-1-rafael@beims.me>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rafael Beims <rafael.beims@toradex.com>

After U-Boot initializes PCIe with "pcie enum", Linux fails to detect
an NVMe disk on some boot cycles with:

  phy phy-32f00000.pcie-phy.0: phy poweron failed --> -110

Discussion with NXP identified that the iMX8MP PCIe PHY PLL may fail to
lock when re-initialized without a reset cycle [1].

The issue reproduces on 7% of tested hardware platforms, with a 30-40%
failure rate per affected device across boot cycles.

Insert a reset cycle in the power-on routine to ensure the PHY is
initialized from a known state.

[1] https://community.nxp.com/t5/i-MX-Processors/iMX8MP-PCIe-initialization-in-U-Boot/m-p/2248437#M242401

Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
Cc: stable@vger.kernel.org
---
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
index 68fcc8114d75..7f5600103a00 100644
--- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
+++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
@@ -89,7 +89,8 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
 			writel(imx8_phy->tx_deemph_gen2,
 			       imx8_phy->base + PCIE_PHY_TRSV_REG6);
 		break;
-	case IMX8MP: /* Do nothing. */
+	case IMX8MP:
+		reset_control_assert(imx8_phy->reset);
 		break;
 	}
 
-- 
2.51.0


