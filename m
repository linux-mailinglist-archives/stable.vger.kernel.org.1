Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2D47B8259
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 16:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242798AbjJDOaq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 10:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242817AbjJDOap (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 10:30:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564D1BD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 07:30:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76200C433C7;
        Wed,  4 Oct 2023 14:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696429842;
        bh=CToBknEb5Zkz0gMzZwoRpuLTZWpCgUN6J17j5Mnns4A=;
        h=Subject:To:Cc:From:Date:From;
        b=eoQDJbEJq8vzIv7p7KFlduGiEUgEslHFCC6mpTuNu542lYh/3HnLCqmQIJwZgXCmS
         cwimjvj9JBUCxnRzpaIleX6ukzVB6vk8SxWyIyND5oWJ8CQM4Ay7nzxmJSioGKfzvM
         GKE9zfCZblfj/TnIjineeoHAxCnn2QLZNp+WDL5c=
Subject: FAILED: patch "[PATCH] scsi: sd: Do not issue commands to suspended disks on" failed to apply to 6.1-stable tree
To:     dlemoal@kernel.org, bvanassche@acm.org, hare@suse.de,
        martin.petersen@oracle.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 04 Oct 2023 16:30:38 +0200
Message-ID: <2023100438-oblivion-stowing-20c5@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 99398d2070ab03d13f90b758ad397e19a65fffb0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100438-oblivion-stowing-20c5@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 99398d2070ab03d13f90b758ad397e19a65fffb0 Mon Sep 17 00:00:00 2001
From: Damien Le Moal <dlemoal@kernel.org>
Date: Fri, 8 Sep 2023 17:03:15 +0900
Subject: [PATCH] scsi: sd: Do not issue commands to suspended disks on
 shutdown

If an error occurs when resuming a host adapter before the devices
attached to the adapter are resumed, the adapter low level driver may
remove the scsi host, resulting in a call to sd_remove() for the
disks of the host. This in turn results in a call to sd_shutdown() which
will issue a synchronize cache command and a start stop unit command to
spindown the disk. sd_shutdown() issues the commands only if the device
is not already runtime suspended but does not check the power state for
system-wide suspend/resume. That is, the commands may be issued with the
device in a suspended state, which causes PM resume to hang, forcing a
reset of the machine to recover.

Fix this by tracking the suspended state of a disk by introducing the
suspended boolean field in the scsi_disk structure. This flag is set to
true when the disk is suspended is sd_suspend_common() and resumed with
sd_resume(). When suspended is true, sd_shutdown() is not executed from
sd_remove().

Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 5a1b802d180f..83b6a3f3863b 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3741,7 +3741,8 @@ static int sd_remove(struct device *dev)
 
 	device_del(&sdkp->disk_dev);
 	del_gendisk(sdkp->disk);
-	sd_shutdown(dev);
+	if (!sdkp->suspended)
+		sd_shutdown(dev);
 
 	put_disk(sdkp->disk);
 	return 0;
@@ -3872,6 +3873,9 @@ static int sd_suspend_common(struct device *dev, bool runtime)
 			ret = 0;
 	}
 
+	if (!ret)
+		sdkp->suspended = true;
+
 	return ret;
 }
 
@@ -3891,21 +3895,26 @@ static int sd_suspend_runtime(struct device *dev)
 static int sd_resume(struct device *dev, bool runtime)
 {
 	struct scsi_disk *sdkp = dev_get_drvdata(dev);
-	int ret;
+	int ret = 0;
 
 	if (!sdkp)	/* E.g.: runtime resume at the start of sd_probe() */
 		return 0;
 
-	if (!sd_do_start_stop(sdkp->device, runtime))
+	if (!sd_do_start_stop(sdkp->device, runtime)) {
+		sdkp->suspended = false;
 		return 0;
+	}
 
 	if (!sdkp->device->no_start_on_resume) {
 		sd_printk(KERN_NOTICE, sdkp, "Starting disk\n");
 		ret = sd_start_stop_device(sdkp, 1);
 	}
 
-	if (!ret)
+	if (!ret) {
 		opal_unlock_from_suspend(sdkp->opal_dev);
+		sdkp->suspended = false;
+	}
+
 	return ret;
 }
 
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 5eea762f84d1..409dda5350d1 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -131,6 +131,7 @@ struct scsi_disk {
 	u8		provisioning_mode;
 	u8		zeroing_mode;
 	u8		nr_actuators;		/* Number of actuators */
+	bool		suspended;	/* Disk is suspended (stopped) */
 	unsigned	ATO : 1;	/* state of disk ATO bit */
 	unsigned	cache_override : 1; /* temp override of WCE,RCD */
 	unsigned	WCE : 1;	/* state of disk WCE bit */

