Return-Path: <stable+bounces-144588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F28AB9803
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 10:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E5FF7ACAE8
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 08:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF8122E3FF;
	Fri, 16 May 2025 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ufjgs29O"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21CF2153D8;
	Fri, 16 May 2025 08:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747385135; cv=none; b=dlHhK6pAg01wvdOwmfz7SKn+22TsOLfioezls/V4mPk5PJSWGKDDjPxDfaSh0qJB2J8IIVx120b+JOQEu9F3sewg5c59ci9A/STGgG8O9iBfv3/5n47XoP7Ds5J3U1nULb6ALWPV/ozXxIJNzXVfm3Bm4xzviT3qycc5sZKJoPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747385135; c=relaxed/simple;
	bh=uwTXcKBle6TeUfwmY9rwgAWSy7S72kwaL8YkThSLPCM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k95d5vO05ex+1Rn9h7j98MM8xVBc+4xFz9tgBy2w0F90KUa6YpoSHnjNtb2ce+4mT60H1pf7VpcgU1HwR+TDSW6J7aptO0Wh/R6rMEA2IwG44raFx/248SXwdLE9Ix+e+QQv5WaBwWq9mmBuvctU/FcuZkbAMVuh47b7XulWN0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ufjgs29O; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G6AflL018907;
	Fri, 16 May 2025 01:45:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=G
	4fvIMceU4IYKEdY6Ins1sd5W47APHupY6T23gpUctk=; b=Ufjgs29OloT8w8jia
	xL8MhS8ER/LIIhvvgS/WQdXMq0Nf4D+wSonimlgjHyGv6Hd2/D3+lGL2bS+G2W3g
	kEfgrhNG/PaXHjtosJ9f1ITJ5NzrngTzBH8uBaopK6yaonpguCoNHTMlI15rFyUT
	85LoCGa2GSf75F4TIWCzWi4x+1L9g6s7gtRgsEpxTSwBGphJSNRcuzy0FhBZ0sFi
	hU26fHD9hfYU73/wnqQzN8xyzxF0KdOVo5vPMOh0FBO5s7jLwWXPKN+Ng3iOKm3U
	mN58RSxLkbL2axL/UlAWMftPPRY8fUmHT5Ho15JgrYcpLXHuVFE63FG01fIcYyN9
	NV9ig==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46nyv4re8d-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 01:45:10 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 16 May 2025 01:44:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 16 May 2025 01:44:57 -0700
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id AC9FD3F707C;
	Fri, 16 May 2025 01:44:52 -0700 (PDT)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <bbrezillon@kernel.org>, <schalla@marvell.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <giovanni.cabiddu@intel.com>, <linux@treblig.org>,
        <bharatb.linux@gmail.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <stable@vger.kernel.org>, Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH v2 2/2] crypto: octeontx2: Use dynamic allocated memory region for lmtst
Date: Fri, 16 May 2025 14:14:41 +0530
Message-ID: <20250516084441.3721548-3-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250516084441.3721548-1-bbhushan2@marvell.com>
References: <20250516084441.3721548-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=S6bZwJsP c=1 sm=1 tr=0 ts=6826fb16 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=dRNrYt_hAAAA:8 a=mqmjYYuR6NFFZE5yN6QA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=UH8RX7gv5XnRAaf1WCu2:22
X-Proofpoint-GUID: 3kBBxP4jp6JoH8uzWLzGFPSh0WP9aCSo
X-Proofpoint-ORIG-GUID: 3kBBxP4jp6JoH8uzWLzGFPSh0WP9aCSo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDA4MiBTYWx0ZWRfXzVhnLpBCgLKC GpsGW3o3m8Qw75khua08wIgSE0r/VuynbxEDT5jBtub4OBCUVjo/Si51ZjFO5VJSIJFSlQVHLoB XPiT1NWI/tYWo1ufVeRNOVqiCiXBRGu8l4vSFGQPDA6jYAyw53bR8BzbduMbFghIpdHF8g/WqAw
 KyGxgczBvStDE2S07PMNzEcC1uwrb0SzX5wAJaGNuj/SvhHgKYSqKqu5z3y0cRD4OtIyl59/4mT pm2A50nkGaa2vEd4NoYk5krnDNXRMpv4/zai0nQwJ1U1V5H1nj6KR337zUqhPeAwuj0JZ2SWqZY xNW5p1cqgAS7WWMhySWEao74b2TwPwQWtDsscakFkwa9Ws3zDhoE4hlXFxa6yAmHZaTbcS9TgjQ
 IaRJvY9ImGal6MsgsvkpyABPW7mM4IkIf0fNMxR3e9+aFgNVONQyOWVLFLkvsMCdPPkzKVSB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_03,2025-05-15_01,2025-03-28_01

