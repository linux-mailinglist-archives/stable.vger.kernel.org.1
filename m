Return-Path: <stable+bounces-212575-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ5NIRM6emlB4wEAu9opvQ
	(envelope-from <stable+bounces-212575-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:32:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F0EA5C4D
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90ECA3030A71
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF38F302779;
	Wed, 28 Jan 2026 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AGya4acY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735D81D6AA;
	Wed, 28 Jan 2026 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615977; cv=none; b=aJVfL3oQJB0lc4TT5L1O1VDIcdJ+o7WsK95snDmb7uHv1T7IwPHPBbg4X95f3hog2pc/3RYDFDBQ0xH4VCNxlu0qLMuMJ41Vs+ys7Wr5mTSgNdFef7d+MPTUhH/rg0fuKjDMM/7STHMzTNAxS4lt2oOoJvF7Smk7/aGpNQFUllk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615977; c=relaxed/simple;
	bh=OrO/oi9moCvGKULwd0ZNt8emGAT+kkFpeMUS4rrm+4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbmic6deJuaVSrRd6k/DKayCQMHdo/wA6zm0GHwK7Sgv2YLanfnnv5ljJ8DMwOfJOoJOspYDMoFHhJjtWQy2byD96ZG60vWfvJqvPlGeTMIm9iw+/eiGVD/YEfqO/ZObJ0WEccZ0EwIwCOouFzvOIsxuNyffuxHHWZY+MAOvtJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AGya4acY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DD2C4CEF1;
	Wed, 28 Jan 2026 15:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615977;
	bh=OrO/oi9moCvGKULwd0ZNt8emGAT+kkFpeMUS4rrm+4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AGya4acY1yxWFiumMB0pmBHl2SaZVTDJnWj0z5kHeyx3joA8S5cfpO3dat2g55+MD
	 x785TmAaZXbrIdcGvfeX8AH4qN1zQmMtJQweE2z2Zq13KVABjdQO3VS9YT5FR+SvhM
	 QgfXlnogj6cp/N/lf/qSD8E9bU4FjYbyNUZtbPTw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 138/227] net: bcmasp: Fix network filter wake for asp-3.0
Date: Wed, 28 Jan 2026 16:23:03 +0100
Message-ID: <20260128145349.426167182@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212575-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: B3F0EA5C4D
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Chen <justin.chen@broadcom.com>

[ Upstream commit bbb11b8d758d17a4ce34b8ed0b49de150568265b ]

We need to apply the tx_chan_offset to the netfilter cfg channel or the
output channel will be incorrect for asp-3.0 and newer.

Fixes: e9f31435ee7d ("net: bcmasp: Add support for asp-v3.0")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://patch.msgid.link/20260120192339.2031648-1-justin.chen@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 5 +++--
 drivers/net/ethernet/broadcom/asp2/bcmasp.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index fd35f4b4dc50b..014340f33345a 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -156,7 +156,7 @@ static void bcmasp_netfilt_hw_en_wake(struct bcmasp_priv *priv,
 			  ASP_RX_FILTER_NET_OFFSET_L4(32),
 			  ASP_RX_FILTER_NET_OFFSET(nfilt->hw_index + 1));
 
-	rx_filter_core_wl(priv, ASP_RX_FILTER_NET_CFG_CH(nfilt->port + 8) |
+	rx_filter_core_wl(priv, ASP_RX_FILTER_NET_CFG_CH(nfilt->ch) |
 			  ASP_RX_FILTER_NET_CFG_EN |
 			  ASP_RX_FILTER_NET_CFG_L2_EN |
 			  ASP_RX_FILTER_NET_CFG_L3_EN |
@@ -166,7 +166,7 @@ static void bcmasp_netfilt_hw_en_wake(struct bcmasp_priv *priv,
 			  ASP_RX_FILTER_NET_CFG_UMC(nfilt->port),
 			  ASP_RX_FILTER_NET_CFG(nfilt->hw_index));
 
-	rx_filter_core_wl(priv, ASP_RX_FILTER_NET_CFG_CH(nfilt->port + 8) |
+	rx_filter_core_wl(priv, ASP_RX_FILTER_NET_CFG_CH(nfilt->ch) |
 			  ASP_RX_FILTER_NET_CFG_EN |
 			  ASP_RX_FILTER_NET_CFG_L2_EN |
 			  ASP_RX_FILTER_NET_CFG_L3_EN |
@@ -714,6 +714,7 @@ struct bcmasp_net_filter *bcmasp_netfilt_get_init(struct bcmasp_intf *intf,
 		nfilter = &priv->net_filters[open_index];
 		nfilter->claimed = true;
 		nfilter->port = intf->port;
+		nfilter->ch = intf->channel + priv->tx_chan_offset;
 		nfilter->hw_index = open_index;
 	}
 
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.h b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
index 74adfdb50e11d..e238507be40af 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.h
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
@@ -348,6 +348,7 @@ struct bcmasp_net_filter {
 	bool				wake_filter;
 
 	int				port;
+	int				ch;
 	unsigned int			hw_index;
 };
 
-- 
2.51.0




