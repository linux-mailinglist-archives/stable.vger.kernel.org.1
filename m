Return-Path: <stable+bounces-161813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3B5B039DF
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 10:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0026D189C622
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 08:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0A023C4E0;
	Mon, 14 Jul 2025 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I3n8Eymi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF3623BF83
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752482931; cv=none; b=VCMJQ4AgmDIhXQG1jm/+Oa8CpekXpiKZTDZa2KWwoRj5SUT4mD3Enp/dVuyhD7Mko264vTEKaiWsFmFJ42485r6sRaU2wVdgFoagzPR6yk2AVU9Dga0nRMzDoAynEKlVVPfwtXZPlWPvFhkVIswXc0vAvp3r541nsaNLd6IBFS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752482931; c=relaxed/simple;
	bh=uEb/0VR0iaHwMvhSvE890850NYx60tZHhru27ZS4cjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGEdtP0i+hIGv9r6GhaU+HejNLjr4CJ13kTgqVVddjbvlYGi1t4ICHZoSFL1FCen8idMSFQHcwU4tQrxocwtt4T9A7u3ZV1WcSmJZTKxr8q5ab8mwpc/D5cZlvCEL/MOe7OZOEOZ9HccptOozUYnYb6kskpDh09hhDNobOfLYQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I3n8Eymi; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a54700a46eso2398961f8f.1
        for <stable@vger.kernel.org>; Mon, 14 Jul 2025 01:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752482928; x=1753087728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2eqVvWUGyRNHCflMNysYozlpMXxPdhkCEbZuAC8Zek=;
        b=I3n8EymihNmdglcYcNwsS2/MPGOG7vVXFBzibnHNvjm5lkfjhFSAjzqaUtmm2e6BlD
         9fo+j/Z+dvGxdk19LI0S9aPjkEcTCaLZpfuRkFZZtxTH/C0aK8F9ET4AZgUu3GYWZG5b
         NWLz9fIlLEUU60YcQik9hrjrXzyo8Mdht053meqDCbLvH8E0gtqK92jVlKTMhlZEqXM4
         zE7GZRaCRfI0ii97ruG7F1pTvtnSBpuAcUF8DnxOggZgeKPbP8qE4mmy8tU4Ad6KlO2F
         U0Wh4lelHhyMnHwTYD7/7FhMIi7zeY1jkNijJBcN5O7tvMe9am1kRFqr5LB2LiB6JqnA
         MRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752482928; x=1753087728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2eqVvWUGyRNHCflMNysYozlpMXxPdhkCEbZuAC8Zek=;
        b=d1T3ObtbkURPE+ok3AN/ggMb5aGXKaZN6Uv8MRhdN1Wd9yl17Egm58+F+Qk7f8eql7
         sXHomI/dkHaDwYxBkksp/IRxtv51j99MVN4OxPN663FLFW/xhOR8Hsbbb+5uaZkviMTr
         vpIt1A8m5Y+w4nP7HaQzIc8gKsHZrHtXetS1Fd+SXj4Gc3C/s9gfYYsQNAUgpYc66Ze9
         FyXIkM7DEFRmK2o3KYzHULVAqbPrw5lf4oBE0KTpZqHEZW47KC6jcy7CArqoRFtWzBfm
         zsKSjHIcW5cg2zmguBgJWuHetJGjkrpbTPWP0HICBBekkkBP7Q9wBr0+UawCd3spaJrW
         HXkg==
X-Forwarded-Encrypted: i=1; AJvYcCXlqwqHdK3FqrfiLh/H9TzNzUrIw/HngA1CduGC99FiL1bI9iiQGzgUcrerQhHdc95tovgOG54=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIYgb3HdIbfOsmW7DLdPGMBRQrIQOXJJcUQPlVoUN6x46bX2jA
	zjvPcXmpWgOeRaLEI5lVsMxo5pF8Wsxb6tP/5dfdTI9K2IdwKQ1BGm50NZCD9QHpqOpHbr0c0DR
	8GZd3eNOvUIxXkPW51p0FAhbE3/h2xkikgK15jrJK
