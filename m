Return-Path: <stable+bounces-14741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F4C83825F
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1BB284484
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF015B5D7;
	Tue, 23 Jan 2024 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2o0QgHm6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDAD5A7B8;
	Tue, 23 Jan 2024 01:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974336; cv=none; b=qfFW/3AD5mjGTB5pOehZSblonNLdeelPW3BsNCOtFOv7Dm5Tj1OmwqdehhBJdDJoGtmQaD9G0f4cSVv40Gyck5RbMMkYOC8ZVY0uCF/unwT66e6jHAtdqWN6G2tRHSYMpXii2vB4Iks/CXu/kgCnseRgAomTmwu+H+v1eI7ojCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974336; c=relaxed/simple;
	bh=Ms0KcOO0F/e72HwtjAPGhhe2Tg8AxCVjKpB6TvSnGvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXQGwNtYSZ+eUTFfs+O3HM0mFNuXnoRbBkGyKoC6cy6JeUPXkYvlHtxVVgXhLTY1xYXT6ae8obuJD6FXHlr8AkNga2qkVA1jdraTfelOmBMyeBm08oGisvnVAnnyE4IsVZJeLg16LFOKaxM5FBPJNVgY6VyhPxwtzioHu010358=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2o0QgHm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D389C43394;
	Tue, 23 Jan 2024 01:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974336;
	bh=Ms0KcOO0F/e72HwtjAPGhhe2Tg8AxCVjKpB6TvSnGvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2o0QgHm6hfq7nwxfNxAoC1tYEiDpB5hwcJ7H/9JjVHtucvAxL/p5G/U88c+aFgKfR
	 AcezwGO8uCRomzS5Fa9CI7b+OKdJLBmIpyVAh9ZOl7fVQnHfgcIQ97A6d/T74t8ggl
	 C6Uw2rlmrVcY0fzyrFrmNPsYaIg233F+urLM5a3Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhiqi Song <songzhiqi1@huawei.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 054/583] crypto: hisilicon/qm - save capability registers in qm init process
Date: Mon, 22 Jan 2024 15:51:45 -0800
Message-ID: <20240122235813.786683156@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhiqi Song <songzhiqi1@huawei.com>

[ Upstream commit cabe13d0bd2efb8dd50ed2310f57b33e1a69a0d4 ]

In previous capability register implementation, qm irq related values
were read from capability registers dynamically when needed. But in
abnormal scenario, e.g. the core is timeout and the device needs to
soft reset and reset failed after disabling the MSE, the device can
not be removed normally, causing the following call trace:

	| Call trace:
        |  pci_irq_vector+0xfc/0x140
        |  hisi_qm_uninit+0x278/0x3b0 [hisi_qm]
        |  hpre_remove+0x16c/0x1c0 [hisi_hpre]
        |  pci_device_remove+0x6c/0x264
        |  device_release_driver_internal+0x1ec/0x3e0
        |  device_release_driver+0x3c/0x60
        |  pci_stop_bus_device+0xfc/0x22c
        |  pci_stop_and_remove_bus_device+0x38/0x70
        |  pci_iov_remove_virtfn+0x108/0x1c0
        |  sriov_disable+0x7c/0x1e4
        |  pci_disable_sriov+0x4c/0x6c
        |  hisi_qm_sriov_disable+0x90/0x160 [hisi_qm]
        |  hpre_remove+0x1a8/0x1c0 [hisi_hpre]
        |  pci_device_remove+0x6c/0x264
        |  device_release_driver_internal+0x1ec/0x3e0
        |  driver_detach+0x168/0x2d0
        |  bus_remove_driver+0xc0/0x230
        |  driver_unregister+0x58/0xdc
        |  pci_unregister_driver+0x40/0x220
        |  hpre_exit+0x34/0x64 [hisi_hpre]
        |  __arm64_sys_delete_module+0x374/0x620
        [...]

        | Call trace:
        |  free_msi_irqs+0x25c/0x300
        |  pci_disable_msi+0x19c/0x264
        |  pci_free_irq_vectors+0x4c/0x70
        |  hisi_qm_pci_uninit+0x44/0x90 [hisi_qm]
        |  hisi_qm_uninit+0x28c/0x3b0 [hisi_qm]
        |  hpre_remove+0x16c/0x1c0 [hisi_hpre]
        |  pci_device_remove+0x6c/0x264
        [...]

The reason for this call trace is that when the MSE is disabled, the value
of capability registers in the BAR space become invalid. This will make the
subsequent unregister process get the wrong irq vector through capability
registers and get the wrong irq number by pci_irq_vector().

So add a capability table structure to pre-store the valid value of the irq
information capability register in qm init process, avoid obtaining invalid
capability register value after the MSE is disabled.

