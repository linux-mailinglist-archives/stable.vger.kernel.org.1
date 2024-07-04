Return-Path: <stable+bounces-58065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1965292799B
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 17:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894351F25309
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 15:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E07B1B1406;
	Thu,  4 Jul 2024 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h1RjvkK7"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B6D1B1204
	for <stable@vger.kernel.org>; Thu,  4 Jul 2024 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105722; cv=none; b=VjWzISzx5pjBh4FiC8G+nldmAUL6ULxqGbDiFYPCDls5fL1F2Cbw+u36T+9Cn9Ft0b6D9ADwqRi6TFBd8KKZ4OK8T3p93g+ZWISxXmFkH5kBgHlU1NuklcekDOPFDXXXdXeSwk1FP+W4N4fG3HEr0R4FQ0D1+odAyo5jvdiXLuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105722; c=relaxed/simple;
	bh=QPeVUrgaEZ8qmuC1e4Q7Ja32koHMoz2tK0lcoaVyWDQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=toSBRrfwyxCjLeT4S2fYvPvIZIHwBcs4dk5a2Fpc2RBTVOlqllfIdCRuGB5YcHkphxm6CoqQvjEjxD2UGgDjDNRK5dJTV55jhSrQ6NXlpF+BsF+lMDpz3HZ+aBuhZ1vUEi0asLQiETM56zrEFRYhmhwIvyMQtBLOuXeErUj8P3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h1RjvkK7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-651e54bb41bso12916147b3.1
        for <stable@vger.kernel.org>; Thu, 04 Jul 2024 08:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720105720; x=1720710520; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SAGA5ww7PBaqsKtz9jWie7SRiEUO1154T36qXbEcKNY=;
        b=h1RjvkK7SoPg+6yjB1cz/oe1wsCjhgojFZuB6hpEoFKWvv7+lVlG3bwcNR3fmdUCPL
         JqJ6lr/+DR1m0A7mRDnc2xeWHwBvzt0vCm2kl+S8N7nDspowCXfqc4bqrpiMqfP11rsI
         mdHul5RMPfjTtd9sHai6aPoFAfXKHL9RqqftPdjq/McAkfY1vxOXhycanTy5XvDYCv18
         21HmeQpZqPRSnAbwvUESFwo2LBQYUHqGCQ8vVdQT7KY1t/dpk4pefNdokVQYvGaPWtBa
         YRrCincAZMQX6KcqMrwtFmjXigMgNfN9Jdt3B7QGM+sHOiDD9sKEYYZotKic4DruMb2s
         SW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720105720; x=1720710520;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAGA5ww7PBaqsKtz9jWie7SRiEUO1154T36qXbEcKNY=;
        b=SaPPTWNo0qeBPM4H1fHzAAR0C2nNDPDVaJn/OMNGL7x4p808iVZsX+mIHpvXNl6GMi
         31Etc4Zu2SrCAPW8McXAoqsbgiM+OkyE5aMocsN4RG0427mmx2XWhO6UFIvNDlJVuxfo
         G4SUJKZLmf4cWhvWXsQcgHIwTj6Gt5GK0JpuymHD1ljwC6LJLGQutTyseAvX7afMM82v
         KIEAupfhF/UHYy6lFVOxoREQJVWEhrlzl9h8RMBvPD2rkw6KK9Sxd57lgKLcwL2RLkVo
         MR7odky4yO2ZDZP3wGn1rcQ+q1XaIAUjeJrMaWWK/5z0EkCtp/hGVRjqAyUR31n3brCp
         1YmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoKmpV/G59WEDLMET4NzqpEOZ8dE2ujulhiJbxrq/hNCm6m6r0N7RQUis8A7SOE69MDdnml4NPwoN5fxdby907jGUlXFcE
X-Gm-Message-State: AOJu0YxxHOvQMdy7Pu9Jgn77zCW8V0Spuv9CXcOjbQhu0lh+n/Bnq1kO
	Qgo3U+X2HFA13xogt9xglRhQAbZJqlziHYOYZZRU9qoc8YY5kxrky3jNjYsqS7DHDnel4sXEd6K
	OxJ8t/TfBR+Shhg==
