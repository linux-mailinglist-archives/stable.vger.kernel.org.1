Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BDC7554B0
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjGPUdM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjGPUdK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:33:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5410CD2
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:33:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1D6F60E2C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10C7C433C8;
        Sun, 16 Jul 2023 20:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539588;
        bh=CB6BsmXIdFZ8HNKNBv0Zv9kANptIDDpS437LKNLLTOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b1BSxfK9VVmJ3SShCup4UC//nYcK/bDW3okTkz1pheAIbXwTkORsJS3JChucCJOg7
         2BJFreMyHvtx/44hUPk5dL2r5HwJdnZuE9pqQ4SviAmrOnMO9GXXb7d4qCBczlHK2T
         UOJig3z/XegVqRHNhO3WxFoPyG/w53hIroLNII7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 061/591] x86/mm: Fix __swp_entry_to_pte() for Xen PV guests
Date:   Sun, 16 Jul 2023 21:43:20 +0200
Message-ID: <20230716194925.458842044@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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
index e479491da8d51..07cd53eeec770 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -237,8 +237,8 @@ static inline void native_pgd_clear(pgd_t *pgd)
 
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



