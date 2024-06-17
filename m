Return-Path: <stable+bounces-52377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11F990ADC7
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 14:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBEE61C2315D
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 12:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3E919308B;
	Mon, 17 Jun 2024 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JHbU4PgA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1966D16C6AF
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 12:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718626578; cv=none; b=BWRfUD58XaBHYFWDRG58S1BVik9YeyhcAnqlkQhjbfY/kFbRCz/+KM/XLFGZP2ObjdzfpApNRMVTS5IxwZfe95EKcyzX9mg7PRbwBp9w3Yw0HSqTXb2eEtKLit2Z15T6Rwj3WuZzMSsjs1QA90zr3pYf07k02rFquzgUhAzAtHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718626578; c=relaxed/simple;
	bh=fYm4gTKYqq14THiJG2JE1RXOEfSYeXi6yfuuilNVqvM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RHmqO5puCJA97fmi7TM+J62p6ZUrw7ArRcwcPZra/1n4deFtzEFzdMVUkyVMG158l+bIg+EmqLCuEbJblByd+fJNDLMrs+F8OV9f06kmQmCyVp44Ndk7aNmXcV+sf3jkQg1XVGp+64d2BgnKVDPfpQQ9+DCa5wG4WKqpEPqU/iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JHbU4PgA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CD3C2BD10;
	Mon, 17 Jun 2024 12:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718626577;
	bh=fYm4gTKYqq14THiJG2JE1RXOEfSYeXi6yfuuilNVqvM=;
	h=Subject:To:Cc:From:Date:From;
	b=JHbU4PgA207t6sw9I0Brev4YMVuI/6KqufrvFKaUQ5Y6SzMnpovIOBh/bioKL/QP5
	 6uJjbjBhiTOJ3STUfTLfsYB5xhOJPuyU+czb/p/ErcAKg8WwkD6A3p9o3X0yPLh7I6
	 tTvgpp448Jg3utjaUrQv8ud9U9v9ax3VvLYGLrwM=
Subject: FAILED: patch "[PATCH] scsi: mpi3mr: Fix ATA NCQ priority support" failed to apply to 5.15-stable tree
To: dlemoal@kernel.org,cassel@kernel.org,martin.petersen@oracle.com,scott.mccoy@wdc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 14:16:14 +0200
Message-ID: <2024061714-judo-railway-20f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 90e6f08915ec6efe46570420412a65050ec826b2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061714-judo-railway-20f6@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

90e6f08915ec ("scsi: mpi3mr: Fix ATA NCQ priority support")
9feb5c4c3f95 ("scsi: mpi3mr: Add target device related sysfs attributes")
986d6bad2103 ("scsi: mpi3mr: Expose adapter state to sysfs")
43ca11005098 ("scsi: mpi3mr: Add support for PEL commands")
506bc1a0d6ba ("scsi: mpi3mr: Add support for MPT commands")
f5e6d5a34376 ("scsi: mpi3mr: Add support for driver commands")
4268fa751365 ("scsi: mpi3mr: Add bsg device support")
dc1178767cba ("scsi: mpt3sas: Use cached ATA Information VPD page")
580e6742205e ("scsi: mpi3mr: Fix deadlock while canceling the fw event")
afd3a5793fe2 ("scsi: mpi3mr: Add io_uring interface support in I/O-polled mode")
c1af985d27da ("scsi: mpi3mr: Add Event acknowledgment logic")
c5758fc72b92 ("scsi: mpi3mr: Gracefully handle online FW update operation")
b64845a7d403 ("scsi: mpi3mr: Detect async reset that occurred in firmware")
c0b00a931e5e ("scsi: mpi3mr: Add IOC reinit function")
fe6db6151565 ("scsi: mpi3mr: Handle offline FW activation in graceful manner")
59bd9cfe3fa0 ("scsi: mpi3mr: Code refactor of IOC init - part2")
e3605f65ef69 ("scsi: mpi3mr: Code refactor of IOC init - part1")
a6856cc4507b ("scsi: mpi3mr: Fault IOC when internal command gets timeout")
2ac794baaec9 ("scsi: mpi3mr: Display IOC firmware package version")
17d6b9cf89cf ("scsi: mpi3mr: Add support for PCIe Managed Switch SES device")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 90e6f08915ec6efe46570420412a65050ec826b2 Mon Sep 17 00:00:00 2001
From: Damien Le Moal <dlemoal@kernel.org>
Date: Tue, 11 Jun 2024 17:34:35 +0900
Subject: [PATCH] scsi: mpi3mr: Fix ATA NCQ priority support

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

