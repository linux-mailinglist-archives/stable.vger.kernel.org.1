Return-Path: <stable+bounces-84279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E8599CF64
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B44B1F22F98
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2838B1C7610;
	Mon, 14 Oct 2024 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hu6nC47l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A101AD3E5;
	Mon, 14 Oct 2024 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917456; cv=none; b=IGUcyYzt1zbsMX+WNG9Joe5h+MoTIpfcAe4vz9iM0sqwIyYlP8NQYu9A7ugMzjwlSmzXv65PuAruLiA/Vif+ZjRn0vQY3phSswCHVe4zb9FcdrN4yKL/Uainuun1o8dh4UUWYR9ZyD/Qpqql8ic67xuoWIbd2K1sOk0fiTiOTBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917456; c=relaxed/simple;
	bh=RkaKx35B/6dnepMhQxRZ8tEIUCp6nBgn+jAk59xu9E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGRGZK5Q4bktegzg4D/Ovz8N16xP87TE7EBgk9+Q7fJYRFCVLygGzDI4iL2py/bnfNUanOpvyzQ3QSPuDVW3Okf4aO/CzM8QbX/riSqPPIDLE9GBY4jAPHMlu9egXFZwd5gMw6hSNQHtNdLCeZewnDYES5sn+HjTsMOl/Sn45IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hu6nC47l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4550CC4CEC3;
	Mon, 14 Oct 2024 14:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728917456;
	bh=RkaKx35B/6dnepMhQxRZ8tEIUCp6nBgn+jAk59xu9E8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hu6nC47l11K8HlNpI5jZpLRxhElaMXWirF6pnY2cFRefNmw7r19n9BRZUjcgkq3w3
	 rcQZy4F3S6pMvw2YJC6VVrBRr/S5Ti0EgC8lLkcYn10BGNNBU7zW3pKxmrv56W5Sf6
	 l8r7jS3KlcDp4wmS81jNoE+Ss8PJOxqxsgqdBG9A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Weili Qian <qianweili@huawei.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 040/798] crypto: hisilicon/qm - reset device before enabling it
Date: Mon, 14 Oct 2024 16:09:54 +0200
Message-ID: <20241014141219.517715033@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Weili Qian <qianweili@huawei.com>

[ Upstream commit 5d2d1ee0874c26b8010ddf7f57e2f246e848af38 ]

Before the device is enabled again, the device may still
store the previously processed data. If an error occurs in
the previous task, the device may fail to be enabled again.
Therefore, before enabling device, reset the device to restore
the initial state.

Signed-off-by: Weili Qian <qianweili@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: b04f06fc0243 ("crypto: hisilicon/qm - inject error before stopping queue")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c |  32 +++---
 drivers/crypto/hisilicon/qm.c             | 114 +++++++++++++++-------
 drivers/crypto/hisilicon/sec2/sec_main.c  |  16 ++-
 drivers/crypto/hisilicon/zip/zip_main.c   |  23 +++--
 4 files changed, 121 insertions(+), 64 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index ed5bb2d7292a0..e9abb66773fe9 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -354,6 +354,8 @@ static struct dfx_diff_registers hpre_diff_regs[] = {
 	},
 };
 
+static const struct hisi_qm_err_ini hpre_err_ini;
+
 bool hpre_check_alg_support(struct hisi_qm *qm, u32 alg)
 {
 	u32 cap_val;
@@ -1152,6 +1154,7 @@ static int hpre_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		qm->qp_num = pf_q_num;
 		qm->debug.curr_qm_qp_num = pf_q_num;
 		qm->qm_list = &hpre_devices;
+		qm->err_ini = &hpre_err_ini;
 		if (pf_q_num_flag)
 			set_bit(QM_MODULE_PARAM, &qm->misc_ctl);
 	}
@@ -1341,8 +1344,6 @@ static int hpre_pf_probe_init(struct hpre *hpre)
 
 	hpre_open_sva_prefetch(qm);
 
-	qm->err_ini = &hpre_err_ini;
-	qm->err_ini->err_info_init(qm);
 	hisi_qm_dev_err_init(qm);
 	ret = hpre_show_last_regs_init(qm);
 	if (ret)
@@ -1371,6 +1372,18 @@ static int hpre_probe_init(struct hpre *hpre)
 	return 0;
 }
 
