Return-Path: <stable+bounces-36714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73FB89C154
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146121C21B8B
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E192C82D9C;
	Mon,  8 Apr 2024 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aANuLN/9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F20F6CDA9;
	Mon,  8 Apr 2024 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582130; cv=none; b=Vhevpl3W7zV5xRWND5g1BcJfC58VMqbromakmV6HhejmFZI/848EtiaO6NExVxlVsbt1/ywqDN6fURXnKdbdSNzL9evke7ktLRQHjeZA6XpOMLcIpY2yLZitisi7cQDNPM0kUdtnFYuI1KJa5S3MeXGjZT///dy6fJNwOPbq8NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582130; c=relaxed/simple;
	bh=SmYktwE2difdoWdV4pAZTzcoVQN2eibCVNKN+g76lyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzfvQUiglicLiQ3Dp1Fls2lLCdUBLcGgms2k4gSLMBxaX5LPv4VSPz1Vn5/m/YPmo4qplvo/JPVAMqN5ycYw2Tq9bAwWphrUdHOl0pAv8MLEJv7mnJnY2wJ4V+Gf5hd7jtN1IHReHz39fW2OjvVqbf1xuBqCK8baF650lpXvENY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aANuLN/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D404C433F1;
	Mon,  8 Apr 2024 13:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712582130;
	bh=SmYktwE2difdoWdV4pAZTzcoVQN2eibCVNKN+g76lyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aANuLN/9NY1AxSXJuwxWWHfWqnBSSLmZvaRyCvzmzG2vfo/Zbqt149whJTkigq6Gy
	 d12ib+D1vce7tvJKsSa7QWiVr/57w7I7iZLxslWE9x3TbK6TAGaoB5tN0+ggXFhyqW
	 9wIPD2UwTo5WWZkV6uOsJUBCCpCY3/CTtbDjvejo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jack Brennen <jbrennen@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 066/252] modpost: Optimize symbol search from linear to binary search
Date: Mon,  8 Apr 2024 14:56:05 +0200
Message-ID: <20240408125308.687673841@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
References: <20240408125306.643546457@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jack Brennen <jbrennen@google.com>

[ Upstream commit 4074532758c5c367d3fcb8d124150824a254659d ]

Modify modpost to use binary search for converting addresses back
into symbol references.  Previously it used linear search.

This change saves a few seconds of wall time for defconfig builds,
but can save several minutes on allyesconfigs.

Before:
$ make LLVM=1 -j128 allyesconfig vmlinux -s KCFLAGS="-Wno-error"
$ time scripts/mod/modpost -M -m -a -N -o vmlinux.symvers vmlinux.o
198.38user 1.27system 3:19.71elapsed

After:
$ make LLVM=1 -j128 allyesconfig vmlinux -s KCFLAGS="-Wno-error"
$ time scripts/mod/modpost -M -m -a -N -o vmlinux.symvers vmlinux.o
11.91user 0.85system 0:12.78elapsed

Signed-off-by: Jack Brennen <jbrennen@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Stable-dep-of: 1102f9f85bf6 ("modpost: do not make find_tosym() return NULL")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/mod/Makefile    |   4 +-
 scripts/mod/modpost.c   |  70 ++------------
 scripts/mod/modpost.h   |  25 +++++
 scripts/mod/symsearch.c | 199 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 232 insertions(+), 66 deletions(-)
 create mode 100644 scripts/mod/symsearch.c

diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
index c9e38ad937fd4..3c54125eb3733 100644
--- a/scripts/mod/Makefile
+++ b/scripts/mod/Makefile
@@ -5,7 +5,7 @@ CFLAGS_REMOVE_empty.o += $(CC_FLAGS_LTO)
 hostprogs-always-y	+= modpost mk_elfconfig
 always-y		+= empty.o
 
-modpost-objs	:= modpost.o file2alias.o sumversion.o
+modpost-objs	:= modpost.o file2alias.o sumversion.o symsearch.o
 
 devicetable-offsets-file := devicetable-offsets.h
 
@@ -16,7 +16,7 @@ targets += $(devicetable-offsets-file) devicetable-offsets.s
 
 # dependencies on generated files need to be listed explicitly
 
