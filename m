Return-Path: <stable+bounces-40830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1328AF93C
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A8B282F37
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075611442EF;
	Tue, 23 Apr 2024 21:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s8j9bxwS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B995D143889;
	Tue, 23 Apr 2024 21:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908491; cv=none; b=X/HlK6luuJRlLYznrP6T1R9NLhqHT5zVR098rumhi+j+Qqa3vKFh1TrMlcvigTcqtIZDUIiC1uYg2iZ2eRMA37ol8kBjd+8u5hmG0vRa6Fn+te+IE5ag4kHiNPhKvQ11Qk7CIzVRc7fYHMuRb/K7rzYWEfFS2X9LiKd22d9CRuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908491; c=relaxed/simple;
	bh=/Jt0QfQga7hqeydzlkOGzl8dZeyPVeYcT4JFb1plOvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajVuFSN+0+Jaa5DJlYM++jEtycXtiITEmV8bNzanPunWQVBpppdeERnHVTnTyHwRXtEXCBPJs7D8ETOrSlf/tKTSipXxFXVN0eeqUQWqiCfIBNyxw//4eReBPU6x+644mLgO5k8BYlSPIaBm90rBcVLJBfiNv/IfrykfEamiDQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s8j9bxwS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E31EC32782;
	Tue, 23 Apr 2024 21:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908491;
	bh=/Jt0QfQga7hqeydzlkOGzl8dZeyPVeYcT4JFb1plOvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s8j9bxwS+IdjPdXRSZXcQkAfJa9K79B+hCW9hFaQKT5GfkgzgjxmGdm6wWbKcE1e0
	 guOxxluArznERk6zfCYvbU7V6Avl9VAVEbw2wKVLoX9UDaD9K2YUsHPCtReOo627Jd
	 qiGXcgx/V1ww/XkyIC9GJCbiHoD5OnItOwBCNgTg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sanath S <Sanath.S@amd.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.8 067/158] thunderbolt: Introduce tb_port_reset()
Date: Tue, 23 Apr 2024 14:38:09 -0700
Message-ID: <20240423213858.140500552@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213855.824778126@linuxfoundation.org>
References: <20240423213855.824778126@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanath S <Sanath.S@amd.com>

commit 01da6b99d49f60b1edead44e33569b1a2e9f49b7 upstream.

Introduce a function that issues Downstream Port Reset to a USB4 port.
This supports Thunderbolt 2, 3 and USB4 routers.

Signed-off-by: Sanath S <Sanath.S@amd.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/lc.c      |   45 ++++++++++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/switch.c  |    7 ++++++
 drivers/thunderbolt/tb.h      |    2 +
 drivers/thunderbolt/tb_regs.h |    4 +++
 drivers/thunderbolt/usb4.c    |   39 ++++++++++++++++++++++++++++++++++++
 5 files changed, 97 insertions(+)

--- a/drivers/thunderbolt/lc.c
+++ b/drivers/thunderbolt/lc.c
@@ -6,6 +6,8 @@
  * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
  */
 
