Return-Path: <stable+bounces-33884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084A9893955
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 11:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9841F212E3
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 09:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3FE101EB;
	Mon,  1 Apr 2024 09:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCGapdnj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D454CFBFD
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711963086; cv=none; b=k0P7pf9shntbCRvvRuXZThb17UsLgG5nrON90gqnYPJ4V+9qGF4UzDobfSDeTvqWye+HMXcJbqMJDDODXJLLG85V96SjtOedwM1f8BXrIJe1E2XoK51dA8WwoCTQDwxS86mPqFE1O+gEb6T1MV8nEezDaQeUFfzUZE5i/IyiFUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711963086; c=relaxed/simple;
	bh=NnJqZwrhHh23qmqguL6GQSovTgqE5TNpcw1HXQ9nlKM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDrf89qXTgPZ3PEWHqUnq7MvwRPiEvFvh1uLYfqJSMS1B3zg3YANbzr/1IP5a4d8e/clfnZSHJliFXSgZ3u7i2BzfCTCzSFzDdcylW91kBrL2Vh9+2nnlYsJ9sHSI35hCh/Co85JH3+WEW5FhQxHDypfzl3E9KYPE1ujpbYPx9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCGapdnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C547C433F1
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 09:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711963086;
	bh=NnJqZwrhHh23qmqguL6GQSovTgqE5TNpcw1HXQ9nlKM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nCGapdnjHcovrOXSizcgkDseveECXznfaVw2xx/RjP/i37NDKEFuhSkWkOhiYyX1l
	 hrx9fnFhWoD0W7lUaUKbG1mwh4ickoMVXnl91gMd0CXg+ztKh50ewBCoiArp4i44Qs
	 ZahSzhDXENxCYd3iA8P/3LaJxW2AlOVQdEvgXeDEjaVjPtj7u4C+keaTDWup+NWgWV
	 o9uFIZwYICn+2oireeCQvFRQIDsUfVOgb+TOKlzzJBar4104iKI0HQOF+Rr3+f3HVJ
	 NHCvuM6H7ya8C5k61XKECsI/HBtiPTI/VyMk2l7DvFAvfWAxCJ9pUow+EsjR/0Ty4S
	 UA7VCEqXH8g1w==
From: Damien Le Moal <dlemoal@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y] scsi: sd: Fix TCG OPAL unlock on system resume
Date: Mon,  1 Apr 2024 18:18:04 +0900
Message-ID: <20240401091804.1752629-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024040127-defraud-ladle-60f4@gregkh>
References: <2024040127-defraud-ladle-60f4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0c76106cb97548810214def8ee22700bbbb90543 upstream.

Commit 3cc2ffe5c16d ("scsi: sd: Differentiate system and runtime start/stop
management") introduced the manage_system_start_stop scsi_device flag to
allow libata to indicate to the SCSI disk driver that nothing should be
done when resuming a disk on system resume. This change turned the
execution of sd_resume() into a no-op for ATA devices on system
resume. While this solved deadlock issues during device resume, this change
also wrongly removed the execution of opal_unlock_from_suspend().  As a
result, devices with TCG OPAL locking enabled remain locked and
inaccessible after a system resume from sleep.

To fix this issue, introduce the SCSI driver resume method and implement it
with the sd_resume() function calling opal_unlock_from_suspend(). The
former sd_resume() function is renamed to sd_resume_common() and modified
to call the new sd_resume() function. For non-ATA devices, this result in
no functional changes.

In order for libata to explicitly execute sd_resume() when a device is
resumed during system restart, the function scsi_resume_device() is
introduced. libata calls this function from the revalidation work executed
on devie resume, a state that is indicated with the new device flag
ATA_DFLAG_RESUMING. Doing so, locked TCG OPAL enabled devices are unlocked
on resume, allowing normal operation.

Fixes: 3cc2ffe5c16d ("scsi: sd: Differentiate system and runtime start/stop management")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218538
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Link: https://lore.kernel.org/r/20240319071209.1179257-1-dlemoal@kernel.org
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/ata/libata-eh.c    |  5 ++++-
 drivers/ata/libata-scsi.c  |  9 +++++++++
 drivers/scsi/scsi_scan.c   | 34 ++++++++++++++++++++++++++++++++++
 drivers/scsi/sd.c          | 25 +++++++++++++++++++++----
 include/linux/libata.h     |  1 +
 include/scsi/scsi_driver.h |  1 +
 include/scsi/scsi_host.h   |  1 +
 7 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 1eaaf01418ea..b8034d194078 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -711,8 +711,10 @@ void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap)
 					ehc->saved_ncq_enabled |= 1 << devno;
 
 				/* If we are resuming, wake up the device */
