Return-Path: <stable+bounces-121866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE20EA59CD9
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D80C3A89FE
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2BF233120;
	Mon, 10 Mar 2025 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wtAezL45"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78797232787;
	Mon, 10 Mar 2025 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626856; cv=none; b=T4rle9EpIKiDLaeLcuJL6dTD4QiXFVOGUvDPEgiHksiZkBS7TJjO89lKOfjjdQWTLLZlARbL8UoUQ2w+6uAiEJEDrxoZKdZ23N1C9L/zOZyUWGC26qkeHyg4MYZjcljIVDLLErqjbBGe5kuFNs4pbo1AqvHc547jDscfFJNymZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626856; c=relaxed/simple;
	bh=7MZoyayWZTYaX4VhDn9U/eMQnSXWjfuKSkiVfzKIWjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6ClHWzBw2j/8PccMP4MbW/snH+XIKazPCz3P9HrwqQnbqVAniYpXrxKmTI637fGGv62JaWR9I6PBgyASOLlKe+GvvgZOeYPceGWHiWwqStrq2GDy81eZa1R87Xtj/Uvcty0boLe/nxuxLdSm9OvJUY1VY6YRw6rBjPYSJYEh7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wtAezL45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014FCC4CEE5;
	Mon, 10 Mar 2025 17:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741626856;
	bh=7MZoyayWZTYaX4VhDn9U/eMQnSXWjfuKSkiVfzKIWjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wtAezL45qw76HwZsQMmi2UqKCtSCTR7XxMfEVJXyYrMuUO+j901bQ0emlAFn29Ove
	 q1rc9efLFM40gLUVKPxOff7Wbb17zEYJofnXUsGNwA6jrcjbXKMCoiCmIbQNjizcsa
	 ylu3CrGYZDMBE+j4lYcPU6kCyJEw31B3+XM2T3QY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 135/207] net: ethtool: netlink: Allow NULL nlattrs when getting a phy_device
Date: Mon, 10 Mar 2025 18:05:28 +0100
Message-ID: <20250310170453.164883414@linuxfoundation.org>
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

From: Maxime Chevallier <maxime.chevallier@bootlin.com>

[ Upstream commit 637399bf7e77797811adf340090b561a8f9d1213 ]

ethnl_req_get_phydev() is used to lookup a phy_device, in the case an
ethtool netlink command targets a specific phydev within a netdev's
topology.

It takes as a parameter a const struct nlattr *header that's used for
error handling :

       if (!phydev) {
               NL_SET_ERR_MSG_ATTR(extack, header,
                                   "no phy matching phyindex");
               return ERR_PTR(-ENODEV);
       }

In the notify path after a ->set operation however, there's no request
attributes available.

The typical callsite for the above function looks like:

	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_XXX_HEADER],
				      info->extack);

So, when tb is NULL (such as in the ethnl notify path), we have a nice
crash.

It turns out that there's only the PLCA command that is in that case, as
the other phydev-specific commands don't have a notification.

This commit fixes the crash by passing the cmd index and the nlattr
array separately, allowing NULL-checking it directly inside the helper.

Fixes: c15e065b46dc ("net: ethtool: Allow passing a phy index for some commands")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Reported-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Link: https://patch.msgid.link/20250301141114.97204-1-maxime.chevallier@bootlin.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ethtool/cabletest.c | 8 ++++----
 net/ethtool/linkstate.c | 2 +-
 net/ethtool/netlink.c   | 6 +++---
 net/ethtool/netlink.h   | 5 +++--
 net/ethtool/phy.c       | 2 +-
 net/ethtool/plca.c      | 6 +++---
 net/ethtool/pse-pd.c    | 4 ++--
 net/ethtool/stats.c     | 2 +-
 net/ethtool/strset.c    | 2 +-
 9 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
index f22051f33868a..84096f6b0236e 100644
--- a/net/ethtool/cabletest.c
+++ b/net/ethtool/cabletest.c
@@ -72,8 +72,8 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
 	dev = req_info.dev;
 
 	rtnl_lock();
