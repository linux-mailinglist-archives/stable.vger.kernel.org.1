Return-Path: <stable+bounces-224486-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOGXIjQDsGnOeQIAu9opvQ
	(envelope-from <stable+bounces-224486-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:40:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F011624B465
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7292030B1ED6
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A201C3ECBEC;
	Tue, 10 Mar 2026 11:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEwPGvga"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F7013AA2D;
	Tue, 10 Mar 2026 11:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142217; cv=none; b=WxpMHnR2dGcerNL9jkH37W93yI31hZuZnJsOnqPKo8hpl2IC8cizv+C4mbZ3zBZaWtqviNaxIy0LcqKj2lZ+bikTmucMMYIhEO+uc5DrMw4aWFr546UYWYXNo0K04Uzg2QNR3OHiVF85w5GuY4viRBGU6PgvUp1Xw8i8Kej+/Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142217; c=relaxed/simple;
	bh=RTWIn4m5nxc95AtTcxHUvssmCQHfECZAQ9eGexUS9Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUXvzWug/ls6k4Ayti+yGhzBkz1E+axnfe0wMxzJwqhU08KG18YGivGMqxplGkpkt+vtqv6Q/uK+sN/WNNln7rRpeQp7D2MTswjPe+AfgwVlp5ilAW5tl00o/xgA2zkNKMKATHj7NQXdbK28ai1ImHT0DbRYhhyVPrrslLoCzoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEwPGvga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F06C2BCAF;
	Tue, 10 Mar 2026 11:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142217;
	bh=RTWIn4m5nxc95AtTcxHUvssmCQHfECZAQ9eGexUS9Yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tEwPGvgaCD4Wtbkkv1sU2QhYGEFEW5TY9UnkVLLDsLe9zNdcYiqHcdIoQ4uH3RKw2
	 PftzPZO/TYKUoKh81YXc1kUzcao5A+DRjLFvFMsKdLBLjMNgX9DzvsV6ed2tP45O92
	 xp8U09Lq9eZ8Pwe5aXhGDmCGYkMXDD9k8K2N4qf7726eUNth32ViBcVOtnIEocq1zv
	 0hI6MCiN4060mJsDiIp/Tm3lwLAeqGNei2USEKJhY79EDkoSvmUMTnriB6bAxcGljd
	 lAz3tMvvoGBRXMKd47oqRmUfY7mZ1K3RaysJVuDiTPBBlVPgPtyokFGfutg8gluEUt
	 dTG+c8+1rVs9g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 307/314] i40e: use xdp.frame_sz as XDP RxQ info frag_size
Date: Tue, 10 Mar 2026 07:19:26 -0400
Message-ID: <fc6273a40ac6c1a87819ab8134030dc83c2488fe.1773141556.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F011624B465
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224486-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Larysa Zaremba <larysa.zaremba@intel.com>

[ Upstream commit c69d22c6c46a1d792ba8af3d8d6356fdc0e6f538 ]

The only user of frag_size field in XDP RxQ info is
bpf_xdp_frags_increase_tail(). It clearly expects whole buffer size instead
of DMA write size. Different assumptions in i40e driver configuration lead
to negative tailroom.

Set frag_size to the same value as frame_sz in shared pages mode, use new
helper to set frag_size when AF_XDP ZC is active.

Fixes: a045d2f2d03d ("i40e: set xdp_rxq_info::frag_size")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Link: https://patch.msgid.link/20260305111253.2317394-7-larysa.zaremba@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index bc00bd4f439be..598739220dfb9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3569,6 +3569,7 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 	u16 pf_q = vsi->base_queue + ring->queue_index;
 	struct i40e_hw *hw = &vsi->back->hw;
 	struct i40e_hmc_obj_rxq rx_ctx;
+	u32 xdp_frame_sz;
 	int err = 0;
 	bool ok;
 
@@ -3578,6 +3579,7 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 	memset(&rx_ctx, 0, sizeof(rx_ctx));
 
 	ring->rx_buf_len = vsi->rx_buf_len;
+	xdp_frame_sz = i40e_rx_pg_size(ring) / 2;
 
 	/* XDP RX-queue info only needed for RX rings exposed to XDP */
 	if (ring->vsi->type != I40E_VSI_MAIN)
@@ -3585,11 +3587,12 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 
 	ring->xsk_pool = i40e_xsk_pool(ring);
 	if (ring->xsk_pool) {
+		xdp_frame_sz = xsk_pool_get_rx_frag_step(ring->xsk_pool);
 		ring->rx_buf_len = xsk_pool_get_rx_frame_size(ring->xsk_pool);
 		err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 					 ring->queue_index,
 					 ring->q_vector->napi.napi_id,
-					 ring->rx_buf_len);
+					 xdp_frame_sz);
 		if (err)
 			return err;
 		err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
@@ -3605,7 +3608,7 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 		err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 					 ring->queue_index,
 					 ring->q_vector->napi.napi_id,
-					 ring->rx_buf_len);
+					 xdp_frame_sz);
 		if (err)
 			return err;
 		err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
@@ -3616,7 +3619,7 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 	}
 
 skip:
-	xdp_init_buff(&ring->xdp, i40e_rx_pg_size(ring) / 2, &ring->xdp_rxq);
+	xdp_init_buff(&ring->xdp, xdp_frame_sz, &ring->xdp_rxq);
 
 	rx_ctx.dbuff = DIV_ROUND_UP(ring->rx_buf_len,
 				    BIT_ULL(I40E_RXQ_CTX_DBUFF_SHIFT));
-- 
2.51.0