-				if (ap->pflags & ATA_PFLAG_RESUMING)
+				if (ap->pflags & ATA_PFLAG_RESUMING) {
+					dev->flags |= ATA_DFLAG_RESUMING;
 					ehc->i.dev_action[devno] |= ATA_EH_SET_ACTIVE;
+				}
 			}
 		}
 
@@ -3089,6 +3091,7 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 	return 0;
 
  err:
+	dev->flags &= ~ATA_DFLAG_RESUMING;
 	*r_failed_dev = dev;
 	return rc;
 }
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a9da2f05e629..a09548630fc8 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4652,6 +4652,7 @@ void ata_scsi_dev_rescan(struct work_struct *work)
 	struct ata_link *link;
 	struct ata_device *dev;
 	unsigned long flags;
+	bool do_resume;
 	int ret = 0;
 
 	mutex_lock(&ap->scsi_scan_mutex);
@@ -4673,7 +4674,15 @@ void ata_scsi_dev_rescan(struct work_struct *work)
 			if (scsi_device_get(sdev))
 				continue;
 
+			do_resume = dev->flags & ATA_DFLAG_RESUMING;
+
 			spin_unlock_irqrestore(ap->lock, flags);
+			if (do_resume) {
+				ret = scsi_resume_device(sdev);
+				if (ret == -EWOULDBLOCK)
+					goto unlock;
+				dev->flags &= ~ATA_DFLAG_RESUMING;
+			}
 			ret = scsi_rescan_device(sdev);
 			scsi_device_put(sdev);
 			spin_lock_irqsave(ap->lock, flags);
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index bab00b65bc9d..852d509b19b2 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1611,6 +1611,40 @@ int scsi_add_device(struct Scsi_Host *host, uint channel,
 }
 EXPORT_SYMBOL(scsi_add_device);
 
