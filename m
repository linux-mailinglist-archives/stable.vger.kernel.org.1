Return-Path: <stable+bounces-120808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CB0A5086D
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2264E3A7449
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C5B19C542;
	Wed,  5 Mar 2025 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hNEUHBhs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FE71ACEDD;
	Wed,  5 Mar 2025 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198033; cv=none; b=Gs3XgVCfC3CFfcuk6NjfCfQEntdd8nEeKCJCiYNHMco5+mqCPnBxQxWtP9SfqOuXGKN9+9YFztwnqaiyhGC1OAIZ+agsIwPZzVz4xHsKTYl3AuGIGaCIZle2k7s4cvis39Ky5GHr+83ZPhZc0n3iUe9gHgIs8TV3iVikIafqSWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198033; c=relaxed/simple;
	bh=DG23MJKy+HQIZ5hONTkoZgLXbK+56bvBCw4BHAWBp5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGO7lVWC5GomnPyp40zNrOKHvRrbpwXJ3c0n+RbQ/08xb0omeUKxVCIUFsRRqpNkyM0XeDLMP8dLeYU93oH4jfomeFFlbURYZp2fn2B93PCMJK83XotwvVj2B+uHS+h000+Gnf2iDvlpVqCoECRqpCfjiQy5pDLG2pfZ1QXW1UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hNEUHBhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5F6C4CED1;
	Wed,  5 Mar 2025 18:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741198032;
	bh=DG23MJKy+HQIZ5hONTkoZgLXbK+56bvBCw4BHAWBp5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hNEUHBhsDSr9J2FmTaJpmjsoT/7MM3v81Y6qegdreB+eL4JcqCvK6pWwXqjXW5Qqb
	 JAEjbXlvk0JjngYEt/aC+UYP+Y8sDJOelf3ZgD6N6tw1mx3vYilmx4nY71EgsDCcYp
	 7WagyldDMif1TNd9umj1NggocJ1eXQhuhW36qcNU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 040/150] net: dsa: rtl8366rb: Fix compilation problem
Date: Wed,  5 Mar 2025 18:47:49 +0100
Message-ID: <20250305174505.428634640@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174503.801402104@linuxfoundation.org>
References: <20250305174503.801402104@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit f15176b8b6e72ac30e14fd273282d2b72562d26b ]

When the kernel is compiled without LED framework support the
rtl8366rb fails to build like this:

rtl8366rb.o: in function `rtl8366rb_setup_led':
rtl8366rb.c:953:(.text.unlikely.rtl8366rb_setup_led+0xe8):
  undefined reference to `led_init_default_state_get'
