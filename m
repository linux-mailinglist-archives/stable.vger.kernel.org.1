Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCD17BDE1F
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376944AbjJINQL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376936AbjJINQJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:16:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DBF94
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:16:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EDEC433CA;
        Mon,  9 Oct 2023 13:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857366;
        bh=YsWxeSwCgJPN6geq7SY36Oi0xxm0GM6fH+QIBgzOQVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1sHHhRWIexF+kr+s5AI16I/tWLbCkGxylUSQ9ImpcMqwazF+lnH+GdzSigZDp9aDO
         0I/vBas77RBaybpRhNZBEPkBaMLJ1DdDuXsBIx9FV3qfYt5fIMfz46vYjP/Qobdmn1
         9Va0HNs44TJwPdkqmlw7wfWyw8qqqRMLowVTIGcg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paul Ausbeck <paula@soe.ucsc.edu>,
        Damien Le Moal <dlemoal@kernel.org>,
        Tanner Watkins <dalzot@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 015/162] ata,scsi: do not issue START STOP UNIT on resume
Date:   Mon,  9 Oct 2023 14:59:56 +0200
Message-ID: <20231009130123.369121104@linuxfoundation.org>
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

[ Upstream commit 0a8589055936d8feb56477123a8373ac634018fa ]

During system resume, ata_port_pm_resume() triggers ata EH to
1) Resume the controller
2) Reset and rescan the ports
3) Revalidate devices
This EH execution is started asynchronously from ata_port_pm_resume(),
which means that when sd_resume() is executed, none or only part of the
above processing may have been executed. However, sd_resume() issues a
START STOP UNIT to wake up the drive from sleep mode. This command is
translated to ATA with ata_scsi_start_stop_xlat() and issued to the
device. However, depending on the state of execution of the EH process
and revalidation triggerred by ata_port_pm_resume(), two things may
happen:
1) The START STOP UNIT fails if it is received before the controller has
   been reenabled at the beginning of the EH execution. This is visible
   with error messages like:

ata10.00: device reported invalid CHS sector 0
sd 9:0:0:0: [sdc] Start/Stop Unit failed: Result: hostbyte=DID_OK driverbyte=DRIVER_OK
sd 9:0:0:0: [sdc] Sense Key : Illegal Request [current]
sd 9:0:0:0: [sdc] Add. Sense: Unaligned write command
sd 9:0:0:0: PM: dpm_run_callback(): scsi_bus_resume+0x0/0x90 returns -5
sd 9:0:0:0: PM: failed to resume async: error -5

2) The START STOP UNIT command is received while the EH process is
   on-going, which mean that it is stopped and must wait for its
   completion, at which point the command is rather useless as the drive
   is already fully spun up already. This case results also in a
   significant delay in sd_resume() which is observable by users as
   the entire system resume completion is delayed.

Given that ATA devices will be woken up by libata activity on resume,
sd_resume() has no need to issue a START STOP UNIT command, which solves
the above mentioned problems. Do not issue this command by introducing
the new scsi_device flag no_start_on_resume and setting this flag to 1
in ata_scsi_dev_config(). sd_resume() is modified to issue a START STOP
UNIT command only if this flag is not set.

Reported-by: Paul Ausbeck <paula@soe.ucsc.edu>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=215880
Fixes: a19a93e4c6a9 ("scsi: core: pm: Rely on the device driver core for async power management")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Tested-by: Tanner Watkins <dalzot@gmail.com>
Tested-by: Paul Ausbeck <paula@soe.ucsc.edu>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Stable-dep-of: 99398d2070ab ("scsi: sd: Do not issue commands to suspended disks on shutdown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-scsi.c  | 7 +++++++
 drivers/scsi/sd.c          | 9 ++++++---
 include/scsi/scsi_device.h | 1 +
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d28628b964e29..9c8dd9f86cbb3 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1081,7 +1081,14 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
 		}
 	} else {
 		sdev->sector_size = ata_id_logical_sector_size(dev->id);
+		/*
+		 * Stop the drive on suspend but do not issue START STOP UNIT
+		 * on resume as this is not necessary and may fail: the device
+		 * will be woken up by ata_port_pm_resume() with a port reset
+		 * and device revalidation.
+		 */
 		sdev->manage_start_stop = 1;
+		sdev->no_start_on_resume = 1;
 	}
 
 	/*
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index e934779bf05c8..5bfca49415113 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3718,7 +3718,7 @@ static int sd_suspend_runtime(struct device *dev)
 static int sd_resume(struct device *dev)
 {
 	struct scsi_disk *sdkp = dev_get_drvdata(dev);
-	int ret;
+	int ret = 0;
 
 	if (!sdkp)	/* E.g.: runtime resume at the start of sd_probe() */
 		return 0;
@@ -3726,8 +3726,11 @@ static int sd_resume(struct device *dev)
 	if (!sdkp->device->manage_start_stop)
 		return 0;
 
-	sd_printk(KERN_NOTICE, sdkp, "Starting disk\n");
-	ret = sd_start_stop_device(sdkp, 1);
+	if (!sdkp->device->no_start_on_resume) {
+		sd_printk(KERN_NOTICE, sdkp, "Starting disk\n");
+		ret = sd_start_stop_device(sdkp, 1);
+	}
+
 	if (!ret)
 		opal_unlock_from_suspend(sdkp->opal_dev);
 	return ret;
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 006858ed04e8c..9fdc77db3a2a8 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -193,6 +193,7 @@ struct scsi_device {
 	unsigned no_start_on_add:1;	/* do not issue start on add */
 	unsigned allow_restart:1; /* issue START_UNIT in error handler */
 	unsigned manage_start_stop:1;	/* Let HLD (sd) manage start/stop */
+	unsigned no_start_on_resume:1; /* Do not issue START_STOP_UNIT on resume */
 	unsigned start_stop_pwr_cond:1;	/* Set power cond. in START_STOP_UNIT */
 	unsigned no_uld_attach:1; /* disable connecting to upper level drivers */
 	unsigned select_no_atn:1;
-- 
2.40.1



