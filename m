Return-Path: <stable+bounces-224085-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLztKJD+r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-224085-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:20:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD1C24A725
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01FDE30A9AA0
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B27387591;
	Tue, 10 Mar 2026 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nb6F+QRZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFF03859EA;
	Tue, 10 Mar 2026 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141219; cv=none; b=kdkJ88XOSP9mpe0WnQbTj8dQDE7GHcZH8xP1UP0M52e6sb0Ay0SQ9YVT985lNQAmQi1SHoJfwQG9VijhATfsc0yrMznHaaqdDqn+nQf2HGTIRyVmLCMGGQPutgm4vPSh+daQhepQRnzfvh1kgh/A/LXadReLFg2+lLPUYE98VD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141219; c=relaxed/simple;
	bh=fkxiTKcbsPiSAqgE8uqpugt4oyUOwi12Vo0j/AU4jLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShK7ycl52wJEw0cCJ1sAhBi+5fCDsOncrrbOkF2MD3cAx5pu0V0I3wGbQ47u2udjyjqDAaUPaOTAuYw/90uMP7LDxlOUPer6h0og+/cj/tnF0W5Cf0aHuNfrhEzjl3JewMMdhrWGeWrivRe7o8WvZ/xkW5yvdrvaKffzS3HjRS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nb6F+QRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5897AC2BC86;
	Tue, 10 Mar 2026 11:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141218;
	bh=fkxiTKcbsPiSAqgE8uqpugt4oyUOwi12Vo0j/AU4jLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nb6F+QRZtXzR/D7NSCPKjqln2p0q15r7Cg/8KLbCuHPW1K5FUMNyqwBMgRSjVeAnd
	 TvFPRosw2Wn4HNqMK9/lBK1BWs6q1jJ5ec/OJBXBblcDPTn+HUHk58p9NcHyIfeKyg
	 3DC5WkQ6MhLgiOMESg2Ra8XQ746HuO1Kyf8yzdrX/VnTD+5pY52J5aLWMkZ2BNlIQU
	 U+/VKPDX1gbR41/2CCXB0uCvFg/Bc71l4ugRqXeRP6XeapMdxuvm3FKi+VS5nxZXmS
	 ywbRnFRBBuOalJjeqB54An5hTdqbEb9XKJPJdLcqRk/9VgDxeoTb4LFewv4tq2pnRH
	 YISg5Z5OL6YQg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Alban Bedel <alban.bedel@lht.dlh.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 220/311] can: mcp251x: fix deadlock in error path of mcp251x_open
Date: Tue, 10 Mar 2026 07:04:27 -0400
Message-ID: <f68ebc30611153ddf6c9076ebcde1a6ca2b366d2.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3CD1C24A725
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224085-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,pengutronix.de:email]
X-Rspamd-Action: no action

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
index fa97adf25b734..bb7782582f401 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1214,6 +1214,7 @@ static int mcp251x_open(struct net_device *net)
 {
 	struct mcp251x_priv *priv = netdev_priv(net);
 	struct spi_device *spi = priv->spi;
+	bool release_irq = false;
 	unsigned long flags = 0;
 	int ret;
 
@@ -1257,12 +1258,24 @@ static int mcp251x_open(struct net_device *net)
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