X-Google-Smtp-Source: AGHT+IH9VR4RffY5ScSTYKGpVKwBEYexOCB2n8xGn6gRVku1k17axUw8NVFzJcK+jQWO+R5Xkyy9mMm5f3/pfeo=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:6ac1:b0:62f:1f63:ae4f with SMTP
 id 00721157ae682-652d52257fdmr189047b3.1.1720105719836; Thu, 04 Jul 2024
 08:08:39 -0700 (PDT)
Date: Thu, 04 Jul 2024 15:07:57 +0000
In-Reply-To: <20240704-shadow-call-stack-v3-0-d11c7a6ebe30@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240704-shadow-call-stack-v3-0-d11c7a6ebe30@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1257; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=QPeVUrgaEZ8qmuC1e4Q7Ja32koHMoz2tK0lcoaVyWDQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmhrrwg1l3+ZOI9jUnEe2Ion3jAzyudZf+KalrV
 Er782CNi0+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZoa68AAKCRAEWL7uWMY5
 RuMYD/44sZG6ccdUiVJPsf3WNFs8QZDVkyvHrlDdZvFrnjTE+0I+ej6cAW8aEFxmQoaZqxeeXpx
 SDRqfb2Sz1Uj2ib1iSeVDyCwjoWh3E5+1Lm4upvweGFhYBYthF+y+CWYDs6CyGgNeZ5Dy3422dw
 GGz52J6La0cXE4+6QWpi2Zq3TViMm78qa+5CbpWhBVC2DBosxiS8R8cnOLRPBCPlEQHf9nQuztI
 K6dGHGRWsgz6rDq3i698LIG3yDdfIfJkB0cHAP6PvVi2MAFk/iA9XT9Keeuybof6jGr+s0/52UB
 o0WYgva8Rjn906xSBQGzKXw7MUiYKfsXHhNGUEaYr37nQpsjsIZz8OC7/gd9V+DqSuZw1PD7ygK
 MM7KZd4Xsog/XkFbddNNOIFhTCDBFRXT+oi+hnAHgZahBSOms2QKjLMXEkGP6HT9kkV8yeyQVm8
 JJnLJPKLU7exs/BQS+F8CpwV/Yq9PCpWoPeHS0Kw7mHx3tyrRdYjY1qOFgYRXYo7TrLD1EPilIk
 2qGi0OpfdvxyMVB2TerIT9qB4HmCsVUOoJ5t8JLxYQYVWHKlxpLDe915CBgx6jbkV5XWZEArDex
 LoxSzqQgKQeaHG5yS3FUOagePEZONfPqAFgK7i4ixwbAkDT871Ax5JVgV7phRM+l/2NeBgkZlu4 9RLIicJGiY7+IIA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240704-shadow-call-stack-v3-1-d11c7a6ebe30@google.com>
Subject: [PATCH v3 1/2] rust: SHADOW_CALL_STACK is incompatible with Rust
From: Alice Ryhl <aliceryhl@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>, Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Valentin Obst <kernel@valentinobst.de>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

When using the shadow call stack sanitizer, all code must be compiled
with the -ffixed-x18 flag, but this flag is not currently being passed
to Rust. This results in crashes that are extremely difficult to debug.

To ensure that nobody else has to go through the same debugging session
that I had to, prevent configurations that enable both SHADOW_CALL_STACK
and RUST.

It is rather common for people to backport 724a75ac9542 ("arm64: rust:
Enable Rust support for AArch64"), so I recommend applying this fix all
the way back to 6.1.

Cc: <stable@vger.kernel.org> # 6.1 and later
Fixes: 724a75ac9542 ("arm64: rust: Enable Rust support for AArch64")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 arch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 975dd22a2dbd..238448a9cb71 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -690,6 +690,7 @@ config SHADOW_CALL_STACK
 	bool "Shadow Call Stack"
 	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
 	depends on DYNAMIC_FTRACE_WITH_ARGS || DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
+	depends on !RUST
 	depends on MMU
 	help
 	  This option enables the compiler's Shadow Call Stack, which

-- 
2.45.2.803.g4e1b14247a-goog


