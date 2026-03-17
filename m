Return-Path: <stable+bounces-226917-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCrPD9jPuWmMOAIAu9opvQ
	(envelope-from <stable+bounces-226917-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 23:04:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B17C2B2E66
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 23:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0037B302E93F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 22:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBE33176E4;
	Tue, 17 Mar 2026 22:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gdrR6vxf"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0712116F4
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 22:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773785007; cv=none; b=gZGstrtEIfpaqCPpgmk77tCje9TEUo3SpHb/VkS8XoFJrdrfdveQTvUwspRM8XaBf1l7tfcNdodfHiwAmBZxrU2/ZZhGymLmb44riPnh6Q9mkPggi72YNedBWz8+WNX6D6cvyGPY5ANwWBshqyXIZVXZOQ6w/EW3y0vOgMLrISM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773785007; c=relaxed/simple;
	bh=oU3OVhNKPZI6FrfLf4b3tz8GEz5wRhmrq2qNQQUyCnY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tqpJV5gGXk1cK09F56mPhFcJFNBMMpmPaHFGxsAA9Bf+MJ2Hg3lILBjmn533GH2212sUcKFMeS41tWj1Q/SxHHimUcvEW4wESTFB02AdZxKKzCyTuoS7+AAcFpYPyFBi3Mrgk5SnyQNH0BODHjYy/lDKFLxgx/1Cxp+9Iydm9iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gdrR6vxf; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4868e691614so7461345e9.1
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 15:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773785004; x=1774389804; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a5ROHSj5Kev7hvsbjDyb4mWRpxoAV8o5zFiVg3Mbgk4=;
        b=gdrR6vxfLZs4p3VvRvGjUtPXUtp/vwYI8n613Zm0GD/pNpF/fdVOHepVTYl1eob9cv
         HqNcsPBiNM8fMvtjBAukkYICIz3asFzoO3Ha7JEudG56wmD1F6VpZfAu/nciwt+M0geC
         FpQg1FapsGDEXRAw31rf1kifY+p/k0J7nQwZZiYDHyNcTOnMmfq9VfmAZTunCq6Vwpyo
         HMwRxn1qqdQwGr4Og+Yo9yK59gEtqz1oUeW3w3lOPQfi6Vo/6f48XkooDBx/n3OpdFpB
         SaY+W6eKeupMVd3N9qIP8Hji1ba3fF6TGBeMYFli6eKHBoysLoTL5dsIE31zMkgBec3Q
         0QbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773785004; x=1774389804;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a5ROHSj5Kev7hvsbjDyb4mWRpxoAV8o5zFiVg3Mbgk4=;
        b=d1sXfOdyhyqkUukYqxXIutTHT8WR7q7f4LerGlYfKyr4Vcf38sDjixaKQG8S7Dh8yk
         ycWQ/FfWK98KwQThUpwv+z6hr0qM4j6OQ/mAoxyp8JXYh2p8MTTEwkSuiW+X+jt71oGk
         eS+ApoRqBR+WiDKA6f+MrXI6EvsBPS/iw54dB6QO5fEdSPUdSnwtgYm4rvLKaNFfiukJ
         TSRPD21XR3kyS5LITiXQfS3fol3TbMTUZwLq0H8iO/SgaXcPNdMqHUHhgobpqGXbiKMQ
         PFzyC8DJuG4nFgivtM+WifdIgE8b1p67n1s6SkyshfncXU12hRT4JP9+HXUYFvrckV0U
         IOKg==
X-Forwarded-Encrypted: i=1; AJvYcCUJVq6LcuJA/RuEWeVlcUnVRUpheVBoCK+aoErgX9IvGsy/wty+2KVqafhu8qjpIRHYpmhhVQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvV1Ylde9DG9M9GFTFd0gUcIsbx4Cxtpq0HMAhkZEjug0+ZFqq
	3KthQ+X/1XLM29gOY6wxiYBI1eX6R0QeahLZ418+POc1qCL0H41JEGGnXGn80kYL5boOKB4nNcq
	3EMkSPA==
X-Received: from wmpo21.prod.google.com ([2002:a05:600c:3395:b0:483:b1c6:5b34])
 (user=nogikh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3514:b0:485:3a03:ced1
 with SMTP id 5b1f17b1804b1-486f458107fmr19079455e9.28.1773785004419; Tue, 17
 Mar 2026 15:03:24 -0700 (PDT)
Date: Tue, 17 Mar 2026 23:03:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260317220319.788561-1-nogikh@google.com>
Subject: [PATCH v2] x86/kexec: Disable KCOV instrumentation after load_segments()
From: Aleksandr Nogikh <nogikh@google.com>
To: bp@alien8.de, tglx@kernel.org, mingo@redhat.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, dvyukov@google.com, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Aleksandr Nogikh <nogikh@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226917-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nogikh@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8B17C2B2E66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The load_segments() function changes segment registers, invalidating
GS base (which KCOV relies on for per-cpu data). When CONFIG_KCOV is
enabled, any subsequent instrumented C code call (e.g.
native_gdt_invalidate()) begins crashing the kernel in an endless
loop.

To reproduce the problem, it's sufficient to do kexec on a
KCOV-instrumented kernel:
$ kexec -l /boot/otherKernel
$ kexec -e

The real-world context for this problem is enabling crash dump
collection in syzkaller. For this, the tool loads a panic kernel
before fuzzing and then calls makedumpfile after the panic. This
workflow requires both CONFIG_KEXEC and CONFIG_KCOV to be enabled
simultaneously.

Adding safeguards directly to the KCOV fast-path
(__sanitizer_cov_trace_pc()) is also undesirable as it would
introduce an extra performance overhead.

Disabling instrumentation for the individual functions would be too
fragile, so let's fix the bug by disabling KCOV instrumentation for
the entire machine_kexec_64.c and physaddr.c. If coverage-guided
fuzzing ever needs these components in the future, we should consider
other approaches.

The problem is not relevant for 32 bit kernels as CONFIG_KCOV is not
supported there.

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
Cc: stable@vger.kernel.org
---
v2:
Updated the comments to explain the underlying context.

v1:
https://lore.kernel.org/all/20260216173716.2279847-1-nogikh@google.com/
---
 arch/x86/kernel/Makefile | 10 ++++++++++
 arch/x86/mm/Makefile     | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index e9aeeeafad173..41b1333907ded 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -43,6 +43,16 @@ KCOV_INSTRUMENT_dumpstack_$(BITS).o			:= n
 KCOV_INSTRUMENT_unwind_orc.o				:= n
 KCOV_INSTRUMENT_unwind_frame.o				:= n
 KCOV_INSTRUMENT_unwind_guess.o				:= n
+# Disable KCOV to prevent crashes during kexec: load_segments() invalidates
+# the GS base, which KCOV relies on for per-CPU data.
+# As KCOV && KEXEC compatibility should be preserved (e.g. syzkaller is
+# using it to collect crash dumps during kernel fuzzing), we could either
+# selectively disable KCOV instrumentation, which can be fragile, or add
+# more checks to KCOV, which would slow it down.
+# As a compromise solution, let's disable KCOV instrumentation for the
+# whole file. If its coverage is ever needed, we should consider other
+# approaches.
+KCOV_INSTRUMENT_machine_kexec_64.o			:= n
 
 CFLAGS_head32.o := -fno-stack-protector
 CFLAGS_head64.o := -fno-stack-protector
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 5b9908f13dcfd..ea3a31b54e49e 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -4,6 +4,16 @@ KCOV_INSTRUMENT_tlb.o			:= n
 KCOV_INSTRUMENT_mem_encrypt.o		:= n
 KCOV_INSTRUMENT_mem_encrypt_amd.o	:= n
 KCOV_INSTRUMENT_pgprot.o		:= n
+# Disable KCOV to prevent crashes during kexec: load_segments() invalidates
+# the GS base, which KCOV relies on for per-CPU data.
+# As KCOV && KEXEC compatibility should be preserved (e.g. syzkaller is
+# using it to collect crash dumps during kernel fuzzing), we could either
+# selectively disable KCOV instrumentation, which can be fragile, or add
+# more checks to KCOV, which would slow it down.
+# As a compromise solution, let's disable KCOV instrumentation for the
+# whole file. If its coverage is ever needed, we should consider other
+# approaches.
+KCOV_INSTRUMENT_physaddr.o		:= n
 
 KASAN_SANITIZE_mem_encrypt.o		:= n
 KASAN_SANITIZE_mem_encrypt_amd.o	:= n

base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
-- 
2.53.0.959.g497ff81fa9-goog


