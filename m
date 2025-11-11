Return-Path: <stable+bounces-194487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5FFC4E439
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 14:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D733AF494
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 13:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D09935B15B;
	Tue, 11 Nov 2025 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VM6fBr1Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55639357A22
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869291; cv=none; b=UUEAq5QIb/uAayH52l/j9k24FUfn6V/sgsc4Y7G/jNlOoq7EJqV35bR1k8+KyZEAMC3wcL6Mg6NVMckBUOKi28enHtsA5Su4XXpe+PNC4kxTmoEElezR8R4XrsBP6wqeM3EKO5oe2zHZCgCaU6yHdHbiWmvv9oOktXgez/+ZBFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869291; c=relaxed/simple;
	bh=A2TkjakrfDdkYRGuTxjcRqTay/V7iT1zDDZWS1m5mUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ukRnsGfLt9MF7XmahjomcQEDjKUcX8+QUSPIYTMjwUGDkMKi7J1sx2cOGW7Sk9wUCHHE7Y4NXLD/KINcnKTjHHGX0AJ9VGSd4EuYXoirsjo6o3AYffclYY+3/CcwKIBPRZZJx79SwSa0Lo1cU8k3CJ3/nl2gSBti8sbIqD9Rkis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VM6fBr1Y; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-297f6ccc890so2614645ad.2
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 05:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762869289; x=1763474089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZoLj4f0GVdI3DGKFlEJ4QWVzpBGFdDaaHgYw2dfwqU=;
        b=VM6fBr1YGmxYu0TgqLDBmuYZthtRhP2l1NGNo+6VXxP63RHkYR6cUAEkj/dIxOGUDY
         oNeBF75BrIsmhCH442DLOVHmuDmCsnEl07eWREbkDA9cPqBd3p2KFNJhMdz5pcwbE521
         Uv1XYgqMlp06hHuWENh50Z2/aORP8v+Uc6ccSwTdklMewwZ5TgE7Zz6CH0K+qfQ9ZAkF
         nqzieJYyDxQ6ixKS9ex2CgxZLk0cZrYMJrvIq+lWi6e4d5+nzro2LqyuaPGMjGdh1/Gs
         6HaKBVvNAu7EXRjl3GQZRcdOkpSHq16Nhy5lEsaoRcfzicfeYvXeY+bOkLsY+uQVSBXN
         t74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762869289; x=1763474089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DZoLj4f0GVdI3DGKFlEJ4QWVzpBGFdDaaHgYw2dfwqU=;
        b=eR2UbjLi5HmgOcb/ZHz1uo/u4wUeQDht2jI0RusLEliS+/OZSL5kglgsVbQJcf9t/N
         4+ndiAjYdbvKrZoWr0FjQpLcySxQnQHvOj8ZXo2WdeYiZ1ntHZtcCM6jdQkwVj4LEUGX
         3gslkHSbqyxc2erJquvRlpkJpZ0fYIg2simrwGSBJ/I1GJbSWK4Gn1VloXPiXckmD7Z9
         Jojk1ZymTDMgfJiwENrw77W2O1xH+w/tD1jPb7uiONZeSPt+7fewQOsc1dve6dAAiqtp
         b8pfgzjHpw7x+0Z/kvRtKCvY4ETWDaiopCYnNM45G4cW0watsBX0IwmGhEaSiQ0K/w4Y
         iZwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgYcE/rPYGwbHnv2k9Z6NsHdeNEP4bzfWNnLI1v70lng7p9pAdDWhShVBCfBDGpSjQbw3vTlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbgOGU8STa4Ff7dwFlYpJRLKZt9bbtglH8CCePfVrq1/PVXtB0
	T78f8eygtSCHX4MP1u5KsmWSuLMhQa5FGvRe6wCnBssOA8TtcIVd7fXr7A9rsDkwHVtYcJzYmgi
	oHPrWMBjcJ5lkT3m5ucCbJfExIt/bnuQ=
