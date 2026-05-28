Return-Path: <stable+bounces-255894-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLC5H8imGGpolwgAu9opvQ
	(envelope-from <stable+bounces-255894-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:34:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 312305F8FE0
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A5643069C63
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7308A2FD7C3;
	Thu, 28 May 2026 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nNeXcRv+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41235DDC5;
	Thu, 28 May 2026 20:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000177; cv=none; b=kDVC54QxGOSfcdSUiO4qfQRzr4rnAFi1BSQMOTD0OnzldkZhi81Tgem4Lmm5pv91bIWWAAckYBg1LtXJZgLP9ZniDUz9hGhia7dG4EWL42wZvP+JVJHV0rJ8C3dlsOuYql6mHcwA1+yc9SQQz/xtqa4wBNyCqsk8qGL8mB9+IZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000177; c=relaxed/simple;
	bh=KAi9d4PB/zt9/g8vAq+UmmzpyxiajsfecIkg90wa4bA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jF78WuKY3Qro20+f0OEmjm9JL8EVd3ZSh9rrcp7d8mNoq7R52EXENy7+6SY0mZmbaJHrNmDNRi9RCnYV17HS9oMBze+QiwvOv6ij7t4OJ+Itf6W8kLx8YpKBz5IfUypcKja/Zs1ua+672EEhnQ475r18GiW7pTSuZQ67bn2VV88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nNeXcRv+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7C81F000E9;
	Thu, 28 May 2026 20:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000176;
	bh=0lzFHVGK97Y8f7J0ilf1YewuTMXki16XZXQq43aftBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nNeXcRv+37spcEj7nONu7jIFLboUj/Y1nOn3rDWxexUYzCdUU4wDGON6OpqQx67No
	 iMOIJhwBV7PkHir0Dly9idd2UWqikILEnAr93fWHxwwolzZYfUpbSKRqc4fkNwOELV
	 xpWRCacOmbGhL6kaE03Jz+5nteZeCZOdI7kdEhnI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 329/377] net: mana: Fix TOCTOU double-fetch of hwc_msg_id from DMA buffer
Date: Thu, 28 May 2026 21:49:27 +0200
Message-ID: <20260528194647.933520331@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255894-lists,stable=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[msgid.link:server fail];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 312305F8FE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

[ Upstream commit 35f0f0a2536a4d604b4dbad92c85c4a8fdebb870 ]

In mana_hwc_rx_event_handler(), resp->response.hwc_msg_id is read from
DMA-coherent memory and bounds-checked, then mana_hwc_handle_resp()
re-reads the same field from the same DMA buffer for test_bit() and
pointer arithmetic.

DMA-coherent memory is mapped uncacheable on x86 and is shared,
unencrypted, in Confidential VMs (SEV-SNP/TDX), so each load goes
directly to host-visible memory. A H/W can modify the value
between the check and the use, bypassing the bounds validation.

Fix this by reading hwc_msg_id exactly once using READ_ONCE() into a
stack-local variable in mana_hwc_rx_event_handler(), and passing the
validated value as a parameter to mana_hwc_handle_resp().

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Link: https://patch.msgid.link/20260514194156.466823-1-ernis@linux.microsoft.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/microsoft/mana/hw_channel.c  | 23 +++++++++++--------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index 840c6b8957c90..1986bf493399f 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -77,21 +77,19 @@ static int mana_hwc_post_rx_wqe(const struct hwc_wq *hwc_rxq,
 }
 
 static void mana_hwc_handle_resp(struct hw_channel_context *hwc, u32 resp_len,
-				 struct hwc_work_request *rx_req)
+				 struct hwc_work_request *rx_req, u16 msg_id)
 {
 	const struct gdma_resp_hdr *resp_msg = rx_req->buf_va;
 	struct hwc_caller_ctx *ctx;
 	int err;
 
-	if (!test_bit(resp_msg->response.hwc_msg_id,
-		      hwc->inflight_msg_res.map)) {
-		dev_err(hwc->dev, "hwc_rx: invalid msg_id = %u\n",
-			resp_msg->response.hwc_msg_id);
+	if (!test_bit(msg_id, hwc->inflight_msg_res.map)) {
+		dev_err(hwc->dev, "hwc_rx: invalid msg_id = %u\n", msg_id);
 		mana_hwc_post_rx_wqe(hwc->rxq, rx_req);
 		return;
 	}
 
-	ctx = hwc->caller_ctx + resp_msg->response.hwc_msg_id;
+	ctx = hwc->caller_ctx + msg_id;
 	err = mana_hwc_verify_resp_msg(ctx, resp_msg, resp_len);
 	if (err)
 		goto out;
@@ -251,6 +249,7 @@ static void mana_hwc_rx_event_handler(void *ctx, u32 gdma_rxq_id,
 	struct gdma_sge *sge;
 	u64 rq_base_addr;
 	u64 rx_req_idx;
+	u16 msg_id;
 	u8 *wqe;
 
 	if (WARN_ON_ONCE(hwc_rxq->gdma_wq->id != gdma_rxq_id))
@@ -269,13 +268,17 @@ static void mana_hwc_rx_event_handler(void *ctx, u32 gdma_rxq_id,
 	rx_req = &hwc_rxq->msg_buf->reqs[rx_req_idx];
 	resp = (struct gdma_resp_hdr *)rx_req->buf_va;
 
-	if (resp->response.hwc_msg_id >= hwc->num_inflight_msg) {
-		dev_err(hwc->dev, "HWC RX: wrong msg_id=%u\n",
-			resp->response.hwc_msg_id);
+	/* Read msg_id once from DMA buffer to prevent TOCTOU:
+	 * DMA memory is shared/unencrypted in CVMs - host can
+	 * modify it between reads.
+	 */
+	msg_id = READ_ONCE(resp->response.hwc_msg_id);
+	if (msg_id >= hwc->num_inflight_msg) {
+		dev_err(hwc->dev, "HWC RX: wrong msg_id=%u\n", msg_id);
 		return;
 	}
 
-	mana_hwc_handle_resp(hwc, rx_oob->tx_oob_data_size, rx_req);
+	mana_hwc_handle_resp(hwc, rx_oob->tx_oob_data_size, rx_req, msg_id);
 
 	/* Can no longer use 'resp', because the buffer is posted to the HW
 	 * in mana_hwc_handle_resp() above.
-- 
2.53.0