Current driver uses static LMTST region allocated by firmware.
Firmware allocated memory for LMTST is available in PF/VF BAR2.
Using this memory have performance impact as this is mapped as
device memory. There is another option to allocate contiguous
memory at run time and map this in LMT MAP table with the
help of AF driver. With this patch dynamic allocated memory
is used for LMTST.

Also add myself as maintainer for crypto octeontx2 driver

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
v1->v2:
 -  Removed changes in pci-host-common.c, those were comitted
    by mistake.

 MAINTAINERS                                   |  1 +
 drivers/crypto/marvell/octeontx2/cn10k_cpt.c  | 89 ++++++++++++++-----
 drivers/crypto/marvell/octeontx2/cn10k_cpt.h  |  1 +
 .../marvell/octeontx2/otx2_cpt_common.h       |  1 +
 .../marvell/octeontx2/otx2_cpt_mbox_common.c  | 25 ++++++
 drivers/crypto/marvell/octeontx2/otx2_cptlf.c |  5 +-
 drivers/crypto/marvell/octeontx2/otx2_cptlf.h | 12 ++-
 .../marvell/octeontx2/otx2_cptpf_main.c       | 12 ++-
 .../marvell/octeontx2/otx2_cptpf_mbox.c       |  1 +
 .../marvell/octeontx2/otx2_cptvf_main.c       | 14 +--
 .../marvell/octeontx2/otx2_cptvf_mbox.c       |  1 +
 11 files changed, 124 insertions(+), 38 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f21f1dabb5fe..652dd271e0ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14292,6 +14292,7 @@ MARVELL CRYPTO DRIVER
 M:	Boris Brezillon <bbrezillon@kernel.org>
 M:	Arnaud Ebalard <arno@natisbad.org>
 M:	Srujana Challa <schalla@marvell.com>
+M:	Bharat Bhushan <bbhushan2@marvell.com>
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
 F:	drivers/crypto/marvell/
diff --git a/drivers/crypto/marvell/octeontx2/cn10k_cpt.c b/drivers/crypto/marvell/octeontx2/cn10k_cpt.c
index 5cae8fafa151..d4aab9e20f2a 100644
--- a/drivers/crypto/marvell/octeontx2/cn10k_cpt.c
+++ b/drivers/crypto/marvell/octeontx2/cn10k_cpt.c
@@ -6,6 +6,7 @@
 #include "otx2_cptvf.h"
 #include "otx2_cptlf.h"
 #include "cn10k_cpt.h"
+#include "otx2_cpt_common.h"
 
 static void cn10k_cpt_send_cmd(union otx2_cpt_inst_s *cptinst, u32 insts_num,
 			       struct otx2_cptlf_info *lf);
