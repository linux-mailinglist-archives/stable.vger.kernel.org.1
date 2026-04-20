Return-Path: <stable+bounces-239963-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INigIKNg5mkxvgEAu9opvQ
	(envelope-from <stable+bounces-239963-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:21:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5577A431099
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 863533022CB3
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261223A4F4F;
	Mon, 20 Apr 2026 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LRuWm8v1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABAD3A1CEC
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705530; cv=none; b=fv6JmuYDWY8ygwkcSEV/JHmZlgf9wAwRqfund3QWufFv5PqKCA9OI31XhAsVD0BWm27h3D8VM/UvYWeO4AwbncVbQ3o772WdRz9dIkYOAFVldEN5UtifRebuO/c/3atrQ47q/s9i07awnliHIxni2OL++CKT5MZVqCd7aWd/lwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705530; c=relaxed/simple;
	bh=7HuwCMtFhgkI3i3Cm8hedgvjuhF+HqVN4oV9qkEM0Sw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jqF3vv4ZjNwI781VElL0I1oHrDSGSG3s0y6ln8JS2n5Ul+Xlh0oRe9pCXTrNzKgb45rotjSZGh4U6sVDn+TyXhxfIXYfni7EjNUL9Ua9lwO3Ly/XUTw7vciS4Qb0v+1coATlcQpwGx95qKPMDu5FVatObTlzgnjMeSuadue9KFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LRuWm8v1; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35fbc53b64bso3792781a91.1
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776705527; x=1777310327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HKhjtZffpudnSoigZVFDRJbxGYPsECcpyVW6J8Asv1A=;
        b=LRuWm8v1jk//MkqP3MDX0GqHo6YebJUMYDm8egJFq6FIz7dm8lOSSwSQ4s+EBOuNRt
         1tzaX58w3Lz+FYAxF50gJ14irrhlheWq6ez+sI5SCOB4dHkqGRjLwxLMbYjlvgWAQcS+
         Vj3eWgif11QzlNTWGIz82At2iO1v/ulKwmBUllQ1st+HIj/XbvU+9Z4sQD8FkhuuzTsV
         RqyAdlYJiWNHmUSwbuvWiQVUUtLYk0Nb6yVhscyUBsbr4FEiS9QeIprfeT+mu0se4AzZ
         SE/AdoczyBwAoFgNS7UE+oz2LsP0EUbooFmrh+4AgbyYwC6oQt1xUWWNc+icgE46Yvrl
         LuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776705527; x=1777310327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HKhjtZffpudnSoigZVFDRJbxGYPsECcpyVW6J8Asv1A=;
        b=gINmFRppU7BfqS78rVUfMTHKa1duttVJY4GdHvoW31rQ3M6OenxBnlT1DsULtLGIIG
         czxotIK3yLsCVyC/RH9garbhS6fBY2X4E8qA5lP6w6z9V6jYHLMZkpB9AlOroGfD13wG
         V3dPqoTaLpjJc90REQzpcZ3gUimu469mT5TUH7NwfAXjxubsp6RWspr81EkwfSW+cs9A
         JAatXY4sPnL1w46Z1j7RoAhTROYMilEhUieTDcjqqDXf2eaFiMruMuhH/ZMTsC4kIGo/
         TE2PNwny9NVJP4GhmwL0KfK/06isyfXd4bT6ReZNvx7t7wH4qsJY09N2fMeeN6456HYY
         fQUw==
X-Forwarded-Encrypted: i=1; AFNElJ8oA08uLMsmQYfzfmxC8FNcBKRlWvZbD5VGvP5f2rIppsLjbDdeffjKNCpTVSav6lXPtQxoJPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmL49BNc9wh0KF9xSVoFrU8eOQYzSXDlevhXaVxc8WbhV8/vVq
	hDOsjDDVWE1okYt/ykhMM4e9437L0FejQx29WotydwuO78Ys/9947bCSvJ8mj4PU2DtkJx6VfQV
	mr2IFdVnVb+MQrXZYTJgc/3iSDg==
X-Received: from pjbev4.prod.google.com ([2002:a17:90a:eac4:b0:35f:b87d:dbd])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e7d0:b0:35c:1695:24a3 with SMTP id 98e67ed59e1d1-361404945e0mr15500805a91.23.1776705526822;
 Mon, 20 Apr 2026 10:18:46 -0700 (PDT)
Date: Mon, 20 Apr 2026 17:18:37 +0000
In-Reply-To: <20260420171837.455487-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260420171837.455487-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260420171837.455487-5-hramamurthy@google.com>
Subject: [PATCH net 4/4] gve: Make ethtool config changes synchronous
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, maolson@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, jacob.e.keller@intel.com, pkaligineedi@google.com, 
	shailend@google.com, jordanrhee@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pin-yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239963-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5577A431099
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Pin-yen Lin <treapking@google.com>

When modifying device features via ethtool, the driver queues the
carrier status update to its workqueue (gve_wq). This leads to a
short link-down state after running the ethtool command.

Use `gve_turnup_and_check_status()` instead of `gve_turnup()` in
`gve_queues_start()` to update the carrier status before returning to
the userspace.

This was discovered by drivers/net/ping.py selftest. The test calls
ping command right after an ethtool configuration, but the interface
could be down without this fix.

Cc: stable@vger.kernel.org
Fixes: 5f08cd3d6423 ("gve: Alloc before freeing when adjusting queues")
Reviewed-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Pin-yen Lin <treapking@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 56 +++++++++++-----------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 8617782791e0..d3b4bec38de5 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1374,6 +1374,33 @@ static void gve_queues_mem_remove(struct gve_priv *priv)
 	priv->rx = NULL;
 }
 
