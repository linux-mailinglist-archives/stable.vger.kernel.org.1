Return-Path: <stable+bounces-14670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 297E1838210
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B005B1F2448D
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB9257892;
	Tue, 23 Jan 2024 01:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zVRSg6NS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06D75733D;
	Tue, 23 Jan 2024 01:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974053; cv=none; b=r7lG52DGvHRKIqx0TkkR3KELKa6wymkm485YxIozfG5Z/N7xBuH/Z2z46Gso6WZ6PjVNfpWJU5gxOgvCVSPZxrzVGpMeXaOs5IvOKVDcIXZYne2zLhr/ODAVVjVMCjYao6Gs9fEHzn3LmZE83BiB648BNa6uM16okf4yGPuc/Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974053; c=relaxed/simple;
	bh=yWp6cYTcYo/ECvSOA0HtX7TPBo+a6eoH8Vzzo79QY4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGjL3K+wB6hG4ulQ3YkgsfhcwEiGdm0Um6TdAFHU3TIelTFm1/7lk9zeV0Q9+1OIJfgJ2vmzkqWoVhx9Ciux20ef2bnrVUIKkwUml1sawrpX3cLfKpWkXyToQ3KdbkINPc593Aq5rvdbm8lLgb7VAfKFSkx11H4B+hrBfCpjiv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zVRSg6NS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EE0C43390;
	Tue, 23 Jan 2024 01:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974053;
	bh=yWp6cYTcYo/ECvSOA0HtX7TPBo+a6eoH8Vzzo79QY4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zVRSg6NSWk/9NbwT5lmfuRr9Mbn2jsrOGW0+1u7sxUt9dD/oEv5lckEsP6GE7vngq
	 ueXZkiDkAvHApIr4/W0vmJnPYwYdZaZrkMlcQpqb/BJ3QA5OCpOfP03z/4SEC5PBQA
	 fIn3lQiF2gQe1drklJq609lrrowM4VmcZXopn7rY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luo Jiaxing <luojiaxing@huawei.com>,
	John Garry <john.garry@huawei.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 142/374] scsi: hisi_sas: Rename HISI_SAS_{RESET -> RESETTING}_BIT
Date: Mon, 22 Jan 2024 15:56:38 -0800
Message-ID: <20240122235749.568859871@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
References: <20240122235744.598274724@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luo Jiaxing <luojiaxing@huawei.com>

[ Upstream commit b5a9fa20e3bf59d89b5f48315a0c0c32963796ed ]

HISI_SAS_RESET_BIT means that the controller is being reset, and so the
name is a bit vague. Rename it to HISI_SAS_RESETTING_BIT.

Link: https://lore.kernel.org/r/1629799260-120116-4-git-send-email-john.garry@huawei.com
Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: d34ee535705e ("scsi: hisi_sas: Replace with standard error code return value")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  2 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 12 ++++++------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  2 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  2 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 10 +++++-----
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 436d174f2194..57be32ba0109 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -35,7 +35,7 @@
 #define HISI_SAS_QUEUE_SLOTS	4096
 #define HISI_SAS_MAX_ITCT_ENTRIES 1024
 #define HISI_SAS_MAX_DEVICES HISI_SAS_MAX_ITCT_ENTRIES
-#define HISI_SAS_RESET_BIT	0
+#define HISI_SAS_RESETTING_BIT	0
 #define HISI_SAS_REJECT_CMD_BIT	1
 #define HISI_SAS_PM_BIT		2
 #define HISI_SAS_HW_FAULT_BIT	3
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 7d93783c09a5..7744594cd3e3 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -724,7 +724,7 @@ static int hisi_sas_init_device(struct domain_device *device)
 		 */
 		local_phy = sas_get_local_phy(device);
 		if (!scsi_is_sas_phy_local(local_phy) &&
-		    !test_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags)) {
+		    !test_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags)) {
 			unsigned long deadline = ata_deadline(jiffies, 20000);
 			struct sata_device *sata_dev = &device->sata_dev;
 			struct ata_host *ata_host = sata_dev->ata_host;
@@ -1072,7 +1072,7 @@ static void hisi_sas_dev_gone(struct domain_device *device)
 		 sas_dev->device_id, sas_dev->dev_type);
 
 	down(&hisi_hba->sem);
-	if (!test_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags)) {
+	if (!test_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags)) {
 		hisi_sas_internal_task_abort(hisi_hba, device,
 					     HISI_SAS_INT_ABT_DEV, 0, true);
 
@@ -1576,7 +1576,7 @@ void hisi_sas_controller_reset_done(struct hisi_hba *hisi_hba)
 	hisi_sas_reset_init_all_devices(hisi_hba);
 	up(&hisi_hba->sem);
 	scsi_unblock_requests(shost);
-	clear_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags);
+	clear_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags);
 
 	hisi_sas_rescan_topology(hisi_hba, hisi_hba->phy_state);
 }
