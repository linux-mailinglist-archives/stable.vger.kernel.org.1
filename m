Return-Path: <stable+bounces-241081-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMQoFE8K7GnDTwAAu9opvQ
	(envelope-from <stable+bounces-241081-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 02:26:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C05234643E6
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 02:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB492304A9C2
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 00:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2412F1A0BE0;
	Sat, 25 Apr 2026 00:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CBRPuchh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07041F1304
	for <stable@vger.kernel.org>; Sat, 25 Apr 2026 00:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777076703; cv=none; b=AOVv5ijhVCOFZdlm+ha+XymylrSoq+TyOfVqM1YfxTz1zzENkDOnsHCoLoJpdUyvpEh0pbZB3PHpJEeU12ukyoi9wR5zvjW2/Mx5AHTV51huUFPfuA4MRvKqOPtd3mWrzyP3S8XHPx4oMqQuXbVy3M1LynyKJwPHFjnSXWe9n54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777076703; c=relaxed/simple;
	bh=QTNTbvBnSC5EltdyXHhC+I6ndxnglhMXh0Und1seaOc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Au5X4BH8B3+mL+smR8d/i+hZjKpcTD4Qn/YRjBrYp1UpaJxOoKowVWw5DjrXWUDjrkPRQBHlsEBz5s8cLqdadjRhn0c03oVvw3PSzvzVbbPFGvDyCOgufeNBMNdxE8Pxtku/xUcBArJlSoAYCGqqki0weSFFQ4iXQHYcJHq7sXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CBRPuchh; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35fb6cd0879so7863891a91.2
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 17:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777076702; x=1777681502; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Mr9oFSsC133Mf1hRrHkDLNxZVk8eA36xlUlRpvwFcQ=;
        b=CBRPuchhYdZYzIvpOG1tcmhpJr0LOe6LO4Y+nWc+j52ZEK2GCg5znzBGIxg6uoFcjW
         41fl+o5gaExn0reO9/rOKOXIQIXqghV4NfwhqrBz9zEXNSxf2USNeiTXLaefw2OunKql
         sfmtWTBKsurLmMCS/y+8ey7ECBQQ9y24XvChp11EgUjen1CFFw4JIWFc+53OuspbrgRX
         VTKX/zF0aWqYFd1BKxH0yqAJ47eTyLtcvGdnsa4Z4/+SRl5FAwCtjLxiGQDwjGQA2nkB
         OxV3TDR7QWFGWIN+uwj8PhX8VyKEIexQuPm6/j7sVKtPlsIi7WdTKKALX359NHWbVgF4
         vKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777076702; x=1777681502;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Mr9oFSsC133Mf1hRrHkDLNxZVk8eA36xlUlRpvwFcQ=;
        b=TiL39MyhxUaQVIdouzJF/OBG+/ImhFskqMV81Tdahi0o/8ECS4hRc7z7TEqHvRnjrm
         64mhRf+l1i3fsmT0iJOFERWtGGUNaMpjhZBys0/AP7WPN6tSvSToYq1/yUKBVZbWMoDi
         df36DUkE3kKxu9Hpw6+/DxOXMa+tbqKhayTDrNzecemnAZ4z6DRJuTzOW+n+52TIfL5M
         ysuJvVSS/EsLmoGLm7viV7C8JqHg3xxGKmlNI4Gv0cYhhuTEe1R/Ij9wLMEKABRZr8mv
         7w/7W/Zbf/AudGPi4QpxSQXGGDT0NS2vXANV354e9/Fv8vO1U8ngqq/Ba8EgNzhq4j88
         aJJQ==
X-Forwarded-Encrypted: i=1; AFNElJ/qeAzfam5SevmwyN5z/7/PPKi7rljHrXwZJ8DyaFMaIsCKQVlbAsPkDW8i6QRzkkESmn09cik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxknaGXe6q0imYN31CjWj5+zjHwMWCXcLbXuMaPZu6kqfJ/gIO9
	ZPkm6w4aDRIZnyl1xXx6wDAE0my4+T5AzU+YNbXO+mVsVk+ia4O6tyiw7mSwau+yDVDNiaUCq9R
	+iNe+VwDlfktyegwZRfv5sl0VVA==
X-Received: from pjh13.prod.google.com ([2002:a17:90b:3f8d:b0:35f:be31:1a85])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2892:b0:35d:a0b7:9608 with SMTP id 98e67ed59e1d1-361403e8a1bmr33217393a91.7.1777076701965;
 Fri, 24 Apr 2026 17:25:01 -0700 (PDT)
Date: Sat, 25 Apr 2026 00:24:50 +0000
In-Reply-To: <20260425002450.163421-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425002450.163421-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425002450.163421-5-hramamurthy@google.com>
Subject: [PATCH net v2 4/4] gve: Make ethtool config changes synchronous
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, maolson@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, jacob.e.keller@intel.com, pkaligineedi@google.com, 
	shailend@google.com, jordanrhee@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pin-yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C05234643E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241081-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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
Signed-off-by: Pin-yen Lin <treapking@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 56 +++++++++++-----------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 1fec8e1e4821..2c461be12a75 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1424,6 +1424,33 @@ static void gve_queues_mem_remove(struct gve_priv *priv)
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
@@ -1486,8 +1513,7 @@ static int gve_queues_start(struct gve_priv *priv,
 			  round_jiffies(jiffies +
 				msecs_to_jiffies(priv->stats_report_timer_period)));
 
-	gve_turnup(priv);
-	queue_work(priv->gve_wq, &priv->service_task);
+	gve_turnup_and_check_status(priv);
 	priv->interface_up_cnt++;
 	return 0;
 
@@ -1608,23 +1634,6 @@ static int gve_close(struct net_device *dev)
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
@@ -2099,15 +2108,6 @@ static void gve_turnup(struct gve_priv *priv)
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
2.54.0.545.g6539524ca2-goog


