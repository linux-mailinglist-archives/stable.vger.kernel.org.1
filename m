Return-Path: <stable+bounces-222369-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O8BHIuko2mRIwUAu9opvQ
	(envelope-from <stable+bounces-222369-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:29:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB62F1CD99C
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A93C334943E
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2DD3033F6;
	Sun,  1 Mar 2026 02:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5mLkQg3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D54F13D53C;
	Sun,  1 Mar 2026 02:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330707; cv=none; b=ofGkghFMou/R1vit02eJT2cs98SkuBVBS2y3/rrvPde2W/TPMOWvGPE1gwQousoOB6YngAvkhK060HdREpq5xUvrfo7EzYtLsCesIPc9lC0fXgyX/i2KAR7ZC0H14Vgz6EWv3vBc7F/Q1+lJ5lfVfVv3hou+NSYR7i0GBZoWMXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330707; c=relaxed/simple;
	bh=Y72sQePBqKk53X31E47JkwQ3KAQtc3l9jiZoM8T7RV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DmNxP/rO4znE/VxmKmklliwJipDtSoxSct5TcBLMr3xTM2WdHMGmkPtwaBPlvQ4LxT8WnNM6kmSox7WOqtWcEyhoJvX9dFg+iSOKyYBM6M2jKj3lar+cb1NsNA6046eDEiiXvaARPRa3jxfrJJ9ycsxnXgazGRnl88TNdNdUBwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5mLkQg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CFEC19421;
	Sun,  1 Mar 2026 02:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330707;
	bh=Y72sQePBqKk53X31E47JkwQ3KAQtc3l9jiZoM8T7RV4=;
	h=From:To:Cc:Subject:Date:From;
	b=h5mLkQg3SmkJUfF1EkNXMdtvblMOxzVtSsPIHczyIWEAQBarrfwTYFCHGK+TfFb8u
	 iYs6qTVUZ2MC84MvyDerkTuoYBIgKeM8yEZZtcN2qIQa1OClk2hDOC2VVR/N1cS58S
	 Ld39Xr9xM5GhncUhcUT2R2fvHVRWyjdxHsfTr5Zo2t1DxVNB70u7UO+CcMA2N8eCe5
	 JTGweFrtRZdbfbwmDqGnSTKXUinWRn8sshRYYJBMzfoAl2wBuesqhQmvK/kGFgRLJz
	 iWuJK2tKNlytMXbnWmyBPIt2zVGRe/TNsrn5egZvurAvekEq9iibojHlU0Og5yEufO
	 ZyOVeljuyt5gg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	fourier.thomas@gmail.com
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: FAILED: Patch "net: wan/fsl_ucc_hdlc: Fix dma_free_coherent() in uhdlc_memclean()" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:05:05 -0500
Message-ID: <20260301020505.1733714-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-222369-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.919];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: BB62F1CD99C
X-Rspamd-Action: no action

The patch below does not apply to the 5.10-stable tree.
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