-$(obj)/modpost.o $(obj)/file2alias.o $(obj)/sumversion.o: $(obj)/elfconfig.h
+$(obj)/modpost.o $(obj)/file2alias.o $(obj)/sumversion.o $(obj)/symsearch.o: $(obj)/elfconfig.h
 $(obj)/file2alias.o: $(obj)/$(devicetable-offsets-file)
 
 quiet_cmd_elfconfig = MKELF   $@
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 5191fdbd3fa23..66589fb4e9aef 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -22,7 +22,6 @@
 #include <errno.h>
 #include "modpost.h"
 #include "../../include/linux/license.h"
-#include "../../include/linux/module_symbol.h"
 
 static bool module_enabled;
 /* Are we using CONFIG_MODVERSIONS? */
@@ -577,11 +576,14 @@ static int parse_elf(struct elf_info *info, const char *filename)
 			*p = TO_NATIVE(*p);
 	}
 
+	symsearch_init(info);
+
 	return 1;
 }
 
 static void parse_elf_finish(struct elf_info *info)
 {
+	symsearch_finish(info);
 	release_file(info->hdr, info->size);
 }
 
@@ -1042,71 +1044,10 @@ static int secref_whitelist(const char *fromsec, const char *fromsym,
 	return 1;
 }
 
-/*
- * If there's no name there, ignore it; likewise, ignore it if it's
- * one of the magic symbols emitted used by current tools.
- *
- * Otherwise if find_symbols_between() returns those symbols, they'll
- * fail the whitelist tests and cause lots of false alarms ... fixable
- * only by merging __exit and __init sections into __text, bloating
- * the kernel (which is especially evil on embedded platforms).
- */
-static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
-{
-	const char *name = elf->strtab + sym->st_name;
-
-	if (!name || !strlen(name))
-		return 0;
-	return !is_mapping_symbol(name);
-}
-
-/* Look up the nearest symbol based on the section and the address */
-static Elf_Sym *find_nearest_sym(struct elf_info *elf, Elf_Addr addr,
-				 unsigned int secndx, bool allow_negative,
-				 Elf_Addr min_distance)
-{
-	Elf_Sym *sym;
-	Elf_Sym *near = NULL;
-	Elf_Addr sym_addr, distance;
-	bool is_arm = (elf->hdr->e_machine == EM_ARM);
-
-	for (sym = elf->symtab_start; sym < elf->symtab_stop; sym++) {
-		if (get_secindex(elf, sym) != secndx)
-			continue;
-		if (!is_valid_name(elf, sym))
-			continue;
-
-		sym_addr = sym->st_value;
-
-		/*
-		 * For ARM Thumb instruction, the bit 0 of st_value is set
-		 * if the symbol is STT_FUNC type. Mask it to get the address.
-		 */
-		if (is_arm && ELF_ST_TYPE(sym->st_info) == STT_FUNC)
-			 sym_addr &= ~1;
-
-		if (addr >= sym_addr)
-			distance = addr - sym_addr;
-		else if (allow_negative)
-			distance = sym_addr - addr;
-		else
-			continue;
-
-		if (distance <= min_distance) {
-			min_distance = distance;
-			near = sym;
-		}
-
-		if (min_distance == 0)
-			break;
-	}
-	return near;
-}
-
 static Elf_Sym *find_fromsym(struct elf_info *elf, Elf_Addr addr,
 			     unsigned int secndx)
 {
-	return find_nearest_sym(elf, addr, secndx, false, ~0);
+	return symsearch_find_nearest(elf, addr, secndx, false, ~0);
 }
 
 static Elf_Sym *find_tosym(struct elf_info *elf, Elf_Addr addr, Elf_Sym *sym)
@@ -1119,7 +1060,8 @@ static Elf_Sym *find_tosym(struct elf_info *elf, Elf_Addr addr, Elf_Sym *sym)
 	 * Strive to find a better symbol name, but the resulting name may not
 	 * match the symbol referenced in the original code.
 	 */
-	return find_nearest_sym(elf, addr, get_secindex(elf, sym), true, 20);
+	return symsearch_find_nearest(elf, addr, get_secindex(elf, sym),
+				      true, 20);
 }
 
 static bool is_executable_section(struct elf_info *elf, unsigned int secndx)
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 5f94c2c9f2d95..6413f26fcb6b4 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -10,6 +10,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <elf.h>
+#include "../../include/linux/module_symbol.h"
 
 #include "list.h"
 #include "elfconfig.h"
