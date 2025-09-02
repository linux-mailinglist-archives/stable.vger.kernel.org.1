Return-Path: <stable+bounces-176945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB537B3F85B
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 10:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8E717B27E
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 08:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653022E8B65;
	Tue,  2 Sep 2025 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q736aFP6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474332E2DDD
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801774; cv=none; b=B91grsfmSCOGu/P4Hd0aqy22qi8vEKwO5XiPSZ55VGTCO3BwdfS0uINajFNWqcWmv9GwzZ0ssbDSWr1sdg6Mld6sRYCHZi1IeG2cEoC/3k0PpGwXF3PD2rRiKo0xJ7xj6zbqwN29mqvrG7OMA4qyPWGSPtKRlfGy2oYkqhVIJYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801774; c=relaxed/simple;
	bh=mz6MChWAhIh1fUS9YL3zMQPODRH3xmYPsKPrGEnKmVE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U8JrZ84OF1cj5n32ojDFb4K6wHTFTR+HsVrZMdt9FMrkCyxBChrKMEUah5fBC5nBJ+peu7Jzank/FPGGaLVPsYPoXsBz33hxqaxAHl4TvTtjS6QN2TSvPFjwFx8aY5xRTvexjf8NXouJ6MZ2A/PBGxUik1cjloADQ6X/cFVE7/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q736aFP6; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45b883aa405so18553215e9.2
        for <stable@vger.kernel.org>; Tue, 02 Sep 2025 01:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756801771; x=1757406571; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fMrVj7jAgdBMUg6bB9EkBvTIBFRbh5mF4KGnDnI9ZoQ=;
        b=Q736aFP6pE3HDPM1K/YTKrI13Zb6j2GY5mHXoLrn4KCtI3xOjhebM5iy6A08lG93BB
         Hi/o5b7fTunhII2O8aVjG0dVcRZuK8onnTAnZK9BNL3pz65Wq8ysaDprx7iGCg+X9ClO
         +oOt4jZlMxfjNHBAgvoulFPTlWoizVg+rwz6KU9/Wgs3+fcziY+e8WLLrsNRFmnZN23x
         wgXq/V9JnsWAjFVpJPfSJvQV4JMih465l6MZiKGQVkHUxH4yQBvSTaj6NqHs2jFD8Hl7
         3OANehw40X32KI5GhUvkNcju4enJRc+4uf/vcLrarAFYuobPHkiPNxfS0dEBLuZ9qlhi
         ERwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756801771; x=1757406571;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fMrVj7jAgdBMUg6bB9EkBvTIBFRbh5mF4KGnDnI9ZoQ=;
        b=PnYrZriNmNDDm6jB70nmJRAC3RjQHnMQog9ZOaGMBXnW3eA9ZAqy/7JDNp5l59hmI1
         ZVdhQ+eBbyMVgV7shW99AmY5RctZeQ5He5AjF95JdUzzkuxI5PiTcP54RXSI2A72Rb0B
         InUqs+gAgMNnhsG8otkHYNPUSTjwesInGnKob73RYKY3hd5y424cCHqlwO9YRUStNQMx
         KFAXOXrBpUSMxWsFzbJXIyf1rcXy3EKN6cy1Gi4BITSmWUr6v9GVnIFvzMcMknK5Hz99
         sGcSmfxW/b+TbP2XHNoMcp9AfI6YQHPeAiM4JWkt3w9RMFVmZZ0NTYXowAFu2Tu7haG5
         YEKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc+VDYE6EIzEahWhWWcs1IWo2IWJxqthy4BzLYN8QbBtarRnQJ4KQ6PisBiiBwPHTgcSUZlkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNKh80TmHi/O+qzs3RJobrH8FPiUvALc+gcQPaDe4oq8+4Wi+F
	PWc4YEOR2eUp7IzvlT+r7hQEpCr/an+lcqMK+2vBqeULM5RN9ZNVZMuh7QLwHOYdWayxt0TKCyb
	9V/IHSEiScpvtWp1nOg==
