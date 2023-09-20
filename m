Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0947A782E
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 11:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbjITJ5J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 05:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbjITJ5I (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 05:57:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B048F
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 02:57:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682EDC433C8;
        Wed, 20 Sep 2023 09:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695203821;
        bh=qROhzAEtHcgpJgbGuai6wgukn5/kB2BxMwyxtP8v9ic=;
        h=Subject:To:Cc:From:Date:From;
        b=hADSmgen+VC0Cr4Rl0zyyV8cRHwwMjY4l5fu1DwpCCvmOwXvuH7ZwdLohZJ/1nPr1
         MBU0+Q4lZP3sntjSzvJPxlKqzSmqXFYvljfyngKhn6jyIR2uhvpKEZuXqK1UuKOHxt
         VsCYzMIXo2LBNIDuAWEAeENZqja3oaCDkmAl2I+w=
Subject: FAILED: patch "[PATCH] ata: libata: disallow dev-initiated LPM transitions to" failed to apply to 5.4-stable tree
To:     niklas.cassel@wdc.com, dlemoal@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 20 Sep 2023 11:56:59 +0200
Message-ID: <2023092059-broiling-pumice-a10f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 24e0e61db3cb86a66824531989f1df80e0939f26
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023092059-broiling-pumice-a10f@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

24e0e61db3cb ("ata: libata: disallow dev-initiated LPM transitions to unsupported states")
7fe183c773c4 ("ata: start separating SATA specific code from libata-core.c")
a52fbcfc7b38 ("ata: move EXPORT_SYMBOL_GPL()s close to exported code")
10a663a1b151 ("ata: ahci: Add shutdown to freeze hardware resources of ahci")
95364f36701e ("ata: make qc_prep return ata_completion_errors")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 24e0e61db3cb86a66824531989f1df80e0939f26 Mon Sep 17 00:00:00 2001
From: Niklas Cassel <niklas.cassel@wdc.com>
Date: Mon, 4 Sep 2023 22:42:56 +0200
Subject: [PATCH] ata: libata: disallow dev-initiated LPM transitions to
 unsupported states
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index abb5911c9d09..08745e7db820 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1883,6 +1883,15 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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
 
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 5d31c08be013..a701e1538482 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -396,10 +396,23 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
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
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 52d58b13e5ee..bf4913f4d7ac 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -222,6 +222,10 @@ enum {
 	ATA_HOST_PARALLEL_SCAN	= (1 << 2),	/* Ports on this host can be scanned in parallel */
 	ATA_HOST_IGNORE_ATA	= (1 << 3),	/* Ignore ATA devices on this host. */
 
+	ATA_HOST_NO_PART	= (1 << 4), /* Host does not support partial */
+	ATA_HOST_NO_SSC		= (1 << 5), /* Host does not support slumber */
+	ATA_HOST_NO_DEVSLP	= (1 << 6), /* Host does not support devslp */
+
 	/* bits 24:31 of host->flags are reserved for LLD specific flags */
 
 	/* various lengths of time */

