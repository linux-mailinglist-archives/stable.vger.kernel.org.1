Return-Path: <stable+bounces-229836-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNGcCFx1wWkQTQQAu9opvQ
	(envelope-from <stable+bounces-229836-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:16:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB292F9A97
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F372305D1FE
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89F53B2FDF;
	Mon, 23 Mar 2026 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fm0soZiq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F3C2877DA;
	Mon, 23 Mar 2026 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282996; cv=none; b=JAn1emvj2TREXXdQEm+LYmi8e90LdNITvk5lziNm/6MizTW3NSsGeovNa5WKN0fQL9kyeLxgArNLBjpCr7RMHYpFUtlEaZIlGEsHgLNzUAMMr+TBs6VH994bWItWep3ErC4DrDBMFbmlYMcTxoE3Xn2a/FBi3NigoTd5PYeLu+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282996; c=relaxed/simple;
	bh=9ceHOTshM1TqlmMaUI6YMDc2dNOBEYKKIO0r+YCCk6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L37RO+62n79IE+MajcKv/AF+P9BotIAswplurZbm9f6xwiBVeIuG3GbQubmt7eUVhOCfxhH6VONNXRuVhMh85y1YiUxNgH+pgJ80NVasi0WSV5/+WEdZhscJN8P/TnTa7+r4GT/rY33+SU1CWmaJOKFTqY/u9RuG1UtqvK02m3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fm0soZiq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE61C2BC9E;
	Mon, 23 Mar 2026 16:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282996;
	bh=9ceHOTshM1TqlmMaUI6YMDc2dNOBEYKKIO0r+YCCk6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fm0soZiqmS53IisG9yPpYL3YUPnlbZzKQ1k3JL/ZvsjNuq4+m2XbpZ64KIcAV7faP
	 9DxvkAimRyX4rpoqb8sq5sFMHx+maTOl6ca9jo1nBxmtpuI1w4lsDxIqsIj4C6RLKJ
	 wku9L2mpU2fmhgmQq5OlD/l3tVmoq1H6zQCyki6c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kevin Hao <haokexin@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 362/481] net: macb: Introduce gem_init_rx_ring()
Date: Mon, 23 Mar 2026 14:45:44 +0100
Message-ID: <20260323134533.934169698@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-229836-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1DB292F9A97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kevin Hao <haokexin@gmail.com>

[ Upstream commit 1a7124ecd655bcaf1845197fe416aa25cff4c3ea ]

Extract the initialization code for the GEM RX ring into a new function.
This change will be utilized in a subsequent patch. No functional changes
are introduced.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260312-macb-versal-v1-1-467647173fa4@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 718d0766ce4c ("net: macb: Reinitialize tx/rx queue pointer registers and rx ring during resume")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cadence/macb_main.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2638,6 +2638,14 @@ static void macb_init_tieoff(struct macb
 	desc->ctrl = 0;
 }
 
+static void gem_init_rx_ring(struct macb_queue *queue)
+{
+	queue->rx_tail = 0;
+	queue->rx_prepared_head = 0;
+
+	gem_rx_refill(queue);
+}
+
 static void gem_init_rings(struct macb *bp)
 {
 	struct macb_queue *queue;
@@ -2655,10 +2663,7 @@ static void gem_init_rings(struct macb *
 		queue->tx_head = 0;
 		queue->tx_tail = 0;
 
-		queue->rx_tail = 0;
-		queue->rx_prepared_head = 0;
-
-		gem_rx_refill(queue);
+		gem_init_rx_ring(queue);
 	}
 
 	macb_init_tieoff(bp);



