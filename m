Return-Path: <stable+bounces-232459-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JYbEtkAzGkoNQYAu9opvQ
	(envelope-from <stable+bounces-232459-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:14:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 022FE36E3EB
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0FE230B3974
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD5830274D;
	Tue, 31 Mar 2026 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1r9nnLPG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F65D301471;
	Tue, 31 Mar 2026 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976802; cv=none; b=nDUSXzxkCYVHeN5eq52tu3NeTy/sJVchMaBRIfLuxStUU9g9FFZROjq0InGNufgMY3UDGwYQIO8Tksz5FQCXl+xiyuFeNqUIdO9spKNqIIGiJqXIGV/NZA2Eap8XwKDAjNWtdCbOaRqM+ivV5xPf+g4m0I2iujKzsRSQNOsg3Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976802; c=relaxed/simple;
	bh=AEIzRIFgxvTIhepbSkxbibzMOKm/ZvDPA0m+zhK+VXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8ARUTW7S/O5dg+nav1z/m4wavyWKycm5IDduVUrZAox/9HN5X2IMMqXPNceqZRS33aD+bWgYhOzio7v8pm8Sk+7DJPVfjapd6jMN2nLrliCnOCjhO7nwmXKtPAL6tqDSVyrpeNzZ//Y7exICbIMKhXn4WcI5Tpc1EnvNsVGKQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1r9nnLPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6F2C19423;
	Tue, 31 Mar 2026 17:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976802;
	bh=AEIzRIFgxvTIhepbSkxbibzMOKm/ZvDPA0m+zhK+VXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1r9nnLPGR+T9tm3RAIKWVr7powhmKVPLMUMDAHr2Z6Y2eF0NrAWV5Jya5F6iQ5UEc
	 iCxjD0NezrQg9PdTRcxHuTWnYnPO/K954iz8tlKPUti0F8V1bvKIb32ucnGJjSKQp0
	 8IH3Q2CRs9Mx2HoJgXJ0hikWAAZVsYjCkYrRu57o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Frank Li <Frank.Li@nxp.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.18 232/309] dmaengine: sh: rz-dmac: Move CHCTRL updates under spinlock
Date: Tue, 31 Mar 2026 18:22:15 +0200
Message-ID: <20260331161802.119684785@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232459-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,renesas.com:email,msgid.link:url,tuxon.dev:email]
X-Rspamd-Queue-Id: 022FE36E3EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Claudiu Beznea <claudiu.beznea@tuxon.dev>

commit 89a8567d84bde88cb7cdbbac2ab2299c4f991490 upstream.

Both rz_dmac_disable_hw() and rz_dmac_irq_handle_channel() update the
CHCTRL register. To avoid concurrency issues when configuring
functionalities exposed by this registers, take the virtual channel lock.
All other CHCTRL updates were already protected by the same lock.

Previously, rz_dmac_disable_hw() disabled and re-enabled local IRQs, before
accessing CHCTRL registers but this does not ensure race-free access.
Remove the local IRQ disable/enable code as well.

Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Cc: stable@vger.kernel.org
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260316133252.240348-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/sh/rz-dmac.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -298,13 +298,10 @@ static void rz_dmac_disable_hw(struct rz
 {
 	struct dma_chan *chan = &channel->vc.chan;
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
-	unsigned long flags;
 
 	dev_dbg(dmac->dev, "%s channel %d\n", __func__, channel->index);
 
-	local_irq_save(flags);
 	rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
-	local_irq_restore(flags);
 }
 
 static void rz_dmac_set_dmars_register(struct rz_dmac *dmac, int nr, u32 dmars)
@@ -569,8 +566,8 @@ static int rz_dmac_terminate_all(struct
 	unsigned int i;
 	LIST_HEAD(head);
 
-	rz_dmac_disable_hw(channel);
 	spin_lock_irqsave(&channel->vc.lock, flags);
+	rz_dmac_disable_hw(channel);
 	for (i = 0; i < DMAC_NR_LMDESC; i++)
 		lmdesc[i].header = 0;
 
@@ -707,7 +704,9 @@ static void rz_dmac_irq_handle_channel(s
 	if (chstat & CHSTAT_ER) {
 		dev_err(dmac->dev, "DMAC err CHSTAT_%d = %08X\n",
 			channel->index, chstat);
-		rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
+
+		scoped_guard(spinlock_irqsave, &channel->vc.lock)
+			rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
 		goto done;
 	}
 