diff --git a/drivers/scsi/mpi3mr/mpi3mr_app.c b/drivers/scsi/mpi3mr/mpi3mr_app.c
index 1638109a68a0..cd261b48eb46 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_app.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_app.c
@@ -2163,10 +2163,72 @@ persistent_id_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(persistent_id);
 
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
+				 struct device_attribute *attr, char *buf)
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
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
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
 static struct attribute *mpi3mr_dev_attrs[] = {
 	&dev_attr_sas_address.attr,
 	&dev_attr_device_handle.attr,
 	&dev_attr_persistent_id.attr,
+	&dev_attr_sas_ncq_prio_supported.attr,
+	&dev_attr_sas_ncq_prio_enable.attr,
 	NULL,
 };
 
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index bf100a4ebfc3..fe1e96fda284 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -2048,9 +2048,6 @@ void
 mpt3sas_setup_direct_io(struct MPT3SAS_ADAPTER *ioc, struct scsi_cmnd *scmd,
 	struct _raid_device *raid_device, Mpi25SCSIIORequest_t *mpi_request);
 
-/* NCQ Prio Handling Check */
-bool scsih_ncq_prio_supp(struct scsi_device *sdev);
-
 void mpt3sas_setup_debugfs(struct MPT3SAS_ADAPTER *ioc);
 void mpt3sas_destroy_debugfs(struct MPT3SAS_ADAPTER *ioc);
 void mpt3sas_init_debugfs(void);
diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index 1c9fd26195b8..87784c96249a 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -4088,7 +4088,7 @@ sas_ncq_prio_supported_show(struct device *dev,
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
 
-	return sysfs_emit(buf, "%d\n", scsih_ncq_prio_supp(sdev));
+	return sysfs_emit(buf, "%d\n", sas_ata_ncq_prio_supported(sdev));
 }
 static DEVICE_ATTR_RO(sas_ncq_prio_supported);
 
@@ -4123,7 +4123,7 @@ sas_ncq_prio_enable_store(struct device *dev,
 	if (kstrtobool(buf, &ncq_prio_enable))
 		return -EINVAL;
 
-	if (!scsih_ncq_prio_supp(sdev))
+	if (!sas_ata_ncq_prio_supported(sdev))
 		return -EINVAL;
 
 	sas_device_priv_data->ncq_prio_enable = ncq_prio_enable;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 12d08d8ba538..870ec2cb4af4 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -12571,29 +12571,6 @@ scsih_pci_mmio_enabled(struct pci_dev *pdev)
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
-	struct scsi_vpd *vpd;
-	bool ncq_prio_supp = false;
-
-	rcu_read_lock();
-	vpd = rcu_dereference(sdev->vpd_pg89);
-	if (!vpd || vpd->len < 214)
-		goto out;
-
-	ncq_prio_supp = (vpd->data[213] >> 4) & 1;
-out:
-	rcu_read_unlock();
-
-	return ncq_prio_supp;
-}
 /*
  * The pci device ids are defined in mpi/mpi2_cnfg.h.
  */
diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index 424a89513814..4e33f1661e4c 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -416,6 +416,29 @@ unsigned int sas_is_tlr_enabled(struct scsi_device *sdev)
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
+	struct scsi_vpd *vpd;
+	bool ncq_prio_supported = false;
+
+	rcu_read_lock();
+	vpd = rcu_dereference(sdev->vpd_pg89);
+	if (vpd && vpd->len >= 214)
+		ncq_prio_supported = (vpd->data[213] >> 4) & 1;
+	rcu_read_unlock();
+
+	return ncq_prio_supported;
+}
+EXPORT_SYMBOL_GPL(sas_ata_ncq_prio_supported);
+
 /*
  * SAS Phy attributes
  */
diff --git a/include/scsi/scsi_transport_sas.h b/include/scsi/scsi_transport_sas.h
index 0e75b9277c8c..e3b6ce3cbf88 100644
--- a/include/scsi/scsi_transport_sas.h
+++ b/include/scsi/scsi_transport_sas.h
@@ -200,6 +200,8 @@ unsigned int sas_is_tlr_enabled(struct scsi_device *);
 void sas_disable_tlr(struct scsi_device *);
 void sas_enable_tlr(struct scsi_device *);
 
+bool sas_ata_ncq_prio_supported(struct scsi_device *sdev);
+
 extern struct sas_rphy *sas_end_device_alloc(struct sas_port *);
 extern struct sas_rphy *sas_expander_alloc(struct sas_port *, enum sas_device_type);
 void sas_rphy_free(struct sas_rphy *);


