Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9C47ECC7A
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbjKOTao (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbjKOTam (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:30:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB0719D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:30:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63A5C433C8;
        Wed, 15 Nov 2023 19:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076639;
        bh=8bkt9+XocJYJ6pB/Rj52UyPJoPNIe2KhvTC9l181HD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YLsQXwBSMBGQtlxi3d19BGTVKsjWyf5SAOEHNJGRtvg31uUCzVAdH3oHZyRdkF/0c
         HOEe3MFFHBIHqJCeyJ1ZcTjd4Zc6TTUqCugtOT0PCJKUrfu1mgBse96G199humWE4P
         1Wi0DcdOnBfOp55xgCRhY9nveXAKLrHW55cMtqCM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Longfang Liu <liulongfang@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 330/550] crypto: hisilicon/qm - fix PF queue parameter issue
Date:   Wed, 15 Nov 2023 14:15:14 -0500
Message-ID: <20231115191623.638271549@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Longfang Liu <liulongfang@huawei.com>

[ Upstream commit 5831fc1fd4a578232fea708b82de0c666ed17153 ]

If the queue isolation feature is enabled, the number of queues
supported by the device changes. When PF is enabled using the
current default number of queues, the default number of queues may
be greater than the number supported by the device. As a result,
the PF fails to be bound to the driver.

After modification, if queue isolation feature is enabled, when
the default queue parameter is greater than the number supported
by the device, the number of enabled queues will be changed to
the number supported by the device, so that the PF and driver
can be properly bound.

Fixes: 8bbecfb402f7 ("crypto: hisilicon/qm - add queue isolation support for Kunpeng930")
Signed-off-by: Longfang Liu <liulongfang@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c |  5 +++++
 drivers/crypto/hisilicon/qm.c             | 18 ++++++++++++------
 drivers/crypto/hisilicon/qm_common.h      |  1 -
 drivers/crypto/hisilicon/sec2/sec_main.c  |  5 +++++
 drivers/crypto/hisilicon/zip/zip_main.c   |  5 +++++
 include/linux/hisi_acc_qm.h               |  7 +++++++
 6 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 655138d21e71f..bbf1bbe283574 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -430,8 +430,11 @@ static u32 uacce_mode = UACCE_MODE_NOUACCE;
 module_param_cb(uacce_mode, &hpre_uacce_mode_ops, &uacce_mode, 0444);
 MODULE_PARM_DESC(uacce_mode, UACCE_MODE_DESC);
 
+static bool pf_q_num_flag;
 static int pf_q_num_set(const char *val, const struct kernel_param *kp)
 {
+	pf_q_num_flag = true;
+
 	return q_num_set(val, kp, PCI_DEVICE_ID_HUAWEI_HPRE_PF);
 }
 
@@ -1154,6 +1157,8 @@ static int hpre_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		qm->qp_num = pf_q_num;
 		qm->debug.curr_qm_qp_num = pf_q_num;
 		qm->qm_list = &hpre_devices;
+		if (pf_q_num_flag)
+			set_bit(QM_MODULE_PARAM, &qm->misc_ctl);
 	}
 
 	ret = hisi_qm_init(qm);
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index edc6fd44e7ca9..ba4852744c052 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -204,8 +204,6 @@
 #define WAIT_PERIOD			20
 #define REMOVE_WAIT_DELAY		10
 
-#define QM_DRIVER_REMOVING		0
-#define QM_RST_SCHED			1
 #define QM_QOS_PARAM_NUM		2
 #define QM_QOS_MAX_VAL			1000
 #define QM_QOS_RATE			100
@@ -2814,7 +2812,6 @@ static void hisi_qm_pre_init(struct hisi_qm *qm)
 	mutex_init(&qm->mailbox_lock);
 	init_rwsem(&qm->qps_lock);
 	qm->qp_in_used = 0;
