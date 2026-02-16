Return-Path: <stable+bounces-216746-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKIcNd5Vk2mi3gEAu9opvQ
	(envelope-from <stable+bounces-216746-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 18:37:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B8D146C13
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 18:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9601301B722
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 17:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171492D7DEA;
	Mon, 16 Feb 2026 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F+4qYhP2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893942C326C
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771263451; cv=none; b=bpPYoUIRiSyOKGx9QvovhLZk6Lw71ZogwvF1A+i+U0Br/VlT8hYkYlKEdNz9kh6hJNYxkbysIjDEBxK8plYsHptIztDO0pxs65I5Y1ey/SrA3p32g61ozPdGTopX2YDQT+HI5f4MRaF4mmgeavsvGJSDuUVYQzvd1X2Yv7op8U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771263451; c=relaxed/simple;
	bh=rQKhB9JdZiNJrrGwmga29AvVsWuvPM0AXufNQXL4yqQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NWZBV5LMrY42E5/e4WYJ83F52tYgIJoijotZFORXCp5dATAt2wmVzy7Xv0e+qU4jdtVw5USU1bwOhT1dKQtxR6+oCYgXilDYeBIKDRz8jCLKg4OE8mIe/3n3EAHfFzNNw+r2a0ghuwzWfsKeRwRoyVnjH6RVQeSwVSgK/1dGrbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F+4qYhP2; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4832c4621c2so39713235e9.3
        for <stable@vger.kernel.org>; Mon, 16 Feb 2026 09:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771263449; x=1771868249; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+CGgBuWMwayfOcIDbZ2XGNgXYWYl77pKODg5gAEKr8g=;
        b=F+4qYhP2rTemcIf2j6YfrXXrPc89AW2nR97jAWSv3FdZgqxDVSWfLRkPjX3ZLu58bG
         F9ajPVaRxxWu/VAo0C5EFcAAftAPfbTrzEWjcYIuSMVNMl7Aa8UFWT5W3RUSSTF/4orX
         jg/XvN2mG1Jfr8DIz+RcqqQSmsSaEYf98SQSG7AFZS8u/mPY+nEK9Xb0NCgoT+3setfj
         Si5rsMOm+n9ApqWzXMSja9RK2L/ItMrPB8SyJJUhUHbMnqnAWRqqs+5ctBVZC6o/0Vyi
         +zBtBXBJh0YqelDEZKQ9E/qQolBvnyGVJ+OOE5aEF0hyCSdlU9xMzgabDyJnHZnFYgGF
         cOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771263449; x=1771868249;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+CGgBuWMwayfOcIDbZ2XGNgXYWYl77pKODg5gAEKr8g=;
        b=TSkWL57p8KWeTkHnrJKmCRGDa0FEhZ7C5QH45iKASmJBLeUOwv+vtT44hva38UFDzp
         CbNH75a1TtHoicH4hpSLE3+pYfd6UYvzj6e4co+leMalZGJUdbgkE4kixgBoq9QglxOt
         v0Vri19rzP+UeCcnj45A7t810KdBOZFxedNR/1NeZ7uUhPYgoKvswU/eIhZh59f5v8L/
         L6lMVixm6uCvRSqmmZPI8TsMXhG7xBl3lIGPdmy7XlTdDE1Qyy1fR5Wl6qV6UV3XA9Em
         lPaRm12gu8yBNYR7co5RkZniKXSbr9JcLXcKsHbNXp75g2PkIvwTDyVKS/09ENdvpE2/
         7oPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwxT2v6lPbKYvyTixGEJ1IdfEoIgd8mkHLGghCspG0Y6J+vnCeNt9/FMzWt8fxaXAZ6BlXfqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE1tb0Czqj8tlf752mmtB2EnBe8ww6OdIPtXWGWJ52mEF52Hhz
	H64J0LQ/7/j675kL55JZA19vn1NDip6gycCjEQGRIYHmQUvV2mStiRAeHRGc9AdVFDxdNewsd6Y
	dXAj84A==
X-Received: from wmog12.prod.google.com ([2002:a05:600c:310c:b0:47e:e20e:e9a5])
 (user=nogikh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c04b:20b0:483:7eea:b185
 with SMTP id 5b1f17b1804b1-4837eeab9e2mr101249885e9.16.1771263448876; Mon, 16
 Feb 2026 09:37:28 -0800 (PST)
Date: Mon, 16 Feb 2026 18:37:16 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.273.g2a3d683680-goog
Message-ID: <20260216173716.2279847-1-nogikh@google.com>
Subject: [PATCH] x86/kexec: Disable KCOV instrumentation after load_segments()
From: Aleksandr Nogikh <nogikh@google.com>
To: tglx@kernel.org, mingo@redhat.com, bp@alien8.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, dvyukov@google.com, 
	kasan-dev@googlegroups.com, Aleksandr Nogikh <nogikh@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216746-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nogikh@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37B8D146C13
X-Rspamd-Action: no action

The load_segments() function changes segment registers, invalidating
GS base (which KCOV relies on for per-cpu data). When CONFIG_KCOV is
enabled, any subsequent instrumented C code call (e.g.
native_gdt_invalidate()) begins crashing the kernel in an
endless loop.

To reproduce the problem, it's sufficient to do kexec on a
KCOV-instrumented kernel:
$ kexec -l /boot/otherKernel
$ kexec -e

(additional problems arise when the kernel is booting into a crash
kernel)

Disabling instrumentation for the individual functions would be too
fragile, so let's fix the bug by disabling KCOV instrumentation for
the whole machine_kexec_64.c and physaddr.c.

The problem is not relevant for 32 bit kernels as CONFIG_KCOV is not
supported there.

Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/Makefile | 4 ++++
 arch/x86/mm/Makefile     | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index e9aeeeafad173..5703fa6027866 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -43,6 +43,10 @@ KCOV_INSTRUMENT_dumpstack_$(BITS).o			:= n
 KCOV_INSTRUMENT_unwind_orc.o				:= n
 KCOV_INSTRUMENT_unwind_frame.o				:= n
 KCOV_INSTRUMENT_unwind_guess.o				:= n
+# When a kexec kernel is loaded, calling load_segments() breaks all
+# subsequent KCOV instrumentation until new kernel takes control.
+# Keep KCOV instrumentation disabled to prevent kernel crashes.
+KCOV_INSTRUMENT_machine_kexec_64.o			:= n
 
 CFLAGS_head32.o := -fno-stack-protector
 CFLAGS_head64.o := -fno-stack-protector
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 5b9908f13dcfd..a678a38a40266 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -4,6 +4,10 @@ KCOV_INSTRUMENT_tlb.o			:= n
 KCOV_INSTRUMENT_mem_encrypt.o		:= n
 KCOV_INSTRUMENT_mem_encrypt_amd.o	:= n
 KCOV_INSTRUMENT_pgprot.o		:= n
+# When a kexec kernel is loaded, calling load_segments() breaks all
+# subsequent KCOV instrumentation until new kernel takes control.
+# Keep KCOV instrumentation disabled to prevent kernel crashes.
+KCOV_INSTRUMENT_physaddr.o		:= n
 
 KASAN_SANITIZE_mem_encrypt.o		:= n
 KASAN_SANITIZE_mem_encrypt_amd.o	:= n
-- 
2.53.0.273.g2a3d683680-goog


