Return-Path: <stable+bounces-138331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0956AA177F
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C6A01BC3E75
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F522459C5;
	Tue, 29 Apr 2025 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zs5Q9iBd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FD4C148;
	Tue, 29 Apr 2025 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948893; cv=none; b=oyyMQpf2voJFvl+wNtQpvpV1F9c4HjjjmKOxdFN5WLXa9FTwiZq7SLYWc3Ad0IVH2a4QuCTLTUYxA2AKnGQiIZDMotj71d1a5Ns7UXLGc4dZEKl6N4sxsFuGZOR+nxZ4B8n55zdKqwemkfBrmsoGuK5CO9gdUWsAecF4F+qlAYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948893; c=relaxed/simple;
	bh=HyOB92Vszon4USWBz80OlzIfNIEvulCfREjyYmUJyOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1L4omtIMP2n/xHUzVvvYl1IZo4100fral2RXldpDZ9NTSe04hp14qJZ3KP1rtbSUwiZ+40efPMdSGcZr2oQYVje/37y7bHesNNjhpVPzR7a/BJfui6b0Hb8PQbid3EripxxE04YyM2jHh4/biq4lffduJ8PzFdk1cz2SJsPczo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zs5Q9iBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBAEC4CEE9;
	Tue, 29 Apr 2025 17:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745948893;
	bh=HyOB92Vszon4USWBz80OlzIfNIEvulCfREjyYmUJyOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zs5Q9iBdCX78KubConCTljICWXlF/v7xJTCRqSmpHMNSb7BXuPqKQcaduyRcvzXML
	 AsD7GxEMXvbohcvghwUrJeX3Ktm2jiyVwH2+9N9eTs5M4gJUkXo5eI2XxAtiz8bOk0
	 MFt18wBeG5ZCUpgFgYrwH0F/Mepw+NYPsVoC8L/k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yihang Li <liyihang6@hisilicon.com>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Christoph Hellwig <hch@lst.de>,
	Xiang Chen <chenxiang66@hisilicon.com>,
	John Garry <john.garry@huawei.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 124/373] scsi: libsas: Delete lldd_clear_aca callback
Date: Tue, 29 Apr 2025 18:40:01 +0200
Message-ID: <20250429161128.277832704@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Garry <john.garry@huawei.com>

[ Upstream commit 25882c82f850e3e972a973e0af310b3e58de38fd ]

This callback is never called, so remove support.

Link: https://lore.kernel.org/r/1645112566-115804-4-git-send-email-john.garry@huawei.com
Tested-by: Yihang Li <liyihang6@hisilicon.com>
Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 8aa580cd9284 ("scsi: hisi_sas: Enable force phy when SATA disk directly connected")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/scsi/libsas.rst         |  2 --
 drivers/scsi/aic94xx/aic94xx.h        |  1 -
 drivers/scsi/aic94xx/aic94xx_init.c   |  1 -
 drivers/scsi/aic94xx/aic94xx_tmf.c    |  9 ---------
 drivers/scsi/hisi_sas/hisi_sas_main.c | 12 ------------
 drivers/scsi/isci/init.c              |  1 -
 drivers/scsi/isci/task.c              | 18 ------------------
 drivers/scsi/isci/task.h              |  4 ----
 drivers/scsi/mvsas/mv_init.c          |  1 -
 drivers/scsi/mvsas/mv_sas.c           | 11 -----------
 drivers/scsi/mvsas/mv_sas.h           |  1 -
 drivers/scsi/pm8001/pm8001_init.c     |  1 -
 drivers/scsi/pm8001/pm8001_sas.c      |  8 --------
 drivers/scsi/pm8001/pm8001_sas.h      |  1 -
 include/scsi/libsas.h                 |  1 -
 15 files changed, 72 deletions(-)

diff --git a/Documentation/scsi/libsas.rst b/Documentation/scsi/libsas.rst
index 6589dfefbc02a..305a253d5c3b0 100644
--- a/Documentation/scsi/libsas.rst
+++ b/Documentation/scsi/libsas.rst
@@ -207,7 +207,6 @@ Management Functions (TMFs) described in SAM::
 	/* Task Management Functions. Must be called from process context. */
 	int (*lldd_abort_task)(struct sas_task *);
 	int (*lldd_abort_task_set)(struct domain_device *, u8 *lun);
