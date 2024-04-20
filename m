Return-Path: <stable+bounces-40344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B8F8ABC78
	for <lists+stable@lfdr.de>; Sat, 20 Apr 2024 18:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65BD1C211C2
	for <lists+stable@lfdr.de>; Sat, 20 Apr 2024 16:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B8B2E3E5;
	Sat, 20 Apr 2024 16:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPMyYD+l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A902032C
	for <stable@vger.kernel.org>; Sat, 20 Apr 2024 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713631567; cv=none; b=iOJ8jyv7sujhGCM9zJf7oRdcnB29CQU+8m2nob2uJVSK6BGH0oyD1nQF2VcGw65QZOdewKVVbz/OJxnZWi35tQ+hbmMCRhRvRyWo5aZFkyfxK9O6lt5R8wBZXDHoyFK4kTklILzbFWoTUE4paYkki2vjRauooc1wxd8MiYkG15w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713631567; c=relaxed/simple;
	bh=vfpUAMza8l79Jvda5oGJSq0jjBmCrcbNcq1inL0AAS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZZQxumtQ2v0F8pxa+TJowo2fvEScQe9SlJw9MjmdvxVKFF9gZDCUVFUvN0YV3Lm8ufbBPeErKu6cm/A02zlrI6YLt+AELSWwv9B2s+oaTlgPakJA6kvIrl3RuX4sVJI3KHeEo7U6MM3b43ezaJ3h4MZZf/c3p4nkCe04xyU2YR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPMyYD+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 512DDC113CC;
	Sat, 20 Apr 2024 16:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713631567;
	bh=vfpUAMza8l79Jvda5oGJSq0jjBmCrcbNcq1inL0AAS4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mPMyYD+l1+c7LegcDo0RP8keXzo10ZCgWy6rCo9+PLJUKuIU1u991NQ45Oyz2sWPl
	 z7DvQP7O/0x8O9Twiu8jhu1zetEplLye171T7eO5idPrOlnuRvCKkIcnsLt+xe2tOS
	 mn25i2Nvaw6KGaMsFshIyQuH4Bn8wdguPS8lRWurF27/SSKxcUxy4NplCcYPAirY9K
	 HehQTGMp+PJ/J4rYZ4LZlT95/dKJhf1itPGqSiErB2QqE+TzELFkSaiJ7OR89C9OGi
	 f91hkHCrk/GbcahjiX7OiuUcg7ls+OprcAxL1Cvor6svsYJ3jY/oDgsUN2XaCSPznp
	 aaJAQU7otpYuw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40318C07E8D;
	Sat, 20 Apr 2024 16:46:07 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Sat, 20 Apr 2024 19:46:03 +0300
Subject: [PATCH 1/4] net: dsa: mt7530: set all CPU ports in MT7531_CPU_PMAP
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240420-for-stable-5-15-backports-v1-1-007bfa19d044@arinc9.com>
References: <20240420-for-stable-5-15-backports-v1-0-007bfa19d044@arinc9.com>
In-Reply-To: <20240420-for-stable-5-15-backports-v1-0-007bfa19d044@arinc9.com>
To: stable@vger.kernel.org
Cc: Daniel Golle <daniel@makrotopia.org>, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Russell King (Oracle)" <linux@armlinux.org.uk>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 "David S. Miller" <davem@davemloft.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713631565; l=3098;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=1jifdxkrWQYraf0PSB8VTfdoDio0BvKtiHEyMvaYCdI=;
 b=4BMgQZs4PpjdeH+nDfWCSWtnnNaYqfiPmtjxwmcsxaMdhSjpXG6F15eQPsrlkZN0GNedMJjMm
 F1otPAYA3SQBWyKhhEJZAxBw3KXA7k1ynGl6pwOMOBM9jLqx0MX9QlN
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

[ Upstream commit ff221029a51fd54cacac66e193e0c75e4de940e7 ]

MT7531_CPU_PMAP represents the destination port mask for trapped-to-CPU
frames (further restricted by PCR_MATRIX).

Currently the driver sets the first CPU port as the single port in this bit
mask, which works fine regardless of whether the device tree defines port
5, 6 or 5+6 as CPU ports. This is because the logic coincides with DSA's
logic of picking the first CPU port as the CPU port that all user ports are
affine to, by default.

An upcoming change would like to influence DSA's selection of the default
CPU port to no longer be the first one, and in that case, this logic needs
adaptation.

Since there is no observed leakage or duplication of frames if all CPU
ports are defined in this bit mask, simply include them all.

Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 15 +++++++--------
 drivers/net/dsa/mt7530.h |  1 +
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index f291d1e70f80..e3852cb48369 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1232,6 +1232,13 @@ mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 	if (priv->id == ID_MT7530 || priv->id == ID_MT7621)
 		mt7530_rmw(priv, MT7530_MFC, CPU_MASK, CPU_EN | CPU_PORT(port));
 
+	/* Add the CPU port to the CPU port bitmap for MT7531. Trapped frames
+	 * will be forwarded to the CPU port that is affine to the inbound user
+	 * port.
+	 */
+	if (priv->id == ID_MT7531)
+		mt7530_set(priv, MT7531_CFC, MT7531_CPU_PMAP(BIT(port)));
+
 	/* CPU port gets connected to all user ports of
 	 * the switch.
 	 */
@@ -2507,16 +2514,8 @@ static int
 mt7531_setup_common(struct dsa_switch *ds)
 {
 	struct mt7530_priv *priv = ds->priv;
-	struct dsa_port *cpu_dp;
 	int ret, i;
 
-	/* BPDU to CPU port */
-	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
-		mt7530_rmw(priv, MT7531_CFC, MT7531_CPU_PMAP_MASK,
-			   BIT(cpu_dp->index));
-		break;
-	}
-
 	mt753x_trap_frames(priv);
 
 	/* Enable and reset MIB counters */
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 299a26ad5809..22152d74b327 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -54,6 +54,7 @@ enum mt753x_id {
 #define  MT7531_MIRROR_PORT_GET(x)	(((x) >> 16) & MIRROR_MASK)
 #define  MT7531_MIRROR_PORT_SET(x)	(((x) & MIRROR_MASK) << 16)
 #define  MT7531_CPU_PMAP_MASK		GENMASK(7, 0)
+#define  MT7531_CPU_PMAP(x)		FIELD_PREP(MT7531_CPU_PMAP_MASK, x)
 
 #define MT753X_MIRROR_REG(id)		(((id) == ID_MT7531) ? \
 					 MT7531_CFC : MT7530_MFC)

-- 
2.40.1



