Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8D67BDE2D
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376957AbjJINQo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376972AbjJINQm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:16:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FBDB6
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:16:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847B8C433C8;
        Mon,  9 Oct 2023 13:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857399;
        bh=MDojoTT4IfKsRvxQ9hboOYF5Lx884qOW9rpYWIRnEMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1jOBAa8iAu0KhSyDb04N8q9Z02TA/alIbUJVvGUdplFxelFEP0SzW6/3q4mTfCZdx
         JPSooL/raYmmrk8SDX7C0xHG66NWee5p5BGv4GJyGjZwdXsCx+gRmN6rgniv3mG0Oj
         SU1EXKIBtM3TafwgGBW+IjI/VkWu71m+0YkdVlO4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 016/162] scsi: sd: Differentiate system and runtime start/stop management
Date:   Mon,  9 Oct 2023 14:59:57 +0200
Message-ID: <20231009130123.395662077@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit 3cc2ffe5c16dc65dfac354bc5b5bc98d3b397567 ]

The underlying device and driver of a SCSI disk may have different
system and runtime power mode control requirements. This is because
runtime power management affects only the SCSI disk, while system level
power management affects all devices, including the controller for the
SCSI disk.

For instance, issuing a START STOP UNIT command when a SCSI disk is
runtime suspended and resumed is fine: the command is translated to a
STANDBY IMMEDIATE command to spin down the ATA disk and to a VERIFY
command to wake it up. The SCSI disk runtime operations have no effect
on the ata port device used to connect the ATA disk. However, for
system suspend/resume operations, the ATA port used to connect the
device will also be suspended and resumed, with the resume operation
requiring re-validating the device link and the device itself. In this
case, issuing a VERIFY command to spinup the disk must be done before
starting to revalidate the device, when the ata port is being resumed.
In such case, we must not allow the SCSI disk driver to issue START STOP
UNIT commands.

Allow a low level driver to refine the SCSI disk start/stop management
by differentiating system and runtime cases with two new SCSI device
flags: manage_system_start_stop and manage_runtime_start_stop. These new
flags replace the current manage_start_stop flag. Drivers setting the
manage_start_stop are modifed to set both new flags, thus preserving the
existing start/stop management behavior. For backward compatibility, the
old manage_start_stop sysfs device attribute is kept as a read-only
attribute showing a value of 1 for devices enabling both new flags and 0
otherwise.

Fixes: 0a8589055936 ("ata,scsi: do not issue START STOP UNIT on resume")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 99398d2070ab ("scsi: sd: Do not issue commands to suspended disks on shutdown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-scsi.c  |  3 +-
 drivers/firewire/sbp2.c    |  9 ++--
 drivers/scsi/sd.c          | 90 ++++++++++++++++++++++++++++++--------
 include/scsi/scsi_device.h |  5 ++-
 4 files changed, 84 insertions(+), 23 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 9c8dd9f86cbb3..8cc8268327f0c 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1087,7 +1087,8 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
 		 * will be woken up by ata_port_pm_resume() with a port reset
 		 * and device revalidation.
 		 */
-		sdev->manage_start_stop = 1;
+		sdev->manage_system_start_stop = true;
+		sdev->manage_runtime_start_stop = true;
 		sdev->no_start_on_resume = 1;
 	}
 
