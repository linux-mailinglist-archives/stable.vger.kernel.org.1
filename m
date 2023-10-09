Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86D87BDDFE
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376879AbjJINOr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376892AbjJINOp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:14:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EA3A6
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:14:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F936C433C8;
        Mon,  9 Oct 2023 13:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857281;
        bh=02CzN25EKda+Ai9bSV/fylIHcfbMT78szjH++kmhHlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aWObOU63+mZ1/o7aOmtbQfJCcxfnF/X6RpKzj0Bzhmm4kI3ZGRNd+0w4aJPWuHzPQ
         BKReCKbkyK+ACFheWDVj2q6lohg2mJmCM0dT1c0v0W/i85j+b/hL+2D4le+FZODeYu
         GMDWi2tyfKpElKq343RVWy4pweXPqfWWShHY3/do=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tom Lendacky <thomas.lendacky@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, stable@kernel.org
Subject: [PATCH 6.5 158/163] x86/sev: Change npages to unsigned long in snp_accept_memory()
Date:   Mon,  9 Oct 2023 15:02:02 +0200
Message-ID: <20231009130128.373020057@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Lendacky <thomas.lendacky@amd.com>

commit 62d5e970d022ef4bde18948dd67247c3194384c1 upstream.

In snp_accept_memory(), the npages variables value is calculated from
phys_addr_t variables but is an unsigned int. A very large range passed
into snp_accept_memory() could lead to truncating npages to zero. This
doesn't happen at the moment but let's be prepared.

Fixes: 6c3211796326 ("x86/sev: Add SNP-specific unaccepted memory support")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/6d511c25576494f682063c9fb6c705b526a3757e.1687441505.git.thomas.lendacky@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/sev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 2787826d9f60..d8c1e3be74c0 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -868,8 +868,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned long npages)
 
 void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 {
-	unsigned long vaddr;
-	unsigned int npages;
+	unsigned long vaddr, npages;
 
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return;
-- 
2.42.0



