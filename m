Return-Path: <stable+bounces-263768-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fsk2AoNgMWoWiQUAu9opvQ
	(envelope-from <stable+bounces-263768-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:41:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D5C690988
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:41:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=pschenker.ch header.s=20220412 header.b=tAi96LJX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263768-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263768-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=pschenker.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82BF73031A00
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 14:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE4439B970;
	Tue, 16 Jun 2026 14:38:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D4136F8F5
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 14:38:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620695; cv=none; b=DtPbSk0iDTQbdxzNmhzUBLl64j60MZFjHPOEbGJb/w2vhQaj9q8li11l2jxxkraC/fRUXK5Z4uMlG5bdVnRWqrY5vjMTBf2J5bIJtgTcl8zKnEIGQx5YgIWqOpo9uDFRwq7Thn5eG21PNcJgonOzHchhCr2GGB7vNKppdWlcnTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620695; c=relaxed/simple;
	bh=G6WeaxFC7coc3mi7da2c15aCmzkL6y9OaDzjZLkJFF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nVf4RdE+8ECrxvAVh8dmO720SKCKGbL8J19/b3R+RE9RnGWKS+UA/RzAwrXUXMQ2wzQyfHAiNrQ7ChHMylsBl5YP4bwYvSpyfCa/UK8EtH6q9yoYgSqfAPWAJMwl42KUrF3NTCoQrTus+f9HnBS5cVwqeXw5Yipv0yJAFCUx8JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch; spf=pass smtp.mailfrom=pschenker.ch; dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b=tAi96LJX; arc=none smtp.client-ip=84.16.66.171
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gfqND4Fy3z8qs;
	Tue, 16 Jun 2026 16:38:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pschenker.ch;
	s=20220412; t=1781620684;
	bh=L4HUsPuZdj6LV3uNElVOC/aB6ZtKXn8837uRKeGnUl0=;
	h=From:To:Cc:Subject:Date:From;
	b=tAi96LJXCg+fKOs6D1B1q64Pr4G70CxNuWQUFaWA9A+WDqf4Gc6eAM0ZBvGatjXId
	 /Fi1Xe8/4Riq0LXduefg3SJpl59vwyHZyJgfUd+f+gyQkrSU0unGCXKTy8Ux6MaaVL
	 nVEwf9VC6Ww+wNNTk90YNVNIVLor7B5oLju+kPPo=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gfqN93F77zy0m;
	Tue, 16 Jun 2026 16:38:01 +0200 (CEST)
From: Philippe Schenker <dev@pschenker.ch>
To: netdev@vger.kernel.org
Cc: Philippe Schenker <philippe.schenker@impulsing.ch>,
	danishanwar@ti.com,
	rogerq@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Carlier <devnexen@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kevin Hao <haokexin@gmail.com>,
	Meghana Malladi <m-malladi@ti.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: ethernet: ti: icssg: guard PA stat lookups
Date: Tue, 16 Jun 2026 16:35:34 +0200
Message-ID: <20260616143642.1972071-1-dev@pschenker.ch>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[pschenker.ch,none];
	R_DKIM_ALLOW(-0.20)[pschenker.ch:s=20220412];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[impulsing.ch,ti.com,kernel.org,lists.infradead.org,vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,intel.com,redhat.com,linux.dev];
	TAGGED_FROM(0.00)[bounces-263768-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:philippe.schenker@impulsing.ch,m:danishanwar@ti.com,m:rogerq@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:stable@vger.kernel.org,m:andrew+netdev@lunn.ch,m:devnexen@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:jacob.e.keller@intel.com,m:kuba@kernel.org,m:haokexin@gmail.com,m:m-malladi@ti.com,m:pabeni@redhat.com,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dev@pschenker.ch,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@pschenker.ch,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[pschenker.ch:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ti.com:email,infradead.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,impulsing.ch:email,pschenker.ch:dkim,pschenker.ch:mid,pschenker.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8D5C690988

From: Philippe Schenker <philippe.schenker@impulsing.ch>

icssg_ndo_get_stats64() unconditionally calls emac_get_stat_by_name()
with FW PA stat names regardless of whether the PA stats block is
present on the hardware.  emac_get_stat_by_name() already guards the
PA stats lookup with `if (emac->prueth->pa_stats)`; when that pointer
is NULL the lookup falls through to netdev_err() and returns -EINVAL.
Because ndo_get_stats64 is polled regularly by the networking stack
this produces thousands of log entries of the form:

  icssg-prueth icssg1-eth end0: Invalid stats FW_RX_ERROR

A secondary consequence is that the int(-EINVAL) return value is
implicitly widened to a near-ULLONG_MAX unsigned value when accumulated
into the __u64 fields of rtnl_link_stats64, silently corrupting the
rx_errors, rx_dropped and tx_dropped counters reported by `ip -s link`.

Every other PA-aware code path in the driver is already guarded with
the same `if (emac->prueth->pa_stats)` check.  Apply the same guard
here.

Fixes: 0d15a26b247d ("net: ti: icssg-prueth: Add ICSSG FW Stats")

Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>

Cc: danishanwar@ti.com
Cc: rogerq@kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org
---

 drivers/net/ethernet/ti/icssg/icssg_common.c | 48 +++++++++++---------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index a28a608f9bf4..2dbb8f717de0 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -1628,28 +1628,34 @@ void icssg_ndo_get_stats64(struct net_device *ndev,
 	stats->rx_over_errors = emac_get_stat_by_name(emac, "rx_over_errors");
 	stats->multicast      = emac_get_stat_by_name(emac, "rx_multicast_frames");
 
-	stats->rx_errors  = ndev->stats.rx_errors +
-			    emac_get_stat_by_name(emac, "FW_RX_ERROR") +
-			    emac_get_stat_by_name(emac, "FW_RX_EOF_SHORT_FRMERR") +
-			    emac_get_stat_by_name(emac, "FW_RX_B0_DROP_EARLY_EOF") +
-			    emac_get_stat_by_name(emac, "FW_RX_EXP_FRAG_Q_DROP") +
-			    emac_get_stat_by_name(emac, "FW_RX_FIFO_OVERRUN");
-	stats->rx_dropped = ndev->stats.rx_dropped +
-			    emac_get_stat_by_name(emac, "FW_DROPPED_PKT") +
-			    emac_get_stat_by_name(emac, "FW_INF_PORT_DISABLED") +
-			    emac_get_stat_by_name(emac, "FW_INF_SAV") +
-			    emac_get_stat_by_name(emac, "FW_INF_SA_DL") +
-			    emac_get_stat_by_name(emac, "FW_INF_PORT_BLOCKED") +
-			    emac_get_stat_by_name(emac, "FW_INF_DROP_TAGGED") +
-			    emac_get_stat_by_name(emac, "FW_INF_DROP_PRIOTAGGED") +
-			    emac_get_stat_by_name(emac, "FW_INF_DROP_NOTAG") +
-			    emac_get_stat_by_name(emac, "FW_INF_DROP_NOTMEMBER");
+	stats->rx_errors  = ndev->stats.rx_errors;
+	stats->rx_dropped = ndev->stats.rx_dropped;
 	stats->tx_errors  = ndev->stats.tx_errors;
-	stats->tx_dropped = ndev->stats.tx_dropped +
-			    emac_get_stat_by_name(emac, "FW_RTU_PKT_DROP") +
-			    emac_get_stat_by_name(emac, "FW_TX_DROPPED_PACKET") +
-			    emac_get_stat_by_name(emac, "FW_TX_TS_DROPPED_PACKET") +
-			    emac_get_stat_by_name(emac, "FW_TX_JUMBO_FRM_CUTOFF");
+	stats->tx_dropped = ndev->stats.tx_dropped;
+
+	if (emac->prueth->pa_stats) {
+		stats->rx_errors  +=
+				emac_get_stat_by_name(emac, "FW_RX_ERROR") +
+				emac_get_stat_by_name(emac, "FW_RX_EOF_SHORT_FRMERR") +
+				emac_get_stat_by_name(emac, "FW_RX_B0_DROP_EARLY_EOF") +
+				emac_get_stat_by_name(emac, "FW_RX_EXP_FRAG_Q_DROP") +
+				emac_get_stat_by_name(emac, "FW_RX_FIFO_OVERRUN");
+		stats->rx_dropped +=
+				emac_get_stat_by_name(emac, "FW_DROPPED_PKT") +
+				emac_get_stat_by_name(emac, "FW_INF_PORT_DISABLED") +
+				emac_get_stat_by_name(emac, "FW_INF_SAV") +
+				emac_get_stat_by_name(emac, "FW_INF_SA_DL") +
+				emac_get_stat_by_name(emac, "FW_INF_PORT_BLOCKED") +
+				emac_get_stat_by_name(emac, "FW_INF_DROP_TAGGED") +
+				emac_get_stat_by_name(emac, "FW_INF_DROP_PRIOTAGGED") +
+				emac_get_stat_by_name(emac, "FW_INF_DROP_NOTAG") +
+				emac_get_stat_by_name(emac, "FW_INF_DROP_NOTMEMBER");
+		stats->tx_dropped +=
+				emac_get_stat_by_name(emac, "FW_RTU_PKT_DROP") +
+				emac_get_stat_by_name(emac, "FW_TX_DROPPED_PACKET") +
+				emac_get_stat_by_name(emac, "FW_TX_TS_DROPPED_PACKET") +
+				emac_get_stat_by_name(emac, "FW_TX_JUMBO_FRM_CUTOFF");
+	}
 }
 EXPORT_SYMBOL_GPL(icssg_ndo_get_stats64);
 
-- 
2.54.0

base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
branch: fix-icssg_common-pa-stats-errors__master-7-1

