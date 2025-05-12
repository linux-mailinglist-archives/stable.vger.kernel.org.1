Return-Path: <stable+bounces-143683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B84F7AB40E4
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5F919E7CB2
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 17:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70235254863;
	Mon, 12 May 2025 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GvbBEYlK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7311E505;
	Mon, 12 May 2025 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072743; cv=none; b=sEX+pmqCdH0BSGEMNxEMeHQwpK3R17JHqKopVg2BS1lamdiFAa50CnNy0Vj8iuGKAqF56RjNWoGZVIFlUTQMw6ABr0Wg7Alek6EtaeXTbjG3rrfd/ePSE7kjXtTP1O3Lz4IH1YhP0/nrjQvQL0rg+iltTOG8+EJe/QQVHzu1EV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072743; c=relaxed/simple;
	bh=NHaQFcl0kj5IRYUcqhVGiYViFCsvNxurZ3aUjxlJ96w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKhWHdeQuCA94axsF3V9M0isfYdLdXNJEMMkqPqCvIIrotWPrLMG4xNfrWU+SybmaU/Y7m/lqxHAUQSLDIxFdDcWF/wcdcl//ib/BFvN7Ufd2SMBXSS3YglZus50N6eBoJc6y0Lp5cis14rVtCZVIDBVFl7+cYUgb0CRjVCQ+w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GvbBEYlK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B36EC4CEE9;
	Mon, 12 May 2025 17:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747072743;
	bh=NHaQFcl0kj5IRYUcqhVGiYViFCsvNxurZ3aUjxlJ96w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GvbBEYlK3lIFAnYPfEslP3RDP0sJJ7grYqaETXpyhmguUhZdrZS5pmHJCmlMVzNw+
	 EdRjknjKPtGEcN4G4uNQcZutybD5Uk7GC2nm9KfrzViExVLjopcu1fc85g8f57BS+Y
	 w+mHDP6jighRuhdaUEo7AT5VTNWmxF4e1TszV/Ek=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 043/184] net: dsa: b53: fix toggling vlan_filtering
Date: Mon, 12 May 2025 19:44:04 +0200
Message-ID: <20250512172043.489188260@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172041.624042835@linuxfoundation.org>
References: <20250512172041.624042835@linuxfoundation.org>
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

From: Jonas Gorski <jonas.gorski@gmail.com>

[ Upstream commit 2dc2bd57111582895e10f54ea380329c89873f1c ]

To allow runtime switching between vlan aware and vlan non-aware mode,
we need to properly keep track of any bridge VLAN configuration.
Likewise, we need to know when we actually switch between both modes, to
not have to rewrite the full VLAN table every time we update the VLANs.

So keep track of the current vlan_filtering mode, and on changes, apply
the appropriate VLAN configuration.

Fixes: 0ee2af4ebbe3 ("net: dsa: set configure_vlan_while_not_filtering to true by default")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://patch.msgid.link/20250429201710.330937-10-jonas.gorski@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/b53/b53_common.c | 104 ++++++++++++++++++++++---------
 drivers/net/dsa/b53/b53_priv.h   |   2 +
 2 files changed, 75 insertions(+), 31 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 271189cf70dcc..d790fdf9fa3b4 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -763,6 +763,22 @@ static bool b53_vlan_port_needs_forced_tagged(struct dsa_switch *ds, int port)
 	return dev->tag_protocol == DSA_TAG_PROTO_NONE && dsa_is_cpu_port(ds, port);
 }
 
+static bool b53_vlan_port_may_join_untagged(struct dsa_switch *ds, int port)
+{
+	struct b53_device *dev = ds->priv;
+	struct dsa_port *dp;
+
+	if (!dev->vlan_filtering)
+		return true;
+
+	dp = dsa_to_port(ds, port);
+
+	if (dsa_port_is_cpu(dp))
+		return true;
+
+	return dp->bridge == NULL;
+}
+
 int b53_configure_vlan(struct dsa_switch *ds)
 {
 	struct b53_device *dev = ds->priv;
@@ -781,7 +797,7 @@ int b53_configure_vlan(struct dsa_switch *ds)
 		b53_do_vlan_op(dev, VTA_CMD_CLEAR);
 	}
 
