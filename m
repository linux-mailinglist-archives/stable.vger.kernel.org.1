Return-Path: <stable+bounces-121865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C49EA59CAA
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F48188A8C2
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA88230BF9;
	Mon, 10 Mar 2025 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IbyfDA84"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97799230BED;
	Mon, 10 Mar 2025 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626853; cv=none; b=eBl34JnoQ4pVrTLF9yhpk9Ax2xVqqYZiOVglt3Gl4i1qDvC2H6+xTKAcFsPxwfnc/M6giwn3DCJ88ykwIjAhy2yXwK75MfLa0oJjRbE5ucNVpDPR2DPeGifa3y1ElLTaWzP9bplgwma3qjX1JFUHEuFZpc9rtpmthlnd7t4wOSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626853; c=relaxed/simple;
	bh=jteehOyx31svkZLuceuUtiMn6o1h91y+8pRddyctSPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gAetMyDG/Ir6Dc1GoKbyxNMd7bbURxeCkWIGcriCvtmHD1WIdvFcg/JUNmTbncP9SKCR/rrkrrU7/SjgNZS2zbWSi/3bTznJ54bMevHaV/1SCWx9phkWbsB/E8amHDQ9/sOroGZ1eKHnUjEUHubj1hM9JEg5OgNhdrwM56ITzk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IbyfDA84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6DAC4CEE5;
	Mon, 10 Mar 2025 17:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741626853;
	bh=jteehOyx31svkZLuceuUtiMn6o1h91y+8pRddyctSPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IbyfDA84QEKbUf+I3dJcZuvRHzE5m6RGPwWy9naMvdsEkvO912dyrZ3f+FIFZ7Lsx
	 TF5pyfPGHWZCPKNPR/Ow3ADXPjd8gmn0nMy6ygljgWo+i4P/W1GYdkVuXX/hqtHhzY
	 NZq7N5UxPntYdskJDGTpYxO+CYLaBn+hKtcXlyfA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 134/207] net: ethtool: plumb PHY stats to PHY drivers
Date: Mon, 10 Mar 2025 18:05:27 +0100
Message-ID: <20250310170453.126476726@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170447.729440535@linuxfoundation.org>
References: <20250310170447.729440535@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit b7a2c1fe6b55364e61b4b54b991eb43a47bb1104 ]

Introduce support for standardized PHY statistics reporting in ethtool
by extending the PHYLIB framework. Add the functions
phy_ethtool_get_phy_stats() and phy_ethtool_get_link_ext_stats() to
provide a consistent interface for retrieving PHY-level and
link-specific statistics. These functions are used within the ethtool
implementation to avoid direct access to the phy_device structure
outside of the PHYLIB framework.

A new structure, ethtool_phy_stats, is introduced to standardize PHY
statistics such as packet counts, byte counts, and error counters.
Drivers are updated to include callbacks for retrieving PHY and
link-specific statistics, ensuring values are explicitly set only for
supported fields, initialized with ETHTOOL_STAT_NOT_SET to avoid
ambiguity.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 637399bf7e77 ("net: ethtool: netlink: Allow NULL nlattrs when getting a phy_device")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy.c        | 43 ++++++++++++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c |  2 ++
 include/linux/ethtool.h      | 23 +++++++++++++++++++
 include/linux/phy.h          | 36 ++++++++++++++++++++++++++++++
 include/linux/phylib_stubs.h | 42 +++++++++++++++++++++++++++++++++++
 net/ethtool/linkstate.c      |  5 +++--
 net/ethtool/stats.c          | 18 +++++++++++++++
 7 files changed, 167 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 0d20b534122b2..ffd1da04d3ad1 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -615,6 +615,49 @@ int phy_ethtool_get_stats(struct phy_device *phydev,
 }
 EXPORT_SYMBOL(phy_ethtool_get_stats);
 
