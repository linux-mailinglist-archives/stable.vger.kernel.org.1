Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C3B7758BB
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjHIKzN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjHIKzA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:55:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1442D79
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 543B06313F
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D37BC433C8;
        Wed,  9 Aug 2023 10:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578376;
        bh=ZOppM/Yb8HS5OYtwntvMTzbppEp6iqchXTwxvSKaxS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jqF+6TeDnzLwSRr/UdZpF3NMARax9R44RwPfVgsQQzJ02P3JustIBhoMdUhLa/psU
         vGCFV+cr16Ymsk//oQmUBlFYhKXi1qcba4BnAqqyV/tGFhcjMfFa46QlwruDpL7yWG
         +a/JKqvMeJMVreKt0uklPkg+nq+eJhbnKgrjgFec=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Will Deacon <will@kernel.org>,
        Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: [PATCH 6.1 008/127] iommu/arm-smmu-v3: Document nesting-related errata
Date:   Wed,  9 Aug 2023 12:39:55 +0200
Message-ID: <20230809103636.904049271@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Robin Murphy <robin.murphy@arm.com>

commit 0bfbfc526c70606bf0fad302e4821087cbecfaf4 upstream

Both MMU-600 and MMU-700 have similar errata around TLB invalidation
while both stages of translation are active, which will need some
consideration once nesting support is implemented. For now, though,
it's very easy to make our implicit lack of nesting support explicit
for those cases, so they're less likely to be missed in future.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Link: https://lore.kernel.org/r/696da78d32bb4491f898f11b0bb4d850a8aa7c6a.1683731256.git.robin.murphy@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/arm64/silicon-errata.rst      |    4 ++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |    5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -141,9 +141,9 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
-| ARM            | MMU-600         | #1076982        | N/A                         |
+| ARM            | MMU-600         | #1076982,1209401| N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
-| ARM            | MMU-700         | #2812531        | N/A                         |
+| ARM            | MMU-700         | #2268618,2812531| N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Broadcom       | Brahma-B53      | N/A             | ARM64_ERRATUM_845719        |
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3438,11 +3438,16 @@ static void arm_smmu_device_iidr_probe(s
 			/* Arm erratum 1076982 */
 			if (variant == 0 && revision <= 2)
 				smmu->features &= ~ARM_SMMU_FEAT_SEV;
+			/* Arm erratum 1209401 */
+			if (variant < 2)
+				smmu->features &= ~ARM_SMMU_FEAT_NESTING;
 			break;
 		case IIDR_PRODUCTID_ARM_MMU_700:
 			/* Arm erratum 2812531 */
 			smmu->features &= ~ARM_SMMU_FEAT_BTM;
 			smmu->options |= ARM_SMMU_OPT_CMDQ_FORCE_SYNC;
+			/* Arm errata 2268618, 2812531 */
+			smmu->features &= ~ARM_SMMU_FEAT_NESTING;
 			break;
 		}
 		break;