X-Gm-Gg: ASbGncu74C2fnHe3c+4BN+0BIIVcTeb3DX/gaNtXm4JvjOxrE0xO+epw7tnPE3k9ay+
	WtT25+kW//EhW1HU1layUQk2NYkOkSo8ZwxG9NJciC/vUNYJfs5waieaFOi+e/29HzH6YiSLunS
	YLI/GG8YZsAOnUK0dGqyFCoWYrJkYy++WboO0+d+Ik5K24UXJNpWdp649rFDtTq/KStMghyCD6K
	i4zMbkBXSQVGwBH1PBwx1uE2ZdGFkzeY7ntZO5rTC2PVAYL5Cmxu3k1CDJpVjmKgT7yTtj2GTRO
	pgdnvX3C4oGl9vcJrbzpykevSgh1DVEFnf5XaGaaNd5BYZw/fCiIVCgB89bWspV9JPmxOGIiz1X
	PbnjWx12huIdP5w==
X-Google-Smtp-Source: AGHT+IF0Z68cGNnWIYfhE+GmNXty3zSKglcsJIW8DTGnNaR5oz+N94f18Ae9bgXwDGF1o3kKuYh1bmeQkQ96c2H5z8Y=
X-Received: by 2002:a17:902:ea09:b0:295:511d:534 with SMTP id
 d9443c01a7336-297e5731561mr84933915ad.10.1762869289453; Tue, 11 Nov 2025
 05:54:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110131913.1789896-1-ojeda@kernel.org>
In-Reply-To: <20251110131913.1789896-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Nov 2025 14:54:36 +0100
X-Gm-Features: AWmQ_blj1Y6aEDrIDY1SHsBj9ipAJhqLELG9lX2PJ-XtkIigMIPK_72YnkrkjN8
Message-ID: <CANiq72mjFobjfQEtNvk9aA+757RkLpcfmCCEJAH69ZYsr67GdA@mail.gmail.com>
Subject: Re: [PATCH v2] gendwarfksyms: Skip files with no exports
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 2:19=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> From: Sami Tolvanen <samitolvanen@google.com>
>
> Starting with Rust 1.91.0 (released 2025-10-30), in upstream commit
> ab91a63d403b ("Ignore intrinsic calls in cross-crate-inlining cost model"=
)
> [1][2], `bindings.o` stops containing DWARF debug information because the
> `Default` implementations contained `write_bytes()` calls which are now
> ignored in that cost model (note that `CLIPPY=3D1` does not reproduce it)=
.
>
> This means `gendwarfksyms` complains:
>
>       RUSTC L rust/bindings.o
>     error: gendwarfksyms: process_module: dwarf_get_units failed: no debu=
gging information?
>
> There are several alternatives that would work here: conditionally
> skipping in the cases needed (but that is subtle and brittle), forcing
> DWARF generation with e.g. a dummy `static` (ugly and we may need to
> do it in several crates), skipping the call to the tool in the Kbuild
> command when there are no exports (fine) or teaching the tool to do so
> itself (simple and clean).
>
> Thus do the last one: don't attempt to process files if we have no symbol
> versions to calculate.
>
>   [ I used the commit log of my patch linked below since it explained the
>     root issue and expanded it a bit more to summarize the alternatives.
>
>       - Miguel ]
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Reported-by: Haiyue Wang <haiyuewa@163.com>
> Closes: https://lore.kernel.org/rust-for-linux/b8c1c73d-bf8b-4bf2-beb1-84=
ffdcd60547@163.com/
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://lore.kernel.org/rust-for-linux/CANiq72nKC5r24VHAp9oUPR1HVPq=
T+=3D0ab9N0w6GqTF-kJOeiSw@mail.gmail.com/
> Link: https://github.com/rust-lang/rust/commit/ab91a63d403b0105cacd72809c=
d292a72984ed99 [1]
> Link: https://github.com/rust-lang/rust/pull/145910 [2]
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

I will send a couple other fixes to Linus this week, so if nobody
shouts, I will be picking this one.

Thanks!

Cheers,
Miguel

