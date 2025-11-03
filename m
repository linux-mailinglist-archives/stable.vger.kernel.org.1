Return-Path: <stable+bounces-192176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2991DC2B0CC
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 11:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953A43B478E
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 10:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62232FE579;
	Mon,  3 Nov 2025 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sppOjdaz"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A6C2FDC47
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165630; cv=none; b=JN6ZlJeneravPzxxauZcCEaIXJSA/Ad5rWhPZGW1RrLlJoCIW/6wjTndYxGv2gv2bzCZ4mZgm2TdXmDmxKzWhW8GQXSUf7u+hgYo6nUF0+E+mIbcelMdkqEuWUXuae5FF7BG7gHw91eCN7348ZUnp48C4bXtqjl7b7KrhSFJ+OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165630; c=relaxed/simple;
	bh=zeOd2iozLHY5E9/h0Dlh5Vw9vcim7rHAVynPoeVlDd8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IT0VPa+koq45/ABzFyevfMVwYMYxzEn4Yg1g4yi+aZ1Kxbws2XqbKcNHR7G1d0RHvFSxnY1e1V4OhTeVxNSHz8VgHpZBGKtLA9D3PgDB4//9y5sFljR9qOlogbb6LH0dIXTbGSl0IAqPV9nQBK/S6T4Ioz8iKqUdCVbFPAttkDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sppOjdaz; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-640cdaf43aeso484268a12.2
        for <stable@vger.kernel.org>; Mon, 03 Nov 2025 02:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762165623; x=1762770423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wfDOrMXlo4clgAlmd0PnLLaSk5oU7JsCtleVfGyOwWI=;
        b=sppOjdaz+7JCYy/CmrPa+P6onqxCs3MB16u9pRaWluab+OtzYPcvItzVGFVAfMTO+M
         SLgftTLnPZH3LjYvR2rJ1ujl0qaSUfLjcH75qhshq5ta1gJP7kgFeCLcY6lOIPuYPwx1
         bf6Ll+Be7WYUOiUXr2BEV4NmNlTxXWzu5FYgN8fJ1CW9WFkKVnG4M1dEPl2Bg/7SoPti
         TV47jHBxi5GTV5RmnEMsjOWvzGg++WhRt3tMp61fUxEDmuEpj+RkZ2PtetokLZCNLJmk
         FwDOLzKaWb20hFRnMRn+ITCSYX/o4oFHlbxReJqRuthKcH0DxalQSdLiGkZwkclEHlob
         rZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165623; x=1762770423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wfDOrMXlo4clgAlmd0PnLLaSk5oU7JsCtleVfGyOwWI=;
        b=ujuSohnrd2qwdOIMriWeODO0vTlJ138yo2qdzSQkYpxHptKDA014bILKNqke5YRdFm
         2F/pHkuBRbykoLQZPhlRDsa3WFE+3WbSL03qG1yqbkQg4DXjtPzKtYyVkqTlJzS0/rU3
         NzxC5M2734TCI02G0v9LwFkqd3q1vJ6OSEL91i1GBjDf1vMSWDqBs9W5zDqULDC7TKup
         dUrM0B1RqTiobBqae/+4hXDfxnIjAR52ewL/Cr9ZiM0ygbugiX0TFwd/38MvVr4by7zc
         Asoxzu3DgBu8vsYEWvaexHirkF5wAW2Bpj17S3/EUqY07RajYGA9QJ7ymDOnrGoatOVy
         fQ+A==
X-Forwarded-Encrypted: i=1; AJvYcCUSWNo5dsc03kixk+2DD0LcaafePyBQglUY0tOmqtjCyVutqLDVXQFNNp8K589usKacerYzGQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjvg8ROQXmDT5lvswKYu04nBqdc9eReUFtA1aNVX3XMDm9bI/+
	gG7Fepqe8i3FksRpUYJjIEijs2jVib6RsflfC0zvmpqIxm68WVFkiyIukt0rmJhIs2NQDCjUbRC
	zpWVWoZ77ToqCMpyocQ==
