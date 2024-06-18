Return-Path: <stable+bounces-52630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371F790C234
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 05:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8681F1C21701
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 03:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5C879F4;
	Tue, 18 Jun 2024 03:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUHSpKZF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1183B1D9503
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 03:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718679827; cv=none; b=bXeaPSZfb6FKKGVfmoO06+HI07P9dsUh0uBoTn+/faOaiGeplujj9WvoOJvY+uHItwiETyO6n/S6VL8XHK4X5i9W2C6qzafxHIdWm1/eX+tlVwMWM7LzFe4zcGmeBaA8jQqUtDy0tdCXB35lHuYUY5nFu/G0YFC3BK/GaOPFJpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718679827; c=relaxed/simple;
	bh=HK3tTDXu1aE8v4iBOyotBQvVyMwOOtSa3zxPpe5NlME=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmW/PSlGsDK/q8LrRBV3rNew/ljHvH508lyVkoIHMuE5YYbe2vMbTR3VQ06Y5hSzDmMUxOlL+sqlZ3AFX9LGPhyLAOn8LVyQBorcPDwej8jyChfYptIbEeWNCoIG1mhLBEURxkvAFT8gWJfyVlgyjv3GzV7hJGrsJ+jPxkXdE3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUHSpKZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5974DC2BD10
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 03:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718679826;
	bh=HK3tTDXu1aE8v4iBOyotBQvVyMwOOtSa3zxPpe5NlME=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uUHSpKZFCt0gWBTF5V6KkrT1eh3TyUF1+2JKYJOeW5D/+3SzPnunbBl20h2wfgF3v
	 h2cAI7eth1EtAH/z/Qo0mVb7TqK2qawTLrAvPrcTGBENFO4iD4mAaJJWKVm1UBJqDP
	 pl7U1yhBHNm8B/sQ3F2AfuiZHUWRTFxha509RpDvUs01sXRTz2swOuGW1mcfn2u0Yl
	 fg3Xcvs1uPOeT7i1qykfW7MWJ2iEtLPLgm14kING25cCD1qFZxrv+oZtuik0fnwaOa
	 osX9nzbX3mNtQl+OT7u7Gp2FeU8uJNPuf68FyLDzMOSmwwD721aXwuSP2cHrklOkm7
	 ad0iaEajVyjHg==
From: Damien Le Moal <dlemoal@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y] scsi: mpi3mr: Fix ATA NCQ priority support
Date: Tue, 18 Jun 2024 12:03:45 +0900
Message-ID: <20240618030345.485545-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024061714-judo-railway-20f6@gregkh>
References: <2024061714-judo-railway-20f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 90e6f08915ec6efe46570420412a65050ec826b2 upstream.

The function mpi3mr_qcmd() of the mpi3mr driver is able to indicate to
the HBA if a read or write command directed at an ATA device should be
translated to an NCQ read/write command with the high prioiryt bit set
when the request uses the RT priority class and the user has enabled NCQ
priority through sysfs.

However, unlike the mpt3sas driver, the mpi3mr driver does not define
the sas_ncq_prio_supported and sas_ncq_prio_enable sysfs attributes, so
the ncq_prio_enable field of struct mpi3mr_sdev_priv_data is never
actually set and NCQ Priority cannot ever be used.

Fix this by defining these missing atributes to allow a user to check if
an ATA device supports NCQ priority and to enable/disable the use of NCQ
priority. To do this, lift the function scsih_ncq_prio_supp() out of the
mpt3sas driver and make it the generic SCSI SAS transport function
sas_ata_ncq_prio_supported(). Nothing in that function is hardware
specific, so this function can be used in both the mpt3sas driver and
the mpi3mr driver.