-	b53_enable_vlan(dev, -1, dev->vlan_enabled, ds->vlan_filtering);
+	b53_enable_vlan(dev, -1, dev->vlan_enabled, dev->vlan_filtering);
 
 	/* Create an untagged VLAN entry for the default PVID in case
 	 * CONFIG_VLAN_8021Q is disabled and there are no calls to
@@ -789,26 +805,39 @@ int b53_configure_vlan(struct dsa_switch *ds)
 	 * entry. Do this only when the tagging protocol is not
 	 * DSA_TAG_PROTO_NONE
 	 */
+	v = &dev->vlans[def_vid];
 	b53_for_each_port(dev, i) {
-		v = &dev->vlans[def_vid];
-		v->members |= BIT(i);
+		if (!b53_vlan_port_may_join_untagged(ds, i))
+			continue;
+
+		vl.members |= BIT(i);
 		if (!b53_vlan_port_needs_forced_tagged(ds, i))
-			v->untag = v->members;
-		b53_write16(dev, B53_VLAN_PAGE,
-			    B53_VLAN_PORT_DEF_TAG(i), def_vid);
+			vl.untag = vl.members;
+		b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(i),
+			    def_vid);
 	}
+	b53_set_vlan_entry(dev, def_vid, &vl);
 
-	/* Upon initial call we have not set-up any VLANs, but upon
-	 * system resume, we need to restore all VLAN entries.
-	 */
-	for (vid = def_vid; vid < dev->num_vlans; vid++) {
-		v = &dev->vlans[vid];
+	if (dev->vlan_filtering) {
+		/* Upon initial call we have not set-up any VLANs, but upon
+		 * system resume, we need to restore all VLAN entries.
+		 */
+		for (vid = def_vid + 1; vid < dev->num_vlans; vid++) {
+			v = &dev->vlans[vid];
 
-		if (!v->members)
-			continue;
+			if (!v->members)
+				continue;
+
+			b53_set_vlan_entry(dev, vid, v);
+			b53_fast_age_vlan(dev, vid);
+		}
 
-		b53_set_vlan_entry(dev, vid, v);
-		b53_fast_age_vlan(dev, vid);
+		b53_for_each_port(dev, i) {
+			if (!dsa_is_cpu_port(ds, i))
+				b53_write16(dev, B53_VLAN_PAGE,
+					    B53_VLAN_PORT_DEF_TAG(i),
+					    dev->ports[i].pvid);
+		}
 	}
 
 	return 0;
@@ -1128,7 +1157,9 @@ EXPORT_SYMBOL(b53_setup_devlink_resources);
 static int b53_setup(struct dsa_switch *ds)
 {
 	struct b53_device *dev = ds->priv;
+	struct b53_vlan *vl;
 	unsigned int port;
+	u16 pvid;
 	int ret;
 
 	/* Request bridge PVID untagged when DSA_TAG_PROTO_NONE is set
@@ -1147,6 +1178,15 @@ static int b53_setup(struct dsa_switch *ds)
 		return ret;
 	}
 
+	/* setup default vlan for filtering mode */
+	pvid = b53_default_pvid(dev);
+	vl = &dev->vlans[pvid];
+	b53_for_each_port(dev, port) {
+		vl->members |= BIT(port);
+		if (!b53_vlan_port_needs_forced_tagged(ds, port))
+			vl->untag |= BIT(port);
+	}
+
 	b53_reset_mib(dev);
 
 	ret = b53_apply_config(dev);
@@ -1500,7 +1540,10 @@ int b53_vlan_filtering(struct dsa_switch *ds, int port, bool vlan_filtering,
 {
 	struct b53_device *dev = ds->priv;
 
-	b53_enable_vlan(dev, port, dev->vlan_enabled, vlan_filtering);
+	if (dev->vlan_filtering != vlan_filtering) {
+		dev->vlan_filtering = vlan_filtering;
+		b53_apply_config(dev);
+	}
 
 	return 0;
 }
@@ -1525,7 +1568,7 @@ static int b53_vlan_prepare(struct dsa_switch *ds, int port,
 	if (vlan->vid >= dev->num_vlans)
 		return -ERANGE;
 
-	b53_enable_vlan(dev, port, true, ds->vlan_filtering);
+	b53_enable_vlan(dev, port, true, dev->vlan_filtering);
 
 	return 0;
 }
@@ -1548,21 +1591,17 @@ int b53_vlan_add(struct dsa_switch *ds, int port,
 	if (vlan->vid == 0)
 		return 0;
 
-	if (!ds->vlan_filtering)
-		return 0;
-
-	b53_read16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(port), &old_pvid);
+	old_pvid = dev->ports[port].pvid;
 	if (pvid)
 		new_pvid = vlan->vid;
 	else if (!pvid && vlan->vid == old_pvid)
 		new_pvid = b53_default_pvid(dev);
 	else
 		new_pvid = old_pvid;
+	dev->ports[port].pvid = new_pvid;
 
 	vl = &dev->vlans[vlan->vid];
 
-	b53_get_vlan_entry(dev, vlan->vid, vl);
-
 	if (dsa_is_cpu_port(ds, port))
 		untagged = false;
 
@@ -1572,6 +1611,9 @@ int b53_vlan_add(struct dsa_switch *ds, int port,
 	else
 		vl->untag &= ~BIT(port);
 
+	if (!dev->vlan_filtering)
+		return 0;
+
 	b53_set_vlan_entry(dev, vlan->vid, vl);
 	b53_fast_age_vlan(dev, vlan->vid);
 
@@ -1596,23 +1638,22 @@ int b53_vlan_del(struct dsa_switch *ds, int port,
 	if (vlan->vid == 0)
 		return 0;
 
-	if (!ds->vlan_filtering)
-		return 0;
-
-	b53_read16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(port), &pvid);
+	pvid = dev->ports[port].pvid;
 
 	vl = &dev->vlans[vlan->vid];
 
-	b53_get_vlan_entry(dev, vlan->vid, vl);
-
 	vl->members &= ~BIT(port);
 
 	if (pvid == vlan->vid)
 		pvid = b53_default_pvid(dev);
+	dev->ports[port].pvid = pvid;
 
 	if (untagged && !b53_vlan_port_needs_forced_tagged(ds, port))
 		vl->untag &= ~(BIT(port));
 
+	if (!dev->vlan_filtering)
+		return 0;
+
 	b53_set_vlan_entry(dev, vlan->vid, vl);
 	b53_fast_age_vlan(dev, vlan->vid);
 
@@ -1959,7 +2000,7 @@ int b53_br_join(struct dsa_switch *ds, int port, struct dsa_bridge bridge,
 	pvid = b53_default_pvid(dev);
 	vl = &dev->vlans[pvid];
 
-	if (ds->vlan_filtering) {
+	if (dev->vlan_filtering) {
 		/* Make this port leave the all VLANs join since we will have
 		 * proper VLAN entries from now on
 		 */
@@ -2039,7 +2080,7 @@ void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge)
 	pvid = b53_default_pvid(dev);
 	vl = &dev->vlans[pvid];
 
-	if (ds->vlan_filtering) {
+	if (dev->vlan_filtering) {
 		/* Make this port join all VLANs without VLAN entries */
 		if (is58xx(dev)) {
 			b53_read16(dev, B53_VLAN_PAGE, B53_JOIN_ALL_VLAN_EN, &reg);
@@ -2797,6 +2838,7 @@ struct b53_device *b53_switch_alloc(struct device *base,
 	ds->ops = &b53_switch_ops;
 	ds->phylink_mac_ops = &b53_phylink_mac_ops;
 	dev->vlan_enabled = true;
+	dev->vlan_filtering = false;
 	/* Let DSA handle the case were multiple bridges span the same switch
 	 * device and different VLAN awareness settings are requested, which
 	 * would be breaking filtering semantics for any of the other bridge
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index 05141176daf50..e9aab4f8d15e1 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -95,6 +95,7 @@ struct b53_pcs {
 
 struct b53_port {
 	u16		vlan_ctl_mask;
+	u16		pvid;
 	struct ethtool_keee eee;
 };
 
@@ -146,6 +147,7 @@ struct b53_device {
 	unsigned int num_vlans;
 	struct b53_vlan *vlans;
 	bool vlan_enabled;
+	bool vlan_filtering;
 	unsigned int num_ports;
 	struct b53_port *ports;
 
-- 
2.39.5