@@ -128,6 +129,8 @@ struct elf_info {
 	 * take shndx from symtab_shndx_start[N] instead */
 	Elf32_Word   *symtab_shndx_start;
 	Elf32_Word   *symtab_shndx_stop;
+
+	struct symsearch *symsearch;
 };
 
 /* Accessor for sym->st_shndx, hides ugliness of "64k sections" */
@@ -154,6 +157,28 @@ static inline unsigned int get_secindex(const struct elf_info *info,
 	return index;
 }
 
+/*
+ * If there's no name there, ignore it; likewise, ignore it if it's
+ * one of the magic symbols emitted used by current tools.
+ *
+ * Internal symbols created by tools should be ignored by modpost.
+ */
+static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
+{
+	const char *name = elf->strtab + sym->st_name;
+
+	if (!name || !strlen(name))
+		return 0;
+	return !is_mapping_symbol(name);
+}
+
+/* symsearch.c */
+void symsearch_init(struct elf_info *elf);
+void symsearch_finish(struct elf_info *elf);
+Elf_Sym *symsearch_find_nearest(struct elf_info *elf, Elf_Addr addr,
+				unsigned int secndx, bool allow_negative,
+				Elf_Addr min_distance);
+
 /* file2alias.c */
 void handle_moddevtable(struct module *mod, struct elf_info *info,
 			Elf_Sym *sym, const char *symname);