diff --git a/drivers/firewire/sbp2.c b/drivers/firewire/sbp2.c
index 60051c0cabeaa..e322a326546b5 100644
--- a/drivers/firewire/sbp2.c
+++ b/drivers/firewire/sbp2.c
@@ -81,7 +81,8 @@ MODULE_PARM_DESC(exclusive_login, "Exclusive login to sbp2 device "
  *
  * - power condition
  *   Set the power condition field in the START STOP UNIT commands sent by
- *   sd_mod on suspend, resume, and shutdown (if manage_start_stop is on).
+ *   sd_mod on suspend, resume, and shutdown (if manage_system_start_stop or
+ *   manage_runtime_start_stop is on).
  *   Some disks need this to spin down or to resume properly.
  *
  * - override internal blacklist
@@ -1517,8 +1518,10 @@ static int sbp2_scsi_slave_configure(struct scsi_device *sdev)
 
 	sdev->use_10_for_rw = 1;
 
-	if (sbp2_param_exclusive_login)
-		sdev->manage_start_stop = 1;
+	if (sbp2_param_exclusive_login) {
+		sdev->manage_system_start_stop = true;
+		sdev->manage_runtime_start_stop = true;
+	}
 
 	if (sdev->type == TYPE_ROM)
 		sdev->use_10_for_ms = 1;
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 5bfca49415113..2ed57dfaf9ee0 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -213,18 +213,32 @@ cache_type_store(struct device *dev, struct device_attribute *attr,
 }
 
 static ssize_t
-manage_start_stop_show(struct device *dev, struct device_attribute *attr,
-		       char *buf)
+manage_start_stop_show(struct device *dev,
+		       struct device_attribute *attr, char *buf)
 {
 	struct scsi_disk *sdkp = to_scsi_disk(dev);
 	struct scsi_device *sdp = sdkp->device;
 
-	return sprintf(buf, "%u\n", sdp->manage_start_stop);
+	return sysfs_emit(buf, "%u\n",
+			  sdp->manage_system_start_stop &&
+			  sdp->manage_runtime_start_stop);
 }
+static DEVICE_ATTR_RO(manage_start_stop);
 
 static ssize_t
-manage_start_stop_store(struct device *dev, struct device_attribute *attr,
-			const char *buf, size_t count)
+manage_system_start_stop_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct scsi_disk *sdkp = to_scsi_disk(dev);
+	struct scsi_device *sdp = sdkp->device;
+
+	return sysfs_emit(buf, "%u\n", sdp->manage_system_start_stop);
+}
+
+static ssize_t
+manage_system_start_stop_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
 {
 	struct scsi_disk *sdkp = to_scsi_disk(dev);
 	struct scsi_device *sdp = sdkp->device;
@@ -236,11 +250,42 @@ manage_start_stop_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtobool(buf, &v))
 		return -EINVAL;
 
-	sdp->manage_start_stop = v;
+	sdp->manage_system_start_stop = v;
 
 	return count;
 }
-static DEVICE_ATTR_RW(manage_start_stop);
+static DEVICE_ATTR_RW(manage_system_start_stop);
+
+static ssize_t
+manage_runtime_start_stop_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct scsi_disk *sdkp = to_scsi_disk(dev);
+	struct scsi_device *sdp = sdkp->device;
+
+	return sysfs_emit(buf, "%u\n", sdp->manage_runtime_start_stop);
+}
+
+static ssize_t
+manage_runtime_start_stop_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct scsi_disk *sdkp = to_scsi_disk(dev);
+	struct scsi_device *sdp = sdkp->device;
+	bool v;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	if (kstrtobool(buf, &v))
+		return -EINVAL;
+
+	sdp->manage_runtime_start_stop = v;
+
+	return count;
+}
+static DEVICE_ATTR_RW(manage_runtime_start_stop);
 
 static ssize_t
 allow_restart_show(struct device *dev, struct device_attribute *attr, char *buf)
@@ -572,6 +617,8 @@ static struct attribute *sd_disk_attrs[] = {
 	&dev_attr_FUA.attr,
 	&dev_attr_allow_restart.attr,
 	&dev_attr_manage_start_stop.attr,
+	&dev_attr_manage_system_start_stop.attr,
+	&dev_attr_manage_runtime_start_stop.attr,
 	&dev_attr_protection_type.attr,
 	&dev_attr_protection_mode.attr,
 	&dev_attr_app_tag_own.attr,
@@ -3652,13 +3699,20 @@ static void sd_shutdown(struct device *dev)
 		sd_sync_cache(sdkp, NULL);
 	}
 
-	if (system_state != SYSTEM_RESTART && sdkp->device->manage_start_stop) {
+	if (system_state != SYSTEM_RESTART &&
+	    sdkp->device->manage_system_start_stop) {
 		sd_printk(KERN_NOTICE, sdkp, "Stopping disk\n");
 		sd_start_stop_device(sdkp, 0);
 	}
 }
 
