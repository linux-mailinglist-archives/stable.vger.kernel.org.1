Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBA8775B45
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjHILQH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbjHILQF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:16:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B225619A1
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:16:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B32A63146
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E65EC433C8;
        Wed,  9 Aug 2023 11:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579763;
        bh=d8csKaG3D0qhYhZWyRgT/h5RcL2qEGPaZlRkTrHWn70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mbu9vyHM+VzBq0LoAfeiA5lpSdIvKZ7hfUQImq0Hjh3A8CTbtMb2frlU6GG9FIsDG
         R3pnRzKtcKiAhQRBrlBVqGBIj/aemZr3HkkUb390XeUrfY0z0uysBgd0Td4xB5T4mK
         6wjX9q+WyNE6YucdN5N+b+o53AOJNvA6xsRqcK4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 078/323] modpost: fix section mismatch message for R_ARM_ABS32
Date:   Wed,  9 Aug 2023 12:38:36 +0200
Message-ID: <20230809103701.715027082@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit b7c63520f6703a25eebb4f8138fed764fcae1c6f ]

addend_arm_rel() processes R_ARM_ABS32 in a wrong way.

Here, test code.

  [test code 1]

    #include <linux/init.h>

    int __initdata foo;
    int get_foo(void) { return foo; }

If you compile it with ARM versatile_defconfig, modpost will show the
symbol name, (unknown).

  WARNING: modpost: vmlinux.o: section mismatch in reference: get_foo (section: .text) -> (unknown) (section: .init.data)

(You need to use GNU linker instead of LLD to reproduce it.)

If you compile it for other architectures, modpost will show the correct
symbol name.

  WARNING: modpost: vmlinux.o: section mismatch in reference: get_foo (section: .text) -> foo (section: .init.data)

For R_ARM_ABS32, addend_arm_rel() sets r->r_addend to a wrong value.

I just mimicked the code in arch/arm/kernel/module.c.

However, there is more difficulty for ARM.

Here, test code.

  [test code 2]

    #include <linux/init.h>

    int __initdata foo;
    int get_foo(void) { return foo; }

    int __initdata bar;
    int get_bar(void) { return bar; }

With this commit applied, modpost will show the following messages
for ARM versatile_defconfig:

  WARNING: modpost: vmlinux.o: section mismatch in reference: get_foo (section: .text) -> foo (section: .init.data)
  WARNING: modpost: vmlinux.o: section mismatch in reference: get_bar (section: .text) -> foo (section: .init.data)

The reference from 'get_bar' to 'foo' seems wrong.

I have no solution for this because it is true in assembly level.

In the following output, relocation at 0x1c is no longer associated
with 'bar'. The two relocation entries point to the same symbol, and
the offset to 'bar' is encoded in the instruction 'r0, [r3, #4]'.

  Disassembly of section .text:

  00000000 <get_foo>:
     0: e59f3004          ldr     r3, [pc, #4]   @ c <get_foo+0xc>
     4: e5930000          ldr     r0, [r3]
     8: e12fff1e          bx      lr
     c: 00000000          .word   0x00000000

  00000010 <get_bar>:
    10: e59f3004          ldr     r3, [pc, #4]   @ 1c <get_bar+0xc>
    14: e5930004          ldr     r0, [r3, #4]
    18: e12fff1e          bx      lr
    1c: 00000000          .word   0x00000000

  Relocation section '.rel.text' at offset 0x244 contains 2 entries:
   Offset     Info    Type            Sym.Value  Sym. Name
  0000000c  00000c02 R_ARM_ABS32       00000000   .init.data
  0000001c  00000c02 R_ARM_ABS32       00000000   .init.data

When find_elf_symbol() gets into a situation where relsym->st_name is
zero, there is no guarantee to get the symbol name as written in C.

I am keeping the current logic because it is useful in many architectures,
but the symbol name is not always correct depending on the optimization.
I left some comments in find_tosym().

Fixes: 56a974fa2d59 ("kbuild: make better section mismatch reports on arm")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/mod/modpost.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 8c2847ef4e422..41b1791a9463b 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1260,6 +1260,10 @@ static Elf_Sym *find_elf_symbol(struct elf_info *elf, Elf64_Sword addr,
 	if (relsym->st_name != 0)
 		return relsym;
 
+	/*
+	 * Strive to find a better symbol name, but the resulting name may not
+	 * match the symbol referenced in the original code.
+	 */
 	relsym_secindex = get_secindex(elf, relsym);
 	for (sym = elf->symtab_start; sym < elf->symtab_stop; sym++) {
 		if (get_secindex(elf, sym) != relsym_secindex)
@@ -1750,12 +1754,14 @@ static int addend_386_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 {
 	unsigned int r_typ = ELF_R_TYPE(r->r_info);
+	Elf_Sym *sym = elf->symtab_start + ELF_R_SYM(r->r_info);
+	void *loc = reloc_location(elf, sechdr, r);
+	uint32_t inst;
 
 	switch (r_typ) {
 	case R_ARM_ABS32:
-		/* From ARM ABI: (S + A) | T */
-		r->r_addend = (int)(long)
-			      (elf->symtab_start + ELF_R_SYM(r->r_info));
+		inst = TO_NATIVE(*(uint32_t *)loc);
+		r->r_addend = inst + sym->st_value;
 		break;
 	case R_ARM_PC24:
 	case R_ARM_CALL:
-- 
2.39.2



