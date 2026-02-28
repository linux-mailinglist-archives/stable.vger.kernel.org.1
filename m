Return-Path: <stable+bounces-220722-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGkcIOVUo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220722-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:49:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D76321C8903
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 980203329E96
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88ED3FE077;
	Sat, 28 Feb 2026 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnVd0gcM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B40F3FE071;
	Sat, 28 Feb 2026 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300602; cv=none; b=buH15UOV4PyKA0XbqbZpAPgHk2p6VLuARLl37vZ73vKZB/8T+y8hw3c8n+s2Irmxh56Y6U6FyexDaYcMXFkuRAb7JJktsdijUrl9TTjKsi2NXGPK93mMpf08NWBZVIqMaTJaq+vII59CKrolTA4jUvzb7YUfT/MQl7V8TGdJ/pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300602; c=relaxed/simple;
	bh=F4MJejqL9xPFVLoPwmRms9z9fysULGQptS0CePkzVu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYsjRJh2DPgQkHS3q5aGyf3FpHerwVIv6WmviBC3z7mFeEo1+7lgad/JxLrRPoqWpD0ruhn30jtZycjD9Sw+vMZTKptl/LBCr8Wyv1UK4JjOqiEgMNlUooprHdc+MgURdOYIBK8GUxWF8TcULjcQZR3Esh2Yx5a/ObEe9I9C+5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnVd0gcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54D0C19425;
	Sat, 28 Feb 2026 17:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300602;
	bh=F4MJejqL9xPFVLoPwmRms9z9fysULGQptS0CePkzVu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NnVd0gcM19+3FWDLKzlexsFOMKqmfmdGu+BZuhHyPKeqinG1s1Kxu2vxXSuwIEHOB
	 Txm+m3xPjuDT+snKfZ1xPSt+SiPfGPmktNJrS6vdVgGT/O87DTGS4+ccTao2CktxTY
	 5IYQtYt24ZB8o/fN9A4cUlAd3QEBTU1mcVu8x3vpdp9v2Rhnuf5cysnmt/9zlHGuVW
	 TV1ZJlI3wPJLOQmQ/qmBsmLneCrrYhis2eOQhaZclEnF0f+VrXD4Zs3/u9MIeZA286
	 q2IzbckvQazHm9ZGSiTmDBzNMjqKOUEkalzCxRCkf3/bJ+s6OnTAklQNIGzu9VDgzW
	 tLWD8r7DmDR1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 643/844] drm: of: drm_of_panel_bridge_remove(): fix device_node leak
Date: Sat, 28 Feb 2026 12:29:16 -0500
Message-ID: <20260228173244.1509663-644-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220722-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Queue-Id: D76321C8903
X-Rspamd-Action: no action

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

[ Upstream commit a4b4385d0523e39a7c058cb5a6c8269e513126ca ]

drm_of_panel_bridge_remove() uses of_graph_get_remote_node() to get a
device_node but does not put the node reference.

Fixes: c70087e8f16f ("drm/drm_of: add drm_of_panel_bridge_remove function")
Cc: stable@vger.kernel.org # v4.15
Acked-by: Maxime Ripard <mripard@kernel.org>
Link: https://patch.msgid.link/20260109-drm-bridge-alloc-getput-drm_of_find_bridge-2-v2-1-8bad3ef90b9f@bootlin.com
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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


