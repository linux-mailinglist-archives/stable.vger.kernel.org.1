Return-Path: <stable+bounces-144299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC112AB61E3
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 07:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7973E8677B7
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 05:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80081F4169;
	Wed, 14 May 2025 05:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KJsa0xE2"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A5C1F3FED;
	Wed, 14 May 2025 05:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747198859; cv=none; b=bvDCwY9DUY34AeHUOVcN+KxiUV0rf3FReM4vRmSEnO0/UapFVL3mYteaWk60UNpCxZvA3TbVHqMz95Xnh4AaufnFIiVg/KUKEM6PSgLkky6fOlGQXqkJiY4ltR1elw4xH21mO/RAZH8K6B0N931gtc3eL1TMLuV7yZ80PuOl5Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747198859; c=relaxed/simple;
	bh=dnAcYrEyP+ymeEgu74eHqf7dLrNlQn8rqfoAYZ3/DBQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGsPBwuCgsHWo13DSvaPUNgqVozTQHpY9qAAvmciVhUoc58AbHiV552KdHJf7MXHRT3b9h5LTXhOplQy/KzxEMxprKZO4kgCPtu/mVSLrPA61tvxSUfembKzL+d1Br7SzDLMtRYC+ssD6eIncxFHDl5BcVHqfYWICWlZpiVICKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KJsa0xE2; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DNW2KH007863;
	Tue, 13 May 2025 22:00:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=0
	g/h8q626a64HHL3mcFWLA55+bwvt3DSSW+DimH6wWA=; b=KJsa0xE2dUhQFTXyG
	Glj3heedUJnpzF1mAI7Qozv/okUNSGUVNhTkI3pmIpscd/77B6jSPjkjn/dK5JYZ
	LGdHt4qVblWqVVfwDCYMalXGE9y/0GXOqalhkifoP4btu11SGqIAR1AcSzB41JvF
	o3ExJSbbAEYgBzrv/gmN0Xnq2XeY9AdIYD9YzvF5LthxQOPaLCtQs3Wegzi7TiEI
	gJ0OqyGWZE3yfyMUlD56PxwcIK5PsOhk5OIFZHDNCfbSeyjMGP/epUf+0nEwrv0d
	WOM7bB42TfBcormWxfryEQr6xvEiP3k4ubzHfaxHZjrRJ7aQfilh0hJv/pSkT5Pc
	cwq2Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46mfu60g74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 22:00:44 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 13 May 2025 22:00:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 13 May 2025 22:00:43 -0700
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id 51B3B5B6934;
	Tue, 13 May 2025 22:00:40 -0700 (PDT)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <bbrezillon@kernel.org>, <arno@natisbad.org>, <schalla@marvell.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <iovanni.cabiddu@intel.com>, <linux@treblig.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
CC: Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH 4/4] crypto: octeontx2: Fix address alignment on CN10KB and CN10KA-B0
Date: Wed, 14 May 2025 10:30:20 +0530
Message-ID: <20250514050020.3165262-5-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514050020.3165262-1-bbhushan2@marvell.com>
References: <20250514050020.3165262-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: HbJ9aIql4V25rqODGa95_F0VVn0bduIY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA0MiBTYWx0ZWRfX5tDQAvEUjJ1g 9ITDUhKd/bc4faEc7eTOYnV+5T+LUPF4jBm3q+5CD/Vn895Y4lZpYaHBJsgLPJGaul6ltN7QCjn boX0z9zEs9ZqrUb4XW3E5iXN9IYLAry/gvUrqfY3QaYEPzdwjROEdc6LBfN8ejc/54iU7lXJ3WG
 VlFjKDZmHX9zypEg8Mpi07r5Odx6p1OoOYxu7fuxByQoR0wbCYUSsdz0KFAZF6U/ABlt1u5WOqX R839m16FxvPj8LpTt7h9c7joJZWg3HXZsVhd4M9ZfELh7CfbH/8KaTQMsymr8fZ82UggsLYYw0M DvNBuUTY1urznJ3+qT6LBrMqz1PaS0i8QK4d+v750JhiTA7rnswthy5i6PAJc8OQmp+ScNG6kCq
 kXPk8xxtr5hYxTqy/u78c+wqPnaxqxa4aqHYF0NW7iOGTjmdKhMtbik5q8a9NU5xK2Ktmh39
X-Authority-Analysis: v=2.4 cv=PIEP+eqC c=1 sm=1 tr=0 ts=6824237c cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=BhrP5AWxFkdJNdVQK0QA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: HbJ9aIql4V25rqODGa95_F0VVn0bduIY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_01,2025-05-09_01,2025-02-21_01

octeontx2 crypto driver allocates memory using kmalloc/kzalloc,
and uses this memory for dma (does dma_map_single()). It assumes
that kmalloc/kzalloc will return 128-byte aligned address. But
kmalloc/kzalloc returns 8-byte aligned address after below changes:
  "9382bc44b5f5 arm64: allow kmalloc() caches aligned to the
   smaller cache_line_size()

Memory allocated are used for following purpose:
 - Input data or scatter list address - 8-Byte alignment
 - Output data or gather list address - 8-Byte alignment
 - Completion address - 32-Byte alignment.