-	qm->misc_ctl = false;
 	if (test_bit(QM_SUPPORT_RPM, &qm->caps)) {
 		if (!acpi_device_power_manageable(ACPI_COMPANION(&pdev->dev)))
 			dev_info(&pdev->dev, "_PS0 and _PR0 are not defined");
@@ -5081,6 +5078,7 @@ static int qm_irqs_register(struct hisi_qm *qm)
 
 static int qm_get_qp_num(struct hisi_qm *qm)
 {
+	struct device *dev = &qm->pdev->dev;
 	bool is_db_isolation;
 
 	/* VF's qp_num assigned by PF in v2, and VF can get qp_num by vft. */
@@ -5097,13 +5095,21 @@ static int qm_get_qp_num(struct hisi_qm *qm)
 	qm->max_qp_num = hisi_qm_get_hw_info(qm, qm_basic_info,
 					     QM_FUNC_MAX_QP_CAP, is_db_isolation);
 
-	/* check if qp number is valid */
-	if (qm->qp_num > qm->max_qp_num) {
-		dev_err(&qm->pdev->dev, "qp num(%u) is more than max qp num(%u)!\n",
+	if (qm->qp_num <= qm->max_qp_num)
+		return 0;
+
+	if (test_bit(QM_MODULE_PARAM, &qm->misc_ctl)) {
+		/* Check whether the set qp number is valid */
+		dev_err(dev, "qp num(%u) is more than max qp num(%u)!\n",
 			qm->qp_num, qm->max_qp_num);
 		return -EINVAL;
 	}
 
+	dev_info(dev, "Default qp num(%u) is too big, reset it to Function's max qp num(%u)!\n",
+		 qm->qp_num, qm->max_qp_num);
+	qm->qp_num = qm->max_qp_num;
+	qm->debug.curr_qm_qp_num = qm->qp_num;
+
 	return 0;
 }
 
diff --git a/drivers/crypto/hisilicon/qm_common.h b/drivers/crypto/hisilicon/qm_common.h
index 1406a422d4551..8e36aa9c681be 100644
--- a/drivers/crypto/hisilicon/qm_common.h
+++ b/drivers/crypto/hisilicon/qm_common.h
@@ -4,7 +4,6 @@
 #define QM_COMMON_H
 
 #define QM_DBG_READ_LEN		256
-#define QM_RESETTING		2
 
 struct qm_cqe {
 	__le32 rsvd0;
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 77f9f131b8503..62bd8936a9154 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -311,8 +311,11 @@ static int sec_diff_regs_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(sec_diff_regs);
 
+static bool pf_q_num_flag;
 static int sec_pf_q_num_set(const char *val, const struct kernel_param *kp)
 {
+	pf_q_num_flag = true;
+
 	return q_num_set(val, kp, PCI_DEVICE_ID_HUAWEI_SEC_PF);
 }
 
@@ -1120,6 +1123,8 @@ static int sec_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		qm->qp_num = pf_q_num;
 		qm->debug.curr_qm_qp_num = pf_q_num;
 		qm->qm_list = &sec_devices;
+		if (pf_q_num_flag)
+			set_bit(QM_MODULE_PARAM, &qm->misc_ctl);
 	} else if (qm->fun_type == QM_HW_VF && qm->ver == QM_HW_V1) {
 		/*
 		 * have no way to get qm configure in VM in v1 hardware,
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index f3ce34198775d..84dbaeb07ea83 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -364,8 +364,11 @@ static u32 uacce_mode = UACCE_MODE_NOUACCE;
 module_param_cb(uacce_mode, &zip_uacce_mode_ops, &uacce_mode, 0444);
 MODULE_PARM_DESC(uacce_mode, UACCE_MODE_DESC);
 
+static bool pf_q_num_flag;
 static int pf_q_num_set(const char *val, const struct kernel_param *kp)
 {
+	pf_q_num_flag = true;
+
 	return q_num_set(val, kp, PCI_DEVICE_ID_HUAWEI_ZIP_PF);
 }
 
@@ -1139,6 +1142,8 @@ static int hisi_zip_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		qm->qp_num = pf_q_num;
 		qm->debug.curr_qm_qp_num = pf_q_num;
 		qm->qm_list = &zip_devices;
+		if (pf_q_num_flag)
+			set_bit(QM_MODULE_PARAM, &qm->misc_ctl);
 	} else if (qm->fun_type == QM_HW_VF && qm->ver == QM_HW_V1) {
 		/*
 		 * have no way to get qm configure in VM in v1 hardware,
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index a7d54d4d41fdb..e1bb4c2801e6b 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -144,6 +144,13 @@ enum qm_vf_state {
 	QM_NOT_READY,
 };
 
+enum qm_misc_ctl_bits {
+	QM_DRIVER_REMOVING = 0x0,
+	QM_RST_SCHED,
+	QM_RESETTING,
+	QM_MODULE_PARAM,
+};
+
 enum qm_cap_bits {
 	QM_SUPPORT_DB_ISOLATION = 0x0,
 	QM_SUPPORT_FUNC_QOS,
-- 
2.42.0



