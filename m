Return-Path: <stable+bounces-156378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3B7AE4F4F
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1251B60B9C
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE4521ADB5;
	Mon, 23 Jun 2025 21:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SSdiYGuN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF3C1DF98B;
	Mon, 23 Jun 2025 21:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713268; cv=none; b=MwXR9ZImxMddysiluWPGOUXUOIh2LmE+XaHzzadJAAC8RkouuKPODdIVmgrUyXc1LZcE89G9pfuDt6oyAn1CpAyQOKtXANfDPIiP4TNpiT2Iw+nYev5jVi538ZkeARY5icnJ91r2MoRpBL/7uOmwZtYTgw0bJUas1ucDrcMax50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713268; c=relaxed/simple;
	bh=dgxfUZGkceJSdX8zFo9+HMyQfF4Fi5HVQfjmODcMpkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4k2VLytyVmY690QkZI7+UB1Ld2AIwFhvkXruOuxENe7z/M/id8H5apLEH/ZqH6DtDiz/cQJ9Eg3aF33ZX79O9E0NL8JiQ4FS3tQBciLGCKHwOBnHijRVt9E68piIjIDRTsqw+drnR1ZQJhEri3/gtT2KM+IzS0NoG81UxwougM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SSdiYGuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75273C4CEEA;
	Mon, 23 Jun 2025 21:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750713267;
	bh=dgxfUZGkceJSdX8zFo9+HMyQfF4Fi5HVQfjmODcMpkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SSdiYGuNDvjP3d5u+YssoRhET7inUKBUc8rgOvF3lIWqdhZvLlGV2eLNmMdMpZHeN
	 QuXe4SHUmR9lgDeEiaLoqdWOTJnCAlpgNlbPGb4lez0la6ml7SXEJfIZphwAzx0i3f
	 +tPd6zPi5EIoBfHRTb3i3rt2rOFGMLcTusV+IPCI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Longfang Liu <liulongfang@huawei.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 087/508] hisi_acc_vfio_pci: fix XQE dma address error
Date: Mon, 23 Jun 2025 15:02:12 +0200
Message-ID: <20250623130647.387332999@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Longfang Liu <liulongfang@huawei.com>

[ Upstream commit 8bb7170c5a055ea17c6857c256ee73c10ff872eb ]

The dma addresses of EQE and AEQE are wrong after migration and
results in guest kernel-mode encryption services  failure.
Comparing the definition of hardware registers, we found that
there was an error when the data read from the register was
combined into an address. Therefore, the address combination
sequence needs to be corrected.

Even after fixing the above problem, we still have an issue
where the Guest from an old kernel can get migrated to
new kernel and may result in wrong data.

In order to ensure that the address is correct after migration,
if an old magic number is detected, the dma address needs to be
updated.

Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live migration")
Signed-off-by: Longfang Liu <liulongfang@huawei.com>
Reviewed-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Link: https://lore.kernel.org/r/20250510081155.55840-2-liulongfang@huawei.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 41 ++++++++++++++++---
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    | 14 ++++++-
 2 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 39eeca18a0f7c..b5efb37712d5e 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -350,6 +350,32 @@ static int vf_qm_func_stop(struct hisi_qm *qm)
 	return hisi_qm_mb(qm, QM_MB_CMD_PAUSE_QM, 0, 0, 0);
 }
 
