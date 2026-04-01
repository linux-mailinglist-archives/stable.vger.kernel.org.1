Return-Path: <stable+bounces-232813-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKTvCOJJzWn4bQYAu9opvQ
	(envelope-from <stable+bounces-232813-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 18:37:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE4F37E01D
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 18:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F5A4314A764
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 16:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7495046AF29;
	Wed,  1 Apr 2026 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXJMw4wW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE7D44B680
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060222; cv=none; b=FS6H/+eah/r1cEHWG8cj4hyE26tz6UMeHIovP/7yT0W99Bpnv+bGRCkShKYf3N7YkXdvOBvlP35/iXAaIKtWuCNtJdb+bLjFWfNbxESrbI0UdLycKjQY1YCxrTAJBFxlcwe9QFHPHdCvPbuOl5lnvBr2qXbFtjfnK1eCKmMna1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060222; c=relaxed/simple;
	bh=jah76msZHSvgCQuq79xNP4DvNR/lFduJZIHhtaC4+hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9sYi2/LyYvmM01r4ZIH3m6Sxs2mOiAl56Lu/1LSRd8dAEUFXLoiPbowGuD4endE4euoaXlX4LRxtpxbfcVfeZSu62Ae7Ym9PnBke6fBIjj6qe8/EnnmdhDALgF2IfWUaXkgE5H8z6iWbkw5XirBT2T5OMMso9rzF3tbBk9oN34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXJMw4wW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4517C2BCB2;
	Wed,  1 Apr 2026 16:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775060221;
	bh=jah76msZHSvgCQuq79xNP4DvNR/lFduJZIHhtaC4+hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kXJMw4wWBDSQQq6T5JzcfRl/36y6nPwhYBYrTvDYofccV8LzTkndhH4UI/9/nSe/q
	 B8aTkFleiLld1idxIAfaaUCtvEN2wjYTtN5AQ64rezUL701H2I8LyLyNhAlaO/9K9T
	 OqdL+F1P9pg+7nMl5atUM6PpJlNv9XuTlxO2TQEGu1F8GfABGDbwVq6UrQU+8Klnrh
	 VVYvXX591KINjiI0ivS0Bo1z7R8/bG1YtJ78iXYE5aIYbx/0p3LL8XaZLOh8VaiSOn
	 pignkePVkF3Wt/jzlAeJlPatWD8EiqQ/ZBkWl8mjXXEGhTUaAbz/JQYtPc6ojiS+q7
	 U4dyh0S2ehFlQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Frank Li <Frank.Li@nxp.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] dmaengine: sh: rz-dmac: Move CHCTRL updates under spinlock
Date: Wed,  1 Apr 2026 12:16:58 -0400
Message-ID: <20260401161658.115456-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033044-applause-erased-d411@gregkh>
References: <2026033044-applause-erased-d411@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232813-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1EE4F37E01D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea@tuxon.dev>

[ Upstream commit 89a8567d84bde88cb7cdbbac2ab2299c4f991490 ]

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
[ replaced scoped_guard(spinlock_irqsave, ...) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/sh/rz-dmac.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index e6f8257c76672..acab58b02dbe9 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -283,13 +283,10 @@ static void rz_dmac_disable_hw(struct rz_dmac_chan *channel)
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
@@ -536,8 +533,8 @@ static int rz_dmac_terminate_all(struct dma_chan *chan)
 	unsigned int i;
 	LIST_HEAD(head);
 
-	rz_dmac_disable_hw(channel);
 	spin_lock_irqsave(&channel->vc.lock, flags);
+	rz_dmac_disable_hw(channel);
 	for (i = 0; i < DMAC_NR_LMDESC; i++)
 		lmdesc[i].header = 0;
 
@@ -646,13 +643,17 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan = &channel->vc.chan;
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
+	unsigned long flags;
 	u32 chstat, chctrl;
 
 	chstat = rz_dmac_ch_readl(channel, CHSTAT, 1);
 	if (chstat & CHSTAT_ER) {
 		dev_err(dmac->dev, "DMAC err CHSTAT_%d = %08X\n",
 			channel->index, chstat);
+
+		spin_lock_irqsave(&channel->vc.lock, flags);
 		rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
+		spin_unlock_irqrestore(&channel->vc.lock, flags);
 		goto done;
 	}
 
-- 
2.53.0


