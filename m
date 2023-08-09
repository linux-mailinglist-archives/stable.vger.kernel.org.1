Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DE577574B
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjHIKo2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjHIKoZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:44:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507702101
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:44:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E169F63118
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA55C433C7;
        Wed,  9 Aug 2023 10:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691577861;
        bh=t20SVCcQ7ynoshafSwL+VpYt07roIpHk5jCQAZX6afg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S75kwOIphDLlLpha/a7o8DsbmxJ+1pBJ9vggjwReWZoOhed7zOFbk5wa06u1B+7ly
         hV6ls/VBhOuyhk5XDdFBY/ph/gLevjTh63eUdiuCdKPV/9juW72I2tWDXHLumSm6PY
         0i1PZkQYuHCPFel3N/Cc5M9hogRzMlDdkb9uujao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Will Deacon <will@kernel.org>,
        Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: [PATCH 6.4 003/165] iommu/arm-smmu-v3: Document MMU-700 erratum 2812531
Date:   Wed,  9 Aug 2023 12:38:54 +0200
Message-ID: <20230809103642.859077937@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

commit 309a15cb16bb075da1c99d46fb457db6a1a2669e upstream

To work around MMU-700 erratum 2812531 we need to ensure that certain
sequences of commands cannot be issued without an intervening sync. In
practice this falls out of our current command-batching machinery
anyway - each batch only contains a single type of invalidation command,
and ends with a sync. The only exception is when a batch is sufficiently
large to need issuing across multiple command queue slots, wherein the
earlier slots will not contain a sync and thus may in theory interleave
with another batch being issued in parallel to create an affected
sequence across the slot boundary.

Since MMU-700 supports range invalidate commands and thus we will prefer
to use them (which also happens to avoid conditions for other errata),
I'm not entirely sure it's even possible for a single high-level
invalidate call to generate a batch of more than 63 commands, but for
the sake of robustness and documentation, wire up an option to enforce
that a sync is always inserted for every slot issued.

The other aspect is that the relative order of DVM commands cannot be
controlled, so DVM cannot be used. Again that is already the status quo,
but since we have at least defined ARM_SMMU_FEAT_BTM, we can explicitly
disable it for documentation purposes even if it's not wired up anywhere
yet.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Link: https://lore.kernel.org/r/330221cdfd0003cd51b6c04e7ff3566741ad8374.1683731256.git.robin.murphy@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/arm64/silicon-errata.rst      |    2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   12 ++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |    1 +
 3 files changed, 15 insertions(+)

--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -145,6 +145,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-600         | #1076982        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | MMU-700         | #2812531        | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Broadcom       | Brahma-B53      | N/A             | ARM64_ERRATUM_845719        |
 +----------------+-----------------+-----------------+-----------------------------+
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -894,6 +894,12 @@ static void arm_smmu_cmdq_batch_add(stru
 {
 	int index;
 
+	if (cmds->num == CMDQ_BATCH_ENTRIES - 1 &&
+	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC)) {
+		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, true);
+		cmds->num = 0;
+	}
+
 	if (cmds->num == CMDQ_BATCH_ENTRIES) {
 		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, false);
 		cmds->num = 0;
@@ -3431,6 +3437,7 @@ static int arm_smmu_device_reset(struct
 
 #define IIDR_IMPLEMENTER_ARM		0x43b
 #define IIDR_PRODUCTID_ARM_MMU_600	0x483
+#define IIDR_PRODUCTID_ARM_MMU_700	0x487
 
 static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
 {
@@ -3451,6 +3458,11 @@ static void arm_smmu_device_iidr_probe(s
 			if (variant == 0 && revision <= 2)
 				smmu->features &= ~ARM_SMMU_FEAT_SEV;
 			break;
+		case IIDR_PRODUCTID_ARM_MMU_700:
+			/* Arm erratum 2812531 */
+			smmu->features &= ~ARM_SMMU_FEAT_BTM;
+			smmu->options |= ARM_SMMU_OPT_CMDQ_FORCE_SYNC;
+			break;
 		}
 		break;
 	}
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -650,6 +650,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
 #define ARM_SMMU_OPT_PAGE0_REGS_ONLY	(1 << 1)
 #define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
+#define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;


