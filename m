Return-Path: <stable+bounces-256950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJB8LLcOG2q/+ggAu9opvQ
	(envelope-from <stable+bounces-256950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:22:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A6460E1B1
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECB603027BBE
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5409346A04;
	Sat, 30 May 2026 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rcONoVNO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD97344D92;
	Sat, 30 May 2026 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157864; cv=none; b=bWtYaFHFsE1ghaRfpYkoW2CUGW28YFuvohopRDLo9wMa1DGXj+KqQ4TQPPDsfBchOwn+Lo/2K9wxOkMkcUbOR55YzlLvLC9Ux630PWUoBoyuoPxSQ4EZa72s9BpzrXZkcagJcC1GSoG37u/qvSbKIbKsA5qJc5vRXtdobfyuzVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157864; c=relaxed/simple;
	bh=ZBqprtyeOitAFLsuO2YY/cbgvxMNDGHSTEEcNV2Sk8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/Hz7pupxnCY4kS/HRATUTtIPGfbjBwz4ggiAk8NDePXiw0XCNI1yEUv+Z35LoLykD9yvKRlWwUswquiVDHTZ8N0yzKIpSf2aEE0A8opm9gAXyqNOXltHA9Knvajl/v+YZb7T8WrZAaxTMwmNO5A/H/YtZzOk1uHn6KZ7IJT0NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rcONoVNO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BE21F00893;
	Sat, 30 May 2026 16:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780157862;
	bh=/n5DMwRioftIAsa3t/XOdk/A4p0ixnAG9PT08t/8kG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rcONoVNOrtierQJuHQrEPsZAkT7LGjindCcWC2rUedCOgNZVGrLr2Xk2atOqhTR4x
	 tL5rEwZloyx+2vqicvdPZore/BwgJc9swr4uC8phKw1smgBtnqzAU+kgtl4lnXmypO
	 qzelvX0p/YTFT4HK19bgsA35bFRkLDqjzNWhf+nM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wenyuan Li <2063309626@qq.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 007/969] can: mcp251x: add error handling for power enable in open and resume
Date: Sat, 30 May 2026 17:52:11 +0200
Message-ID: <20260530160300.687363328@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256950-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,qq.com,pengutronix.de,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: B3A6460E1B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenyuan Li <2063309626@qq.com>

[ Upstream commit 7a57354756c7df223abe2c33774235ad70cb4231 ]

Add missing error handling for mcp251x_power_enable() calls in both
mcp251x_open() and mcp251x_can_resume() functions.

In mcp251x_open(), if power enable fails, jump to error path to close
candev without attempting to disable power again.

In mcp251x_can_resume(), properly check return values of power enable calls
for both power and transceiver regulators. If any fails, return the error
code to the PM framework and log the failure.

This ensures the driver properly handles power control failures and
maintains correct device state.

Signed-off-by: Wenyuan Li <2063309626@qq.com>
Link: https://patch.msgid.link/tencent_F3EFC5D7738AC548857B91657715E2D3AA06@qq.com
[mkl: fix patch description]
[mkl: mcp251x_can_resume(): replace goto by return]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/spi/mcp251x.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 72ae17b2313ec..d3ffab297b77b 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1213,7 +1213,11 @@ static int mcp251x_open(struct net_device *net)
 	}
 
 	mutex_lock(&priv->mcp_lock);
-	mcp251x_power_enable(priv->transceiver, 1);
+	ret = mcp251x_power_enable(priv->transceiver, 1);
+	if (ret) {
+		dev_err(&spi->dev, "failed to enable transceiver power: %pe\n", ERR_PTR(ret));
+		goto out_close_candev;
+	}
 
 	priv->force_quit = 0;
 	priv->tx_skb = NULL;
@@ -1260,6 +1264,7 @@ static int mcp251x_open(struct net_device *net)
 	mcp251x_hw_sleep(spi);
 out_close:
 	mcp251x_power_enable(priv->transceiver, 0);
+out_close_candev:
 	close_candev(net);
 	mutex_unlock(&priv->mcp_lock);
 	if (release_irq)
@@ -1499,11 +1504,25 @@ static int __maybe_unused mcp251x_can_resume(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct mcp251x_priv *priv = spi_get_drvdata(spi);
+	int ret = 0;
 
-	if (priv->after_suspend & AFTER_SUSPEND_POWER)
-		mcp251x_power_enable(priv->power, 1);
-	if (priv->after_suspend & AFTER_SUSPEND_UP)
-		mcp251x_power_enable(priv->transceiver, 1);
+	if (priv->after_suspend & AFTER_SUSPEND_POWER) {
+		ret = mcp251x_power_enable(priv->power, 1);
+		if (ret) {
+			dev_err(dev, "failed to restore power: %pe\n", ERR_PTR(ret));
+			return ret;
+		}
+	}
+
+	if (priv->after_suspend & AFTER_SUSPEND_UP) {
+		ret = mcp251x_power_enable(priv->transceiver, 1);
+		if (ret) {
+			dev_err(dev, "failed to restore transceiver power: %pe\n", ERR_PTR(ret));
+			if (priv->after_suspend & AFTER_SUSPEND_POWER)
+				mcp251x_power_enable(priv->power, 0);
+			return ret;
+		}
+	}
 
 	if (priv->after_suspend & (AFTER_SUSPEND_POWER | AFTER_SUSPEND_UP))
 		queue_work(priv->wq, &priv->restart_work);
-- 
2.53.0




