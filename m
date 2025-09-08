Return-Path: <stable+bounces-178909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63D0B48F41
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 15:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992C4168FF8
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 13:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A635E30AD1A;
	Mon,  8 Sep 2025 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a4LvXJ0D"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF4B309DC5
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337559; cv=none; b=j+r34V7zFhlF7fZ2s+xLR9DPNq31mjyogx6EJj/Sw7djcyMZ1mrwJviTrWbJk6hpMsJLiI4bXqH96Uxfib+cTVJpgKvCLhinm3bsFlGqaOJ8muo6Qot3EGK3LJjuz34D+/byLIr8yxUxi/xp9jpV8dTZqhw1IxKpAsSBpiMbk1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337559; c=relaxed/simple;
	bh=nWM82YYVgDfmnz3ZFulMlOndRktGXnF272wdon8Wdvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gr/4Qe2cdwGLXK9gVyVcWYOoNavbqaKRaZHUsQPmXoX2wHIzf7n48VSD+KfR6ArNbKNjMj0q7gO69LC/FIgQckAH3F++8cJq7YbgtgL9Ec6bMuE1K7X10q6FattayHDIKPYgvP9BvIAIoqmIuJkU/vaKyP8V/h/WrPsEvlAPSOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a4LvXJ0D; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3d19699240dso3240816f8f.1
        for <stable@vger.kernel.org>; Mon, 08 Sep 2025 06:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757337555; x=1757942355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWM82YYVgDfmnz3ZFulMlOndRktGXnF272wdon8Wdvw=;
        b=a4LvXJ0Dn30n/WO4xD7J+kLySGxRnSCOXJzoEqx7BdOWmEq2Tbzqk1LtMfnp5H7ZBe
         mT0MSJPl3caqIDSafAC973IpPnS2ph/uP78qXBoNwsR36dkdyulLeSEEsj840wqJX3iP
         U+SoQYHg2m4W8lzRIg6pvEhMc1gzfHHsmdeDOm567nYNOoBcXBbnqFy7YnC78dXHlMnZ
         Cx8EZWFKDO2jsZkZ9ZNoLGd0zBDEHaTR2kiklJqsTHrsvyUGaEq0E/0vk3aF9WGcTuzJ
         +F7rXtUZvcWi4PWno0ZHnWxQek5pk6vhO2hnkIOKPGG4btBjr2+4g5TJqhjfRU3jQPdE
         fA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757337555; x=1757942355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWM82YYVgDfmnz3ZFulMlOndRktGXnF272wdon8Wdvw=;
        b=nyIK+uhSOMMgWLuP8Pwae5eOPrKgSEn5Sc4OkR9eQ69xfXv3cEw7urkjBEFR+zBRj6
         L5ysGKvxXChuAOx2jBAJMS9f+OzP5OCizZwcZluPmCXdxZmuFJpSJFzHnytWFhXgktOR
         I/ye9m5RLBaTKAT6uVeViM+MSur42b24RAe1xU+71cHIOtUEtebb6oAEBEGD6CxkATdD
         ytO1sdluJroHA3xr9ArmAEm6sgNNuvf/cELd0OTsOKnu5r7LfsfYQQA4y6g/VpqV1sSm
         QhpVn5WGqpHRqXsPXjE0/m0M2phHNXGvbgpEZVkQmP5flsiWQkRFz423HOSHQGhMA0fq
         RosQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAm0GrFDUS3ahYoaMkZwTaxdNiuo/mJcDgs6AJRyKQ36wn2TZx4ufmp2boEs1Cm66pKuVtsg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZY/1emW8YZtI+eIn/mID7PO0IBzEuqro4Si6Mts99vpSDzkgf
	6m7mMd6JsgrKzFOFaZf/WdfBSxKqKzOri2awnTro0ajto0FjyuoeSwjyf51QganizwCjozzG8iG
	yIycjg4S3qDO9EPvYnLv6c9PST3TfHWKMCmWq0KBs
X-Gm-Gg: ASbGnctbdjw/BUqh/ZY02ZwD7yJWnbx3InwjcLTHqIxdL2z2ZeAhPjWsr+ShrPJbqXD
	tcXkzPFEe6uU/Kakz6jDH73RwtD5ldIiyV4sHyiXraCkx3qg1KbyCshb6jTI0CVrLraSm0xWO48
	UBx3WNs/JM8OZX3Dg/sl/7cmJzblABdfyudMCm/o2oT5PBFY9hx1dOmjjUkLjnTK8EIWOiq5ivK
	DCGTOvc+o3mjaLXZlZQjBqGI8jZ6tmQkCzqzSrb0yKv+BoXqlmL28KHPRXblROlLZeFKAcOz4pG
	9wZt1cSdwLw=
X-Google-Smtp-Source: AGHT+IFjSj9fcvGgclrt2uVXMQc5eZzeD36hnbx/1QwTeUfZ8T3zw8xE5Ei6zyAbQg85xb3R6cvvnoz9yGYt46etz/w=
X-Received: by 2002:a5d:5f47:0:b0:3cf:ef30:c819 with SMTP id
 ffacd0b85a97d-3e627b712cfmr5610348f8f.4.1757337554607; Mon, 08 Sep 2025
 06:19:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908-distill-lint-1ae78bcf777c@spud>
In-Reply-To: <20250908-distill-lint-1ae78bcf777c@spud>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 8 Sep 2025 15:19:02 +0200
X-Gm-Features: AS18NWCUVBew4vUh8r_LLedLxLSYsoQ9pdJJZqEHSkY4P6yHIK6L_lJbY-hCLEI
Message-ID: <CAH5fLghqe8sxLD3vk6VLbA8UoMgEw1iNxgE8uETAeCnRz1D0DQ@mail.gmail.com>
Subject: Re: [PATCH v1] rust: cfi: only 64-bit arm and x86 support CFI_CLANG
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	stable@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Kees Cook <kees@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Matthew Maurer <mmaurer@google.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, linux-riscv@lists.infradead.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 3:13=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> The kernel uses the standard rustc targets for non-x86 targets, and out
> of those only 64-bit arm's target has kcfi support enabled. For x86, the
> custom 64-bit target enables kcfi.
>
> The HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC config option that allows
> CFI_CLANG to be used in combination with RUST does not check whether the
> rustc target supports kcfi. This breaks the build on riscv (and
> presumably 32-bit arm) when CFI_CLANG and RUST are enabled at the same
> time.
>
> Ordinarily, a rustc-option check would be used to detect target support
> but unfortunately rustc-option filters out the target for reasons given
> in commit 46e24a545cdb4 ("rust: kasan/kbuild: fix missing flags on first
> build"). As a result, if the host supports kcfi but the target does not,
> e.g. when building for riscv on x86_64, the build would remain broken.
>
> Instead, make HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC depend on the only
> two architectures where the target used supports it to fix the build.
>
> CC: stable@vger.kernel.org
> Fixes: ca627e636551e ("rust: cfi: add support for CFI_CLANG with Rust")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

