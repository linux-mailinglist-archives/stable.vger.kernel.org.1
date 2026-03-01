Return-Path: <stable+bounces-221670-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBUcAquno2mWJAUAu9opvQ
	(envelope-from <stable+bounces-221670-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:42:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9311CDD5D
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26DB9322B374
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5BC2D7DEF;
	Sun,  1 Mar 2026 01:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTUYtjP7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8112513B58A
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328848; cv=none; b=oSMTdUrHl9OwP7NTtZq2gR6bvLkOUlTRAmkU7XxvCaaSstsTB3mWns8XwG94K3OWCyuyC6V4Gk1v34h2U/aIc9QNk5+uzLMsT7lpuABgcdGFloODvyA4/LCDePm0l8CMrEaKNgEPdVCwMb5AUjjd0RlvtPPbNnP3hm14IrwVx5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328848; c=relaxed/simple;
	bh=M3PMPSPG0Bw7uWjv8jBev8cZ9ajjLVnHRfgSr/agZlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I0NJTWD42sAUpcUifDSCMKzFIYSapp7MyTq14TOR+AnI4ams2YHUEewtxmvmlr8tPkSKlHrinxeBgXHUInQ8Be8Dk1LOpGPnNhFjFzc3xHtu84R2p5ls/DtReIv1GKaKwXmoExU/07Ib/AOzrURYXo1OSwLLQOURFBb2ZWacbBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTUYtjP7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A239FC19424;
	Sun,  1 Mar 2026 01:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328848;
	bh=M3PMPSPG0Bw7uWjv8jBev8cZ9ajjLVnHRfgSr/agZlo=;
	h=From:To:Cc:Subject:Date:From;
	b=pTUYtjP7ip5LpWTV4kifsZRsimZue5nXfBDNRnIuXZLkdr5PvG8hBlpWmQ/BdGzgM
	 MxPS3GKZGQN5C88eZui9iHoOuj35Fq5/yvT5/2eDfdoMN7U9yBnGFL/psX+LoK3uNS
	 H74F0t35lGM2MudGkPpwTNbmvgo33km/wpGNKiXnDHhjHABy/1puiQG/3SrJAAn4VK
	 HOkbXo6NA+RsUmrWu9E+IGBuPNFozwFz7PyHNaop1a7Qy7G0zGqpT5y3/0haWb5wsZ
	 EclNN5yyNEZUm/iZfolQHnz0FSUY5ksWlgTv9f6WjPHwJYZV64LhFYHe+CcX0gUF2I
	 YT7LzdXV+6iNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	luca.ceresoli@bootlin.com
Cc: Maxime Ripard <mripard@kernel.org>,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "drm: of: drm_of_panel_bridge_remove(): fix device_node leak" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:34:06 -0500
Message-ID: <20260301013406.1693491-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221670-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F9311CDD5D
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a4b4385d0523e39a7c058cb5a6c8269e513126ca Mon Sep 17 00:00:00 2001
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 9 Jan 2026 08:31:32 +0100
Subject: [PATCH] drm: of: drm_of_panel_bridge_remove(): fix device_node leak

drm_of_panel_bridge_remove() uses of_graph_get_remote_node() to get a
device_node but does not put the node reference.

Fixes: c70087e8f16f ("drm/drm_of: add drm_of_panel_bridge_remove function")
Cc: stable@vger.kernel.org # v4.15
Acked-by: Maxime Ripard <mripard@kernel.org>
Link: https://patch.msgid.link/20260109-drm-bridge-alloc-getput-drm_of_find_bridge-2-v2-1-8bad3ef90b9f@bootlin.com
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 include/drm/drm_of.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
index 7f0256dae3f13..f3e55ea2174c0 100644
--- a/include/drm/drm_of.h
+++ b/include/drm/drm_of.h
@@ -5,6 +5,7 @@
 #include <linux/err.h>
 #include <linux/of_graph.h>
 #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_PANEL_BRIDGE)
+#include <linux/of.h>
 #include <drm/drm_bridge.h>
 #endif
 
@@ -173,6 +174,8 @@ static inline int drm_of_panel_bridge_remove(const struct device_node *np,
 	bridge = of_drm_find_bridge(remote);
 	drm_panel_bridge_remove(bridge);
 
+	of_node_put(remote);
+
 	return 0;
 #else
 	return -EINVAL;
-- 
2.51.0





