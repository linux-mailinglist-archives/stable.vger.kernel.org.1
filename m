Return-Path: <stable+bounces-245040-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIClGmOoAGqTLQEAu9opvQ
	(envelope-from <stable+bounces-245040-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 17:46:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E4A504E9B
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 17:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57B77300118A
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 15:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B10E2DF68;
	Sun, 10 May 2026 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oS2hHUxR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7072F8E95
	for <stable@vger.kernel.org>; Sun, 10 May 2026 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778427996; cv=none; b=pGG1j3ViDZZ09dT6BvvLR487xgZllxBoOBgSL1slafxJsdwOpzJFi+ekyNSOjKRpwbNtd4gDh+cgEn648IFtWOZ87GIx9ePwD/3QK+3pUS3yCiFLPCGdB1vHbzKn62o6SrFgc0PFP1gIo3+d1YKhT2l2zXosVGf0gesq85Yz0vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778427996; c=relaxed/simple;
	bh=swPt37YwjxootFV7RajhsqjMUZsKFK8EzybxGX+DX2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3EUFN57fmik2Ae01ljgQIedrYr2yrbh+RMeLAJo3Q2QAPkNhyjaTvBDXVPwfA8ePOrKqtcQiPhns3Prmyvp9Q1XLcnMNPvNikDoG0raYl8F9zcDlVMf8D2tLzedk34E892yoAJUg1TTuK0aBQJscXUWc7Mx5hAO21nLGBV8urs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oS2hHUxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1AAC2BCB8;
	Sun, 10 May 2026 15:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778427995;
	bh=swPt37YwjxootFV7RajhsqjMUZsKFK8EzybxGX+DX2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oS2hHUxRa0CsqEeiIfT+ai2J86uRyuGjz6+baDZfXQxByViNCRcfRBNiVDpyF2Pi3
	 kM4AE/Aejfj1l1+nHg4tdhvuqiKkZTRVqPdcZQfdyXb+itBTJSnfD00a8wJ28hV4PU
	 A87gY2MI6XzTJIBaaZk61Q6DQmLcZUY8jeGBshxLGYWxhqNE/JmQAc1ZWUuuBEeFPl
	 2KnEAlUNAa3uc4TgXt5IdLyiFSLgk3Epaxy8oT6NvhT+c8enUNP247Eq5GxacPpkRm
	 3STiYPxwPv6eVloaRO0W9dxwrh4/rCh0P50r7YgpQjmQYPIONu1uAm/acGUZxfUImI
	 x7ALZvi3XemLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Furong Xu <0x1207@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] net: stmmac: avoid shadowing global buf_sz
Date: Sun, 10 May 2026 11:46:30 -0400
Message-ID: <20260510154632.158995-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050451-contact-pledge-2d90@gregkh>
References: <2026050451-contact-pledge-2d90@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 65E4A504E9B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-245040-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

[ Upstream commit 876cfb20e8892143c0c967b3657074f9131f9b5f ]

stmmac_rx() declares a local variable named "buf_sz" but there is also
a global variable for a module parameter which is called the same. To
avoid confusion, rename the local variable.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Furong Xu <0x1207@gmail.com>
Link: https://patch.msgid.link/E1tpswi-005U6C-Py@rmk-PC.armlinux.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 0bb05e6adfa9 ("net: stmmac: Prevent NULL deref when RX memory exhausted")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b199e47e55c1b..8b369c622b0ac 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5235,10 +5235,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	struct stmmac_xdp_buff ctx;
 	unsigned long flags;
 	int xdp_status = 0;
-	int buf_sz;
+	int bufsz;
 
 	dma_dir = page_pool_get_dma_dir(rx_q->page_pool);
-	buf_sz = DIV_ROUND_UP(priv->dma_conf.dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
+	bufsz = DIV_ROUND_UP(priv->dma_conf.dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
 	limit = min(priv->dma_conf.dma_rx_size - 1, (unsigned int)limit);
 
 	if (netif_msg_rx_status(priv)) {
@@ -5353,7 +5353,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			dma_sync_single_for_cpu(priv->device, buf->addr,
 						buf1_len, dma_dir);
 
-			xdp_init_buff(&ctx.xdp, buf_sz, &rx_q->xdp_rxq);
+			xdp_init_buff(&ctx.xdp, bufsz, &rx_q->xdp_rxq);
 			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
 					 buf->page_offset, buf1_len, false);
 
-- 
2.53.0


