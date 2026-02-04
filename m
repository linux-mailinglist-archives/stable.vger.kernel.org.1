Return-Path: <stable+bounces-213435-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LYiLtlbg2mWlwMAu9opvQ
	(envelope-from <stable+bounces-213435-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:46:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C10E7591
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A91E7302E7A1
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0062417E0;
	Wed,  4 Feb 2026 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="umQhAprk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D731C5D77;
	Wed,  4 Feb 2026 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216328; cv=none; b=Uk8pwqNeSrxFjQ5nOXiT+67G6DICKl48TNMFWg9KbnCHT+s0R6eGtK0Tdhp7sPP4naeUXNHrjhyG+imvfitcFl6WdblZ6T0fuDh9b13A/CEhY4ULOGzr5/ewmIxSrJYx3C8sBaJYZaRIZh6+FXN14YBg1Ycv7QDhwbW/1bjVvuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216328; c=relaxed/simple;
	bh=TGL1fpaAh/w+zt7IZxpimUMAq/Y2OKTanYquiyTwqwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tzn1PFDxkIS1XqGXZIZMsttSVvMWiWQf69dpyo1CWeKC2+6Ig1T+Sc4JTqHSlLvEefJqGtEUsJPcWfBJxhcIRu2uMXxcz4K7dPqDHiDArkXOCc1u7zqQ1BY33MrQzSj4MNECmLtPGWavi/QTBv1OMC1S7eCrzE4yhDcuo8lCD3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=umQhAprk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D7EC4CEF7;
	Wed,  4 Feb 2026 14:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216328;
	bh=TGL1fpaAh/w+zt7IZxpimUMAq/Y2OKTanYquiyTwqwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=umQhAprksoCX74o2GfMMQKEs0Ysc3gkx3jDeX9f0Q+Tdee5LK1byzig/RDu5BshgM
	 JB/RA2mBEyIdfQ93TiABYBxezo4wx/Wxh6SiqA8YtPjnZ4M7L+u5sc0/+wd2uekovB
	 dazaTDWvxqf/92stlqzPlyFdlQJEWzmKIwuh9w1U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 054/161] amd-xgbe: avoid misleading per-packet error log
Date: Wed,  4 Feb 2026 15:38:37 +0100
Message-ID: <20260204143853.705132474@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.755002596@linuxfoundation.org>
References: <20260204143851.755002596@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213435-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 31C10E7591
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raju Rangoju <Raju.Rangoju@amd.com>

[ Upstream commit c158f985cf6c2c36c99c4f67af2ff3f5ebe09f8f ]

On the receive path, packet can be damaged because of buffer
overflow in Rx FIFO. Avoid misleading per-packet error log when
packet->errors is set, this can flood the log. Instead, rely on the
standard rtnl_link_stats64 stats.

Fixes: c5aa9e3b8156 ("amd-xgbe: Initial AMD 10GbE platform driver")
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
Link: https://patch.msgid.link/20260114163037.2062606-1-Raju.Rangoju@amd.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 9cd6dac033630..3de7674a84675 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -2112,7 +2112,7 @@ static void xgbe_get_stats64(struct net_device *netdev,
 	s->multicast = pstats->rxmulticastframes_g;
 	s->rx_length_errors = pstats->rxlengtherror;
 	s->rx_crc_errors = pstats->rxcrcerror;
-	s->rx_fifo_errors = pstats->rxfifooverflow;
+	s->rx_over_errors = pstats->rxfifooverflow;
 
 	s->tx_packets = pstats->txframecount_gb;
 	s->tx_bytes = pstats->txoctetcount_gb;
@@ -2568,9 +2568,6 @@ static int xgbe_rx_poll(struct xgbe_channel *channel, int budget)
 			goto read_again;
 
 		if (error || packet->errors) {
-			if (packet->errors)
-				netif_err(pdata, rx_err, netdev,
-					  "error in received packet\n");
 			dev_kfree_skb(skb);
 			goto next_packet;
 		}
-- 
2.51.0




