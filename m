Return-Path: <stable+bounces-255542-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKzrEouiGGrClggAu9opvQ
	(envelope-from <stable+bounces-255542-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:16:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6245F8370
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7E0D3060C03
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DED335566;
	Thu, 28 May 2026 20:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BDx/MvKB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD29033A702;
	Thu, 28 May 2026 20:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999203; cv=none; b=Z5IeApDisQMt5WcPSHgF5NDqXr6ImzbY4FmAJkRIZCMD2njpr2vyo+nhZ58VZ/BZwXFUR2vwG7wNmZHFvDaVCNhqHI6zVHl1HLrnKdhxFWk7gmOHmFwv0kcx1e/ToXQx/HIsW3fF+3pbprJ5liWRBEg6Rq8jZ3HfKRKcUwXKteA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999203; c=relaxed/simple;
	bh=eNNzC7C3FyLtN6FuV2kyUV9/Ux7NvT4p8CqATgOxuX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScY3nLSorgv9HHsiRQNxbvPfIBwfAwjjBF8YCX9neDWCVIZZU11iKK0N01bgSt0TMSb5D02ZNuyC/LMR+Z88qEr9lyY9xm0+/pDiYbdbsFUteGrWBdYI8S0bZhCV6VbCxBd9NZcdVUS/myPWVU9gSighV387u8D3rdu3KllIIZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BDx/MvKB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D931F000E9;
	Thu, 28 May 2026 20:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999202;
	bh=Ml+qXZxxBBjf/fN7mo6dLrvOvhOczPSGKk/gAuqelTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BDx/MvKBEwXXdJnrMMQnXl2zlb2MnbTAip1QbbQYgCEPQmTrvWeb4c5SWpQbQ0fql
	 wbBzaGzAVUm3IEnixvQdYyWU1u2IPrs1+Id7VUygQujsqPVQperg5Vpu2TrYR+3uTB
	 dJRsbe24lSAqO5LOuOWs4Q/sGo3m9Kzf33JlXapM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 446/461] nvme-pci: fix dma_vecs leak on p2p memory
Date: Thu, 28 May 2026 21:49:35 +0200
Message-ID: <20260528194700.444052318@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255542-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,lst.de:email]
X-Rspamd-Queue-Id: 8D6245F8370
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 85686c72966c5ee637893f124ddb31a1cace7bee ]

We don't unmap P2P memory, so we don't need to track it. The dma_vec
allocation was getting leaked on the completion.

Fixes: b8b7570a7ec87 ("nvme-pci: fix dma unmapping when using PRPs and not using the IOVA mapping")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6d522c52dca67..5b998db940bd6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -966,7 +966,8 @@ static bool nvme_pci_prp_save_mapping(struct request *req,
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
-	if (dma_use_iova(&iod->dma_state) || !dma_need_unmap(dma_dev))
+	if (dma_use_iova(&iod->dma_state) || !dma_need_unmap(dma_dev) ||
+	    (iod->flags & IOD_DATA_P2P))
 		return true;
 
 	if (!iod->nr_dma_vecs) {
-- 
2.53.0




