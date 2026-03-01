Return-Path: <stable+bounces-221890-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGxzI6Wpo2nfJQUAu9opvQ
	(envelope-from <stable+bounces-221890-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:51:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA40E1CDF91
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A45F131D8D28
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20F72C1788;
	Sun,  1 Mar 2026 01:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOllKSBu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63A5277C9D
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329384; cv=none; b=ilxQD+TPuOUpkwuS8gyflCWheNjYgb+XDb9pUQA0rIruqsgJjdISrV02DqTHIje7QowRJoq5qfdd4EfNGqCihcx5goJVvuk8mRIKqsv3cBv+fqRdaOM5hshxOB/UUcV2EIIn6NsdcgLQnXk1/IQiHb6r572g+CsWEJGmeIDmsBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329384; c=relaxed/simple;
	bh=nC6i27IF8T9hUfPgHhY7YbOJ0NvxHqKhESTNB2tWLak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O/uCgsbyCLk+R21mYd0K66Uu2fx3qlvMFEI1LNeTLz3jSwOwquZ3ZlUSwDW7n13UkM3ZMKwCddSvb7FbhJoRazcv0vIrhni1dYgMTFfuLwlUJ11vltQ5y336sk8ju0IV0B91yQLrnRfY5JQuDD6xyHvLWo59QwxVIA+Lsc9zGyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOllKSBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22701C19421;
	Sun,  1 Mar 2026 01:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329384;
	bh=nC6i27IF8T9hUfPgHhY7YbOJ0NvxHqKhESTNB2tWLak=;
	h=From:To:Cc:Subject:Date:From;
	b=BOllKSBuhpUi20X5jBQFVDMjYGcfYJwo2rD6GHo8ideRveSwijA9vdkPSHh0gTzZU
	 wb2ufhRhGK9/Ltb3KT74cDQSc92NWTbdbVjtZR+/hVBW/Hc6YMKbW3pvGlHQZktObf
	 yGsk0u20cl7CTCRfjri0ETUQbtW6Faz1to3VwI92xWnN0KfO4v8xN3hvP0JwayQMu9
	 N1PGUr4928u43Xy8NN+anwiicLL6Pg0+j6ELKV7QHgcXkBveVsn6dA0apNv+p61ghK
	 XSpyR7ijDqoGQmA6m+BcNblj7ZSvQBGQZ5y9wa4OMAKNRs3tIQE6xOsdQYN+MOis6U
	 fBMoxB31rliig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	luca.ceresoli@bootlin.com
Cc: Maxime Ripard <mripard@kernel.org>,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "drm: of: drm_of_panel_bridge_remove(): fix device_node leak" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:43:02 -0500
Message-ID: <20260301014303.1705028-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-221890-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: EA40E1CDF91
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
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





