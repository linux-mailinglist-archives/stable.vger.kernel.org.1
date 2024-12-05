Return-Path: <stable+bounces-98755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 799449E4FF4
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 09:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B2D188094C
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 08:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D90E1D358F;
	Thu,  5 Dec 2024 08:40:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFD411187
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 08:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388022; cv=none; b=MNDPXbbRtCMg91wBY1SallKkjhrcktEtPyJh1uxFJb8OEPGCl0Fkc89dmQHGl75n2qUAu0/nSlLcqIk8arpf1Zuki09FU54653cUgK54B32RU5TDzkntVFbxGtS1qeoNRpOd4A8W9g/Upd+2Cb6kyNaGJwU5v3LXdjsXqtko1gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388022; c=relaxed/simple;
	bh=R+blb6aTv0vKpGYqEr9EDfFwaWHuTpXx87nKykYM4Ck=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K3o8lt4fnYDJ97sjlGpdVL9ByKEuEpqH53Cm/iqcj1BemWWUuFzFfv7z6prtE4X1mstb7kpVeYSXKKhCYnDhPoGlVGybNE4zJw5RV30cGA0k0GcgfzV/aYm4e6sK+b/pmsv8divhMrGDkJ+JlqHAttNEA/oaXD2oZUHX1dEwPdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B58XCAI011833;
	Thu, 5 Dec 2024 00:40:10 -0800
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43833q5f7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 05 Dec 2024 00:40:09 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 5 Dec 2024 00:40:09 -0800
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 5 Dec 2024 00:40:08 -0800
From: <jianqi.ren.cn@windriver.com>
To: <kory.maincent@bootlin.com>, <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>
Subject: [PATCH 6.1.y] dmaengine: dw-edma: eDMA: Add sync read before starting the DMA transfer in remote setup
Date: Thu, 5 Dec 2024 17:37:58 +0800
Message-ID: <20241205093758.2163649-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TkSsyUZgC2coNXyfTdLw3Bz3uyh0Xheq
X-Authority-Analysis: v=2.4 cv=bqq2BFai c=1 sm=1 tr=0 ts=675166e9 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=RZcAm9yDv7YA:10 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=t7CeM3EgAAAA:8
 a=UiR0G8JrladZec7fDzYA:9 a=d3PnA9EDa4IxuAV0gXij:22 a=cvBusfyB2V15izCimMoJ:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: TkSsyUZgC2coNXyfTdLw3Bz3uyh0Xheq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_06,2024-12-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 bulkscore=0 spamscore=0
 clxscore=1011 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.21.0-2411120000
 definitions=main-2412050062

From: Kory Maincent <kory.maincent@bootlin.com>

[ Upstream commit bbcc1c83f343e580c3aa1f2a8593343bf7b55bba ]

The Linked list element and pointer are not stored in the same memory as
the eDMA controller register. If the doorbell register is toggled before
the full write of the linked list a race condition error will occur.
In remote setup we can only use a readl to the memory to assure the full
write has occurred.

Fixes: 7e4b8a4fbe2c ("dmaengine: Add Synopsys eDMA IP version 0 support")
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Link: https://lore.kernel.org/r/20240129-b4-feature_hdma_mainline-v7-6-8e8c1acb7a46@bootlin.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index a3816ba63285..4fe83d5a25b6 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -357,6 +357,20 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	#endif /* CONFIG_64BIT */
 }
 
+static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
+{
+	/*
+	 * In case of remote eDMA engine setup, the DW PCIe RP/EP internal
+	 * configuration registers and application memory are normally accessed
+	 * over different buses. Ensure LL-data reaches the memory before the
+	 * doorbell register is toggled by issuing the dummy-read from the remote
+	 * LL memory in a hope that the MRd TLP will return only after the
+	 * last MWr TLP is completed
+	 */
+	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		readl(chunk->ll_region.vaddr.io);
+}
+
 void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
@@ -423,6 +437,9 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
 			  upper_32_bits(chunk->ll_region.paddr));
 	}
+
+	dw_edma_v0_sync_ll_data(chunk);
+
 	/* Doorbell */
 	SET_RW_32(dw, chan->dir, doorbell,
 		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
-- 
2.39.4


