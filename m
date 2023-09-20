Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2425B7A7A6E
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjITL2o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjITL2n (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:28:43 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB9BB4
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695209317; x=1726745317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ETvm/kW+shr98Qm5IZsbtYfh9i7I2fgNxCgnD+UjNyg=;
  b=TCWU60nmaZnzgtgkbgicFOmjtx/rcmYZYCft4JQyzES7A43wqJ8vH9uo
   ayomSXXjN4jSM6aiBotDxJ1idlrPld+H9u/VvL2AKUIwLmjA+8bMm64nS
   L1eoc4LuNZLtfug0buWCDXop/f89WranoSZFCRE6ramX0Hyw5mLRPMR03
   ZzkFysaddyE/8UdvNNX1ChMDmlpPnsuxn+txXn3rR2Qo32ZCTie70riaG
   zVZgLkMkRr1JbUH9b9dax6Azkw6v6jPJ7LIy5RBn9rCixXdqhIb5WyhHb
   sQkFCniFugG4xyOydlaxjwU7ZmPOdHt40mquN+PKF6dWlu2LfndIL9F4j
   A==;
X-CSE-ConnectionGUID: eXesSE+jQ0ePgR8py/1r+Q==
X-CSE-MsgGUID: s1l6R4fOSva6k5UKQW9hdw==
X-IronPort-AV: E=Sophos;i="6.02,161,1688400000"; 
   d="scan'208";a="244431614"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2023 19:28:36 +0800
IronPort-SDR: BT/kq9jBnQHyDFCyXxAtst1U1JUI7NT7E6eODUu6LiV0O7Cl06gqnkisVWLUuMbKH8FeCMEd/P
 Uf52j8HG2QxlHi7pR/nyDhL7Nzf2xw0p05+S5Zmt3oAtBPJl3+JDQ1xNTGNSAsGr6ekiHBSzca
 L889NQlyolyDO5CcofP5ibkRYA+FEjBaGBksf6nTJlRmiAEbJ4dQ0wzKyDN+UxTxX/JrrB0ZlH
 5NHi9XpQ/uTm+GU0HdNty9nxJd0fTlaXW7RuLBln/pL0Qi0LKrSMSkvmt0yygsrpzp6FatUIrR
 9xY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2023 03:35:31 -0700
IronPort-SDR: YrJbENZiiTIzSNarjBJbmtZHFjzlnCOXHPDpBKNnt7GjglGUBaQmdU+L73PV8hpqAq2el9ooNZ
 nDiXVhaqpNElebx7HJnQfoo4wq9UUaasgyi6xfP+kVsTEl0ZfvL1giClemR3Vn5zJnI6OFkgvJ
 SX1W7+TU7eWvxNQ8vhiuE5nhEoYPXYyqgp94Sy0bFF4cWa+e6bxbSBBLBA8OS4smu/BOLwDDR2
 kTRMg+uCt8sWQ1O+/e6CGAH/f/vwfg0d9Qx6k7OiHlkFZknrxADlr4x14l91PZGwg5/79jczxo
 N/E=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.lan) ([10.225.163.91])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Sep 2023 04:28:35 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     stable@vger.kernel.org
Cc:     Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH] ata: libata: disallow dev-initiated LPM transitions to unsupported states
Date:   Wed, 20 Sep 2023 13:28:25 +0200
Message-ID: <20230920112825.125825-1-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023092000-constrict-congested-cec9@gregkh>
References: <2023092000-constrict-congested-cec9@gregkh>
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
index 13fb983b3413..274e72eb4c81 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1866,6 +1866,15 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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
index 4a7da8f744e0..f3a288b2e20b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3997,10 +3997,23 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
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
index 73cd0182452c..02239183e3f4 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -278,6 +278,10 @@ enum {
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

