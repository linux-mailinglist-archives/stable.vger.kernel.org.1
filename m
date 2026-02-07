Return-Path: <stable+bounces-214822-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK5/AVmPh2kzZwQAu9opvQ
	(envelope-from <stable+bounces-214822-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 20:15:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFD5106F30
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 20:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3EA4F3004074
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 19:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDE3337BB2;
	Sat,  7 Feb 2026 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSKEM6YH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B883358B1
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 19:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770491730; cv=none; b=o5eELpvI3KCtD3wQhgIm/OBmOsfUo+wthspfatTfwpvebucJcxA7c7Ef8tILeSpGEccl6/4vZfXFA0r0nf7W2PTabg1Hna8TlLF/TuY/4vXb4JnjVzOdOLduFA1sBwvrSX20OegP15Yt3DXx9XNkW0AZAsrPbpgrVgItrdpRc5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770491730; c=relaxed/simple;
	bh=fuSiZlRynij4IQh1g5KZ9i07wPhSWBvurZeW0hnxdd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t588/mS6n14W2gbw6xVFW1nw/1dJYueesPRzgcjcnf4xbhy5bF/y44IfDiGs55JsVByfdViIBObJT5Fh3iS2m84SobxXhJvA7b17qXVJYAEUMs9mFjHUVlx8JaBDjEuHV7TwYuT5RumwGwVhTGZdLHSxAoh8NPuU7panEszBKss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSKEM6YH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B613FC16AAE;
	Sat,  7 Feb 2026 19:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770491729;
	bh=fuSiZlRynij4IQh1g5KZ9i07wPhSWBvurZeW0hnxdd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dSKEM6YHbLYIc7K7cxjf46KmTkp0bImcJ3YGUxAnjFQD7/qtf1ISp0ig7vvanUbaY
	 dx7vp4r9MOly/Q4GS5RS7tr+2ZJUi9VcIt2YJ2fhhgLhaUjF4Ejn8H+5yHtnRuUKaB
	 njz1P5AtiVnq9jURbM3XiGXkd4uX/8+ujTjIfC1RAc4rsUBVVuuNANEui/HgZdPkIN
	 NmS7c7l0UWJzKqU/Uwgw4SgL57zBbK1tfqsBSQXQPnprkGG4Znf5p0plhizd73XBaX
	 aEJxD6gwdAkY3mZKJUezgjeLpnlLb+TGXDe872vUZRKVFa59gNZNqxBeivMZuu+XXm
	 TEHFZ+pny0yIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Max Yuan <maxyuan@google.com>,
	Jordan Rhee <jordanrhee@google.com>,
	Joshua Washington <joshwash@google.com>,
	Matt Olson <maolson@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] gve: Correct ethtool rx_dropped calculation
Date: Sat,  7 Feb 2026 14:15:27 -0500
Message-ID: <20260207191527.516750-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020758-gravy-resupply-beb4@gregkh>
References: <2026020758-gravy-resupply-beb4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214822-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0DFD5106F30
X-Rspamd-Action: no action

From: Max Yuan <maxyuan@google.com>

[ Upstream commit c7db85d579a1dccb624235534508c75fbf2dfe46 ]

The gve driver's "rx_dropped" statistic, exposed via `ethtool -S`,
incorrectly includes `rx_buf_alloc_fail` counts. These failures
represent an inability to allocate receive buffers, not true packet
drops where a received packet is discarded. This misrepresentation can
lead to inaccurate diagnostics.

This patch rectifies the ethtool "rx_dropped" calculation. It removes
`rx_buf_alloc_fail` from the total and adds `xdp_tx_errors` and
`xdp_redirect_errors`, which represent legitimate packet drops within
the XDP path.

Cc: stable@vger.kernel.org
Fixes: 433e274b8f7b ("gve: Add stats for gve.")
Signed-off-by: Max Yuan <maxyuan@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Matt Olson <maolson@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20260202193925.3106272-3-hramamurthy@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Context + variable naming ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/google/gve/gve_ethtool.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 7e60139f8ac57..a9e5033df104e 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -215,8 +215,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	data[i++] = rx_bytes;
 	data[i++] = tx_bytes;
 	/* total rx dropped packets */
-	data[i++] = rx_skb_alloc_fail + rx_buf_alloc_fail +
-		    rx_desc_err_dropped_pkt;
+	data[i++] = rx_skb_alloc_fail + rx_desc_err_dropped_pkt;
 	data[i++] = tx_dropped;
 	data[i++] = priv->tx_timeo_cnt;
 	data[i++] = rx_skb_alloc_fail;
@@ -273,7 +272,6 @@ gve_get_ethtool_stats(struct net_device *netdev,
 			data[i++] = rx->rx_frag_copy_cnt;
 			/* rx dropped packets */
 			data[i++] = tmp_rx_skb_alloc_fail +
-				tmp_rx_buf_alloc_fail +
 				tmp_rx_desc_err_dropped_pkt;
 			data[i++] = rx->rx_copybreak_pkt;
 			data[i++] = rx->rx_copied_pkt;
-- 
2.51.0


