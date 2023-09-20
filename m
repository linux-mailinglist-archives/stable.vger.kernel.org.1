Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9007A7F28
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjITMYh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbjITMYh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:24:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241C683
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:24:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AE5C433C7;
        Wed, 20 Sep 2023 12:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212670;
        bh=QKPSAy7KHd2tcgUAMh9koq+NkrxkbFf3AjZdOoTnEsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ve4OoIQ9eyXpyfg1/KQSN51m8eJBprmjCcEMjLN/aa9p7kDT1IKRYu72lvFKxUKlC
         eJU92Z+7M7zZguNMKymyBhh2kd6Y87lbJ/ym+/mHduAMVSXjdWhUdyhVG33J5izVDD
         je3jCChvAOiWzw+gnYcCbx0XdW8C63/mh+1SVZqw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 5.10 80/83] ata: libata: disallow dev-initiated LPM transitions to unsupported states
Date:   Wed, 20 Sep 2023 13:32:10 +0200
Message-ID: <20230920112829.820319383@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112826.634178162@linuxfoundation.org>
References: <20230920112826.634178162@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <niklas.cassel@wdc.com>

commit 24e0e61db3cb86a66824531989f1df80e0939f26 upstream.

In AHCI 1.3.1, the register description for CAP.SSC:
"When cleared to ‘0’, software must not allow the HBA to initiate
transitions to the Slumber state via agressive link power management nor
the PxCMD.ICC field in each port, and the PxSCTL.IPM field in each port
must be programmed to disallow device initiated Slumber requests."

In AHCI 1.3.1, the register description for CAP.PSC:
"When cleared to ‘0’, software must not allow the HBA to initiate
transitions to the Partial state via agressive link power management nor
the PxCMD.ICC field in each port, and the PxSCTL.IPM field in each port
must be programmed to disallow device initiated Partial requests."

Ensure that we always set the corresponding bits in PxSCTL.IPM, such that
a device is not allowed to initiate transitions to power states which are
unsupported by the HBA.

DevSleep is always initiated by the HBA, however, for completeness, set the
corresponding bit in PxSCTL.IPM such that agressive link power management
cannot transition to DevSleep if DevSleep is not supported.

sata_link_scr_lpm() is used by libahci, ata_piix and libata-pmp.
However, only libahci has the ability to read the CAP/CAP2 register to see
if these features are supported. Therefore, in order to not introduce any
regressions on ata_piix or libata-pmp, create flags that indicate that the
respective feature is NOT supported. This way, the behavior for ata_piix
and libata-pmp should remain unchanged.

This change is based on a patch originally submitted by Runa Guo-oc.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Fixes: 1152b2617a6e ("libata: implement sata_link_scr_lpm() and make ata_dev_set_feature() global")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/ahci.c        |    9 +++++++++
 drivers/ata/libata-sata.c |   19 ++++++++++++++++---
 include/linux/libata.h    |    4 ++++
 3 files changed, 29 insertions(+), 3 deletions(-)

--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1882,6 +1882,15 @@ static int ahci_init_one(struct pci_dev
 	else
 		dev_info(&pdev->dev, "SSS flag set, parallel bus scan disabled\n");
 
+	if (!(hpriv->cap & HOST_CAP_PART))
+		host->flags |= ATA_HOST_NO_PART;
+
+	if (!(hpriv->cap & HOST_CAP_SSC))
+		host->flags |= ATA_HOST_NO_SSC;
+
+	if (!(hpriv->cap2 & HOST_CAP2_SDS))
+		host->flags |= ATA_HOST_NO_DEVSLP;
+
 	if (pi.flags & ATA_FLAG_EM)
 		ahci_reset_em(host);
 
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -394,10 +394,23 @@ int sata_link_scr_lpm(struct ata_link *l
 	case ATA_LPM_MED_POWER_WITH_DIPM:
 	case ATA_LPM_MIN_POWER_WITH_PARTIAL:
 	case ATA_LPM_MIN_POWER:
-		if (ata_link_nr_enabled(link) > 0)
-			/* no restrictions on LPM transitions */
+		if (ata_link_nr_enabled(link) > 0) {
+			/* assume no restrictions on LPM transitions */
 			scontrol &= ~(0x7 << 8);
-		else {
+
+			/*
+			 * If the controller does not support partial, slumber,
+			 * or devsleep, then disallow these transitions.
+			 */
+			if (link->ap->host->flags & ATA_HOST_NO_PART)
+				scontrol |= (0x1 << 8);
+
+			if (link->ap->host->flags & ATA_HOST_NO_SSC)
+				scontrol |= (0x2 << 8);
+
+			if (link->ap->host->flags & ATA_HOST_NO_DEVSLP)
+				scontrol |= (0x4 << 8);
+		} else {
 			/* empty port, power off */
 			scontrol &= ~0xf;
 			scontrol |= (0x1 << 2);
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -260,6 +260,10 @@ enum {
 	ATA_HOST_PARALLEL_SCAN	= (1 << 2),	/* Ports on this host can be scanned in parallel */
 	ATA_HOST_IGNORE_ATA	= (1 << 3),	/* Ignore ATA devices on this host. */
 
+	ATA_HOST_NO_PART	= (1 << 4), /* Host does not support partial */
+	ATA_HOST_NO_SSC		= (1 << 5), /* Host does not support slumber */
+	ATA_HOST_NO_DEVSLP	= (1 << 6), /* Host does not support devslp */
+
 	/* bits 24:31 of host->flags are reserved for LLD specific flags */
 
 	/* various lengths of time */