rtl8366rb.c:980:(.text.unlikely.rtl8366rb_setup_led+0x240):
  undefined reference to `devm_led_classdev_register_ext'

As this is constantly coming up in different randconfig builds,
bite the bullet and create a separate file for the offending
code, split out a header with all stuff needed both in the
core driver and the leds code.

Add a new bool Kconfig option for the LED compile target, such
that it depends on LEDS_CLASS=y || LEDS_CLASS=RTL8366RB
which make LED support always available when LEDS_CLASS is
compiled into the kernel and enforce that if the LEDS_CLASS
is a module, then the RTL8366RB driver needs to be a module
as well so that modprobe can resolve the dependencies.

Fixes: 32d617005475 ("net: dsa: realtek: add LED drivers for rtl8366rb")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502070525.xMUImayb-lkp@intel.com/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/realtek/Kconfig          |   6 +
 drivers/net/dsa/realtek/Makefile         |   3 +
 drivers/net/dsa/realtek/rtl8366rb-leds.c | 177 ++++++++++++++++
 drivers/net/dsa/realtek/rtl8366rb.c      | 258 +----------------------
 drivers/net/dsa/realtek/rtl8366rb.h      | 107 ++++++++++
 5 files changed, 299 insertions(+), 252 deletions(-)
 create mode 100644 drivers/net/dsa/realtek/rtl8366rb-leds.c
 create mode 100644 drivers/net/dsa/realtek/rtl8366rb.h

diff --git a/drivers/net/dsa/realtek/Kconfig b/drivers/net/dsa/realtek/Kconfig
index 6989972eebc30..10687722d14c0 100644
--- a/drivers/net/dsa/realtek/Kconfig
+++ b/drivers/net/dsa/realtek/Kconfig
@@ -43,4 +43,10 @@ config NET_DSA_REALTEK_RTL8366RB
 	help
 	  Select to enable support for Realtek RTL8366RB.
 
+config NET_DSA_REALTEK_RTL8366RB_LEDS
+	bool "Support RTL8366RB LED control"
+	depends on (LEDS_CLASS=y || LEDS_CLASS=NET_DSA_REALTEK_RTL8366RB)
+	depends on NET_DSA_REALTEK_RTL8366RB
+	default NET_DSA_REALTEK_RTL8366RB
+
 endif
diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index 35491dc20d6d6..17367bcba496c 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -12,4 +12,7 @@ endif
 
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
 rtl8366-objs 				:= rtl8366-core.o rtl8366rb.o
+ifdef CONFIG_NET_DSA_REALTEK_RTL8366RB_LEDS
+rtl8366-objs 				+= rtl8366rb-leds.o
+endif
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
diff --git a/drivers/net/dsa/realtek/rtl8366rb-leds.c b/drivers/net/dsa/realtek/rtl8366rb-leds.c
new file mode 100644
index 0000000000000..99c890681ae60
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8366rb-leds.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bitops.h>
+#include <linux/regmap.h>
+#include <net/dsa.h>
+#include "rtl83xx.h"
+#include "rtl8366rb.h"
+
+static inline u32 rtl8366rb_led_group_port_mask(u8 led_group, u8 port)
+{
+	switch (led_group) {
+	case 0:
+		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
+	case 1:
+		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
+	case 2:
+		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
+	case 3:
+		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
+	default:
+		return 0;
+	}
+}
+
+static int rb8366rb_get_port_led(struct rtl8366rb_led *led)
+{
+	struct realtek_priv *priv = led->priv;
+	u8 led_group = led->led_group;
+	u8 port_num = led->port_num;
+	int ret;
+	u32 val;
+
+	ret = regmap_read(priv->map, RTL8366RB_LED_X_X_CTRL_REG(led_group),
+			  &val);
+	if (ret) {
+		dev_err(priv->dev, "error reading LED on port %d group %d\n",
+			led_group, port_num);
+		return ret;
+	}
+
+	return !!(val & rtl8366rb_led_group_port_mask(led_group, port_num));
+}
+
+static int rb8366rb_set_port_led(struct rtl8366rb_led *led, bool enable)
+{
+	struct realtek_priv *priv = led->priv;
+	u8 led_group = led->led_group;
+	u8 port_num = led->port_num;
+	int ret;
+
+	ret = regmap_update_bits(priv->map,
+				 RTL8366RB_LED_X_X_CTRL_REG(led_group),
+				 rtl8366rb_led_group_port_mask(led_group,
+							       port_num),
+				 enable ? 0xffff : 0);
+	if (ret) {
+		dev_err(priv->dev, "error updating LED on port %d group %d\n",
+			led_group, port_num);
+		return ret;
+	}
+
+	/* Change the LED group to manual controlled LEDs if required */
+	ret = rb8366rb_set_ledgroup_mode(priv, led_group,
+					 RTL8366RB_LEDGROUP_FORCE);
+
+	if (ret) {
+		dev_err(priv->dev, "error updating LED GROUP group %d\n",
+			led_group);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int
+rtl8366rb_cled_brightness_set_blocking(struct led_classdev *ldev,
+				       enum led_brightness brightness)
+{
+	struct rtl8366rb_led *led = container_of(ldev, struct rtl8366rb_led,
+						 cdev);
+
+	return rb8366rb_set_port_led(led, brightness == LED_ON);
+}
+
+static int rtl8366rb_setup_led(struct realtek_priv *priv, struct dsa_port *dp,
+			       struct fwnode_handle *led_fwnode)
+{
+	struct rtl8366rb *rb = priv->chip_data;
+	struct led_init_data init_data = { };
+	enum led_default_state state;
+	struct rtl8366rb_led *led;
+	u32 led_group;
+	int ret;
+
+	ret = fwnode_property_read_u32(led_fwnode, "reg", &led_group);
+	if (ret)
+		return ret;
+
+	if (led_group >= RTL8366RB_NUM_LEDGROUPS) {
+		dev_warn(priv->dev, "Invalid LED reg %d defined for port %d",
+			 led_group, dp->index);
+		return -EINVAL;
+	}
+
+	led = &rb->leds[dp->index][led_group];
+	led->port_num = dp->index;
+	led->led_group = led_group;
+	led->priv = priv;
+
+	state = led_init_default_state_get(led_fwnode);
+	switch (state) {
+	case LEDS_DEFSTATE_ON:
+		led->cdev.brightness = 1;
+		rb8366rb_set_port_led(led, 1);
+		break;
+	case LEDS_DEFSTATE_KEEP:
+		led->cdev.brightness =
+			rb8366rb_get_port_led(led);
+		break;
+	case LEDS_DEFSTATE_OFF:
+	default:
+		led->cdev.brightness = 0;
+		rb8366rb_set_port_led(led, 0);
+	}
+
+	led->cdev.max_brightness = 1;
+	led->cdev.brightness_set_blocking =
+		rtl8366rb_cled_brightness_set_blocking;
+	init_data.fwnode = led_fwnode;
+	init_data.devname_mandatory = true;
+
+	init_data.devicename = kasprintf(GFP_KERNEL, "Realtek-%d:0%d:%d",
+					 dp->ds->index, dp->index, led_group);
+	if (!init_data.devicename)
+		return -ENOMEM;
+
+	ret = devm_led_classdev_register_ext(priv->dev, &led->cdev, &init_data);
+	if (ret) {
+		dev_warn(priv->dev, "Failed to init LED %d for port %d",
+			 led_group, dp->index);
+		return ret;
+	}
+
+	return 0;
+}
+
+int rtl8366rb_setup_leds(struct realtek_priv *priv)
+{
+	struct dsa_switch *ds = &priv->ds;
+	struct device_node *leds_np;
+	struct dsa_port *dp;
+	int ret = 0;
+
+	dsa_switch_for_each_port(dp, ds) {
+		if (!dp->dn)
+			continue;
+
+		leds_np = of_get_child_by_name(dp->dn, "leds");
+		if (!leds_np) {
+			dev_dbg(priv->dev, "No leds defined for port %d",
+				dp->index);
+			continue;
+		}
+
+		for_each_child_of_node_scoped(leds_np, led_np) {
+			ret = rtl8366rb_setup_led(priv, dp,
+						  of_fwnode_handle(led_np));
+			if (ret)
+				break;
+		}
+
+		of_node_put(leds_np);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index c7a8cd0605878..ae3d49fc22b80 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -26,11 +26,7 @@
 #include "realtek-smi.h"
 #include "realtek-mdio.h"
 #include "rtl83xx.h"
-
-#define RTL8366RB_PORT_NUM_CPU		5
-#define RTL8366RB_NUM_PORTS		6
-#define RTL8366RB_PHY_NO_MAX		4
-#define RTL8366RB_PHY_ADDR_MAX		31
+#include "rtl8366rb.h"
 
 /* Switch Global Configuration register */
 #define RTL8366RB_SGCR				0x0000
@@ -175,39 +171,6 @@
  */
 #define RTL8366RB_VLAN_INGRESS_CTRL2_REG	0x037f
 
-/* LED control registers */
-/* The LED blink rate is global; it is used by all triggers in all groups. */
-#define RTL8366RB_LED_BLINKRATE_REG		0x0430
-#define RTL8366RB_LED_BLINKRATE_MASK		0x0007
-#define RTL8366RB_LED_BLINKRATE_28MS		0x0000
-#define RTL8366RB_LED_BLINKRATE_56MS		0x0001
-#define RTL8366RB_LED_BLINKRATE_84MS		0x0002
-#define RTL8366RB_LED_BLINKRATE_111MS		0x0003
-#define RTL8366RB_LED_BLINKRATE_222MS		0x0004
-#define RTL8366RB_LED_BLINKRATE_446MS		0x0005
-
-/* LED trigger event for each group */
-#define RTL8366RB_LED_CTRL_REG			0x0431
-#define RTL8366RB_LED_CTRL_OFFSET(led_group)	\
-	(4 * (led_group))
-#define RTL8366RB_LED_CTRL_MASK(led_group)	\
-	(0xf << RTL8366RB_LED_CTRL_OFFSET(led_group))
-
-/* The RTL8366RB_LED_X_X registers are used to manually set the LED state only
- * when the corresponding LED group in RTL8366RB_LED_CTRL_REG is
- * RTL8366RB_LEDGROUP_FORCE. Otherwise, it is ignored.
- */
-#define RTL8366RB_LED_0_1_CTRL_REG		0x0432
-#define RTL8366RB_LED_2_3_CTRL_REG		0x0433
-#define RTL8366RB_LED_X_X_CTRL_REG(led_group)	\
-	((led_group) <= 1 ? \
-		RTL8366RB_LED_0_1_CTRL_REG : \
-		RTL8366RB_LED_2_3_CTRL_REG)
-#define RTL8366RB_LED_0_X_CTRL_MASK		GENMASK(5, 0)
-#define RTL8366RB_LED_X_1_CTRL_MASK		GENMASK(11, 6)
-#define RTL8366RB_LED_2_X_CTRL_MASK		GENMASK(5, 0)
-#define RTL8366RB_LED_X_3_CTRL_MASK		GENMASK(11, 6)
-
 #define RTL8366RB_MIB_COUNT			33
 #define RTL8366RB_GLOBAL_MIB_COUNT		1
 #define RTL8366RB_MIB_COUNTER_PORT_OFFSET	0x0050
@@ -243,7 +206,6 @@
 #define RTL8366RB_PORT_STATUS_AN_MASK		0x0080
 
 #define RTL8366RB_NUM_VLANS		16
-#define RTL8366RB_NUM_LEDGROUPS		4
 #define RTL8366RB_NUM_VIDS		4096
 #define RTL8366RB_PRIORITYMAX		7
 #define RTL8366RB_NUM_FIDS		8
@@ -350,46 +312,6 @@
 #define RTL8366RB_GREEN_FEATURE_TX	BIT(0)
 #define RTL8366RB_GREEN_FEATURE_RX	BIT(2)
 
-enum rtl8366_ledgroup_mode {
-	RTL8366RB_LEDGROUP_OFF			= 0x0,
-	RTL8366RB_LEDGROUP_DUP_COL		= 0x1,
-	RTL8366RB_LEDGROUP_LINK_ACT		= 0x2,
-	RTL8366RB_LEDGROUP_SPD1000		= 0x3,
-	RTL8366RB_LEDGROUP_SPD100		= 0x4,
-	RTL8366RB_LEDGROUP_SPD10		= 0x5,
-	RTL8366RB_LEDGROUP_SPD1000_ACT		= 0x6,
-	RTL8366RB_LEDGROUP_SPD100_ACT		= 0x7,
-	RTL8366RB_LEDGROUP_SPD10_ACT		= 0x8,
-	RTL8366RB_LEDGROUP_SPD100_10_ACT	= 0x9,
-	RTL8366RB_LEDGROUP_FIBER		= 0xa,
-	RTL8366RB_LEDGROUP_AN_FAULT		= 0xb,
-	RTL8366RB_LEDGROUP_LINK_RX		= 0xc,
-	RTL8366RB_LEDGROUP_LINK_TX		= 0xd,
-	RTL8366RB_LEDGROUP_MASTER		= 0xe,
-	RTL8366RB_LEDGROUP_FORCE		= 0xf,
-
-	__RTL8366RB_LEDGROUP_MODE_MAX
-};
-
-struct rtl8366rb_led {
-	u8 port_num;
-	u8 led_group;
-	struct realtek_priv *priv;
-	struct led_classdev cdev;
-};
-
-/**
- * struct rtl8366rb - RTL8366RB-specific data
- * @max_mtu: per-port max MTU setting
- * @pvid_enabled: if PVID is set for respective port
- * @leds: per-port and per-ledgroup led info
- */
-struct rtl8366rb {
-	unsigned int max_mtu[RTL8366RB_NUM_PORTS];
-	bool pvid_enabled[RTL8366RB_NUM_PORTS];
-	struct rtl8366rb_led leds[RTL8366RB_NUM_PORTS][RTL8366RB_NUM_LEDGROUPS];
-};
-
 static struct rtl8366_mib_counter rtl8366rb_mib_counters[] = {
 	{ 0,  0, 4, "IfInOctets"				},
 	{ 0,  4, 4, "EtherStatsOctets"				},
@@ -830,9 +752,10 @@ static int rtl8366rb_jam_table(const struct rtl8366rb_jam_tbl_entry *jam_table,
 	return 0;
 }
 
-static int rb8366rb_set_ledgroup_mode(struct realtek_priv *priv,
-				      u8 led_group,
-				      enum rtl8366_ledgroup_mode mode)
+/* This code is used also with LEDs disabled */
+int rb8366rb_set_ledgroup_mode(struct realtek_priv *priv,
+			       u8 led_group,
+			       enum rtl8366_ledgroup_mode mode)
 {
 	int ret;
 	u32 val;
@@ -849,144 +772,7 @@ static int rb8366rb_set_ledgroup_mode(struct realtek_priv *priv,
 	return 0;
 }
 
-static inline u32 rtl8366rb_led_group_port_mask(u8 led_group, u8 port)
-{
-	switch (led_group) {
-	case 0:
-		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
-	case 1:
-		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
-	case 2:
-		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
-	case 3:
-		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
-	default:
-		return 0;
-	}
-}
-
-static int rb8366rb_get_port_led(struct rtl8366rb_led *led)
-{
-	struct realtek_priv *priv = led->priv;
-	u8 led_group = led->led_group;
-	u8 port_num = led->port_num;
-	int ret;
-	u32 val;
-
-	ret = regmap_read(priv->map, RTL8366RB_LED_X_X_CTRL_REG(led_group),
-			  &val);
-	if (ret) {
-		dev_err(priv->dev, "error reading LED on port %d group %d\n",
-			led_group, port_num);
-		return ret;
-	}
-
-	return !!(val & rtl8366rb_led_group_port_mask(led_group, port_num));
-}
-
-static int rb8366rb_set_port_led(struct rtl8366rb_led *led, bool enable)
-{
-	struct realtek_priv *priv = led->priv;
-	u8 led_group = led->led_group;
-	u8 port_num = led->port_num;
-	int ret;
-
-	ret = regmap_update_bits(priv->map,
-				 RTL8366RB_LED_X_X_CTRL_REG(led_group),
-				 rtl8366rb_led_group_port_mask(led_group,
-							       port_num),
-				 enable ? 0xffff : 0);
-	if (ret) {
-		dev_err(priv->dev, "error updating LED on port %d group %d\n",
-			led_group, port_num);
-		return ret;
-	}
-
-	/* Change the LED group to manual controlled LEDs if required */
-	ret = rb8366rb_set_ledgroup_mode(priv, led_group,
-					 RTL8366RB_LEDGROUP_FORCE);
-
-	if (ret) {
-		dev_err(priv->dev, "error updating LED GROUP group %d\n",
-			led_group);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int
-rtl8366rb_cled_brightness_set_blocking(struct led_classdev *ldev,
-				       enum led_brightness brightness)
-{
-	struct rtl8366rb_led *led = container_of(ldev, struct rtl8366rb_led,
-						 cdev);
-
-	return rb8366rb_set_port_led(led, brightness == LED_ON);
-}
-
-static int rtl8366rb_setup_led(struct realtek_priv *priv, struct dsa_port *dp,
-			       struct fwnode_handle *led_fwnode)
-{
-	struct rtl8366rb *rb = priv->chip_data;
-	struct led_init_data init_data = { };
-	enum led_default_state state;
-	struct rtl8366rb_led *led;
-	u32 led_group;
-	int ret;
-
-	ret = fwnode_property_read_u32(led_fwnode, "reg", &led_group);
-	if (ret)
-		return ret;
-
-	if (led_group >= RTL8366RB_NUM_LEDGROUPS) {
-		dev_warn(priv->dev, "Invalid LED reg %d defined for port %d",
-			 led_group, dp->index);
-		return -EINVAL;
-	}
-
-	led = &rb->leds[dp->index][led_group];
-	led->port_num = dp->index;
-	led->led_group = led_group;
-	led->priv = priv;
-
-	state = led_init_default_state_get(led_fwnode);
-	switch (state) {
-	case LEDS_DEFSTATE_ON:
-		led->cdev.brightness = 1;
-		rb8366rb_set_port_led(led, 1);
-		break;
-	case LEDS_DEFSTATE_KEEP:
-		led->cdev.brightness =
-			rb8366rb_get_port_led(led);
-		break;
-	case LEDS_DEFSTATE_OFF:
-	default:
-		led->cdev.brightness = 0;
-		rb8366rb_set_port_led(led, 0);
-	}
-
-	led->cdev.max_brightness = 1;
-	led->cdev.brightness_set_blocking =
-		rtl8366rb_cled_brightness_set_blocking;
-	init_data.fwnode = led_fwnode;
-	init_data.devname_mandatory = true;
-
-	init_data.devicename = kasprintf(GFP_KERNEL, "Realtek-%d:0%d:%d",
-					 dp->ds->index, dp->index, led_group);
-	if (!init_data.devicename)
-		return -ENOMEM;
-
-	ret = devm_led_classdev_register_ext(priv->dev, &led->cdev, &init_data);
-	if (ret) {
-		dev_warn(priv->dev, "Failed to init LED %d for port %d",
-			 led_group, dp->index);
-		return ret;
-	}
-
-	return 0;
-}
-
+/* This code is used also with LEDs disabled */
 static int rtl8366rb_setup_all_leds_off(struct realtek_priv *priv)
 {
 	int ret = 0;
@@ -1007,38 +793,6 @@ static int rtl8366rb_setup_all_leds_off(struct realtek_priv *priv)
 	return ret;
 }
 
-static int rtl8366rb_setup_leds(struct realtek_priv *priv)
-{
-	struct dsa_switch *ds = &priv->ds;
-	struct device_node *leds_np;
-	struct dsa_port *dp;
-	int ret = 0;
-
-	dsa_switch_for_each_port(dp, ds) {
-		if (!dp->dn)
-			continue;
-
-		leds_np = of_get_child_by_name(dp->dn, "leds");
-		if (!leds_np) {
-			dev_dbg(priv->dev, "No leds defined for port %d",
-				dp->index);
-			continue;
-		}
-
-		for_each_child_of_node_scoped(leds_np, led_np) {
-			ret = rtl8366rb_setup_led(priv, dp,
-						  of_fwnode_handle(led_np));
-			if (ret)
-				break;
-		}
-
-		of_node_put(leds_np);
-		if (ret)
-			return ret;
-	}
-	return 0;
-}
-
 static int rtl8366rb_setup(struct dsa_switch *ds)
 {
 	struct realtek_priv *priv = ds->priv;
diff --git a/drivers/net/dsa/realtek/rtl8366rb.h b/drivers/net/dsa/realtek/rtl8366rb.h
new file mode 100644
index 0000000000000..685ff3275faa1
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8366rb.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _RTL8366RB_H
+#define _RTL8366RB_H
+
+#include "realtek.h"
+
+#define RTL8366RB_PORT_NUM_CPU		5
+#define RTL8366RB_NUM_PORTS		6
+#define RTL8366RB_PHY_NO_MAX		4
+#define RTL8366RB_NUM_LEDGROUPS		4
+#define RTL8366RB_PHY_ADDR_MAX		31
+
+/* LED control registers */
+/* The LED blink rate is global; it is used by all triggers in all groups. */
+#define RTL8366RB_LED_BLINKRATE_REG		0x0430
+#define RTL8366RB_LED_BLINKRATE_MASK		0x0007
+#define RTL8366RB_LED_BLINKRATE_28MS		0x0000
+#define RTL8366RB_LED_BLINKRATE_56MS		0x0001
+#define RTL8366RB_LED_BLINKRATE_84MS		0x0002
+#define RTL8366RB_LED_BLINKRATE_111MS		0x0003
+#define RTL8366RB_LED_BLINKRATE_222MS		0x0004
+#define RTL8366RB_LED_BLINKRATE_446MS		0x0005
+
+/* LED trigger event for each group */
+#define RTL8366RB_LED_CTRL_REG			0x0431
+#define RTL8366RB_LED_CTRL_OFFSET(led_group)	\
+	(4 * (led_group))
+#define RTL8366RB_LED_CTRL_MASK(led_group)	\
+	(0xf << RTL8366RB_LED_CTRL_OFFSET(led_group))
+
+/* The RTL8366RB_LED_X_X registers are used to manually set the LED state only
+ * when the corresponding LED group in RTL8366RB_LED_CTRL_REG is
+ * RTL8366RB_LEDGROUP_FORCE. Otherwise, it is ignored.
+ */
+#define RTL8366RB_LED_0_1_CTRL_REG		0x0432
+#define RTL8366RB_LED_2_3_CTRL_REG		0x0433
+#define RTL8366RB_LED_X_X_CTRL_REG(led_group)	\
+	((led_group) <= 1 ? \
+		RTL8366RB_LED_0_1_CTRL_REG : \
+		RTL8366RB_LED_2_3_CTRL_REG)
+#define RTL8366RB_LED_0_X_CTRL_MASK		GENMASK(5, 0)
+#define RTL8366RB_LED_X_1_CTRL_MASK		GENMASK(11, 6)
+#define RTL8366RB_LED_2_X_CTRL_MASK		GENMASK(5, 0)
+#define RTL8366RB_LED_X_3_CTRL_MASK		GENMASK(11, 6)
+
+enum rtl8366_ledgroup_mode {
+	RTL8366RB_LEDGROUP_OFF			= 0x0,
+	RTL8366RB_LEDGROUP_DUP_COL		= 0x1,
+	RTL8366RB_LEDGROUP_LINK_ACT		= 0x2,
+	RTL8366RB_LEDGROUP_SPD1000		= 0x3,
+	RTL8366RB_LEDGROUP_SPD100		= 0x4,
+	RTL8366RB_LEDGROUP_SPD10		= 0x5,
+	RTL8366RB_LEDGROUP_SPD1000_ACT		= 0x6,
+	RTL8366RB_LEDGROUP_SPD100_ACT		= 0x7,
+	RTL8366RB_LEDGROUP_SPD10_ACT		= 0x8,
+	RTL8366RB_LEDGROUP_SPD100_10_ACT	= 0x9,
+	RTL8366RB_LEDGROUP_FIBER		= 0xa,
+	RTL8366RB_LEDGROUP_AN_FAULT		= 0xb,
+	RTL8366RB_LEDGROUP_LINK_RX		= 0xc,
+	RTL8366RB_LEDGROUP_LINK_TX		= 0xd,
+	RTL8366RB_LEDGROUP_MASTER		= 0xe,
+	RTL8366RB_LEDGROUP_FORCE		= 0xf,
+
+	__RTL8366RB_LEDGROUP_MODE_MAX
+};
+
+#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8366RB_LEDS)
+
+struct rtl8366rb_led {
+	u8 port_num;
+	u8 led_group;
+	struct realtek_priv *priv;
+	struct led_classdev cdev;
+};
+
+int rtl8366rb_setup_leds(struct realtek_priv *priv);
+
+#else
+
+static inline int rtl8366rb_setup_leds(struct realtek_priv *priv)
+{
+	return 0;
+}
+
+#endif /* IS_ENABLED(CONFIG_LEDS_CLASS) */
+
+/**
+ * struct rtl8366rb - RTL8366RB-specific data
+ * @max_mtu: per-port max MTU setting
+ * @pvid_enabled: if PVID is set for respective port
+ * @leds: per-port and per-ledgroup led info
+ */
+struct rtl8366rb {
+	unsigned int max_mtu[RTL8366RB_NUM_PORTS];
+	bool pvid_enabled[RTL8366RB_NUM_PORTS];
+#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8366RB_LEDS)
+	struct rtl8366rb_led leds[RTL8366RB_NUM_PORTS][RTL8366RB_NUM_LEDGROUPS];
+#endif
+};
+
+/* This code is used also with LEDs disabled */
+int rb8366rb_set_ledgroup_mode(struct realtek_priv *priv,
+			       u8 led_group,
+			       enum rtl8366_ledgroup_mode mode);
+
+#endif /* _RTL8366RB_H */
-- 
2.39.5