This patch ensures all addresses are aligned as mentioned above.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 .../marvell/octeontx2/otx2_cpt_reqmgr.h       | 57 ++++++++++++++-----
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cpt_reqmgr.h b/drivers/crypto/marvell/octeontx2/otx2_cpt_reqmgr.h
index f0f1ff45c383..b49dafc596c7 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cpt_reqmgr.h
+++ b/drivers/crypto/marvell/octeontx2/otx2_cpt_reqmgr.h
@@ -350,22 +350,45 @@ static inline struct otx2_cpt_inst_info *
 cn10k_sgv2_info_create(struct pci_dev *pdev, struct otx2_cpt_req_info *req,
 		       gfp_t gfp)
 {
-	u32 dlen = 0, g_len, sg_len, info_len;
-	int align = OTX2_CPT_DMA_MINALIGN;
+	u32 dlen = 0, g_len, s_len, sg_len, info_len;
 	struct otx2_cpt_inst_info *info;
-	u16 g_sz_bytes, s_sz_bytes;
 	u32 total_mem_len;
 	int i;
 
-	g_sz_bytes = ((req->in_cnt + 2) / 3) *
-		      sizeof(struct cn10kb_cpt_sglist_component);
-	s_sz_bytes = ((req->out_cnt + 2) / 3) *
-		      sizeof(struct cn10kb_cpt_sglist_component);
+	/* Allocate memory to meet below alignment requirement:
+	 *  ----------------------------------
+	 * |    struct otx2_cpt_inst_info     |
+	 * |    (No alignment required)       |
+	 * |     -----------------------------|
+	 * |    | padding for 8B alignment    |
+	 * |----------------------------------|
+	 * |    SG List Gather/Input memory   |
+	 * |    Length = multiple of 32Bytes  |
+	 * |    Alignment = 8Byte             |
+	 * |----------------------------------|
+	 * |    SG List Scatter/Output memory |
+	 * |    Length = multiple of 32Bytes  |
+	 * |    Alignment = 8Byte             |
+	 * |    (padding for below alignment) |
+	 * |     -----------------------------|
+	 * |    | padding for 32B alignment   |
+	 * |----------------------------------|
+	 * |    Result response memory        |
+	 *  ----------------------------------
+	 */
+
+	info_len = sizeof(*info);
 
-	g_len = ALIGN(g_sz_bytes, align);
-	sg_len = ALIGN(g_len + s_sz_bytes, align);
-	info_len = ALIGN(sizeof(*info), align);
-	total_mem_len = sg_len + info_len + sizeof(union otx2_cpt_res_s);
+	g_len = ((req->in_cnt + 2) / 3) *
+		 sizeof(struct cn10kb_cpt_sglist_component);
+	s_len = ((req->out_cnt + 2) / 3) *
+		 sizeof(struct cn10kb_cpt_sglist_component);
+	sg_len = g_len + s_len;
+
+	/* Allocate extra memory for SG and response address alignment */
+	total_mem_len = ALIGN(info_len, OTX2_CPT_DPTR_RPTR_ALIGN) + sg_len;
+	total_mem_len = ALIGN(total_mem_len, OTX2_CPT_RES_ADDR_ALIGN) +
+			 sizeof(union otx2_cpt_res_s);
 
 	info = kzalloc(total_mem_len, gfp);
 	if (unlikely(!info))
@@ -375,7 +398,9 @@ cn10k_sgv2_info_create(struct pci_dev *pdev, struct otx2_cpt_req_info *req,
 		dlen += req->in[i].size;
 
 	info->dlen = dlen;
-	info->in_buffer = (u8 *)info + info_len;
+	info->in_buffer = PTR_ALIGN((u8 *)info + info_len,
+				    OTX2_CPT_DPTR_RPTR_ALIGN);
+	info->out_buffer = info->in_buffer + g_len;
 	info->gthr_sz = req->in_cnt;
 	info->sctr_sz = req->out_cnt;
 
@@ -387,7 +412,7 @@ cn10k_sgv2_info_create(struct pci_dev *pdev, struct otx2_cpt_req_info *req,
 	}
 
 	if (sgv2io_components_setup(pdev, req->out, req->out_cnt,
-				    &info->in_buffer[g_len])) {
+				    info->out_buffer)) {
 		dev_err(&pdev->dev, "Failed to setup scatter list\n");
 		goto destroy_info;
 	}
@@ -404,8 +429,10 @@ cn10k_sgv2_info_create(struct pci_dev *pdev, struct otx2_cpt_req_info *req,
 	 * Get buffer for union otx2_cpt_res_s response
 	 * structure and its physical address
 	 */
-	info->completion_addr = info->in_buffer + sg_len;
-	info->comp_baddr = info->dptr_baddr + sg_len;
+	info->completion_addr = PTR_ALIGN((info->in_buffer + sg_len),
+					  OTX2_CPT_RES_ADDR_ALIGN);
+	info->comp_baddr = ALIGN((info->dptr_baddr + sg_len),
+				 OTX2_CPT_RES_ADDR_ALIGN);
 
 	return info;
 
-- 
2.34.1


