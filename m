Return-Path: <stable+bounces-253784-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPVDIsdVEGraWQYAu9opvQ
	(envelope-from <stable+bounces-253784-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 15:10:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D42D15B4D98
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 15:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 771C33077DD1
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 13:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C91394E80;
	Fri, 22 May 2026 13:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XA6IHRVY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5975390C90
	for <stable@vger.kernel.org>; Fri, 22 May 2026 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779454984; cv=none; b=qa0OokYdkrSxOCvlO9j8yigkqKnQc64ucTA0MPDoHWx/HXbAyWTIx6bEbpNANFD2JqRJ880kVPHzMEBmcBvMP+YdMCA6Tebe81xVTqVSAO2TuhC05D/57QPJZ7opH/D8KF9sAEO1ID2bndz/6Ij66cGs29+yDZU7HlE7oii0CdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779454984; c=relaxed/simple;
	bh=oEyyydVtfllvbG13Jf8cLjDq1gqI45jXBP9OUepInaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APFh5uXExSd4LB/Ln4IU3/LQ4BF9F9eCfOcz2rf6WYgC28NZ5JuPxBlaBw6sJjxWwRwm9W69gGRQMfoOq81bw0/U2uYxjYM8LxXtOyRLyF2FgG202fkE56TjaLB57nc/6ktvgyv7Q6+UdVvPRLvx6MEelQSUi3j3C7ADKLm7W3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XA6IHRVY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EE71F00A3D;
	Fri, 22 May 2026 13:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779454982;
	bh=DBTwnpoPL3/orF/z018RvQVZMqbhHFyUKxasykV9jco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XA6IHRVY00NgqCnemljzfRTSy57RvDkVclrdkHFhF2f0uHz3gIwc/2slv827+tbix
	 otbqGmk2ZfgZmmjM4P3vKcQWsD1qnSgM+k1oWTJKS38vIpY2LRHlxfRGYkf2i+25ug
	 HvX4xEPZdjMaLhRuPaGccZ2CftkUTPoYPRU4pfjV/ex3ZdRv55pnApR+7qbMeS56JR
	 3reJk63FmGn2vJO40y5hOAV5WFtitms541nrdAvpUu3Y41ZxprIvvozPn/urSab7/Y
	 RLcDFhXxqeqCMTGFgHoxtkF8RxVtk89koac/bOD+NZXy72MiFj+AlO1EHAzFJ07Jj0
	 mTHo5O5zjEJeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Quan Sun <2022090917019@std.uestc.edu.cn>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] net: ethtool: fix NULL pointer dereference in phy_reply_size
Date: Fri, 22 May 2026 09:02:59 -0400
Message-ID: <20260522130300.3869084-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051922-hardness-swizzle-86b5@gregkh>
References: <2026051922-hardness-swizzle-86b5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253784-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email,msgid.link:url,uestc.edu.cn:email]
X-Rspamd-Queue-Id: D42D15B4D98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Quan Sun <2022090917019@std.uestc.edu.cn>

[ Upstream commit 4908f1395fb1b832ceec11584af649874a2732ea ]

In phy_prepare_data(), several strings such as 'name', 'drvname',
'upstream_sfp_name', and 'downstream_sfp_name' are allocated using
kstrdup(). However, these allocations were not checked  for failure.

If kstrdup() fails for 'name', it returns NULL while the function
continues. This leads to a kernel NULL pointer dereference and panic
later in phy_reply_size() when it unconditionally calls strlen() on
the NULL pointer.

While other strings like 'upstream_sfp_name' might be checked before
access in certain code paths, failing to handle these allocations
consistently can lead to incomplete data reporting or hidden bugs.

Fix this by adding proper NULL checks for all kstrdup() calls in
phy_prepare_data() and implement a centralized error handling path
using goto labels to ensure all previously allocated resources are
freed on failure.

Fixes: 9dd2ad5e92b9 ("net: ethtool: phy: Convert the PHY_GET command to generic phy dump")
Signed-off-by: Quan Sun <2022090917019@std.uestc.edu.cn>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Link: https://patch.msgid.link/20260507131738.1173835-1-2022090917019@std.uestc.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: e3adf69f8eb1 ("net: ethtool: phy: avoid NULL deref when PHY driver is unbound")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ethtool/phy.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index 68372bef4b2fe..cb1e0aea450f9 100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -76,6 +76,7 @@ static int phy_prepare_data(const struct ethnl_req_info *req_info,
 	struct nlattr **tb = info->attrs;
 	struct phy_device_node *pdn;
 	struct phy_device *phydev;
+	int ret;
 
 	/* RTNL is held by the caller */
 	phydev = ethnl_req_get_phydev(req_info, tb, ETHTOOL_A_PHY_HEADER,
@@ -88,8 +89,17 @@ static int phy_prepare_data(const struct ethnl_req_info *req_info,
 		return -EOPNOTSUPP;
 
 	rep_data->phyindex = phydev->phyindex;
+
 	rep_data->name = kstrdup(dev_name(&phydev->mdio.dev), GFP_KERNEL);
+	if (!rep_data->name)
+		return -ENOMEM;
+
 	rep_data->drvname = kstrdup(phydev->drv->name, GFP_KERNEL);
+	if (!rep_data->drvname) {
+		ret = -ENOMEM;
+		goto err_free_name;
+	}
+
 	rep_data->upstream_type = pdn->upstream_type;
 
 	if (pdn->upstream_type == PHY_UPSTREAM_PHY) {
@@ -97,15 +107,33 @@ static int phy_prepare_data(const struct ethnl_req_info *req_info,
 		rep_data->upstream_index = upstream->phyindex;
 	}
 
-	if (pdn->parent_sfp_bus)
+	if (pdn->parent_sfp_bus) {
 		rep_data->upstream_sfp_name = kstrdup(sfp_get_name(pdn->parent_sfp_bus),
 						      GFP_KERNEL);
+		if (!rep_data->upstream_sfp_name) {
+			ret = -ENOMEM;
+			goto err_free_drvname;
+		}
+	}
 
-	if (phydev->sfp_bus)
+	if (phydev->sfp_bus) {
 		rep_data->downstream_sfp_name = kstrdup(sfp_get_name(phydev->sfp_bus),
 							GFP_KERNEL);
+		if (!rep_data->downstream_sfp_name) {
+			ret = -ENOMEM;
+			goto err_free_upstream_sfp;
+		}
+	}
 
 	return 0;
+
+err_free_upstream_sfp:
+	kfree(rep_data->upstream_sfp_name);
+err_free_drvname:
+	kfree(rep_data->drvname);
+err_free_name:
+	kfree(rep_data->name);
+	return ret;
 }
 
 static int phy_fill_reply(struct sk_buff *skb,
-- 
2.53.0