+static int vf_qm_version_check(struct acc_vf_data *vf_data, struct device *dev)
+{
+	switch (vf_data->acc_magic) {
+	case ACC_DEV_MAGIC_V2:
+		if (vf_data->major_ver != ACC_DRV_MAJOR_VER) {
+			dev_info(dev, "migration driver version<%u.%u> not match!\n",
+				 vf_data->major_ver, vf_data->minor_ver);
+			return -EINVAL;
+		}
+		break;
+	case ACC_DEV_MAGIC_V1:
+		/* Correct dma address */
+		vf_data->eqe_dma = vf_data->qm_eqc_dw[QM_XQC_ADDR_HIGH];
+		vf_data->eqe_dma <<= QM_XQC_ADDR_OFFSET;
+		vf_data->eqe_dma |= vf_data->qm_eqc_dw[QM_XQC_ADDR_LOW];
+		vf_data->aeqe_dma = vf_data->qm_aeqc_dw[QM_XQC_ADDR_HIGH];
+		vf_data->aeqe_dma <<= QM_XQC_ADDR_OFFSET;
+		vf_data->aeqe_dma |= vf_data->qm_aeqc_dw[QM_XQC_ADDR_LOW];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int vf_qm_check_match(struct hisi_acc_vf_core_device *hisi_acc_vdev,
 			     struct hisi_acc_vf_migration_file *migf)
 {
@@ -363,7 +389,8 @@ static int vf_qm_check_match(struct hisi_acc_vf_core_device *hisi_acc_vdev,
 	if (migf->total_length < QM_MATCH_SIZE)
 		return -EINVAL;
 
-	if (vf_data->acc_magic != ACC_DEV_MAGIC) {
+	ret = vf_qm_version_check(vf_data, dev);
+	if (ret) {
 		dev_err(dev, "failed to match ACC_DEV_MAGIC\n");
 		return -EINVAL;
 	}
@@ -417,7 +444,9 @@ static int vf_qm_get_match_data(struct hisi_acc_vf_core_device *hisi_acc_vdev,
 	int vf_id = hisi_acc_vdev->vf_id;
 	int ret;
 
-	vf_data->acc_magic = ACC_DEV_MAGIC;
+	vf_data->acc_magic = ACC_DEV_MAGIC_V2;
+	vf_data->major_ver = ACC_DRV_MAJOR_VER;
+	vf_data->minor_ver = ACC_DRV_MINOR_VER;
 	/* Save device id */
 	vf_data->dev_id = hisi_acc_vdev->vf_dev->device;
 
@@ -519,12 +548,12 @@ static int vf_qm_state_save(struct hisi_acc_vf_core_device *hisi_acc_vdev,
 		return -EINVAL;
 
 	/* Every reg is 32 bit, the dma address is 64 bit. */
-	vf_data->eqe_dma = vf_data->qm_eqc_dw[1];
+	vf_data->eqe_dma = vf_data->qm_eqc_dw[QM_XQC_ADDR_HIGH];
 	vf_data->eqe_dma <<= QM_XQC_ADDR_OFFSET;
-	vf_data->eqe_dma |= vf_data->qm_eqc_dw[0];
-	vf_data->aeqe_dma = vf_data->qm_aeqc_dw[1];
+	vf_data->eqe_dma |= vf_data->qm_eqc_dw[QM_XQC_ADDR_LOW];
+	vf_data->aeqe_dma = vf_data->qm_aeqc_dw[QM_XQC_ADDR_HIGH];
 	vf_data->aeqe_dma <<= QM_XQC_ADDR_OFFSET;
-	vf_data->aeqe_dma |= vf_data->qm_aeqc_dw[0];
+	vf_data->aeqe_dma |= vf_data->qm_aeqc_dw[QM_XQC_ADDR_LOW];
 
 	/* Through SQC_BT/CQC_BT to get sqc and cqc address */
 	ret = qm_get_sqc(vf_qm, &vf_data->sqc_dma);
diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
index 67343325b3201..f62247d0adf9a 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
@@ -38,6 +38,9 @@
 #define QM_REG_ADDR_OFFSET	0x0004
 
 #define QM_XQC_ADDR_OFFSET	32U
+#define QM_XQC_ADDR_LOW	0x1
+#define QM_XQC_ADDR_HIGH	0x2
+
 #define QM_VF_AEQ_INT_MASK	0x0004
 #define QM_VF_EQ_INT_MASK	0x000c
 #define QM_IFC_INT_SOURCE_V	0x0020
@@ -49,10 +52,15 @@
 #define QM_EQC_DW0		0X8000
 #define QM_AEQC_DW0		0X8020
 
+#define ACC_DRV_MAJOR_VER 1
+#define ACC_DRV_MINOR_VER 0
+
+#define ACC_DEV_MAGIC_V1	0XCDCDCDCDFEEDAACC
+#define ACC_DEV_MAGIC_V2	0xAACCFEEDDECADEDE
+
 struct acc_vf_data {
 #define QM_MATCH_SIZE offsetofend(struct acc_vf_data, qm_rsv_state)
 	/* QM match information */
-#define ACC_DEV_MAGIC	0XCDCDCDCDFEEDAACC
 	u64 acc_magic;
 	u32 qp_num;
 	u32 dev_id;
@@ -60,7 +68,9 @@ struct acc_vf_data {
 	u32 qp_base;
 	u32 vf_qm_state;
 	/* QM reserved match information */
-	u32 qm_rsv_state[3];
+	u16 major_ver;
+	u16 minor_ver;
+	u32 qm_rsv_state[2];
 
 	/* QM RW regs */
 	u32 aeq_int_mask;
-- 
2.39.5




