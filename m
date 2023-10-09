Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294617BDD20
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376693AbjJINHp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376684AbjJINHj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:07:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C669E
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:07:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D59C433C9;
        Mon,  9 Oct 2023 13:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696856856;
        bh=v4G/Ea6XyNvJV5KlSeRteDCOECioiJI+nulTMjzDLHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m9n1zbhej6cC1Nn1dTLJGOxr6C1hmx1D8XYTgXVjZ0dOvD8jThwjLhvOXX8U9O+Ah
         a0jgJQD4ycuqzDHX/8HjREd5gwKlccA5s1PeScxPNzae7mcijswInTomfI0CYYQZ0r
         4PEjpDtT/M1BZmm11HhK49uXN6w7vABfkCYHYSMU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 014/163] ata: libata-scsi: Fix delayed scsi_rescan_device() execution
Date:   Mon,  9 Oct 2023 14:59:38 +0200
Message-ID: <20231009130124.410214613@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit 8b4d9469d0b0e553208ee6f62f2807111fde18b9 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-core.c | 16 ++++++++++++++++
 drivers/ata/libata-scsi.c | 33 +++++++++++++++------------------
 2 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 76bf185a73c65..6ae9cff6b50c5 100644
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
index 22d7c26297889..ed3146c460910 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4900,7 +4900,7 @@ void ata_scsi_dev_rescan(struct work_struct *work)
 	struct ata_link *link;
 	struct ata_device *dev;
 	unsigned long flags;
-	bool delay_rescan = false;
+	int ret = 0;
 
 	mutex_lock(&ap->scsi_scan_mutex);
 	spin_lock_irqsave(ap->lock, flags);
@@ -4909,37 +4909,34 @@ void ata_scsi_dev_rescan(struct work_struct *work)
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
-			scsi_rescan_device(sdev);
+			ret = scsi_rescan_device(sdev);
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
2.40.1



