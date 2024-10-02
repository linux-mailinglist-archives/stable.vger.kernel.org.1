Return-Path: <stable+bounces-80514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1610598DDCA
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920BA1F26258
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4F41D0F40;
	Wed,  2 Oct 2024 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WBqlYlD3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6541D0B87;
	Wed,  2 Oct 2024 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880594; cv=none; b=a0aJDH04e3kRe8w8kVDIf/T6Z6hQGBM1XFNHD6++Izzy0sqs7nbJ0gHzbZxM84QeS8HBUXNKfJpZUHZlg11dpfonxknv9j7HG65+fUbxG3Agfa8AL2bNlH2bvnSRMKzoosoWwQQydxj9Lw3nOJiI7BCszTMOAz4jQLuU9F8IOps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880594; c=relaxed/simple;
	bh=5TQnQrdu+WSrGUhfv6YvB4te6a6c4c48BQeAtTg37Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gi90tk+R8LDyjQNhgQbj+HyJv4iM8DDvgGsBbMtprJRzyHLWEeaa85ThuL75ckx2MK+4kl0Z8W7s3Hf6sF2dELSj64MuIj3943nlh9phRrKNo9rqhwxvJOd/wedF3BSPFcyo1kagWi/LTkhU+KRXdga3oWcOTW6TbiKyXcbPmqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WBqlYlD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5562AC4CEC2;
	Wed,  2 Oct 2024 14:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727880594;
	bh=5TQnQrdu+WSrGUhfv6YvB4te6a6c4c48BQeAtTg37Yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WBqlYlD3+0FXbsQlQCEZo4338B7iphoTkh7NfnWD8YTLm5cp71qJIu/CLTrA7TZRP
	 ohX/d141ynws/ZNrB+p8WQAhtafLWl0JuHbJb7NbZH+fCMi/tMM9wr4sKQL529gGRo
	 GBurdFLl9gTq1mznVbanIH20In1h8eTMTTNptj7U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gil Fine <gil.fine@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Qin Wan <qin.wan@hp.com>,
	Alexandru Gagniuc <alexandru.gagniuc@hp.com>
Subject: [PATCH 6.6 513/538] thunderbolt: Add support for asymmetric link
Date: Wed,  2 Oct 2024 15:02:32 +0200
Message-ID: <20241002125812.691765274@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gil Fine <gil.fine@linux.intel.com>

[ Upstream commit 81af2952e60603d12415e1a6fd200f8073a2ad8b ]

USB4 v2 spec defines a Gen 4 link that can operate as an aggregated
symmetric (80/80G) or asymmetric (120/40G). When the link is asymmetric,
the USB4 port on one side of the link operates with three TX lanes and
one RX lane, while the USB4 port on the opposite side of the link
operates with three RX lanes and one TX lane.

Add support for the asymmetric link and provide functions that can be
used to transition the link to asymmetric and back.

Signed-off-by: Gil Fine <gil.fine@linux.intel.com>
Co-developed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Qin Wan <qin.wan@hp.com>
Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/switch.c  |  294 ++++++++++++++++++++++++++++++++++++------
 drivers/thunderbolt/tb.c      |   11 +
 drivers/thunderbolt/tb.h      |   16 +-
 drivers/thunderbolt/tb_regs.h |    9 +
 drivers/thunderbolt/usb4.c    |  106 +++++++++++++++
 5 files changed, 381 insertions(+), 55 deletions(-)

--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -947,6 +947,22 @@ int tb_port_get_link_generation(struct t
 	}
 }
 
