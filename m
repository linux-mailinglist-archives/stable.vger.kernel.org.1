Return-Path: <stable+bounces-244556-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPxyJj90/GkEQQAAu9opvQ
	(envelope-from <stable+bounces-244556-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 13:15:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DCA4E74DA
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 13:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0DD3302CD3A
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 11:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D6C372EF6;
	Thu,  7 May 2026 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iTvxxaJu"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E93236EA9F
	for <stable@vger.kernel.org>; Thu,  7 May 2026 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778152488; cv=none; b=GhD2MUion+B7tsXiYOmcGz5ms+ln5KXaB3gFgbZtS4xOxkhN1QxpPRT0z0cXHiM8OUoYldRaKWURaGZ7KpfrAbFdEvUNNqu4MZPb+8A3l4WtZgT6vQGC15hTb0H29fGadOk5DZ2tyGspdbHDvUYKQs+mseOI7Uadldot8dgDYCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778152488; c=relaxed/simple;
	bh=HWhoVc+4Rva/8+60k6n5ob9z0H9Bu7MQOUUG91pVXaA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jCwZ+83MoHv92A+JsmGsshd2KRB6IEf450c0QszAsBdlCnhHgj+0ka9yIXYn1nzzIDCX33ewI5DFRTecN0u21rTAisexnSUbTDLULOAwTa9bk451FtwJGwnP0ml+JrHdfIZC0ZWF/m8kXnVbG7imoaDlCof6ymhG4FPvomrI2n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iTvxxaJu; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-488dcaf2f2fso5421455e9.0
        for <stable@vger.kernel.org>; Thu, 07 May 2026 04:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778152486; x=1778757286; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W6me3rXlMz6Jb1wdHt367NiNHpWa4AAw7E9Agv71638=;
        b=iTvxxaJucFj9dAiQSwA4RCvw3aMm9gtC7alVzerUvoOh9xjFqZwOC6By3y12u5ErtJ
         XvMMCggGyCVpZGLF6y0VN0p7LkD3sTHifdtwmYamgW3EXBuw2qlIq3jWMZhYTCn2Huae
         37YN/GmYge9HKa2P4QCseJ8adKSY0E2Um5Pguz4j02lUyBGbc052lXNb6i8Y8SgftNAK
         18qoZ0X83CAh3R0bi4MyeIvezbYW4bSB18N5A5VKHXoUylZT1KvmHiHUozWvtP/i+b7y
         4SPmx2s8PHFn+/Ica4O5vGs/JFlwAi1y4n802nAxJ5rEK34kx4cQ5X97LOLWN+bi9v+B
         BDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778152486; x=1778757286;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W6me3rXlMz6Jb1wdHt367NiNHpWa4AAw7E9Agv71638=;
        b=nrta6wj6c9pa1uYjkjEs0gpSE+YHbJAr2mJ/5uMWRt28hAyoOZgIQalXF3d31iLbvt
         xCKI5Najtl3xJLvRdCx70UiMYKttTMOMbSZdqtN3Zt3Hslp+D3o8+kDAobV7CfzHiNne
         E1jPahhPBuDYq1WiZyaJreRFohzl3o2+D9/ugxNQy6erPTImfr/tPCoAK5Izx9dRu22H
         tNb1ulw1qll3vBabFdr7ocWTe5KH3kmVzjazNwitpnKN757CYlEzDBNnbJimuGZMwmd6
         slOwlZ23ZRWW6BPkd/5mpUX9JRapUDW8U1M00bgin99b9JYGBGsR9a626Al8+GSijea0
         Jctg==
X-Forwarded-Encrypted: i=1; AFNElJ8g6nTiS+tPVhhggVo2QuiUGnyTk7tNtS0l5K7X/Hpw0DlnaHu8OwqTXE+ltW2oux7rKcTZ3Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF0/V1TuFuM7EsGUs0DXUe0/cx6TNu2lLUnQM7Rs3cfJUU6nzK
	S2ZjjYMMbTqIffPJPbpp8x0dXNKBSlOzuh2NOMbop5O+z4/BVLawDRpxe64NrpkaiZ3aF/KC4PN
	3DfO1z4xfxM6l2BzqRg==
X-Received: from wmgb4.prod.google.com ([2002:a05:600c:1504:b0:48a:52f3:38b5])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c494:b0:48a:592c:e632 with SMTP id 5b1f17b1804b1-48e51f42760mr117980115e9.16.1778152485104;
 Thu, 07 May 2026 04:14:45 -0700 (PDT)
Date: Thu, 07 May 2026 11:14:42 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACF0/GkC/32NQQ6CMBBFr0Jm7ZgyQkFX3sOwkNKWJsqQDhIN6
 d2tHMDl+/n//Q3ExmAFLsUG0a5BAk8Z6FCAGe+TtxiGzECKtKpVhfEli0Gel1xEE1kEm76mypl
 TXQ0t5OEcrQvvXXrrMo9BFo6f/WMtf+lf3VpiiersqCHd61a5q2f2D3s0/IQupfQFjiDaaLUAA AA=
X-Change-Id: 20260504-rustc-option-cross-7b524fc354d8
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4614; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=HWhoVc+4Rva/8+60k6n5ob9z0H9Bu7MQOUUG91pVXaA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp/HQjD90XvhnpHPP8iRWZenChc0O8E8JQc0lu7
 AZykn+DnyeJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCafx0IwAKCRAEWL7uWMY5
 Ro1xEAC0Oj3V7JH9xkEW0CG+svLhrUx5BeYw3D6jd0UYzMumaGDqi2IbN2gKhqi8xhduCaP6idK
 x1B0c2V/lqYIGFdJq4sDvWyDscmQPH9RZgxam7ucbuJb8P4+0khCrG5eM9vmgXyE+BkrwB4h8jR
 8hjR5y952y909Z1xdbh3RA77PzvDEdUmXTU/PaqywviWb1Dh1OaOSkg414Fruu3YBd8C50ebyli
 Jl+HNGmtQcYrYYCofwsutDhcxPDDRDyYt6Gsd5x+HL99Dvto2Vw3E7uXtKMd3OIlN0IWWQYPFjj
 WT/e8KFDSq0WaZjSwN24iJpFVFq1bXVd7ynR+Nqb137QsGjZrnvLmFQ6jR0ykiLHPT9jkGYlzhC
 3BqMaVsD/RzvxrgqEM2tsXeMh1Lzf3/0TIW+wsfYka1iyMI8LMdIBB0ojKOGa1SbZVgMR2jUlCi
 Romz30AVa4hUkflZnBhtgk78/8xO5lSFgdhUJFZuKF2c9DguGl3bOZbXqYQkqDL9IjbGX7Ihp8E
 +EKHzmOMChEZlCH1nOd7wDF3xjCmFrq2H8G/NxJPXst2LNW8arDxNmfidOKLA2WqEsu6lKe3ZTZ
 nhGh/T6Jj7/LbG0/FCDcRiUaaHa7C9rAgpsP53cmWYeW2eTR/QdovpJhDZy14YcDGeAKeu+vEUO ucEsUM2XziXeh1Q==
X-Mailer: b4 0.14.3
Message-ID: <20260507-rustc-option-cross-v2-1-2f650a49c2b5@google.com>
Subject: [PATCH v2] rust: kasan/kbuild: fix rustc-option when cross-compiling
From: Alice Ryhl <aliceryhl@google.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	stable@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 10DCA4E74DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244556-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,gmail.com,google.com,arm.com,googlegroups.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The Makefile version of rustc-option currently checks whether the option
exists for the host target instead of the target actually being compiled
for. It was done this way in commit 46e24a545cdb ("rust: kasan/kbuild:
fix missing flags on first build") to avoid a circular dependency on
target.json. However, because of this, rustc-option currently does not
function when cross-compiling from x86_64 to aarch64 if
CONFIG_SHADOW_CALL_STACK is enabled. This is because KBUILD_RUSTFLAGS
contains -Zfixed-x18 under this configuration. Since that flag does not
exist on the host target, rustc-option runs into a compilation failure
every time, leading to all flags being rejected as unsupported.

To fix this, update rustc-option to pass a --target parameter so that
the host target is not used. For targets using target.json, use a
built-in target that is as close as possible to the target created with
target.json to avoid the circular dependency on target.json.

One scenario where this causes a boot failure:
* Cross-compiled from x86_64 to aarch64.
* With CONFIG_SHADOW_CALL_STACK=y
* With CONFIG_KASAN_SW_TAGS=y
* With CONFIG_KASAN_INLINE=n
Then the resulting kernel image will fail to boot when it first calls
into Rust code with a crash along the lines of "Unable to handle kernel
paging request at virtual address 0ffffffc08541796". This is because the
call threshold is not specified, so rustc will inline kasan operations,
but the kasan shadow offset is not specified, which leads to the inlined
kasan instructions being incorrect.

Note that the -Zsanitizer=kernel-hwaddress parameter itself does not
lead to a rustc-option failure despite being aarch64-specific because
RUSTFLAGS_KASAN has not yet been added to KBUILD_RUSTFLAGS when
rustc-option is evaluated by the kasan Makefile.

Cc: stable@vger.kernel.org
Fixes: 46e24a545cdb ("rust: kasan/kbuild: fix missing flags on first build")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Fix inaccurate statement in commit message.
- Link to v1: https://lore.kernel.org/r/20260504-rustc-option-cross-v1-1-09f2726b680f@google.com
---
 arch/x86/Makefile         | 4 ++++
 arch/x86/Makefile.um      | 8 ++++++++
 scripts/Makefile.compiler | 2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 46fec0b08487..1d526a5d2a83 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -77,6 +77,10 @@ KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -mno-sse4a
 KBUILD_RUSTFLAGS += --target=$(objtree)/scripts/target.json
 KBUILD_RUSTFLAGS += -Ctarget-feature=-sse,-sse2,-sse3,-ssse3,-sse4.1,-sse4.2,-avx,-avx2
 
+# The target.json file is not available when invoking rustc-option, so use the
+# built-in target when checking whether flags are supported instead.
+KBUILD_RUSTFLAGS_OPTION_CHKS += --target=x86_64-unknown-none
+
 #
 # CFLAGS for compiling floating point code inside the kernel.
 #
diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index 19c13afa474e..9adecd65639f 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -14,6 +14,14 @@ endif
 
 KBUILD_RUSTFLAGS += --target=$(objtree)/scripts/target.json
 
+# The target.json file is not available when invoking rustc-option, so use the
+# built-in target when checking whether flags are supported instead.
+ifeq ($(CONFIG_X86_32),y)
+KBUILD_RUSTFLAGS_OPTION_CHKS += --target=i686-unknown-linux-gnu
+else
+KBUILD_RUSTFLAGS_OPTION_CHKS += --target=x86_64-unknown-linux-gnu
+endif
+
 ifeq ($(CONFIG_X86_32),y)
 START := 0x8048000
 
diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
index ef91910de265..06bbe29c846c 100644
--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -80,7 +80,7 @@ ld-option = $(call try-run, $(LD) $(KBUILD_LDFLAGS) $(1) -v,$(1),$(2),$(3))
 # TODO: remove RUSTC_BOOTSTRAP=1 when we raise the minimum GNU Make version to 4.4
 __rustc-option = $(call try-run,\
 	echo '$(pound)![allow(missing_docs)]$(pound)![feature(no_core)]$(pound)![no_core]' | RUSTC_BOOTSTRAP=1\
-	$(1) --sysroot=/dev/null $(filter-out --sysroot=/dev/null --target=%,$(2)) $(3)\
+	$(1) --sysroot=/dev/null $(KBUILD_RUSTFLAGS_OPTION_CHKS) $(filter-out --sysroot=/dev/null --target=%target.json,$(2)) $(3)\
 	--crate-type=rlib --out-dir=$(TMPOUT) --emit=obj=- - >/dev/null,$(3),$(4))
 
 # rustc-option

---
base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
change-id: 20260504-rustc-option-cross-7b524fc354d8

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


