Return-Path: <stable+bounces-229098-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOhWEAhswWkVTAQAu9opvQ
	(envelope-from <stable+bounces-229098-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:36:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A13652F8690
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A69F31BD262
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFF723A564;
	Mon, 23 Mar 2026 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zvZ5+Iux"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FF81A00F0;
	Mon, 23 Mar 2026 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278053; cv=none; b=RHybW0T5MySmAxmkcG/6tdyOTVoRO1IyQqdrhSBEFG1ttepo6vLJq8X2v2OOtuX8JuCtxub6BFlScsthmP4QJ87WiFeLVBXDFfNbbfF93YS0WjM6UhB+391gQQCMYjzU/Kam63i6P9v5+5YVXA/n2/triWDRRJtnzAtUAQvcsC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278053; c=relaxed/simple;
	bh=PIY128Zii2Z7OqlYd3tkpzmi3qRVdCitonA7tVAKTZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTpYsCvW/c5qWy2gOVqpAei2prtxSAkL+pYgwaU2SaO4Ryhg+9Xvo3GUYdZ6mGdaoj3HlGH2vTnYBv2Qsi6MMOpDDkoSxq5Jw7W1hL5Bftg9rIw+DnEgLK42ucU644lJ3kDLmMQXhj3GoQrFrP0RS2N+Ax0JecL1zi6sT3nqOtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zvZ5+Iux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3718AC4CEF7;
	Mon, 23 Mar 2026 15:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278053;
	bh=PIY128Zii2Z7OqlYd3tkpzmi3qRVdCitonA7tVAKTZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zvZ5+IuxO0yuix1z77coeUw8cGQVmak7Ijwf5uozk2AF0JJirPBbu2V83wGkp+THQ
	 WxTC2sAVlIbGh0Zj7BbKUaYXWjEjvhW3h6+zv2va8Rte6AdKyOep21BxL+l1O4v3xA
	 3QxwohM7MWxHtvtZlllvPyf5Cb8oFbrPUA89Xc/U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alban Bedel <alban.bedel@lht.dlh.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 144/567] can: mcp251x: fix deadlock in error path of mcp251x_open
Date: Mon, 23 Mar 2026 14:41:04 +0100
Message-ID: <20260323134537.389400945@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229098-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A13652F8690
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alban Bedel <alban.bedel@lht.dlh.de>

[ Upstream commit ab3f894de216f4a62adc3b57e9191888cbf26885 ]

The mcp251x_open() function call free_irq() in its error path with the
mpc_lock mutex held. But if an interrupt already occurred the
interrupt handler will be waiting for the mpc_lock and free_irq() will
deadlock waiting for the handler to finish.

This issue is similar to the one fixed in commit 7dd9c26bd6cf ("can:
mcp251x: fix deadlock if an interrupt occurs during mcp251x_open") but
for the error path.

To solve this issue move the call to free_irq() after the lock is
released. Setting `priv->force_quit = 1` beforehand ensure that the IRQ
handler will exit right away once it acquired the lock.

Signed-off-by: Alban Bedel <alban.bedel@lht.dlh.de>
Link: https://patch.msgid.link/20260209144706.2261954-1-alban.bedel@lht.dlh.de
Fixes: bf66f3736a94 ("can: mcp251x: Move to threaded interrupts instead of workqueues.")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/spi/mcp251x.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 8c56f85e87c1a..72ae17b2313ec 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1202,6 +1202,7 @@ static int mcp251x_open(struct net_device *net)
 {
 	struct mcp251x_priv *priv = netdev_priv(net);
 	struct spi_device *spi = priv->spi;
+	bool release_irq = false;
 	unsigned long flags = 0;
 	int ret;
 
@@ -1245,12 +1246,24 @@ static int mcp251x_open(struct net_device *net)
 	return 0;
 
 out_free_irq:
-	free_irq(spi->irq, priv);
+	/* The IRQ handler might be running, and if so it will be waiting
+	 * for the lock. But free_irq() must wait for the handler to finish
+	 * so calling it here would deadlock.
+	 *
+	 * Setting priv->force_quit will let the handler exit right away
+	 * without any access to the hardware. This make it safe to call
+	 * free_irq() after the lock is released.
+	 */
+	priv->force_quit = 1;
+	release_irq = true;
+
 	mcp251x_hw_sleep(spi);
 out_close:
 	mcp251x_power_enable(priv->transceiver, 0);
 	close_candev(net);
 	mutex_unlock(&priv->mcp_lock);
+	if (release_irq)
+		free_irq(spi->irq, priv);
 	return ret;
 }
 
-- 
2.51.0