Fixes: 3536cc55cada ("crypto: hisilicon/qm - support get device irq information from hardware registers")
Signed-off-by: Zhiqi Song <songzhiqi1@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/hisilicon/qm.c | 62 +++++++++++++++++++++++++++++------
 include/linux/hisi_acc_qm.h   | 12 +++++++
 2 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index f1589eb3b46a..5872e0f0c094 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -306,6 +306,13 @@ enum qm_basic_type {
 	QM_VF_IRQ_NUM_CAP,
 };
 
+enum qm_pre_store_cap_idx {
+	QM_EQ_IRQ_TYPE_CAP_IDX = 0x0,
+	QM_AEQ_IRQ_TYPE_CAP_IDX,
+	QM_ABN_IRQ_TYPE_CAP_IDX,
+	QM_PF2VF_IRQ_TYPE_CAP_IDX,
+};
+
 static const struct hisi_qm_cap_info qm_cap_info_comm[] = {
 	{QM_SUPPORT_DB_ISOLATION, 0x30,   0, BIT(0),  0x0, 0x0, 0x0},
 	{QM_SUPPORT_FUNC_QOS,     0x3100, 0, BIT(8),  0x0, 0x0, 0x1},
@@ -335,6 +342,13 @@ static const struct hisi_qm_cap_info qm_basic_info[] = {
 	{QM_VF_IRQ_NUM_CAP,     0x311c,   0,  GENMASK(15, 0), 0x1,       0x2,       0x3},
 };
 
+static const u32 qm_pre_store_caps[] = {
+	QM_EQ_IRQ_TYPE_CAP,
+	QM_AEQ_IRQ_TYPE_CAP,
+	QM_ABN_IRQ_TYPE_CAP,
+	QM_PF2VF_IRQ_TYPE_CAP,
+};
+
 struct qm_mailbox {
 	__le16 w0;
 	__le16 queue_num;
@@ -4903,7 +4917,7 @@ static void qm_unregister_abnormal_irq(struct hisi_qm *qm)
 	if (qm->fun_type == QM_HW_VF)
 		return;
 
-	val = hisi_qm_get_hw_info(qm, qm_basic_info, QM_ABN_IRQ_TYPE_CAP, qm->cap_ver);
+	val = qm->cap_tables.qm_cap_table[QM_ABN_IRQ_TYPE_CAP_IDX].cap_val;
 	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_ABN_IRQ_TYPE_MASK))
 		return;
 
@@ -4920,7 +4934,7 @@ static int qm_register_abnormal_irq(struct hisi_qm *qm)
 	if (qm->fun_type == QM_HW_VF)
 		return 0;
 
-	val = hisi_qm_get_hw_info(qm, qm_basic_info, QM_ABN_IRQ_TYPE_CAP, qm->cap_ver);
+	val = qm->cap_tables.qm_cap_table[QM_ABN_IRQ_TYPE_CAP_IDX].cap_val;
 	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_ABN_IRQ_TYPE_MASK))
 		return 0;
 
@@ -4937,7 +4951,7 @@ static void qm_unregister_mb_cmd_irq(struct hisi_qm *qm)
 	struct pci_dev *pdev = qm->pdev;
 	u32 irq_vector, val;
 
-	val = hisi_qm_get_hw_info(qm, qm_basic_info, QM_PF2VF_IRQ_TYPE_CAP, qm->cap_ver);
+	val = qm->cap_tables.qm_cap_table[QM_PF2VF_IRQ_TYPE_CAP_IDX].cap_val;
 	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_IRQ_TYPE_MASK))
 		return;
 
@@ -4951,7 +4965,7 @@ static int qm_register_mb_cmd_irq(struct hisi_qm *qm)
 	u32 irq_vector, val;
 	int ret;
 
-	val = hisi_qm_get_hw_info(qm, qm_basic_info, QM_PF2VF_IRQ_TYPE_CAP, qm->cap_ver);
+	val = qm->cap_tables.qm_cap_table[QM_PF2VF_IRQ_TYPE_CAP_IDX].cap_val;
 	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_IRQ_TYPE_MASK))
 		return 0;
 
@@ -4968,7 +4982,7 @@ static void qm_unregister_aeq_irq(struct hisi_qm *qm)
 	struct pci_dev *pdev = qm->pdev;
 	u32 irq_vector, val;
 
-	val = hisi_qm_get_hw_info(qm, qm_basic_info, QM_AEQ_IRQ_TYPE_CAP, qm->cap_ver);
+	val = qm->cap_tables.qm_cap_table[QM_AEQ_IRQ_TYPE_CAP_IDX].cap_val;
 	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_IRQ_TYPE_MASK))
 		return;
 
