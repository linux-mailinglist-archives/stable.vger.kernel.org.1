Return-Path: <stable+bounces-225118-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8K5wGOUgs2m5SQAAu9opvQ
	(envelope-from <stable+bounces-225118-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:24:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0379E278F5F
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23FBA3047DF6
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74FB359A8B;
	Thu, 12 Mar 2026 20:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UlRyO4lQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADA82D2491;
	Thu, 12 Mar 2026 20:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347033; cv=none; b=WCkG+PBVqkfOqtVcX4zFktJAqyr2QSY0XZwBwXsSW/LMShZ9YGB0+Ts49DgwXH7NU5pHU4LQwSQBOQTmZXOekrElOUrthvZU6XBccEnGt1Z9ewjA9KPt+okS9XE/vy/xKct2TBEWeejFd4DEfgDKcQiF86SQxlYYuMvwMeWxXRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347033; c=relaxed/simple;
	bh=uo967bhW8WbH9wrE5EyPFjFdotJ9DnZV8w7paEt3RcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVorW6M/tVYaE0UhYABv6mQD5EddHp0NBWQMXVOHkCAuZTW4+xe2UF+lRzvIm4zLfZdwbPk+86LKimlEO/ROd2iAtfb1z6SZrZXqwMIliDtF3E4zWYx3wUFHCDMVSuZdwCs2nnQiD/PZ+nr3D+hWp57ImX3nxV2chg5qVqzd67M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UlRyO4lQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CA8C4CEF7;
	Thu, 12 Mar 2026 20:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773347033;
	bh=uo967bhW8WbH9wrE5EyPFjFdotJ9DnZV8w7paEt3RcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UlRyO4lQ4qyG+M3ZcfoXVrRl1+dM0ABX0Vof07fuQsVkz854K+me9DORVUZGwihuK
	 PoLCdvQ/NzXj01J8KCto6iOkpPPsMex4ScJHVvsf0Lm33m48jSfNrzY+x5Oe2fngYc
	 P4U6JhK7ZGGhPcWBwdslNhgaYqDpTqOmO+rFHg1g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chintan Vankar <c-vankar@ti.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 184/265] net: ethernet: ti: am65-cpsw-nuss/cpsw-ale: Fix multicast entry handling in ALE table
Date: Thu, 12 Mar 2026 21:09:31 +0100
Message-ID: <20260312201024.958741329@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225118-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,ti.com:email]
X-Rspamd-Queue-Id: 0379E278F5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chintan Vankar <c-vankar@ti.com>

[ Upstream commit be11a537224d72b906db6b98510619770298c8a4 ]

In the current implementation, flushing multicast entries in MAC mode
incorrectly deletes entries for all ports instead of only the target port,
disrupting multicast traffic on other ports. The cause is adding multicast
entries by setting only host port bit, and not setting the MAC port bits.

Fix this by setting the MAC port's bit in the port mask while adding the
multicast entry. Also fix the flush logic to preserve the host port bit
during removal of MAC port and free ALE entries when mask contains only
host port.

Fixes: 5c50a856d550 ("drivers: net: ethernet: cpsw: add multicast address to ALE table")
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260224181359.2055322-1-c-vankar@ti.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
 drivers/net/ethernet/ti/cpsw_ale.c       | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 6b5cff087686e..68049bb2bd989 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -290,7 +290,7 @@ static void am65_cpsw_nuss_ndo_slave_set_rx_mode(struct net_device *ndev)
 	cpsw_ale_set_allmulti(common->ale,
 			      ndev->flags & IFF_ALLMULTI, port->port_id);
 
-	port_mask = ALE_PORT_HOST;
+	port_mask = BIT(port->port_id) | ALE_PORT_HOST;
 	/* Clear all mcast from ALE */
 	cpsw_ale_flush_multicast(common->ale, port_mask, -1);
 
diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index dc5e247ca5d1a..a6bb09545c608 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -443,14 +443,13 @@ static void cpsw_ale_flush_mcast(struct cpsw_ale *ale, u32 *ale_entry,
 				      ale->port_mask_bits);
 	if ((mask & port_mask) == 0)
 		return; /* ports dont intersect, not interested */
-	mask &= ~port_mask;
+	mask &= (~port_mask | ALE_PORT_HOST);
 
-	/* free if only remaining port is host port */
-	if (mask)
+	if (mask == 0x0 || mask == ALE_PORT_HOST)
+		cpsw_ale_set_entry_type(ale_entry, ALE_TYPE_FREE);
+	else
 		cpsw_ale_set_port_mask(ale_entry, mask,
 				       ale->port_mask_bits);
-	else
-		cpsw_ale_set_entry_type(ale_entry, ALE_TYPE_FREE);
 }
 
 int cpsw_ale_flush_multicast(struct cpsw_ale *ale, int port_mask, int vid)
-- 
2.51.0




