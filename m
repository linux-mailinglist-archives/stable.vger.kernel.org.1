Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5551755163
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjGPTzx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjGPTzx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:55:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE381BE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:55:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 645BF60EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CE3C433C7;
        Sun, 16 Jul 2023 19:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537350;
        bh=DSow8DOZxsMUcdmjX5J3+DIhPRMPGY+3x8kQcWMZzGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g0biVBqtLPikcld/ZBfLjKHwrKdv7VJgh/pXAtj40fPS5sQq+DBScOurd0byAOeG+
         K771+Jkwj0sMb8LXXaS23OhV/qCXa7tREBL0rnop4jahEHqIeARVWzMhBeG5C8oUEw
         t4atHN79DujK6k9JLpJlJ2MymltSRXb6+JH9rsjY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 065/800] x86/mm: Allow guest.enc_status_change_prepare() to fail
Date:   Sun, 16 Jul 2023 21:38:38 +0200
Message-ID: <20230716194950.601847215@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

[ Upstream commit 3f6819dd192ef4f0c568ec3e9d6d408b3fa1ad3d ]

TDX code is going to provide guest.enc_status_change_prepare() that is
able to fail. TDX will use the call to convert the GPA range from shared
to private. This operation can fail.

Add a way to return an error from the callback.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Link: https://lore.kernel.org/all/20230606095622.1939-2-kirill.shutemov%40linux.intel.com
Stable-dep-of: 195edce08b63 ("x86/tdx: Fix race between set_memory_encrypted() and load_unaligned_zeropad()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/x86_init.h | 2 +-
 arch/x86/kernel/x86_init.c      | 2 +-
 arch/x86/mm/mem_encrypt_amd.c   | 4 +++-
 arch/x86/mm/pat/set_memory.c    | 3 ++-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 88085f369ff6f..1ca9701917c55 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -150,7 +150,7 @@ struct x86_init_acpi {
  * @enc_cache_flush_required	Returns true if a cache flush is needed before changing page encryption status
  */
 struct x86_guest {
-	void (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
+	bool (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
 	bool (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
 	bool (*enc_tlb_flush_required)(bool enc);
 	bool (*enc_cache_flush_required)(void);
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index d82f4fa2f1bfe..f230d4d7d8eb4 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -130,7 +130,7 @@ struct x86_cpuinit_ops x86_cpuinit = {
 
 static void default_nmi_init(void) { };
 
-static void enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { }
+static bool enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { return true; }
 static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return false; }
 static bool enc_tlb_flush_required_noop(bool enc) { return false; }
 static bool enc_cache_flush_required_noop(void) { return false; }
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index e0b51c09109f6..4f95c449a406e 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -319,7 +319,7 @@ static void enc_dec_hypercall(unsigned long vaddr, int npages, bool enc)
 #endif
 }
 
-static void amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool enc)
+static bool amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool enc)
 {
 	/*
 	 * To maintain the security guarantees of SEV-SNP guests, make sure
@@ -327,6 +327,8 @@ static void amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool
 	 */
 	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && !enc)
 		snp_set_memory_shared(vaddr, npages);
+
+	return true;
 }
 
 /* Return true unconditionally: return value doesn't matter for the SEV side */
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 7159cf7876130..b8f48ebe753c7 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2151,7 +2151,8 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 		cpa_flush(&cpa, x86_platform.guest.enc_cache_flush_required());
 
 	/* Notify hypervisor that we are about to set/clr encryption attribute. */
-	x86_platform.guest.enc_status_change_prepare(addr, numpages, enc);
+	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, enc))
+		return -EIO;
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
-- 
2.39.2



