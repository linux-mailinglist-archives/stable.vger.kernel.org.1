Return-Path: <stable+bounces-225154-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBRiHVohs2m5SQAAu9opvQ
	(envelope-from <stable+bounces-225154-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:26:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 096052790A9
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6FBB83026528
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB08F35A3BA;
	Thu, 12 Mar 2026 20:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KCtuWfGS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECA9318EE1;
	Thu, 12 Mar 2026 20:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347159; cv=none; b=tw2+MNFCxEwEdRu5XYwHoHLYwgPJCa2jmY9CNXPBohrRGpvgGiwAA58SM0mlfnKb/H6SYZsC2fgjZy2cBvIAXLRUoBqI8+pesqULE2zu33fCkCF0tgP9n0Sp+/gp75QxwJs8FCTOFUbBER07pl0gUJtcWv6dy54s46CIXaEM2HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347159; c=relaxed/simple;
	bh=3D1dNy04ptpw1uiB+hY7rMs03e8LgKU2mlPiZOzY9jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oCVMNFlflkOWGuGGvcqZABwutS6zqAq71hPZtdeDukH0+U+4V9TQVsRqF8+BtFT2WTYSMu7xytVTpLUIBXGi+zaYIXTao6BcpTLBoq+20S4yibZT8wEVoKLiVWc2V4peAjbJFmqYxAqHDrxi2bTx/jXMYcc7AsqvsONCbuQI+og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KCtuWfGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF4BC4CEF7;
	Thu, 12 Mar 2026 20:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773347159;
	bh=3D1dNy04ptpw1uiB+hY7rMs03e8LgKU2mlPiZOzY9jI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KCtuWfGSttXCbUrq+/mBmPzYb+PC9i414XVQXqKeDUhJHsq7AzzOkVx7gg3WsJHpH
	 1f2nnDGQGLC/V6dWS+tr63SInutBgn6wUItOx83JfPD7AWf0zKO25nyu4+axLwPBkb
	 3LDbU3TYhSKLCnbgYwB4E2pV0D2G/Ca6BFt+YPnI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 219/265] amd-xgbe: fix sleep while atomic on suspend/resume
Date: Thu, 12 Mar 2026 21:10:06 +0100
Message-ID: <20260312201026.234400841@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-225154-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 096052790A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raju Rangoju <Raju.Rangoju@amd.com>

[ Upstream commit e2f27363aa6d983504c6836dd0975535e2e9dba0 ]

The xgbe_powerdown() and xgbe_powerup() functions use spinlocks
(spin_lock_irqsave) while calling functions that may sleep:
- napi_disable() can sleep waiting for NAPI polling to complete
- flush_workqueue() can sleep waiting for pending work items

This causes a "BUG: scheduling while atomic" error during suspend/resume
cycles on systems using the AMD XGBE Ethernet controller.

The spinlock protection in these functions is unnecessary as these
functions are called from suspend/resume paths which are already serialized
by the PM core

Fix this by removing the spinlock. Since only code that takes this lock
is xgbe_powerdown() and xgbe_powerup(), remove it completely.

Fixes: c5aa9e3b8156 ("amd-xgbe: Initial AMD 10GbE platform driver")
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
Link: https://patch.msgid.link/20260302042124.1386445-1-Raju.Rangoju@amd.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c  | 10 ----------
 drivers/net/ethernet/amd/xgbe/xgbe-main.c |  1 -
 drivers/net/ethernet/amd/xgbe/xgbe.h      |  3 ---
 3 files changed, 14 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index e6a2492360227..c6fcddbff3f56 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1181,7 +1181,6 @@ int xgbe_powerdown(struct net_device *netdev, unsigned int caller)
 {
 	struct xgbe_prv_data *pdata = netdev_priv(netdev);
 	struct xgbe_hw_if *hw_if = &pdata->hw_if;
-	unsigned long flags;
 
 	DBGPR("-->xgbe_powerdown\n");
 
@@ -1192,8 +1191,6 @@ int xgbe_powerdown(struct net_device *netdev, unsigned int caller)
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&pdata->lock, flags);
-
 	if (caller == XGMAC_DRIVER_CONTEXT)
 		netif_device_detach(netdev);
 
@@ -1209,8 +1206,6 @@ int xgbe_powerdown(struct net_device *netdev, unsigned int caller)
 
 	pdata->power_down = 1;
 
-	spin_unlock_irqrestore(&pdata->lock, flags);
-
 	DBGPR("<--xgbe_powerdown\n");
 
 	return 0;
@@ -1220,7 +1215,6 @@ int xgbe_powerup(struct net_device *netdev, unsigned int caller)
 {
 	struct xgbe_prv_data *pdata = netdev_priv(netdev);
 	struct xgbe_hw_if *hw_if = &pdata->hw_if;
-	unsigned long flags;
 
 	DBGPR("-->xgbe_powerup\n");
 
@@ -1231,8 +1225,6 @@ int xgbe_powerup(struct net_device *netdev, unsigned int caller)
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&pdata->lock, flags);
-
 	pdata->power_down = 0;
 
 	xgbe_napi_enable(pdata, 0);
@@ -1247,8 +1239,6 @@ int xgbe_powerup(struct net_device *netdev, unsigned int caller)
 
 	xgbe_start_timers(pdata);
 
-	spin_unlock_irqrestore(&pdata->lock, flags);
-
 	DBGPR("<--xgbe_powerup\n");
 
 	return 0;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-main.c b/drivers/net/ethernet/amd/xgbe/xgbe-main.c
index 0e8698928e4d7..6e8fafb2acbaa 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-main.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-main.c
@@ -185,7 +185,6 @@ struct xgbe_prv_data *xgbe_alloc_pdata(struct device *dev)
 	pdata->netdev = netdev;
 	pdata->dev = dev;
 
-	spin_lock_init(&pdata->lock);
 	spin_lock_init(&pdata->xpcs_lock);
 	mutex_init(&pdata->rss_mutex);
 	spin_lock_init(&pdata->tstamp_lock);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 7526a0906b391..c98461252053f 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -1083,9 +1083,6 @@ struct xgbe_prv_data {
 	unsigned int pp3;
 	unsigned int pp4;
 
-	/* Overall device lock */
-	spinlock_t lock;
-
 	/* XPCS indirect addressing lock */
 	spinlock_t xpcs_lock;
 	unsigned int xpcs_window_def_reg;
-- 
2.51.0