-	int (*lldd_clear_aca)(struct domain_device *, u8 *lun);
 	int (*lldd_clear_task_set)(struct domain_device *, u8 *lun);
 	int (*lldd_I_T_nexus_reset)(struct domain_device *);
 	int (*lldd_lu_reset)(struct domain_device *, u8 *lun);
@@ -262,7 +261,6 @@ can look like this (called last thing from probe())
 
 	    my_ha->sas_ha.lldd_abort_task     = my_abort_task;
 	    my_ha->sas_ha.lldd_abort_task_set = my_abort_task_set;
-	    my_ha->sas_ha.lldd_clear_aca      = my_clear_aca;
 	    my_ha->sas_ha.lldd_clear_task_set = my_clear_task_set;
 	    my_ha->sas_ha.lldd_I_T_nexus_reset= NULL; (2)
 	    my_ha->sas_ha.lldd_lu_reset       = my_lu_reset;
diff --git a/drivers/scsi/aic94xx/aic94xx.h b/drivers/scsi/aic94xx/aic94xx.h
index 8f24180646c27..f595bc2ee45e7 100644
--- a/drivers/scsi/aic94xx/aic94xx.h
+++ b/drivers/scsi/aic94xx/aic94xx.h
@@ -60,7 +60,6 @@ void asd_set_dmamode(struct domain_device *dev);
 /* ---------- TMFs ---------- */
 int  asd_abort_task(struct sas_task *);
 int  asd_abort_task_set(struct domain_device *, u8 *lun);
-int  asd_clear_aca(struct domain_device *, u8 *lun);
 int  asd_clear_task_set(struct domain_device *, u8 *lun);
 int  asd_lu_reset(struct domain_device *, u8 *lun);
 int  asd_I_T_nexus_reset(struct domain_device *dev);
diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index 7a78606598c4b..954d0c5ae2e28 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -960,7 +960,6 @@ static struct sas_domain_function_template aic94xx_transport_functions = {
 
 	.lldd_abort_task	= asd_abort_task,
 	.lldd_abort_task_set	= asd_abort_task_set,
-	.lldd_clear_aca		= asd_clear_aca,
 	.lldd_clear_task_set	= asd_clear_task_set,
 	.lldd_I_T_nexus_reset	= asd_I_T_nexus_reset,
 	.lldd_lu_reset		= asd_lu_reset,
diff --git a/drivers/scsi/aic94xx/aic94xx_tmf.c b/drivers/scsi/aic94xx/aic94xx_tmf.c
index 0eb6e206a2b48..0ff0d6506ccf2 100644
--- a/drivers/scsi/aic94xx/aic94xx_tmf.c
+++ b/drivers/scsi/aic94xx/aic94xx_tmf.c
@@ -644,15 +644,6 @@ int asd_abort_task_set(struct domain_device *dev, u8 *lun)
 	return res;
 }
 
-int asd_clear_aca(struct domain_device *dev, u8 *lun)
-{
-	int res = asd_initiate_ssp_tmf(dev, lun, TMF_CLEAR_ACA, 0);
-
-	if (res == TMF_RESP_FUNC_COMPLETE)
-		asd_clear_nexus_I_T_L(dev, lun);
-	return res;
-}
-
 int asd_clear_task_set(struct domain_device *dev, u8 *lun)
 {
 	int res = asd_initiate_ssp_tmf(dev, lun, TMF_CLEAR_TASK_SET, 0);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 9663492e566d1..bb95153bd22f0 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1753,17 +1753,6 @@ static int hisi_sas_abort_task_set(struct domain_device *device, u8 *lun)
 	return rc;
 }
 
