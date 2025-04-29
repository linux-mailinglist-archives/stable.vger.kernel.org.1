Return-Path: <stable+bounces-138332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028B0AA17E1
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A555A1F84
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A50C148;
	Tue, 29 Apr 2025 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DxfMY7li"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BBB21ABC1;
	Tue, 29 Apr 2025 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948896; cv=none; b=H3wtWvNVub2IoqbzEnYWPZWU3QntOCT5vtaQ11JRymISL0DuhXtkyra932UsoGgojG7HuzWKcY05djj/WdLq2JBwgmIZF0jjHa8YuEEVm0CQbZdGuoNooDZw9vm8K9eOvzd3IWuB9oR6ggNNXjojJNsWMrScRw7ylSWdb89mbKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948896; c=relaxed/simple;
	bh=/DUlGtFfUDIZn31U31xxGqKyE0STQufM+47vNMq9DDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qe2ZHC6H109iB1RiW5g2AP8G+pYLzQN6wFLHk5q2YrggVZPooQf1hmsIKhy5w3+T2wn6EMEg2C+GQKbkJ2JH+4i4yyofLtcbdZiPHRnYqhqla23I7cS+GljqaO1MI84n1FtI70VQ1TcGh0dr+cHtZHTlX3gyS7pd2uUJOMWT200=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DxfMY7li; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C0CC4CEE3;
	Tue, 29 Apr 2025 17:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745948895;
	bh=/DUlGtFfUDIZn31U31xxGqKyE0STQufM+47vNMq9DDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DxfMY7li79AAhwyzxx2vgQXMeCRPVHjJ9TnSkZC3h7jm3g6BM81uqHWXvkgaxiuEZ
	 g1SYIFIBUl3uzba+wokJdfR4w6VvrtbceIa8zf9Dus3bU4eP4EFXXJXqHqSNx5yrK1
	 r224kMe5XqD8gLLeYmhII99FCKLZBplWl2FgPXWY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yihang Li <liyihang6@hisilicon.com>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	John Garry <john.garry@huawei.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 125/373] scsi: libsas: Add struct sas_tmf_task
Date: Tue, 29 Apr 2025 18:40:02 +0200
Message-ID: <20250429161128.318581987@linuxfoundation.org>
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

[ Upstream commit bbfe82cdbaf84e6622ceb6f3447c8c4bb7dde7ab ]

Some of the LLDDs which use libsas have their own definition of a struct
to hold TMF info, so add a common struct for libsas.

Also add an interim force phy id field for hisi_sas driver, which will be
removed once the STP "TMF" code is factored out.

Even though some LLDDs (pm8001) use a u32 for the tag, u16 will be adequate,
as that named driver only uses tags in range [0, 1024).

Link: https://lore.kernel.org/r/1645112566-115804-8-git-send-email-john.garry@huawei.com
Tested-by: Yihang Li <liyihang6@hisilicon.com>
Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 8aa580cd9284 ("scsi: hisi_sas: Enable force phy when SATA disk directly connected")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  9 +--------
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 22 +++++++++++-----------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  2 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  4 ++--
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  2 +-
 drivers/scsi/mvsas/mv_defs.h           |  5 -----
 drivers/scsi/mvsas/mv_sas.c            | 20 ++++++++++----------
 drivers/scsi/pm8001/pm8001_hwi.c       |  4 ++--
 drivers/scsi/pm8001/pm8001_sas.c       | 18 +++++++++---------
 drivers/scsi/pm8001/pm8001_sas.h       | 10 +++-------
 include/scsi/libsas.h                  |  9 +++++++++
 11 files changed, 49 insertions(+), 56 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 39da9f1645135..081b4e22a502f 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -234,13 +234,6 @@ struct hisi_sas_device {
 	spinlock_t lock; /* For protecting slots */
 };
 
