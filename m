Return-Path: <stable+bounces-46399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E418D03ED
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC2D1C21244
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39DF19DF77;
	Mon, 27 May 2024 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcdCsumv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E30B19DF5E;
	Mon, 27 May 2024 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819392; cv=none; b=WN03xu7Dy2the+5584Hn1Iamr+x5xfEMeg0KUQjiS/rhxNqTIXSRdqy9eRdpIb07GXpobWerCHtTii6UAimMqJmATBTdfb18DSdOTh70F3tIwhR7S+TndCovC97hjXsXz4OjiFBQjpGHXo/LhRzLBVqKAubi+ctoy3dVT/4OVk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819392; c=relaxed/simple;
	bh=bBWR1oV90O3qzHRR2xLKGLcJqtq5MlX1wb+13IQv3Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7c6Ti2ylD4JgA06pfqWlsxy7fJU2uJ9wOTaTI1q4ITSZpeeqWLcPvmPIHRnciiqoMTZkyoP/Pi3YGO5YQJkb1E9TmnmRjrkS6fiwYoAtYa35XrN/d0NIico3fluDDMhoBm65uoSN/K245LKXl9bI5X2Az4PhSiM40rK34FHkUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcdCsumv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA7BC32781;
	Mon, 27 May 2024 14:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819392;
	bh=bBWR1oV90O3qzHRR2xLKGLcJqtq5MlX1wb+13IQv3Us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hcdCsumvh2OURTrpOviSzGnBiJjxJJewlz3b3CXi7SSGkgpwVdeNnEzTEUFaauEIN
	 td7m62++867CAueZCjH16VETpUj4heiEnvVZDH855YDiZ/kW3mf8QMqt19POFUdumf
	 zkPHlBsmzm0aWnFCvSnVDhxVKgUnA5ZuEZ7/76kHOAGoQkgj/JIZbnSC6YKAZis2XZ
	 H++jzrt8zUWsA8rucHyumjHZHfxKFLNjH/KKjcK9BtlLGgHIGiwYurTl61RonT17oF
	 0jAZbxaIISaCqlNC1ue+cWnaEpSPZW+XsTOWFFGLGNYafU//+5NJvehknlai7svFqe
	 iPeAKoUu9y6dg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 14/21] net: dsa: realtek: keep default LED state in rtl8366rb
Date: Mon, 27 May 2024 10:15:25 -0400
Message-ID: <20240527141551.3853516-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141551.3853516-1-sashal@kernel.org>
References: <20240527141551.3853516-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
Content-Transfer-Encoding: 8bit

From: Luiz Angelo Daros de Luca <luizluca@gmail.com>

[ Upstream commit 5edc6585aafefa3d44fb8a84adf241d90227f7a3 ]

This switch family supports four LEDs for each of its six ports. Each
LED group is composed of one of these four LEDs from all six ports. LED
groups can be configured to display hardware information, such as link
activity, or manually controlled through a bitmap in registers
RTL8366RB_LED_0_1_CTRL_REG and RTL8366RB_LED_2_3_CTRL_REG.

After a reset, the default LED group configuration for groups 0 to 3
indicates, respectively, link activity, link at 1000M, 100M, and 10M, or
RTL8366RB_LED_CTRL_REG as 0x5432. These configurations are commonly used
for LED indications. However, the driver was replacing that
configuration to use manually controlled LEDs (RTL8366RB_LED_FORCE)
without providing a way for the OS to control them. The default
configuration is deemed more useful than fixed, uncontrollable turned-on
LEDs.

The driver was enabling/disabling LEDs during port_enable/disable.
However, these events occur when the port is administratively controlled
(up or down) and are not related to link presence. Additionally, when a
port N was disabled, the driver was turning off all LEDs for group N,
not only the corresponding LED for port N in any of those 4 groups. In
such cases, if port 0 was brought down, the LEDs for all ports in LED
group 0 would be turned off. As another side effect, the driver was
wrongly warning that port 5 didn't have an LED ("no LED for port 5").
Since showing the administrative state of ports is not an orthodox way
to use LEDs, it was not worth it to fix it and all this code was
dropped.

The code to disable LEDs was simplified only changing each LED group to
the RTL8366RB_LED_OFF state. Registers RTL8366RB_LED_0_1_CTRL_REG and
RTL8366RB_LED_2_3_CTRL_REG are only used when the corresponding LED
group is configured with RTL8366RB_LED_FORCE and they don't need to be
cleaned. The code still references an LED controlled by
RTL8366RB_INTERRUPT_CONTROL_REG, but as of now, no test device has
actually used it. Also, some magic numbers were replaced by macros.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/realtek/rtl8366rb.c | 87 +++++++----------------------
 1 file changed, 20 insertions(+), 67 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 7868ef237f6c0..4accfec7c73e6 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -186,7 +186,12 @@
 #define RTL8366RB_LED_BLINKRATE_222MS		0x0004
 #define RTL8366RB_LED_BLINKRATE_446MS		0x0005
 
+/* LED trigger event for each group */
 #define RTL8366RB_LED_CTRL_REG			0x0431
