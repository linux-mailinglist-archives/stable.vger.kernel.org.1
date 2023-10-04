Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E967B98D1
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 01:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240917AbjJDXqb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 19:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjJDXqa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 19:46:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A54C9
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 16:46:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97815C433C7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 23:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696463187;
        bh=DECXNjWvV/9cuqHCIHYDpblzdFHoK7Yi9bFHd2mGxMY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=oYiMvwLnuzjorxkN2vAuAoM/DwrqL14qy2REmnktRQUFa6KZ3auX13yEEmw6z68tj
         s77FZ4thkg4CntRFlbZZP7gOp/3XLTmztSdXVo1KZ/ehfywpyOhPwdzjNUIfp3HTo6
         qDfUP0kcqneD3a9j2yAgz+AHyCHKLU3e379+hPo6TFkZ3p5PHQeqHHQ0sTR3YZLYOw
         czDvldDIZlg6NvD526XyPhSI8hLrJeY8qPN0xdajVEDXPQ1swB+WsiP98knV4r4VbA
         5T9te3+YyOu1qHTxahbnloAXXBAgH1pj/BG2mDOS6wuMp+w6MT5o0RGNooi6sfZgSb
         iHp+aaY+OC4DQ==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     stable@vger.kernel.org
Subject: [PATCH 6.5.y] ata: libata-scsi: Fix delayed scsi_rescan_device() execution
Date:   Thu,  5 Oct 2023 08:46:25 +0900
Message-ID: <20231004234625.237344-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023100443-freewill-shanty-0f05@gregkh>
References: <2023100443-freewill-shanty-0f05@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Commit 8b4d9469d0b0e553208ee6f62f2807111fde18b9 upstream.

Commit 6aa0365a3c85 ("ata: libata-scsi: Avoid deadlock on rescan after
device resume") modified ata_scsi_dev_rescan() to check the scsi device
"is_suspended" power field to ensure that the scsi device associated
with an ATA device is fully resumed when scsi_rescan_device() is
executed. However, this fix is problematic as:
1) It relies on a PM internal field that should not be used without PM
   device locking protection.
2) The check for is_suspended and the call to scsi_rescan_device() are
   not atomic and a suspend PM event may be triggered between them,
   casuing scsi_rescan_device() to be called on a suspended device and
   in that function blocking while holding the scsi device lock. This
   would deadlock a following resume operation.
These problems can trigger PM deadlocks on resume, especially with
resume operations triggered quickly after or during suspend operations.
E.g., a simple bash script like:

for (( i=0; i<10; i++ )); do
	echo "+2 > /sys/class/rtc/rtc0/wakealarm
	echo mem > /sys/power/state
done

that triggers a resume 2 seconds after starting suspending a system can
quickly lead to a PM deadlock preventing the system from correctly
resuming.

Fix this by replacing the check on is_suspended with a check on the
return value given by scsi_rescan_device() as that function will fail if
called against a suspended device. Also make sure rescan tasks already
scheduled are first cancelled before suspending an ata port.

Fixes: 6aa0365a3c85 ("ata: libata-scsi: Avoid deadlock on rescan after device resume")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
(cherry picked from commit 8b4d9469d0b0e553208ee6f62f2807111fde18b9)
---
 drivers/ata/libata-core.c | 16 ++++++++++++++++
 drivers/ata/libata-scsi.c | 33 +++++++++++++++------------------
 2 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 79d02eb4e479..397a06bcc0cc 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5245,11 +5245,27 @@ static const unsigned int ata_port_suspend_ehi = ATA_EHI_QUIET
 
 static void ata_port_suspend(struct ata_port *ap, pm_message_t mesg)
 {
+	/*
+	 * We are about to suspend the port, so we do not care about
+	 * scsi_rescan_device() calls scheduled by previous resume operations.
+	 * The next resume will schedule the rescan again. So cancel any rescan
+	 * that is not done yet.
+	 */
+	cancel_delayed_work_sync(&ap->scsi_rescan_task);
+
 	ata_port_request_pm(ap, mesg, 0, ata_port_suspend_ehi, false);
 }
 
 static void ata_port_suspend_async(struct ata_port *ap, pm_message_t mesg)
 {
+	/*
+	 * We are about to suspend the port, so we do not care about
+	 * scsi_rescan_device() calls scheduled by previous resume operations.
+	 * The next resume will schedule the rescan again. So cancel any rescan
+	 * that is not done yet.
+	 */
+	cancel_delayed_work_sync(&ap->scsi_rescan_task);
+
 	ata_port_request_pm(ap, mesg, 0, ata_port_suspend_ehi, true);
 }
 
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index c6ece32de8e3..90001d265336 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4861,7 +4861,7 @@ void ata_scsi_dev_rescan(struct work_struct *work)
 	struct ata_link *link;
 	struct ata_device *dev;
 	unsigned long flags;
-	bool delay_rescan = false;
+	int ret = 0;
 
 	mutex_lock(&ap->scsi_scan_mutex);
 	spin_lock_irqsave(ap->lock, flags);
@@ -4870,37 +4870,34 @@ void ata_scsi_dev_rescan(struct work_struct *work)
 		ata_for_each_dev(dev, link, ENABLED) {
 			struct scsi_device *sdev = dev->sdev;
 
+			/*
+			 * If the port was suspended before this was scheduled,
+			 * bail out.
+			 */
+			if (ap->pflags & ATA_PFLAG_SUSPENDED)
+				goto unlock;
+
 			if (!sdev)
 				continue;
 			if (scsi_device_get(sdev))
 				continue;
 
-			/*
-			 * If the rescan work was scheduled because of a resume
-			 * event, the port is already fully resumed, but the
-			 * SCSI device may not yet be fully resumed. In such
-			 * case, executing scsi_rescan_device() may cause a
-			 * deadlock with the PM code on device_lock(). Prevent
-			 * this by giving up and retrying rescan after a short
-			 * delay.
-			 */
-			delay_rescan = sdev->sdev_gendev.power.is_suspended;
-			if (delay_rescan) {
-				scsi_device_put(sdev);
-				break;
-			}
-
 			spin_unlock_irqrestore(ap->lock, flags);
-			scsi_rescan_device(&(sdev->sdev_gendev));
+			ret = scsi_rescan_device(&(sdev->sdev_gendev));
 			scsi_device_put(sdev);
 			spin_lock_irqsave(ap->lock, flags);
+
+			if (ret)
+				goto unlock;
 		}
 	}
 
+unlock:
 	spin_unlock_irqrestore(ap->lock, flags);
 	mutex_unlock(&ap->scsi_scan_mutex);
 
-	if (delay_rescan)
+	/* Reschedule with a delay if scsi_rescan_device() returned an error */
+	if (ret)
 		schedule_delayed_work(&ap->scsi_rescan_task,
 				      msecs_to_jiffies(5));
 }
-- 
2.41.0

