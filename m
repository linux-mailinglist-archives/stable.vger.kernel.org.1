Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A227A7A6B
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjITL2M (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjITL2M (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:28:12 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13398A9
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695209285; x=1726745285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OwYxfNMAvLPySsToAAeJAxdm8BOe3vV6MO0rHehrKNc=;
  b=iVmLfDETzYd3hMgtzmc0KoUod87/aXpldu9ZMNStf1Cn1hUPxdCaAQew
   6gsVKjMCDJ8D3fKKppVNMq74wCxovCGP8/CkmwOnOxFbOdGDasZ7wyOVE
   Y8OU5aOZ8lzoqbtiCQyKlASnlLXii0S+FL8mPLoKgvFXBrAE0SJOVcHlj
   jS18eSstCJLbSVYodWvsmPFIVncfEeGGzdzVoPLY4LjWPMi6DTouKC35r
   uOiEbidlg/IcFI8FYcLEDPl9jrvLsiBl7ADNazRQPPoIonGRmUkW9UHyn
   9Ikk6trrjVQsxjrqwBUS6ZJ+ZW9/+8oQSxS6xhts77jeV8oxVYIeUYc3n
   w==;
X-CSE-ConnectionGUID: MK5HLT0zRCuWkMJ2hXkdQA==
X-CSE-MsgGUID: lyId3GgITZOrC+x042WBMw==
X-IronPort-AV: E=Sophos;i="6.02,161,1688400000"; 
   d="scan'208";a="242621967"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2023 19:28:05 +0800
IronPort-SDR: bAR9aEHc1t6FWJio7N2u36lH3QyqykEBZT33Z3ZPANr41z+SOttc8OyhHAVlFlWF1Sc8v+ncEc
 Rva+MYz8beuQfg7G9MaLldu4ACbhjGHVvKC069tOn+0axw3kN3oprViQroOKkj+o+ojQIkMXvg
 2Lqp69qgbNp+GBw0kQvO/X7Zli78eMvH3NPW0O78PXR2Pra12AWpVkh6R3P9Sdnf5uII2bPMZ0
 3OjCTjERNyYw9XvQVpUl7xqMkBNv7/iuxErSeaj99V7W4Vv8EYYs0JDTi9zt2SWEvA4FCT3uNs
 FhE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2023 03:34:59 -0700
IronPort-SDR: IVZ6B/9n7/esE0G4kKLNSBk2Nwbjgtee7+EKcr6NTt6Elg7qfrr113FHQBdDwsJs/Ewq8Jxkhq
 9f20xHTQpZdMsgqCe2TwyJfvYfjy2mLCfsqVSPwGPzPQVLayftwXeQLgjNV91Lykm2ZB+8LCC/
 KupzsClh4xpl5NYSelEvqbbD8eVFPhIUAFBfSXKw+40mWfcGxE5dbBrgQKIDymd+cfxNHPgZV5
 AQb/R0RcqeujfodERB7SmYusEJa2yo7RNl05v44cdVc8V/OzvKs+W7AtYSYTCdEHZ1ufZMTFd0
 4NQ=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.lan) ([10.225.163.91])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Sep 2023 04:28:01 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     stable@vger.kernel.org
Cc:     Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH] ata: libata: disallow dev-initiated LPM transitions to unsupported states
Date:   Wed, 20 Sep 2023 13:27:45 +0200
Message-ID: <20230920112745.125794-1-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023092002-mobster-onset-2af9@gregkh>
References: <2023092002-mobster-onset-2af9@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
(cherry picked from commit 24e0e61db3cb86a66824531989f1df80e0939f26)
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/ahci.c        |  9 +++++++++
 drivers/ata/libata-core.c | 19 ++++++++++++++++---
 include/linux/libata.h    |  4 ++++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 0905c07b8c7e..abb3dd048556 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1777,6 +1777,15 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 08dc37a62f5a..69002ad15500 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3993,10 +3993,23 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 		scontrol |= (0x6 << 8);
 		break;
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
index 0e9f8fd37eb9..ab2c5d6cabed 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -279,6 +279,10 @@ enum {
 	ATA_HOST_PARALLEL_SCAN	= (1 << 2),	/* Ports on this host can be scanned in parallel */
 	ATA_HOST_IGNORE_ATA	= (1 << 3),	/* Ignore ATA devices on this host. */
 
+	ATA_HOST_NO_PART	= (1 << 4), /* Host does not support partial */
+	ATA_HOST_NO_SSC		= (1 << 5), /* Host does not support slumber */
+	ATA_HOST_NO_DEVSLP	= (1 << 6), /* Host does not support devslp */
+
 	/* bits 24:31 of host->flags are reserved for LLD specific flags */
 
 	/* various lengths of time */
-- 
2.41.0