X-Google-Smtp-Source: AGHT+IHA/3waiBho0mXu28WwEu1WqeXYiiwR6bIsXlP4vDe3/Ww+rW0qIjmyU+AvmPyU6HG0yyjcIpqx3mZy7js=
X-Received: from ednd3.prod.google.com ([2002:a50:f683:0:b0:640:9915:7946])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:42d2:b0:639:4c9:9c9e with SMTP id 4fb4d7f45d1cf-64076f745edmr9836758a12.10.1762165622423;
 Mon, 03 Nov 2025 02:27:02 -0800 (PST)
Date: Mon, 3 Nov 2025 10:27:01 +0000
In-Reply-To: <20251102212853.1505384-2-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251102212853.1505384-1-ojeda@kernel.org> <20251102212853.1505384-2-ojeda@kernel.org>
Message-ID: <aQiDdZvRNrBkrB-U@google.com>
Subject: Re: [PATCH 2/2] rust: kbuild: workaround `rustdoc` doctests modifier bug
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sun, Nov 02, 2025 at 10:28:53PM +0100, Miguel Ojeda wrote:
> The `rustdoc` modifiers bug [1] was fixed in Rust 1.90.0 [2], for which
> we added a workaround in commit abbf9a449441 ("rust: workaround `rustdoc`
> target modifiers bug").
> 
> However, `rustdoc`'s doctest generation still has a similar issue [3],
> being fixed at [4], which does not affect us because we apply the
> workaround to both, and now, starting with Rust 1.91.0 (released
> 2025-10-30), `-Zsanitizer` is a target modifier too [5], which means we
> fail with:
> 
>       RUSTDOC TK rust/kernel/lib.rs
>     error: mixing `-Zsanitizer` will cause an ABI mismatch in crate `kernel`
>      --> rust/kernel/lib.rs:3:1
>       |
>     3 | //! The `kernel` crate.
>       | ^
>       |
>       = help: the `-Zsanitizer` flag modifies the ABI so Rust crates compiled with different values of this flag cannot be used together safely
>       = note: unset `-Zsanitizer` in this crate is incompatible with `-Zsanitizer=kernel-address` in dependency `core`
>       = help: set `-Zsanitizer=kernel-address` in this crate or unset `-Zsanitizer` in `core`
>       = help: if you are sure this will not cause problems, you may use `-Cunsafe-allow-abi-mismatch=sanitizer` to silence this error
> 
> A simple way around is to add the sanitizer to the list in the existing
> workaround (especially if we had not started to pass the sanitizer
> flags in the previous commit, since in that case that would not be
> necessary). However, that still applies the workaround in more cases
> than necessary.
> 
> Instead, only modify the doctests flags to ignore the check for
> sanitizers, so that it is more local (and thus the compiler keeps checking
> it for us in the normal `rustdoc` calls). Since the previous commit
> already treated the `rustdoc` calls as kernel objects, this should allow
> us in the future to easily remove this workaround when the time comes.
> 
> By the way, the `-Cunsafe-allow-abi-mismatch` flag overwrites previous
> ones rather than appending, so it needs to be all done in the same flag.
> Moreover, unknown modifiers are rejected, and thus we have to gate based
> on the version too.

Ah .. we may want to file a bug for that.

> Finally, `-Zsanitizer-cfi-normalize-integers` is not affected, so it is
> not needed in the workaround.
> 
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
> Link: https://github.com/rust-lang/rust/issues/144521 [1]
> Link: https://github.com/rust-lang/rust/pull/144523 [2]
> Link: https://github.com/rust-lang/rust/issues/146465 [3]
> Link: https://github.com/rust-lang/rust/pull/148068 [4]
> Link: https://github.com/rust-lang/rust/pull/138736 [5]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