+static void gve_handle_link_status(struct gve_priv *priv, bool link_status)
+{
+	if (!gve_get_napi_enabled(priv))
+		return;
+
+	if (link_status == netif_carrier_ok(priv->dev))
+		return;
+
+	if (link_status) {
+		netdev_info(priv->dev, "Device link is up.\n");
+		netif_carrier_on(priv->dev);
+	} else {
+		netdev_info(priv->dev, "Device link is down.\n");
+		netif_carrier_off(priv->dev);
+	}
+}
+
+static void gve_turnup_and_check_status(struct gve_priv *priv)
+{
+	u32 status;
+
+	gve_turnup(priv);
+	status = ioread32be(&priv->reg_bar0->device_status);
+	gve_handle_link_status(priv,
+			       GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
+}
+
 /* The passed-in queue memory is stored into priv and the queues are made live.
  * No memory is allocated. Passed-in memory is freed on errors.
  */
@@ -1434,8 +1461,7 @@ static int gve_queues_start(struct gve_priv *priv,
 			  round_jiffies(jiffies +
 				msecs_to_jiffies(priv->stats_report_timer_period)));
 
-	gve_turnup(priv);
-	queue_work(priv->gve_wq, &priv->service_task);
+	gve_turnup_and_check_status(priv);
 	priv->interface_up_cnt++;
 	return 0;
 
@@ -1548,23 +1574,6 @@ static int gve_close(struct net_device *dev)
 	return 0;
 }
 
-static void gve_handle_link_status(struct gve_priv *priv, bool link_status)
-{
-	if (!gve_get_napi_enabled(priv))
-		return;
-
-	if (link_status == netif_carrier_ok(priv->dev))
-		return;
-
-	if (link_status) {
-		netdev_info(priv->dev, "Device link is up.\n");
-		netif_carrier_on(priv->dev);
-	} else {
-		netdev_info(priv->dev, "Device link is down.\n");
-		netif_carrier_off(priv->dev);
-	}
-}
-
 static int gve_configure_rings_xdp(struct gve_priv *priv,
 				   u16 num_xdp_rings)
 {
@@ -2039,15 +2048,6 @@ static void gve_turnup(struct gve_priv *priv)
 	gve_set_napi_enabled(priv);
 }
 
-static void gve_turnup_and_check_status(struct gve_priv *priv)
-{
-	u32 status;
-
-	gve_turnup(priv);
-	status = ioread32be(&priv->reg_bar0->device_status);
-	gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
-}
-
 static struct gve_notify_block *gve_get_tx_notify_block(struct gve_priv *priv,
 							unsigned int txqueue)
 {
-- 
2.54.0.rc0.605.g598a273b03-goog