+#define RTL8366RB_LED_CTRL_OFFSET(led_group)	\
+	(4 * (led_group))
+#define RTL8366RB_LED_CTRL_MASK(led_group)	\
+	(0xf << RTL8366RB_LED_CTRL_OFFSET(led_group))
 #define RTL8366RB_LED_OFF			0x0
 #define RTL8366RB_LED_DUP_COL			0x1
 #define RTL8366RB_LED_LINK_ACT			0x2
@@ -203,6 +208,11 @@
 #define RTL8366RB_LED_LINK_TX			0xd
 #define RTL8366RB_LED_MASTER			0xe
 #define RTL8366RB_LED_FORCE			0xf
+
+/* The RTL8366RB_LED_X_X registers are used to manually set the LED state only
+ * when the corresponding LED group in RTL8366RB_LED_CTRL_REG is
+ * RTL8366RB_LED_FORCE. Otherwise, it is ignored.
+ */
 #define RTL8366RB_LED_0_1_CTRL_REG		0x0432
 #define RTL8366RB_LED_1_OFFSET			6
 #define RTL8366RB_LED_2_3_CTRL_REG		0x0433
@@ -998,28 +1008,20 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 	 */
 	if (priv->leds_disabled) {
 		/* Turn everything off */
-		regmap_update_bits(priv->map,
-				   RTL8366RB_LED_0_1_CTRL_REG,
-				   0x0FFF, 0);
-		regmap_update_bits(priv->map,
-				   RTL8366RB_LED_2_3_CTRL_REG,
-				   0x0FFF, 0);
 		regmap_update_bits(priv->map,
 				   RTL8366RB_INTERRUPT_CONTROL_REG,
 				   RTL8366RB_P4_RGMII_LED,
 				   0);
-		val = RTL8366RB_LED_OFF;
-	} else {
-		/* TODO: make this configurable per LED */
-		val = RTL8366RB_LED_FORCE;
-	}
-	for (i = 0; i < 4; i++) {
-		ret = regmap_update_bits(priv->map,
-					 RTL8366RB_LED_CTRL_REG,
-					 0xf << (i * 4),
-					 val << (i * 4));
-		if (ret)
-			return ret;
+
+		for (i = 0; i < RTL8366RB_NUM_LEDGROUPS; i++) {
+			val = RTL8366RB_LED_OFF << RTL8366RB_LED_CTRL_OFFSET(i);
+			ret = regmap_update_bits(priv->map,
+						 RTL8366RB_LED_CTRL_REG,
+						 RTL8366RB_LED_CTRL_MASK(i),
+						 val);
+			if (ret)
+				return ret;
+		}
 	}
 
 	ret = rtl8366_reset_vlan(priv);
@@ -1134,52 +1136,6 @@ rtl8366rb_mac_link_down(struct dsa_switch *ds, int port, unsigned int mode,
 	}
 }
 
-static void rb8366rb_set_port_led(struct realtek_priv *priv,
-				  int port, bool enable)
-{
-	u16 val = enable ? 0x3f : 0;
-	int ret;
-
-	if (priv->leds_disabled)
-		return;
-
-	switch (port) {
-	case 0:
-		ret = regmap_update_bits(priv->map,
-					 RTL8366RB_LED_0_1_CTRL_REG,
-					 0x3F, val);
-		break;
-	case 1:
-		ret = regmap_update_bits(priv->map,
-					 RTL8366RB_LED_0_1_CTRL_REG,
-					 0x3F << RTL8366RB_LED_1_OFFSET,
-					 val << RTL8366RB_LED_1_OFFSET);
-		break;
-	case 2:
-		ret = regmap_update_bits(priv->map,
-					 RTL8366RB_LED_2_3_CTRL_REG,
-					 0x3F, val);
-		break;
-	case 3:
-		ret = regmap_update_bits(priv->map,
-					 RTL8366RB_LED_2_3_CTRL_REG,
-					 0x3F << RTL8366RB_LED_3_OFFSET,
-					 val << RTL8366RB_LED_3_OFFSET);
-		break;
-	case 4:
-		ret = regmap_update_bits(priv->map,
-					 RTL8366RB_INTERRUPT_CONTROL_REG,
-					 RTL8366RB_P4_RGMII_LED,
-					 enable ? RTL8366RB_P4_RGMII_LED : 0);
-		break;
-	default:
-		dev_err(priv->dev, "no LED for port %d\n", port);
-		return;
-	}
-	if (ret)
-		dev_err(priv->dev, "error updating LED on port %d\n", port);
-}
-
 static int
 rtl8366rb_port_enable(struct dsa_switch *ds, int port,
 		      struct phy_device *phy)
@@ -1193,7 +1149,6 @@ rtl8366rb_port_enable(struct dsa_switch *ds, int port,
 	if (ret)
 		return ret;
 
-	rb8366rb_set_port_led(priv, port, true);
 	return 0;
 }
 
@@ -1208,8 +1163,6 @@ rtl8366rb_port_disable(struct dsa_switch *ds, int port)
 				 BIT(port));
 	if (ret)
 		return;
-
-	rb8366rb_set_port_led(priv, port, false);
 }
 
 static int
-- 
2.43.0