Reported-by: Scott McCoy <scott.mccoy@wdc.com>
Fixes: 023ab2a9b4ed ("scsi: mpi3mr: Add support for queue command processing")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Link: https://lore.kernel.org/r/20240611083435.92961-1-dlemoal@kernel.org
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
(cherry picked from commit 90e6f08915ec6efe46570420412a65050ec826b2)
---
 drivers/scsi/mpi3mr/mpi3mr.h         |  1 +
 drivers/scsi/mpi3mr/mpi3mr_os.c      | 67 ++++++++++++++++++++++++++++
 drivers/scsi/mpt3sas/mpt3sas_base.h  |  3 --
 drivers/scsi/mpt3sas/mpt3sas_ctl.c   |  4 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 25 -----------
 drivers/scsi/scsi_transport_sas.c    | 29 ++++++++++++
 include/scsi/scsi_transport_sas.h    |  2 +
 7 files changed, 101 insertions(+), 30 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index 2cc42432bd0c..26043e05ca30 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -38,6 +38,7 @@
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_tcq.h>
+#include <scsi/scsi_transport_sas.h>
 
 #include "mpi/mpi30_transport.h"
 #include "mpi/mpi30_cnfg.h"
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index a0d3e2eb8c1a..859e2c1e38e1 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -3549,6 +3549,72 @@ static int mpi3mr_qcmd(struct Scsi_Host *shost,
 	return retval;
 }
 
