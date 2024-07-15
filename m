Return-Path: <stable+bounces-59306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E09493117F
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 11:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFE5AB23457
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 09:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F3A186E53;
	Mon, 15 Jul 2024 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r1a3ITj8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6594186E51
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721036542; cv=none; b=ChG/9wGR9kbqyXTlyAbMfyow3eDQhMJn2KkbPBIFjv71jvjshLZOHpGrSq+1RTBw4SpviFtHA0pSTGBayIVCRXkoVXo5kF4x2rTWU/FFKYcNo37yiia/GPNL5U5AFRXh7rY9bIfLrkYMGJCw1CRIOX/CDLaJw8Xryf2hDKRm8BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721036542; c=relaxed/simple;
	bh=q8fpQmkTEj7DiuzlhRzcdENRDhqWu9IUcxuUMjqinDE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pEZBwM5KPMTUf13alDUenhApcMay/DFiagVDsZ1NCGBLng2qJqJ6FuZ0jvSl/VRSJGk5s+IOpJU5UyV6R7jDz95ajOIf1thcf2mQBPrTPvwN/022xAnI2+ME8jK4FmFKd2oQ0hyfzeqqdkgdu5ktQebDmA96y4uv2Pa6H91H5HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r1a3ITj8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5F3C32782;
	Mon, 15 Jul 2024 09:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721036542;
	bh=q8fpQmkTEj7DiuzlhRzcdENRDhqWu9IUcxuUMjqinDE=;
	h=Subject:To:Cc:From:Date:From;
	b=r1a3ITj8EkxcWQkN3VWBUiE2AOpVW/cFJz2H0nWV2XmFJcrgL7SqiIhoFsXXlLtoR
	 xccZSvFJ3KQHGKFzPCpI/fhA8ofo5AXF0P5Bt6XO6s44D46HjwGulwixvqvp7cIHCU
	 OzsELTUHxW7+gaNumOqFcMNmb3r+Tz45GuRDNnao=
Subject: FAILED: patch "[PATCH] scsi: sd: Do not repeat the starting disk message" failed to apply to 6.1-stable tree
To: dlemoal@kernel.org,bvanassche@acm.org,john.g.garry@oracle.com,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jul 2024 11:42:19 +0200
Message-ID: <2024071518-municipal-zigzagged-a93d@gregkh>
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
git cherry-pick -x 7a6bbc2829d4ab592c7e440a6f6f5deb3cd95db4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024071518-municipal-zigzagged-a93d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

7a6bbc2829d4 ("scsi: sd: Do not repeat the starting disk message")
0c76106cb975 ("scsi: sd: Fix TCG OPAL unlock on system resume")
c4367ac83805 ("scsi: Remove scsi device no_start_on_resume flag")
99398d2070ab ("scsi: sd: Do not issue commands to suspended disks on shutdown")
8b4d9469d0b0 ("ata: libata-scsi: Fix delayed scsi_rescan_device() execution")
ff48b37802e5 ("scsi: Do not attempt to rescan suspended devices")
aa3998dbeb3a ("ata: libata-scsi: Disable scsi device manage_system_start_stop")
3cc2ffe5c16d ("scsi: sd: Differentiate system and runtime start/stop management")
2a5a4326e583 ("Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7a6bbc2829d4ab592c7e440a6f6f5deb3cd95db4 Mon Sep 17 00:00:00 2001
From: Damien Le Moal <dlemoal@kernel.org>
Date: Tue, 2 Jul 2024 06:53:26 +0900
Subject: [PATCH] scsi: sd: Do not repeat the starting disk message

The SCSI disk message "Starting disk" to signal resuming of a suspended
disk is printed in both sd_resume() and sd_resume_common() which results
in this message being printed twice when resuming from e.g. autosuspend:

$ echo 5000 > /sys/block/sda/device/power/autosuspend_delay_ms
$ echo auto > /sys/block/sda/device/power/control

[ 4962.438293] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[ 4962.501121] sd 0:0:0:0: [sda] Stopping disk

$ echo on > /sys/block/sda/device/power/control

[ 4972.805851] sd 0:0:0:0: [sda] Starting disk
[ 4980.558806] sd 0:0:0:0: [sda] Starting disk

Fix this double print by removing the call to sd_printk() from sd_resume()
and moving the call to sd_printk() in sd_resume_common() earlier in the
function, before the check using sd_do_start_stop().  Doing so, the message
is printed once regardless if sd_resume_common() actually executes
sd_start_stop_device() (i.e. SCSI device case) or not (libsas and libata
managed ATA devices case).

Fixes: 0c76106cb975 ("scsi: sd: Fix TCG OPAL unlock on system resume")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Link: https://lore.kernel.org/r/20240701215326.128067-1-dlemoal@kernel.org
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index fe82baa924f8..6203915945a4 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -4117,8 +4117,6 @@ static int sd_resume(struct device *dev)
 {
 	struct scsi_disk *sdkp = dev_get_drvdata(dev);
 
-	sd_printk(KERN_NOTICE, sdkp, "Starting disk\n");
-
 	if (opal_unlock_from_suspend(sdkp->opal_dev)) {
 		sd_printk(KERN_NOTICE, sdkp, "OPAL unlock failed\n");
 		return -EIO;
@@ -4135,12 +4133,13 @@ static int sd_resume_common(struct device *dev, bool runtime)
 	if (!sdkp)	/* E.g.: runtime resume at the start of sd_probe() */
 		return 0;
 
+	sd_printk(KERN_NOTICE, sdkp, "Starting disk\n");
+
 	if (!sd_do_start_stop(sdkp->device, runtime)) {
 		sdkp->suspended = false;
 		return 0;
 	}
 
-	sd_printk(KERN_NOTICE, sdkp, "Starting disk\n");
 	ret = sd_start_stop_device(sdkp, 1);
 	if (!ret) {
 		sd_resume(dev);


