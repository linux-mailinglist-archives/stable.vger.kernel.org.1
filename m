Return-Path: <stable+bounces-252743-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFB1LbUDDmqs5QUAu9opvQ
	(envelope-from <stable+bounces-252743-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:55:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE6B59768C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 359B739D2893
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ECA3FE371;
	Wed, 20 May 2026 18:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="meG2Kfer"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404303FCB10;
	Wed, 20 May 2026 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301474; cv=none; b=TqwPtiJCrmArRkAOfqyqHD+bgnuyb7c2Z5QncI9nSRS9NKj8W7vpFVA1rYCvqYZY82vOSdFaWMavcL5sPKqne5PT3gpJ2cJqHo47p/Sux0cI2+ED6z3EK9Crws4qMV4Xn3ByIx97VKu49gS74LDGc0vgdWdk2ns66milz5GBG+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301474; c=relaxed/simple;
	bh=DGzmZubdNxFXhkNdHe6BxVwuxMH74TWACyoI7U0Hs9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPvE1/joMH3dzI0XoBq6pyKGznphi8VMW04ezxuRhNgCj5Tsma1XnrI2jbeUHmShO1fG2lT/ZtEzrRZQr2rqgHgtMNpC+oldoB2WMHUNtJC6Swdes7r4X7N+hmsq0Rd6gtNSAKMYAWFjuK4EYOve5865ahzqDALaL4UL4qWWvwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=meG2Kfer; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC9E1F000E9;
	Wed, 20 May 2026 18:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301472;
	bh=dpiG52Gk8Mn4EVs7Kc8Lqvbye4OECkXFajPrzszd+b0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=meG2KferJXO88JO2gaJsw0aI7TOQD0ONHe8T1re/EeEvfOHxIab+UOyspoordKTBW
	 /3YkXHonR8gQH/6AoQZ3wHBqUCFxPfzLbjFYJZkkBrAX6ep2zRAI9UP8KiaFDgV+TQ
	 S6qW41A4yTIoQNDNCtsR1NrxseuKHhHcuQKITC48=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Madieu <john.madieu@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 526/666] spi: rockchip: Read ISR, not IMR, to detect cs-inactive IRQ
Date: Wed, 20 May 2026 18:22:17 +0200
Message-ID: <20260520162122.671179688@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-252743-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 2DE6B59768C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Madieu <john.madieu@gmail.com>

[ Upstream commit b4683a239a409d65f88052f5630c748a8ba070cd ]

rockchip_spi_isr() decides whether the current interrupt was the
cs-inactive event by reading IMR:

	if (rs->cs_inactive &&
	    readl_relaxed(rs->regs + ROCKCHIP_SPI_IMR) & INT_CS_INACTIVE)
		ctlr->target_abort(ctlr);

IMR is the interrupt mask register: it tells which sources are enabled,
not which one fired. In the PIO path, rockchip_spi_prepare_irq() enables
both INT_RF_FULL and INT_CS_INACTIVE in IMR when rs->cs_inactive is true:

	if (rs->cs_inactive)
		writel_relaxed(INT_RF_FULL | INT_CS_INACTIVE,
			       rs->regs + ROCKCHIP_SPI_IMR);

so the IMR check is always true once cs_inactive is enabled, and every
PIO interrupt - including normal RF_FULL completions - is dispatched to
ctlr->target_abort(), aborting the transfer. The bug is reachable on
ROCKCHIP_SPI_VER2_TYPE2 in target mode with a DMA-capable controller
when the transfer is short enough to fall back to PIO
(rockchip_spi_can_dma() returns false below fifo_len).

Read ISR (which is RISR masked by IMR) so the check actually reflects
which interrupt fired, and parenthesise the expression for clarity while
at it.

Fixes: 869f2c94db92 ("spi: rockchip: Stop spi slave dma receiver when cs inactive")
Signed-off-by: John Madieu <john.madieu@gmail.com>
Link: https://patch.msgid.link/20260425092936.2590132-2-john.madieu@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-rockchip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index b480408c812f8..ccb35a2e39fbd 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -357,7 +357,8 @@ static irqreturn_t rockchip_spi_isr(int irq, void *dev_id)
 	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 
 	/* When int_cs_inactive comes, spi target abort */
-	if (rs->cs_inactive && readl_relaxed(rs->regs + ROCKCHIP_SPI_IMR) & INT_CS_INACTIVE) {
+	if (rs->cs_inactive &&
+	    (readl_relaxed(rs->regs + ROCKCHIP_SPI_ISR) & INT_CS_INACTIVE)) {
 		ctlr->target_abort(ctlr);
 		writel_relaxed(0, rs->regs + ROCKCHIP_SPI_IMR);
 		writel_relaxed(0xffffffff, rs->regs + ROCKCHIP_SPI_ICR);
-- 
2.53.0