+/**
+ * sas_ncq_prio_supported_show - Indicate if device supports NCQ priority
+ * @dev: pointer to embedded device
+ * @attr: sas_ncq_prio_supported attribute descriptor
+ * @buf: the buffer returned
+ *
+ * A sysfs 'read-only' sdev attribute, only works with SATA devices
+ */
+static ssize_t
+sas_ncq_prio_supported_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+
+	return sysfs_emit(buf, "%d\n", sas_ata_ncq_prio_supported(sdev));
+}
+static DEVICE_ATTR_RO(sas_ncq_prio_supported);
+
+/**
+ * sas_ncq_prio_enable_show - send prioritized io commands to device
+ * @dev: pointer to embedded device
+ * @attr: sas_ncq_prio_enable attribute descriptor
+ * @buf: the buffer returned
+ *
+ * A sysfs 'read/write' sdev attribute, only works with SATA devices
+ */
+static ssize_t
+sas_ncq_prio_enable_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct mpi3mr_sdev_priv_data *sdev_priv_data =  sdev->hostdata;
+
+	if (!sdev_priv_data)
+		return 0;
+
+	return sysfs_emit(buf, "%d\n", sdev_priv_data->ncq_prio_enable);
+}
+
+static ssize_t
+sas_ncq_prio_enable_store(struct device *dev,
+			  struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct mpi3mr_sdev_priv_data *sdev_priv_data =  sdev->hostdata;
+	bool ncq_prio_enable = 0;
+
+	if (kstrtobool(buf, &ncq_prio_enable))
+		return -EINVAL;
+
+	if (!sas_ata_ncq_prio_supported(sdev))
+		return -EINVAL;
+
+	sdev_priv_data->ncq_prio_enable = ncq_prio_enable;
+
+	return strlen(buf);
+}
+static DEVICE_ATTR_RW(sas_ncq_prio_enable);
+
+static struct device_attribute *mpi3mr_dev_attrs[] = {
+	&dev_attr_sas_ncq_prio_supported,
+	&dev_attr_sas_ncq_prio_enable,
+	NULL,
+};
+
 static struct scsi_host_template mpi3mr_driver_template = {
 	.module				= THIS_MODULE,
 	.name				= "MPI3 Storage Controller",
@@ -3577,6 +3643,7 @@ static struct scsi_host_template mpi3mr_driver_template = {
 	.cmd_per_lun			= MPI3MR_MAX_CMDS_LUN,
 	.track_queue_depth		= 1,
 	.cmd_size			= sizeof(struct scmd_priv),
+	.sdev_attrs			= mpi3mr_dev_attrs,
 };
 
 /**
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 0ff208a41a47..60fd8192c059 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -2010,9 +2010,6 @@ void
 mpt3sas_setup_direct_io(struct MPT3SAS_ADAPTER *ioc, struct scsi_cmnd *scmd,
 	struct _raid_device *raid_device, Mpi25SCSIIORequest_t *mpi_request);
 
-/* NCQ Prio Handling Check */
-bool scsih_ncq_prio_supp(struct scsi_device *sdev);
-
 void mpt3sas_setup_debugfs(struct MPT3SAS_ADAPTER *ioc);
 void mpt3sas_destroy_debugfs(struct MPT3SAS_ADAPTER *ioc);
 void mpt3sas_init_debugfs(void);
diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index 1b79f01f03a4..20336175c14f 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -3933,7 +3933,7 @@ sas_ncq_prio_supported_show(struct device *dev,
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
 
-	return sysfs_emit(buf, "%d\n", scsih_ncq_prio_supp(sdev));
+	return sysfs_emit(buf, "%d\n", sas_ata_ncq_prio_supported(sdev));
 }
 static DEVICE_ATTR_RO(sas_ncq_prio_supported);
 
@@ -3968,7 +3968,7 @@ sas_ncq_prio_enable_store(struct device *dev,
 	if (kstrtobool(buf, &ncq_prio_enable))
 		return -EINVAL;
 
-	if (!scsih_ncq_prio_supp(sdev))
+	if (!sas_ata_ncq_prio_supported(sdev))
 		return -EINVAL;
 
 	sas_device_priv_data->ncq_prio_enable = ncq_prio_enable;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index c9f85605349b..bbef78608a67 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -12580,31 +12580,6 @@ scsih_pci_mmio_enabled(struct pci_dev *pdev)
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-/**
- * scsih_ncq_prio_supp - Check for NCQ command priority support
- * @sdev: scsi device struct
- *
- * This is called when a user indicates they would like to enable
- * ncq command priorities. This works only on SATA devices.
- */
-bool scsih_ncq_prio_supp(struct scsi_device *sdev)
-{
-	unsigned char *buf;
-	bool ncq_prio_supp = false;
-
-	if (!scsi_device_supports_vpd(sdev))
-		return ncq_prio_supp;
-
-	buf = kmalloc(SCSI_VPD_PG_LEN, GFP_KERNEL);
-	if (!buf)
-		return ncq_prio_supp;
-
-	if (!scsi_get_vpd_page(sdev, 0x89, buf, SCSI_VPD_PG_LEN))
-		ncq_prio_supp = (buf[213] >> 4) & 1;
-
-	kfree(buf);
-	return ncq_prio_supp;
-}
 /*
  * The pci device ids are defined in mpi/mpi2_cnfg.h.
  */
diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index c6256fdc24b1..8649608faec2 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -410,6 +410,35 @@ unsigned int sas_is_tlr_enabled(struct scsi_device *sdev)
 }
 EXPORT_SYMBOL_GPL(sas_is_tlr_enabled);
 
+/**
+ * sas_ata_ncq_prio_supported - Check for ATA NCQ command priority support
+ * @sdev: SCSI device
+ *
+ * Check if an ATA device supports NCQ priority using VPD page 89h (ATA
+ * Information). Since this VPD page is implemented only for ATA devices,
+ * this function always returns false for SCSI devices.
+ */
+bool sas_ata_ncq_prio_supported(struct scsi_device *sdev)
+{
+	unsigned char *buf;
+	bool ncq_prio_supported = false;
+
+	if (!scsi_device_supports_vpd(sdev))
+		return false;
+
+	buf = kmalloc(SCSI_VPD_PG_LEN, GFP_KERNEL);
+	if (!buf)
+		return false;
+
+	if (!scsi_get_vpd_page(sdev, 0x89, buf, SCSI_VPD_PG_LEN))
+		ncq_prio_supported = (buf[213] >> 4) & 1;
+
+	kfree(buf);
+
+	return ncq_prio_supported;
+}
+EXPORT_SYMBOL_GPL(sas_ata_ncq_prio_supported);
+
 /*
  * SAS Phy attributes
  */
diff --git a/include/scsi/scsi_transport_sas.h b/include/scsi/scsi_transport_sas.h
index 05ec927a3c72..7460f730f7d7 100644
--- a/include/scsi/scsi_transport_sas.h
+++ b/include/scsi/scsi_transport_sas.h
@@ -199,6 +199,8 @@ unsigned int sas_is_tlr_enabled(struct scsi_device *);
 void sas_disable_tlr(struct scsi_device *);
 void sas_enable_tlr(struct scsi_device *);
 
+bool sas_ata_ncq_prio_supported(struct scsi_device *sdev);
+
 extern struct sas_rphy *sas_end_device_alloc(struct sas_port *);
 extern struct sas_rphy *sas_expander_alloc(struct sas_port *, enum sas_device_type);
 void sas_rphy_free(struct sas_rphy *);
-- 
2.45.2


