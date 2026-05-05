Return-Path: <stable+bounces-244036-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IA/tODS9+WnxCwMAu9opvQ
	(envelope-from <stable+bounces-244036-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 11:49:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA244CA1D7
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 11:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D41903004DC2
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 09:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BF5F507;
	Tue,  5 May 2026 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOcr9dWy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E2E18BC3B
	for <stable@vger.kernel.org>; Tue,  5 May 2026 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974578; cv=none; b=DvQqXcGv6QGHWz9ZWySrJ1EvRk/haBnFimJUbTi4r7WlB+aS148l/0cgBmMs84kjrobM6FOmVwi68OmkkyO9R5iknPmbr4eV8oRcYJQ6yXcAn3BWEqqN7eiMQMKxeim117wPgI1ftT1XDqMk/j57V6JwjO4ym0j9hENMn0dCYlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974578; c=relaxed/simple;
	bh=93QLUM1Z2mFgOUBbpdOj6M1lXWvnwwPsxVzykmxIC0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lIHlQDLFx9RMcYyD1mV5z8S5k/HbCArVofX05MKt7DnQcmhMB02q4GVG3ePIyGniqzKww9txeGXIG4SWGNanOxd4lPiddAIFjVUYl/QuxmDnidEtrp6r51uE/MBtliAsQMsXEr8SGya41Hujp7OmRRicMh9xznLOiP189olkf6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOcr9dWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175AFC2BCB4;
	Tue,  5 May 2026 09:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777974578;
	bh=93QLUM1Z2mFgOUBbpdOj6M1lXWvnwwPsxVzykmxIC0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YOcr9dWyDvPCD1I8/EohwZShejQNs2dV90DFXHleyiuz4tBDyxnF9Agzr9CyHBYEw
	 NS1XlRqJqYUlSlerdiGTSsTmVVJp1Sk2PnTjs0iQWaxb8JuAp9zBtxvMYLjQLnAi+H
	 1ysVFq7RoccqKgjs0Oe6TKipMsByEDr51Nqi0isXnxYpD+gzxiBbieOdgDl/SBjNWq
	 cdCLUq7vJvoZZ5P3ZKOw5Gw2n1EzCUsvg5vIDJeId72b4JH4SGPvDXmx+PfheueVp/
	 EGuxup2IA08asuWKCXkOUHIsnkz5BgMNa9RPq3TfYzhzxFTtFTcb1hFczgZ93rz/HL
	 IUp2USiDobqxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] octeon_ep_vf: add NULL check for napi_build_skb()
Date: Tue,  5 May 2026 05:49:31 -0400
Message-ID: <20260505094932.505988-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050148-prevent-cautious-1904@gregkh>
References: <2026050148-prevent-cautious-1904@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8AA244CA1D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244036-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]

From: David Carlier <devnexen@gmail.com>

[ Upstream commit dd66b42854705e4e4ee7f14d260f86c578bed3e3 ]

napi_build_skb() can return NULL on allocation failure. In
__octep_vf_oq_process_rx(), the result is used directly without a NULL
check in both the single-buffer and multi-fragment paths, leading to a
NULL pointer dereference.

Add NULL checks after both napi_build_skb() calls, properly advancing
descriptors and consuming remaining fragments on failure.

Fixes: 1cd3b407977c ("octeon_ep_vf: add Tx/Rx processing and interrupt support")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Link: https://patch.msgid.link/20260409184009.930359-3-devnexen@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ inlined missing octep_vf_oq_next_idx() helper as read_idx++ with wraparound ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../marvell/octeon_ep_vf/octep_vf_rx.c        | 36 +++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
index b579d5b545c46..8347e696937cd 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
@@ -409,10 +409,17 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 			data_offset = OCTEP_VF_OQ_RESP_HW_SIZE;
 			rx_ol_flags = 0;
 		}
-		rx_bytes += buff_info->len;
-
 		if (buff_info->len <= oq->max_single_buffer_size) {
 			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
+			if (!skb) {
+				oq->stats->alloc_failures++;
+				desc_used++;
+				read_idx++;
+				if (read_idx == oq->max_count)
+					read_idx = 0;
+				continue;
+			}
+			rx_bytes += buff_info->len;
 			skb_reserve(skb, data_offset);
 			skb_put(skb, buff_info->len);
 			read_idx++;
@@ -424,6 +431,31 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 			u16 data_len;
 
 			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
+			if (!skb) {
+				oq->stats->alloc_failures++;
+				desc_used++;
+				read_idx++;
+				if (read_idx == oq->max_count)
+					read_idx = 0;
+				data_len = buff_info->len - oq->max_single_buffer_size;
+				while (data_len) {
+					dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
+						       PAGE_SIZE, DMA_FROM_DEVICE);
+					buff_info = (struct octep_vf_rx_buffer *)
+						    &oq->buff_info[read_idx];
+					buff_info->page = NULL;
+					if (data_len < oq->buffer_size)
+						data_len = 0;
+					else
+						data_len -= oq->buffer_size;
+					desc_used++;
+					read_idx++;
+					if (read_idx == oq->max_count)
+						read_idx = 0;
+				}
+				continue;
+			}
+			rx_bytes += buff_info->len;
 			skb_reserve(skb, data_offset);
 			/* Head fragment includes response header(s);
 			 * subsequent fragments contains only data.
-- 
2.53.0


