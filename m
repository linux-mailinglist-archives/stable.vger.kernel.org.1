Return-Path: <stable+bounces-46374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9D38D038E
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85D872A5A6A
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5D817997A;
	Mon, 27 May 2024 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNXId8Oc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353C917967A;
	Mon, 27 May 2024 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819299; cv=none; b=iefDUSJUcSp3dsE6T53OVNuDHP8wt+2yFokF5AhZHt+gMz10LoLhXp+ka7sRjv16qIFW9NGmR/q0pxla52pwwl/m0SSnIkXBiCERGZN0g+ztp+hYTN1WfvMrj9WVx0hOyh3g8nvv2C561bSGgvMD3AUjqimAjgFNBsP3O7WzIwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819299; c=relaxed/simple;
	bh=XniSZaceh5RFPJfvfIIlb+sEa2AMpBB45Vf8zq5nxHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfW4H1xaRZIkB2O56lVJfN4UcUDo1fkbq6j1rcS8zMEmMXqjfAHOvYST+tICxQ0aTFYPlFWwGvPIKs19vyeeD6h3xpFbGkVybd/s/1zVjOiq4dAt+G8BDAOVRdb+9IH3MCvpvPYAwbGpUQ4WWXaEl3Mc57a/o0116+8J9VnPsY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNXId8Oc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9732BC4AF08;
	Mon, 27 May 2024 14:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819299;
	bh=XniSZaceh5RFPJfvfIIlb+sEa2AMpBB45Vf8zq5nxHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KNXId8OcpL3rN8MUGfeW/ZAK8zr/BNNjxffTAvpeRTKRpZ7KY9Qa6NpjswTsvkzhm
	 GO4kDNmD32r1XtcnqU7JK7to60k9z0Y1ew/cdiXMFFjGwNyXBfBgsVRQ5NfN7dnpgP
	 pb5c6sOAze+RvJxaUYb6Sd3N5wjspUYoGNly6nAFoWy8ersgKvAnLoLLUy9k3SdGPj
	 s7P78t5WLFKtb8i3D3K7fh8UBMxMEU4pErVDIO5rcEVBdi31I1IRlgW35h268kfuy0
	 uDetif0i87JvUM+OEUsc5nTC5Y7JfvuMuwEi7nMiTm2rnG1N6aUNDeL8dF1IgsNtDd
	 VoFft7kHZGfNQ==
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
Subject: [PATCH AUTOSEL 6.8 19/30] net: dsa: realtek: keep default LED state in rtl8366rb
Date: Mon, 27 May 2024 10:13:28 -0400
Message-ID: <20240527141406.3852821-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141406.3852821-1-sashal@kernel.org>
References: <20240527141406.3852821-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
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
index e3b6a470ca67f..874e04cf2e0d2 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -182,7 +182,12 @@
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
@@ -199,6 +204,11 @@
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
@@ -1166,52 +1168,6 @@ rtl8366rb_mac_link_down(struct dsa_switch *ds, int port, unsigned int mode,
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
@@ -1225,7 +1181,6 @@ rtl8366rb_port_enable(struct dsa_switch *ds, int port,
 	if (ret)
 		return ret;
 
-	rb8366rb_set_port_led(priv, port, true);
 	return 0;
 }
 
@@ -1240,8 +1195,6 @@ rtl8366rb_port_disable(struct dsa_switch *ds, int port)
 				 BIT(port));
 	if (ret)
 		return;
-
-	rb8366rb_set_port_led(priv, port, false);
 }
 
 static int
-- 
2.43.0