+static void hpre_probe_uninit(struct hisi_qm *qm)
+{
+	if (qm->fun_type == QM_HW_VF)
+		return;
+
+	hpre_cnt_regs_clear(qm);
+	qm->debug.curr_qm_qp_num = 0;
+	hpre_show_last_regs_uninit(qm);
+	hpre_close_sva_prefetch(qm);
+	hisi_qm_dev_err_uninit(qm);
+}
+
 static int hpre_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct hisi_qm *qm;
@@ -1396,7 +1409,7 @@ static int hpre_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	ret = hisi_qm_start(qm);
 	if (ret)
-		goto err_with_err_init;
+		goto err_with_probe_init;
 
 	ret = hpre_debugfs_init(qm);
 	if (ret)
@@ -1433,9 +1446,8 @@ static int hpre_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	hpre_debugfs_exit(qm);
 	hisi_qm_stop(qm, QM_NORMAL);
 
-err_with_err_init:
-	hpre_show_last_regs_uninit(qm);
-	hisi_qm_dev_err_uninit(qm);
+err_with_probe_init:
+	hpre_probe_uninit(qm);
 
 err_with_qm_init:
 	hisi_qm_uninit(qm);
@@ -1456,13 +1468,7 @@ static void hpre_remove(struct pci_dev *pdev)
 	hpre_debugfs_exit(qm);
 	hisi_qm_stop(qm, QM_NORMAL);
 
-	if (qm->fun_type == QM_HW_PF) {
-		hpre_cnt_regs_clear(qm);
-		qm->debug.curr_qm_qp_num = 0;
-		hpre_show_last_regs_uninit(qm);
-		hisi_qm_dev_err_uninit(qm);
-	}
-
+	hpre_probe_uninit(qm);
 	hisi_qm_uninit(qm);
 }
 
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 8b85cb5ab6f89..83ec28f9515ea 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -454,6 +454,7 @@ static struct qm_typical_qos_table shaper_cbs_s[] = {
 };
 
 static void qm_irqs_unregister(struct hisi_qm *qm);
+static int qm_reset_device(struct hisi_qm *qm);
 
 static bool qm_avail_state(struct hisi_qm *qm, enum qm_state new)
 {
@@ -4104,6 +4105,22 @@ static int qm_controller_reset_prepare(struct hisi_qm *qm)
 	return 0;
 }
 
+static int qm_master_ooo_check(struct hisi_qm *qm)
+{
+	u32 val;
+	int ret;
+
+	/* Check the ooo register of the device before resetting the device. */
+	writel(ACC_MASTER_GLOBAL_CTRL_SHUTDOWN, qm->io_base + ACC_MASTER_GLOBAL_CTRL);
+	ret = readl_relaxed_poll_timeout(qm->io_base + ACC_MASTER_TRANS_RETURN,
+					 val, (val == ACC_MASTER_TRANS_RETURN_RW),
+					 POLL_PERIOD, POLL_TIMEOUT);
+	if (ret)
+		pci_warn(qm->pdev, "Bus lock! Please reset system.\n");
+
+	return ret;
+}
+
 static void qm_dev_ecc_mbit_handle(struct hisi_qm *qm)
 {
 	u32 nfe_enb = 0;
@@ -4126,11 +4143,10 @@ static void qm_dev_ecc_mbit_handle(struct hisi_qm *qm)
 	}
 }
 
-static int qm_soft_reset(struct hisi_qm *qm)
+static int qm_soft_reset_prepare(struct hisi_qm *qm)
 {
 	struct pci_dev *pdev = qm->pdev;
 	int ret;
-	u32 val;
 
 	/* Ensure all doorbells and mailboxes received by QM */
 	ret = qm_check_req_recv(qm);
@@ -4152,29 +4168,23 @@ static int qm_soft_reset(struct hisi_qm *qm)
 	}
 
 	qm_dev_ecc_mbit_handle(qm);
-
-	/* OOO register set and check */
-	writel(ACC_MASTER_GLOBAL_CTRL_SHUTDOWN,
-	       qm->io_base + ACC_MASTER_GLOBAL_CTRL);
-
-	/* If bus lock, reset chip */
-	ret = readl_relaxed_poll_timeout(qm->io_base + ACC_MASTER_TRANS_RETURN,
-					 val,
-					 (val == ACC_MASTER_TRANS_RETURN_RW),
-					 POLL_PERIOD, POLL_TIMEOUT);
-	if (ret) {
-		pci_emerg(pdev, "Bus lock! Please reset system.\n");
+	ret = qm_master_ooo_check(qm);
+	if (ret)
 		return ret;
-	}
 
 	if (qm->err_ini->close_sva_prefetch)
 		qm->err_ini->close_sva_prefetch(qm);
 
 	ret = qm_set_pf_mse(qm, false);
