Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86957ECB21
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjKOTUT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjKOTUS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:20:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E47219D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:20:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78F1C433C7;
        Wed, 15 Nov 2023 19:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076015;
        bh=CcwMTyA6dPe5NkUz5Kp2A2SUPSad456L819L0ok4IMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=smQ4M8YMAsjxVNfqWWWUHFudY+BCtYWEAOO4CmekyQ3GtnFb1+Z8u/o4tgDQfMv90
         3YbjeT0/UthHyRhDQldkkupBRvZuyzlEtFPk+kP5vK4dADddzlXWTc/c7V6n4ToOZE
         VY6YxfxyNEBn5Syg0kU1tVb8juwwh+xmkOdHp1lY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>,
        Adam Dunlap <acdunlap@google.com>,
        Ingo Molnar <mingo@kernel.org>, Jacob Xu <jacobhxu@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 021/550] x86/sev-es: Allow copy_from_kernel_nofault() in earlier boot
Date:   Wed, 15 Nov 2023 14:10:05 -0500
Message-ID: <20231115191602.183944310@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adam Dunlap <acdunlap@google.com>

[ Upstream commit f79936545fb122856bd78b189d3c7ee59928c751 ]

Previously, if copy_from_kernel_nofault() was called before
boot_cpu_data.x86_virt_bits was set up, then it would trigger undefined
behavior due to a shift by 64.

This ended up causing boot failures in the latest version of ubuntu2204
in the gcp project when using SEV-SNP.

Specifically, this function is called during an early #VC handler which
is triggered by a CPUID to check if NX is implemented.

Fixes: 1aa9aa8ee517 ("x86/sev-es: Setup GHCB-based boot #VC handler")
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Adam Dunlap <acdunlap@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Jacob Xu <jacobhxu@google.com>
Link: https://lore.kernel.org/r/20230912002703.3924521-2-acdunlap@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/maccess.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/maccess.c b/arch/x86/mm/maccess.c
index 5a53c2cc169cc..6993f026adec9 100644
--- a/arch/x86/mm/maccess.c
+++ b/arch/x86/mm/maccess.c
@@ -9,12 +9,21 @@ bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 	unsigned long vaddr = (unsigned long)unsafe_src;
 
 	/*
-	 * Range covering the highest possible canonical userspace address
-	 * as well as non-canonical address range. For the canonical range
-	 * we also need to include the userspace guard page.
+	 * Do not allow userspace addresses.  This disallows
+	 * normal userspace and the userspace guard page:
 	 */
-	return vaddr >= TASK_SIZE_MAX + PAGE_SIZE &&
-	       __is_canonical_address(vaddr, boot_cpu_data.x86_virt_bits);
+	if (vaddr < TASK_SIZE_MAX + PAGE_SIZE)
+		return false;
+
+	/*
+	 * Allow everything during early boot before 'x86_virt_bits'
+	 * is initialized.  Needed for instruction decoding in early
+	 * exception handlers.
+	 */
+	if (!boot_cpu_data.x86_virt_bits)
+		return true;
+
+	return __is_canonical_address(vaddr, boot_cpu_data.x86_virt_bits);
 }
 #else
 bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
-- 
2.42.0



