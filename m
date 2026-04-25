Return-Path: <stable+bounces-241078-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHuLN/wJ7GnDTwAAu9opvQ
	(envelope-from <stable+bounces-241078-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 02:25:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D020B4643AA
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 02:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C90F1300C7D9
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 00:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF351A6827;
	Sat, 25 Apr 2026 00:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UMAAUJQq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5008014B08A
	for <stable@vger.kernel.org>; Sat, 25 Apr 2026 00:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777076697; cv=none; b=UbL/V7gG5naBfd4GzPUB3E4irCGCiJYNDzi8HEwzOAf1qQ7tefBmytqJ2+5V3Ed+SqcKCI5/z4v8FDYB9AC0iKIyXWsn7vuu99oDGLk57oQgs4v+EvOBYxMLyiLej+BgARqbak6FUfFAvVN+3mTDIVseyn8zlJSYjOsGa99S89Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777076697; c=relaxed/simple;
	bh=Mjnx1s3bsqC9FAzihiRv4foFXTmL4rKmWuq5XvBiL6Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YgYUEq3rckDejiJjcswWlmWn+eHC8zVtEssqx6/GvQ7YwD+kMJN8ggiBYvf1wkauV9le+79VLTQfyis/MAgaN4W7xdXylvDYmmGpKMiBzCVMQvhEd1JB4vSvblIZlieEu3lpWxmVfnNRuxPAAvBus8Q583iWfWJhDDok6Vi5fMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UMAAUJQq; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b7c904d476so9536585ad.3
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 17:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777076696; x=1777681496; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Waoun8sqMnhJduShdptqSPbzHIpwQYFL4W4pABJXnK0=;
        b=UMAAUJQqAOkxqp+kAKZTQIuprJQhsD4ElGilIsjAdyiWExl6AFkH1kFcRpeEWysxOw
         EEAihnhC2ZHtKAKdB5MKWbTH2IyMerQq1Ymvfj1Ocfzx1RbKD5TGIajTGqchEkmwmCRO
         eYYsK2ry8Y1/8KefYJI6Y7Iu+PMvXdJTWC1Gm1vLQo4TAqQktHPrTtAST2Y/JIBpmXq2
         rzWRn0iu0BbmgOt3xlXepcrp0/FV03jfr4RJxeEGcA376sc6xAYTiFrk9KK5+iFgSDSA
         hOfQ2Mv110QI6PXEq4xnieuFMdKV8fjoCmOapSpCzzy6G3VMW4UeRbTijxuCktFNVhsS
         1CSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777076696; x=1777681496;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Waoun8sqMnhJduShdptqSPbzHIpwQYFL4W4pABJXnK0=;
        b=kPjPkY57M+lwxOts+COzfXugrVVL1NuyJnoI0/SsoqlROoCPPjocZnVaN4qI0i+nfu
         sTlSixJoXbSB7UNvIBT+jOKec9DizUrcnHqh/dohdw1yQvzwzLtW/Nl6QcbuE+9XJjh4
         HxILYbWb3CYofpF6LERyD1Bl0qpH98M3Xw0nXjgRx7p0fhEfJ7Kyre3WzQIyRsFN/AoD
         4bomUxLcGHGBx14TLzoPo3LkAr/Odg6LKbFcGavEO999ImafFUhCtdx8aWYEpWZhMgBJ
         YQu5MvA+hX0C1J2FxnGU19k33mspUbvRadgROf5lejjyYmntI324zLYokujVqqsXW4DF
         1ZyA==
X-Forwarded-Encrypted: i=1; AFNElJ+1EOtV1mkSWiCRAHk73cqDCi22j8X9g1tLfYCJdnvsJp23OTTnLedSSMx2yaYofyItZDfCuj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFq0xIDpMtg5IRFQrFrtXXmlqj2Dq3ERA/nbo6om82UxegSkN0
	4/SPDjzuJ+/cbGyB+7oXK6oNh/f85I16cLdl6s47JJIgmMpO0q+hA4zUFkuxyR/F8gxYwNTRGRr
	yCyT7+NRHr/4kkOjI7q7bnKjlqQ==
X-Received: from plbb16.prod.google.com ([2002:a17:903:c10:b0:2b2:49fe:d6db])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c94b:b0:2a9:e8b:5326 with SMTP id d9443c01a7336-2b5f9f51e59mr333405275ad.23.1777076695413;
 Fri, 24 Apr 2026 17:24:55 -0700 (PDT)
Date: Sat, 25 Apr 2026 00:24:47 +0000
In-Reply-To: <20260425002450.163421-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425002450.163421-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425002450.163421-2-hramamurthy@google.com>
Subject: [PATCH net v2 1/4] gve: Add NULL pointer checks for per-queue statistics
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
X-Rspamd-Queue-Id: D020B4643AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241078-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Debarghya Kundu <debarghyak@google.com>

gve_get_[tx/rx]_queue_stats references the [tx/rx] null rings when the
link is down. Add NULL pointer checks to guard this

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
index 424d973c97f2..ef00d9ca1643 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2746,9 +2746,13 @@ static void gve_get_rx_queue_stats(struct net_device *dev, int idx,
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
@@ -2762,9 +2766,13 @@ static void gve_get_tx_queue_stats(struct net_device *dev, int idx,
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
2.54.0.545.g6539524ca2-goog