-	phydev = ethnl_req_get_phydev(&req_info,
-				      tb[ETHTOOL_A_CABLE_TEST_HEADER],
+	phydev = ethnl_req_get_phydev(&req_info, tb,
+				      ETHTOOL_A_CABLE_TEST_HEADER,
 				      info->extack);
 	if (IS_ERR_OR_NULL(phydev)) {
 		ret = -EOPNOTSUPP;
@@ -339,8 +339,8 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 		goto out_dev_put;
 
 	rtnl_lock();
-	phydev = ethnl_req_get_phydev(&req_info,
-				      tb[ETHTOOL_A_CABLE_TEST_TDR_HEADER],
+	phydev = ethnl_req_get_phydev(&req_info, tb,
+				      ETHTOOL_A_CABLE_TEST_TDR_HEADER,
 				      info->extack);
 	if (IS_ERR_OR_NULL(phydev)) {
 		ret = -EOPNOTSUPP;
diff --git a/net/ethtool/linkstate.c b/net/ethtool/linkstate.c
index af19e1bed303f..05a5f72c99fab 100644
--- a/net/ethtool/linkstate.c
+++ b/net/ethtool/linkstate.c
@@ -103,7 +103,7 @@ static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
 	struct phy_device *phydev;
 	int ret;
 
-	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_LINKSTATE_HEADER],
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_LINKSTATE_HEADER,
 				      info->extack);
 	if (IS_ERR(phydev)) {
 		ret = PTR_ERR(phydev);
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 4d18dc29b3043..e233dfc8ca4be 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -210,7 +210,7 @@ int ethnl_parse_header_dev_get(struct ethnl_req_info *req_info,
 }
 
 struct phy_device *ethnl_req_get_phydev(const struct ethnl_req_info *req_info,
-					const struct nlattr *header,
+					struct nlattr **tb, unsigned int header,
 					struct netlink_ext_ack *extack)
 {
 	struct phy_device *phydev;
@@ -224,8 +224,8 @@ struct phy_device *ethnl_req_get_phydev(const struct ethnl_req_info *req_info,
 		return req_info->dev->phydev;
 
 	phydev = phy_link_topo_get_phy(req_info->dev, req_info->phy_index);
-	if (!phydev) {
-		NL_SET_ERR_MSG_ATTR(extack, header,
+	if (!phydev && tb) {
+		NL_SET_ERR_MSG_ATTR(extack, tb[header],
 				    "no phy matching phyindex");
 		return ERR_PTR(-ENODEV);
 	}
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 203b08eb6c6f6..5e176938d6d22 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -275,7 +275,8 @@ static inline void ethnl_parse_header_dev_put(struct ethnl_req_info *req_info)
  * ethnl_req_get_phydev() - Gets the phy_device targeted by this request,
  *			    if any. Must be called under rntl_lock().
  * @req_info:	The ethnl request to get the phy from.
- * @header:	The netlink header, used for error reporting.
+ * @tb:		The netlink attributes array, for error reporting.
+ * @header:	The netlink header index, used for error reporting.
  * @extack:	The netlink extended ACK, for error reporting.
  *
  * The caller must hold RTNL, until it's done interacting with the returned
@@ -289,7 +290,7 @@ static inline void ethnl_parse_header_dev_put(struct ethnl_req_info *req_info)
  *	   is returned.
  */
 struct phy_device *ethnl_req_get_phydev(const struct ethnl_req_info *req_info,
-					const struct nlattr *header,
+					struct nlattr **tb, unsigned int header,
 					struct netlink_ext_ack *extack);
 
 /**
diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index ed8f690f6bac8..e067cc234419d 100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -125,7 +125,7 @@ static int ethnl_phy_parse_request(struct ethnl_req_info *req_base,
 	struct phy_req_info *req_info = PHY_REQINFO(req_base);
 	struct phy_device *phydev;
 
-	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_PHY_HEADER],
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_PHY_HEADER,
 				      extack);
 	if (!phydev)
 		return 0;
diff --git a/net/ethtool/plca.c b/net/ethtool/plca.c
index d95d92f173a6d..e1f7820a6158f 100644
--- a/net/ethtool/plca.c
+++ b/net/ethtool/plca.c
@@ -62,7 +62,7 @@ static int plca_get_cfg_prepare_data(const struct ethnl_req_info *req_base,
 	struct phy_device *phydev;
 	int ret;
 
-	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_PLCA_HEADER],
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_PLCA_HEADER,
 				      info->extack);
 	// check that the PHY device is available and connected
 	if (IS_ERR_OR_NULL(phydev)) {
@@ -152,7 +152,7 @@ ethnl_set_plca(struct ethnl_req_info *req_info, struct genl_info *info)
 	bool mod = false;
 	int ret;
 
-	phydev = ethnl_req_get_phydev(req_info, tb[ETHTOOL_A_PLCA_HEADER],
+	phydev = ethnl_req_get_phydev(req_info, tb, ETHTOOL_A_PLCA_HEADER,
 				      info->extack);
 	// check that the PHY device is available and connected
 	if (IS_ERR_OR_NULL(phydev))
@@ -211,7 +211,7 @@ static int plca_get_status_prepare_data(const struct ethnl_req_info *req_base,
 	struct phy_device *phydev;
 	int ret;
 
-	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_PLCA_HEADER],
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_PLCA_HEADER,
 				      info->extack);
 	// check that the PHY device is available and connected
 	if (IS_ERR_OR_NULL(phydev)) {
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index a0705edca22a1..71843de832cca 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -64,7 +64,7 @@ static int pse_prepare_data(const struct ethnl_req_info *req_base,
 	if (ret < 0)
 		return ret;
 
-	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_PSE_HEADER],
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_PSE_HEADER,
 				      info->extack);
 	if (IS_ERR(phydev))
 		return -ENODEV;
@@ -261,7 +261,7 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 	struct phy_device *phydev;
 	int ret;
 
-	phydev = ethnl_req_get_phydev(req_info, tb[ETHTOOL_A_PSE_HEADER],
+	phydev = ethnl_req_get_phydev(req_info, tb, ETHTOOL_A_PSE_HEADER,
 				      info->extack);
 	ret = ethnl_set_pse_validate(phydev, info);
 	if (ret)
diff --git a/net/ethtool/stats.c b/net/ethtool/stats.c
index f4d822c225db6..273ae4ff343fe 100644
--- a/net/ethtool/stats.c
+++ b/net/ethtool/stats.c
@@ -128,7 +128,7 @@ static int stats_prepare_data(const struct ethnl_req_info *req_base,
 	struct phy_device *phydev;
 	int ret;
 
-	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_STATS_HEADER],
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_STATS_HEADER,
 				      info->extack);
 	if (IS_ERR(phydev))
 		return PTR_ERR(phydev);
diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
index b3382b3cf325c..b9400d18f01d5 100644
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
@@ -299,7 +299,7 @@ static int strset_prepare_data(const struct ethnl_req_info *req_base,
 		return 0;
 	}
 
-	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_HEADER_FLAGS],
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_HEADER_FLAGS,
 				      info->extack);
 
 	/* phydev can be NULL, check for errors only */
-- 
2.39.5