@@ -1587,7 +1587,7 @@ static int hisi_sas_controller_prereset(struct hisi_hba *hisi_hba)
 	if (!hisi_hba->hw->soft_reset)
 		return -1;
 
-	if (test_and_set_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags))
+	if (test_and_set_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags))
 		return -1;
 
 	if (hisi_sas_debugfs_enable && hisi_hba->debugfs_itct[0].itct)
@@ -1611,7 +1611,7 @@ static int hisi_sas_controller_reset(struct hisi_hba *hisi_hba)
 		clear_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
 		up(&hisi_hba->sem);
 		scsi_unblock_requests(shost);
-		clear_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags);
+		clear_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags);
 		return rc;
 	}
 
@@ -2251,7 +2251,7 @@ void hisi_sas_phy_down(struct hisi_hba *hisi_hba, int phy_no, int rdy,
 	} else {
 		struct hisi_sas_port *port  = phy->port;
 
-		if (test_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags) ||
+		if (test_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags) ||
 		    phy->in_reset) {
 			dev_info(dev, "ignore flutter phy%d down\n", phy_no);
 			return;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index afe639994f3d..862f4e8b7eb5 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1422,7 +1422,7 @@ static irqreturn_t int_bcast_v1_hw(int irq, void *p)
 		goto end;
 	}
 
-	if (!test_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags))
+	if (!test_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags))
 		sas_notify_port_event(sas_phy, PORTE_BROADCAST_RCVD,
 				      GFP_ATOMIC);
 
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index c40588ed68a5..a6d89a149546 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -2831,7 +2831,7 @@ static void phy_bcast_v2_hw(int phy_no, struct hisi_hba *hisi_hba)
 	hisi_sas_phy_write32(hisi_hba, phy_no, SL_RX_BCAST_CHK_MSK, 1);
 	bcast_status = hisi_sas_phy_read32(hisi_hba, phy_no, RX_PRIMS_STATUS);
 	if ((bcast_status & RX_BCAST_CHG_MSK) &&
-	    !test_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags))
+	    !test_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags))
 		sas_notify_port_event(sas_phy, PORTE_BROADCAST_RCVD,
 				      GFP_ATOMIC);
 	hisi_sas_phy_write32(hisi_hba, phy_no, CHL_INT0,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index d1c07e7cb60d..2ed787956fa8 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -1622,7 +1622,7 @@ static irqreturn_t phy_bcast_v3_hw(int phy_no, struct hisi_hba *hisi_hba)
 	hisi_sas_phy_write32(hisi_hba, phy_no, SL_RX_BCAST_CHK_MSK, 1);
 	bcast_status = hisi_sas_phy_read32(hisi_hba, phy_no, RX_PRIMS_STATUS);
 	if ((bcast_status & RX_BCAST_CHG_MSK) &&
-	    !test_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags))
+	    !test_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags))
 		sas_notify_port_event(sas_phy, PORTE_BROADCAST_RCVD,
 				      GFP_ATOMIC);
 	hisi_sas_phy_write32(hisi_hba, phy_no, CHL_INT0,
@@ -4935,7 +4935,7 @@ static void hisi_sas_reset_prepare_v3_hw(struct pci_dev *pdev)
 	int rc;
 
 	dev_info(dev, "FLR prepare\n");
-	set_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags);
+	set_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags);
 	hisi_sas_controller_reset_prepare(hisi_hba);
 
 	rc = disable_host_v3_hw(hisi_hba);
@@ -4981,7 +4981,7 @@ static int _suspend_v3_hw(struct device *device)
 		return -ENODEV;
 	}
 
-	if (test_and_set_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags))
+	if (test_and_set_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags))
 		return -1;
 
 	scsi_block_requests(shost);
@@ -4992,7 +4992,7 @@ static int _suspend_v3_hw(struct device *device)
 	if (rc) {
 		dev_err(dev, "PM suspend: disable host failed rc=%d\n", rc);
 		clear_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
-		clear_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags);
+		clear_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags);
 		scsi_unblock_requests(shost);
 		return rc;
 	}
@@ -5031,7 +5031,7 @@ static int _resume_v3_hw(struct device *device)
 	}
 	phys_init_v3_hw(hisi_hba);
 	sas_resume_ha(sha);
-	clear_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags);
+	clear_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags);
 
 	return 0;
 }
-- 
2.43.0




