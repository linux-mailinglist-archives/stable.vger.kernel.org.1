Return-Path: <stable+bounces-239960-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MO+FHg5g5mkqvgEAu9opvQ
	(envelope-from <stable+bounces-239960-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:19:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D54430FCC
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5769300D4E5
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E5E378830;
	Mon, 20 Apr 2026 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g9yY9vVr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F280137E2E4
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705524; cv=none; b=e1mRmYRZQVEHhv0cb+jYdZe+ikXrAQ5R13DrVuv8Za6TMyz5dEwHK7a+LymJi+Ltu7LS4ykaquCBu43MvLCaRHThNsCiOXA/s2GxYY/9PeviZjplBl+NQivHkoL35I2j+YwY2aPpdltQh8ISdleB5WaJ6OccWh7xR94Po/31RaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705524; c=relaxed/simple;
	bh=u0UVsOozKt4Tg7IC9nw6qxk0e3pyOwuHpeuJX0VNCQM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JgMo2ELMj81mMdnTsgKGXkrtqboZM7ZgiLkD4s6Cl8Wl96gaQRn9p/AhD6XqBdCSaLrtWeQkqbiIqMrTBbtQxG3cFN8MJt+UncziMDsi6yIuE8MSjDwwFbGWz6D1i2NvOXlokpQwmAbDPeeiNKxW0oy/Ftd86vUVMBNIr07McPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g9yY9vVr; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35d9f68d00fso6528051a91.2
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 10:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776705522; x=1777310322; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+0Cj3kzc2z6biU160rJ3owwxifAK2ueeF94SXw4tnzM=;
        b=g9yY9vVrV0M1Wqmco3v5QErLyz7rFhkGkkhHRjh92Wv+qrmwK11DeEDZEhS2lYcTQo
         FQeS/EtL1F76QEGPYRhwQ1oXq/O5s85WBK+8fbeZyaV+5NOCF0nzY8vOsR0ModEvdKEW
         9ePHghw/11Skrr+Dvn65b2cA5d9fEdnA2m6eZxant40htr9N8P7Urh2TJ2QjHvYeMKs0
         H+jQIV1BvuGokCRLsz+dRBQfR6ZWbm3rVJqxub3LmbggsLn7UIDvJo8Tw1ah4ztRWv+I
         wxnPxUNyG8lApBUOR9zheV+ROP5ASwtM4/xByuyYAZgCy5ljB2XYBJznWa3+Pr1Fla6c
         KLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776705522; x=1777310322;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0Cj3kzc2z6biU160rJ3owwxifAK2ueeF94SXw4tnzM=;
        b=Tm9VEDAdhdu7BJ3w/vWxyPlFtA7+mjoow2eh0QrZaxTGS7gRA/Ax5uII8yBw1igRuW
         JMpG639nSeTQW7dhhOWZ2A/cliXffcpUq1OPqyvzRP8PGTmKwVLuZoK9hM2L8qlVj3lU
         nCOFxVAY6mRUFHXXX1fVYNqTLpInW/Xzsnlm5Ab5x1DTgwxfQSV1hxk3GofrRITb7qH3
         C1qRIVvlu7KhVUoZrLAucgQ6+rXHIftxZ5UcO8mG1q83pty9z7BktRZJkbsp+YpPtiWz
         yoglNVQHGHVzpPTLEewLy1ca1DFz2XidADx05igd6pmUKD6PnOM28fUdWhkGCfjjEb8F
         zRwg==
X-Forwarded-Encrypted: i=1; AFNElJ8zumn/7NgaNyWebkLRDkSW6udaoVJ91bHjnygzFnis4OdbhxKkmT1fy42UV2EFXCbrvx2XPCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhm0+Dd3wYimiEtm7xfZ+OqYjCHP0ZJDMGENNOgeebiRyCQKO+
	lk7Jp8BdJ6Q00Dxe8vJgcWCNADeEbFd/DXF+p+bxRCEbb1OEAP/DiTBXUkjEGsIvoPER/aiwG5c
	pGDijyrj3uMyvW5KzczMwgbCnNw==
X-Received: from pjtl11.prod.google.com ([2002:a17:90a:c58b:b0:35d:a8d7:ccda])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4e85:b0:35f:b5df:450 with SMTP id 98e67ed59e1d1-3614048a226mr15714612a91.19.1776705522232;
 Mon, 20 Apr 2026 10:18:42 -0700 (PDT)
Date: Mon, 20 Apr 2026 17:18:34 +0000
In-Reply-To: <20260420171837.455487-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260420171837.455487-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260420171837.455487-2-hramamurthy@google.com>
Subject: [PATCH net 1/4] gve: Add NULL pointer checks for per-queue statistics
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, maolson@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, jacob.e.keller@intel.com, pkaligineedi@google.com, 
	shailend@google.com, jordanrhee@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Debarghya Kundu <debarghyak@google.com>, 
	Pin-yen Lin <treapking@google.com>
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
	TAGGED_FROM(0.00)[bounces-239960-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
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
X-Rspamd-Queue-Id: 18D54430FCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Debarghya Kundu <debarghyak@google.com>

gve_get_[tx/rx]_queue_stats references the [tx/rx] null rings when the
link is down. Add NULL pointer checks to guard this.

This was discovered by drivers/net/stats.py selftest.

Cc: stable@vger.kernel.org
Fixes: 2e5e0932dff5 ("gve: add support for basic queue stats")
Signed-off-by: Debarghya Kundu <debarghyak@google.com>
Signed-off-by: Pin-yen Lin <treapking@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 0ee864b0afe0..675382e9756c 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2705,9 +2705,13 @@ static void gve_get_rx_queue_stats(struct net_device *dev, int idx,
 				   struct netdev_queue_stats_rx *rx_stats)
 {
 	struct gve_priv *priv = netdev_priv(dev);
-	struct gve_rx_ring *rx = &priv->rx[idx];
+	struct gve_rx_ring *rx;
 	unsigned int start;
 
+	if (!priv->rx)
+		return;
+	rx = &priv->rx[idx];
+
 	do {
 		start = u64_stats_fetch_begin(&rx->statss);
 		rx_stats->packets = rx->rpackets;
@@ -2721,9 +2725,13 @@ static void gve_get_tx_queue_stats(struct net_device *dev, int idx,
 				   struct netdev_queue_stats_tx *tx_stats)
 {
 	struct gve_priv *priv = netdev_priv(dev);
-	struct gve_tx_ring *tx = &priv->tx[idx];
+	struct gve_tx_ring *tx;
 	unsigned int start;
 
+	if (!priv->tx)
+		return;
+	tx = &priv->tx[idx];
+
 	do {
 		start = u64_stats_fetch_begin(&tx->statss);
 		tx_stats->packets = tx->pkt_done;
-- 
2.54.0.rc0.605.g598a273b03-goog


