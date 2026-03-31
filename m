Return-Path: <stable+bounces-232516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Kg3K38BzGk8NQYAu9opvQ
	(envelope-from <stable+bounces-232516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:16:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B13E36E617
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D94030C5B09
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A8831064B;
	Tue, 31 Mar 2026 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ln7f7l8Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAD330FF20;
	Tue, 31 Mar 2026 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976950; cv=none; b=Q+hm07kvvsJD4Evnj/HbKo9Bz2yhFMI8ycX4m31BQjmz5zzuc0vEStWdJSJ9op5klomit6ea0IJ0wUtKs8Nq4E0ReDkMcDxrE6uu6PfnI15AvmytFw9ctXSmXNBVNj8fjyx4dgDqgngQg8sOoK4y9kU4WwH1UO5O77QOxiD6XWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976950; c=relaxed/simple;
	bh=b0H+AICXvrzEKUci1hJBor24L/d5HULcFwcmPaLYTmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgIp7BnSzPrBOrS3BH2OrpdOgeTvMEUX6/feOL6/jNThdibnRJ2HSZCWroWViPmc55t981gVinNnanShKXOBDWHDEJ2fyfoHTmC/mtSU5ztirPLBo/W68YupQMHuYKEuN5oYPYLpxtrWFUdd9ORnsez18jZHwFQVIvoipicxfxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ln7f7l8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756C1C19423;
	Tue, 31 Mar 2026 17:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976949;
	bh=b0H+AICXvrzEKUci1hJBor24L/d5HULcFwcmPaLYTmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ln7f7l8QsMekiG/Fe/iyQJum5MSYeN7N3kGmejVvah1WQPTrUjFfzaH1Ei65lT//g
	 NHpvUdaGeCDVtQE8oR7ighgaWZU6ZyRMkAg0OXusVbT7ZHAz9lntZ8ONjPuVUFcl/I
	 /MDdFe/INPhkn3R0JuDl4A66288jUjFvffE35TiE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	LUO Haowen <luo-hw@foxmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 290/309] dmaengine: dw-edma: Fix multiple times setting of the CYCLE_STATE and CYCLE_BIT bits for HDMA.
Date: Tue, 31 Mar 2026 18:23:13 +0200
Message-ID: <20260331161804.241113067@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,foxmail.com,nxp.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-232516-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gxmicro.cn:email]
X-Rspamd-Queue-Id: 6B13E36E617
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: LUO Haowen <luo-hw@foxmail.com>

[ Upstream commit 3f63297ff61a994b99d710dcb6dbde41c4003233 ]

Others have submitted this issue (https://lore.kernel.org/dmaengine/
20240722030405.3385-1-zhengdongxiong@gxmicro.cn/),
but it has not been fixed yet. Therefore, more supplementary information
is provided here.

As mentioned in the "PCS-CCS-CB-TCB" Producer-Consumer Synchronization of
"DesignWare Cores PCI Express Controller Databook, version 6.00a":

1. The Consumer CYCLE_STATE (CCS) bit in the register only needs to be
initialized once; the value will update automatically to be
~CYCLE_BIT (CB) in the next chunk.
2. The Consumer CYCLE_BIT bit in the register is loaded from the LL
element and tested against CCS. When CB = CCS, the data transfer is
executed. Otherwise not.

The current logic sets customer (HDMA) CS and CB bits to 1 in each chunk
while setting the producer (software) CB of odd chunks to 0 and even
chunks to 1 in the linked list. This is leading to a mismatch between
the producer CB and consumer CS bits.

This issue can be reproduced by setting the transmission data size to
exceed one chunk. By the way, in the EDMA using the same "PCS-CCS-CB-TCB"
mechanism, the CS bit is only initialized once and this issue was not
found. Refer to
drivers/dma/dw-edma/dw-edma-v0-core.c:dw_edma_v0_core_start.

So fix this issue by initializing the CYCLE_STATE and CYCLE_BIT bits
only once.

Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
Signed-off-by: LUO Haowen <luo-hw@foxmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/tencent_CB11AA9F3920C1911AF7477A9BD8EFE0AD05@qq.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index e3f8db4fe909a..ce8f7254bab21 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -252,10 +252,10 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 			  lower_32_bits(chunk->ll_region.paddr));
 		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
 			  upper_32_bits(chunk->ll_region.paddr));
+		/* Set consumer cycle */
+		SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
+			HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
 	}
-	/* Set consumer cycle */
-	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
-		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
 
 	dw_hdma_v0_sync_ll_data(chunk);
 
-- 
2.53.0




