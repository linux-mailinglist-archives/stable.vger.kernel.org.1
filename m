Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65ACA7DD40D
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbjJaRGy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236519AbjJaRGi (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:06:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E8B10F8
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:04:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9996C433C7;
        Tue, 31 Oct 2023 17:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698771899;
        bh=vrLzXWM8Y/YcXFep2ISp9+IhSZZAsGyzwzz1Rq555JY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bbuC672BjS5EwdlTYa9CYPELTv8CuTl5QcX8aoQcfTY8Q79qjt6NaaV8efHzH3rai
         SaAOIuUdKFwBv8rJ27pA7kdyrX3gKhx2ne0e9TefeM8dEpbez+TXXIKOmZtzlyfs+k
         8lAJ4jfqwf67tbvbgT2wj8NVUwHdvMVVRCgZAejM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1 56/86] scsi: sd: Introduce manage_shutdown device flag
Date:   Tue, 31 Oct 2023 18:01:21 +0100
Message-ID: <20231031165920.318011844@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
References: <20231031165918.608547597@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <dlemoal@kernel.org>

commit 24eca2dce0f8d19db808c972b0281298d0bafe99 upstream.

Commit aa3998dbeb3a ("ata: libata-scsi: Disable scsi device
manage_system_start_stop") change setting the manage_system_start_stop
flag to false for libata managed disks to enable libata internal
management of disk suspend/resume. However, a side effect of this change
is that on system shutdown, disks are no longer being stopped (set to
standby mode with the heads unloaded). While this is not a critical
issue, this unclean shutdown is not recommended and shows up with
increased smart counters (e.g. the unexpected power loss counter
"Unexpect_Power_Loss_Ct").

Instead of defining a shutdown driver method for all ATA adapter
drivers (not all of them define that operation), this patch resolves
this issue by further refining the sd driver start/stop control of disks
using the new flag manage_shutdown. If this new flag is set to true by
a low level driver, the function sd_shutdown() will issue a
START STOP UNIT command with the start argument set to 0 when a disk
needs to be powered off (suspended) on system power off, that is, when
system_state is equal to SYSTEM_POWER_OFF.

Similarly to the other manage_xxx flags, the new manage_shutdown flag is
exposed through sysfs as a read-write device attribute.

To avoid any confusion between manage_shutdown and
manage_system_start_stop, the comments describing these flags in
include/scsi/scsi.h are also improved.

Fixes: aa3998dbeb3a ("ata: libata-scsi: Disable scsi device manage_system_start_stop")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218038
Link: https://lore.kernel.org/all/cd397c88-bf53-4768-9ab8-9d107df9e613@gmail.com/
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libata-scsi.c  |    5 +++--
 drivers/firewire/sbp2.c    |    1 +
 drivers/scsi/sd.c          |   39 ++++++++++++++++++++++++++++++++++++---
 include/scsi/scsi_device.h |   20 ++++++++++++++++++--
 4 files changed, 58 insertions(+), 7 deletions(-)

--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1084,10 +1084,11 @@ int ata_scsi_dev_config(struct scsi_devi
 
 		/*
 		 * Ask the sd driver to issue START STOP UNIT on runtime suspend
-		 * and resume only. For system level suspend/resume, devices
-		 * power state is handled directly by libata EH.
+		 * and resume and shutdown only. For system level suspend/resume,
+		 * devices power state is handled directly by libata EH.
 		 */
 		sdev->manage_runtime_start_stop = true;
+		sdev->manage_shutdown = true;
 	}
 
 	/*
--- a/drivers/firewire/sbp2.c
+++ b/drivers/firewire/sbp2.c
@@ -1521,6 +1521,7 @@ static int sbp2_scsi_slave_configure(str
 	if (sbp2_param_exclusive_login) {
 		sdev->manage_system_start_stop = true;
 		sdev->manage_runtime_start_stop = true;
+		sdev->manage_shutdown = true;
 	}
 
 	if (sdev->type == TYPE_ROM)
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -221,7 +221,8 @@ manage_start_stop_show(struct device *de
 
 	return sysfs_emit(buf, "%u\n",
 			  sdp->manage_system_start_stop &&
-			  sdp->manage_runtime_start_stop);
+			  sdp->manage_runtime_start_stop &&
+			  sdp->manage_shutdown);
 }
 static DEVICE_ATTR_RO(manage_start_stop);
 
@@ -287,6 +288,35 @@ manage_runtime_start_stop_store(struct d
 }
 static DEVICE_ATTR_RW(manage_runtime_start_stop);
 
+static ssize_t manage_shutdown_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct scsi_disk *sdkp = to_scsi_disk(dev);
+	struct scsi_device *sdp = sdkp->device;
+
+	return sysfs_emit(buf, "%u\n", sdp->manage_shutdown);
+}
+
+static ssize_t manage_shutdown_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
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
+	sdp->manage_shutdown = v;
+
+	return count;
+}
+static DEVICE_ATTR_RW(manage_shutdown);
+
 static ssize_t
 allow_restart_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -619,6 +649,7 @@ static struct attribute *sd_disk_attrs[]
 	&dev_attr_manage_start_stop.attr,
 	&dev_attr_manage_system_start_stop.attr,
 	&dev_attr_manage_runtime_start_stop.attr,
+	&dev_attr_manage_shutdown.attr,
 	&dev_attr_protection_type.attr,
 	&dev_attr_protection_mode.attr,
 	&dev_attr_app_tag_own.attr,
@@ -3700,8 +3731,10 @@ static void sd_shutdown(struct device *d
 		sd_sync_cache(sdkp, NULL);
 	}
 
-	if (system_state != SYSTEM_RESTART &&
-	    sdkp->device->manage_system_start_stop) {
+	if ((system_state != SYSTEM_RESTART &&
+	     sdkp->device->manage_system_start_stop) ||
+	    (system_state == SYSTEM_POWER_OFF &&
+	     sdkp->device->manage_shutdown)) {
 		sd_printk(KERN_NOTICE, sdkp, "Stopping disk\n");
 		sd_start_stop_device(sdkp, 0);
 	}
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -162,8 +162,24 @@ struct scsi_device {
 				 * core. */
 	unsigned int eh_timeout; /* Error handling timeout */
 
-	bool manage_system_start_stop; /* Let HLD (sd) manage system start/stop */
-	bool manage_runtime_start_stop; /* Let HLD (sd) manage runtime start/stop */
+	/*
+	 * If true, let the high-level device driver (sd) manage the device
+	 * power state for system suspend/resume (suspend to RAM and
+	 * hibernation) operations.
+	 */
+	bool manage_system_start_stop;
+
+	/*
+	 * If true, let the high-level device driver (sd) manage the device
+	 * power state for runtime device suspand and resume operations.
+	 */
+	bool manage_runtime_start_stop;
+
+	/*
+	 * If true, let the high-level device driver (sd) manage the device
+	 * power state for system shutdown (power off) operations.
+	 */
+	bool manage_shutdown;
 
 	unsigned removable:1;
 	unsigned changed:1;	/* Data invalid due to media change */


