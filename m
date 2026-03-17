Return-Path: <stable+bounces-226201-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEQAHq+FuWkPJAIAu9opvQ
	(envelope-from <stable+bounces-226201-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:47:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C91DC2AE6DA
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89B013009155
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5993A3ED13D;
	Tue, 17 Mar 2026 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VHIBL//D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEE714F70;
	Tue, 17 Mar 2026 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765693; cv=none; b=g+dywPfwXl3NvMNPZypdIYQHg1L9sfzFbAo0aTKcSEPPEvjKTan+Nc3hKeM5t6DBrgn6ZeuEXPV5pIFSQWWDN+8Yj/mPjR/16OX2SLYM270hF3jnoTk3tMFe6uMQpbOrtlj4lElppCRkCX3X7FCttwNVh8R21PCQX5bMvdBjRrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765693; c=relaxed/simple;
	bh=/OdfbMm/3Uy/m5eOm+geznu7Jo26ELfxlI+hUEOiPGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qX+pwAf9Td7Xk88tPiF08CTIcTBZotJgnSrO3ixUO+M2hq/vIvFXWa/LkvyXJC5WBjFxN37/nRwWt0iWPodgW61HB7V11Zf0ldO9+ZzmbkMlKJbyyuoi58VDcudG2kShbc5FrBcHQbQYtdNFkY87TC9KXVMxaGMO5KOt8HEPlD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VHIBL//D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B957C4CEF7;
	Tue, 17 Mar 2026 16:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773765692;
	bh=/OdfbMm/3Uy/m5eOm+geznu7Jo26ELfxlI+hUEOiPGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VHIBL//DMVgSV2ac3/1zFm+EChOsdN1lQqbqfoliKVBLxpwPCPB8STIS3X2jaP9Z8
	 7/8KBtcQHVQn5oKkF/yvfB184KM8406sz3sVMMine36sZ6FJH1NJQ0T/pCQyLpLjDk
	 6kBtbXSUsD0b4qFcPFe7AmchSNcCJz4EzeTHW7Uc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 072/378] amd-xgbe: reset PHY settings before starting PHY
Date: Tue, 17 Mar 2026 17:30:29 +0100
Message-ID: <20260317163009.665967103@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226201-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,bootlin.com:email,amd.com:email]
X-Rspamd-Queue-Id: C91DC2AE6DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raju Rangoju <Raju.Rangoju@amd.com>

[ Upstream commit a8ba129af46856112981c124850ec6a85a1c1ab6 ]

commit f93505f35745 ("amd-xgbe: let the MAC manage PHY PM") moved
xgbe_phy_reset() from xgbe_open() to xgbe_start(), placing it after
phy_start(). As a result, the PHY settings were being reset after the
PHY had already started.

Reorder the calls so that the PHY settings are reset before
phy_start() is invoked.

Fixes: f93505f35745 ("amd-xgbe: let the MAC manage PHY PM")
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
Link: https://patch.msgid.link/20260306111629.1515676-4-Raju.Rangoju@amd.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 3444ec681a11f..6de12a0e06553 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1271,6 +1271,12 @@ static int xgbe_start(struct xgbe_prv_data *pdata)
 	if (ret)
 		goto err_napi;
 
+	/* Reset the phy settings */
+	ret = xgbe_phy_reset(pdata);
+	if (ret)
+		goto err_irqs;
+
+	/* Start the phy */
 	ret = phy_if->phy_start(pdata);
 	if (ret)
 		goto err_irqs;
@@ -1284,11 +1290,6 @@ static int xgbe_start(struct xgbe_prv_data *pdata)
 
 	udp_tunnel_nic_reset_ntf(netdev);
 
-	/* Reset the phy settings */
-	ret = xgbe_phy_reset(pdata);
-	if (ret)
-		goto err_txrx;
-
 	netif_tx_start_all_queues(netdev);
 
 	xgbe_start_timers(pdata);
@@ -1298,10 +1299,6 @@ static int xgbe_start(struct xgbe_prv_data *pdata)
 
 	return 0;
 
-err_txrx:
-	hw_if->disable_rx(pdata);
-	hw_if->disable_tx(pdata);
-
 err_irqs:
 	xgbe_free_irqs(pdata);
 
-- 
2.51.0




