Return-Path: <stable+bounces-119348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855C6A424D3
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF3FA7AA174
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A631514CC;
	Mon, 24 Feb 2025 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dbHYZoZ6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1417E2571CA;
	Mon, 24 Feb 2025 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740409161; cv=none; b=CAV2W40o9vyC3Z1dL0TPeyv0BlkkQ8NiQZHdxRZUP+Pn2XdpBNz8xA4PK3NXQWpfNzz1vHNgL929cdelDe+8BM+3jh2Xf+OLUf0HKHfNGN0WRd5p+YQ4rABXXJ0p7/l6oet9oNqNx/GrcpOQrzOK8baTMJW2rxEqscqlTMicOMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740409161; c=relaxed/simple;
	bh=sJI9mIQPdX2TcJ60LNBwR8FoFRi0SqweWjitELoPujE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mw2evkzBxoy3Nelz5oiQeo95yvTGhonOFz87Z1UU5W4bxEq3QMVRGWKknFhQg2UqPls9NCBkOrjV1xoap8bUWuGAamPnxjPD2MFAgxAOgueUGtKu/1MQ9XWcVUDfV8DhsjsdaWhL+xtCLpJ6osCGtJhUaZKzMMLDm6POdyexelA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dbHYZoZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC8FC4CEE6;
	Mon, 24 Feb 2025 14:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740409160;
	bh=sJI9mIQPdX2TcJ60LNBwR8FoFRi0SqweWjitELoPujE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dbHYZoZ6wrEQ36CH2cmx700JNt31HB7DWXhEmaKd0HWatDOSHwbqjlUUzoxNFnAIg
	 5i3PXjo6PWSr037DfoK3I4Le17f1aBo5g+uwF5Bi5zykFyZFHcVo4paTDT4gaCA3BW
	 +qY7nQdGd6bWDu/5azq5eSzJ20d1Bmdmotn+Jb0Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Jeroen de Borst <jeroendb@google.com>,
	Joshua Washington <joshwash@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.13 114/138] gve: set xdp redirect target only when it is available
Date: Mon, 24 Feb 2025 15:35:44 +0100
Message-ID: <20250224142608.958169629@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142604.442289573@linuxfoundation.org>
References: <20250224142604.442289573@linuxfoundation.org>
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

From: Joshua Washington <joshwash@google.com>

commit 415cadd505464d9a11ff5e0f6e0329c127849da5 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/google/gve/gve.h      |   10 ++++++++++
 drivers/net/ethernet/google/gve/gve_main.c |    6 +++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1116,6 +1116,16 @@ static inline u32 gve_xdp_tx_start_queue
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
 
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1903,6 +1903,8 @@ static void gve_turndown(struct gve_priv
 	/* Stop tx queues */
 	netif_tx_disable(priv->dev);
 
+	xdp_features_clear_redirect_target(priv->dev);
+
 	gve_clear_napi_enabled(priv);
 	gve_clear_report_stats(priv);
 
@@ -1972,6 +1974,9 @@ static void gve_turnup(struct gve_priv *
 		napi_schedule(&block->napi);
 	}
 
+	if (priv->num_xdp_queues && gve_supports_xdp_xmit(priv))
+		xdp_features_set_redirect_target(priv->dev, false);
+
 	gve_set_napi_enabled(priv);
 }
 
@@ -2246,7 +2251,6 @@ static void gve_set_netdev_xdp_features(
 	if (priv->queue_format == GVE_GQI_QPL_FORMAT) {
 		xdp_features = NETDEV_XDP_ACT_BASIC;
 		xdp_features |= NETDEV_XDP_ACT_REDIRECT;
-		xdp_features |= NETDEV_XDP_ACT_NDO_XMIT;
 		xdp_features |= NETDEV_XDP_ACT_XSK_ZEROCOPY;
 	} else {
 		xdp_features = 0;



