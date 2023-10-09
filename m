Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADAD7BE0AE
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376840AbjJINmz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377394AbjJINmy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:42:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B81B9
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:42:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59387C433C8;
        Mon,  9 Oct 2023 13:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858972;
        bh=nPcO1lc7YcUqkJHgPZJnSiSnUT09839cIDEDeAkNuqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YjqjEZ5gAUOFXCOjbwoIwnVbdHs+4ArqcIFK33xzvJVpQzG9dd771kjuAV4Bqf4Sl
         QEez3YaJunjW7gBwc1zNQrVTdleqnEo3LYrhHxxNhyjn6BjG3iLue+QKdGAt0JWpS5
         4c6MdIeFfCbXd0HUcke4ZdxaLLU15MwqVnn/uNvw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 5.10 159/226] ata: libata-core: Fix ata_port_request_pm() locking
Date:   Mon,  9 Oct 2023 15:02:00 +0200
Message-ID: <20231009130130.841999728@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <dlemoal@kernel.org>

commit 3b8e0af4a7a331d1510e963b8fd77e2fca0a77f1 upstream.

The function ata_port_request_pm() checks the port flag
ATA_PFLAG_PM_PENDING and calls ata_port_wait_eh() if this flag is set to
ensure that power management operations for a port are not scheduled
simultaneously. However, this flag check is done without holding the
port lock.

Fix this by taking the port lock on entry to the function and checking
the flag under this lock. The lock is released and re-taken if
ata_port_wait_eh() needs to be called. The two WARN_ON() macros checking
that the ATA_PFLAG_PM_PENDING flag was cleared are removed as the first
call is racy and the second one done without holding the port lock.

Fixes: 5ef41082912b ("ata: add ata port system PM callbacks")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Tested-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libata-core.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4974,17 +4974,19 @@ static void ata_port_request_pm(struct a
 	struct ata_link *link;
 	unsigned long flags;
 
-	/* Previous resume operation might still be in
-	 * progress.  Wait for PM_PENDING to clear.
+	spin_lock_irqsave(ap->lock, flags);
+
+	/*
+	 * A previous PM operation might still be in progress. Wait for
+	 * ATA_PFLAG_PM_PENDING to clear.
 	 */
 	if (ap->pflags & ATA_PFLAG_PM_PENDING) {
+		spin_unlock_irqrestore(ap->lock, flags);
 		ata_port_wait_eh(ap);
-		WARN_ON(ap->pflags & ATA_PFLAG_PM_PENDING);
+		spin_lock_irqsave(ap->lock, flags);
 	}
 
-	/* request PM ops to EH */
-	spin_lock_irqsave(ap->lock, flags);
-
+	/* Request PM operation to EH */
 	ap->pm_mesg = mesg;
 	ap->pflags |= ATA_PFLAG_PM_PENDING;
 	ata_for_each_link(link, ap, HOST_FIRST) {
@@ -4996,10 +4998,8 @@ static void ata_port_request_pm(struct a
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	if (!async) {
+	if (!async)
 		ata_port_wait_eh(ap);
-		WARN_ON(ap->pflags & ATA_PFLAG_PM_PENDING);
-	}
 }
 
 /*