-static int sd_suspend_common(struct device *dev, bool ignore_stop_errors)
+static inline bool sd_do_start_stop(struct scsi_device *sdev, bool runtime)
+{
+	return (sdev->manage_system_start_stop && !runtime) ||
+		(sdev->manage_runtime_start_stop && runtime);
+}
+
+static int sd_suspend_common(struct device *dev, bool runtime)
 {
 	struct scsi_disk *sdkp = dev_get_drvdata(dev);
 	struct scsi_sense_hdr sshdr;
@@ -3690,12 +3744,12 @@ static int sd_suspend_common(struct device *dev, bool ignore_stop_errors)
 		}
 	}
 
-	if (sdkp->device->manage_start_stop) {
+	if (sd_do_start_stop(sdkp->device, runtime)) {
 		if (!sdkp->device->silence_suspend)
 			sd_printk(KERN_NOTICE, sdkp, "Stopping disk\n");
 		/* an error is not worth aborting a system sleep */
 		ret = sd_start_stop_device(sdkp, 0);
-		if (ignore_stop_errors)
+		if (!runtime)
 			ret = 0;
 	}
 
@@ -3707,23 +3761,23 @@ static int sd_suspend_system(struct device *dev)
 	if (pm_runtime_suspended(dev))
 		return 0;
 
-	return sd_suspend_common(dev, true);
+	return sd_suspend_common(dev, false);
 }
 
 static int sd_suspend_runtime(struct device *dev)
 {
-	return sd_suspend_common(dev, false);
+	return sd_suspend_common(dev, true);
 }
 
-static int sd_resume(struct device *dev)
+static int sd_resume(struct device *dev, bool runtime)
 {
 	struct scsi_disk *sdkp = dev_get_drvdata(dev);
-	int ret = 0;
+	int ret;
 
 	if (!sdkp)	/* E.g.: runtime resume at the start of sd_probe() */
 		return 0;
 
-	if (!sdkp->device->manage_start_stop)
+	if (!sd_do_start_stop(sdkp->device, runtime))
 		return 0;
 
 	if (!sdkp->device->no_start_on_resume) {
@@ -3741,7 +3795,7 @@ static int sd_resume_system(struct device *dev)
 	if (pm_runtime_suspended(dev))
 		return 0;
 
-	return sd_resume(dev);
+	return sd_resume(dev, false);
 }
 
 static int sd_resume_runtime(struct device *dev)
@@ -3765,7 +3819,7 @@ static int sd_resume_runtime(struct device *dev)
 				  "Failed to clear sense data\n");
 	}
 
-	return sd_resume(dev);
+	return sd_resume(dev, true);
 }
 
 /**
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 9fdc77db3a2a8..dc2cff18b68bd 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -161,6 +161,10 @@ struct scsi_device {
 				 * pass settings from slave_alloc to scsi
 				 * core. */
 	unsigned int eh_timeout; /* Error handling timeout */
+
+	bool manage_system_start_stop; /* Let HLD (sd) manage system start/stop */
+	bool manage_runtime_start_stop; /* Let HLD (sd) manage runtime start/stop */
+
 	unsigned removable:1;
 	unsigned changed:1;	/* Data invalid due to media change */
 	unsigned busy:1;	/* Used to prevent races */
@@ -192,7 +196,6 @@ struct scsi_device {
 	unsigned use_192_bytes_for_3f:1; /* ask for 192 bytes from page 0x3f */
 	unsigned no_start_on_add:1;	/* do not issue start on add */
 	unsigned allow_restart:1; /* issue START_UNIT in error handler */
-	unsigned manage_start_stop:1;	/* Let HLD (sd) manage start/stop */
 	unsigned no_start_on_resume:1; /* Do not issue START_STOP_UNIT on resume */
 	unsigned start_stop_pwr_cond:1;	/* Set power cond. in START_STOP_UNIT */
 	unsigned no_uld_attach:1; /* disable connecting to upper level drivers */
-- 
2.40.1



