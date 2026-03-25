Return-Path: <stable+bounces-230360-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPQDIMMLxGk+vgQAu9opvQ
	(envelope-from <stable+bounces-230360-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 17:22:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C137328E4B
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 17:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B2C73153BA7
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 15:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A92C3E1CE5;
	Wed, 25 Mar 2026 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E8q7IxG4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE3D3E4C8B
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774453713; cv=none; b=aK9uXyZg0TxgkEurAB7FGifmn+Iq/k+DVJ7xLSEBd1ZXXd3bRXrJfsIFaA/1dTjaUsxQpQdqdHMlMr7IoCGFWv3pFkBJta3iCxejQhlu3YsorKJpxLlOOq1ytA203Kv/gl/CtxY4LEJl83XH20vVfruQfr307f3ptnEiflvGipo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774453713; c=relaxed/simple;
	bh=XQPzRGvc+NN8ZiYj/B//JMqvCRQ2hs4U1klIP2GW90c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kDERAVjjIKXkRJ4dJG+3HNk2xytzM7CgPfUbzpbAsG9MVLlVcsRma+Axjj+KpcEui88nVLCaSPl+QWuL+AwUmMnWjpG7kYRaJCafDZ5G0fjkl4smHq+Rsc6YH6uWub6IOEE/CH9MChis90u7oxhxS4bWVmW9mIlOMdVGrCSxAHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E8q7IxG4; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b8fbe7a6f41so220420266b.0
        for <stable@vger.kernel.org>; Wed, 25 Mar 2026 08:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774453710; x=1775058510; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M/sO4V9/AfamlzvH6Yz1izySgX6li4ODe+c+dOZMt3Y=;
        b=E8q7IxG44o6idd1IUfTyigFJrul91UlH7uDzIevG1Cj3aWXslyFSm0R4B8h1rTM3u4
         74sqeq55Kxem4FRebzfCwdziWD7rLbBeGnhiixUYUHYMOTs6I4XH6Hh6n0pmSmEek89l
         Lv9WJlEBg0zu3YqOV2Bm0w/EyI2ZsFZ/oECnHQdEe1aj/LSF38bI0qEd3B4XeszRGFzd
         senuvKq/oeAlxPjRDrWxNVHloi5NwTPkbLJsysp9MYaYoSZxgKgk6zYsureFm7Bs8rKx
         jweHqG0oqIGYqL3P+Hc/uZY2AtCYWBBM7kyaC2Od6wwdfoWnp72zXw+ZQu/J8uQW2+WN
         7bzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774453710; x=1775058510;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M/sO4V9/AfamlzvH6Yz1izySgX6li4ODe+c+dOZMt3Y=;
        b=FonREKQvnzLq/7lTU/7y/Ghuy53vZ/QpypVExPQq27njMoIZllarfyvjUfBBF8wfyT
         3rwhFxZoRxjHE6RLrgvbR+JyXlp8uA/JdIlKv9Hvd2shdbFGf0mWwFUtWVW+EP1CqQgz
         y+UH6t+pVNm2rdMXUsC/tcPW8lDXo4w8yjN+qKDKuu+kQ5bzu8RCD3P5XtolyAXWPJkv
         31P+d9Jn1FBA069QXf0RpOeTOk9q0CzHzFpT2YB+v+aEpZ++Am7UI1ygZVY3Wdk/6Ewc
         A1GMgIBiUCwkoWgibp0SKUtpf9ZRwtHkJMSSHRqT9Nfi4V/0TFGCH9jhJ8x79hZQdp6d
         wtGw==
X-Forwarded-Encrypted: i=1; AJvYcCX0HfbQUxZ5fwLsa1YV4zMajmiypwX5hFqC5W+eyZIOo5X9XpECP0sxrwl/FGSLdvksiYE9e0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHcZSVESTT6gRwBQrQmbX21glQUJW7zOtg3WOPoVN7Wasp8bOV
	6Rhw82zCuQBf8I1iiHZpAvhsHNNuXhoCayp6H6fNrIl/Ig+rAKnpOTyvzRPXAcQy/09NWJUq6DJ
	qUjqqpA==
X-Received: from ejwi18.prod.google.com ([2002:a17:906:4fd2:b0:b98:b1fa:13b4])
 (user=nogikh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:c20:b0:b8e:d1f3:4744
 with SMTP id a640c23a62f3a-b9a546a0ba0mr275814266b.55.1774453709696; Wed, 25
 Mar 2026 08:48:29 -0700 (PDT)
Date: Wed, 25 Mar 2026 16:48:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260325154825.551191-1-nogikh@google.com>
Subject: [PATCH v3] x86/kexec: Disable KCOV instrumentation after load_segments()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230360-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nogikh@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2C137328E4B
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
fragile, so disable KCOV instrumentation for the entire
machine_kexec_64.c and physaddr.c. If coverage-guided fuzzing ever
needs these components in the future, other approaches should be
considered.

The problem is not relevant for 32 bit kernels as CONFIG_KCOV is not
supported there.

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
Fixes: 0d345996e4cb ("x86/kernel: increase kcov coverage under arch/x86/kernel folder")
Cc: stable@vger.kernel.org
---
v3:
Changed the wording of the commit description and the comments.
Added a Fixes tag.

v2:
https://lore.kernel.org/all/20260317220319.788561-1-nogikh@google.com/

Updated the comments to explain the underlying context.

v1:
https://lore.kernel.org/all/20260216173716.2279847-1-nogikh@google.com/
---
 arch/x86/kernel/Makefile | 11 +++++++++++
 arch/x86/mm/Makefile     |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index e9aeeeafad173..febf6f49207b3 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -43,6 +43,17 @@ KCOV_INSTRUMENT_dumpstack_$(BITS).o			:= n
 KCOV_INSTRUMENT_unwind_orc.o				:= n
 KCOV_INSTRUMENT_unwind_frame.o				:= n
 KCOV_INSTRUMENT_unwind_guess.o				:= n
+# Disable KCOV to prevent crashes during kexec: load_segments() invalidates
+# the GS base, which KCOV relies on for per-CPU data.
+# As KCOV && KEXEC compatibility should be preserved (e.g. syzkaller is
+# using it to collect crash dumps during kernel fuzzing), disabling
+# KCOV for KEXEC kernels is not an option. Selectively disabling KCOV
+# instrumentation for individual affected functions can be fragile, while
+# adding more checks to KCOV would slow it down.
+# As a compromise solution, disable KCOV instrumentation for the whole
+# source code file. If its coverage is ever needed, other approaches
+# should be considered.
+KCOV_INSTRUMENT_machine_kexec_64.o			:= n
 
 CFLAGS_head32.o := -fno-stack-protector
 CFLAGS_head64.o := -fno-stack-protector
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 5b9908f13dcfd..3a5364853eab8 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -4,6 +4,8 @@ KCOV_INSTRUMENT_tlb.o			:= n
 KCOV_INSTRUMENT_mem_encrypt.o		:= n
 KCOV_INSTRUMENT_mem_encrypt_amd.o	:= n
 KCOV_INSTRUMENT_pgprot.o		:= n
+# See the "Disable KCOV" comment in arch/x86/kernel/Makefile.
+KCOV_INSTRUMENT_physaddr.o		:= n
 
 KASAN_SANITIZE_mem_encrypt.o		:= n
 KASAN_SANITIZE_mem_encrypt_amd.o	:= n

base-commit: c369299895a591d96745d6492d4888259b004a9e
-- 
2.53.0.1018.g2bb0e51243-goog


