Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B5C73E85B
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjFZSYz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjFZSY3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:24:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344C9270B
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:23:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE48E60F40
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8648C433C8;
        Mon, 26 Jun 2023 18:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803830;
        bh=RD03h99Z7i3+/28C0q3OKC7flKm44aKMn6olaaLGMg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VkmAmYoC0NWI69ixZCdbreeyYsyWMiMQGWPwXglA7jaeCsF39YaRYvzlNsO521egH
         roVYS+gGSAmiAPi8qYX/2ErI3p8vtz8WYEgLse+EZ+SEfb02pO21cHuH3HhpVRg5Un
         mNGH62a4vzXATTkAfOol8nTXWpbz6d1988Y+6ROI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Omar Sandoval <osandov@fb.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 192/199] x86/unwind/orc: Add ELF section with ORC version identifier
Date:   Mon, 26 Jun 2023 20:11:38 +0200
Message-ID: <20230626180814.160044340@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

[ Upstream commit b9f174c811e3ae4ae8959dc57e6adb9990e913f4 ]

Commits ffb1b4a41016 ("x86/unwind/orc: Add 'signal' field to ORC
metadata") and fb799447ae29 ("x86,objtool: Split UNWIND_HINT_EMPTY in
two") changed the ORC format. Although ORC is internal to the kernel,
it's the only way for external tools to get reliable kernel stack traces
on x86-64. In particular, the drgn debugger [1] uses ORC for stack
unwinding, and these format changes broke it [2]. As the drgn
maintainer, I don't care how often or how much the kernel changes the
ORC format as long as I have a way to detect the change.

It suffices to store a version identifier in the vmlinux and kernel
module ELF files (to use when parsing ORC sections from ELF), and in
kernel memory (to use when parsing ORC from a core dump+symbol table).
Rather than hard-coding a version number that needs to be manually
bumped, Peterz suggested hashing the definitions from orc_types.h. If
there is a format change that isn't caught by this, the hashing script
can be updated.

This patch adds an .orc_header allocated ELF section containing the
20-byte hash to vmlinux and kernel modules, along with the corresponding
__start_orc_header and __stop_orc_header symbols in vmlinux.

1: https://github.com/osandov/drgn
2: https://github.com/osandov/drgn/issues/303

Fixes: ffb1b4a41016 ("x86/unwind/orc: Add 'signal' field to ORC metadata")
Fixes: fb799447ae29 ("x86,objtool: Split UNWIND_HINT_EMPTY in two")
Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lkml.kernel.org/r/aef9c8dc43915b886a8c48509a12ec1b006ca1ca.1686690801.git.osandov@osandov.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/Makefile                 | 12 ++++++++++++
 arch/x86/include/asm/Kbuild       |  1 +
 arch/x86/include/asm/orc_header.h | 19 +++++++++++++++++++
 arch/x86/kernel/unwind_orc.c      |  3 +++
 include/asm-generic/vmlinux.lds.h |  3 +++
 scripts/mod/modpost.c             |  5 +++++
 scripts/orc_hash.sh               | 16 ++++++++++++++++
 7 files changed, 59 insertions(+)
 create mode 100644 arch/x86/include/asm/orc_header.h
 create mode 100644 scripts/orc_hash.sh

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index b39975977c037..fdc2e3abd6152 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -305,6 +305,18 @@ ifeq ($(RETPOLINE_CFLAGS),)
 endif
 endif
 
+ifdef CONFIG_UNWINDER_ORC
+orc_hash_h := arch/$(SRCARCH)/include/generated/asm/orc_hash.h
+orc_hash_sh := $(srctree)/scripts/orc_hash.sh
+targets += $(orc_hash_h)
+quiet_cmd_orc_hash = GEN     $@
+      cmd_orc_hash = mkdir -p $(dir $@); \
+		     $(CONFIG_SHELL) $(orc_hash_sh) < $< > $@
+$(orc_hash_h): $(srctree)/arch/x86/include/asm/orc_types.h $(orc_hash_sh) FORCE
+	$(call if_changed,orc_hash)
+archprepare: $(orc_hash_h)
+endif
+
 archclean:
 	$(Q)rm -rf $(objtree)/arch/i386
 	$(Q)rm -rf $(objtree)/arch/x86_64
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 1e51650b79d7c..4f1ce5fc4e194 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 
+generated-y += orc_hash.h
 generated-y += syscalls_32.h
 generated-y += syscalls_64.h
 generated-y += syscalls_x32.h
diff --git a/arch/x86/include/asm/orc_header.h b/arch/x86/include/asm/orc_header.h
new file mode 100644
index 0000000000000..07bacf3e160ea
--- /dev/null
+++ b/arch/x86/include/asm/orc_header.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#ifndef _ORC_HEADER_H
+#define _ORC_HEADER_H
+
+#include <linux/types.h>
+#include <linux/compiler.h>
+#include <asm/orc_hash.h>
+
+/*
+ * The header is currently a 20-byte hash of the ORC entry definition; see
+ * scripts/orc_hash.sh.
+ */
+#define ORC_HEADER					\
+	__used __section(".orc_header") __aligned(4)	\
+	static const u8 orc_header[] = { ORC_HASH }
+
+#endif /* _ORC_HEADER_H */
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 37307b40f8daf..c960f250624ab 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -7,6 +7,9 @@
 #include <asm/unwind.h>
 #include <asm/orc_types.h>
 #include <asm/orc_lookup.h>
+#include <asm/orc_header.h>
+
+ORC_HEADER;
 
 #define orc_warn(fmt, ...) \
 	printk_deferred_once(KERN_WARNING "WARNING: " fmt, ##__VA_ARGS__)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index d1f57e4868ed3..7058b01e9f146 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -839,6 +839,9 @@
 
 #ifdef CONFIG_UNWINDER_ORC
 #define ORC_UNWIND_TABLE						\
+	.orc_header : AT(ADDR(.orc_header) - LOAD_OFFSET) {		\
+		BOUNDED_SECTION_BY(.orc_header, _orc_header)		\
+	}								\
 	. = ALIGN(4);							\
 	.orc_unwind_ip : AT(ADDR(.orc_unwind_ip) - LOAD_OFFSET) {	\
 		BOUNDED_SECTION_BY(.orc_unwind_ip, _orc_unwind_ip)	\
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 9466b6a2abae4..5b3964b39709f 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1985,6 +1985,11 @@ static void add_header(struct buffer *b, struct module *mod)
 	buf_printf(b, "#include <linux/vermagic.h>\n");
 	buf_printf(b, "#include <linux/compiler.h>\n");
 	buf_printf(b, "\n");
+	buf_printf(b, "#ifdef CONFIG_UNWINDER_ORC\n");
+	buf_printf(b, "#include <asm/orc_header.h>\n");
+	buf_printf(b, "ORC_HEADER;\n");
+	buf_printf(b, "#endif\n");
+	buf_printf(b, "\n");
 	buf_printf(b, "BUILD_SALT;\n");
 	buf_printf(b, "BUILD_LTO_INFO;\n");
 	buf_printf(b, "\n");
diff --git a/scripts/orc_hash.sh b/scripts/orc_hash.sh
new file mode 100644
index 0000000000000..466611aa0053f
--- /dev/null
+++ b/scripts/orc_hash.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Meta Platforms, Inc. and affiliates.
+
+set -e
+
+printf '%s' '#define ORC_HASH '
+
+awk '
+/^#define ORC_(REG|TYPE)_/ { print }
+/^struct orc_entry {$/ { p=1 }
+p { print }
+/^}/ { p=0 }' |
+	sha1sum |
+	cut -d " " -f 1 |
+	sed 's/\([0-9a-f]\{2\}\)/0x\1,/g'
-- 
2.39.2