-static int hisi_sas_clear_aca(struct domain_device *device, u8 *lun)
-{
-	struct hisi_sas_tmf_task tmf_task;
-	int rc;
-
-	tmf_task.tmf = TMF_CLEAR_ACA;
-	rc = hisi_sas_debug_issue_ssp_tmf(device, lun, &tmf_task);
-
-	return rc;
-}
-
 #define I_T_NEXUS_RESET_PHYUP_TIMEOUT  (2 * HZ)
 
 static int hisi_sas_debug_I_T_nexus_reset(struct domain_device *device)
@@ -2275,7 +2264,6 @@ static struct sas_domain_function_template hisi_sas_transport_ops = {
 	.lldd_control_phy	= hisi_sas_control_phy,
 	.lldd_abort_task	= hisi_sas_abort_task,
 	.lldd_abort_task_set	= hisi_sas_abort_task_set,
-	.lldd_clear_aca		= hisi_sas_clear_aca,
 	.lldd_I_T_nexus_reset	= hisi_sas_I_T_nexus_reset,
 	.lldd_lu_reset		= hisi_sas_lu_reset,
 	.lldd_query_task	= hisi_sas_query_task,
diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index ffd33e5decae8..bd73f6925a9dc 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -191,7 +191,6 @@ static struct sas_domain_function_template isci_transport_ops  = {
 	/* Task Management Functions. Must be called from process context. */
 	.lldd_abort_task	= isci_task_abort_task,
 	.lldd_abort_task_set	= isci_task_abort_task_set,
-	.lldd_clear_aca		= isci_task_clear_aca,
 	.lldd_clear_task_set	= isci_task_clear_task_set,
 	.lldd_I_T_nexus_reset	= isci_task_I_T_nexus_reset,
 	.lldd_lu_reset		= isci_task_lu_reset,
diff --git a/drivers/scsi/isci/task.c b/drivers/scsi/isci/task.c
index 3fd88d72a0c01..403bfee34d84d 100644
--- a/drivers/scsi/isci/task.c
+++ b/drivers/scsi/isci/task.c
@@ -625,24 +625,6 @@ int isci_task_abort_task_set(
 }
 
 
-/**
- * isci_task_clear_aca() - This function is one of the SAS Domain Template
- *    functions. This is one of the Task Management functoins called by libsas.
- * @d_device: This parameter specifies the domain device associated with this
- *    request.
- * @lun: This parameter specifies the lun	 associated with this request.
- *
- * status, zero indicates success.
- */
-int isci_task_clear_aca(
-	struct domain_device *d_device,
-	u8 *lun)
-{
-	return TMF_RESP_FUNC_FAILED;
-}
-
-
-
 /**
  * isci_task_clear_task_set() - This function is one of the SAS Domain Template
  *    functions. This is one of the Task Management functoins called by libsas.
diff --git a/drivers/scsi/isci/task.h b/drivers/scsi/isci/task.h
index 8f4531f22ac29..5939cb175a20f 100644
--- a/drivers/scsi/isci/task.h
+++ b/drivers/scsi/isci/task.h
@@ -140,10 +140,6 @@ int isci_task_abort_task_set(
 	struct domain_device *d_device,
 	u8 *lun);
 
-int isci_task_clear_aca(
-	struct domain_device *d_device,
-	u8 *lun);
-
 int isci_task_clear_task_set(
 	struct domain_device *d_device,
 	u8 *lun);
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index f6f8ca3c8c7f5..1c98662db080f 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -64,7 +64,6 @@ static struct sas_domain_function_template mvs_transport_ops = {
 
 	.lldd_abort_task	= mvs_abort_task,
 	.lldd_abort_task_set    = mvs_abort_task_set,
-	.lldd_clear_aca         = mvs_clear_aca,
 	.lldd_clear_task_set    = mvs_clear_task_set,
 	.lldd_I_T_nexus_reset	= mvs_I_T_nexus_reset,
 	.lldd_lu_reset 		= mvs_lu_reset,
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index 31d1ea5a5dd2b..107f1993932bf 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -1548,17 +1548,6 @@ int mvs_abort_task_set(struct domain_device *dev, u8 *lun)
 	return rc;
 }
 
-int mvs_clear_aca(struct domain_device *dev, u8 *lun)
-{
-	int rc = TMF_RESP_FUNC_FAILED;
-	struct mvs_tmf_task tmf_task;
-
-	tmf_task.tmf = TMF_CLEAR_ACA;
-	rc = mvs_debug_issue_ssp_tmf(dev, lun, &tmf_task);
-
-	return rc;
-}
-
 int mvs_clear_task_set(struct domain_device *dev, u8 *lun)
 {
 	int rc = TMF_RESP_FUNC_FAILED;
diff --git a/drivers/scsi/mvsas/mv_sas.h b/drivers/scsi/mvsas/mv_sas.h
index 8ff976c9967e1..fa654c73beeee 100644
--- a/drivers/scsi/mvsas/mv_sas.h
+++ b/drivers/scsi/mvsas/mv_sas.h
@@ -441,7 +441,6 @@ int mvs_scan_finished(struct Scsi_Host *shost, unsigned long time);
 int mvs_queue_command(struct sas_task *task, gfp_t gfp_flags);
 int mvs_abort_task(struct sas_task *task);
 int mvs_abort_task_set(struct domain_device *dev, u8 *lun);
-int mvs_clear_aca(struct domain_device *dev, u8 *lun);
 int mvs_clear_task_set(struct domain_device *dev, u8 * lun);
 void mvs_port_formed(struct asd_sas_phy *sas_phy);
 void mvs_port_deformed(struct asd_sas_phy *sas_phy);
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index a54460fe86300..0659ee9aafce7 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -123,7 +123,6 @@ static struct sas_domain_function_template pm8001_transport_ops = {
 
 	.lldd_abort_task	= pm8001_abort_task,
 	.lldd_abort_task_set	= pm8001_abort_task_set,
-	.lldd_clear_aca		= pm8001_clear_aca,
 	.lldd_clear_task_set	= pm8001_clear_task_set,
 	.lldd_I_T_nexus_reset   = pm8001_I_T_nexus_reset,
 	.lldd_lu_reset		= pm8001_lu_reset,
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 5fb08acbc0e5e..93fe1bec25e21 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -1341,14 +1341,6 @@ int pm8001_abort_task_set(struct domain_device *dev, u8 *lun)
 	return pm8001_issue_ssp_tmf(dev, lun, &tmf_task);
 }
 
-int pm8001_clear_aca(struct domain_device *dev, u8 *lun)
-{
-	struct pm8001_tmf_task tmf_task;
-
-	tmf_task.tmf = TMF_CLEAR_ACA;
-	return pm8001_issue_ssp_tmf(dev, lun, &tmf_task);
-}
-
 int pm8001_clear_task_set(struct domain_device *dev, u8 *lun)
 {
 	struct pm8001_tmf_task tmf_task;
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index f40a41f450d9b..52c62a29df18a 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -645,7 +645,6 @@ int pm8001_scan_finished(struct Scsi_Host *shost, unsigned long time);
 int pm8001_queue_command(struct sas_task *task, gfp_t gfp_flags);
 int pm8001_abort_task(struct sas_task *task);
 int pm8001_abort_task_set(struct domain_device *dev, u8 *lun);
-int pm8001_clear_aca(struct domain_device *dev, u8 *lun);
 int pm8001_clear_task_set(struct domain_device *dev, u8 *lun);
 int pm8001_dev_found(struct domain_device *dev);
 void pm8001_dev_gone(struct domain_device *dev);
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 6fe125a71b608..22c54f21206d4 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -636,7 +636,6 @@ struct sas_domain_function_template {
 	/* Task Management Functions. Must be called from process context. */
 	int (*lldd_abort_task)(struct sas_task *);
 	int (*lldd_abort_task_set)(struct domain_device *, u8 *lun);
-	int (*lldd_clear_aca)(struct domain_device *, u8 *lun);
 	int (*lldd_clear_task_set)(struct domain_device *, u8 *lun);
 	int (*lldd_I_T_nexus_reset)(struct domain_device *);
 	int (*lldd_ata_check_ready)(struct domain_device *);
-- 
2.39.5