@@ -4982,7 +4996,7 @@ static int qm_register_aeq_irq(struct hisi_qm *qm)
 	u32 irq_vector, val;
 	int ret;
 
-	val = hisi_qm_get_hw_info(qm, qm_basic_info, QM_AEQ_IRQ_TYPE_CAP, qm->cap_ver);
+	val = qm->cap_tables.qm_cap_table[QM_AEQ_IRQ_TYPE_CAP_IDX].cap_val;
 	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_IRQ_TYPE_MASK))
 		return 0;
 
@@ -5000,7 +5014,7 @@ static void qm_unregister_eq_irq(struct hisi_qm *qm)
 	struct pci_dev *pdev = qm->pdev;
 	u32 irq_vector, val;
 
-	val = hisi_qm_get_hw_info(qm, qm_basic_info, QM_EQ_IRQ_TYPE_CAP, qm->cap_ver);
+	val = qm->cap_tables.qm_cap_table[QM_EQ_IRQ_TYPE_CAP_IDX].cap_val;
 	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_IRQ_TYPE_MASK))
 		return;
 
@@ -5014,7 +5028,7 @@ static int qm_register_eq_irq(struct hisi_qm *qm)
 	u32 irq_vector, val;
 	int ret;
 
-	val = hisi_qm_get_hw_info(qm, qm_basic_info, QM_EQ_IRQ_TYPE_CAP, qm->cap_ver);
+	val = qm->cap_tables.qm_cap_table[QM_EQ_IRQ_TYPE_CAP_IDX].cap_val;
 	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_IRQ_TYPE_MASK))
 		return 0;
 
@@ -5102,7 +5116,29 @@ static int qm_get_qp_num(struct hisi_qm *qm)
 	return 0;
 }
 
-static void qm_get_hw_caps(struct hisi_qm *qm)
+static int qm_pre_store_irq_type_caps(struct hisi_qm *qm)
+{
+	struct hisi_qm_cap_record *qm_cap;
+	struct pci_dev *pdev = qm->pdev;
+	size_t i, size;
+
+	size = ARRAY_SIZE(qm_pre_store_caps);
+	qm_cap = devm_kzalloc(&pdev->dev, sizeof(*qm_cap) * size, GFP_KERNEL);
+	if (!qm_cap)
+		return -ENOMEM;
+
+	for (i = 0; i < size; i++) {
+		qm_cap[i].type = qm_pre_store_caps[i];
+		qm_cap[i].cap_val = hisi_qm_get_hw_info(qm, qm_basic_info,
+							qm_pre_store_caps[i], qm->cap_ver);
+	}
+
+	qm->cap_tables.qm_cap_table = qm_cap;
+
+	return 0;
+}
+
+static int qm_get_hw_caps(struct hisi_qm *qm)
 {
 	const struct hisi_qm_cap_info *cap_info = qm->fun_type == QM_HW_PF ?
 						  qm_cap_info_pf : qm_cap_info_vf;
@@ -5133,6 +5169,9 @@ static void qm_get_hw_caps(struct hisi_qm *qm)
 		if (val)
 			set_bit(cap_info[i].type, &qm->caps);
 	}
+
+	/* Fetch and save the value of irq type related capability registers */
+	return qm_pre_store_irq_type_caps(qm);
 }
 
 static int qm_get_pci_res(struct hisi_qm *qm)
@@ -5154,7 +5193,10 @@ static int qm_get_pci_res(struct hisi_qm *qm)
 		goto err_request_mem_regions;
 	}
 
-	qm_get_hw_caps(qm);
+	ret = qm_get_hw_caps(qm);
+	if (ret)
+		goto err_ioremap;
+
 	if (test_bit(QM_SUPPORT_DB_ISOLATION, &qm->caps)) {
 		qm->db_interval = QM_QP_DB_INTERVAL;
 		qm->db_phys_base = pci_resource_start(pdev, PCI_BAR_4);
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 7262c9993c39..eff6ec42ccbe 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -265,6 +265,16 @@ struct hisi_qm_cap_info {
 	u32 v3_val;
 };
 
+struct hisi_qm_cap_record {
+	u32 type;
+	u32 cap_val;
+};
+
+struct hisi_qm_cap_tables {
+	struct hisi_qm_cap_record *qm_cap_table;
+	struct hisi_qm_cap_record *dev_cap_table;
+};
+
 struct hisi_qm_list {
 	struct mutex lock;
 	struct list_head list;
@@ -363,6 +373,8 @@ struct hisi_qm {
 	u32 mb_qos;
 	u32 type_rate;
 	struct qm_err_isolate isolate_data;
+
+	struct hisi_qm_cap_tables cap_tables;
 };
 
 struct hisi_qp_status {
-- 
2.43.0




