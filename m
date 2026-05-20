Return-Path: <stable+bounces-251872-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FwsKOj2DWry4wUAu9opvQ
	(envelope-from <stable+bounces-251872-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:01:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A47F5951DB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9BC8D3088AA9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F244B3F1AD9;
	Wed, 20 May 2026 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KYofV0eM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860783F2115;
	Wed, 20 May 2026 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299107; cv=none; b=qKNzPmQS+o4jlxCuo8x1K8JtO07wFadvmxRLkHQpZTmCkPxz/S+PEXEjhOi3UtIhl2ep7GQL4X4SOXmXcIofdbfbROFpJISdXQhksDE+bAc2QR/CN5buKjK0lvQnE2ckN20x/WPsTvzcBQLNmBfbTg9IIejs2pBieDujcMa3BhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299107; c=relaxed/simple;
	bh=oLHWKQfHHMb5nxIMCoAn5q4ss3kk/o+1aLX2fHy/EnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqMXerlR9DJ2JJW1t1GZsrOYEhOpK1c+qXciN1ArvUxI4FDGZ850EkP5QEXuIiZ5FAMtVXDVINuQbMRzj7eegKYUY6fe628hTpI1lCy6JpVhd0v6E4wFmLGbZEDmVZLDcyy+0k+gipfV0to21/Zbohy4vAb4xWPn++XHmZFJTO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KYofV0eM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2061F000E9;
	Wed, 20 May 2026 17:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299106;
	bh=LdPnEGyFSpek7f0EepYEXvUayvjDZoMMGM2HlJ617m8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KYofV0eMJdaccemeeUNG4fqCD66506U/WSLrQQwaeZ35V8bbD/8HWPmiXGF2slaKC
	 pooGJyC7E5AjL3EYOFYaAZMkhykK6qidc5RpZWkOky+4rHhgsa7nApa9nQpTViX2Ye
	 J5hE28CXNkzIVTu8JPEU+ejEMPTJ16PHjXBC7PHE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 623/957] net: dsa: append ethtool counters of all hidden ports to conduit
Date: Wed, 20 May 2026 18:18:26 +0200
Message-ID: <20260520162148.041661058@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251872-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 5A47F5951DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit f647ed2ca78ec4efcc436915b441da9de0974926 ]

Currently there is no way to see packet counters on cascade ports, and
no clarity on how the API for that would look like.

Because it's something that is currently needed, just extend the hack
where ethtool -S on the conduit interface dumps CPU port counters, and
also use it to dump counters of cascade ports.

Note that the "pXX_" naming convention changes to "sXX_pYY", to
distinguish between ports having the same index but belonging to
different switches. This has a slight chance of causing regressions to
existing tooling:

- grepping for "p04_counter_name" still works, but might return more
  than one string now
- grepping for "    p04_counter_name" no longer works

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20251122112311.138784-4-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 0f99e0c3e19b ("net: dsa: remove redundant netdev_lock_ops() from conduit ethtool ops")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/dsa/conduit.c | 126 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 93 insertions(+), 33 deletions(-)

diff --git a/net/dsa/conduit.c b/net/dsa/conduit.c
index c210e31296558..a1b044467bd6f 100644
--- a/net/dsa/conduit.c
+++ b/net/dsa/conduit.c
@@ -87,25 +87,51 @@ static void dsa_conduit_get_regs(struct net_device *dev,
 	}
 }
 
