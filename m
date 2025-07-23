Return-Path: <stable+bounces-164485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEF2B0F82A
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 18:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB84544160
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 16:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222211F4634;
	Wed, 23 Jul 2025 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GV6Xj0wU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607751F4628
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288339; cv=none; b=BXdSSkEmKJWMfJCOViYobfsWzmTUu3w+2+GeSeHESRRWjMBiwkAgIzCYZoObadBVdPlmTzAkMWpw16OviFJml8OYD5efEcDzwRq2CiBfG9WOUdAsHZQZLHt4a+Sa1bL+Np90ixzDMS+amNVSFqPyqA/MUPgFadLwPxza8cUJFIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288339; c=relaxed/simple;
	bh=i2PevyDaj0s7rgGu8xf75hRjJbgkN6sLNaP3bfNMmc0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AAsEsYAsQRuQY0KaWSHA3A5Iizbk0mhiyYzfim3g5D1xV2U2P07cJTOw07dQtSb6ZUPZ2lHpl0DuwWF5tnyzv9uFDJZ7VrNBgaSy2pkcR55rk82s0AfyonFlFLduL2PO8m1gnAygH+pyqhx+7+CiOSYU7+JAhvenuuT9fO4dU6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GV6Xj0wU; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b31cc625817so880451a12.0
        for <stable@vger.kernel.org>; Wed, 23 Jul 2025 09:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753288338; x=1753893138; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m0s3rllgkjDarEULakl9MiGjhDbZfYra7BMAYPRbah0=;
        b=GV6Xj0wUL3S0BKtE1OaiXzfL2gWf0VGqqqh+GfMJW84ukuOC0eZUW34F4ox00OuzCD
         huXWE5xb5SzcimCaaPSkgz8vC+d0M/hQS7zyy7CWgDtmLSyvY2Ogo6FGMr9qnNWCvFeP
         cwF3W+R/lDoaJLE1KaUyF0cCyBjbEHvXVctwC+QFYbYBV2ySnRkGa2aKISIwVOHJy0/Q
         kbO2bQlJE2UXYTt8S7jcEFbYg7ceZw+BMxMivrnlzDm1UYpF/EsgIYWx+G3LGozWnpDN
         lUGcnolQfGSrJeW8QCd/q4PewwI9xYRKRxLC0yvYdwILxdXgySTgtCDe0StcKl5zOEbk
         N3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753288338; x=1753893138;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m0s3rllgkjDarEULakl9MiGjhDbZfYra7BMAYPRbah0=;
        b=HsasimiwdrE5tgxxiuAp7WgfuPo+lSaAD7MoNjMlAJTPCTzpHl2QkVolaJDuKWoD/3
         un0W/Bno4o/z/qA+Yc+Z7PW/42l9BpzYN0VAvpkhSsX190OjQq0tgYhWMPRE/l9iN1Bz
         +QaY9MMKHMpByVCq93Jo5rViM2wH5JHxdCHxf/jS6sfkvSIdCWgBoKrOPi99BruKaOs+
         NPOpG1grXsw1lyoesvjCv8ISnV253mhjIbpXvzxt32gy22VKMQype+H/KbFCobGXQmP0
         +H56xvlNhQjkKJ/FWJB+3Osx16GjHF1erFrY23zcZAP55PYk8nztk3Qmv0TA/XbvbZfD
         f6Eg==
X-Gm-Message-State: AOJu0YyVwTDcbpnr31gbtgtluJ8+eVrGdx/W9o0CXwcP8iHCwmWgUODV
	JXkTnKnyiCUUfhgysstfYcXQNYrS9j5lNm5vfqwJFf8mUs/qkeFqHxRLQJ02VdZ6/FYY6wiz02y
	zy9FBkK4pqVrrXuOaGrxKY8YaMhKqnPNg++VBoEhh2bw/yHTlyu++2LZcpreYq94luUGYdK058R
	XI34LGVC2Wt+a4uQczhV/IhHfPA+gRoHuX5NaZLAw7L6RngxCFGXIA
X-Google-Smtp-Source: AGHT+IHwY6YBBdEwIXjjWgPIM2PLpe7V+sb249s+XQm4zhk54iDc5F5u0VJq6Qud5IHsdOqXIbycQl23FE1dnuU=
X-Received: from pjbst13.prod.google.com ([2002:a17:90b:1fcd:b0:31e:40d4:1d0e])
 (user=jtoantran job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:33c9:b0:313:d342:448c with SMTP id 98e67ed59e1d1-31e513cfdd3mr4557036a91.17.1753288337311;
 Wed, 23 Jul 2025 09:32:17 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:32:05 +0000
In-Reply-To: <20250723163209.1929303-1-jtoantran@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723163209.1929303-1-jtoantran@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723163209.1929303-3-jtoantran@google.com>
Subject: [PATCH v1 2/6] runtime constants: add default dummy infrastructure
From: Jimmy Tran <jtoantran@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Laight <david.laight@aculab.com>, x86@kernel.org, 
	Andrei Vagin <avagin@gmail.com>, Jimmy Tran <jtoantran@google.com>
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
2.50.0.727.gbf7dc18ff4-goog