+/**
+ * __phy_ethtool_get_phy_stats - Retrieve standardized PHY statistics
+ * @phydev: Pointer to the PHY device
+ * @phy_stats: Pointer to ethtool_eth_phy_stats structure
+ * @phydev_stats: Pointer to ethtool_phy_stats structure
+ *
+ * Fetches PHY statistics using a kernel-defined interface for consistent
+ * diagnostics. Unlike phy_ethtool_get_stats(), which allows custom stats,
+ * this function enforces a standardized format for better interoperability.
+ */
+void __phy_ethtool_get_phy_stats(struct phy_device *phydev,
+				 struct ethtool_eth_phy_stats *phy_stats,
+				 struct ethtool_phy_stats *phydev_stats)
+{
+	if (!phydev->drv || !phydev->drv->get_phy_stats)
+		return;
+
+	mutex_lock(&phydev->lock);
+	phydev->drv->get_phy_stats(phydev, phy_stats, phydev_stats);
+	mutex_unlock(&phydev->lock);
+}
+
+/**
+ * __phy_ethtool_get_link_ext_stats - Retrieve extended link statistics for a PHY
+ * @phydev: Pointer to the PHY device
+ * @link_stats: Pointer to the structure to store extended link statistics
+ *
+ * Populates the ethtool_link_ext_stats structure with link down event counts
+ * and additional driver-specific link statistics, if available.
+ */
+void __phy_ethtool_get_link_ext_stats(struct phy_device *phydev,
+				      struct ethtool_link_ext_stats *link_stats)
+{
+	link_stats->link_down_events = READ_ONCE(phydev->link_down_events);
+
+	if (!phydev->drv || !phydev->drv->get_link_stats)
+		return;
+
+	mutex_lock(&phydev->lock);
+	phydev->drv->get_link_stats(phydev, link_stats);
+	mutex_unlock(&phydev->lock);
+}
+
 /**
  * phy_ethtool_get_plca_cfg - Get PLCA RS configuration
  * @phydev: the phy_device struct
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index b26bb33cd1d48..5f1ad0c7fb534 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3773,6 +3773,8 @@ static const struct ethtool_phy_ops phy_ethtool_phy_ops = {
 static const struct phylib_stubs __phylib_stubs = {
 	.hwtstamp_get = __phy_hwtstamp_get,
 	.hwtstamp_set = __phy_hwtstamp_set,
+	.get_phy_stats = __phy_ethtool_get_phy_stats,
+	.get_link_ext_stats = __phy_ethtool_get_link_ext_stats,
 };
 
 static void phylib_register_stubs(void)
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index b8b935b526033..b0ed740ca749b 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -412,6 +412,29 @@ struct ethtool_eth_phy_stats {
 	);
 };
 
+/**
+ * struct ethtool_phy_stats - PHY-level statistics counters
+ * @rx_packets: Total successfully received frames
+ * @rx_bytes: Total successfully received bytes
+ * @rx_errors: Total received frames with errors (e.g., CRC errors)
+ * @tx_packets: Total successfully transmitted frames
+ * @tx_bytes: Total successfully transmitted bytes
+ * @tx_errors: Total transmitted frames with errors
+ *
+ * This structure provides a standardized interface for reporting
+ * PHY-level statistics counters. It is designed to expose statistics
+ * commonly provided by PHYs but not explicitly defined in the IEEE
+ * 802.3 standard.
+ */
+struct ethtool_phy_stats {
+	u64 rx_packets;
+	u64 rx_bytes;
+	u64 rx_errors;
+	u64 tx_packets;
+	u64 tx_bytes;
+	u64 tx_errors;
+};
+
 /* Basic IEEE 802.3 MAC Ctrl statistics (30.3.3.*), not otherwise exposed
  * via a more targeted API.
  */
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 563c462056857..bed2b81f8fb3f 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1090,6 +1090,35 @@ struct phy_driver {
 	int (*cable_test_get_status)(struct phy_device *dev, bool *finished);
 
 	/* Get statistics from the PHY using ethtool */
+	/**
+	 * @get_phy_stats: Retrieve PHY statistics.
+	 * @dev: The PHY device for which the statistics are retrieved.
+	 * @eth_stats: structure where Ethernet PHY stats will be stored.
+	 * @stats: structure where additional PHY-specific stats will be stored.
+	 *
+	 * Retrieves the supported PHY statistics and populates the provided
+	 * structures. The input structures are pre-initialized with
+	 * `ETHTOOL_STAT_NOT_SET`, and the driver must only modify members
+	 * corresponding to supported statistics. Unmodified members will remain
+	 * set to `ETHTOOL_STAT_NOT_SET` and will not be returned to userspace.
+	 */
+	void (*get_phy_stats)(struct phy_device *dev,
+			      struct ethtool_eth_phy_stats *eth_stats,
+			      struct ethtool_phy_stats *stats);
+
+	/**
+	 * @get_link_stats: Retrieve link statistics.
+	 * @dev: The PHY device for which the statistics are retrieved.
+	 * @link_stats: structure where link-specific stats will be stored.
+	 *
+	 * Retrieves link-related statistics for the given PHY device. The input
+	 * structure is pre-initialized with `ETHTOOL_STAT_NOT_SET`, and the
+	 * driver must only modify members corresponding to supported
+	 * statistics. Unmodified members will remain set to
+	 * `ETHTOOL_STAT_NOT_SET` and will not be returned to userspace.
+	 */
+	void (*get_link_stats)(struct phy_device *dev,
+			       struct ethtool_link_ext_stats *link_stats);
 	/** @get_sset_count: Number of statistic counters */
 	int (*get_sset_count)(struct phy_device *dev);
 	/** @get_strings: Names of the statistic counters */
@@ -2065,6 +2094,13 @@ int phy_ethtool_get_strings(struct phy_device *phydev, u8 *data);
 int phy_ethtool_get_sset_count(struct phy_device *phydev);
 int phy_ethtool_get_stats(struct phy_device *phydev,
 			  struct ethtool_stats *stats, u64 *data);
+
+void __phy_ethtool_get_phy_stats(struct phy_device *phydev,
+			 struct ethtool_eth_phy_stats *phy_stats,
+			 struct ethtool_phy_stats *phydev_stats);
+void __phy_ethtool_get_link_ext_stats(struct phy_device *phydev,
+				      struct ethtool_link_ext_stats *link_stats);
+
 int phy_ethtool_get_plca_cfg(struct phy_device *phydev,
 			     struct phy_plca_cfg *plca_cfg);
 int phy_ethtool_set_plca_cfg(struct phy_device *phydev,
diff --git a/include/linux/phylib_stubs.h b/include/linux/phylib_stubs.h
index 1279f48c8a707..9d2d6090c86d1 100644
--- a/include/linux/phylib_stubs.h
+++ b/include/linux/phylib_stubs.h
@@ -5,6 +5,9 @@
 
 #include <linux/rtnetlink.h>
 
+struct ethtool_eth_phy_stats;
+struct ethtool_link_ext_stats;
+struct ethtool_phy_stats;
 struct kernel_hwtstamp_config;
 struct netlink_ext_ack;
 struct phy_device;
@@ -19,6 +22,11 @@ struct phylib_stubs {
 	int (*hwtstamp_set)(struct phy_device *phydev,
 			    struct kernel_hwtstamp_config *config,
 			    struct netlink_ext_ack *extack);
+	void (*get_phy_stats)(struct phy_device *phydev,
+			      struct ethtool_eth_phy_stats *phy_stats,
+			      struct ethtool_phy_stats *phydev_stats);
+	void (*get_link_ext_stats)(struct phy_device *phydev,
+				   struct ethtool_link_ext_stats *link_stats);
 };
 
 static inline int phy_hwtstamp_get(struct phy_device *phydev,
@@ -50,6 +58,29 @@ static inline int phy_hwtstamp_set(struct phy_device *phydev,
 	return phylib_stubs->hwtstamp_set(phydev, config, extack);
 }
 
+static inline void phy_ethtool_get_phy_stats(struct phy_device *phydev,
+					struct ethtool_eth_phy_stats *phy_stats,
+					struct ethtool_phy_stats *phydev_stats)
+{
+	ASSERT_RTNL();
+
+	if (!phylib_stubs)
+		return;
+
+	phylib_stubs->get_phy_stats(phydev, phy_stats, phydev_stats);
+}
+
+static inline void phy_ethtool_get_link_ext_stats(struct phy_device *phydev,
+				    struct ethtool_link_ext_stats *link_stats)
+{
+	ASSERT_RTNL();
+
+	if (!phylib_stubs)
+		return;
+
+	phylib_stubs->get_link_ext_stats(phydev, link_stats);
+}
+
 #else
 
 static inline int phy_hwtstamp_get(struct phy_device *phydev,
@@ -65,4 +96,15 @@ static inline int phy_hwtstamp_set(struct phy_device *phydev,
 	return -EOPNOTSUPP;
 }
 
+static inline void phy_ethtool_get_phy_stats(struct phy_device *phydev,
+					struct ethtool_eth_phy_stats *phy_stats,
+					struct ethtool_phy_stats *phydev_stats)
+{
+}
+
+static inline void phy_ethtool_get_link_ext_stats(struct phy_device *phydev,
+				    struct ethtool_link_ext_stats *link_stats)
+{
+}
+
 #endif
diff --git a/net/ethtool/linkstate.c b/net/ethtool/linkstate.c
index 459cfea7652d4..af19e1bed303f 100644
--- a/net/ethtool/linkstate.c
+++ b/net/ethtool/linkstate.c
@@ -3,6 +3,7 @@
 #include "netlink.h"
 #include "common.h"
 #include <linux/phy.h>
+#include <linux/phylib_stubs.h>
 
 struct linkstate_req_info {
 	struct ethnl_req_info		base;
@@ -135,8 +136,8 @@ static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
 
 	if (req_base->flags & ETHTOOL_FLAG_STATS) {
 		if (phydev)
-			data->link_stats.link_down_events =
-				READ_ONCE(phydev->link_down_events);
+			phy_ethtool_get_link_ext_stats(phydev,
+						       &data->link_stats);
 
 		if (dev->ethtool_ops->get_link_ext_stats)
 			dev->ethtool_ops->get_link_ext_stats(dev,
diff --git a/net/ethtool/stats.c b/net/ethtool/stats.c
index 912f0c4fff2fb..f4d822c225db6 100644
--- a/net/ethtool/stats.c
+++ b/net/ethtool/stats.c
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/phy.h>
+#include <linux/phylib_stubs.h>
+
 #include "netlink.h"
 #include "common.h"
 #include "bitset.h"
@@ -20,6 +23,7 @@ struct stats_reply_data {
 		struct ethtool_eth_mac_stats	mac_stats;
 		struct ethtool_eth_ctrl_stats	ctrl_stats;
 		struct ethtool_rmon_stats	rmon_stats;
+		struct ethtool_phy_stats	phydev_stats;
 	);
 	const struct ethtool_rmon_hist_range	*rmon_ranges;
 };
@@ -120,8 +124,15 @@ static int stats_prepare_data(const struct ethnl_req_info *req_base,
 	struct stats_reply_data *data = STATS_REPDATA(reply_base);
 	enum ethtool_mac_stats_src src = req_info->src;
 	struct net_device *dev = reply_base->dev;
+	struct nlattr **tb = info->attrs;
+	struct phy_device *phydev;
 	int ret;
 
+	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_STATS_HEADER],
+				      info->extack);
+	if (IS_ERR(phydev))
+		return PTR_ERR(phydev);
+
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		return ret;
@@ -145,6 +156,13 @@ static int stats_prepare_data(const struct ethnl_req_info *req_base,
 	data->ctrl_stats.src = src;
 	data->rmon_stats.src = src;
 
+	if (test_bit(ETHTOOL_STATS_ETH_PHY, req_info->stat_mask) &&
+	    src == ETHTOOL_MAC_STATS_SRC_AGGREGATE) {
+		if (phydev)
+			phy_ethtool_get_phy_stats(phydev, &data->phy_stats,
+						  &data->phydev_stats);
+	}
+
 	if (test_bit(ETHTOOL_STATS_ETH_PHY, req_info->stat_mask) &&
 	    dev->ethtool_ops->get_eth_phy_stats)
 		dev->ethtool_ops->get_eth_phy_stats(dev, &data->phy_stats);
-- 
2.39.5