-struct hisi_sas_tmf_task {
-	int force_phy;
-	int phy_id;
-	u8 tmf;
-	u16 tag_of_task_to_be_managed;
-};
-
 struct hisi_sas_slot {
 	struct list_head entry;
 	struct list_head delivery;
@@ -259,7 +252,7 @@ struct hisi_sas_slot {
 	dma_addr_t cmd_hdr_dma;
 	struct timer_list internal_abort_timer;
 	bool is_internal;
-	struct hisi_sas_tmf_task *tmf;
+	struct sas_tmf_task *tmf;
 	/* Do not reorder/change members after here */
 	void	*buf;
 	dma_addr_t buf_dma;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index bb95153bd22f0..0ca80e00835cb 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -11,7 +11,7 @@
 	((!dev) || (dev->dev_type == SAS_PHY_UNUSED))
 
 static int hisi_sas_debug_issue_ssp_tmf(struct domain_device *device,
-				u8 *lun, struct hisi_sas_tmf_task *tmf);
+				u8 *lun, struct sas_tmf_task *tmf);
 static int
 hisi_sas_internal_task_abort(struct hisi_hba *hisi_hba,
 			     struct domain_device *device,
@@ -477,7 +477,7 @@ void hisi_sas_task_deliver(struct hisi_hba *hisi_hba,
 }
 
 static int hisi_sas_task_exec(struct sas_task *task, gfp_t gfp_flags,
-			      struct hisi_sas_tmf_task *tmf)
+			      struct sas_tmf_task *tmf)
 {
 	int n_elem = 0, n_elem_dif = 0, n_elem_req = 0;
 	struct domain_device *device = task->dev;
@@ -691,7 +691,7 @@ static int hisi_sas_init_device(struct domain_device *device)
 {
 	int rc = TMF_RESP_FUNC_COMPLETE;
 	struct scsi_lun lun;
-	struct hisi_sas_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	int retry = HISI_SAS_DISK_RECOVER_CNT;
 	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
 	struct device *dev = hisi_hba->dev;
@@ -1195,7 +1195,7 @@ static void hisi_sas_tmf_timedout(struct timer_list *t)
 #define INTERNAL_ABORT_TIMEOUT		(6 * HZ)
 static int hisi_sas_exec_internal_tmf_task(struct domain_device *device,
 					   void *parameter, u32 para_len,
-					   struct hisi_sas_tmf_task *tmf)
+					   struct sas_tmf_task *tmf)
 {
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
 	struct hisi_hba *hisi_hba = sas_dev->hisi_hba;
@@ -1330,7 +1330,7 @@ static int hisi_sas_softreset_ata_disk(struct domain_device *device)
 	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
 	struct device *dev = hisi_hba->dev;
 	int s = sizeof(struct host_to_dev_fis);
-	struct hisi_sas_tmf_task tmf = {};
+	struct sas_tmf_task tmf = {};
 
 	ata_for_each_link(link, ap, EDGE) {
 		int pmp = sata_srst_pmp(link);
@@ -1364,7 +1364,7 @@ static int hisi_sas_softreset_ata_disk(struct domain_device *device)
 }
 
 static int hisi_sas_debug_issue_ssp_tmf(struct domain_device *device,
-				u8 *lun, struct hisi_sas_tmf_task *tmf)
+				u8 *lun, struct sas_tmf_task *tmf)
 {
 	struct sas_ssp_task ssp_task;
 
@@ -1469,7 +1469,7 @@ static void hisi_sas_send_ata_reset_each_phy(struct hisi_hba *hisi_hba,
 					     struct asd_sas_port *sas_port,
 					     struct domain_device *device)
 {
-	struct hisi_sas_tmf_task tmf_task = { .force_phy = 1 };
+	struct sas_tmf_task tmf_task = { .force_phy = 1 };
 	struct ata_port *ap = device->sata_dev.ap;
 	struct device *dev = hisi_hba->dev;
 	int s = sizeof(struct host_to_dev_fis);
@@ -1624,7 +1624,7 @@ static int hisi_sas_controller_reset(struct hisi_hba *hisi_hba)
 static int hisi_sas_abort_task(struct sas_task *task)
 {
 	struct scsi_lun lun;
-	struct hisi_sas_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	struct domain_device *device = task->dev;
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
 	struct hisi_hba *hisi_hba;
@@ -1733,7 +1733,7 @@ static int hisi_sas_abort_task_set(struct domain_device *device, u8 *lun)
 {
 	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
 	struct device *dev = hisi_hba->dev;
-	struct hisi_sas_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	int rc;
 
 	rc = hisi_sas_internal_task_abort(hisi_hba, device,
@@ -1868,7 +1868,7 @@ static int hisi_sas_lu_reset(struct domain_device *device, u8 *lun)
 			hisi_sas_release_task(hisi_hba, device);
 		sas_put_local_phy(phy);
 	} else {
-		struct hisi_sas_tmf_task tmf_task = { .tmf =  TMF_LU_RESET };
+		struct sas_tmf_task tmf_task = { .tmf =  TMF_LU_RESET };
 
 		rc = hisi_sas_debug_issue_ssp_tmf(device, lun, &tmf_task);
 		if (rc == TMF_RESP_FUNC_COMPLETE)
@@ -1926,7 +1926,7 @@ static int hisi_sas_clear_nexus_ha(struct sas_ha_struct *sas_ha)
 static int hisi_sas_query_task(struct sas_task *task)
 {
 	struct scsi_lun lun;
-	struct hisi_sas_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	int rc = TMF_RESP_FUNC_FAILED;
 
 	if (task->lldd_task && task->task_proto & SAS_PROTOCOL_SSP) {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 862f4e8b7eb58..76756dd318d75 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -958,7 +958,7 @@ static void prep_ssp_v1_hw(struct hisi_hba *hisi_hba,
 	struct hisi_sas_port *port = slot->port;
 	struct sas_ssp_task *ssp_task = &task->ssp_task;
 	struct scsi_cmnd *scsi_cmnd = ssp_task->cmd;
-	struct hisi_sas_tmf_task *tmf = slot->tmf;
+	struct sas_tmf_task *tmf = slot->tmf;
 	int has_data = 0, priority = !!tmf;
 	u8 *buf_cmd, fburst = 0;
 	u32 dw1, dw2;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index a6d89a1495461..9a8009fc3f206 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -1742,7 +1742,7 @@ static void prep_ssp_v2_hw(struct hisi_hba *hisi_hba,
 	struct hisi_sas_port *port = slot->port;
 	struct sas_ssp_task *ssp_task = &task->ssp_task;
 	struct scsi_cmnd *scsi_cmnd = ssp_task->cmd;
-	struct hisi_sas_tmf_task *tmf = slot->tmf;
+	struct sas_tmf_task *tmf = slot->tmf;
 	int has_data = 0, priority = !!tmf;
 	u8 *buf_cmd;
 	u32 dw1 = 0, dw2 = 0;
@@ -2499,7 +2499,7 @@ static void prep_ata_v2_hw(struct hisi_hba *hisi_hba,
 	struct hisi_sas_cmd_hdr *hdr = slot->cmd_hdr;
 	struct asd_sas_port *sas_port = device->port;
 	struct hisi_sas_port *port = to_hisi_sas_port(sas_port);
-	struct hisi_sas_tmf_task *tmf = slot->tmf;
+	struct sas_tmf_task *tmf = slot->tmf;
 	u8 *buf_cmd;
 	int has_data = 0, hdr_tag = 0;
 	u32 dw0, dw1 = 0, dw2 = 0;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 3f3d768548c57..2fce1c0a54635 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -1223,7 +1223,7 @@ static void prep_ssp_v3_hw(struct hisi_hba *hisi_hba,
 	struct hisi_sas_port *port = slot->port;
 	struct sas_ssp_task *ssp_task = &task->ssp_task;
 	struct scsi_cmnd *scsi_cmnd = ssp_task->cmd;
-	struct hisi_sas_tmf_task *tmf = slot->tmf;
+	struct sas_tmf_task *tmf = slot->tmf;
 	int has_data = 0, priority = !!tmf;
 	unsigned char prot_op;
 	u8 *buf_cmd;
diff --git a/drivers/scsi/mvsas/mv_defs.h b/drivers/scsi/mvsas/mv_defs.h
index 199ab49aa047f..7123a2efbf583 100644
--- a/drivers/scsi/mvsas/mv_defs.h
+++ b/drivers/scsi/mvsas/mv_defs.h
@@ -486,9 +486,4 @@ enum datapres_field {
 	SENSE_DATA	= 2,
 };
 
-/* define task management IU */
-struct mvs_tmf_task{
-	u8 tmf;
-	u16 tag_of_task_to_be_managed;
-};
 #endif
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index 107f1993932bf..04d3710c683fe 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -551,7 +551,7 @@ static int mvs_task_prep_ata(struct mvs_info *mvi,
 
 static int mvs_task_prep_ssp(struct mvs_info *mvi,
 			     struct mvs_task_exec_info *tei, int is_tmf,
-			     struct mvs_tmf_task *tmf)
+			     struct sas_tmf_task *tmf)
 {
 	struct sas_task *task = tei->task;
 	struct mvs_cmd_hdr *hdr = tei->hdr;
@@ -691,7 +691,7 @@ static int mvs_task_prep_ssp(struct mvs_info *mvi,
 
 #define	DEV_IS_GONE(mvi_dev)	((!mvi_dev || (mvi_dev->dev_type == SAS_PHY_UNUSED)))
 static int mvs_task_prep(struct sas_task *task, struct mvs_info *mvi, int is_tmf,
-				struct mvs_tmf_task *tmf, int *pass)
+				struct sas_tmf_task *tmf, int *pass)
 {
 	struct domain_device *dev = task->dev;
 	struct mvs_device *mvi_dev = dev->lldd_dev;
@@ -837,7 +837,7 @@ static int mvs_task_prep(struct sas_task *task, struct mvs_info *mvi, int is_tmf
 
 static int mvs_task_exec(struct sas_task *task, gfp_t gfp_flags,
 				struct completion *completion, int is_tmf,
-				struct mvs_tmf_task *tmf)
+				struct sas_tmf_task *tmf)
 {
 	struct mvs_info *mvi = NULL;
 	u32 rc = 0;
@@ -1275,7 +1275,7 @@ static void mvs_tmf_timedout(struct timer_list *t)
 
 #define MVS_TASK_TIMEOUT 20
 static int mvs_exec_internal_tmf_task(struct domain_device *dev,
-			void *parameter, u32 para_len, struct mvs_tmf_task *tmf)
+			void *parameter, u32 para_len, struct sas_tmf_task *tmf)
 {
 	int res, retry;
 	struct sas_task *task = NULL;
@@ -1350,7 +1350,7 @@ static int mvs_exec_internal_tmf_task(struct domain_device *dev,
 }
 
 static int mvs_debug_issue_ssp_tmf(struct domain_device *dev,
-				u8 *lun, struct mvs_tmf_task *tmf)
+				u8 *lun, struct sas_tmf_task *tmf)
 {
 	struct sas_ssp_task ssp_task;
 	if (!(dev->tproto & SAS_PROTOCOL_SSP))
@@ -1382,7 +1382,7 @@ int mvs_lu_reset(struct domain_device *dev, u8 *lun)
 {
 	unsigned long flags;
 	int rc = TMF_RESP_FUNC_FAILED;
-	struct mvs_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	struct mvs_device * mvi_dev = dev->lldd_dev;
 	struct mvs_info *mvi = mvi_dev->mvi_info;
 
@@ -1426,7 +1426,7 @@ int mvs_query_task(struct sas_task *task)
 {
 	u32 tag;
 	struct scsi_lun lun;
-	struct mvs_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	int rc = TMF_RESP_FUNC_FAILED;
 
 	if (task->lldd_task && task->task_proto & SAS_PROTOCOL_SSP) {
@@ -1463,7 +1463,7 @@ int mvs_query_task(struct sas_task *task)
 int mvs_abort_task(struct sas_task *task)
 {
 	struct scsi_lun lun;
-	struct mvs_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	struct domain_device *dev = task->dev;
 	struct mvs_device *mvi_dev = (struct mvs_device *)dev->lldd_dev;
 	struct mvs_info *mvi;
@@ -1540,7 +1540,7 @@ int mvs_abort_task(struct sas_task *task)
 int mvs_abort_task_set(struct domain_device *dev, u8 *lun)
 {
 	int rc;
-	struct mvs_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 
 	tmf_task.tmf = TMF_ABORT_TASK_SET;
 	rc = mvs_debug_issue_ssp_tmf(dev, lun, &tmf_task);
@@ -1551,7 +1551,7 @@ int mvs_abort_task_set(struct domain_device *dev, u8 *lun)
 int mvs_clear_task_set(struct domain_device *dev, u8 *lun)
 {
 	int rc = TMF_RESP_FUNC_FAILED;
-	struct mvs_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 
 	tmf_task.tmf = TMF_CLEAR_TASK_SET;
 	rc = mvs_debug_issue_ssp_tmf(dev, lun, &tmf_task);
diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index 352705e023c83..537b762a2b834 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -4624,7 +4624,7 @@ int pm8001_chip_abort_task(struct pm8001_hba_info *pm8001_ha,
  * @tmf: task management function.
  */
 int pm8001_chip_ssp_tm_req(struct pm8001_hba_info *pm8001_ha,
-	struct pm8001_ccb_info *ccb, struct pm8001_tmf_task *tmf)
+	struct pm8001_ccb_info *ccb, struct sas_tmf_task *tmf)
 {
 	struct sas_task *task = ccb->task;
 	struct domain_device *dev = task->dev;
@@ -4636,7 +4636,7 @@ int pm8001_chip_ssp_tm_req(struct pm8001_hba_info *pm8001_ha,
 
 	memset(&sspTMCmd, 0, sizeof(sspTMCmd));
 	sspTMCmd.device_id = cpu_to_le32(pm8001_dev->device_id);
-	sspTMCmd.relate_tag = cpu_to_le32(tmf->tag_of_task_to_be_managed);
+	sspTMCmd.relate_tag = cpu_to_le32((u32)tmf->tag_of_task_to_be_managed);
 	sspTMCmd.tmf = cpu_to_le32(tmf->tmf);
 	memcpy(sspTMCmd.lun, task->ssp_task.LUN, 8);
 	sspTMCmd.tag = cpu_to_le32(ccb->ccb_tag);
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 93fe1bec25e21..2c003c17fe6aa 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -335,7 +335,7 @@ static int pm8001_task_prep_ata(struct pm8001_hba_info *pm8001_ha,
   * @tmf: the task management IU
   */
 static int pm8001_task_prep_ssp_tm(struct pm8001_hba_info *pm8001_ha,
-	struct pm8001_ccb_info *ccb, struct pm8001_tmf_task *tmf)
+	struct pm8001_ccb_info *ccb, struct sas_tmf_task *tmf)
 {
 	return PM8001_CHIP_DISP->ssp_tm_req(pm8001_ha, ccb, tmf);
 }
@@ -378,7 +378,7 @@ static int sas_find_local_port_id(struct domain_device *dev)
   * @tmf: the task management IU
   */
 static int pm8001_task_exec(struct sas_task *task,
-	gfp_t gfp_flags, int is_tmf, struct pm8001_tmf_task *tmf)
+	gfp_t gfp_flags, int is_tmf, struct sas_tmf_task *tmf)
 {
 	struct domain_device *dev = task->dev;
 	struct pm8001_hba_info *pm8001_ha;
@@ -715,7 +715,7 @@ static void pm8001_tmf_timedout(struct timer_list *t)
   * this function, note it is also with the task execute interface.
   */
 static int pm8001_exec_internal_tmf_task(struct domain_device *dev,
-	void *parameter, u32 para_len, struct pm8001_tmf_task *tmf)
+	void *parameter, u32 para_len, struct sas_tmf_task *tmf)
 {
 	int res, retry;
 	struct sas_task *task = NULL;
@@ -906,7 +906,7 @@ void pm8001_dev_gone(struct domain_device *dev)
 }
 
 static int pm8001_issue_ssp_tmf(struct domain_device *dev,
-	u8 *lun, struct pm8001_tmf_task *tmf)
+	u8 *lun, struct sas_tmf_task *tmf)
 {
 	struct sas_ssp_task ssp_task;
 	if (!(dev->tproto & SAS_PROTOCOL_SSP))
@@ -1108,7 +1108,7 @@ int pm8001_I_T_nexus_event_handler(struct domain_device *dev)
 int pm8001_lu_reset(struct domain_device *dev, u8 *lun)
 {
 	int rc = TMF_RESP_FUNC_FAILED;
-	struct pm8001_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	struct pm8001_device *pm8001_dev = dev->lldd_dev;
 	struct pm8001_hba_info *pm8001_ha = pm8001_find_ha_by_dev(dev);
 	DECLARE_COMPLETION_ONSTACK(completion_setstate);
@@ -1137,7 +1137,7 @@ int pm8001_query_task(struct sas_task *task)
 {
 	u32 tag = 0xdeadbeef;
 	struct scsi_lun lun;
-	struct pm8001_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	int rc = TMF_RESP_FUNC_FAILED;
 	if (unlikely(!task || !task->lldd_task || !task->dev))
 		return rc;
@@ -1186,7 +1186,7 @@ int pm8001_abort_task(struct sas_task *task)
 	struct pm8001_hba_info *pm8001_ha;
 	struct scsi_lun lun;
 	struct pm8001_device *pm8001_dev;
-	struct pm8001_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	int rc = TMF_RESP_FUNC_FAILED, ret;
 	u32 phy_id;
 	struct sas_task_slow slow_task;
@@ -1335,7 +1335,7 @@ int pm8001_abort_task(struct sas_task *task)
 
 int pm8001_abort_task_set(struct domain_device *dev, u8 *lun)
 {
-	struct pm8001_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 
 	tmf_task.tmf = TMF_ABORT_TASK_SET;
 	return pm8001_issue_ssp_tmf(dev, lun, &tmf_task);
@@ -1343,7 +1343,7 @@ int pm8001_abort_task_set(struct domain_device *dev, u8 *lun)
 
 int pm8001_clear_task_set(struct domain_device *dev, u8 *lun)
 {
-	struct pm8001_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	struct pm8001_device *pm8001_dev = dev->lldd_dev;
 	struct pm8001_hba_info *pm8001_ha = pm8001_find_ha_by_dev(dev);
 
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index 52c62a29df18a..75864b47921aa 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -99,11 +99,7 @@ extern const struct pm8001_dispatch pm8001_80xx_dispatch;
 struct pm8001_hba_info;
 struct pm8001_ccb_info;
 struct pm8001_device;
-/* define task management IU */
-struct pm8001_tmf_task {
-	u8	tmf;
-	u32	tag_of_task_to_be_managed;
-};
+
 struct pm8001_ioctl_payload {
 	u32	signature;
 	u16	major_function;
@@ -203,7 +199,7 @@ struct pm8001_dispatch {
 		struct pm8001_device *pm8001_dev, u8 flag, u32 task_tag,
 		u32 cmd_tag);
 	int (*ssp_tm_req)(struct pm8001_hba_info *pm8001_ha,
-		struct pm8001_ccb_info *ccb, struct pm8001_tmf_task *tmf);
+		struct pm8001_ccb_info *ccb, struct sas_tmf_task *tmf);
 	int (*get_nvmd_req)(struct pm8001_hba_info *pm8001_ha, void *payload);
 	int (*set_nvmd_req)(struct pm8001_hba_info *pm8001_ha, void *payload);
 	int (*fw_flash_update_req)(struct pm8001_hba_info *pm8001_ha,
@@ -682,7 +678,7 @@ int pm8001_chip_set_nvmd_req(struct pm8001_hba_info *pm8001_ha, void *payload);
 int pm8001_chip_get_nvmd_req(struct pm8001_hba_info *pm8001_ha, void *payload);
 int pm8001_chip_ssp_tm_req(struct pm8001_hba_info *pm8001_ha,
 				struct pm8001_ccb_info *ccb,
-				struct pm8001_tmf_task *tmf);
+				struct sas_tmf_task *tmf);
 int pm8001_chip_abort_task(struct pm8001_hba_info *pm8001_ha,
 				struct pm8001_device *pm8001_dev,
 				u8 flag, u32 task_tag, u32 cmd_tag);
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 22c54f21206d4..306005b3b60f3 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -576,6 +576,15 @@ struct sas_ssp_task {
 	struct scsi_cmnd *cmd;
 };
 
+struct sas_tmf_task {
+	u8 tmf;
+	u16 tag_of_task_to_be_managed;
+
+	/* Temp */
+	int force_phy;
+	int phy_id;
+};
+
 struct sas_task {
 	struct domain_device *dev;
 
-- 
2.39.5