+int scsi_resume_device(struct scsi_device *sdev)
+{
+	struct device *dev = &sdev->sdev_gendev;
+	int ret = 0;
+
+	device_lock(dev);
+
+	/*
+	 * Bail out if the device or its queue are not running. Otherwise,
+	 * the rescan may block waiting for commands to be executed, with us
+	 * holding the device lock. This can result in a potential deadlock
+	 * in the power management core code when system resume is on-going.
+	 */
+	if (sdev->sdev_state != SDEV_RUNNING ||
+	    blk_queue_pm_only(sdev->request_queue)) {
+		ret = -EWOULDBLOCK;
+		goto unlock;
+	}
+
+	if (dev->driver && try_module_get(dev->driver->owner)) {
+		struct scsi_driver *drv = to_scsi_driver(dev->driver);
+
+		if (drv->resume)
+			ret = drv->resume(dev);
+		module_put(dev->driver->owner);
+	}
+
+unlock:
+	device_unlock(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(scsi_resume_device);
+
 int scsi_rescan_device(struct scsi_device *sdev)
 {
 	struct device *dev = &sdev->sdev_gendev;
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 4433b02c8935..c793bca88223 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -110,6 +110,7 @@ static int sd_suspend_system(struct device *);
 static int sd_suspend_runtime(struct device *);
 static int sd_resume_system(struct device *);
 static int sd_resume_runtime(struct device *);
+static int sd_resume(struct device *);
 static void sd_rescan(struct device *);
 static blk_status_t sd_init_command(struct scsi_cmnd *SCpnt);
 static void sd_uninit_command(struct scsi_cmnd *SCpnt);
@@ -691,6 +692,7 @@ static struct scsi_driver sd_template = {
 		.pm		= &sd_pm_ops,
 	},
 	.rescan			= sd_rescan,
+	.resume			= sd_resume,
 	.init_command		= sd_init_command,
 	.uninit_command		= sd_uninit_command,
 	.done			= sd_done,
@@ -3830,7 +3832,22 @@ static int sd_suspend_runtime(struct device *dev)
 	return sd_suspend_common(dev, true);
 }
 
-static int sd_resume(struct device *dev, bool runtime)
+static int sd_resume(struct device *dev)
+{
+	struct scsi_disk *sdkp = dev_get_drvdata(dev);
+
+	if (sdkp->device->no_start_on_resume)
+		sd_printk(KERN_NOTICE, sdkp, "Starting disk\n");
+
+	if (opal_unlock_from_suspend(sdkp->opal_dev)) {
+		sd_printk(KERN_NOTICE, sdkp, "OPAL unlock failed\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int sd_resume_common(struct device *dev, bool runtime)
 {
 	struct scsi_disk *sdkp = dev_get_drvdata(dev);
 	int ret = 0;
@@ -3849,7 +3866,7 @@ static int sd_resume(struct device *dev, bool runtime)
 	}
 
 	if (!ret) {
-		opal_unlock_from_suspend(sdkp->opal_dev);
+		sd_resume(dev);
 		sdkp->suspended = false;
 	}
 
@@ -3868,7 +3885,7 @@ static int sd_resume_system(struct device *dev)
 		return 0;
 	}
 
-	return sd_resume(dev, false);
+	return sd_resume_common(dev, false);
 }
 
 static int sd_resume_runtime(struct device *dev)
@@ -3892,7 +3909,7 @@ static int sd_resume_runtime(struct device *dev)
 				  "Failed to clear sense data\n");
 	}
 
-	return sd_resume(dev, true);
+	return sd_resume_common(dev, true);
 }
 
 /**
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 45910aebc377..6645259be143 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -102,6 +102,7 @@ enum {
 	ATA_DFLAG_NCQ_SEND_RECV = (1 << 19), /* device supports NCQ SEND and RECV */
 	ATA_DFLAG_NCQ_PRIO	= (1 << 20), /* device supports NCQ priority */
 	ATA_DFLAG_NCQ_PRIO_ENABLED = (1 << 21), /* Priority cmds sent to dev */
+	ATA_DFLAG_RESUMING	= (1 << 22),  /* Device is resuming */
 	ATA_DFLAG_INIT_MASK	= (1 << 24) - 1,
 
 	ATA_DFLAG_DETACH	= (1 << 24),
diff --git a/include/scsi/scsi_driver.h b/include/scsi/scsi_driver.h
index 4ce1988b2ba0..f40915d2ecee 100644
--- a/include/scsi/scsi_driver.h
+++ b/include/scsi/scsi_driver.h
@@ -12,6 +12,7 @@ struct request;
 struct scsi_driver {
 	struct device_driver	gendrv;
 
+	int (*resume)(struct device *);
 	void (*rescan)(struct device *);
 	blk_status_t (*init_command)(struct scsi_cmnd *);
 	void (*uninit_command)(struct scsi_cmnd *);
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 71def41b1ad7..149b63e3534a 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -752,6 +752,7 @@ extern int __must_check scsi_add_host_with_dma(struct Scsi_Host *,
 					       struct device *,
 					       struct device *);
 extern void scsi_scan_host(struct Scsi_Host *);
+extern int scsi_resume_device(struct scsi_device *sdev);
 extern int scsi_rescan_device(struct scsi_device *sdev);
 extern void scsi_remove_host(struct Scsi_Host *);
 extern struct Scsi_Host *scsi_host_get(struct Scsi_Host *);
-- 
2.44.0