+#include <linux/delay.h>
+
 #include "tb.h"
 
 /**
@@ -45,6 +47,49 @@ static int find_port_lc_cap(struct tb_po
 	return sw->cap_lc + start + phys * size;
 }
 
+/**
+ * tb_lc_reset_port() - Trigger downstream port reset through LC
+ * @port: Port that is reset
+ *
+ * Triggers downstream port reset through link controller registers.
+ * Returns %0 in case of success negative errno otherwise. Only supports
+ * non-USB4 routers with link controller (that's Thunderbolt 2 and
+ * Thunderbolt 3).
+ */
+int tb_lc_reset_port(struct tb_port *port)
+{
+	struct tb_switch *sw = port->sw;
+	int cap, ret;
+	u32 mode;
+
+	if (sw->generation < 2)
+		return -EINVAL;
+
+	cap = find_port_lc_cap(port);
+	if (cap < 0)
+		return cap;
+
+	ret = tb_sw_read(sw, &mode, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
+	if (ret)
+		return ret;
+
+	mode |= TB_LC_PORT_MODE_DPR;
+
+	ret = tb_sw_write(sw, &mode, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
+	if (ret)
+		return ret;
+
+	fsleep(10000);
+
+	ret = tb_sw_read(sw, &mode, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
+	if (ret)
+		return ret;
+
+	mode &= ~TB_LC_PORT_MODE_DPR;
+
+	return tb_sw_write(sw, &mode, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
+}
+
 static int tb_lc_set_port_configured(struct tb_port *port, bool configured)
 {
 	bool upstream = tb_is_upstream_port(port);
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -676,6 +676,13 @@ int tb_port_disable(struct tb_port *port
 	return __tb_port_enable(port, false);
 }
 
+static int tb_port_reset(struct tb_port *port)
+{
+	if (tb_switch_is_usb4(port->sw))
+		return port->cap_usb4 ? usb4_port_reset(port) : 0;
+	return tb_lc_reset_port(port);
+}
+
 /*
  * tb_init_port() - initialize a port
  *
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -1173,6 +1173,7 @@ int tb_drom_read(struct tb_switch *sw);
 int tb_drom_read_uid_only(struct tb_switch *sw, u64 *uid);
 
 int tb_lc_read_uuid(struct tb_switch *sw, u32 *uuid);
+int tb_lc_reset_port(struct tb_port *port);
 int tb_lc_configure_port(struct tb_port *port);
 void tb_lc_unconfigure_port(struct tb_port *port);
 int tb_lc_configure_xdomain(struct tb_port *port);
@@ -1305,6 +1306,7 @@ void usb4_switch_remove_ports(struct tb_
 
 int usb4_port_unlock(struct tb_port *port);
 int usb4_port_hotplug_enable(struct tb_port *port);
+int usb4_port_reset(struct tb_port *port);
 int usb4_port_configure(struct tb_port *port);
 void usb4_port_unconfigure(struct tb_port *port);
 int usb4_port_configure_xdomain(struct tb_port *port, struct tb_xdomain *xd);
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -389,6 +389,7 @@ struct tb_regs_port_header {
 #define PORT_CS_18_CSA				BIT(22)
 #define PORT_CS_18_TIP				BIT(24)
 #define PORT_CS_19				0x13
+#define PORT_CS_19_DPR				BIT(0)
 #define PORT_CS_19_PC				BIT(3)
 #define PORT_CS_19_PID				BIT(4)
 #define PORT_CS_19_WOC				BIT(16)
@@ -584,6 +585,9 @@ struct tb_regs_hop {
 #define TB_LC_POWER				0x740
 
 /* Link controller registers */
+#define TB_LC_PORT_MODE				0x26
+#define TB_LC_PORT_MODE_DPR			BIT(0)
+
 #define TB_LC_CS_42				0x2a
 #define TB_LC_CS_42_USB_PLUGGED			BIT(31)
 
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -1113,6 +1113,45 @@ int usb4_port_hotplug_enable(struct tb_p
 	return tb_port_write(port, &val, TB_CFG_PORT, ADP_CS_5, 1);
 }
 
+/**
+ * usb4_port_reset() - Issue downstream port reset
+ * @port: USB4 port to reset
+ *
+ * Issues downstream port reset to @port.
+ */
+int usb4_port_reset(struct tb_port *port)
+{
+	int ret;
+	u32 val;
+
+	if (!port->cap_usb4)
+		return -EINVAL;
+
+	ret = tb_port_read(port, &val, TB_CFG_PORT,
+			   port->cap_usb4 + PORT_CS_19, 1);
+	if (ret)
+		return ret;
+
+	val |= PORT_CS_19_DPR;
+
+	ret = tb_port_write(port, &val, TB_CFG_PORT,
+			    port->cap_usb4 + PORT_CS_19, 1);
+	if (ret)
+		return ret;
+
+	fsleep(10000);
+
+	ret = tb_port_read(port, &val, TB_CFG_PORT,
+			   port->cap_usb4 + PORT_CS_19, 1);
+	if (ret)
+		return ret;
+
+	val &= ~PORT_CS_19_DPR;
+
+	return tb_port_write(port, &val, TB_CFG_PORT,
+			     port->cap_usb4 + PORT_CS_19, 1);
+}
+
 static int usb4_port_set_configured(struct tb_port *port, bool configured)
 {
 	int ret;



