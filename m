Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB2179BD47
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355243AbjIKV5g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240987AbjIKO7D (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:59:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016441B9
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:58:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA21C433C8;
        Mon, 11 Sep 2023 14:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444338;
        bh=EfgxQ/nq12xNGdl0rcyfVS+IpPQEHRYeWbZj8KxCh3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ewMqOb/SAD9gHUdTP5aZj2Y8b97qhIPo8BLV+Kf3hy04e0W2LqLjUvevZOu5GuSyS
         ycIPqekkmEuzBgDm9AAZom74AMItmg9Pa72pa4DsSt2U0cAIlO+H0xDsNr43O8WIUV
         yPW0UaPovbuQZUqQwxzubOCu+QAbR9slTUfj8Oto=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Steve Rutherford <srutherford@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Pankaj Gupta <pankaj.gupta@amd.com>,
        Ben Hillier <bhillier@google.com>
Subject: [PATCH 6.4 694/737] x86/sev: Make enc_dec_hypercall() accept a size instead of npages
Date:   Mon, 11 Sep 2023 15:49:13 +0200
Message-ID: <20230911134709.914973914@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve Rutherford <srutherford@google.com>

commit ac3f9c9f1b37edaa7d1a9b908bc79d843955a1a2 upstream.

enc_dec_hypercall() accepted a page count instead of a size, which
forced its callers to round up. As a result, non-page aligned
vaddrs caused pages to be spuriously marked as decrypted via the
encryption status hypercall, which in turn caused consistent
corruption of pages during live migration. Live migration requires
accurate encryption status information to avoid migrating pages
from the wrong perspective.

Fixes: 064ce6c550a0 ("mm: x86: Invoke hypercall when page encryption status is changed")
Signed-off-by: Steve Rutherford <srutherford@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Tested-by: Ben Hillier <bhillier@google.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230824223731.2055016-1-srutherford@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/mem_encrypt.h |    6 +++---
 arch/x86/kernel/kvm.c              |    4 +---
 arch/x86/mm/mem_encrypt_amd.c      |   13 ++++++-------
 3 files changed, 10 insertions(+), 13 deletions(-)

--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -50,8 +50,8 @@ void __init sme_enable(struct boot_param
 
 int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size);
 int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
-void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages,
-					    bool enc);
+void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr,
+					    unsigned long size, bool enc);
 
 void __init mem_encrypt_free_decrypted_mem(void);
 
@@ -85,7 +85,7 @@ early_set_memory_decrypted(unsigned long
 static inline int __init
 early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
 static inline void __init
-early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages, bool enc) {}
+early_set_mem_enc_dec_hypercall(unsigned long vaddr, unsigned long size, bool enc) {}
 
 static inline void mem_encrypt_free_decrypted_mem(void) { }
 
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -966,10 +966,8 @@ static void __init kvm_init_platform(voi
 		 * Ensure that _bss_decrypted section is marked as decrypted in the
 		 * shared pages list.
 		 */
-		nr_pages = DIV_ROUND_UP(__end_bss_decrypted - __start_bss_decrypted,
-					PAGE_SIZE);
 		early_set_mem_enc_dec_hypercall((unsigned long)__start_bss_decrypted,
-						nr_pages, 0);
+						__end_bss_decrypted - __start_bss_decrypted, 0);
 
 		/*
 		 * If not booted using EFI, enable Live migration support.
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -288,11 +288,10 @@ static bool amd_enc_cache_flush_required
 	return !cpu_feature_enabled(X86_FEATURE_SME_COHERENT);
 }
 
-static void enc_dec_hypercall(unsigned long vaddr, int npages, bool enc)
+static void enc_dec_hypercall(unsigned long vaddr, unsigned long size, bool enc)
 {
 #ifdef CONFIG_PARAVIRT
-	unsigned long sz = npages << PAGE_SHIFT;
-	unsigned long vaddr_end = vaddr + sz;
+	unsigned long vaddr_end = vaddr + size;
 
 	while (vaddr < vaddr_end) {
 		int psize, pmask, level;
@@ -342,7 +341,7 @@ static bool amd_enc_status_change_finish
 		snp_set_memory_private(vaddr, npages);
 
 	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
-		enc_dec_hypercall(vaddr, npages, enc);
+		enc_dec_hypercall(vaddr, npages << PAGE_SHIFT, enc);
 
 	return true;
 }
@@ -466,7 +465,7 @@ static int __init early_set_memory_enc_d
 
 	ret = 0;
 
-	early_set_mem_enc_dec_hypercall(start, PAGE_ALIGN(size) >> PAGE_SHIFT, enc);
+	early_set_mem_enc_dec_hypercall(start, size, enc);
 out:
 	__flush_tlb_all();
 	return ret;
@@ -482,9 +481,9 @@ int __init early_set_memory_encrypted(un
 	return early_set_memory_enc_dec(vaddr, size, true);
 }
 
-void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages, bool enc)
+void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, unsigned long size, bool enc)
 {
-	enc_dec_hypercall(vaddr, npages, enc);
+	enc_dec_hypercall(vaddr, size, enc);
 }
 
 void __init sme_early_init(void)