X-Gm-Gg: ASbGncsyFueqEndv2voD3nUZOe4w+Du5cnTn/UJgKTEh+AjaV1pCseXmem/GhVX5LnR
	x9rW98dWoCO03a9nksZnbh6OQP4OFN4TqewZNeh0WQWsNiwLm7+MMoF8it7VoQsAZ4FGKz5CULp
	kislqAnCF3uEd0RvIIpsf1wSEd/Aw3nWZkKkcVER5KdzMcJlvuSugupwsmISBQIhEyFBnPAx9qy
	RnsVUUUb6VZN/8XVD+KtdtPGcK0B4GFifDjLA==
X-Google-Smtp-Source: AGHT+IFbanDs448XsjcCBuRD1OV+c4gYqU1GnCMBsm0XxQ4lxhrcMIJOjMNwYVAs8QqAaAg2E2jmgkH/HpU2k0t6Gys=
X-Received: by 2002:a05:6000:1ac5:b0:3a5:58a5:6a83 with SMTP id
 ffacd0b85a97d-3b5f187e264mr10159893f8f.13.1752482927867; Mon, 14 Jul 2025
 01:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250712160103.1244945-1-ojeda@kernel.org> <20250712160103.1244945-2-ojeda@kernel.org>
 <20250714084638.GL905792@noisy.programming.kicks-ass.net>
In-Reply-To: <20250714084638.GL905792@noisy.programming.kicks-ass.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 14 Jul 2025 10:48:33 +0200
X-Gm-Features: Ac12FXxMqzqa-86YzzJsOO2IogpXRlxWKeLa1kAAYOw4KPVk-KLgMAKuFCR7SWg
Message-ID: <CAH5fLgjtU1u=h8FY3im364AsC21GitnrjhBT=YJMmipH_ZWnQA@mail.gmail.com>
Subject: Re: [PATCH 1/2] objtool/rust: add one more `noreturn` Rust function
 for Rust 1.89.0
To: Peter Zijlstra <peterz@infradead.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 10:46=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Sat, Jul 12, 2025 at 06:01:02PM +0200, Miguel Ojeda wrote:
> > Starting with Rust 1.89.0 (expected 2025-08-07), under
> > `CONFIG_RUST_DEBUG_ASSERTIONS=3Dy`, `objtool` may report:
> >
> >     rust/kernel.o: warning: objtool: _R..._6kernel4pageNtB5_4Page8read_=
raw()
> >     falls through to next function _R..._6kernel4pageNtB5_4Page9write_r=
aw()
> >
> > (and many others) due to calls to the `noreturn` symbol:
> >
> >     core::panicking::panic_nounwind_fmt
> >
> > Thus add the mangled one to the list so that `objtool` knows it is
> > actually `noreturn`.
> >
> > See commit 56d680dd23c3 ("objtool/rust: list `noreturn` Rust functions"=
)
> > for more details.
> >
> > Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned=
 in older LTSs).
> > Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> > ---
> >  tools/objtool/check.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > index f23bdda737aa..3257eefc41ed 100644
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -224,6 +224,7 @@ static bool is_rust_noreturn(const struct symbol *f=
unc)
> >              str_ends_with(func->name, "_4core9panicking14panic_explici=
t")                            ||
> >              str_ends_with(func->name, "_4core9panicking14panic_nounwin=
d")                            ||
> >              str_ends_with(func->name, "_4core9panicking18panic_bounds_=
check")                        ||
> > +            str_ends_with(func->name, "_4core9panicking18panic_nounwin=
d_fmt")                        ||
> >              str_ends_with(func->name, "_4core9panicking19assert_failed=
_inner")                       ||
> >              str_ends_with(func->name, "_4core9panicking30panic_null_po=
inter_dereference")            ||
> >              str_ends_with(func->name, "_4core9panicking36panic_misalig=
ned_pointer_dereference")      ||
>
> Just having "_4core9panicking" substring is not sufficient?

That prefix just means it is defined in the panicking.rs file, which
also has a few functions that are not noreturn.

Alice

