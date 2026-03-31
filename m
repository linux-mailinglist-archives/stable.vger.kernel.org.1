Return-Path: <stable+bounces-232610-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGQLIqtazGk9SgYAu9opvQ
	(envelope-from <stable+bounces-232610-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 01:37:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC86372DFC
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 01:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3ADAE3020FF4
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 23:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A433AEF27;
	Tue, 31 Mar 2026 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+wSFUPV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF1B3AA1A1
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775000229; cv=none; b=QcpCSr8O6duGQxD85WjyqICUPmsVsxicjAJm2AozrGvJxMxXCoSks/gtkXgfaXxwymg3hOAwxtTpGlHbCjwr9Hs67eq82SrK7Bu4dGpO5ojUigbY3klrv/wGLolc8bapTTMo4UJ8LGecLuVp00LO2AW4ux2DkMU8O+vubttqNvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775000229; c=relaxed/simple;
	bh=+aWwp7gYScpiG/F2aKif0srBr/lhuO53mgtcK932GFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNFfZq1XsnmM2WnJqapJ/+u5yphI8sCz9lUUjatO0EIcDBnIc8ya/PDIdEn+TBo7sWCyfJfkGTgIipg5+yr3Qe1nMNflnHjsOIxg/1sYtP4XVsikKGhXbxahOXMSwWrxDxPb/SGLwxuFTxUMt23boNrjLpArqEjR9oamb6FiCLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+wSFUPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7334FC2BCB0;
	Tue, 31 Mar 2026 23:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775000229;
	bh=+aWwp7gYScpiG/F2aKif0srBr/lhuO53mgtcK932GFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V+wSFUPV+3hopwVHSSurPv8AhoCMZX3CUc5/R0BbDwRbPEqdYkpBADsrdW4thYkJI
	 Zy8ss72QvvBEAUPCHmdYEdx1VKM+gPOyFbKOHOTjZCVC6/LxJCyUDZIUJBlIJQ32zI
	 401Ckz6/+1GOO9s/HkgeUbQSbv65rskwMzfa/JG0jcZ7TO9ft9nEXxKuSR/8LrkD29
	 KjP+mo2xKfLRhV71HLJWCcCDUFKpRntUtbseUJ5GTHcMIP26QGAZN7uFi5Eybbb5L7
	 ihi9aUNObefbKe8Z5sRQWiI1eLI9WRV2AMvr0jtYgNm02cIqyKrSkF6IXRM7y3M1me
	 fnX5djDZjyabA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joy Zou <joy.zou@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] dmaengine: fsl-edma: fix channel parameter config for fixed channel requests
Date: Tue, 31 Mar 2026 19:37:05 -0400
Message-ID: <20260331233706.3629169-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331233706.3629169-1-sashal@kernel.org>
References: <2026033014-jitters-makeshift-a3d2@gregkh>
 <20260331233706.3629169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232610-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,msgid.link:url]
X-Rspamd-Queue-Id: CDC86372DFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Joy Zou <joy.zou@nxp.com>

[ Upstream commit 2e7b5cf72e51c9cf9c8b75190189c757df31ddd9 ]

Configure only the requested channel when a fixed channel is specified
to avoid modifying other channels unintentionally.

Fix parameter configuration when a fixed DMA channel is requested on
i.MX9 AON domain and i.MX8QM/QXP/DXL platforms. When a client requests
a fixed channel (e.g., channel 6), the driver traverses channels 0-5
and may unintentionally modify their configuration if they are unused.

This leads to issues such as setting the `is_multi_fifo` flag unexpectedly,
causing memcpy tests to fail when using the dmatest tool.

Only affect edma memcpy test when the channel is fixed.

Fixes: 72f5801a4e2b ("dmaengine: fsl-edma: integrate v3 support")
Signed-off-by: Joy Zou <joy.zou@nxp.com>
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20250917-b4-edma-chanconf-v1-1-886486e02e91@nxp.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/fsl-edma-main.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 0e6207382cde1..745870d469028 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -152,10 +152,8 @@ static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
 		fsl_chan = to_fsl_edma_chan(chan);
 		i = fsl_chan - fsl_edma->chans;
 
-		fsl_chan->priority = dma_spec->args[1];
-		fsl_chan->is_rxchan = dma_spec->args[2] & FSL_EDMA_RX;
-		fsl_chan->is_remote = dma_spec->args[2] & FSL_EDMA_REMOTE;
-		fsl_chan->is_multi_fifo = dma_spec->args[2] & FSL_EDMA_MULTI_FIFO;
+		if (!b_chmux && i != dma_spec->args[0])
+			continue;
 
 		if ((dma_spec->args[2] & FSL_EDMA_EVEN_CH) && (i & 0x1))
 			continue;
@@ -163,17 +161,15 @@ static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
 		if ((dma_spec->args[2] & FSL_EDMA_ODD_CH) && !(i & 0x1))
 			continue;
 
-		if (!b_chmux && i == dma_spec->args[0]) {
-			chan = dma_get_slave_channel(chan);
-			chan->device->privatecnt++;
-			return chan;
-		} else if (b_chmux && !fsl_chan->srcid) {
-			/* if controller support channel mux, choose a free channel */
-			chan = dma_get_slave_channel(chan);
-			chan->device->privatecnt++;
-			fsl_chan->srcid = dma_spec->args[0];
-			return chan;
-		}
+		fsl_chan->srcid = dma_spec->args[0];
+		fsl_chan->priority = dma_spec->args[1];
+		fsl_chan->is_rxchan = dma_spec->args[2] & FSL_EDMA_RX;
+		fsl_chan->is_remote = dma_spec->args[2] & FSL_EDMA_REMOTE;
+		fsl_chan->is_multi_fifo = dma_spec->args[2] & FSL_EDMA_MULTI_FIFO;
+
+		chan = dma_get_slave_channel(chan);
+		chan->device->privatecnt++;
+		return chan;
 	}
 	return NULL;
 }
-- 
2.53.0


