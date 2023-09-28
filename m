Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CD37B21D1
	for <lists+stable@lfdr.de>; Thu, 28 Sep 2023 17:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjI1Pyl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 28 Sep 2023 11:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjI1Pyk (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 28 Sep 2023 11:54:40 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E59B7
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 08:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695916479; x=1727452479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ETvm/kW+shr98Qm5IZsbtYfh9i7I2fgNxCgnD+UjNyg=;
  b=PzjuI/r6OQdU3m9dNqU33aHFhKQQkly2ha1Sr+Rn+NlYjmclMQpl4C0m
   MY3Tuky/nX+rA3YSgxCclsqTpDWxXqWsyDpsyXaGRi5Vm3YP0qfkYZlan
   /FntA5BGfsf9UTWRb5eXZjh60E9coW5t0Lqh4jefuynzkaWXPRFquhxdR
   1jyQVBtqzazRUm0OedrFnkoo0yMiwOdSPhfvNZBlk8CJFOpGrpFKWUoHi
   67nLxJR6nWAsdgCRRth7ePQBGNAG8ZTmHOmEwtTFdHBw9vvo66+Roj90x
   qzhzc6sW9b43eFMlaT6NyC7CY7GYqzoQYDg+oLDz9H9KlEdPIPTaAJ8Rn
   A==;
X-CSE-ConnectionGUID: 8Of0hG85S3qOMLvq4GeSkg==
X-CSE-MsgGUID: s8b0XY/3TsWhy464MbtgqA==
X-IronPort-AV: E=Sophos;i="6.03,184,1694707200"; 
   d="scan'208";a="245195358"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2023 23:54:39 +0800
IronPort-SDR: x1CSxPm8EiNEH6tutSiKmZl81Mmsf0Cgnf15+ClaM9oobFSzWa8gL1jtGzEiUn5FNKbZ2Pi5A+
 YkrkaXX/9JWVxEK6PLR4rFW9OG6R1eK0fN797eUmGjVG5Uv7LTOdYjhf3BAFXVeL9K6qFK2nVP
 pVvrj/kYhGKMeKAsBdLY5q+1aasu6Yjh7DQRMOPcFmpGx5WnUsOSDsPkappCaPE1szIueunz2D
 CtxFUBHK80BlI2DxJDkwDEXeOayDYztiGw8kp3UeCKXxQpS/tVdbaMuvHL+7KCdg/dEYp6B0Gl
 2rM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2023 08:01:24 -0700
IronPort-SDR: Nq31qymqAbbvLJUVmCNxn8EQNhISP/n6xlPprziQLCTrXT5T4nieMVbsv98u/RqG8GmurTAeSo
 BFZ5kWubO0dzlzzNkfsX2d5SF5HEnkX98iFNNItVN0Mr+22WDTnjrjkXUydC2nm2fZhkHBS6BT
 PuLz/H9Z3r+ShqV4HiJUGRZot+QfI0VYkIrQRwCy1b+pVUOtL9KeNRw5f5IynjjiPEasDi41es
 vd4tCbetzfCQVrD30hOSPB3kqkNb2UkXCGcBZfl+LI3EQnAX3FoEraxSeT8ZXYtoQYjfMLf3rn
 qK4=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.wdc.com) ([10.225.163.111])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Sep 2023 08:54:36 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     stable@vger.kernel.org
Cc:     Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 4.19.y] ata: libata: disallow dev-initiated LPM transitions to unsupported states
Date:   Thu, 28 Sep 2023 17:54:26 +0200
Message-ID: <20230928155426.9839-1-niklas.cassel@wdc.com>
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