-	if (ret) {
+	if (ret)
 		pci_err(pdev, "Fails to disable pf MSE bit.\n");
-		return ret;
-	}
+
+	return ret;
+}
+
+static int qm_reset_device(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
 
 	/* The reset related sub-control registers are not in PCI BAR */
 	if (ACPI_HANDLE(&pdev->dev)) {
@@ -4193,12 +4203,23 @@ static int qm_soft_reset(struct hisi_qm *qm)
 			pci_err(pdev, "Reset step %llu failed!\n", value);
 			return -EIO;
 		}
-	} else {
-		pci_err(pdev, "No reset method!\n");
-		return -EINVAL;
+
+		return 0;
 	}
 
-	return 0;
+	pci_err(pdev, "No reset method!\n");
+	return -EINVAL;
+}
+
+static int qm_soft_reset(struct hisi_qm *qm)
+{
+	int ret;
+
+	ret = qm_soft_reset_prepare(qm);
+	if (ret)
+		return ret;
+
+	return qm_reset_device(qm);
 }
 
 static int qm_vf_reset_done(struct hisi_qm *qm)
@@ -5160,6 +5181,35 @@ static int qm_get_pci_res(struct hisi_qm *qm)
 	return ret;
 }
 
+static int qm_clear_device(struct hisi_qm *qm)
+{
+	acpi_handle handle = ACPI_HANDLE(&qm->pdev->dev);
+	int ret;
+
+	if (qm->fun_type == QM_HW_VF)
+		return 0;
+
+	/* Device does not support reset, return */
+	if (!qm->err_ini->err_info_init)
+		return 0;
+	qm->err_ini->err_info_init(qm);
+
+	if (!handle)
+		return 0;
+
+	/* No reset method, return */
+	if (!acpi_has_method(handle, qm->err_info.acpi_rst))
+		return 0;
+
+	ret = qm_master_ooo_check(qm);
+	if (ret) {
+		writel(0x0, qm->io_base + ACC_MASTER_GLOBAL_CTRL);
+		return ret;
+	}
+
+	return qm_reset_device(qm);
+}
+
 static int hisi_qm_pci_init(struct hisi_qm *qm)
 {
 	struct pci_dev *pdev = qm->pdev;
@@ -5189,8 +5239,14 @@ static int hisi_qm_pci_init(struct hisi_qm *qm)
 		goto err_get_pci_res;
 	}
 
+	ret = qm_clear_device(qm);
+	if (ret)
+		goto err_free_vectors;
+
 	return 0;
 
+err_free_vectors:
+	pci_free_irq_vectors(pdev);
 err_get_pci_res:
 	qm_put_pci_res(qm);
 err_disable_pcidev:
@@ -5457,7 +5513,6 @@ static int qm_prepare_for_suspend(struct hisi_qm *qm)
 {
 	struct pci_dev *pdev = qm->pdev;
 	int ret;
-	u32 val;
 
 	ret = qm->ops->set_msi(qm, false);
 	if (ret) {
@@ -5465,18 +5520,9 @@ static int qm_prepare_for_suspend(struct hisi_qm *qm)
 		return ret;
 	}
 
-	/* shutdown OOO register */
-	writel(ACC_MASTER_GLOBAL_CTRL_SHUTDOWN,
-	       qm->io_base + ACC_MASTER_GLOBAL_CTRL);
-
-	ret = readl_relaxed_poll_timeout(qm->io_base + ACC_MASTER_TRANS_RETURN,
-					 val,
-					 (val == ACC_MASTER_TRANS_RETURN_RW),
-					 POLL_PERIOD, POLL_TIMEOUT);
-	if (ret) {
-		pci_emerg(pdev, "Bus lock! Please reset system.\n");
+	ret = qm_master_ooo_check(qm);
+	if (ret)
 		return ret;
-	}
 
 	ret = qm_set_pf_mse(qm, false);
 	if (ret)
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 4bab5000a13e5..d2ead648767bd 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -1063,9 +1063,6 @@ static int sec_pf_probe_init(struct sec_dev *sec)
 	struct hisi_qm *qm = &sec->qm;
 	int ret;
 
-	qm->err_ini = &sec_err_ini;
-	qm->err_ini->err_info_init(qm);
-
 	ret = sec_set_user_domain_and_cache(qm);
 	if (ret)
 		return ret;
@@ -1120,6 +1117,7 @@ static int sec_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		qm->qp_num = pf_q_num;
 		qm->debug.curr_qm_qp_num = pf_q_num;
 		qm->qm_list = &sec_devices;
+		qm->err_ini = &sec_err_ini;
 		if (pf_q_num_flag)
 			set_bit(QM_MODULE_PARAM, &qm->misc_ctl);
 	} else if (qm->fun_type == QM_HW_VF && qm->ver == QM_HW_V1) {
@@ -1184,6 +1182,12 @@ static int sec_probe_init(struct sec_dev *sec)
 
 static void sec_probe_uninit(struct hisi_qm *qm)
 {
+	if (qm->fun_type == QM_HW_VF)
+		return;
+
+	sec_debug_regs_clear(qm);
+	sec_show_last_regs_uninit(qm);
+	sec_close_sva_prefetch(qm);
 	hisi_qm_dev_err_uninit(qm);
 }
 
@@ -1276,7 +1280,6 @@ static int sec_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	sec_debugfs_exit(qm);
 	hisi_qm_stop(qm, QM_NORMAL);
 err_probe_uninit:
-	sec_show_last_regs_uninit(qm);
 	sec_probe_uninit(qm);
 err_qm_uninit:
 	sec_qm_uninit(qm);
@@ -1298,11 +1301,6 @@ static void sec_remove(struct pci_dev *pdev)
 	sec_debugfs_exit(qm);
 
 	(void)hisi_qm_stop(qm, QM_NORMAL);
-
-	if (qm->fun_type == QM_HW_PF)
-		sec_debug_regs_clear(qm);
-	sec_show_last_regs_uninit(qm);
-
 	sec_probe_uninit(qm);
 
 	sec_qm_uninit(qm);
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 9e3f5bca27dee..a8d5d105b3542 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -1151,8 +1151,6 @@ static int hisi_zip_pf_probe_init(struct hisi_zip *hisi_zip)
 
 	hisi_zip->ctrl = ctrl;
 	ctrl->hisi_zip = hisi_zip;
-	qm->err_ini = &hisi_zip_err_ini;
-	qm->err_ini->err_info_init(qm);
 
 	ret = hisi_zip_set_user_domain_and_cache(qm);
 	if (ret)
@@ -1213,6 +1211,7 @@ static int hisi_zip_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		qm->qp_num = pf_q_num;
 		qm->debug.curr_qm_qp_num = pf_q_num;
 		qm->qm_list = &zip_devices;
+		qm->err_ini = &hisi_zip_err_ini;
 		if (pf_q_num_flag)
 			set_bit(QM_MODULE_PARAM, &qm->misc_ctl);
 	} else if (qm->fun_type == QM_HW_VF && qm->ver == QM_HW_V1) {
@@ -1279,6 +1278,16 @@ static int hisi_zip_probe_init(struct hisi_zip *hisi_zip)
 	return 0;
 }
 
+static void hisi_zip_probe_uninit(struct hisi_qm *qm)
+{
+	if (qm->fun_type == QM_HW_VF)
+		return;
+
+	hisi_zip_show_last_regs_uninit(qm);
+	hisi_zip_close_sva_prefetch(qm);
+	hisi_qm_dev_err_uninit(qm);
+}
+
 static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct hisi_zip *hisi_zip;
@@ -1305,7 +1314,7 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	ret = hisi_qm_start(qm);
 	if (ret)
-		goto err_dev_err_uninit;
+		goto err_probe_uninit;
 
 	ret = hisi_zip_debugfs_init(qm);
 	if (ret)
@@ -1342,9 +1351,8 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	hisi_zip_debugfs_exit(qm);
 	hisi_qm_stop(qm, QM_NORMAL);
 
-err_dev_err_uninit:
-	hisi_zip_show_last_regs_uninit(qm);
-	hisi_qm_dev_err_uninit(qm);
+err_probe_uninit:
+	hisi_zip_probe_uninit(qm);
 
 err_qm_uninit:
 	hisi_zip_qm_uninit(qm);
@@ -1365,8 +1373,7 @@ static void hisi_zip_remove(struct pci_dev *pdev)
 
 	hisi_zip_debugfs_exit(qm);
 	hisi_qm_stop(qm, QM_NORMAL);
-	hisi_zip_show_last_regs_uninit(qm);
-	hisi_qm_dev_err_uninit(qm);
+	hisi_zip_probe_uninit(qm);
 	hisi_zip_qm_uninit(qm);
 }
 
-- 
2.43.0




