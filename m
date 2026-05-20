Return-Path: <stable+bounces-252264-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMuaMIsSDmoJ6AUAu9opvQ
	(envelope-from <stable+bounces-252264-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:59:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCB4598F6A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26E783103D4C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72EE3F54D1;
	Wed, 20 May 2026 18:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wHpG6hnW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BF43F6C5F;
	Wed, 20 May 2026 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300220; cv=none; b=fVr2WC3XrvXsDBwLL9wT3HdhBis68+X9z2RwkuqDis/2EJVU3/E0fMXOkKbQIJu3G8K0cHu8sqqc+VbQF2Q1+1V4Yt+AMJ7/dyk2nFf5kmfhMoeadrMow1UDGquTNvEFZd/VKN5URAvXPrp8GLakChuXXb/KOArmaqBdUBsXr9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300220; c=relaxed/simple;
	bh=2R2UGaeggw4EUEE9ABNPwTJeCbLpYhKKrpwTlRtb0oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oux9NpKaopRHPlotzEJKqGnEgXmAXBI77PpjQs0l/qIeI6a6RjKsOfnEYiamSlmWCOaALp1BbWmO5t6Zk1V6wlbpCEgVUpaew8sSVdpX1R0XqMQkZlggrDwjI7My2DxSvDguaPtTkRt4kWGIm1f0KfIsTe03oOANaTcyLgp12qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wHpG6hnW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C123B1F000E9;
	Wed, 20 May 2026 18:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300219;
	bh=kvw2k5ZZaSL9Clt6A7aP4KKX1FFXLSzMx10js0h+7aM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wHpG6hnW9BxyXBljdxzVDHeS2RedH7PiJcjEQxMwPeMmAp8Z1SBOxvYUhvb1ngMto
	 aqsA5Zal7k8F88GpJtfJP8N5ygswtHj4dkV7f6fjZ7DCyb2XgchAU7MwmLlbg+YScJ
	 pntG/1bgcDHvF9WY2srZXyXx81ACStxFMeF9IbUY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 093/666] net: airoha: Add missing RX_CPU_IDX() configuration in airoha_qdma_cleanup_rx_queue()
Date: Wed, 20 May 2026 18:15:04 +0200
Message-ID: <20260520162113.241670332@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252264-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: CDCB4598F6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 656121b155030086b01cfce9bd31b0c925ee6860 ]

When the descriptor index written in REG_RX_CPU_IDX() is equal to the one
stored in REG_RX_DMA_IDX(), the hw will stop since the QDMA RX ring is
empty.
Add missing REG_RX_CPU_IDX() configuration in airoha_qdma_cleanup_rx_queue
routine during QDMA RX ring cleanup.

Fixes: 514aac359987 ("net: airoha: Add missing cleanup bits in airoha_qdma_cleanup_rx_queue()")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20260408-airoha-cpu-idx-airoha_qdma_cleanup_rx_queue-v1-1-8efa64844308@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 268d3050c0178..d8af267f64f71 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -1641,6 +1641,11 @@ static void airoha_qdma_cleanup_rx_queue(struct airoha_queue *q)
 	}
 
 	q->head = q->tail;
+	/* Set RX_DMA_IDX to RX_CPU_IDX to notify the hw the QDMA RX ring is
+	 * empty.
+	 */
+	airoha_qdma_rmw(qdma, REG_RX_CPU_IDX(qid), RX_RING_CPU_IDX_MASK,
+			FIELD_PREP(RX_RING_CPU_IDX_MASK, q->head));
 	airoha_qdma_rmw(qdma, REG_RX_DMA_IDX(qid), RX_RING_DMA_IDX_MASK,
 			FIELD_PREP(RX_RING_DMA_IDX_MASK, q->tail));
 }
-- 
2.53.0




