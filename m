Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996F174C3B0
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjGILfL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjGILfK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:35:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F0018C
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:35:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DFCB60BB7
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A2FC433C7;
        Sun,  9 Jul 2023 11:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902508;
        bh=nMHmZ8UaeAsg7LtNm1mf2R8kHtuBz+81MdAZrNG1mJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rL1wKtnYm3B8dVeS50KnphrLrCl+WESDY6ELWlGEKgUu92XrbK8I8xQrc2aJpeg5H
         rfPTROzOPb7PmB/BK2JpmN9kkkSf7A9RIyWO0k0+LDftXuUrRcvcazeBKvzwpcYFpc
         Ku8WvQDP8x+vgkYRYXtbJJ4IUvpHucKCwiC/2GMU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 402/431] modpost: fix section mismatch message for R_ARM_{PC24,CALL,JUMP24}
Date:   Sun,  9 Jul 2023 13:15:50 +0200
Message-ID: <20230709111500.606213440@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit 56a24b8ce6a7f9c4a21b2276a8644f6f3d8fc14d ]

addend_arm_rel() processes R_ARM_PC24, R_ARM_CALL, R_ARM_JUMP24 in a
wrong way.

Here, test code.

[test code for R_ARM_JUMP24]

  .section .init.text,"ax"
  bar:
          bx      lr

  .section .text,"ax"
  .globl foo
  foo:
          b       bar

[test code for R_ARM_CALL]

  .section .init.text,"ax"
  bar:
          bx      lr

  .section .text,"ax"
  .globl foo
  foo:
          push    {lr}
          bl      bar
          pop     {pc}

If you compile it with ARM multi_v7_defconfig, modpost will show the
symbol name, (unknown).

  WARNING: modpost: vmlinux.o: section mismatch in reference: foo (section: .text) -> (unknown) (section: .init.text)

(You need to use GNU linker instead of LLD to reproduce it.)

Fix the code to make modpost show the correct symbol name.

I imported (with adjustment) sign_extend32() from include/linux/bitops.h.

The '+8' is the compensation for pc-relative instruction. It is
documented in "ELF for the Arm Architecture" [1].

  "If the relocation is pc-relative then compensation for the PC bias
  (the PC value is 8 bytes ahead of the executing instruction in Arm
  state and 4 bytes in Thumb state) must be encoded in the relocation
  by the object producer."

[1]: https://github.com/ARM-software/abi-aa/blob/main/aaelf32/aaelf32.rst

Fixes: 56a974fa2d59 ("kbuild: make better section mismatch reports on arm")
Fixes: 6e2e340b59d2 ("ARM: 7324/1: modpost: Fix section warnings for ARM for many compilers")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/mod/modpost.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index ff7a8df9e54cd..30d2ebc391f4a 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1417,12 +1417,20 @@ static int addend_386_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 #define	R_ARM_THM_JUMP19	51
 #endif
 
+static int32_t sign_extend32(int32_t value, int index)
+{
+	uint8_t shift = 31 - index;
+
+	return (int32_t)(value << shift) >> shift;
+}
+
 static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 {
 	unsigned int r_typ = ELF_R_TYPE(r->r_info);
 	Elf_Sym *sym = elf->symtab_start + ELF_R_SYM(r->r_info);
 	void *loc = reloc_location(elf, sechdr, r);
 	uint32_t inst;
+	int32_t offset;
 
 	switch (r_typ) {
 	case R_ARM_ABS32:
@@ -1432,6 +1440,10 @@ static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 	case R_ARM_PC24:
 	case R_ARM_CALL:
 	case R_ARM_JUMP24:
+		inst = TO_NATIVE(*(uint32_t *)loc);
+		offset = sign_extend32((inst & 0x00ffffff) << 2, 25);
+		r->r_addend = offset + sym->st_value + 8;
+		break;
 	case R_ARM_THM_CALL:
 	case R_ARM_THM_JUMP24:
 	case R_ARM_THM_JUMP19:
-- 
2.39.2



