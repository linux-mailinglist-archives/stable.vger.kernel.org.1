Return-Path: <stable+bounces-119413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 718E1A42D15
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 20:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267EC3A8AFA
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 19:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6F61A5B8B;
	Mon, 24 Feb 2025 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d4BvOmBf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA0B2571B6
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 19:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740426762; cv=none; b=gBeoBRKKZX55TdC1V1l5uJRJbI5T7Weh9w/Yukl1vwy3Etyhm8VQfJ2cTYHLbuDAIiu//uuI8uN0USCd7gMIvL4GsGOJv6QOMz4U/JnFn///tz1TEkUpJsrjHElvgTXCJTt9ubmS53zr+TAKPTIca2hJxMcRI75nEvwTnw9fYg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740426762; c=relaxed/simple;
	bh=pzX7wenmNYa+Cka35kCxGTWnQM6g5T3hkTL9jYqPBeM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TRQ6sAXgwMlXgZs9iXQM5Q/9zLxY9U1EMOYLqEeBZZmtRkb6sTnhzsp36/rpJzYWj4ntFDDQXXL8ZhZ6f0Dw2DRVMag8MRcQERVCMqqnuFNPZDRUKlZynFD0hJguhvQWdvsOpzYY4OCuz7/wr6DWN7PMSF87AK6a2q1MaMGwHio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d4BvOmBf; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22109f29c99so95949275ad.1
        for <stable@vger.kernel.org>; Mon, 24 Feb 2025 11:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740426760; x=1741031560; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wOfasf1W0OYsUaNVbnDQ1vrvQY9QZgzw//Y5wLR+va0=;
        b=d4BvOmBfOT9DZu70CZVQYgVrRYZxpFVQrPh7jYN/jPAGUQ6r2fZlr9CmWwse2qrfvF
         FqWUwK9Iy4vubeF7Ucgee549D+nhz26Sd3NUAvhkqorGA9k/Sxz3hJps/0n735beL2Wu
         YRbCsINtU1jqonUhEEx6RkWp6X7D9jAsy8UJYH21xuouPvmZOpVj4QUFMNPp6m1ykwsx
         pinc+6dZDohfIA/w9hRXNcJXWFzyR5uk7jBqlG/B7RekyfvG8adO2MKliuX2havh/5Wi
         R23840lfLztivmbmabMAoyH+3nJg2ye0xb2C99Y5wfAyW3ZponSTGzfxDSo9/EByoXEq
         xnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740426760; x=1741031560;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wOfasf1W0OYsUaNVbnDQ1vrvQY9QZgzw//Y5wLR+va0=;
        b=VfdqSt0ven6J32G9R7H4blcdok3FDLG5lnMD7uq6rLvbH17xKzsMwuan3ihdstFjHD
         wfbHbhCUVHflCgRXOQBvc5+vRXcxQ43/4gYMCCRo/d32N3j6CS7xQVL/GmPH8I/Vjs3B
         dTrT2DTjkci0s/M2uUuE63WxAqujHlcbbiESXz0RWRo6ANddX5PyGLqDNBnVnuZNzEI1
         zNYdjJ4K7OwmNfxhrMYrOlGxghLM7hNKXbw9wxJCl870oN7lSjJqVCqPQsPVHPXeMHlr
         PfZbpR4G3TyuDUGODCzSNNF2CmXuaIrWrO7htrbjflQ64WDkfWt/f+G14jv3JDgSVqm4
         47OQ==
X-Gm-Message-State: AOJu0Ywf8ceEErM46V2MPOpZaYlsazXHnf7oAdWISvdPaLyK/BJceMqA
	W8x/oJdQWSgryn+cnpxkszD2Sxrjw/epRlnM2GlsAjyoM3cvYGXC0U0IasPcq8Idc4N8hEQ88QG
	I7tLflBjhPcCyw7Xm8eGVOD1rOo5U1oAGcjUltVnRcHqE5RIZT8dddLGC98C9yS6B5HZoLWqJEF
	cB0QFwC6JzfF98nId1RpAjhTNvxY1zwgn+n5tW9qghOT0=
X-Google-Smtp-Source: AGHT+IF+7+EkwbStTgWmwCAOQnXJwT9vLZm7ppHOm08ByiwVMe8qhWHsdLCMC4I518VuwPedEmDetIrl/965Rw==
X-Received: from plhv15.prod.google.com ([2002:a17:903:238f:b0:220:d79f:a9bd])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2448:b0:21f:9107:fca3 with SMTP id d9443c01a7336-22307b69a02mr7152945ad.30.1740426759807;
 Mon, 24 Feb 2025 11:52:39 -0800 (PST)
Date: Mon, 24 Feb 2025 11:52:38 -0800
In-Reply-To: <2025022437-molecular-next-d0f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025022437-molecular-next-d0f6@gregkh>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250224195238.961070-1-joshwash@google.com>
Subject: [PATCH 6.6.y] gve: set xdp redirect target only when it is available
From: Joshua Washington <joshwash@google.com>
To: stable@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"

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
(cherry picked from commit 415cadd505464d9a11ff5e0f6e0329c127849da5)
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve.h      | 10 ++++++++++
 drivers/net/ethernet/google/gve/gve_main.c |  6 +++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 0d1e681be250..d59e28c86775 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1030,6 +1030,16 @@ static inline u32 gve_xdp_tx_start_queue_id(struct gve_priv *priv)
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
 /* buffers */
 int gve_alloc_page(struct gve_priv *priv, struct device *dev,
 		   struct page **page, dma_addr_t *dma,
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 90d433b36799..8cd098fe88ef 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1753,6 +1753,8 @@ static void gve_turndown(struct gve_priv *priv)
 	/* Stop tx queues */
 	netif_tx_disable(priv->dev);
 
+	xdp_features_clear_redirect_target(priv->dev);
+
 	gve_clear_napi_enabled(priv);
 	gve_clear_report_stats(priv);
 
@@ -1793,6 +1795,9 @@ static void gve_turnup(struct gve_priv *priv)
 		}
 	}
 
+	if (priv->num_xdp_queues && gve_supports_xdp_xmit(priv))
+		xdp_features_set_redirect_target(priv->dev, false);
+
 	gve_set_napi_enabled(priv);
 }
 
@@ -2014,7 +2019,6 @@ static void gve_set_netdev_xdp_features(struct gve_priv *priv)
 	if (priv->queue_format == GVE_GQI_QPL_FORMAT) {
 		xdp_features = NETDEV_XDP_ACT_BASIC;
 		xdp_features |= NETDEV_XDP_ACT_REDIRECT;
-		xdp_features |= NETDEV_XDP_ACT_NDO_XMIT;
 		xdp_features |= NETDEV_XDP_ACT_XSK_ZEROCOPY;
 	} else {
 		xdp_features = 0;
-- 
2.48.1.658.g4767266eb4-goog