X-Google-Smtp-Source: AGHT+IH+wbAKMP4pet3Iec/jg+z/+uHyKtEPnwn80rzGG04HiSXVcEQZ2VRn1KYTtbbuXX26NiHOYJCKfauiaaw=
X-Received: from wrbbs17.prod.google.com ([2002:a05:6000:711:b0:3b7:8b93:59f4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1a8c:b0:3c9:24f5:4711 with SMTP id ffacd0b85a97d-3d1def66f6dmr8162944f8f.43.1756801770707;
 Tue, 02 Sep 2025 01:29:30 -0700 (PDT)
Date: Tue, 2 Sep 2025 08:29:29 +0000
In-Reply-To: <20250901-shrimp-define-9d99cc2a012a@spud>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250408220311.1033475-1-ojeda@kernel.org> <20250901-shrimp-define-9d99cc2a012a@spud>
Message-ID: <aLaq6TpUtLkqHg_o@google.com>
Subject: Re: [PATCH] rust: kasan/kbuild: fix missing flags on first build
From: Alice Ryhl <aliceryhl@google.com>
To: Conor Dooley <conor@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	kasan-dev@googlegroups.com, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Matthew Maurer <mmaurer@google.com>, Sami Tolvanen <samitolvanen@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Sep 01, 2025 at 06:45:54PM +0100, Conor Dooley wrote:
> Yo,
> 
> On Wed, Apr 09, 2025 at 12:03:11AM +0200, Miguel Ojeda wrote:
> > If KASAN is enabled, and one runs in a clean repository e.g.:
> > 
> >     make LLVM=1 prepare
> >     make LLVM=1 prepare
> > 
> > Then the Rust code gets rebuilt, which should not happen.
> > 
> > The reason is some of the LLVM KASAN `rustc` flags are added in the
> > second run:
> > 
> >     -Cllvm-args=-asan-instrumentation-with-call-threshold=10000
> >     -Cllvm-args=-asan-stack=0
> >     -Cllvm-args=-asan-globals=1
> >     -Cllvm-args=-asan-kernel-mem-intrinsic-prefix=1
> > 
> > Further runs do not rebuild Rust because the flags do not change anymore.
> > 
> > Rebuilding like that in the second run is bad, even if this just happens
> > with KASAN enabled, but missing flags in the first one is even worse.
> > 
> > The root issue is that we pass, for some architectures and for the moment,
> > a generated `target.json` file. That file is not ready by the time `rustc`
> > gets called for the flag test, and thus the flag test fails just because
> > the file is not available, e.g.:
> > 
> >     $ ... --target=./scripts/target.json ... -Cllvm-args=...
> >     error: target file "./scripts/target.json" does not exist
> > 
> > There are a few approaches we could take here to solve this. For instance,
> > we could ensure that every time that the config is rebuilt, we regenerate
> > the file and recompute the flags. Or we could use the LLVM version to
> > check for these flags, instead of testing the flag (which may have other
> > advantages, such as allowing us to detect renames on the LLVM side).
> > 
> > However, it may be easier than that: `rustc` is aware of the `-Cllvm-args`
> > regardless of the `--target` (e.g. I checked that the list printed
> > is the same, plus that I can check for these flags even if I pass
> > a completely unrelated target), and thus we can just eliminate the
> > dependency completely.
> > 
> > Thus filter out the target.
> 
> 
> 
> 
> > This does mean that `rustc-option` cannot be used to test a flag that
> > requires the right target, but we don't have other users yet, it is a
> > minimal change and we want to get rid of custom targets in the future.
> 
> Hmm, while this might be true, I think it should not actually have been
> true. Commit ca627e636551e ("rust: cfi: add support for CFI_CLANG with Rust")
> added a cc-option check to the rust kconfig symbol, checking if the c
> compiler supports the integer normalisations stuff:
> 	depends on !CFI_CLANG || RUSTC_VERSION >= 107900 && $(cc-option,-fsanitize=kcfi -fsanitize-cfi-icall-experimental-normalize-integers)
> and also sets the relevant options in the makefile:
> 	ifdef CONFIG_RUST
> 	       # Always pass -Zsanitizer-cfi-normalize-integers as CONFIG_RUST selects
> 	       # CONFIG_CFI_ICALL_NORMALIZE_INTEGERS.
> 	       RUSTC_FLAGS_CFI   := -Zsanitizer=kcfi -Zsanitizer-cfi-normalize-integers
> 	       KBUILD_RUSTFLAGS += $(RUSTC_FLAGS_CFI)
> 	       export RUSTC_FLAGS_CFI
> 	endif
> but it should also have added a rustc-option check as, unfortunately,
> support for kcfi in rustc is target specific. This results in build
> breakages where the arch supports CFI_CLANG and RUST, but the target in
> use does not have the kcfi flag set.
> I attempted to fix this by adding:
> 	diff --git a/arch/Kconfig b/arch/Kconfig
> 	index d1b4ffd6e0856..235709fb75152 100644
> 	--- a/arch/Kconfig
> 	+++ b/arch/Kconfig
> 	@@ -916,6 +916,7 @@ config HAVE_CFI_ICALL_NORMALIZE_INTEGERS_CLANG
> 	 config HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC
> 	        def_bool y
> 	        depends on HAVE_CFI_ICALL_NORMALIZE_INTEGERS_CLANG
> 	+       depends on $(rustc-option,-C panic=abort -Zsanitizer=kcfi -Zsanitizer-cfi-normalize-integers)
> 	        depends on RUSTC_VERSION >= 107900
> 	        # With GCOV/KASAN we need this fix: https://github.com/rust-lang/rust/pull/129373
> 	        depends on (RUSTC_LLVM_VERSION >= 190103 && RUSTC_VERSION >= 108200) || \
> but of course this does not work for cross compilation, as you're
> stripping the target information out and so the check passes on my host
> even though my intended
> RUSTC_BOOTSTRAP=1 rustc -C panic=abort -Zsanitizer=kcfi -Zsanitizer-cfi-normalize-integers -Ctarget-cpu=generic-rv64 --target=riscv64imac-unknown-none-elf
> is a failure.
> 
> I dunno too much about rustc itself, but I suspect that adding kcfi to
> the target there is a "free" win, but that'll take time to trickle down
> and the minimum version rustc version for the kernel isn't going to have
> that.
> 
> I'm not really sure what your target.json suggestion below is, so just
> reporting so that someone that understands the alternative solutions can
> fix this.

Probably right now we have to do this cfg by

	depends on CONFIG_ARM

to prevent riscv if rustc has the missing setting
set on riscv. Once we add it to riscv, we change it to

	depends on CONFIG_ARM || (RUSTC_VERSION >= ??? || CONFIG_RISCV)

Alice

