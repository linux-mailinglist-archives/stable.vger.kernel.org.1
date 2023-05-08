Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE386FAD44
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbjEHLdD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbjEHLcm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:32:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351FD93C1
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:31:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D8A763060
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C34C4339B;
        Mon,  8 May 2023 11:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545478;
        bh=/1jU58CawqNL+24BzGN3tQTZLKQQ9cGWRu093uBT6ds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hty99L3KxBtPr+8wB3/Ck8lIZ6Wo1/vJvKeaSemApiZ+xPfCzGYm5tm99atJYHBVO
         meo2574okHldgjxBlSEVt1e2lOTYKgaxOUeC4GUsuczMEYIq2KaulYEAlGps2es0ma
         K18Rw33kBr366wJiSgKmFKC8GV5Q9YHs4In3ub0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Kishon Vijay Abraham I <kvijayab@amd.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 5.15 052/371] iommu/amd: Fix "Guest Virtual APIC Table Root Pointer" configuration in IRTE
Date:   Mon,  8 May 2023 11:44:13 +0200
Message-Id: <20230508094814.126856384@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kishon Vijay Abraham I <kvijayab@amd.com>

commit ccc62b827775915a9b82db42a29813d04f92df7a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/amd/amd_iommu_types.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -918,8 +918,8 @@ struct amd_ir_data {
 	 */
 	struct irq_cfg *cfg;
 	int ga_vector;
-	int ga_root_ptr;
-	int ga_tag;
+	u64 ga_root_ptr;
+	u32 ga_tag;
 };
 
 struct amd_irte_ops {


