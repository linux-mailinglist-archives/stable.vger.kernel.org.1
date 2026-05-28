Return-Path: <stable+bounces-256401-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPmDN52tGGpymAgAu9opvQ
	(envelope-from <stable+bounces-256401-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:03:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 564DD5FA275
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82675330C14A
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93B835201B;
	Thu, 28 May 2026 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XA2OEjaq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9026233372A;
	Thu, 28 May 2026 20:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001594; cv=none; b=QnRT5yiViHU2QUtp0sbCNf6dkqudF/nrvSoE4/BY62BAnxqjGx7M0iS91Lp3yWNbbhSd5WZnb3d+2NmFmqzXqvdBqhWLlaRK03CIZKmfPj/8WrJJLbgN2uu0+kpyU8tHeltl426u1N6RahLwIhviixdI0ISp2J6xgVTPvpqWMOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001594; c=relaxed/simple;
	bh=J/Zh9r9uyLyt2V8gVYjRDZLKlVBU0BI+Vo43yLlgONM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRYsVolzgpYp93ZUfacIl8NvqaTeCvBg+mnFVhn3brbo5cb8Dzl5gIGAFULaZgUM3vCQ8Gx38sQRVAz/IUHESlWDYlbfn7MfE3bE64dTH9UajgWMWskpV5yuO4/1BeIOcE5GDZdTg0X6UQ4/1McKBddGtlXY8Wr4jn1M9T5vSCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XA2OEjaq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0291F000E9;
	Thu, 28 May 2026 20:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001593;
	bh=qQ29Gk0zkZnV0u+3ddQvWdyajo3ddVl5SWrVxShGanc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XA2OEjaqLiBPogNlY/TRHgYcgWNn4Un2XLA5dlY5aOacuJbQFOeO8ESVoWcZK3IIl
	 p2itouPCgSJ3JD/toyzihaoYUzurpxTo2LXML5OLaR+o1JoXtcKey6uslfyr4z8m0P
	 jIgZgDC1qyQip7dGmbX3I8cUih+teOPbPMRxy5uc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 182/186] net: mana: validate rx_req_idx to prevent out-of-bounds array access
Date: Thu, 28 May 2026 21:51:02 +0200
Message-ID: <20260528194933.904650486@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194928.941004471@linuxfoundation.org>
References: <20260528194928.941004471@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256401-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 564DD5FA275
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aditya Garg <gargaditya@linux.microsoft.com>

[ Upstream commit b809d0409991b75a6cff846a5ac27c3062953f84 ]

In mana_hwc_rx_event_handler(), rx_req_idx is derived from
sge->address in DMA-coherent memory. In Confidential VMs
(SEV-SNP/TDX), this memory is shared unencrypted and HW can modify
WQE contents at any time. No bounds check exists on rx_req_idx,
which can lead to an out-of-bounds access into reqs[].

Add bounds check on rx_req_idx in mana_hwc_rx_event_handler() before
using it to index the reqs[] array.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Link: https://patch.msgid.link/20260520051553.857120-1-gargaditya@linux.microsoft.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microsoft/mana/hw_channel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index b5ec1250a674f..1234c62fcbc7d 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -232,6 +232,12 @@ static void mana_hwc_rx_event_handler(void *ctx, u32 gdma_rxq_id,
 	rq_base_addr = hwc_rxq->msg_buf->mem_info.dma_handle;
 	rx_req_idx = (sge->address - rq_base_addr) / hwc->max_req_msg_size;
 
+	if (rx_req_idx >= hwc_rxq->msg_buf->num_reqs) {
+		dev_err(hwc->dev, "HWC RX: wrong rx_req_idx=%llu, num_reqs=%u\n",
+			rx_req_idx, hwc_rxq->msg_buf->num_reqs);
+		return;
+	}
+
 	rx_req = &hwc_rxq->msg_buf->reqs[rx_req_idx];
 	resp = (struct gdma_resp_hdr *)rx_req->buf_va;
 
-- 
2.53.0




