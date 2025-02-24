Return-Path: <stable+bounces-118761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E76A41B0B
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39D73A3EDA
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6AC2505A2;
	Mon, 24 Feb 2025 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nfKOmYxF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D30F19F121
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392983; cv=none; b=Mt/FBofeYiMaY7F5fcg4Qkvo85P5b6mxj8hYsISEGfTTUTVh5j19MiuFdo2oupf039YFO47u18ixI8snyPu72IqjP+gf2SBTuL0QBtI9vvFr665/QOrDfEF8YAnDy48hTnyoa9IZz3DQtcqVpjXZNkml0fiknhUbGu1LfVyVUIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392983; c=relaxed/simple;
	bh=X2XcuCNCXaC419W6fLQAIqOSr/xP5PyL5ZYV19Z5sKA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Jzt+SC3BBFN3/i3w2NZmvDwAmABNWydK7CPSyG3K0clUJdnACbG5HjfT5kZDUsQdVvRYL1x5M0H/8GvbnjMNkyIM7SVSFTKUmi8eJlMnGLDuLpA9JeSGVHIi+xxkxHZ67FpqXyc4AZ7Ks0agaN24wILQUIQFySozqOBahs/n/uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nfKOmYxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66945C4CEE8;
	Mon, 24 Feb 2025 10:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740392983;
	bh=X2XcuCNCXaC419W6fLQAIqOSr/xP5PyL5ZYV19Z5sKA=;
	h=Subject:To:Cc:From:Date:From;
	b=nfKOmYxFWeEJDhQaiLEoX75zSWyc0sImkxUORaP6o3I9rAD+2e5hj/0n4gCDDZEm/
	 Izf7pqq7Z+qE+vImjaap0OHw0xFG9FPBGEvwePqM40kQdr7fJWrzqo1gn1Rm0b2s4L
	 P9cTMW/WLmDwDIzB6+/NFH64QcCB+Fk9fAlKydwg=
Subject: FAILED: patch "[PATCH] gve: set xdp redirect target only when it is available" failed to apply to 6.6-stable tree
To: joshwash@google.com,jeroendb@google.com,kuba@kernel.org,pkaligineedi@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Feb 2025 11:29:37 +0100
Message-ID: <2025022437-molecular-next-d0f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 415cadd505464d9a11ff5e0f6e0329c127849da5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025022437-molecular-next-d0f6@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 415cadd505464d9a11ff5e0f6e0329c127849da5 Mon Sep 17 00:00:00 2001
From: Joshua Washington <joshwash@google.com>
Date: Fri, 14 Feb 2025 14:43:59 -0800
Subject: [PATCH] gve: set xdp redirect target only when it is available

Before this patch the NETDEV_XDP_ACT_NDO_XMIT XDP feature flag is set by
default as part of driver initialization, and is never cleared. However,
this flag differs from others in that it is used as an indicator for
whether the driver is ready to perform the ndo_xdp_xmit operation as
part of an XDP_REDIRECT. Kernel helpers
xdp_features_(set|clear)_redirect_target exist to convey this meaning.

This patch ensures that the netdev is only reported as a redirect target
when XDP queues exist to forward traffic.

Fixes: 39a7f4aa3e4a ("gve: Add XDP REDIRECT support for GQI-QPL format")
Cc: stable@vger.kernel.org
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Jeroen de Borst <jeroendb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Link: https://patch.msgid.link/20250214224417.1237818-1-joshwash@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 8167cc5fb0df..78d2a19593d1 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1116,6 +1116,16 @@ static inline u32 gve_xdp_tx_start_queue_id(struct gve_priv *priv)
 	return gve_xdp_tx_queue_id(priv, 0);
 }
 
+static inline bool gve_supports_xdp_xmit(struct gve_priv *priv)
+{
+	switch (priv->queue_format) {
+	case GVE_GQI_QPL_FORMAT:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /* gqi napi handler defined in gve_main.c */
 int gve_napi_poll(struct napi_struct *napi, int budget);
 
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 533e659b15b3..92237fb0b60c 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1903,6 +1903,8 @@ static void gve_turndown(struct gve_priv *priv)
 	/* Stop tx queues */
 	netif_tx_disable(priv->dev);
 
+	xdp_features_clear_redirect_target(priv->dev);
+
 	gve_clear_napi_enabled(priv);
 	gve_clear_report_stats(priv);
 
@@ -1972,6 +1974,9 @@ static void gve_turnup(struct gve_priv *priv)
 		napi_schedule(&block->napi);
 	}
 
+	if (priv->num_xdp_queues && gve_supports_xdp_xmit(priv))
+		xdp_features_set_redirect_target(priv->dev, false);
+
 	gve_set_napi_enabled(priv);
 }
 
@@ -2246,7 +2251,6 @@ static void gve_set_netdev_xdp_features(struct gve_priv *priv)
 	if (priv->queue_format == GVE_GQI_QPL_FORMAT) {
 		xdp_features = NETDEV_XDP_ACT_BASIC;
 		xdp_features |= NETDEV_XDP_ACT_REDIRECT;
-		xdp_features |= NETDEV_XDP_ACT_NDO_XMIT;
 		xdp_features |= NETDEV_XDP_ACT_XSK_ZEROCOPY;
 	} else {
 		xdp_features = 0;


