Return-Path: <stable+bounces-20892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9DE85C626
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47E0AB20FFD
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 20:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F8B1509BC;
	Tue, 20 Feb 2024 20:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DMvHiEo7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C1F150995;
	Tue, 20 Feb 2024 20:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462696; cv=none; b=tgneJL82rjGUYok+xcUKm6yFlX5eJ86MTxlEWz1XnTGEynXm1VotGEHPwbTcECUtkGcF0KjG6F1Bk6nuVK2gn2a4oJuJuUah74kbFFSUc2S9b7xWfdAQ8N0oXmTLAjIRw4Ixe1poVQ6CAqmE8/jxw5YYtkchfVqZHO4vcsHn50I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462696; c=relaxed/simple;
	bh=6DLc/vizlUXXVDmybn9w7ymhcK+0akgN1sDId7ag1yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9Z7+ArFva+YBk4EEOHBAIoNdxkPfV1FZGuibe9A3o3s3J51375PxvgUdiMd3uavXgy/XtkuP1Wxt4nSm1ThN5f7XQk2MQfTvermq8l0dA+EKr5KdqWOTJS7Au8SQqYUSEfcSI1O8g3mMyQMrMx1U/jERrlFPWsQSZmSV4sjupM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DMvHiEo7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF61C433F1;
	Tue, 20 Feb 2024 20:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708462695;
	bh=6DLc/vizlUXXVDmybn9w7ymhcK+0akgN1sDId7ag1yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DMvHiEo7EkbTytd16S+sksW8T/Dor5LzDWGQy1vDeYdxzSBQOYP4nHx3YgNPMJEbo
	 RFM0R5XZtxPpd7P7abAddIfY1+CdIo+FEcYqWgq9Q63eNhky16zMQvsDjAanzkqdfj
	 QbNpx8MIv7CTQwS6JlJKYUIvIb0OkGlZt4uv9YfQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nick Desaulniers <ndesaulniers@google.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>,
	Andrew Pinski <quic_apinski@quicinc.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.1 001/197] work around gcc bugs with asm goto with outputs
Date: Tue, 20 Feb 2024 21:49:20 +0100
Message-ID: <20240220204841.121413956@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220204841.073267068@linuxfoundation.org>
References: <20240220204841.073267068@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 68fb3ca0e408e00db1c3f8fccdfa19e274c033be upstream.

