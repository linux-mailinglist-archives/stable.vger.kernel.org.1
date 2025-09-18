Return-Path: <stable+bounces-173095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A52B35BA9
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE10189768B
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B25A319866;
	Tue, 26 Aug 2025 11:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DiT1Gsvv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DAD326D48;
	Tue, 26 Aug 2025 11:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207360; cv=none; b=I1sqQAlOOhomUjVX6o2fr31eJiyy2taM7BEhIzmLb7E3bRZGh37eiAQWIy7JGWzmxLevSlRvZYN1BXYHAVs+SZ11aRZzOJnY+Wf8re5r76+BpYAw6UFJMR6BM5ULAuBWEV4kGPMPLL6FobRgNSD/SvsUbgjLt4nxiYRgxml+jak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207360; c=relaxed/simple;
	bh=FCkPZX70LUFB6kIT0J7AZ+m5nAf0xGH42LGtUDIkGc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNb5O0O48NvraSPwHGxJgf55GlRdf09qKGKSCAsuzRG0IpuVZjB56lPzVPuhTqJOgTZd0Zh2C7cJMQwSK6QD0zYAHpfYK8lZGTzB2FJSi8mUr8lq/AEGjVlRV4x6xeST2pNu23783M/lePGWz3a8AJHpzVJawd0sTHsu/1Wp5s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DiT1Gsvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2047C4CEF4;
	Tue, 26 Aug 2025 11:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756207359;
	bh=FCkPZX70LUFB6kIT0J7AZ+m5nAf0xGH42LGtUDIkGc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DiT1GsvvO50Julc/XfPKqjZkqV0Gxy3A6so/9L3WGJb6geUR41OJK1hAyp0IUNOMG
	 r8xm7YcTMmMy35wktvNTxr6kQTC+7tUpEMlqR62UyZDd8cpGYsEvi4Ee3Yl4M+urLW
	 DJ3w/xkW4r23uvVZCVA8nkjVClPgezYogvgHZHMs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John David Anglin <dave.anglin@bell.net>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 6.16 121/457] parisc: Check region is readable by user in raw_copy_from_user()
Date: Tue, 26 Aug 2025 13:06:45 +0200
Message-ID: <20250826110940.363246701@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John David Anglin <dave.anglin@bell.net>

commit 91428ca9320edbab1211851d82429d33b9cd73ef upstream.

Because of the way the _PAGE_READ is handled in the parisc PTE, an
access interruption is not generated when the kernel reads from a
region where the _PAGE_READ is zero. The current code was written
assuming read access faults would also occur in the kernel.

This change adds user access checks to raw_copy_from_user().  The
prober_user() define checks whether user code has read access to
a virtual address. Note that page faults are not handled in the
exception support for the probe instruction. For this reason, we
precede the probe by a ldb access check.

Signed-off-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # v5.12+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/include/asm/special_insns.h |   28 ++++++++++++++++++++++++++++
 arch/parisc/lib/memcpy.c                |   19 ++++++++++++++++++-
 2 files changed, 46 insertions(+), 1 deletion(-)

--- a/arch/parisc/include/asm/special_insns.h
+++ b/arch/parisc/include/asm/special_insns.h
@@ -32,6 +32,34 @@
 	pa;						\
 })
 
+/**
+ * prober_user() - Probe user read access
+ * @sr:		Space regster.
+ * @va:		Virtual address.
+ *
+ * Return: Non-zero if address is accessible.
+ *
+ * Due to the way _PAGE_READ is handled in TLB entries, we need
+ * a special check to determine whether a user address is accessible.
+ * The ldb instruction does the initial access check. If it is
+ * successful, the probe instruction checks user access rights.
+ */
+#define prober_user(sr, va)	({			\
+	unsigned long read_allowed;			\
+	__asm__ __volatile__(				\
+		"copy %%r0,%0\n"			\
+		"8:\tldb 0(%%sr%1,%2),%%r0\n"		\
+		"\tproberi (%%sr%1,%2),%3,%0\n"		\
+		"9:\n"					\
+		ASM_EXCEPTIONTABLE_ENTRY(8b, 9b,	\
+				"or %%r0,%%r0,%%r0")	\
+		: "=&r" (read_allowed)			\
+		: "i" (sr), "r" (va), "i" (PRIV_USER)	\
+		: "memory"				\
+	);						\
+	read_allowed;					\
+})
+
 #define CR_EIEM 15	/* External Interrupt Enable Mask */
 #define CR_CR16 16	/* CR16 Interval Timer */
 #define CR_EIRR 23	/* External Interrupt Request Register */
--- a/arch/parisc/lib/memcpy.c
+++ b/arch/parisc/lib/memcpy.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/compiler.h>
 #include <linux/uaccess.h>
+#include <linux/mm.h>
 
 #define get_user_space()	mfsp(SR_USER)
 #define get_kernel_space()	SR_KERNEL
@@ -32,9 +33,25 @@ EXPORT_SYMBOL(raw_copy_to_user);
 unsigned long raw_copy_from_user(void *dst, const void __user *src,
 			       unsigned long len)
 {
+	unsigned long start = (unsigned long) src;
+	unsigned long end = start + len;
+	unsigned long newlen = len;
+
 	mtsp(get_user_space(), SR_TEMP1);
 	mtsp(get_kernel_space(), SR_TEMP2);
-	return pa_memcpy(dst, (void __force *)src, len);
+
+	/* Check region is user accessible */
+	if (start)
+	while (start < end) {
+		if (!prober_user(SR_TEMP1, start)) {
+			newlen = (start - (unsigned long) src);
+			break;
+		}
+		start += PAGE_SIZE;
+		/* align to page boundry which may have different permission */
+		start = PAGE_ALIGN_DOWN(start);
+	}
+	return len - newlen + pa_memcpy(dst, (void __force *)src, newlen);
 }
 EXPORT_SYMBOL(raw_copy_from_user);
 



