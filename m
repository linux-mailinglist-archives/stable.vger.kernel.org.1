Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF6B73E8A6
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjFZS2L (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjFZS1k (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:27:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD7F2139
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:27:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D2CF60E76
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98807C433C9;
        Mon, 26 Jun 2023 18:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804033;
        bh=o55GBpZFcIEWLBySimbT8MCSm5JynwD2K2UG/V9bkCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MRjjwLuLz3igyMNs0qq8g9bX/814/M8sNCVPfVOQVofR2hlv+NgCr61JKjCm4B5RD
         DI3MddI7Iw2sEl1D/bVHaNHahZ+eoBwPcwyElXIxB9oxTQE1hp/zojE7nq1uc4Vv6S
         l/p0tAqPCOOUgeDa9QRLm8GYxBUkOFiX+ILAMidQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Joe Breuer <linux-kernel@jmbreuer.net>,
        Damien Le Moal <dlemoal@kernel.org>,
        Hannes Reinecke <hare@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 006/170] ata: libata-scsi: Avoid deadlock on rescan after device resume
Date:   Mon, 26 Jun 2023 20:09:35 +0200
Message-ID: <20230626180800.790347981@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit 6aa0365a3c8512587fffd42fe438768709ddef8e ]

When an ATA port is resumed from sleep, the port is reset and a power
management request issued to libata EH to reset the port and rescanning
the device(s) attached to the port. Device rescanning is done by
scheduling an ata_scsi_dev_rescan() work, which will execute
scsi_rescan_device().

However, scsi_rescan_device() takes the generic device lock, which is
also taken by dpm_resume() when the SCSI device is resumed as well. If
a device rescan execution starts before the completion of the SCSI
device resume, the rcu locking used to refresh the cached VPD pages of
the device, combined with the generic device locking from
scsi_rescan_device() and from dpm_resume() can cause a deadlock.

Avoid this situation by changing struct ata_port scsi_rescan_task to be
a delayed work instead of a simple work_struct. ata_scsi_dev_rescan() is
modified to check if the SCSI device associated with the ATA device that
must be rescanned is not suspended. If the SCSI device is still
suspended, ata_scsi_dev_rescan() returns early and reschedule itself for
execution after an arbitrary delay of 5ms.

Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reported-by: Joe Breuer <linux-kernel@jmbreuer.net>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217530
Fixes: a19a93e4c6a9 ("scsi: core: pm: Rely on the device driver core for async power management")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Joe Breuer <linux-kernel@jmbreuer.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-core.c |  3 ++-
 drivers/ata/libata-eh.c   |  2 +-
 drivers/ata/libata-scsi.c | 22 +++++++++++++++++++++-
 include/linux/libata.h    |  2 +-
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a5ea144722fa3..0ba0c3d1613f1 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5313,7 +5313,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 
 	mutex_init(&ap->scsi_scan_mutex);
 	INIT_DELAYED_WORK(&ap->hotplug_task, ata_scsi_hotplug);
-	INIT_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan);
+	INIT_DELAYED_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan);
 	INIT_LIST_HEAD(&ap->eh_done_q);
 	init_waitqueue_head(&ap->eh_wait_q);
 	init_completion(&ap->park_req_pending);
@@ -5919,6 +5919,7 @@ static void ata_port_detach(struct ata_port *ap)
 	WARN_ON(!(ap->pflags & ATA_PFLAG_UNLOADED));
 
 	cancel_delayed_work_sync(&ap->hotplug_task);
+	cancel_delayed_work_sync(&ap->scsi_rescan_task);
 
  skip_eh:
 	/* clean up zpodd on port removal */
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 08e11bc312c28..a3ae5fc2a42fc 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2973,7 +2973,7 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 			ehc->i.flags |= ATA_EHI_SETMODE;
 
 			/* schedule the scsi_rescan_device() here */
-			schedule_work(&(ap->scsi_rescan_task));
+			schedule_delayed_work(&ap->scsi_rescan_task, 0);
 		} else if (dev->class == ATA_DEV_UNKNOWN &&
 			   ehc->tries[dev->devno] &&
 			   ata_class_enabled(ehc->classes[dev->devno])) {
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 39e1ff9b686b9..9c0052d28078a 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4601,10 +4601,11 @@ int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
 void ata_scsi_dev_rescan(struct work_struct *work)
 {
 	struct ata_port *ap =
-		container_of(work, struct ata_port, scsi_rescan_task);
+		container_of(work, struct ata_port, scsi_rescan_task.work);
 	struct ata_link *link;
 	struct ata_device *dev;
 	unsigned long flags;
+	bool delay_rescan = false;
 
 	mutex_lock(&ap->scsi_scan_mutex);
 	spin_lock_irqsave(ap->lock, flags);
@@ -4618,6 +4619,21 @@ void ata_scsi_dev_rescan(struct work_struct *work)
 			if (scsi_device_get(sdev))
 				continue;
 
+			/*
+			 * If the rescan work was scheduled because of a resume
+			 * event, the port is already fully resumed, but the
+			 * SCSI device may not yet be fully resumed. In such
+			 * case, executing scsi_rescan_device() may cause a
+			 * deadlock with the PM code on device_lock(). Prevent
+			 * this by giving up and retrying rescan after a short
+			 * delay.
+			 */
+			delay_rescan = sdev->sdev_gendev.power.is_suspended;
+			if (delay_rescan) {
+				scsi_device_put(sdev);
+				break;
+			}
+
 			spin_unlock_irqrestore(ap->lock, flags);
 			scsi_rescan_device(&(sdev->sdev_gendev));
 			scsi_device_put(sdev);
@@ -4627,4 +4643,8 @@ void ata_scsi_dev_rescan(struct work_struct *work)
 
 	spin_unlock_irqrestore(ap->lock, flags);
 	mutex_unlock(&ap->scsi_scan_mutex);
+
+	if (delay_rescan)
+		schedule_delayed_work(&ap->scsi_rescan_task,
+				      msecs_to_jiffies(5));
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index fe990176e6ee9..9713f4d8f15f4 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -834,7 +834,7 @@ struct ata_port {
 
 	struct mutex		scsi_scan_mutex;
 	struct delayed_work	hotplug_task;
-	struct work_struct	scsi_rescan_task;
+	struct delayed_work	scsi_rescan_task;
 
 	unsigned int		hsm_task_state;
 
-- 
2.39.2



