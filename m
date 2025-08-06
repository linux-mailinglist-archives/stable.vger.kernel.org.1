Return-Path: <stable+bounces-166721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB65CB1C9A9
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 18:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86191628132
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 16:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C801522541B;
	Wed,  6 Aug 2025 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tpJz2FY7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283152566F5
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497213; cv=none; b=sihFt7gJ48gcKe++wlh8NU3plOInUxsjxKscsYc8+yUbkR2hwn1dj5HGii5CeEXGEOTlbDthsgsjnPJCpEcNPWLsWWvtFpiQIX7I84iDpm8h7tGd6LTqdYfMLwt1mXZ5g/y/FzwV/fEIC76UAGiL5Aq2NJ/0FlruRHSl+Dr25tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497213; c=relaxed/simple;
	bh=SOOV5VouMdu4NrR+4g6lTRFS8oPUL6aNSfHMus3RBVk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kB330UIIsVOV7yot/0IGEIg6ddJvSCGmFLBD2Xv23cH3UYfKFNBEsnUo2bw2TDVUJskAZsJRdeAXWUd0mRd3I9qmJMOxvLEEwquXkzeWaLbwqDruCKc60C80IR6gQ57qDAdOVzvdyTj1ZZ50QRIi4fl9rJjjjIeLHL+r3ObD7MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tpJz2FY7; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2403c86ff97so157425ad.1
        for <stable@vger.kernel.org>; Wed, 06 Aug 2025 09:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754497211; x=1755102011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vscHXQVG0eTLZ+LHlIb0JUUnQG0Fd4hw8rPrFp+lP28=;
        b=tpJz2FY7ke1NZzXinE7nhBRGJp074ITQQ0yQTkQaRJPd9u8Oz7wwK+9nBaZRE/8DCs
         FzL6CHsHpA8Ts/G0FnMuYVJuzzaPEMenbbX3ExIJBK1cMlhQv7CjJ7lgEShwByXBvp87
         teaxTrWtJJGf6upJu9VW4Dvxe5RJG7uiybnX2nswQUVoUESosfAVj6DIcJJJsfKjNujR
         vJys2cV1t8vZFzN1jU2WYJp6SC0/4v85wjFiwI7J1Spiuzz9FEWYHw2A6XFLq0VkUjqR
         eSEreqltgFsMfWRm+8XhSdygWZzHAudGYEtKs/J4f91+K9ZPGIhky4WlEl2MP8rEC2S5
         I0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754497211; x=1755102011;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vscHXQVG0eTLZ+LHlIb0JUUnQG0Fd4hw8rPrFp+lP28=;
        b=nsKtpy6aw6sRSOOPPMSqR3OQYGeWaACVVU9mU9AC16YYBSWOZzXZ0KWsmRW+/zfDy3
         fu9uLYb3k8TOwunWLYLQ2xZhse42ru8FyxAHYYHe6CLc3DyqxvBnD6wdqsJG2/8MHdfq
         tREm+Cejiqq+Pe8q2aJn4j5FHBSi8siOtN8TvF9T2gJnmlsAcUYYaNsX+36D2VCTQK88
         ukQROJfHS28XzmFUKW4spWVmtEi8L8Ad0P7MDdK+EuWPUW1+XXqSnsJpLLZQ9HH9re32
         Uq7ABXAzW9Z/MvCOFQrO85PV8khKMRVJopEWfNRE/+9h/mwzWVi9JYugQhKeP1b5kdZ6
         QwXQ==
X-Gm-Message-State: AOJu0Ywmg72kokvH+d+vdtPa4I4Y7WxGuxxT7FIo5kBJBbVl8MrE+S1f
	SigFNGCUDGkB3OXpLx1H0sx9kdjI0fHjBIyqnSPOsd0cOBZ+P9LZL3Zr2gKkE14zO9pVt1Eg/e1
	UUPBbhTxdhrhxI858TzaQ5jfmMWqwZv8xSTc58LWf0Afz+kRcjys6oWM2yhUWGjhv4hrmVC8vEB
	toyHKxLxRtT8tWV6BmNxR4HKCg8MRMTudp9IYb4ZNxf9Tt633LzN63
X-Google-Smtp-Source: AGHT+IGNF92VO9hDBhmKobOxAluTRFCf6DnF72l7Ggg1KUmzA/dvgvrqgXWgVzNZ0lABiE3rjv/hzv4JVVeH5i8=
X-Received: from pjqh12.prod.google.com ([2002:a17:90a:a88c:b0:311:d79d:e432])
 (user=jtoantran job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f612:b0:240:469d:beb0 with SMTP id d9443c01a7336-242a0b6fc4cmr50519145ad.31.1754497211365;
 Wed, 06 Aug 2025 09:20:11 -0700 (PDT)
Date: Wed,  6 Aug 2025 16:19:58 +0000
In-Reply-To: <20250806162003.1134886-1-jtoantran@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806162003.1134886-1-jtoantran@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806162003.1134886-3-jtoantran@google.com>
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


