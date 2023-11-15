Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608E87ED4A8
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344574AbjKOU6q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344702AbjKOU5o (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0293519A9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B53C433CA;
        Wed, 15 Nov 2023 20:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081224;
        bh=+oYMtUJbcZApFFLXOm3x+u/sRxhg09sNA6WAAc2UBAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LCk4wj7A0ipYU7bUjY0Q759TSSJoP+7D7huui9RduFNQ/zykgIc2UUUw4lXL5yYeF
         XSdLrDbbEyYoxOvBHQ4sNv5PDYiXgZMzo3TQD9Y2bbRvR+DuRsMWW2TMHRQd6sMJ6G
         FTn56Mcxa87uFhXVGS6Ap4nYXoTjwjvQn/zdvpT0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>,
        Adam Dunlap <acdunlap@google.com>,
        Ingo Molnar <mingo@kernel.org>, Jacob Xu <jacobhxu@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 009/244] x86/sev-es: Allow copy_from_kernel_nofault() in earlier boot
Date:   Wed, 15 Nov 2023 15:33:21 -0500
Message-ID: <20231115203548.933364739@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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



