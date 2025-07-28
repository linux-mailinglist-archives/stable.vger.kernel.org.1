Return-Path: <stable+bounces-165004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E07DB141B2
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 20:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D30947ABDB3
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 18:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3AB275B12;
	Mon, 28 Jul 2025 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cpw1GdC0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834802561A7
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725443; cv=none; b=CFVvkfsruOxk+k8c5lJQzk/UdWMcqO183bdcHjiqbqh5iDQP+BUqlZF16xCIBhjZtokGEjjR2LDuxWOWtPktYci38eFAvV9BjhITDgtj8z671HazQr05OLEQd9QRPTz/NQyJbcdBKRGhNcUtafuV2owQY2rKpz/SNOeicFmQoyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725443; c=relaxed/simple;
	bh=SOOV5VouMdu4NrR+4g6lTRFS8oPUL6aNSfHMus3RBVk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Emnr7hF9B26qaCLpPfdVpnYKXA6IEpbyBqjvZmGSz3Fkd2pYrVjLrOCAwTbIqh2UU8cYrBQJL3MxAaoMIzYBrmmAh82z1djQtJ7uwTa7MRzGRPSTGKwN9nhSxDW3y9hNBcDx2Dd5WxjaOa/BEM5HYGrWVKK4CKwothSGO2Ced/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cpw1GdC0; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74ea5d9982cso4151789b3a.2
        for <stable@vger.kernel.org>; Mon, 28 Jul 2025 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725440; x=1754330240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vscHXQVG0eTLZ+LHlIb0JUUnQG0Fd4hw8rPrFp+lP28=;
        b=cpw1GdC0gYTbCY6pc+lRrjR85LCHwys/67MJAhYshDujd2xnaLu5NRrPYbpSyC0w5d
         jxFPC+CautPK6pzj7DjvVo9mdawO8UjrwT7KBJdVReCaqmcX/Q+i6wrdGrudSF28nzyQ
         Z5NMsCNPwvacoVYBX3e1QP17s7kaXGhm3gY0/UkR2LqCTDogYqpjETm/WXL9K2dGm/VT
         m3bm1xpPUrAgeJ8d5KHikQsQp11LNMtjV1wtRTwIA2fsBDIJT9oxue+3e7SD7eO6hkbs
         5QyRC9zC654nL0rI/2EZ4+WRmxssCSp1Zh+2eTSXP96Xi2GAYFIaepWj3RH13LAEN++M
         +QbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725440; x=1754330240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vscHXQVG0eTLZ+LHlIb0JUUnQG0Fd4hw8rPrFp+lP28=;
        b=txW2mXxwwpAZIyq+9LOEa61uwpV/E2+9SwZeVRmTOABKuuyky+gGkMSycTCf0AQpoH
         UeC830C4+8Eqk7mhwYUMB5ZIiv0HP1uU28ptCvx6GQmqF1CVjT4wZcpkiR+CFAxm1tP+
         Vln6hOUxTnINjD0DnRjQtSeHXYop3IXYy17PcOzbYwLOr0zWsdB3EL0QwdEbwT/PPWBP
         pitws55a+tGwpBRtRgQpL0p1iIQxslvVxUaMbIfyXWxKX39a54jcgbDWooJxZIJsC44L
         Wx+FXSx3ieJgWSK1OGotmZYsSuy1OOhP9S1D/7JZu4PKkaXSR/hT0CQivP4bDBxszeAF
         UHxA==
X-Gm-Message-State: AOJu0YzPv/Kys2V6/LV5/SOcX2BUHOGWMiZ9WjanKc5O7FxwrXSyKUfq
	2T2+V/JumjwWOcvZrA1920UFDYQu77J9+THDq/adIIx8/WGyIRIOvf8YOv7CoST0WIq5en53iQj
	DQec+BJlvkuna0jQMNHTfXSgr3/MHGwyoGQpU+WpT8/SlAZVyCX5tj/kj2MXJ7eOrM7hCsIAapM
	B4teljtkZeJ+Q3VXqMbUlbGm5UvUdiAANlDe2PK0J0IKIlWBKC9tTo
