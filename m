Return-Path: <stable+bounces-221776-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GU3Apaoo2mWJAUAu9opvQ
	(envelope-from <stable+bounces-221776-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:46:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA041CDE8B
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF00B3195182
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B317A2DD5E2;
	Sun,  1 Mar 2026 01:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8oavIFB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770BA2D8767;
	Sun,  1 Mar 2026 01:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329108; cv=none; b=bbiFYTGOOx2m8ma+Cs0bRj6aAZaR50BNYZbzBsOBSMOxLQD+F2Q1zwxia8Wna/ehjSWT/rMj1mofv35dIQlnFK0RtbyuXbQ6/kaqbTgW8n/cCaeqHxjPjxLN0LqH+oyzEPbUJI4g04OxdtebmCwS32bXepFCbZLbyA2s8/peswM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329108; c=relaxed/simple;
	bh=r83bL9Ip788wcTF1R+/r0bNkCXbnYOhnB1jth0XjJ5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pAVbfhWcPI3JVnFfg9Lqyc5GvzH5KsMEQK+au/dhSKdkhFFJ9gVcujU70/THb3sW107RATPBGDwtubLDGtJW6NeD7JMCgTMYNUcb8FdJqz78RRIICfENzA8pdtT0OkkOFU+oRw3e9FFZDatJolzVR614X3hQ15IVtmVyG0hO9MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8oavIFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB26FC19421;
	Sun,  1 Mar 2026 01:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329108;
	bh=r83bL9Ip788wcTF1R+/r0bNkCXbnYOhnB1jth0XjJ5M=;
	h=From:To:Cc:Subject:Date:From;
	b=q8oavIFBm2JDgKkXBKsHOY3v8KEaLpbACqpBnMkl5RIHP8o3cvEq/qWvQyzQm9wey
	 OSVEcZXwPX5XL6FprF/yOrW2Y9uomcL2mk9VCkPqsMnTFiKsFIjNjCcWRiE0RGF4fE
	 kHgMwIjakERgbM7klV5Gyps61Sz+8dYKPwwm8U8U9B0lpQyx3Sq3Qpshnxpiv+SlIO
	 9/p16dFfAYymofgk4Ns8svxwlmSuxp1BSyUR+SkY9FZGvzCQqulG9xzZarn2wXDpRy
	 /ogysGZ545jRJGv+pRD/dfpnJbObpDf9COBcLptvX2oDs53nSIbu0jCVzRjqyIbXvW
	 070hnOlMeSOcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	fourier.thomas@gmail.com
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: FAILED: Patch "net: wan/fsl_ucc_hdlc: Fix dma_free_coherent() in uhdlc_memclean()" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:38:26 -0500
Message-ID: <20260301013826.1698870-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-221776-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.893];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 5BA041CDE8B
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 36bd7d5deef936c4e1e3cd341598140e5c14c1d3 Mon Sep 17 00:00:00 2001
From: Thomas Fourier <fourier.thomas@gmail.com>
Date: Fri, 6 Feb 2026 09:53:33 +0100
Subject: [PATCH] net: wan/fsl_ucc_hdlc: Fix dma_free_coherent() in
 uhdlc_memclean()

The priv->rx_buffer and priv->tx_buffer are alloc'd together as
contiguous buffers in uhdlc_init() but freed as two buffers in
uhdlc_memclean().

Change the cleanup to only call dma_free_coherent() once on the whole
buffer.

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Link: https://patch.msgid.link/20260206085334.21195-2-fourier.thomas@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index f999798a56127..dff84731343cc 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -790,18 +790,14 @@ static void uhdlc_memclean(struct ucc_hdlc_private *priv)
 
 	if (priv->rx_buffer) {
 		dma_free_coherent(priv->dev,
-				  RX_BD_RING_LEN * MAX_RX_BUF_LENGTH,
+				  (RX_BD_RING_LEN + TX_BD_RING_LEN) * MAX_RX_BUF_LENGTH,
 				  priv->rx_buffer, priv->dma_rx_addr);
 		priv->rx_buffer = NULL;
 		priv->dma_rx_addr = 0;
-	}
 
-	if (priv->tx_buffer) {
-		dma_free_coherent(priv->dev,
-				  TX_BD_RING_LEN * MAX_RX_BUF_LENGTH,
-				  priv->tx_buffer, priv->dma_tx_addr);
 		priv->tx_buffer = NULL;
 		priv->dma_tx_addr = 0;
+
 	}
 }
 
-- 
2.51.0