+static const char *width_name(enum tb_link_width width)
+{
+	switch (width) {
+	case TB_LINK_WIDTH_SINGLE:
+		return "symmetric, single lane";
+	case TB_LINK_WIDTH_DUAL:
+		return "symmetric, dual lanes";
+	case TB_LINK_WIDTH_ASYM_TX:
+		return "asymmetric, 3 transmitters, 1 receiver";
+	case TB_LINK_WIDTH_ASYM_RX:
+		return "asymmetric, 3 receivers, 1 transmitter";
+	default:
+		return "unknown";
+	}
+}
+
 /**
  * tb_port_get_link_width() - Get current link width
  * @port: Port to check (USB4 or CIO)
@@ -972,8 +988,15 @@ int tb_port_get_link_width(struct tb_por
 		LANE_ADP_CS_1_CURRENT_WIDTH_SHIFT;
 }
 
-static bool tb_port_is_width_supported(struct tb_port *port,
-				       unsigned int width_mask)
+/**
+ * tb_port_width_supported() - Is the given link width supported
+ * @port: Port to check
+ * @width: Widths to check (bitmask)
+ *
+ * Can be called to any lane adapter. Checks if given @width is
+ * supported by the hardware and returns %true if it is.
+ */
+bool tb_port_width_supported(struct tb_port *port, unsigned int width)
 {
 	u32 phy, widths;
 	int ret;
@@ -981,15 +1004,23 @@ static bool tb_port_is_width_supported(s
 	if (!port->cap_phy)
 		return false;
 
+	if (width & (TB_LINK_WIDTH_ASYM_TX | TB_LINK_WIDTH_ASYM_RX)) {
+		if (tb_port_get_link_generation(port) < 4 ||
+		    !usb4_port_asym_supported(port))
+			return false;
+	}
+
 	ret = tb_port_read(port, &phy, TB_CFG_PORT,
 			   port->cap_phy + LANE_ADP_CS_0, 1);
 	if (ret)
 		return false;
 
-	widths = (phy & LANE_ADP_CS_0_SUPPORTED_WIDTH_MASK) >>
-		LANE_ADP_CS_0_SUPPORTED_WIDTH_SHIFT;
-
-	return widths & width_mask;
+	/*
+	 * The field encoding is the same as &enum tb_link_width (which is
+	 * passed to @width).
+	 */
+	widths = FIELD_GET(LANE_ADP_CS_0_SUPPORTED_WIDTH_MASK, phy);
+	return widths & width;
 }
 
 /**
@@ -1024,10 +1055,18 @@ int tb_port_set_link_width(struct tb_por
 		val |= LANE_ADP_CS_1_TARGET_WIDTH_SINGLE <<
 			LANE_ADP_CS_1_TARGET_WIDTH_SHIFT;
 		break;
+
 	case TB_LINK_WIDTH_DUAL:
+		if (tb_port_get_link_generation(port) >= 4)
+			return usb4_port_asym_set_link_width(port, width);
 		val |= LANE_ADP_CS_1_TARGET_WIDTH_DUAL <<
 			LANE_ADP_CS_1_TARGET_WIDTH_SHIFT;
 		break;
+
+	case TB_LINK_WIDTH_ASYM_TX:
+	case TB_LINK_WIDTH_ASYM_RX:
+		return usb4_port_asym_set_link_width(port, width);
+
 	default:
 		return -EINVAL;
 	}
@@ -1152,7 +1191,7 @@ void tb_port_lane_bonding_disable(struct
 /**
  * tb_port_wait_for_link_width() - Wait until link reaches specific width
  * @port: Port to wait for
- * @width_mask: Expected link width mask
+ * @width: Expected link width (bitmask)
  * @timeout_msec: Timeout in ms how long to wait
  *
  * Should be used after both ends of the link have been bonded (or
@@ -1161,14 +1200,14 @@ void tb_port_lane_bonding_disable(struct
  * within the given timeout, %0 if it did. Can be passed a mask of
  * expected widths and succeeds if any of the widths is reached.
  */
-int tb_port_wait_for_link_width(struct tb_port *port, unsigned int width_mask,
+int tb_port_wait_for_link_width(struct tb_port *port, unsigned int width,
 				int timeout_msec)
 {
 	ktime_t timeout = ktime_add_ms(ktime_get(), timeout_msec);
 	int ret;
 
 	/* Gen 4 link does not support single lane */
-	if ((width_mask & TB_LINK_WIDTH_SINGLE) &&
+	if ((width & TB_LINK_WIDTH_SINGLE) &&
 	    tb_port_get_link_generation(port) >= 4)
 		return -EOPNOTSUPP;
 
@@ -1182,7 +1221,7 @@ int tb_port_wait_for_link_width(struct t
 			 */
 			if (ret != -EACCES)
 				return ret;
-		} else if (ret & width_mask) {
+		} else if (ret & width) {
 			return 0;
 		}
 
@@ -2821,6 +2860,38 @@ static int tb_switch_update_link_attribu
 	return 0;
 }
 
+/* Must be called after tb_switch_update_link_attributes() */
+static void tb_switch_link_init(struct tb_switch *sw)
+{
+	struct tb_port *up, *down;
+	bool bonded;
+
+	if (!tb_route(sw) || tb_switch_is_icm(sw))
+		return;
+
+	tb_sw_dbg(sw, "current link speed %u.0 Gb/s\n", sw->link_speed);
+	tb_sw_dbg(sw, "current link width %s\n", width_name(sw->link_width));
+
+	bonded = sw->link_width >= TB_LINK_WIDTH_DUAL;
+
+	/*
+	 * Gen 4 links come up as bonded so update the port structures
+	 * accordingly.
+	 */
+	up = tb_upstream_port(sw);
+	down = tb_switch_downstream_port(sw);
+
+	up->bonded = bonded;
+	if (up->dual_link_port)
+		up->dual_link_port->bonded = bonded;
+	tb_port_update_credits(up);
+
+	down->bonded = bonded;
+	if (down->dual_link_port)
+		down->dual_link_port->bonded = bonded;
+	tb_port_update_credits(down);
+}
+
 /**
  * tb_switch_lane_bonding_enable() - Enable lane bonding
  * @sw: Switch to enable lane bonding
@@ -2829,24 +2900,20 @@ static int tb_switch_update_link_attribu
  * switch. If conditions are correct and both switches support the feature,
  * lanes are bonded. It is safe to call this to any switch.
  */
-int tb_switch_lane_bonding_enable(struct tb_switch *sw)
+static int tb_switch_lane_bonding_enable(struct tb_switch *sw)
 {
 	struct tb_port *up, *down;
-	u64 route = tb_route(sw);
-	unsigned int width_mask;
+	unsigned int width;
 	int ret;
 
-	if (!route)
-		return 0;
-
 	if (!tb_switch_lane_bonding_possible(sw))
 		return 0;
 
 	up = tb_upstream_port(sw);
 	down = tb_switch_downstream_port(sw);
 
-	if (!tb_port_is_width_supported(up, TB_LINK_WIDTH_DUAL) ||
-	    !tb_port_is_width_supported(down, TB_LINK_WIDTH_DUAL))
+	if (!tb_port_width_supported(up, TB_LINK_WIDTH_DUAL) ||
+	    !tb_port_width_supported(down, TB_LINK_WIDTH_DUAL))
 		return 0;
 
 	/*
@@ -2870,21 +2937,10 @@ int tb_switch_lane_bonding_enable(struct
 	}
 
 	/* Any of the widths are all bonded */
-	width_mask = TB_LINK_WIDTH_DUAL | TB_LINK_WIDTH_ASYM_TX |
-		     TB_LINK_WIDTH_ASYM_RX;
+	width = TB_LINK_WIDTH_DUAL | TB_LINK_WIDTH_ASYM_TX |
+		TB_LINK_WIDTH_ASYM_RX;
 
-	ret = tb_port_wait_for_link_width(down, width_mask, 100);
-	if (ret) {
-		tb_port_warn(down, "timeout enabling lane bonding\n");
-		return ret;
-	}
-
-	tb_port_update_credits(down);
-	tb_port_update_credits(up);
-	tb_switch_update_link_attributes(sw);
-
-	tb_sw_dbg(sw, "lane bonding enabled\n");
-	return ret;
+	return tb_port_wait_for_link_width(down, width, 100);
 }
 
 /**
@@ -2894,20 +2950,27 @@ int tb_switch_lane_bonding_enable(struct
  * Disables lane bonding between @sw and parent. This can be called even
  * if lanes were not bonded originally.
  */
-void tb_switch_lane_bonding_disable(struct tb_switch *sw)
+static int tb_switch_lane_bonding_disable(struct tb_switch *sw)
 {
 	struct tb_port *up, *down;
 	int ret;
 
-	if (!tb_route(sw))
-		return;
-
 	up = tb_upstream_port(sw);
 	if (!up->bonded)
-		return;
+		return 0;
 
-	down = tb_switch_downstream_port(sw);
+	/*
+	 * If the link is Gen 4 there is no way to switch the link to
+	 * two single lane links so avoid that here. Also don't bother
+	 * if the link is not up anymore (sw is unplugged).
+	 */
+	ret = tb_port_get_link_generation(up);
+	if (ret < 0)
+		return ret;
+	if (ret >= 4)
+		return -EOPNOTSUPP;
 
+	down = tb_switch_downstream_port(sw);
 	tb_port_lane_bonding_disable(up);
 	tb_port_lane_bonding_disable(down);
 
@@ -2915,15 +2978,160 @@ void tb_switch_lane_bonding_disable(stru
 	 * It is fine if we get other errors as the router might have
 	 * been unplugged.
 	 */
-	ret = tb_port_wait_for_link_width(down, TB_LINK_WIDTH_SINGLE, 100);
-	if (ret == -ETIMEDOUT)
-		tb_sw_warn(sw, "timeout disabling lane bonding\n");
+	return tb_port_wait_for_link_width(down, TB_LINK_WIDTH_SINGLE, 100);
+}
+
+static int tb_switch_asym_enable(struct tb_switch *sw, enum tb_link_width width)
+{
+	struct tb_port *up, *down, *port;
+	enum tb_link_width down_width;
+	int ret;
+
+	up = tb_upstream_port(sw);
+	down = tb_switch_downstream_port(sw);
+
+	if (width == TB_LINK_WIDTH_ASYM_TX) {
+		down_width = TB_LINK_WIDTH_ASYM_RX;
+		port = down;
+	} else {
+		down_width = TB_LINK_WIDTH_ASYM_TX;
+		port = up;
+	}
+
+	ret = tb_port_set_link_width(up, width);
+	if (ret)
+		return ret;
+
+	ret = tb_port_set_link_width(down, down_width);
+	if (ret)
+		return ret;
+
+	/*
+	 * Initiate the change in the router that one of its TX lanes is
+	 * changing to RX but do so only if there is an actual change.
+	 */
+	if (sw->link_width != width) {
+		ret = usb4_port_asym_start(port);
+		if (ret)
+			return ret;
+
+		ret = tb_port_wait_for_link_width(up, width, 100);
+		if (ret)
+			return ret;
+	}
+
+	sw->link_width = width;
+	return 0;
+}
+
+static int tb_switch_asym_disable(struct tb_switch *sw)
+{
+	struct tb_port *up, *down;
+	int ret;
+
+	up = tb_upstream_port(sw);
+	down = tb_switch_downstream_port(sw);
+
+	ret = tb_port_set_link_width(up, TB_LINK_WIDTH_DUAL);
+	if (ret)
+		return ret;
+
+	ret = tb_port_set_link_width(down, TB_LINK_WIDTH_DUAL);
+	if (ret)
+		return ret;
+
+	/*
+	 * Initiate the change in the router that has three TX lanes and
+	 * is changing one of its TX lanes to RX but only if there is a
+	 * change in the link width.
+	 */
+	if (sw->link_width > TB_LINK_WIDTH_DUAL) {
+		if (sw->link_width == TB_LINK_WIDTH_ASYM_TX)
+			ret = usb4_port_asym_start(up);
+		else
+			ret = usb4_port_asym_start(down);
+		if (ret)
+			return ret;
+
+		ret = tb_port_wait_for_link_width(up, TB_LINK_WIDTH_DUAL, 100);
+		if (ret)
+			return ret;
+	}
+
+	sw->link_width = TB_LINK_WIDTH_DUAL;
+	return 0;
+}
+
+/**
+ * tb_switch_set_link_width() - Configure router link width
+ * @sw: Router to configure
+ * @width: The new link width
+ *
+ * Set device router link width to @width from router upstream port
+ * perspective. Supports also asymmetric links if the routers boths side
+ * of the link supports it.
+ *
+ * Does nothing for host router.
+ *
+ * Returns %0 in case of success, negative errno otherwise.
+ */
+int tb_switch_set_link_width(struct tb_switch *sw, enum tb_link_width width)
+{
+	struct tb_port *up, *down;
+	int ret = 0;
+
+	if (!tb_route(sw))
+		return 0;
+
+	up = tb_upstream_port(sw);
+	down = tb_switch_downstream_port(sw);
+
+	switch (width) {
+	case TB_LINK_WIDTH_SINGLE:
+		ret = tb_switch_lane_bonding_disable(sw);
+		break;
+
+	case TB_LINK_WIDTH_DUAL:
+		if (sw->link_width == TB_LINK_WIDTH_ASYM_TX ||
+		    sw->link_width == TB_LINK_WIDTH_ASYM_RX) {
+			ret = tb_switch_asym_disable(sw);
+			if (ret)
+				break;
+		}
+		ret = tb_switch_lane_bonding_enable(sw);
+		break;
+
+	case TB_LINK_WIDTH_ASYM_TX:
+	case TB_LINK_WIDTH_ASYM_RX:
+		ret = tb_switch_asym_enable(sw, width);
+		break;
+	}
+
+	switch (ret) {
+	case 0:
+		break;
+
+	case -ETIMEDOUT:
+		tb_sw_warn(sw, "timeout changing link width\n");
+		return ret;
+
+	case -ENOTCONN:
+	case -EOPNOTSUPP:
+	case -ENODEV:
+		return ret;
+
+	default:
+		tb_sw_dbg(sw, "failed to change link width: %d\n", ret);
+		return ret;
+	}
 
 	tb_port_update_credits(down);
 	tb_port_update_credits(up);
+
 	tb_switch_update_link_attributes(sw);
 
-	tb_sw_dbg(sw, "lane bonding disabled\n");
+	tb_sw_dbg(sw, "link width set to %s\n", width_name(width));
+	return ret;
 }
 
 /**
@@ -3090,6 +3298,8 @@ int tb_switch_add(struct tb_switch *sw)
 		if (ret)
 			return ret;
 
+		tb_switch_link_init(sw);
+
 		ret = tb_switch_clx_init(sw);
 		if (ret)
 			return ret;
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -985,7 +985,7 @@ static void tb_scan_port(struct tb_port
 	}
 
 	/* Enable lane bonding if supported */
-	tb_switch_lane_bonding_enable(sw);
+	tb_switch_set_link_width(sw, TB_LINK_WIDTH_DUAL);
 	/* Set the link configured */
 	tb_switch_configure_link(sw);
 	/*
@@ -1103,7 +1103,8 @@ static void tb_free_unplugged_children(s
 			tb_retimer_remove_all(port);
 			tb_remove_dp_resources(port->remote->sw);
 			tb_switch_unconfigure_link(port->remote->sw);
-			tb_switch_lane_bonding_disable(port->remote->sw);
+			tb_switch_set_link_width(port->remote->sw,
+						 TB_LINK_WIDTH_SINGLE);
 			tb_switch_remove(port->remote->sw);
 			port->remote = NULL;
 			if (port->dual_link_port)
@@ -1766,7 +1767,8 @@ static void tb_handle_hotplug(struct wor
 			tb_remove_dp_resources(port->remote->sw);
 			tb_switch_tmu_disable(port->remote->sw);
 			tb_switch_unconfigure_link(port->remote->sw);
-			tb_switch_lane_bonding_disable(port->remote->sw);
+			tb_switch_set_link_width(port->remote->sw,
+						 TB_LINK_WIDTH_SINGLE);
 			tb_switch_remove(port->remote->sw);
 			port->remote = NULL;
 			if (port->dual_link_port)
@@ -2258,7 +2260,8 @@ static void tb_restore_children(struct t
 			continue;
 
 		if (port->remote) {
-			tb_switch_lane_bonding_enable(port->remote->sw);
+			tb_switch_set_link_width(port->remote->sw,
+						 port->remote->sw->link_width);
 			tb_switch_configure_link(port->remote->sw);
 
 			tb_restore_children(port->remote->sw);
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -164,11 +164,6 @@ struct tb_switch_tmu {
  * switches) you need to have domain lock held.
  *
  * In USB4 terminology this structure represents a router.
- *
- * Note @link_width is not the same as whether link is bonded or not.
- * For Gen 4 links the link is also bonded when it is asymmetric. The
- * correct way to find out whether the link is bonded or not is to look
- * @bonded field of the upstream port.
  */
 struct tb_switch {
 	struct device dev;
@@ -969,8 +964,7 @@ static inline bool tb_switch_is_icm(cons
 	return !sw->config.enabled;
 }
 
-int tb_switch_lane_bonding_enable(struct tb_switch *sw);
-void tb_switch_lane_bonding_disable(struct tb_switch *sw);
+int tb_switch_set_link_width(struct tb_switch *sw, enum tb_link_width width);
 int tb_switch_configure_link(struct tb_switch *sw);
 void tb_switch_unconfigure_link(struct tb_switch *sw);
 
@@ -1103,10 +1097,11 @@ static inline bool tb_port_use_credit_al
 int tb_port_get_link_speed(struct tb_port *port);
 int tb_port_get_link_generation(struct tb_port *port);
 int tb_port_get_link_width(struct tb_port *port);
+bool tb_port_width_supported(struct tb_port *port, unsigned int width);
 int tb_port_set_link_width(struct tb_port *port, enum tb_link_width width);
 int tb_port_lane_bonding_enable(struct tb_port *port);
 void tb_port_lane_bonding_disable(struct tb_port *port);
-int tb_port_wait_for_link_width(struct tb_port *port, unsigned int width_mask,
+int tb_port_wait_for_link_width(struct tb_port *port, unsigned int width,
 				int timeout_msec);
 int tb_port_update_credits(struct tb_port *port);
 
@@ -1304,6 +1299,11 @@ int usb4_port_router_online(struct tb_po
 int usb4_port_enumerate_retimers(struct tb_port *port);
 bool usb4_port_clx_supported(struct tb_port *port);
 int usb4_port_margining_caps(struct tb_port *port, u32 *caps);
+
+bool usb4_port_asym_supported(struct tb_port *port);
+int usb4_port_asym_set_link_width(struct tb_port *port, enum tb_link_width width);
+int usb4_port_asym_start(struct tb_port *port);
+
 int usb4_port_hw_margin(struct tb_port *port, unsigned int lanes,
 			unsigned int ber_level, bool timing, bool right_high,
 			u32 *results);
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -348,10 +348,14 @@ struct tb_regs_port_header {
 #define LANE_ADP_CS_1				0x01
 #define LANE_ADP_CS_1_TARGET_SPEED_MASK		GENMASK(3, 0)
 #define LANE_ADP_CS_1_TARGET_SPEED_GEN3		0xc
-#define LANE_ADP_CS_1_TARGET_WIDTH_MASK		GENMASK(9, 4)
+#define LANE_ADP_CS_1_TARGET_WIDTH_MASK		GENMASK(5, 4)
 #define LANE_ADP_CS_1_TARGET_WIDTH_SHIFT	4
 #define LANE_ADP_CS_1_TARGET_WIDTH_SINGLE	0x1
 #define LANE_ADP_CS_1_TARGET_WIDTH_DUAL		0x3
+#define LANE_ADP_CS_1_TARGET_WIDTH_ASYM_MASK	GENMASK(7, 6)
+#define LANE_ADP_CS_1_TARGET_WIDTH_ASYM_TX	0x1
+#define LANE_ADP_CS_1_TARGET_WIDTH_ASYM_RX	0x2
+#define LANE_ADP_CS_1_TARGET_WIDTH_ASYM_DUAL	0x0
 #define LANE_ADP_CS_1_CL0S_ENABLE		BIT(10)
 #define LANE_ADP_CS_1_CL1_ENABLE		BIT(11)
 #define LANE_ADP_CS_1_CL2_ENABLE		BIT(12)
@@ -384,6 +388,8 @@ struct tb_regs_port_header {
 #define PORT_CS_18_WOCS				BIT(16)
 #define PORT_CS_18_WODS				BIT(17)
 #define PORT_CS_18_WOU4S			BIT(18)
+#define PORT_CS_18_CSA				BIT(22)
+#define PORT_CS_18_TIP				BIT(24)
 #define PORT_CS_19				0x13
 #define PORT_CS_19_DPR				BIT(0)
 #define PORT_CS_19_PC				BIT(3)
@@ -391,6 +397,7 @@ struct tb_regs_port_header {
 #define PORT_CS_19_WOC				BIT(16)
 #define PORT_CS_19_WOD				BIT(17)
 #define PORT_CS_19_WOU4				BIT(18)
+#define PORT_CS_19_START_ASYM			BIT(24)
 
 /* Display Port adapter registers */
 #define ADP_DP_CS_0				0x00
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -1495,6 +1495,112 @@ bool usb4_port_clx_supported(struct tb_p
 }
 
 /**
+ * usb4_port_asym_supported() - If the port supports asymmetric link
+ * @port: USB4 port
+ *
+ * Checks if the port and the cable supports asymmetric link and returns
+ * %true in that case.
+ */
+bool usb4_port_asym_supported(struct tb_port *port)
+{
+	u32 val;
+
+	if (!port->cap_usb4)
+		return false;
+
+	if (tb_port_read(port, &val, TB_CFG_PORT, port->cap_usb4 + PORT_CS_18, 1))
+		return false;
+
+	return !!(val & PORT_CS_18_CSA);
+}
+
+/**
+ * usb4_port_asym_set_link_width() - Set link width to asymmetric or symmetric
+ * @port: USB4 port
+ * @width: Asymmetric width to configure
+ *
+ * Sets USB4 port link width to @width. Can be called for widths where
+ * usb4_port_asym_width_supported() returned @true.
+ */
+int usb4_port_asym_set_link_width(struct tb_port *port, enum tb_link_width width)
+{
+	u32 val;
+	int ret;
+
+	if (!port->cap_phy)
+		return -EINVAL;
+
+	ret = tb_port_read(port, &val, TB_CFG_PORT,
+			   port->cap_phy + LANE_ADP_CS_1, 1);
+	if (ret)
+		return ret;
+
+	val &= ~LANE_ADP_CS_1_TARGET_WIDTH_ASYM_MASK;
+	switch (width) {
+	case TB_LINK_WIDTH_DUAL:
+		val |= FIELD_PREP(LANE_ADP_CS_1_TARGET_WIDTH_ASYM_MASK,
+				  LANE_ADP_CS_1_TARGET_WIDTH_ASYM_DUAL);
+		break;
+	case TB_LINK_WIDTH_ASYM_TX:
+		val |= FIELD_PREP(LANE_ADP_CS_1_TARGET_WIDTH_ASYM_MASK,
+				  LANE_ADP_CS_1_TARGET_WIDTH_ASYM_TX);
+		break;
+	case TB_LINK_WIDTH_ASYM_RX:
+		val |= FIELD_PREP(LANE_ADP_CS_1_TARGET_WIDTH_ASYM_MASK,
+				  LANE_ADP_CS_1_TARGET_WIDTH_ASYM_RX);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return tb_port_write(port, &val, TB_CFG_PORT,
+			     port->cap_phy + LANE_ADP_CS_1, 1);
+}
+
+/**
+ * usb4_port_asym_start() - Start symmetry change and wait for completion
+ * @port: USB4 port
+ *
+ * Start symmetry change of the link to asymmetric or symmetric
+ * (according to what was previously set in tb_port_set_link_width().
+ * Wait for completion of the change.
+ *
+ * Returns %0 in case of success, %-ETIMEDOUT if case of timeout or
+ * a negative errno in case of a failure.
+ */
+int usb4_port_asym_start(struct tb_port *port)
+{
+	int ret;
+	u32 val;
+
+	ret = tb_port_read(port, &val, TB_CFG_PORT,
+			   port->cap_usb4 + PORT_CS_19, 1);
+	if (ret)
+		return ret;
+
+	val &= ~PORT_CS_19_START_ASYM;
+	val |= FIELD_PREP(PORT_CS_19_START_ASYM, 1);
+
+	ret = tb_port_write(port, &val, TB_CFG_PORT,
+			    port->cap_usb4 + PORT_CS_19, 1);
+	if (ret)
+		return ret;
+
+	/*
+	 * Wait for PORT_CS_19_START_ASYM to be 0. This means the USB4
+	 * port started the symmetry transition.
+	 */
+	ret = usb4_port_wait_for_bit(port, port->cap_usb4 + PORT_CS_19,
+				     PORT_CS_19_START_ASYM, 0, 1000);
+	if (ret)
+		return ret;
+
+	/* Then wait for the transtion to be completed */
+	return usb4_port_wait_for_bit(port, port->cap_usb4 + PORT_CS_18,
+				      PORT_CS_18_TIP, 0, 5000);
+}
+
+/**
  * usb4_port_margining_caps() - Read USB4 port marginig capabilities
  * @port: USB4 port
  * @caps: Array with at least two elements to hold the results



