Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D14478AC2E
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjH1Khw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjH1KhY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:37:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411F5A7
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:37:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA6BA63F26
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74EAC433C8;
        Mon, 28 Aug 2023 10:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219040;
        bh=5d5namxpWQ1zBtmSiEg/2AO/UbIjOAsZyfe2zmyHbmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2GLmBJE8ipvtfT5SzahhwpZl+pRAW+Kzn4WhODDXAVU/DK+zrgAgwRrsGPF1RthBb
         zavSNAxV+9A+sUVQOJDzGmJKII1BVVYni2q0T+yZND+DOqCSfWafXE/QRDELSyPg6q
         Em3muWXsOBTnm+d3FCb836NaokEz+xspKnvxdeFk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Kishon Vijay Abraham I <kvijayab@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 034/158] iommu/amd: Fix "Guest Virtual APIC Table Root Pointer" configuration in IRTE
Date:   Mon, 28 Aug 2023 12:12:11 +0200
Message-ID: <20230828101158.494137054@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kishon Vijay Abraham I <kvijayab@amd.com>

[ Upstream commit ccc62b827775915a9b82db42a29813d04f92df7a ]

commit b9c6ff94e43a ("iommu/amd: Re-factor guest virtual APIC
(de-)activation code") while refactoring guest virtual APIC
activation/de-activation code, stored information for activate/de-activate
in "struct amd_ir_data". It used 32-bit integer data type for storing the
"Guest Virtual APIC Table Root Pointer" (ga_root_ptr), though the
"ga_root_ptr" is actually a 40-bit field in IRTE (Interrupt Remapping
Table Entry).

This causes interrupts from PCIe devices to not reach the guest in the case
of PCIe passthrough with SME (Secure Memory Encryption) enabled as _SME_
bit in the "ga_root_ptr" is lost before writing it to the IRTE.

Fix it by using 64-bit data type for storing the "ga_root_ptr". While at
that also change the data type of "ga_tag" to u32 in order to match
the IOMMU spec.

Fixes: b9c6ff94e43a ("iommu/amd: Re-factor guest virtual APIC (de-)activation code")
Cc: stable@vger.kernel.org # v5.4+
Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Link: https://lore.kernel.org/r/20230405130317.9351-1-kvijayab@amd.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 76e9d3e2f9f20..15eef44efd030 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -886,8 +886,8 @@ struct amd_ir_data {
 	 */
 	struct irq_cfg *cfg;
 	int ga_vector;
-	int ga_root_ptr;
-	int ga_tag;
+	u64 ga_root_ptr;
+	u32 ga_tag;
 };
 
 struct amd_irte_ops {
-- 
2.40.1