X-Google-Smtp-Source: AGHT+IG1c+a2EKRZCZyUmDrJ/47zFvSMXXlhtD9A46RvtTyqflNKmlqHjLnQC+E47s6fJbgyHxPL+f6DJQpDknw=
X-Received: from pgbbw39.prod.google.com ([2002:a05:6a02:4a7:b0:b31:d7a7:69ab])
 (user=jtoantran job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:1584:b0:239:29ea:9c97 with SMTP id adf61e73a8af0-23d701519cemr21753720637.24.1753725439607;
 Mon, 28 Jul 2025 10:57:19 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:56:55 +0000
In-Reply-To: <20250728175701.3286764-1-jtoantran@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723163209.1929303-1-jtoantran@google.com> <20250728175701.3286764-1-jtoantran@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175701.3286764-3-jtoantran@google.com>
Subject: [PATCH v2 2/7] runtime constants: add default dummy infrastructure
From: Jimmy Tran <jtoantran@google.com>
To: stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	David Laight <david.laight@aculab.com>, Andrei Vagin <avagin@gmail.com>, 
	Jimmy Tran <jtoantran@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Linus Torvalds <torvalds@linux-foundation.org>

commit e78298556ee5d881f6679effb2a6743969ea6e2d upstream.

This adds the initial dummy support for 'runtime constants' for when
an architecture doesn't actually support an implementation of fixing
up said runtime constants.

This ends up being the fallback to just using the variables as regular
__ro_after_init variables, and changes the dcache d_hash() function to
use this model.

Cc: <stable@vger.kernel.org> # 6.10.x: e60cc61: vfs: dcache: move hashlen_hash
Fixes: e78298556ee5 ("runtime constants: add default dummy infrastructure")
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jimmy Tran <jtoantran@google.com>
---
 fs/dcache.c                         | 11 ++++++++++-
 include/asm-generic/Kbuild          |  1 +
 include/asm-generic/runtime-const.h | 15 +++++++++++++++
 include/asm-generic/vmlinux.lds.h   |  8 ++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 include/asm-generic/runtime-const.h

diff --git a/fs/dcache.c b/fs/dcache.c
index 82adee104f82c..9e5c92b4b4aaa 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -35,6 +35,8 @@
 #include "internal.h"
 #include "mount.h"
 
+#include <asm/runtime-const.h>
+
 /*
  * Usage:
  * dcache->d_inode->i_lock protects:
@@ -102,7 +104,8 @@ static struct hlist_bl_head *dentry_hashtable __read_mostly;
 
 static inline struct hlist_bl_head *d_hash(unsigned long hashlen)
 {
-	return dentry_hashtable + ((u32)hashlen >> d_hash_shift);
+	return runtime_const_ptr(dentry_hashtable) +
+		runtime_const_shift_right_32(hashlen, d_hash_shift);
 }
 
 #define IN_LOOKUP_SHIFT 10
@@ -3297,6 +3300,9 @@ static void __init dcache_init_early(void)
 					0,
 					0);
 	d_hash_shift = 32 - d_hash_shift;
+
+	runtime_const_init(shift, d_hash_shift);
+	runtime_const_init(ptr, dentry_hashtable);
 }
 
 static void __init dcache_init(void)
@@ -3325,6 +3331,9 @@ static void __init dcache_init(void)
 					0,
 					0);
 	d_hash_shift = 32 - d_hash_shift;
+
+	runtime_const_init(shift, d_hash_shift);
+	runtime_const_init(ptr, dentry_hashtable);
 }
 
 /* SLAB cache for __getname() consumers */
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 941be574bbe00..22673ec5defbb 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -46,6 +46,7 @@ mandatory-y += pci.h
 mandatory-y += percpu.h
 mandatory-y += pgalloc.h
 mandatory-y += preempt.h
+mandatory-y += runtime-const.h
 mandatory-y += rwonce.h
 mandatory-y += sections.h
 mandatory-y += serial.h
diff --git a/include/asm-generic/runtime-const.h b/include/asm-generic/runtime-const.h
new file mode 100644
index 0000000000000..3e68a17fbf287
--- /dev/null
+++ b/include/asm-generic/runtime-const.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RUNTIME_CONST_H
+#define _ASM_RUNTIME_CONST_H
+
+/*
+ * This is the fallback for when the architecture doesn't
+ * support the runtime const operations.
+ *
+ * We just use the actual symbols as-is.
+ */
+#define runtime_const_ptr(sym) (sym)
+#define runtime_const_shift_right_32(val, sym) ((u32)(val)>>(sym))
+#define runtime_const_init(type, sym) do { } while (0)
+
+#endif
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index cf3f8b9bf43f0..66bfd3dc91a33 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -907,6 +907,14 @@
 #define CON_INITCALL							\
 	BOUNDED_SECTION_POST_LABEL(.con_initcall.init, __con_initcall, _start, _end)
 
+#define RUNTIME_NAME(t, x) runtime_##t##_##x
+
+#define RUNTIME_CONST(t, x)						\
+	. = ALIGN(8);							\
+	RUNTIME_NAME(t, x) : AT(ADDR(RUNTIME_NAME(t, x)) - LOAD_OFFSET) {	\
+		*(RUNTIME_NAME(t, x));					\
+	}
+
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
 #define KUNIT_TABLE()							\
 		. = ALIGN(8);						\
-- 
2.50.1.470.g6ba607880d-goog