@@ -27,7 +28,7 @@ static struct cpt_hw_ops cn10k_hw_ops = {
 static void cn10k_cpt_send_cmd(union otx2_cpt_inst_s *cptinst, u32 insts_num,
 			       struct otx2_cptlf_info *lf)
 {
-	void __iomem *lmtline = lf->lmtline;
+	void *lmtline = lf->lfs->lmt_info.base + (lf->slot * LMTLINE_SIZE);
 	u64 val = (lf->slot & 0x7FF);
 	u64 tar_addr = 0;
 
@@ -41,15 +42,49 @@ static void cn10k_cpt_send_cmd(union otx2_cpt_inst_s *cptinst, u32 insts_num,
 	dma_wmb();
 
 	/* Copy CPT command to LMTLINE */
-	memcpy_toio(lmtline, cptinst, insts_num * OTX2_CPT_INST_SIZE);
+	memcpy(lmtline, cptinst, insts_num * OTX2_CPT_INST_SIZE);
 	cn10k_lmt_flush(val, tar_addr);
 }
 
+void cn10k_cpt_lmtst_free(struct pci_dev *pdev, struct otx2_cptlfs_info *lfs)
+{
+	struct otx2_lmt_info *lmt_info = &lfs->lmt_info;
+
+	if (!lmt_info->base)
+		return;
+
+	dma_free_attrs(&pdev->dev, lmt_info->size,
+		       lmt_info->base - lmt_info->align,
+		       lmt_info->iova - lmt_info->align,
+		       DMA_ATTR_FORCE_CONTIGUOUS);
+}
+EXPORT_SYMBOL_NS_GPL(cn10k_cpt_lmtst_free, "CRYPTO_DEV_OCTEONTX2_CPT");
+
+static int cn10k_cpt_lmtst_alloc(struct pci_dev *pdev,
+				 struct otx2_cptlfs_info *lfs, u32 size)
+{
+	struct otx2_lmt_info *lmt_info = &lfs->lmt_info;
+	dma_addr_t align_iova;
+	dma_addr_t iova;
+
+	lmt_info->base = dma_alloc_attrs(&pdev->dev, size, &iova, GFP_KERNEL,
+					 DMA_ATTR_FORCE_CONTIGUOUS);
+	if (!lmt_info->base)
+		return -ENOMEM;
+
+	align_iova = ALIGN((u64)iova, LMTLINE_ALIGN);
+	lmt_info->iova = align_iova;
+	lmt_info->align = align_iova - iova;
+	lmt_info->size = size;
+	lmt_info->base += lmt_info->align;
+	return 0;
+}
+
 int cn10k_cptpf_lmtst_init(struct otx2_cptpf_dev *cptpf)
 {
 	struct pci_dev *pdev = cptpf->pdev;
-	resource_size_t size;
-	u64 lmt_base;
+	u32 size;
+	int ret;
 
 	if (!test_bit(CN10K_LMTST, &cptpf->cap_flag)) {
 		cptpf->lfs.ops = &otx2_hw_ops;
@@ -57,18 +92,19 @@ int cn10k_cptpf_lmtst_init(struct otx2_cptpf_dev *cptpf)
 	}
 
 	cptpf->lfs.ops = &cn10k_hw_ops;
-	lmt_base = readq(cptpf->reg_base + RVU_PF_LMTLINE_ADDR);
-	if (!lmt_base) {
-		dev_err(&pdev->dev, "PF LMTLINE address not configured\n");
-		return -ENOMEM;
+	size = OTX2_CPT_MAX_VFS_NUM * LMTLINE_SIZE + LMTLINE_ALIGN;
+	ret = cn10k_cpt_lmtst_alloc(pdev, &cptpf->lfs, size);
+	if (ret) {
+		dev_err(&pdev->dev, "PF-%d LMTLINE memory allocation failed\n",
+			cptpf->pf_id);
+		return ret;
 	}
-	size = pci_resource_len(pdev, PCI_MBOX_BAR_NUM);
-	size -= ((1 + cptpf->max_vfs) * MBOX_SIZE);
-	cptpf->lfs.lmt_base = devm_ioremap_wc(&pdev->dev, lmt_base, size);
-	if (!cptpf->lfs.lmt_base) {
-		dev_err(&pdev->dev,
-			"Mapping of PF LMTLINE address failed\n");
-		return -ENOMEM;
+
+	ret = otx2_cpt_lmtst_tbl_setup_msg(&cptpf->lfs);
+	if (ret) {
+		dev_err(&pdev->dev, "PF-%d: LMTST Table setup failed\n",
+		cptpf->pf_id);
+		cn10k_cpt_lmtst_free(pdev, &cptpf->lfs);
 	}
 
 	return 0;
@@ -78,18 +114,25 @@ EXPORT_SYMBOL_NS_GPL(cn10k_cptpf_lmtst_init, "CRYPTO_DEV_OCTEONTX2_CPT");
 int cn10k_cptvf_lmtst_init(struct otx2_cptvf_dev *cptvf)
 {
 	struct pci_dev *pdev = cptvf->pdev;
-	resource_size_t offset, size;
+	u32 size;
+	int ret;
 
 	if (!test_bit(CN10K_LMTST, &cptvf->cap_flag))
 		return 0;
 
-	offset = pci_resource_start(pdev, PCI_MBOX_BAR_NUM);
-	size = pci_resource_len(pdev, PCI_MBOX_BAR_NUM);
-	/* Map VF LMILINE region */
-	cptvf->lfs.lmt_base = devm_ioremap_wc(&pdev->dev, offset, size);
-	if (!cptvf->lfs.lmt_base) {
-		dev_err(&pdev->dev, "Unable to map BAR4\n");
-		return -ENOMEM;
+	size = cptvf->lfs.lfs_num * LMTLINE_SIZE + LMTLINE_ALIGN;
+	ret = cn10k_cpt_lmtst_alloc(pdev, &cptvf->lfs, size);
+	if (ret) {
+		dev_err(&pdev->dev, "VF-%d LMTLINE memory allocation failed\n",
+			cptvf->vf_id);
+		return ret;
+	}
+
+	ret = otx2_cpt_lmtst_tbl_setup_msg(&cptvf->lfs);
+	if (ret) {
+		dev_err(&pdev->dev, "VF-%d: LMTST Table setup failed\n",
+			cptvf->vf_id);
+		cn10k_cpt_lmtst_free(pdev, &cptvf->lfs);
 	}
 
 	return 0;
diff --git a/drivers/crypto/marvell/octeontx2/cn10k_cpt.h b/drivers/crypto/marvell/octeontx2/cn10k_cpt.h
index 92be3ecf570f..ea5990048c21 100644
--- a/drivers/crypto/marvell/octeontx2/cn10k_cpt.h
+++ b/drivers/crypto/marvell/octeontx2/cn10k_cpt.h
@@ -50,6 +50,7 @@ static inline u8 otx2_cpt_get_uc_compcode(union otx2_cpt_res_s *result)
 
 int cn10k_cptpf_lmtst_init(struct otx2_cptpf_dev *cptpf);
 int cn10k_cptvf_lmtst_init(struct otx2_cptvf_dev *cptvf);
+void cn10k_cpt_lmtst_free(struct pci_dev *pdev, struct otx2_cptlfs_info *lfs);
 void cn10k_cpt_ctx_flush(struct pci_dev *pdev, u64 cptr, bool inval);
 int cn10k_cpt_hw_ctx_init(struct pci_dev *pdev,
 			  struct cn10k_cpt_errata_ctx *er_ctx);
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h b/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h
index c5b7c57574ef..44ef33a6c071 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h
+++ b/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h
@@ -223,5 +223,6 @@ int otx2_cpt_detach_rsrcs_msg(struct otx2_cptlfs_info *lfs);
 int otx2_cpt_msix_offset_msg(struct otx2_cptlfs_info *lfs);
 int otx2_cpt_sync_mbox_msg(struct otx2_mbox *mbox);
 int otx2_cpt_lf_reset_msg(struct otx2_cptlfs_info *lfs, int slot);
+int otx2_cpt_lmtst_tbl_setup_msg(struct otx2_cptlfs_info *lfs);
 
 #endif /* __OTX2_CPT_COMMON_H */
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cpt_mbox_common.c b/drivers/crypto/marvell/octeontx2/otx2_cpt_mbox_common.c
index b8b7c8a3c0ca..95f3de3a34eb 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cpt_mbox_common.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cpt_mbox_common.c
@@ -255,3 +255,28 @@ int otx2_cpt_lf_reset_msg(struct otx2_cptlfs_info *lfs, int slot)
 	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(otx2_cpt_lf_reset_msg, "CRYPTO_DEV_OCTEONTX2_CPT");
+
+int otx2_cpt_lmtst_tbl_setup_msg(struct otx2_cptlfs_info *lfs)
+{
+	struct otx2_mbox *mbox = lfs->mbox;
+	struct pci_dev *pdev = lfs->pdev;
+	struct lmtst_tbl_setup_req *req;
+
+	req = (struct lmtst_tbl_setup_req *)
+	       otx2_mbox_alloc_msg_rsp(mbox, 0, sizeof(*req),
+				       sizeof(struct msg_rsp));
+	if (!req) {
+		dev_err(&pdev->dev, "RVU MBOX failed to alloc message.\n");
+		return -EFAULT;
+	}
+
+	req->hdr.id = MBOX_MSG_LMTST_TBL_SETUP;
+	req->hdr.sig = OTX2_MBOX_REQ_SIG;
+	req->hdr.pcifunc = 0;
+
+	req->use_local_lmt_region = true;
+	req->lmt_iova = lfs->lmt_info.iova;
+
+	return otx2_cpt_send_mbox_msg(mbox, pdev);
+}
+EXPORT_SYMBOL_NS_GPL(otx2_cpt_lmtst_tbl_setup_msg, "CRYPTO_DEV_OCTEONTX2_CPT");
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptlf.c b/drivers/crypto/marvell/octeontx2/otx2_cptlf.c
index b5d66afcc030..dc7c7a2650a5 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptlf.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptlf.c
@@ -433,10 +433,7 @@ int otx2_cptlf_init(struct otx2_cptlfs_info *lfs, u8 eng_grp_mask, int pri,
 	for (slot = 0; slot < lfs->lfs_num; slot++) {
 		lfs->lf[slot].lfs = lfs;
 		lfs->lf[slot].slot = slot;
-		if (lfs->lmt_base)
-			lfs->lf[slot].lmtline = lfs->lmt_base +
-						(slot * LMTLINE_SIZE);
-		else
+		if (!lfs->lmt_info.base)
 			lfs->lf[slot].lmtline = lfs->reg_base +
 				OTX2_CPT_RVU_FUNC_ADDR_S(BLKADDR_LMT, slot,
 						 OTX2_CPT_LMT_LF_LMTLINEX(0));
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptlf.h b/drivers/crypto/marvell/octeontx2/otx2_cptlf.h
index bd8604be2952..6e004a5568d8 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptlf.h
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptlf.h
@@ -105,11 +105,19 @@ struct cpt_hw_ops {
 			      gfp_t gfp);
 };
 
+#define LMTLINE_SIZE  128
+#define LMTLINE_ALIGN 128
+struct otx2_lmt_info {
+	void *base;
+	dma_addr_t iova;
+	u32 size;
+	u8 align;
+};
+
 struct otx2_cptlfs_info {
 	/* Registers start address of VF/PF LFs are attached to */
 	void __iomem *reg_base;
-#define LMTLINE_SIZE  128
-	void __iomem *lmt_base;
+	struct otx2_lmt_info lmt_info;
 	struct pci_dev *pdev;   /* Device LFs are attached to */
 	struct otx2_cptlf_info lf[OTX2_CPT_MAX_LFS_NUM];
 	struct otx2_mbox *mbox;
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
index 687b6c7d7674..1c5c262af48d 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
@@ -792,19 +792,19 @@ static int otx2_cptpf_probe(struct pci_dev *pdev,
 	cptpf->max_vfs = pci_sriov_get_totalvfs(pdev);
 	cptpf->kvf_limits = 1;
 
-	err = cn10k_cptpf_lmtst_init(cptpf);
+	/* Initialize CPT PF device */
+	err = cptpf_device_init(cptpf);
 	if (err)
 		goto unregister_intr;
 
-	/* Initialize CPT PF device */
-	err = cptpf_device_init(cptpf);
+	err = cn10k_cptpf_lmtst_init(cptpf);
 	if (err)
 		goto unregister_intr;
 
 	/* Initialize engine groups */
 	err = otx2_cpt_init_eng_grps(pdev, &cptpf->eng_grps);
 	if (err)
-		goto unregister_intr;
+		goto free_lmtst;
 
 	err = sysfs_create_group(&dev->kobj, &cptpf_sysfs_group);
 	if (err)
@@ -820,6 +820,8 @@ static int otx2_cptpf_probe(struct pci_dev *pdev,
 	sysfs_remove_group(&dev->kobj, &cptpf_sysfs_group);
 cleanup_eng_grps:
 	otx2_cpt_cleanup_eng_grps(pdev, &cptpf->eng_grps);
+free_lmtst:
+	cn10k_cpt_lmtst_free(pdev, &cptpf->lfs);
 unregister_intr:
 	cptpf_disable_afpf_mbox_intr(cptpf);
 destroy_afpf_mbox:
@@ -854,6 +856,8 @@ static void otx2_cptpf_remove(struct pci_dev *pdev)
 	cptpf_disable_afpf_mbox_intr(cptpf);
 	/* Destroy AF-PF mbox */
 	cptpf_afpf_mbox_destroy(cptpf);
+	/* Free LMTST memory */
+	cn10k_cpt_lmtst_free(pdev, &cptpf->lfs);
 	pci_set_drvdata(pdev, NULL);
 }
 
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c
index 3eb45bb91296..12c0e966fa65 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c
@@ -502,6 +502,7 @@ static void process_afpf_mbox_msg(struct otx2_cptpf_dev *cptpf,
 	case MBOX_MSG_CPT_INLINE_IPSEC_CFG:
 	case MBOX_MSG_NIX_INLINE_IPSEC_CFG:
 	case MBOX_MSG_CPT_LF_RESET:
+	case MBOX_MSG_LMTST_TBL_SETUP:
 		break;
 
 	default:
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
index 11e351a48efe..56904bdfd6e8 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
@@ -376,10 +376,6 @@ static int otx2_cptvf_probe(struct pci_dev *pdev,
 
 	otx2_cpt_set_hw_caps(pdev, &cptvf->cap_flag);
 
-	ret = cn10k_cptvf_lmtst_init(cptvf);
-	if (ret)
-		goto clear_drvdata;
-
 	/* Initialize PF<=>VF mailbox */
 	ret = cptvf_pfvf_mbox_init(cptvf);
 	if (ret)
@@ -405,13 +401,19 @@ static int otx2_cptvf_probe(struct pci_dev *pdev,
 	if (cptvf->eng_caps[OTX2_CPT_SE_TYPES] & BIT_ULL(35))
 		cptvf->lfs.ops->cpt_sg_info_create = cn10k_sgv2_info_create;
 
+	ret = cn10k_cptvf_lmtst_init(cptvf);
+	if (ret)
+		goto unregister_interrupts;
+
 	/* Initialize CPT LFs */
 	ret = cptvf_lf_init(cptvf);
 	if (ret)
-		goto unregister_interrupts;
+		goto free_lmtst;
 
 	return 0;
 
+free_lmtst:
+	cn10k_cpt_lmtst_free(pdev, &cptvf->lfs);
 unregister_interrupts:
 	cptvf_disable_pfvf_mbox_intrs(cptvf);
 destroy_pfvf_mbox:
@@ -435,6 +437,8 @@ static void otx2_cptvf_remove(struct pci_dev *pdev)
 	cptvf_disable_pfvf_mbox_intrs(cptvf);
 	/* Destroy PF-VF mbox */
 	cptvf_pfvf_mbox_destroy(cptvf);
+	/* Free LMTST memory */
+	cn10k_cpt_lmtst_free(pdev, &cptvf->lfs);
 	pci_set_drvdata(pdev, NULL);
 }
 
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_mbox.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_mbox.c
index d9fa5f6e204d..931b72580fd9 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_mbox.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_mbox.c
@@ -134,6 +134,7 @@ static void process_pfvf_mbox_mbox_msg(struct otx2_cptvf_dev *cptvf,
 		       sizeof(cptvf->eng_caps));
 		break;
 	case MBOX_MSG_CPT_LF_RESET:
+	case MBOX_MSG_LMTST_TBL_SETUP:
 		break;
 	default:
 		dev_err(&cptvf->pdev->dev, "Unsupported msg %d received.\n",
-- 
2.34.1


