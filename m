Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3F87B8AA5
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244478AbjJDShX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244487AbjJDShW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:37:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1E6CE
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:37:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837A5C433C8;
        Wed,  4 Oct 2023 18:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444638;
        bh=vMaFqrf74YGEctJx9V23KLcJ1iKOtmlG/qi50ut5PkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6zapxMRVaEu7we+bvL9vXVCdWG6fVT18BTEbN4KaOGReYpp92CEE5s/VoW4a7F0x
         ownbpx489NJrd6zQqa1rYvPy0yDEtJ3mRfyN28IWvFDyCzsxwc+Acu4YKZcprAxPxU
         5esqPOkRP2OQWUeemVP6/B4br1K2mKUvt0YlKzKY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.5 304/321] ata: libata-core: Fix port and device removal
Date:   Wed,  4 Oct 2023 19:57:29 +0200
Message-ID: <20231004175243.378369593@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <dlemoal@kernel.org>

commit 84d76529c650f887f1e18caee72d6f0589e1baf9 upstream.

Whenever an ATA adapter driver is removed (e.g. rmmod),
ata_port_detach() is called repeatedly for all the adapter ports to
remove (unload) the devices attached to the port and delete the port
device itself. Removing of devices is done using libata EH with the
ATA_PFLAG_UNLOADING port flag set. This causes libata EH to execute
ata_eh_unload() which disables all devices attached to the port.

ata_port_detach() finishes by calling scsi_remove_host() to remove the
scsi host associated with the port. This function will trigger the
removal of all scsi devices attached to the host and in the case of
disks, calls to sd_shutdown() which will flush the device write cache
and stop the device. However, given that the devices were already
disabled by ata_eh_unload(), the synchronize write cache command and
start stop unit commands fail. E.g. running "rmmod ahci" with first
removing sd_mod results in error messages like:

ata13.00: disable device
sd 0:0:0:0: [sda] Synchronizing SCSI cache
sd 0:0:0:0: [sda] Synchronize Cache(10) failed: Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
sd 0:0:0:0: [sda] Stopping disk
sd 0:0:0:0: [sda] Start/Stop Unit failed: Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK

Fix this by removing all scsi devices of the ata devices connected to
the port before scheduling libata EH to disable the ATA devices.

Fixes: 720ba12620ee ("[PATCH] libata-hp: update unload-unplug")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
Tested-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libata-core.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6130,11 +6130,30 @@ static void ata_port_detach(struct ata_p
 	if (!ap->ops->error_handler)
 		goto skip_eh;
 
-	/* tell EH we're leaving & flush EH */
+	/* Wait for any ongoing EH */
+	ata_port_wait_eh(ap);
+
+	mutex_lock(&ap->scsi_scan_mutex);
 	spin_lock_irqsave(ap->lock, flags);
+
+	/* Remove scsi devices */
+	ata_for_each_link(link, ap, HOST_FIRST) {
+		ata_for_each_dev(dev, link, ALL) {
+			if (dev->sdev) {
+				spin_unlock_irqrestore(ap->lock, flags);
+				scsi_remove_device(dev->sdev);
+				spin_lock_irqsave(ap->lock, flags);
+				dev->sdev = NULL;
+			}
+		}
+	}
+
+	/* Tell EH to disable all devices */
 	ap->pflags |= ATA_PFLAG_UNLOADING;
 	ata_port_schedule_eh(ap);
+
 	spin_unlock_irqrestore(ap->lock, flags);
+	mutex_unlock(&ap->scsi_scan_mutex);
 
 	/* wait till EH commits suicide */
 	ata_port_wait_eh(ap);


