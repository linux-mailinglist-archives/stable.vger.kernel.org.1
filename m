Return-Path: <stable+bounces-251871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0dZ+BUcCDmra5QUAu9opvQ
	(envelope-from <stable+bounces-251871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:49:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F372597452
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E19231A3999
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761FE3F1AD9;
	Wed, 20 May 2026 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N1yIAFY2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AAF2F0C62;
	Wed, 20 May 2026 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299105; cv=none; b=F9juwPlGBvISv5bVulGO0Qvb9wyf3mRZrLEBU0FtL3Jm8o/y1OyMgLk8UXeUUN/YEpKnP91FeOVA+o2JbkqMTWgdin4Bv4NAEE+rSH/qs64tQ0NVNlFr0857WNpmW3tDhNJKlJA0FzBXU6UZmGvpvTNPD8QqYTv5xhtFifhy650=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299105; c=relaxed/simple;
	bh=wyoa+hg1L3OVQm3ACLuvtntNVS50OOVSpcjKe4fqH3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzAobrJxc4VC4iyxMDK6a+y3WxrcRLo6y5uqPSmsXqyx2rM+EKrUy4dN+bDqizLU4IykBO4XEtYtutYNXn7rhK5a9CeQYW7zqcO+0E1On7xBnZhVxx529sXyAQXAf1Yvdaqbew9VsMf7NtcBYwGtehvh+Bx2nflf2tN14VjeWAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N1yIAFY2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775461F000E9;
	Wed, 20 May 2026 17:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299103;
	bh=3kWooR6MjEuREeMUAPbSiu9k6P2t4b54SsMTU2MgLio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N1yIAFY2Jn7XvC4Zr1cvbic2UiBXGcSlAPrhh2f01G3N+qw5PRtSuw82h9DhA3BSS
	 0td7MNHLHh1gZu+hC9Uw9ZJ9uusN0Xh9ZbTc5hUNYM/scZQO2TUR2Zy+gnLp5wje4g
	 R4IWhkKAanBNhNq/iu+M9x2r43EdniNmV4H5ajr0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 622/957] net: dsa: use kernel data types for ethtool ops on conduit
Date: Wed, 20 May 2026 18:18:25 +0200
Message-ID: <20260520162148.020585855@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251871-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lunn.ch:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,nxp.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 2F372597452
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 8afabd27fe46ebf991b4aea20b74e08196c15c0c ]

Suppress some checkpatch 'CHECK' messages about u8 being preferable over
uint8_t, etc. No functional change.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20251122112311.138784-3-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 0f99e0c3e19b ("net: dsa: remove redundant netdev_lock_ops() from conduit ethtool ops")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/dsa/conduit.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/dsa/conduit.c b/net/dsa/conduit.c
index f80795b3d0460..c210e31296558 100644
--- a/net/dsa/conduit.c
+++ b/net/dsa/conduit.c
@@ -89,7 +89,7 @@ static void dsa_conduit_get_regs(struct net_device *dev,
 
 static void dsa_conduit_get_ethtool_stats(struct net_device *dev,
 					  struct ethtool_stats *stats,
-					  uint64_t *data)
+					  u64 *data)
 {
 	struct dsa_port *cpu_dp = dev->dsa_ptr;
 	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
@@ -110,7 +110,7 @@ static void dsa_conduit_get_ethtool_stats(struct net_device *dev,
 
 static void dsa_conduit_get_ethtool_phy_stats(struct net_device *dev,
 					      struct ethtool_stats *stats,
-					      uint64_t *data)
+					      u64 *data)
 {
 	struct dsa_port *cpu_dp = dev->dsa_ptr;
 	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
@@ -160,8 +160,8 @@ static int dsa_conduit_get_sset_count(struct net_device *dev, int sset)
 	return count;
 }
 
-static void dsa_conduit_get_strings(struct net_device *dev, uint32_t stringset,
-				    uint8_t *data)
+static void dsa_conduit_get_strings(struct net_device *dev, u32 stringset,
+				    u8 *data)
 {
 	struct dsa_port *cpu_dp = dev->dsa_ptr;
 	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
@@ -169,8 +169,7 @@ static void dsa_conduit_get_strings(struct net_device *dev, uint32_t stringset,
 	int port = cpu_dp->index;
 	int len = ETH_GSTRING_LEN;
 	int mcount = 0, count, i;
-	uint8_t pfx[4];
-	uint8_t *ndata;
+	u8 pfx[4], *ndata;
 
 	snprintf(pfx, sizeof(pfx), "p%.2d", port);
 	/* We do not want to be NULL-terminated, since this is a prefix */
-- 
2.53.0




