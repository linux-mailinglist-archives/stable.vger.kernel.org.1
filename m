Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954CB77ACAA
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjHMVfk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjHMVfj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:35:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C242E10DD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:35:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60B1262CEC
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DCCC433C7;
        Sun, 13 Aug 2023 21:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962540;
        bh=jMa0yFUyBMoO14cGhZjriSxrKglpiq5ssP1edSCI88E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rxgGESpp1cl6Fm/1OlnkDXadSfUZ+ifcSeGUj/95SZUPgTo/F/MoRgz+U5nj7vHRT
         twQy71NjoxmnKKjikgUT3XQs5ucENOcrm+S0sK4A4azyj/mgLI517W9bOjN7xyLeVr
         Yy8gxNLpkw1Umq4w4aI3Yo7HN3YP7YrEdxJHcy18=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tao Liu <ltao@redhat.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, stable@kernel.org
Subject: [PATCH 6.1 067/149] x86/sev: Do not try to parse for the CC blob on non-AMD hardware
Date:   Sun, 13 Aug 2023 23:18:32 +0200
Message-ID: <20230813211720.805980913@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Borislav Petkov (AMD) <bp@alien8.de>

commit bee6cf1a80b54548a039e224c651bb15b644a480 upstream.

Tao Liu reported a boot hang on an Intel Atom machine due to an unmapped
EFI config table. The reason being that the CC blob which contains the
CPUID page for AMD SNP guests is parsed for before even checking
whether the machine runs on AMD hardware.

Usually that's not a problem on !AMD hw - it simply won't find the CC
blob's GUID and return. However, if any parts of the config table
pointers array is not mapped, the kernel will #PF very early in the
decompressor stage without any opportunity to recover.

Therefore, do a superficial CPUID check before poking for the CC blob.
This will fix the current issue on real hardware. It would also work as
a guest on a non-lying hypervisor.

For the lying hypervisor, the check is done again, *after* parsing the
CC blob as the real CPUID page will be present then.

Clear the #VC handler in case SEV-{ES,SNP} hasn't been detected, as
a precaution.

Fixes: c01fce9cef84 ("x86/compressed: Add SEV-SNP feature detection/setup")
Reported-by: Tao Liu <ltao@redhat.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Tao Liu <ltao@redhat.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20230601072043.24439-1-ltao@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/boot/compressed/idt_64.c |    9 ++++++++-
 arch/x86/boot/compressed/sev.c    |   37 +++++++++++++++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 3 deletions(-)

--- a/arch/x86/boot/compressed/idt_64.c
+++ b/arch/x86/boot/compressed/idt_64.c
@@ -63,7 +63,14 @@ void load_stage2_idt(void)
 	set_idt_entry(X86_TRAP_PF, boot_page_fault);
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-	set_idt_entry(X86_TRAP_VC, boot_stage2_vc);
+	/*
+	 * Clear the second stage #VC handler in case guest types
+	 * needing #VC have not been detected.
+	 */
+	if (sev_status & BIT(1))
+		set_idt_entry(X86_TRAP_VC, boot_stage2_vc);
+	else
+		set_idt_entry(X86_TRAP_VC, NULL);
 #endif
 
 	load_boot_idt(&boot_idt_desc);
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -355,12 +355,45 @@ void sev_enable(struct boot_params *bp)
 		bp->cc_blob_address = 0;
 
 	/*
+	 * Do an initial SEV capability check before snp_init() which
+	 * loads the CPUID page and the same checks afterwards are done
+	 * without the hypervisor and are trustworthy.
+	 *
+	 * If the HV fakes SEV support, the guest will crash'n'burn
+	 * which is good enough.
+	 */
+
+	/* Check for the SME/SEV support leaf */
+	eax = 0x80000000;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+	if (eax < 0x8000001f)
+		return;
+
+	/*
+	 * Check for the SME/SEV feature:
+	 *   CPUID Fn8000_001F[EAX]
+	 *   - Bit 0 - Secure Memory Encryption support
+	 *   - Bit 1 - Secure Encrypted Virtualization support
+	 *   CPUID Fn8000_001F[EBX]
+	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
+	 */
+	eax = 0x8000001f;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+	/* Check whether SEV is supported */
+	if (!(eax & BIT(1)))
+		return;
+
+	/*
 	 * Setup/preliminary detection of SNP. This will be sanity-checked
 	 * against CPUID/MSR values later.
 	 */
 	snp = snp_init(bp);
 
-	/* Check for the SME/SEV support leaf */
+	/* Now repeat the checks with the SNP CPUID table. */
+
+	/* Recheck the SME/SEV support leaf */
 	eax = 0x80000000;
 	ecx = 0;
 	native_cpuid(&eax, &ebx, &ecx, &edx);
@@ -368,7 +401,7 @@ void sev_enable(struct boot_params *bp)
 		return;
 
 	/*
-	 * Check for the SME/SEV feature:
+	 * Recheck for the SME/SEV feature:
 	 *   CPUID Fn8000_001F[EAX]
 	 *   - Bit 0 - Secure Memory Encryption support
 	 *   - Bit 1 - Secure Encrypted Virtualization support


