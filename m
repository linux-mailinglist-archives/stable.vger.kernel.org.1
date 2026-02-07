Return-Path: <stable+bounces-214825-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XrKsJK2Wh2kDaQQAu9opvQ
	(envelope-from <stable+bounces-214825-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 20:46:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DD2106FC5
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 20:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 359CD3016CAF
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 19:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E49A270EDF;
	Sat,  7 Feb 2026 19:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ickEY0pc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5232D3D544
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770493609; cv=none; b=Hj09zUZ/eHUc5vP+2Lc3L8JdYhEfTgpTy4BZ4AOnFDnMNsoILSVdZJoynD9wTXfISDi+mD76S+hQdT4TFpXJttPRym3eWE7FjtpUfgU7LhCsOaq4btAou33Kjk+AgZsZD7VL8jslHiVRujw9jWFjiwU05CRetbxSAoQOrosH0AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770493609; c=relaxed/simple;
	bh=VBjULUzn120ur3IW6k8F7cC+diB1+mjC5RCg/BgAGLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fx+YwBZTt9KRvCSYSV1CIYk/Qvu6cNehgxTS/1c7fm/IuDZFo10iCKxm4Z7mz7nZr0q8lV+R4yUyxhI/NBmLzqBXagPqdBz+6TFO2j13MbJd69BE1KmreyFP6v+msFmcZPltIqTY4YaAl0fDvz2PtqAyVDuMr+8xrKqs+0x3p9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ickEY0pc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34090C116D0;
	Sat,  7 Feb 2026 19:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770493608;
	bh=VBjULUzn120ur3IW6k8F7cC+diB1+mjC5RCg/BgAGLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ickEY0pcBaGZljuy7Va/ofNFmTGJ/RviYzW51bCfTyYe42fg1gySpFfOlQuiRFT3a
	 Q/ECW0VwEebREawPb+Sg1Gy8xeuVNdvDB+sqkxQGVZykPXuK0z7LuQFAfSLmnTqf4Z
	 5oo5Q/QOWrleD3PF3sjgrdzD56qwQQSSGXR0j2fmGC5rekUx2bIVE63lVBbau0uGcu
	 CIrFf5tUYnecLIWaRkTCOL5qXZdSNN6PqIy9aHsJwdPgVrjhXqlbW6wqw0KTDP4XB5
	 D7NLllNCyjmZbZB9cs0LCtGcgP96VyEsLQuzTrInNAy/FdA1qB4Om4zIIUQWEs87V9
	 HPeRtYhsZPPMg==
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
Subject: [PATCH 5.10.y] gve: Correct ethtool rx_dropped calculation
Date: Sat,  7 Feb 2026 14:46:45 -0500
Message-ID: <20260207194645.533741-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020704-caring-doornail-1175@gregkh>
References: <2026020704-caring-doornail-1175@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214825-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: D8DD2106FC5
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
[ removed rx_buf_alloc_fail from rx_dropped calculation ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/google/gve/gve_ethtool.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index cbfd007449351..2a52cce7838e0 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -209,8 +209,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	data[i++] = rx_bytes;
 	data[i++] = tx_bytes;
 	/* total rx dropped packets */
-	data[i++] = rx_skb_alloc_fail + rx_buf_alloc_fail +
-		    rx_desc_err_dropped_pkt;
+	data[i++] = rx_skb_alloc_fail + rx_desc_err_dropped_pkt;
 	/* Skip tx_dropped */
 	i++;
 
@@ -265,7 +264,6 @@ gve_get_ethtool_stats(struct net_device *netdev,
 			data[i++] = tmp_rx_bytes;
 			/* rx dropped packets */
 			data[i++] = tmp_rx_skb_alloc_fail +
-				tmp_rx_buf_alloc_fail +
 				tmp_rx_desc_err_dropped_pkt;
 			data[i++] = rx->rx_copybreak_pkt;
 			data[i++] = rx->rx_copied_pkt;
-- 
2.51.0


