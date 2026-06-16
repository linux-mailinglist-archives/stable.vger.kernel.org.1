Return-Path: <stable+bounces-264297-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZuIRD/d1MWqbjwUAu9opvQ
	(envelope-from <stable+bounces-264297-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:12:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBC6691CEF
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:12:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=g15es8ji;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264297-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-264297-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5697F301CD10
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E6D44CAE6;
	Tue, 16 Jun 2026 15:53:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2BE44B68E;
	Tue, 16 Jun 2026 15:53:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625222; cv=none; b=rGXBM+uFGXYhUhF2VN6g1mwcVD2IETNMwmQKskj3Z0yVrlS/2+cmEdQ1R6+QquNI3lt15+MvAF6AdBLfFiMW5eJbqaeE5o5d5Wjg4xcrd8uXY7cXCKMSDLEYfTZq1hJyMMKf77+T2qVFpxGATD1LjakwV3Ys72FhDTSJY0fNcjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625222; c=relaxed/simple;
	bh=1AEDF9oZDHESesBMxV3m65xYyY/ulbmU4h+Vy1rjYLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0BVW+5GWdgAloO5UyuNpipY9BfQx6vmaZLE6d63DCsRPxlqPdzslNyjXYeUCYl7QbEzyQL++dnWyZ321MGCr/6THhz5SNz95KaEafFD9WLUN4inFcjOS3uocSAn7+Ot2s/OnGFlVONlgATuev2QZAJ6P0gvP4npY1miAWh5D90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g15es8ji; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46191F000E9;
	Tue, 16 Jun 2026 15:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625221;
	bh=t4QQ3NrEcE1ftLFMFoNyjj9bNseSq3Kr0N/EN5FQbsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g15es8jiYdFX6gzBlllOYeRwXA05Ba3coBYWj9g7Hcn8tPi3PTGawqhZ3kdfmRZNU
	 femgm2XZZpUPn6ZxrMhRJzVbM2Tcse/GsY+jhwNnJvn2TAxWuwz/G+20Ir2fm3zhZn
	 GGZ9KQ1Zbfbxh+yBUk3ZNQAs9ugZqtf1/tA8cb4o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rosen Penev <rosenp@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 100/325] net: ibm: emac: Fix use-after-free during device removal
Date: Tue, 16 Jun 2026 20:28:16 +0530
Message-ID: <20260616145102.669721837@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-264297-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:rosenp@gmail.com,m:jacob.e.keller@intel.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CBC6691CEF

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rosen Penev <rosenp@gmail.com>

[ Upstream commit a0130d682222ae21afc395aead7cd2d87e1a8358 ]

The driver was using devm_register_netdev() which causes unregister_netdev()
to be deferred until the devres cleanup phase, which runs after emac_remove()
returns. This creates a use-after-free window where:

1. emac_remove() is called, which tears down hardware (cancels work, detaches
   modules, unregisters from MAL)
2. emac_remove() returns
3. devres cleanup runs and finally calls unregister_netdev()

During step 3, the network stack might still process packets, triggering
emac_irq(), emac_poll(), or other handlers that access now-freed hardware
resources (dev->emacp, dev->mal, etc.).

Fix this by replacing devm_register_netdev() with manual register_netdev()
and calling unregister_netdev() at the beginning of emac_remove(), before
any hardware teardown. This ensures the network device is fully stopped and
unregistered before hardware resources are released.

The change is safe because:
- dev->ndev is assigned very early in probe (before any error paths that
  could bypass emac_remove)
- platform_set_drvdata() is only called after successful registration, so
  emac_remove() only runs for fully registered devices
- unregister_netdev() is idempotent and safe to call on any registered device

Fixes: a4dd8535a527 ("net: ibm: emac: use devm for register_netdev")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/emac/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 417dfa18daae3a..4e503b3d0d2d34 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3144,7 +3144,7 @@ static int emac_probe(struct platform_device *ofdev)
 
 	netif_carrier_off(ndev);
 
-	err = devm_register_netdev(&ofdev->dev, ndev);
+	err = register_netdev(ndev);
 	if (err) {
 		printk(KERN_ERR "%pOF: failed to register net device (%d)!\n",
 		       np, err);
@@ -3197,6 +3197,13 @@ static void emac_remove(struct platform_device *ofdev)
 
 	DBG(dev, "remove" NL);
 
+	/* Unregister network device before tearing down hardware
+	 * to prevent use-after-free during deferred cleanup. This ensures
+	 * the network stack stops all operations before hardware resources
+	 * are released.
+	 */
+	unregister_netdev(dev->ndev);
+
 	cancel_work_sync(&dev->reset_work);
 
 	if (emac_has_feature(dev, EMAC_FTR_HAS_TAH))
-- 
2.53.0