diff --git a/scripts/mod/symsearch.c b/scripts/mod/symsearch.c
new file mode 100644
index 0000000000000..aa4ed51f9960c
--- /dev/null
+++ b/scripts/mod/symsearch.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Helper functions for finding the symbol in an ELF which is "nearest"
+ * to a given address.
+ */
+
+#include "modpost.h"
+
+struct syminfo {
+	unsigned int symbol_index;
+	unsigned int section_index;
+	Elf_Addr addr;
+};
+
+/*
+ * Container used to hold an entire binary search table.
+ * Entries in table are ascending, sorted first by section_index,
+ * then by addr, and last by symbol_index.  The sorting by
+ * symbol_index is used to ensure predictable behavior when
+ * multiple symbols are present with the same address; all
+ * symbols past the first are effectively ignored, by eliding
+ * them in symsearch_fixup().
+ */
+struct symsearch {
+	unsigned int table_size;
+	struct syminfo table[];
+};
+
+static int syminfo_compare(const void *s1, const void *s2)
+{
+	const struct syminfo *sym1 = s1;
+	const struct syminfo *sym2 = s2;
+
+	if (sym1->section_index > sym2->section_index)
+		return 1;
+	if (sym1->section_index < sym2->section_index)
+		return -1;
+	if (sym1->addr > sym2->addr)
+		return 1;
+	if (sym1->addr < sym2->addr)
+		return -1;
+	if (sym1->symbol_index > sym2->symbol_index)
+		return 1;
+	if (sym1->symbol_index < sym2->symbol_index)
+		return -1;
+	return 0;
+}
+
+static unsigned int symbol_count(struct elf_info *elf)
+{
+	unsigned int result = 0;
+
+	for (Elf_Sym *sym = elf->symtab_start; sym < elf->symtab_stop; sym++) {
+		if (is_valid_name(elf, sym))
+			result++;
+	}
+	return result;
+}
+
+/*
+ * Populate the search array that we just allocated.
+ * Be slightly paranoid here.  The ELF file is mmap'd and could
+ * conceivably change between symbol_count() and symsearch_populate().
+ * If we notice any difference, bail out rather than potentially
+ * propagating errors or crashing.
+ */
+static void symsearch_populate(struct elf_info *elf,
+			       struct syminfo *table,
+			       unsigned int table_size)
+{
+	bool is_arm = (elf->hdr->e_machine == EM_ARM);
+
+	for (Elf_Sym *sym = elf->symtab_start; sym < elf->symtab_stop; sym++) {
+		if (is_valid_name(elf, sym)) {
+			if (table_size-- == 0)
+				fatal("%s: size mismatch\n", __func__);
+			table->symbol_index = sym - elf->symtab_start;
+			table->section_index = get_secindex(elf, sym);
+			table->addr = sym->st_value;
+
+			/*
+			 * For ARM Thumb instruction, the bit 0 of st_value is
+			 * set if the symbol is STT_FUNC type. Mask it to get
+			 * the address.
+			 */
+			if (is_arm && ELF_ST_TYPE(sym->st_info) == STT_FUNC)
+				table->addr &= ~1;
+
+			table++;
+		}
+	}
+
+	if (table_size != 0)
+		fatal("%s: size mismatch\n", __func__);
+}
+
+/*
+ * Do any fixups on the table after sorting.
+ * For now, this just finds adjacent entries which have
+ * the same section_index and addr, and it propagates
+ * the first symbol_index over the subsequent entries,
+ * so that only one symbol_index is seen for any given
+ * section_index and addr.  This ensures that whether
+ * we're looking at an address from "above" or "below"
+ * that we see the same symbol_index.
+ * This does leave some duplicate entries in the table;
+ * in practice, these are a small fraction of the
+ * total number of entries, and they are harmless to
+ * the binary search algorithm other than a few occasional
+ * unnecessary comparisons.
+ */
+static void symsearch_fixup(struct syminfo *table, unsigned int table_size)
+{
+	/* Don't look at index 0, it will never change. */
+	for (unsigned int i = 1; i < table_size; i++) {
+		if (table[i].addr == table[i - 1].addr &&
+		    table[i].section_index == table[i - 1].section_index) {
+			table[i].symbol_index = table[i - 1].symbol_index;
+		}
+	}
+}
+
+void symsearch_init(struct elf_info *elf)
+{
+	unsigned int table_size = symbol_count(elf);
+
+	elf->symsearch = NOFAIL(malloc(sizeof(struct symsearch) +
+				       sizeof(struct syminfo) * table_size));
+	elf->symsearch->table_size = table_size;
+
+	symsearch_populate(elf, elf->symsearch->table, table_size);
+	qsort(elf->symsearch->table, table_size,
+	      sizeof(struct syminfo), syminfo_compare);
+
+	symsearch_fixup(elf->symsearch->table, table_size);
+}
+
+void symsearch_finish(struct elf_info *elf)
+{
+	free(elf->symsearch);
+	elf->symsearch = NULL;
+}
+
+/*
+ * Find the syminfo which is in secndx and "nearest" to addr.
+ * allow_negative: allow returning a symbol whose address is > addr.
+ * min_distance: ignore symbols which are further away than this.
+ *
+ * Returns a pointer into the symbol table for success.
+ * Returns NULL if no legal symbol is found within the requested range.
+ */
+Elf_Sym *symsearch_find_nearest(struct elf_info *elf, Elf_Addr addr,
+				unsigned int secndx, bool allow_negative,
+				Elf_Addr min_distance)
+{
+	unsigned int hi = elf->symsearch->table_size;
+	unsigned int lo = 0;
+	struct syminfo *table = elf->symsearch->table;
+	struct syminfo target;
+
+	target.addr = addr;
+	target.section_index = secndx;
+	target.symbol_index = ~0;  /* compares greater than any actual index */
+	while (hi > lo) {
+		unsigned int mid = lo + (hi - lo) / 2;  /* Avoids overflow */
+
+		if (syminfo_compare(&table[mid], &target) > 0)
+			hi = mid;
+		else
+			lo = mid + 1;
+	}
+
+	/*
+	 * table[hi], if it exists, is the first entry in the array which
+	 * lies beyond target.  table[hi - 1], if it exists, is the last
+	 * entry in the array which comes before target, including the
+	 * case where it perfectly matches the section and the address.
+	 *
+	 * Note -- if the address we're looking up falls perfectly
+	 * in the middle of two symbols, this is written to always
+	 * prefer the symbol with the lower address.
+	 */
+	Elf_Sym *result = NULL;
+
+	if (allow_negative &&
+	    hi < elf->symsearch->table_size &&
+	    table[hi].section_index == secndx &&
+	    table[hi].addr - addr <= min_distance) {
+		min_distance = table[hi].addr - addr;
+		result = &elf->symtab_start[table[hi].symbol_index];
+	}
+	if (hi > 0 &&
+	    table[hi - 1].section_index == secndx &&
+	    addr - table[hi - 1].addr <= min_distance) {
+		result = &elf->symtab_start[table[hi - 1].symbol_index];
+	}
+	return result;
+}
-- 
2.43.0




