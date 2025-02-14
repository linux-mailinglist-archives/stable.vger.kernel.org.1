Return-Path: <stable+bounces-116462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6025FA368A3
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 23:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5BB18933A3
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 22:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BFC1FCCE5;
	Fri, 14 Feb 2025 22:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sj/IziDH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818B11FC7F7
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 22:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739573090; cv=none; b=USzKZNULH1FTEf3Ad38n2bf9TTLhpeuGTgPFE13Vqo5weH7Rae4CO/YtmeYSsleUeMT78LQcNNbcLLbs9PQoItkhfk0c/PbnV5w/7/rTDyCbCzgHWbqfjJDGd60xyL0tnSpGzntJoaRsG3jldZES4EM817Mg/qJgW2HqcZYfEtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739573090; c=relaxed/simple;
	bh=C9A3LWRVVEvM4OBlqT9wYA0yWCdJj2Hpz7Z1pzmG8wU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MuLbcx6xcEkmCd+Gz8HMZ+IxQ2BULVtdgMDMJe7zc1ibZHzMUpc0rlLMlv8UczFleghxlRQIO6TIv9ADtbG29BJp9w8mADI6VRbVtuC4T1UynvlJDnTBFSgLKWBoYIjFaQ8uQkQssBGgU1SerHQ7mv++Zt7Pdr8nhrnes5SPxtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sj/IziDH; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220fb031245so16639365ad.3
        for <stable@vger.kernel.org>; Fri, 14 Feb 2025 14:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739573088; x=1740177888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tUNETmfCcN16mATl/cudDdX8wxXBFFNsGuPJIeAzz7o=;
        b=sj/IziDHroH5kXw5DjtQJdNC0AeZGArJJh2x98x4jO7HBS6Lp7Tzk+QZzpa8dqlUYP
         jfqLmNconmo8MCmiAOPWrPLU/TCV3nuJNTehQ/OVNXbbLClxjaiAiLNxLKA5WIblBQb6
         7NoOkVtNjckuuQY10tkKmL4ZsEAR3d5lWYDpM75KGEDAxgp+m2fYP1Z6XITeuCKYkuE6
         EZvFJYqiDjBQytspQ5rYqzYceWstJ4fS8EdgThrk+ZAyL1e4Qh6ok/h5O40PPUJ0zsCk
         QI4C36QMidbIjO60BKbHmGiHDc68GtFC1NeQFj5F+cM5sPeA2uzs/3ZHZvbPbRvlR/LM
         DFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739573088; x=1740177888;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUNETmfCcN16mATl/cudDdX8wxXBFFNsGuPJIeAzz7o=;
        b=MArJYP4RwD9XSO2RcMcigWprVXGzDB43VfcqTukfETmu3kKJ6q2JaDBM1MjPMC58JA
         T2zVzQznTBR4D2xUVNK0Bk4lnzj9i2SHaL53GD9dZOYAzfOupku86/kMLswsA6/PUoiZ
         8ujyvgPQAiHrgyYjv3bGGaVPdcFFDxqmc/WrunkCHOHbOOc8T39EnZJfAyZq6QZZeL3v
         Co/GX4+G6kUu/27Jm/TR4dOq7Tg1gh3HdcK6xZ0pa1FTqI7fUJFxHKHlOpESjxBWxP66
         tNZksfSyby6DZYYVDLsf3FJhCuSwJb4e2zLfM6P5sj7OczJKUHWMSKqKD5j08GF/oVrP
         ektw==
X-Forwarded-Encrypted: i=1; AJvYcCVdmCm62yRr+D2j8auhG2AB1H8ottQUKnPQTLgRzFP2nw5Opl7OXtrhZiRhjBrVvglxvYgbW3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YysD/s52sNpsMqIQw6eJlNZwci5NKy2w2oiaW0Gb8hILa+816zh
	tmnU/XOG2jK5oQB2e9CyAb0PJp7xjzL7/Rj9M54GcetZpV7kr8OesWUyS3J1nq6Wgklfz4/ZBuv
	AppAnsjFt5Q==
X-Google-Smtp-Source: AGHT+IFipCMt7qHod8wE+QJEnJFVy+GDVWXm+FNM4uL263Au9RAnEUGi4OFC3Gq37Yk5dRgHAwAYikh+aCfyzw==
X-Received: from pjbtb14.prod.google.com ([2002:a17:90b:53ce:b0:2ea:756d:c396])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:986:b0:215:5ea2:6544 with SMTP id d9443c01a7336-22103efa6e3mr14484155ad.7.1739573087787;
 Fri, 14 Feb 2025 14:44:47 -0800 (PST)
Date: Fri, 14 Feb 2025 14:43:59 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250214224417.1237818-1-joshwash@google.com>
Subject: [PATCH net] gve: set xdp redirect target only when it is available
From: joshwash@google.com
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, stable@kernel.org, 
	Joshua Washington <joshwash@google.com>, stable@vger.kernel.org, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	Shailend Chand <shailend@google.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

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
---
 drivers/net/ethernet/google/gve/gve.h      | 10 ++++++++++
 drivers/net/ethernet/google/gve/gve_main.c |  6 +++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

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
-- 
2.48.1.601.g30ceb7b040-goog


