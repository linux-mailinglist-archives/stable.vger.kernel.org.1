Return-Path: <stable+bounces-33882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54455893932
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 10:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22921F21AF1
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 08:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF542DDA7;
	Mon,  1 Apr 2024 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1hrTOwb0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4332F55
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711961671; cv=none; b=EO/uMn6smERaMHvbSPTEhz+Zz+QQJNEHjXhuEhJC8T+aR/5cj9ute45ILTPk9xX5Pvz/ZTatSQR4/PjUhzJ6VRslTNFaUylcxqRdsngUPaglqlgYVjS7PmK+QWyeb6avsy8OinDxtjx9b8k+1RucJN/Jg9MKhGEZVtHHqIvVE6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711961671; c=relaxed/simple;
	bh=//qkJwNYvanK8D1i3fhxNDTTgmlJrEl++cZrNymcqfM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XMnhCucjphr12bQU2ter8p5XIUYuwWJoAh5q/iz0Ck6DetD2HWrIZ803vii5PQuVvy7xkXvSsuJUXj+uZWHbH6X4vb0OKeJnv44O679KELKI6FVVasEktTxjy7eLTtYPbkDkbPGS9KEhFxm7LdHb5VW1DwqlW+WHUs+0Vpa3KDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1hrTOwb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D39EC433F1;
	Mon,  1 Apr 2024 08:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711961670;
	bh=//qkJwNYvanK8D1i3fhxNDTTgmlJrEl++cZrNymcqfM=;
	h=Subject:To:Cc:From:Date:From;
	b=1hrTOwb0kyxEwtkGCsQinKvuBzMtO8TGpKXnZ0N+Gi2qojtR6oSSa2BBk5lbyllDv
	 Mq2lWpq46KdpNoglIrVA7Mjtvfx+b01bNn2W9GaUND1OlLSY53N7v3H90/sv+im4j7
	 O1YQLrc4v/g8O1eYYVYMu80i7MokRziwfifxTplk=
Subject: FAILED: patch "[PATCH] scsi: sd: Fix TCG OPAL unlock on system resume" failed to apply to 6.1-stable tree
To: dlemoal@kernel.org,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Apr 2024 10:54:27 +0200
Message-ID: <2024040127-defraud-ladle-60f4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0c76106cb97548810214def8ee22700bbbb90543
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040127-defraud-ladle-60f4@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

0c76106cb975 ("scsi: sd: Fix TCG OPAL unlock on system resume")
99398d2070ab ("scsi: sd: Do not issue commands to suspended disks on shutdown")
8b4d9469d0b0 ("ata: libata-scsi: Fix delayed scsi_rescan_device() execution")
ff48b37802e5 ("scsi: Do not attempt to rescan suspended devices")
aa3998dbeb3a ("ata: libata-scsi: Disable scsi device manage_system_start_stop")
3cc2ffe5c16d ("scsi: sd: Differentiate system and runtime start/stop management")
2a5a4326e583 ("Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0c76106cb97548810214def8ee22700bbbb90543 Mon Sep 17 00:00:00 2001
From: Damien Le Moal <dlemoal@kernel.org>
Date: Tue, 19 Mar 2024 16:12:09 +0900
Subject: [PATCH] scsi: sd: Fix TCG OPAL unlock on system resume

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

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b0d6e69c4a5b..214b935c2ced 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -712,8 +712,10 @@ void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap)
 				ehc->saved_ncq_enabled |= 1 << devno;
 
 			/* If we are resuming, wake up the device */
-			if (ap->pflags & ATA_PFLAG_RESUMING)
+			if (ap->pflags & ATA_PFLAG_RESUMING) {
+				dev->flags |= ATA_DFLAG_RESUMING;
 				ehc->i.dev_action[devno] |= ATA_EH_SET_ACTIVE;
+			}
 		}
 	}
 
@@ -3169,6 +3171,7 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 	return 0;
 
  err:
+	dev->flags &= ~ATA_DFLAG_RESUMING;
 	*r_failed_dev = dev;
 	return rc;
 }
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 0a0f483124c3..2f4c58837641 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4730,6 +4730,7 @@ void ata_scsi_dev_rescan(struct work_struct *work)
 	struct ata_link *link;
 	struct ata_device *dev;
 	unsigned long flags;
+	bool do_resume;
 	int ret = 0;
 
 	mutex_lock(&ap->scsi_scan_mutex);
@@ -4751,7 +4752,15 @@ void ata_scsi_dev_rescan(struct work_struct *work)
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
index 8d06475de17a..ffd7e7e72933 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1642,6 +1642,40 @@ int scsi_add_device(struct Scsi_Host *host, uint channel,
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
index ccff8f2e2e75..3cf898670290 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -4108,7 +4108,21 @@ static int sd_suspend_runtime(struct device *dev)
 	return sd_suspend_common(dev, true);
 }
 
-static int sd_resume(struct device *dev, bool runtime)
+static int sd_resume(struct device *dev)
+{
+	struct scsi_disk *sdkp = dev_get_drvdata(dev);
+
+	sd_printk(KERN_NOTICE, sdkp, "Starting disk\n");
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
 	int ret;
@@ -4124,7 +4138,7 @@ static int sd_resume(struct device *dev, bool runtime)
 	sd_printk(KERN_NOTICE, sdkp, "Starting disk\n");
 	ret = sd_start_stop_device(sdkp, 1);
 	if (!ret) {
-		opal_unlock_from_suspend(sdkp->opal_dev);
+		sd_resume(dev);
 		sdkp->suspended = false;
 	}
 
@@ -4143,7 +4157,7 @@ static int sd_resume_system(struct device *dev)
 		return 0;
 	}
 
-	return sd_resume(dev, false);
+	return sd_resume_common(dev, false);
 }
 
 static int sd_resume_runtime(struct device *dev)
@@ -4170,7 +4184,7 @@ static int sd_resume_runtime(struct device *dev)
 				  "Failed to clear sense data\n");
 	}
 
-	return sd_resume(dev, true);
+	return sd_resume_common(dev, true);
 }
 
 static const struct dev_pm_ops sd_pm_ops = {
@@ -4193,6 +4207,7 @@ static struct scsi_driver sd_template = {
 		.pm		= &sd_pm_ops,
 	},
 	.rescan			= sd_rescan,
+	.resume			= sd_resume,
 	.init_command		= sd_init_command,
 	.uninit_command		= sd_uninit_command,
 	.done			= sd_done,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 26d68115afb8..324d792e7c78 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -107,6 +107,7 @@ enum {
 
 	ATA_DFLAG_NCQ_PRIO_ENABLED = (1 << 20), /* Priority cmds sent to dev */
 	ATA_DFLAG_CDL_ENABLED	= (1 << 21), /* cmd duration limits is enabled */
+	ATA_DFLAG_RESUMING	= (1 << 22),  /* Device is resuming */
 	ATA_DFLAG_DETACH	= (1 << 24),
 	ATA_DFLAG_DETACHED	= (1 << 25),
 	ATA_DFLAG_DA		= (1 << 26), /* device supports Device Attention */
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
index b259d42a1e1a..129001f600fc 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -767,6 +767,7 @@ scsi_template_proc_dir(const struct scsi_host_template *sht);
 #define scsi_template_proc_dir(sht) NULL
 #endif
 extern void scsi_scan_host(struct Scsi_Host *);
+extern int scsi_resume_device(struct scsi_device *sdev);
 extern int scsi_rescan_device(struct scsi_device *sdev);
 extern void scsi_remove_host(struct Scsi_Host *);
 extern struct Scsi_Host *scsi_host_get(struct Scsi_Host *);


