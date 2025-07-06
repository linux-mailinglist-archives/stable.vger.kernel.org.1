Return-Path: <stable+bounces-159415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE30BAF785B
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 16:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12B607AADE6
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C7F2E62CD;
	Thu,  3 Jul 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ht46iwDZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7207C126BFF;
	Thu,  3 Jul 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554161; cv=none; b=d10yPuDXUs3f6356/HmgH8edeUeMcJ/W7pzOaBiYlMxz4xEgls/7aaDx4Xs6iTpEzJxqzrDfSKzY7D1eWGws487GQfPPoWbCt+1wrPmSc8JQ1E/3fpAdjkVGKxLPPCliDwGuqnYaNoR4APQqX8ClwXmwNB2gExFipeHgjIv8isI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554161; c=relaxed/simple;
	bh=f0R3D3WTY/ci9SZ7DZLnWtjrvnCiV0cukHu16HIVPmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tg1d7rNc+nYirZCPGdGxraUR0BPSwvNRaGlvvugqrnSTvbalVQfkLdjp5IsTSssP8xdQnfqjyzW02FNB6DfLgwjE0RaR93w71GOyW6aS9LlPu7xl5jprUBLvyouP8SvstHVs6hONHdCFWq0/7n9gxrBCLe5aWZMlMst5oQDD63g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ht46iwDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE9AC4CEE3;
	Thu,  3 Jul 2025 14:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751554161;
	bh=f0R3D3WTY/ci9SZ7DZLnWtjrvnCiV0cukHu16HIVPmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ht46iwDZYQ0WxWI+UeOHTqNlHHxxvvkBgz1IOFef7rjDBV94s+5xCGH6bmXAgfBBh
	 vM9c2xGgzJy/mtKi+NYnFxHXcbtJur00DH8dUB9Stf4mDg3qMs0up0DjaD0+/0f0tC
	 0Bb9I8P3CyS4GRQcTWHmgR3qSaBaOFWE0TXjufQY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Muna Sinada <muna.sinada@oss.qualcomm.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 100/218] wifi: mac80211: Create separate links for VLAN interfaces
Date: Thu,  3 Jul 2025 16:40:48 +0200
Message-ID: <20250703143959.935209788@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143955.956569535@linuxfoundation.org>
References: <20250703143955.956569535@linuxfoundation.org>
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

From: Muna Sinada <muna.sinada@oss.qualcomm.com>

[ Upstream commit 90233b0ad215efc9ea56a7c0b09021bcd4eea4ac ]

Currently, MLD links for an AP_VLAN interface type is not fully
supported.

Add allocation of separate links for each VLAN interface and copy
chanctx and chandef of AP bss to VLAN where necessary. Separate
links are created because for Dynamic VLAN each link will have its own
default_multicast_key.

Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
Link: https://patch.msgid.link/20250325213125.1509362-3-muna.sinada@oss.qualcomm.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Stable-dep-of: d87c3ca0f8f1 ("wifi: mac80211: finish link init before RCU publish")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/chan.c        |  3 ++
 net/mac80211/ieee80211_i.h |  3 ++
 net/mac80211/iface.c       | 12 ++++-
 net/mac80211/link.c        | 90 ++++++++++++++++++++++++++++++++++++--
 4 files changed, 103 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index cca6d14084d21..282e8c13e2bfc 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -2097,6 +2097,9 @@ void ieee80211_link_release_channel(struct ieee80211_link_data *link)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 
+	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
+		return;
+
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (rcu_access_pointer(link->conf->chanctx_conf))
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 41e69e066b386..2f017dbbcb975 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2070,6 +2070,9 @@ static inline void ieee80211_vif_clear_links(struct ieee80211_sub_if_data *sdata
 	ieee80211_vif_set_links(sdata, 0, 0);
 }
 
+void ieee80211_apvlan_link_setup(struct ieee80211_sub_if_data *sdata);
+void ieee80211_apvlan_link_clear(struct ieee80211_sub_if_data *sdata);
+
 /* tx handling */
 void ieee80211_clear_tx_pending(struct ieee80211_local *local);
 void ieee80211_tx_pending(struct tasklet_struct *t);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 7e1e561ef76c1..209d6ffa8e426 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -494,6 +494,9 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 			break;
 		list_del_rcu(&sdata->u.mntr.list);
 		break;
+	case NL80211_IFTYPE_AP_VLAN:
+		ieee80211_apvlan_link_clear(sdata);
+		break;
 	default:
 		break;
 	}
@@ -1268,6 +1271,8 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		sdata->crypto_tx_tailroom_needed_cnt +=
 			master->crypto_tx_tailroom_needed_cnt;
 
+		ieee80211_apvlan_link_setup(sdata);
+
 		break;
 		}
 	case NL80211_IFTYPE_AP:
@@ -1322,7 +1327,12 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	case NL80211_IFTYPE_AP_VLAN:
 		/* no need to tell driver, but set carrier and chanctx */
 		if (sdata->bss->active) {
-			ieee80211_link_vlan_copy_chanctx(&sdata->deflink);
+			struct ieee80211_link_data *link;
+
+			for_each_link_data(sdata, link) {
+				ieee80211_link_vlan_copy_chanctx(link);
+			}
+
 			netif_carrier_on(dev);
 			ieee80211_set_vif_encap_ops(sdata);
 		} else {
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 46092fbcde90e..0525f9e44c37b 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -12,6 +12,71 @@
 #include "key.h"
 #include "debugfs_netdev.h"
 
+static void ieee80211_update_apvlan_links(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_sub_if_data *vlan;
+	struct ieee80211_link_data *link;
+	u16 ap_bss_links = sdata->vif.valid_links;
+	u16 new_links, vlan_links;
+	unsigned long add;
+
+	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list) {
+		int link_id;
+
+		if (!vlan)
+			continue;
+
+		/* No support for 4addr with MLO yet */
+		if (vlan->wdev.use_4addr)
+			return;
+
+		vlan_links = vlan->vif.valid_links;
+
+		new_links = ap_bss_links;
+
+		add = new_links & ~vlan_links;
+		if (!add)
+			continue;
+
+		ieee80211_vif_set_links(vlan, add, 0);
+
+		for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
+			link = sdata_dereference(vlan->link[link_id], vlan);
+			ieee80211_link_vlan_copy_chanctx(link);
+		}
+	}
+}
+
+void ieee80211_apvlan_link_setup(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_sub_if_data *ap_bss = container_of(sdata->bss,
+					    struct ieee80211_sub_if_data, u.ap);
+	u16 new_links = ap_bss->vif.valid_links;
+	unsigned long add;
+	int link_id;
+
+	if (!ap_bss->vif.valid_links)
+		return;
+
+	add = new_links;
+	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
+		sdata->wdev.valid_links |= BIT(link_id);
+		ether_addr_copy(sdata->wdev.links[link_id].addr,
+				ap_bss->wdev.links[link_id].addr);
+	}
+
+	ieee80211_vif_set_links(sdata, new_links, 0);
+}
+
+void ieee80211_apvlan_link_clear(struct ieee80211_sub_if_data *sdata)
+{
+	if (!sdata->wdev.valid_links)
+		return;
+
+	sdata->wdev.valid_links = 0;
+	ieee80211_vif_clear_links(sdata);
+}
+
 void ieee80211_link_setup(struct ieee80211_link_data *link)
 {
 	if (link->sdata->vif.type == NL80211_IFTYPE_STATION)
@@ -31,6 +96,17 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 	rcu_assign_pointer(sdata->vif.link_conf[link_id], link_conf);
 	rcu_assign_pointer(sdata->link[link_id], link);
 
+	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
+		struct ieee80211_sub_if_data *ap_bss;
+		struct ieee80211_bss_conf *ap_bss_conf;
+
+		ap_bss = container_of(sdata->bss,
+				      struct ieee80211_sub_if_data, u.ap);
+		ap_bss_conf = sdata_dereference(ap_bss->vif.link_conf[link_id],
+						ap_bss);
+		memcpy(link_conf, ap_bss_conf, sizeof(*link_conf));
+	}
+
 	link->sdata = sdata;
 	link->link_id = link_id;
 	link->conf = link_conf;
@@ -51,6 +127,7 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 	if (!deflink) {
 		switch (sdata->vif.type) {
 		case NL80211_IFTYPE_AP:
+		case NL80211_IFTYPE_AP_VLAN:
 			ether_addr_copy(link_conf->addr,
 					sdata->wdev.links[link_id].addr);
 			link_conf->bssid = link_conf->addr;
@@ -174,6 +251,7 @@ static void ieee80211_set_vif_links_bitmaps(struct ieee80211_sub_if_data *sdata,
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_AP_VLAN:
 		/* in an AP all links are always active */
 		sdata->vif.active_links = valid_links;
 
@@ -275,12 +353,16 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 		ieee80211_set_vif_links_bitmaps(sdata, new_links, dormant_links);
 
 		/* tell the driver */
-		ret = drv_change_vif_links(sdata->local, sdata,
-					   old_links & old_active,
-					   new_links & sdata->vif.active_links,
-					   old);
+		if (sdata->vif.type != NL80211_IFTYPE_AP_VLAN)
+			ret = drv_change_vif_links(sdata->local, sdata,
+						   old_links & old_active,
+						   new_links & sdata->vif.active_links,
+						   old);
 		if (!new_links)
 			ieee80211_debugfs_recreate_netdev(sdata, false);
+
+		if (sdata->vif.type == NL80211_IFTYPE_AP)
+			ieee80211_update_apvlan_links(sdata);
 	}
 
 	if (ret) {
-- 
2.39.5




