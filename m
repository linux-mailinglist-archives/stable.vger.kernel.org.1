Return-Path: <stable+bounces-124291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E6FA5F470
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212791700AD
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEBD267AE3;
	Thu, 13 Mar 2025 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mFOn7JwX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE893267AEC;
	Thu, 13 Mar 2025 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868915; cv=none; b=k/u/ogL5PlRP4eeS40AhdnmiGpavs5l0ZFy9WP3osNPifS+OHFaAZ9TNSIrL0oQDk/VJ64qt4Zuc2+rP9Ete3O6Mk+C89AwI1ySZUAdGClBUHeXGnFRJaBJRLwvUIhQ/V+SQVoWvET0g6oj+9eqElYGc473UCkt0qbz1fOL9Kdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868915; c=relaxed/simple;
	bh=BrA5kwQMmGQQMYk6S2XUWmZeq22AObYhwIfp/FjW3dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g530jkLLArLcNaDAxghR2JNGruS//djGDV92O1THWYAILd3SXknG2U84hnLhFvzEXniOLs0WZdqXdP6wmd8DTfq5EvG1OzI6Ir1jhadALH1UeRjnCYCHV25m5psSNiA1OCTSv7gqblHSQz0VUeZC7zugVBkIGUV6X459buTzdsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mFOn7JwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E95FC4CEDD;
	Thu, 13 Mar 2025 12:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741868914;
	bh=BrA5kwQMmGQQMYk6S2XUWmZeq22AObYhwIfp/FjW3dI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mFOn7JwX7lrGOccehyhu9WOBJFOEGfu0DJxAg1Z8fd+tgKbE9jMxQm/+uXGyjbMBz
	 khT3GMZzSIWg/kng1r3SVr9xun0aHSNQ/Z5pVpx2rKc+Qs9Hskz2YbogxKArkTBhid
	 5K5lqtENwB66rtT8oDTPUggQ1n7+PzFBy8UABZMc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.19
Date: Thu, 13 Mar 2025 13:28:20 +0100
Message-ID: <2025031320-linguini-dioxide-e60d@gregkh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025031320-obsessed-gentile-edc7@gregkh>
References: <2025031320-obsessed-gentile-edc7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/.clippy.toml b/.clippy.toml
new file mode 100644
index 000000000000..e4c4eef10b28
--- /dev/null
+++ b/.clippy.toml
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+check-private-items = true
+
+disallowed-macros = [
+    # The `clippy::dbg_macro` lint only works with `std::dbg!`, thus we simulate
+    # it here, see: https://github.com/rust-lang/rust-clippy/issues/11303.
+    { path = "kernel::dbg", reason = "the `dbg!` macro is intended as a debugging tool" },
+]
diff --git a/.gitignore b/.gitignore
index 56972adb5031..a61e4778d011 100644
--- a/.gitignore
+++ b/.gitignore
@@ -103,6 +103,7 @@ modules.order
 # We don't want to ignore the following even if they are dot-files
 #
 !.clang-format
+!.clippy.toml
 !.cocciconfig
 !.editorconfig
 !.get_maintainer.ignore
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index f8bc1630eba0..fa21cdd610b2 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -212,6 +212,17 @@ pid>/``).
 This value defaults to 0.
 
 
+core_sort_vma
+=============
+
+The default coredump writes VMAs in address order. By setting
+``core_sort_vma`` to 1, VMAs will be written from smallest size
+to largest size. This is known to break at least elfutils, but
+can be handy when dealing with very large (and truncated)
+coredumps where the more useful debugging details are included
+in the smaller VMAs.
+
+
 core_uses_pid
 =============
 
diff --git a/Documentation/rust/coding-guidelines.rst b/Documentation/rust/coding-guidelines.rst
index 329b070a1d47..a2e326b42410 100644
--- a/Documentation/rust/coding-guidelines.rst
+++ b/Documentation/rust/coding-guidelines.rst
@@ -227,3 +227,149 @@ The equivalent in Rust may look like (ignoring documentation):
 That is, the equivalent of ``GPIO_LINE_DIRECTION_IN`` would be referred to as
 ``gpio::LineDirection::In``. In particular, it should not be named
 ``gpio::gpio_line_direction::GPIO_LINE_DIRECTION_IN``.
+
+
+Lints
+-----
+
+In Rust, it is possible to ``allow`` particular warnings (diagnostics, lints)
+locally, making the compiler ignore instances of a given warning within a given
+function, module, block, etc.
+
+It is similar to ``#pragma GCC diagnostic push`` + ``ignored`` + ``pop`` in C
+[#]_:
+
+.. code-block:: c
+
+	#pragma GCC diagnostic push
+	#pragma GCC diagnostic ignored "-Wunused-function"
+	static void f(void) {}
+	#pragma GCC diagnostic pop
+
+.. [#] In this particular case, the kernel's ``__{always,maybe}_unused``
+       attributes (C23's ``[[maybe_unused]]``) may be used; however, the example
+       is meant to reflect the equivalent lint in Rust discussed afterwards.
+
+But way less verbose:
+
+.. code-block:: rust
+
+	#[allow(dead_code)]
+	fn f() {}
+
+By that virtue, it makes it possible to comfortably enable more diagnostics by
+default (i.e. outside ``W=`` levels). In particular, those that may have some
+false positives but that are otherwise quite useful to keep enabled to catch
+potential mistakes.
+
+On top of that, Rust provides the ``expect`` attribute which takes this further.
+It makes the compiler warn if the warning was not produced. For instance, the
+following will ensure that, when ``f()`` is called somewhere, we will have to
+remove the attribute:
+
+.. code-block:: rust
+
+	#[expect(dead_code)]
+	fn f() {}
+
+If we do not, we get a warning from the compiler::
+
+	warning: this lint expectation is unfulfilled
+	 --> x.rs:3:10
+	  |
+	3 | #[expect(dead_code)]
+	  |          ^^^^^^^^^
+	  |
+	  = note: `#[warn(unfulfilled_lint_expectations)]` on by default
+
+This means that ``expect``\ s do not get forgotten when they are not needed, which
+may happen in several situations, e.g.:
+
+- Temporary attributes added while developing.
+
+- Improvements in lints in the compiler, Clippy or custom tools which may
+  remove a false positive.
+
+- When the lint is not needed anymore because it was expected that it would be
+  removed at some point, such as the ``dead_code`` example above.
+
+It also increases the visibility of the remaining ``allow``\ s and reduces the
+chance of misapplying one.
+
+Thus prefer ``expect`` over ``allow`` unless:
+
+- Conditional compilation triggers the warning in some cases but not others.
+
+  If there are only a few cases where the warning triggers (or does not
+  trigger) compared to the total number of cases, then one may consider using
+  a conditional ``expect`` (i.e. ``cfg_attr(..., expect(...))``). Otherwise,
+  it is likely simpler to just use ``allow``.
+
+- Inside macros, when the different invocations may create expanded code that
+  triggers the warning in some cases but not in others.
+
+- When code may trigger a warning for some architectures but not others, such
+  as an ``as`` cast to a C FFI type.
+
+As a more developed example, consider for instance this program:
+
+.. code-block:: rust
+
+	fn g() {}
+
+	fn main() {
+	    #[cfg(CONFIG_X)]
+	    g();
+	}
+
+Here, function ``g()`` is dead code if ``CONFIG_X`` is not set. Can we use
+``expect`` here?
+
+.. code-block:: rust
+
+	#[expect(dead_code)]
+	fn g() {}
+
+	fn main() {
+	    #[cfg(CONFIG_X)]
+	    g();
+	}
+
+This would emit a lint if ``CONFIG_X`` is set, since it is not dead code in that
+configuration. Therefore, in cases like this, we cannot use ``expect`` as-is.
+
+A simple possibility is using ``allow``:
+
+.. code-block:: rust
+
+	#[allow(dead_code)]
+	fn g() {}
+
+	fn main() {
+	    #[cfg(CONFIG_X)]
+	    g();
+	}
+
+An alternative would be using a conditional ``expect``:
+
+.. code-block:: rust
+
+	#[cfg_attr(not(CONFIG_X), expect(dead_code))]
+	fn g() {}
+
+	fn main() {
+	    #[cfg(CONFIG_X)]
+	    g();
+	}
+
+This would ensure that, if someone introduces another call to ``g()`` somewhere
+(e.g. unconditionally), then it would be spotted that it is not dead code
+anymore. However, the ``cfg_attr`` is more complex than a simple ``allow``.
+
+Therefore, it is likely that it is not worth using conditional ``expect``\ s when
+more than one or two configurations are involved or when the lint may be
+triggered due to non-local changes (such as ``dead_code``).
+
+For more information about diagnostics in Rust, please see:
+
+	https://doc.rust-lang.org/stable/reference/attributes/diagnostics.html
diff --git a/MAINTAINERS b/MAINTAINERS
index 6bb4ec0c162a..de04c7ba8571 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20175,6 +20175,7 @@ B:	https://github.com/Rust-for-Linux/linux/issues
 C:	zulip://rust-for-linux.zulipchat.com
 P:	https://rust-for-linux.com/contributing
 T:	git https://github.com/Rust-for-Linux/linux.git rust-next
+F:	.clippy.toml
 F:	Documentation/rust/
 F:	rust/
 F:	samples/rust/
@@ -20182,6 +20183,13 @@ F:	scripts/*rust*
 F:	tools/testing/selftests/rust/
 K:	\b(?i:rust)\b
 
+RUST [ALLOC]
+M:	Danilo Krummrich <dakr@kernel.org>
+L:	rust-for-linux@vger.kernel.org
+S:	Maintained
+F:	rust/kernel/alloc.rs
+F:	rust/kernel/alloc/
+
 RXRPC SOCKETS (AF_RXRPC)
 M:	David Howells <dhowells@redhat.com>
 M:	Marc Dionne <marc.dionne@auristor.com>
diff --git a/Makefile b/Makefile
index 17dfe0a8ca8f..343c9f25433c 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 18
+SUBLEVEL = 19
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
@@ -446,19 +446,23 @@ KBUILD_USERLDFLAGS := $(USERLDFLAGS)
 export rust_common_flags := --edition=2021 \
 			    -Zbinary_dep_depinfo=y \
 			    -Astable_features \
-			    -Dunsafe_op_in_unsafe_fn \
 			    -Dnon_ascii_idents \
+			    -Dunsafe_op_in_unsafe_fn \
+			    -Wmissing_docs \
 			    -Wrust_2018_idioms \
 			    -Wunreachable_pub \
-			    -Wmissing_docs \
-			    -Wrustdoc::missing_crate_level_docs \
 			    -Wclippy::all \
+			    -Wclippy::ignored_unit_patterns \
 			    -Wclippy::mut_mut \
 			    -Wclippy::needless_bitwise_bool \
 			    -Wclippy::needless_continue \
 			    -Aclippy::needless_lifetimes \
 			    -Wclippy::no_mangle_with_rust_abi \
-			    -Wclippy::dbg_macro
+			    -Wclippy::undocumented_unsafe_blocks \
+			    -Wclippy::unnecessary_safety_comment \
+			    -Wclippy::unnecessary_safety_doc \
+			    -Wrustdoc::missing_crate_level_docs \
+			    -Wrustdoc::unescaped_backticks
 
 KBUILD_HOSTCFLAGS   := $(KBUILD_USERHOSTCFLAGS) $(HOST_LFS_CFLAGS) \
 		       $(HOSTCFLAGS) -I $(srctree)/scripts/include
@@ -583,6 +587,9 @@ endif
 # Allows the usage of unstable features in stable compilers.
 export RUSTC_BOOTSTRAP := 1
 
+# Allows finding `.clippy.toml` in out-of-srctree builds.
+export CLIPPY_CONF_DIR := $(srctree)
+
 export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE LD CC HOSTPKG_CONFIG
 export RUSTC RUSTDOC RUSTFMT RUSTC_OR_CLIPPY_QUIET RUSTC_OR_CLIPPY BINDGEN
 export HOSTRUSTC KBUILD_HOSTRUSTFLAGS
@@ -1060,6 +1067,11 @@ endif
 KBUILD_USERCFLAGS  += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 KBUILD_USERLDFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 
+# userspace programs are linked via the compiler, use the correct linker
+ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_LD_IS_LLD),yy)
+KBUILD_USERLDFLAGS += --ld-path=$(LD)
+endif
+
 # make the checker run with the right architecture
 CHECKFLAGS += --arch=$(ARCH)
 
diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 293f880865e8..f0304273eb35 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -34,8 +34,8 @@ extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 				      unsigned long addr, pte_t *ptep,
 				      pte_t pte, int dirty);
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
-extern pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-				     unsigned long addr, pte_t *ptep);
+extern pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
+				     pte_t *ptep, unsigned long sz);
 #define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
 extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
 				    unsigned long addr, pte_t *ptep);
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 0a6956bbfb32..fe167ce297a1 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -100,20 +100,11 @@ static int find_num_contig(struct mm_struct *mm, unsigned long addr,
 
 static inline int num_contig_ptes(unsigned long size, size_t *pgsize)
 {
-	int contig_ptes = 0;
+	int contig_ptes = 1;
 
 	*pgsize = size;
 
 	switch (size) {
-#ifndef __PAGETABLE_PMD_FOLDED
-	case PUD_SIZE:
-		if (pud_sect_supported())
-			contig_ptes = 1;
-		break;
-#endif
-	case PMD_SIZE:
-		contig_ptes = 1;
-		break;
 	case CONT_PMD_SIZE:
 		*pgsize = PMD_SIZE;
 		contig_ptes = CONT_PMDS;
@@ -122,6 +113,8 @@ static inline int num_contig_ptes(unsigned long size, size_t *pgsize)
 		*pgsize = PAGE_SIZE;
 		contig_ptes = CONT_PTES;
 		break;
+	default:
+		WARN_ON(!__hugetlb_valid_size(size));
 	}
 
 	return contig_ptes;
@@ -163,24 +156,23 @@ static pte_t get_clear_contig(struct mm_struct *mm,
 			     unsigned long pgsize,
 			     unsigned long ncontig)
 {
-	pte_t orig_pte = __ptep_get(ptep);
-	unsigned long i;
-
-	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++) {
-		pte_t pte = __ptep_get_and_clear(mm, addr, ptep);
-
-		/*
-		 * If HW_AFDBM is enabled, then the HW could turn on
-		 * the dirty or accessed bit for any page in the set,
-		 * so check them all.
-		 */
-		if (pte_dirty(pte))
-			orig_pte = pte_mkdirty(orig_pte);
-
-		if (pte_young(pte))
-			orig_pte = pte_mkyoung(orig_pte);
+	pte_t pte, tmp_pte;
+	bool present;
+
+	pte = __ptep_get_and_clear(mm, addr, ptep);
+	present = pte_present(pte);
+	while (--ncontig) {
+		ptep++;
+		addr += pgsize;
+		tmp_pte = __ptep_get_and_clear(mm, addr, ptep);
+		if (present) {
+			if (pte_dirty(tmp_pte))
+				pte = pte_mkdirty(pte);
+			if (pte_young(tmp_pte))
+				pte = pte_mkyoung(pte);
+		}
 	}
-	return orig_pte;
+	return pte;
 }
 
 static pte_t get_clear_contig_flush(struct mm_struct *mm,
@@ -385,18 +377,13 @@ void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 		__pte_clear(mm, addr, ptep);
 }
 
-pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-			      unsigned long addr, pte_t *ptep)
+pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, unsigned long sz)
 {
 	int ncontig;
 	size_t pgsize;
-	pte_t orig_pte = __ptep_get(ptep);
-
-	if (!pte_cont(orig_pte))
-		return __ptep_get_and_clear(mm, addr, ptep);
-
-	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
 
+	ncontig = num_contig_ptes(sz, &pgsize);
 	return get_clear_contig(mm, addr, ptep, pgsize, ncontig);
 }
 
@@ -538,6 +525,8 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
 
 pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
+	unsigned long psize = huge_page_size(hstate_vma(vma));
+
 	if (alternative_has_cap_unlikely(ARM64_WORKAROUND_2645198)) {
 		/*
 		 * Break-before-make (BBM) is required for all user space mappings
@@ -547,7 +536,7 @@ pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr
 		if (pte_user_exec(__ptep_get(ptep)))
 			return huge_ptep_clear_flush(vma, addr, ptep);
 	}
-	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep, psize);
 }
 
 void huge_ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep,
diff --git a/arch/loongarch/include/asm/bug.h b/arch/loongarch/include/asm/bug.h
index 08388876ade4..561ac1bf79e2 100644
--- a/arch/loongarch/include/asm/bug.h
+++ b/arch/loongarch/include/asm/bug.h
@@ -4,6 +4,7 @@
 
 #include <asm/break.h>
 #include <linux/stringify.h>
+#include <linux/objtool.h>
 
 #ifndef CONFIG_DEBUG_BUGVERBOSE
 #define _BUGVERBOSE_LOCATION(file, line)
@@ -33,25 +34,25 @@
 
 #define ASM_BUG_FLAGS(flags)					\
 	__BUG_ENTRY(flags)					\
-	break		BRK_BUG
+	break		BRK_BUG;
 
 #define ASM_BUG()	ASM_BUG_FLAGS(0)
 
-#define __BUG_FLAGS(flags)					\
-	asm_inline volatile (__stringify(ASM_BUG_FLAGS(flags)));
+#define __BUG_FLAGS(flags, extra)					\
+	asm_inline volatile (__stringify(ASM_BUG_FLAGS(flags))		\
+			     extra);
 
 #define __WARN_FLAGS(flags)					\
 do {								\
 	instrumentation_begin();				\
-	__BUG_FLAGS(BUGFLAG_WARNING|(flags));			\
-	annotate_reachable();					\
+	__BUG_FLAGS(BUGFLAG_WARNING|(flags), ASM_REACHABLE);	\
 	instrumentation_end();					\
 } while (0)
 
 #define BUG()							\
 do {								\
 	instrumentation_begin();				\
-	__BUG_FLAGS(0);						\
+	__BUG_FLAGS(0, "");					\
 	unreachable();						\
 } while (0)
 
diff --git a/arch/loongarch/include/asm/hugetlb.h b/arch/loongarch/include/asm/hugetlb.h
index 376c0708e297..6302e60fbaee 100644
--- a/arch/loongarch/include/asm/hugetlb.h
+++ b/arch/loongarch/include/asm/hugetlb.h
@@ -41,7 +41,8 @@ static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-					    unsigned long addr, pte_t *ptep)
+					    unsigned long addr, pte_t *ptep,
+					    unsigned long sz)
 {
 	pte_t clear;
 	pte_t pte = ptep_get(ptep);
@@ -56,8 +57,9 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long addr, pte_t *ptep)
 {
 	pte_t pte;
+	unsigned long sz = huge_page_size(hstate_vma(vma));
 
-	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep, sz);
 	flush_tlb_page(vma, addr);
 	return pte;
 }
diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
index 8ae641dc53bb..f9381800e291 100644
--- a/arch/loongarch/kernel/machine_kexec.c
+++ b/arch/loongarch/kernel/machine_kexec.c
@@ -126,14 +126,14 @@ void kexec_reboot(void)
 	/* All secondary cpus go to kexec_smp_wait */
 	if (smp_processor_id() > 0) {
 		relocated_kexec_smp_wait(NULL);
-		unreachable();
+		BUG();
 	}
 #endif
 
 	do_kexec = (void *)reboot_code_buffer;
 	do_kexec(efi_boot, cmdline_ptr, systable_ptr, start_addr, first_ind_entry);
 
-	unreachable();
+	BUG();
 }
 
 
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 56934fe58170..1fa6a604734e 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -387,6 +387,9 @@ static void __init check_kernel_sections_mem(void)
  */
 static void __init arch_mem_init(char **cmdline_p)
 {
+	/* Recalculate max_low_pfn for "mem=xxx" */
+	max_pfn = max_low_pfn = PHYS_PFN(memblock_end_of_DRAM());
+
 	if (usermem)
 		pr_info("User-defined physical RAM map overwrite\n");
 
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 5d59e9ce2772..d96065dbe779 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -19,6 +19,7 @@
 #include <linux/smp.h>
 #include <linux/threads.h>
 #include <linux/export.h>
+#include <linux/suspend.h>
 #include <linux/syscore_ops.h>
 #include <linux/time.h>
 #include <linux/tracepoint.h>
@@ -423,7 +424,7 @@ void loongson_cpu_die(unsigned int cpu)
 	mb();
 }
 
-void __noreturn arch_cpu_idle_dead(void)
+static void __noreturn idle_play_dead(void)
 {
 	register uint64_t addr;
 	register void (*init_fn)(void);
@@ -447,6 +448,50 @@ void __noreturn arch_cpu_idle_dead(void)
 	BUG();
 }
 
+#ifdef CONFIG_HIBERNATION
+static void __noreturn poll_play_dead(void)
+{
+	register uint64_t addr;
+	register void (*init_fn)(void);
+
+	idle_task_exit();
+	__this_cpu_write(cpu_state, CPU_DEAD);
+
+	__smp_mb();
+	do {
+		__asm__ __volatile__("nop\n\t");
+		addr = iocsr_read64(LOONGARCH_IOCSR_MBUF0);
+	} while (addr == 0);
+
+	init_fn = (void *)TO_CACHE(addr);
+	iocsr_write32(0xffffffff, LOONGARCH_IOCSR_IPI_CLEAR);
+
+	init_fn();
+	BUG();
+}
+#endif
+
+static void (*play_dead)(void) = idle_play_dead;
+
+void __noreturn arch_cpu_idle_dead(void)
+{
+	play_dead();
+	BUG(); /* play_dead() doesn't return */
+}
+
+#ifdef CONFIG_HIBERNATION
+int hibernate_resume_nonboot_cpu_disable(void)
+{
+	int ret;
+
+	play_dead = poll_play_dead;
+	ret = suspend_disable_secondary_cpus();
+	play_dead = idle_play_dead;
+
+	return ret;
+}
+#endif
+
 #endif
 
 /*
diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
index 90894f70ff4a..add52e927f15 100644
--- a/arch/loongarch/kvm/exit.c
+++ b/arch/loongarch/kvm/exit.c
@@ -624,6 +624,12 @@ static int kvm_handle_rdwr_fault(struct kvm_vcpu *vcpu, bool write)
 	struct kvm_run *run = vcpu->run;
 	unsigned long badv = vcpu->arch.badv;
 
+	/* Inject ADE exception if exceed max GPA size */
+	if (unlikely(badv >= vcpu->kvm->arch.gpa_size)) {
+		kvm_queue_exception(vcpu, EXCCODE_ADE, EXSUBCODE_ADEM);
+		return RESUME_GUEST;
+	}
+
 	ret = kvm_handle_mm_fault(vcpu, badv, write);
 	if (ret) {
 		/* Treat as MMIO */
diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index 7e8f5d6829ef..34fad2c29ee6 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -297,6 +297,13 @@ int kvm_arch_enable_virtualization_cpu(void)
 	kvm_debug("GCFG:%lx GSTAT:%lx GINTC:%lx GTLBC:%lx",
 		  read_csr_gcfg(), read_csr_gstat(), read_csr_gintc(), read_csr_gtlbc());
 
+	/*
+	 * HW Guest CSR registers are lost after CPU suspend and resume.
+	 * Clear last_vcpu so that Guest CSR registers forced to reload
+	 * from vCPU SW state.
+	 */
+	this_cpu_ptr(vmcs)->last_vcpu = NULL;
+
 	return 0;
 }
 
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 9d53eca66fcc..e7a084de64f7 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -311,7 +311,7 @@ static int kvm_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
 	int ret = RESUME_GUEST;
 	unsigned long estat = vcpu->arch.host_estat;
-	u32 intr = estat & 0x1fff; /* Ignore NMI */
+	u32 intr = estat & CSR_ESTAT_IS;
 	u32 ecode = (estat & CSR_ESTAT_EXC) >> CSR_ESTAT_EXC_SHIFT;
 
 	vcpu->mode = OUTSIDE_GUEST_MODE;
diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
index 4ba734aaef87..fe9e973912d4 100644
--- a/arch/loongarch/kvm/vm.c
+++ b/arch/loongarch/kvm/vm.c
@@ -46,7 +46,11 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	if (kvm_pvtime_supported())
 		kvm->arch.pv_features |= BIT(KVM_FEATURE_STEAL_TIME);
 
-	kvm->arch.gpa_size = BIT(cpu_vabits - 1);
+	/*
+	 * cpu_vabits means user address space only (a half of total).
+	 * GPA size of VM is the same with the size of user address space.
+	 */
+	kvm->arch.gpa_size = BIT(cpu_vabits);
 	kvm->arch.root_level = CONFIG_PGTABLE_LEVELS - 1;
 	kvm->arch.invalid_ptes[0] = 0;
 	kvm->arch.invalid_ptes[1] = (unsigned long)invalid_pte_table;
diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
index fd69c8808554..00ee3c036630 100644
--- a/arch/mips/include/asm/hugetlb.h
+++ b/arch/mips/include/asm/hugetlb.h
@@ -32,7 +32,8 @@ static inline int prepare_hugepage_range(struct file *file,
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-					    unsigned long addr, pte_t *ptep)
+					    unsigned long addr, pte_t *ptep,
+					    unsigned long sz)
 {
 	pte_t clear;
 	pte_t pte = *ptep;
@@ -47,13 +48,14 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long addr, pte_t *ptep)
 {
 	pte_t pte;
+	unsigned long sz = huge_page_size(hstate_vma(vma));
 
 	/*
 	 * clear the huge pte entry firstly, so that the other smp threads will
 	 * not get old pte entry after finishing flush_tlb_page and before
 	 * setting new huge pte entry
 	 */
-	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep, sz);
 	flush_tlb_page(vma, addr);
 	return pte;
 }
diff --git a/arch/parisc/include/asm/hugetlb.h b/arch/parisc/include/asm/hugetlb.h
index 72daacc472a0..f7a91411dcc9 100644
--- a/arch/parisc/include/asm/hugetlb.h
+++ b/arch/parisc/include/asm/hugetlb.h
@@ -10,7 +10,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep);
+			      pte_t *ptep, unsigned long sz);
 
 /*
  * If the arch doesn't supply something else, assume that hugepage
diff --git a/arch/parisc/mm/hugetlbpage.c b/arch/parisc/mm/hugetlbpage.c
index aa664f7ddb63..cec2b9a581dd 100644
--- a/arch/parisc/mm/hugetlbpage.c
+++ b/arch/parisc/mm/hugetlbpage.c
@@ -147,7 +147,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 
 
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep)
+			      pte_t *ptep, unsigned long sz)
 {
 	pte_t entry;
 
diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index dad2e7980f24..86326587e58d 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -45,7 +45,8 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-					    unsigned long addr, pte_t *ptep)
+					    unsigned long addr, pte_t *ptep,
+					    unsigned long sz)
 {
 	return __pte(pte_update(mm, addr, ptep, ~0UL, 0, 1));
 }
@@ -55,8 +56,9 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long addr, pte_t *ptep)
 {
 	pte_t pte;
+	unsigned long sz = huge_page_size(hstate_vma(vma));
 
-	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep, sz);
 	flush_hugetlb_page(vma, addr);
 	return pte;
 }
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index 6824e8139801..3708fa48bee9 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -242,7 +242,7 @@ static inline int tlbe_is_writable(struct kvm_book3e_206_tlb_entry *tlbe)
 	return tlbe->mas7_3 & (MAS3_SW|MAS3_UW);
 }
 
-static inline bool kvmppc_e500_ref_setup(struct tlbe_ref *ref,
+static inline void kvmppc_e500_ref_setup(struct tlbe_ref *ref,
 					 struct kvm_book3e_206_tlb_entry *gtlbe,
 					 kvm_pfn_t pfn, unsigned int wimg)
 {
@@ -252,7 +252,11 @@ static inline bool kvmppc_e500_ref_setup(struct tlbe_ref *ref,
 	/* Use guest supplied MAS2_G and MAS2_E */
 	ref->flags |= (gtlbe->mas2 & MAS2_ATTRIB_MASK) | wimg;
 
-	return tlbe_is_writable(gtlbe);
+	/* Mark the page accessed */
+	kvm_set_pfn_accessed(pfn);
+
+	if (tlbe_is_writable(gtlbe))
+		kvm_set_pfn_dirty(pfn);
 }
 
 static inline void kvmppc_e500_ref_release(struct tlbe_ref *ref)
@@ -322,7 +326,6 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 {
 	struct kvm_memory_slot *slot;
 	unsigned long pfn = 0; /* silence GCC warning */
-	struct page *page = NULL;
 	unsigned long hva;
 	int pfnmap = 0;
 	int tsize = BOOK3E_PAGESZ_4K;
@@ -334,7 +337,6 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 	unsigned int wimg = 0;
 	pgd_t *pgdir;
 	unsigned long flags;
-	bool writable = false;
 
 	/* used to check for invalidations in progress */
 	mmu_seq = kvm->mmu_invalidate_seq;
@@ -444,7 +446,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 
 	if (likely(!pfnmap)) {
 		tsize_pages = 1UL << (tsize + 10 - PAGE_SHIFT);
-		pfn = __kvm_faultin_pfn(slot, gfn, FOLL_WRITE, NULL, &page);
+		pfn = gfn_to_pfn_memslot(slot, gfn);
 		if (is_error_noslot_pfn(pfn)) {
 			if (printk_ratelimit())
 				pr_err("%s: real page not found for gfn %lx\n",
@@ -489,7 +491,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 	}
 	local_irq_restore(flags);
 
-	writable = kvmppc_e500_ref_setup(ref, gtlbe, pfn, wimg);
+	kvmppc_e500_ref_setup(ref, gtlbe, pfn, wimg);
 	kvmppc_e500_setup_stlbe(&vcpu_e500->vcpu, gtlbe, tsize,
 				ref, gvaddr, stlbe);
 
@@ -497,8 +499,11 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 	kvmppc_mmu_flush_icache(pfn);
 
 out:
-	kvm_release_faultin_page(kvm, page, !!ret, writable);
 	spin_unlock(&kvm->mmu_lock);
+
+	/* Drop refcount on page, so that mmu notifiers can clear it */
+	kvm_release_pfn_clean(pfn);
+
 	return ret;
 }
 
diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
index faf3624d8057..446126497768 100644
--- a/arch/riscv/include/asm/hugetlb.h
+++ b/arch/riscv/include/asm/hugetlb.h
@@ -28,7 +28,8 @@ void set_huge_pte_at(struct mm_struct *mm,
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-			      unsigned long addr, pte_t *ptep);
+			      unsigned long addr, pte_t *ptep,
+			      unsigned long sz);
 
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
 pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 42314f093922..b4a78a4b35cf 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -293,7 +293,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 			      unsigned long addr,
-			      pte_t *ptep)
+			      pte_t *ptep, unsigned long sz)
 {
 	pte_t orig_pte = ptep_get(ptep);
 	int pte_num;
diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index cf1b5d6fb1a6..4731a51241ba 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -20,8 +20,15 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t pte);
 pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
-pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-			      unsigned long addr, pte_t *ptep);
+pte_t __huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep);
+
+static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+					    unsigned long addr, pte_t *ptep,
+					    unsigned long sz)
+{
+	return __huge_ptep_get_and_clear(mm, addr, ptep);
+}
 
 /*
  * If the arch doesn't supply something else, assume that hugepage
@@ -57,7 +64,7 @@ static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long address, pte_t *ptep)
 {
-	return huge_ptep_get_and_clear(vma->vm_mm, address, ptep);
+	return __huge_ptep_get_and_clear(vma->vm_mm, address, ptep);
 }
 
 static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
@@ -66,7 +73,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 {
 	int changed = !pte_same(huge_ptep_get(vma->vm_mm, addr, ptep), pte);
 	if (changed) {
-		huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+		__huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
 		__set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
 	}
 	return changed;
@@ -75,7 +82,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
 {
-	pte_t pte = huge_ptep_get_and_clear(mm, addr, ptep);
+	pte_t pte = __huge_ptep_get_and_clear(mm, addr, ptep);
 	__set_huge_pte_at(mm, addr, ptep, pte_wrprotect(pte));
 }
 
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 160b2acba8db..908bae849843 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -284,10 +284,10 @@ static void __init test_monitor_call(void)
 		return;
 	asm volatile(
 		"	mc	0,0\n"
-		"0:	xgr	%0,%0\n"
+		"0:	lhi	%[val],0\n"
 		"1:\n"
-		EX_TABLE(0b,1b)
-		: "+d" (val));
+		EX_TABLE(0b, 1b)
+		: [val] "+d" (val));
 	if (!val)
 		panic("Monitor call doesn't work!\n");
 }
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index ded0eff58a19..9c1ba8c0cac6 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -174,8 +174,8 @@ pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 	return __rste_to_pte(pte_val(*ptep));
 }
 
-pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-			      unsigned long addr, pte_t *ptep)
+pte_t __huge_ptep_get_and_clear(struct mm_struct *mm,
+				unsigned long addr, pte_t *ptep)
 {
 	pte_t pte = huge_ptep_get(mm, addr, ptep);
 	pmd_t *pmdp = (pmd_t *) ptep;
diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
index c714ca6a05aa..e7a9cdd498dc 100644
--- a/arch/sparc/include/asm/hugetlb.h
+++ b/arch/sparc/include/asm/hugetlb.h
@@ -20,7 +20,7 @@ void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep);
+			      pte_t *ptep, unsigned long sz);
 
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
 static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index cc91ca7a1e18..c276d70a7479 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -368,7 +368,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 }
 
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep)
+			      pte_t *ptep, unsigned long sz)
 {
 	unsigned int i, nptes, orig_shift, shift;
 	unsigned long size;
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index c882e1f67af0..d8c5de40669d 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "misc.h"
 #include <asm/bootparam.h>
+#include <asm/bootparam_utils.h>
 #include <asm/e820/types.h>
 #include <asm/processor.h>
 #include "pgtable.h"
@@ -107,6 +108,7 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 	bool l5_required = false;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
+	sanitize_boot_params(bp);
 	boot_params_ptr = bp;
 
 	/*
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 8499b9cb9c82..e4dd840e0bec 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -761,6 +761,7 @@ struct kvm_vcpu_arch {
 	u32 pkru;
 	u32 hflags;
 	u64 efer;
+	u64 host_debugctl;
 	u64 apic_base;
 	struct kvm_lapic *apic;    /* kernel irqchip context */
 	bool load_eoi_exitmap_pending;
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 37b8244899d8..04712fd0c964 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -405,7 +405,6 @@ bool __init early_is_amd_nb(u32 device)
 
 struct resource *amd_get_mmconfig_range(struct resource *res)
 {
-	u32 address;
 	u64 base, msr;
 	unsigned int segn_busn_bits;
 
@@ -413,13 +412,11 @@ struct resource *amd_get_mmconfig_range(struct resource *res)
 	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return NULL;
 
-	/* assume all cpus from fam10h have mmconfig */
-	if (boot_cpu_data.x86 < 0x10)
+	/* Assume CPUs from Fam10h have mmconfig, although not all VMs do */
+	if (boot_cpu_data.x86 < 0x10 ||
+	    rdmsrl_safe(MSR_FAM10H_MMIO_CONF_BASE, &msr))
 		return NULL;
 
-	address = MSR_FAM10H_MMIO_CONF_BASE;
-	rdmsrl(address, msr);
-
 	/* mmconfig is not enabled */
 	if (!(msr & FAM10H_MMIO_CONF_ENABLE))
 		return NULL;
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index e6fa03ed9172..a6c6bccfa8b8 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -808,7 +808,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 			cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
 
 			/* If bit 31 is set, this is an unknown format */
-			for (j = 0 ; j < 3 ; j++)
+			for (j = 0 ; j < 4 ; j++)
 				if (regs[j] & (1 << 31))
 					regs[j] = 0;
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 4b5f3d052151..b93d88ec1417 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -672,26 +672,37 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 }
 #endif
 
-#define TLB_INST_4K	0x01
-#define TLB_INST_4M	0x02
-#define TLB_INST_2M_4M	0x03
+#define TLB_INST_4K		0x01
+#define TLB_INST_4M		0x02
+#define TLB_INST_2M_4M		0x03
 
-#define TLB_INST_ALL	0x05
-#define TLB_INST_1G	0x06
+#define TLB_INST_ALL		0x05
+#define TLB_INST_1G		0x06
 
-#define TLB_DATA_4K	0x11
-#define TLB_DATA_4M	0x12
-#define TLB_DATA_2M_4M	0x13
-#define TLB_DATA_4K_4M	0x14
+#define TLB_DATA_4K		0x11
+#define TLB_DATA_4M		0x12
+#define TLB_DATA_2M_4M		0x13
+#define TLB_DATA_4K_4M		0x14
 
-#define TLB_DATA_1G	0x16
+#define TLB_DATA_1G		0x16
+#define TLB_DATA_1G_2M_4M	0x17
 
-#define TLB_DATA0_4K	0x21
-#define TLB_DATA0_4M	0x22
-#define TLB_DATA0_2M_4M	0x23
+#define TLB_DATA0_4K		0x21
+#define TLB_DATA0_4M		0x22
+#define TLB_DATA0_2M_4M		0x23
 
-#define STLB_4K		0x41
-#define STLB_4K_2M	0x42
+#define STLB_4K			0x41
+#define STLB_4K_2M		0x42
+
+/*
+ * All of leaf 0x2's one-byte TLB descriptors implies the same number of
+ * entries for their respective TLB types.  The 0x63 descriptor is an
+ * exception: it implies 4 dTLB entries for 1GB pages 32 dTLB entries
+ * for 2MB or 4MB pages.  Encode descriptor 0x63 dTLB entry count for
+ * 2MB/4MB pages here, as its count for dTLB 1GB pages is already at the
+ * intel_tlb_table[] mapping.
+ */
+#define TLB_0x63_2M_4M_ENTRIES	32
 
 static const struct _tlb_table intel_tlb_table[] = {
 	{ 0x01, TLB_INST_4K,		32,	" TLB_INST 4 KByte pages, 4-way set associative" },
@@ -713,7 +724,8 @@ static const struct _tlb_table intel_tlb_table[] = {
 	{ 0x5c, TLB_DATA_4K_4M,		128,	" TLB_DATA 4 KByte and 4 MByte pages" },
 	{ 0x5d, TLB_DATA_4K_4M,		256,	" TLB_DATA 4 KByte and 4 MByte pages" },
 	{ 0x61, TLB_INST_4K,		48,	" TLB_INST 4 KByte pages, full associative" },
-	{ 0x63, TLB_DATA_1G,		4,	" TLB_DATA 1 GByte pages, 4-way set associative" },
+	{ 0x63, TLB_DATA_1G_2M_4M,	4,	" TLB_DATA 1 GByte pages, 4-way set associative"
+						" (plus 32 entries TLB_DATA 2 MByte or 4 MByte pages, not encoded here)" },
 	{ 0x6b, TLB_DATA_4K,		256,	" TLB_DATA 4 KByte pages, 8-way associative" },
 	{ 0x6c, TLB_DATA_2M_4M,		128,	" TLB_DATA 2 MByte or 4 MByte pages, 8-way associative" },
 	{ 0x6d, TLB_DATA_1G,		16,	" TLB_DATA 1 GByte pages, fully associative" },
@@ -813,6 +825,12 @@ static void intel_tlb_lookup(const unsigned char desc)
 		if (tlb_lld_4m[ENTRIES] < intel_tlb_table[k].entries)
 			tlb_lld_4m[ENTRIES] = intel_tlb_table[k].entries;
 		break;
+	case TLB_DATA_1G_2M_4M:
+		if (tlb_lld_2m[ENTRIES] < TLB_0x63_2M_4M_ENTRIES)
+			tlb_lld_2m[ENTRIES] = TLB_0x63_2M_4M_ENTRIES;
+		if (tlb_lld_4m[ENTRIES] < TLB_0x63_2M_4M_ENTRIES)
+			tlb_lld_4m[ENTRIES] = TLB_0x63_2M_4M_ENTRIES;
+		fallthrough;
 	case TLB_DATA_1G:
 		if (tlb_lld_1g[ENTRIES] < intel_tlb_table[k].entries)
 			tlb_lld_1g[ENTRIES] = intel_tlb_table[k].entries;
@@ -836,7 +854,7 @@ static void intel_detect_tlb(struct cpuinfo_x86 *c)
 		cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
 
 		/* If bit 31 is set, this is an unknown format */
-		for (j = 0 ; j < 3 ; j++)
+		for (j = 0 ; j < 4 ; j++)
 			if (regs[j] & (1 << 31))
 				regs[j] = 0;
 
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index f5365b32582a..def6a2854a4b 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -175,23 +175,29 @@ static bool need_sha_check(u32 cur_rev)
 {
 	switch (cur_rev >> 8) {
 	case 0x80012: return cur_rev <= 0x800126f; break;
+	case 0x80082: return cur_rev <= 0x800820f; break;
 	case 0x83010: return cur_rev <= 0x830107c; break;
 	case 0x86001: return cur_rev <= 0x860010e; break;
 	case 0x86081: return cur_rev <= 0x8608108; break;
 	case 0x87010: return cur_rev <= 0x8701034; break;
 	case 0x8a000: return cur_rev <= 0x8a0000a; break;
+	case 0xa0010: return cur_rev <= 0xa00107a; break;
 	case 0xa0011: return cur_rev <= 0xa0011da; break;
 	case 0xa0012: return cur_rev <= 0xa001243; break;
+	case 0xa0082: return cur_rev <= 0xa00820e; break;
 	case 0xa1011: return cur_rev <= 0xa101153; break;
 	case 0xa1012: return cur_rev <= 0xa10124e; break;
 	case 0xa1081: return cur_rev <= 0xa108109; break;
 	case 0xa2010: return cur_rev <= 0xa20102f; break;
 	case 0xa2012: return cur_rev <= 0xa201212; break;
+	case 0xa4041: return cur_rev <= 0xa404109; break;
+	case 0xa5000: return cur_rev <= 0xa500013; break;
 	case 0xa6012: return cur_rev <= 0xa60120a; break;
 	case 0xa7041: return cur_rev <= 0xa704109; break;
 	case 0xa7052: return cur_rev <= 0xa705208; break;
 	case 0xa7080: return cur_rev <= 0xa708009; break;
 	case 0xa70c0: return cur_rev <= 0xa70C009; break;
+	case 0xaa001: return cur_rev <= 0xaa00116; break;
 	case 0xaa002: return cur_rev <= 0xaa00218; break;
 	default: break;
 	}
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index b65ab214bdf5..776a20172867 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -64,6 +64,13 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	struct file *backing;
 	long ret;
 
+	/*
+	 * ECREATE would detect this too, but checking here also ensures
+	 * that the 'encl_size' calculations below can never overflow.
+	 */
+	if (!is_power_of_2(secs->size))
+		return -EINVAL;
+
 	va_page = sgx_encl_grow(encl, true);
 	if (IS_ERR(va_page))
 		return PTR_ERR(va_page);
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 83bfecd1a6e4..9157b4485ded 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1387,7 +1387,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 
 		entry->ecx = entry->edx = 0;
 		if (!enable_pmu || !kvm_cpu_cap_has(X86_FEATURE_PERFMON_V2)) {
-			entry->eax = entry->ebx;
+			entry->eax = entry->ebx = 0;
 			break;
 		}
 
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index e9af87b12814..3ec56bf76ef1 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4579,6 +4579,8 @@ void sev_es_vcpu_reset(struct vcpu_svm *svm)
 
 void sev_es_prepare_switch_to_guest(struct vcpu_svm *svm, struct sev_es_save_area *hostsa)
 {
+	struct kvm *kvm = svm->vcpu.kvm;
+
 	/*
 	 * All host state for SEV-ES guests is categorized into three swap types
 	 * based on how it is handled by hardware during a world switch:
@@ -4602,10 +4604,15 @@ void sev_es_prepare_switch_to_guest(struct vcpu_svm *svm, struct sev_es_save_are
 
 	/*
 	 * If DebugSwap is enabled, debug registers are loaded but NOT saved by
-	 * the CPU (Type-B). If DebugSwap is disabled/unsupported, the CPU both
-	 * saves and loads debug registers (Type-A).
+	 * the CPU (Type-B). If DebugSwap is disabled/unsupported, the CPU does
+	 * not save or load debug registers.  Sadly, on CPUs without
+	 * ALLOWED_SEV_FEATURES, KVM can't prevent SNP guests from enabling
+	 * DebugSwap on secondary vCPUs without KVM's knowledge via "AP Create".
+	 * Save all registers if DebugSwap is supported to prevent host state
+	 * from being clobbered by a misbehaving guest.
 	 */
-	if (sev_vcpu_has_debug_swap(svm)) {
+	if (sev_vcpu_has_debug_swap(svm) ||
+	    (sev_snp_guest(kvm) && cpu_feature_enabled(X86_FEATURE_DEBUG_SWAP))) {
 		hostsa->dr0 = native_get_debugreg(0);
 		hostsa->dr1 = native_get_debugreg(1);
 		hostsa->dr2 = native_get_debugreg(2);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a7cb7c82b38e..e39ab7c0be4e 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3167,6 +3167,27 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 			kvm_pr_unimpl_wrmsr(vcpu, ecx, data);
 			break;
 		}
+
+		/*
+		 * AMD changed the architectural behavior of bits 5:2.  On CPUs
+		 * without BusLockTrap, bits 5:2 control "external pins", but
+		 * on CPUs that support BusLockDetect, bit 2 enables BusLockTrap
+		 * and bits 5:3 are reserved-to-zero.  Sadly, old KVM allowed
+		 * the guest to set bits 5:2 despite not actually virtualizing
+		 * Performance-Monitoring/Breakpoint external pins.  Drop bits
+		 * 5:2 for backwards compatibility.
+		 */
+		data &= ~GENMASK(5, 2);
+
+		/*
+		 * Suppress BTF as KVM doesn't virtualize BTF, but there's no
+		 * way to communicate lack of support to the guest.
+		 */
+		if (data & DEBUGCTLMSR_BTF) {
+			kvm_pr_unimpl_wrmsr(vcpu, MSR_IA32_DEBUGCTLMSR, data);
+			data &= ~DEBUGCTLMSR_BTF;
+		}
+
 		if (data & DEBUGCTL_RESERVED_BITS)
 			return 1;
 
@@ -4176,6 +4197,18 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_in
 
 	guest_state_enter_irqoff();
 
+	/*
+	 * Set RFLAGS.IF prior to VMRUN, as the host's RFLAGS.IF at the time of
+	 * VMRUN controls whether or not physical IRQs are masked (KVM always
+	 * runs with V_INTR_MASKING_MASK).  Toggle RFLAGS.IF here to avoid the
+	 * temptation to do STI+VMRUN+CLI, as AMD CPUs bleed the STI shadow
+	 * into guest state if delivery of an event during VMRUN triggers a
+	 * #VMEXIT, and the guest_state transitions already tell lockdep that
+	 * IRQs are being enabled/disabled.  Note!  GIF=0 for the entirety of
+	 * this path, so IRQs aren't actually unmasked while running host code.
+	 */
+	raw_local_irq_enable();
+
 	amd_clear_divider();
 
 	if (sev_es_guest(vcpu->kvm))
@@ -4184,6 +4217,8 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_in
 	else
 		__svm_vcpu_run(svm, spec_ctrl_intercepted);
 
+	raw_local_irq_disable();
+
 	guest_state_exit_irqoff();
 }
 
@@ -4240,6 +4275,16 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu,
 	clgi();
 	kvm_load_guest_xsave_state(vcpu);
 
+	/*
+	 * Hardware only context switches DEBUGCTL if LBR virtualization is
+	 * enabled.  Manually load DEBUGCTL if necessary (and restore it after
+	 * VM-Exit), as running with the host's DEBUGCTL can negatively affect
+	 * guest state and can even be fatal, e.g. due to Bus Lock Detect.
+	 */
+	if (!(svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK) &&
+	    vcpu->arch.host_debugctl != svm->vmcb->save.dbgctl)
+		update_debugctlmsr(svm->vmcb->save.dbgctl);
+
 	kvm_wait_lapic_expire(vcpu);
 
 	/*
@@ -4267,6 +4312,10 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu,
 	if (unlikely(svm->vmcb->control.exit_code == SVM_EXIT_NMI))
 		kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
 
+	if (!(svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK) &&
+	    vcpu->arch.host_debugctl != svm->vmcb->save.dbgctl)
+		update_debugctlmsr(vcpu->arch.host_debugctl);
+
 	kvm_load_host_xsave_state(vcpu);
 	stgi();
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 43fa6a16eb19..d114efac7af7 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -591,7 +591,7 @@ static inline bool is_vnmi_enabled(struct vcpu_svm *svm)
 /* svm.c */
 #define MSR_INVALID				0xffffffffU
 
-#define DEBUGCTL_RESERVED_BITS (~(0x3fULL))
+#define DEBUGCTL_RESERVED_BITS (~DEBUGCTLMSR_LBR)
 
 extern bool dump_invalid_vmcb;
 
diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index 2ed80aea3bb1..0c61153b275f 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -170,12 +170,8 @@ SYM_FUNC_START(__svm_vcpu_run)
 	mov VCPU_RDI(%_ASM_DI), %_ASM_DI
 
 	/* Enter guest mode */
-	sti
-
 3:	vmrun %_ASM_AX
 4:
-	cli
-
 	/* Pop @svm to RAX while it's the only available register. */
 	pop %_ASM_AX
 
@@ -340,12 +336,8 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 	mov KVM_VMCB_pa(%rax), %rax
 
 	/* Enter guest mode */
-	sti
-
 1:	vmrun %rax
-
-2:	cli
-
+2:
 	/* IMPORTANT: Stuff the RSB immediately after VM-Exit, before RET! */
 	FILL_RETURN_BUFFER %rax, RSB_CLEAR_LOOPS, X86_FEATURE_RSB_VMEXIT
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 1af30e3472cd..a3d45b01dbad 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1515,16 +1515,12 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu,
  */
 void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-
 	if (vcpu->scheduled_out && !kvm_pause_in_guest(vcpu->kvm))
 		shrink_ple_window(vcpu);
 
 	vmx_vcpu_load_vmcs(vcpu, cpu, NULL);
 
 	vmx_vcpu_pi_load(vcpu, cpu);
-
-	vmx->host_debugctlmsr = get_debugctlmsr();
 }
 
 void vmx_vcpu_put(struct kvm_vcpu *vcpu)
@@ -7454,8 +7450,8 @@ fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit)
 	}
 
 	/* MSR_IA32_DEBUGCTLMSR is zeroed on vmexit. Restore it if needed */
-	if (vmx->host_debugctlmsr)
-		update_debugctlmsr(vmx->host_debugctlmsr);
+	if (vcpu->arch.host_debugctl)
+		update_debugctlmsr(vcpu->arch.host_debugctl);
 
 #ifndef CONFIG_X86_64
 	/*
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 41bf59bbc642..cf57fbf12104 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -339,8 +339,6 @@ struct vcpu_vmx {
 	/* apic deadline value in host tsc */
 	u64 hv_deadline_tsc;
 
-	unsigned long host_debugctlmsr;
-
 	/*
 	 * Only bits masked by msr_ia32_feature_control_valid_bits can be set in
 	 * msr_ia32_feature_control. FEAT_CTL_LOCKED is always included
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b67a2f46e40b..8794c0a8a2e4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10964,6 +10964,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		set_debugreg(0, 7);
 	}
 
+	vcpu->arch.host_debugctl = get_debugctlmsr();
+
 	guest_timing_enter_irqoff();
 
 	for (;;) {
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index eb503f53c319..101725c149c4 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -263,28 +263,33 @@ static void __init probe_page_size_mask(void)
 }
 
 /*
- * INVLPG may not properly flush Global entries
- * on these CPUs when PCIDs are enabled.
+ * INVLPG may not properly flush Global entries on
+ * these CPUs.  New microcode fixes the issue.
  */
 static const struct x86_cpu_id invlpg_miss_ids[] = {
-	X86_MATCH_VFM(INTEL_ALDERLAKE,	    0),
-	X86_MATCH_VFM(INTEL_ALDERLAKE_L,    0),
-	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, 0),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE,	    0),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,   0),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,   0),
+	X86_MATCH_VFM(INTEL_ALDERLAKE,	    0x2e),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L,    0x42c),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, 0x11),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE,	    0x118),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,   0x4117),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,   0x2e),
 	{}
 };
 
 static void setup_pcid(void)
 {
+	const struct x86_cpu_id *invlpg_miss_match;
+
 	if (!IS_ENABLED(CONFIG_X86_64))
 		return;
 
 	if (!boot_cpu_has(X86_FEATURE_PCID))
 		return;
 
-	if (x86_match_cpu(invlpg_miss_ids)) {
+	invlpg_miss_match = x86_match_cpu(invlpg_miss_ids);
+
+	if (invlpg_miss_match &&
+	    boot_cpu_data.microcode < invlpg_miss_match->driver_data) {
 		pr_info("Incomplete global flushes, disabling PCID");
 		setup_clear_cpu_cap(X86_FEATURE_PCID);
 		return;
diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 5e9be13a56a8..7acba66eed48 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -682,7 +682,7 @@ static void utf16_le_to_7bit(const __le16 *in, unsigned int size, u8 *out)
 	out[size] = 0;
 
 	while (i < size) {
-		u8 c = le16_to_cpu(in[i]) & 0xff;
+		u8 c = le16_to_cpu(in[i]) & 0x7f;
 
 		if (c && !isprint(c))
 			c = '!';
diff --git a/drivers/base/core.c b/drivers/base/core.c
index d922cefc1e66..ec0ef6a0de94 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2079,6 +2079,7 @@ static bool __fw_devlink_relax_cycles(struct fwnode_handle *con_handle,
 out:
 	sup_handle->flags &= ~FWNODE_FLAG_VISITED;
 	put_device(sup_dev);
+	put_device(con_dev);
 	put_device(par_dev);
 	return ret;
 }
diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
index b0227cf9ddd3..5de7223beb4d 100644
--- a/drivers/block/rnull.rs
+++ b/drivers/block/rnull.rs
@@ -32,7 +32,7 @@
 }
 
 struct NullBlkModule {
-    _disk: Pin<Box<Mutex<GenDisk<NullBlkDevice>>>>,
+    _disk: Pin<KBox<Mutex<GenDisk<NullBlkDevice>>>>,
 }
 
 impl kernel::Module for NullBlkModule {
@@ -47,7 +47,7 @@ fn init(_module: &'static ThisModule) -> Result<Self> {
             .rotational(false)
             .build(format_args!("rnullb{}", 0), tagset)?;
 
-        let disk = Box::pin_init(new_mutex!(disk, "nullb:disk"), flags::GFP_KERNEL)?;
+        let disk = KBox::pin_init(new_mutex!(disk, "nullb:disk"), flags::GFP_KERNEL)?;
 
         Ok(Self { _disk: disk })
     }
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 458ac54e7b20..c7d728d686e5 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2665,9 +2665,12 @@ static int ublk_ctrl_set_params(struct ublk_device *ub,
 	if (ph.len > sizeof(struct ublk_params))
 		ph.len = sizeof(struct ublk_params);
 
-	/* parameters can only be changed when device isn't live */
 	mutex_lock(&ub->mutex);
-	if (ub->dev_info.state == UBLK_S_DEV_LIVE) {
+	if (test_bit(UB_STATE_USED, &ub->state)) {
+		/*
+		 * Parameters can only be changed when device hasn't
+		 * been started yet
+		 */
 		ret = -EACCES;
 	} else if (copy_from_user(&ub->params, argp, ph.len)) {
 		ret = -EFAULT;
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 6bc6dd417adf..3a0b9dc98707 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3644,6 +3644,7 @@ static ssize_t force_poll_sync_write(struct file *file,
 }
 
 static const struct file_operations force_poll_sync_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= force_poll_sync_read,
 	.write		= force_poll_sync_write,
diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 9938bb034c1c..acfd673834ed 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -1040,8 +1040,9 @@ static void mhi_pci_recovery_work(struct work_struct *work)
 err_unprepare:
 	mhi_unprepare_after_power_down(mhi_cntrl);
 err_try_reset:
-	if (pci_reset_function(pdev))
-		dev_err(&pdev->dev, "Recovery failed\n");
+	err = pci_try_reset_function(pdev);
+	if (err)
+		dev_err(&pdev->dev, "Recovery failed: %d\n", err);
 }
 
 static void health_check(struct timer_list *t)
diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 07371cb653d3..4af1901c9d52 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -470,8 +470,12 @@ static ssize_t driver_override_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct cdx_device *cdx_dev = to_cdx_device(dev);
+	ssize_t len;
 
-	return sysfs_emit(buf, "%s\n", cdx_dev->driver_override);
+	device_lock(dev);
+	len = sysfs_emit(buf, "%s\n", cdx_dev->driver_override);
+	device_unlock(dev);
+	return len;
 }
 static DEVICE_ATTR_RW(driver_override);
 
diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 2cf595d2e10b..f7dd455dd0dd 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -264,8 +264,8 @@ int misc_register(struct miscdevice *misc)
 		device_create_with_groups(&misc_class, misc->parent, dev,
 					  misc, misc->groups, "%s", misc->name);
 	if (IS_ERR(misc->this_device)) {
+		misc_minor_free(misc->minor);
 		if (is_dynamic) {
-			misc_minor_free(misc->minor);
 			misc->minor = MISC_DYNAMIC_MINOR;
 		}
 		err = PTR_ERR(misc->this_device);
diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 38e0fff9afe7..cc6ee4334602 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -121,10 +121,15 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 	struct platform_device *pdev;
 	int res, id;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENOENT;
+
 	/* kernfs guarantees string termination, so count + 1 is safe */
 	aggr = kzalloc(sizeof(*aggr) + count + 1, GFP_KERNEL);
-	if (!aggr)
-		return -ENOMEM;
+	if (!aggr) {
+		res = -ENOMEM;
+		goto put_module;
+	}
 
 	memcpy(aggr->args, buf, count + 1);
 
@@ -163,6 +168,7 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 	}
 
 	aggr->pdev = pdev;
+	module_put(THIS_MODULE);
 	return count;
 
 remove_table:
@@ -177,6 +183,8 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 	kfree(aggr->lookups);
 free_ga:
 	kfree(aggr);
+put_module:
+	module_put(THIS_MODULE);
 	return res;
 }
 
@@ -205,13 +213,19 @@ static ssize_t delete_device_store(struct device_driver *driver,
 	if (error)
 		return error;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENOENT;
+
 	mutex_lock(&gpio_aggregator_lock);
 	aggr = idr_remove(&gpio_aggregator_idr, id);
 	mutex_unlock(&gpio_aggregator_lock);
-	if (!aggr)
+	if (!aggr) {
+		module_put(THIS_MODULE);
 		return -ENOENT;
+	}
 
 	gpio_aggregator_free(aggr);
+	module_put(THIS_MODULE);
 	return count;
 }
 static DRIVER_ATTR_WO(delete_device);
diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 6159fda38d5d..6641ed5cd8e1 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -40,7 +40,7 @@ struct gpio_rcar_info {
 
 struct gpio_rcar_priv {
 	void __iomem *base;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct device *dev;
 	struct gpio_chip gpio_chip;
 	unsigned int irq_parent;
@@ -123,7 +123,7 @@ static void gpio_rcar_config_interrupt_input_mode(struct gpio_rcar_priv *p,
 	 * "Setting Level-Sensitive Interrupt Input Mode"
 	 */
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 
 	/* Configure positive or negative logic in POSNEG */
 	gpio_rcar_modify_bit(p, POSNEG, hwirq, !active_high_rising_edge);
@@ -142,7 +142,7 @@ static void gpio_rcar_config_interrupt_input_mode(struct gpio_rcar_priv *p,
 	if (!level_trigger)
 		gpio_rcar_write(p, INTCLR, BIT(hwirq));
 
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static int gpio_rcar_irq_set_type(struct irq_data *d, unsigned int type)
@@ -246,7 +246,7 @@ static void gpio_rcar_config_general_input_output_mode(struct gpio_chip *chip,
 	 * "Setting General Input Mode"
 	 */
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 
 	/* Configure positive logic in POSNEG */
 	gpio_rcar_modify_bit(p, POSNEG, gpio, false);
@@ -261,7 +261,7 @@ static void gpio_rcar_config_general_input_output_mode(struct gpio_chip *chip,
 	if (p->info.has_outdtsel && output)
 		gpio_rcar_modify_bit(p, OUTDTSEL, gpio, false);
 
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static int gpio_rcar_request(struct gpio_chip *chip, unsigned offset)
@@ -347,7 +347,7 @@ static int gpio_rcar_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 		return 0;
 	}
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 	outputs = gpio_rcar_read(p, INOUTSEL);
 	m = outputs & bankmask;
 	if (m)
@@ -356,7 +356,7 @@ static int gpio_rcar_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	m = ~outputs & bankmask;
 	if (m)
 		val |= gpio_rcar_read(p, INDT) & m;
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 
 	bits[0] = val;
 	return 0;
@@ -367,9 +367,9 @@ static void gpio_rcar_set(struct gpio_chip *chip, unsigned offset, int value)
 	struct gpio_rcar_priv *p = gpiochip_get_data(chip);
 	unsigned long flags;
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 	gpio_rcar_modify_bit(p, OUTDT, offset, value);
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static void gpio_rcar_set_multiple(struct gpio_chip *chip, unsigned long *mask,
@@ -386,12 +386,12 @@ static void gpio_rcar_set_multiple(struct gpio_chip *chip, unsigned long *mask,
 	if (!bankmask)
 		return;
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 	val = gpio_rcar_read(p, OUTDT);
 	val &= ~bankmask;
 	val |= (bankmask & bits[0]);
 	gpio_rcar_write(p, OUTDT, val);
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static int gpio_rcar_direction_output(struct gpio_chip *chip, unsigned offset,
@@ -468,7 +468,12 @@ static int gpio_rcar_parse_dt(struct gpio_rcar_priv *p, unsigned int *npins)
 	p->info = *info;
 
 	ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &args);
-	*npins = ret == 0 ? args.args[2] : RCAR_MAX_GPIO_PER_BANK;
+	if (ret) {
+		*npins = RCAR_MAX_GPIO_PER_BANK;
+	} else {
+		*npins = args.args[2];
+		of_node_put(args.np);
+	}
 
 	if (*npins == 0 || *npins > RCAR_MAX_GPIO_PER_BANK) {
 		dev_warn(p->dev, "Invalid number of gpio lines %u, using %u\n",
@@ -505,7 +510,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	p->dev = dev;
-	spin_lock_init(&p->lock);
+	raw_spin_lock_init(&p->lock);
 
 	/* Get device configuration from DT node */
 	ret = gpio_rcar_parse_dt(p, &npins);
diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 27eff741fe9a..c36a9dbccd4d 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -15,10 +15,9 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
-#include <linux/platform_device.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 
 #define VF610_GPIO_PER_PORT		32
 
@@ -37,6 +36,7 @@ struct vf610_gpio_port {
 	struct clk *clk_port;
 	struct clk *clk_gpio;
 	int irq;
+	spinlock_t lock; /* protect gpio direction registers */
 };
 
 #define GPIO_PDOR		0x00
@@ -125,6 +125,7 @@ static int vf610_gpio_direction_input(struct gpio_chip *chip, unsigned int gpio)
 	u32 val;
 
 	if (port->sdata->have_paddr) {
+		guard(spinlock_irqsave)(&port->lock);
 		val = vf610_gpio_readl(port->gpio_base + GPIO_PDDR);
 		val &= ~mask;
 		vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);
@@ -143,6 +144,7 @@ static int vf610_gpio_direction_output(struct gpio_chip *chip, unsigned int gpio
 	vf610_gpio_set(chip, gpio, value);
 
 	if (port->sdata->have_paddr) {
+		guard(spinlock_irqsave)(&port->lock);
 		val = vf610_gpio_readl(port->gpio_base + GPIO_PDDR);
 		val |= mask;
 		vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);
@@ -297,7 +299,8 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	if (!port)
 		return -ENOMEM;
 
-	port->sdata = of_device_get_match_data(dev);
+	port->sdata = device_get_match_data(dev);
+	spin_lock_init(&port->lock);
 
 	dual_base = port->sdata->have_dual_base;
 
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 7408ea8caacc..ae53f26da945 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -211,6 +211,18 @@ config DRM_DEBUG_MODESET_LOCK
 
 	  If in doubt, say "N".
 
+config DRM_CLIENT_SELECTION
+	bool
+	depends on DRM
+	select DRM_CLIENT_SETUP if DRM_FBDEV_EMULATION
+	help
+	  Drivers that support in-kernel DRM clients have to select this
+	  option.
+
+config DRM_CLIENT_SETUP
+	bool
+	depends on DRM_CLIENT_SELECTION
+
 config DRM_FBDEV_EMULATION
 	bool "Enable legacy fbdev support for your modesetting driver"
 	depends on DRM
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 84746054c721..1ec44529447a 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -144,8 +144,12 @@ drm_kms_helper-y := \
 	drm_rect.o \
 	drm_self_refresh_helper.o \
 	drm_simple_kms_helper.o
+drm_kms_helper-$(CONFIG_DRM_CLIENT_SETUP) += \
+	drm_client_setup.o
 drm_kms_helper-$(CONFIG_DRM_PANEL_BRIDGE) += bridge/panel.o
-drm_kms_helper-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fb_helper.o
+drm_kms_helper-$(CONFIG_DRM_FBDEV_EMULATION) += \
+	drm_fbdev_client.o \
+	drm_fb_helper.o
 obj-$(CONFIG_DRM_KMS_HELPER) += drm_kms_helper.o
 
 #
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index ad29634f8b44..80c85b6cc478 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -266,8 +266,8 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 	/* EOP buffer is not required for all ASICs */
 	if (properties->eop_ring_buffer_address) {
 		if (properties->eop_ring_buffer_size != topo_dev->node_props.eop_buffer_size) {
-			pr_debug("queue eop bo size 0x%lx not equal to node eop buf size 0x%x\n",
-				properties->eop_buf_bo->tbo.base.size,
+			pr_debug("queue eop bo size 0x%x not equal to node eop buf size 0x%x\n",
+				properties->eop_ring_buffer_size,
 				topo_dev->node_props.eop_buffer_size);
 			err = -EINVAL;
 			goto out_err_unreserve;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index d915020a4295..f0eda0ba0156 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1455,7 +1455,8 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
 
 	/* Invalid input */
-	if (!plane_state->dst_rect.width ||
+	if (!plane_state ||
+			!plane_state->dst_rect.width ||
 			!plane_state->dst_rect.height ||
 			!plane_state->src_rect.width ||
 			!plane_state->src_rect.height) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 452589adaf04..e5f619c979d8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1883,16 +1883,6 @@ static int smu_v14_0_allow_ih_interrupt(struct smu_context *smu)
 				    NULL);
 }
 
-static int smu_v14_0_process_pending_interrupt(struct smu_context *smu)
-{
-	int ret = 0;
-
-	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_ACDC_BIT))
-		ret = smu_v14_0_allow_ih_interrupt(smu);
-
-	return ret;
-}
-
 int smu_v14_0_enable_thermal_alert(struct smu_context *smu)
 {
 	int ret = 0;
@@ -1904,7 +1894,7 @@ int smu_v14_0_enable_thermal_alert(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	return smu_v14_0_process_pending_interrupt(smu);
+	return smu_v14_0_allow_ih_interrupt(smu);
 }
 
 int smu_v14_0_disable_thermal_alert(struct smu_context *smu)
diff --git a/drivers/gpu/drm/drm_client_setup.c b/drivers/gpu/drm/drm_client_setup.c
new file mode 100644
index 000000000000..5969c4ffe31b
--- /dev/null
+++ b/drivers/gpu/drm/drm_client_setup.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: MIT
+
+#include <drm/drm_client_setup.h>
+#include <drm/drm_device.h>
+#include <drm/drm_fbdev_client.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_print.h>
+
+/**
+ * drm_client_setup() - Setup in-kernel DRM clients
+ * @dev: DRM device
+ * @format: Preferred pixel format for the device. Use NULL, unless
+ *          there is clearly a driver-preferred format.
+ *
+ * This function sets up the in-kernel DRM clients. Restore, hotplug
+ * events and teardown are all taken care of.
+ *
+ * Drivers should call drm_client_setup() after registering the new
+ * DRM device with drm_dev_register(). This function is safe to call
+ * even when there are no connectors present. Setup will be retried
+ * on the next hotplug event.
+ *
+ * The clients are destroyed by drm_dev_unregister().
+ */
+void drm_client_setup(struct drm_device *dev, const struct drm_format_info *format)
+{
+	int ret;
+
+	ret = drm_fbdev_client_setup(dev, format);
+	if (ret)
+		drm_warn(dev, "Failed to set up DRM client; error %d\n", ret);
+}
+EXPORT_SYMBOL(drm_client_setup);
+
+/**
+ * drm_client_setup_with_fourcc() - Setup in-kernel DRM clients for color mode
+ * @dev: DRM device
+ * @fourcc: Preferred pixel format as 4CC code for the device
+ *
+ * This function sets up the in-kernel DRM clients. It is equivalent
+ * to drm_client_setup(), but expects a 4CC code as second argument.
+ */
+void drm_client_setup_with_fourcc(struct drm_device *dev, u32 fourcc)
+{
+	drm_client_setup(dev, drm_format_info(fourcc));
+}
+EXPORT_SYMBOL(drm_client_setup_with_fourcc);
+
+/**
+ * drm_client_setup_with_color_mode() - Setup in-kernel DRM clients for color mode
+ * @dev: DRM device
+ * @color_mode: Preferred color mode for the device
+ *
+ * This function sets up the in-kernel DRM clients. It is equivalent
+ * to drm_client_setup(), but expects a color mode as second argument.
+ *
+ * Do not use this function in new drivers. Prefer drm_client_setup() with a
+ * format of NULL.
+ */
+void drm_client_setup_with_color_mode(struct drm_device *dev, unsigned int color_mode)
+{
+	u32 fourcc = drm_driver_color_mode_format(dev, color_mode);
+
+	drm_client_setup_with_fourcc(dev, fourcc);
+}
+EXPORT_SYMBOL(drm_client_setup_with_color_mode);
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index eaac2e5726e7..b15ddbd65e7b 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -492,8 +492,8 @@ EXPORT_SYMBOL(drm_fb_helper_init);
  * @fb_helper: driver-allocated fbdev helper
  *
  * A helper to alloc fb_info and the member cmap. Called by the driver
- * within the fb_probe fb_helper callback function. Drivers do not
- * need to release the allocated fb_info structure themselves, this is
+ * within the struct &drm_driver.fbdev_probe callback function. Drivers do
+ * not need to release the allocated fb_info structure themselves, this is
  * automatically done when calling drm_fb_helper_fini().
  *
  * RETURNS:
@@ -1443,67 +1443,27 @@ int drm_fb_helper_pan_display(struct fb_var_screeninfo *var,
 EXPORT_SYMBOL(drm_fb_helper_pan_display);
 
 static uint32_t drm_fb_helper_find_format(struct drm_fb_helper *fb_helper, const uint32_t *formats,
-					  size_t format_count, uint32_t bpp, uint32_t depth)
+					  size_t format_count, unsigned int color_mode)
 {
 	struct drm_device *dev = fb_helper->dev;
 	uint32_t format;
 	size_t i;
 
-	/*
-	 * Do not consider YUV or other complicated formats
-	 * for framebuffers. This means only legacy formats
-	 * are supported (fmt->depth is a legacy field), but
-	 * the framebuffer emulation can only deal with such
-	 * formats, specifically RGB/BGA formats.
-	 */
-	format = drm_mode_legacy_fb_format(bpp, depth);
-	if (!format)
-		goto err;
+	format = drm_driver_color_mode_format(dev, color_mode);
+	if (!format) {
+		drm_info(dev, "unsupported color mode of %d\n", color_mode);
+		return DRM_FORMAT_INVALID;
+	}
 
 	for (i = 0; i < format_count; ++i) {
 		if (formats[i] == format)
 			return format;
 	}
-
-err:
-	/* We found nothing. */
-	drm_warn(dev, "bpp/depth value of %u/%u not supported\n", bpp, depth);
+	drm_warn(dev, "format %p4cc not supported\n", &format);
 
 	return DRM_FORMAT_INVALID;
 }
 
-static uint32_t drm_fb_helper_find_color_mode_format(struct drm_fb_helper *fb_helper,
-						     const uint32_t *formats, size_t format_count,
-						     unsigned int color_mode)
-{
-	struct drm_device *dev = fb_helper->dev;
-	uint32_t bpp, depth;
-
-	switch (color_mode) {
-	case 1:
-	case 2:
-	case 4:
-	case 8:
-	case 16:
-	case 24:
-		bpp = depth = color_mode;
-		break;
-	case 15:
-		bpp = 16;
-		depth = 15;
-		break;
-	case 32:
-		bpp = 32;
-		depth = 24;
-		break;
-	default:
-		drm_info(dev, "unsupported color mode of %d\n", color_mode);
-		return DRM_FORMAT_INVALID;
-	}
-
-	return drm_fb_helper_find_format(fb_helper, formats, format_count, bpp, depth);
-}
-
 static int __drm_fb_helper_find_sizes(struct drm_fb_helper *fb_helper,
 				      struct drm_fb_helper_surface_size *sizes)
 {
@@ -1533,10 +1493,10 @@ static int __drm_fb_helper_find_sizes(struct drm_fb_helper *fb_helper,
 			if (!cmdline_mode->bpp_specified)
 				continue;
 
-			surface_format = drm_fb_helper_find_color_mode_format(fb_helper,
-									      plane->format_types,
-									      plane->format_count,
-									      cmdline_mode->bpp);
+			surface_format = drm_fb_helper_find_format(fb_helper,
+								   plane->format_types,
+								   plane->format_count,
+								   cmdline_mode->bpp);
 			if (surface_format != DRM_FORMAT_INVALID)
 				break; /* found supported format */
 		}
@@ -1546,10 +1506,10 @@ static int __drm_fb_helper_find_sizes(struct drm_fb_helper *fb_helper,
 			break; /* found supported format */
 
 		/* try preferred color mode */
-		surface_format = drm_fb_helper_find_color_mode_format(fb_helper,
-								      plane->format_types,
-								      plane->format_count,
-								      fb_helper->preferred_bpp);
+		surface_format = drm_fb_helper_find_format(fb_helper,
+							   plane->format_types,
+							   plane->format_count,
+							   fb_helper->preferred_bpp);
 		if (surface_format != DRM_FORMAT_INVALID)
 			break; /* found supported format */
 	}
@@ -1650,7 +1610,7 @@ static int drm_fb_helper_find_sizes(struct drm_fb_helper *fb_helper,
 
 /*
  * Allocates the backing storage and sets up the fbdev info structure through
- * the ->fb_probe callback.
+ * the ->fbdev_probe callback.
  */
 static int drm_fb_helper_single_fb_probe(struct drm_fb_helper *fb_helper)
 {
@@ -1668,7 +1628,10 @@ static int drm_fb_helper_single_fb_probe(struct drm_fb_helper *fb_helper)
 	}
 
 	/* push down into drivers */
-	ret = (*fb_helper->funcs->fb_probe)(fb_helper, &sizes);
+	if (dev->driver->fbdev_probe)
+		ret = dev->driver->fbdev_probe(fb_helper, &sizes);
+	else if (fb_helper->funcs)
+		ret = fb_helper->funcs->fb_probe(fb_helper, &sizes);
 	if (ret < 0)
 		return ret;
 
@@ -1740,7 +1703,7 @@ static void drm_fb_helper_fill_var(struct fb_info *info,
  * instance and the drm framebuffer allocated in &drm_fb_helper.fb.
  *
  * Drivers should call this (or their equivalent setup code) from their
- * &drm_fb_helper_funcs.fb_probe callback after having allocated the fbdev
+ * &drm_driver.fbdev_probe callback after having allocated the fbdev
  * backing storage framebuffer.
  */
 void drm_fb_helper_fill_info(struct fb_info *info,
@@ -1896,7 +1859,7 @@ __drm_fb_helper_initial_config_and_unlock(struct drm_fb_helper *fb_helper)
  * Note that this also registers the fbdev and so allows userspace to call into
  * the driver through the fbdev interfaces.
  *
- * This function will call down into the &drm_fb_helper_funcs.fb_probe callback
+ * This function will call down into the &drm_driver.fbdev_probe callback
  * to let the driver allocate and initialize the fbdev info structure and the
  * drm framebuffer used to back the fbdev. drm_fb_helper_fill_info() is provided
  * as a helper to setup simple default values for the fbdev info structure.
diff --git a/drivers/gpu/drm/drm_fbdev_client.c b/drivers/gpu/drm/drm_fbdev_client.c
new file mode 100644
index 000000000000..a09382afe2fb
--- /dev/null
+++ b/drivers/gpu/drm/drm_fbdev_client.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: MIT
+
+#include <drm/drm_client.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_fbdev_client.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_print.h>
+
+/*
+ * struct drm_client_funcs
+ */
+
+static void drm_fbdev_client_unregister(struct drm_client_dev *client)
+{
+	struct drm_fb_helper *fb_helper = drm_fb_helper_from_client(client);
+
+	if (fb_helper->info) {
+		drm_fb_helper_unregister_info(fb_helper);
+	} else {
+		drm_client_release(&fb_helper->client);
+		drm_fb_helper_unprepare(fb_helper);
+		kfree(fb_helper);
+	}
+}
+
+static int drm_fbdev_client_restore(struct drm_client_dev *client)
+{
+	drm_fb_helper_lastclose(client->dev);
+
+	return 0;
+}
+
+static int drm_fbdev_client_hotplug(struct drm_client_dev *client)
+{
+	struct drm_fb_helper *fb_helper = drm_fb_helper_from_client(client);
+	struct drm_device *dev = client->dev;
+	int ret;
+
+	if (dev->fb_helper)
+		return drm_fb_helper_hotplug_event(dev->fb_helper);
+
+	ret = drm_fb_helper_init(dev, fb_helper);
+	if (ret)
+		goto err_drm_err;
+
+	if (!drm_drv_uses_atomic_modeset(dev))
+		drm_helper_disable_unused_functions(dev);
+
+	ret = drm_fb_helper_initial_config(fb_helper);
+	if (ret)
+		goto err_drm_fb_helper_fini;
+
+	return 0;
+
+err_drm_fb_helper_fini:
+	drm_fb_helper_fini(fb_helper);
+err_drm_err:
+	drm_err(dev, "fbdev: Failed to setup emulation (ret=%d)\n", ret);
+	return ret;
+}
+
+static const struct drm_client_funcs drm_fbdev_client_funcs = {
+	.owner		= THIS_MODULE,
+	.unregister	= drm_fbdev_client_unregister,
+	.restore	= drm_fbdev_client_restore,
+	.hotplug	= drm_fbdev_client_hotplug,
+};
+
+/**
+ * drm_fbdev_client_setup() - Setup fbdev emulation
+ * @dev: DRM device
+ * @format: Preferred color format for the device. DRM_FORMAT_XRGB8888
+ *          is used if this is zero.
+ *
+ * This function sets up fbdev emulation. Restore, hotplug events and
+ * teardown are all taken care of. Drivers that do suspend/resume need
+ * to call drm_fb_helper_set_suspend_unlocked() themselves. Simple
+ * drivers might use drm_mode_config_helper_suspend().
+ *
+ * This function is safe to call even when there are no connectors present.
+ * Setup will be retried on the next hotplug event.
+ *
+ * The fbdev client is destroyed by drm_dev_unregister().
+ *
+ * Returns:
+ * 0 on success, or a negative errno code otherwise.
+ */
+int drm_fbdev_client_setup(struct drm_device *dev, const struct drm_format_info *format)
+{
+	struct drm_fb_helper *fb_helper;
+	unsigned int color_mode;
+	int ret;
+
+	/* TODO: Use format info throughout DRM */
+	if (format) {
+		unsigned int bpp = drm_format_info_bpp(format, 0);
+
+		switch (bpp) {
+		case 16:
+			color_mode = format->depth; // could also be 15
+			break;
+		default:
+			color_mode = bpp;
+		}
+	} else {
+		switch (dev->mode_config.preferred_depth) {
+		case 0:
+		case 24:
+			color_mode = 32;
+			break;
+		default:
+			color_mode = dev->mode_config.preferred_depth;
+		}
+	}
+
+	drm_WARN(dev, !dev->registered, "Device has not been registered.\n");
+	drm_WARN(dev, dev->fb_helper, "fb_helper is already set!\n");
+
+	fb_helper = kzalloc(sizeof(*fb_helper), GFP_KERNEL);
+	if (!fb_helper)
+		return -ENOMEM;
+	drm_fb_helper_prepare(dev, fb_helper, color_mode, NULL);
+
+	ret = drm_client_init(dev, &fb_helper->client, "fbdev", &drm_fbdev_client_funcs);
+	if (ret) {
+		drm_err(dev, "Failed to register client: %d\n", ret);
+		goto err_drm_client_init;
+	}
+
+	drm_client_register(&fb_helper->client);
+
+	return 0;
+
+err_drm_client_init:
+	drm_fb_helper_unprepare(fb_helper);
+	kfree(fb_helper);
+	return ret;
+}
+EXPORT_SYMBOL(drm_fbdev_client_setup);
diff --git a/drivers/gpu/drm/drm_fbdev_ttm.c b/drivers/gpu/drm/drm_fbdev_ttm.c
index 119ffb28aaf9..d799cbe944cd 100644
--- a/drivers/gpu/drm/drm_fbdev_ttm.c
+++ b/drivers/gpu/drm/drm_fbdev_ttm.c
@@ -71,71 +71,7 @@ static const struct fb_ops drm_fbdev_ttm_fb_ops = {
 static int drm_fbdev_ttm_helper_fb_probe(struct drm_fb_helper *fb_helper,
 					     struct drm_fb_helper_surface_size *sizes)
 {
-	struct drm_client_dev *client = &fb_helper->client;
-	struct drm_device *dev = fb_helper->dev;
-	struct drm_client_buffer *buffer;
-	struct fb_info *info;
-	size_t screen_size;
-	void *screen_buffer;
-	u32 format;
-	int ret;
-
-	drm_dbg_kms(dev, "surface width(%d), height(%d) and bpp(%d)\n",
-		    sizes->surface_width, sizes->surface_height,
-		    sizes->surface_bpp);
-
-	format = drm_driver_legacy_fb_format(dev, sizes->surface_bpp,
-					     sizes->surface_depth);
-	buffer = drm_client_framebuffer_create(client, sizes->surface_width,
-					       sizes->surface_height, format);
-	if (IS_ERR(buffer))
-		return PTR_ERR(buffer);
-
-	fb_helper->buffer = buffer;
-	fb_helper->fb = buffer->fb;
-
-	screen_size = buffer->gem->size;
-	screen_buffer = vzalloc(screen_size);
-	if (!screen_buffer) {
-		ret = -ENOMEM;
-		goto err_drm_client_framebuffer_delete;
-	}
-
-	info = drm_fb_helper_alloc_info(fb_helper);
-	if (IS_ERR(info)) {
-		ret = PTR_ERR(info);
-		goto err_vfree;
-	}
-
-	drm_fb_helper_fill_info(info, fb_helper, sizes);
-
-	info->fbops = &drm_fbdev_ttm_fb_ops;
-
-	/* screen */
-	info->flags |= FBINFO_VIRTFB | FBINFO_READS_FAST;
-	info->screen_buffer = screen_buffer;
-	info->fix.smem_len = screen_size;
-
-	/* deferred I/O */
-	fb_helper->fbdefio.delay = HZ / 20;
-	fb_helper->fbdefio.deferred_io = drm_fb_helper_deferred_io;
-
-	info->fbdefio = &fb_helper->fbdefio;
-	ret = fb_deferred_io_init(info);
-	if (ret)
-		goto err_drm_fb_helper_release_info;
-
-	return 0;
-
-err_drm_fb_helper_release_info:
-	drm_fb_helper_release_info(fb_helper);
-err_vfree:
-	vfree(screen_buffer);
-err_drm_client_framebuffer_delete:
-	fb_helper->fb = NULL;
-	fb_helper->buffer = NULL;
-	drm_client_framebuffer_delete(buffer);
-	return ret;
+	return drm_fbdev_ttm_driver_fbdev_probe(fb_helper, sizes);
 }
 
 static void drm_fbdev_ttm_damage_blit_real(struct drm_fb_helper *fb_helper,
@@ -240,6 +176,82 @@ static const struct drm_fb_helper_funcs drm_fbdev_ttm_helper_funcs = {
 	.fb_dirty = drm_fbdev_ttm_helper_fb_dirty,
 };
 
+/*
+ * struct drm_driver
+ */
+
+int drm_fbdev_ttm_driver_fbdev_probe(struct drm_fb_helper *fb_helper,
+				     struct drm_fb_helper_surface_size *sizes)
+{
+	struct drm_client_dev *client = &fb_helper->client;
+	struct drm_device *dev = fb_helper->dev;
+	struct drm_client_buffer *buffer;
+	struct fb_info *info;
+	size_t screen_size;
+	void *screen_buffer;
+	u32 format;
+	int ret;
+
+	drm_dbg_kms(dev, "surface width(%d), height(%d) and bpp(%d)\n",
+		    sizes->surface_width, sizes->surface_height,
+		    sizes->surface_bpp);
+
+	format = drm_driver_legacy_fb_format(dev, sizes->surface_bpp,
+					     sizes->surface_depth);
+	buffer = drm_client_framebuffer_create(client, sizes->surface_width,
+					       sizes->surface_height, format);
+	if (IS_ERR(buffer))
+		return PTR_ERR(buffer);
+
+	fb_helper->funcs = &drm_fbdev_ttm_helper_funcs;
+	fb_helper->buffer = buffer;
+	fb_helper->fb = buffer->fb;
+
+	screen_size = buffer->gem->size;
+	screen_buffer = vzalloc(screen_size);
+	if (!screen_buffer) {
+		ret = -ENOMEM;
+		goto err_drm_client_framebuffer_delete;
+	}
+
+	info = drm_fb_helper_alloc_info(fb_helper);
+	if (IS_ERR(info)) {
+		ret = PTR_ERR(info);
+		goto err_vfree;
+	}
+
+	drm_fb_helper_fill_info(info, fb_helper, sizes);
+
+	info->fbops = &drm_fbdev_ttm_fb_ops;
+
+	/* screen */
+	info->flags |= FBINFO_VIRTFB | FBINFO_READS_FAST;
+	info->screen_buffer = screen_buffer;
+	info->fix.smem_len = screen_size;
+
+	/* deferred I/O */
+	fb_helper->fbdefio.delay = HZ / 20;
+	fb_helper->fbdefio.deferred_io = drm_fb_helper_deferred_io;
+
+	info->fbdefio = &fb_helper->fbdefio;
+	ret = fb_deferred_io_init(info);
+	if (ret)
+		goto err_drm_fb_helper_release_info;
+
+	return 0;
+
+err_drm_fb_helper_release_info:
+	drm_fb_helper_release_info(fb_helper);
+err_vfree:
+	vfree(screen_buffer);
+err_drm_client_framebuffer_delete:
+	fb_helper->fb = NULL;
+	fb_helper->buffer = NULL;
+	drm_client_framebuffer_delete(buffer);
+	return ret;
+}
+EXPORT_SYMBOL(drm_fbdev_ttm_driver_fbdev_probe);
+
 static void drm_fbdev_ttm_client_unregister(struct drm_client_dev *client)
 {
 	struct drm_fb_helper *fb_helper = drm_fb_helper_from_client(client);
diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 193cf8ed7912..3a94ca211f9c 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -36,7 +36,6 @@
  * @depth: bit depth per pixel
  *
  * Computes a drm fourcc pixel format code for the given @bpp/@depth values.
- * Useful in fbdev emulation code, since that deals in those values.
  */
 uint32_t drm_mode_legacy_fb_format(uint32_t bpp, uint32_t depth)
 {
@@ -140,6 +139,35 @@ uint32_t drm_driver_legacy_fb_format(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drm_driver_legacy_fb_format);
 
+/**
+ * drm_driver_color_mode_format - Compute DRM 4CC code from color mode
+ * @dev: DRM device
+ * @color_mode: command-line color mode
+ *
+ * Computes a DRM 4CC pixel format code for the given color mode using
+ * drm_driver_color_mode(). The color mode is in the format used and the
+ * kernel command line. It specifies the number of bits per pixel
+ * and color depth in a single value.
+ *
+ * Useful in fbdev emulation code, since that deals in those values. The
+ * helper does not consider YUV or other complicated formats. This means
+ * only legacy formats are supported (fmt->depth is a legacy field), but
+ * the framebuffer emulation can only deal with such formats, specifically
+ * RGB/BGA formats.
+ */
+uint32_t drm_driver_color_mode_format(struct drm_device *dev, unsigned int color_mode)
+{
+	switch (color_mode) {
+	case 15:
+		return drm_driver_legacy_fb_format(dev, 16, 15);
+	case 32:
+		return drm_driver_legacy_fb_format(dev, 32, 24);
+	default:
+		return drm_driver_legacy_fb_format(dev, color_mode, color_mode);
+	}
+}
+EXPORT_SYMBOL(drm_driver_color_mode_format);
+
 /*
  * Internal function to query information for a given format. See
  * drm_format_info() for the public API.
diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
index 447740d79d3d..bcf248f69252 100644
--- a/drivers/gpu/drm/drm_panic_qr.rs
+++ b/drivers/gpu/drm/drm_panic_qr.rs
@@ -209,12 +209,9 @@
 impl Version {
     /// Returns the smallest QR version than can hold these segments.
     fn from_segments(segments: &[&Segment<'_>]) -> Option<Version> {
-        for v in (1..=40).map(|k| Version(k)) {
-            if v.max_data() * 8 >= segments.iter().map(|s| s.total_size_bits(v)).sum() {
-                return Some(v);
-            }
-        }
-        None
+        (1..=40)
+            .map(Version)
+            .find(|&v| v.max_data() * 8 >= segments.iter().map(|s| s.total_size_bits(v)).sum())
     }
 
     fn width(&self) -> u8 {
@@ -242,7 +239,7 @@ fn g1_blk_size(&self) -> usize {
     }
 
     fn alignment_pattern(&self) -> &'static [u8] {
-        &ALIGNMENT_PATTERNS[self.0 - 1]
+        ALIGNMENT_PATTERNS[self.0 - 1]
     }
 
     fn poly(&self) -> &'static [u8] {
@@ -479,7 +476,7 @@ struct EncodedMsg<'a> {
 /// Data to be put in the QR code, with correct segment encoding, padding, and
 /// Error Code Correction.
 impl EncodedMsg<'_> {
-    fn new<'a, 'b>(segments: &[&Segment<'b>], data: &'a mut [u8]) -> Option<EncodedMsg<'a>> {
+    fn new<'a>(segments: &[&Segment<'_>], data: &'a mut [u8]) -> Option<EncodedMsg<'a>> {
         let version = Version::from_segments(segments)?;
         let ec_size = version.ec_size();
         let g1_blocks = version.g1_blocks();
@@ -492,7 +489,7 @@ fn new<'a, 'b>(segments: &[&Segment<'b>], data: &'a mut [u8]) -> Option<EncodedM
         data.fill(0);
 
         let mut em = EncodedMsg {
-            data: data,
+            data,
             ec_size,
             g1_blocks,
             g2_blocks,
@@ -722,7 +719,10 @@ fn draw_finders(&mut self) {
 
     fn is_finder(&self, x: u8, y: u8) -> bool {
         let end = self.width - 8;
-        (x < 8 && y < 8) || (x < 8 && y >= end) || (x >= end && y < 8)
+        #[expect(clippy::nonminimal_bool)]
+        {
+            (x < 8 && y < 8) || (x < 8 && y >= end) || (x >= end && y < 8)
+        }
     }
 
     // Alignment pattern: 5x5 squares in a grid.
@@ -931,7 +931,7 @@ fn draw_all(&mut self, data: impl Iterator<Item = u8>) {
 /// They must remain valid for the duration of the function call.
 #[no_mangle]
 pub unsafe extern "C" fn drm_panic_qr_generate(
-    url: *const i8,
+    url: *const kernel::ffi::c_char,
     data: *mut u8,
     data_len: usize,
     data_size: usize,
@@ -978,10 +978,11 @@ fn draw_all(&mut self, data: impl Iterator<Item = u8>) {
 /// * `url_len`: Length of the URL.
 ///
 /// * If `url_len` > 0, remove the 2 segments header/length and also count the
-/// conversion to numeric segments.
+///   conversion to numeric segments.
 /// * If `url_len` = 0, only removes 3 bytes for 1 binary segment.
 #[no_mangle]
 pub extern "C" fn drm_panic_qr_max_data_size(version: u8, url_len: usize) -> usize {
+    #[expect(clippy::manual_range_contains)]
     if version < 1 || version > 40 {
         return 0;
     }
diff --git a/drivers/gpu/drm/i915/display/i9xx_plane.c b/drivers/gpu/drm/i915/display/i9xx_plane.c
index 9447f7229b60..17a1e3801a85 100644
--- a/drivers/gpu/drm/i915/display/i9xx_plane.c
+++ b/drivers/gpu/drm/i915/display/i9xx_plane.c
@@ -416,7 +416,8 @@ static int i9xx_plane_min_cdclk(const struct intel_crtc_state *crtc_state,
 	return DIV_ROUND_UP(pixel_rate * num, den);
 }
 
-static void i9xx_plane_update_noarm(struct intel_plane *plane,
+static void i9xx_plane_update_noarm(struct intel_dsb *dsb,
+				    struct intel_plane *plane,
 				    const struct intel_crtc_state *crtc_state,
 				    const struct intel_plane_state *plane_state)
 {
@@ -444,7 +445,8 @@ static void i9xx_plane_update_noarm(struct intel_plane *plane,
 	}
 }
 
-static void i9xx_plane_update_arm(struct intel_plane *plane,
+static void i9xx_plane_update_arm(struct intel_dsb *dsb,
+				  struct intel_plane *plane,
 				  const struct intel_crtc_state *crtc_state,
 				  const struct intel_plane_state *plane_state)
 {
@@ -507,7 +509,8 @@ static void i9xx_plane_update_arm(struct intel_plane *plane,
 				  intel_plane_ggtt_offset(plane_state) + dspaddr_offset);
 }
 
-static void i830_plane_update_arm(struct intel_plane *plane,
+static void i830_plane_update_arm(struct intel_dsb *dsb,
+				  struct intel_plane *plane,
 				  const struct intel_crtc_state *crtc_state,
 				  const struct intel_plane_state *plane_state)
 {
@@ -517,11 +520,12 @@ static void i830_plane_update_arm(struct intel_plane *plane,
 	 * Additional breakage on i830 causes register reads to return
 	 * the last latched value instead of the last written value [ALM026].
 	 */
-	i9xx_plane_update_noarm(plane, crtc_state, plane_state);
-	i9xx_plane_update_arm(plane, crtc_state, plane_state);
+	i9xx_plane_update_noarm(dsb, plane, crtc_state, plane_state);
+	i9xx_plane_update_arm(dsb, plane, crtc_state, plane_state);
 }
 
-static void i9xx_plane_disable_arm(struct intel_plane *plane,
+static void i9xx_plane_disable_arm(struct intel_dsb *dsb,
+				   struct intel_plane *plane,
 				   const struct intel_crtc_state *crtc_state)
 {
 	struct drm_i915_private *dev_priv = to_i915(plane->base.dev);
@@ -549,7 +553,8 @@ static void i9xx_plane_disable_arm(struct intel_plane *plane,
 }
 
 static void
-g4x_primary_async_flip(struct intel_plane *plane,
+g4x_primary_async_flip(struct intel_dsb *dsb,
+		       struct intel_plane *plane,
 		       const struct intel_crtc_state *crtc_state,
 		       const struct intel_plane_state *plane_state,
 		       bool async_flip)
@@ -569,7 +574,8 @@ g4x_primary_async_flip(struct intel_plane *plane,
 }
 
 static void
-vlv_primary_async_flip(struct intel_plane *plane,
+vlv_primary_async_flip(struct intel_dsb *dsb,
+		       struct intel_plane *plane,
 		       const struct intel_crtc_state *crtc_state,
 		       const struct intel_plane_state *plane_state,
 		       bool async_flip)
diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index 293efc1f841d..4e95b8eda23f 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -50,38 +50,38 @@
 #include "skl_scaler.h"
 #include "skl_universal_plane.h"
 
-static int header_credits_available(struct drm_i915_private *dev_priv,
+static int header_credits_available(struct intel_display *display,
 				    enum transcoder dsi_trans)
 {
-	return (intel_de_read(dev_priv, DSI_CMD_TXCTL(dsi_trans)) & FREE_HEADER_CREDIT_MASK)
+	return (intel_de_read(display, DSI_CMD_TXCTL(dsi_trans)) & FREE_HEADER_CREDIT_MASK)
 		>> FREE_HEADER_CREDIT_SHIFT;
 }
 
-static int payload_credits_available(struct drm_i915_private *dev_priv,
+static int payload_credits_available(struct intel_display *display,
 				     enum transcoder dsi_trans)
 {
-	return (intel_de_read(dev_priv, DSI_CMD_TXCTL(dsi_trans)) & FREE_PLOAD_CREDIT_MASK)
+	return (intel_de_read(display, DSI_CMD_TXCTL(dsi_trans)) & FREE_PLOAD_CREDIT_MASK)
 		>> FREE_PLOAD_CREDIT_SHIFT;
 }
 
-static bool wait_for_header_credits(struct drm_i915_private *dev_priv,
+static bool wait_for_header_credits(struct intel_display *display,
 				    enum transcoder dsi_trans, int hdr_credit)
 {
-	if (wait_for_us(header_credits_available(dev_priv, dsi_trans) >=
+	if (wait_for_us(header_credits_available(display, dsi_trans) >=
 			hdr_credit, 100)) {
-		drm_err(&dev_priv->drm, "DSI header credits not released\n");
+		drm_err(display->drm, "DSI header credits not released\n");
 		return false;
 	}
 
 	return true;
 }
 
-static bool wait_for_payload_credits(struct drm_i915_private *dev_priv,
+static bool wait_for_payload_credits(struct intel_display *display,
 				     enum transcoder dsi_trans, int payld_credit)
 {
-	if (wait_for_us(payload_credits_available(dev_priv, dsi_trans) >=
+	if (wait_for_us(payload_credits_available(display, dsi_trans) >=
 			payld_credit, 100)) {
-		drm_err(&dev_priv->drm, "DSI payload credits not released\n");
+		drm_err(display->drm, "DSI payload credits not released\n");
 		return false;
 	}
 
@@ -98,7 +98,7 @@ static enum transcoder dsi_port_to_transcoder(enum port port)
 
 static void wait_for_cmds_dispatched_to_panel(struct intel_encoder *encoder)
 {
-	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
+	struct intel_display *display = to_intel_display(encoder);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	struct mipi_dsi_device *dsi;
 	enum port port;
@@ -108,8 +108,8 @@ static void wait_for_cmds_dispatched_to_panel(struct intel_encoder *encoder)
 	/* wait for header/payload credits to be released */
 	for_each_dsi_port(port, intel_dsi->ports) {
 		dsi_trans = dsi_port_to_transcoder(port);
-		wait_for_header_credits(dev_priv, dsi_trans, MAX_HEADER_CREDIT);
-		wait_for_payload_credits(dev_priv, dsi_trans, MAX_PLOAD_CREDIT);
+		wait_for_header_credits(display, dsi_trans, MAX_HEADER_CREDIT);
+		wait_for_payload_credits(display, dsi_trans, MAX_PLOAD_CREDIT);
 	}
 
 	/* send nop DCS command */
@@ -119,22 +119,22 @@ static void wait_for_cmds_dispatched_to_panel(struct intel_encoder *encoder)
 		dsi->channel = 0;
 		ret = mipi_dsi_dcs_nop(dsi);
 		if (ret < 0)
-			drm_err(&dev_priv->drm,
+			drm_err(display->drm,
 				"error sending DCS NOP command\n");
 	}
 
 	/* wait for header credits to be released */
 	for_each_dsi_port(port, intel_dsi->ports) {
 		dsi_trans = dsi_port_to_transcoder(port);
-		wait_for_header_credits(dev_priv, dsi_trans, MAX_HEADER_CREDIT);
+		wait_for_header_credits(display, dsi_trans, MAX_HEADER_CREDIT);
 	}
 
 	/* wait for LP TX in progress bit to be cleared */
 	for_each_dsi_port(port, intel_dsi->ports) {
 		dsi_trans = dsi_port_to_transcoder(port);
-		if (wait_for_us(!(intel_de_read(dev_priv, DSI_LP_MSG(dsi_trans)) &
+		if (wait_for_us(!(intel_de_read(display, DSI_LP_MSG(dsi_trans)) &
 				  LPTX_IN_PROGRESS), 20))
-			drm_err(&dev_priv->drm, "LPTX bit not cleared\n");
+			drm_err(display->drm, "LPTX bit not cleared\n");
 	}
 }
 
@@ -142,7 +142,7 @@ static int dsi_send_pkt_payld(struct intel_dsi_host *host,
 			      const struct mipi_dsi_packet *packet)
 {
 	struct intel_dsi *intel_dsi = host->intel_dsi;
-	struct drm_i915_private *i915 = to_i915(intel_dsi->base.base.dev);
+	struct intel_display *display = to_intel_display(&intel_dsi->base);
 	enum transcoder dsi_trans = dsi_port_to_transcoder(host->port);
 	const u8 *data = packet->payload;
 	u32 len = packet->payload_length;
@@ -150,20 +150,20 @@ static int dsi_send_pkt_payld(struct intel_dsi_host *host,
 
 	/* payload queue can accept *256 bytes*, check limit */
 	if (len > MAX_PLOAD_CREDIT * 4) {
-		drm_err(&i915->drm, "payload size exceeds max queue limit\n");
+		drm_err(display->drm, "payload size exceeds max queue limit\n");
 		return -EINVAL;
 	}
 
 	for (i = 0; i < len; i += 4) {
 		u32 tmp = 0;
 
-		if (!wait_for_payload_credits(i915, dsi_trans, 1))
+		if (!wait_for_payload_credits(display, dsi_trans, 1))
 			return -EBUSY;
 
 		for (j = 0; j < min_t(u32, len - i, 4); j++)
 			tmp |= *data++ << 8 * j;
 
-		intel_de_write(i915, DSI_CMD_TXPYLD(dsi_trans), tmp);
+		intel_de_write(display, DSI_CMD_TXPYLD(dsi_trans), tmp);
 	}
 
 	return 0;
@@ -174,14 +174,14 @@ static int dsi_send_pkt_hdr(struct intel_dsi_host *host,
 			    bool enable_lpdt)
 {
 	struct intel_dsi *intel_dsi = host->intel_dsi;
-	struct drm_i915_private *dev_priv = to_i915(intel_dsi->base.base.dev);
+	struct intel_display *display = to_intel_display(&intel_dsi->base);
 	enum transcoder dsi_trans = dsi_port_to_transcoder(host->port);
 	u32 tmp;
 
-	if (!wait_for_header_credits(dev_priv, dsi_trans, 1))
+	if (!wait_for_header_credits(display, dsi_trans, 1))
 		return -EBUSY;
 
-	tmp = intel_de_read(dev_priv, DSI_CMD_TXHDR(dsi_trans));
+	tmp = intel_de_read(display, DSI_CMD_TXHDR(dsi_trans));
 
 	if (packet->payload)
 		tmp |= PAYLOAD_PRESENT;
@@ -200,15 +200,14 @@ static int dsi_send_pkt_hdr(struct intel_dsi_host *host,
 	tmp |= ((packet->header[0] & DT_MASK) << DT_SHIFT);
 	tmp |= (packet->header[1] << PARAM_WC_LOWER_SHIFT);
 	tmp |= (packet->header[2] << PARAM_WC_UPPER_SHIFT);
-	intel_de_write(dev_priv, DSI_CMD_TXHDR(dsi_trans), tmp);
+	intel_de_write(display, DSI_CMD_TXHDR(dsi_trans), tmp);
 
 	return 0;
 }
 
 void icl_dsi_frame_update(struct intel_crtc_state *crtc_state)
 {
-	struct intel_crtc *crtc = to_intel_crtc(crtc_state->uapi.crtc);
-	struct drm_i915_private *dev_priv = to_i915(crtc->base.dev);
+	struct intel_display *display = to_intel_display(crtc_state);
 	u32 mode_flags;
 	enum port port;
 
@@ -226,12 +225,13 @@ void icl_dsi_frame_update(struct intel_crtc_state *crtc_state)
 	else
 		return;
 
-	intel_de_rmw(dev_priv, DSI_CMD_FRMCTL(port), 0, DSI_FRAME_UPDATE_REQUEST);
+	intel_de_rmw(display, DSI_CMD_FRMCTL(port), 0,
+		     DSI_FRAME_UPDATE_REQUEST);
 }
 
 static void dsi_program_swing_and_deemphasis(struct intel_encoder *encoder)
 {
-	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
+	struct intel_display *display = to_intel_display(encoder);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	enum phy phy;
 	u32 tmp, mask, val;
@@ -245,31 +245,31 @@ static void dsi_program_swing_and_deemphasis(struct intel_encoder *encoder)
 		mask = SCALING_MODE_SEL_MASK | RTERM_SELECT_MASK;
 		val = SCALING_MODE_SEL(0x2) | TAP2_DISABLE | TAP3_DISABLE |
 		      RTERM_SELECT(0x6);
-		tmp = intel_de_read(dev_priv, ICL_PORT_TX_DW5_LN(0, phy));
+		tmp = intel_de_read(display, ICL_PORT_TX_DW5_LN(0, phy));
 		tmp &= ~mask;
 		tmp |= val;
-		intel_de_write(dev_priv, ICL_PORT_TX_DW5_GRP(phy), tmp);
-		intel_de_rmw(dev_priv, ICL_PORT_TX_DW5_AUX(phy), mask, val);
+		intel_de_write(display, ICL_PORT_TX_DW5_GRP(phy), tmp);
+		intel_de_rmw(display, ICL_PORT_TX_DW5_AUX(phy), mask, val);
 
 		mask = SWING_SEL_LOWER_MASK | SWING_SEL_UPPER_MASK |
 		       RCOMP_SCALAR_MASK;
 		val = SWING_SEL_UPPER(0x2) | SWING_SEL_LOWER(0x2) |
 		      RCOMP_SCALAR(0x98);
-		tmp = intel_de_read(dev_priv, ICL_PORT_TX_DW2_LN(0, phy));
+		tmp = intel_de_read(display, ICL_PORT_TX_DW2_LN(0, phy));
 		tmp &= ~mask;
 		tmp |= val;
-		intel_de_write(dev_priv, ICL_PORT_TX_DW2_GRP(phy), tmp);
-		intel_de_rmw(dev_priv, ICL_PORT_TX_DW2_AUX(phy), mask, val);
+		intel_de_write(display, ICL_PORT_TX_DW2_GRP(phy), tmp);
+		intel_de_rmw(display, ICL_PORT_TX_DW2_AUX(phy), mask, val);
 
 		mask = POST_CURSOR_1_MASK | POST_CURSOR_2_MASK |
 		       CURSOR_COEFF_MASK;
 		val = POST_CURSOR_1(0x0) | POST_CURSOR_2(0x0) |
 		      CURSOR_COEFF(0x3f);
-		intel_de_rmw(dev_priv, ICL_PORT_TX_DW4_AUX(phy), mask, val);
+		intel_de_rmw(display, ICL_PORT_TX_DW4_AUX(phy), mask, val);
 
 		/* Bspec: must not use GRP register for write */
 		for (lane = 0; lane <= 3; lane++)
-			intel_de_rmw(dev_priv, ICL_PORT_TX_DW4_LN(lane, phy),
+			intel_de_rmw(display, ICL_PORT_TX_DW4_LN(lane, phy),
 				     mask, val);
 	}
 }
@@ -277,13 +277,13 @@ static void dsi_program_swing_and_deemphasis(struct intel_encoder *encoder)
 static void configure_dual_link_mode(struct intel_encoder *encoder,
 				     const struct intel_crtc_state *pipe_config)
 {
-	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
+	struct intel_display *display = to_intel_display(encoder);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	i915_reg_t dss_ctl1_reg, dss_ctl2_reg;
 	u32 dss_ctl1;
 
 	/* FIXME: Move all DSS handling to intel_vdsc.c */
-	if (DISPLAY_VER(dev_priv) >= 12) {
+	if (DISPLAY_VER(display) >= 12) {
 		struct intel_crtc *crtc = to_intel_crtc(pipe_config->uapi.crtc);
 
 		dss_ctl1_reg = ICL_PIPE_DSS_CTL1(crtc->pipe);
@@ -293,7 +293,7 @@ static void configure_dual_link_mode(struct intel_encoder *encoder,
 		dss_ctl2_reg = DSS_CTL2;
 	}
 
-	dss_ctl1 = intel_de_read(dev_priv, dss_ctl1_reg);
+	dss_ctl1 = intel_de_read(display, dss_ctl1_reg);
 	dss_ctl1 |= SPLITTER_ENABLE;
 	dss_ctl1 &= ~OVERLAP_PIXELS_MASK;
 	dss_ctl1 |= OVERLAP_PIXELS(intel_dsi->pixel_overlap);
@@ -308,19 +308,19 @@ static void configure_dual_link_mode(struct intel_encoder *encoder,
 		dl_buffer_depth = hactive / 2 + intel_dsi->pixel_overlap;
 
 		if (dl_buffer_depth > MAX_DL_BUFFER_TARGET_DEPTH)
-			drm_err(&dev_priv->drm,
+			drm_err(display->drm,
 				"DL buffer depth exceed max value\n");
 
 		dss_ctl1 &= ~LEFT_DL_BUF_TARGET_DEPTH_MASK;
 		dss_ctl1 |= LEFT_DL_BUF_TARGET_DEPTH(dl_buffer_depth);
-		intel_de_rmw(dev_priv, dss_ctl2_reg, RIGHT_DL_BUF_TARGET_DEPTH_MASK,
+		intel_de_rmw(display, dss_ctl2_reg, RIGHT_DL_BUF_TARGET_DEPTH_MASK,
 			     RIGHT_DL_BUF_TARGET_DEPTH(dl_buffer_depth));
 	} else {
 		/* Interleave */
 		dss_ctl1 |= DUAL_LINK_MODE_INTERLEAVE;
 	}
 
-	intel_de_write(dev_priv, dss_ctl1_reg, dss_ctl1);
+	intel_de_write(display, dss_ctl1_reg, dss_ctl1);
 }
 
 /* aka DSI 8X clock */
@@ -341,6 +341,7 @@ static int afe_clk(struct intel_encoder *encoder,
 static void gen11_dsi_program_esc_clk_div(struct intel_encoder *encoder,
 					  const struct intel_crtc_state *crtc_state)
 {
+	struct intel_display *display = to_intel_display(encoder);
 	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	enum port port;
@@ -360,33 +361,34 @@ static void gen11_dsi_program_esc_clk_div(struct intel_encoder *encoder,
 	}
 
 	for_each_dsi_port(port, intel_dsi->ports) {
-		intel_de_write(dev_priv, ICL_DSI_ESC_CLK_DIV(port),
+		intel_de_write(display, ICL_DSI_ESC_CLK_DIV(port),
 			       esc_clk_div_m & ICL_ESC_CLK_DIV_MASK);
-		intel_de_posting_read(dev_priv, ICL_DSI_ESC_CLK_DIV(port));
+		intel_de_posting_read(display, ICL_DSI_ESC_CLK_DIV(port));
 	}
 
 	for_each_dsi_port(port, intel_dsi->ports) {
-		intel_de_write(dev_priv, ICL_DPHY_ESC_CLK_DIV(port),
+		intel_de_write(display, ICL_DPHY_ESC_CLK_DIV(port),
 			       esc_clk_div_m & ICL_ESC_CLK_DIV_MASK);
-		intel_de_posting_read(dev_priv, ICL_DPHY_ESC_CLK_DIV(port));
+		intel_de_posting_read(display, ICL_DPHY_ESC_CLK_DIV(port));
 	}
 
 	if (IS_ALDERLAKE_S(dev_priv) || IS_ALDERLAKE_P(dev_priv)) {
 		for_each_dsi_port(port, intel_dsi->ports) {
-			intel_de_write(dev_priv, ADL_MIPIO_DW(port, 8),
+			intel_de_write(display, ADL_MIPIO_DW(port, 8),
 				       esc_clk_div_m_phy & TX_ESC_CLK_DIV_PHY);
-			intel_de_posting_read(dev_priv, ADL_MIPIO_DW(port, 8));
+			intel_de_posting_read(display, ADL_MIPIO_DW(port, 8));
 		}
 	}
 }
 
-static void get_dsi_io_power_domains(struct drm_i915_private *dev_priv,
-				     struct intel_dsi *intel_dsi)
+static void get_dsi_io_power_domains(struct intel_dsi *intel_dsi)
 {
+	struct intel_display *display = to_intel_display(&intel_dsi->base);
+	struct drm_i915_private *dev_priv = to_i915(display->drm);
 	enum port port;
 
 	for_each_dsi_port(port, intel_dsi->ports) {
-		drm_WARN_ON(&dev_priv->drm, intel_dsi->io_wakeref[port]);
+		drm_WARN_ON(display->drm, intel_dsi->io_wakeref[port]);
 		intel_dsi->io_wakeref[port] =
 			intel_display_power_get(dev_priv,
 						port == PORT_A ?
@@ -397,15 +399,15 @@ static void get_dsi_io_power_domains(struct drm_i915_private *dev_priv,
 
 static void gen11_dsi_enable_io_power(struct intel_encoder *encoder)
 {
-	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
+	struct intel_display *display = to_intel_display(encoder);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	enum port port;
 
 	for_each_dsi_port(port, intel_dsi->ports)
-		intel_de_rmw(dev_priv, ICL_DSI_IO_MODECTL(port),
+		intel_de_rmw(display, ICL_DSI_IO_MODECTL(port),
 			     0, COMBO_PHY_MODE_DSI);
 
-	get_dsi_io_power_domains(dev_priv, intel_dsi);
+	get_dsi_io_power_domains(intel_dsi);
 }
 
 static void gen11_dsi_power_up_lanes(struct intel_encoder *encoder)
@@ -421,6 +423,7 @@ static void gen11_dsi_power_up_lanes(struct intel_encoder *encoder)
 
 static void gen11_dsi_config_phy_lanes_sequence(struct intel_encoder *encoder)
 {
+	struct intel_display *display = to_intel_display(encoder);
 	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	enum phy phy;
@@ -429,32 +432,33 @@ static void gen11_dsi_config_phy_lanes_sequence(struct intel_encoder *encoder)
 
 	/* Step 4b(i) set loadgen select for transmit and aux lanes */
 	for_each_dsi_phy(phy, intel_dsi->phys) {
-		intel_de_rmw(dev_priv, ICL_PORT_TX_DW4_AUX(phy), LOADGEN_SELECT, 0);
+		intel_de_rmw(display, ICL_PORT_TX_DW4_AUX(phy),
+			     LOADGEN_SELECT, 0);
 		for (lane = 0; lane <= 3; lane++)
-			intel_de_rmw(dev_priv, ICL_PORT_TX_DW4_LN(lane, phy),
+			intel_de_rmw(display, ICL_PORT_TX_DW4_LN(lane, phy),
 				     LOADGEN_SELECT, lane != 2 ? LOADGEN_SELECT : 0);
 	}
 
 	/* Step 4b(ii) set latency optimization for transmit and aux lanes */
 	for_each_dsi_phy(phy, intel_dsi->phys) {
-		intel_de_rmw(dev_priv, ICL_PORT_TX_DW2_AUX(phy),
+		intel_de_rmw(display, ICL_PORT_TX_DW2_AUX(phy),
 			     FRC_LATENCY_OPTIM_MASK, FRC_LATENCY_OPTIM_VAL(0x5));
-		tmp = intel_de_read(dev_priv, ICL_PORT_TX_DW2_LN(0, phy));
+		tmp = intel_de_read(display, ICL_PORT_TX_DW2_LN(0, phy));
 		tmp &= ~FRC_LATENCY_OPTIM_MASK;
 		tmp |= FRC_LATENCY_OPTIM_VAL(0x5);
-		intel_de_write(dev_priv, ICL_PORT_TX_DW2_GRP(phy), tmp);
+		intel_de_write(display, ICL_PORT_TX_DW2_GRP(phy), tmp);
 
 		/* For EHL, TGL, set latency optimization for PCS_DW1 lanes */
 		if (IS_JASPERLAKE(dev_priv) || IS_ELKHARTLAKE(dev_priv) ||
-		    (DISPLAY_VER(dev_priv) >= 12)) {
-			intel_de_rmw(dev_priv, ICL_PORT_PCS_DW1_AUX(phy),
+		    (DISPLAY_VER(display) >= 12)) {
+			intel_de_rmw(display, ICL_PORT_PCS_DW1_AUX(phy),
 				     LATENCY_OPTIM_MASK, LATENCY_OPTIM_VAL(0));
 
-			tmp = intel_de_read(dev_priv,
+			tmp = intel_de_read(display,
 					    ICL_PORT_PCS_DW1_LN(0, phy));
 			tmp &= ~LATENCY_OPTIM_MASK;
 			tmp |= LATENCY_OPTIM_VAL(0x1);
-			intel_de_write(dev_priv, ICL_PORT_PCS_DW1_GRP(phy),
+			intel_de_write(display, ICL_PORT_PCS_DW1_GRP(phy),
 				       tmp);
 		}
 	}
@@ -463,17 +467,17 @@ static void gen11_dsi_config_phy_lanes_sequence(struct intel_encoder *encoder)
 
 static void gen11_dsi_voltage_swing_program_seq(struct intel_encoder *encoder)
 {
-	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
+	struct intel_display *display = to_intel_display(encoder);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	u32 tmp;
 	enum phy phy;
 
 	/* clear common keeper enable bit */
 	for_each_dsi_phy(phy, intel_dsi->phys) {
-		tmp = intel_de_read(dev_priv, ICL_PORT_PCS_DW1_LN(0, phy));
+		tmp = intel_de_read(display, ICL_PORT_PCS_DW1_LN(0, phy));
 		tmp &= ~COMMON_KEEPER_EN;
-		intel_de_write(dev_priv, ICL_PORT_PCS_DW1_GRP(phy), tmp);
-		intel_de_rmw(dev_priv, ICL_PORT_PCS_DW1_AUX(phy), COMMON_KEEPER_EN, 0);
+		intel_de_write(display, ICL_PORT_PCS_DW1_GRP(phy), tmp);
+		intel_de_rmw(display, ICL_PORT_PCS_DW1_AUX(phy), COMMON_KEEPER_EN, 0);
 	}
 
 	/*
@@ -482,14 +486,15 @@ static void gen11_dsi_voltage_swing_program_seq(struct intel_encoder *encoder)
 	 * as part of lane phy sequence configuration
 	 */
 	for_each_dsi_phy(phy, intel_dsi->phys)
-		intel_de_rmw(dev_priv, ICL_PORT_CL_DW5(phy), 0, SUS_CLOCK_CONFIG);
+		intel_de_rmw(display, ICL_PORT_CL_DW5(phy), 0,
+			     SUS_CLOCK_CONFIG);
 
 	/* Clear training enable to change swing values */
 	for_each_dsi_phy(phy, intel_dsi->phys) {
-		tmp = intel_de_read(dev_priv, ICL_PORT_TX_DW5_LN(0, phy));
+		tmp = intel_de_read(display, ICL_PORT_TX_DW5_LN(0, phy));
 		tmp &= ~TX_TRAINING_EN;
-		intel_de_write(dev_priv, ICL_PORT_TX_DW5_GRP(phy), tmp);
-		intel_de_rmw(dev_priv, ICL_PORT_TX_DW5_AUX(phy), TX_TRAINING_EN, 0);
+		intel_de_write(display, ICL_PORT_TX_DW5_GRP(phy), tmp);
+		intel_de_rmw(display, ICL_PORT_TX_DW5_AUX(phy), TX_TRAINING_EN, 0);
 	}
 
 	/* Program swing and de-emphasis */
@@ -497,26 +502,26 @@ static void gen11_dsi_voltage_swing_program_seq(struct intel_encoder *encoder)
 
 	/* Set training enable to trigger update */
 	for_each_dsi_phy(phy, intel_dsi->phys) {
-		tmp = intel_de_read(dev_priv, ICL_PORT_TX_DW5_LN(0, phy));
+		tmp = intel_de_read(display, ICL_PORT_TX_DW5_LN(0, phy));
 		tmp |= TX_TRAINING_EN;
-		intel_de_write(dev_priv, ICL_PORT_TX_DW5_GRP(phy), tmp);
-		intel_de_rmw(dev_priv, ICL_PORT_TX_DW5_AUX(phy), 0, TX_TRAINING_EN);
+		intel_de_write(display, ICL_PORT_TX_DW5_GRP(phy), tmp);
+		intel_de_rmw(display, ICL_PORT_TX_DW5_AUX(phy), 0, TX_TRAINING_EN);
 	}
 }
 
 static void gen11_dsi_enable_ddi_buffer(struct intel_encoder *encoder)
 {
-	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
+	struct intel_display *display = to_intel_display(encoder);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	enum port port;
 
 	for_each_dsi_port(port, intel_dsi->ports) {
-		intel_de_rmw(dev_priv, DDI_BUF_CTL(port), 0, DDI_BUF_CTL_ENABLE);
+		intel_de_rmw(display, DDI_BUF_CTL(port), 0, DDI_BUF_CTL_ENABLE);
 
-		if (wait_for_us(!(intel_de_read(dev_priv, DDI_BUF_CTL(port)) &
+		if (wait_for_us(!(intel_de_read(display, DDI_BUF_CTL(port)) &
 				  DDI_BUF_IS_IDLE),
 				  500))
-			drm_err(&dev_priv->drm, "DDI port:%c buffer idle\n",
+			drm_err(display->drm, "DDI port:%c buffer idle\n",
 				port_name(port));
 	}
 }
@@ -525,6 +530,7 @@ static void
 gen11_dsi_setup_dphy_timings(struct intel_encoder *encoder,
 			     const struct intel_crtc_state *crtc_state)
 {
+	struct intel_display *display = to_intel_display(encoder);
 	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	enum port port;
@@ -532,12 +538,12 @@ gen11_dsi_setup_dphy_timings(struct intel_encoder *encoder,
 
 	/* Program DPHY clock lanes timings */
 	for_each_dsi_port(port, intel_dsi->ports)
-		intel_de_write(dev_priv, DPHY_CLK_TIMING_PARAM(port),
+		intel_de_write(display, DPHY_CLK_TIMING_PARAM(port),
 			       intel_dsi->dphy_reg);
 
 	/* Program DPHY data lanes timings */
 	for_each_dsi_port(port, intel_dsi->ports)
-		intel_de_write(dev_priv, DPHY_DATA_TIMING_PARAM(port),
+		intel_de_write(display, DPHY_DATA_TIMING_PARAM(port),
 			       intel_dsi->dphy_data_lane_reg);
 
 	/*
@@ -546,10 +552,10 @@ gen11_dsi_setup_dphy_timings(struct intel_encoder *encoder,
 	 * a value '0' inside TA_PARAM_REGISTERS otherwise
 	 * leave all fields at HW default values.
 	 */
-	if (DISPLAY_VER(dev_priv) == 11) {
+	if (DISPLAY_VER(display) == 11) {
 		if (afe_clk(encoder, crtc_state) <= 800000) {
 			for_each_dsi_port(port, intel_dsi->ports)
-				intel_de_rmw(dev_priv, DPHY_TA_TIMING_PARAM(port),
+				intel_de_rmw(display, DPHY_TA_TIMING_PARAM(port),
 					     TA_SURE_MASK,
 					     TA_SURE_OVERRIDE | TA_SURE(0));
 		}
@@ -557,7 +563,7 @@ gen11_dsi_setup_dphy_timings(struct intel_encoder *encoder,
 
 	if (IS_JASPERLAKE(dev_priv) || IS_ELKHARTLAKE(dev_priv)) {
 		for_each_dsi_phy(phy, intel_dsi->phys)
-			intel_de_rmw(dev_priv, ICL_DPHY_CHKN(phy),
+			intel_de_rmw(display, ICL_DPHY_CHKN(phy),
 				     0, ICL_DPHY_CHKN_AFE_OVER_PPI_STRAP);
 	}
 }
@@ -566,30 +572,30 @@ static void
 gen11_dsi_setup_timings(struct intel_encoder *encoder,
 			const struct intel_crtc_state *crtc_state)
 {
-	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
+	struct intel_display *display = to_intel_display(encoder);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	enum port port;
 
 	/* Program T-INIT master registers */
 	for_each_dsi_port(port, intel_dsi->ports)
-		intel_de_rmw(dev_priv, ICL_DSI_T_INIT_MASTER(port),
+		intel_de_rmw(display, ICL_DSI_T_INIT_MASTER(port),
 			     DSI_T_INIT_MASTER_MASK, intel_dsi->init_count);
 
 	/* shadow register inside display core */
 	for_each_dsi_port(port, intel_dsi->ports)
-		intel_de_write(dev_priv, DSI_CLK_TIMING_PARAM(port),
+		intel_de_write(display, DSI_CLK_TIMING_PARAM(port),
 			       intel_dsi->dphy_reg);
 
 	/* shadow register inside display core */
 	for_each_dsi_port(port, intel_dsi->ports)
-		intel_de_write(dev_priv, DSI_DATA_TIMING_PARAM(port),
+		intel_de_write(display, DSI_DATA_TIMING_PARAM(port),
 			       intel_dsi->dphy_data_lane_reg);
 
 	/* shadow register inside display core */
-	if (DISPLAY_VER(dev_priv) == 11) {
+	if (DISPLAY_VER(display) == 11) {
 		if (afe_clk(encoder, crtc_state) <= 800000) {
 			for_each_dsi_port(port, intel_dsi->ports) {
-				intel_de_rmw(dev_priv, DSI_TA_TIMING_PARAM(port),
+				intel_de_rmw(display, DSI_TA_TIMING_PARAM(port),
 					     TA_SURE_MASK,
 					     TA_SURE_OVERRIDE | TA_SURE(0));
 			}
@@ -599,45 +605,45 @@ gen11_dsi_setup_timings(struct intel_encoder *encoder,
 
 static void gen11_dsi_gate_clocks(struct intel_encoder *encoder)
 {
-	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
+	struct intel_display *display = to_intel_display(encoder);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	u32 tmp;
 	enum phy phy;
 
-	mutex_lock(&dev_priv->display.dpll.lock);
-	tmp = intel_de_read(dev_priv, ICL_DPCLKA_CFGCR0);
+	mutex_lock(&display->dpll.lock);
+	tmp = intel_de_read(display, ICL_DPCLKA_CFGCR0);
 	for_each_dsi_phy(phy, intel_dsi->phys)
 		tmp |= ICL_DPCLKA_CFGCR0_DDI_CLK_OFF(phy);
 
-	intel_de_write(dev_priv, ICL_DPCLKA_CFGCR0, tmp);
-	mutex_unlock(&dev_priv->display.dpll.lock);
+	intel_de_write(display, ICL_DPCLKA_CFGCR0, tmp);
+	mutex_unlock(&display->dpll.lock);
 }
 
 static void gen11_dsi_ungate_clocks(struct intel_encoder *encoder)
 {
-	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
+	struct intel_display *display = to_intel_display(encoder);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	u32 tmp;
 	enum phy phy;
 
-	mutex_lock(&dev_priv->display.dpll.lock);
-	tmp = intel_de_read(dev_priv, ICL_DPCLKA_CFGCR0);
+	mutex_lock(&display->dpll.lock);
+	tmp = intel_de_read(display, ICL_DPCLKA_CFGCR0);
 	for_each_dsi_phy(phy, intel_dsi->phys)
 		tmp &= ~ICL_DPCLKA_CFGCR0_DDI_CLK_OFF(phy);
 
-	intel_de_write(dev_priv, ICL_DPCLKA_CFGCR0, tmp);
-	mutex_unlock(&dev_priv->display.dpll.lock);
+	intel_de_write(display, ICL_DPCLKA_CFGCR0, tmp);
+	mutex_unlock(&display->dpll.lock);
 }
 
 static bool gen11_dsi_is_clock_enabled(struct intel_encoder *encoder)
 {
-	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
+	struct intel_display *display = to_intel_display(encoder);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	bool clock_enabled = false;
 	enum phy phy;
 	u32 tmp;
 
-	tmp = intel_de_read(dev_priv, ICL_DPCLKA_CFGCR0);
+	tmp = intel_de_read(display, ICL_DPCLKA_CFGCR0);
 
 	for_each_dsi_phy(phy, intel_dsi->phys) {
 		if (!(tmp & ICL_DPCLKA_CFGCR0_DDI_CLK_OFF(phy)))
@@ -650,36 +656,36 @@ static bool gen11_dsi_is_clock_enabled(struct intel_encoder *encoder)
 static void gen11_dsi_map_pll(struct intel_encoder *encoder,
 			      const struct intel_crtc_state *crtc_state)
 {
-	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
+	struct intel_display *display = to_intel_display(encoder);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	struct intel_shared_dpll *pll = crtc_state->shared_dpll;
 	enum phy phy;
 	u32 val;
 
-	mutex_lock(&dev_priv->display.dpll.lock);
+	mutex_lock(&display->dpll.lock);
 
-	val = intel_de_read(dev_priv, ICL_DPCLKA_CFGCR0);
+	val = intel_de_read(display, ICL_DPCLKA_CFGCR0);
 	for_each_dsi_phy(phy, intel_dsi->phys) {
 		val &= ~ICL_DPCLKA_CFGCR0_DDI_CLK_SEL_MASK(phy);
 		val |= ICL_DPCLKA_CFGCR0_DDI_CLK_SEL(pll->info->id, phy);
 	}
-	intel_de_write(dev_priv, ICL_DPCLKA_CFGCR0, val);
+	intel_de_write(display, ICL_DPCLKA_CFGCR0, val);
 
 	for_each_dsi_phy(phy, intel_dsi->phys) {
 		val &= ~ICL_DPCLKA_CFGCR0_DDI_CLK_OFF(phy);
 	}
-	intel_de_write(dev_priv, ICL_DPCLKA_CFGCR0, val);
+	intel_de_write(display, ICL_DPCLKA_CFGCR0, val);
 
-	intel_de_posting_read(dev_priv, ICL_DPCLKA_CFGCR0);
+	intel_de_posting_read(display, ICL_DPCLKA_CFGCR0);
 
-	mutex_unlock(&dev_priv->display.dpll.lock);
+	mutex_unlock(&display->dpll.lock);
 }
 
 static void
 gen11_dsi_configure_transcoder(struct intel_encoder *encoder,
 			       const struct intel_crtc_state *pipe_config)
 {
-	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
+	struct intel_display *display = to_intel_display(encoder);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	struct intel_crtc *crtc = to_intel_crtc(pipe_config->uapi.crtc);
 	enum pipe pipe = crtc->pipe;
@@ -689,7 +695,7 @@ gen11_dsi_configure_transcoder(struct intel_encoder *encoder,
 
 	for_each_dsi_port(port, intel_dsi->ports) {
 		dsi_trans = dsi_port_to_transcoder(port);
-		tmp = intel_de_read(dev_priv, DSI_TRANS_FUNC_CONF(dsi_trans));
+		tmp = intel_de_read(display, DSI_TRANS_FUNC_CONF(dsi_trans));
 
 		if (intel_dsi->eotp_pkt)
 			tmp &= ~EOTP_DISABLED;
@@ -745,7 +751,7 @@ gen11_dsi_configure_transcoder(struct intel_encoder *encoder,
 			}
 		}
 
-		if (DISPLAY_VER(dev_priv) >= 12) {
+		if (DISPLAY_VER(display) >= 12) {
 			if (is_vid_mode(intel_dsi))
 				tmp |= BLANKING_PACKET_ENABLE;
 		}
@@ -778,15 +784,15 @@ gen11_dsi_configure_transcoder(struct intel_encoder *encoder,
 			tmp |= TE_SOURCE_GPIO;
 		}
 
-		intel_de_write(dev_priv, DSI_TRANS_FUNC_CONF(dsi_trans), tmp);
+		intel_de_write(display, DSI_TRANS_FUNC_CONF(dsi_trans), tmp);
 	}
 
 	/* enable port sync mode if dual link */
 	if (intel_dsi->dual_link) {
 		for_each_dsi_port(port, intel_dsi->ports) {
 			dsi_trans = dsi_port_to_transcoder(port);
-			intel_de_rmw(dev_priv,
-				     TRANS_DDI_FUNC_CTL2(dev_priv, dsi_trans),
+			intel_de_rmw(display,
+				     TRANS_DDI_FUNC_CTL2(display, dsi_trans),
 				     0, PORT_SYNC_MODE_ENABLE);
 		}
 
@@ -798,10 +804,10 @@ gen11_dsi_configure_transcoder(struct intel_encoder *encoder,
 		dsi_trans = dsi_port_to_transcoder(port);
 
 		/* select data lane width */
-		tmp = intel_de_read(dev_priv,
-				    TRANS_DDI_FUNC_CTL(dev_priv, dsi_trans));
-		tmp &= ~DDI_PORT_WIDTH_MASK;
-		tmp |= DDI_PORT_WIDTH(intel_dsi->lane_count);
+		tmp = intel_de_read(display,
+				    TRANS_DDI_FUNC_CTL(display, dsi_trans));
+		tmp &= ~TRANS_DDI_PORT_WIDTH_MASK;
+		tmp |= TRANS_DDI_PORT_WIDTH(intel_dsi->lane_count);
 
 		/* select input pipe */
 		tmp &= ~TRANS_DDI_EDP_INPUT_MASK;
@@ -825,16 +831,16 @@ gen11_dsi_configure_transcoder(struct intel_encoder *encoder,
 
 		/* enable DDI buffer */
 		tmp |= TRANS_DDI_FUNC_ENABLE;
-		intel_de_write(dev_priv,
-			       TRANS_DDI_FUNC_CTL(dev_priv, dsi_trans), tmp);
+		intel_de_write(display,
+			       TRANS_DDI_FUNC_CTL(display, dsi_trans), tmp);
 	}
 
 	/* wait for link ready */
 	for_each_dsi_port(port, intel_dsi->ports) {
 		dsi_trans = dsi_port_to_transcoder(port);
-		if (wait_for_us((intel_de_read(dev_priv, DSI_TRANS_FUNC_CONF(dsi_trans)) &
+		if (wait_for_us((intel_de_read(display, DSI_TRANS_FUNC_CONF(dsi_trans)) &
 				 LINK_READY), 2500))
-			drm_err(&dev_priv->drm, "DSI link not ready\n");
+			drm_err(display->drm, "DSI link not ready\n");
 	}
 }
 
@@ -842,7 +848,7 @@ static void
 gen11_dsi_set_transcoder_timings(struct intel_encoder *encoder,
 				 const struct intel_crtc_state *crtc_state)
 {
-	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
+	struct intel_display *display = to_intel_display(encoder);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	const struct drm_display_mode *adjusted_mode =
 		&crtc_state->hw.adjusted_mode;
@@ -909,17 +915,17 @@ gen11_dsi_set_transcoder_timings(struct intel_encoder *encoder,
 
 	/* minimum hactive as per bspec: 256 pixels */
 	if (adjusted_mode->crtc_hdisplay < 256)
-		drm_err(&dev_priv->drm, "hactive is less then 256 pixels\n");
+		drm_err(display->drm, "hactive is less then 256 pixels\n");
 
 	/* if RGB666 format, then hactive must be multiple of 4 pixels */
 	if (intel_dsi->pixel_format == MIPI_DSI_FMT_RGB666 && hactive % 4 != 0)
-		drm_err(&dev_priv->drm,
+		drm_err(display->drm,
 			"hactive pixels are not multiple of 4\n");
 
 	/* program TRANS_HTOTAL register */
 	for_each_dsi_port(port, intel_dsi->ports) {
 		dsi_trans = dsi_port_to_transcoder(port);
-		intel_de_write(dev_priv, TRANS_HTOTAL(dev_priv, dsi_trans),
+		intel_de_write(display, TRANS_HTOTAL(display, dsi_trans),
 			       HACTIVE(hactive - 1) | HTOTAL(htotal - 1));
 	}
 
@@ -928,12 +934,12 @@ gen11_dsi_set_transcoder_timings(struct intel_encoder *encoder,
 		if (intel_dsi->video_mode == NON_BURST_SYNC_PULSE) {
 			/* BSPEC: hsync size should be atleast 16 pixels */
 			if (hsync_size < 16)
-				drm_err(&dev_priv->drm,
+				drm_err(display->drm,
 					"hsync size < 16 pixels\n");
 		}
 
 		if (hback_porch < 16)
-			drm_err(&dev_priv->drm, "hback porch < 16 pixels\n");
+			drm_err(display->drm, "hback porch < 16 pixels\n");
 
 		if (intel_dsi->dual_link) {
 			hsync_start /= 2;
@@ -942,8 +948,8 @@ gen11_dsi_set_transcoder_timings(struct intel_encoder *encoder,
 
 		for_each_dsi_port(port, intel_dsi->ports) {
 			dsi_trans = dsi_port_to_transcoder(port);
-			intel_de_write(dev_priv,
-				       TRANS_HSYNC(dev_priv, dsi_trans),
+			intel_de_write(display,
+				       TRANS_HSYNC(display, dsi_trans),
 				       HSYNC_START(hsync_start - 1) | HSYNC_END(hsync_end - 1));
 		}
 	}
@@ -957,22 +963,22 @@ gen11_dsi_set_transcoder_timings(struct intel_encoder *encoder,
 		 * struct drm_display_mode.
 		 * For interlace mode: program required pixel minus 2
 		 */
-		intel_de_write(dev_priv, TRANS_VTOTAL(dev_priv, dsi_trans),
+		intel_de_write(display, TRANS_VTOTAL(display, dsi_trans),
 			       VACTIVE(vactive - 1) | VTOTAL(vtotal - 1));
 	}
 
 	if (vsync_end < vsync_start || vsync_end > vtotal)
-		drm_err(&dev_priv->drm, "Invalid vsync_end value\n");
+		drm_err(display->drm, "Invalid vsync_end value\n");
 
 	if (vsync_start < vactive)
-		drm_err(&dev_priv->drm, "vsync_start less than vactive\n");
+		drm_err(display->drm, "vsync_start less than vactive\n");
 
 	/* program TRANS_VSYNC register for video mode only */
 	if (is_vid_mode(intel_dsi)) {
 		for_each_dsi_port(port, intel_dsi->ports) {
 			dsi_trans = dsi_port_to_transcoder(port);
-			intel_de_write(dev_priv,
-				       TRANS_VSYNC(dev_priv, dsi_trans),
+			intel_de_write(display,
+				       TRANS_VSYNC(display, dsi_trans),
 				       VSYNC_START(vsync_start - 1) | VSYNC_END(vsync_end - 1));
 		}
 	}
@@ -986,8 +992,8 @@ gen11_dsi_set_transcoder_timings(struct intel_encoder *encoder,
 	if (is_vid_mode(intel_dsi)) {
 		for_each_dsi_port(port, intel_dsi->ports) {
 			dsi_trans = dsi_port_to_transcoder(port);
-			intel_de_write(dev_priv,
-				       TRANS_VSYNCSHIFT(dev_priv, dsi_trans),
+			intel_de_write(display,
+				       TRANS_VSYNCSHIFT(display, dsi_trans),
 				       vsync_shift);
 		}
 	}
@@ -998,11 +1004,11 @@ gen11_dsi_set_transcoder_timings(struct intel_encoder *encoder,
 	 * FIXME get rid of these local hacks and do it right,
 	 * this will not handle eg. delayed vblank correctly.
 	 */
-	if (DISPLAY_VER(dev_priv) >= 12) {
+	if (DISPLAY_VER(display) >= 12) {
 		for_each_dsi_port(port, intel_dsi->ports) {
 			dsi_trans = dsi_port_to_transcoder(port);
-			intel_de_write(dev_priv,
-				       TRANS_VBLANK(dev_priv, dsi_trans),
+			intel_de_write(display,
+				       TRANS_VBLANK(display, dsi_trans),
 				       VBLANK_START(vactive - 1) | VBLANK_END(vtotal - 1));
 		}
 	}
@@ -1010,20 +1016,20 @@ gen11_dsi_set_transcoder_timings(struct intel_encoder *encoder,
 
 static void gen11_dsi_enable_transcoder(struct intel_encoder *encoder)
 {
-	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
+	struct intel_display *display = to_intel_display(encoder);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	enum port port;
 	enum transcoder dsi_trans;
 
 	for_each_dsi_port(port, intel_dsi->ports) {
 		dsi_trans = dsi_port_to_transcoder(port);
-		intel_de_rmw(dev_priv, TRANSCONF(dev_priv, dsi_trans), 0,
+		intel_de_rmw(display, TRANSCONF(display, dsi_trans), 0,
 			     TRANSCONF_ENABLE);
 
 		/* wait for transcoder to be enabled */
-		if (intel_de_wait_for_set(dev_priv, TRANSCONF(dev_priv, dsi_trans),
+		if (intel_de_wait_for_set(display, TRANSCONF(display, dsi_trans),
 					  TRANSCONF_STATE_ENABLE, 10))
-			drm_err(&dev_priv->drm,
+			drm_err(display->drm,
 				"DSI transcoder not enabled\n");
 	}
 }
@@ -1031,7 +1037,7 @@ static void gen11_dsi_enable_transcoder(struct intel_encoder *encoder)
 static void gen11_dsi_setup_timeouts(struct intel_encoder *encoder,
 				     const struct intel_crtc_state *crtc_state)
 {
-	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
+	struct intel_display *display = to_intel_display(encoder);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	enum port port;
 	enum transcoder dsi_trans;
@@ -1055,21 +1061,21 @@ static void gen11_dsi_setup_timeouts(struct intel_encoder *encoder,
 		dsi_trans = dsi_port_to_transcoder(port);
 
 		/* program hst_tx_timeout */
-		intel_de_rmw(dev_priv, DSI_HSTX_TO(dsi_trans),
+		intel_de_rmw(display, DSI_HSTX_TO(dsi_trans),
 			     HSTX_TIMEOUT_VALUE_MASK,
 			     HSTX_TIMEOUT_VALUE(hs_tx_timeout));
 
 		/* FIXME: DSI_CALIB_TO */
 
 		/* program lp_rx_host timeout */
-		intel_de_rmw(dev_priv, DSI_LPRX_HOST_TO(dsi_trans),
+		intel_de_rmw(display, DSI_LPRX_HOST_TO(dsi_trans),
 			     LPRX_TIMEOUT_VALUE_MASK,
 			     LPRX_TIMEOUT_VALUE(lp_rx_timeout));
 
 		/* FIXME: DSI_PWAIT_TO */
 
 		/* program turn around timeout */
-		intel_de_rmw(dev_priv, DSI_TA_TO(dsi_trans),
+		intel_de_rmw(display, DSI_TA_TO(dsi_trans),
 			     TA_TIMEOUT_VALUE_MASK,
 			     TA_TIMEOUT_VALUE(ta_timeout));
 	}
@@ -1078,7 +1084,7 @@ static void gen11_dsi_setup_timeouts(struct intel_encoder *encoder,
 static void gen11_dsi_config_util_pin(struct intel_encoder *encoder,
 				      bool enable)
 {
-	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
+	struct intel_display *display = to_intel_display(encoder);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	u32 tmp;
 
@@ -1090,7 +1096,7 @@ static void gen11_dsi_config_util_pin(struct intel_encoder *encoder,
 	if (is_vid_mode(intel_dsi) || (intel_dsi->ports & BIT(PORT_B)))
 		return;
 
-	tmp = intel_de_read(dev_priv, UTIL_PIN_CTL);
+	tmp = intel_de_read(display, UTIL_PIN_CTL);
 
 	if (enable) {
 		tmp |= UTIL_PIN_DIRECTION_INPUT;
@@ -1098,7 +1104,7 @@ static void gen11_dsi_config_util_pin(struct intel_encoder *encoder,
 	} else {
 		tmp &= ~UTIL_PIN_ENABLE;
 	}
-	intel_de_write(dev_priv, UTIL_PIN_CTL, tmp);
+	intel_de_write(display, UTIL_PIN_CTL, tmp);
 }
 
 static void
@@ -1136,7 +1142,7 @@ gen11_dsi_enable_port_and_phy(struct intel_encoder *encoder,
 
 static void gen11_dsi_powerup_panel(struct intel_encoder *encoder)
 {
-	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
+	struct intel_display *display = to_intel_display(encoder);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	struct mipi_dsi_device *dsi;
 	enum port port;
@@ -1152,14 +1158,14 @@ static void gen11_dsi_powerup_panel(struct intel_encoder *encoder)
 		 * FIXME: This uses the number of DW's currently in the payload
 		 * receive queue. This is probably not what we want here.
 		 */
-		tmp = intel_de_read(dev_priv, DSI_CMD_RXCTL(dsi_trans));
+		tmp = intel_de_read(display, DSI_CMD_RXCTL(dsi_trans));
 		tmp &= NUMBER_RX_PLOAD_DW_MASK;
 		/* multiply "Number Rx Payload DW" by 4 to get max value */
 		tmp = tmp * 4;
 		dsi = intel_dsi->dsi_hosts[port]->device;
 		ret = mipi_dsi_set_maximum_return_packet_size(dsi, tmp);
 		if (ret < 0)
-			drm_err(&dev_priv->drm,
+			drm_err(display->drm,
 				"error setting max return pkt size%d\n", tmp);
 	}
 
@@ -1219,10 +1225,10 @@ static void gen11_dsi_pre_enable(struct intel_atomic_state *state,
 static void icl_apply_kvmr_pipe_a_wa(struct intel_encoder *encoder,
 				     enum pipe pipe, bool enable)
 {
-	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
+	struct intel_display *display = to_intel_display(encoder);
 
-	if (DISPLAY_VER(dev_priv) == 11 && pipe == PIPE_B)
-		intel_de_rmw(dev_priv, CHICKEN_PAR1_1,
+	if (DISPLAY_VER(display) == 11 && pipe == PIPE_B)
+		intel_de_rmw(display, CHICKEN_PAR1_1,
 			     IGNORE_KVMR_PIPE_A,
 			     enable ? IGNORE_KVMR_PIPE_A : 0);
 }
@@ -1235,13 +1241,13 @@ static void icl_apply_kvmr_pipe_a_wa(struct intel_encoder *encoder,
  */
 static void adlp_set_lp_hs_wakeup_gb(struct intel_encoder *encoder)
 {
-	struct drm_i915_private *i915 = to_i915(encoder->base.dev);
+	struct intel_display *display = to_intel_display(encoder);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	enum port port;
 
-	if (DISPLAY_VER(i915) == 13) {
+	if (DISPLAY_VER(display) == 13) {
 		for_each_dsi_port(port, intel_dsi->ports)
-			intel_de_rmw(i915, TGL_DSI_CHKN_REG(port),
+			intel_de_rmw(display, TGL_DSI_CHKN_REG(port),
 				     TGL_DSI_CHKN_LSHS_GB_MASK,
 				     TGL_DSI_CHKN_LSHS_GB(4));
 	}
@@ -1275,7 +1281,7 @@ static void gen11_dsi_enable(struct intel_atomic_state *state,
 
 static void gen11_dsi_disable_transcoder(struct intel_encoder *encoder)
 {
-	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
+	struct intel_display *display = to_intel_display(encoder);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	enum port port;
 	enum transcoder dsi_trans;
@@ -1284,13 +1290,13 @@ static void gen11_dsi_disable_transcoder(struct intel_encoder *encoder)
 		dsi_trans = dsi_port_to_transcoder(port);
 
 		/* disable transcoder */
-		intel_de_rmw(dev_priv, TRANSCONF(dev_priv, dsi_trans),
+		intel_de_rmw(display, TRANSCONF(display, dsi_trans),
 			     TRANSCONF_ENABLE, 0);
 
 		/* wait for transcoder to be disabled */
-		if (intel_de_wait_for_clear(dev_priv, TRANSCONF(dev_priv, dsi_trans),
+		if (intel_de_wait_for_clear(display, TRANSCONF(display, dsi_trans),
 					    TRANSCONF_STATE_ENABLE, 50))
-			drm_err(&dev_priv->drm,
+			drm_err(display->drm,
 				"DSI trancoder not disabled\n");
 	}
 }
@@ -1307,7 +1313,7 @@ static void gen11_dsi_powerdown_panel(struct intel_encoder *encoder)
 
 static void gen11_dsi_deconfigure_trancoder(struct intel_encoder *encoder)
 {
-	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
+	struct intel_display *display = to_intel_display(encoder);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	enum port port;
 	enum transcoder dsi_trans;
@@ -1316,29 +1322,29 @@ static void gen11_dsi_deconfigure_trancoder(struct intel_encoder *encoder)
 	/* disable periodic update mode */
 	if (is_cmd_mode(intel_dsi)) {
 		for_each_dsi_port(port, intel_dsi->ports)
-			intel_de_rmw(dev_priv, DSI_CMD_FRMCTL(port),
+			intel_de_rmw(display, DSI_CMD_FRMCTL(port),
 				     DSI_PERIODIC_FRAME_UPDATE_ENABLE, 0);
 	}
 
 	/* put dsi link in ULPS */
 	for_each_dsi_port(port, intel_dsi->ports) {
 		dsi_trans = dsi_port_to_transcoder(port);
-		tmp = intel_de_read(dev_priv, DSI_LP_MSG(dsi_trans));
+		tmp = intel_de_read(display, DSI_LP_MSG(dsi_trans));
 		tmp |= LINK_ENTER_ULPS;
 		tmp &= ~LINK_ULPS_TYPE_LP11;
-		intel_de_write(dev_priv, DSI_LP_MSG(dsi_trans), tmp);
+		intel_de_write(display, DSI_LP_MSG(dsi_trans), tmp);
 
-		if (wait_for_us((intel_de_read(dev_priv, DSI_LP_MSG(dsi_trans)) &
+		if (wait_for_us((intel_de_read(display, DSI_LP_MSG(dsi_trans)) &
 				 LINK_IN_ULPS),
 				10))
-			drm_err(&dev_priv->drm, "DSI link not in ULPS\n");
+			drm_err(display->drm, "DSI link not in ULPS\n");
 	}
 
 	/* disable ddi function */
 	for_each_dsi_port(port, intel_dsi->ports) {
 		dsi_trans = dsi_port_to_transcoder(port);
-		intel_de_rmw(dev_priv,
-			     TRANS_DDI_FUNC_CTL(dev_priv, dsi_trans),
+		intel_de_rmw(display,
+			     TRANS_DDI_FUNC_CTL(display, dsi_trans),
 			     TRANS_DDI_FUNC_ENABLE, 0);
 	}
 
@@ -1346,8 +1352,8 @@ static void gen11_dsi_deconfigure_trancoder(struct intel_encoder *encoder)
 	if (intel_dsi->dual_link) {
 		for_each_dsi_port(port, intel_dsi->ports) {
 			dsi_trans = dsi_port_to_transcoder(port);
-			intel_de_rmw(dev_priv,
-				     TRANS_DDI_FUNC_CTL2(dev_priv, dsi_trans),
+			intel_de_rmw(display,
+				     TRANS_DDI_FUNC_CTL2(display, dsi_trans),
 				     PORT_SYNC_MODE_ENABLE, 0);
 		}
 	}
@@ -1355,18 +1361,18 @@ static void gen11_dsi_deconfigure_trancoder(struct intel_encoder *encoder)
 
 static void gen11_dsi_disable_port(struct intel_encoder *encoder)
 {
-	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
+	struct intel_display *display = to_intel_display(encoder);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	enum port port;
 
 	gen11_dsi_ungate_clocks(encoder);
 	for_each_dsi_port(port, intel_dsi->ports) {
-		intel_de_rmw(dev_priv, DDI_BUF_CTL(port), DDI_BUF_CTL_ENABLE, 0);
+		intel_de_rmw(display, DDI_BUF_CTL(port), DDI_BUF_CTL_ENABLE, 0);
 
-		if (wait_for_us((intel_de_read(dev_priv, DDI_BUF_CTL(port)) &
+		if (wait_for_us((intel_de_read(display, DDI_BUF_CTL(port)) &
 				 DDI_BUF_IS_IDLE),
 				 8))
-			drm_err(&dev_priv->drm,
+			drm_err(display->drm,
 				"DDI port:%c buffer not idle\n",
 				port_name(port));
 	}
@@ -1375,6 +1381,7 @@ static void gen11_dsi_disable_port(struct intel_encoder *encoder)
 
 static void gen11_dsi_disable_io_power(struct intel_encoder *encoder)
 {
+	struct intel_display *display = to_intel_display(encoder);
 	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	enum port port;
@@ -1392,7 +1399,7 @@ static void gen11_dsi_disable_io_power(struct intel_encoder *encoder)
 
 	/* set mode to DDI */
 	for_each_dsi_port(port, intel_dsi->ports)
-		intel_de_rmw(dev_priv, ICL_DSI_IO_MODECTL(port),
+		intel_de_rmw(display, ICL_DSI_IO_MODECTL(port),
 			     COMBO_PHY_MODE_DSI, 0);
 }
 
@@ -1504,8 +1511,7 @@ static void gen11_dsi_get_timings(struct intel_encoder *encoder,
 
 static bool gen11_dsi_is_periodic_cmd_mode(struct intel_dsi *intel_dsi)
 {
-	struct drm_device *dev = intel_dsi->base.base.dev;
-	struct drm_i915_private *dev_priv = to_i915(dev);
+	struct intel_display *display = to_intel_display(&intel_dsi->base);
 	enum transcoder dsi_trans;
 	u32 val;
 
@@ -1514,7 +1520,7 @@ static bool gen11_dsi_is_periodic_cmd_mode(struct intel_dsi *intel_dsi)
 	else
 		dsi_trans = TRANSCODER_DSI_0;
 
-	val = intel_de_read(dev_priv, DSI_TRANS_FUNC_CONF(dsi_trans));
+	val = intel_de_read(display, DSI_TRANS_FUNC_CONF(dsi_trans));
 	return (val & DSI_PERIODIC_FRAME_UPDATE_ENABLE);
 }
 
@@ -1557,7 +1563,7 @@ static void gen11_dsi_get_config(struct intel_encoder *encoder,
 static void gen11_dsi_sync_state(struct intel_encoder *encoder,
 				 const struct intel_crtc_state *crtc_state)
 {
-	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
+	struct intel_display *display = to_intel_display(encoder);
 	struct intel_crtc *intel_crtc;
 	enum pipe pipe;
 
@@ -1568,9 +1574,9 @@ static void gen11_dsi_sync_state(struct intel_encoder *encoder,
 	pipe = intel_crtc->pipe;
 
 	/* wa verify 1409054076:icl,jsl,ehl */
-	if (DISPLAY_VER(dev_priv) == 11 && pipe == PIPE_B &&
-	    !(intel_de_read(dev_priv, CHICKEN_PAR1_1) & IGNORE_KVMR_PIPE_A))
-		drm_dbg_kms(&dev_priv->drm,
+	if (DISPLAY_VER(display) == 11 && pipe == PIPE_B &&
+	    !(intel_de_read(display, CHICKEN_PAR1_1) & IGNORE_KVMR_PIPE_A))
+		drm_dbg_kms(display->drm,
 			    "[ENCODER:%d:%s] BIOS left IGNORE_KVMR_PIPE_A cleared with pipe B enabled\n",
 			    encoder->base.base.id,
 			    encoder->base.name);
@@ -1579,9 +1585,9 @@ static void gen11_dsi_sync_state(struct intel_encoder *encoder,
 static int gen11_dsi_dsc_compute_config(struct intel_encoder *encoder,
 					struct intel_crtc_state *crtc_state)
 {
-	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
+	struct intel_display *display = to_intel_display(encoder);
 	struct drm_dsc_config *vdsc_cfg = &crtc_state->dsc.config;
-	int dsc_max_bpc = DISPLAY_VER(dev_priv) >= 12 ? 12 : 10;
+	int dsc_max_bpc = DISPLAY_VER(display) >= 12 ? 12 : 10;
 	bool use_dsc;
 	int ret;
 
@@ -1606,12 +1612,12 @@ static int gen11_dsi_dsc_compute_config(struct intel_encoder *encoder,
 		return ret;
 
 	/* DSI specific sanity checks on the common code */
-	drm_WARN_ON(&dev_priv->drm, vdsc_cfg->vbr_enable);
-	drm_WARN_ON(&dev_priv->drm, vdsc_cfg->simple_422);
-	drm_WARN_ON(&dev_priv->drm,
+	drm_WARN_ON(display->drm, vdsc_cfg->vbr_enable);
+	drm_WARN_ON(display->drm, vdsc_cfg->simple_422);
+	drm_WARN_ON(display->drm,
 		    vdsc_cfg->pic_width % vdsc_cfg->slice_width);
-	drm_WARN_ON(&dev_priv->drm, vdsc_cfg->slice_height < 8);
-	drm_WARN_ON(&dev_priv->drm,
+	drm_WARN_ON(display->drm, vdsc_cfg->slice_height < 8);
+	drm_WARN_ON(display->drm,
 		    vdsc_cfg->pic_height % vdsc_cfg->slice_height);
 
 	ret = drm_dsc_compute_rc_parameters(vdsc_cfg);
@@ -1627,7 +1633,7 @@ static int gen11_dsi_compute_config(struct intel_encoder *encoder,
 				    struct intel_crtc_state *pipe_config,
 				    struct drm_connector_state *conn_state)
 {
-	struct drm_i915_private *i915 = to_i915(encoder->base.dev);
+	struct intel_display *display = to_intel_display(encoder);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	struct intel_connector *intel_connector = intel_dsi->attached_connector;
 	struct drm_display_mode *adjusted_mode =
@@ -1661,7 +1667,7 @@ static int gen11_dsi_compute_config(struct intel_encoder *encoder,
 	pipe_config->clock_set = true;
 
 	if (gen11_dsi_dsc_compute_config(encoder, pipe_config))
-		drm_dbg_kms(&i915->drm, "Attempting to use DSC failed\n");
+		drm_dbg_kms(display->drm, "Attempting to use DSC failed\n");
 
 	pipe_config->port_clock = afe_clk(encoder, pipe_config) / 5;
 
@@ -1679,15 +1685,13 @@ static int gen11_dsi_compute_config(struct intel_encoder *encoder,
 static void gen11_dsi_get_power_domains(struct intel_encoder *encoder,
 					struct intel_crtc_state *crtc_state)
 {
-	struct drm_i915_private *i915 = to_i915(encoder->base.dev);
-
-	get_dsi_io_power_domains(i915,
-				 enc_to_intel_dsi(encoder));
+	get_dsi_io_power_domains(enc_to_intel_dsi(encoder));
 }
 
 static bool gen11_dsi_get_hw_state(struct intel_encoder *encoder,
 				   enum pipe *pipe)
 {
+	struct intel_display *display = to_intel_display(encoder);
 	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	enum transcoder dsi_trans;
@@ -1703,8 +1707,8 @@ static bool gen11_dsi_get_hw_state(struct intel_encoder *encoder,
 
 	for_each_dsi_port(port, intel_dsi->ports) {
 		dsi_trans = dsi_port_to_transcoder(port);
-		tmp = intel_de_read(dev_priv,
-				    TRANS_DDI_FUNC_CTL(dev_priv, dsi_trans));
+		tmp = intel_de_read(display,
+				    TRANS_DDI_FUNC_CTL(display, dsi_trans));
 		switch (tmp & TRANS_DDI_EDP_INPUT_MASK) {
 		case TRANS_DDI_EDP_INPUT_A_ON:
 			*pipe = PIPE_A;
@@ -1719,11 +1723,11 @@ static bool gen11_dsi_get_hw_state(struct intel_encoder *encoder,
 			*pipe = PIPE_D;
 			break;
 		default:
-			drm_err(&dev_priv->drm, "Invalid PIPE input\n");
+			drm_err(display->drm, "Invalid PIPE input\n");
 			goto out;
 		}
 
-		tmp = intel_de_read(dev_priv, TRANSCONF(dev_priv, dsi_trans));
+		tmp = intel_de_read(display, TRANSCONF(display, dsi_trans));
 		ret = tmp & TRANSCONF_ENABLE;
 	}
 out:
@@ -1833,8 +1837,7 @@ static const struct mipi_dsi_host_ops gen11_dsi_host_ops = {
 
 static void icl_dphy_param_init(struct intel_dsi *intel_dsi)
 {
-	struct drm_device *dev = intel_dsi->base.base.dev;
-	struct drm_i915_private *dev_priv = to_i915(dev);
+	struct intel_display *display = to_intel_display(&intel_dsi->base);
 	struct intel_connector *connector = intel_dsi->attached_connector;
 	struct mipi_config *mipi_config = connector->panel.vbt.dsi.config;
 	u32 tlpx_ns;
@@ -1858,7 +1861,7 @@ static void icl_dphy_param_init(struct intel_dsi *intel_dsi)
 	 */
 	prepare_cnt = DIV_ROUND_UP(ths_prepare_ns * 4, tlpx_ns);
 	if (prepare_cnt > ICL_PREPARE_CNT_MAX) {
-		drm_dbg_kms(&dev_priv->drm, "prepare_cnt out of range (%d)\n",
+		drm_dbg_kms(display->drm, "prepare_cnt out of range (%d)\n",
 			    prepare_cnt);
 		prepare_cnt = ICL_PREPARE_CNT_MAX;
 	}
@@ -1867,7 +1870,7 @@ static void icl_dphy_param_init(struct intel_dsi *intel_dsi)
 	clk_zero_cnt = DIV_ROUND_UP(mipi_config->tclk_prepare_clkzero -
 				    ths_prepare_ns, tlpx_ns);
 	if (clk_zero_cnt > ICL_CLK_ZERO_CNT_MAX) {
-		drm_dbg_kms(&dev_priv->drm,
+		drm_dbg_kms(display->drm,
 			    "clk_zero_cnt out of range (%d)\n", clk_zero_cnt);
 		clk_zero_cnt = ICL_CLK_ZERO_CNT_MAX;
 	}
@@ -1875,7 +1878,7 @@ static void icl_dphy_param_init(struct intel_dsi *intel_dsi)
 	/* trail cnt in escape clocks*/
 	trail_cnt = DIV_ROUND_UP(tclk_trail_ns, tlpx_ns);
 	if (trail_cnt > ICL_TRAIL_CNT_MAX) {
-		drm_dbg_kms(&dev_priv->drm, "trail_cnt out of range (%d)\n",
+		drm_dbg_kms(display->drm, "trail_cnt out of range (%d)\n",
 			    trail_cnt);
 		trail_cnt = ICL_TRAIL_CNT_MAX;
 	}
@@ -1883,7 +1886,7 @@ static void icl_dphy_param_init(struct intel_dsi *intel_dsi)
 	/* tclk pre count in escape clocks */
 	tclk_pre_cnt = DIV_ROUND_UP(mipi_config->tclk_pre, tlpx_ns);
 	if (tclk_pre_cnt > ICL_TCLK_PRE_CNT_MAX) {
-		drm_dbg_kms(&dev_priv->drm,
+		drm_dbg_kms(display->drm,
 			    "tclk_pre_cnt out of range (%d)\n", tclk_pre_cnt);
 		tclk_pre_cnt = ICL_TCLK_PRE_CNT_MAX;
 	}
@@ -1892,7 +1895,7 @@ static void icl_dphy_param_init(struct intel_dsi *intel_dsi)
 	hs_zero_cnt = DIV_ROUND_UP(mipi_config->ths_prepare_hszero -
 				   ths_prepare_ns, tlpx_ns);
 	if (hs_zero_cnt > ICL_HS_ZERO_CNT_MAX) {
-		drm_dbg_kms(&dev_priv->drm, "hs_zero_cnt out of range (%d)\n",
+		drm_dbg_kms(display->drm, "hs_zero_cnt out of range (%d)\n",
 			    hs_zero_cnt);
 		hs_zero_cnt = ICL_HS_ZERO_CNT_MAX;
 	}
@@ -1900,7 +1903,7 @@ static void icl_dphy_param_init(struct intel_dsi *intel_dsi)
 	/* hs exit zero cnt in escape clocks */
 	exit_zero_cnt = DIV_ROUND_UP(mipi_config->ths_exit, tlpx_ns);
 	if (exit_zero_cnt > ICL_EXIT_ZERO_CNT_MAX) {
-		drm_dbg_kms(&dev_priv->drm,
+		drm_dbg_kms(display->drm,
 			    "exit_zero_cnt out of range (%d)\n",
 			    exit_zero_cnt);
 		exit_zero_cnt = ICL_EXIT_ZERO_CNT_MAX;
@@ -1942,10 +1945,9 @@ static void icl_dsi_add_properties(struct intel_connector *connector)
 						       fixed_mode->vdisplay);
 }
 
-void icl_dsi_init(struct drm_i915_private *dev_priv,
+void icl_dsi_init(struct intel_display *display,
 		  const struct intel_bios_encoder_data *devdata)
 {
-	struct intel_display *display = &dev_priv->display;
 	struct intel_dsi *intel_dsi;
 	struct intel_encoder *encoder;
 	struct intel_connector *intel_connector;
@@ -1973,7 +1975,8 @@ void icl_dsi_init(struct drm_i915_private *dev_priv,
 	encoder->devdata = devdata;
 
 	/* register DSI encoder with DRM subsystem */
-	drm_encoder_init(&dev_priv->drm, &encoder->base, &gen11_dsi_encoder_funcs,
+	drm_encoder_init(display->drm, &encoder->base,
+			 &gen11_dsi_encoder_funcs,
 			 DRM_MODE_ENCODER_DSI, "DSI %c", port_name(port));
 
 	encoder->pre_pll_enable = gen11_dsi_pre_pll_enable;
@@ -1998,7 +2001,8 @@ void icl_dsi_init(struct drm_i915_private *dev_priv,
 	encoder->shutdown = intel_dsi_shutdown;
 
 	/* register DSI connector with DRM subsystem */
-	drm_connector_init(&dev_priv->drm, connector, &gen11_dsi_connector_funcs,
+	drm_connector_init(display->drm, connector,
+			   &gen11_dsi_connector_funcs,
 			   DRM_MODE_CONNECTOR_DSI);
 	drm_connector_helper_add(connector, &gen11_dsi_connector_helper_funcs);
 	connector->display_info.subpixel_order = SubPixelHorizontalRGB;
@@ -2011,12 +2015,12 @@ void icl_dsi_init(struct drm_i915_private *dev_priv,
 
 	intel_bios_init_panel_late(display, &intel_connector->panel, encoder->devdata, NULL);
 
-	mutex_lock(&dev_priv->drm.mode_config.mutex);
+	mutex_lock(&display->drm->mode_config.mutex);
 	intel_panel_add_vbt_lfp_fixed_mode(intel_connector);
-	mutex_unlock(&dev_priv->drm.mode_config.mutex);
+	mutex_unlock(&display->drm->mode_config.mutex);
 
 	if (!intel_panel_preferred_fixed_mode(intel_connector)) {
-		drm_err(&dev_priv->drm, "DSI fixed mode info missing\n");
+		drm_err(display->drm, "DSI fixed mode info missing\n");
 		goto err;
 	}
 
@@ -2029,10 +2033,10 @@ void icl_dsi_init(struct drm_i915_private *dev_priv,
 	else
 		intel_dsi->ports = BIT(port);
 
-	if (drm_WARN_ON(&dev_priv->drm, intel_connector->panel.vbt.dsi.bl_ports & ~intel_dsi->ports))
+	if (drm_WARN_ON(display->drm, intel_connector->panel.vbt.dsi.bl_ports & ~intel_dsi->ports))
 		intel_connector->panel.vbt.dsi.bl_ports &= intel_dsi->ports;
 
-	if (drm_WARN_ON(&dev_priv->drm, intel_connector->panel.vbt.dsi.cabc_ports & ~intel_dsi->ports))
+	if (drm_WARN_ON(display->drm, intel_connector->panel.vbt.dsi.cabc_ports & ~intel_dsi->ports))
 		intel_connector->panel.vbt.dsi.cabc_ports &= intel_dsi->ports;
 
 	for_each_dsi_port(port, intel_dsi->ports) {
@@ -2046,7 +2050,7 @@ void icl_dsi_init(struct drm_i915_private *dev_priv,
 	}
 
 	if (!intel_dsi_vbt_init(intel_dsi, MIPI_DSI_GENERIC_PANEL_ID)) {
-		drm_dbg_kms(&dev_priv->drm, "no device found\n");
+		drm_dbg_kms(display->drm, "no device found\n");
 		goto err;
 	}
 
diff --git a/drivers/gpu/drm/i915/display/icl_dsi.h b/drivers/gpu/drm/i915/display/icl_dsi.h
index 43fa7d72eeb1..099fc50e35b4 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.h
+++ b/drivers/gpu/drm/i915/display/icl_dsi.h
@@ -6,11 +6,11 @@
 #ifndef __ICL_DSI_H__
 #define __ICL_DSI_H__
 
-struct drm_i915_private;
 struct intel_bios_encoder_data;
 struct intel_crtc_state;
+struct intel_display;
 
-void icl_dsi_init(struct drm_i915_private *dev_priv,
+void icl_dsi_init(struct intel_display *display,
 		  const struct intel_bios_encoder_data *devdata);
 void icl_dsi_frame_update(struct intel_crtc_state *crtc_state);
 
diff --git a/drivers/gpu/drm/i915/display/intel_atomic_plane.c b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
index e979786aa5cf..5c2a7987cccb 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
@@ -790,7 +790,8 @@ skl_next_plane_to_commit(struct intel_atomic_state *state,
 	return NULL;
 }
 
-void intel_plane_update_noarm(struct intel_plane *plane,
+void intel_plane_update_noarm(struct intel_dsb *dsb,
+			      struct intel_plane *plane,
 			      const struct intel_crtc_state *crtc_state,
 			      const struct intel_plane_state *plane_state)
 {
@@ -799,10 +800,11 @@ void intel_plane_update_noarm(struct intel_plane *plane,
 	trace_intel_plane_update_noarm(plane, crtc);
 
 	if (plane->update_noarm)
-		plane->update_noarm(plane, crtc_state, plane_state);
+		plane->update_noarm(dsb, plane, crtc_state, plane_state);
 }
 
-void intel_plane_async_flip(struct intel_plane *plane,
+void intel_plane_async_flip(struct intel_dsb *dsb,
+			    struct intel_plane *plane,
 			    const struct intel_crtc_state *crtc_state,
 			    const struct intel_plane_state *plane_state,
 			    bool async_flip)
@@ -810,34 +812,37 @@ void intel_plane_async_flip(struct intel_plane *plane,
 	struct intel_crtc *crtc = to_intel_crtc(crtc_state->uapi.crtc);
 
 	trace_intel_plane_async_flip(plane, crtc, async_flip);
-	plane->async_flip(plane, crtc_state, plane_state, async_flip);
+	plane->async_flip(dsb, plane, crtc_state, plane_state, async_flip);
 }
 
-void intel_plane_update_arm(struct intel_plane *plane,
+void intel_plane_update_arm(struct intel_dsb *dsb,
+			    struct intel_plane *plane,
 			    const struct intel_crtc_state *crtc_state,
 			    const struct intel_plane_state *plane_state)
 {
 	struct intel_crtc *crtc = to_intel_crtc(crtc_state->uapi.crtc);
 
 	if (crtc_state->do_async_flip && plane->async_flip) {
-		intel_plane_async_flip(plane, crtc_state, plane_state, true);
+		intel_plane_async_flip(dsb, plane, crtc_state, plane_state, true);
 		return;
 	}
 
 	trace_intel_plane_update_arm(plane, crtc);
-	plane->update_arm(plane, crtc_state, plane_state);
+	plane->update_arm(dsb, plane, crtc_state, plane_state);
 }
 
-void intel_plane_disable_arm(struct intel_plane *plane,
+void intel_plane_disable_arm(struct intel_dsb *dsb,
+			     struct intel_plane *plane,
 			     const struct intel_crtc_state *crtc_state)
 {
 	struct intel_crtc *crtc = to_intel_crtc(crtc_state->uapi.crtc);
 
 	trace_intel_plane_disable_arm(plane, crtc);
-	plane->disable_arm(plane, crtc_state);
+	plane->disable_arm(dsb, plane, crtc_state);
 }
 
-void intel_crtc_planes_update_noarm(struct intel_atomic_state *state,
+void intel_crtc_planes_update_noarm(struct intel_dsb *dsb,
+				    struct intel_atomic_state *state,
 				    struct intel_crtc *crtc)
 {
 	struct intel_crtc_state *new_crtc_state =
@@ -862,11 +867,13 @@ void intel_crtc_planes_update_noarm(struct intel_atomic_state *state,
 		/* TODO: for mailbox updates this should be skipped */
 		if (new_plane_state->uapi.visible ||
 		    new_plane_state->planar_slave)
-			intel_plane_update_noarm(plane, new_crtc_state, new_plane_state);
+			intel_plane_update_noarm(dsb, plane,
+						 new_crtc_state, new_plane_state);
 	}
 }
 
-static void skl_crtc_planes_update_arm(struct intel_atomic_state *state,
+static void skl_crtc_planes_update_arm(struct intel_dsb *dsb,
+				       struct intel_atomic_state *state,
 				       struct intel_crtc *crtc)
 {
 	struct intel_crtc_state *old_crtc_state =
@@ -893,13 +900,14 @@ static void skl_crtc_planes_update_arm(struct intel_atomic_state *state,
 		 */
 		if (new_plane_state->uapi.visible ||
 		    new_plane_state->planar_slave)
-			intel_plane_update_arm(plane, new_crtc_state, new_plane_state);
+			intel_plane_update_arm(dsb, plane, new_crtc_state, new_plane_state);
 		else
-			intel_plane_disable_arm(plane, new_crtc_state);
+			intel_plane_disable_arm(dsb, plane, new_crtc_state);
 	}
 }
 
-static void i9xx_crtc_planes_update_arm(struct intel_atomic_state *state,
+static void i9xx_crtc_planes_update_arm(struct intel_dsb *dsb,
+					struct intel_atomic_state *state,
 					struct intel_crtc *crtc)
 {
 	struct intel_crtc_state *new_crtc_state =
@@ -919,21 +927,22 @@ static void i9xx_crtc_planes_update_arm(struct intel_atomic_state *state,
 		 * would have to be called here as well.
 		 */
 		if (new_plane_state->uapi.visible)
-			intel_plane_update_arm(plane, new_crtc_state, new_plane_state);
+			intel_plane_update_arm(dsb, plane, new_crtc_state, new_plane_state);
 		else
-			intel_plane_disable_arm(plane, new_crtc_state);
+			intel_plane_disable_arm(dsb, plane, new_crtc_state);
 	}
 }
 
-void intel_crtc_planes_update_arm(struct intel_atomic_state *state,
+void intel_crtc_planes_update_arm(struct intel_dsb *dsb,
+				  struct intel_atomic_state *state,
 				  struct intel_crtc *crtc)
 {
 	struct drm_i915_private *i915 = to_i915(state->base.dev);
 
 	if (DISPLAY_VER(i915) >= 9)
-		skl_crtc_planes_update_arm(state, crtc);
+		skl_crtc_planes_update_arm(dsb, state, crtc);
 	else
-		i9xx_crtc_planes_update_arm(state, crtc);
+		i9xx_crtc_planes_update_arm(dsb, state, crtc);
 }
 
 int intel_atomic_plane_check_clipping(struct intel_plane_state *plane_state,
diff --git a/drivers/gpu/drm/i915/display/intel_atomic_plane.h b/drivers/gpu/drm/i915/display/intel_atomic_plane.h
index 6c4fe3596465..0f982f452ff3 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic_plane.h
+++ b/drivers/gpu/drm/i915/display/intel_atomic_plane.h
@@ -14,6 +14,7 @@ struct drm_rect;
 struct intel_atomic_state;
 struct intel_crtc;
 struct intel_crtc_state;
+struct intel_dsb;
 struct intel_plane;
 struct intel_plane_state;
 enum plane_id;
@@ -32,26 +33,32 @@ void intel_plane_copy_uapi_to_hw_state(struct intel_plane_state *plane_state,
 				       struct intel_crtc *crtc);
 void intel_plane_copy_hw_state(struct intel_plane_state *plane_state,
 			       const struct intel_plane_state *from_plane_state);
-void intel_plane_async_flip(struct intel_plane *plane,
+void intel_plane_async_flip(struct intel_dsb *dsb,
+			    struct intel_plane *plane,
 			    const struct intel_crtc_state *crtc_state,
 			    const struct intel_plane_state *plane_state,
 			    bool async_flip);
-void intel_plane_update_noarm(struct intel_plane *plane,
+void intel_plane_update_noarm(struct intel_dsb *dsb,
+			      struct intel_plane *plane,
 			      const struct intel_crtc_state *crtc_state,
 			      const struct intel_plane_state *plane_state);
-void intel_plane_update_arm(struct intel_plane *plane,
+void intel_plane_update_arm(struct intel_dsb *dsb,
+			    struct intel_plane *plane,
 			    const struct intel_crtc_state *crtc_state,
 			    const struct intel_plane_state *plane_state);
-void intel_plane_disable_arm(struct intel_plane *plane,
+void intel_plane_disable_arm(struct intel_dsb *dsb,
+			     struct intel_plane *plane,
 			     const struct intel_crtc_state *crtc_state);
 struct intel_plane *intel_plane_alloc(void);
 void intel_plane_free(struct intel_plane *plane);
 struct drm_plane_state *intel_plane_duplicate_state(struct drm_plane *plane);
 void intel_plane_destroy_state(struct drm_plane *plane,
 			       struct drm_plane_state *state);
-void intel_crtc_planes_update_noarm(struct intel_atomic_state *state,
+void intel_crtc_planes_update_noarm(struct intel_dsb *dsb,
+				    struct intel_atomic_state *state,
 				    struct intel_crtc *crtc);
-void intel_crtc_planes_update_arm(struct intel_atomic_state *state,
+void intel_crtc_planes_update_arm(struct intel_dsb *dsbx,
+				  struct intel_atomic_state *state,
 				  struct intel_crtc *crtc);
 int intel_plane_atomic_check_with_state(const struct intel_crtc_state *old_crtc_state,
 					struct intel_crtc_state *crtc_state,
diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
index ec55cb651d44..1fbe3cd452c1 100644
--- a/drivers/gpu/drm/i915/display/intel_color.c
+++ b/drivers/gpu/drm/i915/display/intel_color.c
@@ -1912,6 +1912,23 @@ void intel_color_post_update(const struct intel_crtc_state *crtc_state)
 		i915->display.funcs.color->color_post_update(crtc_state);
 }
 
+void intel_color_modeset(const struct intel_crtc_state *crtc_state)
+{
+	struct intel_display *display = to_intel_display(crtc_state);
+
+	intel_color_load_luts(crtc_state);
+	intel_color_commit_noarm(crtc_state);
+	intel_color_commit_arm(crtc_state);
+
+	if (DISPLAY_VER(display) < 9) {
+		struct intel_crtc *crtc = to_intel_crtc(crtc_state->uapi.crtc);
+		struct intel_plane *plane = to_intel_plane(crtc->base.primary);
+
+		/* update DSPCNTR to configure gamma/csc for pipe bottom color */
+		plane->disable_arm(NULL, plane, crtc_state);
+	}
+}
+
 void intel_color_prepare_commit(struct intel_atomic_state *state,
 				struct intel_crtc *crtc)
 {
diff --git a/drivers/gpu/drm/i915/display/intel_color.h b/drivers/gpu/drm/i915/display/intel_color.h
index 79f230a1709a..ab3aaec06a2a 100644
--- a/drivers/gpu/drm/i915/display/intel_color.h
+++ b/drivers/gpu/drm/i915/display/intel_color.h
@@ -28,6 +28,7 @@ void intel_color_commit_noarm(const struct intel_crtc_state *crtc_state);
 void intel_color_commit_arm(const struct intel_crtc_state *crtc_state);
 void intel_color_post_update(const struct intel_crtc_state *crtc_state);
 void intel_color_load_luts(const struct intel_crtc_state *crtc_state);
+void intel_color_modeset(const struct intel_crtc_state *crtc_state);
 void intel_color_get_config(struct intel_crtc_state *crtc_state);
 bool intel_color_lut_equal(const struct intel_crtc_state *crtc_state,
 			   const struct drm_property_blob *blob1,
diff --git a/drivers/gpu/drm/i915/display/intel_cursor.c b/drivers/gpu/drm/i915/display/intel_cursor.c
index 9ad53e1cbbd0..aeadb834d332 100644
--- a/drivers/gpu/drm/i915/display/intel_cursor.c
+++ b/drivers/gpu/drm/i915/display/intel_cursor.c
@@ -275,7 +275,8 @@ static int i845_check_cursor(struct intel_crtc_state *crtc_state,
 }
 
 /* TODO: split into noarm+arm pair */
-static void i845_cursor_update_arm(struct intel_plane *plane,
+static void i845_cursor_update_arm(struct intel_dsb *dsb,
+				   struct intel_plane *plane,
 				   const struct intel_crtc_state *crtc_state,
 				   const struct intel_plane_state *plane_state)
 {
@@ -315,10 +316,11 @@ static void i845_cursor_update_arm(struct intel_plane *plane,
 	}
 }
 
-static void i845_cursor_disable_arm(struct intel_plane *plane,
+static void i845_cursor_disable_arm(struct intel_dsb *dsb,
+				    struct intel_plane *plane,
 				    const struct intel_crtc_state *crtc_state)
 {
-	i845_cursor_update_arm(plane, crtc_state, NULL);
+	i845_cursor_update_arm(dsb, plane, crtc_state, NULL);
 }
 
 static bool i845_cursor_get_hw_state(struct intel_plane *plane,
@@ -527,22 +529,25 @@ static int i9xx_check_cursor(struct intel_crtc_state *crtc_state,
 	return 0;
 }
 
-static void i9xx_cursor_disable_sel_fetch_arm(struct intel_plane *plane,
+static void i9xx_cursor_disable_sel_fetch_arm(struct intel_dsb *dsb,
+					      struct intel_plane *plane,
 					      const struct intel_crtc_state *crtc_state)
 {
-	struct drm_i915_private *dev_priv = to_i915(plane->base.dev);
+	struct intel_display *display = to_intel_display(plane->base.dev);
 	enum pipe pipe = plane->pipe;
 
 	if (!crtc_state->enable_psr2_sel_fetch)
 		return;
 
-	intel_de_write_fw(dev_priv, SEL_FETCH_CUR_CTL(pipe), 0);
+	intel_de_write_dsb(display, dsb, SEL_FETCH_CUR_CTL(pipe), 0);
 }
 
-static void wa_16021440873(struct intel_plane *plane,
+static void wa_16021440873(struct intel_dsb *dsb,
+			   struct intel_plane *plane,
 			   const struct intel_crtc_state *crtc_state,
 			   const struct intel_plane_state *plane_state)
 {
+	struct intel_display *display = to_intel_display(plane->base.dev);
 	struct drm_i915_private *dev_priv = to_i915(plane->base.dev);
 	u32 ctl = plane_state->ctl;
 	int et_y_position = drm_rect_height(&crtc_state->pipe_src) + 1;
@@ -551,16 +556,18 @@ static void wa_16021440873(struct intel_plane *plane,
 	ctl &= ~MCURSOR_MODE_MASK;
 	ctl |= MCURSOR_MODE_64_2B;
 
-	intel_de_write_fw(dev_priv, SEL_FETCH_CUR_CTL(pipe), ctl);
+	intel_de_write_dsb(display, dsb, SEL_FETCH_CUR_CTL(pipe), ctl);
 
-	intel_de_write(dev_priv, CURPOS_ERLY_TPT(dev_priv, pipe),
-		       CURSOR_POS_Y(et_y_position));
+	intel_de_write_dsb(display, dsb, CURPOS_ERLY_TPT(dev_priv, pipe),
+			   CURSOR_POS_Y(et_y_position));
 }
 
-static void i9xx_cursor_update_sel_fetch_arm(struct intel_plane *plane,
+static void i9xx_cursor_update_sel_fetch_arm(struct intel_dsb *dsb,
+					     struct intel_plane *plane,
 					     const struct intel_crtc_state *crtc_state,
 					     const struct intel_plane_state *plane_state)
 {
+	struct intel_display *display = to_intel_display(plane->base.dev);
 	struct drm_i915_private *dev_priv = to_i915(plane->base.dev);
 	enum pipe pipe = plane->pipe;
 
@@ -571,19 +578,17 @@ static void i9xx_cursor_update_sel_fetch_arm(struct intel_plane *plane,
 		if (crtc_state->enable_psr2_su_region_et) {
 			u32 val = intel_cursor_position(crtc_state, plane_state,
 				true);
-			intel_de_write_fw(dev_priv,
-					  CURPOS_ERLY_TPT(dev_priv, pipe),
-					  val);
+
+			intel_de_write_dsb(display, dsb, CURPOS_ERLY_TPT(dev_priv, pipe), val);
 		}
 
-		intel_de_write_fw(dev_priv, SEL_FETCH_CUR_CTL(pipe),
-				  plane_state->ctl);
+		intel_de_write_dsb(display, dsb, SEL_FETCH_CUR_CTL(pipe), plane_state->ctl);
 	} else {
 		/* Wa_16021440873 */
 		if (crtc_state->enable_psr2_su_region_et)
-			wa_16021440873(plane, crtc_state, plane_state);
+			wa_16021440873(dsb, plane, crtc_state, plane_state);
 		else
-			i9xx_cursor_disable_sel_fetch_arm(plane, crtc_state);
+			i9xx_cursor_disable_sel_fetch_arm(dsb, plane, crtc_state);
 	}
 }
 
@@ -610,9 +615,11 @@ static u32 skl_cursor_wm_reg_val(const struct skl_wm_level *level)
 	return val;
 }
 
-static void skl_write_cursor_wm(struct intel_plane *plane,
+static void skl_write_cursor_wm(struct intel_dsb *dsb,
+				struct intel_plane *plane,
 				const struct intel_crtc_state *crtc_state)
 {
+	struct intel_display *display = to_intel_display(plane->base.dev);
 	struct drm_i915_private *i915 = to_i915(plane->base.dev);
 	enum plane_id plane_id = plane->id;
 	enum pipe pipe = plane->pipe;
@@ -622,30 +629,32 @@ static void skl_write_cursor_wm(struct intel_plane *plane,
 	int level;
 
 	for (level = 0; level < i915->display.wm.num_levels; level++)
-		intel_de_write_fw(i915, CUR_WM(pipe, level),
-				  skl_cursor_wm_reg_val(skl_plane_wm_level(pipe_wm, plane_id, level)));
+		intel_de_write_dsb(display, dsb, CUR_WM(pipe, level),
+				   skl_cursor_wm_reg_val(skl_plane_wm_level(pipe_wm, plane_id, level)));
 
-	intel_de_write_fw(i915, CUR_WM_TRANS(pipe),
-			  skl_cursor_wm_reg_val(skl_plane_trans_wm(pipe_wm, plane_id)));
+	intel_de_write_dsb(display, dsb, CUR_WM_TRANS(pipe),
+			   skl_cursor_wm_reg_val(skl_plane_trans_wm(pipe_wm, plane_id)));
 
 	if (HAS_HW_SAGV_WM(i915)) {
 		const struct skl_plane_wm *wm = &pipe_wm->planes[plane_id];
 
-		intel_de_write_fw(i915, CUR_WM_SAGV(pipe),
-				  skl_cursor_wm_reg_val(&wm->sagv.wm0));
-		intel_de_write_fw(i915, CUR_WM_SAGV_TRANS(pipe),
-				  skl_cursor_wm_reg_val(&wm->sagv.trans_wm));
+		intel_de_write_dsb(display, dsb, CUR_WM_SAGV(pipe),
+				   skl_cursor_wm_reg_val(&wm->sagv.wm0));
+		intel_de_write_dsb(display, dsb, CUR_WM_SAGV_TRANS(pipe),
+				   skl_cursor_wm_reg_val(&wm->sagv.trans_wm));
 	}
 
-	intel_de_write_fw(i915, CUR_BUF_CFG(pipe),
-			  skl_cursor_ddb_reg_val(ddb));
+	intel_de_write_dsb(display, dsb, CUR_BUF_CFG(pipe),
+			   skl_cursor_ddb_reg_val(ddb));
 }
 
 /* TODO: split into noarm+arm pair */
-static void i9xx_cursor_update_arm(struct intel_plane *plane,
+static void i9xx_cursor_update_arm(struct intel_dsb *dsb,
+				   struct intel_plane *plane,
 				   const struct intel_crtc_state *crtc_state,
 				   const struct intel_plane_state *plane_state)
 {
+	struct intel_display *display = to_intel_display(plane->base.dev);
 	struct drm_i915_private *dev_priv = to_i915(plane->base.dev);
 	enum pipe pipe = plane->pipe;
 	u32 cntl = 0, base = 0, pos = 0, fbc_ctl = 0;
@@ -685,38 +694,36 @@ static void i9xx_cursor_update_arm(struct intel_plane *plane,
 	 */
 
 	if (DISPLAY_VER(dev_priv) >= 9)
-		skl_write_cursor_wm(plane, crtc_state);
+		skl_write_cursor_wm(dsb, plane, crtc_state);
 
 	if (plane_state)
-		i9xx_cursor_update_sel_fetch_arm(plane, crtc_state,
-						 plane_state);
+		i9xx_cursor_update_sel_fetch_arm(dsb, plane, crtc_state, plane_state);
 	else
-		i9xx_cursor_disable_sel_fetch_arm(plane, crtc_state);
+		i9xx_cursor_disable_sel_fetch_arm(dsb, plane, crtc_state);
 
 	if (plane->cursor.base != base ||
 	    plane->cursor.size != fbc_ctl ||
 	    plane->cursor.cntl != cntl) {
 		if (HAS_CUR_FBC(dev_priv))
-			intel_de_write_fw(dev_priv,
-					  CUR_FBC_CTL(dev_priv, pipe),
-					  fbc_ctl);
-		intel_de_write_fw(dev_priv, CURCNTR(dev_priv, pipe), cntl);
-		intel_de_write_fw(dev_priv, CURPOS(dev_priv, pipe), pos);
-		intel_de_write_fw(dev_priv, CURBASE(dev_priv, pipe), base);
+			intel_de_write_dsb(display, dsb, CUR_FBC_CTL(dev_priv, pipe), fbc_ctl);
+		intel_de_write_dsb(display, dsb, CURCNTR(dev_priv, pipe), cntl);
+		intel_de_write_dsb(display, dsb, CURPOS(dev_priv, pipe), pos);
+		intel_de_write_dsb(display, dsb, CURBASE(dev_priv, pipe), base);
 
 		plane->cursor.base = base;
 		plane->cursor.size = fbc_ctl;
 		plane->cursor.cntl = cntl;
 	} else {
-		intel_de_write_fw(dev_priv, CURPOS(dev_priv, pipe), pos);
-		intel_de_write_fw(dev_priv, CURBASE(dev_priv, pipe), base);
+		intel_de_write_dsb(display, dsb, CURPOS(dev_priv, pipe), pos);
+		intel_de_write_dsb(display, dsb, CURBASE(dev_priv, pipe), base);
 	}
 }
 
-static void i9xx_cursor_disable_arm(struct intel_plane *plane,
+static void i9xx_cursor_disable_arm(struct intel_dsb *dsb,
+				    struct intel_plane *plane,
 				    const struct intel_crtc_state *crtc_state)
 {
-	i9xx_cursor_update_arm(plane, crtc_state, NULL);
+	i9xx_cursor_update_arm(dsb, plane, crtc_state, NULL);
 }
 
 static bool i9xx_cursor_get_hw_state(struct intel_plane *plane,
@@ -905,10 +912,10 @@ intel_legacy_cursor_update(struct drm_plane *_plane,
 	}
 
 	if (new_plane_state->uapi.visible) {
-		intel_plane_update_noarm(plane, crtc_state, new_plane_state);
-		intel_plane_update_arm(plane, crtc_state, new_plane_state);
+		intel_plane_update_noarm(NULL, plane, crtc_state, new_plane_state);
+		intel_plane_update_arm(NULL, plane, crtc_state, new_plane_state);
 	} else {
-		intel_plane_disable_arm(plane, crtc_state);
+		intel_plane_disable_arm(NULL, plane, crtc_state);
 	}
 
 	local_irq_enable();
diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 2f1d9ce87ceb..34dee523f0b6 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -4888,7 +4888,7 @@ void intel_ddi_init(struct intel_display *display,
 		if (!assert_has_icl_dsi(dev_priv))
 			return;
 
-		icl_dsi_init(dev_priv, devdata);
+		icl_dsi_init(display, devdata);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/i915/display/intel_de.h b/drivers/gpu/drm/i915/display/intel_de.h
index e881bfeafb47..e017cd4a8168 100644
--- a/drivers/gpu/drm/i915/display/intel_de.h
+++ b/drivers/gpu/drm/i915/display/intel_de.h
@@ -8,6 +8,7 @@
 
 #include "i915_drv.h"
 #include "i915_trace.h"
+#include "intel_dsb.h"
 #include "intel_uncore.h"
 
 static inline struct intel_uncore *__to_uncore(struct intel_display *display)
@@ -233,4 +234,14 @@ __intel_de_write_notrace(struct intel_display *display, i915_reg_t reg,
 }
 #define intel_de_write_notrace(p,...) __intel_de_write_notrace(__to_intel_display(p), __VA_ARGS__)
 
+static __always_inline void
+intel_de_write_dsb(struct intel_display *display, struct intel_dsb *dsb,
+		   i915_reg_t reg, u32 val)
+{
+	if (dsb)
+		intel_dsb_reg_write(dsb, reg, val);
+	else
+		intel_de_write_fw(display, reg, val);
+}
+
 #endif /* __INTEL_DE_H__ */
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 2c6d0da8a16f..3039ee03e1c7 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -135,7 +135,8 @@
 static void intel_set_transcoder_timings(const struct intel_crtc_state *crtc_state);
 static void intel_set_pipe_src_size(const struct intel_crtc_state *crtc_state);
 static void hsw_set_transconf(const struct intel_crtc_state *crtc_state);
-static void bdw_set_pipe_misc(const struct intel_crtc_state *crtc_state);
+static void bdw_set_pipe_misc(struct intel_dsb *dsb,
+			      const struct intel_crtc_state *crtc_state);
 
 /* returns HPLL frequency in kHz */
 int vlv_get_hpll_vco(struct drm_i915_private *dev_priv)
@@ -715,7 +716,7 @@ void intel_plane_disable_noatomic(struct intel_crtc *crtc,
 	if (DISPLAY_VER(dev_priv) == 2 && !crtc_state->active_planes)
 		intel_set_cpu_fifo_underrun_reporting(dev_priv, crtc->pipe, false);
 
-	intel_plane_disable_arm(plane, crtc_state);
+	intel_plane_disable_arm(NULL, plane, crtc_state);
 	intel_crtc_wait_for_next_vblank(crtc);
 }
 
@@ -1172,8 +1173,8 @@ static void intel_crtc_async_flip_disable_wa(struct intel_atomic_state *state,
 			 * Apart from the async flip bit we want to
 			 * preserve the old state for the plane.
 			 */
-			intel_plane_async_flip(plane, old_crtc_state,
-					       old_plane_state, false);
+			intel_plane_async_flip(NULL, plane,
+					       old_crtc_state, old_plane_state, false);
 			need_vbl_wait = true;
 		}
 	}
@@ -1315,7 +1316,7 @@ static void intel_crtc_disable_planes(struct intel_atomic_state *state,
 		    !(update_mask & BIT(plane->id)))
 			continue;
 
-		intel_plane_disable_arm(plane, new_crtc_state);
+		intel_plane_disable_arm(NULL, plane, new_crtc_state);
 
 		if (old_plane_state->uapi.visible)
 			fb_bits |= plane->frontbuffer_bit;
@@ -1502,14 +1503,6 @@ static void intel_encoders_update_pipe(struct intel_atomic_state *state,
 	}
 }
 
-static void intel_disable_primary_plane(const struct intel_crtc_state *crtc_state)
-{
-	struct intel_crtc *crtc = to_intel_crtc(crtc_state->uapi.crtc);
-	struct intel_plane *plane = to_intel_plane(crtc->base.primary);
-
-	plane->disable_arm(plane, crtc_state);
-}
-
 static void ilk_configure_cpu_transcoder(const struct intel_crtc_state *crtc_state)
 {
 	struct intel_crtc *crtc = to_intel_crtc(crtc_state->uapi.crtc);
@@ -1575,11 +1568,7 @@ static void ilk_crtc_enable(struct intel_atomic_state *state,
 	 * On ILK+ LUT must be loaded before the pipe is running but with
 	 * clocks enabled
 	 */
-	intel_color_load_luts(new_crtc_state);
-	intel_color_commit_noarm(new_crtc_state);
-	intel_color_commit_arm(new_crtc_state);
-	/* update DSPCNTR to configure gamma for pipe bottom color */
-	intel_disable_primary_plane(new_crtc_state);
+	intel_color_modeset(new_crtc_state);
 
 	intel_initial_watermarks(state, crtc);
 	intel_enable_transcoder(new_crtc_state);
@@ -1716,7 +1705,7 @@ static void hsw_crtc_enable(struct intel_atomic_state *state,
 		intel_set_pipe_src_size(pipe_crtc_state);
 
 		if (DISPLAY_VER(dev_priv) >= 9 || IS_BROADWELL(dev_priv))
-			bdw_set_pipe_misc(pipe_crtc_state);
+			bdw_set_pipe_misc(NULL, pipe_crtc_state);
 	}
 
 	if (!transcoder_is_dsi(cpu_transcoder))
@@ -1741,12 +1730,7 @@ static void hsw_crtc_enable(struct intel_atomic_state *state,
 		 * On ILK+ LUT must be loaded before the pipe is running but with
 		 * clocks enabled
 		 */
-		intel_color_load_luts(pipe_crtc_state);
-		intel_color_commit_noarm(pipe_crtc_state);
-		intel_color_commit_arm(pipe_crtc_state);
-		/* update DSPCNTR to configure gamma/csc for pipe bottom color */
-		if (DISPLAY_VER(dev_priv) < 9)
-			intel_disable_primary_plane(pipe_crtc_state);
+		intel_color_modeset(pipe_crtc_state);
 
 		hsw_set_linetime_wm(pipe_crtc_state);
 
@@ -2147,11 +2131,7 @@ static void valleyview_crtc_enable(struct intel_atomic_state *state,
 
 	i9xx_pfit_enable(new_crtc_state);
 
-	intel_color_load_luts(new_crtc_state);
-	intel_color_commit_noarm(new_crtc_state);
-	intel_color_commit_arm(new_crtc_state);
-	/* update DSPCNTR to configure gamma for pipe bottom color */
-	intel_disable_primary_plane(new_crtc_state);
+	intel_color_modeset(new_crtc_state);
 
 	intel_initial_watermarks(state, crtc);
 	intel_enable_transcoder(new_crtc_state);
@@ -2187,11 +2167,7 @@ static void i9xx_crtc_enable(struct intel_atomic_state *state,
 
 	i9xx_pfit_enable(new_crtc_state);
 
-	intel_color_load_luts(new_crtc_state);
-	intel_color_commit_noarm(new_crtc_state);
-	intel_color_commit_arm(new_crtc_state);
-	/* update DSPCNTR to configure gamma for pipe bottom color */
-	intel_disable_primary_plane(new_crtc_state);
+	intel_color_modeset(new_crtc_state);
 
 	if (!intel_initial_watermarks(state, crtc))
 		intel_update_watermarks(dev_priv);
@@ -3246,9 +3222,11 @@ static void hsw_set_transconf(const struct intel_crtc_state *crtc_state)
 	intel_de_posting_read(dev_priv, TRANSCONF(dev_priv, cpu_transcoder));
 }
 
-static void bdw_set_pipe_misc(const struct intel_crtc_state *crtc_state)
+static void bdw_set_pipe_misc(struct intel_dsb *dsb,
+			      const struct intel_crtc_state *crtc_state)
 {
 	struct intel_crtc *crtc = to_intel_crtc(crtc_state->uapi.crtc);
+	struct intel_display *display = to_intel_display(crtc->base.dev);
 	struct drm_i915_private *dev_priv = to_i915(crtc->base.dev);
 	u32 val = 0;
 
@@ -3293,7 +3271,7 @@ static void bdw_set_pipe_misc(const struct intel_crtc_state *crtc_state)
 	if (IS_BROADWELL(dev_priv))
 		val |= PIPE_MISC_PSR_MASK_SPRITE_ENABLE;
 
-	intel_de_write(dev_priv, PIPE_MISC(crtc->pipe), val);
+	intel_de_write_dsb(display, dsb, PIPE_MISC(crtc->pipe), val);
 }
 
 int bdw_get_pipe_misc_bpp(struct intel_crtc *crtc)
@@ -6846,7 +6824,7 @@ static void commit_pipe_pre_planes(struct intel_atomic_state *state,
 			intel_color_commit_arm(new_crtc_state);
 
 		if (DISPLAY_VER(dev_priv) >= 9 || IS_BROADWELL(dev_priv))
-			bdw_set_pipe_misc(new_crtc_state);
+			bdw_set_pipe_misc(NULL, new_crtc_state);
 
 		if (intel_crtc_needs_fastset(new_crtc_state))
 			intel_pipe_fastset(old_crtc_state, new_crtc_state);
@@ -6946,7 +6924,7 @@ static void intel_pre_update_crtc(struct intel_atomic_state *state,
 	    intel_crtc_needs_color_update(new_crtc_state))
 		intel_color_commit_noarm(new_crtc_state);
 
-	intel_crtc_planes_update_noarm(state, crtc);
+	intel_crtc_planes_update_noarm(NULL, state, crtc);
 }
 
 static void intel_update_crtc(struct intel_atomic_state *state,
@@ -6962,7 +6940,7 @@ static void intel_update_crtc(struct intel_atomic_state *state,
 
 	commit_pipe_pre_planes(state, crtc);
 
-	intel_crtc_planes_update_arm(state, crtc);
+	intel_crtc_planes_update_arm(NULL, state, crtc);
 
 	commit_pipe_post_planes(state, crtc);
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index f29e5dc3db91..3e24d2e90d3c 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1036,6 +1036,10 @@ struct intel_csc_matrix {
 	u16 postoff[3];
 };
 
+void intel_io_mmio_fw_write(void *ctx, i915_reg_t reg, u32 val);
+
+typedef void (*intel_io_reg_write)(void *ctx, i915_reg_t reg, u32 val);
+
 struct intel_crtc_state {
 	/*
 	 * uapi (drm) state. This is the software state shown to userspace.
@@ -1578,22 +1582,26 @@ struct intel_plane {
 				   u32 pixel_format, u64 modifier,
 				   unsigned int rotation);
 	/* Write all non-self arming plane registers */
-	void (*update_noarm)(struct intel_plane *plane,
+	void (*update_noarm)(struct intel_dsb *dsb,
+			     struct intel_plane *plane,
 			     const struct intel_crtc_state *crtc_state,
 			     const struct intel_plane_state *plane_state);
 	/* Write all self-arming plane registers */
-	void (*update_arm)(struct intel_plane *plane,
+	void (*update_arm)(struct intel_dsb *dsb,
+			   struct intel_plane *plane,
 			   const struct intel_crtc_state *crtc_state,
 			   const struct intel_plane_state *plane_state);
 	/* Disable the plane, must arm */
-	void (*disable_arm)(struct intel_plane *plane,
+	void (*disable_arm)(struct intel_dsb *dsb,
+			    struct intel_plane *plane,
 			    const struct intel_crtc_state *crtc_state);
 	bool (*get_hw_state)(struct intel_plane *plane, enum pipe *pipe);
 	int (*check_plane)(struct intel_crtc_state *crtc_state,
 			   struct intel_plane_state *plane_state);
 	int (*min_cdclk)(const struct intel_crtc_state *crtc_state,
 			 const struct intel_plane_state *plane_state);
-	void (*async_flip)(struct intel_plane *plane,
+	void (*async_flip)(struct intel_dsb *dsb,
+			   struct intel_plane *plane,
 			   const struct intel_crtc_state *crtc_state,
 			   const struct intel_plane_state *plane_state,
 			   bool async_flip);
diff --git a/drivers/gpu/drm/i915/display/intel_sprite.c b/drivers/gpu/drm/i915/display/intel_sprite.c
index e657b09ede99..e6fadcef58e0 100644
--- a/drivers/gpu/drm/i915/display/intel_sprite.c
+++ b/drivers/gpu/drm/i915/display/intel_sprite.c
@@ -378,7 +378,8 @@ static void vlv_sprite_update_gamma(const struct intel_plane_state *plane_state)
 }
 
 static void
-vlv_sprite_update_noarm(struct intel_plane *plane,
+vlv_sprite_update_noarm(struct intel_dsb *dsb,
+			struct intel_plane *plane,
 			const struct intel_crtc_state *crtc_state,
 			const struct intel_plane_state *plane_state)
 {
@@ -399,7 +400,8 @@ vlv_sprite_update_noarm(struct intel_plane *plane,
 }
 
 static void
-vlv_sprite_update_arm(struct intel_plane *plane,
+vlv_sprite_update_arm(struct intel_dsb *dsb,
+		      struct intel_plane *plane,
 		      const struct intel_crtc_state *crtc_state,
 		      const struct intel_plane_state *plane_state)
 {
@@ -449,7 +451,8 @@ vlv_sprite_update_arm(struct intel_plane *plane,
 }
 
 static void
-vlv_sprite_disable_arm(struct intel_plane *plane,
+vlv_sprite_disable_arm(struct intel_dsb *dsb,
+		       struct intel_plane *plane,
 		       const struct intel_crtc_state *crtc_state)
 {
 	struct intel_display *display = to_intel_display(plane->base.dev);
@@ -795,7 +798,8 @@ static void ivb_sprite_update_gamma(const struct intel_plane_state *plane_state)
 }
 
 static void
-ivb_sprite_update_noarm(struct intel_plane *plane,
+ivb_sprite_update_noarm(struct intel_dsb *dsb,
+			struct intel_plane *plane,
 			const struct intel_crtc_state *crtc_state,
 			const struct intel_plane_state *plane_state)
 {
@@ -826,7 +830,8 @@ ivb_sprite_update_noarm(struct intel_plane *plane,
 }
 
 static void
-ivb_sprite_update_arm(struct intel_plane *plane,
+ivb_sprite_update_arm(struct intel_dsb *dsb,
+		      struct intel_plane *plane,
 		      const struct intel_crtc_state *crtc_state,
 		      const struct intel_plane_state *plane_state)
 {
@@ -874,7 +879,8 @@ ivb_sprite_update_arm(struct intel_plane *plane,
 }
 
 static void
-ivb_sprite_disable_arm(struct intel_plane *plane,
+ivb_sprite_disable_arm(struct intel_dsb *dsb,
+		       struct intel_plane *plane,
 		       const struct intel_crtc_state *crtc_state)
 {
 	struct intel_display *display = to_intel_display(plane->base.dev);
@@ -1133,7 +1139,8 @@ static void ilk_sprite_update_gamma(const struct intel_plane_state *plane_state)
 }
 
 static void
-g4x_sprite_update_noarm(struct intel_plane *plane,
+g4x_sprite_update_noarm(struct intel_dsb *dsb,
+			struct intel_plane *plane,
 			const struct intel_crtc_state *crtc_state,
 			const struct intel_plane_state *plane_state)
 {
@@ -1162,7 +1169,8 @@ g4x_sprite_update_noarm(struct intel_plane *plane,
 }
 
 static void
-g4x_sprite_update_arm(struct intel_plane *plane,
+g4x_sprite_update_arm(struct intel_dsb *dsb,
+		      struct intel_plane *plane,
 		      const struct intel_crtc_state *crtc_state,
 		      const struct intel_plane_state *plane_state)
 {
@@ -1206,7 +1214,8 @@ g4x_sprite_update_arm(struct intel_plane *plane,
 }
 
 static void
-g4x_sprite_disable_arm(struct intel_plane *plane,
+g4x_sprite_disable_arm(struct intel_dsb *dsb,
+		       struct intel_plane *plane,
 		       const struct intel_crtc_state *crtc_state)
 {
 	struct intel_display *display = to_intel_display(plane->base.dev);
diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
index 62a5287ea1d9..7f77a76309bd 100644
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@ -589,11 +589,11 @@ static u32 skl_plane_min_alignment(struct intel_plane *plane,
  * in full-range YCbCr.
  */
 static void
-icl_program_input_csc(struct intel_plane *plane,
-		      const struct intel_crtc_state *crtc_state,
+icl_program_input_csc(struct intel_dsb *dsb,
+		      struct intel_plane *plane,
 		      const struct intel_plane_state *plane_state)
 {
-	struct drm_i915_private *dev_priv = to_i915(plane->base.dev);
+	struct intel_display *display = to_intel_display(plane->base.dev);
 	enum pipe pipe = plane->pipe;
 	enum plane_id plane_id = plane->id;
 
@@ -637,31 +637,31 @@ icl_program_input_csc(struct intel_plane *plane,
 	};
 	const u16 *csc = input_csc_matrix[plane_state->hw.color_encoding];
 
-	intel_de_write_fw(dev_priv, PLANE_INPUT_CSC_COEFF(pipe, plane_id, 0),
-			  ROFF(csc[0]) | GOFF(csc[1]));
-	intel_de_write_fw(dev_priv, PLANE_INPUT_CSC_COEFF(pipe, plane_id, 1),
-			  BOFF(csc[2]));
-	intel_de_write_fw(dev_priv, PLANE_INPUT_CSC_COEFF(pipe, plane_id, 2),
-			  ROFF(csc[3]) | GOFF(csc[4]));
-	intel_de_write_fw(dev_priv, PLANE_INPUT_CSC_COEFF(pipe, plane_id, 3),
-			  BOFF(csc[5]));
-	intel_de_write_fw(dev_priv, PLANE_INPUT_CSC_COEFF(pipe, plane_id, 4),
-			  ROFF(csc[6]) | GOFF(csc[7]));
-	intel_de_write_fw(dev_priv, PLANE_INPUT_CSC_COEFF(pipe, plane_id, 5),
-			  BOFF(csc[8]));
-
-	intel_de_write_fw(dev_priv, PLANE_INPUT_CSC_PREOFF(pipe, plane_id, 0),
-			  PREOFF_YUV_TO_RGB_HI);
-	intel_de_write_fw(dev_priv, PLANE_INPUT_CSC_PREOFF(pipe, plane_id, 1),
-			  PREOFF_YUV_TO_RGB_ME);
-	intel_de_write_fw(dev_priv, PLANE_INPUT_CSC_PREOFF(pipe, plane_id, 2),
-			  PREOFF_YUV_TO_RGB_LO);
-	intel_de_write_fw(dev_priv,
-			  PLANE_INPUT_CSC_POSTOFF(pipe, plane_id, 0), 0x0);
-	intel_de_write_fw(dev_priv,
-			  PLANE_INPUT_CSC_POSTOFF(pipe, plane_id, 1), 0x0);
-	intel_de_write_fw(dev_priv,
-			  PLANE_INPUT_CSC_POSTOFF(pipe, plane_id, 2), 0x0);
+	intel_de_write_dsb(display, dsb, PLANE_INPUT_CSC_COEFF(pipe, plane_id, 0),
+			   ROFF(csc[0]) | GOFF(csc[1]));
+	intel_de_write_dsb(display, dsb, PLANE_INPUT_CSC_COEFF(pipe, plane_id, 1),
+			   BOFF(csc[2]));
+	intel_de_write_dsb(display, dsb, PLANE_INPUT_CSC_COEFF(pipe, plane_id, 2),
+			   ROFF(csc[3]) | GOFF(csc[4]));
+	intel_de_write_dsb(display, dsb, PLANE_INPUT_CSC_COEFF(pipe, plane_id, 3),
+			   BOFF(csc[5]));
+	intel_de_write_dsb(display, dsb, PLANE_INPUT_CSC_COEFF(pipe, plane_id, 4),
+			   ROFF(csc[6]) | GOFF(csc[7]));
+	intel_de_write_dsb(display, dsb, PLANE_INPUT_CSC_COEFF(pipe, plane_id, 5),
+			   BOFF(csc[8]));
+
+	intel_de_write_dsb(display, dsb, PLANE_INPUT_CSC_PREOFF(pipe, plane_id, 0),
+			   PREOFF_YUV_TO_RGB_HI);
+	intel_de_write_dsb(display, dsb, PLANE_INPUT_CSC_PREOFF(pipe, plane_id, 1),
+			   PREOFF_YUV_TO_RGB_ME);
+	intel_de_write_dsb(display, dsb, PLANE_INPUT_CSC_PREOFF(pipe, plane_id, 2),
+			   PREOFF_YUV_TO_RGB_LO);
+	intel_de_write_dsb(display, dsb,
+			   PLANE_INPUT_CSC_POSTOFF(pipe, plane_id, 0), 0x0);
+	intel_de_write_dsb(display, dsb,
+			   PLANE_INPUT_CSC_POSTOFF(pipe, plane_id, 1), 0x0);
+	intel_de_write_dsb(display, dsb,
+			   PLANE_INPUT_CSC_POSTOFF(pipe, plane_id, 2), 0x0);
 }
 
 static unsigned int skl_plane_stride_mult(const struct drm_framebuffer *fb,
@@ -715,9 +715,11 @@ static u32 skl_plane_wm_reg_val(const struct skl_wm_level *level)
 	return val;
 }
 
-static void skl_write_plane_wm(struct intel_plane *plane,
+static void skl_write_plane_wm(struct intel_dsb *dsb,
+			       struct intel_plane *plane,
 			       const struct intel_crtc_state *crtc_state)
 {
+	struct intel_display *display = to_intel_display(plane->base.dev);
 	struct drm_i915_private *i915 = to_i915(plane->base.dev);
 	enum plane_id plane_id = plane->id;
 	enum pipe pipe = plane->pipe;
@@ -729,71 +731,75 @@ static void skl_write_plane_wm(struct intel_plane *plane,
 	int level;
 
 	for (level = 0; level < i915->display.wm.num_levels; level++)
-		intel_de_write_fw(i915, PLANE_WM(pipe, plane_id, level),
-				  skl_plane_wm_reg_val(skl_plane_wm_level(pipe_wm, plane_id, level)));
+		intel_de_write_dsb(display, dsb, PLANE_WM(pipe, plane_id, level),
+				   skl_plane_wm_reg_val(skl_plane_wm_level(pipe_wm, plane_id, level)));
 
-	intel_de_write_fw(i915, PLANE_WM_TRANS(pipe, plane_id),
-			  skl_plane_wm_reg_val(skl_plane_trans_wm(pipe_wm, plane_id)));
+	intel_de_write_dsb(display, dsb, PLANE_WM_TRANS(pipe, plane_id),
+			   skl_plane_wm_reg_val(skl_plane_trans_wm(pipe_wm, plane_id)));
 
 	if (HAS_HW_SAGV_WM(i915)) {
 		const struct skl_plane_wm *wm = &pipe_wm->planes[plane_id];
 
-		intel_de_write_fw(i915, PLANE_WM_SAGV(pipe, plane_id),
-				  skl_plane_wm_reg_val(&wm->sagv.wm0));
-		intel_de_write_fw(i915, PLANE_WM_SAGV_TRANS(pipe, plane_id),
-				  skl_plane_wm_reg_val(&wm->sagv.trans_wm));
+		intel_de_write_dsb(display, dsb, PLANE_WM_SAGV(pipe, plane_id),
+				   skl_plane_wm_reg_val(&wm->sagv.wm0));
+		intel_de_write_dsb(display, dsb, PLANE_WM_SAGV_TRANS(pipe, plane_id),
+				   skl_plane_wm_reg_val(&wm->sagv.trans_wm));
 	}
 
-	intel_de_write_fw(i915, PLANE_BUF_CFG(pipe, plane_id),
-			  skl_plane_ddb_reg_val(ddb));
+	intel_de_write_dsb(display, dsb, PLANE_BUF_CFG(pipe, plane_id),
+			   skl_plane_ddb_reg_val(ddb));
 
 	if (DISPLAY_VER(i915) < 11)
-		intel_de_write_fw(i915, PLANE_NV12_BUF_CFG(pipe, plane_id),
-				  skl_plane_ddb_reg_val(ddb_y));
+		intel_de_write_dsb(display, dsb, PLANE_NV12_BUF_CFG(pipe, plane_id),
+				   skl_plane_ddb_reg_val(ddb_y));
 }
 
 static void
-skl_plane_disable_arm(struct intel_plane *plane,
+skl_plane_disable_arm(struct intel_dsb *dsb,
+		      struct intel_plane *plane,
 		      const struct intel_crtc_state *crtc_state)
 {
-	struct drm_i915_private *dev_priv = to_i915(plane->base.dev);
+	struct intel_display *display = to_intel_display(plane->base.dev);
 	enum plane_id plane_id = plane->id;
 	enum pipe pipe = plane->pipe;
 
-	skl_write_plane_wm(plane, crtc_state);
+	skl_write_plane_wm(dsb, plane, crtc_state);
 
-	intel_de_write_fw(dev_priv, PLANE_CTL(pipe, plane_id), 0);
-	intel_de_write_fw(dev_priv, PLANE_SURF(pipe, plane_id), 0);
+	intel_de_write_dsb(display, dsb, PLANE_CTL(pipe, plane_id), 0);
+	intel_de_write_dsb(display, dsb, PLANE_SURF(pipe, plane_id), 0);
 }
 
-static void icl_plane_disable_sel_fetch_arm(struct intel_plane *plane,
+static void icl_plane_disable_sel_fetch_arm(struct intel_dsb *dsb,
+					    struct intel_plane *plane,
 					    const struct intel_crtc_state *crtc_state)
 {
-	struct drm_i915_private *i915 = to_i915(plane->base.dev);
+	struct intel_display *display = to_intel_display(plane->base.dev);
 	enum pipe pipe = plane->pipe;
 
 	if (!crtc_state->enable_psr2_sel_fetch)
 		return;
 
-	intel_de_write_fw(i915, SEL_FETCH_PLANE_CTL(pipe, plane->id), 0);
+	intel_de_write_dsb(display, dsb, SEL_FETCH_PLANE_CTL(pipe, plane->id), 0);
 }
 
 static void
-icl_plane_disable_arm(struct intel_plane *plane,
+icl_plane_disable_arm(struct intel_dsb *dsb,
+		      struct intel_plane *plane,
 		      const struct intel_crtc_state *crtc_state)
 {
+	struct intel_display *display = to_intel_display(plane->base.dev);
 	struct drm_i915_private *dev_priv = to_i915(plane->base.dev);
 	enum plane_id plane_id = plane->id;
 	enum pipe pipe = plane->pipe;
 
 	if (icl_is_hdr_plane(dev_priv, plane_id))
-		intel_de_write_fw(dev_priv, PLANE_CUS_CTL(pipe, plane_id), 0);
+		intel_de_write_dsb(display, dsb, PLANE_CUS_CTL(pipe, plane_id), 0);
 
-	skl_write_plane_wm(plane, crtc_state);
+	skl_write_plane_wm(dsb, plane, crtc_state);
 
-	icl_plane_disable_sel_fetch_arm(plane, crtc_state);
-	intel_de_write_fw(dev_priv, PLANE_CTL(pipe, plane_id), 0);
-	intel_de_write_fw(dev_priv, PLANE_SURF(pipe, plane_id), 0);
+	icl_plane_disable_sel_fetch_arm(dsb, plane, crtc_state);
+	intel_de_write_dsb(display, dsb, PLANE_CTL(pipe, plane_id), 0);
+	intel_de_write_dsb(display, dsb, PLANE_SURF(pipe, plane_id), 0);
 }
 
 static bool
@@ -1230,28 +1236,30 @@ static u32 skl_plane_keymsk(const struct intel_plane_state *plane_state)
 	return keymsk;
 }
 
-static void icl_plane_csc_load_black(struct intel_plane *plane)
+static void icl_plane_csc_load_black(struct intel_dsb *dsb,
+				     struct intel_plane *plane,
+				     const struct intel_crtc_state *crtc_state)
 {
-	struct drm_i915_private *i915 = to_i915(plane->base.dev);
+	struct intel_display *display = to_intel_display(plane->base.dev);
 	enum plane_id plane_id = plane->id;
 	enum pipe pipe = plane->pipe;
 
-	intel_de_write_fw(i915, PLANE_CSC_COEFF(pipe, plane_id, 0), 0);
-	intel_de_write_fw(i915, PLANE_CSC_COEFF(pipe, plane_id, 1), 0);
+	intel_de_write_dsb(display, dsb, PLANE_CSC_COEFF(pipe, plane_id, 0), 0);
+	intel_de_write_dsb(display, dsb, PLANE_CSC_COEFF(pipe, plane_id, 1), 0);
 
-	intel_de_write_fw(i915, PLANE_CSC_COEFF(pipe, plane_id, 2), 0);
-	intel_de_write_fw(i915, PLANE_CSC_COEFF(pipe, plane_id, 3), 0);
+	intel_de_write_dsb(display, dsb, PLANE_CSC_COEFF(pipe, plane_id, 2), 0);
+	intel_de_write_dsb(display, dsb, PLANE_CSC_COEFF(pipe, plane_id, 3), 0);
 
-	intel_de_write_fw(i915, PLANE_CSC_COEFF(pipe, plane_id, 4), 0);
-	intel_de_write_fw(i915, PLANE_CSC_COEFF(pipe, plane_id, 5), 0);
+	intel_de_write_dsb(display, dsb, PLANE_CSC_COEFF(pipe, plane_id, 4), 0);
+	intel_de_write_dsb(display, dsb, PLANE_CSC_COEFF(pipe, plane_id, 5), 0);
 
-	intel_de_write_fw(i915, PLANE_CSC_PREOFF(pipe, plane_id, 0), 0);
-	intel_de_write_fw(i915, PLANE_CSC_PREOFF(pipe, plane_id, 1), 0);
-	intel_de_write_fw(i915, PLANE_CSC_PREOFF(pipe, plane_id, 2), 0);
+	intel_de_write_dsb(display, dsb, PLANE_CSC_PREOFF(pipe, plane_id, 0), 0);
+	intel_de_write_dsb(display, dsb, PLANE_CSC_PREOFF(pipe, plane_id, 1), 0);
+	intel_de_write_dsb(display, dsb, PLANE_CSC_PREOFF(pipe, plane_id, 2), 0);
 
-	intel_de_write_fw(i915, PLANE_CSC_POSTOFF(pipe, plane_id, 0), 0);
-	intel_de_write_fw(i915, PLANE_CSC_POSTOFF(pipe, plane_id, 1), 0);
-	intel_de_write_fw(i915, PLANE_CSC_POSTOFF(pipe, plane_id, 2), 0);
+	intel_de_write_dsb(display, dsb, PLANE_CSC_POSTOFF(pipe, plane_id, 0), 0);
+	intel_de_write_dsb(display, dsb, PLANE_CSC_POSTOFF(pipe, plane_id, 1), 0);
+	intel_de_write_dsb(display, dsb, PLANE_CSC_POSTOFF(pipe, plane_id, 2), 0);
 }
 
 static int icl_plane_color_plane(const struct intel_plane_state *plane_state)
@@ -1264,11 +1272,12 @@ static int icl_plane_color_plane(const struct intel_plane_state *plane_state)
 }
 
 static void
-skl_plane_update_noarm(struct intel_plane *plane,
+skl_plane_update_noarm(struct intel_dsb *dsb,
+		       struct intel_plane *plane,
 		       const struct intel_crtc_state *crtc_state,
 		       const struct intel_plane_state *plane_state)
 {
-	struct drm_i915_private *dev_priv = to_i915(plane->base.dev);
+	struct intel_display *display = to_intel_display(plane->base.dev);
 	enum plane_id plane_id = plane->id;
 	enum pipe pipe = plane->pipe;
 	u32 stride = skl_plane_stride(plane_state, 0);
@@ -1283,21 +1292,23 @@ skl_plane_update_noarm(struct intel_plane *plane,
 		crtc_y = 0;
 	}
 
-	intel_de_write_fw(dev_priv, PLANE_STRIDE(pipe, plane_id),
-			  PLANE_STRIDE_(stride));
-	intel_de_write_fw(dev_priv, PLANE_POS(pipe, plane_id),
-			  PLANE_POS_Y(crtc_y) | PLANE_POS_X(crtc_x));
-	intel_de_write_fw(dev_priv, PLANE_SIZE(pipe, plane_id),
-			  PLANE_HEIGHT(src_h - 1) | PLANE_WIDTH(src_w - 1));
+	intel_de_write_dsb(display, dsb, PLANE_STRIDE(pipe, plane_id),
+			   PLANE_STRIDE_(stride));
+	intel_de_write_dsb(display, dsb, PLANE_POS(pipe, plane_id),
+			   PLANE_POS_Y(crtc_y) | PLANE_POS_X(crtc_x));
+	intel_de_write_dsb(display, dsb, PLANE_SIZE(pipe, plane_id),
+			   PLANE_HEIGHT(src_h - 1) | PLANE_WIDTH(src_w - 1));
 
-	skl_write_plane_wm(plane, crtc_state);
+	skl_write_plane_wm(dsb, plane, crtc_state);
 }
 
 static void
-skl_plane_update_arm(struct intel_plane *plane,
+skl_plane_update_arm(struct intel_dsb *dsb,
+		     struct intel_plane *plane,
 		     const struct intel_crtc_state *crtc_state,
 		     const struct intel_plane_state *plane_state)
 {
+	struct intel_display *display = to_intel_display(plane->base.dev);
 	struct drm_i915_private *dev_priv = to_i915(plane->base.dev);
 	enum plane_id plane_id = plane->id;
 	enum pipe pipe = plane->pipe;
@@ -1317,22 +1328,26 @@ skl_plane_update_arm(struct intel_plane *plane,
 		plane_color_ctl = plane_state->color_ctl |
 			glk_plane_color_ctl_crtc(crtc_state);
 
-	intel_de_write_fw(dev_priv, PLANE_KEYVAL(pipe, plane_id), skl_plane_keyval(plane_state));
-	intel_de_write_fw(dev_priv, PLANE_KEYMSK(pipe, plane_id), skl_plane_keymsk(plane_state));
-	intel_de_write_fw(dev_priv, PLANE_KEYMAX(pipe, plane_id), skl_plane_keymax(plane_state));
+	intel_de_write_dsb(display, dsb, PLANE_KEYVAL(pipe, plane_id),
+			   skl_plane_keyval(plane_state));
+	intel_de_write_dsb(display, dsb, PLANE_KEYMSK(pipe, plane_id),
+			   skl_plane_keymsk(plane_state));
+	intel_de_write_dsb(display, dsb, PLANE_KEYMAX(pipe, plane_id),
+			   skl_plane_keymax(plane_state));
 
-	intel_de_write_fw(dev_priv, PLANE_OFFSET(pipe, plane_id),
-			  PLANE_OFFSET_Y(y) | PLANE_OFFSET_X(x));
+	intel_de_write_dsb(display, dsb, PLANE_OFFSET(pipe, plane_id),
+			   PLANE_OFFSET_Y(y) | PLANE_OFFSET_X(x));
 
-	intel_de_write_fw(dev_priv, PLANE_AUX_DIST(pipe, plane_id),
-			  skl_plane_aux_dist(plane_state, 0));
+	intel_de_write_dsb(display, dsb, PLANE_AUX_DIST(pipe, plane_id),
+			   skl_plane_aux_dist(plane_state, 0));
 
-	intel_de_write_fw(dev_priv, PLANE_AUX_OFFSET(pipe, plane_id),
-			  PLANE_OFFSET_Y(plane_state->view.color_plane[1].y) |
-			  PLANE_OFFSET_X(plane_state->view.color_plane[1].x));
+	intel_de_write_dsb(display, dsb, PLANE_AUX_OFFSET(pipe, plane_id),
+			   PLANE_OFFSET_Y(plane_state->view.color_plane[1].y) |
+			   PLANE_OFFSET_X(plane_state->view.color_plane[1].x));
 
 	if (DISPLAY_VER(dev_priv) >= 10)
-		intel_de_write_fw(dev_priv, PLANE_COLOR_CTL(pipe, plane_id), plane_color_ctl);
+		intel_de_write_dsb(display, dsb, PLANE_COLOR_CTL(pipe, plane_id),
+				   plane_color_ctl);
 
 	/*
 	 * Enable the scaler before the plane so that we don't
@@ -1349,17 +1364,19 @@ skl_plane_update_arm(struct intel_plane *plane,
 	 * disabled. Try to make the plane enable atomic by writing
 	 * the control register just before the surface register.
 	 */
-	intel_de_write_fw(dev_priv, PLANE_CTL(pipe, plane_id), plane_ctl);
-	intel_de_write_fw(dev_priv, PLANE_SURF(pipe, plane_id),
-			  skl_plane_surf(plane_state, 0));
+	intel_de_write_dsb(display, dsb, PLANE_CTL(pipe, plane_id),
+			   plane_ctl);
+	intel_de_write_dsb(display, dsb, PLANE_SURF(pipe, plane_id),
+			   skl_plane_surf(plane_state, 0));
 }
 
-static void icl_plane_update_sel_fetch_noarm(struct intel_plane *plane,
+static void icl_plane_update_sel_fetch_noarm(struct intel_dsb *dsb,
+					     struct intel_plane *plane,
 					     const struct intel_crtc_state *crtc_state,
 					     const struct intel_plane_state *plane_state,
 					     int color_plane)
 {
-	struct drm_i915_private *i915 = to_i915(plane->base.dev);
+	struct intel_display *display = to_intel_display(plane->base.dev);
 	enum pipe pipe = plane->pipe;
 	const struct drm_rect *clip;
 	u32 val;
@@ -1376,7 +1393,7 @@ static void icl_plane_update_sel_fetch_noarm(struct intel_plane *plane,
 		y = (clip->y1 + plane_state->uapi.dst.y1);
 	val = y << 16;
 	val |= plane_state->uapi.dst.x1;
-	intel_de_write_fw(i915, SEL_FETCH_PLANE_POS(pipe, plane->id), val);
+	intel_de_write_dsb(display, dsb, SEL_FETCH_PLANE_POS(pipe, plane->id), val);
 
 	x = plane_state->view.color_plane[color_plane].x;
 
@@ -1391,20 +1408,21 @@ static void icl_plane_update_sel_fetch_noarm(struct intel_plane *plane,
 
 	val = y << 16 | x;
 
-	intel_de_write_fw(i915, SEL_FETCH_PLANE_OFFSET(pipe, plane->id),
-			  val);
+	intel_de_write_dsb(display, dsb, SEL_FETCH_PLANE_OFFSET(pipe, plane->id), val);
 
 	/* Sizes are 0 based */
 	val = (drm_rect_height(clip) - 1) << 16;
 	val |= (drm_rect_width(&plane_state->uapi.src) >> 16) - 1;
-	intel_de_write_fw(i915, SEL_FETCH_PLANE_SIZE(pipe, plane->id), val);
+	intel_de_write_dsb(display, dsb, SEL_FETCH_PLANE_SIZE(pipe, plane->id), val);
 }
 
 static void
-icl_plane_update_noarm(struct intel_plane *plane,
+icl_plane_update_noarm(struct intel_dsb *dsb,
+		       struct intel_plane *plane,
 		       const struct intel_crtc_state *crtc_state,
 		       const struct intel_plane_state *plane_state)
 {
+	struct intel_display *display = to_intel_display(plane->base.dev);
 	struct drm_i915_private *dev_priv = to_i915(plane->base.dev);
 	enum plane_id plane_id = plane->id;
 	enum pipe pipe = plane->pipe;
@@ -1428,76 +1446,82 @@ icl_plane_update_noarm(struct intel_plane *plane,
 		crtc_y = 0;
 	}
 
-	intel_de_write_fw(dev_priv, PLANE_STRIDE(pipe, plane_id),
-			  PLANE_STRIDE_(stride));
-	intel_de_write_fw(dev_priv, PLANE_POS(pipe, plane_id),
-			  PLANE_POS_Y(crtc_y) | PLANE_POS_X(crtc_x));
-	intel_de_write_fw(dev_priv, PLANE_SIZE(pipe, plane_id),
-			  PLANE_HEIGHT(src_h - 1) | PLANE_WIDTH(src_w - 1));
+	intel_de_write_dsb(display, dsb, PLANE_STRIDE(pipe, plane_id),
+			   PLANE_STRIDE_(stride));
+	intel_de_write_dsb(display, dsb, PLANE_POS(pipe, plane_id),
+			   PLANE_POS_Y(crtc_y) | PLANE_POS_X(crtc_x));
+	intel_de_write_dsb(display, dsb, PLANE_SIZE(pipe, plane_id),
+			   PLANE_HEIGHT(src_h - 1) | PLANE_WIDTH(src_w - 1));
 
-	intel_de_write_fw(dev_priv, PLANE_KEYVAL(pipe, plane_id), skl_plane_keyval(plane_state));
-	intel_de_write_fw(dev_priv, PLANE_KEYMSK(pipe, plane_id), skl_plane_keymsk(plane_state));
-	intel_de_write_fw(dev_priv, PLANE_KEYMAX(pipe, plane_id), skl_plane_keymax(plane_state));
+	intel_de_write_dsb(display, dsb, PLANE_KEYVAL(pipe, plane_id),
+			   skl_plane_keyval(plane_state));
+	intel_de_write_dsb(display, dsb, PLANE_KEYMSK(pipe, plane_id),
+			   skl_plane_keymsk(plane_state));
+	intel_de_write_dsb(display, dsb, PLANE_KEYMAX(pipe, plane_id),
+			   skl_plane_keymax(plane_state));
 
-	intel_de_write_fw(dev_priv, PLANE_OFFSET(pipe, plane_id),
-			  PLANE_OFFSET_Y(y) | PLANE_OFFSET_X(x));
+	intel_de_write_dsb(display, dsb, PLANE_OFFSET(pipe, plane_id),
+			   PLANE_OFFSET_Y(y) | PLANE_OFFSET_X(x));
 
 	if (intel_fb_is_rc_ccs_cc_modifier(fb->modifier)) {
-		intel_de_write_fw(dev_priv, PLANE_CC_VAL(pipe, plane_id, 0),
-				  lower_32_bits(plane_state->ccval));
-		intel_de_write_fw(dev_priv, PLANE_CC_VAL(pipe, plane_id, 1),
-				  upper_32_bits(plane_state->ccval));
+		intel_de_write_dsb(display, dsb, PLANE_CC_VAL(pipe, plane_id, 0),
+				   lower_32_bits(plane_state->ccval));
+		intel_de_write_dsb(display, dsb, PLANE_CC_VAL(pipe, plane_id, 1),
+				   upper_32_bits(plane_state->ccval));
 	}
 
 	/* FLAT CCS doesn't need to program AUX_DIST */
 	if (!HAS_FLAT_CCS(dev_priv) && DISPLAY_VER(dev_priv) < 20)
-		intel_de_write_fw(dev_priv, PLANE_AUX_DIST(pipe, plane_id),
-				  skl_plane_aux_dist(plane_state, color_plane));
+		intel_de_write_dsb(display, dsb, PLANE_AUX_DIST(pipe, plane_id),
+				   skl_plane_aux_dist(plane_state, color_plane));
 
 	if (icl_is_hdr_plane(dev_priv, plane_id))
-		intel_de_write_fw(dev_priv, PLANE_CUS_CTL(pipe, plane_id),
-				  plane_state->cus_ctl);
+		intel_de_write_dsb(display, dsb, PLANE_CUS_CTL(pipe, plane_id),
+				   plane_state->cus_ctl);
 
-	intel_de_write_fw(dev_priv, PLANE_COLOR_CTL(pipe, plane_id), plane_color_ctl);
+	intel_de_write_dsb(display, dsb, PLANE_COLOR_CTL(pipe, plane_id),
+			   plane_color_ctl);
 
 	if (fb->format->is_yuv && icl_is_hdr_plane(dev_priv, plane_id))
-		icl_program_input_csc(plane, crtc_state, plane_state);
+		icl_program_input_csc(dsb, plane, plane_state);
 
-	skl_write_plane_wm(plane, crtc_state);
+	skl_write_plane_wm(dsb, plane, crtc_state);
 
 	/*
 	 * FIXME: pxp session invalidation can hit any time even at time of commit
 	 * or after the commit, display content will be garbage.
 	 */
 	if (plane_state->force_black)
-		icl_plane_csc_load_black(plane);
+		icl_plane_csc_load_black(dsb, plane, crtc_state);
 
-	icl_plane_update_sel_fetch_noarm(plane, crtc_state, plane_state, color_plane);
+	icl_plane_update_sel_fetch_noarm(dsb, plane, crtc_state, plane_state, color_plane);
 }
 
-static void icl_plane_update_sel_fetch_arm(struct intel_plane *plane,
+static void icl_plane_update_sel_fetch_arm(struct intel_dsb *dsb,
+					   struct intel_plane *plane,
 					   const struct intel_crtc_state *crtc_state,
 					   const struct intel_plane_state *plane_state)
 {
-	struct drm_i915_private *i915 = to_i915(plane->base.dev);
+	struct intel_display *display = to_intel_display(plane->base.dev);
 	enum pipe pipe = plane->pipe;
 
 	if (!crtc_state->enable_psr2_sel_fetch)
 		return;
 
 	if (drm_rect_height(&plane_state->psr2_sel_fetch_area) > 0)
-		intel_de_write_fw(i915, SEL_FETCH_PLANE_CTL(pipe, plane->id),
-				  SEL_FETCH_PLANE_CTL_ENABLE);
+		intel_de_write_dsb(display, dsb, SEL_FETCH_PLANE_CTL(pipe, plane->id),
+				   SEL_FETCH_PLANE_CTL_ENABLE);
 	else
-		icl_plane_disable_sel_fetch_arm(plane, crtc_state);
+		icl_plane_disable_sel_fetch_arm(dsb, plane, crtc_state);
 }
 
 static void
-icl_plane_update_arm(struct intel_plane *plane,
+icl_plane_update_arm(struct intel_dsb *dsb,
+		     struct intel_plane *plane,
 		     const struct intel_crtc_state *crtc_state,
 		     const struct intel_plane_state *plane_state)
 {
-	struct drm_i915_private *dev_priv = to_i915(plane->base.dev);
+	struct intel_display *display = to_intel_display(plane->base.dev);
 	enum plane_id plane_id = plane->id;
 	enum pipe pipe = plane->pipe;
 	int color_plane = icl_plane_color_plane(plane_state);
@@ -1516,25 +1540,27 @@ icl_plane_update_arm(struct intel_plane *plane,
 	if (plane_state->scaler_id >= 0)
 		skl_program_plane_scaler(plane, crtc_state, plane_state);
 
-	icl_plane_update_sel_fetch_arm(plane, crtc_state, plane_state);
+	icl_plane_update_sel_fetch_arm(dsb, plane, crtc_state, plane_state);
 
 	/*
 	 * The control register self-arms if the plane was previously
 	 * disabled. Try to make the plane enable atomic by writing
 	 * the control register just before the surface register.
 	 */
-	intel_de_write_fw(dev_priv, PLANE_CTL(pipe, plane_id), plane_ctl);
-	intel_de_write_fw(dev_priv, PLANE_SURF(pipe, plane_id),
-			  skl_plane_surf(plane_state, color_plane));
+	intel_de_write_dsb(display, dsb, PLANE_CTL(pipe, plane_id),
+			   plane_ctl);
+	intel_de_write_dsb(display, dsb, PLANE_SURF(pipe, plane_id),
+			   skl_plane_surf(plane_state, color_plane));
 }
 
 static void
-skl_plane_async_flip(struct intel_plane *plane,
+skl_plane_async_flip(struct intel_dsb *dsb,
+		     struct intel_plane *plane,
 		     const struct intel_crtc_state *crtc_state,
 		     const struct intel_plane_state *plane_state,
 		     bool async_flip)
 {
-	struct drm_i915_private *dev_priv = to_i915(plane->base.dev);
+	struct intel_display *display = to_intel_display(plane->base.dev);
 	enum plane_id plane_id = plane->id;
 	enum pipe pipe = plane->pipe;
 	u32 plane_ctl = plane_state->ctl;
@@ -1544,9 +1570,10 @@ skl_plane_async_flip(struct intel_plane *plane,
 	if (async_flip)
 		plane_ctl |= PLANE_CTL_ASYNC_FLIP;
 
-	intel_de_write_fw(dev_priv, PLANE_CTL(pipe, plane_id), plane_ctl);
-	intel_de_write_fw(dev_priv, PLANE_SURF(pipe, plane_id),
-			  skl_plane_surf(plane_state, 0));
+	intel_de_write_dsb(display, dsb, PLANE_CTL(pipe, plane_id),
+			   plane_ctl);
+	intel_de_write_dsb(display, dsb, PLANE_SURF(pipe, plane_id),
+			   skl_plane_surf(plane_state, 0));
 }
 
 static bool intel_format_is_p01x(u32 format)
diff --git a/drivers/gpu/drm/imagination/pvr_fw_meta.c b/drivers/gpu/drm/imagination/pvr_fw_meta.c
index c39beb70c317..6d13864851fc 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_meta.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_meta.c
@@ -527,8 +527,10 @@ pvr_meta_vm_map(struct pvr_device *pvr_dev, struct pvr_fw_object *fw_obj)
 static void
 pvr_meta_vm_unmap(struct pvr_device *pvr_dev, struct pvr_fw_object *fw_obj)
 {
-	pvr_vm_unmap(pvr_dev->kernel_vm_ctx, fw_obj->fw_mm_node.start,
-		     fw_obj->fw_mm_node.size);
+	struct pvr_gem_object *pvr_obj = fw_obj->gem;
+
+	pvr_vm_unmap_obj(pvr_dev->kernel_vm_ctx, pvr_obj,
+			 fw_obj->fw_mm_node.start, fw_obj->fw_mm_node.size);
 }
 
 static bool
diff --git a/drivers/gpu/drm/imagination/pvr_fw_trace.c b/drivers/gpu/drm/imagination/pvr_fw_trace.c
index 73707daa4e52..5dbb636d7d4f 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_trace.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_trace.c
@@ -333,8 +333,8 @@ static int fw_trace_seq_show(struct seq_file *s, void *v)
 	if (sf_id == ROGUE_FW_SF_LAST)
 		return -EINVAL;
 
-	timestamp = read_fw_trace(trace_seq_data, 1) |
-		((u64)read_fw_trace(trace_seq_data, 2) << 32);
+	timestamp = ((u64)read_fw_trace(trace_seq_data, 1) << 32) |
+		read_fw_trace(trace_seq_data, 2);
 	timestamp = (timestamp & ~ROGUE_FWT_TIMESTAMP_TIME_CLRMSK) >>
 		ROGUE_FWT_TIMESTAMP_TIME_SHIFT;
 
diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index 20cb46012082..87780cc7c0c3 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -109,12 +109,20 @@ pvr_queue_fence_get_driver_name(struct dma_fence *f)
 	return PVR_DRIVER_NAME;
 }
 
+static void pvr_queue_fence_release_work(struct work_struct *w)
+{
+	struct pvr_queue_fence *fence = container_of(w, struct pvr_queue_fence, release_work);
+
+	pvr_context_put(fence->queue->ctx);
+	dma_fence_free(&fence->base);
+}
+
 static void pvr_queue_fence_release(struct dma_fence *f)
 {
 	struct pvr_queue_fence *fence = container_of(f, struct pvr_queue_fence, base);
+	struct pvr_device *pvr_dev = fence->queue->ctx->pvr_dev;
 
-	pvr_context_put(fence->queue->ctx);
-	dma_fence_free(f);
+	queue_work(pvr_dev->sched_wq, &fence->release_work);
 }
 
 static const char *
@@ -268,6 +276,7 @@ pvr_queue_fence_init(struct dma_fence *f,
 
 	pvr_context_get(queue->ctx);
 	fence->queue = queue;
+	INIT_WORK(&fence->release_work, pvr_queue_fence_release_work);
 	dma_fence_init(&fence->base, fence_ops,
 		       &fence_ctx->lock, fence_ctx->id,
 		       atomic_inc_return(&fence_ctx->seqno));
@@ -304,8 +313,9 @@ pvr_queue_cccb_fence_init(struct dma_fence *fence, struct pvr_queue *queue)
 static void
 pvr_queue_job_fence_init(struct dma_fence *fence, struct pvr_queue *queue)
 {
-	pvr_queue_fence_init(fence, queue, &pvr_queue_job_fence_ops,
-			     &queue->job_fence_ctx);
+	if (!fence->ops)
+		pvr_queue_fence_init(fence, queue, &pvr_queue_job_fence_ops,
+				     &queue->job_fence_ctx);
 }
 
 /**
diff --git a/drivers/gpu/drm/imagination/pvr_queue.h b/drivers/gpu/drm/imagination/pvr_queue.h
index e06ced69302f..93fe9ac9f58c 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.h
+++ b/drivers/gpu/drm/imagination/pvr_queue.h
@@ -5,6 +5,7 @@
 #define PVR_QUEUE_H
 
 #include <drm/gpu_scheduler.h>
+#include <linux/workqueue.h>
 
 #include "pvr_cccb.h"
 #include "pvr_device.h"
@@ -63,6 +64,9 @@ struct pvr_queue_fence {
 
 	/** @queue: Queue that created this fence. */
 	struct pvr_queue *queue;
+
+	/** @release_work: Fence release work structure. */
+	struct work_struct release_work;
 };
 
 /**
diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index 363f885a7098..2896fa7501b1 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -293,8 +293,9 @@ pvr_vm_bind_op_map_init(struct pvr_vm_bind_op *bind_op,
 
 static int
 pvr_vm_bind_op_unmap_init(struct pvr_vm_bind_op *bind_op,
-			  struct pvr_vm_context *vm_ctx, u64 device_addr,
-			  u64 size)
+			  struct pvr_vm_context *vm_ctx,
+			  struct pvr_gem_object *pvr_obj,
+			  u64 device_addr, u64 size)
 {
 	int err;
 
@@ -318,6 +319,7 @@ pvr_vm_bind_op_unmap_init(struct pvr_vm_bind_op *bind_op,
 		goto err_bind_op_fini;
 	}
 
+	bind_op->pvr_obj = pvr_obj;
 	bind_op->vm_ctx = vm_ctx;
 	bind_op->device_addr = device_addr;
 	bind_op->size = size;
@@ -597,20 +599,6 @@ pvr_vm_create_context(struct pvr_device *pvr_dev, bool is_userspace_context)
 	return ERR_PTR(err);
 }
 
-/**
- * pvr_vm_unmap_all() - Unmap all mappings associated with a VM context.
- * @vm_ctx: Target VM context.
- *
- * This function ensures that no mappings are left dangling by unmapping them
- * all in order of ascending device-virtual address.
- */
-void
-pvr_vm_unmap_all(struct pvr_vm_context *vm_ctx)
-{
-	WARN_ON(pvr_vm_unmap(vm_ctx, vm_ctx->gpuvm_mgr.mm_start,
-			     vm_ctx->gpuvm_mgr.mm_range));
-}
-
 /**
  * pvr_vm_context_release() - Teardown a VM context.
  * @ref_count: Pointer to reference counter of the VM context.
@@ -703,11 +691,7 @@ pvr_vm_lock_extra(struct drm_gpuvm_exec *vm_exec)
 	struct pvr_vm_bind_op *bind_op = vm_exec->extra.priv;
 	struct pvr_gem_object *pvr_obj = bind_op->pvr_obj;
 
-	/* Unmap operations don't have an object to lock. */
-	if (!pvr_obj)
-		return 0;
-
-	/* Acquire lock on the GEM being mapped. */
+	/* Acquire lock on the GEM object being mapped/unmapped. */
 	return drm_exec_lock_obj(&vm_exec->exec, gem_from_pvr_gem(pvr_obj));
 }
 
@@ -772,8 +756,10 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pvr_gem_object *pvr_obj,
 }
 
 /**
- * pvr_vm_unmap() - Unmap an already mapped section of device-virtual memory.
+ * pvr_vm_unmap_obj_locked() - Unmap an already mapped section of device-virtual
+ * memory.
  * @vm_ctx: Target VM context.
+ * @pvr_obj: Target PowerVR memory object.
  * @device_addr: Virtual device address at the start of the target mapping.
  * @size: Size of the target mapping.
  *
@@ -784,9 +770,13 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pvr_gem_object *pvr_obj,
  *  * Any error encountered while performing internal operations required to
  *    destroy the mapping (returned from pvr_vm_gpuva_unmap or
  *    pvr_vm_gpuva_remap).
+ *
+ * The vm_ctx->lock must be held when calling this function.
  */
-int
-pvr_vm_unmap(struct pvr_vm_context *vm_ctx, u64 device_addr, u64 size)
+static int
+pvr_vm_unmap_obj_locked(struct pvr_vm_context *vm_ctx,
+			struct pvr_gem_object *pvr_obj,
+			u64 device_addr, u64 size)
 {
 	struct pvr_vm_bind_op bind_op = {0};
 	struct drm_gpuvm_exec vm_exec = {
@@ -799,11 +789,13 @@ pvr_vm_unmap(struct pvr_vm_context *vm_ctx, u64 device_addr, u64 size)
 		},
 	};
 
-	int err = pvr_vm_bind_op_unmap_init(&bind_op, vm_ctx, device_addr,
-					    size);
+	int err = pvr_vm_bind_op_unmap_init(&bind_op, vm_ctx, pvr_obj,
+					    device_addr, size);
 	if (err)
 		return err;
 
+	pvr_gem_object_get(pvr_obj);
+
 	err = drm_gpuvm_exec_lock(&vm_exec);
 	if (err)
 		goto err_cleanup;
@@ -818,6 +810,96 @@ pvr_vm_unmap(struct pvr_vm_context *vm_ctx, u64 device_addr, u64 size)
 	return err;
 }
 
+/**
+ * pvr_vm_unmap_obj() - Unmap an already mapped section of device-virtual
+ * memory.
+ * @vm_ctx: Target VM context.
+ * @pvr_obj: Target PowerVR memory object.
+ * @device_addr: Virtual device address at the start of the target mapping.
+ * @size: Size of the target mapping.
+ *
+ * Return:
+ *  * 0 on success,
+ *  * Any error encountered by pvr_vm_unmap_obj_locked.
+ */
+int
+pvr_vm_unmap_obj(struct pvr_vm_context *vm_ctx, struct pvr_gem_object *pvr_obj,
+		 u64 device_addr, u64 size)
+{
+	int err;
+
+	mutex_lock(&vm_ctx->lock);
+	err = pvr_vm_unmap_obj_locked(vm_ctx, pvr_obj, device_addr, size);
+	mutex_unlock(&vm_ctx->lock);
+
+	return err;
+}
+
+/**
+ * pvr_vm_unmap() - Unmap an already mapped section of device-virtual memory.
+ * @vm_ctx: Target VM context.
+ * @device_addr: Virtual device address at the start of the target mapping.
+ * @size: Size of the target mapping.
+ *
+ * Return:
+ *  * 0 on success,
+ *  * Any error encountered by drm_gpuva_find,
+ *  * Any error encountered by pvr_vm_unmap_obj_locked.
+ */
+int
+pvr_vm_unmap(struct pvr_vm_context *vm_ctx, u64 device_addr, u64 size)
+{
+	struct pvr_gem_object *pvr_obj;
+	struct drm_gpuva *va;
+	int err;
+
+	mutex_lock(&vm_ctx->lock);
+
+	va = drm_gpuva_find(&vm_ctx->gpuvm_mgr, device_addr, size);
+	if (va) {
+		pvr_obj = gem_to_pvr_gem(va->gem.obj);
+		err = pvr_vm_unmap_obj_locked(vm_ctx, pvr_obj,
+					      va->va.addr, va->va.range);
+	} else {
+		err = -ENOENT;
+	}
+
+	mutex_unlock(&vm_ctx->lock);
+
+	return err;
+}
+
+/**
+ * pvr_vm_unmap_all() - Unmap all mappings associated with a VM context.
+ * @vm_ctx: Target VM context.
+ *
+ * This function ensures that no mappings are left dangling by unmapping them
+ * all in order of ascending device-virtual address.
+ */
+void
+pvr_vm_unmap_all(struct pvr_vm_context *vm_ctx)
+{
+	mutex_lock(&vm_ctx->lock);
+
+	for (;;) {
+		struct pvr_gem_object *pvr_obj;
+		struct drm_gpuva *va;
+
+		va = drm_gpuva_find_first(&vm_ctx->gpuvm_mgr,
+					  vm_ctx->gpuvm_mgr.mm_start,
+					  vm_ctx->gpuvm_mgr.mm_range);
+		if (!va)
+			break;
+
+		pvr_obj = gem_to_pvr_gem(va->gem.obj);
+
+		WARN_ON(pvr_vm_unmap_obj_locked(vm_ctx, pvr_obj,
+						va->va.addr, va->va.range));
+	}
+
+	mutex_unlock(&vm_ctx->lock);
+}
+
 /* Static data areas are determined by firmware. */
 static const struct drm_pvr_static_data_area static_data_areas[] = {
 	{
diff --git a/drivers/gpu/drm/imagination/pvr_vm.h b/drivers/gpu/drm/imagination/pvr_vm.h
index 79406243617c..b0528dffa7f1 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.h
+++ b/drivers/gpu/drm/imagination/pvr_vm.h
@@ -38,6 +38,9 @@ struct pvr_vm_context *pvr_vm_create_context(struct pvr_device *pvr_dev,
 int pvr_vm_map(struct pvr_vm_context *vm_ctx,
 	       struct pvr_gem_object *pvr_obj, u64 pvr_obj_offset,
 	       u64 device_addr, u64 size);
+int pvr_vm_unmap_obj(struct pvr_vm_context *vm_ctx,
+		     struct pvr_gem_object *pvr_obj,
+		     u64 device_addr, u64 size);
 int pvr_vm_unmap(struct pvr_vm_context *vm_ctx, u64 device_addr, u64 size);
 void pvr_vm_unmap_all(struct pvr_vm_context *vm_ctx);
 
diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index ceef470c9fbf..1050a4617fc1 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -4,6 +4,8 @@ config DRM_NOUVEAU
 	depends on DRM && PCI && MMU
 	select IOMMU_API
 	select FW_LOADER
+	select FW_CACHE if PM_SLEEP
+	select DRM_CLIENT_SELECTION
 	select DRM_DISPLAY_DP_HELPER
 	select DRM_DISPLAY_HDMI_HELPER
 	select DRM_DISPLAY_HELPER
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 34985771b2a2..6e5adab03471 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -31,6 +31,7 @@
 #include <linux/dynamic_debug.h>
 
 #include <drm/drm_aperture.h>
+#include <drm/drm_client_setup.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_ttm.h>
 #include <drm/drm_gem_ttm_helper.h>
@@ -836,6 +837,7 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
 {
 	struct nvkm_device *device;
 	struct nouveau_drm *drm;
+	const struct drm_format_info *format;
 	int ret;
 
 	if (vga_switcheroo_client_probe_defer(pdev))
@@ -873,9 +875,11 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
 		goto fail_pci;
 
 	if (drm->client.device.info.ram_size <= 32 * 1024 * 1024)
-		drm_fbdev_ttm_setup(drm->dev, 8);
+		format = drm_format_info(DRM_FORMAT_C8);
 	else
-		drm_fbdev_ttm_setup(drm->dev, 32);
+		format = NULL;
+
+	drm_client_setup(drm->dev, format);
 
 	quirk_broken_nv_runpm(pdev);
 	return 0;
@@ -1318,6 +1322,8 @@ driver_stub = {
 	.dumb_create = nouveau_display_dumb_create,
 	.dumb_map_offset = drm_gem_ttm_dumb_map_offset,
 
+	DRM_FBDEV_TTM_DRIVER_OPS,
+
 	.name = DRIVER_NAME,
 	.desc = DRIVER_DESC,
 #ifdef GIT_REVISION
diff --git a/drivers/gpu/drm/radeon/r300.c b/drivers/gpu/drm/radeon/r300.c
index 05c13102a8cb..d22889fbfa9c 100644
--- a/drivers/gpu/drm/radeon/r300.c
+++ b/drivers/gpu/drm/radeon/r300.c
@@ -359,7 +359,8 @@ int r300_mc_wait_for_idle(struct radeon_device *rdev)
 	return -1;
 }
 
-static void r300_gpu_init(struct radeon_device *rdev)
+/* rs400_gpu_init also calls this! */
+void r300_gpu_init(struct radeon_device *rdev)
 {
 	uint32_t gb_tile_config, tmp;
 
diff --git a/drivers/gpu/drm/radeon/radeon_asic.h b/drivers/gpu/drm/radeon/radeon_asic.h
index 1e00f6b99f94..8f5e07834fcc 100644
--- a/drivers/gpu/drm/radeon/radeon_asic.h
+++ b/drivers/gpu/drm/radeon/radeon_asic.h
@@ -165,6 +165,7 @@ void r200_set_safe_registers(struct radeon_device *rdev);
  */
 extern int r300_init(struct radeon_device *rdev);
 extern void r300_fini(struct radeon_device *rdev);
+extern void r300_gpu_init(struct radeon_device *rdev);
 extern int r300_suspend(struct radeon_device *rdev);
 extern int r300_resume(struct radeon_device *rdev);
 extern int r300_asic_reset(struct radeon_device *rdev, bool hard);
diff --git a/drivers/gpu/drm/radeon/rs400.c b/drivers/gpu/drm/radeon/rs400.c
index d6c18fd740ec..13cd0a688a65 100644
--- a/drivers/gpu/drm/radeon/rs400.c
+++ b/drivers/gpu/drm/radeon/rs400.c
@@ -256,8 +256,22 @@ int rs400_mc_wait_for_idle(struct radeon_device *rdev)
 
 static void rs400_gpu_init(struct radeon_device *rdev)
 {
-	/* FIXME: is this correct ? */
-	r420_pipes_init(rdev);
+	/* Earlier code was calling r420_pipes_init and then
+	 * rs400_mc_wait_for_idle(rdev). The problem is that
+	 * at least on my Mobility Radeon Xpress 200M RC410 card
+	 * that ends up in this code path ends up num_gb_pipes == 3
+	 * while the card seems to have only one pipe. With the
+	 * r420 pipe initialization method.
+	 *
+	 * Problems shown up as HyperZ glitches, see:
+	 * https://bugs.freedesktop.org/show_bug.cgi?id=110897
+	 *
+	 * Delegating initialization to r300 code seems to work
+	 * and results in proper pipe numbers. The rs400 cards
+	 * are said to be not r400, but r300 kind of cards.
+	 */
+	r300_gpu_init(rdev);
+
 	if (rs400_mc_wait_for_idle(rdev)) {
 		pr_warn("rs400: Failed to wait MC idle while programming pipes. Bad things might happen. %08x\n",
 			RREG32(RADEON_MC_STATUS));
diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
index c75302ca3427..f56e77e7f6d0 100644
--- a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
+++ b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
@@ -21,7 +21,7 @@
  *
  */
 
-#if !defined(_GPU_SCHED_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#if !defined(_GPU_SCHED_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
 #define _GPU_SCHED_TRACE_H_
 
 #include <linux/stringify.h>
@@ -106,7 +106,7 @@ TRACE_EVENT(drm_sched_job_wait_dep,
 		      __entry->seqno)
 );
 
-#endif
+#endif /* _GPU_SCHED_TRACE_H_ */
 
 /* This part must be outside protection */
 #undef TRACE_INCLUDE_PATH
diff --git a/drivers/gpu/drm/xe/display/xe_plane_initial.c b/drivers/gpu/drm/xe/display/xe_plane_initial.c
index a50ab9eae40a..f99d38cc5d8e 100644
--- a/drivers/gpu/drm/xe/display/xe_plane_initial.c
+++ b/drivers/gpu/drm/xe/display/xe_plane_initial.c
@@ -194,8 +194,6 @@ intel_find_initial_plane_obj(struct intel_crtc *crtc,
 		to_intel_plane(crtc->base.primary);
 	struct intel_plane_state *plane_state =
 		to_intel_plane_state(plane->base.state);
-	struct intel_crtc_state *crtc_state =
-		to_intel_crtc_state(crtc->base.state);
 	struct drm_framebuffer *fb;
 	struct i915_vma *vma;
 
@@ -241,14 +239,6 @@ intel_find_initial_plane_obj(struct intel_crtc *crtc,
 	atomic_or(plane->frontbuffer_bit, &to_intel_frontbuffer(fb)->bits);
 
 	plane_config->vma = vma;
-
-	/*
-	 * Flip to the newly created mapping ASAP, so we can re-use the
-	 * first part of GGTT for WOPCM, prevent flickering, and prevent
-	 * the lookup of sysmem scratch pages.
-	 */
-	plane->check_plane(crtc_state, plane_state);
-	plane->async_flip(plane, crtc_state, plane_state, true);
 	return;
 
 nofb:
diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index b940688c3613..98fe8573e054 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -379,9 +379,7 @@ int xe_gt_init_early(struct xe_gt *gt)
 	if (err)
 		return err;
 
-	xe_wa_process_gt(gt);
 	xe_wa_process_oob(gt);
-	xe_tuning_process_gt(gt);
 
 	xe_force_wake_init_gt(gt, gt_to_fw(gt));
 	spin_lock_init(&gt->global_invl_lock);
@@ -469,6 +467,8 @@ static int all_fw_domain_init(struct xe_gt *gt)
 		goto err_hw_fence_irq;
 
 	xe_gt_mcr_set_implicit_defaults(gt);
+	xe_wa_process_gt(gt);
+	xe_tuning_process_gt(gt);
 	xe_reg_sr_apply_mmio(&gt->reg_sr, gt);
 
 	err = xe_gt_clock_init(gt);
diff --git a/drivers/gpu/drm/xe/xe_hmm.c b/drivers/gpu/drm/xe/xe_hmm.c
index 2c32dc46f7d4..d7a9408b3a97 100644
--- a/drivers/gpu/drm/xe/xe_hmm.c
+++ b/drivers/gpu/drm/xe/xe_hmm.c
@@ -19,11 +19,10 @@ static u64 xe_npages_in_range(unsigned long start, unsigned long end)
 	return (end - start) >> PAGE_SHIFT;
 }
 
-/*
+/**
  * xe_mark_range_accessed() - mark a range is accessed, so core mm
  * have such information for memory eviction or write back to
  * hard disk
- *
  * @range: the range to mark
  * @write: if write to this range, we mark pages in this range
  * as dirty
@@ -43,15 +42,51 @@ static void xe_mark_range_accessed(struct hmm_range *range, bool write)
 	}
 }
 
-/*
+static int xe_alloc_sg(struct xe_device *xe, struct sg_table *st,
+		       struct hmm_range *range, struct rw_semaphore *notifier_sem)
+{
+	unsigned long i, npages, hmm_pfn;
+	unsigned long num_chunks = 0;
+	int ret;
+
+	/* HMM docs says this is needed. */
+	ret = down_read_interruptible(notifier_sem);
+	if (ret)
+		return ret;
+
+	if (mmu_interval_read_retry(range->notifier, range->notifier_seq)) {
+		up_read(notifier_sem);
+		return -EAGAIN;
+	}
+
+	npages = xe_npages_in_range(range->start, range->end);
+	for (i = 0; i < npages;) {
+		unsigned long len;
+
+		hmm_pfn = range->hmm_pfns[i];
+		xe_assert(xe, hmm_pfn & HMM_PFN_VALID);
+
+		len = 1UL << hmm_pfn_to_map_order(hmm_pfn);
+
+		/* If order > 0 the page may extend beyond range->start */
+		len -= (hmm_pfn & ~HMM_PFN_FLAGS) & (len - 1);
+		i += len;
+		num_chunks++;
+	}
+	up_read(notifier_sem);
+
+	return sg_alloc_table(st, num_chunks, GFP_KERNEL);
+}
+
+/**
  * xe_build_sg() - build a scatter gather table for all the physical pages/pfn
  * in a hmm_range. dma-map pages if necessary. dma-address is save in sg table
  * and will be used to program GPU page table later.
- *
  * @xe: the xe device who will access the dma-address in sg table
  * @range: the hmm range that we build the sg table from. range->hmm_pfns[]
  * has the pfn numbers of pages that back up this hmm address range.
  * @st: pointer to the sg table.
+ * @notifier_sem: The xe notifier lock.
  * @write: whether we write to this range. This decides dma map direction
  * for system pages. If write we map it bi-diretional; otherwise
  * DMA_TO_DEVICE
@@ -78,43 +113,84 @@ static void xe_mark_range_accessed(struct hmm_range *range, bool write)
  * Returns 0 if successful; -ENOMEM if fails to allocate memory
  */
 static int xe_build_sg(struct xe_device *xe, struct hmm_range *range,
-		       struct sg_table *st, bool write)
+		       struct sg_table *st,
+		       struct rw_semaphore *notifier_sem,
+		       bool write)
 {
+	unsigned long npages = xe_npages_in_range(range->start, range->end);
 	struct device *dev = xe->drm.dev;
-	struct page **pages;
-	u64 i, npages;
-	int ret;
+	struct scatterlist *sgl;
+	struct page *page;
+	unsigned long i, j;
 
-	npages = xe_npages_in_range(range->start, range->end);
-	pages = kvmalloc_array(npages, sizeof(*pages), GFP_KERNEL);
-	if (!pages)
-		return -ENOMEM;
+	lockdep_assert_held(notifier_sem);
 
-	for (i = 0; i < npages; i++) {
-		pages[i] = hmm_pfn_to_page(range->hmm_pfns[i]);
-		xe_assert(xe, !is_device_private_page(pages[i]));
+	i = 0;
+	for_each_sg(st->sgl, sgl, st->nents, j) {
+		unsigned long hmm_pfn, size;
+
+		hmm_pfn = range->hmm_pfns[i];
+		page = hmm_pfn_to_page(hmm_pfn);
+		xe_assert(xe, !is_device_private_page(page));
+
+		size = 1UL << hmm_pfn_to_map_order(hmm_pfn);
+		size -= page_to_pfn(page) & (size - 1);
+		i += size;
+
+		if (unlikely(j == st->nents - 1)) {
+			if (i > npages)
+				size -= (i - npages);
+			sg_mark_end(sgl);
+		}
+		sg_set_page(sgl, page, size << PAGE_SHIFT, 0);
 	}
+	xe_assert(xe, i == npages);
 
-	ret = sg_alloc_table_from_pages_segment(st, pages, npages, 0, npages << PAGE_SHIFT,
-						xe_sg_segment_size(dev), GFP_KERNEL);
-	if (ret)
-		goto free_pages;
+	return dma_map_sgtable(dev, st, write ? DMA_BIDIRECTIONAL : DMA_TO_DEVICE,
+			       DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_NO_KERNEL_MAPPING);
+}
+
+static void xe_hmm_userptr_set_mapped(struct xe_userptr_vma *uvma)
+{
+	struct xe_userptr *userptr = &uvma->userptr;
+	struct xe_vm *vm = xe_vma_vm(&uvma->vma);
+
+	lockdep_assert_held_write(&vm->lock);
+	lockdep_assert_held(&vm->userptr.notifier_lock);
+
+	mutex_lock(&userptr->unmap_mutex);
+	xe_assert(vm->xe, !userptr->mapped);
+	userptr->mapped = true;
+	mutex_unlock(&userptr->unmap_mutex);
+}
+
+void xe_hmm_userptr_unmap(struct xe_userptr_vma *uvma)
+{
+	struct xe_userptr *userptr = &uvma->userptr;
+	struct xe_vma *vma = &uvma->vma;
+	bool write = !xe_vma_read_only(vma);
+	struct xe_vm *vm = xe_vma_vm(vma);
+	struct xe_device *xe = vm->xe;
 
-	ret = dma_map_sgtable(dev, st, write ? DMA_BIDIRECTIONAL : DMA_TO_DEVICE,
-			      DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_NO_KERNEL_MAPPING);
-	if (ret) {
-		sg_free_table(st);
-		st = NULL;
+	if (!lockdep_is_held_type(&vm->userptr.notifier_lock, 0) &&
+	    !lockdep_is_held_type(&vm->lock, 0) &&
+	    !(vma->gpuva.flags & XE_VMA_DESTROYED)) {
+		/* Don't unmap in exec critical section. */
+		xe_vm_assert_held(vm);
+		/* Don't unmap while mapping the sg. */
+		lockdep_assert_held(&vm->lock);
 	}
 
-free_pages:
-	kvfree(pages);
-	return ret;
+	mutex_lock(&userptr->unmap_mutex);
+	if (userptr->sg && userptr->mapped)
+		dma_unmap_sgtable(xe->drm.dev, userptr->sg,
+				  write ? DMA_BIDIRECTIONAL : DMA_TO_DEVICE, 0);
+	userptr->mapped = false;
+	mutex_unlock(&userptr->unmap_mutex);
 }
 
-/*
+/**
  * xe_hmm_userptr_free_sg() - Free the scatter gather table of userptr
- *
  * @uvma: the userptr vma which hold the scatter gather table
  *
  * With function xe_userptr_populate_range, we allocate storage of
@@ -124,16 +200,9 @@ static int xe_build_sg(struct xe_device *xe, struct hmm_range *range,
 void xe_hmm_userptr_free_sg(struct xe_userptr_vma *uvma)
 {
 	struct xe_userptr *userptr = &uvma->userptr;
-	struct xe_vma *vma = &uvma->vma;
-	bool write = !xe_vma_read_only(vma);
-	struct xe_vm *vm = xe_vma_vm(vma);
-	struct xe_device *xe = vm->xe;
-	struct device *dev = xe->drm.dev;
-
-	xe_assert(xe, userptr->sg);
-	dma_unmap_sgtable(dev, userptr->sg,
-			  write ? DMA_BIDIRECTIONAL : DMA_TO_DEVICE, 0);
 
+	xe_assert(xe_vma_vm(&uvma->vma)->xe, userptr->sg);
+	xe_hmm_userptr_unmap(uvma);
 	sg_free_table(userptr->sg);
 	userptr->sg = NULL;
 }
@@ -166,13 +235,20 @@ int xe_hmm_userptr_populate_range(struct xe_userptr_vma *uvma,
 {
 	unsigned long timeout =
 		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
-	unsigned long *pfns, flags = HMM_PFN_REQ_FAULT;
+	unsigned long *pfns;
 	struct xe_userptr *userptr;
 	struct xe_vma *vma = &uvma->vma;
 	u64 userptr_start = xe_vma_userptr(vma);
 	u64 userptr_end = userptr_start + xe_vma_size(vma);
 	struct xe_vm *vm = xe_vma_vm(vma);
-	struct hmm_range hmm_range;
+	struct hmm_range hmm_range = {
+		.pfn_flags_mask = 0, /* ignore pfns */
+		.default_flags = HMM_PFN_REQ_FAULT,
+		.start = userptr_start,
+		.end = userptr_end,
+		.notifier = &uvma->userptr.notifier,
+		.dev_private_owner = vm->xe,
+	};
 	bool write = !xe_vma_read_only(vma);
 	unsigned long notifier_seq;
 	u64 npages;
@@ -199,19 +275,14 @@ int xe_hmm_userptr_populate_range(struct xe_userptr_vma *uvma,
 		return -ENOMEM;
 
 	if (write)
-		flags |= HMM_PFN_REQ_WRITE;
+		hmm_range.default_flags |= HMM_PFN_REQ_WRITE;
 
 	if (!mmget_not_zero(userptr->notifier.mm)) {
 		ret = -EFAULT;
 		goto free_pfns;
 	}
 
-	hmm_range.default_flags = flags;
 	hmm_range.hmm_pfns = pfns;
-	hmm_range.notifier = &userptr->notifier;
-	hmm_range.start = userptr_start;
-	hmm_range.end = userptr_end;
-	hmm_range.dev_private_owner = vm->xe;
 
 	while (true) {
 		hmm_range.notifier_seq = mmu_interval_read_begin(&userptr->notifier);
@@ -238,16 +309,37 @@ int xe_hmm_userptr_populate_range(struct xe_userptr_vma *uvma,
 	if (ret)
 		goto free_pfns;
 
-	ret = xe_build_sg(vm->xe, &hmm_range, &userptr->sgt, write);
+	ret = xe_alloc_sg(vm->xe, &userptr->sgt, &hmm_range, &vm->userptr.notifier_lock);
 	if (ret)
 		goto free_pfns;
 
+	ret = down_read_interruptible(&vm->userptr.notifier_lock);
+	if (ret)
+		goto free_st;
+
+	if (mmu_interval_read_retry(hmm_range.notifier, hmm_range.notifier_seq)) {
+		ret = -EAGAIN;
+		goto out_unlock;
+	}
+
+	ret = xe_build_sg(vm->xe, &hmm_range, &userptr->sgt,
+			  &vm->userptr.notifier_lock, write);
+	if (ret)
+		goto out_unlock;
+
 	xe_mark_range_accessed(&hmm_range, write);
 	userptr->sg = &userptr->sgt;
+	xe_hmm_userptr_set_mapped(uvma);
 	userptr->notifier_seq = hmm_range.notifier_seq;
+	up_read(&vm->userptr.notifier_lock);
+	kvfree(pfns);
+	return 0;
 
+out_unlock:
+	up_read(&vm->userptr.notifier_lock);
+free_st:
+	sg_free_table(&userptr->sgt);
 free_pfns:
 	kvfree(pfns);
 	return ret;
 }
-
diff --git a/drivers/gpu/drm/xe/xe_hmm.h b/drivers/gpu/drm/xe/xe_hmm.h
index 909dc2bdcd97..0ea98d8e7bbc 100644
--- a/drivers/gpu/drm/xe/xe_hmm.h
+++ b/drivers/gpu/drm/xe/xe_hmm.h
@@ -3,9 +3,16 @@
  * Copyright © 2024 Intel Corporation
  */
 
+#ifndef _XE_HMM_H_
+#define _XE_HMM_H_
+
 #include <linux/types.h>
 
 struct xe_userptr_vma;
 
 int xe_hmm_userptr_populate_range(struct xe_userptr_vma *uvma, bool is_mm_mmap_locked);
+
 void xe_hmm_userptr_free_sg(struct xe_userptr_vma *uvma);
+
+void xe_hmm_userptr_unmap(struct xe_userptr_vma *uvma);
+#endif
diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index 797576690356..230cf47fb9c5 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -28,6 +28,8 @@ struct xe_pt_dir {
 	struct xe_pt pt;
 	/** @children: Array of page-table child nodes */
 	struct xe_ptw *children[XE_PDES];
+	/** @staging: Array of page-table staging nodes */
+	struct xe_ptw *staging[XE_PDES];
 };
 
 #if IS_ENABLED(CONFIG_DRM_XE_DEBUG_VM)
@@ -48,9 +50,10 @@ static struct xe_pt_dir *as_xe_pt_dir(struct xe_pt *pt)
 	return container_of(pt, struct xe_pt_dir, pt);
 }
 
-static struct xe_pt *xe_pt_entry(struct xe_pt_dir *pt_dir, unsigned int index)
+static struct xe_pt *
+xe_pt_entry_staging(struct xe_pt_dir *pt_dir, unsigned int index)
 {
-	return container_of(pt_dir->children[index], struct xe_pt, base);
+	return container_of(pt_dir->staging[index], struct xe_pt, base);
 }
 
 static u64 __xe_pt_empty_pte(struct xe_tile *tile, struct xe_vm *vm,
@@ -125,6 +128,7 @@ struct xe_pt *xe_pt_create(struct xe_vm *vm, struct xe_tile *tile,
 	}
 	pt->bo = bo;
 	pt->base.children = level ? as_xe_pt_dir(pt)->children : NULL;
+	pt->base.staging = level ? as_xe_pt_dir(pt)->staging : NULL;
 
 	if (vm->xef)
 		xe_drm_client_add_bo(vm->xef->client, pt->bo);
@@ -205,8 +209,8 @@ void xe_pt_destroy(struct xe_pt *pt, u32 flags, struct llist_head *deferred)
 		struct xe_pt_dir *pt_dir = as_xe_pt_dir(pt);
 
 		for (i = 0; i < XE_PDES; i++) {
-			if (xe_pt_entry(pt_dir, i))
-				xe_pt_destroy(xe_pt_entry(pt_dir, i), flags,
+			if (xe_pt_entry_staging(pt_dir, i))
+				xe_pt_destroy(xe_pt_entry_staging(pt_dir, i), flags,
 					      deferred);
 		}
 	}
@@ -375,8 +379,10 @@ xe_pt_insert_entry(struct xe_pt_stage_bind_walk *xe_walk, struct xe_pt *parent,
 		/* Continue building a non-connected subtree. */
 		struct iosys_map *map = &parent->bo->vmap;
 
-		if (unlikely(xe_child))
+		if (unlikely(xe_child)) {
 			parent->base.children[offset] = &xe_child->base;
+			parent->base.staging[offset] = &xe_child->base;
+		}
 
 		xe_pt_write(xe_walk->vm->xe, map, offset, pte);
 		parent->num_live++;
@@ -613,6 +619,7 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
 			.ops = &xe_pt_stage_bind_ops,
 			.shifts = xe_normal_pt_shifts,
 			.max_level = XE_PT_HIGHEST_LEVEL,
+			.staging = true,
 		},
 		.vm = xe_vma_vm(vma),
 		.tile = tile,
@@ -872,7 +879,7 @@ static void xe_pt_cancel_bind(struct xe_vma *vma,
 	}
 }
 
-static void xe_pt_commit_locks_assert(struct xe_vma *vma)
+static void xe_pt_commit_prepare_locks_assert(struct xe_vma *vma)
 {
 	struct xe_vm *vm = xe_vma_vm(vma);
 
@@ -884,6 +891,16 @@ static void xe_pt_commit_locks_assert(struct xe_vma *vma)
 	xe_vm_assert_held(vm);
 }
 
+static void xe_pt_commit_locks_assert(struct xe_vma *vma)
+{
+	struct xe_vm *vm = xe_vma_vm(vma);
+
+	xe_pt_commit_prepare_locks_assert(vma);
+
+	if (xe_vma_is_userptr(vma))
+		lockdep_assert_held_read(&vm->userptr.notifier_lock);
+}
+
 static void xe_pt_commit(struct xe_vma *vma,
 			 struct xe_vm_pgtable_update *entries,
 			 u32 num_entries, struct llist_head *deferred)
@@ -894,13 +911,17 @@ static void xe_pt_commit(struct xe_vma *vma,
 
 	for (i = 0; i < num_entries; i++) {
 		struct xe_pt *pt = entries[i].pt;
+		struct xe_pt_dir *pt_dir;
 
 		if (!pt->level)
 			continue;
 
+		pt_dir = as_xe_pt_dir(pt);
 		for (j = 0; j < entries[i].qwords; j++) {
 			struct xe_pt *oldpte = entries[i].pt_entries[j].pt;
+			int j_ = j + entries[i].ofs;
 
+			pt_dir->children[j_] = pt_dir->staging[j_];
 			xe_pt_destroy(oldpte, xe_vma_vm(vma)->flags, deferred);
 		}
 	}
@@ -912,7 +933,7 @@ static void xe_pt_abort_bind(struct xe_vma *vma,
 {
 	int i, j;
 
-	xe_pt_commit_locks_assert(vma);
+	xe_pt_commit_prepare_locks_assert(vma);
 
 	for (i = num_entries - 1; i >= 0; --i) {
 		struct xe_pt *pt = entries[i].pt;
@@ -927,10 +948,10 @@ static void xe_pt_abort_bind(struct xe_vma *vma,
 		pt_dir = as_xe_pt_dir(pt);
 		for (j = 0; j < entries[i].qwords; j++) {
 			u32 j_ = j + entries[i].ofs;
-			struct xe_pt *newpte = xe_pt_entry(pt_dir, j_);
+			struct xe_pt *newpte = xe_pt_entry_staging(pt_dir, j_);
 			struct xe_pt *oldpte = entries[i].pt_entries[j].pt;
 
-			pt_dir->children[j_] = oldpte ? &oldpte->base : 0;
+			pt_dir->staging[j_] = oldpte ? &oldpte->base : 0;
 			xe_pt_destroy(newpte, xe_vma_vm(vma)->flags, NULL);
 		}
 	}
@@ -942,7 +963,7 @@ static void xe_pt_commit_prepare_bind(struct xe_vma *vma,
 {
 	u32 i, j;
 
-	xe_pt_commit_locks_assert(vma);
+	xe_pt_commit_prepare_locks_assert(vma);
 
 	for (i = 0; i < num_entries; i++) {
 		struct xe_pt *pt = entries[i].pt;
@@ -960,10 +981,10 @@ static void xe_pt_commit_prepare_bind(struct xe_vma *vma,
 			struct xe_pt *newpte = entries[i].pt_entries[j].pt;
 			struct xe_pt *oldpte = NULL;
 
-			if (xe_pt_entry(pt_dir, j_))
-				oldpte = xe_pt_entry(pt_dir, j_);
+			if (xe_pt_entry_staging(pt_dir, j_))
+				oldpte = xe_pt_entry_staging(pt_dir, j_);
 
-			pt_dir->children[j_] = &newpte->base;
+			pt_dir->staging[j_] = &newpte->base;
 			entries[i].pt_entries[j].pt = oldpte;
 		}
 	}
@@ -1212,42 +1233,22 @@ static int vma_check_userptr(struct xe_vm *vm, struct xe_vma *vma,
 		return 0;
 
 	uvma = to_userptr_vma(vma);
-	notifier_seq = uvma->userptr.notifier_seq;
+	if (xe_pt_userptr_inject_eagain(uvma))
+		xe_vma_userptr_force_invalidate(uvma);
 
-	if (uvma->userptr.initial_bind && !xe_vm_in_fault_mode(vm))
-		return 0;
+	notifier_seq = uvma->userptr.notifier_seq;
 
 	if (!mmu_interval_read_retry(&uvma->userptr.notifier,
-				     notifier_seq) &&
-	    !xe_pt_userptr_inject_eagain(uvma))
+				     notifier_seq))
 		return 0;
 
-	if (xe_vm_in_fault_mode(vm)) {
+	if (xe_vm_in_fault_mode(vm))
 		return -EAGAIN;
-	} else {
-		spin_lock(&vm->userptr.invalidated_lock);
-		list_move_tail(&uvma->userptr.invalidate_link,
-			       &vm->userptr.invalidated);
-		spin_unlock(&vm->userptr.invalidated_lock);
-
-		if (xe_vm_in_preempt_fence_mode(vm)) {
-			struct dma_resv_iter cursor;
-			struct dma_fence *fence;
-			long err;
-
-			dma_resv_iter_begin(&cursor, xe_vm_resv(vm),
-					    DMA_RESV_USAGE_BOOKKEEP);
-			dma_resv_for_each_fence_unlocked(&cursor, fence)
-				dma_fence_enable_sw_signaling(fence);
-			dma_resv_iter_end(&cursor);
-
-			err = dma_resv_wait_timeout(xe_vm_resv(vm),
-						    DMA_RESV_USAGE_BOOKKEEP,
-						    false, MAX_SCHEDULE_TIMEOUT);
-			XE_WARN_ON(err <= 0);
-		}
-	}
 
+	/*
+	 * Just continue the operation since exec or rebind worker
+	 * will take care of rebinding.
+	 */
 	return 0;
 }
 
@@ -1513,6 +1514,7 @@ static unsigned int xe_pt_stage_unbind(struct xe_tile *tile, struct xe_vma *vma,
 			.ops = &xe_pt_stage_unbind_ops,
 			.shifts = xe_normal_pt_shifts,
 			.max_level = XE_PT_HIGHEST_LEVEL,
+			.staging = true,
 		},
 		.tile = tile,
 		.modified_start = xe_vma_start(vma),
@@ -1554,7 +1556,7 @@ static void xe_pt_abort_unbind(struct xe_vma *vma,
 {
 	int i, j;
 
-	xe_pt_commit_locks_assert(vma);
+	xe_pt_commit_prepare_locks_assert(vma);
 
 	for (i = num_entries - 1; i >= 0; --i) {
 		struct xe_vm_pgtable_update *entry = &entries[i];
@@ -1567,7 +1569,7 @@ static void xe_pt_abort_unbind(struct xe_vma *vma,
 			continue;
 
 		for (j = entry->ofs; j < entry->ofs + entry->qwords; j++)
-			pt_dir->children[j] =
+			pt_dir->staging[j] =
 				entries[i].pt_entries[j - entry->ofs].pt ?
 				&entries[i].pt_entries[j - entry->ofs].pt->base : NULL;
 	}
@@ -1580,7 +1582,7 @@ xe_pt_commit_prepare_unbind(struct xe_vma *vma,
 {
 	int i, j;
 
-	xe_pt_commit_locks_assert(vma);
+	xe_pt_commit_prepare_locks_assert(vma);
 
 	for (i = 0; i < num_entries; ++i) {
 		struct xe_vm_pgtable_update *entry = &entries[i];
@@ -1594,8 +1596,8 @@ xe_pt_commit_prepare_unbind(struct xe_vma *vma,
 		pt_dir = as_xe_pt_dir(pt);
 		for (j = entry->ofs; j < entry->ofs + entry->qwords; j++) {
 			entry->pt_entries[j - entry->ofs].pt =
-				xe_pt_entry(pt_dir, j);
-			pt_dir->children[j] = NULL;
+				xe_pt_entry_staging(pt_dir, j);
+			pt_dir->staging[j] = NULL;
 		}
 	}
 }
diff --git a/drivers/gpu/drm/xe/xe_pt_walk.c b/drivers/gpu/drm/xe/xe_pt_walk.c
index b8b3d2aea492..be602a763ff3 100644
--- a/drivers/gpu/drm/xe/xe_pt_walk.c
+++ b/drivers/gpu/drm/xe/xe_pt_walk.c
@@ -74,7 +74,8 @@ int xe_pt_walk_range(struct xe_ptw *parent, unsigned int level,
 		     u64 addr, u64 end, struct xe_pt_walk *walk)
 {
 	pgoff_t offset = xe_pt_offset(addr, level, walk);
-	struct xe_ptw **entries = parent->children ? parent->children : NULL;
+	struct xe_ptw **entries = walk->staging ? (parent->staging ?: NULL) :
+		(parent->children ?: NULL);
 	const struct xe_pt_walk_ops *ops = walk->ops;
 	enum page_walk_action action;
 	struct xe_ptw *child;
diff --git a/drivers/gpu/drm/xe/xe_pt_walk.h b/drivers/gpu/drm/xe/xe_pt_walk.h
index 5ecc4d2f0f65..5c02c244f7de 100644
--- a/drivers/gpu/drm/xe/xe_pt_walk.h
+++ b/drivers/gpu/drm/xe/xe_pt_walk.h
@@ -11,12 +11,14 @@
 /**
  * struct xe_ptw - base class for driver pagetable subclassing.
  * @children: Pointer to an array of children if any.
+ * @staging: Pointer to an array of staging if any.
  *
  * Drivers could subclass this, and if it's a page-directory, typically
  * embed an array of xe_ptw pointers.
  */
 struct xe_ptw {
 	struct xe_ptw **children;
+	struct xe_ptw **staging;
 };
 
 /**
@@ -41,6 +43,8 @@ struct xe_pt_walk {
 	 * as shared pagetables.
 	 */
 	bool shared_pt_mode;
+	/** @staging: Walk staging PT structure */
+	bool staging;
 };
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 5693b337f5df..872de052d670 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -580,51 +580,26 @@ static void preempt_rebind_work_func(struct work_struct *w)
 	trace_xe_vm_rebind_worker_exit(vm);
 }
 
-static bool vma_userptr_invalidate(struct mmu_interval_notifier *mni,
-				   const struct mmu_notifier_range *range,
-				   unsigned long cur_seq)
+static void __vma_userptr_invalidate(struct xe_vm *vm, struct xe_userptr_vma *uvma)
 {
-	struct xe_userptr *userptr = container_of(mni, typeof(*userptr), notifier);
-	struct xe_userptr_vma *uvma = container_of(userptr, typeof(*uvma), userptr);
+	struct xe_userptr *userptr = &uvma->userptr;
 	struct xe_vma *vma = &uvma->vma;
-	struct xe_vm *vm = xe_vma_vm(vma);
 	struct dma_resv_iter cursor;
 	struct dma_fence *fence;
 	long err;
 
-	xe_assert(vm->xe, xe_vma_is_userptr(vma));
-	trace_xe_vma_userptr_invalidate(vma);
-
-	if (!mmu_notifier_range_blockable(range))
-		return false;
-
-	vm_dbg(&xe_vma_vm(vma)->xe->drm,
-	       "NOTIFIER: addr=0x%016llx, range=0x%016llx",
-		xe_vma_start(vma), xe_vma_size(vma));
-
-	down_write(&vm->userptr.notifier_lock);
-	mmu_interval_set_seq(mni, cur_seq);
-
-	/* No need to stop gpu access if the userptr is not yet bound. */
-	if (!userptr->initial_bind) {
-		up_write(&vm->userptr.notifier_lock);
-		return true;
-	}
-
 	/*
 	 * Tell exec and rebind worker they need to repin and rebind this
 	 * userptr.
 	 */
 	if (!xe_vm_in_fault_mode(vm) &&
-	    !(vma->gpuva.flags & XE_VMA_DESTROYED) && vma->tile_present) {
+	    !(vma->gpuva.flags & XE_VMA_DESTROYED)) {
 		spin_lock(&vm->userptr.invalidated_lock);
 		list_move_tail(&userptr->invalidate_link,
 			       &vm->userptr.invalidated);
 		spin_unlock(&vm->userptr.invalidated_lock);
 	}
 
-	up_write(&vm->userptr.notifier_lock);
-
 	/*
 	 * Preempt fences turn into schedule disables, pipeline these.
 	 * Note that even in fault mode, we need to wait for binds and
@@ -642,11 +617,37 @@ static bool vma_userptr_invalidate(struct mmu_interval_notifier *mni,
 				    false, MAX_SCHEDULE_TIMEOUT);
 	XE_WARN_ON(err <= 0);
 
-	if (xe_vm_in_fault_mode(vm)) {
+	if (xe_vm_in_fault_mode(vm) && userptr->initial_bind) {
 		err = xe_vm_invalidate_vma(vma);
 		XE_WARN_ON(err);
 	}
 
+	xe_hmm_userptr_unmap(uvma);
+}
+
+static bool vma_userptr_invalidate(struct mmu_interval_notifier *mni,
+				   const struct mmu_notifier_range *range,
+				   unsigned long cur_seq)
+{
+	struct xe_userptr_vma *uvma = container_of(mni, typeof(*uvma), userptr.notifier);
+	struct xe_vma *vma = &uvma->vma;
+	struct xe_vm *vm = xe_vma_vm(vma);
+
+	xe_assert(vm->xe, xe_vma_is_userptr(vma));
+	trace_xe_vma_userptr_invalidate(vma);
+
+	if (!mmu_notifier_range_blockable(range))
+		return false;
+
+	vm_dbg(&xe_vma_vm(vma)->xe->drm,
+	       "NOTIFIER: addr=0x%016llx, range=0x%016llx",
+		xe_vma_start(vma), xe_vma_size(vma));
+
+	down_write(&vm->userptr.notifier_lock);
+	mmu_interval_set_seq(mni, cur_seq);
+
+	__vma_userptr_invalidate(vm, uvma);
+	up_write(&vm->userptr.notifier_lock);
 	trace_xe_vma_userptr_invalidate_complete(vma);
 
 	return true;
@@ -656,6 +657,34 @@ static const struct mmu_interval_notifier_ops vma_userptr_notifier_ops = {
 	.invalidate = vma_userptr_invalidate,
 };
 
+#if IS_ENABLED(CONFIG_DRM_XE_USERPTR_INVAL_INJECT)
+/**
+ * xe_vma_userptr_force_invalidate() - force invalidate a userptr
+ * @uvma: The userptr vma to invalidate
+ *
+ * Perform a forced userptr invalidation for testing purposes.
+ */
+void xe_vma_userptr_force_invalidate(struct xe_userptr_vma *uvma)
+{
+	struct xe_vm *vm = xe_vma_vm(&uvma->vma);
+
+	/* Protect against concurrent userptr pinning */
+	lockdep_assert_held(&vm->lock);
+	/* Protect against concurrent notifiers */
+	lockdep_assert_held(&vm->userptr.notifier_lock);
+	/*
+	 * Protect against concurrent instances of this function and
+	 * the critical exec sections
+	 */
+	xe_vm_assert_held(vm);
+
+	if (!mmu_interval_read_retry(&uvma->userptr.notifier,
+				     uvma->userptr.notifier_seq))
+		uvma->userptr.notifier_seq -= 2;
+	__vma_userptr_invalidate(vm, uvma);
+}
+#endif
+
 int xe_vm_userptr_pin(struct xe_vm *vm)
 {
 	struct xe_userptr_vma *uvma, *next;
@@ -1012,6 +1041,7 @@ static struct xe_vma *xe_vma_create(struct xe_vm *vm,
 			INIT_LIST_HEAD(&userptr->invalidate_link);
 			INIT_LIST_HEAD(&userptr->repin_link);
 			vma->gpuva.gem.offset = bo_offset_or_userptr;
+			mutex_init(&userptr->unmap_mutex);
 
 			err = mmu_interval_notifier_insert(&userptr->notifier,
 							   current->mm,
@@ -1053,6 +1083,7 @@ static void xe_vma_destroy_late(struct xe_vma *vma)
 		 * them anymore
 		 */
 		mmu_interval_notifier_remove(&userptr->notifier);
+		mutex_destroy(&userptr->unmap_mutex);
 		xe_vm_put(vm);
 	} else if (xe_vma_is_null(vma)) {
 		xe_vm_put(vm);
@@ -2284,8 +2315,17 @@ static int vm_bind_ioctl_ops_parse(struct xe_vm *vm, struct drm_gpuva_ops *ops,
 			break;
 		}
 		case DRM_GPUVA_OP_UNMAP:
+			xe_vma_ops_incr_pt_update_ops(vops, op->tile_mask);
+			break;
 		case DRM_GPUVA_OP_PREFETCH:
-			/* FIXME: Need to skip some prefetch ops */
+			vma = gpuva_to_vma(op->base.prefetch.va);
+
+			if (xe_vma_is_userptr(vma)) {
+				err = xe_vma_userptr_pin_pages(to_userptr_vma(vma));
+				if (err)
+					return err;
+			}
+
 			xe_vma_ops_incr_pt_update_ops(vops, op->tile_mask);
 			break;
 		default:
diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
index c864dba35e1d..d2406532fcc5 100644
--- a/drivers/gpu/drm/xe/xe_vm.h
+++ b/drivers/gpu/drm/xe/xe_vm.h
@@ -275,9 +275,17 @@ static inline void vm_dbg(const struct drm_device *dev,
 			  const char *format, ...)
 { /* noop */ }
 #endif
-#endif
 
 struct xe_vm_snapshot *xe_vm_snapshot_capture(struct xe_vm *vm);
 void xe_vm_snapshot_capture_delayed(struct xe_vm_snapshot *snap);
 void xe_vm_snapshot_print(struct xe_vm_snapshot *snap, struct drm_printer *p);
 void xe_vm_snapshot_free(struct xe_vm_snapshot *snap);
+
+#if IS_ENABLED(CONFIG_DRM_XE_USERPTR_INVAL_INJECT)
+void xe_vma_userptr_force_invalidate(struct xe_userptr_vma *uvma);
+#else
+static inline void xe_vma_userptr_force_invalidate(struct xe_userptr_vma *uvma)
+{
+}
+#endif
+#endif
diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
index 7f9a303e51d8..a4b4091cfd0d 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -59,12 +59,16 @@ struct xe_userptr {
 	struct sg_table *sg;
 	/** @notifier_seq: notifier sequence number */
 	unsigned long notifier_seq;
+	/** @unmap_mutex: Mutex protecting dma-unmapping */
+	struct mutex unmap_mutex;
 	/**
 	 * @initial_bind: user pointer has been bound at least once.
 	 * write: vm->userptr.notifier_lock in read mode and vm->resv held.
 	 * read: vm->userptr.notifier_lock in write mode or vm->resv held.
 	 */
 	bool initial_bind;
+	/** @mapped: Whether the @sgt sg-table is dma-mapped. Protected by @unmap_mutex. */
+	bool mapped;
 #if IS_ENABLED(CONFIG_DRM_XE_USERPTR_INVAL_INJECT)
 	u32 divisor;
 #endif
@@ -227,8 +231,8 @@ struct xe_vm {
 		 * up for revalidation. Protected from access with the
 		 * @invalidated_lock. Removing items from the list
 		 * additionally requires @lock in write mode, and adding
-		 * items to the list requires the @userptr.notifer_lock in
-		 * write mode.
+		 * items to the list requires either the @userptr.notifer_lock in
+		 * write mode, OR @lock in write mode.
 		 */
 		struct list_head invalidated;
 	} userptr;
diff --git a/drivers/hid/hid-appleir.c b/drivers/hid/hid-appleir.c
index 8deded185725..c45e5aa569d2 100644
--- a/drivers/hid/hid-appleir.c
+++ b/drivers/hid/hid-appleir.c
@@ -188,7 +188,7 @@ static int appleir_raw_event(struct hid_device *hid, struct hid_report *report,
 	static const u8 flatbattery[] = { 0x25, 0x87, 0xe0 };
 	unsigned long flags;
 
-	if (len != 5)
+	if (len != 5 || !(hid->claimed & HID_CLAIMED_INPUT))
 		goto out;
 
 	if (!memcmp(data, keydown, sizeof(keydown))) {
diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 22683ec819aa..646ba5b92e0b 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -268,11 +268,13 @@ static void cbas_ec_remove(struct platform_device *pdev)
 	mutex_unlock(&cbas_ec_reglock);
 }
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id cbas_ec_acpi_ids[] = {
 	{ "GOOG000B", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, cbas_ec_acpi_ids);
+#endif
 
 #ifdef CONFIG_OF
 static const struct of_device_id cbas_ec_of_match[] = {
diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 7b3596689878..19b7bb0c3d7f 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -1327,11 +1327,11 @@ static void steam_remove(struct hid_device *hdev)
 		return;
 	}
 
+	hid_destroy_device(steam->client_hdev);
 	cancel_delayed_work_sync(&steam->mode_switch);
 	cancel_work_sync(&steam->work_connect);
 	cancel_work_sync(&steam->rumble_work);
 	cancel_work_sync(&steam->unregister_work);
-	hid_destroy_device(steam->client_hdev);
 	steam->client_hdev = NULL;
 	steam->client_opened = 0;
 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index fbd4f8ea1951..af6a5afc1a93 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -833,9 +833,9 @@ static void hid_ishtp_cl_remove(struct ishtp_cl_device *cl_device)
 			hid_ishtp_cl);
 
 	dev_dbg(ishtp_device(cl_device), "%s\n", __func__);
-	hid_ishtp_cl_deinit(hid_ishtp_cl);
 	ishtp_put_device(cl_device);
 	ishtp_hid_remove(client_data);
+	hid_ishtp_cl_deinit(hid_ishtp_cl);
 
 	hid_ishtp_cl = NULL;
 
diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.c b/drivers/hid/intel-ish-hid/ishtp-hid.c
index 00c6f0ebf356..be2c62fc8251 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid.c
@@ -261,12 +261,14 @@ int ishtp_hid_probe(unsigned int cur_hid_dev,
  */
 void ishtp_hid_remove(struct ishtp_cl_data *client_data)
 {
+	void *data;
 	int i;
 
 	for (i = 0; i < client_data->num_hid_devices; ++i) {
 		if (client_data->hid_sensor_hubs[i]) {
-			kfree(client_data->hid_sensor_hubs[i]->driver_data);
+			data = client_data->hid_sensor_hubs[i]->driver_data;
 			hid_destroy_device(client_data->hid_sensor_hubs[i]);
+			kfree(data);
 			client_data->hid_sensor_hubs[i] = NULL;
 		}
 	}
diff --git a/drivers/hwmon/ad7314.c b/drivers/hwmon/ad7314.c
index 7802bbf5f958..59424103f634 100644
--- a/drivers/hwmon/ad7314.c
+++ b/drivers/hwmon/ad7314.c
@@ -22,11 +22,13 @@
  */
 #define AD7314_TEMP_MASK		0x7FE0
 #define AD7314_TEMP_SHIFT		5
+#define AD7314_LEADING_ZEROS_MASK	BIT(15)
 
 /*
  * ADT7301 and ADT7302 temperature masks
  */
 #define ADT7301_TEMP_MASK		0x3FFF
+#define ADT7301_LEADING_ZEROS_MASK	(BIT(15) | BIT(14))
 
 enum ad7314_variant {
 	adt7301,
@@ -65,12 +67,20 @@ static ssize_t ad7314_temperature_show(struct device *dev,
 		return ret;
 	switch (spi_get_device_id(chip->spi_dev)->driver_data) {
 	case ad7314:
+		if (ret & AD7314_LEADING_ZEROS_MASK) {
+			/* Invalid read-out, leading zero part is missing */
+			return -EIO;
+		}
 		data = (ret & AD7314_TEMP_MASK) >> AD7314_TEMP_SHIFT;
 		data = sign_extend32(data, 9);
 
 		return sprintf(buf, "%d\n", 250 * data);
 	case adt7301:
 	case adt7302:
+		if (ret & ADT7301_LEADING_ZEROS_MASK) {
+			/* Invalid read-out, leading zero part is missing */
+			return -EIO;
+		}
 		/*
 		 * Documented as a 13 bit twos complement register
 		 * with a sign bit - which is a 14 bit 2's complement
diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index b5352900463f..0d29c8f97ba7 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -181,40 +181,40 @@ static const struct ntc_compensation ncpXXwf104[] = {
 };
 
 static const struct ntc_compensation ncpXXxh103[] = {
-	{ .temp_c	= -40, .ohm	= 247565 },
-	{ .temp_c	= -35, .ohm	= 181742 },
-	{ .temp_c	= -30, .ohm	= 135128 },
-	{ .temp_c	= -25, .ohm	= 101678 },
-	{ .temp_c	= -20, .ohm	= 77373 },
-	{ .temp_c	= -15, .ohm	= 59504 },
-	{ .temp_c	= -10, .ohm	= 46222 },
-	{ .temp_c	= -5, .ohm	= 36244 },
-	{ .temp_c	= 0, .ohm	= 28674 },
-	{ .temp_c	= 5, .ohm	= 22878 },
-	{ .temp_c	= 10, .ohm	= 18399 },
-	{ .temp_c	= 15, .ohm	= 14910 },
-	{ .temp_c	= 20, .ohm	= 12169 },
+	{ .temp_c	= -40, .ohm	= 195652 },
+	{ .temp_c	= -35, .ohm	= 148171 },
+	{ .temp_c	= -30, .ohm	= 113347 },
+	{ .temp_c	= -25, .ohm	= 87559 },
+	{ .temp_c	= -20, .ohm	= 68237 },
+	{ .temp_c	= -15, .ohm	= 53650 },
+	{ .temp_c	= -10, .ohm	= 42506 },
+	{ .temp_c	= -5, .ohm	= 33892 },
+	{ .temp_c	= 0, .ohm	= 27219 },
+	{ .temp_c	= 5, .ohm	= 22021 },
+	{ .temp_c	= 10, .ohm	= 17926 },
+	{ .temp_c	= 15, .ohm	= 14674 },
+	{ .temp_c	= 20, .ohm	= 12081 },
 	{ .temp_c	= 25, .ohm	= 10000 },
-	{ .temp_c	= 30, .ohm	= 8271 },
-	{ .temp_c	= 35, .ohm	= 6883 },
-	{ .temp_c	= 40, .ohm	= 5762 },
-	{ .temp_c	= 45, .ohm	= 4851 },
-	{ .temp_c	= 50, .ohm	= 4105 },
-	{ .temp_c	= 55, .ohm	= 3492 },
-	{ .temp_c	= 60, .ohm	= 2985 },
-	{ .temp_c	= 65, .ohm	= 2563 },
-	{ .temp_c	= 70, .ohm	= 2211 },
-	{ .temp_c	= 75, .ohm	= 1915 },
-	{ .temp_c	= 80, .ohm	= 1666 },
-	{ .temp_c	= 85, .ohm	= 1454 },
-	{ .temp_c	= 90, .ohm	= 1275 },
-	{ .temp_c	= 95, .ohm	= 1121 },
-	{ .temp_c	= 100, .ohm	= 990 },
-	{ .temp_c	= 105, .ohm	= 876 },
-	{ .temp_c	= 110, .ohm	= 779 },
-	{ .temp_c	= 115, .ohm	= 694 },
-	{ .temp_c	= 120, .ohm	= 620 },
-	{ .temp_c	= 125, .ohm	= 556 },
+	{ .temp_c	= 30, .ohm	= 8315 },
+	{ .temp_c	= 35, .ohm	= 6948 },
+	{ .temp_c	= 40, .ohm	= 5834 },
+	{ .temp_c	= 45, .ohm	= 4917 },
+	{ .temp_c	= 50, .ohm	= 4161 },
+	{ .temp_c	= 55, .ohm	= 3535 },
+	{ .temp_c	= 60, .ohm	= 3014 },
+	{ .temp_c	= 65, .ohm	= 2586 },
+	{ .temp_c	= 70, .ohm	= 2228 },
+	{ .temp_c	= 75, .ohm	= 1925 },
+	{ .temp_c	= 80, .ohm	= 1669 },
+	{ .temp_c	= 85, .ohm	= 1452 },
+	{ .temp_c	= 90, .ohm	= 1268 },
+	{ .temp_c	= 95, .ohm	= 1110 },
+	{ .temp_c	= 100, .ohm	= 974 },
+	{ .temp_c	= 105, .ohm	= 858 },
+	{ .temp_c	= 110, .ohm	= 758 },
+	{ .temp_c	= 115, .ohm	= 672 },
+	{ .temp_c	= 120, .ohm	= 596 },
+	{ .temp_c	= 125, .ohm	= 531 },
 };
 
 /*
diff --git a/drivers/hwmon/peci/dimmtemp.c b/drivers/hwmon/peci/dimmtemp.c
index 4a72e9712408..b7b09780c7b0 100644
--- a/drivers/hwmon/peci/dimmtemp.c
+++ b/drivers/hwmon/peci/dimmtemp.c
@@ -127,8 +127,6 @@ static int update_thresholds(struct peci_dimmtemp *priv, int dimm_no)
 		return 0;
 
 	ret = priv->gen_info->read_thresholds(priv, dimm_order, chan_rank, &data);
-	if (ret == -ENODATA) /* Use default or previous value */
-		return 0;
 	if (ret)
 		return ret;
 
@@ -509,11 +507,11 @@ read_thresholds_icx(struct peci_dimmtemp *priv, int dimm_order, int chan_rank, u
 
 	ret = peci_ep_pci_local_read(priv->peci_dev, 0, 13, 0, 2, 0xd4, &reg_val);
 	if (ret || !(reg_val & BIT(31)))
-		return -ENODATA; /* Use default or previous value */
+		return -ENODATA;
 
 	ret = peci_ep_pci_local_read(priv->peci_dev, 0, 13, 0, 2, 0xd0, &reg_val);
 	if (ret)
-		return -ENODATA; /* Use default or previous value */
+		return -ENODATA;
 
 	/*
 	 * Device 26, Offset 224e0: IMC 0 channel 0 -> rank 0
@@ -546,11 +544,11 @@ read_thresholds_spr(struct peci_dimmtemp *priv, int dimm_order, int chan_rank, u
 
 	ret = peci_ep_pci_local_read(priv->peci_dev, 0, 30, 0, 2, 0xd4, &reg_val);
 	if (ret || !(reg_val & BIT(31)))
-		return -ENODATA; /* Use default or previous value */
+		return -ENODATA;
 
 	ret = peci_ep_pci_local_read(priv->peci_dev, 0, 30, 0, 2, 0xd0, &reg_val);
 	if (ret)
-		return -ENODATA; /* Use default or previous value */
+		return -ENODATA;
 
 	/*
 	 * Device 26, Offset 219a8: IMC 0 channel 0 -> rank 0
diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
index ec40c5c59954..59424dc518c8 100644
--- a/drivers/hwmon/pmbus/pmbus.c
+++ b/drivers/hwmon/pmbus/pmbus.c
@@ -103,6 +103,8 @@ static int pmbus_identify(struct i2c_client *client,
 		if (pmbus_check_byte_register(client, 0, PMBUS_PAGE)) {
 			int page;
 
+			info->pages = PMBUS_PAGES;
+
 			for (page = 1; page < PMBUS_PAGES; page++) {
 				if (pmbus_set_page(client, page, 0xff) < 0)
 					break;
diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
index 5e0759a70f6d..92d82faf237f 100644
--- a/drivers/hwmon/xgene-hwmon.c
+++ b/drivers/hwmon/xgene-hwmon.c
@@ -706,7 +706,7 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
 			goto out;
 		}
 
-		if (!ctx->pcc_comm_addr) {
+		if (IS_ERR_OR_NULL(ctx->pcc_comm_addr)) {
 			dev_err(&pdev->dev,
 				"Failed to ioremap PCC comm region\n");
 			rc = -ENOMEM;
diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 0d7b9839e5b6..6bb6af0f96fa 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -329,6 +329,21 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa824),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Arrow Lake */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7724),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
+		/* Panther Lake-H */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xe324),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
+		/* Panther Lake-P/U */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xe424),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{
 		/* Alder Lake CPU */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x466f),
diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 955e9eff0099..6fe32f866765 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1082,7 +1082,7 @@ static int ad7192_update_scan_mode(struct iio_dev *indio_dev, const unsigned lon
 
 	conf &= ~AD7192_CONF_CHAN_MASK;
 	for_each_set_bit(i, scan_mask, 8)
-		conf |= FIELD_PREP(AD7192_CONF_CHAN_MASK, i);
+		conf |= FIELD_PREP(AD7192_CONF_CHAN_MASK, BIT(i));
 
 	ret = ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, conf);
 	if (ret < 0)
diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index d7fd21e7c6e2..3618e769b106 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -329,7 +329,7 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 #define AT91_HWFIFO_MAX_SIZE_STR	"128"
 #define AT91_HWFIFO_MAX_SIZE		128
 
-#define AT91_SAMA5D2_CHAN_SINGLE(index, num, addr)			\
+#define AT91_SAMA_CHAN_SINGLE(index, num, addr, rbits)			\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.channel = num,						\
@@ -337,7 +337,7 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 		.scan_index = index,					\
 		.scan_type = {						\
 			.sign = 'u',					\
-			.realbits = 14,					\
+			.realbits = rbits,				\
 			.storagebits = 16,				\
 		},							\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
@@ -350,7 +350,13 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 		.indexed = 1,						\
 	}
 
-#define AT91_SAMA5D2_CHAN_DIFF(index, num, num2, addr)			\
+#define AT91_SAMA5D2_CHAN_SINGLE(index, num, addr)			\
+	AT91_SAMA_CHAN_SINGLE(index, num, addr, 14)
+
+#define AT91_SAMA7G5_CHAN_SINGLE(index, num, addr)			\
+	AT91_SAMA_CHAN_SINGLE(index, num, addr, 16)
+
+#define AT91_SAMA_CHAN_DIFF(index, num, num2, addr, rbits)		\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.differential = 1,					\
@@ -360,7 +366,7 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 		.scan_index = index,					\
 		.scan_type = {						\
 			.sign = 's',					\
-			.realbits = 14,					\
+			.realbits = rbits,				\
 			.storagebits = 16,				\
 		},							\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
@@ -373,6 +379,12 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 		.indexed = 1,						\
 	}
 
+#define AT91_SAMA5D2_CHAN_DIFF(index, num, num2, addr)			\
+	AT91_SAMA_CHAN_DIFF(index, num, num2, addr, 14)
+
+#define AT91_SAMA7G5_CHAN_DIFF(index, num, num2, addr)			\
+	AT91_SAMA_CHAN_DIFF(index, num, num2, addr, 16)
+
 #define AT91_SAMA5D2_CHAN_TOUCH(num, name, mod)				\
 	{								\
 		.type = IIO_POSITIONRELATIVE,				\
@@ -666,30 +678,30 @@ static const struct iio_chan_spec at91_sama5d2_adc_channels[] = {
 };
 
 static const struct iio_chan_spec at91_sama7g5_adc_channels[] = {
-	AT91_SAMA5D2_CHAN_SINGLE(0, 0, 0x60),
-	AT91_SAMA5D2_CHAN_SINGLE(1, 1, 0x64),
-	AT91_SAMA5D2_CHAN_SINGLE(2, 2, 0x68),
-	AT91_SAMA5D2_CHAN_SINGLE(3, 3, 0x6c),
-	AT91_SAMA5D2_CHAN_SINGLE(4, 4, 0x70),
-	AT91_SAMA5D2_CHAN_SINGLE(5, 5, 0x74),
-	AT91_SAMA5D2_CHAN_SINGLE(6, 6, 0x78),
-	AT91_SAMA5D2_CHAN_SINGLE(7, 7, 0x7c),
-	AT91_SAMA5D2_CHAN_SINGLE(8, 8, 0x80),
-	AT91_SAMA5D2_CHAN_SINGLE(9, 9, 0x84),
-	AT91_SAMA5D2_CHAN_SINGLE(10, 10, 0x88),
-	AT91_SAMA5D2_CHAN_SINGLE(11, 11, 0x8c),
-	AT91_SAMA5D2_CHAN_SINGLE(12, 12, 0x90),
-	AT91_SAMA5D2_CHAN_SINGLE(13, 13, 0x94),
-	AT91_SAMA5D2_CHAN_SINGLE(14, 14, 0x98),
-	AT91_SAMA5D2_CHAN_SINGLE(15, 15, 0x9c),
-	AT91_SAMA5D2_CHAN_DIFF(16, 0, 1, 0x60),
-	AT91_SAMA5D2_CHAN_DIFF(17, 2, 3, 0x68),
-	AT91_SAMA5D2_CHAN_DIFF(18, 4, 5, 0x70),
-	AT91_SAMA5D2_CHAN_DIFF(19, 6, 7, 0x78),
-	AT91_SAMA5D2_CHAN_DIFF(20, 8, 9, 0x80),
-	AT91_SAMA5D2_CHAN_DIFF(21, 10, 11, 0x88),
-	AT91_SAMA5D2_CHAN_DIFF(22, 12, 13, 0x90),
-	AT91_SAMA5D2_CHAN_DIFF(23, 14, 15, 0x98),
+	AT91_SAMA7G5_CHAN_SINGLE(0, 0, 0x60),
+	AT91_SAMA7G5_CHAN_SINGLE(1, 1, 0x64),
+	AT91_SAMA7G5_CHAN_SINGLE(2, 2, 0x68),
+	AT91_SAMA7G5_CHAN_SINGLE(3, 3, 0x6c),
+	AT91_SAMA7G5_CHAN_SINGLE(4, 4, 0x70),
+	AT91_SAMA7G5_CHAN_SINGLE(5, 5, 0x74),
+	AT91_SAMA7G5_CHAN_SINGLE(6, 6, 0x78),
+	AT91_SAMA7G5_CHAN_SINGLE(7, 7, 0x7c),
+	AT91_SAMA7G5_CHAN_SINGLE(8, 8, 0x80),
+	AT91_SAMA7G5_CHAN_SINGLE(9, 9, 0x84),
+	AT91_SAMA7G5_CHAN_SINGLE(10, 10, 0x88),
+	AT91_SAMA7G5_CHAN_SINGLE(11, 11, 0x8c),
+	AT91_SAMA7G5_CHAN_SINGLE(12, 12, 0x90),
+	AT91_SAMA7G5_CHAN_SINGLE(13, 13, 0x94),
+	AT91_SAMA7G5_CHAN_SINGLE(14, 14, 0x98),
+	AT91_SAMA7G5_CHAN_SINGLE(15, 15, 0x9c),
+	AT91_SAMA7G5_CHAN_DIFF(16, 0, 1, 0x60),
+	AT91_SAMA7G5_CHAN_DIFF(17, 2, 3, 0x68),
+	AT91_SAMA7G5_CHAN_DIFF(18, 4, 5, 0x70),
+	AT91_SAMA7G5_CHAN_DIFF(19, 6, 7, 0x78),
+	AT91_SAMA7G5_CHAN_DIFF(20, 8, 9, 0x80),
+	AT91_SAMA7G5_CHAN_DIFF(21, 10, 11, 0x88),
+	AT91_SAMA7G5_CHAN_DIFF(22, 12, 13, 0x90),
+	AT91_SAMA7G5_CHAN_DIFF(23, 14, 15, 0x98),
 	IIO_CHAN_SOFT_TIMESTAMP(24),
 	AT91_SAMA5D2_CHAN_TEMP(AT91_SAMA7G5_ADC_TEMP_CHANNEL, "temp", 0xdc),
 };
diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index 7d61b2fe6624..390d3fab2147 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -714,6 +714,12 @@ static int ad3552r_reset(struct ad3552r_desc *dac)
 		return ret;
 	}
 
+	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
+	ret = ad3552r_write_reg(dac, AD3552R_REG_ADDR_ERR_STATUS,
+				AD3552R_MASK_RESET_STATUS);
+	if (ret)
+		return ret;
+
 	return ad3552r_update_reg_field(dac,
 					addr_mask_map[AD3552R_ADDR_ASCENSION][0],
 					addr_mask_map[AD3552R_ADDR_ASCENSION][1],
diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index 848baa6e3bbf..d85b7d3de866 100644
--- a/drivers/iio/filter/admv8818.c
+++ b/drivers/iio/filter/admv8818.c
@@ -574,21 +574,15 @@ static int admv8818_init(struct admv8818_state *st)
 	struct spi_device *spi = st->spi;
 	unsigned int chip_id;
 
-	ret = regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
-				 ADMV8818_SOFTRESET_N_MSK |
-				 ADMV8818_SOFTRESET_MSK,
-				 FIELD_PREP(ADMV8818_SOFTRESET_N_MSK, 1) |
-				 FIELD_PREP(ADMV8818_SOFTRESET_MSK, 1));
+	ret = regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
+			   ADMV8818_SOFTRESET_N_MSK | ADMV8818_SOFTRESET_MSK);
 	if (ret) {
 		dev_err(&spi->dev, "ADMV8818 Soft Reset failed.\n");
 		return ret;
 	}
 
-	ret = regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
-				 ADMV8818_SDOACTIVE_N_MSK |
-				 ADMV8818_SDOACTIVE_MSK,
-				 FIELD_PREP(ADMV8818_SDOACTIVE_N_MSK, 1) |
-				 FIELD_PREP(ADMV8818_SDOACTIVE_MSK, 1));
+	ret = regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
+			   ADMV8818_SDOACTIVE_N_MSK | ADMV8818_SDOACTIVE_MSK);
 	if (ret) {
 		dev_err(&spi->dev, "ADMV8818 SDO Enable failed.\n");
 		return ret;
diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index 079e02be1005..7f9d6cac8adb 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -108,11 +108,11 @@ static const struct part_id_gts_multiplier apds9306_gts_mul[] = {
 	{
 		.part_id = 0xB1,
 		.max_scale_int = 16,
-		.max_scale_nano = 3264320,
+		.max_scale_nano = 326432000,
 	}, {
 		.part_id = 0xB3,
 		.max_scale_int = 14,
-		.max_scale_nano = 9712000,
+		.max_scale_nano = 97120000,
 	},
 };
 
diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
index 285a748748d7..f150d8769f19 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -286,7 +286,6 @@ static int rtsx_usb_get_status_with_bulk(struct rtsx_ucr *ucr, u16 *status)
 int rtsx_usb_get_card_status(struct rtsx_ucr *ucr, u16 *status)
 {
 	int ret;
-	u8 interrupt_val = 0;
 	u16 *buf;
 
 	if (!status)
@@ -309,20 +308,6 @@ int rtsx_usb_get_card_status(struct rtsx_ucr *ucr, u16 *status)
 		ret = rtsx_usb_get_status_with_bulk(ucr, status);
 	}
 
-	rtsx_usb_read_register(ucr, CARD_INT_PEND, &interrupt_val);
-	/* Cross check presence with interrupts */
-	if (*status & XD_CD)
-		if (!(interrupt_val & XD_INT))
-			*status &= ~XD_CD;
-
-	if (*status & SD_CD)
-		if (!(interrupt_val & SD_INT))
-			*status &= ~SD_CD;
-
-	if (*status & MS_CD)
-		if (!(interrupt_val & MS_INT))
-			*status &= ~MS_CD;
-
 	/* usb_control_msg may return positive when success */
 	if (ret < 0)
 		return ret;
diff --git a/drivers/misc/eeprom/digsy_mtc_eeprom.c b/drivers/misc/eeprom/digsy_mtc_eeprom.c
index 88888485e6f8..ee58f7ce5bfa 100644
--- a/drivers/misc/eeprom/digsy_mtc_eeprom.c
+++ b/drivers/misc/eeprom/digsy_mtc_eeprom.c
@@ -50,7 +50,7 @@ static struct platform_device digsy_mtc_eeprom = {
 };
 
 static struct gpiod_lookup_table eeprom_spi_gpiod_table = {
-	.dev_id         = "spi_gpio",
+	.dev_id         = "spi_gpio.1",
 	.table          = {
 		GPIO_LOOKUP("gpio@b00", GPIO_EEPROM_CLK,
 			    "sck", GPIO_ACTIVE_HIGH),
diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index c3a6657dcd4a..a5f88ec97df7 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -117,6 +117,8 @@
 
 #define MEI_DEV_ID_LNL_M      0xA870  /* Lunar Lake Point M */
 
+#define MEI_DEV_ID_PTL_P      0xE470  /* Panther Lake P */
+
 /*
  * MEI HW Section
  */
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 6589635f8ba3..d6ff9d82ae94 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -124,6 +124,8 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_LNL_M, MEI_ME_PCH15_CFG)},
 
+	{MEI_PCI_DEVICE(MEI_DEV_ID_PTL_P, MEI_ME_PCH15_CFG)},
+
 	/* required last entry */
 	{0, }
 };
diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index 1618cca9a731..ef0a9f423c8f 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -504,7 +504,7 @@ static int vsc_tp_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	tp->wakeuphost = devm_gpiod_get(dev, "wakeuphost", GPIOD_IN);
+	tp->wakeuphost = devm_gpiod_get(dev, "wakeuphostint", GPIOD_IN);
 	if (IS_ERR(tp->wakeuphost))
 		return PTR_ERR(tp->wakeuphost);
 
diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
index 7fea00c7ca8a..c60386bf2d1a 100644
--- a/drivers/net/caif/caif_virtio.c
+++ b/drivers/net/caif/caif_virtio.c
@@ -745,7 +745,7 @@ static int cfv_probe(struct virtio_device *vdev)
 
 	if (cfv->vr_rx)
 		vdev->vringh_config->del_vrhs(cfv->vdev);
-	if (cfv->vdev)
+	if (cfv->vq_tx)
 		vdev->config->del_vqs(cfv->vdev);
 	free_netdev(netdev);
 	return err;
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index d84ee1b419a6..abc979fbb45d 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2590,7 +2590,8 @@ mt7531_setup_common(struct dsa_switch *ds)
 	if (ret < 0)
 		return ret;
 
-	return 0;
+	/* Setup VLAN ID 0 for VLAN-unaware bridges */
+	return mt7530_setup_vlan0(priv);
 }
 
 static int
@@ -2686,11 +2687,6 @@ mt7531_setup(struct dsa_switch *ds)
 	if (ret)
 		return ret;
 
-	/* Setup VLAN ID 0 for VLAN-unaware bridges */
-	ret = mt7530_setup_vlan0(priv);
-	if (ret)
-		return ret;
-
 	ds->assisted_learning_on_cpu_port = true;
 	ds->mtu_enforcement_ingress = true;
 
diff --git a/drivers/net/ethernet/emulex/benet/be.h b/drivers/net/ethernet/emulex/benet/be.h
index e48b861e4ce1..270ff9aab335 100644
--- a/drivers/net/ethernet/emulex/benet/be.h
+++ b/drivers/net/ethernet/emulex/benet/be.h
@@ -562,7 +562,7 @@ struct be_adapter {
 	struct be_dma_mem mbox_mem_alloced;
 
 	struct be_mcc_obj mcc_obj;
-	struct mutex mcc_lock;	/* For serializing mcc cmds to BE card */
+	spinlock_t mcc_lock;	/* For serializing mcc cmds to BE card */
 	spinlock_t mcc_cq_lock;
 
 	u16 cfg_num_rx_irqs;		/* configured via set-channels */
diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethernet/emulex/benet/be_cmds.c
index 61adcebeef01..51b8377edd1d 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.c
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
@@ -575,7 +575,7 @@ int be_process_mcc(struct be_adapter *adapter)
 /* Wait till no more pending mcc requests are present */
 static int be_mcc_wait_compl(struct be_adapter *adapter)
 {
-#define mcc_timeout		12000 /* 12s timeout */
+#define mcc_timeout		120000 /* 12s timeout */
 	int i, status = 0;
 	struct be_mcc_obj *mcc_obj = &adapter->mcc_obj;
 
@@ -589,7 +589,7 @@ static int be_mcc_wait_compl(struct be_adapter *adapter)
 
 		if (atomic_read(&mcc_obj->q.used) == 0)
 			break;
-		usleep_range(500, 1000);
+		udelay(100);
 	}
 	if (i == mcc_timeout) {
 		dev_err(&adapter->pdev->dev, "FW not responding\n");
@@ -866,7 +866,7 @@ static bool use_mcc(struct be_adapter *adapter)
 static int be_cmd_lock(struct be_adapter *adapter)
 {
 	if (use_mcc(adapter)) {
-		mutex_lock(&adapter->mcc_lock);
+		spin_lock_bh(&adapter->mcc_lock);
 		return 0;
 	} else {
 		return mutex_lock_interruptible(&adapter->mbox_lock);
@@ -877,7 +877,7 @@ static int be_cmd_lock(struct be_adapter *adapter)
 static void be_cmd_unlock(struct be_adapter *adapter)
 {
 	if (use_mcc(adapter))
-		return mutex_unlock(&adapter->mcc_lock);
+		return spin_unlock_bh(&adapter->mcc_lock);
 	else
 		return mutex_unlock(&adapter->mbox_lock);
 }
@@ -1047,7 +1047,7 @@ int be_cmd_mac_addr_query(struct be_adapter *adapter, u8 *mac_addr,
 	struct be_cmd_req_mac_query *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1076,7 +1076,7 @@ int be_cmd_mac_addr_query(struct be_adapter *adapter, u8 *mac_addr,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1088,7 +1088,7 @@ int be_cmd_pmac_add(struct be_adapter *adapter, const u8 *mac_addr,
 	struct be_cmd_req_pmac_add *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1113,7 +1113,7 @@ int be_cmd_pmac_add(struct be_adapter *adapter, const u8 *mac_addr,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 
 	if (base_status(status) == MCC_STATUS_UNAUTHORIZED_REQUEST)
 		status = -EPERM;
@@ -1131,7 +1131,7 @@ int be_cmd_pmac_del(struct be_adapter *adapter, u32 if_id, int pmac_id, u32 dom)
 	if (pmac_id == -1)
 		return 0;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1151,7 +1151,7 @@ int be_cmd_pmac_del(struct be_adapter *adapter, u32 if_id, int pmac_id, u32 dom)
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1414,7 +1414,7 @@ int be_cmd_rxq_create(struct be_adapter *adapter,
 	struct be_dma_mem *q_mem = &rxq->dma_mem;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1444,7 +1444,7 @@ int be_cmd_rxq_create(struct be_adapter *adapter,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1508,7 +1508,7 @@ int be_cmd_rxq_destroy(struct be_adapter *adapter, struct be_queue_info *q)
 	struct be_cmd_req_q_destroy *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1525,7 +1525,7 @@ int be_cmd_rxq_destroy(struct be_adapter *adapter, struct be_queue_info *q)
 	q->created = false;
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1593,7 +1593,7 @@ int be_cmd_get_stats(struct be_adapter *adapter, struct be_dma_mem *nonemb_cmd)
 	struct be_cmd_req_hdr *hdr;
 	int status = 0;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1621,7 +1621,7 @@ int be_cmd_get_stats(struct be_adapter *adapter, struct be_dma_mem *nonemb_cmd)
 	adapter->stats_cmd_sent = true;
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1637,7 +1637,7 @@ int lancer_cmd_get_pport_stats(struct be_adapter *adapter,
 			    CMD_SUBSYSTEM_ETH))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1660,7 +1660,7 @@ int lancer_cmd_get_pport_stats(struct be_adapter *adapter,
 	adapter->stats_cmd_sent = true;
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1697,7 +1697,7 @@ int be_cmd_link_status_query(struct be_adapter *adapter, u16 *link_speed,
 	struct be_cmd_req_link_status *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	if (link_status)
 		*link_status = LINK_DOWN;
@@ -1736,7 +1736,7 @@ int be_cmd_link_status_query(struct be_adapter *adapter, u16 *link_speed,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1747,7 +1747,7 @@ int be_cmd_get_die_temperature(struct be_adapter *adapter)
 	struct be_cmd_req_get_cntl_addnl_attribs *req;
 	int status = 0;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1762,7 +1762,7 @@ int be_cmd_get_die_temperature(struct be_adapter *adapter)
 
 	status = be_mcc_notify(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1811,7 +1811,7 @@ int be_cmd_get_fat_dump(struct be_adapter *adapter, u32 buf_len, void *buf)
 	if (!get_fat_cmd.va)
 		return -ENOMEM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	while (total_size) {
 		buf_size = min(total_size, (u32)60 * 1024);
@@ -1849,9 +1849,9 @@ int be_cmd_get_fat_dump(struct be_adapter *adapter, u32 buf_len, void *buf)
 		log_offset += buf_size;
 	}
 err:
+	spin_unlock_bh(&adapter->mcc_lock);
 	dma_free_coherent(&adapter->pdev->dev, get_fat_cmd.size,
 			  get_fat_cmd.va, get_fat_cmd.dma);
-	mutex_unlock(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1862,7 +1862,7 @@ int be_cmd_get_fw_ver(struct be_adapter *adapter)
 	struct be_cmd_req_get_fw_version *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1885,7 +1885,7 @@ int be_cmd_get_fw_ver(struct be_adapter *adapter)
 			sizeof(adapter->fw_on_flash));
 	}
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1899,7 +1899,7 @@ static int __be_cmd_modify_eqd(struct be_adapter *adapter,
 	struct be_cmd_req_modify_eq_delay *req;
 	int status = 0, i;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1922,7 +1922,7 @@ static int __be_cmd_modify_eqd(struct be_adapter *adapter,
 
 	status = be_mcc_notify(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1949,7 +1949,7 @@ int be_cmd_vlan_config(struct be_adapter *adapter, u32 if_id, u16 *vtag_array,
 	struct be_cmd_req_vlan_config *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1971,7 +1971,7 @@ int be_cmd_vlan_config(struct be_adapter *adapter, u32 if_id, u16 *vtag_array,
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1982,7 +1982,7 @@ static int __be_cmd_rx_filter(struct be_adapter *adapter, u32 flags, u32 value)
 	struct be_cmd_req_rx_filter *req = mem->va;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2015,7 +2015,7 @@ static int __be_cmd_rx_filter(struct be_adapter *adapter, u32 flags, u32 value)
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2046,7 +2046,7 @@ int be_cmd_set_flow_control(struct be_adapter *adapter, u32 tx_fc, u32 rx_fc)
 			    CMD_SUBSYSTEM_COMMON))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2066,7 +2066,7 @@ int be_cmd_set_flow_control(struct be_adapter *adapter, u32 tx_fc, u32 rx_fc)
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 
 	if (base_status(status) == MCC_STATUS_FEATURE_NOT_SUPPORTED)
 		return  -EOPNOTSUPP;
@@ -2085,7 +2085,7 @@ int be_cmd_get_flow_control(struct be_adapter *adapter, u32 *tx_fc, u32 *rx_fc)
 			    CMD_SUBSYSTEM_COMMON))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2108,7 +2108,7 @@ int be_cmd_get_flow_control(struct be_adapter *adapter, u32 *tx_fc, u32 *rx_fc)
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2189,7 +2189,7 @@ int be_cmd_rss_config(struct be_adapter *adapter, u8 *rsstable,
 	if (!(be_if_cap_flags(adapter) & BE_IF_FLAGS_RSS))
 		return 0;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2214,7 +2214,7 @@ int be_cmd_rss_config(struct be_adapter *adapter, u8 *rsstable,
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2226,7 +2226,7 @@ int be_cmd_set_beacon_state(struct be_adapter *adapter, u8 port_num,
 	struct be_cmd_req_enable_disable_beacon *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2247,7 +2247,7 @@ int be_cmd_set_beacon_state(struct be_adapter *adapter, u8 port_num,
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2258,7 +2258,7 @@ int be_cmd_get_beacon_state(struct be_adapter *adapter, u8 port_num, u32 *state)
 	struct be_cmd_req_get_beacon_state *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2282,7 +2282,7 @@ int be_cmd_get_beacon_state(struct be_adapter *adapter, u8 port_num, u32 *state)
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2306,7 +2306,7 @@ int be_cmd_read_port_transceiver_data(struct be_adapter *adapter,
 		return -ENOMEM;
 	}
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2328,7 +2328,7 @@ int be_cmd_read_port_transceiver_data(struct be_adapter *adapter,
 		memcpy(data, resp->page_data + off, len);
 	}
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma);
 	return status;
 }
@@ -2345,7 +2345,7 @@ static int lancer_cmd_write_object(struct be_adapter *adapter,
 	void *ctxt = NULL;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 	adapter->flash_status = 0;
 
 	wrb = wrb_from_mccq(adapter);
@@ -2387,7 +2387,7 @@ static int lancer_cmd_write_object(struct be_adapter *adapter,
 	if (status)
 		goto err_unlock;
 
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 
 	if (!wait_for_completion_timeout(&adapter->et_cmd_compl,
 					 msecs_to_jiffies(60000)))
@@ -2406,7 +2406,7 @@ static int lancer_cmd_write_object(struct be_adapter *adapter,
 	return status;
 
 err_unlock:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2460,7 +2460,7 @@ static int lancer_cmd_delete_object(struct be_adapter *adapter,
 	struct be_mcc_wrb *wrb;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2478,7 +2478,7 @@ static int lancer_cmd_delete_object(struct be_adapter *adapter,
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2491,7 +2491,7 @@ int lancer_cmd_read_object(struct be_adapter *adapter, struct be_dma_mem *cmd,
 	struct lancer_cmd_resp_read_object *resp;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2525,7 +2525,7 @@ int lancer_cmd_read_object(struct be_adapter *adapter, struct be_dma_mem *cmd,
 	}
 
 err_unlock:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2537,7 +2537,7 @@ static int be_cmd_write_flashrom(struct be_adapter *adapter,
 	struct be_cmd_write_flashrom *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 	adapter->flash_status = 0;
 
 	wrb = wrb_from_mccq(adapter);
@@ -2562,7 +2562,7 @@ static int be_cmd_write_flashrom(struct be_adapter *adapter,
 	if (status)
 		goto err_unlock;
 
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 
 	if (!wait_for_completion_timeout(&adapter->et_cmd_compl,
 					 msecs_to_jiffies(40000)))
@@ -2573,7 +2573,7 @@ static int be_cmd_write_flashrom(struct be_adapter *adapter,
 	return status;
 
 err_unlock:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2584,7 +2584,7 @@ static int be_cmd_get_flash_crc(struct be_adapter *adapter, u8 *flashed_crc,
 	struct be_mcc_wrb *wrb;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2611,7 +2611,7 @@ static int be_cmd_get_flash_crc(struct be_adapter *adapter, u8 *flashed_crc,
 		memcpy(flashed_crc, req->crc, 4);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3217,7 +3217,7 @@ int be_cmd_enable_magic_wol(struct be_adapter *adapter, u8 *mac,
 	struct be_cmd_req_acpi_wol_magic_config *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3234,7 +3234,7 @@ int be_cmd_enable_magic_wol(struct be_adapter *adapter, u8 *mac,
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3249,7 +3249,7 @@ int be_cmd_set_loopback(struct be_adapter *adapter, u8 port_num,
 			    CMD_SUBSYSTEM_LOWLEVEL))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3272,7 +3272,7 @@ int be_cmd_set_loopback(struct be_adapter *adapter, u8 port_num,
 	if (status)
 		goto err_unlock;
 
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 
 	if (!wait_for_completion_timeout(&adapter->et_cmd_compl,
 					 msecs_to_jiffies(SET_LB_MODE_TIMEOUT)))
@@ -3281,7 +3281,7 @@ int be_cmd_set_loopback(struct be_adapter *adapter, u8 port_num,
 	return status;
 
 err_unlock:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3298,7 +3298,7 @@ int be_cmd_loopback_test(struct be_adapter *adapter, u32 port_num,
 			    CMD_SUBSYSTEM_LOWLEVEL))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3324,7 +3324,7 @@ int be_cmd_loopback_test(struct be_adapter *adapter, u32 port_num,
 	if (status)
 		goto err;
 
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 
 	wait_for_completion(&adapter->et_cmd_compl);
 	resp = embedded_payload(wrb);
@@ -3332,7 +3332,7 @@ int be_cmd_loopback_test(struct be_adapter *adapter, u32 port_num,
 
 	return status;
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3348,7 +3348,7 @@ int be_cmd_ddr_dma_test(struct be_adapter *adapter, u64 pattern,
 			    CMD_SUBSYSTEM_LOWLEVEL))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3382,7 +3382,7 @@ int be_cmd_ddr_dma_test(struct be_adapter *adapter, u64 pattern,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3393,7 +3393,7 @@ int be_cmd_get_seeprom_data(struct be_adapter *adapter,
 	struct be_cmd_req_seeprom_read *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3409,7 +3409,7 @@ int be_cmd_get_seeprom_data(struct be_adapter *adapter,
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3424,7 +3424,7 @@ int be_cmd_get_phy_info(struct be_adapter *adapter)
 			    CMD_SUBSYSTEM_COMMON))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3469,7 +3469,7 @@ int be_cmd_get_phy_info(struct be_adapter *adapter)
 	}
 	dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3479,7 +3479,7 @@ static int be_cmd_set_qos(struct be_adapter *adapter, u32 bps, u32 domain)
 	struct be_cmd_req_set_qos *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3499,7 +3499,7 @@ static int be_cmd_set_qos(struct be_adapter *adapter, u32 bps, u32 domain)
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3611,7 +3611,7 @@ int be_cmd_get_fn_privileges(struct be_adapter *adapter, u32 *privilege,
 	struct be_cmd_req_get_fn_privileges *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3643,7 +3643,7 @@ int be_cmd_get_fn_privileges(struct be_adapter *adapter, u32 *privilege,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3655,7 +3655,7 @@ int be_cmd_set_fn_privileges(struct be_adapter *adapter, u32 privileges,
 	struct be_cmd_req_set_fn_privileges *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3675,7 +3675,7 @@ int be_cmd_set_fn_privileges(struct be_adapter *adapter, u32 privileges,
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3707,7 +3707,7 @@ int be_cmd_get_mac_from_list(struct be_adapter *adapter, u8 *mac,
 		return -ENOMEM;
 	}
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3771,7 +3771,7 @@ int be_cmd_get_mac_from_list(struct be_adapter *adapter, u8 *mac,
 	}
 
 out:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	dma_free_coherent(&adapter->pdev->dev, get_mac_list_cmd.size,
 			  get_mac_list_cmd.va, get_mac_list_cmd.dma);
 	return status;
@@ -3831,7 +3831,7 @@ int be_cmd_set_mac_list(struct be_adapter *adapter, u8 *mac_array,
 	if (!cmd.va)
 		return -ENOMEM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3853,7 +3853,7 @@ int be_cmd_set_mac_list(struct be_adapter *adapter, u8 *mac_array,
 
 err:
 	dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma);
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3889,7 +3889,7 @@ int be_cmd_set_hsw_config(struct be_adapter *adapter, u16 pvid,
 			    CMD_SUBSYSTEM_COMMON))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3930,7 +3930,7 @@ int be_cmd_set_hsw_config(struct be_adapter *adapter, u16 pvid,
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3944,7 +3944,7 @@ int be_cmd_get_hsw_config(struct be_adapter *adapter, u16 *pvid,
 	int status;
 	u16 vid;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3991,7 +3991,7 @@ int be_cmd_get_hsw_config(struct be_adapter *adapter, u16 *pvid,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -4190,7 +4190,7 @@ int be_cmd_set_ext_fat_capabilites(struct be_adapter *adapter,
 	struct be_cmd_req_set_ext_fat_caps *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -4206,7 +4206,7 @@ int be_cmd_set_ext_fat_capabilites(struct be_adapter *adapter,
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -4684,7 +4684,7 @@ int be_cmd_manage_iface(struct be_adapter *adapter, u32 iface, u8 op)
 	if (iface == 0xFFFFFFFF)
 		return -1;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -4701,7 +4701,7 @@ int be_cmd_manage_iface(struct be_adapter *adapter, u32 iface, u8 op)
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -4735,7 +4735,7 @@ int be_cmd_get_if_id(struct be_adapter *adapter, struct be_vf_cfg *vf_cfg,
 	struct be_cmd_resp_get_iface_list *resp;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -4756,7 +4756,7 @@ int be_cmd_get_if_id(struct be_adapter *adapter, struct be_vf_cfg *vf_cfg,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -4850,7 +4850,7 @@ int be_cmd_enable_vf(struct be_adapter *adapter, u8 domain)
 	if (BEx_chip(adapter))
 		return 0;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -4868,7 +4868,7 @@ int be_cmd_enable_vf(struct be_adapter *adapter, u8 domain)
 	req->enable = 1;
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -4941,7 +4941,7 @@ __be_cmd_set_logical_link_config(struct be_adapter *adapter,
 	u32 link_config = 0;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -4969,7 +4969,7 @@ __be_cmd_set_logical_link_config(struct be_adapter *adapter,
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -5000,8 +5000,7 @@ int be_cmd_set_features(struct be_adapter *adapter)
 	struct be_mcc_wrb *wrb;
 	int status;
 
-	if (mutex_lock_interruptible(&adapter->mcc_lock))
-		return -1;
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -5039,7 +5038,7 @@ int be_cmd_set_features(struct be_adapter *adapter)
 		dev_info(&adapter->pdev->dev,
 			 "Adapter does not support HW error recovery\n");
 
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -5053,7 +5052,7 @@ int be_roce_mcc_cmd(void *netdev_handle, void *wrb_payload,
 	struct be_cmd_resp_hdr *resp;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -5076,7 +5075,7 @@ int be_roce_mcc_cmd(void *netdev_handle, void *wrb_payload,
 	memcpy(wrb_payload, resp, sizeof(*resp) + resp->response_length);
 	be_dws_le_to_cpu(wrb_payload, sizeof(*resp) + resp->response_length);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 EXPORT_SYMBOL(be_roce_mcc_cmd);
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 875fe379eea2..3d2e21592119 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -5667,8 +5667,8 @@ static int be_drv_init(struct be_adapter *adapter)
 	}
 
 	mutex_init(&adapter->mbox_lock);
-	mutex_init(&adapter->mcc_lock);
 	mutex_init(&adapter->rx_filter_lock);
+	spin_lock_init(&adapter->mcc_lock);
 	spin_lock_init(&adapter->mcc_cq_lock);
 	init_completion(&adapter->et_cmd_compl);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
index bab16c2191b2..181af419b878 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
@@ -483,7 +483,7 @@ int hclge_ptp_init(struct hclge_dev *hdev)
 
 		ret = hclge_ptp_get_cycle(hdev);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	ret = hclge_ptp_int_en(hdev, true);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index f5acfb7d4ff6..ab7c2750c104 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -11,6 +11,8 @@
 #include "dwmac_dma.h"
 #include "dwmac1000.h"
 
+#define DRIVER_NAME "dwmac-loongson-pci"
+
 /* Normal Loongson Tx Summary */
 #define DMA_INTR_ENA_NIE_TX_LOONGSON	0x00040000
 /* Normal Loongson Rx Summary */
@@ -568,7 +570,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (pci_resource_len(pdev, i) == 0)
 			continue;
-		ret = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
+		ret = pcim_iomap_regions(pdev, BIT(0), DRIVER_NAME);
 		if (ret)
 			goto err_disable_device;
 		break;
@@ -687,7 +689,7 @@ static const struct pci_device_id loongson_dwmac_id_table[] = {
 MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
 
 static struct pci_driver loongson_dwmac_driver = {
-	.name = "dwmac-loongson-pci",
+	.name = DRIVER_NAME,
 	.id_table = loongson_dwmac_id_table,
 	.probe = loongson_dwmac_probe,
 	.remove = loongson_dwmac_remove,
diff --git a/drivers/net/ipa/data/ipa_data-v4.7.c b/drivers/net/ipa/data/ipa_data-v4.7.c
index c8c23d9be961..41f212209993 100644
--- a/drivers/net/ipa/data/ipa_data-v4.7.c
+++ b/drivers/net/ipa/data/ipa_data-v4.7.c
@@ -28,20 +28,18 @@ enum ipa_resource_type {
 enum ipa_rsrc_group_id {
 	/* Source resource group identifiers */
 	IPA_RSRC_GROUP_SRC_UL_DL			= 0,
-	IPA_RSRC_GROUP_SRC_UC_RX_Q,
 	IPA_RSRC_GROUP_SRC_COUNT,	/* Last in set; not a source group */
 
 	/* Destination resource group identifiers */
-	IPA_RSRC_GROUP_DST_UL_DL_DPL			= 0,
-	IPA_RSRC_GROUP_DST_UNUSED_1,
+	IPA_RSRC_GROUP_DST_UL_DL			= 0,
 	IPA_RSRC_GROUP_DST_COUNT,	/* Last; not a destination group */
 };
 
 /* QSB configuration data for an SoC having IPA v4.7 */
 static const struct ipa_qsb_data ipa_qsb_data[] = {
 	[IPA_QSB_MASTER_DDR] = {
-		.max_writes		= 8,
-		.max_reads		= 0,	/* no limit (hardware max) */
+		.max_writes		= 12,
+		.max_reads		= 13,
 		.max_reads_beats	= 120,
 	},
 };
@@ -81,7 +79,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 		},
 		.endpoint = {
 			.config = {
-				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL_DPL,
+				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL,
 				.aggregation	= true,
 				.status_enable	= true,
 				.rx = {
@@ -106,6 +104,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 			.filter_support	= true,
 			.config = {
 				.resource_group	= IPA_RSRC_GROUP_SRC_UL_DL,
+				.checksum       = true,
 				.qmap		= true,
 				.status_enable	= true,
 				.tx = {
@@ -128,7 +127,8 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 		},
 		.endpoint = {
 			.config = {
-				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL_DPL,
+				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL,
+				.checksum       = true,
 				.qmap		= true,
 				.aggregation	= true,
 				.rx = {
@@ -197,12 +197,12 @@ static const struct ipa_resource ipa_resource_src[] = {
 /* Destination resource configuration data for an SoC having IPA v4.7 */
 static const struct ipa_resource ipa_resource_dst[] = {
 	[IPA_RESOURCE_TYPE_DST_DATA_SECTORS] = {
-		.limits[IPA_RSRC_GROUP_DST_UL_DL_DPL] = {
+		.limits[IPA_RSRC_GROUP_DST_UL_DL] = {
 			.min = 7,	.max = 7,
 		},
 	},
 	[IPA_RESOURCE_TYPE_DST_DPS_DMARS] = {
-		.limits[IPA_RSRC_GROUP_DST_UL_DL_DPL] = {
+		.limits[IPA_RSRC_GROUP_DST_UL_DL] = {
 			.min = 2,	.max = 2,
 		},
 	},
diff --git a/drivers/net/mctp/mctp-i3c.c b/drivers/net/mctp/mctp-i3c.c
index ee9d562f0817..a2b15cddf46e 100644
--- a/drivers/net/mctp/mctp-i3c.c
+++ b/drivers/net/mctp/mctp-i3c.c
@@ -507,6 +507,9 @@ static int mctp_i3c_header_create(struct sk_buff *skb, struct net_device *dev,
 {
 	struct mctp_i3c_internal_hdr *ihdr;
 
+	if (!daddr || !saddr)
+		return -EINVAL;
+
 	skb_push(skb, sizeof(struct mctp_i3c_internal_hdr));
 	skb_reset_mac_header(skb);
 	ihdr = (void *)skb_mac_header(skb);
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 4f3e742907cb..c9cfdc33fc5f 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -615,6 +615,49 @@ int phy_ethtool_get_stats(struct phy_device *phydev,
 }
 EXPORT_SYMBOL(phy_ethtool_get_stats);
 
+/**
+ * __phy_ethtool_get_phy_stats - Retrieve standardized PHY statistics
+ * @phydev: Pointer to the PHY device
+ * @phy_stats: Pointer to ethtool_eth_phy_stats structure
+ * @phydev_stats: Pointer to ethtool_phy_stats structure
+ *
+ * Fetches PHY statistics using a kernel-defined interface for consistent
+ * diagnostics. Unlike phy_ethtool_get_stats(), which allows custom stats,
+ * this function enforces a standardized format for better interoperability.
+ */
+void __phy_ethtool_get_phy_stats(struct phy_device *phydev,
+				 struct ethtool_eth_phy_stats *phy_stats,
+				 struct ethtool_phy_stats *phydev_stats)
+{
+	if (!phydev->drv || !phydev->drv->get_phy_stats)
+		return;
+
+	mutex_lock(&phydev->lock);
+	phydev->drv->get_phy_stats(phydev, phy_stats, phydev_stats);
+	mutex_unlock(&phydev->lock);
+}
+
+/**
+ * __phy_ethtool_get_link_ext_stats - Retrieve extended link statistics for a PHY
+ * @phydev: Pointer to the PHY device
+ * @link_stats: Pointer to the structure to store extended link statistics
+ *
+ * Populates the ethtool_link_ext_stats structure with link down event counts
+ * and additional driver-specific link statistics, if available.
+ */
+void __phy_ethtool_get_link_ext_stats(struct phy_device *phydev,
+				      struct ethtool_link_ext_stats *link_stats)
+{
+	link_stats->link_down_events = READ_ONCE(phydev->link_down_events);
+
+	if (!phydev->drv || !phydev->drv->get_link_stats)
+		return;
+
+	mutex_lock(&phydev->lock);
+	phydev->drv->get_link_stats(phydev, link_stats);
+	mutex_unlock(&phydev->lock);
+}
+
 /**
  * phy_ethtool_get_plca_cfg - Get PLCA RS configuration
  * @phydev: the phy_device struct
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 499797646580..119dfa2d6643 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3776,6 +3776,8 @@ static const struct ethtool_phy_ops phy_ethtool_phy_ops = {
 static const struct phylib_stubs __phylib_stubs = {
 	.hwtstamp_get = __phy_hwtstamp_get,
 	.hwtstamp_set = __phy_hwtstamp_set,
+	.get_phy_stats = __phy_ethtool_get_phy_stats,
+	.get_link_ext_stats = __phy_ethtool_get_link_ext_stats,
 };
 
 static void phylib_register_stubs(void)
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 4583e15ad03a..1420c4efa48e 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -72,6 +72,17 @@
 #define PPP_PROTO_LEN	2
 #define PPP_LCP_HDRLEN	4
 
+/* The filter instructions generated by libpcap are constructed
+ * assuming a four-byte PPP header on each packet, where the last
+ * 2 bytes are the protocol field defined in the RFC and the first
+ * byte of the first 2 bytes indicates the direction.
+ * The second byte is currently unused, but we still need to initialize
+ * it to prevent crafted BPF programs from reading them which would
+ * cause reading of uninitialized data.
+ */
+#define PPP_FILTER_OUTBOUND_TAG 0x0100
+#define PPP_FILTER_INBOUND_TAG  0x0000
+
 /*
  * An instance of /dev/ppp can be associated with either a ppp
  * interface unit or a ppp channel.  In both cases, file->private_data
@@ -1762,10 +1773,10 @@ ppp_send_frame(struct ppp *ppp, struct sk_buff *skb)
 
 	if (proto < 0x8000) {
 #ifdef CONFIG_PPP_FILTER
-		/* check if we should pass this packet */
-		/* the filter instructions are constructed assuming
-		   a four-byte PPP header on each packet */
-		*(u8 *)skb_push(skb, 2) = 1;
+		/* check if the packet passes the pass and active filters.
+		 * See comment for PPP_FILTER_OUTBOUND_TAG above.
+		 */
+		*(__be16 *)skb_push(skb, 2) = htons(PPP_FILTER_OUTBOUND_TAG);
 		if (ppp->pass_filter &&
 		    bpf_prog_run(ppp->pass_filter, skb) == 0) {
 			if (ppp->debug & 1)
@@ -2482,14 +2493,13 @@ ppp_receive_nonmp_frame(struct ppp *ppp, struct sk_buff *skb)
 		/* network protocol frame - give it to the kernel */
 
 #ifdef CONFIG_PPP_FILTER
-		/* check if the packet passes the pass and active filters */
-		/* the filter instructions are constructed assuming
-		   a four-byte PPP header on each packet */
 		if (ppp->pass_filter || ppp->active_filter) {
 			if (skb_unclone(skb, GFP_ATOMIC))
 				goto err;
-
-			*(u8 *)skb_push(skb, 2) = 0;
+			/* Check if the packet passes the pass and active filters.
+			 * See comment for PPP_FILTER_INBOUND_TAG above.
+			 */
+			*(__be16 *)skb_push(skb, 2) = htons(PPP_FILTER_INBOUND_TAG);
 			if (ppp->pass_filter &&
 			    bpf_prog_run(ppp->pass_filter, skb) == 0) {
 				if (ppp->debug & 1)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index c620911a1193..754e01688900 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1197,7 +1197,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 
 			if (tlv_len != sizeof(*fseq_ver))
 				goto invalid_tlv_len;
-			IWL_INFO(drv, "TLV_FW_FSEQ_VERSION: %s\n",
+			IWL_INFO(drv, "TLV_FW_FSEQ_VERSION: %.32s\n",
 				 fseq_ver->version);
 			}
 			break;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 91ca830a7b60..f4276fdee6be 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1518,6 +1518,13 @@ static ssize_t iwl_dbgfs_fw_dbg_clear_write(struct iwl_mvm *mvm,
 	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_9000)
 		return -EOPNOTSUPP;
 
+	/*
+	 * If the firmware is not running, silently succeed since there is
+	 * no data to clear.
+	 */
+	if (!iwl_mvm_firmware_running(mvm))
+		return count;
+
 	mutex_lock(&mvm->mutex);
 	iwl_fw_dbg_clear_monitor_buf(&mvm->fwrt);
 	mutex_unlock(&mvm->mutex);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 72fa7ac86516..17b8ccc27569 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -1030,6 +1030,8 @@ void iwl_mvm_rx_session_protect_notif(struct iwl_mvm *mvm,
 		/* End TE, notify mac80211 */
 		mvmvif->time_event_data.id = SESSION_PROTECT_CONF_MAX_ID;
 		mvmvif->time_event_data.link_id = -1;
+		/* set the bit so the ROC cleanup will actually clean up */
+		set_bit(IWL_MVM_STATUS_ROC_P2P_RUNNING, &mvm->status);
 		iwl_mvm_roc_finished(mvm);
 		ieee80211_remain_on_channel_expired(mvm->hw);
 	} else if (le32_to_cpu(notif->start)) {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 27a7e0b5b3d5..ebe9b25cc53a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2003-2015, 2018-2024 Intel Corporation
+ * Copyright (C) 2003-2015, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -643,7 +643,8 @@ dma_addr_t iwl_pcie_get_sgt_tb_phys(struct sg_table *sgt, unsigned int offset,
 				    unsigned int len);
 struct sg_table *iwl_pcie_prep_tso(struct iwl_trans *trans, struct sk_buff *skb,
 				   struct iwl_cmd_meta *cmd_meta,
-				   u8 **hdr, unsigned int hdr_room);
+				   u8 **hdr, unsigned int hdr_room,
+				   unsigned int offset);
 
 void iwl_pcie_free_tso_pages(struct iwl_trans *trans, struct sk_buff *skb,
 			     struct iwl_cmd_meta *cmd_meta);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index b1846abb99b7..477a05cd1288 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2020, 2023-2024 Intel Corporation
+ * Copyright (C) 2018-2020, 2023-2025 Intel Corporation
  */
 #include <net/tso.h>
 #include <linux/tcp.h>
@@ -188,7 +188,8 @@ static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
 		(3 + snap_ip_tcp_hdrlen + sizeof(struct ethhdr));
 
 	/* Our device supports 9 segments at most, it will fit in 1 page */
-	sgt = iwl_pcie_prep_tso(trans, skb, out_meta, &start_hdr, hdr_room);
+	sgt = iwl_pcie_prep_tso(trans, skb, out_meta, &start_hdr, hdr_room,
+				snap_ip_tcp_hdrlen + hdr_len);
 	if (!sgt)
 		return -ENOMEM;
 
@@ -347,6 +348,7 @@ iwl_tfh_tfd *iwl_txq_gen2_build_tx_amsdu(struct iwl_trans *trans,
 	return tfd;
 
 out_err:
+	iwl_pcie_free_tso_pages(trans, skb, out_meta);
 	iwl_txq_gen2_tfd_unmap(trans, out_meta, tfd);
 	return NULL;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 9fe050f0ddc1..9fcdd06e126a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2003-2014, 2018-2021, 2023-2024 Intel Corporation
+ * Copyright (C) 2003-2014, 2018-2021, 2023-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1853,6 +1853,7 @@ dma_addr_t iwl_pcie_get_sgt_tb_phys(struct sg_table *sgt, unsigned int offset,
  * @cmd_meta: command meta to store the scatter list information for unmapping
  * @hdr: output argument for TSO headers
  * @hdr_room: requested length for TSO headers
+ * @offset: offset into the data from which mapping should start
  *
  * Allocate space for a scatter gather list and TSO headers and map the SKB
  * using the scatter gather list. The SKB is unmapped again when the page is
@@ -1862,9 +1863,12 @@ dma_addr_t iwl_pcie_get_sgt_tb_phys(struct sg_table *sgt, unsigned int offset,
  */
 struct sg_table *iwl_pcie_prep_tso(struct iwl_trans *trans, struct sk_buff *skb,
 				   struct iwl_cmd_meta *cmd_meta,
-				   u8 **hdr, unsigned int hdr_room)
+				   u8 **hdr, unsigned int hdr_room,
+				   unsigned int offset)
 {
 	struct sg_table *sgt;
+	unsigned int n_segments = skb_shinfo(skb)->nr_frags + 1;
+	int orig_nents;
 
 	if (WARN_ON_ONCE(skb_has_frag_list(skb)))
 		return NULL;
@@ -1872,8 +1876,7 @@ struct sg_table *iwl_pcie_prep_tso(struct iwl_trans *trans, struct sk_buff *skb,
 	*hdr = iwl_pcie_get_page_hdr(trans,
 				     hdr_room + __alignof__(struct sg_table) +
 				     sizeof(struct sg_table) +
-				     (skb_shinfo(skb)->nr_frags + 1) *
-				     sizeof(struct scatterlist),
+				     n_segments * sizeof(struct scatterlist),
 				     skb);
 	if (!*hdr)
 		return NULL;
@@ -1881,14 +1884,15 @@ struct sg_table *iwl_pcie_prep_tso(struct iwl_trans *trans, struct sk_buff *skb,
 	sgt = (void *)PTR_ALIGN(*hdr + hdr_room, __alignof__(struct sg_table));
 	sgt->sgl = (void *)(sgt + 1);
 
-	sg_init_table(sgt->sgl, skb_shinfo(skb)->nr_frags + 1);
+	sg_init_table(sgt->sgl, n_segments);
 
 	/* Only map the data, not the header (it is copied to the TSO page) */
-	sgt->orig_nents = skb_to_sgvec(skb, sgt->sgl, skb_headlen(skb),
-				       skb->data_len);
-	if (WARN_ON_ONCE(sgt->orig_nents <= 0))
+	orig_nents = skb_to_sgvec(skb, sgt->sgl, offset, skb->len - offset);
+	if (WARN_ON_ONCE(orig_nents <= 0))
 		return NULL;
 
+	sgt->orig_nents = orig_nents;
+
 	/* And map the entire SKB */
 	if (dma_map_sgtable(trans->dev, sgt, DMA_TO_DEVICE, 0) < 0)
 		return NULL;
@@ -1937,7 +1941,8 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 		(3 + snap_ip_tcp_hdrlen + sizeof(struct ethhdr)) + iv_len;
 
 	/* Our device supports 9 segments at most, it will fit in 1 page */
-	sgt = iwl_pcie_prep_tso(trans, skb, out_meta, &start_hdr, hdr_room);
+	sgt = iwl_pcie_prep_tso(trans, skb, out_meta, &start_hdr, hdr_room,
+				snap_ip_tcp_hdrlen + hdr_len + iv_len);
 	if (!sgt)
 		return -ENOMEM;
 
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 61af1583356c..e4daac9c2440 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -120,19 +120,31 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	struct nvme_ns *ns = q->queuedata;
 	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
 	bool supports_metadata = bdev && blk_get_integrity(bdev->bd_disk);
+	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
 	bool has_metadata = meta_buffer && meta_len;
 	struct bio *bio = NULL;
 	int ret;
 
-	if (has_metadata && !supports_metadata)
-		return -EINVAL;
+	if (!nvme_ctrl_sgl_supported(ctrl))
+		dev_warn_once(ctrl->device, "using unchecked data buffer\n");
+	if (has_metadata) {
+		if (!supports_metadata) {
+			ret = -EINVAL;
+			goto out;
+		}
+		if (!nvme_ctrl_meta_sgl_supported(ctrl))
+			dev_warn_once(ctrl->device,
+				      "using unchecked metadata buffer\n");
+	}
 
 	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		struct iov_iter iter;
 
 		/* fixedbufs is only for non-vectored io */
-		if (WARN_ON_ONCE(flags & NVME_IOCTL_VEC))
-			return -EINVAL;
+		if (WARN_ON_ONCE(flags & NVME_IOCTL_VEC)) {
+			ret = -EINVAL;
+			goto out;
+		}
 		ret = io_uring_cmd_import_fixed(ubuffer, bufflen,
 				rq_data_dir(req), &iter, ioucmd);
 		if (ret < 0)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 61bba5513de0..dcdce7d12e44 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1130,6 +1130,13 @@ static inline bool nvme_ctrl_sgl_supported(struct nvme_ctrl *ctrl)
 	return ctrl->sgls & ((1 << 0) | (1 << 1));
 }
 
+static inline bool nvme_ctrl_meta_sgl_supported(struct nvme_ctrl *ctrl)
+{
+	if (ctrl->ops->flags & NVME_F_FABRICS)
+		return true;
+	return ctrl->sgls & NVME_CTRL_SGLS_MSDS;
+}
+
 #ifdef CONFIG_NVME_HOST_AUTH
 int __init nvme_init_auth(void);
 void __exit nvme_exit_auth(void);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cc74682dc0d4..e1329d4974fd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -43,6 +43,7 @@
  */
 #define NVME_MAX_KB_SZ	8192
 #define NVME_MAX_SEGS	128
+#define NVME_MAX_META_SEGS 15
 #define NVME_MAX_NR_ALLOCATIONS	5
 
 static int use_threaded_interrupts;
@@ -143,6 +144,7 @@ struct nvme_dev {
 	bool hmb;
 
 	mempool_t *iod_mempool;
+	mempool_t *iod_meta_mempool;
 
 	/* shadow doorbell buffer support: */
 	__le32 *dbbuf_dbs;
@@ -238,6 +240,8 @@ struct nvme_iod {
 	dma_addr_t first_dma;
 	dma_addr_t meta_dma;
 	struct sg_table sgt;
+	struct sg_table meta_sgt;
+	union nvme_descriptor meta_list;
 	union nvme_descriptor list[NVME_MAX_NR_ALLOCATIONS];
 };
 
@@ -505,6 +509,15 @@ static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
 	spin_unlock(&nvmeq->sq_lock);
 }
 
+static inline bool nvme_pci_metadata_use_sgls(struct nvme_dev *dev,
+					      struct request *req)
+{
+	if (!nvme_ctrl_meta_sgl_supported(&dev->ctrl))
+		return false;
+	return req->nr_integrity_segments > 1 ||
+		nvme_req(req)->flags & NVME_REQ_USERCMD;
+}
+
 static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req,
 				     int nseg)
 {
@@ -517,8 +530,10 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req,
 		return false;
 	if (!nvmeq->qid)
 		return false;
+	if (nvme_pci_metadata_use_sgls(dev, req))
+		return true;
 	if (!sgl_threshold || avg_seg_size < sgl_threshold)
-		return false;
+		return nvme_req(req)->flags & NVME_REQ_USERCMD;
 	return true;
 }
 
@@ -779,7 +794,8 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct bio_vec bv = req_bvec(req);
 
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
-			if ((bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1)) +
+			if (!nvme_pci_metadata_use_sgls(dev, req) &&
+			    (bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1)) +
 			     bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
 				return nvme_setup_prp_simple(dev, req,
 							     &cmnd->rw, &bv);
@@ -823,11 +839,69 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	return ret;
 }
 
-static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
-		struct nvme_command *cmnd)
+static blk_status_t nvme_pci_setup_meta_sgls(struct nvme_dev *dev,
+					     struct request *req)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_rw_command *cmnd = &iod->cmd.rw;
+	struct nvme_sgl_desc *sg_list;
+	struct scatterlist *sgl, *sg;
+	unsigned int entries;
+	dma_addr_t sgl_dma;
+	int rc, i;
+
+	iod->meta_sgt.sgl = mempool_alloc(dev->iod_meta_mempool, GFP_ATOMIC);
+	if (!iod->meta_sgt.sgl)
+		return BLK_STS_RESOURCE;
+
+	sg_init_table(iod->meta_sgt.sgl, req->nr_integrity_segments);
+	iod->meta_sgt.orig_nents = blk_rq_map_integrity_sg(req,
+							   iod->meta_sgt.sgl);
+	if (!iod->meta_sgt.orig_nents)
+		goto out_free_sg;
+
+	rc = dma_map_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req),
+			     DMA_ATTR_NO_WARN);
+	if (rc)
+		goto out_free_sg;
+
+	sg_list = dma_pool_alloc(dev->prp_small_pool, GFP_ATOMIC, &sgl_dma);
+	if (!sg_list)
+		goto out_unmap_sg;
+
+	entries = iod->meta_sgt.nents;
+	iod->meta_list.sg_list = sg_list;
+	iod->meta_dma = sgl_dma;
+
+	cmnd->flags = NVME_CMD_SGL_METASEG;
+	cmnd->metadata = cpu_to_le64(sgl_dma);
+
+	sgl = iod->meta_sgt.sgl;
+	if (entries == 1) {
+		nvme_pci_sgl_set_data(sg_list, sgl);
+		return BLK_STS_OK;
+	}
+
+	sgl_dma += sizeof(*sg_list);
+	nvme_pci_sgl_set_seg(sg_list, sgl_dma, entries);
+	for_each_sg(sgl, sg, entries, i)
+		nvme_pci_sgl_set_data(&sg_list[i + 1], sg);
+
+	return BLK_STS_OK;
+
+out_unmap_sg:
+	dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
+out_free_sg:
+	mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
+	return BLK_STS_RESOURCE;
+}
+
+static blk_status_t nvme_pci_setup_meta_mptr(struct nvme_dev *dev,
+					     struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct bio_vec bv = rq_integrity_vec(req);
+	struct nvme_command *cmnd = &iod->cmd;
 
 	iod->meta_dma = dma_map_bvec(dev->dev, &bv, rq_dma_dir(req), 0);
 	if (dma_mapping_error(dev->dev, iod->meta_dma))
@@ -836,6 +910,13 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
 	return BLK_STS_OK;
 }
 
+static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req)
+{
+	if (nvme_pci_metadata_use_sgls(dev, req))
+		return nvme_pci_setup_meta_sgls(dev, req);
+	return nvme_pci_setup_meta_mptr(dev, req);
+}
+
 static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -844,6 +925,7 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 	iod->aborted = false;
 	iod->nr_allocations = -1;
 	iod->sgt.nents = 0;
+	iod->meta_sgt.nents = 0;
 
 	ret = nvme_setup_cmd(req->q->queuedata, req);
 	if (ret)
@@ -856,7 +938,7 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 	}
 
 	if (blk_integrity_rq(req)) {
-		ret = nvme_map_metadata(dev, req, &iod->cmd);
+		ret = nvme_map_metadata(dev, req);
 		if (ret)
 			goto out_unmap_data;
 	}
@@ -955,17 +1037,31 @@ static void nvme_queue_rqs(struct request **rqlist)
 	*rqlist = requeue_list;
 }
 
+static __always_inline void nvme_unmap_metadata(struct nvme_dev *dev,
+						struct request *req)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+
+	if (!iod->meta_sgt.nents) {
+		dma_unmap_page(dev->dev, iod->meta_dma,
+			       rq_integrity_vec(req).bv_len,
+			       rq_dma_dir(req));
+		return;
+	}
+
+	dma_pool_free(dev->prp_small_pool, iod->meta_list.sg_list,
+		      iod->meta_dma);
+	dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
+	mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
+}
+
 static __always_inline void nvme_pci_unmap_rq(struct request *req)
 {
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	struct nvme_dev *dev = nvmeq->dev;
 
-	if (blk_integrity_rq(req)) {
-	        struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-
-		dma_unmap_page(dev->dev, iod->meta_dma,
-			       rq_integrity_vec(req).bv_len, rq_dma_dir(req));
-	}
+	if (blk_integrity_rq(req))
+		nvme_unmap_metadata(dev, req);
 
 	if (blk_rq_nr_phys_segments(req))
 		nvme_unmap_data(dev, req);
@@ -2719,6 +2815,7 @@ static void nvme_release_prp_pools(struct nvme_dev *dev)
 
 static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
 {
+	size_t meta_size = sizeof(struct scatterlist) * (NVME_MAX_META_SEGS + 1);
 	size_t alloc_size = sizeof(struct scatterlist) * NVME_MAX_SEGS;
 
 	dev->iod_mempool = mempool_create_node(1,
@@ -2727,7 +2824,18 @@ static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
 			dev_to_node(dev->dev));
 	if (!dev->iod_mempool)
 		return -ENOMEM;
+
+	dev->iod_meta_mempool = mempool_create_node(1,
+			mempool_kmalloc, mempool_kfree,
+			(void *)meta_size, GFP_KERNEL,
+			dev_to_node(dev->dev));
+	if (!dev->iod_meta_mempool)
+		goto free;
+
 	return 0;
+free:
+	mempool_destroy(dev->iod_mempool);
+	return -ENOMEM;
 }
 
 static void nvme_free_tagset(struct nvme_dev *dev)
@@ -2792,6 +2900,11 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
+	if (nvme_ctrl_meta_sgl_supported(&dev->ctrl))
+		dev->ctrl.max_integrity_segments = NVME_MAX_META_SEGS;
+	else
+		dev->ctrl.max_integrity_segments = 1;
+
 	nvme_dbbuf_dma_alloc(dev);
 
 	result = nvme_setup_host_mem(dev);
@@ -3061,11 +3174,6 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	dev->ctrl.max_hw_sectors = min_t(u32,
 		NVME_MAX_KB_SZ << 1, dma_opt_mapping_size(&pdev->dev) >> 9);
 	dev->ctrl.max_segments = NVME_MAX_SEGS;
-
-	/*
-	 * There is no support for SGLs for metadata (yet), so we are limited to
-	 * a single integrity segment for the separate metadata pointer.
-	 */
 	dev->ctrl.max_integrity_segments = 1;
 	return dev;
 
@@ -3128,6 +3236,11 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto out_disable;
 
+	if (nvme_ctrl_meta_sgl_supported(&dev->ctrl))
+		dev->ctrl.max_integrity_segments = NVME_MAX_META_SEGS;
+	else
+		dev->ctrl.max_integrity_segments = 1;
+
 	nvme_dbbuf_dma_alloc(dev);
 
 	result = nvme_setup_host_mem(dev);
@@ -3170,6 +3283,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	nvme_free_queues(dev, 0);
 out_release_iod_mempool:
 	mempool_destroy(dev->iod_mempool);
+	mempool_destroy(dev->iod_meta_mempool);
 out_release_prp_pools:
 	nvme_release_prp_pools(dev);
 out_dev_unmap:
@@ -3235,6 +3349,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dbbuf_dma_free(dev);
 	nvme_free_queues(dev, 0);
 	mempool_destroy(dev->iod_mempool);
+	mempool_destroy(dev->iod_meta_mempool);
 	nvme_release_prp_pools(dev);
 	nvme_dev_unmap(dev);
 	nvme_uninit_ctrl(&dev->ctrl);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 840ae475074d..eeb05b7bc0fd 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -217,6 +217,19 @@ static inline int nvme_tcp_queue_id(struct nvme_tcp_queue *queue)
 	return queue - queue->ctrl->queues;
 }
 
+static inline bool nvme_tcp_recv_pdu_supported(enum nvme_tcp_pdu_type type)
+{
+	switch (type) {
+	case nvme_tcp_c2h_term:
+	case nvme_tcp_c2h_data:
+	case nvme_tcp_r2t:
+	case nvme_tcp_rsp:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /*
  * Check if the queue is TLS encrypted
  */
@@ -763,6 +776,40 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	return 0;
 }
 
+static void nvme_tcp_handle_c2h_term(struct nvme_tcp_queue *queue,
+		struct nvme_tcp_term_pdu *pdu)
+{
+	u16 fes;
+	const char *msg;
+	u32 plen = le32_to_cpu(pdu->hdr.plen);
+
+	static const char * const msg_table[] = {
+		[NVME_TCP_FES_INVALID_PDU_HDR] = "Invalid PDU Header Field",
+		[NVME_TCP_FES_PDU_SEQ_ERR] = "PDU Sequence Error",
+		[NVME_TCP_FES_HDR_DIGEST_ERR] = "Header Digest Error",
+		[NVME_TCP_FES_DATA_OUT_OF_RANGE] = "Data Transfer Out Of Range",
+		[NVME_TCP_FES_DATA_LIMIT_EXCEEDED] = "Data Transfer Limit Exceeded",
+		[NVME_TCP_FES_UNSUPPORTED_PARAM] = "Unsupported Parameter",
+	};
+
+	if (plen < NVME_TCP_MIN_C2HTERM_PLEN ||
+	    plen > NVME_TCP_MAX_C2HTERM_PLEN) {
+		dev_err(queue->ctrl->ctrl.device,
+			"Received a malformed C2HTermReq PDU (plen = %u)\n",
+			plen);
+		return;
+	}
+
+	fes = le16_to_cpu(pdu->fes);
+	if (fes && fes < ARRAY_SIZE(msg_table))
+		msg = msg_table[fes];
+	else
+		msg = "Unknown";
+
+	dev_err(queue->ctrl->ctrl.device,
+		"Received C2HTermReq (FES = %s)\n", msg);
+}
+
 static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		unsigned int *offset, size_t *len)
 {
@@ -784,6 +831,25 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		return 0;
 
 	hdr = queue->pdu;
+	if (unlikely(hdr->hlen != sizeof(struct nvme_tcp_rsp_pdu))) {
+		if (!nvme_tcp_recv_pdu_supported(hdr->type))
+			goto unsupported_pdu;
+
+		dev_err(queue->ctrl->ctrl.device,
+			"pdu type %d has unexpected header length (%d)\n",
+			hdr->type, hdr->hlen);
+		return -EPROTO;
+	}
+
+	if (unlikely(hdr->type == nvme_tcp_c2h_term)) {
+		/*
+		 * C2HTermReq never includes Header or Data digests.
+		 * Skip the checks.
+		 */
+		nvme_tcp_handle_c2h_term(queue, (void *)queue->pdu);
+		return -EINVAL;
+	}
+
 	if (queue->hdr_digest) {
 		ret = nvme_tcp_verify_hdgst(queue, queue->pdu, hdr->hlen);
 		if (unlikely(ret))
@@ -807,10 +873,13 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		nvme_tcp_init_recv_ctx(queue);
 		return nvme_tcp_handle_r2t(queue, (void *)queue->pdu);
 	default:
-		dev_err(queue->ctrl->ctrl.device,
-			"unsupported pdu type (%d)\n", hdr->type);
-		return -EINVAL;
+		goto unsupported_pdu;
 	}
+
+unsupported_pdu:
+	dev_err(queue->ctrl->ctrl.device,
+		"unsupported pdu type (%d)\n", hdr->type);
+	return -EINVAL;
 }
 
 static inline void nvme_tcp_end_request(struct request *rq, u16 status)
@@ -1452,11 +1521,11 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	msg.msg_flags = MSG_WAITALL;
 	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
 			iov.iov_len, msg.msg_flags);
-	if (ret < sizeof(*icresp)) {
+	if (ret >= 0 && ret < sizeof(*icresp))
+		ret = -ECONNRESET;
+	if (ret < 0) {
 		pr_warn("queue %d: failed to receive icresp, error %d\n",
 			nvme_tcp_queue_id(queue), ret);
-		if (ret >= 0)
-			ret = -ECONNRESET;
 		goto free_icresp;
 	}
 	ret = -ENOTCONN;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7c51c2a8c109..4f9cac8a5abe 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -571,10 +571,16 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 	struct nvmet_tcp_cmd *cmd =
 		container_of(req, struct nvmet_tcp_cmd, req);
 	struct nvmet_tcp_queue	*queue = cmd->queue;
+	enum nvmet_tcp_recv_state queue_state;
+	struct nvmet_tcp_cmd *queue_cmd;
 	struct nvme_sgl_desc *sgl;
 	u32 len;
 
-	if (unlikely(cmd == queue->cmd)) {
+	/* Pairs with store_release in nvmet_prepare_receive_pdu() */
+	queue_state = smp_load_acquire(&queue->rcv_state);
+	queue_cmd = READ_ONCE(queue->cmd);
+
+	if (unlikely(cmd == queue_cmd)) {
 		sgl = &cmd->req.cmd->common.dptr.sgl;
 		len = le32_to_cpu(sgl->length);
 
@@ -583,7 +589,7 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 		 * Avoid using helpers, this might happen before
 		 * nvmet_req_init is completed.
 		 */
-		if (queue->rcv_state == NVMET_TCP_RECV_PDU &&
+		if (queue_state == NVMET_TCP_RECV_PDU &&
 		    len && len <= cmd->req.port->inline_data_size &&
 		    nvme_is_write(cmd->req.cmd))
 			return;
@@ -847,8 +853,9 @@ static void nvmet_prepare_receive_pdu(struct nvmet_tcp_queue *queue)
 {
 	queue->offset = 0;
 	queue->left = sizeof(struct nvme_tcp_hdr);
-	queue->cmd = NULL;
-	queue->rcv_state = NVMET_TCP_RECV_PDU;
+	WRITE_ONCE(queue->cmd, NULL);
+	/* Ensure rcv_state is visible only after queue->cmd is set */
+	smp_store_release(&queue->rcv_state, NVMET_TCP_RECV_PDU);
 }
 
 static void nvmet_tcp_free_crypto(struct nvmet_tcp_queue *queue)
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index e45d6d3a8dc6..45445a1600a9 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -360,12 +360,12 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 
 	prop = of_get_flat_dt_prop(node, "alignment", &len);
 	if (prop) {
-		if (len != dt_root_size_cells * sizeof(__be32)) {
+		if (len != dt_root_addr_cells * sizeof(__be32)) {
 			pr_err("invalid alignment property in '%s' node.\n",
 				uname);
 			return -EINVAL;
 		}
-		align = dt_mem_next_cell(dt_root_size_cells, &prop);
+		align = dt_mem_next_cell(dt_root_addr_cells, &prop);
 	}
 
 	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 2cfb2ac3f465..84dcd7da7319 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9958,6 +9958,7 @@ static const struct tpacpi_quirk battery_quirk_table[] __initconst = {
 	 * Individual addressing is broken on models that expose the
 	 * primary battery as BAT1.
 	 */
+	TPACPI_Q_LNV('G', '8', true),       /* ThinkPad X131e */
 	TPACPI_Q_LNV('8', 'F', true),       /* Thinkpad X120e */
 	TPACPI_Q_LNV('J', '7', true),       /* B5400 */
 	TPACPI_Q_LNV('J', 'I', true),       /* Thinkpad 11e */
diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 27afbb9d544b..cbf531d0ba68 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -1742,7 +1742,8 @@ static int rio_mport_add_riodev(struct mport_cdev_priv *priv,
 		err = rio_add_net(net);
 		if (err) {
 			rmcd_debug(RDEV, "failed to register net, err=%d", err);
-			kfree(net);
+			put_device(&net->dev);
+			mport->net = NULL;
 			goto cleanup;
 		}
 	}
diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index fdcf742b2adb..c12941f71e2c 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -871,7 +871,10 @@ static struct rio_net *rio_scan_alloc_net(struct rio_mport *mport,
 		dev_set_name(&net->dev, "rnet_%d", net->id);
 		net->dev.parent = &mport->dev;
 		net->dev.release = rio_scan_release_dev;
-		rio_add_net(net);
+		if (rio_add_net(net)) {
+			put_device(&net->dev);
+			net = NULL;
+		}
 	}
 
 	return net;
diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 242570a5e565..455c1fd1490f 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -148,8 +148,9 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 	}
 
 	ret = ctrl->xfer_msg(ctrl, txn);
-
-	if (!ret && need_tid && !txn->msg->comp) {
+	if (ret == -ETIMEDOUT) {
+		slim_free_txn_tid(ctrl, txn);
+	} else if (!ret && need_tid && !txn->msg->comp) {
 		unsigned long ms = txn->rl + HZ;
 
 		time_left = wait_for_completion_timeout(txn->comp,
diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index 0dd85d2635b9..47d06af33747 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -1131,7 +1131,10 @@ static int cxacru_bind(struct usbatm_data *usbatm_instance,
 	struct cxacru_data *instance;
 	struct usb_device *usb_dev = interface_to_usbdev(intf);
 	struct usb_host_endpoint *cmd_ep = usb_dev->ep_in[CXACRU_EP_CMD];
-	struct usb_endpoint_descriptor *in, *out;
+	static const u8 ep_addrs[] = {
+		CXACRU_EP_CMD + USB_DIR_IN,
+		CXACRU_EP_CMD + USB_DIR_OUT,
+		0};
 	int ret;
 
 	/* instance init */
@@ -1179,13 +1182,11 @@ static int cxacru_bind(struct usbatm_data *usbatm_instance,
 	}
 
 	if (usb_endpoint_xfer_int(&cmd_ep->desc))
-		ret = usb_find_common_endpoints(intf->cur_altsetting,
-						NULL, NULL, &in, &out);
+		ret = usb_check_int_endpoints(intf, ep_addrs);
 	else
-		ret = usb_find_common_endpoints(intf->cur_altsetting,
-						&in, &out, NULL, NULL);
+		ret = usb_check_bulk_endpoints(intf, ep_addrs);
 
-	if (ret) {
+	if (!ret) {
 		usb_err(usbatm_instance, "cxacru_bind: interface has incorrect endpoints\n");
 		ret = -ENODEV;
 		goto fail;
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 906daf423cb0..145787c424e0 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -6065,6 +6065,36 @@ void usb_hub_cleanup(void)
 	usb_deregister(&hub_driver);
 } /* usb_hub_cleanup() */
 
+/**
+ * hub_hc_release_resources - clear resources used by host controller
+ * @udev: pointer to device being released
+ *
+ * Context: task context, might sleep
+ *
+ * Function releases the host controller resources in correct order before
+ * making any operation on resuming usb device. The host controller resources
+ * allocated for devices in tree should be released starting from the last
+ * usb device in tree toward the root hub. This function is used only during
+ * resuming device when usb device require reinitialization – that is, when
+ * flag udev->reset_resume is set.
+ *
+ * This call is synchronous, and may not be used in an interrupt context.
+ */
+static void hub_hc_release_resources(struct usb_device *udev)
+{
+	struct usb_hub *hub = usb_hub_to_struct_hub(udev);
+	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
+	int i;
+
+	/* Release up resources for all children before this device */
+	for (i = 0; i < udev->maxchild; i++)
+		if (hub->ports[i]->child)
+			hub_hc_release_resources(hub->ports[i]->child);
+
+	if (hcd->driver->reset_device)
+		hcd->driver->reset_device(hcd, udev);
+}
+
 /**
  * usb_reset_and_verify_device - perform a USB port reset to reinitialize a device
  * @udev: device to reset (not in SUSPENDED or NOTATTACHED state)
@@ -6129,6 +6159,9 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
 	bos = udev->bos;
 	udev->bos = NULL;
 
+	if (udev->reset_resume)
+		hub_hc_release_resources(udev);
+
 	mutex_lock(hcd->address0_mutex);
 
 	for (i = 0; i < PORT_INIT_TRIES; ++i) {
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 027479179f09..6926bd639ec6 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -341,6 +341,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0638, 0x0a13), .driver_info =
 	  USB_QUIRK_STRING_FETCH_255 },
 
+	/* Prolific Single-LUN Mass Storage Card Reader */
+	{ USB_DEVICE(0x067b, 0x2731), .driver_info = USB_QUIRK_DELAY_INIT |
+	  USB_QUIRK_NO_LPM },
+
 	/* Saitek Cyborg Gold Joystick */
 	{ USB_DEVICE(0x06a3, 0x0006), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 244e3e04e1ad..7820d6815bed 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -131,11 +131,24 @@ void dwc3_enable_susphy(struct dwc3 *dwc, bool enable)
 	}
 }
 
-void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
+void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bool ignore_susphy)
 {
+	unsigned int hw_mode;
 	u32 reg;
 
 	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+
+	 /*
+	  * For DRD controllers, GUSB3PIPECTL.SUSPENDENABLE and
+	  * GUSB2PHYCFG.SUSPHY should be cleared during mode switching,
+	  * and they can be set after core initialization.
+	  */
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD && !ignore_susphy) {
+		if (DWC3_GCTL_PRTCAP(reg) != mode)
+			dwc3_enable_susphy(dwc, false);
+	}
+
 	reg &= ~(DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_OTG));
 	reg |= DWC3_GCTL_PRTCAPDIR(mode);
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
@@ -216,7 +229,7 @@ static void __dwc3_set_mode(struct work_struct *work)
 
 	spin_lock_irqsave(&dwc->lock, flags);
 
-	dwc3_set_prtcap(dwc, desired_dr_role);
+	dwc3_set_prtcap(dwc, desired_dr_role, false);
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
@@ -658,16 +671,7 @@ static int dwc3_ss_phy_setup(struct dwc3 *dwc, int index)
 	 */
 	reg &= ~DWC3_GUSB3PIPECTL_UX_EXIT_PX;
 
-	/*
-	 * Above DWC_usb3.0 1.94a, it is recommended to set
-	 * DWC3_GUSB3PIPECTL_SUSPHY to '0' during coreConsultant configuration.
-	 * So default value will be '0' when the core is reset. Application
-	 * needs to set it to '1' after the core initialization is completed.
-	 *
-	 * Similarly for DRD controllers, GUSB3PIPECTL.SUSPENDENABLE must be
-	 * cleared after power-on reset, and it can be set after core
-	 * initialization.
-	 */
+	/* Ensure the GUSB3PIPECTL.SUSPENDENABLE is cleared prior to phy init. */
 	reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
 
 	if (dwc->u2ss_inp3_quirk)
@@ -747,15 +751,7 @@ static int dwc3_hs_phy_setup(struct dwc3 *dwc, int index)
 		break;
 	}
 
-	/*
-	 * Above DWC_usb3.0 1.94a, it is recommended to set
-	 * DWC3_GUSB2PHYCFG_SUSPHY to '0' during coreConsultant configuration.
-	 * So default value will be '0' when the core is reset. Application
-	 * needs to set it to '1' after the core initialization is completed.
-	 *
-	 * Similarly for DRD controllers, GUSB2PHYCFG.SUSPHY must be cleared
-	 * after power-on reset, and it can be set after core initialization.
-	 */
+	/* Ensure the GUSB2PHYCFG.SUSPHY is cleared prior to phy init. */
 	reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
 
 	if (dwc->dis_enblslpm_quirk)
@@ -830,6 +826,25 @@ static int dwc3_phy_init(struct dwc3 *dwc)
 			goto err_exit_usb3_phy;
 	}
 
+	/*
+	 * Above DWC_usb3.0 1.94a, it is recommended to set
+	 * DWC3_GUSB3PIPECTL_SUSPHY and DWC3_GUSB2PHYCFG_SUSPHY to '0' during
+	 * coreConsultant configuration. So default value will be '0' when the
+	 * core is reset. Application needs to set it to '1' after the core
+	 * initialization is completed.
+	 *
+	 * Certain phy requires to be in P0 power state during initialization.
+	 * Make sure GUSB3PIPECTL.SUSPENDENABLE and GUSB2PHYCFG.SUSPHY are clear
+	 * prior to phy init to maintain in the P0 state.
+	 *
+	 * After phy initialization, some phy operations can only be executed
+	 * while in lower P states. Ensure GUSB3PIPECTL.SUSPENDENABLE and
+	 * GUSB2PHYCFG.SUSPHY are set soon after initialization to avoid
+	 * blocking phy ops.
+	 */
+	if (!DWC3_VER_IS_WITHIN(DWC3, ANY, 194A))
+		dwc3_enable_susphy(dwc, true);
+
 	return 0;
 
 err_exit_usb3_phy:
@@ -1564,7 +1579,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, false);
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, false);
@@ -1576,7 +1591,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 			return dev_err_probe(dev, ret, "failed to initialize gadget\n");
 		break;
 	case USB_DR_MODE_HOST:
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST, false);
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, true);
@@ -1621,7 +1636,7 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 	}
 
 	/* de-assert DRVVBUS for HOST and OTG mode */
-	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, true);
 }
 
 static void dwc3_get_software_properties(struct dwc3 *dwc)
@@ -1811,8 +1826,6 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->tx_thr_num_pkt_prd = tx_thr_num_pkt_prd;
 	dwc->tx_max_burst_prd = tx_max_burst_prd;
 
-	dwc->imod_interval = 0;
-
 	dwc->tx_fifo_resize_max_num = tx_fifo_resize_max_num;
 }
 
@@ -1830,21 +1843,19 @@ static void dwc3_check_params(struct dwc3 *dwc)
 	unsigned int hwparam_gen =
 		DWC3_GHWPARAMS3_SSPHY_IFC(dwc->hwparams.hwparams3);
 
-	/* Check for proper value of imod_interval */
-	if (dwc->imod_interval && !dwc3_has_imod(dwc)) {
-		dev_warn(dwc->dev, "Interrupt moderation not supported\n");
-		dwc->imod_interval = 0;
-	}
-
 	/*
+	 * Enable IMOD for all supporting controllers.
+	 *
+	 * Particularly, DWC_usb3 v3.00a must enable this feature for
+	 * the following reason:
+	 *
 	 * Workaround for STAR 9000961433 which affects only version
 	 * 3.00a of the DWC_usb3 core. This prevents the controller
 	 * interrupt from being masked while handling events. IMOD
 	 * allows us to work around this issue. Enable it for the
 	 * affected version.
 	 */
-	if (!dwc->imod_interval &&
-	    DWC3_VER_IS(DWC3, 300A))
+	if (dwc3_has_imod((dwc)))
 		dwc->imod_interval = 1;
 
 	/* Check the maximum_speed parameter */
@@ -2433,7 +2444,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		if (ret)
 			return ret;
 
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, true);
 		dwc3_gadget_resume(dwc);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
@@ -2441,7 +2452,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 			ret = dwc3_core_init_for_resume(dwc);
 			if (ret)
 				return ret;
-			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
+			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST, true);
 			break;
 		}
 		/* Restore GUSB2PHYCFG bits that were modified in suspend */
@@ -2470,7 +2481,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		if (ret)
 			return ret;
 
-		dwc3_set_prtcap(dwc, dwc->current_dr_role);
+		dwc3_set_prtcap(dwc, dwc->current_dr_role, true);
 
 		dwc3_otg_init(dwc);
 		if (dwc->current_otg_role == DWC3_OTG_ROLE_HOST) {
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 0e91a227507f..f288d88cd105 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1562,7 +1562,7 @@ struct dwc3_gadget_ep_cmd_params {
 #define DWC3_HAS_OTG			BIT(3)
 
 /* prototypes */
-void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode);
+void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bool ignore_susphy);
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode);
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type);
 
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index d76ae676783c..7977860932b1 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -173,7 +173,7 @@ void dwc3_otg_init(struct dwc3 *dwc)
 	 * block "Initialize GCTL for OTG operation".
 	 */
 	/* GCTL.PrtCapDir=2'b11 */
-	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG);
+	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG, true);
 	/* GUSB2PHYCFG0.SusPHY=0 */
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
 	reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
@@ -556,7 +556,7 @@ int dwc3_drd_init(struct dwc3 *dwc)
 
 		dwc3_drd_update(dwc);
 	} else {
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG);
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG, true);
 
 		/* use OTG block to get ID event */
 		irq = dwc3_otg_get_irq(dwc);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 8c80bb4a467b..309a871453bf 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4507,14 +4507,18 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
 		    DWC3_GEVNTSIZ_SIZE(evt->length));
 
+	evt->flags &= ~DWC3_EVENT_PENDING;
+	/*
+	 * Add an explicit write memory barrier to make sure that the update of
+	 * clearing DWC3_EVENT_PENDING is observed in dwc3_check_event_buf()
+	 */
+	wmb();
+
 	if (dwc->imod_interval) {
 		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), DWC3_GEVNTCOUNT_EHB);
 		dwc3_writel(dwc->regs, DWC3_DEV_IMOD(0), dwc->imod_interval);
 	}
 
-	/* Keep the clearing of DWC3_EVENT_PENDING at the end */
-	evt->flags &= ~DWC3_EVENT_PENDING;
-
 	return ret;
 }
 
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index cec86c0c6369..8402a86176f4 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1050,10 +1050,11 @@ static int set_config(struct usb_composite_dev *cdev,
 	else
 		usb_gadget_set_remote_wakeup(gadget, 0);
 done:
-	if (power <= USB_SELF_POWER_VBUS_MAX_DRAW)
-		usb_gadget_set_selfpowered(gadget);
-	else
+	if (power > USB_SELF_POWER_VBUS_MAX_DRAW ||
+	    (c && !(c->bmAttributes & USB_CONFIG_ATT_SELFPOWER)))
 		usb_gadget_clear_selfpowered(gadget);
+	else
+		usb_gadget_set_selfpowered(gadget);
 
 	usb_gadget_vbus_draw(gadget, power);
 	if (result >= 0 && cdev->delayed_status)
@@ -2615,7 +2616,10 @@ void composite_suspend(struct usb_gadget *gadget)
 
 	cdev->suspended = 1;
 
-	usb_gadget_set_selfpowered(gadget);
+	if (cdev->config &&
+	    cdev->config->bmAttributes & USB_CONFIG_ATT_SELFPOWER)
+		usb_gadget_set_selfpowered(gadget);
+
 	usb_gadget_vbus_draw(gadget, 2);
 }
 
@@ -2649,8 +2653,11 @@ void composite_resume(struct usb_gadget *gadget)
 		else
 			maxpower = min(maxpower, 900U);
 
-		if (maxpower > USB_SELF_POWER_VBUS_MAX_DRAW)
+		if (maxpower > USB_SELF_POWER_VBUS_MAX_DRAW ||
+		    !(cdev->config->bmAttributes & USB_CONFIG_ATT_SELFPOWER))
 			usb_gadget_clear_selfpowered(gadget);
+		else
+			usb_gadget_set_selfpowered(gadget);
 
 		usb_gadget_vbus_draw(gadget, maxpower);
 	} else {
diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 09e2838917e2..f58590bf5e02 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -1052,8 +1052,8 @@ void gether_suspend(struct gether *link)
 		 * There is a transfer in progress. So we trigger a remote
 		 * wakeup to inform the host.
 		 */
-		ether_wakeup_host(dev->port_usb);
-		return;
+		if (!ether_wakeup_host(dev->port_usb))
+			return;
 	}
 	spin_lock_irqsave(&dev->lock, flags);
 	link->is_suspend = true;
diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 8d774f19271e..2fe3a92978fa 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/unaligned.h>
 #include <linux/bitfield.h>
+#include <linux/pci.h>
 
 #include "xhci.h"
 #include "xhci-trace.h"
@@ -770,9 +771,16 @@ static int xhci_exit_test_mode(struct xhci_hcd *xhci)
 enum usb_link_tunnel_mode xhci_port_is_tunneled(struct xhci_hcd *xhci,
 						struct xhci_port *port)
 {
+	struct usb_hcd *hcd;
 	void __iomem *base;
 	u32 offset;
 
+	/* Don't try and probe this capability for non-Intel hosts */
+	hcd = xhci_to_hcd(xhci);
+	if (!dev_is_pci(hcd->self.controller) ||
+	    to_pci_dev(hcd->self.controller)->vendor != PCI_VENDOR_ID_INTEL)
+		return USB_LINK_UNKNOWN;
+
 	base = &xhci->cap_regs->hc_capbase;
 	offset = xhci_find_next_ext_cap(base, 0, XHCI_EXT_CAPS_INTEL_SPR_SHADOW);
 
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index d2900197a49e..32c8693b438b 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2443,7 +2443,8 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 	 * and our use of dma addresses in the trb_address_map radix tree needs
 	 * TRB_SEGMENT_SIZE alignment, so we pick the greater alignment need.
 	 */
-	if (xhci->quirks & XHCI_ZHAOXIN_TRB_FETCH)
+	if (xhci->quirks & XHCI_TRB_OVERFETCH)
+		/* Buggy HC prefetches beyond segment bounds - allocate dummy space at the end */
 		xhci->segment_pool = dma_pool_create("xHCI ring segments", dev,
 				TRB_SEGMENT_SIZE * 2, TRB_SEGMENT_SIZE * 2, xhci->page_size * 2);
 	else
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index deb3c98c9bea..1b033c8ce188 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -28,8 +28,8 @@
 #define SPARSE_CNTL_ENABLE	0xC12C
 
 /* Device for a quirk */
-#define PCI_VENDOR_ID_FRESCO_LOGIC	0x1b73
-#define PCI_DEVICE_ID_FRESCO_LOGIC_PDK	0x1000
+#define PCI_VENDOR_ID_FRESCO_LOGIC		0x1b73
+#define PCI_DEVICE_ID_FRESCO_LOGIC_PDK		0x1000
 #define PCI_DEVICE_ID_FRESCO_LOGIC_FL1009	0x1009
 #define PCI_DEVICE_ID_FRESCO_LOGIC_FL1100	0x1100
 #define PCI_DEVICE_ID_FRESCO_LOGIC_FL1400	0x1400
@@ -38,8 +38,10 @@
 #define PCI_DEVICE_ID_EJ168		0x7023
 #define PCI_DEVICE_ID_EJ188		0x7052
 
-#define PCI_DEVICE_ID_INTEL_LYNXPOINT_XHCI	0x8c31
-#define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
+#define PCI_DEVICE_ID_VIA_VL805			0x3483
+
+#define PCI_DEVICE_ID_INTEL_LYNXPOINT_XHCI		0x8c31
+#define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI		0x9c31
 #define PCI_DEVICE_ID_INTEL_WILDCATPOINT_LP_XHCI	0x9cb1
 #define PCI_DEVICE_ID_INTEL_CHERRYVIEW_XHCI		0x22b5
 #define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_XHCI		0xa12f
@@ -424,8 +426,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 			pdev->device == 0x3432)
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 
-	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == 0x3483)
+	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == PCI_DEVICE_ID_VIA_VL805) {
 		xhci->quirks |= XHCI_LPM_SUPPORT;
+		xhci->quirks |= XHCI_TRB_OVERFETCH;
+	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
 		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI) {
@@ -473,11 +477,11 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 
 		if (pdev->device == 0x9202) {
 			xhci->quirks |= XHCI_RESET_ON_RESUME;
-			xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
+			xhci->quirks |= XHCI_TRB_OVERFETCH;
 		}
 
 		if (pdev->device == 0x9203)
-			xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
+			xhci->quirks |= XHCI_TRB_OVERFETCH;
 	}
 
 	if (pdev->vendor == PCI_DEVICE_ID_CADENCE &&
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 673179047eb8..439767d242fa 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1621,7 +1621,7 @@ struct xhci_hcd {
 #define XHCI_EP_CTX_BROKEN_DCS	BIT_ULL(42)
 #define XHCI_SUSPEND_RESUME_CLKS	BIT_ULL(43)
 #define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)
-#define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
+#define XHCI_TRB_OVERFETCH	BIT_ULL(45)
 #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
 #define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
 #define XHCI_CDNS_SCTX_QUIRK	BIT_ULL(48)
diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index edc43f169d49..7324de52d950 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -312,8 +312,10 @@ static int usbhsc_clk_get(struct device *dev, struct usbhs_priv *priv)
 	priv->clks[1] = of_clk_get(dev_of_node(dev), 1);
 	if (PTR_ERR(priv->clks[1]) == -ENOENT)
 		priv->clks[1] = NULL;
-	else if (IS_ERR(priv->clks[1]))
+	else if (IS_ERR(priv->clks[1])) {
+		clk_put(priv->clks[0]);
 		return PTR_ERR(priv->clks[1]);
+	}
 
 	return 0;
 }
@@ -779,6 +781,8 @@ static void usbhs_remove(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "usb remove\n");
 
+	flush_delayed_work(&priv->notify_hotplug_work);
+
 	/* power off */
 	if (!usbhs_get_dparam(priv, runtime_pwctrl))
 		usbhsc_power_ctrl(priv, 0);
diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index 105132ae87ac..e8e5723f5412 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -1094,7 +1094,7 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
 		goto usbhs_mod_gadget_probe_err_gpriv;
 	}
 
-	gpriv->transceiver = usb_get_phy(USB_PHY_TYPE_UNDEFINED);
+	gpriv->transceiver = devm_usb_get_phy(dev, USB_PHY_TYPE_UNDEFINED);
 	dev_info(dev, "%stransceiver found\n",
 		 !IS_ERR(gpriv->transceiver) ? "" : "no ");
 
diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index 64f6dd0dc660..88c50b984e8a 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -334,6 +334,11 @@ static int rt1711h_probe(struct i2c_client *client)
 {
 	int ret;
 	struct rt1711h_chip *chip;
+	const u16 alert_mask = TCPC_ALERT_TX_SUCCESS | TCPC_ALERT_TX_DISCARDED |
+			       TCPC_ALERT_TX_FAILED | TCPC_ALERT_RX_HARD_RST |
+			       TCPC_ALERT_RX_STATUS | TCPC_ALERT_POWER_STATUS |
+			       TCPC_ALERT_CC_STATUS | TCPC_ALERT_RX_BUF_OVF |
+			       TCPC_ALERT_FAULT;
 
 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
@@ -382,6 +387,12 @@ static int rt1711h_probe(struct i2c_client *client)
 					dev_name(chip->dev), chip);
 	if (ret < 0)
 		return ret;
+
+	/* Enable alert interrupts */
+	ret = rt1711h_write16(chip, TCPC_ALERT_MASK, alert_mask);
+	if (ret < 0)
+		return ret;
+
 	enable_irq_wake(client->irq);
 
 	return 0;
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 7a3f0f5af38f..3f2bc13efa48 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -25,7 +25,7 @@
  * difficult to estimate the time it takes for the system to process the command
  * before it is actually passed to the PPM.
  */
-#define UCSI_TIMEOUT_MS		5000
+#define UCSI_TIMEOUT_MS		10000
 
 /*
  * UCSI_SWAP_TIMEOUT_MS - Timeout for role swap requests
@@ -1330,7 +1330,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 
 	mutex_lock(&ucsi->ppm_lock);
 
-	ret = ucsi->ops->read_cci(ucsi, &cci);
+	ret = ucsi->ops->poll_cci(ucsi, &cci);
 	if (ret < 0)
 		goto out;
 
@@ -1348,7 +1348,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 
 		tmo = jiffies + msecs_to_jiffies(UCSI_TIMEOUT_MS);
 		do {
-			ret = ucsi->ops->read_cci(ucsi, &cci);
+			ret = ucsi->ops->poll_cci(ucsi, &cci);
 			if (ret < 0)
 				goto out;
 			if (cci & UCSI_CCI_COMMAND_COMPLETE)
@@ -1377,7 +1377,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 		/* Give the PPM time to process a reset before reading CCI */
 		msleep(20);
 
-		ret = ucsi->ops->read_cci(ucsi, &cci);
+		ret = ucsi->ops->poll_cci(ucsi, &cci);
 		if (ret)
 			goto out;
 
@@ -1809,11 +1809,11 @@ static int ucsi_init(struct ucsi *ucsi)
 
 err_unregister:
 	for (con = connector; con->port; con++) {
+		if (con->wq)
+			destroy_workqueue(con->wq);
 		ucsi_unregister_partner(con);
 		ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
 		ucsi_unregister_port_psy(con);
-		if (con->wq)
-			destroy_workqueue(con->wq);
 
 		usb_power_delivery_unregister_capabilities(con->port_sink_caps);
 		con->port_sink_caps = NULL;
@@ -1913,8 +1913,8 @@ struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops)
 	struct ucsi *ucsi;
 
 	if (!ops ||
-	    !ops->read_version || !ops->read_cci || !ops->read_message_in ||
-	    !ops->sync_control || !ops->async_control)
+	    !ops->read_version || !ops->read_cci || !ops->poll_cci ||
+	    !ops->read_message_in || !ops->sync_control || !ops->async_control)
 		return ERR_PTR(-EINVAL);
 
 	ucsi = kzalloc(sizeof(*ucsi), GFP_KERNEL);
@@ -1997,10 +1997,6 @@ void ucsi_unregister(struct ucsi *ucsi)
 
 	for (i = 0; i < ucsi->cap.num_connectors; i++) {
 		cancel_work_sync(&ucsi->connector[i].work);
-		ucsi_unregister_partner(&ucsi->connector[i]);
-		ucsi_unregister_altmodes(&ucsi->connector[i],
-					 UCSI_RECIPIENT_CON);
-		ucsi_unregister_port_psy(&ucsi->connector[i]);
 
 		if (ucsi->connector[i].wq) {
 			struct ucsi_work *uwork;
@@ -2016,6 +2012,11 @@ void ucsi_unregister(struct ucsi *ucsi)
 			destroy_workqueue(ucsi->connector[i].wq);
 		}
 
+		ucsi_unregister_partner(&ucsi->connector[i]);
+		ucsi_unregister_altmodes(&ucsi->connector[i],
+					 UCSI_RECIPIENT_CON);
+		ucsi_unregister_port_psy(&ucsi->connector[i]);
+
 		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_sink_caps);
 		ucsi->connector[i].port_sink_caps = NULL;
 		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_source_caps);
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 1cf5aad4c23a..a333006d3496 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -60,6 +60,7 @@ struct dentry;
  * struct ucsi_operations - UCSI I/O operations
  * @read_version: Read implemented UCSI version
  * @read_cci: Read CCI register
+ * @poll_cci: Read CCI register while polling with notifications disabled
  * @read_message_in: Read message data from UCSI
  * @sync_control: Blocking control operation
  * @async_control: Non-blocking control operation
@@ -74,6 +75,7 @@ struct dentry;
 struct ucsi_operations {
 	int (*read_version)(struct ucsi *ucsi, u16 *version);
 	int (*read_cci)(struct ucsi *ucsi, u32 *cci);
+	int (*poll_cci)(struct ucsi *ucsi, u32 *cci);
 	int (*read_message_in)(struct ucsi *ucsi, void *val, size_t val_len);
 	int (*sync_control)(struct ucsi *ucsi, u64 command);
 	int (*async_control)(struct ucsi *ucsi, u64 command);
diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index accf15ff1306..8de2961718cd 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -59,19 +59,24 @@ static int ucsi_acpi_read_version(struct ucsi *ucsi, u16 *version)
 static int ucsi_acpi_read_cci(struct ucsi *ucsi, u32 *cci)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
-	int ret;
-
-	if (UCSI_COMMAND(ua->cmd) == UCSI_PPM_RESET) {
-		ret = ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_READ);
-		if (ret)
-			return ret;
-	}
 
 	memcpy(cci, ua->base + UCSI_CCI, sizeof(*cci));
 
 	return 0;
 }
 
+static int ucsi_acpi_poll_cci(struct ucsi *ucsi, u32 *cci)
+{
+	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
+	int ret;
+
+	ret = ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_READ);
+	if (ret)
+		return ret;
+
+	return ucsi_acpi_read_cci(ucsi, cci);
+}
+
 static int ucsi_acpi_read_message_in(struct ucsi *ucsi, void *val, size_t val_len)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
@@ -94,6 +99,7 @@ static int ucsi_acpi_async_control(struct ucsi *ucsi, u64 command)
 static const struct ucsi_operations ucsi_acpi_ops = {
 	.read_version = ucsi_acpi_read_version,
 	.read_cci = ucsi_acpi_read_cci,
+	.poll_cci = ucsi_acpi_poll_cci,
 	.read_message_in = ucsi_acpi_read_message_in,
 	.sync_control = ucsi_sync_control_common,
 	.async_control = ucsi_acpi_async_control
@@ -145,6 +151,7 @@ static int ucsi_gram_sync_control(struct ucsi *ucsi, u64 command)
 static const struct ucsi_operations ucsi_gram_ops = {
 	.read_version = ucsi_acpi_read_version,
 	.read_cci = ucsi_acpi_read_cci,
+	.poll_cci = ucsi_acpi_poll_cci,
 	.read_message_in = ucsi_gram_read_message_in,
 	.sync_control = ucsi_gram_sync_control,
 	.async_control = ucsi_acpi_async_control
diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 740171f24ef9..4b1668733a4b 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -664,6 +664,7 @@ static int ucsi_ccg_sync_control(struct ucsi *ucsi, u64 command)
 static const struct ucsi_operations ucsi_ccg_ops = {
 	.read_version = ucsi_ccg_read_version,
 	.read_cci = ucsi_ccg_read_cci,
+	.poll_cci = ucsi_ccg_read_cci,
 	.read_message_in = ucsi_ccg_read_message_in,
 	.sync_control = ucsi_ccg_sync_control,
 	.async_control = ucsi_ccg_async_control,
diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 9b6cb76e6328..75c0e54c37fa 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -201,6 +201,7 @@ static void pmic_glink_ucsi_connector_status(struct ucsi_connector *con)
 static const struct ucsi_operations pmic_glink_ucsi_ops = {
 	.read_version = pmic_glink_ucsi_read_version,
 	.read_cci = pmic_glink_ucsi_read_cci,
+	.poll_cci = pmic_glink_ucsi_read_cci,
 	.read_message_in = pmic_glink_ucsi_read_message_in,
 	.sync_control = ucsi_sync_control_common,
 	.async_control = pmic_glink_ucsi_async_control,
diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
index 6923fad31d79..57ef7d83a412 100644
--- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
+++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
@@ -424,6 +424,7 @@ static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
 static const struct ucsi_operations ucsi_stm32g0_ops = {
 	.read_version = ucsi_stm32g0_read_version,
 	.read_cci = ucsi_stm32g0_read_cci,
+	.poll_cci = ucsi_stm32g0_read_cci,
 	.read_message_in = ucsi_stm32g0_read_message_in,
 	.sync_control = ucsi_sync_control_common,
 	.async_control = ucsi_stm32g0_async_control,
diff --git a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
index f3a5e24ea84d..40e5da4fd2a4 100644
--- a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
+++ b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
@@ -74,6 +74,7 @@ static int yoga_c630_ucsi_async_control(struct ucsi *ucsi, u64 command)
 const struct ucsi_operations yoga_c630_ucsi_ops = {
 	.read_version = yoga_c630_ucsi_read_version,
 	.read_cci = yoga_c630_ucsi_read_cci,
+	.poll_cci = yoga_c630_ucsi_read_cci,
 	.read_message_in = yoga_c630_ucsi_read_message_in,
 	.sync_control = ucsi_sync_control_common,
 	.async_control = yoga_c630_ucsi_async_control,
diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index c24036c4e51e..e4e196abdaac 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -49,7 +49,7 @@ static int pmcmd_ioctl(u64 cmd, void __user *uptr)
 	switch (cmd & PMCMD_TYPE_MASK) {
 	case ACRN_PMCMD_GET_PX_CNT:
 	case ACRN_PMCMD_GET_CX_CNT:
-		pm_info = kmalloc(sizeof(u64), GFP_KERNEL);
+		pm_info = kzalloc(sizeof(u64), GFP_KERNEL);
 		if (!pm_info)
 			return -ENOMEM;
 
@@ -64,7 +64,7 @@ static int pmcmd_ioctl(u64 cmd, void __user *uptr)
 		kfree(pm_info);
 		break;
 	case ACRN_PMCMD_GET_PX_DATA:
-		px_data = kmalloc(sizeof(*px_data), GFP_KERNEL);
+		px_data = kzalloc(sizeof(*px_data), GFP_KERNEL);
 		if (!px_data)
 			return -ENOMEM;
 
@@ -79,7 +79,7 @@ static int pmcmd_ioctl(u64 cmd, void __user *uptr)
 		kfree(px_data);
 		break;
 	case ACRN_PMCMD_GET_CX_DATA:
-		cx_data = kmalloc(sizeof(*cx_data), GFP_KERNEL);
+		cx_data = kzalloc(sizeof(*cx_data), GFP_KERNEL);
 		if (!cx_data)
 			return -ENOMEM;
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 848cb2c3d9dd..78c4a3765002 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1200,7 +1200,7 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 	ssize_t ret;
 	bool only_release_metadata = false;
 	bool force_page_uptodate = false;
-	loff_t old_isize = i_size_read(inode);
+	loff_t old_isize;
 	unsigned int ilock_flags = 0;
 	const bool nowait = (iocb->ki_flags & IOCB_NOWAIT);
 	unsigned int bdp_flags = (nowait ? BDP_ASYNC : 0);
@@ -1212,6 +1212,13 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * We can only trust the isize with inode lock held, or it can race with
+	 * other buffered writes and cause incorrect call of
+	 * pagecache_isize_extended() to overwrite existing data.
+	 */
+	old_isize = i_size_read(inode);
+
 	ret = generic_write_checks(iocb, i);
 	if (ret <= 0)
 		goto out;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 395b8b880ce7..587ac07cd194 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7094,6 +7094,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 		btrfs_err(fs_info,
 			  "failed to add chunk map, start=%llu len=%llu: %d",
 			  map->start, map->chunk_len, ret);
+		btrfs_free_chunk_map(map);
 	}
 
 	return ret;
diff --git a/fs/coredump.c b/fs/coredump.c
index 45737b43dda5..2b8c36c9660c 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -63,6 +63,7 @@ static void free_vma_snapshot(struct coredump_params *cprm);
 
 static int core_uses_pid;
 static unsigned int core_pipe_limit;
+static unsigned int core_sort_vma;
 static char core_pattern[CORENAME_MAX_SIZE] = "core";
 static int core_name_size = CORENAME_MAX_SIZE;
 unsigned int core_file_note_size_limit = CORE_FILE_NOTE_SIZE_DEFAULT;
@@ -1025,6 +1026,15 @@ static struct ctl_table coredump_sysctls[] = {
 		.extra1		= (unsigned int *)&core_file_note_size_min,
 		.extra2		= (unsigned int *)&core_file_note_size_max,
 	},
+	{
+		.procname	= "core_sort_vma",
+		.data		= &core_sort_vma,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 };
 
 static int __init init_fs_coredump_sysctls(void)
@@ -1255,8 +1265,9 @@ static bool dump_vma_snapshot(struct coredump_params *cprm)
 		cprm->vma_data_size += m->dump_size;
 	}
 
-	sort(cprm->vma_meta, cprm->vma_count, sizeof(*cprm->vma_meta),
-		cmp_vma_size, NULL);
+	if (core_sort_vma)
+		sort(cprm->vma_meta, cprm->vma_count, sizeof(*cprm->vma_meta),
+		     cmp_vma_size, NULL);
 
 	return true;
 }
diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index ce9be95c9172..9ff825f1502d 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -141,7 +141,7 @@ int exfat_set_bitmap(struct inode *inode, unsigned int clu, bool sync)
 	return 0;
 }
 
-void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync)
+int exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync)
 {
 	int i, b;
 	unsigned int ent_idx;
@@ -150,13 +150,17 @@ void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync)
 	struct exfat_mount_options *opts = &sbi->options;
 
 	if (!is_valid_cluster(sbi, clu))
-		return;
+		return -EIO;
 
 	ent_idx = CLUSTER_TO_BITMAP_ENT(clu);
 	i = BITMAP_OFFSET_SECTOR_INDEX(sb, ent_idx);
 	b = BITMAP_OFFSET_BIT_IN_SECTOR(sb, ent_idx);
 
+	if (!test_bit_le(b, sbi->vol_amap[i]->b_data))
+		return -EIO;
+
 	clear_bit_le(b, sbi->vol_amap[i]->b_data);
+
 	exfat_update_bh(sbi->vol_amap[i], sync);
 
 	if (opts->discard) {
@@ -171,6 +175,8 @@ void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync)
 			opts->discard = 0;
 		}
 	}
+
+	return 0;
 }
 
 /*
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 3cdc1de362a9..d2ba8e2d0c39 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -452,7 +452,7 @@ int exfat_count_num_clusters(struct super_block *sb,
 int exfat_load_bitmap(struct super_block *sb);
 void exfat_free_bitmap(struct exfat_sb_info *sbi);
 int exfat_set_bitmap(struct inode *inode, unsigned int clu, bool sync);
-void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync);
+int exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync);
 unsigned int exfat_find_free_bitmap(struct super_block *sb, unsigned int clu);
 int exfat_count_used_clusters(struct super_block *sb, unsigned int *ret_count);
 int exfat_trim_fs(struct inode *inode, struct fstrim_range *range);
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 9e5492ac409b..6f3651c6ca91 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -175,6 +175,7 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 		BITMAP_OFFSET_SECTOR_INDEX(sb, CLUSTER_TO_BITMAP_ENT(clu));
 
 	if (p_chain->flags == ALLOC_NO_FAT_CHAIN) {
+		int err;
 		unsigned int last_cluster = p_chain->dir + p_chain->size - 1;
 		do {
 			bool sync = false;
@@ -189,7 +190,9 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 				cur_cmap_i = next_cmap_i;
 			}
 
-			exfat_clear_bitmap(inode, clu, (sync && IS_DIRSYNC(inode)));
+			err = exfat_clear_bitmap(inode, clu, (sync && IS_DIRSYNC(inode)));
+			if (err)
+				break;
 			clu++;
 			num_clusters++;
 		} while (num_clusters < p_chain->size);
@@ -210,12 +213,13 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 				cur_cmap_i = next_cmap_i;
 			}
 
-			exfat_clear_bitmap(inode, clu, (sync && IS_DIRSYNC(inode)));
+			if (exfat_clear_bitmap(inode, clu, (sync && IS_DIRSYNC(inode))))
+				break;
 			clu = n_clu;
 			num_clusters++;
 
 			if (err)
-				goto dec_used_clus;
+				break;
 
 			if (num_clusters >= sbi->num_clusters - EXFAT_FIRST_CLUSTER) {
 				/*
@@ -229,7 +233,6 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 		} while (clu != EXFAT_EOF_CLUSTER);
 	}
 
-dec_used_clus:
 	sbi->used_clusters -= num_clusters;
 	return 0;
 }
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 05b51e721783..807349d8ea05 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -587,7 +587,7 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	valid_size = ei->valid_size;
 
 	ret = generic_write_checks(iocb, iter);
-	if (ret < 0)
+	if (ret <= 0)
 		goto unlock;
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 337197ece599..e47a5ddfc79b 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -237,7 +237,7 @@ static int exfat_search_empty_slot(struct super_block *sb,
 		dentry = 0;
 	}
 
-	while (dentry + num_entries < total_entries &&
+	while (dentry + num_entries <= total_entries &&
 	       clu.dir != EXFAT_EOF_CLUSTER) {
 		i = dentry & (dentries_per_clu - 1);
 
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index a44132c98653..3b9461f5e712 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -258,17 +258,18 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq, bool was
 	 */
 	if (!subreq->consumed &&
 	    !prev_donated &&
-	    !list_is_first(&subreq->rreq_link, &rreq->subrequests) &&
-	    subreq->start == prev->start + prev->len) {
+	    !list_is_first(&subreq->rreq_link, &rreq->subrequests)) {
 		prev = list_prev_entry(subreq, rreq_link);
-		WRITE_ONCE(prev->next_donated, prev->next_donated + subreq->len);
-		subreq->start += subreq->len;
-		subreq->len = 0;
-		subreq->transferred = 0;
-		trace_netfs_donate(rreq, subreq, prev, subreq->len,
-				   netfs_trace_donate_to_prev);
-		trace_netfs_sreq(subreq, netfs_sreq_trace_donate_to_prev);
-		goto remove_subreq_locked;
+		if (subreq->start == prev->start + prev->len) {
+			WRITE_ONCE(prev->next_donated, prev->next_donated + subreq->len);
+			subreq->start += subreq->len;
+			subreq->len = 0;
+			subreq->transferred = 0;
+			trace_netfs_donate(rreq, subreq, prev, subreq->len,
+					   netfs_trace_donate_to_prev);
+			trace_netfs_sreq(subreq, netfs_sreq_trace_donate_to_prev);
+			goto remove_subreq_locked;
+		}
 	}
 
 	/* If we can't donate down the chain, donate up the chain instead. */
diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index 54d5004fec18..e72f5e674834 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -181,16 +181,17 @@ void netfs_pgpriv2_write_to_the_cache(struct netfs_io_request *rreq)
 			break;
 
 		folioq_unmark3(folioq, slot);
-		if (!folioq->marks3) {
+		while (!folioq->marks3) {
 			folioq = folioq->next;
 			if (!folioq)
-				break;
+				goto end_of_queue;
 		}
 
 		slot = __ffs(folioq->marks3);
 		folio = folioq_folio(folioq, slot);
 	}
 
+end_of_queue:
 	netfs_issue_write(wreq, &wreq->io_streams[1]);
 	smp_wmb(); /* Write lists before ALL_QUEUED. */
 	set_bit(NETFS_RREQ_ALL_QUEUED, &wreq->flags);
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 6800ee92d742..153d25d4b810 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -29,6 +29,7 @@
 #include <linux/pagemap.h>
 #include <linux/gfp.h>
 #include <linux/swap.h>
+#include <linux/compaction.h>
 
 #include <linux/uaccess.h>
 #include <linux/filelock.h>
@@ -451,7 +452,7 @@ static bool nfs_release_folio(struct folio *folio, gfp_t gfp)
 	/* If the private flag is set, then the folio is not freeable */
 	if (folio_test_private(folio)) {
 		if ((current_gfp_context(gfp) & GFP_KERNEL) != GFP_KERNEL ||
-		    current_is_kswapd())
+		    current_is_kswapd() || current_is_kcompactd())
 			return false;
 		if (nfs_wb_folio(folio->mapping->host, folio) < 0)
 			return false;
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 05274121e46f..b630beb757a4 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -209,10 +209,8 @@ struct cifs_cred {
 
 struct cifs_open_info_data {
 	bool adjust_tz;
-	union {
-		bool reparse_point;
-		bool symlink;
-	};
+	bool reparse_point;
+	bool contains_posix_file_info;
 	struct {
 		/* ioctl response buffer */
 		struct {
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index e11e67af760f..a3f0835e12be 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -968,7 +968,7 @@ cifs_get_file_info(struct file *filp)
 		/* TODO: add support to query reparse tag */
 		data.adjust_tz = false;
 		if (data.symlink_target) {
-			data.symlink = true;
+			data.reparse_point = true;
 			data.reparse.tag = IO_REPARSE_TAG_SYMLINK;
 		}
 		path = build_path_from_dentry(dentry, page);
diff --git a/fs/smb/client/reparse.h b/fs/smb/client/reparse.h
index ff05b0e75c92..f080f92cb1e7 100644
--- a/fs/smb/client/reparse.h
+++ b/fs/smb/client/reparse.h
@@ -97,14 +97,30 @@ static inline bool reparse_inode_match(struct inode *inode,
 
 static inline bool cifs_open_data_reparse(struct cifs_open_info_data *data)
 {
-	struct smb2_file_all_info *fi = &data->fi;
-	u32 attrs = le32_to_cpu(fi->Attributes);
+	u32 attrs;
 	bool ret;
 
-	ret = data->reparse_point || (attrs & ATTR_REPARSE);
-	if (ret)
-		attrs |= ATTR_REPARSE;
-	fi->Attributes = cpu_to_le32(attrs);
+	if (data->contains_posix_file_info) {
+		struct smb311_posix_qinfo *fi = &data->posix_fi;
+
+		attrs = le32_to_cpu(fi->DosAttributes);
+		if (data->reparse_point) {
+			attrs |= ATTR_REPARSE;
+			fi->DosAttributes = cpu_to_le32(attrs);
+		}
+
+	} else {
+		struct smb2_file_all_info *fi = &data->fi;
+
+		attrs = le32_to_cpu(fi->Attributes);
+		if (data->reparse_point) {
+			attrs |= ATTR_REPARSE;
+			fi->Attributes = cpu_to_le32(attrs);
+		}
+	}
+
+	ret = attrs & ATTR_REPARSE;
+
 	return ret;
 }
 
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index c70f4961c4eb..bd791aa54681 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -551,7 +551,7 @@ static int cifs_query_path_info(const unsigned int xid,
 	int rc;
 	FILE_ALL_INFO fi = {};
 
-	data->symlink = false;
+	data->reparse_point = false;
 	data->adjust_tz = false;
 
 	/* could do find first instead but this returns more info */
@@ -592,7 +592,7 @@ static int cifs_query_path_info(const unsigned int xid,
 		/* Need to check if this is a symbolic link or not */
 		tmprc = CIFS_open(xid, &oparms, &oplock, NULL);
 		if (tmprc == -EOPNOTSUPP)
-			data->symlink = true;
+			data->reparse_point = true;
 		else if (tmprc == 0)
 			CIFSSMBClose(xid, tcon, fid.netfid);
 	}
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 7dfd3eb3847b..6048b3fed3e7 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -648,6 +648,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 		switch (cmds[i]) {
 		case SMB2_OP_QUERY_INFO:
 			idata = in_iov[i].iov_base;
+			idata->contains_posix_file_info = false;
 			if (rc == 0 && cfile && cfile->symlink_target) {
 				idata->symlink_target = kstrdup(cfile->symlink_target, GFP_KERNEL);
 				if (!idata->symlink_target)
@@ -671,6 +672,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 			break;
 		case SMB2_OP_POSIX_QUERY_INFO:
 			idata = in_iov[i].iov_base;
+			idata->contains_posix_file_info = true;
 			if (rc == 0 && cfile && cfile->symlink_target) {
 				idata->symlink_target = kstrdup(cfile->symlink_target, GFP_KERNEL);
 				if (!idata->symlink_target)
@@ -768,6 +770,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 				idata = in_iov[i].iov_base;
 				idata->reparse.io.iov = *iov;
 				idata->reparse.io.buftype = resp_buftype[i + 1];
+				idata->contains_posix_file_info = false; /* BB VERIFY */
 				rbuf = reparse_buf_ptr(iov);
 				if (IS_ERR(rbuf)) {
 					rc = PTR_ERR(rbuf);
@@ -789,6 +792,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 		case SMB2_OP_QUERY_WSL_EA:
 			if (!rc) {
 				idata = in_iov[i].iov_base;
+				idata->contains_posix_file_info = false;
 				qi_rsp = rsp_iov[i + 1].iov_base;
 				data[0] = (u8 *)qi_rsp + le16_to_cpu(qi_rsp->OutputBufferOffset);
 				size[0] = le32_to_cpu(qi_rsp->OutputBufferLength);
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index e8da63d29a28..516be8c0b2a9 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -1001,6 +1001,7 @@ static int smb2_query_file_info(const unsigned int xid, struct cifs_tcon *tcon,
 		if (!data->symlink_target)
 			return -ENOMEM;
 	}
+	data->contains_posix_file_info = false;
 	return SMB2_query_info(xid, tcon, fid->persistent_fid, fid->volatile_fid, &data->fi);
 }
 
@@ -5177,7 +5178,7 @@ int __cifs_sfu_make_node(unsigned int xid, struct inode *inode,
 			     FILE_CREATE, CREATE_NOT_DIR |
 			     CREATE_OPTION_SPECIAL, ACL_NO_MODE);
 	oparms.fid = &fid;
-
+	idata.contains_posix_file_info = false;
 	rc = server->ops->open(xid, &oparms, &oplock, &idata);
 	if (rc)
 		goto out;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index c763a2f7df66..8464261d7638 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7441,17 +7441,17 @@ int smb2_lock(struct ksmbd_work *work)
 		}
 
 no_check_cl:
+		flock = smb_lock->fl;
+		list_del(&smb_lock->llist);
+
 		if (smb_lock->zero_len) {
 			err = 0;
 			goto skip;
 		}
-
-		flock = smb_lock->fl;
-		list_del(&smb_lock->llist);
 retry:
 		rc = vfs_lock_file(filp, smb_lock->cmd, flock, NULL);
 skip:
-		if (flags & SMB2_LOCKFLAG_UNLOCK) {
+		if (smb_lock->flags & SMB2_LOCKFLAG_UNLOCK) {
 			if (!rc) {
 				ksmbd_debug(SMB, "File unlocked\n");
 			} else if (rc == -ENOENT) {
diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 1c9775f1efa5..da8ed72f335d 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -807,6 +807,13 @@ static int parse_sid(struct smb_sid *psid, char *end_of_acl)
 		return -EINVAL;
 	}
 
+	if (!psid->num_subauth)
+		return 0;
+
+	if (psid->num_subauth > SID_MAX_SUB_AUTHORITIES ||
+	    end_of_acl < (char *)psid + 8 + sizeof(__le32) * psid->num_subauth)
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -848,6 +855,9 @@ int parse_sec_desc(struct mnt_idmap *idmap, struct smb_ntsd *pntsd,
 	pntsd->type = cpu_to_le16(DACL_PRESENT);
 
 	if (pntsd->osidoffset) {
+		if (le32_to_cpu(pntsd->osidoffset) < sizeof(struct smb_ntsd))
+			return -EINVAL;
+
 		rc = parse_sid(owner_sid_ptr, end_of_acl);
 		if (rc) {
 			pr_err("%s: Error %d parsing Owner SID\n", __func__, rc);
@@ -863,6 +873,9 @@ int parse_sec_desc(struct mnt_idmap *idmap, struct smb_ntsd *pntsd,
 	}
 
 	if (pntsd->gsidoffset) {
+		if (le32_to_cpu(pntsd->gsidoffset) < sizeof(struct smb_ntsd))
+			return -EINVAL;
+
 		rc = parse_sid(group_sid_ptr, end_of_acl);
 		if (rc) {
 			pr_err("%s: Error %d mapping Owner SID to gid\n",
@@ -884,6 +897,9 @@ int parse_sec_desc(struct mnt_idmap *idmap, struct smb_ntsd *pntsd,
 		pntsd->type |= cpu_to_le16(DACL_PROTECTED);
 
 	if (dacloffset) {
+		if (dacloffset < sizeof(struct smb_ntsd))
+			return -EINVAL;
+
 		parse_dacl(idmap, dacl_ptr, end_of_acl,
 			   owner_sid_ptr, group_sid_ptr, fattr);
 	}
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 69bac122adbe..87af57cf35a1 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -281,6 +281,7 @@ static int handle_response(int type, void *payload, size_t sz)
 		if (entry->type + 1 != type) {
 			pr_err("Waiting for IPC type %d, got %d. Ignore.\n",
 			       entry->type + 1, type);
+			continue;
 		}
 
 		entry->response = kvzalloc(sz, GFP_KERNEL);
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 594d5905f615..215bf9f317cb 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -84,7 +84,7 @@ static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 
 #ifndef __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-		unsigned long addr, pte_t *ptep)
+		unsigned long addr, pte_t *ptep, unsigned long sz)
 {
 	return ptep_get_and_clear(mm, addr, ptep);
 }
diff --git a/include/drm/drm_client_setup.h b/include/drm/drm_client_setup.h
new file mode 100644
index 000000000000..46aab3fb46be
--- /dev/null
+++ b/include/drm/drm_client_setup.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: MIT */
+
+#ifndef DRM_CLIENT_SETUP_H
+#define DRM_CLIENT_SETUP_H
+
+#include <linux/types.h>
+
+struct drm_device;
+struct drm_format_info;
+
+#if defined(CONFIG_DRM_CLIENT_SETUP)
+void drm_client_setup(struct drm_device *dev, const struct drm_format_info *format);
+void drm_client_setup_with_fourcc(struct drm_device *dev, u32 fourcc);
+void drm_client_setup_with_color_mode(struct drm_device *dev, unsigned int color_mode);
+#else
+static inline void drm_client_setup(struct drm_device *dev,
+				    const struct drm_format_info *format)
+{ }
+static inline void drm_client_setup_with_fourcc(struct drm_device *dev, u32 fourcc)
+{ }
+static inline void drm_client_setup_with_color_mode(struct drm_device *dev,
+						    unsigned int color_mode)
+{ }
+#endif
+
+#endif
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 02ea4e3248fd..36a606af4ba1 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -34,6 +34,8 @@
 
 #include <drm/drm_device.h>
 
+struct drm_fb_helper;
+struct drm_fb_helper_surface_size;
 struct drm_file;
 struct drm_gem_object;
 struct drm_master;
@@ -366,6 +368,22 @@ struct drm_driver {
 			       struct drm_device *dev, uint32_t handle,
 			       uint64_t *offset);
 
+	/**
+	 * @fbdev_probe
+	 *
+	 * Allocates and initialize the fb_info structure for fbdev emulation.
+	 * Furthermore it also needs to allocate the DRM framebuffer used to
+	 * back the fbdev.
+	 *
+	 * This callback is mandatory for fbdev support.
+	 *
+	 * Returns:
+	 *
+	 * 0 on success ot a negative error code otherwise.
+	 */
+	int (*fbdev_probe)(struct drm_fb_helper *fbdev_helper,
+			   struct drm_fb_helper_surface_size *sizes);
+
 	/**
 	 * @show_fdinfo:
 	 *
diff --git a/include/drm/drm_fbdev_client.h b/include/drm/drm_fbdev_client.h
new file mode 100644
index 000000000000..e11a5614f127
--- /dev/null
+++ b/include/drm/drm_fbdev_client.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: MIT */
+
+#ifndef DRM_FBDEV_CLIENT_H
+#define DRM_FBDEV_CLIENT_H
+
+struct drm_device;
+struct drm_format_info;
+
+#ifdef CONFIG_DRM_FBDEV_EMULATION
+int drm_fbdev_client_setup(struct drm_device *dev, const struct drm_format_info *format);
+#else
+static inline int drm_fbdev_client_setup(struct drm_device *dev,
+					 const struct drm_format_info *format)
+{
+	return 0;
+}
+#endif
+
+#endif
diff --git a/include/drm/drm_fbdev_ttm.h b/include/drm/drm_fbdev_ttm.h
index 9e6c3bdf3537..243685d02eb1 100644
--- a/include/drm/drm_fbdev_ttm.h
+++ b/include/drm/drm_fbdev_ttm.h
@@ -3,11 +3,24 @@
 #ifndef DRM_FBDEV_TTM_H
 #define DRM_FBDEV_TTM_H
 
+#include <linux/stddef.h>
+
 struct drm_device;
+struct drm_fb_helper;
+struct drm_fb_helper_surface_size;
 
 #ifdef CONFIG_DRM_FBDEV_EMULATION
+int drm_fbdev_ttm_driver_fbdev_probe(struct drm_fb_helper *fb_helper,
+				     struct drm_fb_helper_surface_size *sizes);
+
+#define DRM_FBDEV_TTM_DRIVER_OPS \
+	.fbdev_probe = drm_fbdev_ttm_driver_fbdev_probe
+
 void drm_fbdev_ttm_setup(struct drm_device *dev, unsigned int preferred_bpp);
 #else
+#define DRM_FBDEV_TTM_DRIVER_OPS \
+	.fbdev_probe = NULL
+
 static inline void drm_fbdev_ttm_setup(struct drm_device *dev, unsigned int preferred_bpp)
 { }
 #endif
diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index ccf91daa4307..c3f4405d6662 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -313,6 +313,7 @@ drm_get_format_info(struct drm_device *dev,
 uint32_t drm_mode_legacy_fb_format(uint32_t bpp, uint32_t depth);
 uint32_t drm_driver_legacy_fb_format(struct drm_device *dev,
 				     uint32_t bpp, uint32_t depth);
+uint32_t drm_driver_color_mode_format(struct drm_device *dev, unsigned int color_mode);
 unsigned int drm_format_info_block_width(const struct drm_format_info *info,
 					 int plane);
 unsigned int drm_format_info_block_height(const struct drm_format_info *info,
diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index e94776496049..7bf0c521db63 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -80,6 +80,11 @@ static inline unsigned long compact_gap(unsigned int order)
 	return 2UL << order;
 }
 
+static inline int current_is_kcompactd(void)
+{
+	return current->flags & PF_KCOMPACTD;
+}
+
 #ifdef CONFIG_COMPACTION
 
 extern unsigned int extfrag_for_order(struct zone *zone, unsigned int order);
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index b8b935b52603..b0ed740ca749 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -412,6 +412,29 @@ struct ethtool_eth_phy_stats {
 	);
 };
 
+/**
+ * struct ethtool_phy_stats - PHY-level statistics counters
+ * @rx_packets: Total successfully received frames
+ * @rx_bytes: Total successfully received bytes
+ * @rx_errors: Total received frames with errors (e.g., CRC errors)
+ * @tx_packets: Total successfully transmitted frames
+ * @tx_bytes: Total successfully transmitted bytes
+ * @tx_errors: Total transmitted frames with errors
+ *
+ * This structure provides a standardized interface for reporting
+ * PHY-level statistics counters. It is designed to expose statistics
+ * commonly provided by PHYs but not explicitly defined in the IEEE
+ * 802.3 standard.
+ */
+struct ethtool_phy_stats {
+	u64 rx_packets;
+	u64 rx_bytes;
+	u64 rx_errors;
+	u64 tx_packets;
+	u64 tx_bytes;
+	u64 tx_errors;
+};
+
 /* Basic IEEE 802.3 MAC Ctrl statistics (30.3.3.*), not otherwise exposed
  * via a more targeted API.
  */
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index e4697539b665..25a7b13574c2 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1009,7 +1009,9 @@ static inline void hugetlb_count_sub(long l, struct mm_struct *mm)
 static inline pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma,
 						unsigned long addr, pte_t *ptep)
 {
-	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+	unsigned long psize = huge_page_size(hstate_vma(vma));
+
+	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep, psize);
 }
 #endif
 
diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
index e07e8978d691..e435250fcb4d 100644
--- a/include/linux/nvme-tcp.h
+++ b/include/linux/nvme-tcp.h
@@ -13,6 +13,8 @@
 #define NVME_TCP_ADMIN_CCSZ	SZ_8K
 #define NVME_TCP_DIGEST_LENGTH	4
 #define NVME_TCP_MIN_MAXH2CDATA 4096
+#define NVME_TCP_MIN_C2HTERM_PLEN	24
+#define NVME_TCP_MAX_C2HTERM_PLEN	152
 
 enum nvme_tcp_pfv {
 	NVME_TCP_PFV_1_0 = 0x0,
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b58d9405d65e..1c101f6fad2f 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -388,6 +388,7 @@ enum {
 	NVME_CTRL_CTRATT_PREDICTABLE_LAT	= 1 << 5,
 	NVME_CTRL_CTRATT_NAMESPACE_GRANULARITY	= 1 << 7,
 	NVME_CTRL_CTRATT_UUID_LIST		= 1 << 9,
+	NVME_CTRL_SGLS_MSDS                     = 1 << 19,
 };
 
 struct nvme_lbaf {
diff --git a/include/linux/phy.h b/include/linux/phy.h
index a98bc91a0cde..945264f457d8 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1090,6 +1090,35 @@ struct phy_driver {
 	int (*cable_test_get_status)(struct phy_device *dev, bool *finished);
 
 	/* Get statistics from the PHY using ethtool */
+	/**
+	 * @get_phy_stats: Retrieve PHY statistics.
+	 * @dev: The PHY device for which the statistics are retrieved.
+	 * @eth_stats: structure where Ethernet PHY stats will be stored.
+	 * @stats: structure where additional PHY-specific stats will be stored.
+	 *
+	 * Retrieves the supported PHY statistics and populates the provided
+	 * structures. The input structures are pre-initialized with
+	 * `ETHTOOL_STAT_NOT_SET`, and the driver must only modify members
+	 * corresponding to supported statistics. Unmodified members will remain
+	 * set to `ETHTOOL_STAT_NOT_SET` and will not be returned to userspace.
+	 */
+	void (*get_phy_stats)(struct phy_device *dev,
+			      struct ethtool_eth_phy_stats *eth_stats,
+			      struct ethtool_phy_stats *stats);
+
+	/**
+	 * @get_link_stats: Retrieve link statistics.
+	 * @dev: The PHY device for which the statistics are retrieved.
+	 * @link_stats: structure where link-specific stats will be stored.
+	 *
+	 * Retrieves link-related statistics for the given PHY device. The input
+	 * structure is pre-initialized with `ETHTOOL_STAT_NOT_SET`, and the
+	 * driver must only modify members corresponding to supported
+	 * statistics. Unmodified members will remain set to
+	 * `ETHTOOL_STAT_NOT_SET` and will not be returned to userspace.
+	 */
+	void (*get_link_stats)(struct phy_device *dev,
+			       struct ethtool_link_ext_stats *link_stats);
 	/** @get_sset_count: Number of statistic counters */
 	int (*get_sset_count)(struct phy_device *dev);
 	/** @get_strings: Names of the statistic counters */
@@ -2055,6 +2084,13 @@ int phy_ethtool_get_strings(struct phy_device *phydev, u8 *data);
 int phy_ethtool_get_sset_count(struct phy_device *phydev);
 int phy_ethtool_get_stats(struct phy_device *phydev,
 			  struct ethtool_stats *stats, u64 *data);
+
+void __phy_ethtool_get_phy_stats(struct phy_device *phydev,
+			 struct ethtool_eth_phy_stats *phy_stats,
+			 struct ethtool_phy_stats *phydev_stats);
+void __phy_ethtool_get_link_ext_stats(struct phy_device *phydev,
+				      struct ethtool_link_ext_stats *link_stats);
+
 int phy_ethtool_get_plca_cfg(struct phy_device *phydev,
 			     struct phy_plca_cfg *plca_cfg);
 int phy_ethtool_set_plca_cfg(struct phy_device *phydev,
diff --git a/include/linux/phylib_stubs.h b/include/linux/phylib_stubs.h
index 1279f48c8a70..9d2d6090c86d 100644
--- a/include/linux/phylib_stubs.h
+++ b/include/linux/phylib_stubs.h
@@ -5,6 +5,9 @@
 
 #include <linux/rtnetlink.h>
 
+struct ethtool_eth_phy_stats;
+struct ethtool_link_ext_stats;
+struct ethtool_phy_stats;
 struct kernel_hwtstamp_config;
 struct netlink_ext_ack;
 struct phy_device;
@@ -19,6 +22,11 @@ struct phylib_stubs {
 	int (*hwtstamp_set)(struct phy_device *phydev,
 			    struct kernel_hwtstamp_config *config,
 			    struct netlink_ext_ack *extack);
+	void (*get_phy_stats)(struct phy_device *phydev,
+			      struct ethtool_eth_phy_stats *phy_stats,
+			      struct ethtool_phy_stats *phydev_stats);
+	void (*get_link_ext_stats)(struct phy_device *phydev,
+				   struct ethtool_link_ext_stats *link_stats);
 };
 
 static inline int phy_hwtstamp_get(struct phy_device *phydev,
@@ -50,6 +58,29 @@ static inline int phy_hwtstamp_set(struct phy_device *phydev,
 	return phylib_stubs->hwtstamp_set(phydev, config, extack);
 }
 
+static inline void phy_ethtool_get_phy_stats(struct phy_device *phydev,
+					struct ethtool_eth_phy_stats *phy_stats,
+					struct ethtool_phy_stats *phydev_stats)
+{
+	ASSERT_RTNL();
+
+	if (!phylib_stubs)
+		return;
+
+	phylib_stubs->get_phy_stats(phydev, phy_stats, phydev_stats);
+}
+
+static inline void phy_ethtool_get_link_ext_stats(struct phy_device *phydev,
+				    struct ethtool_link_ext_stats *link_stats)
+{
+	ASSERT_RTNL();
+
+	if (!phylib_stubs)
+		return;
+
+	phylib_stubs->get_link_ext_stats(phydev, link_stats);
+}
+
 #else
 
 static inline int phy_hwtstamp_get(struct phy_device *phydev,
@@ -65,4 +96,15 @@ static inline int phy_hwtstamp_set(struct phy_device *phydev,
 	return -EOPNOTSUPP;
 }
 
+static inline void phy_ethtool_get_phy_stats(struct phy_device *phydev,
+					struct ethtool_eth_phy_stats *phy_stats,
+					struct ethtool_phy_stats *phydev_stats)
+{
+}
+
+static inline void phy_ethtool_get_link_ext_stats(struct phy_device *phydev,
+				    struct ethtool_link_ext_stats *link_stats)
+{
+}
+
 #endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8982820dae21..0d1d70aded38 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1682,7 +1682,7 @@ extern struct pid *cad_pid;
 #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
 #define PF_USER_WORKER		0x00004000	/* Kernel thread cloned from userspace thread */
 #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
-#define PF__HOLE__00010000	0x00010000
+#define PF_KCOMPACTD		0x00010000	/* I am kcompactd */
 #define PF_KSWAPD		0x00020000	/* I am kswapd */
 #define PF_MEMALLOC_NOFS	0x00040000	/* All allocations inherit GFP_NOFS. See memalloc_nfs_save() */
 #define PF_MEMALLOC_NOIO	0x00080000	/* All allocations inherit GFP_NOIO. See memalloc_noio_save() */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a0e1d2124727..5fff74c73606 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11846,6 +11846,8 @@ void perf_pmu_unregister(struct pmu *pmu)
 {
 	mutex_lock(&pmus_lock);
 	list_del_rcu(&pmu->entry);
+	idr_remove(&pmu_idr, pmu->type);
+	mutex_unlock(&pmus_lock);
 
 	/*
 	 * We dereference the pmu list under both SRCU and regular RCU, so
@@ -11855,7 +11857,6 @@ void perf_pmu_unregister(struct pmu *pmu)
 	synchronize_rcu();
 
 	free_percpu(pmu->pmu_disable_count);
-	idr_remove(&pmu_idr, pmu->type);
 	if (pmu_bus_running && pmu->dev && pmu->dev != PMU_NULL_DEV) {
 		if (pmu->nr_addr_filters)
 			device_remove_file(pmu->dev, &dev_attr_nr_addr_filters);
@@ -11863,7 +11864,6 @@ void perf_pmu_unregister(struct pmu *pmu)
 		put_device(pmu->dev);
 	}
 	free_pmu_context(pmu);
-	mutex_unlock(&pmus_lock);
 }
 EXPORT_SYMBOL_GPL(perf_pmu_unregister);
 
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index a0e0676f5d8b..4fdc08ca0f3c 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1775,6 +1775,7 @@ void uprobe_free_utask(struct task_struct *t)
 	if (!utask)
 		return;
 
+	t->utask = NULL;
 	if (utask->active_uprobe)
 		put_uprobe(utask->active_uprobe);
 
@@ -1784,7 +1785,6 @@ void uprobe_free_utask(struct task_struct *t)
 
 	xol_free_insn_slot(t);
 	kfree(utask);
-	t->utask = NULL;
 }
 
 /*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ddc096d6b0c2..58ba14ed8fbc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4155,15 +4155,17 @@ static inline bool child_cfs_rq_on_list(struct cfs_rq *cfs_rq)
 {
 	struct cfs_rq *prev_cfs_rq;
 	struct list_head *prev;
+	struct rq *rq = rq_of(cfs_rq);
 
 	if (cfs_rq->on_list) {
 		prev = cfs_rq->leaf_cfs_rq_list.prev;
 	} else {
-		struct rq *rq = rq_of(cfs_rq);
-
 		prev = rq->tmp_alone_branch;
 	}
 
+	if (prev == &rq->leaf_cfs_rq_list)
+		return false;
+
 	prev_cfs_rq = container_of(prev, struct cfs_rq, leaf_cfs_rq_list);
 
 	return (prev_cfs_rq->tg->parent == cfs_rq->tg);
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index c62d1629cffe..99048c330382 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -1018,6 +1018,19 @@ static int parse_symbol_and_return(int argc, const char *argv[],
 	if (*is_return)
 		return 0;
 
+	if (is_tracepoint) {
+		tmp = *symbol;
+		while (*tmp && (isalnum(*tmp) || *tmp == '_'))
+			tmp++;
+		if (*tmp) {
+			/* find a wrong character. */
+			trace_probe_log_err(tmp - *symbol, BAD_TP_NAME);
+			kfree(*symbol);
+			*symbol = NULL;
+			return -EINVAL;
+		}
+	}
+
 	/* If there is $retval, this should be a return fprobe. */
 	for (i = 2; i < argc; i++) {
 		tmp = strstr(argv[i], "$retval");
@@ -1025,6 +1038,8 @@ static int parse_symbol_and_return(int argc, const char *argv[],
 			if (is_tracepoint) {
 				trace_probe_log_set_index(i);
 				trace_probe_log_err(tmp - argv[i], RETVAL_ON_PROBE);
+				kfree(*symbol);
+				*symbol = NULL;
 				return -EINVAL;
 			}
 			*is_return = true;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 5803e6a41570..8a6797c2278d 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -36,7 +36,6 @@
 #define MAX_BTF_ARGS_LEN	128
 #define MAX_DENTRY_ARGS_LEN	256
 #define MAX_STRING_SIZE		PATH_MAX
-#define MAX_ARG_BUF_LEN		(MAX_TRACE_ARGS * MAX_ARG_NAME_LEN)
 
 /* Reserved field names */
 #define FIELD_STRING_IP		"__probe_ip"
@@ -481,6 +480,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(NON_UNIQ_SYMBOL,	"The symbol is not unique"),		\
 	C(BAD_RETPROBE,		"Retprobe address must be an function entry"), \
 	C(NO_TRACEPOINT,	"Tracepoint is not found"),		\
+	C(BAD_TP_NAME,		"Invalid character in tracepoint name"),\
 	C(BAD_ADDR_SUFFIX,	"Invalid probed address suffix"), \
 	C(NO_GROUP_NAME,	"Group name is not specified"),		\
 	C(GROUP_TOO_LONG,	"Group name is too long"),		\
diff --git a/mm/compaction.c b/mm/compaction.c
index 384e4672998e..77dbb9022b47 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -3164,6 +3164,7 @@ static int kcompactd(void *p)
 	if (!cpumask_empty(cpumask))
 		set_cpus_allowed_ptr(tsk, cpumask);
 
+	current->flags |= PF_KCOMPACTD;
 	set_freezable();
 
 	pgdat->kcompactd_max_order = 0;
@@ -3220,6 +3221,8 @@ static int kcompactd(void *p)
 			pgdat->proactive_compact_trigger = false;
 	}
 
+	current->flags &= ~PF_KCOMPACTD;
+
 	return 0;
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bdee6d3ab0e7..1e9aa6de4e21 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5395,7 +5395,7 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 	if (src_ptl != dst_ptl)
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 
-	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte);
+	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte, sz);
 
 	if (need_clear_uffd_wp && pte_marker_uffd_wp(pte))
 		huge_pte_clear(mm, new_addr, dst_pte, sz);
@@ -5570,7 +5570,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			set_vma_resv_flags(vma, HPAGE_RESV_UNMAPPED);
 		}
 
-		pte = huge_ptep_get_and_clear(mm, address, ptep);
+		pte = huge_ptep_get_and_clear(mm, address, ptep, sz);
 		tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
 		if (huge_pte_dirty(pte))
 			set_page_dirty(page);
diff --git a/mm/internal.h b/mm/internal.h
index 9bb098e78f15..398633d6b6c9 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1101,7 +1101,7 @@ static inline int find_next_best_node(int node, nodemask_t *used_node_mask)
  * mm/memory-failure.c
  */
 #ifdef CONFIG_MEMORY_FAILURE
-void unmap_poisoned_folio(struct folio *folio, enum ttu_flags ttu);
+int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill);
 void shake_folio(struct folio *folio);
 extern int hwpoison_filter(struct page *p);
 
@@ -1123,8 +1123,9 @@ void add_to_kill_ksm(struct task_struct *tsk, struct page *p,
 unsigned long page_mapped_in_vma(struct page *page, struct vm_area_struct *vma);
 
 #else
-static inline void unmap_poisoned_folio(struct folio *folio, enum ttu_flags ttu)
+static inline int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill)
 {
+	return -EBUSY;
 }
 #endif
 
diff --git a/mm/kasan/kasan_test_rust.rs b/mm/kasan/kasan_test_rust.rs
index caa7175964ef..5b34edf30e72 100644
--- a/mm/kasan/kasan_test_rust.rs
+++ b/mm/kasan/kasan_test_rust.rs
@@ -11,11 +11,12 @@
 /// drop the vector, and touch it.
 #[no_mangle]
 pub extern "C" fn kasan_test_rust_uaf() -> u8 {
-    let mut v: Vec<u8> = Vec::new();
+    let mut v: KVec<u8> = KVec::new();
     for _ in 0..4096 {
         v.push(0x42, GFP_KERNEL).unwrap();
     }
     let ptr: *mut u8 = addr_of_mut!(v[2048]);
     drop(v);
+    // SAFETY: Incorrect, on purpose.
     unsafe { *ptr }
 }
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 3ea50f09311f..3df45c25c1f6 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -357,6 +357,7 @@ void kmsan_handle_dma(struct page *page, size_t offset, size_t size,
 		size -= to_go;
 	}
 }
+EXPORT_SYMBOL_GPL(kmsan_handle_dma);
 
 void kmsan_handle_dma_sg(struct scatterlist *sg, int nents,
 			 enum dma_data_direction dir)
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 96ce31e5a203..fa25a022e64d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1554,11 +1554,35 @@ static int get_hwpoison_page(struct page *p, unsigned long flags)
 	return ret;
 }
 
-void unmap_poisoned_folio(struct folio *folio, enum ttu_flags ttu)
+int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill)
 {
-	if (folio_test_hugetlb(folio) && !folio_test_anon(folio)) {
-		struct address_space *mapping;
+	enum ttu_flags ttu = TTU_IGNORE_MLOCK | TTU_SYNC | TTU_HWPOISON;
+	struct address_space *mapping;
+
+	if (folio_test_swapcache(folio)) {
+		pr_err("%#lx: keeping poisoned page in swap cache\n", pfn);
+		ttu &= ~TTU_HWPOISON;
+	}
 
+	/*
+	 * Propagate the dirty bit from PTEs to struct page first, because we
+	 * need this to decide if we should kill or just drop the page.
+	 * XXX: the dirty test could be racy: set_page_dirty() may not always
+	 * be called inside page lock (it's recommended but not enforced).
+	 */
+	mapping = folio_mapping(folio);
+	if (!must_kill && !folio_test_dirty(folio) && mapping &&
+	    mapping_can_writeback(mapping)) {
+		if (folio_mkclean(folio)) {
+			folio_set_dirty(folio);
+		} else {
+			ttu &= ~TTU_HWPOISON;
+			pr_info("%#lx: corrupted page was clean: dropped without side effects\n",
+				pfn);
+		}
+	}
+
+	if (folio_test_hugetlb(folio) && !folio_test_anon(folio)) {
 		/*
 		 * For hugetlb folios in shared mappings, try_to_unmap
 		 * could potentially call huge_pmd_unshare.  Because of
@@ -1570,7 +1594,7 @@ void unmap_poisoned_folio(struct folio *folio, enum ttu_flags ttu)
 		if (!mapping) {
 			pr_info("%#lx: could not lock mapping for mapped hugetlb folio\n",
 				folio_pfn(folio));
-			return;
+			return -EBUSY;
 		}
 
 		try_to_unmap(folio, ttu|TTU_RMAP_LOCKED);
@@ -1578,6 +1602,8 @@ void unmap_poisoned_folio(struct folio *folio, enum ttu_flags ttu)
 	} else {
 		try_to_unmap(folio, ttu);
 	}
+
+	return folio_mapped(folio) ? -EBUSY : 0;
 }
 
 /*
@@ -1587,8 +1613,6 @@ void unmap_poisoned_folio(struct folio *folio, enum ttu_flags ttu)
 static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
 		unsigned long pfn, int flags)
 {
-	enum ttu_flags ttu = TTU_IGNORE_MLOCK | TTU_SYNC | TTU_HWPOISON;
-	struct address_space *mapping;
 	LIST_HEAD(tokill);
 	bool unmap_success;
 	int forcekill;
@@ -1611,29 +1635,6 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
 	if (!folio_mapped(folio))
 		return true;
 
-	if (folio_test_swapcache(folio)) {
-		pr_err("%#lx: keeping poisoned page in swap cache\n", pfn);
-		ttu &= ~TTU_HWPOISON;
-	}
-
-	/*
-	 * Propagate the dirty bit from PTEs to struct page first, because we
-	 * need this to decide if we should kill or just drop the page.
-	 * XXX: the dirty test could be racy: set_page_dirty() may not always
-	 * be called inside page lock (it's recommended but not enforced).
-	 */
-	mapping = folio_mapping(folio);
-	if (!(flags & MF_MUST_KILL) && !folio_test_dirty(folio) && mapping &&
-	    mapping_can_writeback(mapping)) {
-		if (folio_mkclean(folio)) {
-			folio_set_dirty(folio);
-		} else {
-			ttu &= ~TTU_HWPOISON;
-			pr_info("%#lx: corrupted page was clean: dropped without side effects\n",
-				pfn);
-		}
-	}
-
 	/*
 	 * First collect all the processes that have the page
 	 * mapped in dirty form.  This has to be done before try_to_unmap,
@@ -1641,9 +1642,7 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
 	 */
 	collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
 
-	unmap_poisoned_folio(folio, ttu);
-
-	unmap_success = !folio_mapped(folio);
+	unmap_success = !unmap_poisoned_folio(folio, pfn, flags & MF_MUST_KILL);
 	if (!unmap_success)
 		pr_err("%#lx: failed to unmap page (folio mapcount=%d)\n",
 		       pfn, folio_mapcount(folio));
diff --git a/mm/memory.c b/mm/memory.c
index d322ddfe6791..525f96ad65b8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2957,8 +2957,10 @@ static int __apply_to_page_range(struct mm_struct *mm, unsigned long addr,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none(*pgd) && !create)
 			continue;
-		if (WARN_ON_ONCE(pgd_leaf(*pgd)))
-			return -EINVAL;
+		if (WARN_ON_ONCE(pgd_leaf(*pgd))) {
+			err = -EINVAL;
+			break;
+		}
 		if (!pgd_none(*pgd) && WARN_ON_ONCE(pgd_bad(*pgd))) {
 			if (!create)
 				continue;
@@ -5077,7 +5079,11 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	bool is_cow = (vmf->flags & FAULT_FLAG_WRITE) &&
 		      !(vma->vm_flags & VM_SHARED);
 	int type, nr_pages;
-	unsigned long addr = vmf->address;
+	unsigned long addr;
+	bool needs_fallback = false;
+
+fallback:
+	addr = vmf->address;
 
 	/* Did we COW the page? */
 	if (is_cow)
@@ -5116,7 +5122,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	 * approach also applies to non-anonymous-shmem faults to avoid
 	 * inflating the RSS of the process.
 	 */
-	if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma))) {
+	if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma)) ||
+	    unlikely(needs_fallback)) {
 		nr_pages = 1;
 	} else if (nr_pages > 1) {
 		pgoff_t idx = folio_page_idx(folio, page);
@@ -5152,9 +5159,9 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 		ret = VM_FAULT_NOPAGE;
 		goto unlock;
 	} else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
-		update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
-		ret = VM_FAULT_NOPAGE;
-		goto unlock;
+		needs_fallback = true;
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		goto fallback;
 	}
 
 	folio_ref_add(folio, nr_pages - 1);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 621ae1015106..619445096ef4 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1795,26 +1795,24 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		if (folio_test_large(folio))
 			pfn = folio_pfn(folio) + folio_nr_pages(folio) - 1;
 
-		/*
-		 * HWPoison pages have elevated reference counts so the migration would
-		 * fail on them. It also doesn't make any sense to migrate them in the
-		 * first place. Still try to unmap such a page in case it is still mapped
-		 * (keep the unmap as the catch all safety net).
-		 */
+		if (!folio_try_get(folio))
+			continue;
+
+		if (unlikely(page_folio(page) != folio))
+			goto put_folio;
+
 		if (folio_test_hwpoison(folio) ||
 		    (folio_test_large(folio) && folio_test_has_hwpoisoned(folio))) {
 			if (WARN_ON(folio_test_lru(folio)))
 				folio_isolate_lru(folio);
-			if (folio_mapped(folio))
-				unmap_poisoned_folio(folio, TTU_IGNORE_MLOCK);
-			continue;
-		}
-
-		if (!folio_try_get(folio))
-			continue;
+			if (folio_mapped(folio)) {
+				folio_lock(folio);
+				unmap_poisoned_folio(folio, pfn, false);
+				folio_unlock(folio);
+			}
 
-		if (unlikely(page_folio(page) != folio))
 			goto put_folio;
+		}
 
 		if (!isolate_folio_to_list(folio, &source)) {
 			if (__ratelimit(&migrate_rs)) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index de65e8b4f75f..e0a77fe1b630 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4243,6 +4243,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 restart:
 	compaction_retries = 0;
 	no_progress_loops = 0;
+	compact_result = COMPACT_SKIPPED;
 	compact_priority = DEF_COMPACT_PRIORITY;
 	cpuset_mems_cookie = read_mems_allowed_begin();
 	zonelist_iter_cookie = zonelist_iter_begin();
@@ -5991,11 +5992,10 @@ static void setup_per_zone_lowmem_reserve(void)
 
 			for (j = i + 1; j < MAX_NR_ZONES; j++) {
 				struct zone *upper_zone = &pgdat->node_zones[j];
-				bool empty = !zone_managed_pages(upper_zone);
 
 				managed_pages += zone_managed_pages(upper_zone);
 
-				if (clear || empty)
+				if (clear)
 					zone->lowmem_reserve[j] = 0;
 				else
 					zone->lowmem_reserve[j] = managed_pages / ratio;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index ce13c4062647..66011831d798 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1215,6 +1215,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 		 */
 		if (!src_folio) {
 			struct folio *folio;
+			bool locked;
 
 			/*
 			 * Pin the page while holding the lock to be sure the
@@ -1234,12 +1235,26 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 				goto out;
 			}
 
+			locked = folio_trylock(folio);
+			/*
+			 * We avoid waiting for folio lock with a raised
+			 * refcount for large folios because extra refcounts
+			 * will result in split_folio() failing later and
+			 * retrying.  If multiple tasks are trying to move a
+			 * large folio we can end up livelocking.
+			 */
+			if (!locked && folio_test_large(folio)) {
+				spin_unlock(src_ptl);
+				err = -EAGAIN;
+				goto out;
+			}
+
 			folio_get(folio);
 			src_folio = folio;
 			src_folio_pte = orig_src_pte;
 			spin_unlock(src_ptl);
 
-			if (!folio_trylock(src_folio)) {
+			if (!locked) {
 				pte_unmap(&orig_src_pte);
 				pte_unmap(&orig_dst_pte);
 				src_pte = dst_pte = NULL;
diff --git a/mm/vma.c b/mm/vma.c
index 7621384d64cf..c9ddc06b672a 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1417,24 +1417,28 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
 {
 	struct vm_area_struct *vma = vmg->vma;
+	unsigned long start = vmg->start;
+	unsigned long end = vmg->end;
 	struct vm_area_struct *merged;
 
 	/* First, try to merge. */
 	merged = vma_merge_existing_range(vmg);
 	if (merged)
 		return merged;
+	if (vmg_nomem(vmg))
+		return ERR_PTR(-ENOMEM);
 
 	/* Split any preceding portion of the VMA. */
-	if (vma->vm_start < vmg->start) {
-		int err = split_vma(vmg->vmi, vma, vmg->start, 1);
+	if (vma->vm_start < start) {
+		int err = split_vma(vmg->vmi, vma, start, 1);
 
 		if (err)
 			return ERR_PTR(err);
 	}
 
 	/* Split any trailing portion of the VMA. */
-	if (vma->vm_end > vmg->end) {
-		int err = split_vma(vmg->vmi, vma, vmg->end, 0);
+	if (vma->vm_end > end) {
+		int err = split_vma(vmg->vmi, vma, end, 0);
 
 		if (err)
 			return ERR_PTR(err);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 3f9255dfacb0..fd70a7cd1c8f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -586,13 +586,13 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
 			mask |= PGTBL_PGD_MODIFIED;
 		err = vmap_pages_p4d_range(pgd, addr, next, prot, pages, &nr, &mask);
 		if (err)
-			return err;
+			break;
 	} while (pgd++, addr = next, addr != end);
 
 	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
 		arch_sync_kernel_mappings(start, end);
 
-	return 0;
+	return err;
 }
 
 /*
diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index e45187b88220..41be38264493 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -131,7 +131,8 @@ int vlan_check_real_dev(struct net_device *real_dev,
 {
 	const char *name = real_dev->name;
 
-	if (real_dev->features & NETIF_F_VLAN_CHALLENGED) {
+	if (real_dev->features & NETIF_F_VLAN_CHALLENGED ||
+	    real_dev->type != ARPHRD_ETHER) {
 		pr_info("VLANs not supported on %s\n", name);
 		NL_SET_ERR_MSG_MOD(extack, "VLANs not supported on device");
 		return -EOPNOTSUPP;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 90c21b3edcd8..c019f69c5939 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9731,6 +9731,9 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 				     sizeof(*ev) + (name ? eir_precalc_len(name_len) : 0) +
 				     eir_precalc_len(sizeof(conn->dev_class)));
 
+	if (!skb)
+		return;
+
 	ev = skb_put(skb, sizeof(*ev));
 	bacpy(&ev->addr.bdaddr, &conn->dst);
 	ev->addr.type = link_to_bdaddr(conn->type, conn->dst_type);
@@ -10484,6 +10487,8 @@ void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 
 	skb = mgmt_alloc_skb(hdev, MGMT_EV_DEVICE_FOUND,
 			     sizeof(*ev) + (name ? eir_precalc_len(name_len) : 0));
+	if (!skb)
+		return;
 
 	ev = skb_put(skb, sizeof(*ev));
 	bacpy(&ev->addr.bdaddr, bdaddr);
diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
index f22051f33868..84096f6b0236 100644
--- a/net/ethtool/cabletest.c
+++ b/net/ethtool/cabletest.c
@@ -72,8 +72,8 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
 	dev = req_info.dev;
 
 	rtnl_lock();
-	phydev = ethnl_req_get_phydev(&req_info,
-				      tb[ETHTOOL_A_CABLE_TEST_HEADER],
+	phydev = ethnl_req_get_phydev(&req_info, tb,
+				      ETHTOOL_A_CABLE_TEST_HEADER,
 				      info->extack);
 	if (IS_ERR_OR_NULL(phydev)) {
 		ret = -EOPNOTSUPP;
@@ -339,8 +339,8 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 		goto out_dev_put;
 
 	rtnl_lock();
-	phydev = ethnl_req_get_phydev(&req_info,
-				      tb[ETHTOOL_A_CABLE_TEST_TDR_HEADER],
+	phydev = ethnl_req_get_phydev(&req_info, tb,
+				      ETHTOOL_A_CABLE_TEST_TDR_HEADER,
 				      info->extack);
 	if (IS_ERR_OR_NULL(phydev)) {
 		ret = -EOPNOTSUPP;
diff --git a/net/ethtool/linkstate.c b/net/ethtool/linkstate.c
index 34d76e87847d..05a5f72c99fa 100644
--- a/net/ethtool/linkstate.c
+++ b/net/ethtool/linkstate.c
@@ -3,6 +3,7 @@
 #include "netlink.h"
 #include "common.h"
 #include <linux/phy.h>
+#include <linux/phylib_stubs.h>
 
 struct linkstate_req_info {
 	struct ethnl_req_info		base;
@@ -26,9 +27,8 @@ const struct nla_policy ethnl_linkstate_get_policy[] = {
 		NLA_POLICY_NESTED(ethnl_header_policy_stats),
 };
 
-static int linkstate_get_sqi(struct net_device *dev)
+static int linkstate_get_sqi(struct phy_device *phydev)
 {
-	struct phy_device *phydev = dev->phydev;
 	int ret;
 
 	if (!phydev)
@@ -46,9 +46,8 @@ static int linkstate_get_sqi(struct net_device *dev)
 	return ret;
 }
 
-static int linkstate_get_sqi_max(struct net_device *dev)
+static int linkstate_get_sqi_max(struct phy_device *phydev)
 {
-	struct phy_device *phydev = dev->phydev;
 	int ret;
 
 	if (!phydev)
@@ -100,19 +99,28 @@ static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
 {
 	struct linkstate_reply_data *data = LINKSTATE_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
+	struct nlattr **tb = info->attrs;
+	struct phy_device *phydev;
 	int ret;
 
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_LINKSTATE_HEADER,
+				      info->extack);
+	if (IS_ERR(phydev)) {
+		ret = PTR_ERR(phydev);
+		goto out;
+	}
+
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		return ret;
 	data->link = __ethtool_get_link(dev);
 
-	ret = linkstate_get_sqi(dev);
+	ret = linkstate_get_sqi(phydev);
 	if (linkstate_sqi_critical_error(ret))
 		goto out;
 	data->sqi = ret;
 
-	ret = linkstate_get_sqi_max(dev);
+	ret = linkstate_get_sqi_max(phydev);
 	if (linkstate_sqi_critical_error(ret))
 		goto out;
 	data->sqi_max = ret;
@@ -127,9 +135,9 @@ static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
 			   sizeof(data->link_stats) / 8);
 
 	if (req_base->flags & ETHTOOL_FLAG_STATS) {
-		if (dev->phydev)
-			data->link_stats.link_down_events =
-				READ_ONCE(dev->phydev->link_down_events);
+		if (phydev)
+			phy_ethtool_get_link_ext_stats(phydev,
+						       &data->link_stats);
 
 		if (dev->ethtool_ops->get_link_ext_stats)
 			dev->ethtool_ops->get_link_ext_stats(dev,
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 4d18dc29b304..e233dfc8ca4b 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -210,7 +210,7 @@ int ethnl_parse_header_dev_get(struct ethnl_req_info *req_info,
 }
 
 struct phy_device *ethnl_req_get_phydev(const struct ethnl_req_info *req_info,
-					const struct nlattr *header,
+					struct nlattr **tb, unsigned int header,
 					struct netlink_ext_ack *extack)
 {
 	struct phy_device *phydev;
@@ -224,8 +224,8 @@ struct phy_device *ethnl_req_get_phydev(const struct ethnl_req_info *req_info,
 		return req_info->dev->phydev;
 
 	phydev = phy_link_topo_get_phy(req_info->dev, req_info->phy_index);
-	if (!phydev) {
-		NL_SET_ERR_MSG_ATTR(extack, header,
+	if (!phydev && tb) {
+		NL_SET_ERR_MSG_ATTR(extack, tb[header],
 				    "no phy matching phyindex");
 		return ERR_PTR(-ENODEV);
 	}
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 203b08eb6c6f..5e176938d6d2 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -275,7 +275,8 @@ static inline void ethnl_parse_header_dev_put(struct ethnl_req_info *req_info)
  * ethnl_req_get_phydev() - Gets the phy_device targeted by this request,
  *			    if any. Must be called under rntl_lock().
  * @req_info:	The ethnl request to get the phy from.
- * @header:	The netlink header, used for error reporting.
+ * @tb:		The netlink attributes array, for error reporting.
+ * @header:	The netlink header index, used for error reporting.
  * @extack:	The netlink extended ACK, for error reporting.
  *
  * The caller must hold RTNL, until it's done interacting with the returned
@@ -289,7 +290,7 @@ static inline void ethnl_parse_header_dev_put(struct ethnl_req_info *req_info)
  *	   is returned.
  */
 struct phy_device *ethnl_req_get_phydev(const struct ethnl_req_info *req_info,
-					const struct nlattr *header,
+					struct nlattr **tb, unsigned int header,
 					struct netlink_ext_ack *extack);
 
 /**
diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index ed8f690f6bac..e067cc234419 100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -125,7 +125,7 @@ static int ethnl_phy_parse_request(struct ethnl_req_info *req_base,
 	struct phy_req_info *req_info = PHY_REQINFO(req_base);
 	struct phy_device *phydev;
 
-	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_PHY_HEADER],
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_PHY_HEADER,
 				      extack);
 	if (!phydev)
 		return 0;
diff --git a/net/ethtool/plca.c b/net/ethtool/plca.c
index d95d92f173a6..e1f7820a6158 100644
--- a/net/ethtool/plca.c
+++ b/net/ethtool/plca.c
@@ -62,7 +62,7 @@ static int plca_get_cfg_prepare_data(const struct ethnl_req_info *req_base,
 	struct phy_device *phydev;
 	int ret;
 
-	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_PLCA_HEADER],
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_PLCA_HEADER,
 				      info->extack);
 	// check that the PHY device is available and connected
 	if (IS_ERR_OR_NULL(phydev)) {
@@ -152,7 +152,7 @@ ethnl_set_plca(struct ethnl_req_info *req_info, struct genl_info *info)
 	bool mod = false;
 	int ret;
 
-	phydev = ethnl_req_get_phydev(req_info, tb[ETHTOOL_A_PLCA_HEADER],
+	phydev = ethnl_req_get_phydev(req_info, tb, ETHTOOL_A_PLCA_HEADER,
 				      info->extack);
 	// check that the PHY device is available and connected
 	if (IS_ERR_OR_NULL(phydev))
@@ -211,7 +211,7 @@ static int plca_get_status_prepare_data(const struct ethnl_req_info *req_base,
 	struct phy_device *phydev;
 	int ret;
 
-	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_PLCA_HEADER],
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_PLCA_HEADER,
 				      info->extack);
 	// check that the PHY device is available and connected
 	if (IS_ERR_OR_NULL(phydev)) {
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index a0705edca22a..71843de832cc 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -64,7 +64,7 @@ static int pse_prepare_data(const struct ethnl_req_info *req_base,
 	if (ret < 0)
 		return ret;
 
-	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_PSE_HEADER],
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_PSE_HEADER,
 				      info->extack);
 	if (IS_ERR(phydev))
 		return -ENODEV;
@@ -261,7 +261,7 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 	struct phy_device *phydev;
 	int ret;
 
-	phydev = ethnl_req_get_phydev(req_info, tb[ETHTOOL_A_PSE_HEADER],
+	phydev = ethnl_req_get_phydev(req_info, tb, ETHTOOL_A_PSE_HEADER,
 				      info->extack);
 	ret = ethnl_set_pse_validate(phydev, info);
 	if (ret)
diff --git a/net/ethtool/stats.c b/net/ethtool/stats.c
index 912f0c4fff2f..273ae4ff343f 100644
--- a/net/ethtool/stats.c
+++ b/net/ethtool/stats.c
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/phy.h>
+#include <linux/phylib_stubs.h>
+
 #include "netlink.h"
 #include "common.h"
 #include "bitset.h"
@@ -20,6 +23,7 @@ struct stats_reply_data {
 		struct ethtool_eth_mac_stats	mac_stats;
 		struct ethtool_eth_ctrl_stats	ctrl_stats;
 		struct ethtool_rmon_stats	rmon_stats;
+		struct ethtool_phy_stats	phydev_stats;
 	);
 	const struct ethtool_rmon_hist_range	*rmon_ranges;
 };
@@ -120,8 +124,15 @@ static int stats_prepare_data(const struct ethnl_req_info *req_base,
 	struct stats_reply_data *data = STATS_REPDATA(reply_base);
 	enum ethtool_mac_stats_src src = req_info->src;
 	struct net_device *dev = reply_base->dev;
+	struct nlattr **tb = info->attrs;
+	struct phy_device *phydev;
 	int ret;
 
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_STATS_HEADER,
+				      info->extack);
+	if (IS_ERR(phydev))
+		return PTR_ERR(phydev);
+
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		return ret;
@@ -145,6 +156,13 @@ static int stats_prepare_data(const struct ethnl_req_info *req_base,
 	data->ctrl_stats.src = src;
 	data->rmon_stats.src = src;
 
+	if (test_bit(ETHTOOL_STATS_ETH_PHY, req_info->stat_mask) &&
+	    src == ETHTOOL_MAC_STATS_SRC_AGGREGATE) {
+		if (phydev)
+			phy_ethtool_get_phy_stats(phydev, &data->phy_stats,
+						  &data->phydev_stats);
+	}
+
 	if (test_bit(ETHTOOL_STATS_ETH_PHY, req_info->stat_mask) &&
 	    dev->ethtool_ops->get_eth_phy_stats)
 		dev->ethtool_ops->get_eth_phy_stats(dev, &data->phy_stats);
diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
index b3382b3cf325..b9400d18f01d 100644
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
@@ -299,7 +299,7 @@ static int strset_prepare_data(const struct ethnl_req_info *req_base,
 		return 0;
 	}
 
-	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_HEADER_FLAGS],
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_HEADER_FLAGS,
 				      info->extack);
 
 	/* phydev can be NULL, check for errors only */
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 2308665b51c5..2dfac79dc78b 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -13,12 +13,15 @@
 #include <net/tcp.h>
 #include <net/protocol.h>
 
-static void tcp_gso_tstamp(struct sk_buff *skb, unsigned int ts_seq,
+static void tcp_gso_tstamp(struct sk_buff *skb, struct sk_buff *gso_skb,
 			   unsigned int seq, unsigned int mss)
 {
+	u32 flags = skb_shinfo(gso_skb)->tx_flags & SKBTX_ANY_TSTAMP;
+	u32 ts_seq = skb_shinfo(gso_skb)->tskey;
+
 	while (skb) {
 		if (before(ts_seq, seq + mss)) {
-			skb_shinfo(skb)->tx_flags |= SKBTX_SW_TSTAMP;
+			skb_shinfo(skb)->tx_flags |= flags;
 			skb_shinfo(skb)->tskey = ts_seq;
 			return;
 		}
@@ -193,8 +196,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	th = tcp_hdr(skb);
 	seq = ntohl(th->seq);
 
-	if (unlikely(skb_shinfo(gso_skb)->tx_flags & SKBTX_SW_TSTAMP))
-		tcp_gso_tstamp(segs, skb_shinfo(gso_skb)->tskey, seq, mss);
+	if (unlikely(skb_shinfo(gso_skb)->tx_flags & SKBTX_ANY_TSTAMP))
+		tcp_gso_tstamp(segs, gso_skb, seq, mss);
 
 	newcheck = ~csum_fold(csum_add(csum_unfold(th->check), delta));
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index a5be6e4ed326..ecfca59f31f1 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -321,13 +321,17 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 
 	/* clear destructor to avoid skb_segment assigning it to tail */
 	copy_dtor = gso_skb->destructor == sock_wfree;
-	if (copy_dtor)
+	if (copy_dtor) {
 		gso_skb->destructor = NULL;
+		gso_skb->sk = NULL;
+	}
 
 	segs = skb_segment(gso_skb, features);
 	if (IS_ERR_OR_NULL(segs)) {
-		if (copy_dtor)
+		if (copy_dtor) {
 			gso_skb->destructor = sock_wfree;
+			gso_skb->sk = sk;
+		}
 		return segs;
 	}
 
diff --git a/net/ipv6/ila/ila_lwt.c b/net/ipv6/ila/ila_lwt.c
index ff7e734e335b..7d574f5132e2 100644
--- a/net/ipv6/ila/ila_lwt.c
+++ b/net/ipv6/ila/ila_lwt.c
@@ -88,13 +88,15 @@ static int ila_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 		}
 
-		if (ilwt->connected) {
+		/* cache only if we don't create a dst reference loop */
+		if (ilwt->connected && orig_dst->lwtstate != dst->lwtstate) {
 			local_bh_disable();
 			dst_cache_set_ip6(&ilwt->dst_cache, dst, &fl6.saddr);
 			local_bh_enable();
 		}
 	}
 
+	skb_dst_drop(skb);
 	skb_dst_set(skb, dst);
 	return dst_output(net, sk, skb);
 
diff --git a/net/llc/llc_s_ac.c b/net/llc/llc_s_ac.c
index 06fb8e6944b0..7a0cae9a8111 100644
--- a/net/llc/llc_s_ac.c
+++ b/net/llc/llc_s_ac.c
@@ -24,7 +24,7 @@
 #include <net/llc_s_ac.h>
 #include <net/llc_s_ev.h>
 #include <net/llc_sap.h>
-
+#include <net/sock.h>
 
 /**
  *	llc_sap_action_unitdata_ind - forward UI PDU to network layer
@@ -40,6 +40,26 @@ int llc_sap_action_unitdata_ind(struct llc_sap *sap, struct sk_buff *skb)
 	return 0;
 }
 
+static int llc_prepare_and_xmit(struct sk_buff *skb)
+{
+	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
+	struct sk_buff *nskb;
+	int rc;
+
+	rc = llc_mac_hdr_init(skb, ev->saddr.mac, ev->daddr.mac);
+	if (rc)
+		return rc;
+
+	nskb = skb_clone(skb, GFP_ATOMIC);
+	if (!nskb)
+		return -ENOMEM;
+
+	if (skb->sk)
+		skb_set_owner_w(nskb, skb->sk);
+
+	return dev_queue_xmit(nskb);
+}
+
 /**
  *	llc_sap_action_send_ui - sends UI PDU resp to UNITDATA REQ to MAC layer
  *	@sap: SAP
@@ -52,17 +72,12 @@ int llc_sap_action_unitdata_ind(struct llc_sap *sap, struct sk_buff *skb)
 int llc_sap_action_send_ui(struct llc_sap *sap, struct sk_buff *skb)
 {
 	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
-	int rc;
 
 	llc_pdu_header_init(skb, LLC_PDU_TYPE_U, ev->saddr.lsap,
 			    ev->daddr.lsap, LLC_PDU_CMD);
 	llc_pdu_init_as_ui_cmd(skb);
-	rc = llc_mac_hdr_init(skb, ev->saddr.mac, ev->daddr.mac);
-	if (likely(!rc)) {
-		skb_get(skb);
-		rc = dev_queue_xmit(skb);
-	}
-	return rc;
+
+	return llc_prepare_and_xmit(skb);
 }
 
 /**
@@ -77,17 +92,12 @@ int llc_sap_action_send_ui(struct llc_sap *sap, struct sk_buff *skb)
 int llc_sap_action_send_xid_c(struct llc_sap *sap, struct sk_buff *skb)
 {
 	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
-	int rc;
 
 	llc_pdu_header_init(skb, LLC_PDU_TYPE_U_XID, ev->saddr.lsap,
 			    ev->daddr.lsap, LLC_PDU_CMD);
 	llc_pdu_init_as_xid_cmd(skb, LLC_XID_NULL_CLASS_2, 0);
-	rc = llc_mac_hdr_init(skb, ev->saddr.mac, ev->daddr.mac);
-	if (likely(!rc)) {
-		skb_get(skb);
-		rc = dev_queue_xmit(skb);
-	}
-	return rc;
+
+	return llc_prepare_and_xmit(skb);
 }
 
 /**
@@ -133,17 +143,12 @@ int llc_sap_action_send_xid_r(struct llc_sap *sap, struct sk_buff *skb)
 int llc_sap_action_send_test_c(struct llc_sap *sap, struct sk_buff *skb)
 {
 	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
-	int rc;
 
 	llc_pdu_header_init(skb, LLC_PDU_TYPE_U, ev->saddr.lsap,
 			    ev->daddr.lsap, LLC_PDU_CMD);
 	llc_pdu_init_as_test_cmd(skb);
-	rc = llc_mac_hdr_init(skb, ev->saddr.mac, ev->daddr.mac);
-	if (likely(!rc)) {
-		skb_get(skb);
-		rc = dev_queue_xmit(skb);
-	}
-	return rc;
+
+	return llc_prepare_and_xmit(skb);
 }
 
 int llc_sap_action_send_test_r(struct llc_sap *sap, struct sk_buff *skb)
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 7a0242e937d3..bfe0514efca3 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1751,6 +1751,7 @@ struct ieee802_11_elems {
 	const struct ieee80211_eht_operation *eht_operation;
 	const struct ieee80211_multi_link_elem *ml_basic;
 	const struct ieee80211_multi_link_elem *ml_reconf;
+	const struct ieee80211_multi_link_elem *ml_epcs;
 	const struct ieee80211_bandwidth_indication *bandwidth_indication;
 	const struct ieee80211_ttlm_elem *ttlm[IEEE80211_TTLM_MAX_CNT];
 
@@ -1781,6 +1782,7 @@ struct ieee802_11_elems {
 	/* mult-link element can be de-fragmented and thus u8 is not sufficient */
 	size_t ml_basic_len;
 	size_t ml_reconf_len;
+	size_t ml_epcs_len;
 
 	u8 ttlm_num;
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 111066928b96..88751b0eb317 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4733,6 +4733,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		parse_params.start = bss_ies->data;
 		parse_params.len = bss_ies->len;
 		parse_params.bss = cbss;
+		parse_params.link_id = -1;
 		bss_elems = ieee802_11_parse_elems_full(&parse_params);
 		if (!bss_elems) {
 			ret = false;
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 279c5143b335..6da39c864f45 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -44,6 +44,12 @@ struct ieee80211_elems_parse {
 	/* The reconfiguration Multi-Link element in the original elements */
 	const struct element *ml_reconf_elem;
 
+	/* The EPCS Multi-Link element in the original elements */
+	const struct element *ml_epcs_elem;
+
+	bool multi_link_inner;
+	bool skip_vendor;
+
 	/*
 	 * scratch buffer that can be used for various element parsing related
 	 * tasks, e.g., element de-fragmentation etc.
@@ -149,16 +155,18 @@ ieee80211_parse_extension_element(u32 *crc,
 			switch (le16_get_bits(mle->control,
 					      IEEE80211_ML_CONTROL_TYPE)) {
 			case IEEE80211_ML_CONTROL_TYPE_BASIC:
-				if (elems_parse->ml_basic_elem) {
+				if (elems_parse->multi_link_inner) {
 					elems->parse_error |=
 						IEEE80211_PARSE_ERR_DUP_NEST_ML_BASIC;
 					break;
 				}
-				elems_parse->ml_basic_elem = elem;
 				break;
 			case IEEE80211_ML_CONTROL_TYPE_RECONF:
 				elems_parse->ml_reconf_elem = elem;
 				break;
+			case IEEE80211_ML_CONTROL_TYPE_PRIO_ACCESS:
+				elems_parse->ml_epcs_elem = elem;
+				break;
 			default:
 				break;
 			}
@@ -393,6 +401,9 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 			break;
 		case WLAN_EID_VENDOR_SPECIFIC:
+			if (elems_parse->skip_vendor)
+				break;
+
 			if (elen >= 4 && pos[0] == 0x00 && pos[1] == 0x50 &&
 			    pos[2] == 0xf2) {
 				/* Microsoft OUI (00:50:F2) */
@@ -860,21 +871,36 @@ ieee80211_mle_get_sta_prof(struct ieee80211_elems_parse *elems_parse,
 	}
 }
 
-static void ieee80211_mle_parse_link(struct ieee80211_elems_parse *elems_parse,
-				     struct ieee80211_elems_parse_params *params)
+static const struct element *
+ieee80211_prep_mle_link_parse(struct ieee80211_elems_parse *elems_parse,
+			      struct ieee80211_elems_parse_params *params,
+			      struct ieee80211_elems_parse_params *sub)
 {
 	struct ieee802_11_elems *elems = &elems_parse->elems;
 	struct ieee80211_mle_per_sta_profile *prof;
-	struct ieee80211_elems_parse_params sub = {
-		.mode = params->mode,
-		.action = params->action,
-		.from_ap = params->from_ap,
-		.link_id = -1,
-	};
-	ssize_t ml_len = elems->ml_basic_len;
-	const struct element *non_inherit = NULL;
+	const struct element *tmp;
+	ssize_t ml_len;
 	const u8 *end;
 
+	if (params->mode < IEEE80211_CONN_MODE_EHT)
+		return NULL;
+
+	for_each_element_extid(tmp, WLAN_EID_EXT_EHT_MULTI_LINK,
+			       elems->ie_start, elems->total_len) {
+		const struct ieee80211_multi_link_elem *mle =
+			(void *)tmp->data + 1;
+
+		if (!ieee80211_mle_size_ok(tmp->data + 1, tmp->datalen - 1))
+			continue;
+
+		if (le16_get_bits(mle->control, IEEE80211_ML_CONTROL_TYPE) !=
+		    IEEE80211_ML_CONTROL_TYPE_BASIC)
+			continue;
+
+		elems_parse->ml_basic_elem = tmp;
+		break;
+	}
+
 	ml_len = cfg80211_defragment_element(elems_parse->ml_basic_elem,
 					     elems->ie_start,
 					     elems->total_len,
@@ -885,26 +911,26 @@ static void ieee80211_mle_parse_link(struct ieee80211_elems_parse *elems_parse,
 					     WLAN_EID_FRAGMENT);
 
 	if (ml_len < 0)
-		return;
+		return NULL;
 
 	elems->ml_basic = (const void *)elems_parse->scratch_pos;
 	elems->ml_basic_len = ml_len;
 	elems_parse->scratch_pos += ml_len;
 
 	if (params->link_id == -1)
-		return;
+		return NULL;
 
 	ieee80211_mle_get_sta_prof(elems_parse, params->link_id);
 	prof = elems->prof;
 
 	if (!prof)
-		return;
+		return NULL;
 
 	/* check if we have the 4 bytes for the fixed part in assoc response */
 	if (elems->sta_prof_len < sizeof(*prof) + prof->sta_info_len - 1 + 4) {
 		elems->prof = NULL;
 		elems->sta_prof_len = 0;
-		return;
+		return NULL;
 	}
 
 	/*
@@ -913,13 +939,17 @@ static void ieee80211_mle_parse_link(struct ieee80211_elems_parse *elems_parse,
 	 * the -1 is because the 'sta_info_len' is accounted to as part of the
 	 * per-STA profile, but not part of the 'u8 variable[]' portion.
 	 */
-	sub.start = prof->variable + prof->sta_info_len - 1 + 4;
+	sub->start = prof->variable + prof->sta_info_len - 1 + 4;
 	end = (const u8 *)prof + elems->sta_prof_len;
-	sub.len = end - sub.start;
+	sub->len = end - sub->start;
+
+	sub->mode = params->mode;
+	sub->action = params->action;
+	sub->from_ap = params->from_ap;
+	sub->link_id = -1;
 
-	non_inherit = cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
-					     sub.start, sub.len);
-	_ieee802_11_parse_elems_full(&sub, elems_parse, non_inherit);
+	return cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
+				      sub->start, sub->len);
 }
 
 static void
@@ -943,18 +973,43 @@ ieee80211_mle_defrag_reconf(struct ieee80211_elems_parse *elems_parse)
 	elems_parse->scratch_pos += ml_len;
 }
 
+static void
+ieee80211_mle_defrag_epcs(struct ieee80211_elems_parse *elems_parse)
+{
+	struct ieee802_11_elems *elems = &elems_parse->elems;
+	ssize_t ml_len;
+
+	ml_len = cfg80211_defragment_element(elems_parse->ml_epcs_elem,
+					     elems->ie_start,
+					     elems->total_len,
+					     elems_parse->scratch_pos,
+					     elems_parse->scratch +
+						elems_parse->scratch_len -
+						elems_parse->scratch_pos,
+					     WLAN_EID_FRAGMENT);
+	if (ml_len < 0)
+		return;
+	elems->ml_epcs = (void *)elems_parse->scratch_pos;
+	elems->ml_epcs_len = ml_len;
+	elems_parse->scratch_pos += ml_len;
+}
+
 struct ieee802_11_elems *
 ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 {
+	struct ieee80211_elems_parse_params sub = {};
 	struct ieee80211_elems_parse *elems_parse;
-	struct ieee802_11_elems *elems;
 	const struct element *non_inherit = NULL;
-	u8 *nontransmitted_profile;
-	int nontransmitted_profile_len = 0;
+	struct ieee802_11_elems *elems;
 	size_t scratch_len = 3 * params->len;
+	bool multi_link_inner = false;
 
 	BUILD_BUG_ON(offsetof(typeof(*elems_parse), elems) != 0);
 
+	/* cannot parse for both a specific link and non-transmitted BSS */
+	if (WARN_ON(params->link_id >= 0 && params->bss))
+		return NULL;
+
 	elems_parse = kzalloc(struct_size(elems_parse, scratch, scratch_len),
 			      GFP_ATOMIC);
 	if (!elems_parse)
@@ -971,36 +1026,55 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 	ieee80211_clear_tpe(&elems->tpe);
 	ieee80211_clear_tpe(&elems->csa_tpe);
 
-	nontransmitted_profile = elems_parse->scratch_pos;
-	nontransmitted_profile_len =
-		ieee802_11_find_bssid_profile(params->start, params->len,
-					      elems, params->bss,
-					      nontransmitted_profile);
-	elems_parse->scratch_pos += nontransmitted_profile_len;
-	non_inherit = cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
-					     nontransmitted_profile,
-					     nontransmitted_profile_len);
+	/*
+	 * If we're looking for a non-transmitted BSS then we cannot at
+	 * the same time be looking for a second link as the two can only
+	 * appear in the same frame carrying info for different BSSes.
+	 *
+	 * In any case, we only look for one at a time, as encoded by
+	 * the WARN_ON above.
+	 */
+	if (params->bss) {
+		int nontx_len =
+			ieee802_11_find_bssid_profile(params->start,
+						      params->len,
+						      elems, params->bss,
+						      elems_parse->scratch_pos);
+		sub.start = elems_parse->scratch_pos;
+		sub.mode = params->mode;
+		sub.len = nontx_len;
+		sub.action = params->action;
+		sub.link_id = params->link_id;
+
+		/* consume the space used for non-transmitted profile */
+		elems_parse->scratch_pos += nontx_len;
+
+		non_inherit = cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
+						     sub.start, nontx_len);
+	} else {
+		/* must always parse to get elems_parse->ml_basic_elem */
+		non_inherit = ieee80211_prep_mle_link_parse(elems_parse, params,
+							    &sub);
+		multi_link_inner = true;
+	}
 
+	elems_parse->skip_vendor =
+		cfg80211_find_elem(WLAN_EID_VENDOR_SPECIFIC,
+				   sub.start, sub.len);
 	elems->crc = _ieee802_11_parse_elems_full(params, elems_parse,
 						  non_inherit);
 
-	/* Override with nontransmitted profile, if found */
-	if (nontransmitted_profile_len) {
-		struct ieee80211_elems_parse_params sub = {
-			.mode = params->mode,
-			.start = nontransmitted_profile,
-			.len = nontransmitted_profile_len,
-			.action = params->action,
-			.link_id = params->link_id,
-		};
-
+	/* Override with nontransmitted/per-STA profile if found */
+	if (sub.len) {
+		elems_parse->multi_link_inner = multi_link_inner;
+		elems_parse->skip_vendor = false;
 		_ieee802_11_parse_elems_full(&sub, elems_parse, NULL);
 	}
 
-	ieee80211_mle_parse_link(elems_parse, params);
-
 	ieee80211_mle_defrag_reconf(elems_parse);
 
+	ieee80211_mle_defrag_epcs(elems_parse);
+
 	if (elems->tim && !elems->parse_error) {
 		const struct ieee80211_tim_ie *tim_ie = elems->tim;
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b4ba2d9f0417..2a085ec5bfd0 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -968,7 +968,7 @@ static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
 
 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 					     struct mptcp_pm_addr_entry *entry,
-					     bool needs_id)
+					     bool needs_id, bool replace)
 {
 	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
 	unsigned int addr_max;
@@ -1008,6 +1008,17 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 			if (entry->addr.id)
 				goto out;
 
+			/* allow callers that only need to look up the local
+			 * addr's id to skip replacement. This allows them to
+			 * avoid calling synchronize_rcu in the packet recv
+			 * path.
+			 */
+			if (!replace) {
+				kfree(entry);
+				ret = cur->addr.id;
+				goto out;
+			}
+
 			pernet->addrs--;
 			entry->addr.id = cur->addr.id;
 			list_del_rcu(&cur->list);
@@ -1160,7 +1171,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	entry->ifindex = 0;
 	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 	entry->lsk = NULL;
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true, false);
 	if (ret < 0)
 		kfree(entry);
 
@@ -1432,7 +1443,8 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
-						!mptcp_pm_has_addr_attr_id(attr, info));
+						!mptcp_pm_has_addr_attr_id(attr, info),
+						true);
 	if (ret < 0) {
 		GENL_SET_ERR_MSG_FMT(info, "too many addresses or duplicate one: %d", ret);
 		goto out_free;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 1e78f575fb56..ecfceddce00f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4218,6 +4218,11 @@ static int parse_monitor_flags(struct nlattr *nla, u32 *mntrflags)
 		if (flags[flag])
 			*mntrflags |= (1<<flag);
 
+	/* cooked monitor mode is incompatible with other modes */
+	if (*mntrflags & MONITOR_FLAG_COOK_FRAMES &&
+	    *mntrflags != MONITOR_FLAG_COOK_FRAMES)
+		return -EOPNOTSUPP;
+
 	*mntrflags |= MONITOR_FLAG_CHANGED;
 
 	return 0;
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 6489ba943a63..2b626078739c 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -407,7 +407,8 @@ static bool is_an_alpha2(const char *alpha2)
 {
 	if (!alpha2)
 		return false;
-	return isalpha(alpha2[0]) && isalpha(alpha2[1]);
+	return isascii(alpha2[0]) && isalpha(alpha2[0]) &&
+	       isascii(alpha2[1]) && isalpha(alpha2[1]);
 }
 
 static bool alpha2_equal(const char *alpha2_x, const char *alpha2_y)
diff --git a/rust/Makefile b/rust/Makefile
index 45779a064fa4..09521fc449dc 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -3,7 +3,7 @@
 # Where to place rustdoc generated documentation
 rustdoc_output := $(objtree)/Documentation/output/rust/rustdoc
 
-obj-$(CONFIG_RUST) += core.o compiler_builtins.o
+obj-$(CONFIG_RUST) += core.o compiler_builtins.o ffi.o
 always-$(CONFIG_RUST) += exports_core_generated.h
 
 # Missing prototypes are expected in the helpers since these are exported
@@ -15,8 +15,8 @@ always-$(CONFIG_RUST) += libmacros.so
 no-clean-files += libmacros.so
 
 always-$(CONFIG_RUST) += bindings/bindings_generated.rs bindings/bindings_helpers_generated.rs
-obj-$(CONFIG_RUST) += alloc.o bindings.o kernel.o
-always-$(CONFIG_RUST) += exports_alloc_generated.h exports_helpers_generated.h \
+obj-$(CONFIG_RUST) += bindings.o kernel.o
+always-$(CONFIG_RUST) += exports_helpers_generated.h \
     exports_bindings_generated.h exports_kernel_generated.h
 
 always-$(CONFIG_RUST) += uapi/uapi_generated.rs
@@ -53,15 +53,10 @@ endif
 core-cfgs = \
     --cfg no_fp_fmt_parse
 
-alloc-cfgs = \
-    --cfg no_global_oom_handling \
-    --cfg no_rc \
-    --cfg no_sync
-
 quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
       cmd_rustdoc = \
 	OBJTREE=$(abspath $(objtree)) \
-	$(RUSTDOC) $(if $(rustdoc_host),$(rust_common_flags),$(rust_flags)) \
+	$(RUSTDOC) $(filter-out $(skip_flags),$(if $(rustdoc_host),$(rust_common_flags),$(rust_flags))) \
 		$(rustc_target_flags) -L$(objtree)/$(obj) \
 		-Zunstable-options --generate-link-to-definition \
 		--output $(rustdoc_output) \
@@ -81,7 +76,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
 # command-like flags to solve the issue. Meanwhile, we use the non-custom case
 # and then retouch the generated files.
 rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins \
-    rustdoc-alloc rustdoc-kernel
+    rustdoc-kernel
 	$(Q)cp $(srctree)/Documentation/images/logo.svg $(rustdoc_output)/static.files/
 	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(rustdoc_output)/static.files/
 	$(Q)find $(rustdoc_output) -name '*.html' -type f -print0 | xargs -0 sed -Ei \
@@ -98,6 +93,9 @@ rustdoc-macros: private rustc_target_flags = --crate-type proc-macro \
 rustdoc-macros: $(src)/macros/lib.rs FORCE
 	+$(call if_changed,rustdoc)
 
+# Starting with Rust 1.82.0, skipping `-Wrustdoc::unescaped_backticks` should
+# not be needed -- see https://github.com/rust-lang/rust/pull/128307.
+rustdoc-core: private skip_flags = -Wrustdoc::unescaped_backticks
 rustdoc-core: private rustc_target_flags = $(core-cfgs)
 rustdoc-core: $(RUST_LIB_SRC)/core/src/lib.rs FORCE
 	+$(call if_changed,rustdoc)
@@ -105,20 +103,14 @@ rustdoc-core: $(RUST_LIB_SRC)/core/src/lib.rs FORCE
 rustdoc-compiler_builtins: $(src)/compiler_builtins.rs rustdoc-core FORCE
 	+$(call if_changed,rustdoc)
 
-# We need to allow `rustdoc::broken_intra_doc_links` because some
-# `no_global_oom_handling` functions refer to non-`no_global_oom_handling`
-# functions. Ideally `rustdoc` would have a way to distinguish broken links
-# due to things that are "configured out" vs. entirely non-existing ones.
-rustdoc-alloc: private rustc_target_flags = $(alloc-cfgs) \
-    -Arustdoc::broken_intra_doc_links
-rustdoc-alloc: $(RUST_LIB_SRC)/alloc/src/lib.rs rustdoc-core rustdoc-compiler_builtins FORCE
+rustdoc-ffi: $(src)/ffi.rs rustdoc-core FORCE
 	+$(call if_changed,rustdoc)
 
-rustdoc-kernel: private rustc_target_flags = --extern alloc \
+rustdoc-kernel: private rustc_target_flags = --extern ffi \
     --extern build_error --extern macros=$(objtree)/$(obj)/libmacros.so \
     --extern bindings --extern uapi
-rustdoc-kernel: $(src)/kernel/lib.rs rustdoc-core rustdoc-macros \
-    rustdoc-compiler_builtins rustdoc-alloc $(obj)/libmacros.so \
+rustdoc-kernel: $(src)/kernel/lib.rs rustdoc-core rustdoc-ffi rustdoc-macros \
+    rustdoc-compiler_builtins $(obj)/libmacros.so \
     $(obj)/bindings.o FORCE
 	+$(call if_changed,rustdoc)
 
@@ -135,15 +127,28 @@ quiet_cmd_rustc_test_library = RUSTC TL $<
 rusttestlib-build_error: $(src)/build_error.rs FORCE
 	+$(call if_changed,rustc_test_library)
 
+rusttestlib-ffi: $(src)/ffi.rs FORCE
+	+$(call if_changed,rustc_test_library)
+
 rusttestlib-macros: private rustc_target_flags = --extern proc_macro
 rusttestlib-macros: private rustc_test_library_proc = yes
 rusttestlib-macros: $(src)/macros/lib.rs FORCE
 	+$(call if_changed,rustc_test_library)
 
-rusttestlib-bindings: $(src)/bindings/lib.rs FORCE
+rusttestlib-kernel: private rustc_target_flags = --extern ffi \
+    --extern build_error --extern macros \
+    --extern bindings --extern uapi
+rusttestlib-kernel: $(src)/kernel/lib.rs \
+    rusttestlib-bindings rusttestlib-uapi rusttestlib-build_error \
+    $(obj)/libmacros.so $(obj)/bindings.o FORCE
+	+$(call if_changed,rustc_test_library)
+
+rusttestlib-bindings: private rustc_target_flags = --extern ffi
+rusttestlib-bindings: $(src)/bindings/lib.rs rusttestlib-ffi FORCE
 	+$(call if_changed,rustc_test_library)
 
-rusttestlib-uapi: $(src)/uapi/lib.rs FORCE
+rusttestlib-uapi: private rustc_target_flags = --extern ffi
+rusttestlib-uapi: $(src)/uapi/lib.rs rusttestlib-ffi FORCE
 	+$(call if_changed,rustc_test_library)
 
 quiet_cmd_rustdoc_test = RUSTDOC T $<
@@ -162,7 +167,7 @@ quiet_cmd_rustdoc_test_kernel = RUSTDOC TK $<
 	mkdir -p $(objtree)/$(obj)/test/doctests/kernel; \
 	OBJTREE=$(abspath $(objtree)) \
 	$(RUSTDOC) --test $(rust_flags) \
-		-L$(objtree)/$(obj) --extern alloc --extern kernel \
+		-L$(objtree)/$(obj) --extern ffi --extern kernel \
 		--extern build_error --extern macros \
 		--extern bindings --extern uapi \
 		--no-run --crate-name kernel -Zunstable-options \
@@ -192,19 +197,20 @@ quiet_cmd_rustc_test = RUSTC T  $<
 
 rusttest: rusttest-macros rusttest-kernel
 
-rusttest-macros: private rustc_target_flags = --extern proc_macro
+rusttest-macros: private rustc_target_flags = --extern proc_macro \
+	--extern macros --extern kernel
 rusttest-macros: private rustdoc_test_target_flags = --crate-type proc-macro
-rusttest-macros: $(src)/macros/lib.rs FORCE
+rusttest-macros: $(src)/macros/lib.rs \
+    rusttestlib-macros rusttestlib-kernel FORCE
 	+$(call if_changed,rustc_test)
 	+$(call if_changed,rustdoc_test)
 
-rusttest-kernel: private rustc_target_flags = --extern alloc \
+rusttest-kernel: private rustc_target_flags = --extern ffi \
     --extern build_error --extern macros --extern bindings --extern uapi
-rusttest-kernel: $(src)/kernel/lib.rs \
+rusttest-kernel: $(src)/kernel/lib.rs rusttestlib-ffi rusttestlib-kernel \
     rusttestlib-build_error rusttestlib-macros rusttestlib-bindings \
     rusttestlib-uapi FORCE
 	+$(call if_changed,rustc_test)
-	+$(call if_changed,rustc_test_library)
 
 ifdef CONFIG_CC_IS_CLANG
 bindgen_c_flags = $(c_flags)
@@ -266,7 +272,11 @@ else
 bindgen_c_flags_lto = $(bindgen_c_flags)
 endif
 
-bindgen_c_flags_final = $(bindgen_c_flags_lto) -D__BINDGEN__
+# `-fno-builtin` is passed to avoid `bindgen` from using `clang` builtin
+# prototypes for functions like `memcpy` -- if this flag is not passed,
+# `bindgen`-generated prototypes use `c_ulong` or `c_uint` depending on
+# architecture instead of generating `usize`.
+bindgen_c_flags_final = $(bindgen_c_flags_lto) -fno-builtin -D__BINDGEN__
 
 # Each `bindgen` release may upgrade the list of Rust target versions. By
 # default, the highest stable release in their list is used. Thus we need to set
@@ -284,7 +294,7 @@ bindgen_c_flags_final = $(bindgen_c_flags_lto) -D__BINDGEN__
 quiet_cmd_bindgen = BINDGEN $@
       cmd_bindgen = \
 	$(BINDGEN) $< $(bindgen_target_flags) --rust-target 1.68 \
-		--use-core --with-derive-default --ctypes-prefix core::ffi --no-layout-tests \
+		--use-core --with-derive-default --ctypes-prefix ffi --no-layout-tests \
 		--no-debug '.*' --enable-function-attribute-detection \
 		-o $@ -- $(bindgen_c_flags_final) -DMODULE \
 		$(bindgen_target_cflags) $(bindgen_target_extra)
@@ -325,9 +335,6 @@ quiet_cmd_exports = EXPORTS $@
 $(obj)/exports_core_generated.h: $(obj)/core.o FORCE
 	$(call if_changed,exports)
 
-$(obj)/exports_alloc_generated.h: $(obj)/alloc.o FORCE
-	$(call if_changed,exports)
-
 # Even though Rust kernel modules should never use the bindings directly,
 # symbols from the `bindings` crate and the C helpers need to be exported
 # because Rust generics and inlined functions may not get their code generated
@@ -374,7 +381,7 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
 
 rust-analyzer:
 	$(Q)$(srctree)/scripts/generate_rust_analyzer.py \
-		--cfgs='core=$(core-cfgs)' --cfgs='alloc=$(alloc-cfgs)' \
+		--cfgs='core=$(core-cfgs)' \
 		$(realpath $(srctree)) $(realpath $(objtree)) \
 		$(rustc_sysroot) $(RUST_LIB_SRC) $(KBUILD_EXTMOD) > \
 		$(if $(KBUILD_EXTMOD),$(extmod_prefix),$(objtree))/rust-project.json
@@ -412,29 +419,28 @@ $(obj)/compiler_builtins.o: private rustc_objcopy = -w -W '__*'
 $(obj)/compiler_builtins.o: $(src)/compiler_builtins.rs $(obj)/core.o FORCE
 	+$(call if_changed_rule,rustc_library)
 
-$(obj)/alloc.o: private skip_clippy = 1
-$(obj)/alloc.o: private skip_flags = -Wunreachable_pub
-$(obj)/alloc.o: private rustc_target_flags = $(alloc-cfgs)
-$(obj)/alloc.o: $(RUST_LIB_SRC)/alloc/src/lib.rs $(obj)/compiler_builtins.o FORCE
+$(obj)/build_error.o: $(src)/build_error.rs $(obj)/compiler_builtins.o FORCE
 	+$(call if_changed_rule,rustc_library)
 
-$(obj)/build_error.o: $(src)/build_error.rs $(obj)/compiler_builtins.o FORCE
+$(obj)/ffi.o: $(src)/ffi.rs $(obj)/compiler_builtins.o FORCE
 	+$(call if_changed_rule,rustc_library)
 
+$(obj)/bindings.o: private rustc_target_flags = --extern ffi
 $(obj)/bindings.o: $(src)/bindings/lib.rs \
-    $(obj)/compiler_builtins.o \
+    $(obj)/ffi.o \
     $(obj)/bindings/bindings_generated.rs \
     $(obj)/bindings/bindings_helpers_generated.rs FORCE
 	+$(call if_changed_rule,rustc_library)
 
+$(obj)/uapi.o: private rustc_target_flags = --extern ffi
 $(obj)/uapi.o: $(src)/uapi/lib.rs \
-    $(obj)/compiler_builtins.o \
+    $(obj)/ffi.o \
     $(obj)/uapi/uapi_generated.rs FORCE
 	+$(call if_changed_rule,rustc_library)
 
-$(obj)/kernel.o: private rustc_target_flags = --extern alloc \
+$(obj)/kernel.o: private rustc_target_flags = --extern ffi \
     --extern build_error --extern macros --extern bindings --extern uapi
-$(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/alloc.o $(obj)/build_error.o \
+$(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/build_error.o \
     $(obj)/libmacros.so $(obj)/bindings.o $(obj)/uapi.o FORCE
 	+$(call if_changed_rule,rustc_library)
 
diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index b7c7483123b7..0f96af8b9a7f 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -1,5 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 
+# We want to map these types to `isize`/`usize` manually, instead of
+# define them as `int`/`long` depending on platform bitwidth.
+--blocklist-type __kernel_s?size_t
+--blocklist-type __kernel_ptrdiff_t
+
 --opaque-type xregs_state
 --opaque-type desc_struct
 --opaque-type arch_lbr_state
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ae82e9c941af..a80783fcbe04 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -31,4 +31,5 @@ const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT = GFP_KERNEL_ACCOUNT;
 const gfp_t RUST_CONST_HELPER_GFP_NOWAIT = GFP_NOWAIT;
 const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
 const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM = ___GFP_HIGHMEM;
+const gfp_t RUST_CONST_HELPER___GFP_NOWARN = ___GFP_NOWARN;
 const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL = BLK_FEAT_ROTATIONAL;
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 93a1a3fc97bc..014af0d1fc70 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -25,7 +25,13 @@
 )]
 
 #[allow(dead_code)]
+#[allow(clippy::undocumented_unsafe_blocks)]
 mod bindings_raw {
+    // Manual definition for blocklisted types.
+    type __kernel_size_t = usize;
+    type __kernel_ssize_t = isize;
+    type __kernel_ptrdiff_t = isize;
+
     // Use glob import here to expose all helpers.
     // Symbols defined within the module will take precedence to the glob import.
     pub use super::bindings_helper::*;
diff --git a/rust/exports.c b/rust/exports.c
index e5695f3b45b7..82a037381798 100644
--- a/rust/exports.c
+++ b/rust/exports.c
@@ -16,7 +16,6 @@
 #define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(sym)
 
 #include "exports_core_generated.h"
-#include "exports_alloc_generated.h"
 #include "exports_helpers_generated.h"
 #include "exports_bindings_generated.h"
 #include "exports_kernel_generated.h"
diff --git a/rust/ffi.rs b/rust/ffi.rs
new file mode 100644
index 000000000000..584f75b49862
--- /dev/null
+++ b/rust/ffi.rs
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Foreign function interface (FFI) types.
+//!
+//! This crate provides mapping from C primitive types to Rust ones.
+//!
+//! The Rust [`core`] crate provides [`core::ffi`], which maps integer types to the platform default
+//! C ABI. The kernel does not use [`core::ffi`], so it can customise the mapping that deviates from
+//! the platform default.
+
+#![no_std]
+
+macro_rules! alias {
+    ($($name:ident = $ty:ty;)*) => {$(
+        #[allow(non_camel_case_types, missing_docs)]
+        pub type $name = $ty;
+
+        // Check size compatibility with `core`.
+        const _: () = assert!(
+            core::mem::size_of::<$name>() == core::mem::size_of::<core::ffi::$name>()
+        );
+    )*}
+}
+
+alias! {
+    // `core::ffi::c_char` is either `i8` or `u8` depending on architecture. In the kernel, we use
+    // `-funsigned-char` so it's always mapped to `u8`.
+    c_char = u8;
+
+    c_schar = i8;
+    c_uchar = u8;
+
+    c_short = i16;
+    c_ushort = u16;
+
+    c_int = i32;
+    c_uint = u32;
+
+    // In the kernel, `intptr_t` is defined to be `long` in all platforms, so we can map the type to
+    // `isize`.
+    c_long = isize;
+    c_ulong = usize;
+
+    c_longlong = i64;
+    c_ulonglong = u64;
+}
+
+pub use core::ffi::c_void;
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 30f40149f3a9..20a0c69d5cc7 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -22,5 +22,6 @@
 #include "spinlock.c"
 #include "task.c"
 #include "uaccess.c"
+#include "vmalloc.c"
 #include "wait.c"
 #include "workqueue.c"
diff --git a/rust/helpers/slab.c b/rust/helpers/slab.c
index f043e087f9d6..a842bfbddcba 100644
--- a/rust/helpers/slab.c
+++ b/rust/helpers/slab.c
@@ -7,3 +7,9 @@ rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
 {
 	return krealloc(objp, new_size, flags);
 }
+
+void * __must_check __realloc_size(2)
+rust_helper_kvrealloc(const void *p, size_t size, gfp_t flags)
+{
+	return kvrealloc(p, size, flags);
+}
diff --git a/rust/helpers/vmalloc.c b/rust/helpers/vmalloc.c
new file mode 100644
index 000000000000..80d34501bbc0
--- /dev/null
+++ b/rust/helpers/vmalloc.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/vmalloc.h>
+
+void * __must_check __realloc_size(2)
+rust_helper_vrealloc(const void *p, size_t size, gfp_t flags)
+{
+	return vrealloc(p, size, flags);
+}
diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 1966bd407017..f2f7f3a53d29 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -1,23 +1,41 @@
 // SPDX-License-Identifier: GPL-2.0
 
-//! Extensions to the [`alloc`] crate.
+//! Implementation of the kernel's memory allocation infrastructure.
 
-#[cfg(not(test))]
-#[cfg(not(testlib))]
-mod allocator;
-pub mod box_ext;
-pub mod vec_ext;
+#[cfg(not(any(test, testlib)))]
+pub mod allocator;
+pub mod kbox;
+pub mod kvec;
+pub mod layout;
+
+#[cfg(any(test, testlib))]
+pub mod allocator_test;
+
+#[cfg(any(test, testlib))]
+pub use self::allocator_test as allocator;
+
+pub use self::kbox::Box;
+pub use self::kbox::KBox;
+pub use self::kbox::KVBox;
+pub use self::kbox::VBox;
+
+pub use self::kvec::IntoIter;
+pub use self::kvec::KVVec;
+pub use self::kvec::KVec;
+pub use self::kvec::VVec;
+pub use self::kvec::Vec;
 
 /// Indicates an allocation error.
 #[derive(Copy, Clone, PartialEq, Eq, Debug)]
 pub struct AllocError;
+use core::{alloc::Layout, ptr::NonNull};
 
 /// Flags to be used when allocating memory.
 ///
 /// They can be combined with the operators `|`, `&`, and `!`.
 ///
 /// Values can be used from the [`flags`] module.
-#[derive(Clone, Copy)]
+#[derive(Clone, Copy, PartialEq)]
 pub struct Flags(u32);
 
 impl Flags {
@@ -25,6 +43,11 @@ impl Flags {
     pub(crate) fn as_raw(self) -> u32 {
         self.0
     }
+
+    /// Check whether `flags` is contained in `self`.
+    pub fn contains(self, flags: Flags) -> bool {
+        (self & flags) == flags
+    }
 }
 
 impl core::ops::BitOr for Flags {
@@ -85,4 +108,117 @@ pub mod flags {
     /// use any filesystem callback.  It is very likely to fail to allocate memory, even for very
     /// small allocations.
     pub const GFP_NOWAIT: Flags = Flags(bindings::GFP_NOWAIT);
+
+    /// Suppresses allocation failure reports.
+    ///
+    /// This is normally or'd with other flags.
+    pub const __GFP_NOWARN: Flags = Flags(bindings::__GFP_NOWARN);
+}
+
+/// The kernel's [`Allocator`] trait.
+///
+/// An implementation of [`Allocator`] can allocate, re-allocate and free memory buffers described
+/// via [`Layout`].
+///
+/// [`Allocator`] is designed to be implemented as a ZST; [`Allocator`] functions do not operate on
+/// an object instance.
+///
+/// In order to be able to support `#[derive(SmartPointer)]` later on, we need to avoid a design
+/// that requires an `Allocator` to be instantiated, hence its functions must not contain any kind
+/// of `self` parameter.
+///
+/// # Safety
+///
+/// - A memory allocation returned from an allocator must remain valid until it is explicitly freed.
+///
+/// - Any pointer to a valid memory allocation must be valid to be passed to any other [`Allocator`]
+///   function of the same type.
+///
+/// - Implementers must ensure that all trait functions abide by the guarantees documented in the
+///   `# Guarantees` sections.
+pub unsafe trait Allocator {
+    /// Allocate memory based on `layout` and `flags`.
+    ///
+    /// On success, returns a buffer represented as `NonNull<[u8]>` that satisfies the layout
+    /// constraints (i.e. minimum size and alignment as specified by `layout`).
+    ///
+    /// This function is equivalent to `realloc` when called with `None`.
+    ///
+    /// # Guarantees
+    ///
+    /// When the return value is `Ok(ptr)`, then `ptr` is
+    /// - valid for reads and writes for `layout.size()` bytes, until it is passed to
+    ///   [`Allocator::free`] or [`Allocator::realloc`],
+    /// - aligned to `layout.align()`,
+    ///
+    /// Additionally, `Flags` are honored as documented in
+    /// <https://docs.kernel.org/core-api/mm-api.html#mm-api-gfp-flags>.
+    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, AllocError> {
+        // SAFETY: Passing `None` to `realloc` is valid by its safety requirements and asks for a
+        // new memory allocation.
+        unsafe { Self::realloc(None, layout, Layout::new::<()>(), flags) }
+    }
+
+    /// Re-allocate an existing memory allocation to satisfy the requested `layout`.
+    ///
+    /// If the requested size is zero, `realloc` behaves equivalent to `free`.
+    ///
+    /// If the requested size is larger than the size of the existing allocation, a successful call
+    /// to `realloc` guarantees that the new or grown buffer has at least `Layout::size` bytes, but
+    /// may also be larger.
+    ///
+    /// If the requested size is smaller than the size of the existing allocation, `realloc` may or
+    /// may not shrink the buffer; this is implementation specific to the allocator.
+    ///
+    /// On allocation failure, the existing buffer, if any, remains valid.
+    ///
+    /// The buffer is represented as `NonNull<[u8]>`.
+    ///
+    /// # Safety
+    ///
+    /// - If `ptr == Some(p)`, then `p` must point to an existing and valid memory allocation
+    ///   created by this [`Allocator`]; if `old_layout` is zero-sized `p` does not need to be a
+    ///   pointer returned by this [`Allocator`].
+    /// - `ptr` is allowed to be `None`; in this case a new memory allocation is created and
+    ///   `old_layout` is ignored.
+    /// - `old_layout` must match the `Layout` the allocation has been created with.
+    ///
+    /// # Guarantees
+    ///
+    /// This function has the same guarantees as [`Allocator::alloc`]. When `ptr == Some(p)`, then
+    /// it additionally guarantees that:
+    /// - the contents of the memory pointed to by `p` are preserved up to the lesser of the new
+    ///   and old size, i.e. `ret_ptr[0..min(layout.size(), old_layout.size())] ==
+    ///   p[0..min(layout.size(), old_layout.size())]`.
+    /// - when the return value is `Err(AllocError)`, then `ptr` is still valid.
+    unsafe fn realloc(
+        ptr: Option<NonNull<u8>>,
+        layout: Layout,
+        old_layout: Layout,
+        flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError>;
+
+    /// Free an existing memory allocation.
+    ///
+    /// # Safety
+    ///
+    /// - `ptr` must point to an existing and valid memory allocation created by this [`Allocator`];
+    ///   if `old_layout` is zero-sized `p` does not need to be a pointer returned by this
+    ///   [`Allocator`].
+    /// - `layout` must match the `Layout` the allocation has been created with.
+    /// - The memory allocation at `ptr` must never again be read from or written to.
+    unsafe fn free(ptr: NonNull<u8>, layout: Layout) {
+        // SAFETY: The caller guarantees that `ptr` points at a valid allocation created by this
+        // allocator. We are passing a `Layout` with the smallest possible alignment, so it is
+        // smaller than or equal to the alignment previously used with this allocation.
+        let _ = unsafe { Self::realloc(Some(ptr), Layout::new::<()>(), layout, Flags(0)) };
+    }
+}
+
+/// Returns a properly aligned dangling pointer from the given `layout`.
+pub(crate) fn dangling_from_layout(layout: Layout) -> NonNull<u8> {
+    let ptr = layout.align() as *mut u8;
+
+    // SAFETY: `layout.align()` (and hence `ptr`) is guaranteed to be non-zero.
+    unsafe { NonNull::new_unchecked(ptr) }
 }
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index e6ea601f38c6..439985e29fbc 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -1,74 +1,188 @@
 // SPDX-License-Identifier: GPL-2.0
 
 //! Allocator support.
+//!
+//! Documentation for the kernel's memory allocators can found in the "Memory Allocation Guide"
+//! linked below. For instance, this includes the concept of "get free page" (GFP) flags and the
+//! typical application of the different kernel allocators.
+//!
+//! Reference: <https://docs.kernel.org/core-api/memory-allocation.html>
 
-use super::{flags::*, Flags};
-use core::alloc::{GlobalAlloc, Layout};
+use super::Flags;
+use core::alloc::Layout;
 use core::ptr;
+use core::ptr::NonNull;
 
-struct KernelAllocator;
+use crate::alloc::{AllocError, Allocator};
+use crate::bindings;
+use crate::pr_warn;
 
-/// Calls `krealloc` with a proper size to alloc a new object aligned to `new_layout`'s alignment.
+/// The contiguous kernel allocator.
 ///
-/// # Safety
+/// `Kmalloc` is typically used for physically contiguous allocations up to page size, but also
+/// supports larger allocations up to `bindings::KMALLOC_MAX_SIZE`, which is hardware specific.
 ///
-/// - `ptr` can be either null or a pointer which has been allocated by this allocator.
-/// - `new_layout` must have a non-zero size.
-pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: Flags) -> *mut u8 {
+/// For more details see [self].
+pub struct Kmalloc;
+
+/// The virtually contiguous kernel allocator.
+///
+/// `Vmalloc` allocates pages from the page level allocator and maps them into the contiguous kernel
+/// virtual space. It is typically used for large allocations. The memory allocated with this
+/// allocator is not physically contiguous.
+///
+/// For more details see [self].
+pub struct Vmalloc;
+
+/// The kvmalloc kernel allocator.
+///
+/// `KVmalloc` attempts to allocate memory with `Kmalloc` first, but falls back to `Vmalloc` upon
+/// failure. This allocator is typically used when the size for the requested allocation is not
+/// known and may exceed the capabilities of `Kmalloc`.
+///
+/// For more details see [self].
+pub struct KVmalloc;
+
+/// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
+fn aligned_size(new_layout: Layout) -> usize {
     // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
     let layout = new_layout.pad_to_align();
 
     // Note that `layout.size()` (after padding) is guaranteed to be a multiple of `layout.align()`
     // which together with the slab guarantees means the `krealloc` will return a properly aligned
     // object (see comments in `kmalloc()` for more information).
-    let size = layout.size();
-
-    // SAFETY:
-    // - `ptr` is either null or a pointer returned from a previous `k{re}alloc()` by the
-    //   function safety requirement.
-    // - `size` is greater than 0 since it's from `layout.size()` (which cannot be zero according
-    //   to the function safety requirement)
-    unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, size, flags.0) as *mut u8 }
+    layout.size()
 }
 
-unsafe impl GlobalAlloc for KernelAllocator {
-    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
-        // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
-        // requirement.
-        unsafe { krealloc_aligned(ptr::null_mut(), layout, GFP_KERNEL) }
-    }
+/// # Invariants
+///
+/// One of the following: `krealloc`, `vrealloc`, `kvrealloc`.
+struct ReallocFunc(
+    unsafe extern "C" fn(*const crate::ffi::c_void, usize, u32) -> *mut crate::ffi::c_void,
+);
 
-    unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
-        unsafe {
-            bindings::kfree(ptr as *const core::ffi::c_void);
-        }
-    }
+impl ReallocFunc {
+    // INVARIANT: `krealloc` satisfies the type invariants.
+    const KREALLOC: Self = Self(bindings::krealloc);
 
-    unsafe fn realloc(&self, ptr: *mut u8, layout: Layout, new_size: usize) -> *mut u8 {
-        // SAFETY:
-        // - `new_size`, when rounded up to the nearest multiple of `layout.align()`, will not
-        //   overflow `isize` by the function safety requirement.
-        // - `layout.align()` is a proper alignment (i.e. not zero and must be a power of two).
-        let layout = unsafe { Layout::from_size_align_unchecked(new_size, layout.align()) };
+    // INVARIANT: `vrealloc` satisfies the type invariants.
+    const VREALLOC: Self = Self(bindings::vrealloc);
+
+    // INVARIANT: `kvrealloc` satisfies the type invariants.
+    const KVREALLOC: Self = Self(bindings::kvrealloc);
+
+    /// # Safety
+    ///
+    /// This method has the same safety requirements as [`Allocator::realloc`].
+    ///
+    /// # Guarantees
+    ///
+    /// This method has the same guarantees as `Allocator::realloc`. Additionally
+    /// - it accepts any pointer to a valid memory allocation allocated by this function.
+    /// - memory allocated by this function remains valid until it is passed to this function.
+    unsafe fn call(
+        &self,
+        ptr: Option<NonNull<u8>>,
+        layout: Layout,
+        old_layout: Layout,
+        flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        let size = aligned_size(layout);
+        let ptr = match ptr {
+            Some(ptr) => {
+                if old_layout.size() == 0 {
+                    ptr::null()
+                } else {
+                    ptr.as_ptr()
+                }
+            }
+            None => ptr::null(),
+        };
 
         // SAFETY:
-        // - `ptr` is either null or a pointer allocated by this allocator by the function safety
-        //   requirement.
-        // - the size of `layout` is not zero because `new_size` is not zero by the function safety
-        //   requirement.
-        unsafe { krealloc_aligned(ptr, layout, GFP_KERNEL) }
+        // - `self.0` is one of `krealloc`, `vrealloc`, `kvrealloc` and thus only requires that
+        //   `ptr` is NULL or valid.
+        // - `ptr` is either NULL or valid by the safety requirements of this function.
+        //
+        // GUARANTEE:
+        // - `self.0` is one of `krealloc`, `vrealloc`, `kvrealloc`.
+        // - Those functions provide the guarantees of this function.
+        let raw_ptr = unsafe {
+            // If `size == 0` and `ptr != NULL` the memory behind the pointer is freed.
+            self.0(ptr.cast(), size, flags.0).cast()
+        };
+
+        let ptr = if size == 0 {
+            crate::alloc::dangling_from_layout(layout)
+        } else {
+            NonNull::new(raw_ptr).ok_or(AllocError)?
+        };
+
+        Ok(NonNull::slice_from_raw_parts(ptr, size))
+    }
+}
+
+// SAFETY: `realloc` delegates to `ReallocFunc::call`, which guarantees that
+// - memory remains valid until it is explicitly freed,
+// - passing a pointer to a valid memory allocation is OK,
+// - `realloc` satisfies the guarantees, since `ReallocFunc::call` has the same.
+unsafe impl Allocator for Kmalloc {
+    #[inline]
+    unsafe fn realloc(
+        ptr: Option<NonNull<u8>>,
+        layout: Layout,
+        old_layout: Layout,
+        flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        // SAFETY: `ReallocFunc::call` has the same safety requirements as `Allocator::realloc`.
+        unsafe { ReallocFunc::KREALLOC.call(ptr, layout, old_layout, flags) }
     }
+}
+
+// SAFETY: `realloc` delegates to `ReallocFunc::call`, which guarantees that
+// - memory remains valid until it is explicitly freed,
+// - passing a pointer to a valid memory allocation is OK,
+// - `realloc` satisfies the guarantees, since `ReallocFunc::call` has the same.
+unsafe impl Allocator for Vmalloc {
+    #[inline]
+    unsafe fn realloc(
+        ptr: Option<NonNull<u8>>,
+        layout: Layout,
+        old_layout: Layout,
+        flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        // TODO: Support alignments larger than PAGE_SIZE.
+        if layout.align() > bindings::PAGE_SIZE {
+            pr_warn!("Vmalloc does not support alignments larger than PAGE_SIZE yet.\n");
+            return Err(AllocError);
+        }
 
-    unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
-        // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
-        // requirement.
-        unsafe { krealloc_aligned(ptr::null_mut(), layout, GFP_KERNEL | __GFP_ZERO) }
+        // SAFETY: If not `None`, `ptr` is guaranteed to point to valid memory, which was previously
+        // allocated with this `Allocator`.
+        unsafe { ReallocFunc::VREALLOC.call(ptr, layout, old_layout, flags) }
     }
 }
 
-#[global_allocator]
-static ALLOCATOR: KernelAllocator = KernelAllocator;
+// SAFETY: `realloc` delegates to `ReallocFunc::call`, which guarantees that
+// - memory remains valid until it is explicitly freed,
+// - passing a pointer to a valid memory allocation is OK,
+// - `realloc` satisfies the guarantees, since `ReallocFunc::call` has the same.
+unsafe impl Allocator for KVmalloc {
+    #[inline]
+    unsafe fn realloc(
+        ptr: Option<NonNull<u8>>,
+        layout: Layout,
+        old_layout: Layout,
+        flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        // TODO: Support alignments larger than PAGE_SIZE.
+        if layout.align() > bindings::PAGE_SIZE {
+            pr_warn!("KVmalloc does not support alignments larger than PAGE_SIZE yet.\n");
+            return Err(AllocError);
+        }
 
-// See <https://github.com/rust-lang/rust/pull/86844>.
-#[no_mangle]
-static __rust_no_alloc_shim_is_unstable: u8 = 0;
+        // SAFETY: If not `None`, `ptr` is guaranteed to point to valid memory, which was previously
+        // allocated with this `Allocator`.
+        unsafe { ReallocFunc::KVREALLOC.call(ptr, layout, old_layout, flags) }
+    }
+}
diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
new file mode 100644
index 000000000000..e3240d16040b
--- /dev/null
+++ b/rust/kernel/alloc/allocator_test.rs
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! So far the kernel's `Box` and `Vec` types can't be used by userspace test cases, since all users
+//! of those types (e.g. `CString`) use kernel allocators for instantiation.
+//!
+//! In order to allow userspace test cases to make use of such types as well, implement the
+//! `Cmalloc` allocator within the allocator_test module and type alias all kernel allocators to
+//! `Cmalloc`. The `Cmalloc` allocator uses libc's `realloc()` function as allocator backend.
+
+#![allow(missing_docs)]
+
+use super::{flags::*, AllocError, Allocator, Flags};
+use core::alloc::Layout;
+use core::cmp;
+use core::ptr;
+use core::ptr::NonNull;
+
+/// The userspace allocator based on libc.
+pub struct Cmalloc;
+
+pub type Kmalloc = Cmalloc;
+pub type Vmalloc = Kmalloc;
+pub type KVmalloc = Kmalloc;
+
+extern "C" {
+    #[link_name = "aligned_alloc"]
+    fn libc_aligned_alloc(align: usize, size: usize) -> *mut crate::ffi::c_void;
+
+    #[link_name = "free"]
+    fn libc_free(ptr: *mut crate::ffi::c_void);
+}
+
+// SAFETY:
+// - memory remains valid until it is explicitly freed,
+// - passing a pointer to a valid memory allocation created by this `Allocator` is always OK,
+// - `realloc` provides the guarantees as provided in the `# Guarantees` section.
+unsafe impl Allocator for Cmalloc {
+    unsafe fn realloc(
+        ptr: Option<NonNull<u8>>,
+        layout: Layout,
+        old_layout: Layout,
+        flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        let src = match ptr {
+            Some(src) => {
+                if old_layout.size() == 0 {
+                    ptr::null_mut()
+                } else {
+                    src.as_ptr()
+                }
+            }
+            None => ptr::null_mut(),
+        };
+
+        if layout.size() == 0 {
+            // SAFETY: `src` is either NULL or was previously allocated with this `Allocator`
+            unsafe { libc_free(src.cast()) };
+
+            return Ok(NonNull::slice_from_raw_parts(
+                crate::alloc::dangling_from_layout(layout),
+                0,
+            ));
+        }
+
+        // SAFETY: Returns either NULL or a pointer to a memory allocation that satisfies or
+        // exceeds the given size and alignment requirements.
+        let dst = unsafe { libc_aligned_alloc(layout.align(), layout.size()) } as *mut u8;
+        let dst = NonNull::new(dst).ok_or(AllocError)?;
+
+        if flags.contains(__GFP_ZERO) {
+            // SAFETY: The preceding calls to `libc_aligned_alloc` and `NonNull::new`
+            // guarantee that `dst` points to memory of at least `layout.size()` bytes.
+            unsafe { dst.as_ptr().write_bytes(0, layout.size()) };
+        }
+
+        if !src.is_null() {
+            // SAFETY:
+            // - `src` has previously been allocated with this `Allocator`; `dst` has just been
+            //   newly allocated, hence the memory regions do not overlap.
+            // - both` src` and `dst` are properly aligned and valid for reads and writes
+            unsafe {
+                ptr::copy_nonoverlapping(
+                    src,
+                    dst.as_ptr(),
+                    cmp::min(layout.size(), old_layout.size()),
+                )
+            };
+        }
+
+        // SAFETY: `src` is either NULL or was previously allocated with this `Allocator`
+        unsafe { libc_free(src.cast()) };
+
+        Ok(NonNull::slice_from_raw_parts(dst, layout.size()))
+    }
+}
diff --git a/rust/kernel/alloc/box_ext.rs b/rust/kernel/alloc/box_ext.rs
deleted file mode 100644
index 7009ad78d4e0..000000000000
--- a/rust/kernel/alloc/box_ext.rs
+++ /dev/null
@@ -1,89 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-//! Extensions to [`Box`] for fallible allocations.
-
-use super::{AllocError, Flags};
-use alloc::boxed::Box;
-use core::{mem::MaybeUninit, ptr, result::Result};
-
-/// Extensions to [`Box`].
-pub trait BoxExt<T>: Sized {
-    /// Allocates a new box.
-    ///
-    /// The allocation may fail, in which case an error is returned.
-    fn new(x: T, flags: Flags) -> Result<Self, AllocError>;
-
-    /// Allocates a new uninitialised box.
-    ///
-    /// The allocation may fail, in which case an error is returned.
-    fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError>;
-
-    /// Drops the contents, but keeps the allocation.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// use kernel::alloc::{flags, box_ext::BoxExt};
-    /// let value = Box::new([0; 32], flags::GFP_KERNEL)?;
-    /// assert_eq!(*value, [0; 32]);
-    /// let mut value = Box::drop_contents(value);
-    /// // Now we can re-use `value`:
-    /// value.write([1; 32]);
-    /// // SAFETY: We just wrote to it.
-    /// let value = unsafe { value.assume_init() };
-    /// assert_eq!(*value, [1; 32]);
-    /// # Ok::<(), Error>(())
-    /// ```
-    fn drop_contents(this: Self) -> Box<MaybeUninit<T>>;
-}
-
-impl<T> BoxExt<T> for Box<T> {
-    fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
-        let mut b = <Self as BoxExt<_>>::new_uninit(flags)?;
-        b.write(x);
-        // SAFETY: We just wrote to it.
-        Ok(unsafe { b.assume_init() })
-    }
-
-    #[cfg(any(test, testlib))]
-    fn new_uninit(_flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError> {
-        Ok(Box::new_uninit())
-    }
-
-    #[cfg(not(any(test, testlib)))]
-    fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError> {
-        let ptr = if core::mem::size_of::<MaybeUninit<T>>() == 0 {
-            core::ptr::NonNull::<_>::dangling().as_ptr()
-        } else {
-            let layout = core::alloc::Layout::new::<MaybeUninit<T>>();
-
-            // SAFETY: Memory is being allocated (first arg is null). The only other source of
-            // safety issues is sleeping on atomic context, which is addressed by klint. Lastly,
-            // the type is not a SZT (checked above).
-            let ptr =
-                unsafe { super::allocator::krealloc_aligned(core::ptr::null_mut(), layout, flags) };
-            if ptr.is_null() {
-                return Err(AllocError);
-            }
-
-            ptr.cast::<MaybeUninit<T>>()
-        };
-
-        // SAFETY: For non-zero-sized types, we allocate above using the global allocator. For
-        // zero-sized types, we use `NonNull::dangling`.
-        Ok(unsafe { Box::from_raw(ptr) })
-    }
-
-    fn drop_contents(this: Self) -> Box<MaybeUninit<T>> {
-        let ptr = Box::into_raw(this);
-        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
-        unsafe { ptr::drop_in_place(ptr) };
-
-        // CAST: `MaybeUninit<T>` is a transparent wrapper of `T`.
-        let ptr = ptr.cast::<MaybeUninit<T>>();
-
-        // SAFETY: `ptr` is valid for writes, because it came from `Box::into_raw` and it is valid for
-        // reads, since the pointer came from `Box::into_raw` and the type is `MaybeUninit<T>`.
-        unsafe { Box::from_raw(ptr) }
-    }
-}
diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
new file mode 100644
index 000000000000..9ce414361c2c
--- /dev/null
+++ b/rust/kernel/alloc/kbox.rs
@@ -0,0 +1,456 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Implementation of [`Box`].
+
+#[allow(unused_imports)] // Used in doc comments.
+use super::allocator::{KVmalloc, Kmalloc, Vmalloc};
+use super::{AllocError, Allocator, Flags};
+use core::alloc::Layout;
+use core::fmt;
+use core::marker::PhantomData;
+use core::mem::ManuallyDrop;
+use core::mem::MaybeUninit;
+use core::ops::{Deref, DerefMut};
+use core::pin::Pin;
+use core::ptr::NonNull;
+use core::result::Result;
+
+use crate::init::{InPlaceInit, InPlaceWrite, Init, PinInit};
+use crate::types::ForeignOwnable;
+
+/// The kernel's [`Box`] type -- a heap allocation for a single value of type `T`.
+///
+/// This is the kernel's version of the Rust stdlib's `Box`. There are several differences,
+/// for example no `noalias` attribute is emitted and partially moving out of a `Box` is not
+/// supported. There are also several API differences, e.g. `Box` always requires an [`Allocator`]
+/// implementation to be passed as generic, page [`Flags`] when allocating memory and all functions
+/// that may allocate memory are fallible.
+///
+/// `Box` works with any of the kernel's allocators, e.g. [`Kmalloc`], [`Vmalloc`] or [`KVmalloc`].
+/// There are aliases for `Box` with these allocators ([`KBox`], [`VBox`], [`KVBox`]).
+///
+/// When dropping a [`Box`], the value is also dropped and the heap memory is automatically freed.
+///
+/// # Examples
+///
+/// ```
+/// let b = KBox::<u64>::new(24_u64, GFP_KERNEL)?;
+///
+/// assert_eq!(*b, 24_u64);
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// ```
+/// # use kernel::bindings;
+/// const SIZE: usize = bindings::KMALLOC_MAX_SIZE as usize + 1;
+/// struct Huge([u8; SIZE]);
+///
+/// assert!(KBox::<Huge>::new_uninit(GFP_KERNEL | __GFP_NOWARN).is_err());
+/// ```
+///
+/// ```
+/// # use kernel::bindings;
+/// const SIZE: usize = bindings::KMALLOC_MAX_SIZE as usize + 1;
+/// struct Huge([u8; SIZE]);
+///
+/// assert!(KVBox::<Huge>::new_uninit(GFP_KERNEL).is_ok());
+/// ```
+///
+/// # Invariants
+///
+/// `self.0` is always properly aligned and either points to memory allocated with `A` or, for
+/// zero-sized types, is a dangling, well aligned pointer.
+#[repr(transparent)]
+pub struct Box<T: ?Sized, A: Allocator>(NonNull<T>, PhantomData<A>);
+
+/// Type alias for [`Box`] with a [`Kmalloc`] allocator.
+///
+/// # Examples
+///
+/// ```
+/// let b = KBox::new(24_u64, GFP_KERNEL)?;
+///
+/// assert_eq!(*b, 24_u64);
+/// # Ok::<(), Error>(())
+/// ```
+pub type KBox<T> = Box<T, super::allocator::Kmalloc>;
+
+/// Type alias for [`Box`] with a [`Vmalloc`] allocator.
+///
+/// # Examples
+///
+/// ```
+/// let b = VBox::new(24_u64, GFP_KERNEL)?;
+///
+/// assert_eq!(*b, 24_u64);
+/// # Ok::<(), Error>(())
+/// ```
+pub type VBox<T> = Box<T, super::allocator::Vmalloc>;
+
+/// Type alias for [`Box`] with a [`KVmalloc`] allocator.
+///
+/// # Examples
+///
+/// ```
+/// let b = KVBox::new(24_u64, GFP_KERNEL)?;
+///
+/// assert_eq!(*b, 24_u64);
+/// # Ok::<(), Error>(())
+/// ```
+pub type KVBox<T> = Box<T, super::allocator::KVmalloc>;
+
+// SAFETY: `Box` is `Send` if `T` is `Send` because the `Box` owns a `T`.
+unsafe impl<T, A> Send for Box<T, A>
+where
+    T: Send + ?Sized,
+    A: Allocator,
+{
+}
+
+// SAFETY: `Box` is `Sync` if `T` is `Sync` because the `Box` owns a `T`.
+unsafe impl<T, A> Sync for Box<T, A>
+where
+    T: Sync + ?Sized,
+    A: Allocator,
+{
+}
+
+impl<T, A> Box<T, A>
+where
+    T: ?Sized,
+    A: Allocator,
+{
+    /// Creates a new `Box<T, A>` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// For non-ZSTs, `raw` must point at an allocation allocated with `A` that is sufficiently
+    /// aligned for and holds a valid `T`. The caller passes ownership of the allocation to the
+    /// `Box`.
+    ///
+    /// For ZSTs, `raw` must be a dangling, well aligned pointer.
+    #[inline]
+    pub const unsafe fn from_raw(raw: *mut T) -> Self {
+        // INVARIANT: Validity of `raw` is guaranteed by the safety preconditions of this function.
+        // SAFETY: By the safety preconditions of this function, `raw` is not a NULL pointer.
+        Self(unsafe { NonNull::new_unchecked(raw) }, PhantomData)
+    }
+
+    /// Consumes the `Box<T, A>` and returns a raw pointer.
+    ///
+    /// This will not run the destructor of `T` and for non-ZSTs the allocation will stay alive
+    /// indefinitely. Use [`Box::from_raw`] to recover the [`Box`], drop the value and free the
+    /// allocation, if any.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let x = KBox::new(24, GFP_KERNEL)?;
+    /// let ptr = KBox::into_raw(x);
+    /// // SAFETY: `ptr` comes from a previous call to `KBox::into_raw`.
+    /// let x = unsafe { KBox::from_raw(ptr) };
+    ///
+    /// assert_eq!(*x, 24);
+    /// # Ok::<(), Error>(())
+    /// ```
+    #[inline]
+    pub fn into_raw(b: Self) -> *mut T {
+        ManuallyDrop::new(b).0.as_ptr()
+    }
+
+    /// Consumes and leaks the `Box<T, A>` and returns a mutable reference.
+    ///
+    /// See [`Box::into_raw`] for more details.
+    #[inline]
+    pub fn leak<'a>(b: Self) -> &'a mut T {
+        // SAFETY: `Box::into_raw` always returns a properly aligned and dereferenceable pointer
+        // which points to an initialized instance of `T`.
+        unsafe { &mut *Box::into_raw(b) }
+    }
+}
+
+impl<T, A> Box<MaybeUninit<T>, A>
+where
+    A: Allocator,
+{
+    /// Converts a `Box<MaybeUninit<T>, A>` to a `Box<T, A>`.
+    ///
+    /// It is undefined behavior to call this function while the value inside of `b` is not yet
+    /// fully initialized.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the value inside of `b` is in an initialized state.
+    pub unsafe fn assume_init(self) -> Box<T, A> {
+        let raw = Self::into_raw(self);
+
+        // SAFETY: `raw` comes from a previous call to `Box::into_raw`. By the safety requirements
+        // of this function, the value inside the `Box` is in an initialized state. Hence, it is
+        // safe to reconstruct the `Box` as `Box<T, A>`.
+        unsafe { Box::from_raw(raw.cast()) }
+    }
+
+    /// Writes the value and converts to `Box<T, A>`.
+    pub fn write(mut self, value: T) -> Box<T, A> {
+        (*self).write(value);
+
+        // SAFETY: We've just initialized `b`'s value.
+        unsafe { self.assume_init() }
+    }
+}
+
+impl<T, A> Box<T, A>
+where
+    A: Allocator,
+{
+    /// Creates a new `Box<T, A>` and initializes its contents with `x`.
+    ///
+    /// New memory is allocated with `A`. The allocation may fail, in which case an error is
+    /// returned. For ZSTs no memory is allocated.
+    pub fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
+        let b = Self::new_uninit(flags)?;
+        Ok(Box::write(b, x))
+    }
+
+    /// Creates a new `Box<T, A>` with uninitialized contents.
+    ///
+    /// New memory is allocated with `A`. The allocation may fail, in which case an error is
+    /// returned. For ZSTs no memory is allocated.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let b = KBox::<u64>::new_uninit(GFP_KERNEL)?;
+    /// let b = KBox::write(b, 24);
+    ///
+    /// assert_eq!(*b, 24_u64);
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>, A>, AllocError> {
+        let layout = Layout::new::<MaybeUninit<T>>();
+        let ptr = A::alloc(layout, flags)?;
+
+        // INVARIANT: `ptr` is either a dangling pointer or points to memory allocated with `A`,
+        // which is sufficient in size and alignment for storing a `T`.
+        Ok(Box(ptr.cast(), PhantomData))
+    }
+
+    /// Constructs a new `Pin<Box<T, A>>`. If `T` does not implement [`Unpin`], then `x` will be
+    /// pinned in memory and can't be moved.
+    #[inline]
+    pub fn pin(x: T, flags: Flags) -> Result<Pin<Box<T, A>>, AllocError>
+    where
+        A: 'static,
+    {
+        Ok(Self::new(x, flags)?.into())
+    }
+
+    /// Forgets the contents (does not run the destructor), but keeps the allocation.
+    fn forget_contents(this: Self) -> Box<MaybeUninit<T>, A> {
+        let ptr = Self::into_raw(this);
+
+        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
+        unsafe { Box::from_raw(ptr.cast()) }
+    }
+
+    /// Drops the contents, but keeps the allocation.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let value = KBox::new([0; 32], GFP_KERNEL)?;
+    /// assert_eq!(*value, [0; 32]);
+    /// let value = KBox::drop_contents(value);
+    /// // Now we can re-use `value`:
+    /// let value = KBox::write(value, [1; 32]);
+    /// assert_eq!(*value, [1; 32]);
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn drop_contents(this: Self) -> Box<MaybeUninit<T>, A> {
+        let ptr = this.0.as_ptr();
+
+        // SAFETY: `ptr` is valid, because it came from `this`. After this call we never access the
+        // value stored in `this` again.
+        unsafe { core::ptr::drop_in_place(ptr) };
+
+        Self::forget_contents(this)
+    }
+
+    /// Moves the `Box`'s value out of the `Box` and consumes the `Box`.
+    pub fn into_inner(b: Self) -> T {
+        // SAFETY: By the type invariant `&*b` is valid for `read`.
+        let value = unsafe { core::ptr::read(&*b) };
+        let _ = Self::forget_contents(b);
+        value
+    }
+}
+
+impl<T, A> From<Box<T, A>> for Pin<Box<T, A>>
+where
+    T: ?Sized,
+    A: Allocator,
+{
+    /// Converts a `Box<T, A>` into a `Pin<Box<T, A>>`. If `T` does not implement [`Unpin`], then
+    /// `*b` will be pinned in memory and can't be moved.
+    ///
+    /// This moves `b` into `Pin` without moving `*b` or allocating and copying any memory.
+    fn from(b: Box<T, A>) -> Self {
+        // SAFETY: The value wrapped inside a `Pin<Box<T, A>>` cannot be moved or replaced as long
+        // as `T` does not implement `Unpin`.
+        unsafe { Pin::new_unchecked(b) }
+    }
+}
+
+impl<T, A> InPlaceWrite<T> for Box<MaybeUninit<T>, A>
+where
+    A: Allocator + 'static,
+{
+    type Initialized = Box<T, A>;
+
+    fn write_init<E>(mut self, init: impl Init<T, E>) -> Result<Self::Initialized, E> {
+        let slot = self.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
+        // slot is valid.
+        unsafe { init.__init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { Box::assume_init(self) })
+    }
+
+    fn write_pin_init<E>(mut self, init: impl PinInit<T, E>) -> Result<Pin<Self::Initialized>, E> {
+        let slot = self.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
+        // slot is valid and will not be moved, because we pin it later.
+        unsafe { init.__pinned_init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { Box::assume_init(self) }.into())
+    }
+}
+
+impl<T, A> InPlaceInit<T> for Box<T, A>
+where
+    A: Allocator + 'static,
+{
+    type PinnedSelf = Pin<Self>;
+
+    #[inline]
+    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>, E>
+    where
+        E: From<AllocError>,
+    {
+        Box::<_, A>::new_uninit(flags)?.write_pin_init(init)
+    }
+
+    #[inline]
+    fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
+    where
+        E: From<AllocError>,
+    {
+        Box::<_, A>::new_uninit(flags)?.write_init(init)
+    }
+}
+
+impl<T: 'static, A> ForeignOwnable for Box<T, A>
+where
+    A: Allocator,
+{
+    type Borrowed<'a> = &'a T;
+
+    fn into_foreign(self) -> *const crate::ffi::c_void {
+        Box::into_raw(self) as _
+    }
+
+    unsafe fn from_foreign(ptr: *const crate::ffi::c_void) -> Self {
+        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
+        // call to `Self::into_foreign`.
+        unsafe { Box::from_raw(ptr as _) }
+    }
+
+    unsafe fn borrow<'a>(ptr: *const crate::ffi::c_void) -> &'a T {
+        // SAFETY: The safety requirements of this method ensure that the object remains alive and
+        // immutable for the duration of 'a.
+        unsafe { &*ptr.cast() }
+    }
+}
+
+impl<T: 'static, A> ForeignOwnable for Pin<Box<T, A>>
+where
+    A: Allocator,
+{
+    type Borrowed<'a> = Pin<&'a T>;
+
+    fn into_foreign(self) -> *const crate::ffi::c_void {
+        // SAFETY: We are still treating the box as pinned.
+        Box::into_raw(unsafe { Pin::into_inner_unchecked(self) }) as _
+    }
+
+    unsafe fn from_foreign(ptr: *const crate::ffi::c_void) -> Self {
+        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
+        // call to `Self::into_foreign`.
+        unsafe { Pin::new_unchecked(Box::from_raw(ptr as _)) }
+    }
+
+    unsafe fn borrow<'a>(ptr: *const crate::ffi::c_void) -> Pin<&'a T> {
+        // SAFETY: The safety requirements for this function ensure that the object is still alive,
+        // so it is safe to dereference the raw pointer.
+        // The safety requirements of `from_foreign` also ensure that the object remains alive for
+        // the lifetime of the returned value.
+        let r = unsafe { &*ptr.cast() };
+
+        // SAFETY: This pointer originates from a `Pin<Box<T>>`.
+        unsafe { Pin::new_unchecked(r) }
+    }
+}
+
+impl<T, A> Deref for Box<T, A>
+where
+    T: ?Sized,
+    A: Allocator,
+{
+    type Target = T;
+
+    fn deref(&self) -> &T {
+        // SAFETY: `self.0` is always properly aligned, dereferenceable and points to an initialized
+        // instance of `T`.
+        unsafe { self.0.as_ref() }
+    }
+}
+
+impl<T, A> DerefMut for Box<T, A>
+where
+    T: ?Sized,
+    A: Allocator,
+{
+    fn deref_mut(&mut self) -> &mut T {
+        // SAFETY: `self.0` is always properly aligned, dereferenceable and points to an initialized
+        // instance of `T`.
+        unsafe { self.0.as_mut() }
+    }
+}
+
+impl<T, A> fmt::Debug for Box<T, A>
+where
+    T: ?Sized + fmt::Debug,
+    A: Allocator,
+{
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        fmt::Debug::fmt(&**self, f)
+    }
+}
+
+impl<T, A> Drop for Box<T, A>
+where
+    T: ?Sized,
+    A: Allocator,
+{
+    fn drop(&mut self) {
+        let layout = Layout::for_value::<T>(self);
+
+        // SAFETY: The pointer in `self.0` is guaranteed to be valid by the type invariant.
+        unsafe { core::ptr::drop_in_place::<T>(self.deref_mut()) };
+
+        // SAFETY:
+        // - `self.0` was previously allocated with `A`.
+        // - `layout` is equal to the `Layout´ `self.0` was allocated with.
+        unsafe { A::free(self.0.cast(), layout) };
+    }
+}
diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
new file mode 100644
index 000000000000..ae9d072741ce
--- /dev/null
+++ b/rust/kernel/alloc/kvec.rs
@@ -0,0 +1,913 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Implementation of [`Vec`].
+
+use super::{
+    allocator::{KVmalloc, Kmalloc, Vmalloc},
+    layout::ArrayLayout,
+    AllocError, Allocator, Box, Flags,
+};
+use core::{
+    fmt,
+    marker::PhantomData,
+    mem::{ManuallyDrop, MaybeUninit},
+    ops::Deref,
+    ops::DerefMut,
+    ops::Index,
+    ops::IndexMut,
+    ptr,
+    ptr::NonNull,
+    slice,
+    slice::SliceIndex,
+};
+
+/// Create a [`KVec`] containing the arguments.
+///
+/// New memory is allocated with `GFP_KERNEL`.
+///
+/// # Examples
+///
+/// ```
+/// let mut v = kernel::kvec![];
+/// v.push(1, GFP_KERNEL)?;
+/// assert_eq!(v, [1]);
+///
+/// let mut v = kernel::kvec![1; 3]?;
+/// v.push(4, GFP_KERNEL)?;
+/// assert_eq!(v, [1, 1, 1, 4]);
+///
+/// let mut v = kernel::kvec![1, 2, 3]?;
+/// v.push(4, GFP_KERNEL)?;
+/// assert_eq!(v, [1, 2, 3, 4]);
+///
+/// # Ok::<(), Error>(())
+/// ```
+#[macro_export]
+macro_rules! kvec {
+    () => (
+        $crate::alloc::KVec::new()
+    );
+    ($elem:expr; $n:expr) => (
+        $crate::alloc::KVec::from_elem($elem, $n, GFP_KERNEL)
+    );
+    ($($x:expr),+ $(,)?) => (
+        match $crate::alloc::KBox::new_uninit(GFP_KERNEL) {
+            Ok(b) => Ok($crate::alloc::KVec::from($crate::alloc::KBox::write(b, [$($x),+]))),
+            Err(e) => Err(e),
+        }
+    );
+}
+
+/// The kernel's [`Vec`] type.
+///
+/// A contiguous growable array type with contents allocated with the kernel's allocators (e.g.
+/// [`Kmalloc`], [`Vmalloc`] or [`KVmalloc`]), written `Vec<T, A>`.
+///
+/// For non-zero-sized values, a [`Vec`] will use the given allocator `A` for its allocation. For
+/// the most common allocators the type aliases [`KVec`], [`VVec`] and [`KVVec`] exist.
+///
+/// For zero-sized types the [`Vec`]'s pointer must be `dangling_mut::<T>`; no memory is allocated.
+///
+/// Generally, [`Vec`] consists of a pointer that represents the vector's backing buffer, the
+/// capacity of the vector (the number of elements that currently fit into the vector), its length
+/// (the number of elements that are currently stored in the vector) and the `Allocator` type used
+/// to allocate (and free) the backing buffer.
+///
+/// A [`Vec`] can be deconstructed into and (re-)constructed from its previously named raw parts
+/// and manually modified.
+///
+/// [`Vec`]'s backing buffer gets, if required, automatically increased (re-allocated) when elements
+/// are added to the vector.
+///
+/// # Invariants
+///
+/// - `self.ptr` is always properly aligned and either points to memory allocated with `A` or, for
+///   zero-sized types, is a dangling, well aligned pointer.
+///
+/// - `self.len` always represents the exact number of elements stored in the vector.
+///
+/// - `self.layout` represents the absolute number of elements that can be stored within the vector
+///   without re-allocation. For ZSTs `self.layout`'s capacity is zero. However, it is legal for the
+///   backing buffer to be larger than `layout`.
+///
+/// - The `Allocator` type `A` of the vector is the exact same `Allocator` type the backing buffer
+///   was allocated with (and must be freed with).
+pub struct Vec<T, A: Allocator> {
+    ptr: NonNull<T>,
+    /// Represents the actual buffer size as `cap` times `size_of::<T>` bytes.
+    ///
+    /// Note: This isn't quite the same as `Self::capacity`, which in contrast returns the number of
+    /// elements we can still store without reallocating.
+    layout: ArrayLayout<T>,
+    len: usize,
+    _p: PhantomData<A>,
+}
+
+/// Type alias for [`Vec`] with a [`Kmalloc`] allocator.
+///
+/// # Examples
+///
+/// ```
+/// let mut v = KVec::new();
+/// v.push(1, GFP_KERNEL)?;
+/// assert_eq!(&v, &[1]);
+///
+/// # Ok::<(), Error>(())
+/// ```
+pub type KVec<T> = Vec<T, Kmalloc>;
+
+/// Type alias for [`Vec`] with a [`Vmalloc`] allocator.
+///
+/// # Examples
+///
+/// ```
+/// let mut v = VVec::new();
+/// v.push(1, GFP_KERNEL)?;
+/// assert_eq!(&v, &[1]);
+///
+/// # Ok::<(), Error>(())
+/// ```
+pub type VVec<T> = Vec<T, Vmalloc>;
+
+/// Type alias for [`Vec`] with a [`KVmalloc`] allocator.
+///
+/// # Examples
+///
+/// ```
+/// let mut v = KVVec::new();
+/// v.push(1, GFP_KERNEL)?;
+/// assert_eq!(&v, &[1]);
+///
+/// # Ok::<(), Error>(())
+/// ```
+pub type KVVec<T> = Vec<T, KVmalloc>;
+
+// SAFETY: `Vec` is `Send` if `T` is `Send` because `Vec` owns its elements.
+unsafe impl<T, A> Send for Vec<T, A>
+where
+    T: Send,
+    A: Allocator,
+{
+}
+
+// SAFETY: `Vec` is `Sync` if `T` is `Sync` because `Vec` owns its elements.
+unsafe impl<T, A> Sync for Vec<T, A>
+where
+    T: Sync,
+    A: Allocator,
+{
+}
+
+impl<T, A> Vec<T, A>
+where
+    A: Allocator,
+{
+    #[inline]
+    const fn is_zst() -> bool {
+        core::mem::size_of::<T>() == 0
+    }
+
+    /// Returns the number of elements that can be stored within the vector without allocating
+    /// additional memory.
+    pub fn capacity(&self) -> usize {
+        if const { Self::is_zst() } {
+            usize::MAX
+        } else {
+            self.layout.len()
+        }
+    }
+
+    /// Returns the number of elements stored within the vector.
+    #[inline]
+    pub fn len(&self) -> usize {
+        self.len
+    }
+
+    /// Forcefully sets `self.len` to `new_len`.
+    ///
+    /// # Safety
+    ///
+    /// - `new_len` must be less than or equal to [`Self::capacity`].
+    /// - If `new_len` is greater than `self.len`, all elements within the interval
+    ///   [`self.len`,`new_len`) must be initialized.
+    #[inline]
+    pub unsafe fn set_len(&mut self, new_len: usize) {
+        debug_assert!(new_len <= self.capacity());
+        self.len = new_len;
+    }
+
+    /// Returns a slice of the entire vector.
+    #[inline]
+    pub fn as_slice(&self) -> &[T] {
+        self
+    }
+
+    /// Returns a mutable slice of the entire vector.
+    #[inline]
+    pub fn as_mut_slice(&mut self) -> &mut [T] {
+        self
+    }
+
+    /// Returns a mutable raw pointer to the vector's backing buffer, or, if `T` is a ZST, a
+    /// dangling raw pointer.
+    #[inline]
+    pub fn as_mut_ptr(&mut self) -> *mut T {
+        self.ptr.as_ptr()
+    }
+
+    /// Returns a raw pointer to the vector's backing buffer, or, if `T` is a ZST, a dangling raw
+    /// pointer.
+    #[inline]
+    pub fn as_ptr(&self) -> *const T {
+        self.ptr.as_ptr()
+    }
+
+    /// Returns `true` if the vector contains no elements, `false` otherwise.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = KVec::new();
+    /// assert!(v.is_empty());
+    ///
+    /// v.push(1, GFP_KERNEL);
+    /// assert!(!v.is_empty());
+    /// ```
+    #[inline]
+    pub fn is_empty(&self) -> bool {
+        self.len() == 0
+    }
+
+    /// Creates a new, empty `Vec<T, A>`.
+    ///
+    /// This method does not allocate by itself.
+    #[inline]
+    pub const fn new() -> Self {
+        // INVARIANT: Since this is a new, empty `Vec` with no backing memory yet,
+        // - `ptr` is a properly aligned dangling pointer for type `T`,
+        // - `layout` is an empty `ArrayLayout` (zero capacity)
+        // - `len` is zero, since no elements can be or have been stored,
+        // - `A` is always valid.
+        Self {
+            ptr: NonNull::dangling(),
+            layout: ArrayLayout::empty(),
+            len: 0,
+            _p: PhantomData::<A>,
+        }
+    }
+
+    /// Returns a slice of `MaybeUninit<T>` for the remaining spare capacity of the vector.
+    pub fn spare_capacity_mut(&mut self) -> &mut [MaybeUninit<T>] {
+        // SAFETY:
+        // - `self.len` is smaller than `self.capacity` and hence, the resulting pointer is
+        //   guaranteed to be part of the same allocated object.
+        // - `self.len` can not overflow `isize`.
+        let ptr = unsafe { self.as_mut_ptr().add(self.len) } as *mut MaybeUninit<T>;
+
+        // SAFETY: The memory between `self.len` and `self.capacity` is guaranteed to be allocated
+        // and valid, but uninitialized.
+        unsafe { slice::from_raw_parts_mut(ptr, self.capacity() - self.len) }
+    }
+
+    /// Appends an element to the back of the [`Vec`] instance.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = KVec::new();
+    /// v.push(1, GFP_KERNEL)?;
+    /// assert_eq!(&v, &[1]);
+    ///
+    /// v.push(2, GFP_KERNEL)?;
+    /// assert_eq!(&v, &[1, 2]);
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
+        self.reserve(1, flags)?;
+
+        // SAFETY:
+        // - `self.len` is smaller than `self.capacity` and hence, the resulting pointer is
+        //   guaranteed to be part of the same allocated object.
+        // - `self.len` can not overflow `isize`.
+        let ptr = unsafe { self.as_mut_ptr().add(self.len) };
+
+        // SAFETY:
+        // - `ptr` is properly aligned and valid for writes.
+        unsafe { core::ptr::write(ptr, v) };
+
+        // SAFETY: We just initialised the first spare entry, so it is safe to increase the length
+        // by 1. We also know that the new length is <= capacity because of the previous call to
+        // `reserve` above.
+        unsafe { self.set_len(self.len() + 1) };
+        Ok(())
+    }
+
+    /// Creates a new [`Vec`] instance with at least the given capacity.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let v = KVec::<u32>::with_capacity(20, GFP_KERNEL)?;
+    ///
+    /// assert!(v.capacity() >= 20);
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn with_capacity(capacity: usize, flags: Flags) -> Result<Self, AllocError> {
+        let mut v = Vec::new();
+
+        v.reserve(capacity, flags)?;
+
+        Ok(v)
+    }
+
+    /// Creates a `Vec<T, A>` from a pointer, a length and a capacity using the allocator `A`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = kernel::kvec![1, 2, 3]?;
+    /// v.reserve(1, GFP_KERNEL)?;
+    ///
+    /// let (mut ptr, mut len, cap) = v.into_raw_parts();
+    ///
+    /// // SAFETY: We've just reserved memory for another element.
+    /// unsafe { ptr.add(len).write(4) };
+    /// len += 1;
+    ///
+    /// // SAFETY: We only wrote an additional element at the end of the `KVec`'s buffer and
+    /// // correspondingly increased the length of the `KVec` by one. Otherwise, we construct it
+    /// // from the exact same raw parts.
+    /// let v = unsafe { KVec::from_raw_parts(ptr, len, cap) };
+    ///
+    /// assert_eq!(v, [1, 2, 3, 4]);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    ///
+    /// # Safety
+    ///
+    /// If `T` is a ZST:
+    ///
+    /// - `ptr` must be a dangling, well aligned pointer.
+    ///
+    /// Otherwise:
+    ///
+    /// - `ptr` must have been allocated with the allocator `A`.
+    /// - `ptr` must satisfy or exceed the alignment requirements of `T`.
+    /// - `ptr` must point to memory with a size of at least `size_of::<T>() * capacity` bytes.
+    /// - The allocated size in bytes must not be larger than `isize::MAX`.
+    /// - `length` must be less than or equal to `capacity`.
+    /// - The first `length` elements must be initialized values of type `T`.
+    ///
+    /// It is also valid to create an empty `Vec` passing a dangling pointer for `ptr` and zero for
+    /// `cap` and `len`.
+    pub unsafe fn from_raw_parts(ptr: *mut T, length: usize, capacity: usize) -> Self {
+        let layout = if Self::is_zst() {
+            ArrayLayout::empty()
+        } else {
+            // SAFETY: By the safety requirements of this function, `capacity * size_of::<T>()` is
+            // smaller than `isize::MAX`.
+            unsafe { ArrayLayout::new_unchecked(capacity) }
+        };
+
+        // INVARIANT: For ZSTs, we store an empty `ArrayLayout`, all other type invariants are
+        // covered by the safety requirements of this function.
+        Self {
+            // SAFETY: By the safety requirements, `ptr` is either dangling or pointing to a valid
+            // memory allocation, allocated with `A`.
+            ptr: unsafe { NonNull::new_unchecked(ptr) },
+            layout,
+            len: length,
+            _p: PhantomData::<A>,
+        }
+    }
+
+    /// Consumes the `Vec<T, A>` and returns its raw components `pointer`, `length` and `capacity`.
+    ///
+    /// This will not run the destructor of the contained elements and for non-ZSTs the allocation
+    /// will stay alive indefinitely. Use [`Vec::from_raw_parts`] to recover the [`Vec`], drop the
+    /// elements and free the allocation, if any.
+    pub fn into_raw_parts(self) -> (*mut T, usize, usize) {
+        let mut me = ManuallyDrop::new(self);
+        let len = me.len();
+        let capacity = me.capacity();
+        let ptr = me.as_mut_ptr();
+        (ptr, len, capacity)
+    }
+
+    /// Ensures that the capacity exceeds the length by at least `additional` elements.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = KVec::new();
+    /// v.push(1, GFP_KERNEL)?;
+    ///
+    /// v.reserve(10, GFP_KERNEL)?;
+    /// let cap = v.capacity();
+    /// assert!(cap >= 10);
+    ///
+    /// v.reserve(10, GFP_KERNEL)?;
+    /// let new_cap = v.capacity();
+    /// assert_eq!(new_cap, cap);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocError> {
+        let len = self.len();
+        let cap = self.capacity();
+
+        if cap - len >= additional {
+            return Ok(());
+        }
+
+        if Self::is_zst() {
+            // The capacity is already `usize::MAX` for ZSTs, we can't go higher.
+            return Err(AllocError);
+        }
+
+        // We know that `cap <= isize::MAX` because of the type invariants of `Self`. So the
+        // multiplication by two won't overflow.
+        let new_cap = core::cmp::max(cap * 2, len.checked_add(additional).ok_or(AllocError)?);
+        let layout = ArrayLayout::new(new_cap).map_err(|_| AllocError)?;
+
+        // SAFETY:
+        // - `ptr` is valid because it's either `None` or comes from a previous call to
+        //   `A::realloc`.
+        // - `self.layout` matches the `ArrayLayout` of the preceding allocation.
+        let ptr = unsafe {
+            A::realloc(
+                Some(self.ptr.cast()),
+                layout.into(),
+                self.layout.into(),
+                flags,
+            )?
+        };
+
+        // INVARIANT:
+        // - `layout` is some `ArrayLayout::<T>`,
+        // - `ptr` has been created by `A::realloc` from `layout`.
+        self.ptr = ptr.cast();
+        self.layout = layout;
+
+        Ok(())
+    }
+}
+
+impl<T: Clone, A: Allocator> Vec<T, A> {
+    /// Extend the vector by `n` clones of `value`.
+    pub fn extend_with(&mut self, n: usize, value: T, flags: Flags) -> Result<(), AllocError> {
+        if n == 0 {
+            return Ok(());
+        }
+
+        self.reserve(n, flags)?;
+
+        let spare = self.spare_capacity_mut();
+
+        for item in spare.iter_mut().take(n - 1) {
+            item.write(value.clone());
+        }
+
+        // We can write the last element directly without cloning needlessly.
+        spare[n - 1].write(value);
+
+        // SAFETY:
+        // - `self.len() + n < self.capacity()` due to the call to reserve above,
+        // - the loop and the line above initialized the next `n` elements.
+        unsafe { self.set_len(self.len() + n) };
+
+        Ok(())
+    }
+
+    /// Pushes clones of the elements of slice into the [`Vec`] instance.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = KVec::new();
+    /// v.push(1, GFP_KERNEL)?;
+    ///
+    /// v.extend_from_slice(&[20, 30, 40], GFP_KERNEL)?;
+    /// assert_eq!(&v, &[1, 20, 30, 40]);
+    ///
+    /// v.extend_from_slice(&[50, 60], GFP_KERNEL)?;
+    /// assert_eq!(&v, &[1, 20, 30, 40, 50, 60]);
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn extend_from_slice(&mut self, other: &[T], flags: Flags) -> Result<(), AllocError> {
+        self.reserve(other.len(), flags)?;
+        for (slot, item) in core::iter::zip(self.spare_capacity_mut(), other) {
+            slot.write(item.clone());
+        }
+
+        // SAFETY:
+        // - `other.len()` spare entries have just been initialized, so it is safe to increase
+        //   the length by the same number.
+        // - `self.len() + other.len() <= self.capacity()` is guaranteed by the preceding `reserve`
+        //   call.
+        unsafe { self.set_len(self.len() + other.len()) };
+        Ok(())
+    }
+
+    /// Create a new `Vec<T, A>` and extend it by `n` clones of `value`.
+    pub fn from_elem(value: T, n: usize, flags: Flags) -> Result<Self, AllocError> {
+        let mut v = Self::with_capacity(n, flags)?;
+
+        v.extend_with(n, value, flags)?;
+
+        Ok(v)
+    }
+}
+
+impl<T, A> Drop for Vec<T, A>
+where
+    A: Allocator,
+{
+    fn drop(&mut self) {
+        // SAFETY: `self.as_mut_ptr` is guaranteed to be valid by the type invariant.
+        unsafe {
+            ptr::drop_in_place(core::ptr::slice_from_raw_parts_mut(
+                self.as_mut_ptr(),
+                self.len,
+            ))
+        };
+
+        // SAFETY:
+        // - `self.ptr` was previously allocated with `A`.
+        // - `self.layout` matches the `ArrayLayout` of the preceding allocation.
+        unsafe { A::free(self.ptr.cast(), self.layout.into()) };
+    }
+}
+
+impl<T, A, const N: usize> From<Box<[T; N], A>> for Vec<T, A>
+where
+    A: Allocator,
+{
+    fn from(b: Box<[T; N], A>) -> Vec<T, A> {
+        let len = b.len();
+        let ptr = Box::into_raw(b);
+
+        // SAFETY:
+        // - `b` has been allocated with `A`,
+        // - `ptr` fulfills the alignment requirements for `T`,
+        // - `ptr` points to memory with at least a size of `size_of::<T>() * len`,
+        // - all elements within `b` are initialized values of `T`,
+        // - `len` does not exceed `isize::MAX`.
+        unsafe { Vec::from_raw_parts(ptr as _, len, len) }
+    }
+}
+
+impl<T> Default for KVec<T> {
+    #[inline]
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl<T: fmt::Debug, A: Allocator> fmt::Debug for Vec<T, A> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        fmt::Debug::fmt(&**self, f)
+    }
+}
+
+impl<T, A> Deref for Vec<T, A>
+where
+    A: Allocator,
+{
+    type Target = [T];
+
+    #[inline]
+    fn deref(&self) -> &[T] {
+        // SAFETY: The memory behind `self.as_ptr()` is guaranteed to contain `self.len`
+        // initialized elements of type `T`.
+        unsafe { slice::from_raw_parts(self.as_ptr(), self.len) }
+    }
+}
+
+impl<T, A> DerefMut for Vec<T, A>
+where
+    A: Allocator,
+{
+    #[inline]
+    fn deref_mut(&mut self) -> &mut [T] {
+        // SAFETY: The memory behind `self.as_ptr()` is guaranteed to contain `self.len`
+        // initialized elements of type `T`.
+        unsafe { slice::from_raw_parts_mut(self.as_mut_ptr(), self.len) }
+    }
+}
+
+impl<T: Eq, A> Eq for Vec<T, A> where A: Allocator {}
+
+impl<T, I: SliceIndex<[T]>, A> Index<I> for Vec<T, A>
+where
+    A: Allocator,
+{
+    type Output = I::Output;
+
+    #[inline]
+    fn index(&self, index: I) -> &Self::Output {
+        Index::index(&**self, index)
+    }
+}
+
+impl<T, I: SliceIndex<[T]>, A> IndexMut<I> for Vec<T, A>
+where
+    A: Allocator,
+{
+    #[inline]
+    fn index_mut(&mut self, index: I) -> &mut Self::Output {
+        IndexMut::index_mut(&mut **self, index)
+    }
+}
+
+macro_rules! impl_slice_eq {
+    ($([$($vars:tt)*] $lhs:ty, $rhs:ty,)*) => {
+        $(
+            impl<T, U, $($vars)*> PartialEq<$rhs> for $lhs
+            where
+                T: PartialEq<U>,
+            {
+                #[inline]
+                fn eq(&self, other: &$rhs) -> bool { self[..] == other[..] }
+            }
+        )*
+    }
+}
+
+impl_slice_eq! {
+    [A1: Allocator, A2: Allocator] Vec<T, A1>, Vec<U, A2>,
+    [A: Allocator] Vec<T, A>, &[U],
+    [A: Allocator] Vec<T, A>, &mut [U],
+    [A: Allocator] &[T], Vec<U, A>,
+    [A: Allocator] &mut [T], Vec<U, A>,
+    [A: Allocator] Vec<T, A>, [U],
+    [A: Allocator] [T], Vec<U, A>,
+    [A: Allocator, const N: usize] Vec<T, A>, [U; N],
+    [A: Allocator, const N: usize] Vec<T, A>, &[U; N],
+}
+
+impl<'a, T, A> IntoIterator for &'a Vec<T, A>
+where
+    A: Allocator,
+{
+    type Item = &'a T;
+    type IntoIter = slice::Iter<'a, T>;
+
+    fn into_iter(self) -> Self::IntoIter {
+        self.iter()
+    }
+}
+
+impl<'a, T, A: Allocator> IntoIterator for &'a mut Vec<T, A>
+where
+    A: Allocator,
+{
+    type Item = &'a mut T;
+    type IntoIter = slice::IterMut<'a, T>;
+
+    fn into_iter(self) -> Self::IntoIter {
+        self.iter_mut()
+    }
+}
+
+/// An [`Iterator`] implementation for [`Vec`] that moves elements out of a vector.
+///
+/// This structure is created by the [`Vec::into_iter`] method on [`Vec`] (provided by the
+/// [`IntoIterator`] trait).
+///
+/// # Examples
+///
+/// ```
+/// let v = kernel::kvec![0, 1, 2]?;
+/// let iter = v.into_iter();
+///
+/// # Ok::<(), Error>(())
+/// ```
+pub struct IntoIter<T, A: Allocator> {
+    ptr: *mut T,
+    buf: NonNull<T>,
+    len: usize,
+    layout: ArrayLayout<T>,
+    _p: PhantomData<A>,
+}
+
+impl<T, A> IntoIter<T, A>
+where
+    A: Allocator,
+{
+    fn into_raw_parts(self) -> (*mut T, NonNull<T>, usize, usize) {
+        let me = ManuallyDrop::new(self);
+        let ptr = me.ptr;
+        let buf = me.buf;
+        let len = me.len;
+        let cap = me.layout.len();
+        (ptr, buf, len, cap)
+    }
+
+    /// Same as `Iterator::collect` but specialized for `Vec`'s `IntoIter`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let v = kernel::kvec![1, 2, 3]?;
+    /// let mut it = v.into_iter();
+    ///
+    /// assert_eq!(it.next(), Some(1));
+    ///
+    /// let v = it.collect(GFP_KERNEL);
+    /// assert_eq!(v, [2, 3]);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    ///
+    /// # Implementation details
+    ///
+    /// Currently, we can't implement `FromIterator`. There are a couple of issues with this trait
+    /// in the kernel, namely:
+    ///
+    /// - Rust's specialization feature is unstable. This prevents us to optimize for the special
+    ///   case where `I::IntoIter` equals `Vec`'s `IntoIter` type.
+    /// - We also can't use `I::IntoIter`'s type ID either to work around this, since `FromIterator`
+    ///   doesn't require this type to be `'static`.
+    /// - `FromIterator::from_iter` does return `Self` instead of `Result<Self, AllocError>`, hence
+    ///   we can't properly handle allocation failures.
+    /// - Neither `Iterator::collect` nor `FromIterator::from_iter` can handle additional allocation
+    ///   flags.
+    ///
+    /// Instead, provide `IntoIter::collect`, such that we can at least convert a `IntoIter` into a
+    /// `Vec` again.
+    ///
+    /// Note that `IntoIter::collect` doesn't require `Flags`, since it re-uses the existing backing
+    /// buffer. However, this backing buffer may be shrunk to the actual count of elements.
+    pub fn collect(self, flags: Flags) -> Vec<T, A> {
+        let old_layout = self.layout;
+        let (mut ptr, buf, len, mut cap) = self.into_raw_parts();
+        let has_advanced = ptr != buf.as_ptr();
+
+        if has_advanced {
+            // Copy the contents we have advanced to at the beginning of the buffer.
+            //
+            // SAFETY:
+            // - `ptr` is valid for reads of `len * size_of::<T>()` bytes,
+            // - `buf.as_ptr()` is valid for writes of `len * size_of::<T>()` bytes,
+            // - `ptr` and `buf.as_ptr()` are not be subject to aliasing restrictions relative to
+            //   each other,
+            // - both `ptr` and `buf.ptr()` are properly aligned.
+            unsafe { ptr::copy(ptr, buf.as_ptr(), len) };
+            ptr = buf.as_ptr();
+
+            // SAFETY: `len` is guaranteed to be smaller than `self.layout.len()`.
+            let layout = unsafe { ArrayLayout::<T>::new_unchecked(len) };
+
+            // SAFETY: `buf` points to the start of the backing buffer and `len` is guaranteed to be
+            // smaller than `cap`. Depending on `alloc` this operation may shrink the buffer or leaves
+            // it as it is.
+            ptr = match unsafe {
+                A::realloc(Some(buf.cast()), layout.into(), old_layout.into(), flags)
+            } {
+                // If we fail to shrink, which likely can't even happen, continue with the existing
+                // buffer.
+                Err(_) => ptr,
+                Ok(ptr) => {
+                    cap = len;
+                    ptr.as_ptr().cast()
+                }
+            };
+        }
+
+        // SAFETY: If the iterator has been advanced, the advanced elements have been copied to
+        // the beginning of the buffer and `len` has been adjusted accordingly.
+        //
+        // - `ptr` is guaranteed to point to the start of the backing buffer.
+        // - `cap` is either the original capacity or, after shrinking the buffer, equal to `len`.
+        // - `alloc` is guaranteed to be unchanged since `into_iter` has been called on the original
+        //   `Vec`.
+        unsafe { Vec::from_raw_parts(ptr, len, cap) }
+    }
+}
+
+impl<T, A> Iterator for IntoIter<T, A>
+where
+    A: Allocator,
+{
+    type Item = T;
+
+    /// # Examples
+    ///
+    /// ```
+    /// let v = kernel::kvec![1, 2, 3]?;
+    /// let mut it = v.into_iter();
+    ///
+    /// assert_eq!(it.next(), Some(1));
+    /// assert_eq!(it.next(), Some(2));
+    /// assert_eq!(it.next(), Some(3));
+    /// assert_eq!(it.next(), None);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    fn next(&mut self) -> Option<T> {
+        if self.len == 0 {
+            return None;
+        }
+
+        let current = self.ptr;
+
+        // SAFETY: We can't overflow; decreasing `self.len` by one every time we advance `self.ptr`
+        // by one guarantees that.
+        unsafe { self.ptr = self.ptr.add(1) };
+
+        self.len -= 1;
+
+        // SAFETY: `current` is guaranteed to point at a valid element within the buffer.
+        Some(unsafe { current.read() })
+    }
+
+    /// # Examples
+    ///
+    /// ```
+    /// let v: KVec<u32> = kernel::kvec![1, 2, 3]?;
+    /// let mut iter = v.into_iter();
+    /// let size = iter.size_hint().0;
+    ///
+    /// iter.next();
+    /// assert_eq!(iter.size_hint().0, size - 1);
+    ///
+    /// iter.next();
+    /// assert_eq!(iter.size_hint().0, size - 2);
+    ///
+    /// iter.next();
+    /// assert_eq!(iter.size_hint().0, size - 3);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    fn size_hint(&self) -> (usize, Option<usize>) {
+        (self.len, Some(self.len))
+    }
+}
+
+impl<T, A> Drop for IntoIter<T, A>
+where
+    A: Allocator,
+{
+    fn drop(&mut self) {
+        // SAFETY: `self.ptr` is guaranteed to be valid by the type invariant.
+        unsafe { ptr::drop_in_place(ptr::slice_from_raw_parts_mut(self.ptr, self.len)) };
+
+        // SAFETY:
+        // - `self.buf` was previously allocated with `A`.
+        // - `self.layout` matches the `ArrayLayout` of the preceding allocation.
+        unsafe { A::free(self.buf.cast(), self.layout.into()) };
+    }
+}
+
+impl<T, A> IntoIterator for Vec<T, A>
+where
+    A: Allocator,
+{
+    type Item = T;
+    type IntoIter = IntoIter<T, A>;
+
+    /// Consumes the `Vec<T, A>` and creates an `Iterator`, which moves each value out of the
+    /// vector (from start to end).
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let v = kernel::kvec![1, 2]?;
+    /// let mut v_iter = v.into_iter();
+    ///
+    /// let first_element: Option<u32> = v_iter.next();
+    ///
+    /// assert_eq!(first_element, Some(1));
+    /// assert_eq!(v_iter.next(), Some(2));
+    /// assert_eq!(v_iter.next(), None);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    ///
+    /// ```
+    /// let v = kernel::kvec![];
+    /// let mut v_iter = v.into_iter();
+    ///
+    /// let first_element: Option<u32> = v_iter.next();
+    ///
+    /// assert_eq!(first_element, None);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    #[inline]
+    fn into_iter(self) -> Self::IntoIter {
+        let buf = self.ptr;
+        let layout = self.layout;
+        let (ptr, len, _) = self.into_raw_parts();
+
+        IntoIter {
+            ptr,
+            buf,
+            len,
+            layout,
+            _p: PhantomData::<A>,
+        }
+    }
+}
diff --git a/rust/kernel/alloc/layout.rs b/rust/kernel/alloc/layout.rs
new file mode 100644
index 000000000000..4b3cd7fdc816
--- /dev/null
+++ b/rust/kernel/alloc/layout.rs
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Memory layout.
+//!
+//! Custom layout types extending or improving [`Layout`].
+
+use core::{alloc::Layout, marker::PhantomData};
+
+/// Error when constructing an [`ArrayLayout`].
+pub struct LayoutError;
+
+/// A layout for an array `[T; n]`.
+///
+/// # Invariants
+///
+/// - `len * size_of::<T>() <= isize::MAX`.
+pub struct ArrayLayout<T> {
+    len: usize,
+    _phantom: PhantomData<fn() -> T>,
+}
+
+impl<T> Clone for ArrayLayout<T> {
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+impl<T> Copy for ArrayLayout<T> {}
+
+const ISIZE_MAX: usize = isize::MAX as usize;
+
+impl<T> ArrayLayout<T> {
+    /// Creates a new layout for `[T; 0]`.
+    pub const fn empty() -> Self {
+        // INVARIANT: `0 * size_of::<T>() <= isize::MAX`.
+        Self {
+            len: 0,
+            _phantom: PhantomData,
+        }
+    }
+
+    /// Creates a new layout for `[T; len]`.
+    ///
+    /// # Errors
+    ///
+    /// When `len * size_of::<T>()` overflows or when `len * size_of::<T>() > isize::MAX`.
+    pub const fn new(len: usize) -> Result<Self, LayoutError> {
+        match len.checked_mul(core::mem::size_of::<T>()) {
+            Some(size) if size <= ISIZE_MAX => {
+                // INVARIANT: We checked above that `len * size_of::<T>() <= isize::MAX`.
+                Ok(Self {
+                    len,
+                    _phantom: PhantomData,
+                })
+            }
+            _ => Err(LayoutError),
+        }
+    }
+
+    /// Creates a new layout for `[T; len]`.
+    ///
+    /// # Safety
+    ///
+    /// `len` must be a value, for which `len * size_of::<T>() <= isize::MAX` is true.
+    pub unsafe fn new_unchecked(len: usize) -> Self {
+        // INVARIANT: By the safety requirements of this function
+        // `len * size_of::<T>() <= isize::MAX`.
+        Self {
+            len,
+            _phantom: PhantomData,
+        }
+    }
+
+    /// Returns the number of array elements represented by this layout.
+    pub const fn len(&self) -> usize {
+        self.len
+    }
+
+    /// Returns `true` when no array elements are represented by this layout.
+    pub const fn is_empty(&self) -> bool {
+        self.len == 0
+    }
+}
+
+impl<T> From<ArrayLayout<T>> for Layout {
+    fn from(value: ArrayLayout<T>) -> Self {
+        let res = Layout::array::<T>(value.len);
+        // SAFETY: By the type invariant of `ArrayLayout` we have
+        // `len * size_of::<T>() <= isize::MAX` and thus the result must be `Ok`.
+        unsafe { res.unwrap_unchecked() }
+    }
+}
diff --git a/rust/kernel/alloc/vec_ext.rs b/rust/kernel/alloc/vec_ext.rs
deleted file mode 100644
index 1297a4be32e8..000000000000
--- a/rust/kernel/alloc/vec_ext.rs
+++ /dev/null
@@ -1,185 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-//! Extensions to [`Vec`] for fallible allocations.
-
-use super::{AllocError, Flags};
-use alloc::vec::Vec;
-
-/// Extensions to [`Vec`].
-pub trait VecExt<T>: Sized {
-    /// Creates a new [`Vec`] instance with at least the given capacity.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// let v = Vec::<u32>::with_capacity(20, GFP_KERNEL)?;
-    ///
-    /// assert!(v.capacity() >= 20);
-    /// # Ok::<(), Error>(())
-    /// ```
-    fn with_capacity(capacity: usize, flags: Flags) -> Result<Self, AllocError>;
-
-    /// Appends an element to the back of the [`Vec`] instance.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// let mut v = Vec::new();
-    /// v.push(1, GFP_KERNEL)?;
-    /// assert_eq!(&v, &[1]);
-    ///
-    /// v.push(2, GFP_KERNEL)?;
-    /// assert_eq!(&v, &[1, 2]);
-    /// # Ok::<(), Error>(())
-    /// ```
-    fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError>;
-
-    /// Pushes clones of the elements of slice into the [`Vec`] instance.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// let mut v = Vec::new();
-    /// v.push(1, GFP_KERNEL)?;
-    ///
-    /// v.extend_from_slice(&[20, 30, 40], GFP_KERNEL)?;
-    /// assert_eq!(&v, &[1, 20, 30, 40]);
-    ///
-    /// v.extend_from_slice(&[50, 60], GFP_KERNEL)?;
-    /// assert_eq!(&v, &[1, 20, 30, 40, 50, 60]);
-    /// # Ok::<(), Error>(())
-    /// ```
-    fn extend_from_slice(&mut self, other: &[T], flags: Flags) -> Result<(), AllocError>
-    where
-        T: Clone;
-
-    /// Ensures that the capacity exceeds the length by at least `additional` elements.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// let mut v = Vec::new();
-    /// v.push(1, GFP_KERNEL)?;
-    ///
-    /// v.reserve(10, GFP_KERNEL)?;
-    /// let cap = v.capacity();
-    /// assert!(cap >= 10);
-    ///
-    /// v.reserve(10, GFP_KERNEL)?;
-    /// let new_cap = v.capacity();
-    /// assert_eq!(new_cap, cap);
-    ///
-    /// # Ok::<(), Error>(())
-    /// ```
-    fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocError>;
-}
-
-impl<T> VecExt<T> for Vec<T> {
-    fn with_capacity(capacity: usize, flags: Flags) -> Result<Self, AllocError> {
-        let mut v = Vec::new();
-        <Self as VecExt<_>>::reserve(&mut v, capacity, flags)?;
-        Ok(v)
-    }
-
-    fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
-        <Self as VecExt<_>>::reserve(self, 1, flags)?;
-        let s = self.spare_capacity_mut();
-        s[0].write(v);
-
-        // SAFETY: We just initialised the first spare entry, so it is safe to increase the length
-        // by 1. We also know that the new length is <= capacity because of the previous call to
-        // `reserve` above.
-        unsafe { self.set_len(self.len() + 1) };
-        Ok(())
-    }
-
-    fn extend_from_slice(&mut self, other: &[T], flags: Flags) -> Result<(), AllocError>
-    where
-        T: Clone,
-    {
-        <Self as VecExt<_>>::reserve(self, other.len(), flags)?;
-        for (slot, item) in core::iter::zip(self.spare_capacity_mut(), other) {
-            slot.write(item.clone());
-        }
-
-        // SAFETY: We just initialised the `other.len()` spare entries, so it is safe to increase
-        // the length by the same amount. We also know that the new length is <= capacity because
-        // of the previous call to `reserve` above.
-        unsafe { self.set_len(self.len() + other.len()) };
-        Ok(())
-    }
-
-    #[cfg(any(test, testlib))]
-    fn reserve(&mut self, additional: usize, _flags: Flags) -> Result<(), AllocError> {
-        Vec::reserve(self, additional);
-        Ok(())
-    }
-
-    #[cfg(not(any(test, testlib)))]
-    fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocError> {
-        let len = self.len();
-        let cap = self.capacity();
-
-        if cap - len >= additional {
-            return Ok(());
-        }
-
-        if core::mem::size_of::<T>() == 0 {
-            // The capacity is already `usize::MAX` for SZTs, we can't go higher.
-            return Err(AllocError);
-        }
-
-        // We know cap is <= `isize::MAX` because `Layout::array` fails if the resulting byte size
-        // is greater than `isize::MAX`. So the multiplication by two won't overflow.
-        let new_cap = core::cmp::max(cap * 2, len.checked_add(additional).ok_or(AllocError)?);
-        let layout = core::alloc::Layout::array::<T>(new_cap).map_err(|_| AllocError)?;
-
-        let (old_ptr, len, cap) = destructure(self);
-
-        // We need to make sure that `ptr` is either NULL or comes from a previous call to
-        // `krealloc_aligned`. A `Vec<T>`'s `ptr` value is not guaranteed to be NULL and might be
-        // dangling after being created with `Vec::new`. Instead, we can rely on `Vec<T>`'s capacity
-        // to be zero if no memory has been allocated yet.
-        let ptr = if cap == 0 {
-            core::ptr::null_mut()
-        } else {
-            old_ptr
-        };
-
-        // SAFETY: `ptr` is valid because it's either NULL or comes from a previous call to
-        // `krealloc_aligned`. We also verified that the type is not a ZST.
-        let new_ptr = unsafe { super::allocator::krealloc_aligned(ptr.cast(), layout, flags) };
-        if new_ptr.is_null() {
-            // SAFETY: We are just rebuilding the existing `Vec` with no changes.
-            unsafe { rebuild(self, old_ptr, len, cap) };
-            Err(AllocError)
-        } else {
-            // SAFETY: `ptr` has been reallocated with the layout for `new_cap` elements. New cap
-            // is greater than `cap`, so it continues to be >= `len`.
-            unsafe { rebuild(self, new_ptr.cast::<T>(), len, new_cap) };
-            Ok(())
-        }
-    }
-}
-
-#[cfg(not(any(test, testlib)))]
-fn destructure<T>(v: &mut Vec<T>) -> (*mut T, usize, usize) {
-    let mut tmp = Vec::new();
-    core::mem::swap(&mut tmp, v);
-    let mut tmp = core::mem::ManuallyDrop::new(tmp);
-    let len = tmp.len();
-    let cap = tmp.capacity();
-    (tmp.as_mut_ptr(), len, cap)
-}
-
-/// Rebuilds a `Vec` from a pointer, length, and capacity.
-///
-/// # Safety
-///
-/// The same as [`Vec::from_raw_parts`].
-#[cfg(not(any(test, testlib)))]
-unsafe fn rebuild<T>(v: &mut Vec<T>, ptr: *mut T, len: usize, cap: usize) {
-    // SAFETY: The safety requirements from this function satisfy those of `from_raw_parts`.
-    let mut tmp = unsafe { Vec::from_raw_parts(ptr, len, cap) };
-    core::mem::swap(&mut tmp, v);
-}
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 708125dce96a..c6df153ebb88 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -174,9 +174,9 @@ pub fn build<T: Operations>(
 ///
 /// # Invariants
 ///
-///  - `gendisk` must always point to an initialized and valid `struct gendisk`.
-///  - `gendisk` was added to the VFS through a call to
-///     `bindings::device_add_disk`.
+/// - `gendisk` must always point to an initialized and valid `struct gendisk`.
+/// - `gendisk` was added to the VFS through a call to
+///   `bindings::device_add_disk`.
 pub struct GenDisk<T: Operations> {
     _tagset: Arc<TagSet<T>>,
     gendisk: *mut bindings::gendisk,
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 9ba7fdfeb4b2..c8646d0d9866 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -131,7 +131,7 @@ impl<T: Operations> OperationsVTable<T> {
     unsafe extern "C" fn poll_callback(
         _hctx: *mut bindings::blk_mq_hw_ctx,
         _iob: *mut bindings::io_comp_batch,
-    ) -> core::ffi::c_int {
+    ) -> crate::ffi::c_int {
         T::poll().into()
     }
 
@@ -145,9 +145,9 @@ impl<T: Operations> OperationsVTable<T> {
     /// for the same context.
     unsafe extern "C" fn init_hctx_callback(
         _hctx: *mut bindings::blk_mq_hw_ctx,
-        _tagset_data: *mut core::ffi::c_void,
-        _hctx_idx: core::ffi::c_uint,
-    ) -> core::ffi::c_int {
+        _tagset_data: *mut crate::ffi::c_void,
+        _hctx_idx: crate::ffi::c_uint,
+    ) -> crate::ffi::c_int {
         from_result(|| Ok(0))
     }
 
@@ -159,7 +159,7 @@ impl<T: Operations> OperationsVTable<T> {
     /// This function may only be called by blk-mq C infrastructure.
     unsafe extern "C" fn exit_hctx_callback(
         _hctx: *mut bindings::blk_mq_hw_ctx,
-        _hctx_idx: core::ffi::c_uint,
+        _hctx_idx: crate::ffi::c_uint,
     ) {
     }
 
@@ -176,9 +176,9 @@ impl<T: Operations> OperationsVTable<T> {
     unsafe extern "C" fn init_request_callback(
         _set: *mut bindings::blk_mq_tag_set,
         rq: *mut bindings::request,
-        _hctx_idx: core::ffi::c_uint,
-        _numa_node: core::ffi::c_uint,
-    ) -> core::ffi::c_int {
+        _hctx_idx: crate::ffi::c_uint,
+        _numa_node: crate::ffi::c_uint,
+    ) -> crate::ffi::c_int {
         from_result(|| {
             // SAFETY: By the safety requirements of this function, `rq` points
             // to a valid allocation.
@@ -203,7 +203,7 @@ impl<T: Operations> OperationsVTable<T> {
     unsafe extern "C" fn exit_request_callback(
         _set: *mut bindings::blk_mq_tag_set,
         rq: *mut bindings::request,
-        _hctx_idx: core::ffi::c_uint,
+        _hctx_idx: crate::ffi::c_uint,
     ) {
         // SAFETY: The tagset invariants guarantee that all requests are allocated with extra memory
         // for the request data.
diff --git a/rust/kernel/block/mq/raw_writer.rs b/rust/kernel/block/mq/raw_writer.rs
index 9222465d670b..7e2159e4f6a6 100644
--- a/rust/kernel/block/mq/raw_writer.rs
+++ b/rust/kernel/block/mq/raw_writer.rs
@@ -25,7 +25,7 @@ fn new(buffer: &'a mut [u8]) -> Result<RawWriter<'a>> {
     }
 
     pub(crate) fn from_array<const N: usize>(
-        a: &'a mut [core::ffi::c_char; N],
+        a: &'a mut [crate::ffi::c_char; N],
     ) -> Result<RawWriter<'a>> {
         Self::new(
             // SAFETY: the buffer of `a` is valid for read and write as `u8` for
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index f9a1ca655a35..d7f175a05d99 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -53,7 +53,7 @@ pub fn new(
                     queue_depth: num_tags,
                     cmd_size,
                     flags: bindings::BLK_MQ_F_SHOULD_MERGE,
-                    driver_data: core::ptr::null_mut::<core::ffi::c_void>(),
+                    driver_data: core::ptr::null_mut::<crate::ffi::c_void>(),
                     nr_maps: num_maps,
                     ..tag_set
                 }
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 6f1587a2524e..5fece574ec02 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -6,9 +6,10 @@
 
 use crate::{alloc::AllocError, str::CStr};
 
-use alloc::alloc::LayoutError;
+use core::alloc::LayoutError;
 
 use core::fmt;
+use core::num::NonZeroI32;
 use core::num::TryFromIntError;
 use core::str::Utf8Error;
 
@@ -20,7 +21,11 @@ macro_rules! declare_err {
             $(
             #[doc = $doc]
             )*
-            pub const $err: super::Error = super::Error(-(crate::bindings::$err as i32));
+            pub const $err: super::Error =
+                match super::Error::try_from_errno(-(crate::bindings::$err as i32)) {
+                    Some(err) => err,
+                    None => panic!("Invalid errno in `declare_err!`"),
+                };
         };
     }
 
@@ -88,14 +93,14 @@ macro_rules! declare_err {
 ///
 /// The value is a valid `errno` (i.e. `>= -MAX_ERRNO && < 0`).
 #[derive(Clone, Copy, PartialEq, Eq)]
-pub struct Error(core::ffi::c_int);
+pub struct Error(NonZeroI32);
 
 impl Error {
     /// Creates an [`Error`] from a kernel error code.
     ///
     /// It is a bug to pass an out-of-range `errno`. `EINVAL` would
     /// be returned in such a case.
-    pub(crate) fn from_errno(errno: core::ffi::c_int) -> Error {
+    pub fn from_errno(errno: crate::ffi::c_int) -> Error {
         if errno < -(bindings::MAX_ERRNO as i32) || errno >= 0 {
             // TODO: Make it a `WARN_ONCE` once available.
             crate::pr_warn!(
@@ -107,7 +112,20 @@ pub(crate) fn from_errno(errno: core::ffi::c_int) -> Error {
 
         // INVARIANT: The check above ensures the type invariant
         // will hold.
-        Error(errno)
+        // SAFETY: `errno` is checked above to be in a valid range.
+        unsafe { Error::from_errno_unchecked(errno) }
+    }
+
+    /// Creates an [`Error`] from a kernel error code.
+    ///
+    /// Returns [`None`] if `errno` is out-of-range.
+    const fn try_from_errno(errno: crate::ffi::c_int) -> Option<Error> {
+        if errno < -(bindings::MAX_ERRNO as i32) || errno >= 0 {
+            return None;
+        }
+
+        // SAFETY: `errno` is checked above to be in a valid range.
+        Some(unsafe { Error::from_errno_unchecked(errno) })
     }
 
     /// Creates an [`Error`] from a kernel error code.
@@ -115,38 +133,35 @@ pub(crate) fn from_errno(errno: core::ffi::c_int) -> Error {
     /// # Safety
     ///
     /// `errno` must be within error code range (i.e. `>= -MAX_ERRNO && < 0`).
-    unsafe fn from_errno_unchecked(errno: core::ffi::c_int) -> Error {
+    const unsafe fn from_errno_unchecked(errno: crate::ffi::c_int) -> Error {
         // INVARIANT: The contract ensures the type invariant
         // will hold.
-        Error(errno)
+        // SAFETY: The caller guarantees `errno` is non-zero.
+        Error(unsafe { NonZeroI32::new_unchecked(errno) })
     }
 
     /// Returns the kernel error code.
-    pub fn to_errno(self) -> core::ffi::c_int {
-        self.0
+    pub fn to_errno(self) -> crate::ffi::c_int {
+        self.0.get()
     }
 
     #[cfg(CONFIG_BLOCK)]
     pub(crate) fn to_blk_status(self) -> bindings::blk_status_t {
         // SAFETY: `self.0` is a valid error due to its invariant.
-        unsafe { bindings::errno_to_blk_status(self.0) }
+        unsafe { bindings::errno_to_blk_status(self.0.get()) }
     }
 
     /// Returns the error encoded as a pointer.
-    #[allow(dead_code)]
-    pub(crate) fn to_ptr<T>(self) -> *mut T {
-        #[cfg_attr(target_pointer_width = "32", allow(clippy::useless_conversion))]
+    pub fn to_ptr<T>(self) -> *mut T {
         // SAFETY: `self.0` is a valid error due to its invariant.
-        unsafe {
-            bindings::ERR_PTR(self.0.into()) as *mut _
-        }
+        unsafe { bindings::ERR_PTR(self.0.get() as _) as *mut _ }
     }
 
     /// Returns a string representing the error, if one exists.
-    #[cfg(not(testlib))]
+    #[cfg(not(any(test, testlib)))]
     pub fn name(&self) -> Option<&'static CStr> {
         // SAFETY: Just an FFI call, there are no extra safety requirements.
-        let ptr = unsafe { bindings::errname(-self.0) };
+        let ptr = unsafe { bindings::errname(-self.0.get()) };
         if ptr.is_null() {
             None
         } else {
@@ -160,7 +175,7 @@ pub fn name(&self) -> Option<&'static CStr> {
     /// When `testlib` is configured, this always returns `None` to avoid the dependency on a
     /// kernel function so that tests that use this (e.g., by calling [`Result::unwrap`]) can still
     /// run in userspace.
-    #[cfg(testlib)]
+    #[cfg(any(test, testlib))]
     pub fn name(&self) -> Option<&'static CStr> {
         None
     }
@@ -171,9 +186,11 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         match self.name() {
             // Print out number if no name can be found.
             None => f.debug_tuple("Error").field(&-self.0).finish(),
-            // SAFETY: These strings are ASCII-only.
             Some(name) => f
-                .debug_tuple(unsafe { core::str::from_utf8_unchecked(name) })
+                .debug_tuple(
+                    // SAFETY: These strings are ASCII-only.
+                    unsafe { core::str::from_utf8_unchecked(name) },
+                )
                 .finish(),
         }
     }
@@ -239,7 +256,7 @@ fn from(e: core::convert::Infallible) -> Error {
 
 /// Converts an integer as returned by a C kernel function to an error if it's negative, and
 /// `Ok(())` otherwise.
-pub fn to_result(err: core::ffi::c_int) -> Result {
+pub fn to_result(err: crate::ffi::c_int) -> Result {
     if err < 0 {
         Err(Error::from_errno(err))
     } else {
@@ -262,21 +279,21 @@ pub fn to_result(err: core::ffi::c_int) -> Result {
 /// fn devm_platform_ioremap_resource(
 ///     pdev: &mut PlatformDevice,
 ///     index: u32,
-/// ) -> Result<*mut core::ffi::c_void> {
+/// ) -> Result<*mut kernel::ffi::c_void> {
 ///     // SAFETY: `pdev` points to a valid platform device. There are no safety requirements
 ///     // on `index`.
 ///     from_err_ptr(unsafe { bindings::devm_platform_ioremap_resource(pdev.to_ptr(), index) })
 /// }
 /// ```
-// TODO: Remove `dead_code` marker once an in-kernel client is available.
-#[allow(dead_code)]
-pub(crate) fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
-    // CAST: Casting a pointer to `*const core::ffi::c_void` is always valid.
-    let const_ptr: *const core::ffi::c_void = ptr.cast();
+pub fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
+    // CAST: Casting a pointer to `*const crate::ffi::c_void` is always valid.
+    let const_ptr: *const crate::ffi::c_void = ptr.cast();
     // SAFETY: The FFI function does not deref the pointer.
     if unsafe { bindings::IS_ERR(const_ptr) } {
         // SAFETY: The FFI function does not deref the pointer.
         let err = unsafe { bindings::PTR_ERR(const_ptr) };
+
+        #[allow(clippy::unnecessary_cast)]
         // CAST: If `IS_ERR()` returns `true`,
         // then `PTR_ERR()` is guaranteed to return a
         // negative value greater-or-equal to `-bindings::MAX_ERRNO`,
@@ -286,8 +303,7 @@ pub(crate) fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
         //
         // SAFETY: `IS_ERR()` ensures `err` is a
         // negative value greater-or-equal to `-bindings::MAX_ERRNO`.
-        #[allow(clippy::unnecessary_cast)]
-        return Err(unsafe { Error::from_errno_unchecked(err as core::ffi::c_int) });
+        return Err(unsafe { Error::from_errno_unchecked(err as crate::ffi::c_int) });
     }
     Ok(ptr)
 }
@@ -307,7 +323,7 @@ pub(crate) fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
 /// # use kernel::bindings;
 /// unsafe extern "C" fn probe_callback(
 ///     pdev: *mut bindings::platform_device,
-/// ) -> core::ffi::c_int {
+/// ) -> kernel::ffi::c_int {
 ///     from_result(|| {
 ///         let ptr = devm_alloc(pdev)?;
 ///         bindings::platform_set_drvdata(pdev, ptr);
@@ -315,9 +331,7 @@ pub(crate) fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
 ///     })
 /// }
 /// ```
-// TODO: Remove `dead_code` marker once an in-kernel client is available.
-#[allow(dead_code)]
-pub(crate) fn from_result<T, F>(f: F) -> T
+pub fn from_result<T, F>(f: F) -> T
 where
     T: From<i16>,
     F: FnOnce() -> Result<T>,
diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index 13a374a5cdb7..c5162fdc95ff 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -12,7 +12,7 @@
 /// One of the following: `bindings::request_firmware`, `bindings::firmware_request_nowarn`,
 /// `bindings::firmware_request_platform`, `bindings::request_firmware_direct`.
 struct FwFunc(
-    unsafe extern "C" fn(*mut *const bindings::firmware, *const i8, *mut bindings::device) -> i32,
+    unsafe extern "C" fn(*mut *const bindings::firmware, *const u8, *mut bindings::device) -> i32,
 );
 
 impl FwFunc {
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 789f80f71ca7..c962029f96e1 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -13,7 +13,7 @@
 //! To initialize a `struct` with an in-place constructor you will need two things:
 //! - an in-place constructor,
 //! - a memory location that can hold your `struct` (this can be the [stack], an [`Arc<T>`],
-//!   [`UniqueArc<T>`], [`Box<T>`] or any other smart pointer that implements [`InPlaceInit`]).
+//!   [`UniqueArc<T>`], [`KBox<T>`] or any other smart pointer that implements [`InPlaceInit`]).
 //!
 //! To get an in-place constructor there are generally three options:
 //! - directly creating an in-place constructor using the [`pin_init!`] macro,
@@ -35,7 +35,7 @@
 //! that you need to write `<-` instead of `:` for fields that you want to initialize in-place.
 //!
 //! ```rust
-//! # #![allow(clippy::disallowed_names)]
+//! # #![expect(clippy::disallowed_names)]
 //! use kernel::sync::{new_mutex, Mutex};
 //! # use core::pin::Pin;
 //! #[pin_data]
@@ -55,7 +55,7 @@
 //! (or just the stack) to actually initialize a `Foo`:
 //!
 //! ```rust
-//! # #![allow(clippy::disallowed_names)]
+//! # #![expect(clippy::disallowed_names)]
 //! # use kernel::sync::{new_mutex, Mutex};
 //! # use core::pin::Pin;
 //! # #[pin_data]
@@ -68,7 +68,7 @@
 //! #     a <- new_mutex!(42, "Foo::a"),
 //! #     b: 24,
 //! # });
-//! let foo: Result<Pin<Box<Foo>>> = Box::pin_init(foo, GFP_KERNEL);
+//! let foo: Result<Pin<KBox<Foo>>> = KBox::pin_init(foo, GFP_KERNEL);
 //! ```
 //!
 //! For more information see the [`pin_init!`] macro.
@@ -87,20 +87,19 @@
 //! To declare an init macro/function you just return an [`impl PinInit<T, E>`]:
 //!
 //! ```rust
-//! # #![allow(clippy::disallowed_names)]
 //! # use kernel::{sync::Mutex, new_mutex, init::PinInit, try_pin_init};
 //! #[pin_data]
 //! struct DriverData {
 //!     #[pin]
 //!     status: Mutex<i32>,
-//!     buffer: Box<[u8; 1_000_000]>,
+//!     buffer: KBox<[u8; 1_000_000]>,
 //! }
 //!
 //! impl DriverData {
 //!     fn new() -> impl PinInit<Self, Error> {
 //!         try_pin_init!(Self {
 //!             status <- new_mutex!(0, "DriverData::status"),
-//!             buffer: Box::init(kernel::init::zeroed(), GFP_KERNEL)?,
+//!             buffer: KBox::init(kernel::init::zeroed(), GFP_KERNEL)?,
 //!         })
 //!     }
 //! }
@@ -121,11 +120,12 @@
 //!   `slot` gets called.
 //!
 //! ```rust
-//! # #![allow(unreachable_pub, clippy::disallowed_names)]
+//! # #![expect(unreachable_pub, clippy::disallowed_names)]
 //! use kernel::{init, types::Opaque};
 //! use core::{ptr::addr_of_mut, marker::PhantomPinned, pin::Pin};
 //! # mod bindings {
-//! #     #![allow(non_camel_case_types)]
+//! #     #![expect(non_camel_case_types)]
+//! #     #![expect(clippy::missing_safety_doc)]
 //! #     pub struct foo;
 //! #     pub unsafe fn init_foo(_ptr: *mut foo) {}
 //! #     pub unsafe fn destroy_foo(_ptr: *mut foo) {}
@@ -133,7 +133,7 @@
 //! # }
 //! # // `Error::from_errno` is `pub(crate)` in the `kernel` crate, thus provide a workaround.
 //! # trait FromErrno {
-//! #     fn from_errno(errno: core::ffi::c_int) -> Error {
+//! #     fn from_errno(errno: kernel::ffi::c_int) -> Error {
 //! #         // Dummy error that can be constructed outside the `kernel` crate.
 //! #         Error::from(core::fmt::Error)
 //! #     }
@@ -211,13 +211,12 @@
 //! [`pin_init!`]: crate::pin_init!
 
 use crate::{
-    alloc::{box_ext::BoxExt, AllocError, Flags},
+    alloc::{AllocError, Flags, KBox},
     error::{self, Error},
     sync::Arc,
     sync::UniqueArc,
     types::{Opaque, ScopeGuard},
 };
-use alloc::boxed::Box;
 use core::{
     cell::UnsafeCell,
     convert::Infallible,
@@ -238,7 +237,7 @@
 /// # Examples
 ///
 /// ```rust
-/// # #![allow(clippy::disallowed_names)]
+/// # #![expect(clippy::disallowed_names)]
 /// # use kernel::{init, macros::pin_data, pin_init, stack_pin_init, init::*, sync::Mutex, new_mutex};
 /// # use core::pin::Pin;
 /// #[pin_data]
@@ -290,7 +289,7 @@ macro_rules! stack_pin_init {
 /// # Examples
 ///
 /// ```rust,ignore
-/// # #![allow(clippy::disallowed_names)]
+/// # #![expect(clippy::disallowed_names)]
 /// # use kernel::{init, pin_init, stack_try_pin_init, init::*, sync::Mutex, new_mutex};
 /// # use macros::pin_data;
 /// # use core::{alloc::AllocError, pin::Pin};
@@ -298,7 +297,7 @@ macro_rules! stack_pin_init {
 /// struct Foo {
 ///     #[pin]
 ///     a: Mutex<usize>,
-///     b: Box<Bar>,
+///     b: KBox<Bar>,
 /// }
 ///
 /// struct Bar {
@@ -307,7 +306,7 @@ macro_rules! stack_pin_init {
 ///
 /// stack_try_pin_init!(let foo: Result<Pin<&mut Foo>, AllocError> = pin_init!(Foo {
 ///     a <- new_mutex!(42),
-///     b: Box::new(Bar {
+///     b: KBox::new(Bar {
 ///         x: 64,
 ///     }, GFP_KERNEL)?,
 /// }));
@@ -316,7 +315,7 @@ macro_rules! stack_pin_init {
 /// ```
 ///
 /// ```rust,ignore
-/// # #![allow(clippy::disallowed_names)]
+/// # #![expect(clippy::disallowed_names)]
 /// # use kernel::{init, pin_init, stack_try_pin_init, init::*, sync::Mutex, new_mutex};
 /// # use macros::pin_data;
 /// # use core::{alloc::AllocError, pin::Pin};
@@ -324,7 +323,7 @@ macro_rules! stack_pin_init {
 /// struct Foo {
 ///     #[pin]
 ///     a: Mutex<usize>,
-///     b: Box<Bar>,
+///     b: KBox<Bar>,
 /// }
 ///
 /// struct Bar {
@@ -333,7 +332,7 @@ macro_rules! stack_pin_init {
 ///
 /// stack_try_pin_init!(let foo: Pin<&mut Foo> =? pin_init!(Foo {
 ///     a <- new_mutex!(42),
-///     b: Box::new(Bar {
+///     b: KBox::new(Bar {
 ///         x: 64,
 ///     }, GFP_KERNEL)?,
 /// }));
@@ -368,7 +367,6 @@ macro_rules! stack_try_pin_init {
 /// The syntax is almost identical to that of a normal `struct` initializer:
 ///
 /// ```rust
-/// # #![allow(clippy::disallowed_names)]
 /// # use kernel::{init, pin_init, macros::pin_data, init::*};
 /// # use core::pin::Pin;
 /// #[pin_data]
@@ -392,7 +390,7 @@ macro_rules! stack_try_pin_init {
 ///     },
 /// });
 /// # initializer }
-/// # Box::pin_init(demo(), GFP_KERNEL).unwrap();
+/// # KBox::pin_init(demo(), GFP_KERNEL).unwrap();
 /// ```
 ///
 /// Arbitrary Rust expressions can be used to set the value of a variable.
@@ -413,7 +411,6 @@ macro_rules! stack_try_pin_init {
 /// To create an initializer function, simply declare it like this:
 ///
 /// ```rust
-/// # #![allow(clippy::disallowed_names)]
 /// # use kernel::{init, pin_init, init::*};
 /// # use core::pin::Pin;
 /// # #[pin_data]
@@ -440,7 +437,7 @@ macro_rules! stack_try_pin_init {
 /// Users of `Foo` can now create it like this:
 ///
 /// ```rust
-/// # #![allow(clippy::disallowed_names)]
+/// # #![expect(clippy::disallowed_names)]
 /// # use kernel::{init, pin_init, macros::pin_data, init::*};
 /// # use core::pin::Pin;
 /// # #[pin_data]
@@ -462,13 +459,12 @@ macro_rules! stack_try_pin_init {
 /// #         })
 /// #     }
 /// # }
-/// let foo = Box::pin_init(Foo::new(), GFP_KERNEL);
+/// let foo = KBox::pin_init(Foo::new(), GFP_KERNEL);
 /// ```
 ///
 /// They can also easily embed it into their own `struct`s:
 ///
 /// ```rust
-/// # #![allow(clippy::disallowed_names)]
 /// # use kernel::{init, pin_init, macros::pin_data, init::*};
 /// # use core::pin::Pin;
 /// # #[pin_data]
@@ -541,6 +537,7 @@ macro_rules! stack_try_pin_init {
 /// }
 /// pin_init!(&this in Buf {
 ///     buf: [0; 64],
+///     // SAFETY: TODO.
 ///     ptr: unsafe { addr_of_mut!((*this.as_ptr()).buf).cast() },
 ///     pin: PhantomPinned,
 /// });
@@ -590,11 +587,10 @@ macro_rules! pin_init {
 /// # Examples
 ///
 /// ```rust
-/// # #![feature(new_uninit)]
 /// use kernel::{init::{self, PinInit}, error::Error};
 /// #[pin_data]
 /// struct BigBuf {
-///     big: Box<[u8; 1024 * 1024 * 1024]>,
+///     big: KBox<[u8; 1024 * 1024 * 1024]>,
 ///     small: [u8; 1024 * 1024],
 ///     ptr: *mut u8,
 /// }
@@ -602,7 +598,7 @@ macro_rules! pin_init {
 /// impl BigBuf {
 ///     fn new() -> impl PinInit<Self, Error> {
 ///         try_pin_init!(Self {
-///             big: Box::init(init::zeroed(), GFP_KERNEL)?,
+///             big: KBox::init(init::zeroed(), GFP_KERNEL)?,
 ///             small: [0; 1024 * 1024],
 ///             ptr: core::ptr::null_mut(),
 ///         }? Error)
@@ -694,16 +690,16 @@ macro_rules! init {
 /// # Examples
 ///
 /// ```rust
-/// use kernel::{init::{PinInit, zeroed}, error::Error};
+/// use kernel::{alloc::KBox, init::{PinInit, zeroed}, error::Error};
 /// struct BigBuf {
-///     big: Box<[u8; 1024 * 1024 * 1024]>,
+///     big: KBox<[u8; 1024 * 1024 * 1024]>,
 ///     small: [u8; 1024 * 1024],
 /// }
 ///
 /// impl BigBuf {
 ///     fn new() -> impl Init<Self, Error> {
 ///         try_init!(Self {
-///             big: Box::init(zeroed(), GFP_KERNEL)?,
+///             big: KBox::init(zeroed(), GFP_KERNEL)?,
 ///             small: [0; 1024 * 1024],
 ///         }? Error)
 ///     }
@@ -814,8 +810,8 @@ macro_rules! assert_pinned {
 /// A pin-initializer for the type `T`.
 ///
 /// To use this initializer, you will need a suitable memory location that can hold a `T`. This can
-/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`] or even the stack (see [`stack_pin_init!`]). Use the
-/// [`InPlaceInit::pin_init`] function of a smart pointer like [`Arc<T>`] on this.
+/// be [`KBox<T>`], [`Arc<T>`], [`UniqueArc<T>`] or even the stack (see [`stack_pin_init!`]). Use
+/// the [`InPlaceInit::pin_init`] function of a smart pointer like [`Arc<T>`] on this.
 ///
 /// Also see the [module description](self).
 ///
@@ -854,7 +850,7 @@ pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
     /// # Examples
     ///
     /// ```rust
-    /// # #![allow(clippy::disallowed_names)]
+    /// # #![expect(clippy::disallowed_names)]
     /// use kernel::{types::Opaque, init::pin_init_from_closure};
     /// #[repr(C)]
     /// struct RawFoo([u8; 16]);
@@ -875,6 +871,7 @@ pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
     /// }
     ///
     /// let foo = pin_init!(Foo {
+    ///     // SAFETY: TODO.
     ///     raw <- unsafe {
     ///         Opaque::ffi_init(|s| {
     ///             init_foo(s);
@@ -894,7 +891,7 @@ fn pin_chain<F>(self, f: F) -> ChainPinInit<Self, F, T, E>
 }
 
 /// An initializer returned by [`PinInit::pin_chain`].
-pub struct ChainPinInit<I, F, T: ?Sized, E>(I, F, __internal::Invariant<(E, Box<T>)>);
+pub struct ChainPinInit<I, F, T: ?Sized, E>(I, F, __internal::Invariant<(E, KBox<T>)>);
 
 // SAFETY: The `__pinned_init` function is implemented such that it
 // - returns `Ok(())` on successful initialization,
@@ -920,8 +917,8 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
 /// An initializer for `T`.
 ///
 /// To use this initializer, you will need a suitable memory location that can hold a `T`. This can
-/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`] or even the stack (see [`stack_pin_init!`]). Use the
-/// [`InPlaceInit::init`] function of a smart pointer like [`Arc<T>`] on this. Because
+/// be [`KBox<T>`], [`Arc<T>`], [`UniqueArc<T>`] or even the stack (see [`stack_pin_init!`]). Use
+/// the [`InPlaceInit::init`] function of a smart pointer like [`Arc<T>`] on this. Because
 /// [`PinInit<T, E>`] is a super trait, you can use every function that takes it as well.
 ///
 /// Also see the [module description](self).
@@ -965,7 +962,7 @@ pub unsafe trait Init<T: ?Sized, E = Infallible>: PinInit<T, E> {
     /// # Examples
     ///
     /// ```rust
-    /// # #![allow(clippy::disallowed_names)]
+    /// # #![expect(clippy::disallowed_names)]
     /// use kernel::{types::Opaque, init::{self, init_from_closure}};
     /// struct Foo {
     ///     buf: [u8; 1_000_000],
@@ -993,7 +990,7 @@ fn chain<F>(self, f: F) -> ChainInit<Self, F, T, E>
 }
 
 /// An initializer returned by [`Init::chain`].
-pub struct ChainInit<I, F, T: ?Sized, E>(I, F, __internal::Invariant<(E, Box<T>)>);
+pub struct ChainInit<I, F, T: ?Sized, E>(I, F, __internal::Invariant<(E, KBox<T>)>);
 
 // SAFETY: The `__init` function is implemented such that it
 // - returns `Ok(())` on successful initialization,
@@ -1077,8 +1074,9 @@ pub fn uninit<T, E>() -> impl Init<MaybeUninit<T>, E> {
 /// # Examples
 ///
 /// ```rust
-/// use kernel::{error::Error, init::init_array_from_fn};
-/// let array: Box<[usize; 1_000]> = Box::init::<Error>(init_array_from_fn(|i| i), GFP_KERNEL).unwrap();
+/// use kernel::{alloc::KBox, error::Error, init::init_array_from_fn};
+/// let array: KBox<[usize; 1_000]> =
+///     KBox::init::<Error>(init_array_from_fn(|i| i), GFP_KERNEL).unwrap();
 /// assert_eq!(array.len(), 1_000);
 /// ```
 pub fn init_array_from_fn<I, const N: usize, T, E>(
@@ -1162,6 +1160,7 @@ pub fn pin_init_array_from_fn<I, const N: usize, T, E>(
 // SAFETY: Every type can be initialized by-value.
 unsafe impl<T, E> Init<T, E> for T {
     unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
+        // SAFETY: TODO.
         unsafe { slot.write(self) };
         Ok(())
     }
@@ -1170,6 +1169,7 @@ unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
 // SAFETY: Every type can be initialized by-value. `__pinned_init` calls `__init`.
 unsafe impl<T, E> PinInit<T, E> for T {
     unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
+        // SAFETY: TODO.
         unsafe { self.__init(slot) }
     }
 }
@@ -1243,26 +1243,6 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
     }
 }
 
-impl<T> InPlaceInit<T> for Box<T> {
-    type PinnedSelf = Pin<Self>;
-
-    #[inline]
-    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Self::PinnedSelf, E>
-    where
-        E: From<AllocError>,
-    {
-        <Box<_> as BoxExt<_>>::new_uninit(flags)?.write_pin_init(init)
-    }
-
-    #[inline]
-    fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
-    where
-        E: From<AllocError>,
-    {
-        <Box<_> as BoxExt<_>>::new_uninit(flags)?.write_init(init)
-    }
-}
-
 impl<T> InPlaceInit<T> for UniqueArc<T> {
     type PinnedSelf = Pin<Self>;
 
@@ -1299,28 +1279,6 @@ pub trait InPlaceWrite<T> {
     fn write_pin_init<E>(self, init: impl PinInit<T, E>) -> Result<Pin<Self::Initialized>, E>;
 }
 
-impl<T> InPlaceWrite<T> for Box<MaybeUninit<T>> {
-    type Initialized = Box<T>;
-
-    fn write_init<E>(mut self, init: impl Init<T, E>) -> Result<Self::Initialized, E> {
-        let slot = self.as_mut_ptr();
-        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
-        // slot is valid.
-        unsafe { init.__init(slot)? };
-        // SAFETY: All fields have been initialized.
-        Ok(unsafe { self.assume_init() })
-    }
-
-    fn write_pin_init<E>(mut self, init: impl PinInit<T, E>) -> Result<Pin<Self::Initialized>, E> {
-        let slot = self.as_mut_ptr();
-        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
-        // slot is valid and will not be moved, because we pin it later.
-        unsafe { init.__pinned_init(slot)? };
-        // SAFETY: All fields have been initialized.
-        Ok(unsafe { self.assume_init() }.into())
-    }
-}
-
 impl<T> InPlaceWrite<T> for UniqueArc<MaybeUninit<T>> {
     type Initialized = UniqueArc<T>;
 
@@ -1411,6 +1369,7 @@ pub fn zeroed<T: Zeroable>() -> impl Init<T> {
 
 macro_rules! impl_zeroable {
     ($($({$($generics:tt)*})? $t:ty, )*) => {
+        // SAFETY: Safety comments written in the macro invocation.
         $(unsafe impl$($($generics)*)? Zeroable for $t {})*
     };
 }
@@ -1451,7 +1410,7 @@ macro_rules! impl_zeroable {
     //
     // In this case we are allowed to use `T: ?Sized`, since all zeros is the `None` variant.
     {<T: ?Sized>} Option<NonNull<T>>,
-    {<T: ?Sized>} Option<Box<T>>,
+    {<T: ?Sized>} Option<KBox<T>>,
 
     // SAFETY: `null` pointer is valid.
     //
diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__internal.rs
index 13cefd37512f..74329cc3262c 100644
--- a/rust/kernel/init/__internal.rs
+++ b/rust/kernel/init/__internal.rs
@@ -15,9 +15,10 @@
 /// [this table]: https://doc.rust-lang.org/nomicon/phantom-data.html#table-of-phantomdata-patterns
 pub(super) type Invariant<T> = PhantomData<fn(*mut T) -> *mut T>;
 
-/// This is the module-internal type implementing `PinInit` and `Init`. It is unsafe to create this
-/// type, since the closure needs to fulfill the same safety requirement as the
-/// `__pinned_init`/`__init` functions.
+/// Module-internal type implementing `PinInit` and `Init`.
+///
+/// It is unsafe to create this type, since the closure needs to fulfill the same safety
+/// requirement as the `__pinned_init`/`__init` functions.
 pub(crate) struct InitClosure<F, T: ?Sized, E>(pub(crate) F, pub(crate) Invariant<(E, T)>);
 
 // SAFETY: While constructing the `InitClosure`, the user promised that it upholds the
@@ -53,6 +54,7 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
 pub unsafe trait HasPinData {
     type PinData: PinData;
 
+    #[expect(clippy::missing_safety_doc)]
     unsafe fn __pin_data() -> Self::PinData;
 }
 
@@ -82,6 +84,7 @@ fn make_closure<F, O, E>(self, f: F) -> F
 pub unsafe trait HasInitData {
     type InitData: InitData;
 
+    #[expect(clippy::missing_safety_doc)]
     unsafe fn __init_data() -> Self::InitData;
 }
 
@@ -102,7 +105,7 @@ fn make_closure<F, O, E>(self, f: F) -> F
     }
 }
 
-pub struct AllData<T: ?Sized>(PhantomData<fn(Box<T>) -> Box<T>>);
+pub struct AllData<T: ?Sized>(PhantomData<fn(KBox<T>) -> KBox<T>>);
 
 impl<T: ?Sized> Clone for AllData<T> {
     fn clone(&self) -> Self {
@@ -112,10 +115,12 @@ fn clone(&self) -> Self {
 
 impl<T: ?Sized> Copy for AllData<T> {}
 
+// SAFETY: TODO.
 unsafe impl<T: ?Sized> InitData for AllData<T> {
     type Datee = T;
 }
 
+// SAFETY: TODO.
 unsafe impl<T: ?Sized> HasInitData for T {
     type InitData = AllData<T>;
 
diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index 9a0c4650ef67..1fd146a83241 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -182,13 +182,13 @@
 //!     // Normally `Drop` bounds do not have the correct semantics, but for this purpose they do
 //!     // (normally people want to know if a type has any kind of drop glue at all, here we want
 //!     // to know if it has any kind of custom drop glue, which is exactly what this bound does).
-//!     #[allow(drop_bounds)]
+//!     #[expect(drop_bounds)]
 //!     impl<T: ::core::ops::Drop> MustNotImplDrop for T {}
 //!     impl<T> MustNotImplDrop for Bar<T> {}
 //!     // Here comes a convenience check, if one implemented `PinnedDrop`, but forgot to add it to
 //!     // `#[pin_data]`, then this will error with the same mechanic as above, this is not needed
 //!     // for safety, but a good sanity check, since no normal code calls `PinnedDrop::drop`.
-//!     #[allow(non_camel_case_types)]
+//!     #[expect(non_camel_case_types)]
 //!     trait UselessPinnedDropImpl_you_need_to_specify_PinnedDrop {}
 //!     impl<
 //!         T: ::kernel::init::PinnedDrop,
@@ -513,6 +513,7 @@ fn drop($($sig:tt)*) {
             }
         ),
     ) => {
+        // SAFETY: TODO.
         unsafe $($impl_sig)* {
             // Inherit all attributes and the type/ident tokens for the signature.
             $(#[$($attr)*])*
@@ -872,6 +873,7 @@ unsafe fn __pin_data() -> Self::PinData {
                 }
             }
 
+            // SAFETY: TODO.
             unsafe impl<$($impl_generics)*>
                 $crate::init::__internal::PinData for __ThePinData<$($ty_generics)*>
             where $($whr)*
@@ -923,14 +925,14 @@ impl<'__pin, $($impl_generics)*> ::core::marker::Unpin for $name<$($ty_generics)
         // `Drop`. Additionally we will implement this trait for the struct leading to a conflict,
         // if it also implements `Drop`
         trait MustNotImplDrop {}
-        #[allow(drop_bounds)]
+        #[expect(drop_bounds)]
         impl<T: ::core::ops::Drop> MustNotImplDrop for T {}
         impl<$($impl_generics)*> MustNotImplDrop for $name<$($ty_generics)*>
         where $($whr)* {}
         // We also take care to prevent users from writing a useless `PinnedDrop` implementation.
         // They might implement `PinnedDrop` correctly for the struct, but forget to give
         // `PinnedDrop` as the parameter to `#[pin_data]`.
-        #[allow(non_camel_case_types)]
+        #[expect(non_camel_case_types)]
         trait UselessPinnedDropImpl_you_need_to_specify_PinnedDrop {}
         impl<T: $crate::init::PinnedDrop>
             UselessPinnedDropImpl_you_need_to_specify_PinnedDrop for T {}
@@ -987,6 +989,7 @@ fn drop(&mut self) {
         //
         // The functions are `unsafe` to prevent accidentally calling them.
         #[allow(dead_code)]
+        #[expect(clippy::missing_safety_doc)]
         impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
         where $($whr)*
         {
@@ -997,6 +1000,7 @@ impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
                     slot: *mut $p_type,
                     init: impl $crate::init::PinInit<$p_type, E>,
                 ) -> ::core::result::Result<(), E> {
+                    // SAFETY: TODO.
                     unsafe { $crate::init::PinInit::__pinned_init(init, slot) }
                 }
             )*
@@ -1007,6 +1011,7 @@ impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
                     slot: *mut $type,
                     init: impl $crate::init::Init<$type, E>,
                 ) -> ::core::result::Result<(), E> {
+                    // SAFETY: TODO.
                     unsafe { $crate::init::Init::__init(init, slot) }
                 }
             )*
@@ -1121,6 +1126,8 @@ macro_rules! __init_internal {
         // no possibility of returning without `unsafe`.
         struct __InitOk;
         // Get the data about fields from the supplied type.
+        //
+        // SAFETY: TODO.
         let data = unsafe {
             use $crate::init::__internal::$has_data;
             // Here we abuse `paste!` to retokenize `$t`. Declarative macros have some internal
@@ -1176,6 +1183,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
         let init = move |slot| -> ::core::result::Result<(), $err> {
             init(slot).map(|__InitOk| ())
         };
+        // SAFETY: TODO.
         let init = unsafe { $crate::init::$construct_closure::<_, $err>(init) };
         init
     }};
@@ -1324,6 +1332,8 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
         // Endpoint, nothing more to munch, create the initializer.
         // Since we are in the closure that is never called, this will never get executed.
         // We abuse `slot` to get the correct type inference here:
+        //
+        // SAFETY: TODO.
         unsafe {
             // Here we abuse `paste!` to retokenize `$t`. Declarative macros have some internal
             // information that is associated to already parsed fragments, so a path fragment
diff --git a/rust/kernel/ioctl.rs b/rust/kernel/ioctl.rs
index cfa7d080b531..2fc7662339e5 100644
--- a/rust/kernel/ioctl.rs
+++ b/rust/kernel/ioctl.rs
@@ -4,7 +4,7 @@
 //!
 //! C header: [`include/asm-generic/ioctl.h`](srctree/include/asm-generic/ioctl.h)
 
-#![allow(non_snake_case)]
+#![expect(non_snake_case)]
 
 use crate::build_assert;
 
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index e936254531fd..d764cb7ff5d7 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -15,7 +15,8 @@
 #![feature(arbitrary_self_types)]
 #![feature(coerce_unsized)]
 #![feature(dispatch_from_dyn)]
-#![feature(new_uninit)]
+#![feature(inline_const)]
+#![feature(lint_reasons)]
 #![feature(unsize)]
 
 // Ensure conditional compilation based on the kernel configuration works;
@@ -26,6 +27,8 @@
 // Allow proc-macros to refer to `::kernel` inside the `kernel` crate (this crate).
 extern crate self as kernel;
 
+pub use ffi;
+
 pub mod alloc;
 #[cfg(CONFIG_BLOCK)]
 pub mod block;
diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index 5b4aec29eb67..fb93330f4af4 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -354,6 +354,7 @@ pub fn pop_front(&mut self) -> Option<ListArc<T, ID>> {
     ///
     /// `item` must not be in a different linked list (with the same id).
     pub unsafe fn remove(&mut self, item: &T) -> Option<ListArc<T, ID>> {
+        // SAFETY: TODO.
         let mut item = unsafe { ListLinks::fields(T::view_links(item)) };
         // SAFETY: The user provided a reference, and reference are never dangling.
         //
diff --git a/rust/kernel/list/arc_field.rs b/rust/kernel/list/arc_field.rs
index 2330f673427a..c4b9dd503982 100644
--- a/rust/kernel/list/arc_field.rs
+++ b/rust/kernel/list/arc_field.rs
@@ -56,7 +56,7 @@ pub unsafe fn assert_ref(&self) -> &T {
     ///
     /// The caller must have mutable access to the `ListArc<ID>` containing the struct with this
     /// field for the duration of the returned reference.
-    #[allow(clippy::mut_from_ref)]
+    #[expect(clippy::mut_from_ref)]
     pub unsafe fn assert_mut(&self) -> &mut T {
         // SAFETY: The caller has exclusive access to the `ListArc`, so they also have exclusive
         // access to this field.
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 910ce867480a..beb62ec712c3 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -314,7 +314,7 @@ impl<T: Driver> Adapter<T> {
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
     unsafe extern "C" fn soft_reset_callback(
         phydev: *mut bindings::phy_device,
-    ) -> core::ffi::c_int {
+    ) -> crate::ffi::c_int {
         from_result(|| {
             // SAFETY: This callback is called only in contexts
             // where we hold `phy_device->lock`, so the accessors on
@@ -328,7 +328,7 @@ impl<T: Driver> Adapter<T> {
     /// # Safety
     ///
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
-    unsafe extern "C" fn probe_callback(phydev: *mut bindings::phy_device) -> core::ffi::c_int {
+    unsafe extern "C" fn probe_callback(phydev: *mut bindings::phy_device) -> crate::ffi::c_int {
         from_result(|| {
             // SAFETY: This callback is called only in contexts
             // where we can exclusively access `phy_device` because
@@ -345,7 +345,7 @@ impl<T: Driver> Adapter<T> {
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
     unsafe extern "C" fn get_features_callback(
         phydev: *mut bindings::phy_device,
-    ) -> core::ffi::c_int {
+    ) -> crate::ffi::c_int {
         from_result(|| {
             // SAFETY: This callback is called only in contexts
             // where we hold `phy_device->lock`, so the accessors on
@@ -359,7 +359,7 @@ impl<T: Driver> Adapter<T> {
     /// # Safety
     ///
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
-    unsafe extern "C" fn suspend_callback(phydev: *mut bindings::phy_device) -> core::ffi::c_int {
+    unsafe extern "C" fn suspend_callback(phydev: *mut bindings::phy_device) -> crate::ffi::c_int {
         from_result(|| {
             // SAFETY: The C core code ensures that the accessors on
             // `Device` are okay to call even though `phy_device->lock`
@@ -373,7 +373,7 @@ impl<T: Driver> Adapter<T> {
     /// # Safety
     ///
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
-    unsafe extern "C" fn resume_callback(phydev: *mut bindings::phy_device) -> core::ffi::c_int {
+    unsafe extern "C" fn resume_callback(phydev: *mut bindings::phy_device) -> crate::ffi::c_int {
         from_result(|| {
             // SAFETY: The C core code ensures that the accessors on
             // `Device` are okay to call even though `phy_device->lock`
@@ -389,7 +389,7 @@ impl<T: Driver> Adapter<T> {
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
     unsafe extern "C" fn config_aneg_callback(
         phydev: *mut bindings::phy_device,
-    ) -> core::ffi::c_int {
+    ) -> crate::ffi::c_int {
         from_result(|| {
             // SAFETY: This callback is called only in contexts
             // where we hold `phy_device->lock`, so the accessors on
@@ -405,7 +405,7 @@ impl<T: Driver> Adapter<T> {
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
     unsafe extern "C" fn read_status_callback(
         phydev: *mut bindings::phy_device,
-    ) -> core::ffi::c_int {
+    ) -> crate::ffi::c_int {
         from_result(|| {
             // SAFETY: This callback is called only in contexts
             // where we hold `phy_device->lock`, so the accessors on
@@ -421,7 +421,7 @@ impl<T: Driver> Adapter<T> {
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
     unsafe extern "C" fn match_phy_device_callback(
         phydev: *mut bindings::phy_device,
-    ) -> core::ffi::c_int {
+    ) -> crate::ffi::c_int {
         // SAFETY: This callback is called only in contexts
         // where we hold `phy_device->lock`, so the accessors on
         // `Device` are okay to call.
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 4571daec0961..8bdab9aa0d16 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -14,10 +14,7 @@
 #[doc(no_inline)]
 pub use core::pin::Pin;
 
-pub use crate::alloc::{box_ext::BoxExt, flags::*, vec_ext::VecExt};
-
-#[doc(no_inline)]
-pub use alloc::{boxed::Box, vec::Vec};
+pub use crate::alloc::{flags::*, Box, KBox, KVBox, KVVec, KVec, VBox, VVec, Vec};
 
 #[doc(no_inline)]
 pub use macros::{module, pin_data, pinned_drop, vtable, Zeroable};
diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
index 508b0221256c..a28077a7cb30 100644
--- a/rust/kernel/print.rs
+++ b/rust/kernel/print.rs
@@ -14,6 +14,7 @@
 use crate::str::RawFormatter;
 
 // Called from `vsprintf` with format specifier `%pA`.
+#[expect(clippy::missing_safety_doc)]
 #[no_mangle]
 unsafe extern "C" fn rust_fmt_argument(
     buf: *mut c_char,
@@ -23,6 +24,7 @@
     use fmt::Write;
     // SAFETY: The C contract guarantees that `buf` is valid if it's less than `end`.
     let mut w = unsafe { RawFormatter::from_ptrs(buf.cast(), end.cast()) };
+    // SAFETY: TODO.
     let _ = w.write_fmt(unsafe { *(ptr as *const fmt::Arguments<'_>) });
     w.pos().cast()
 }
@@ -102,6 +104,7 @@ pub unsafe fn call_printk(
 ) {
     // `_printk` does not seem to fail in any path.
     #[cfg(CONFIG_PRINTK)]
+    // SAFETY: TODO.
     unsafe {
         bindings::_printk(
             format_string.as_ptr() as _,
@@ -137,7 +140,7 @@ pub fn call_printk_cont(args: fmt::Arguments<'_>) {
 #[doc(hidden)]
 #[cfg(not(testlib))]
 #[macro_export]
-#[allow(clippy::crate_in_macro_def)]
+#[expect(clippy::crate_in_macro_def)]
 macro_rules! print_macro (
     // The non-continuation cases (most of them, e.g. `INFO`).
     ($format_string:path, false, $($arg:tt)+) => (
diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index 7543378d3729..571e27efe544 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -7,7 +7,6 @@
 //! Reference: <https://docs.kernel.org/core-api/rbtree.html>
 
 use crate::{alloc::Flags, bindings, container_of, error::Result, prelude::*};
-use alloc::boxed::Box;
 use core::{
     cmp::{Ord, Ordering},
     marker::PhantomData,
@@ -497,7 +496,7 @@ fn drop(&mut self) {
             // but it is not observable. The loop invariant is still maintained.
 
             // SAFETY: `this` is valid per the loop invariant.
-            unsafe { drop(Box::from_raw(this.cast_mut())) };
+            unsafe { drop(KBox::from_raw(this.cast_mut())) };
         }
     }
 }
@@ -764,7 +763,7 @@ pub fn remove_current(self) -> (Option<Self>, RBTreeNode<K, V>) {
         // point to the links field of `Node<K, V>` objects.
         let this = unsafe { container_of!(self.current.as_ptr(), Node<K, V>, links) }.cast_mut();
         // SAFETY: `this` is valid by the type invariants as described above.
-        let node = unsafe { Box::from_raw(this) };
+        let node = unsafe { KBox::from_raw(this) };
         let node = RBTreeNode { node };
         // SAFETY: The reference to the tree used to create the cursor outlives the cursor, so
         // the tree cannot change. By the tree invariant, all nodes are valid.
@@ -809,7 +808,7 @@ fn remove_neighbor(&mut self, direction: Direction) -> Option<RBTreeNode<K, V>>
             // point to the links field of `Node<K, V>` objects.
             let this = unsafe { container_of!(neighbor, Node<K, V>, links) }.cast_mut();
             // SAFETY: `this` is valid by the type invariants as described above.
-            let node = unsafe { Box::from_raw(this) };
+            let node = unsafe { KBox::from_raw(this) };
             return Some(RBTreeNode { node });
         }
         None
@@ -1038,7 +1037,7 @@ fn next(&mut self) -> Option<Self::Item> {
 /// It contains the memory needed to hold a node that can be inserted into a red-black tree. One
 /// can be obtained by directly allocating it ([`RBTreeNodeReservation::new`]).
 pub struct RBTreeNodeReservation<K, V> {
-    node: Box<MaybeUninit<Node<K, V>>>,
+    node: KBox<MaybeUninit<Node<K, V>>>,
 }
 
 impl<K, V> RBTreeNodeReservation<K, V> {
@@ -1046,7 +1045,7 @@ impl<K, V> RBTreeNodeReservation<K, V> {
     /// call to [`RBTree::insert`].
     pub fn new(flags: Flags) -> Result<RBTreeNodeReservation<K, V>> {
         Ok(RBTreeNodeReservation {
-            node: <Box<_> as BoxExt<_>>::new_uninit(flags)?,
+            node: KBox::new_uninit(flags)?,
         })
     }
 }
@@ -1062,14 +1061,15 @@ impl<K, V> RBTreeNodeReservation<K, V> {
     /// Initialises a node reservation.
     ///
     /// It then becomes an [`RBTreeNode`] that can be inserted into a tree.
-    pub fn into_node(mut self, key: K, value: V) -> RBTreeNode<K, V> {
-        self.node.write(Node {
-            key,
-            value,
-            links: bindings::rb_node::default(),
-        });
-        // SAFETY: We just wrote to it.
-        let node = unsafe { self.node.assume_init() };
+    pub fn into_node(self, key: K, value: V) -> RBTreeNode<K, V> {
+        let node = KBox::write(
+            self.node,
+            Node {
+                key,
+                value,
+                links: bindings::rb_node::default(),
+            },
+        );
         RBTreeNode { node }
     }
 }
@@ -1079,7 +1079,7 @@ pub fn into_node(mut self, key: K, value: V) -> RBTreeNode<K, V> {
 /// The node is fully initialised (with key and value) and can be inserted into a tree without any
 /// extra allocations or failure paths.
 pub struct RBTreeNode<K, V> {
-    node: Box<Node<K, V>>,
+    node: KBox<Node<K, V>>,
 }
 
 impl<K, V> RBTreeNode<K, V> {
@@ -1091,7 +1091,9 @@ pub fn new(key: K, value: V, flags: Flags) -> Result<RBTreeNode<K, V>> {
 
     /// Get the key and value from inside the node.
     pub fn to_key_value(self) -> (K, V) {
-        (self.node.key, self.node.value)
+        let node = KBox::into_inner(self.node);
+
+        (node.key, node.value)
     }
 }
 
@@ -1113,7 +1115,7 @@ impl<K, V> RBTreeNode<K, V> {
     /// may be freed (but only for the key/value; memory for the node itself is kept for reuse).
     pub fn into_reservation(self) -> RBTreeNodeReservation<K, V> {
         RBTreeNodeReservation {
-            node: Box::drop_contents(self.node),
+            node: KBox::drop_contents(self.node),
         }
     }
 }
@@ -1164,7 +1166,7 @@ impl<'a, K, V> RawVacantEntry<'a, K, V> {
     /// The `node` must have a key such that inserting it here does not break the ordering of this
     /// [`RBTree`].
     fn insert(self, node: RBTreeNode<K, V>) -> &'a mut V {
-        let node = Box::into_raw(node.node);
+        let node = KBox::into_raw(node.node);
 
         // SAFETY: `node` is valid at least until we call `Box::from_raw`, which only happens when
         // the node is removed or replaced.
@@ -1238,21 +1240,24 @@ pub fn remove_node(self) -> RBTreeNode<K, V> {
             // SAFETY: The node was a node in the tree, but we removed it, so we can convert it
             // back into a box.
             node: unsafe {
-                Box::from_raw(container_of!(self.node_links, Node<K, V>, links).cast_mut())
+                KBox::from_raw(container_of!(self.node_links, Node<K, V>, links).cast_mut())
             },
         }
     }
 
     /// Takes the value of the entry out of the map, and returns it.
     pub fn remove(self) -> V {
-        self.remove_node().node.value
+        let rb_node = self.remove_node();
+        let node = KBox::into_inner(rb_node.node);
+
+        node.value
     }
 
     /// Swap the current node for the provided node.
     ///
     /// The key of both nodes must be equal.
     fn replace(self, node: RBTreeNode<K, V>) -> RBTreeNode<K, V> {
-        let node = Box::into_raw(node.node);
+        let node = KBox::into_raw(node.node);
 
         // SAFETY: `node` is valid at least until we call `Box::from_raw`, which only happens when
         // the node is removed or replaced.
@@ -1268,7 +1273,7 @@ fn replace(self, node: RBTreeNode<K, V>) -> RBTreeNode<K, V> {
         // - `self.node_ptr` produces a valid pointer to a node in the tree.
         // - Now that we removed this entry from the tree, we can convert the node to a box.
         let old_node =
-            unsafe { Box::from_raw(container_of!(self.node_links, Node<K, V>, links).cast_mut()) };
+            unsafe { KBox::from_raw(container_of!(self.node_links, Node<K, V>, links).cast_mut()) };
 
         RBTreeNode { node: old_node }
     }
diff --git a/rust/kernel/std_vendor.rs b/rust/kernel/std_vendor.rs
index 67bf9d37ddb5..8b4872b48e97 100644
--- a/rust/kernel/std_vendor.rs
+++ b/rust/kernel/std_vendor.rs
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: Apache-2.0 OR MIT
 
+//! Rust standard library vendored code.
+//!
 //! The contents of this file come from the Rust standard library, hosted in
 //! the <https://github.com/rust-lang/rust> repository, licensed under
 //! "Apache-2.0 OR MIT" and adapted for kernel use. For copyright details,
@@ -14,7 +16,7 @@
 ///
 /// ```rust
 /// let a = 2;
-/// # #[allow(clippy::dbg_macro)]
+/// # #[expect(clippy::disallowed_macros)]
 /// let b = dbg!(a * 2) + 1;
 /// //      ^-- prints: [src/main.rs:2] a * 2 = 4
 /// assert_eq!(b, 5);
@@ -52,7 +54,7 @@
 /// With a method call:
 ///
 /// ```rust
-/// # #[allow(clippy::dbg_macro)]
+/// # #[expect(clippy::disallowed_macros)]
 /// fn foo(n: usize) {
 ///     if dbg!(n.checked_sub(4)).is_some() {
 ///         // ...
@@ -71,7 +73,7 @@
 /// Naive factorial implementation:
 ///
 /// ```rust
-/// # #[allow(clippy::dbg_macro)]
+/// # #[expect(clippy::disallowed_macros)]
 /// # {
 /// fn factorial(n: u32) -> u32 {
 ///     if dbg!(n <= 1) {
@@ -118,7 +120,7 @@
 /// a tuple (and return it, too):
 ///
 /// ```
-/// # #[allow(clippy::dbg_macro)]
+/// # #![expect(clippy::disallowed_macros)]
 /// assert_eq!(dbg!(1usize, 2u32), (1, 2));
 /// ```
 ///
@@ -127,7 +129,7 @@
 /// invocations. You can use a 1-tuple directly if you need one:
 ///
 /// ```
-/// # #[allow(clippy::dbg_macro)]
+/// # #[expect(clippy::disallowed_macros)]
 /// # {
 /// assert_eq!(1, dbg!(1u32,)); // trailing comma ignored
 /// assert_eq!((1,), dbg!((1u32,))); // 1-tuple
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index bb8d4f41475b..d04c12a1426d 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -2,8 +2,7 @@
 
 //! String representations.
 
-use crate::alloc::{flags::*, vec_ext::VecExt, AllocError};
-use alloc::vec::Vec;
+use crate::alloc::{flags::*, AllocError, KVec};
 use core::fmt::{self, Write};
 use core::ops::{self, Deref, DerefMut, Index};
 
@@ -162,10 +161,10 @@ pub const fn len(&self) -> usize {
     /// Returns the length of this string with `NUL`.
     #[inline]
     pub const fn len_with_nul(&self) -> usize {
-        // SAFETY: This is one of the invariant of `CStr`.
-        // We add a `unreachable_unchecked` here to hint the optimizer that
-        // the value returned from this function is non-zero.
         if self.0.is_empty() {
+            // SAFETY: This is one of the invariant of `CStr`.
+            // We add a `unreachable_unchecked` here to hint the optimizer that
+            // the value returned from this function is non-zero.
             unsafe { core::hint::unreachable_unchecked() };
         }
         self.0.len()
@@ -185,7 +184,7 @@ pub const fn is_empty(&self) -> bool {
     /// last at least `'a`. When `CStr` is alive, the memory pointed by `ptr`
     /// must not be mutated.
     #[inline]
-    pub unsafe fn from_char_ptr<'a>(ptr: *const core::ffi::c_char) -> &'a Self {
+    pub unsafe fn from_char_ptr<'a>(ptr: *const crate::ffi::c_char) -> &'a Self {
         // SAFETY: The safety precondition guarantees `ptr` is a valid pointer
         // to a `NUL`-terminated C string.
         let len = unsafe { bindings::strlen(ptr) } + 1;
@@ -248,7 +247,7 @@ pub unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut CStr {
 
     /// Returns a C pointer to the string.
     #[inline]
-    pub const fn as_char_ptr(&self) -> *const core::ffi::c_char {
+    pub const fn as_char_ptr(&self) -> *const crate::ffi::c_char {
         self.0.as_ptr() as _
     }
 
@@ -301,6 +300,7 @@ pub fn to_str(&self) -> Result<&str, core::str::Utf8Error> {
     /// ```
     #[inline]
     pub unsafe fn as_str_unchecked(&self) -> &str {
+        // SAFETY: TODO.
         unsafe { core::str::from_utf8_unchecked(self.as_bytes()) }
     }
 
@@ -524,7 +524,28 @@ macro_rules! c_str {
 #[cfg(test)]
 mod tests {
     use super::*;
-    use alloc::format;
+
+    struct String(CString);
+
+    impl String {
+        fn from_fmt(args: fmt::Arguments<'_>) -> Self {
+            String(CString::try_from_fmt(args).unwrap())
+        }
+    }
+
+    impl Deref for String {
+        type Target = str;
+
+        fn deref(&self) -> &str {
+            self.0.to_str().unwrap()
+        }
+    }
+
+    macro_rules! format {
+        ($($f:tt)*) => ({
+            &*String::from_fmt(kernel::fmt!($($f)*))
+        })
+    }
 
     const ALL_ASCII_CHARS: &'static str =
         "\\x01\\x02\\x03\\x04\\x05\\x06\\x07\\x08\\x09\\x0a\\x0b\\x0c\\x0d\\x0e\\x0f\
@@ -790,7 +811,7 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
 /// assert_eq!(s.is_ok(), false);
 /// ```
 pub struct CString {
-    buf: Vec<u8>,
+    buf: KVec<u8>,
 }
 
 impl CString {
@@ -803,7 +824,7 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
         let size = f.bytes_written();
 
         // Allocate a vector with the required number of bytes, and write to it.
-        let mut buf = <Vec<_> as VecExt<_>>::with_capacity(size, GFP_KERNEL)?;
+        let mut buf = KVec::with_capacity(size, GFP_KERNEL)?;
         // SAFETY: The buffer stored in `buf` is at least of size `size` and is valid for writes.
         let mut f = unsafe { Formatter::from_buffer(buf.as_mut_ptr(), size) };
         f.write_fmt(args)?;
@@ -850,10 +871,9 @@ impl<'a> TryFrom<&'a CStr> for CString {
     type Error = AllocError;
 
     fn try_from(cstr: &'a CStr) -> Result<CString, AllocError> {
-        let mut buf = Vec::new();
+        let mut buf = KVec::new();
 
-        <Vec<_> as VecExt<_>>::extend_from_slice(&mut buf, cstr.as_bytes_with_nul(), GFP_KERNEL)
-            .map_err(|_| AllocError)?;
+        buf.extend_from_slice(cstr.as_bytes_with_nul(), GFP_KERNEL)?;
 
         // INVARIANT: The `CStr` and `CString` types have the same invariants for
         // the string data, and we copied it over without changes.
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 28743a7c74a8..fa4509406ee9 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -17,13 +17,12 @@
 //! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
 
 use crate::{
-    alloc::{box_ext::BoxExt, AllocError, Flags},
+    alloc::{AllocError, Flags, KBox},
     bindings,
     init::{self, InPlaceInit, Init, PinInit},
     try_init,
     types::{ForeignOwnable, Opaque},
 };
-use alloc::boxed::Box;
 use core::{
     alloc::Layout,
     fmt,
@@ -201,11 +200,11 @@ pub fn new(contents: T, flags: Flags) -> Result<Self, AllocError> {
             data: contents,
         };
 
-        let inner = <Box<_> as BoxExt<_>>::new(value, flags)?;
+        let inner = KBox::new(value, flags)?;
 
         // SAFETY: We just created `inner` with a reference count of 1, which is owned by the new
         // `Arc` object.
-        Ok(unsafe { Self::from_inner(Box::leak(inner).into()) })
+        Ok(unsafe { Self::from_inner(KBox::leak(inner).into()) })
     }
 }
 
@@ -333,12 +332,12 @@ pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
 impl<T: 'static> ForeignOwnable for Arc<T> {
     type Borrowed<'a> = ArcBorrow<'a, T>;
 
-    fn into_foreign(self) -> *const core::ffi::c_void {
+    fn into_foreign(self) -> *const crate::ffi::c_void {
         ManuallyDrop::new(self).ptr.as_ptr() as _
     }
 
-    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
-        // SAFETY: By the safety requirement of this function, we know that `ptr` came from
+    unsafe fn borrow<'a>(ptr: *const crate::ffi::c_void) -> ArcBorrow<'a, T> {
+        // By the safety requirement of this function, we know that `ptr` came from
         // a previous call to `Arc::into_foreign`.
         let inner = NonNull::new(ptr as *mut ArcInner<T>).unwrap();
 
@@ -347,7 +346,7 @@ unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
         unsafe { ArcBorrow::new(inner) }
     }
 
-    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
+    unsafe fn from_foreign(ptr: *const crate::ffi::c_void) -> Self {
         // SAFETY: By the safety requirement of this function, we know that `ptr` came from
         // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
         // holds a reference count increment that is transferrable to us.
@@ -398,8 +397,8 @@ fn drop(&mut self) {
         if is_zero {
             // The count reached zero, we must free the memory.
             //
-            // SAFETY: The pointer was initialised from the result of `Box::leak`.
-            unsafe { drop(Box::from_raw(self.ptr.as_ptr())) };
+            // SAFETY: The pointer was initialised from the result of `KBox::leak`.
+            unsafe { drop(KBox::from_raw(self.ptr.as_ptr())) };
         }
     }
 }
@@ -641,7 +640,7 @@ pub fn new(value: T, flags: Flags) -> Result<Self, AllocError> {
     /// Tries to allocate a new [`UniqueArc`] instance whose contents are not initialised yet.
     pub fn new_uninit(flags: Flags) -> Result<UniqueArc<MaybeUninit<T>>, AllocError> {
         // INVARIANT: The refcount is initialised to a non-zero value.
-        let inner = Box::try_init::<AllocError>(
+        let inner = KBox::try_init::<AllocError>(
             try_init!(ArcInner {
                 // SAFETY: There are no safety requirements for this FFI call.
                 refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
@@ -651,8 +650,8 @@ pub fn new_uninit(flags: Flags) -> Result<UniqueArc<MaybeUninit<T>>, AllocError>
         )?;
         Ok(UniqueArc {
             // INVARIANT: The newly-created object has a refcount of 1.
-            // SAFETY: The pointer from the `Box` is valid.
-            inner: unsafe { Arc::from_inner(Box::leak(inner).into()) },
+            // SAFETY: The pointer from the `KBox` is valid.
+            inner: unsafe { Arc::from_inner(KBox::leak(inner).into()) },
         })
     }
 }
diff --git a/rust/kernel/sync/arc/std_vendor.rs b/rust/kernel/sync/arc/std_vendor.rs
index a66a0c2831b3..11b3f4ecca5f 100644
--- a/rust/kernel/sync/arc/std_vendor.rs
+++ b/rust/kernel/sync/arc/std_vendor.rs
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: Apache-2.0 OR MIT
 
+//! Rust standard library vendored code.
+//!
 //! The contents of this file come from the Rust standard library, hosted in
 //! the <https://github.com/rust-lang/rust> repository, licensed under
 //! "Apache-2.0 OR MIT" and adapted for kernel use. For copyright details,
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 2b306afbe56d..7df565038d7d 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -7,6 +7,7 @@
 
 use super::{lock::Backend, lock::Guard, LockClassKey};
 use crate::{
+    ffi::{c_int, c_long},
     init::PinInit,
     pin_init,
     str::CStr,
@@ -14,7 +15,6 @@
     time::Jiffies,
     types::Opaque,
 };
-use core::ffi::{c_int, c_long};
 use core::marker::PhantomPinned;
 use core::ptr;
 use macros::pin_data;
@@ -70,8 +70,8 @@ macro_rules! new_condvar {
 /// }
 ///
 /// /// Allocates a new boxed `Example`.
-/// fn new_example() -> Result<Pin<Box<Example>>> {
-///     Box::pin_init(pin_init!(Example {
+/// fn new_example() -> Result<Pin<KBox<Example>>> {
+///     KBox::pin_init(pin_init!(Example {
 ///         value <- new_mutex!(0),
 ///         value_changed <- new_condvar!(),
 ///     }), GFP_KERNEL)
@@ -93,7 +93,6 @@ pub struct CondVar {
 }
 
 // SAFETY: `CondVar` only uses a `struct wait_queue_head`, which is safe to use on any thread.
-#[allow(clippy::non_send_fields_in_send_ty)]
 unsafe impl Send for CondVar {}
 
 // SAFETY: `CondVar` only uses a `struct wait_queue_head`, which is safe to use on multiple threads
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f6c34ca4d819..528eb6907231 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -46,7 +46,7 @@ pub unsafe trait Backend {
     /// remain valid for read indefinitely.
     unsafe fn init(
         ptr: *mut Self::State,
-        name: *const core::ffi::c_char,
+        name: *const crate::ffi::c_char,
         key: *mut bindings::lock_class_key,
     );
 
@@ -150,9 +150,9 @@ pub(crate) fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
         // SAFETY: The caller owns the lock, so it is safe to unlock it.
         unsafe { B::unlock(self.lock.state.get(), &self.state) };
 
-        // SAFETY: The lock was just unlocked above and is being relocked now.
-        let _relock =
-            ScopeGuard::new(|| unsafe { B::relock(self.lock.state.get(), &mut self.state) });
+        let _relock = ScopeGuard::new(||
+                // SAFETY: The lock was just unlocked above and is being relocked now.
+                unsafe { B::relock(self.lock.state.get(), &mut self.state) });
 
         cb()
     }
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
index 30632070ee67..59a872cbcac6 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -58,7 +58,7 @@ macro_rules! new_mutex {
 /// }
 ///
 /// // Allocate a boxed `Example`.
-/// let e = Box::pin_init(Example::new(), GFP_KERNEL)?;
+/// let e = KBox::pin_init(Example::new(), GFP_KERNEL)?;
 /// assert_eq!(e.c, 10);
 /// assert_eq!(e.d.lock().a, 20);
 /// assert_eq!(e.d.lock().b, 30);
@@ -96,7 +96,7 @@ unsafe impl super::Backend for MutexBackend {
 
     unsafe fn init(
         ptr: *mut Self::State,
-        name: *const core::ffi::c_char,
+        name: *const crate::ffi::c_char,
         key: *mut bindings::lock_class_key,
     ) {
         // SAFETY: The safety requirements ensure that `ptr` is valid for writes, and `name` and
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index ea5c5bc1ce12..b77eed1789ad 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -56,7 +56,7 @@ macro_rules! new_spinlock {
 /// }
 ///
 /// // Allocate a boxed `Example`.
-/// let e = Box::pin_init(Example::new(), GFP_KERNEL)?;
+/// let e = KBox::pin_init(Example::new(), GFP_KERNEL)?;
 /// assert_eq!(e.c, 10);
 /// assert_eq!(e.d.lock().a, 20);
 /// assert_eq!(e.d.lock().b, 30);
@@ -95,7 +95,7 @@ unsafe impl super::Backend for SpinLockBackend {
 
     unsafe fn init(
         ptr: *mut Self::State,
-        name: *const core::ffi::c_char,
+        name: *const crate::ffi::c_char,
         key: *mut bindings::lock_class_key,
     ) {
         // SAFETY: The safety requirements ensure that `ptr` is valid for writes, and `name` and
diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.rs
index ce2ee8d87865..a7b244675c2b 100644
--- a/rust/kernel/sync/locked_by.rs
+++ b/rust/kernel/sync/locked_by.rs
@@ -43,7 +43,7 @@
 /// struct InnerDirectory {
 ///     /// The sum of the bytes used by all files.
 ///     bytes_used: u64,
-///     _files: Vec<File>,
+///     _files: KVec<File>,
 /// }
 ///
 /// struct Directory {
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 55dff7e088bf..5bce090a3869 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -4,13 +4,9 @@
 //!
 //! C header: [`include/linux/sched.h`](srctree/include/linux/sched.h).
 
+use crate::ffi::{c_int, c_long, c_uint};
 use crate::types::Opaque;
-use core::{
-    ffi::{c_int, c_long, c_uint},
-    marker::PhantomData,
-    ops::Deref,
-    ptr,
-};
+use core::{marker::PhantomData, ops::Deref, ptr};
 
 /// A sentinel value used for infinite timeouts.
 pub const MAX_SCHEDULE_TIMEOUT: c_long = c_long::MAX;
diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index e3bb5e89f88d..379c0f5772e5 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -12,10 +12,10 @@
 pub const NSEC_PER_MSEC: i64 = bindings::NSEC_PER_MSEC as i64;
 
 /// The time unit of Linux kernel. One jiffy equals (1/HZ) second.
-pub type Jiffies = core::ffi::c_ulong;
+pub type Jiffies = crate::ffi::c_ulong;
 
 /// The millisecond time unit.
-pub type Msecs = core::ffi::c_uint;
+pub type Msecs = crate::ffi::c_uint;
 
 /// Converts milliseconds to jiffies.
 #[inline]
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 9e7ca066355c..7c8c531ef190 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -3,13 +3,11 @@
 //! Kernel types.
 
 use crate::init::{self, PinInit};
-use alloc::boxed::Box;
 use core::{
     cell::UnsafeCell,
     marker::{PhantomData, PhantomPinned},
     mem::{ManuallyDrop, MaybeUninit},
     ops::{Deref, DerefMut},
-    pin::Pin,
     ptr::NonNull,
 };
 
@@ -31,7 +29,7 @@ pub trait ForeignOwnable: Sized {
     /// For example, it might be invalid, dangling or pointing to uninitialized memory. Using it in
     /// any way except for [`ForeignOwnable::from_foreign`], [`ForeignOwnable::borrow`],
     /// [`ForeignOwnable::try_from_foreign`] can result in undefined behavior.
-    fn into_foreign(self) -> *const core::ffi::c_void;
+    fn into_foreign(self) -> *const crate::ffi::c_void;
 
     /// Borrows a foreign-owned object.
     ///
@@ -39,7 +37,7 @@ pub trait ForeignOwnable: Sized {
     ///
     /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
     /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
-    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowed<'a>;
+    unsafe fn borrow<'a>(ptr: *const crate::ffi::c_void) -> Self::Borrowed<'a>;
 
     /// Converts a foreign-owned object back to a Rust-owned one.
     ///
@@ -49,7 +47,7 @@ pub trait ForeignOwnable: Sized {
     /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
     /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] for
     /// this object must have been dropped.
-    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;
+    unsafe fn from_foreign(ptr: *const crate::ffi::c_void) -> Self;
 
     /// Tries to convert a foreign-owned object back to a Rust-owned one.
     ///
@@ -60,7 +58,7 @@ pub trait ForeignOwnable: Sized {
     ///
     /// `ptr` must either be null or satisfy the safety requirements for
     /// [`ForeignOwnable::from_foreign`].
-    unsafe fn try_from_foreign(ptr: *const core::ffi::c_void) -> Option<Self> {
+    unsafe fn try_from_foreign(ptr: *const crate::ffi::c_void) -> Option<Self> {
         if ptr.is_null() {
             None
         } else {
@@ -71,64 +69,16 @@ unsafe fn try_from_foreign(ptr: *const core::ffi::c_void) -> Option<Self> {
     }
 }
 
-impl<T: 'static> ForeignOwnable for Box<T> {
-    type Borrowed<'a> = &'a T;
-
-    fn into_foreign(self) -> *const core::ffi::c_void {
-        Box::into_raw(self) as _
-    }
-
-    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
-        // SAFETY: The safety requirements for this function ensure that the object is still alive,
-        // so it is safe to dereference the raw pointer.
-        // The safety requirements of `from_foreign` also ensure that the object remains alive for
-        // the lifetime of the returned value.
-        unsafe { &*ptr.cast() }
-    }
-
-    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
-        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
-        // call to `Self::into_foreign`.
-        unsafe { Box::from_raw(ptr as _) }
-    }
-}
-
-impl<T: 'static> ForeignOwnable for Pin<Box<T>> {
-    type Borrowed<'a> = Pin<&'a T>;
-
-    fn into_foreign(self) -> *const core::ffi::c_void {
-        // SAFETY: We are still treating the box as pinned.
-        Box::into_raw(unsafe { Pin::into_inner_unchecked(self) }) as _
-    }
-
-    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Pin<&'a T> {
-        // SAFETY: The safety requirements for this function ensure that the object is still alive,
-        // so it is safe to dereference the raw pointer.
-        // The safety requirements of `from_foreign` also ensure that the object remains alive for
-        // the lifetime of the returned value.
-        let r = unsafe { &*ptr.cast() };
-
-        // SAFETY: This pointer originates from a `Pin<Box<T>>`.
-        unsafe { Pin::new_unchecked(r) }
-    }
-
-    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
-        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
-        // call to `Self::into_foreign`.
-        unsafe { Pin::new_unchecked(Box::from_raw(ptr as _)) }
-    }
-}
-
 impl ForeignOwnable for () {
     type Borrowed<'a> = ();
 
-    fn into_foreign(self) -> *const core::ffi::c_void {
+    fn into_foreign(self) -> *const crate::ffi::c_void {
         core::ptr::NonNull::dangling().as_ptr()
     }
 
-    unsafe fn borrow<'a>(_: *const core::ffi::c_void) -> Self::Borrowed<'a> {}
+    unsafe fn borrow<'a>(_: *const crate::ffi::c_void) -> Self::Borrowed<'a> {}
 
-    unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
+    unsafe fn from_foreign(_: *const crate::ffi::c_void) -> Self {}
 }
 
 /// Runs a cleanup function/closure when dropped.
@@ -185,7 +135,7 @@ unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
 /// # use kernel::types::ScopeGuard;
 /// fn example3(arg: bool) -> Result {
 ///     let mut vec =
-///         ScopeGuard::new_with_data(Vec::new(), |v| pr_info!("vec had {} elements\n", v.len()));
+///         ScopeGuard::new_with_data(KVec::new(), |v| pr_info!("vec had {} elements\n", v.len()));
 ///
 ///     vec.push(10u8, GFP_KERNEL)?;
 ///     if arg {
@@ -225,7 +175,7 @@ pub fn dismiss(mut self) -> T {
 impl ScopeGuard<(), fn(())> {
     /// Creates a new guarded object with the given cleanup function.
     pub fn new(cleanup: impl FnOnce()) -> ScopeGuard<(), impl FnOnce(())> {
-        ScopeGuard::new_with_data((), move |_| cleanup())
+        ScopeGuard::new_with_data((), move |()| cleanup())
     }
 }
 
@@ -410,6 +360,7 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     ///
     /// struct Empty {}
     ///
+    /// # // SAFETY: TODO.
     /// unsafe impl AlwaysRefCounted for Empty {
     ///     fn inc_ref(&self) {}
     ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
@@ -417,6 +368,7 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     ///
     /// let mut data = Empty {};
     /// let ptr = NonNull::<Empty>::new(&mut data as *mut _).unwrap();
+    /// # // SAFETY: TODO.
     /// let data_ref: ARef<Empty> = unsafe { ARef::from_raw(ptr) };
     /// let raw_ptr: NonNull<Empty> = ARef::into_raw(data_ref);
     ///
@@ -481,21 +433,23 @@ pub enum Either<L, R> {
 /// All bit-patterns must be valid for this type. This type must not have interior mutability.
 pub unsafe trait FromBytes {}
 
-// SAFETY: All bit patterns are acceptable values of the types below.
-unsafe impl FromBytes for u8 {}
-unsafe impl FromBytes for u16 {}
-unsafe impl FromBytes for u32 {}
-unsafe impl FromBytes for u64 {}
-unsafe impl FromBytes for usize {}
-unsafe impl FromBytes for i8 {}
-unsafe impl FromBytes for i16 {}
-unsafe impl FromBytes for i32 {}
-unsafe impl FromBytes for i64 {}
-unsafe impl FromBytes for isize {}
-// SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
-// patterns are also acceptable for arrays of that type.
-unsafe impl<T: FromBytes> FromBytes for [T] {}
-unsafe impl<T: FromBytes, const N: usize> FromBytes for [T; N] {}
+macro_rules! impl_frombytes {
+    ($($({$($generics:tt)*})? $t:ty, )*) => {
+        // SAFETY: Safety comments written in the macro invocation.
+        $(unsafe impl$($($generics)*)? FromBytes for $t {})*
+    };
+}
+
+impl_frombytes! {
+    // SAFETY: All bit patterns are acceptable values of the types below.
+    u8, u16, u32, u64, usize,
+    i8, i16, i32, i64, isize,
+
+    // SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
+    // patterns are also acceptable for arrays of that type.
+    {<T: FromBytes>} [T],
+    {<T: FromBytes, const N: usize>} [T; N],
+}
 
 /// Types that can be viewed as an immutable slice of initialized bytes.
 ///
@@ -514,21 +468,23 @@ unsafe impl<T: FromBytes> FromBytes for [T] {}
 /// mutability.
 pub unsafe trait AsBytes {}
 
-// SAFETY: Instances of the following types have no uninitialized portions.
-unsafe impl AsBytes for u8 {}
-unsafe impl AsBytes for u16 {}
-unsafe impl AsBytes for u32 {}
-unsafe impl AsBytes for u64 {}
-unsafe impl AsBytes for usize {}
-unsafe impl AsBytes for i8 {}
-unsafe impl AsBytes for i16 {}
-unsafe impl AsBytes for i32 {}
-unsafe impl AsBytes for i64 {}
-unsafe impl AsBytes for isize {}
-unsafe impl AsBytes for bool {}
-unsafe impl AsBytes for char {}
-unsafe impl AsBytes for str {}
-// SAFETY: If individual values in an array have no uninitialized portions, then the array itself
-// does not have any uninitialized portions either.
-unsafe impl<T: AsBytes> AsBytes for [T] {}
-unsafe impl<T: AsBytes, const N: usize> AsBytes for [T; N] {}
+macro_rules! impl_asbytes {
+    ($($({$($generics:tt)*})? $t:ty, )*) => {
+        // SAFETY: Safety comments written in the macro invocation.
+        $(unsafe impl$($($generics)*)? AsBytes for $t {})*
+    };
+}
+
+impl_asbytes! {
+    // SAFETY: Instances of the following types have no uninitialized portions.
+    u8, u16, u32, u64, usize,
+    i8, i16, i32, i64, isize,
+    bool,
+    char,
+    str,
+
+    // SAFETY: If individual values in an array have no uninitialized portions, then the array
+    // itself does not have any uninitialized portions either.
+    {<T: AsBytes>} [T],
+    {<T: AsBytes, const N: usize>} [T; N],
+}
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index e9347cff99ab..5a3c2d4df65f 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -8,11 +8,10 @@
     alloc::Flags,
     bindings,
     error::Result,
+    ffi::c_void,
     prelude::*,
     types::{AsBytes, FromBytes},
 };
-use alloc::vec::Vec;
-use core::ffi::{c_ulong, c_void};
 use core::mem::{size_of, MaybeUninit};
 
 /// The type used for userspace addresses.
@@ -46,15 +45,14 @@
 /// every byte in the region.
 ///
 /// ```no_run
-/// use alloc::vec::Vec;
-/// use core::ffi::c_void;
+/// use kernel::ffi::c_void;
 /// use kernel::error::Result;
 /// use kernel::uaccess::{UserPtr, UserSlice};
 ///
 /// fn bytes_add_one(uptr: UserPtr, len: usize) -> Result<()> {
 ///     let (read, mut write) = UserSlice::new(uptr, len).reader_writer();
 ///
-///     let mut buf = Vec::new();
+///     let mut buf = KVec::new();
 ///     read.read_all(&mut buf, GFP_KERNEL)?;
 ///
 ///     for b in &mut buf {
@@ -69,8 +67,7 @@
 /// Example illustrating a TOCTOU (time-of-check to time-of-use) bug.
 ///
 /// ```no_run
-/// use alloc::vec::Vec;
-/// use core::ffi::c_void;
+/// use kernel::ffi::c_void;
 /// use kernel::error::{code::EINVAL, Result};
 /// use kernel::uaccess::{UserPtr, UserSlice};
 ///
@@ -78,21 +75,21 @@
 /// fn is_valid(uptr: UserPtr, len: usize) -> Result<bool> {
 ///     let read = UserSlice::new(uptr, len).reader();
 ///
-///     let mut buf = Vec::new();
+///     let mut buf = KVec::new();
 ///     read.read_all(&mut buf, GFP_KERNEL)?;
 ///
 ///     todo!()
 /// }
 ///
 /// /// Returns the bytes behind this user pointer if they are valid.
-/// fn get_bytes_if_valid(uptr: UserPtr, len: usize) -> Result<Vec<u8>> {
+/// fn get_bytes_if_valid(uptr: UserPtr, len: usize) -> Result<KVec<u8>> {
 ///     if !is_valid(uptr, len)? {
 ///         return Err(EINVAL);
 ///     }
 ///
 ///     let read = UserSlice::new(uptr, len).reader();
 ///
-///     let mut buf = Vec::new();
+///     let mut buf = KVec::new();
 ///     read.read_all(&mut buf, GFP_KERNEL)?;
 ///
 ///     // THIS IS A BUG! The bytes could have changed since we checked them.
@@ -130,7 +127,7 @@ pub fn new(ptr: UserPtr, length: usize) -> Self {
     /// Reads the entirety of the user slice, appending it to the end of the provided buffer.
     ///
     /// Fails with [`EFAULT`] if the read happens on a bad address.
-    pub fn read_all(self, buf: &mut Vec<u8>, flags: Flags) -> Result {
+    pub fn read_all(self, buf: &mut KVec<u8>, flags: Flags) -> Result {
         self.reader().read_all(buf, flags)
     }
 
@@ -227,13 +224,9 @@ pub fn read_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> Result {
         if len > self.length {
             return Err(EFAULT);
         }
-        let Ok(len_ulong) = c_ulong::try_from(len) else {
-            return Err(EFAULT);
-        };
-        // SAFETY: `out_ptr` points into a mutable slice of length `len_ulong`, so we may write
+        // SAFETY: `out_ptr` points into a mutable slice of length `len`, so we may write
         // that many bytes to it.
-        let res =
-            unsafe { bindings::copy_from_user(out_ptr, self.ptr as *const c_void, len_ulong) };
+        let res = unsafe { bindings::copy_from_user(out_ptr, self.ptr as *const c_void, len) };
         if res != 0 {
             return Err(EFAULT);
         }
@@ -262,9 +255,6 @@ pub fn read<T: FromBytes>(&mut self) -> Result<T> {
         if len > self.length {
             return Err(EFAULT);
         }
-        let Ok(len_ulong) = c_ulong::try_from(len) else {
-            return Err(EFAULT);
-        };
         let mut out: MaybeUninit<T> = MaybeUninit::uninit();
         // SAFETY: The local variable `out` is valid for writing `size_of::<T>()` bytes.
         //
@@ -275,7 +265,7 @@ pub fn read<T: FromBytes>(&mut self) -> Result<T> {
             bindings::_copy_from_user(
                 out.as_mut_ptr().cast::<c_void>(),
                 self.ptr as *const c_void,
-                len_ulong,
+                len,
             )
         };
         if res != 0 {
@@ -291,9 +281,9 @@ pub fn read<T: FromBytes>(&mut self) -> Result<T> {
     /// Reads the entirety of the user slice, appending it to the end of the provided buffer.
     ///
     /// Fails with [`EFAULT`] if the read happens on a bad address.
-    pub fn read_all(mut self, buf: &mut Vec<u8>, flags: Flags) -> Result {
+    pub fn read_all(mut self, buf: &mut KVec<u8>, flags: Flags) -> Result {
         let len = self.length;
-        VecExt::<u8>::reserve(buf, len, flags)?;
+        buf.reserve(len, flags)?;
 
         // The call to `try_reserve` was successful, so the spare capacity is at least `len` bytes
         // long.
@@ -338,12 +328,9 @@ pub fn write_slice(&mut self, data: &[u8]) -> Result {
         if len > self.length {
             return Err(EFAULT);
         }
-        let Ok(len_ulong) = c_ulong::try_from(len) else {
-            return Err(EFAULT);
-        };
-        // SAFETY: `data_ptr` points into an immutable slice of length `len_ulong`, so we may read
+        // SAFETY: `data_ptr` points into an immutable slice of length `len`, so we may read
         // that many bytes from it.
-        let res = unsafe { bindings::copy_to_user(self.ptr as *mut c_void, data_ptr, len_ulong) };
+        let res = unsafe { bindings::copy_to_user(self.ptr as *mut c_void, data_ptr, len) };
         if res != 0 {
             return Err(EFAULT);
         }
@@ -362,9 +349,6 @@ pub fn write<T: AsBytes>(&mut self, value: &T) -> Result {
         if len > self.length {
             return Err(EFAULT);
         }
-        let Ok(len_ulong) = c_ulong::try_from(len) else {
-            return Err(EFAULT);
-        };
         // SAFETY: The reference points to a value of type `T`, so it is valid for reading
         // `size_of::<T>()` bytes.
         //
@@ -375,7 +359,7 @@ pub fn write<T: AsBytes>(&mut self, value: &T) -> Result {
             bindings::_copy_to_user(
                 self.ptr as *mut c_void,
                 (value as *const T).cast::<c_void>(),
-                len_ulong,
+                len,
             )
         };
         if res != 0 {
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 553a5cba2adc..4d1d2062f6eb 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -216,7 +216,7 @@ pub fn try_spawn<T: 'static + Send + FnOnce()>(
             func: Some(func),
         });
 
-        self.enqueue(Box::pin_init(init, flags).map_err(|_| AllocError)?);
+        self.enqueue(KBox::pin_init(init, flags).map_err(|_| AllocError)?);
         Ok(())
     }
 }
@@ -239,9 +239,9 @@ fn project(self: Pin<&mut Self>) -> &mut Option<T> {
 }
 
 impl<T: FnOnce()> WorkItem for ClosureWork<T> {
-    type Pointer = Pin<Box<Self>>;
+    type Pointer = Pin<KBox<Self>>;
 
-    fn run(mut this: Pin<Box<Self>>) {
+    fn run(mut this: Pin<KBox<Self>>) {
         if let Some(func) = this.as_mut().project().take() {
             (func)()
         }
@@ -297,7 +297,7 @@ unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
 
 /// Defines the method that should be called directly when a work item is executed.
 ///
-/// This trait is implemented by `Pin<Box<T>>` and [`Arc<T>`], and is mainly intended to be
+/// This trait is implemented by `Pin<KBox<T>>` and [`Arc<T>`], and is mainly intended to be
 /// implemented for smart pointer types. For your own structs, you would implement [`WorkItem`]
 /// instead. The [`run`] method on this trait will usually just perform the appropriate
 /// `container_of` translation and then call into the [`run`][WorkItem::run] method from the
@@ -329,7 +329,7 @@ pub unsafe trait WorkItemPointer<const ID: u64>: RawWorkItem<ID> {
 /// This trait is used when the `work_struct` field is defined using the [`Work`] helper.
 pub trait WorkItem<const ID: u64 = 0> {
     /// The pointer type that this struct is wrapped in. This will typically be `Arc<Self>` or
-    /// `Pin<Box<Self>>`.
+    /// `Pin<KBox<Self>>`.
     type Pointer: WorkItemPointer<ID>;
 
     /// The method that should be called when this work item is executed.
@@ -366,7 +366,6 @@ unsafe impl<T: ?Sized, const ID: u64> Sync for Work<T, ID> {}
 impl<T: ?Sized, const ID: u64> Work<T, ID> {
     /// Creates a new instance of [`Work`].
     #[inline]
-    #[allow(clippy::new_ret_no_self)]
     pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self>
     where
         T: WorkItem<ID>,
@@ -520,13 +519,14 @@ unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workqueue::Work<$work_typ
     impl{T} HasWork<Self> for ClosureWork<T> { self.work }
 }
 
+// SAFETY: TODO.
 unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Arc<T>
 where
     T: WorkItem<ID, Pointer = Self>,
     T: HasWork<T, ID>,
 {
     unsafe extern "C" fn run(ptr: *mut bindings::work_struct) {
-        // SAFETY: The `__enqueue` method always uses a `work_struct` stored in a `Work<T, ID>`.
+        // The `__enqueue` method always uses a `work_struct` stored in a `Work<T, ID>`.
         let ptr = ptr as *mut Work<T, ID>;
         // SAFETY: This computes the pointer that `__enqueue` got from `Arc::into_raw`.
         let ptr = unsafe { T::work_container_of(ptr) };
@@ -537,6 +537,7 @@ unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Arc<T>
     }
 }
 
+// SAFETY: TODO.
 unsafe impl<T, const ID: u64> RawWorkItem<ID> for Arc<T>
 where
     T: WorkItem<ID, Pointer = Self>,
@@ -565,18 +566,19 @@ unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
     }
 }
 
-unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Pin<Box<T>>
+// SAFETY: TODO.
+unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Pin<KBox<T>>
 where
     T: WorkItem<ID, Pointer = Self>,
     T: HasWork<T, ID>,
 {
     unsafe extern "C" fn run(ptr: *mut bindings::work_struct) {
-        // SAFETY: The `__enqueue` method always uses a `work_struct` stored in a `Work<T, ID>`.
+        // The `__enqueue` method always uses a `work_struct` stored in a `Work<T, ID>`.
         let ptr = ptr as *mut Work<T, ID>;
         // SAFETY: This computes the pointer that `__enqueue` got from `Arc::into_raw`.
         let ptr = unsafe { T::work_container_of(ptr) };
         // SAFETY: This pointer comes from `Arc::into_raw` and we've been given back ownership.
-        let boxed = unsafe { Box::from_raw(ptr) };
+        let boxed = unsafe { KBox::from_raw(ptr) };
         // SAFETY: The box was already pinned when it was enqueued.
         let pinned = unsafe { Pin::new_unchecked(boxed) };
 
@@ -584,7 +586,8 @@ unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Pin<Box<T>>
     }
 }
 
-unsafe impl<T, const ID: u64> RawWorkItem<ID> for Pin<Box<T>>
+// SAFETY: TODO.
+unsafe impl<T, const ID: u64> RawWorkItem<ID> for Pin<KBox<T>>
 where
     T: WorkItem<ID, Pointer = Self>,
     T: HasWork<T, ID>,
@@ -598,9 +601,9 @@ unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
         // SAFETY: We're not going to move `self` or any of its fields, so its okay to temporarily
         // remove the `Pin` wrapper.
         let boxed = unsafe { Pin::into_inner_unchecked(self) };
-        let ptr = Box::into_raw(boxed);
+        let ptr = KBox::into_raw(boxed);
 
-        // SAFETY: Pointers into a `Box` point at a valid value.
+        // SAFETY: Pointers into a `KBox` point at a valid value.
         let work_ptr = unsafe { T::raw_get_work(ptr) };
         // SAFETY: `raw_get_work` returns a pointer to a valid value.
         let work_ptr = unsafe { Work::raw_get(work_ptr) };
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 90e2202ba4d5..b16402a16acd 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -132,7 +132,7 @@ pub fn module(ts: TokenStream) -> TokenStream {
 /// calls to this function at compile time:
 ///
 /// ```compile_fail
-/// # use kernel::error::VTABLE_DEFAULT_ERROR;
+/// # // Intentionally missing `use`s to simplify `rusttest`.
 /// kernel::build_error(VTABLE_DEFAULT_ERROR)
 /// ```
 ///
@@ -242,8 +242,8 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream {
 /// #[pin_data]
 /// struct DriverData {
 ///     #[pin]
-///     queue: Mutex<Vec<Command>>,
-///     buf: Box<[u8; 1024 * 1024]>,
+///     queue: Mutex<KVec<Command>>,
+///     buf: KBox<[u8; 1024 * 1024]>,
 /// }
 /// ```
 ///
@@ -251,8 +251,8 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream {
 /// #[pin_data(PinnedDrop)]
 /// struct DriverData {
 ///     #[pin]
-///     queue: Mutex<Vec<Command>>,
-///     buf: Box<[u8; 1024 * 1024]>,
+///     queue: Mutex<KVec<Command>>,
+///     buf: KBox<[u8; 1024 * 1024]>,
 ///     raw_info: *mut Info,
 /// }
 ///
@@ -281,8 +281,8 @@ pub fn pin_data(inner: TokenStream, item: TokenStream) -> TokenStream {
 /// #[pin_data(PinnedDrop)]
 /// struct DriverData {
 ///     #[pin]
-///     queue: Mutex<Vec<Command>>,
-///     buf: Box<[u8; 1024 * 1024]>,
+///     queue: Mutex<KVec<Command>>,
+///     buf: KBox<[u8; 1024 * 1024]>,
 ///     raw_info: *mut Info,
 /// }
 ///
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index aef3b132f32b..e7a087b7e884 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -253,7 +253,7 @@ mod __module_init {{
                     #[doc(hidden)]
                     #[no_mangle]
                     #[link_section = \".init.text\"]
-                    pub unsafe extern \"C\" fn init_module() -> core::ffi::c_int {{
+                    pub unsafe extern \"C\" fn init_module() -> kernel::ffi::c_int {{
                         // SAFETY: This function is inaccessible to the outside due to the double
                         // module wrapping it. It is called exactly once by the C side via its
                         // unique name.
@@ -292,7 +292,7 @@ mod __module_init {{
                     #[doc(hidden)]
                     #[link_section = \"{initcall_section}\"]
                     #[used]
-                    pub static __{name}_initcall: extern \"C\" fn() -> core::ffi::c_int = __{name}_init;
+                    pub static __{name}_initcall: extern \"C\" fn() -> kernel::ffi::c_int = __{name}_init;
 
                     #[cfg(not(MODULE))]
                     #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
@@ -307,7 +307,7 @@ mod __module_init {{
                     #[cfg(not(MODULE))]
                     #[doc(hidden)]
                     #[no_mangle]
-                    pub extern \"C\" fn __{name}_init() -> core::ffi::c_int {{
+                    pub extern \"C\" fn __{name}_init() -> kernel::ffi::c_int {{
                         // SAFETY: This function is inaccessible to the outside due to the double
                         // module wrapping it. It is called exactly once by the C side via its
                         // placement above in the initcall section.
@@ -330,7 +330,7 @@ mod __module_init {{
                     /// # Safety
                     ///
                     /// This function must only be called once.
-                    unsafe fn __init() -> core::ffi::c_int {{
+                    unsafe fn __init() -> kernel::ffi::c_int {{
                         match <{type_} as kernel::Module>::init(&super::super::THIS_MODULE) {{
                             Ok(m) => {{
                                 // SAFETY: No data race, since `__MOD` can only be accessed by this
diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
index 80a00260e3e7..13495910271f 100644
--- a/rust/uapi/lib.rs
+++ b/rust/uapi/lib.rs
@@ -14,6 +14,7 @@
 #![cfg_attr(test, allow(unsafe_op_in_unsafe_fn))]
 #![allow(
     clippy::all,
+    clippy::undocumented_unsafe_blocks,
     dead_code,
     missing_docs,
     non_camel_case_types,
@@ -24,4 +25,9 @@
     unsafe_op_in_unsafe_fn
 )]
 
+// Manual definition of blocklisted types.
+type __kernel_size_t = usize;
+type __kernel_ssize_t = isize;
+type __kernel_ptrdiff_t = isize;
+
 include!(concat!(env!("OBJTREE"), "/rust/uapi/uapi_generated.rs"));
diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
index 2a9eaab62d1c..4aaf117bf8e3 100644
--- a/samples/rust/rust_minimal.rs
+++ b/samples/rust/rust_minimal.rs
@@ -13,7 +13,7 @@
 }
 
 struct RustMinimal {
-    numbers: Vec<i32>,
+    numbers: KVec<i32>,
 }
 
 impl kernel::Module for RustMinimal {
@@ -21,7 +21,7 @@ fn init(_module: &'static ThisModule) -> Result<Self> {
         pr_info!("Rust minimal sample (init)\n");
         pr_info!("Am I built-in? {}\n", !cfg!(MODULE));
 
-        let mut numbers = Vec::new();
+        let mut numbers = KVec::new();
         numbers.push(72, GFP_KERNEL)?;
         numbers.push(108, GFP_KERNEL)?;
         numbers.push(200, GFP_KERNEL)?;
diff --git a/samples/rust/rust_print.rs b/samples/rust/rust_print.rs
index 6eabb0d79ea3..ba1606bdbd75 100644
--- a/samples/rust/rust_print.rs
+++ b/samples/rust/rust_print.rs
@@ -15,6 +15,7 @@
 
 struct RustPrint;
 
+#[expect(clippy::disallowed_macros)]
 fn arc_print() -> Result {
     use kernel::sync::*;
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 880785b52c04..2bba59e790b8 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -248,7 +248,7 @@ $(obj)/%.lst: $(obj)/%.c FORCE
 # Compile Rust sources (.rs)
 # ---------------------------------------------------------------------------
 
-rust_allowed_features := arbitrary_self_types,new_uninit
+rust_allowed_features := arbitrary_self_types,lint_reasons
 
 # `--out-dir` is required to avoid temporaries being created by `rustc` in the
 # current working directory, which may be not accessible in the out-of-tree
@@ -258,7 +258,7 @@ rust_common_cmd = \
 	-Zallow-features=$(rust_allowed_features) \
 	-Zcrate-attr=no_std \
 	-Zcrate-attr='feature($(rust_allowed_features))' \
-	-Zunstable-options --extern force:alloc --extern kernel \
+	-Zunstable-options --extern kernel \
 	--crate-type rlib -L $(objtree)/rust/ \
 	--crate-name $(basename $(notdir $@)) \
 	--sysroot=/dev/null \
diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index d2bc63cde8c6..09e1d166d8d2 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -64,13 +64,6 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
         [],
     )
 
-    append_crate(
-        "alloc",
-        sysroot_src / "alloc" / "src" / "lib.rs",
-        ["core", "compiler_builtins"],
-        cfg=crates_cfgs.get("alloc", []),
-    )
-
     append_crate(
         "macros",
         srctree / "rust" / "macros" / "lib.rs",
@@ -96,7 +89,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     append_crate(
         "kernel",
         srctree / "rust" / "kernel" / "lib.rs",
-        ["core", "alloc", "macros", "build_error", "bindings"],
+        ["core", "macros", "build_error", "bindings"],
         cfg=cfg,
     )
     crates[-1]["source"] = {
@@ -133,7 +126,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
             append_crate(
                 name,
                 path,
-                ["core", "alloc", "kernel"],
+                ["core", "kernel"],
                 cfg=cfg,
             )
 
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 9955c4d54e42..b30faf731da7 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -106,7 +106,7 @@ static struct snd_seq_client *clientptr(int clientid)
 	return clienttab[clientid];
 }
 
-struct snd_seq_client *snd_seq_client_use_ptr(int clientid)
+static struct snd_seq_client *client_use_ptr(int clientid, bool load_module)
 {
 	unsigned long flags;
 	struct snd_seq_client *client;
@@ -126,7 +126,7 @@ struct snd_seq_client *snd_seq_client_use_ptr(int clientid)
 	}
 	spin_unlock_irqrestore(&clients_lock, flags);
 #ifdef CONFIG_MODULES
-	if (!in_interrupt()) {
+	if (load_module) {
 		static DECLARE_BITMAP(client_requested, SNDRV_SEQ_GLOBAL_CLIENTS);
 		static DECLARE_BITMAP(card_requested, SNDRV_CARDS);
 
@@ -168,6 +168,20 @@ struct snd_seq_client *snd_seq_client_use_ptr(int clientid)
 	return client;
 }
 
+/* get snd_seq_client object for the given id quickly */
+struct snd_seq_client *snd_seq_client_use_ptr(int clientid)
+{
+	return client_use_ptr(clientid, false);
+}
+
+/* get snd_seq_client object for the given id;
+ * if not found, retry after loading the modules
+ */
+static struct snd_seq_client *client_load_and_use_ptr(int clientid)
+{
+	return client_use_ptr(clientid, IS_ENABLED(CONFIG_MODULES));
+}
+
 /* Take refcount and perform ioctl_mutex lock on the given client;
  * used only for OSS sequencer
  * Unlock via snd_seq_client_ioctl_unlock() below
@@ -176,7 +190,7 @@ bool snd_seq_client_ioctl_lock(int clientid)
 {
 	struct snd_seq_client *client;
 
-	client = snd_seq_client_use_ptr(clientid);
+	client = client_load_and_use_ptr(clientid);
 	if (!client)
 		return false;
 	mutex_lock(&client->ioctl_mutex);
@@ -1195,7 +1209,7 @@ static int snd_seq_ioctl_running_mode(struct snd_seq_client *client, void  *arg)
 	int err = 0;
 
 	/* requested client number */
-	cptr = snd_seq_client_use_ptr(info->client);
+	cptr = client_load_and_use_ptr(info->client);
 	if (cptr == NULL)
 		return -ENOENT;		/* don't change !!! */
 
@@ -1257,7 +1271,7 @@ static int snd_seq_ioctl_get_client_info(struct snd_seq_client *client,
 	struct snd_seq_client *cptr;
 
 	/* requested client number */
-	cptr = snd_seq_client_use_ptr(client_info->client);
+	cptr = client_load_and_use_ptr(client_info->client);
 	if (cptr == NULL)
 		return -ENOENT;		/* don't change !!! */
 
@@ -1392,7 +1406,7 @@ static int snd_seq_ioctl_get_port_info(struct snd_seq_client *client, void *arg)
 	struct snd_seq_client *cptr;
 	struct snd_seq_client_port *port;
 
-	cptr = snd_seq_client_use_ptr(info->addr.client);
+	cptr = client_load_and_use_ptr(info->addr.client);
 	if (cptr == NULL)
 		return -ENXIO;
 
@@ -1496,10 +1510,10 @@ static int snd_seq_ioctl_subscribe_port(struct snd_seq_client *client,
 	struct snd_seq_client *receiver = NULL, *sender = NULL;
 	struct snd_seq_client_port *sport = NULL, *dport = NULL;
 
-	receiver = snd_seq_client_use_ptr(subs->dest.client);
+	receiver = client_load_and_use_ptr(subs->dest.client);
 	if (!receiver)
 		goto __end;
-	sender = snd_seq_client_use_ptr(subs->sender.client);
+	sender = client_load_and_use_ptr(subs->sender.client);
 	if (!sender)
 		goto __end;
 	sport = snd_seq_port_use_ptr(sender, subs->sender.port);
@@ -1864,7 +1878,7 @@ static int snd_seq_ioctl_get_client_pool(struct snd_seq_client *client,
 	struct snd_seq_client_pool *info = arg;
 	struct snd_seq_client *cptr;
 
-	cptr = snd_seq_client_use_ptr(info->client);
+	cptr = client_load_and_use_ptr(info->client);
 	if (cptr == NULL)
 		return -ENOENT;
 	memset(info, 0, sizeof(*info));
@@ -1968,7 +1982,7 @@ static int snd_seq_ioctl_get_subscription(struct snd_seq_client *client,
 	struct snd_seq_client_port *sport = NULL;
 
 	result = -EINVAL;
-	sender = snd_seq_client_use_ptr(subs->sender.client);
+	sender = client_load_and_use_ptr(subs->sender.client);
 	if (!sender)
 		goto __end;
 	sport = snd_seq_port_use_ptr(sender, subs->sender.port);
@@ -1999,7 +2013,7 @@ static int snd_seq_ioctl_query_subs(struct snd_seq_client *client, void *arg)
 	struct list_head *p;
 	int i;
 
-	cptr = snd_seq_client_use_ptr(subs->root.client);
+	cptr = client_load_and_use_ptr(subs->root.client);
 	if (!cptr)
 		goto __end;
 	port = snd_seq_port_use_ptr(cptr, subs->root.port);
@@ -2066,7 +2080,7 @@ static int snd_seq_ioctl_query_next_client(struct snd_seq_client *client,
 	if (info->client < 0)
 		info->client = 0;
 	for (; info->client < SNDRV_SEQ_MAX_CLIENTS; info->client++) {
-		cptr = snd_seq_client_use_ptr(info->client);
+		cptr = client_load_and_use_ptr(info->client);
 		if (cptr)
 			break; /* found */
 	}
@@ -2089,7 +2103,7 @@ static int snd_seq_ioctl_query_next_port(struct snd_seq_client *client,
 	struct snd_seq_client *cptr;
 	struct snd_seq_client_port *port = NULL;
 
-	cptr = snd_seq_client_use_ptr(info->addr.client);
+	cptr = client_load_and_use_ptr(info->addr.client);
 	if (cptr == NULL)
 		return -ENXIO;
 
@@ -2186,7 +2200,7 @@ static int snd_seq_ioctl_client_ump_info(struct snd_seq_client *caller,
 		size = sizeof(struct snd_ump_endpoint_info);
 	else
 		size = sizeof(struct snd_ump_block_info);
-	cptr = snd_seq_client_use_ptr(client);
+	cptr = client_load_and_use_ptr(client);
 	if (!cptr)
 		return -ENOENT;
 
@@ -2458,7 +2472,7 @@ int snd_seq_kernel_client_enqueue(int client, struct snd_seq_event *ev,
 	if (check_event_type_and_length(ev))
 		return -EINVAL;
 
-	cptr = snd_seq_client_use_ptr(client);
+	cptr = client_load_and_use_ptr(client);
 	if (cptr == NULL)
 		return -EINVAL;
 	
@@ -2690,7 +2704,7 @@ void snd_seq_info_clients_read(struct snd_info_entry *entry,
 
 	/* list the client table */
 	for (c = 0; c < SNDRV_SEQ_MAX_CLIENTS; c++) {
-		client = snd_seq_client_use_ptr(c);
+		client = client_load_and_use_ptr(c);
 		if (client == NULL)
 			continue;
 		if (client->type == NO_CLIENT) {
diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 68f1eee9e5c9..dbf933c18a82 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -208,6 +208,7 @@ comment "Set to Y if you want auto-loading the side codec driver"
 
 config SND_HDA_CODEC_REALTEK
 	tristate "Build Realtek HD-audio codec support"
+	depends on INPUT
 	select SND_HDA_GENERIC
 	select SND_HDA_GENERIC_LEDS
 	select SND_HDA_SCODEC_COMPONENT
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index b4540c5cd2a6..ea52bc7370a5 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2242,6 +2242,8 @@ static const struct snd_pci_quirk power_save_denylist[] = {
 	SND_PCI_QUIRK(0x1631, 0xe017, "Packard Bell NEC IMEDIA 5204", 0),
 	/* KONTRON SinglePC may cause a stall at runtime resume */
 	SND_PCI_QUIRK(0x1734, 0x1232, "KONTRON SinglePC", 0),
+	/* Dell ALC3271 */
+	SND_PCI_QUIRK(0x1028, 0x0962, "Dell ALC3271", 0),
 	{}
 };
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4a3b4c6d4114..b559f0d4e348 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3845,6 +3845,79 @@ static void alc225_shutup(struct hda_codec *codec)
 	}
 }
 
+static void alc222_init(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	hda_nid_t hp_pin = alc_get_hp_pin(spec);
+	bool hp1_pin_sense, hp2_pin_sense;
+
+	if (!hp_pin)
+		return;
+
+	msleep(30);
+
+	hp1_pin_sense = snd_hda_jack_detect(codec, hp_pin);
+	hp2_pin_sense = snd_hda_jack_detect(codec, 0x14);
+
+	if (hp1_pin_sense || hp2_pin_sense) {
+		msleep(2);
+
+		if (hp1_pin_sense)
+			snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+		if (hp2_pin_sense)
+			snd_hda_codec_write(codec, 0x14, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+		msleep(75);
+
+		if (hp1_pin_sense)
+			snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+		if (hp2_pin_sense)
+			snd_hda_codec_write(codec, 0x14, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+
+		msleep(75);
+	}
+}
+
+static void alc222_shutup(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	hda_nid_t hp_pin = alc_get_hp_pin(spec);
+	bool hp1_pin_sense, hp2_pin_sense;
+
+	if (!hp_pin)
+		hp_pin = 0x21;
+
+	hp1_pin_sense = snd_hda_jack_detect(codec, hp_pin);
+	hp2_pin_sense = snd_hda_jack_detect(codec, 0x14);
+
+	if (hp1_pin_sense || hp2_pin_sense) {
+		msleep(2);
+
+		if (hp1_pin_sense)
+			snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+		if (hp2_pin_sense)
+			snd_hda_codec_write(codec, 0x14, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+
+		msleep(75);
+
+		if (hp1_pin_sense)
+			snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+		if (hp2_pin_sense)
+			snd_hda_codec_write(codec, 0x14, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+
+		msleep(75);
+	}
+	alc_auto_setup_eapd(codec, false);
+	alc_shutup_pins(codec);
+}
+
 static void alc_default_init(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
@@ -4929,7 +5002,6 @@ static void alc298_fixup_samsung_amp_v2_4_amps(struct hda_codec *codec,
 		alc298_samsung_v2_init_amps(codec, 4);
 }
 
-#if IS_REACHABLE(CONFIG_INPUT)
 static void gpio2_mic_hotkey_event(struct hda_codec *codec,
 				   struct hda_jack_callback *event)
 {
@@ -5038,10 +5110,6 @@ static void alc233_fixup_lenovo_line2_mic_hotkey(struct hda_codec *codec,
 		spec->kb_dev = NULL;
 	}
 }
-#else /* INPUT */
-#define alc280_fixup_hp_gpio2_mic_hotkey	NULL
-#define alc233_fixup_lenovo_line2_mic_hotkey	NULL
-#endif /* INPUT */
 
 static void alc269_fixup_hp_line1_mic1_led(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
@@ -5055,6 +5123,16 @@ static void alc269_fixup_hp_line1_mic1_led(struct hda_codec *codec,
 	}
 }
 
+static void alc233_fixup_lenovo_low_en_micmute_led(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+		spec->micmute_led_polarity = 1;
+	alc233_fixup_lenovo_line2_mic_hotkey(codec, fix, action);
+}
+
 static void alc_hp_mute_disable(struct hda_codec *codec, unsigned int delay)
 {
 	if (delay <= 0)
@@ -7588,6 +7666,7 @@ enum {
 	ALC275_FIXUP_DELL_XPS,
 	ALC293_FIXUP_LENOVO_SPK_NOISE,
 	ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY,
+	ALC233_FIXUP_LENOVO_L2MH_LOW_ENLED,
 	ALC255_FIXUP_DELL_SPK_NOISE,
 	ALC225_FIXUP_DISABLE_MIC_VREF,
 	ALC225_FIXUP_DELL1_MIC_NO_PRESENCE,
@@ -7657,7 +7736,6 @@ enum {
 	ALC285_FIXUP_THINKPAD_X1_GEN7,
 	ALC285_FIXUP_THINKPAD_HEADSET_JACK,
 	ALC294_FIXUP_ASUS_ALLY,
-	ALC294_FIXUP_ASUS_ALLY_X,
 	ALC294_FIXUP_ASUS_ALLY_PINS,
 	ALC294_FIXUP_ASUS_ALLY_VERBS,
 	ALC294_FIXUP_ASUS_ALLY_SPEAKER,
@@ -8574,6 +8652,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc233_fixup_lenovo_line2_mic_hotkey,
 	},
+	[ALC233_FIXUP_LENOVO_L2MH_LOW_ENLED] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc233_fixup_lenovo_low_en_micmute_led,
+	},
 	[ALC233_FIXUP_INTEL_NUC8_DMIC] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_inv_dmic,
@@ -9096,12 +9178,6 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC294_FIXUP_ASUS_ALLY_PINS
 	},
-	[ALC294_FIXUP_ASUS_ALLY_X] = {
-		.type = HDA_FIXUP_FUNC,
-		.v.func = tas2781_fixup_i2c,
-		.chained = true,
-		.chain_id = ALC294_FIXUP_ASUS_ALLY_PINS
-	},
 	[ALC294_FIXUP_ASUS_ALLY_PINS] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -10586,7 +10662,6 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1740, "ASUS UX430UA", ALC295_FIXUP_ASUS_DACS),
 	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_DUAL_SPK),
 	SND_PCI_QUIRK(0x1043, 0x17f3, "ROG Ally NR2301L/X", ALC294_FIXUP_ASUS_ALLY),
-	SND_PCI_QUIRK(0x1043, 0x1eb3, "ROG Ally X RC72LA", ALC294_FIXUP_ASUS_ALLY_X),
 	SND_PCI_QUIRK(0x1043, 0x1863, "ASUS UX6404VI/VV", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1881, "ASUS Zephyrus S/M", ALC294_FIXUP_ASUS_GX502_PINS),
 	SND_PCI_QUIRK(0x1043, 0x18b1, "Asus MJ401TA", ALC256_FIXUP_ASUS_HEADSET_MIC),
@@ -10852,6 +10927,9 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3178, "ThinkCentre Station", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x31af, "ThinkCentre Station", ALC623_FIXUP_LENOVO_THINKSTATION_P340),
 	SND_PCI_QUIRK(0x17aa, 0x334b, "Lenovo ThinkCentre M70 Gen5", ALC283_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x17aa, 0x3384, "ThinkCentre M90a PRO", ALC233_FIXUP_LENOVO_L2MH_LOW_ENLED),
+	SND_PCI_QUIRK(0x17aa, 0x3386, "ThinkCentre M90a Gen6", ALC233_FIXUP_LENOVO_L2MH_LOW_ENLED),
+	SND_PCI_QUIRK(0x17aa, 0x3387, "ThinkCentre M70a Gen6", ALC233_FIXUP_LENOVO_L2MH_LOW_ENLED),
 	SND_PCI_QUIRK(0x17aa, 0x3801, "Lenovo Yoga9 14IAP7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	HDA_CODEC_QUIRK(0x17aa, 0x3802, "DuetITL 2021", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo Yoga Pro 9 14IRP8", ALC287_FIXUP_TAS2781_I2C),
@@ -11838,8 +11916,11 @@ static int patch_alc269(struct hda_codec *codec)
 		spec->codec_variant = ALC269_TYPE_ALC300;
 		spec->gen.mixer_nid = 0; /* no loopback on ALC300 */
 		break;
+	case 0x10ec0222:
 	case 0x10ec0623:
 		spec->codec_variant = ALC269_TYPE_ALC623;
+		spec->shutup = alc222_shutup;
+		spec->init_hook = alc222_init;
 		break;
 	case 0x10ec0700:
 	case 0x10ec0701:
diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index 5f81c68fd42b..5756ff3528a2 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -151,6 +151,12 @@ static int snd_usx2y_card_used[SNDRV_CARDS];
 static void snd_usx2y_card_private_free(struct snd_card *card);
 static void usx2y_unlinkseq(struct snd_usx2y_async_seq *s);
 
+#ifdef USX2Y_NRPACKS_VARIABLE
+int nrpacks = USX2Y_NRPACKS; /* number of packets per urb */
+module_param(nrpacks, int, 0444);
+MODULE_PARM_DESC(nrpacks, "Number of packets per URB.");
+#endif
+
 /*
  * pipe 4 is used for switching the lamps, setting samplerate, volumes ....
  */
@@ -432,6 +438,11 @@ static int snd_usx2y_probe(struct usb_interface *intf,
 	struct snd_card *card;
 	int err;
 
+#ifdef USX2Y_NRPACKS_VARIABLE
+	if (nrpacks < 0 || nrpacks > USX2Y_NRPACKS_MAX)
+		return -EINVAL;
+#endif
+
 	if (le16_to_cpu(device->descriptor.idVendor) != 0x1604 ||
 	    (le16_to_cpu(device->descriptor.idProduct) != USB_ID_US122 &&
 	     le16_to_cpu(device->descriptor.idProduct) != USB_ID_US224 &&
diff --git a/sound/usb/usx2y/usbusx2y.h b/sound/usb/usx2y/usbusx2y.h
index 391fd7b4ed5e..6a76d04bf1c7 100644
--- a/sound/usb/usx2y/usbusx2y.h
+++ b/sound/usb/usx2y/usbusx2y.h
@@ -7,6 +7,32 @@
 
 #define NRURBS	        2
 
+/* Default value used for nr of packs per urb.
+ * 1 to 4 have been tested ok on uhci.
+ * To use 3 on ohci, you'd need a patch:
+ * look for "0000425-linux-2.6.9-rc4-mm1_ohci-hcd.patch.gz" on
+ * "https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000425"
+ *
+ * 1, 2 and 4 work out of the box on ohci, if I recall correctly.
+ * Bigger is safer operation, smaller gives lower latencies.
+ */
+#define USX2Y_NRPACKS 4
+
+#define USX2Y_NRPACKS_MAX 1024
+
+/* If your system works ok with this module's parameter
+ * nrpacks set to 1, you might as well comment
+ * this define out, and thereby produce smaller, faster code.
+ * You'd also set USX2Y_NRPACKS to 1 then.
+ */
+#define USX2Y_NRPACKS_VARIABLE 1
+
+#ifdef USX2Y_NRPACKS_VARIABLE
+extern int nrpacks;
+#define nr_of_packs() nrpacks
+#else
+#define nr_of_packs() USX2Y_NRPACKS
+#endif
 
 #define URBS_ASYNC_SEQ 10
 #define URB_DATA_LEN_ASYNC_SEQ 32
diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
index f540f46a0b14..acca8bead82e 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -28,33 +28,6 @@
 #include "usx2y.h"
 #include "usbusx2y.h"
 
-/* Default value used for nr of packs per urb.
- * 1 to 4 have been tested ok on uhci.
- * To use 3 on ohci, you'd need a patch:
- * look for "0000425-linux-2.6.9-rc4-mm1_ohci-hcd.patch.gz" on
- * "https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000425"
- *
- * 1, 2 and 4 work out of the box on ohci, if I recall correctly.
- * Bigger is safer operation, smaller gives lower latencies.
- */
-#define USX2Y_NRPACKS 4
-
-/* If your system works ok with this module's parameter
- * nrpacks set to 1, you might as well comment
- * this define out, and thereby produce smaller, faster code.
- * You'd also set USX2Y_NRPACKS to 1 then.
- */
-#define USX2Y_NRPACKS_VARIABLE 1
-
-#ifdef USX2Y_NRPACKS_VARIABLE
-static int nrpacks = USX2Y_NRPACKS; /* number of packets per urb */
-#define  nr_of_packs() nrpacks
-module_param(nrpacks, int, 0444);
-MODULE_PARM_DESC(nrpacks, "Number of packets per URB.");
-#else
-#define nr_of_packs() USX2Y_NRPACKS
-#endif
-
 static int usx2y_urb_capt_retire(struct snd_usx2y_substream *subs)
 {
 	struct urb	*urb = subs->completed_urb;
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 2ed0ef6f21ee..32e9f194d449 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -4,6 +4,7 @@
 #include <argp.h>
 #include <unistd.h>
 #include <stdint.h>
+#include "bpf_util.h"
 #include "bench.h"
 #include "trigger_bench.skel.h"
 #include "trace_helpers.h"
@@ -72,7 +73,7 @@ static __always_inline void inc_counter(struct counter *counters)
 	unsigned slot;
 
 	if (unlikely(tid == 0))
-		tid = syscall(SYS_gettid);
+		tid = sys_gettid();
 
 	/* multiplicative hashing, it's fast */
 	slot = 2654435769U * tid;
diff --git a/tools/testing/selftests/bpf/bpf_util.h b/tools/testing/selftests/bpf/bpf_util.h
index 10587a29b967..feff92219e21 100644
--- a/tools/testing/selftests/bpf/bpf_util.h
+++ b/tools/testing/selftests/bpf/bpf_util.h
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
+#include <syscall.h>
 #include <bpf/libbpf.h> /* libbpf_num_possible_cpus */
 
 static inline unsigned int bpf_num_possible_cpus(void)
@@ -59,4 +60,12 @@ static inline void bpf_strlcpy(char *dst, const char *src, size_t sz)
 	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
 #endif
 
+/* Availability of gettid across glibc versions is hit-and-miss, therefore
+ * fallback to syscall in this macro and use it everywhere.
+ */
+#ifndef sys_gettid
+#define sys_gettid() syscall(SYS_gettid)
+#endif
+
+
 #endif /* __BPF_UTIL__ */
diff --git a/tools/testing/selftests/bpf/map_tests/task_storage_map.c b/tools/testing/selftests/bpf/map_tests/task_storage_map.c
index 7d050364efca..62971dbf2996 100644
--- a/tools/testing/selftests/bpf/map_tests/task_storage_map.c
+++ b/tools/testing/selftests/bpf/map_tests/task_storage_map.c
@@ -12,6 +12,7 @@
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
 
+#include "bpf_util.h"
 #include "test_maps.h"
 #include "task_local_storage_helpers.h"
 #include "read_bpf_task_storage_busy.skel.h"
@@ -115,7 +116,7 @@ void test_task_storage_map_stress_lookup(void)
 	CHECK(err, "attach", "error %d\n", err);
 
 	/* Trigger program */
-	syscall(SYS_gettid);
+	sys_gettid();
 	skel->bss->pid = 0;
 
 	CHECK(skel->bss->busy != 0, "bad bpf_task_storage_busy", "got %d\n", skel->bss->busy);
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 070c52c312e5..6befa870434b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -690,7 +690,7 @@ void test_bpf_cookie(void)
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
 
-	skel->bss->my_tid = syscall(SYS_gettid);
+	skel->bss->my_tid = sys_gettid();
 
 	if (test__start_subtest("kprobe"))
 		kprobe_subtest(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 9006549a1294..b8e1224cfd19 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -226,7 +226,7 @@ static void test_task_common_nocheck(struct bpf_iter_attach_opts *opts,
 	ASSERT_OK(pthread_create(&thread_id, NULL, &do_nothing_wait, NULL),
 		  "pthread_create");
 
-	skel->bss->tid = syscall(SYS_gettid);
+	skel->bss->tid = sys_gettid();
 
 	do_dummy_read_opts(skel->progs.dump_task, opts);
 
@@ -255,10 +255,10 @@ static void *run_test_task_tid(void *arg)
 	union bpf_iter_link_info linfo;
 	int num_unknown_tid, num_known_tid;
 
-	ASSERT_NEQ(getpid(), syscall(SYS_gettid), "check_new_thread_id");
+	ASSERT_NEQ(getpid(), sys_gettid(), "check_new_thread_id");
 
 	memset(&linfo, 0, sizeof(linfo));
-	linfo.task.tid = syscall(SYS_gettid);
+	linfo.task.tid = sys_gettid();
 	opts.link_info = &linfo;
 	opts.link_info_len = sizeof(linfo);
 	test_task_common(&opts, 0, 1);
diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
index 747761572098..9015e2c2ab12 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
@@ -63,14 +63,14 @@ static void test_tp_btf(int cgroup_fd)
 	if (!ASSERT_OK(err, "map_delete_elem"))
 		goto out;
 
-	skel->bss->target_pid = syscall(SYS_gettid);
+	skel->bss->target_pid = sys_gettid();
 
 	err = cgrp_ls_tp_btf__attach(skel);
 	if (!ASSERT_OK(err, "skel_attach"))
 		goto out;
 
-	syscall(SYS_gettid);
-	syscall(SYS_gettid);
+	sys_gettid();
+	sys_gettid();
 
 	skel->bss->target_pid = 0;
 
@@ -154,7 +154,7 @@ static void test_recursion(int cgroup_fd)
 		goto out;
 
 	/* trigger sys_enter, make sure it does not cause deadlock */
-	syscall(SYS_gettid);
+	sys_gettid();
 
 out:
 	cgrp_ls_recursion__destroy(skel);
@@ -224,7 +224,7 @@ static void test_yes_rcu_lock(__u64 cgroup_id)
 		return;
 
 	CGROUP_MODE_SET(skel);
-	skel->bss->target_pid = syscall(SYS_gettid);
+	skel->bss->target_pid = sys_gettid();
 
 	bpf_program__set_autoload(skel->progs.yes_rcu_lock, true);
 	err = cgrp_ls_sleepable__load(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index 26019313e1fc..1c682550e0e7 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -1010,7 +1010,7 @@ static void run_core_reloc_tests(bool use_btfgen)
 	struct data *data;
 	void *mmap_data = NULL;
 
-	my_pid_tgid = getpid() | ((uint64_t)syscall(SYS_gettid) << 32);
+	my_pid_tgid = getpid() | ((uint64_t)sys_gettid() << 32);
 
 	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
 		char btf_file[] = "/tmp/core_reloc.btf.XXXXXX";
diff --git a/tools/testing/selftests/bpf/prog_tests/linked_funcs.c b/tools/testing/selftests/bpf/prog_tests/linked_funcs.c
index cad664546912..fa639b021f7e 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_funcs.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_funcs.c
@@ -20,7 +20,7 @@ void test_linked_funcs(void)
 	bpf_program__set_autoload(skel->progs.handler1, true);
 	bpf_program__set_autoload(skel->progs.handler2, true);
 
-	skel->rodata->my_tid = syscall(SYS_gettid);
+	skel->rodata->my_tid = sys_gettid();
 	skel->bss->syscall_id = SYS_getpgid;
 
 	err = linked_funcs__load(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
index c29787e092d6..761ce24bce38 100644
--- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
@@ -23,7 +23,7 @@ static int get_pid_tgid(pid_t *pid, pid_t *tgid,
 	struct stat st;
 	int err;
 
-	*pid = syscall(SYS_gettid);
+	*pid = sys_gettid();
 	*tgid = getpid();
 
 	err = stat("/proc/self/ns/pid", &st);
diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
index a1f7e7378a64..ebe0c12b5536 100644
--- a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
@@ -21,7 +21,7 @@ static void test_success(void)
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
 
-	skel->bss->target_pid = syscall(SYS_gettid);
+	skel->bss->target_pid = sys_gettid();
 
 	bpf_program__set_autoload(skel->progs.get_cgroup_id, true);
 	bpf_program__set_autoload(skel->progs.task_succ, true);
@@ -58,7 +58,7 @@ static void test_rcuptr_acquire(void)
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
 
-	skel->bss->target_pid = syscall(SYS_gettid);
+	skel->bss->target_pid = sys_gettid();
 
 	bpf_program__set_autoload(skel->progs.task_acquire, true);
 	err = rcu_read_lock__load(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index c33c05161a9e..0d42ce00166f 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -23,14 +23,14 @@ static void test_sys_enter_exit(void)
 	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
 		return;
 
-	skel->bss->target_pid = syscall(SYS_gettid);
+	skel->bss->target_pid = sys_gettid();
 
 	err = task_local_storage__attach(skel);
 	if (!ASSERT_OK(err, "skel_attach"))
 		goto out;
 
-	syscall(SYS_gettid);
-	syscall(SYS_gettid);
+	sys_gettid();
+	sys_gettid();
 
 	/* 3x syscalls: 1x attach and 2x gettid */
 	ASSERT_EQ(skel->bss->enter_cnt, 3, "enter_cnt");
@@ -99,7 +99,7 @@ static void test_recursion(void)
 
 	/* trigger sys_enter, make sure it does not cause deadlock */
 	skel->bss->test_pid = getpid();
-	syscall(SYS_gettid);
+	sys_gettid();
 	skel->bss->test_pid = 0;
 	task_ls_recursion__detach(skel);
 
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index c1ac813ff9ba..02a484b22aa6 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -125,7 +125,7 @@ static void *child_thread(void *ctx)
 	struct child *child = ctx;
 	int c = 0, err;
 
-	child->tid = syscall(SYS_gettid);
+	child->tid = sys_gettid();
 
 	/* let parent know we are ready */
 	err = write(child->c2p[1], &c, 1);
diff --git a/tools/testing/selftests/damon/damon_nr_regions.py b/tools/testing/selftests/damon/damon_nr_regions.py
index 2e8a74aff543..58f3291fed12 100755
--- a/tools/testing/selftests/damon/damon_nr_regions.py
+++ b/tools/testing/selftests/damon/damon_nr_regions.py
@@ -65,6 +65,7 @@ def test_nr_regions(real_nr_regions, min_nr_regions, max_nr_regions):
 
     test_name = 'nr_regions test with %d/%d/%d real/min/max nr_regions' % (
             real_nr_regions, min_nr_regions, max_nr_regions)
+    collected_nr_regions.sort()
     if (collected_nr_regions[0] < min_nr_regions or
         collected_nr_regions[-1] > max_nr_regions):
         print('fail %s' % test_name)
@@ -109,6 +110,7 @@ def main():
     attrs = kdamonds.kdamonds[0].contexts[0].monitoring_attrs
     attrs.min_nr_regions = 3
     attrs.max_nr_regions = 7
+    attrs.update_us = 100000
     err = kdamonds.kdamonds[0].commit()
     if err is not None:
         proc.terminate()
diff --git a/tools/testing/selftests/damon/damos_quota.py b/tools/testing/selftests/damon/damos_quota.py
index 7d4c6bb2e3cd..57c4937aaed2 100755
--- a/tools/testing/selftests/damon/damos_quota.py
+++ b/tools/testing/selftests/damon/damos_quota.py
@@ -51,16 +51,19 @@ def main():
         nr_quota_exceeds = scheme.stats.qt_exceeds
 
     wss_collected.sort()
+    nr_expected_quota_exceeds = 0
     for wss in wss_collected:
         if wss > sz_quota:
             print('quota is not kept: %s > %s' % (wss, sz_quota))
             print('collected samples are as below')
             print('\n'.join(['%d' % wss for wss in wss_collected]))
             exit(1)
+        if wss == sz_quota:
+            nr_expected_quota_exceeds += 1
 
-    if nr_quota_exceeds < len(wss_collected):
-        print('quota is not always exceeded: %d > %d' %
-              (len(wss_collected), nr_quota_exceeds))
+    if nr_quota_exceeds < nr_expected_quota_exceeds:
+        print('quota is exceeded less than expected: %d < %d' %
+              (nr_quota_exceeds, nr_expected_quota_exceeds))
         exit(1)
 
 if __name__ == '__main__':
diff --git a/tools/testing/selftests/damon/damos_quota_goal.py b/tools/testing/selftests/damon/damos_quota_goal.py
index 18246f3b62f7..f76e0412b564 100755
--- a/tools/testing/selftests/damon/damos_quota_goal.py
+++ b/tools/testing/selftests/damon/damos_quota_goal.py
@@ -63,6 +63,9 @@ def main():
             if last_effective_bytes != 0 else -1.0))
 
         if last_effective_bytes == goal.effective_bytes:
+            # effective quota was already minimum that cannot be more reduced
+            if expect_increase is False and last_effective_bytes == 1:
+                continue
             print('efective bytes not changed: %d' % goal.effective_bytes)
             exit(1)
 
diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testing/selftests/mm/hugepage-mremap.c
index ada9156cc497..c463d1c09c9b 100644
--- a/tools/testing/selftests/mm/hugepage-mremap.c
+++ b/tools/testing/selftests/mm/hugepage-mremap.c
@@ -15,7 +15,7 @@
 #define _GNU_SOURCE
 #include <stdlib.h>
 #include <stdio.h>
-#include <asm-generic/unistd.h>
+#include <unistd.h>
 #include <sys/mman.h>
 #include <errno.h>
 #include <fcntl.h> /* Definition of O_* constants */
diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 66b4e111b5a2..b61803e36d1c 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -11,7 +11,7 @@
 #include <string.h>
 #include <stdbool.h>
 #include <stdint.h>
-#include <asm-generic/unistd.h>
+#include <unistd.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <sys/mman.h>
@@ -369,6 +369,7 @@ static void test_unmerge_discarded(void)
 	munmap(map, size);
 }
 
+#ifdef __NR_userfaultfd
 static void test_unmerge_uffd_wp(void)
 {
 	struct uffdio_writeprotect uffd_writeprotect;
@@ -429,6 +430,7 @@ static void test_unmerge_uffd_wp(void)
 unmap:
 	munmap(map, size);
 }
+#endif
 
 /* Verify that KSM can be enabled / queried with prctl. */
 static void test_prctl(void)
@@ -684,7 +686,9 @@ int main(int argc, char **argv)
 		exit(test_child_ksm());
 	}
 
+#ifdef __NR_userfaultfd
 	tests++;
+#endif
 
 	ksft_print_header();
 	ksft_set_plan(tests);
@@ -696,7 +700,9 @@ int main(int argc, char **argv)
 	test_unmerge();
 	test_unmerge_zero_pages();
 	test_unmerge_discarded();
+#ifdef __NR_userfaultfd
 	test_unmerge_uffd_wp();
+#endif
 
 	test_prot_none();
 
diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
index 74c911aa3aea..9a0597310a76 100644
--- a/tools/testing/selftests/mm/memfd_secret.c
+++ b/tools/testing/selftests/mm/memfd_secret.c
@@ -17,7 +17,7 @@
 
 #include <stdlib.h>
 #include <string.h>
-#include <asm-generic/unistd.h>
+#include <unistd.h>
 #include <errno.h>
 #include <stdio.h>
 #include <fcntl.h>
@@ -28,6 +28,8 @@
 #define pass(fmt, ...) ksft_test_result_pass(fmt, ##__VA_ARGS__)
 #define skip(fmt, ...) ksft_test_result_skip(fmt, ##__VA_ARGS__)
 
+#ifdef __NR_memfd_secret
+
 #define PATTERN	0x55
 
 static const int prot = PROT_READ | PROT_WRITE;
@@ -332,3 +334,13 @@ int main(int argc, char *argv[])
 
 	ksft_finished();
 }
+
+#else /* __NR_memfd_secret */
+
+int main(int argc, char *argv[])
+{
+	printf("skip: skipping memfd_secret test (missing __NR_memfd_secret)\n");
+	return KSFT_SKIP;
+}
+
+#endif /* __NR_memfd_secret */
diff --git a/tools/testing/selftests/mm/mkdirty.c b/tools/testing/selftests/mm/mkdirty.c
index 1db134063c38..b8a7efe9204e 100644
--- a/tools/testing/selftests/mm/mkdirty.c
+++ b/tools/testing/selftests/mm/mkdirty.c
@@ -9,7 +9,7 @@
  */
 #include <fcntl.h>
 #include <signal.h>
-#include <asm-generic/unistd.h>
+#include <unistd.h>
 #include <string.h>
 #include <errno.h>
 #include <stdlib.h>
@@ -265,6 +265,7 @@ static void test_pte_mapped_thp(void)
 	munmap(mmap_mem, mmap_size);
 }
 
+#ifdef __NR_userfaultfd
 static void test_uffdio_copy(void)
 {
 	struct uffdio_register uffdio_register;
@@ -321,6 +322,7 @@ static void test_uffdio_copy(void)
 	munmap(dst, pagesize);
 	free(src);
 }
+#endif /* __NR_userfaultfd */
 
 int main(void)
 {
@@ -333,7 +335,9 @@ int main(void)
 			       thpsize / 1024);
 		tests += 3;
 	}
+#ifdef __NR_userfaultfd
 	tests += 1;
+#endif /* __NR_userfaultfd */
 
 	ksft_print_header();
 	ksft_set_plan(tests);
@@ -363,7 +367,9 @@ int main(void)
 	if (thpsize)
 		test_pte_mapped_thp();
 	/* Placing a fresh page via userfaultfd may set the PTE dirty. */
+#ifdef __NR_userfaultfd
 	test_uffdio_copy();
+#endif /* __NR_userfaultfd */
 
 	err = ksft_get_fail_cnt();
 	if (err)
diff --git a/tools/testing/selftests/mm/mlock2.h b/tools/testing/selftests/mm/mlock2.h
index 1e5731bab499..4417eaa5cfb7 100644
--- a/tools/testing/selftests/mm/mlock2.h
+++ b/tools/testing/selftests/mm/mlock2.h
@@ -3,7 +3,6 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <asm-generic/unistd.h>
 
 static int mlock2_(void *start, size_t len, int flags)
 {
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index 4990f7ab4cb7..4fcecfb7b189 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -42,7 +42,7 @@
 #include <sys/wait.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <asm-generic/unistd.h>
+#include <unistd.h>
 #include <sys/ptrace.h>
 #include <setjmp.h>
 
diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 717539eddf98..7ad6ba660c7d 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -673,7 +673,11 @@ int uffd_open_dev(unsigned int flags)
 
 int uffd_open_sys(unsigned int flags)
 {
+#ifdef __NR_userfaultfd
 	return syscall(__NR_userfaultfd, flags);
+#else
+	return -1;
+#endif
 }
 
 int uffd_open(unsigned int flags)
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index a4b83280998a..944d559ade21 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -33,10 +33,11 @@
  * pthread_mutex_lock will also verify the atomicity of the memory
  * transfer (UFFDIO_COPY).
  */
-#include <asm-generic/unistd.h>
+
 #include "uffd-common.h"
 
 uint64_t features;
+#ifdef __NR_userfaultfd
 
 #define BOUNCE_RANDOM		(1<<0)
 #define BOUNCE_RACINGFAULTS	(1<<1)
@@ -471,3 +472,15 @@ int main(int argc, char **argv)
 	       nr_pages, nr_pages_per_cpu);
 	return userfaultfd_stress();
 }
+
+#else /* __NR_userfaultfd */
+
+#warning "missing __NR_userfaultfd definition"
+
+int main(void)
+{
+	printf("skip: Skipping userfaultfd test (missing __NR_userfaultfd)\n");
+	return KSFT_SKIP;
+}
+
+#endif /* __NR_userfaultfd */
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index a2e71b1636e7..3ddbb0a71b9c 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -5,11 +5,12 @@
  *  Copyright (C) 2015-2023  Red Hat, Inc.
  */
 
-#include <asm-generic/unistd.h>
 #include "uffd-common.h"
 
 #include "../../../../mm/gup_test.h"
 
+#ifdef __NR_userfaultfd
+
 /* The unit test doesn't need a large or random size, make it 32MB for now */
 #define  UFFD_TEST_MEM_SIZE               (32UL << 20)
 
@@ -1558,3 +1559,14 @@ int main(int argc, char *argv[])
 	return ksft_get_fail_cnt() ? KSFT_FAIL : KSFT_PASS;
 }
 
+#else /* __NR_userfaultfd */
+
+#warning "missing __NR_userfaultfd definition"
+
+int main(void)
+{
+	printf("Skipping %s (missing __NR_userfaultfd)\n", __file__);
+	return KSFT_SKIP;
+}
+
+#endif /* __NR_userfaultfd */
diff --git a/usr/include/Makefile b/usr/include/Makefile
index 771e32872b2a..58173cfe5ff1 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -10,7 +10,7 @@ UAPI_CFLAGS := -std=c90 -Wall -Werror=implicit-function-declaration
 
 # In theory, we do not care -m32 or -m64 for header compile tests.
 # It is here just because CONFIG_CC_CAN_LINK is tested with -m32 or -m64.
-UAPI_CFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CFLAGS))
+UAPI_CFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 
 # USERCFLAGS might contain sysroot location for CC.
 UAPI_CFLAGS += $(USERCFLAGS)

