Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E3275D1BF
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjGUSwf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjGUSwd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:52:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5E93A91
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:52:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BD1F61D89
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2E9C433C8;
        Fri, 21 Jul 2023 18:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965544;
        bh=cJo8eAjUavLJ/VxXJQjqT+d0kGMzfbYyhc4fuWz21f0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zyFXzXVHWkftlnIwHIb2lStNh3QU0E2oB4DOGGqxYeRFU4SkvZ+tRWrbaGy5he6hf
         0V6u1mal08rBdI66VNYPrT759gaTePEvCSlc4DM6P8BOYvD2LAq4rSX4HnNlYjJezd
         NWn7ZYL/QT+4VcMrOMoXzLG7GeDoFpFvHurQdOE4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 028/532] x86/mm: Fix __swp_entry_to_pte() for Xen PV guests
Date:   Fri, 21 Jul 2023 17:58:52 +0200
Message-ID: <20230721160616.186910551@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Juergen Gross <jgross@suse.com>

[ Upstream commit 0f88130e8a6fd185b0aeb5d8e286083735f2585a ]

Normally __swp_entry_to_pte() is never called with a value translating
to a valid PTE. The only known exception is pte_swap_tests(), resulting
in a WARN splat in Xen PV guests, as __pte_to_swp_entry() did
translate the PFN of the valid PTE to a guest local PFN, while
__swp_entry_to_pte() doesn't do the opposite translation.

Fix that by using __pte() in __swp_entry_to_pte() instead of open
coding the native variant of it.

For correctness do the similar conversion for __swp_entry_to_pmd().

Fixes: 05289402d717 ("mm/debug_vm_pgtable: add tests validating arch helpers for core MM features")
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230306123259.12461-1-jgross@suse.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/pgtable_64.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 56d0399a0cd16..dd520b44e89cc 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -235,8 +235,8 @@ static inline void native_pgd_clear(pgd_t *pgd)
 
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val((pte)) })
 #define __pmd_to_swp_entry(pmd)		((swp_entry_t) { pmd_val((pmd)) })
-#define __swp_entry_to_pte(x)		((pte_t) { .pte = (x).val })
-#define __swp_entry_to_pmd(x)		((pmd_t) { .pmd = (x).val })
+#define __swp_entry_to_pte(x)		(__pte((x).val))
+#define __swp_entry_to_pmd(x)		(__pmd((x).val))
 
 extern int kern_addr_valid(unsigned long addr);
 extern void cleanup_highmap(void);
-- 
2.39.2



