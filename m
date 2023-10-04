Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB7D7B98CE
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 01:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjJDXp2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 19:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjJDXp0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 19:45:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D47C0
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 16:45:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D76AC433C9
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 23:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696463123;
        bh=tayR7Jy7frkBTgp3JcVAmK3a/JhmWLNkTa2UbtmuRTQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=k9EBV/4cMyc/6MlEXONcSiKL2WrI0gIP5PnlhYQduJs25TRWB1JeHjs85DXuYkt9J
         CXqN84r56guGA68gQbFXnWLcFnAvPssZHNrteh5yfI7PWtcPGuVPboIrU2XHMzPRjN
         reVa/FFjuGrudUtc2q1PmhPPiU3iGQ1jYiqjy254fpzumWTeIf7MTZra55ili7RhD0
         DgvfBTh1EYsext6LY93bTBGfd36X2hv/uOa6YRHD7sg/wcOW7Gy/MOgA6ZsPiRXVhV
         y00MSRE+zh0zp5GQcDYD2ksODr1ykA104iy8RumX68yC/ca8qUtIUcYVMHhMW6l7wa
         9IM/Uid2TXCWQ==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     stable@vger.kernel.org
Subject: [PATCH 6.5.y] scsi: Do not attempt to rescan suspended devices
Date:   Thu,  5 Oct 2023 08:45:21 +0900
Message-ID: <20231004234521.237241-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023100454-hamper-falsify-595d@gregkh>
References: <2023100454-hamper-falsify-595d@gregkh>
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

Commit ff48b37802e5c134e2dfc4d091f10b2eb5065a72 upstream.

scsi_rescan_device() takes a scsi device lock before executing a device
handler and device driver rescan methods. Waiting for the completion of
any command issued to the device by these methods will thus be done with
the device lock held. As a result, there is a risk of deadlocking within
the power management code if scsi_rescan_device() is called to handle a
device resume with the associated scsi device not yet resumed.

Avoid such situation by checking that the target scsi device is in the
running state, that is, fully capable of executing commands, before
proceeding with the rescan and bailout returning -EWOULDBLOCK otherwise.
With this error return, the caller can retry rescaning the device after
a delay.

The state check is done with the device lock held and is thus safe
against incoming suspend power management operations.

Fixes: 6aa0365a3c85 ("ata: libata-scsi: Avoid deadlock on rescan after device resume")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
(cherry picked from commit ff48b37802e5c134e2dfc4d091f10b2eb5065a72)
---
 drivers/scsi/scsi_priv.h |  2 +-
 drivers/scsi/scsi_scan.c | 18 +++++++++++++++++-
 include/scsi/scsi_host.h |  2 +-
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index f42388ecb024..30861e7e6850 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -138,7 +138,7 @@ extern int scsi_complete_async_scans(void);
 extern int scsi_scan_host_selected(struct Scsi_Host *, unsigned int,
 				   unsigned int, u64, enum scsi_scan_mode);
 extern void scsi_forget_host(struct Scsi_Host *);
-extern void scsi_rescan_device(struct device *);
+extern int scsi_rescan_device(struct device *dev);
 
 /* scsi_sysctl.c */
 #ifdef CONFIG_SYSCTL
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index aa13feb17c62..5d4d3d48e3f0 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1619,12 +1619,24 @@ int scsi_add_device(struct Scsi_Host *host, uint channel,
 }
 EXPORT_SYMBOL(scsi_add_device);
 
-void scsi_rescan_device(struct device *dev)
+int scsi_rescan_device(struct device *dev)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
+	int ret = 0;
 
 	device_lock(dev);
 
+	/*
+	 * Bail out if the device is not running. Otherwise, the rescan may
+	 * block waiting for commands to be executed, with us holding the
+	 * device lock. This can result in a potential deadlock in the power
+	 * management core code when system resume is on-going.
+	 */
+	if (sdev->sdev_state != SDEV_RUNNING) {
+		ret = -EWOULDBLOCK;
+		goto unlock;
+	}
+
 	scsi_attach_vpd(sdev);
 	scsi_cdl_check(sdev);
 
@@ -1638,7 +1650,11 @@ void scsi_rescan_device(struct device *dev)
 			drv->rescan(dev);
 		module_put(dev->driver->owner);
 	}
+
+unlock:
 	device_unlock(dev);
+
+	return ret;
 }
 EXPORT_SYMBOL(scsi_rescan_device);
 
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index a2b8d30c4c80..4fa55d88d492 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -764,7 +764,7 @@ scsi_template_proc_dir(const struct scsi_host_template *sht);
 #define scsi_template_proc_dir(sht) NULL
 #endif
 extern void scsi_scan_host(struct Scsi_Host *);
-extern void scsi_rescan_device(struct device *);
+extern int scsi_rescan_device(struct device *dev);
 extern void scsi_remove_host(struct Scsi_Host *);
 extern struct Scsi_Host *scsi_host_get(struct Scsi_Host *);
 extern int scsi_host_busy(struct Scsi_Host *shost);
-- 
2.41.0