+static ssize_t dsa_conduit_append_port_stats(struct dsa_switch *ds, int port,
+					     u64 *data, size_t start)
+{
+	int count;
+
+	if (!ds->ops->get_sset_count)
+		return 0;
+
+	count = ds->ops->get_sset_count(ds, port, ETH_SS_STATS);
+	if (count < 0)
+		return count;
+
+	if (ds->ops->get_ethtool_stats)
+		ds->ops->get_ethtool_stats(ds, port, data + start);
+
+	return count;
+}
+
 static void dsa_conduit_get_ethtool_stats(struct net_device *dev,
 					  struct ethtool_stats *stats,
 					  u64 *data)
 {
-	struct dsa_port *cpu_dp = dev->dsa_ptr;
+	struct dsa_port *dp, *cpu_dp = dev->dsa_ptr;
 	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
-	struct dsa_switch *ds = cpu_dp->ds;
-	int port = cpu_dp->index;
-	int count = 0;
+	struct dsa_switch_tree *dst = cpu_dp->dst;
+	int count, mcount = 0;
 
 	if (ops && ops->get_sset_count && ops->get_ethtool_stats) {
 		netdev_lock_ops(dev);
-		count = ops->get_sset_count(dev, ETH_SS_STATS);
+		mcount = ops->get_sset_count(dev, ETH_SS_STATS);
 		ops->get_ethtool_stats(dev, stats, data);
 		netdev_unlock_ops(dev);
 	}
 
-	if (ds->ops->get_ethtool_stats)
-		ds->ops->get_ethtool_stats(ds, port, data + count);
+	list_for_each_entry(dp, &dst->ports, list) {
+		if (!dsa_port_is_dsa(dp) && !dsa_port_is_cpu(dp))
+			continue;
+
+		count = dsa_conduit_append_port_stats(dp->ds, dp->index,
+						      data, mcount);
+		if (count < 0)
+			return;
+
+		mcount += count;
+	}
 }
 
 static void dsa_conduit_get_ethtool_phy_stats(struct net_device *dev,
@@ -136,11 +162,18 @@ static void dsa_conduit_get_ethtool_phy_stats(struct net_device *dev,
 		ds->ops->get_ethtool_phy_stats(ds, port, data + count);
 }
 
+static void dsa_conduit_append_port_sset_count(struct dsa_switch *ds, int port,
+					       int sset, int *count)
+{
+	if (ds->ops->get_sset_count)
+		*count += ds->ops->get_sset_count(ds, port, sset);
+}
+
 static int dsa_conduit_get_sset_count(struct net_device *dev, int sset)
 {
-	struct dsa_port *cpu_dp = dev->dsa_ptr;
+	struct dsa_port *dp, *cpu_dp = dev->dsa_ptr;
 	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
-	struct dsa_switch *ds = cpu_dp->ds;
+	struct dsa_switch_tree *dst = cpu_dp->dst;
 	int count = 0;
 
 	netdev_lock_ops(dev);
@@ -154,26 +187,57 @@ static int dsa_conduit_get_sset_count(struct net_device *dev, int sset)
 	if (count < 0)
 		count = 0;
 
-	if (ds->ops->get_sset_count)
-		count += ds->ops->get_sset_count(ds, cpu_dp->index, sset);
+	list_for_each_entry(dp, &dst->ports, list) {
+		if (!dsa_port_is_dsa(dp) && !dsa_port_is_cpu(dp))
+			continue;
+
+		dsa_conduit_append_port_sset_count(dp->ds, dp->index, sset,
+						   &count);
+	}
 
 	return count;
 }
 
-static void dsa_conduit_get_strings(struct net_device *dev, u32 stringset,
-				    u8 *data)
+static ssize_t dsa_conduit_append_port_strings(struct dsa_switch *ds, int port,
+					       u32 stringset, u8 *data,
+					       size_t start)
 {
-	struct dsa_port *cpu_dp = dev->dsa_ptr;
-	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
-	struct dsa_switch *ds = cpu_dp->ds;
-	int port = cpu_dp->index;
 	int len = ETH_GSTRING_LEN;
-	int mcount = 0, count, i;
-	u8 pfx[4], *ndata;
+	u8 pfx[8], *ndata;
+	int count, i;
+
+	if (!ds->ops->get_strings)
+		return 0;
 
-	snprintf(pfx, sizeof(pfx), "p%.2d", port);
+	snprintf(pfx, sizeof(pfx), "s%.2d_p%.2d", ds->index, port);
 	/* We do not want to be NULL-terminated, since this is a prefix */
 	pfx[sizeof(pfx) - 1] = '_';
+	ndata = data + start * len;
+	/* This function copies ETH_GSTRINGS_LEN bytes, we will mangle
+	 * the output after to prepend our CPU port prefix we
+	 * constructed earlier
+	 */
+	ds->ops->get_strings(ds, port, stringset, ndata);
+	count = ds->ops->get_sset_count(ds, port, stringset);
+	if (count < 0)
+		return count;
+
+	for (i = 0; i < count; i++) {
+		memmove(ndata + (i * len + sizeof(pfx)),
+			ndata + i * len, len - sizeof(pfx));
+		memcpy(ndata + i * len, pfx, sizeof(pfx));
+	}
+
+	return count;
+}
+
+static void dsa_conduit_get_strings(struct net_device *dev, u32 stringset,
+				    u8 *data)
+{
+	struct dsa_port *dp, *cpu_dp = dev->dsa_ptr;
+	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
+	struct dsa_switch_tree *dst = cpu_dp->dst;
+	int count, mcount = 0;
 
 	netdev_lock_ops(dev);
 	if (stringset == ETH_SS_PHY_STATS && dev->phydev &&
@@ -191,21 +255,17 @@ static void dsa_conduit_get_strings(struct net_device *dev, u32 stringset,
 	}
 	netdev_unlock_ops(dev);
 
-	if (ds->ops->get_strings) {
-		ndata = data + mcount * len;
-		/* This function copies ETH_GSTRINGS_LEN bytes, we will mangle
-		 * the output after to prepend our CPU port prefix we
-		 * constructed earlier
-		 */
-		ds->ops->get_strings(ds, port, stringset, ndata);
-		count = ds->ops->get_sset_count(ds, port, stringset);
+	list_for_each_entry(dp, &dst->ports, list) {
+		if (!dsa_port_is_dsa(dp) && !dsa_port_is_cpu(dp))
+			continue;
+
+		count = dsa_conduit_append_port_strings(dp->ds, dp->index,
+							stringset, data,
+							mcount);
 		if (count < 0)
 			return;
-		for (i = 0; i < count; i++) {
-			memmove(ndata + (i * len + sizeof(pfx)),
-				ndata + i * len, len - sizeof(pfx));
-			memcpy(ndata + i * len, pfx, sizeof(pfx));
-		}
+
+		mcount += count;
 	}
 }
 
-- 
2.53.0




