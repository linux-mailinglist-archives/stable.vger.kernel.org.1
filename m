Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635927A0B08
	for <lists+stable@lfdr.de>; Thu, 14 Sep 2023 18:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjINQwy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 14 Sep 2023 12:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238255AbjINQwx (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 14 Sep 2023 12:52:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729F51BCB
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 09:52:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E15C433C7;
        Thu, 14 Sep 2023 16:52:47 +0000 (UTC)
Date:   Thu, 14 Sep 2023 18:52:45 +0200
From:   Helge Deller <deller@gmx.de>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        John David Anglin <dave.anglin@bell.net>
Subject: [STABLE][PATCH] linux/export: fix reference to exported functions
 for parisc64
Message-ID: <ZQM6XXX9Sln2SZx2@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg,

could you please cherry-pick this upstream commit:

	08700ec70504 ("linux/export: fix reference to exported functions for parisc64")

to the v6.5 stable kernel series?

Thanks!
Helge

---

From 08700ec705043eb0cee01b35cf5b9d63f0230d12 Mon Sep 17 00:00:00 2001
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 6 Sep 2023 03:46:57 +0900
Subject: [PATCH] linux/export: fix reference to exported functions for
 parisc64

John David Anglin reported parisc has been broken since commit
ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost").

Like ia64, parisc64 uses a function descriptor. The function
references must be prefixed with P%.

Also, symbols prefixed $$ from the library have the symbol type
STT_LOPROC instead of STT_FUNC. They should be handled as functions
too.

Fixes: ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
Reported-by: John David Anglin <dave.anglin@bell.net>
Tested-by: John David Anglin <dave.anglin@bell.net>
Tested-by: Helge Deller <deller@gmx.de>
Closes: https://lore.kernel.org/linux-parisc/1901598a-e11d-f7dd-a5d9-9a69d06e6b6e@bell.net/T/#u
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
index 1c849db953a5..45fca09b2319 100644
--- a/include/linux/export-internal.h
+++ b/include/linux/export-internal.h
@@ -52,6 +52,8 @@
 
 #ifdef CONFIG_IA64
 #define KSYM_FUNC(name)		@fptr(name)
+#elif defined(CONFIG_PARISC) && defined(CONFIG_64BIT)
+#define KSYM_FUNC(name)		P%name
 #else
 #define KSYM_FUNC(name)		name
 #endif
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index b29b29707f10..ba981f22908a 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1226,6 +1226,15 @@ static void check_export_symbol(struct module *mod, struct elf_info *elf,
 	 */
 	s->is_func = (ELF_ST_TYPE(sym->st_info) == STT_FUNC);
 
+	/*
+	 * For parisc64, symbols prefixed $$ from the library have the symbol type
+	 * STT_LOPROC. They should be handled as functions too.
+	 */
+	if (elf->hdr->e_ident[EI_CLASS] == ELFCLASS64 &&
+	    elf->hdr->e_machine == EM_PARISC &&
+	    ELF_ST_TYPE(sym->st_info) == STT_LOPROC)
+		s->is_func = true;
+
 	if (match(secname, PATTERNS(INIT_SECTIONS)))
 		warn("%s: %s: EXPORT_SYMBOL used for init symbol. Remove __init or EXPORT_SYMBOL.\n",
 		     mod->name, name);