We've had issues with gcc and 'asm goto' before, and we created a
'asm_volatile_goto()' macro for that in the past: see commits
3f0116c3238a ("compiler/gcc4: Add quirk for 'asm goto' miscompilation
bug") and a9f180345f53 ("compiler/gcc4: Make quirk for
asm_volatile_goto() unconditional").

Then, much later, we ended up removing the workaround in commit
43c249ea0b1e ("compiler-gcc.h: remove ancient workaround for gcc PR
58670") because we no longer supported building the kernel with the
affected gcc versions, but we left the macro uses around.

Now, Sean Christopherson reports a new version of a very similar
problem, which is fixed by re-applying that ancient workaround.  But the
problem in question is limited to only the 'asm goto with outputs'
cases, so instead of re-introducing the old workaround as-is, let's
rename and limit the workaround to just that much less common case.

It looks like there are at least two separate issues that all hit in
this area:

 (a) some versions of gcc don't mark the asm goto as 'volatile' when it
     has outputs:

        https://gcc.gnu.org/bugzilla/show_bug.cgi?id=98619
        https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110420

     which is easy to work around by just adding the 'volatile' by hand.

 (b) Internal compiler errors:

        https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110422

     which are worked around by adding the extra empty 'asm' as a
     barrier, as in the original workaround.

but the problem Sean sees may be a third thing since it involves bad
code generation (not an ICE) even with the manually added 'volatile'.

The same old workaround works for this case, even if this feels a
bit like voodoo programming and may only be hiding the issue.

Reported-and-tested-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/all/20240208220604.140859-1-seanjc@google.com/
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: Jakub Jelinek <jakub@redhat.com>
Cc: Andrew Pinski <quic_apinski@quicinc.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arc/include/asm/jump_label.h           |    4 ++--
 arch/arm/include/asm/jump_label.h           |    4 ++--
 arch/arm64/include/asm/alternative-macros.h |    4 ++--
 arch/arm64/include/asm/jump_label.h         |    4 ++--
 arch/csky/include/asm/jump_label.h          |    4 ++--
 arch/mips/include/asm/jump_label.h          |    4 ++--
 arch/parisc/include/asm/jump_label.h        |    4 ++--
 arch/powerpc/include/asm/bug.h              |    2 +-
 arch/powerpc/include/asm/jump_label.h       |    4 ++--
 arch/powerpc/include/asm/uaccess.h          |    8 ++++----
 arch/powerpc/kernel/irq_64.c                |    2 +-
 arch/riscv/include/asm/jump_label.h         |    4 ++--
 arch/s390/include/asm/jump_label.h          |    4 ++--
 arch/sparc/include/asm/jump_label.h         |    4 ++--
 arch/um/include/asm/cpufeature.h            |    2 +-
 arch/x86/include/asm/cpufeature.h           |    2 +-
 arch/x86/include/asm/jump_label.h           |    6 +++---
 arch/x86/include/asm/rmwcc.h                |    2 +-
 arch/x86/include/asm/uaccess.h              |   10 +++++-----
 arch/x86/include/asm/virtext.h              |   12 ++++++------
 arch/x86/kvm/svm/svm_ops.h                  |    6 +++---
 arch/x86/kvm/vmx/vmx.c                      |    8 ++++----
 arch/x86/kvm/vmx/vmx_ops.h                  |    6 +++---
 arch/xtensa/include/asm/jump_label.h        |    4 ++--
 include/linux/compiler-gcc.h                |   19 +++++++++++++++++++
 include/linux/compiler_types.h              |    4 ++--
 net/netfilter/nft_set_pipapo_avx2.c         |    2 +-
 samples/bpf/asm_goto_workaround.h           |    8 ++++----
 tools/arch/x86/include/asm/rmwcc.h          |    2 +-
 tools/include/linux/compiler_types.h        |    4 ++--
 30 files changed, 86 insertions(+), 67 deletions(-)

--- a/arch/arc/include/asm/jump_label.h
+++ b/arch/arc/include/asm/jump_label.h
@@ -31,7 +31,7 @@
 static __always_inline bool arch_static_branch(struct static_key *key,
 					       bool branch)
 {
-	asm_volatile_goto(".balign "__stringify(JUMP_LABEL_NOP_SIZE)"	\n"
+	asm goto(".balign "__stringify(JUMP_LABEL_NOP_SIZE)"		\n"
 		 "1:							\n"
 		 "nop							\n"
 		 ".pushsection __jump_table, \"aw\"			\n"
@@ -47,7 +47,7 @@ l_yes:
 static __always_inline bool arch_static_branch_jump(struct static_key *key,
 						    bool branch)
 {
-	asm_volatile_goto(".balign "__stringify(JUMP_LABEL_NOP_SIZE)"	\n"
+	asm goto(".balign "__stringify(JUMP_LABEL_NOP_SIZE)"		\n"
 		 "1:							\n"
 		 "b %l[l_yes]						\n"
 		 ".pushsection __jump_table, \"aw\"			\n"
--- a/arch/arm/include/asm/jump_label.h
+++ b/arch/arm/include/asm/jump_label.h
@@ -11,7 +11,7 @@
 
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("1:\n\t"
+	asm goto("1:\n\t"
 		 WASM(nop) "\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
 		 ".word 1b, %l[l_yes], %c0\n\t"
@@ -25,7 +25,7 @@ l_yes:
 
 static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("1:\n\t"
+	asm goto("1:\n\t"
 		 WASM(b) " %l[l_yes]\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
 		 ".word 1b, %l[l_yes], %c0\n\t"
--- a/arch/arm64/include/asm/alternative-macros.h
+++ b/arch/arm64/include/asm/alternative-macros.h
@@ -229,7 +229,7 @@ alternative_has_feature_likely(unsigned
 	compiletime_assert(feature < ARM64_NCAPS,
 			   "feature must be < ARM64_NCAPS");
 
-	asm_volatile_goto(
+	asm goto(
 	ALTERNATIVE_CB("b	%l[l_no]", %[feature], alt_cb_patch_nops)
 	:
 	: [feature] "i" (feature)
@@ -247,7 +247,7 @@ alternative_has_feature_unlikely(unsigne
 	compiletime_assert(feature < ARM64_NCAPS,
 			   "feature must be < ARM64_NCAPS");
 
-	asm_volatile_goto(
+	asm goto(
 	ALTERNATIVE("nop", "b	%l[l_yes]", %[feature])
 	:
 	: [feature] "i" (feature)
--- a/arch/arm64/include/asm/jump_label.h
+++ b/arch/arm64/include/asm/jump_label.h
@@ -18,7 +18,7 @@
 static __always_inline bool arch_static_branch(struct static_key *key,
 					       bool branch)
 {
-	asm_volatile_goto(
+	asm goto(
 		"1:	nop					\n\t"
 		 "	.pushsection	__jump_table, \"aw\"	\n\t"
 		 "	.align		3			\n\t"
@@ -35,7 +35,7 @@ l_yes:
 static __always_inline bool arch_static_branch_jump(struct static_key *key,
 						    bool branch)
 {
-	asm_volatile_goto(
+	asm goto(
 		"1:	b		%l[l_yes]		\n\t"
 		 "	.pushsection	__jump_table, \"aw\"	\n\t"
 		 "	.align		3			\n\t"
--- a/arch/csky/include/asm/jump_label.h
+++ b/arch/csky/include/asm/jump_label.h
@@ -12,7 +12,7 @@
 static __always_inline bool arch_static_branch(struct static_key *key,
 					       bool branch)
 {
-	asm_volatile_goto(
+	asm goto(
 		"1:	nop32					\n"
 		"	.pushsection	__jump_table, \"aw\"	\n"
 		"	.align		2			\n"
@@ -29,7 +29,7 @@ label:
 static __always_inline bool arch_static_branch_jump(struct static_key *key,
 						    bool branch)
 {
-	asm_volatile_goto(
+	asm goto(
 		"1:	bsr32		%l[label]		\n"
 		"	.pushsection	__jump_table, \"aw\"	\n"
 		"	.align		2			\n"
--- a/arch/mips/include/asm/jump_label.h
+++ b/arch/mips/include/asm/jump_label.h
@@ -36,7 +36,7 @@
 
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("1:\t" B_INSN " 2f\n\t"
+	asm goto("1:\t" B_INSN " 2f\n\t"
 		"2:\t.insn\n\t"
 		".pushsection __jump_table,  \"aw\"\n\t"
 		WORD_INSN " 1b, %l[l_yes], %0\n\t"
@@ -50,7 +50,7 @@ l_yes:
 
 static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("1:\t" J_INSN " %l[l_yes]\n\t"
+	asm goto("1:\t" J_INSN " %l[l_yes]\n\t"
 		".pushsection __jump_table,  \"aw\"\n\t"
 		WORD_INSN " 1b, %l[l_yes], %0\n\t"
 		".popsection\n\t"
--- a/arch/parisc/include/asm/jump_label.h
+++ b/arch/parisc/include/asm/jump_label.h
@@ -12,7 +12,7 @@
 
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("1:\n\t"
+	asm goto("1:\n\t"
 		 "nop\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
 		 ".align %1\n\t"
@@ -29,7 +29,7 @@ l_yes:
 
 static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("1:\n\t"
+	asm goto("1:\n\t"
 		 "b,n %l[l_yes]\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
 		 ".align %1\n\t"
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -74,7 +74,7 @@
 		  ##__VA_ARGS__)
 
 #define WARN_ENTRY(insn, flags, label, ...)		\
-	asm_volatile_goto(				\
+	asm goto(					\
 		"1:	" insn "\n"			\
 		EX_TABLE(1b, %l[label])			\
 		_EMIT_BUG_ENTRY				\
--- a/arch/powerpc/include/asm/jump_label.h
+++ b/arch/powerpc/include/asm/jump_label.h
@@ -17,7 +17,7 @@
 
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("1:\n\t"
+	asm goto("1:\n\t"
 		 "nop # arch_static_branch\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
 		 ".long 1b - ., %l[l_yes] - .\n\t"
@@ -32,7 +32,7 @@ l_yes:
 
 static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("1:\n\t"
+	asm goto("1:\n\t"
 		 "b %l[l_yes] # arch_static_branch_jump\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
 		 ".long 1b - ., %l[l_yes] - .\n\t"
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -72,7 +72,7 @@ __pu_failed:							\
  * are no aliasing issues.
  */
 #define __put_user_asm_goto(x, addr, label, op)			\
-	asm_volatile_goto(					\
+	asm goto(					\
 		"1:	" op "%U1%X1 %0,%1	# put_user\n"	\
 		EX_TABLE(1b, %l2)				\
 		:						\
@@ -85,7 +85,7 @@ __pu_failed:							\
 	__put_user_asm_goto(x, ptr, label, "std")
 #else /* __powerpc64__ */
 #define __put_user_asm2_goto(x, addr, label)			\
-	asm_volatile_goto(					\
+	asm goto(					\
 		"1:	stw%X1 %0, %1\n"			\
 		"2:	stw%X1 %L0, %L1\n"			\
 		EX_TABLE(1b, %l2)				\
@@ -132,7 +132,7 @@ do {								\
 #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
 #define __get_user_asm_goto(x, addr, label, op)			\
-	asm_volatile_goto(					\
+	asm_goto_output(					\
 		"1:	"op"%U1%X1 %0, %1	# get_user\n"	\
 		EX_TABLE(1b, %l2)				\
 		: "=r" (x)					\
@@ -145,7 +145,7 @@ do {								\
 	__get_user_asm_goto(x, addr, label, "ld")
 #else /* __powerpc64__ */
 #define __get_user_asm2_goto(x, addr, label)			\
-	asm_volatile_goto(					\
+	asm_goto_output(					\
 		"1:	lwz%X1 %0, %1\n"			\
 		"2:	lwz%X1 %L0, %L1\n"			\
 		EX_TABLE(1b, %l2)				\
--- a/arch/powerpc/kernel/irq_64.c
+++ b/arch/powerpc/kernel/irq_64.c
@@ -230,7 +230,7 @@ again:
 	 * This allows interrupts to be unmasked without hard disabling, and
 	 * also without new hard interrupts coming in ahead of pending ones.
 	 */
-	asm_volatile_goto(
+	asm goto(
 "1:					\n"
 "		lbz	9,%0(13)	\n"
 "		cmpwi	9,0		\n"
--- a/arch/riscv/include/asm/jump_label.h
+++ b/arch/riscv/include/asm/jump_label.h
@@ -17,7 +17,7 @@
 static __always_inline bool arch_static_branch(struct static_key * const key,
 					       const bool branch)
 {
-	asm_volatile_goto(
+	asm goto(
 		"	.align		2			\n\t"
 		"	.option push				\n\t"
 		"	.option norelax				\n\t"
@@ -39,7 +39,7 @@ label:
 static __always_inline bool arch_static_branch_jump(struct static_key * const key,
 						    const bool branch)
 {
-	asm_volatile_goto(
+	asm goto(
 		"	.align		2			\n\t"
 		"	.option push				\n\t"
 		"	.option norelax				\n\t"
--- a/arch/s390/include/asm/jump_label.h
+++ b/arch/s390/include/asm/jump_label.h
@@ -25,7 +25,7 @@
  */
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("0:	brcl 0,%l[label]\n"
+	asm goto("0:	brcl 0,%l[label]\n"
 			  ".pushsection __jump_table,\"aw\"\n"
 			  ".balign	8\n"
 			  ".long	0b-.,%l[label]-.\n"
@@ -39,7 +39,7 @@ label:
 
 static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("0:	brcl 15,%l[label]\n"
+	asm goto("0:	brcl 15,%l[label]\n"
 			  ".pushsection __jump_table,\"aw\"\n"
 			  ".balign	8\n"
 			  ".long	0b-.,%l[label]-.\n"
--- a/arch/sparc/include/asm/jump_label.h
+++ b/arch/sparc/include/asm/jump_label.h
@@ -10,7 +10,7 @@
 
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("1:\n\t"
+	asm goto("1:\n\t"
 		 "nop\n\t"
 		 "nop\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
@@ -26,7 +26,7 @@ l_yes:
 
 static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("1:\n\t"
+	asm goto("1:\n\t"
 		 "b %l[l_yes]\n\t"
 		 "nop\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
--- a/arch/um/include/asm/cpufeature.h
+++ b/arch/um/include/asm/cpufeature.h
@@ -75,7 +75,7 @@ extern void setup_clear_cpu_cap(unsigned
  */
 static __always_inline bool _static_cpu_has(u16 bit)
 {
-	asm_volatile_goto("1: jmp 6f\n"
+	asm goto("1: jmp 6f\n"
 		 "2:\n"
 		 ".skip -(((5f-4f) - (2b-1b)) > 0) * "
 			 "((5f-4f) - (2b-1b)),0x90\n"
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -173,7 +173,7 @@ extern void clear_cpu_cap(struct cpuinfo
  */
 static __always_inline bool _static_cpu_has(u16 bit)
 {
-	asm_volatile_goto(
+	asm goto(
 		ALTERNATIVE_TERNARY("jmp 6f", %P[feature], "", "jmp %l[t_no]")
 		".pushsection .altinstr_aux,\"ax\"\n"
 		"6:\n"
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -24,7 +24,7 @@
 
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("1:"
+	asm goto("1:"
 		"jmp %l[l_yes] # objtool NOPs this \n\t"
 		JUMP_TABLE_ENTRY
 		: :  "i" (key), "i" (2 | branch) : : l_yes);
@@ -38,7 +38,7 @@ l_yes:
 
 static __always_inline bool arch_static_branch(struct static_key * const key, const bool branch)
 {
-	asm_volatile_goto("1:"
+	asm goto("1:"
 		".byte " __stringify(BYTES_NOP5) "\n\t"
 		JUMP_TABLE_ENTRY
 		: :  "i" (key), "i" (branch) : : l_yes);
@@ -52,7 +52,7 @@ l_yes:
 
 static __always_inline bool arch_static_branch_jump(struct static_key * const key, const bool branch)
 {
-	asm_volatile_goto("1:"
+	asm goto("1:"
 		"jmp %l[l_yes]\n\t"
 		JUMP_TABLE_ENTRY
 		: :  "i" (key), "i" (branch) : : l_yes);
--- a/arch/x86/include/asm/rmwcc.h
+++ b/arch/x86/include/asm/rmwcc.h
@@ -18,7 +18,7 @@
 #define __GEN_RMWcc(fullop, _var, cc, clobbers, ...)			\
 ({									\
 	bool c = false;							\
-	asm_volatile_goto (fullop "; j" #cc " %l[cc_label]"		\
+	asm goto (fullop "; j" #cc " %l[cc_label]"		\
 			: : [var] "m" (_var), ## __VA_ARGS__		\
 			: clobbers : cc_label);				\
 	if (0) {							\
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -155,7 +155,7 @@ extern int __get_user_bad(void);
 
 #ifdef CONFIG_X86_32
 #define __put_user_goto_u64(x, addr, label)			\
-	asm_volatile_goto("\n"					\
+	asm goto("\n"					\
 		     "1:	movl %%eax,0(%1)\n"		\
 		     "2:	movl %%edx,4(%1)\n"		\
 		     _ASM_EXTABLE_UA(1b, %l2)			\
@@ -317,7 +317,7 @@ do {									\
 } while (0)
 
 #define __get_user_asm(x, addr, itype, ltype, label)			\
-	asm_volatile_goto("\n"						\
+	asm_goto_output("\n"						\
 		     "1:	mov"itype" %[umem],%[output]\n"		\
 		     _ASM_EXTABLE_UA(1b, %l2)				\
 		     : [output] ltype(x)				\
@@ -397,7 +397,7 @@ do {									\
 	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
 	__typeof__(*(_ptr)) __old = *_old;				\
 	__typeof__(*(_ptr)) __new = (_new);				\
-	asm_volatile_goto("\n"						\
+	asm_goto_output("\n"						\
 		     "1: " LOCK_PREFIX "cmpxchg"itype" %[new], %[ptr]\n"\
 		     _ASM_EXTABLE_UA(1b, %l[label])			\
 		     : CC_OUT(z) (success),				\
@@ -416,7 +416,7 @@ do {									\
 	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
 	__typeof__(*(_ptr)) __old = *_old;				\
 	__typeof__(*(_ptr)) __new = (_new);				\
-	asm_volatile_goto("\n"						\
+	asm_goto_output("\n"						\
 		     "1: " LOCK_PREFIX "cmpxchg8b %[ptr]\n"		\
 		     _ASM_EXTABLE_UA(1b, %l[label])			\
 		     : CC_OUT(z) (success),				\
@@ -499,7 +499,7 @@ struct __large_struct { unsigned long bu
  * aliasing issues.
  */
 #define __put_user_goto(x, addr, itype, ltype, label)			\
-	asm_volatile_goto("\n"						\
+	asm goto("\n"							\
 		"1:	mov"itype" %0,%1\n"				\
 		_ASM_EXTABLE_UA(1b, %l2)				\
 		: : ltype(x), "m" (__m(addr))				\
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -43,9 +43,9 @@ static inline int cpu_has_vmx(void)
  */
 static inline int cpu_vmxoff(void)
 {
-	asm_volatile_goto("1: vmxoff\n\t"
-			  _ASM_EXTABLE(1b, %l[fault])
-			  ::: "cc", "memory" : fault);
+	asm goto("1: vmxoff\n\t"
+		  _ASM_EXTABLE(1b, %l[fault])
+		  ::: "cc", "memory" : fault);
 
 	cr4_clear_bits(X86_CR4_VMXE);
 	return 0;
@@ -129,9 +129,9 @@ static inline void cpu_svm_disable(void)
 		 * case, GIF must already be set, otherwise the NMI would have
 		 * been blocked, so just eat the fault.
 		 */
-		asm_volatile_goto("1: stgi\n\t"
-				  _ASM_EXTABLE(1b, %l[fault])
-				  ::: "memory" : fault);
+		asm goto("1: stgi\n\t"
+			  _ASM_EXTABLE(1b, %l[fault])
+			  ::: "memory" : fault);
 fault:
 		wrmsrl(MSR_EFER, efer & ~EFER_SVME);
 	}
--- a/arch/x86/kvm/svm/svm_ops.h
+++ b/arch/x86/kvm/svm/svm_ops.h
@@ -8,7 +8,7 @@
 
 #define svm_asm(insn, clobber...)				\
 do {								\
-	asm_volatile_goto("1: " __stringify(insn) "\n\t"	\
+	asm goto("1: " __stringify(insn) "\n\t"	\
 			  _ASM_EXTABLE(1b, %l[fault])		\
 			  ::: clobber : fault);			\
 	return;							\
@@ -18,7 +18,7 @@ fault:								\
 
 #define svm_asm1(insn, op1, clobber...)				\
 do {								\
-	asm_volatile_goto("1: "  __stringify(insn) " %0\n\t"	\
+	asm goto("1: "  __stringify(insn) " %0\n\t"	\
 			  _ASM_EXTABLE(1b, %l[fault])		\
 			  :: op1 : clobber : fault);		\
 	return;							\
@@ -28,7 +28,7 @@ fault:								\
 
 #define svm_asm2(insn, op1, op2, clobber...)				\
 do {									\
-	asm_volatile_goto("1: "  __stringify(insn) " %1, %0\n\t"	\
+	asm goto("1: "  __stringify(insn) " %1, %0\n\t"	\
 			  _ASM_EXTABLE(1b, %l[fault])			\
 			  :: op1, op2 : clobber : fault);		\
 	return;								\
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2469,10 +2469,10 @@ static int kvm_cpu_vmxon(u64 vmxon_point
 
 	cr4_set_bits(X86_CR4_VMXE);
 
-	asm_volatile_goto("1: vmxon %[vmxon_pointer]\n\t"
-			  _ASM_EXTABLE(1b, %l[fault])
-			  : : [vmxon_pointer] "m"(vmxon_pointer)
-			  : : fault);
+	asm goto("1: vmxon %[vmxon_pointer]\n\t"
+		  _ASM_EXTABLE(1b, %l[fault])
+		  : : [vmxon_pointer] "m"(vmxon_pointer)
+		  : : fault);
 	return 0;
 
 fault:
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -73,7 +73,7 @@ static __always_inline unsigned long __v
 
 #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
-	asm_volatile_goto("1: vmread %[field], %[output]\n\t"
+	asm_goto_output("1: vmread %[field], %[output]\n\t"
 			  "jna %l[do_fail]\n\t"
 
 			  _ASM_EXTABLE(1b, %l[do_exception])
@@ -166,7 +166,7 @@ static __always_inline unsigned long vmc
 
 #define vmx_asm1(insn, op1, error_args...)				\
 do {									\
-	asm_volatile_goto("1: " __stringify(insn) " %0\n\t"		\
+	asm goto("1: " __stringify(insn) " %0\n\t"			\
 			  ".byte 0x2e\n\t" /* branch not taken hint */	\
 			  "jna %l[error]\n\t"				\
 			  _ASM_EXTABLE(1b, %l[fault])			\
@@ -183,7 +183,7 @@ fault:									\
 
 #define vmx_asm2(insn, op1, op2, error_args...)				\
 do {									\
-	asm_volatile_goto("1: "  __stringify(insn) " %1, %0\n\t"	\
+	asm goto("1: "  __stringify(insn) " %1, %0\n\t"			\
 			  ".byte 0x2e\n\t" /* branch not taken hint */	\
 			  "jna %l[error]\n\t"				\
 			  _ASM_EXTABLE(1b, %l[fault])			\
--- a/arch/xtensa/include/asm/jump_label.h
+++ b/arch/xtensa/include/asm/jump_label.h
@@ -13,7 +13,7 @@
 static __always_inline bool arch_static_branch(struct static_key *key,
 					       bool branch)
 {
-	asm_volatile_goto("1:\n\t"
+	asm goto("1:\n\t"
 			  "_nop\n\t"
 			  ".pushsection __jump_table,  \"aw\"\n\t"
 			  ".word 1b, %l[l_yes], %c0\n\t"
@@ -38,7 +38,7 @@ static __always_inline bool arch_static_
 	 * make it reachable and wrap both into a no-transform block
 	 * to avoid any assembler interference with this.
 	 */
-	asm_volatile_goto("1:\n\t"
+	asm goto("1:\n\t"
 			  ".begin no-transform\n\t"
 			  "_j %l[l_yes]\n\t"
 			  "2:\n\t"
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -66,6 +66,25 @@
 		__builtin_unreachable();	\
 	} while (0)
 
+/*
+ * GCC 'asm goto' with outputs miscompiles certain code sequences:
+ *
+ *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110420
+ *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110422
+ *
+ * Work it around via the same compiler barrier quirk that we used
+ * to use for the old 'asm goto' workaround.
+ *
+ * Also, always mark such 'asm goto' statements as volatile: all
+ * asm goto statements are supposed to be volatile as per the
+ * documentation, but some versions of gcc didn't actually do
+ * that for asms with outputs:
+ *
+ *    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=98619
+ */
+#define asm_goto_output(x...) \
+	do { asm volatile goto(x); asm (""); } while (0)
+
 #if defined(CONFIG_ARCH_USE_BUILTIN_BSWAP)
 #define __HAVE_BUILTIN_BSWAP32__
 #define __HAVE_BUILTIN_BSWAP64__
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -284,8 +284,8 @@ struct ftrace_likely_data {
 # define __realloc_size(x, ...)
 #endif
 
-#ifndef asm_volatile_goto
-#define asm_volatile_goto(x...) asm goto(x)
+#ifndef asm_goto_output
+#define asm_goto_output(x...) asm goto(x)
 #endif
 
 #ifdef CONFIG_CC_HAS_ASM_INLINE
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -57,7 +57,7 @@
 
 /* Jump to label if @reg is zero */
 #define NFT_PIPAPO_AVX2_NOMATCH_GOTO(reg, label)			\
-	asm_volatile_goto("vptest %%ymm" #reg ", %%ymm" #reg ";"	\
+	asm goto("vptest %%ymm" #reg ", %%ymm" #reg ";"	\
 			  "je %l[" #label "]" : : : : label)
 
 /* Store 256 bits from YMM register into memory. Contrary to bucket load
--- a/samples/bpf/asm_goto_workaround.h
+++ b/samples/bpf/asm_goto_workaround.h
@@ -4,14 +4,14 @@
 #define __ASM_GOTO_WORKAROUND_H
 
 /*
- * This will bring in asm_volatile_goto and asm_inline macro definitions
+ * This will bring in asm_goto_output and asm_inline macro definitions
  * if enabled by compiler and config options.
  */
 #include <linux/types.h>
 
-#ifdef asm_volatile_goto
-#undef asm_volatile_goto
-#define asm_volatile_goto(x...) asm volatile("invalid use of asm_volatile_goto")
+#ifdef asm_goto_output
+#undef asm_goto_output
+#define asm_goto_output(x...) asm volatile("invalid use of asm_goto_output")
 #endif
 
 /*
--- a/tools/arch/x86/include/asm/rmwcc.h
+++ b/tools/arch/x86/include/asm/rmwcc.h
@@ -4,7 +4,7 @@
 
 #define __GEN_RMWcc(fullop, var, cc, ...)				\
 do {									\
-	asm_volatile_goto (fullop "; j" cc " %l[cc_label]"		\
+	asm goto (fullop "; j" cc " %l[cc_label]"		\
 			: : "m" (var), ## __VA_ARGS__ 			\
 			: "memory" : cc_label);				\
 	return 0;							\
--- a/tools/include/linux/compiler_types.h
+++ b/tools/include/linux/compiler_types.h
@@ -36,8 +36,8 @@
 #include <linux/compiler-gcc.h>
 #endif
 
-#ifndef asm_volatile_goto
-#define asm_volatile_goto(x...) asm goto(x)
+#ifndef asm_goto_output
+#define asm_goto_output(x...) asm goto(x)
 #endif
 
 #endif /* __LINUX_COMPILER_TYPES_H */



