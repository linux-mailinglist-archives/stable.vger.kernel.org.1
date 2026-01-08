Return-Path: <stable+bounces-206299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEE5D037C3
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 15:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 051D8307B53B
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 14:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28FA44D02A;
	Thu,  8 Jan 2026 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VT20jLL6"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572DC44D699
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 10:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767867364; cv=none; b=ttapnZtJP4i03M/8xhUWbmsZ/yCVemzZISLwLKxExoTxzExkSgrjgPxzwt1dnhZMLlMsCgPpLzmkqnP+rgkMHH+esycMr1Ah/JVPmLfnbfEuy8CtJvPXtwAzPbdF931yK8fzF//xEn/pMv3hA2JShFl4wt15mbBzS7qn/zIlSVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767867364; c=relaxed/simple;
	bh=fj1FBkh7W+PEQibJwDFOmX8Obsz2clEaCmmdzKNnPiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RMfZDtyPflbiRe867GPoR0vqSeG4lbhg7v590TV42W6X74WUG/idVg17wDmzx0kS32Zeyo7ELu2jtfstJiS/mhpSj60t6BpUpXfqlGdan1A2lHsQwtDIg3iiSQK1IYBTnp2ZeMkK51vrLqzDYn9s7LJK5E0I+iS2G6EAH+dnju4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VT20jLL6; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=JMbkyDAgPtB4zqdiXuZ7+Dzb6wYBlHTRTXDmKyclHgs=; b=VT20jLL6qedEYId2eTh1xfw9q7
	Dory1cctc5/w7mQ6zvykOEHYmS8+/9MB4qMnRHgj47Vy34DlNGrkcN47LbBZ9AZN+aJeoKzLgXv6g
	uWjXe5QddGcnKkV83ohuCgYJ8ZzeMP8ZcWDEl8rolQL6OuA6Is86VussAjwRv8GWWwPNuclgJEL4h
	osph8y0/tdvKYVBp4ziykHHWVZchBtynbD2FAMjzI1bdbW51+V9A3YBbnhrDe2D1mTCvMjTZvizYe
	kLcQunMfPMdnw3kjjCTDw89KjYleZVe/QkduW/89NzIhqbDZeYpDmLhFPEvHAGWpX4RC5Nkqeres+
	1k/kE14Q==;
Received: from 179-125-75-246-dinamico.pombonet.net.br ([179.125.75.246] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vdn3Z-002vo2-C0; Thu, 08 Jan 2026 11:15:53 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@infradead.org>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.15 1/2] x86: remove __range_not_ok()
Date: Thu,  8 Jan 2026 07:15:44 -0300
Message-ID: <20260108101545.2982626-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

commit 36903abedfe8d419e90ce349b2b4ce6dc2883e17 upstream.

The __range_not_ok() helper is an x86 (and sparc64) specific interface
that does roughly the same thing as __access_ok(), but with different
calling conventions.

Change this to use the normal interface in order for consistency as we
clean up all access_ok() implementations.

This changes the limit from TASK_SIZE to TASK_SIZE_MAX, which Al points
out is the right thing do do here anyway.

The callers have to use __access_ok() instead of the normal access_ok()
though, because on x86 that contains a WARN_ON_IN_IRQ() check that cannot
be used inside of NMI context while tracing.

The check in copy_code() is not needed any more, because this one is
already done by copy_from_user_nmi().

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Link: https://lore.kernel.org/lkml/YgsUKcXGR7r4nINj@zeniv-ca.linux.org.uk/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Stable-dep-of: d319f344561d ("mm: Fix copy_from_user_nofault().")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 arch/x86/events/core.c         |  2 +-
 arch/x86/include/asm/uaccess.h | 10 ++++++----
 arch/x86/kernel/dumpstack.c    |  6 ------
 arch/x86/kernel/stacktrace.c   |  2 +-
 arch/x86/lib/usercopy.c        |  2 +-
 5 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 9a77c6062c24..fdf1e2aaa5ed 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2790,7 +2790,7 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
 static inline int
 valid_user_frame(const void __user *fp, unsigned long size)
 {
-	return (__range_not_ok(fp, size, TASK_SIZE) == 0);
+	return __access_ok(fp, size);
 }
 
 static unsigned long get_segment_base(unsigned int segment)
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3616fd4ba395..66284ac86076 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -16,8 +16,10 @@
  * Test whether a block of memory is a valid user space address.
  * Returns 0 if the range is valid, nonzero otherwise.
  */
-static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, unsigned long limit)
+static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size)
 {
+	unsigned long limit = TASK_SIZE_MAX;
+
 	/*
 	 * If we have used "sizeof()" for the size,
 	 * we know it won't overflow the limit (but
@@ -35,10 +37,10 @@ static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, un
 	return unlikely(addr > limit);
 }
 
-#define __range_not_ok(addr, size, limit)				\
+#define __access_ok(addr, size)						\
 ({									\
 	__chk_user_ptr(addr);						\
-	__chk_range_not_ok((unsigned long __force)(addr), size, limit); \
+	!__chk_range_not_ok((unsigned long __force)(addr), size);	\
 })
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
@@ -69,7 +71,7 @@ static inline bool pagefault_disabled(void);
 #define access_ok(addr, size)					\
 ({									\
 	WARN_ON_IN_IRQ();						\
-	likely(!__range_not_ok(addr, size, TASK_SIZE_MAX));		\
+	likely(__access_ok(addr, size));				\
 })
 
 extern int __get_user_1(void);
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 8a8660074284..bf73dbfb2355 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -81,12 +81,6 @@ static int copy_code(struct pt_regs *regs, u8 *buf, unsigned long src,
 	/* The user space code from other tasks cannot be accessed. */
 	if (regs != task_pt_regs(current))
 		return -EPERM;
-	/*
-	 * Make sure userspace isn't trying to trick us into dumping kernel
-	 * memory by pointing the userspace instruction pointer at it.
-	 */
-	if (__chk_range_not_ok(src, nbytes, TASK_SIZE_MAX))
-		return -EINVAL;
 
 	/*
 	 * Even if named copy_from_user_nmi() this can be invoked from
diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 15b058eefc4e..ee117fcf46ed 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -90,7 +90,7 @@ copy_stack_frame(const struct stack_frame_user __user *fp,
 {
 	int ret;
 
-	if (__range_not_ok(fp, sizeof(*frame), TASK_SIZE))
+	if (!__access_ok(fp, sizeof(*frame)))
 		return 0;
 
 	ret = 1;
diff --git a/arch/x86/lib/usercopy.c b/arch/x86/lib/usercopy.c
index c3e8a62ca561..ad0139d25401 100644
--- a/arch/x86/lib/usercopy.c
+++ b/arch/x86/lib/usercopy.c
@@ -32,7 +32,7 @@ copy_from_user_nmi(void *to, const void __user *from, unsigned long n)
 {
 	unsigned long ret;
 
-	if (__range_not_ok(from, n, TASK_SIZE))
+	if (!__access_ok(from, n))
 		return n;
 
 	if (!nmi_uaccess_okay())
-- 
2.47.3


