Return-Path: <stable+bounces-114637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC29A2F0C4
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38F5E168420
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DD223A571;
	Mon, 10 Feb 2025 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yDxdybam"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CEF2397B0
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199669; cv=none; b=igFeytUpo/qCed7qTspCFhHrwit/CvqjIf2ECQG/3ZIeqOzgAXHJ8UyPZmTZjq45BvZ/Xp7qyYNXklql0Z9e0VJWYqQtrZokneK6WH7Zfjklj50SjTEMDRv1ldPjEyr3xmeslIPWVHT3dPUVZr9aGKfB8KzjuC3G5m7gq13jD4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199669; c=relaxed/simple;
	bh=5KyUZaK/Io7nW6Z1ngEsCOaS2qDsjOtY877p4vT5RmU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bz6HmQS6ew8Y+Lwc5VafZgQ/D/64EGiQHGGq8BNiv1eYIZDr9wawAJ/K8VLf+tbzR18KOirHeIo8L37LrUlX4o5YxXrXM8lZC1L3jPVncAzyWLODvcvuozFUmLzUtxNvWqYhk0565NMouJoYaezPO7PfXPGUiDcz2xY6B3dCiTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yDxdybam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20395C4CEDF;
	Mon, 10 Feb 2025 15:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739199669;
	bh=5KyUZaK/Io7nW6Z1ngEsCOaS2qDsjOtY877p4vT5RmU=;
	h=Subject:To:Cc:From:Date:From;
	b=yDxdybamX+frYndxbsVDPsz5xryUk6Qw2SraKrQF6xJi8QH0lQL6D7rmDd0QSsnjI
	 e0QR9Mcz1CgZZ8mImhjvJeUa9tcXTEwjfZlw7Orw5TFogOJCrhjOkXl/CIbGrUUj7g
	 i2vxmWrbZGFJWWPd6KEXXHxKumZQL0vjn2gtNeso=
Subject: FAILED: patch "[PATCH] s390/fpu: Add fpc exception handler / remove fixup section" failed to apply to 6.12-stable tree
To: hca@linux.ibm.com,agordeev@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 16:00:58 +0100
Message-ID: <2025021058-supplier-busybody-2b89@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ae02615b7fcea9ce9a4ec40b3c5b5dafd322b179
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021058-supplier-busybody-2b89@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ae02615b7fcea9ce9a4ec40b3c5b5dafd322b179 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Fri, 10 Jan 2025 11:52:17 +0100
Subject: [PATCH] s390/fpu: Add fpc exception handler / remove fixup section
 again

The fixup section was added again by mistake when test_fp_ctl() was
removed. The reason for the removal of the fixup section is described in
commit 484a8ed8b7d1 ("s390/extable: add dedicated uaccess handler").
Remove it again for the same reason.

Add an exception handler which handles exceptions when the floating point
control register is attempted to be set to invalid values. The exception
handler sets the floating point control register to zero and continues
execution at the specified address.

The new sfpc inline assembly is open-coded to make back porting a bit
easier.

Fixes: 702644249d3e ("s390/fpu: get rid of test_fp_ctl()")
Cc: stable@vger.kernel.org
Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

diff --git a/arch/s390/include/asm/asm-extable.h b/arch/s390/include/asm/asm-extable.h
index 4a6b0a8b6412..00a67464c445 100644
--- a/arch/s390/include/asm/asm-extable.h
+++ b/arch/s390/include/asm/asm-extable.h
@@ -14,6 +14,7 @@
 #define EX_TYPE_UA_LOAD_REG	5
 #define EX_TYPE_UA_LOAD_REGPAIR	6
 #define EX_TYPE_ZEROPAD		7
+#define EX_TYPE_FPC		8
 
 #define EX_DATA_REG_ERR_SHIFT	0
 #define EX_DATA_REG_ERR		GENMASK(3, 0)
@@ -84,4 +85,7 @@
 #define EX_TABLE_ZEROPAD(_fault, _target, _regdata, _regaddr)		\
 	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_ZEROPAD, _regdata, _regaddr, 0)
 
+#define EX_TABLE_FPC(_fault, _target)					\
+	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_FPC, __stringify(%%r0), __stringify(%%r0), 0)
+
 #endif /* __ASM_EXTABLE_H */
diff --git a/arch/s390/include/asm/fpu-insn.h b/arch/s390/include/asm/fpu-insn.h
index de510c9f6efa..0f1b59eb4c5a 100644
--- a/arch/s390/include/asm/fpu-insn.h
+++ b/arch/s390/include/asm/fpu-insn.h
@@ -100,19 +100,12 @@ static __always_inline void fpu_lfpc(unsigned int *fpc)
  */
 static inline void fpu_lfpc_safe(unsigned int *fpc)
 {
-	u32 tmp;
-
 	instrument_read(fpc, sizeof(*fpc));
 	asm_inline volatile(
-		"0:	lfpc	%[fpc]\n"
-		"1:	nopr	%%r7\n"
-		".pushsection .fixup, \"ax\"\n"
-		"2:	lghi	%[tmp],0\n"
-		"	sfpc	%[tmp]\n"
-		"	jg	1b\n"
-		".popsection\n"
-		EX_TABLE(1b, 2b)
-		: [tmp] "=d" (tmp)
+		"	lfpc	%[fpc]\n"
+		"0:	nopr	%%r7\n"
+		EX_TABLE_FPC(0b, 0b)
+		:
 		: [fpc] "Q" (*fpc)
 		: "memory");
 }
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 377b9aaf8c92..ff1ddba96352 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -52,7 +52,6 @@ SECTIONS
 		SOFTIRQENTRY_TEXT
 		FTRACE_HOTPATCH_TRAMPOLINES_TEXT
 		*(.text.*_indirect_*)
-		*(.fixup)
 		*(.gnu.warning)
 		. = ALIGN(PAGE_SIZE);
 		_etext = .;		/* End of text section */
diff --git a/arch/s390/mm/extable.c b/arch/s390/mm/extable.c
index 0a0738a473af..812ec5be1291 100644
--- a/arch/s390/mm/extable.c
+++ b/arch/s390/mm/extable.c
@@ -77,6 +77,13 @@ static bool ex_handler_zeropad(const struct exception_table_entry *ex, struct pt
 	return true;
 }
 
+static bool ex_handler_fpc(const struct exception_table_entry *ex, struct pt_regs *regs)
+{
+	asm volatile("sfpc	%[val]\n" : : [val] "d" (0));
+	regs->psw.addr = extable_fixup(ex);
+	return true;
+}
+
 bool fixup_exception(struct pt_regs *regs)
 {
 	const struct exception_table_entry *ex;
@@ -99,6 +106,8 @@ bool fixup_exception(struct pt_regs *regs)
 		return ex_handler_ua_load_reg(ex, true, regs);
 	case EX_TYPE_ZEROPAD:
 		return ex_handler_zeropad(ex, regs);
+	case EX_TYPE_FPC:
+		return ex_handler_fpc(ex, regs);
 	}
 	panic("invalid exception table entry");
 }


