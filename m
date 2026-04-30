Return-Path: <stable+bounces-242210-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oK3TECbK82mL7AEAu9opvQ
	(envelope-from <stable+bounces-242210-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 23:31:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A29C4A8355
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 23:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50B2830055AF
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 21:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F8027A904;
	Thu, 30 Apr 2026 21:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E54yCNp0"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FA136E467
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 21:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584190; cv=pass; b=mCX5Fla8ECHx3f/2LF/4tGh49BodWlnBaa663mvwmiL5JYKbBhdJAh9ebr4v0WbbILFqFft9aNW7D1nO1H0XOJllu5orC6iKxU+0el2CBO1cMOenkGB5TPo/oniZqrVYev5WkBdSkizVLvUJOhx1mfqYb4vlGvrDSUHDUMlN5FM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584190; c=relaxed/simple;
	bh=2uxDae9ONJwe0Y0DiJfQRd5vGS73WGpldKj8Ll5+1w0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgcfwiZs4uS5K+Vq3qSQ82e6XxtsHMdVU95xhXjMJiWZLo73AGT7nrDsTrN2ZPSWEwhD42XZjlpeZbfkD+TsMcEnBod4y9srrGt3qMmjjFEO2lSZ5ogXvQZ8NQrvunP2QNPNrqRC21zo3oFsx8Elx43SACUuVGSKmHyq9YJWj7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E54yCNp0; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12db205ca0bso156502c88.2
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 14:23:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777584188; cv=none;
        d=google.com; s=arc-20240605;
        b=RszlUcvV1Vf0y0saVoueQ0dBLZzh/lqZpNyr4rcnZBNq+osDz8O3A2T7FZiduidijB
         /LOk897/QNvnPw/6BBzAyFv1+gOjUcaICYFOBuu6SJrXjC8CQosH2iH2KprlIVqP8ttT
         Yirjmn4frmLJMBT4dqlMW3Gm9SABujuJwwG41wihH4pr5/vNV2Uin6AIv91ovT5R0Zp0
         yv2mY3ypsHDlAl9cmpUIugaozyiAJdEjzOb26U/wbNgEl0J8zKsst6ch7ESnNF6TkOim
         8fWPjkQfZknyROElQWMjhvNsTzIjwQtzO36fcJF2fptch/kGHvgXAUbWV90Wiphn4Agq
         vA/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4bf+/AuCnDsNNa3KHyHBcLKzX/unSh3vRTfxAh38ofQ=;
        fh=cnW0qUBGvvYNXLXd+rWEDkQOsngiEQ7f4sOXdVrVw60=;
        b=kXRAOAXeDcuzW6ukfpuMJ0HZhgu4538/m+bunf/NWwrCoBFPjhMi9yvtfPz45xfxBI
         8XCugzB6LlPibDQQbhK7x0gzvwNt9Kgo27MUeeIbBOfPcW/wInGYGBIS33QfS6TL/rjV
         7UiH6rZgcUXDdo67/YJ9uBIkCH1UvTLOQcL2lDv/u9KnyDEH4c0MsSmZomKaVgB4PhpG
         lj/NgF5mxSYZ6fVC/sNUdXU4TGmwoUVofVO+5IDenASkB1GJxZiqTvz3esR8Ll+4YYV6
         WYmOD41C1ZV3OAoI3CJX1cW+LpClRID+Vc+xaJGrzb3DMxnz+UrjGGYIRNUtDEKLWV15
         uTLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777584188; x=1778188988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bf+/AuCnDsNNa3KHyHBcLKzX/unSh3vRTfxAh38ofQ=;
        b=E54yCNp0FG43nSKEpwde3bQTmZl/TTAtQZji6dbtMHoP19ZG6tOCoGU6An01Nb/X0b
         /uj1WufJRkFeawqWBtNPw8FwSY7jNFtte87EaN/byvdDgGuA7GU5AzQ+rqpwN//XM36I
         dJnXLcl+RqjnfO6q+++cJI1S9HdYGLUolLRw/gTNSWFkaKSg7KX72HNaK+o1/OyYdZ6v
         Y4tw7d/DzivwdfumkbTLLxdNtsBe/pI4Ff/lH6uobn9S81UZujUAj9K5TuLPwKund+ND
         2cKY8Z7vZblsho2GNeoY5vMaPGYoVhG8jPw8huTBa/BYe2KJkri14wlXjQoKX3OP38SE
         fUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584188; x=1778188988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4bf+/AuCnDsNNa3KHyHBcLKzX/unSh3vRTfxAh38ofQ=;
        b=mNf2Nl1RBJStYiAdC4jFvR4OchOQSHaJQVBgHMdk8WucMhdK9att7dEAUG9fTztjxp
         84QSf1TURLpXC32nEW0WrxJHuIktXD9kzssoiY2WHmFlSAUb3g9LhLS60LuIfhrvbEJD
         X2uMEH6lOlOvgHgLdlzDGdB+brtFBxJZ8G3zfwGIdq6h5RhNZkMIcbKQ4U/CHpbDW76D
         g6qNKCNXOmQksFOr6lNgnhHJbu1n9npJW/5GUasP+zMLjs4kKopDmihuMrMN7E/q5RhU
         /f9hvTAE3c50F/On9HK9A7T6c7RXOR3tlilavynTOVfHBB5H2/ZwM5Az0xwib1gWTzUQ
         KHCg==
X-Forwarded-Encrypted: i=1; AFNElJ8bTxNje+YwOO2e9kqcXCVKgya4beOvMY5lvWwS1uV0TyZ/h1cgF2KuH2+CYpwJeJJ3HKo0AaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWQlmKTCn4X7O9H+SnG9Rm7u3damTLxq5yKxiaD/aJMsWSBRUj
	T0PDRVMGu8aluF4F2MQDD1r9Eby1yzIxg+5HcgcyHtuuqxV7TcI9YoqSEITYfUv8RmtVA1c3yqX
	4f3ayL6oObT2MUKGKhSgE468C0/4NCA0=
X-Gm-Gg: AeBDieuUiPSXVUkCcycLLW47uwnGWLK5MK99ZlVJO42vBFxibgEgyx108dFokzJHKsg
	oFaCCUTzt/dLtqQhDp0Mrwvm4WZp3Dguj19lvWNoZGTOZQjSjCPCmUc1mCfIxA6LUYBUxLcFD5V
	cVj/X7yRVuo/xl/rKqOkC5qg1jMyVHk62W6VThF0SWXAXseXSEXhkC4r7llQk0K2auG2slNBvm7
	PZ+f+YyCm1S4illSHXSr49BzrOElN/HYXO1tG4LatV8fBcvavYAGk6sZ0b4lZz8U8U4rJMiGZUM
	fiKKTCdfFpqVRmgHBXsNWoVWYWWpAsysU2yiKD5JAdcCVNk5WNofqn5Okl2UoZYcAWwlsywA6GW
	vYOKixbgQvklI7+c44oYMf6fG85IUy3EKUQ==
X-Received: by 2002:a05:7301:5803:b0:2ea:de28:f389 with SMTP id
 5a478bee46e88-2ed3ef6ebd6mr980570eec.8.1777584188058; Thu, 30 Apr 2026
 14:23:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260426144201.227108-1-ojeda@kernel.org>
In-Reply-To: <20260426144201.227108-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 30 Apr 2026 23:22:55 +0200
X-Gm-Features: AVHnY4IfHY-QpW189HGIBjOv408u-WVPLp2De5vzk3HKKlMEGMU_6EDA8ddRWI4
Message-ID: <CANiq72mSsW2PwOb++YyHM518s=2A7TEVugqL_ufZjGuiSsg4Fg@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: allow `clippy::collapsible_match` globally
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>, 
	Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1A29C4A8355
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.34 / 15.00];
	URIBL_BLACK(7.50)[rust-lang.github.io:url];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242210-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[linuxfoundation.org,android.com,brauner.io,google.com,kernel.org,garyguo.net,protonmail.com,umich.edu,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_RCPT(0.00)[stable];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rust-lang.github.io:url,mail.gmail.com:mid]
X-Spam: Yes

On Sun, Apr 26, 2026 at 4:42=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> The `clippy::collapsible_match` lint [1] can make code harder to read
> in certain cases [2], e.g.
>
>       CLIPPY P rust/libmacros.so - due to command line change
>     warning: this `if` can be collapsed into the outer `match`
>       --> rust/pin-init/internal/src/helpers.rs:91:17
>        |
>     91 | /                 if nesting =3D=3D 1 {
>     92 | |                     impl_generics.push(tt.clone());
>     93 | |                     impl_generics.push(tt);
>     94 | |                     skip_until_comma =3D false;
>     95 | |                 }
>        | |_________________^
>        |
>        =3D help: for further information visit https://rust-lang.github.i=
o/rust-clippy/master/index.html#collapsible_match
>        =3D note: `-W clippy::collapsible-match` implied by `-W clippy::al=
l`
>        =3D help: to override `-W clippy::all` add `#[allow(clippy::collap=
sible_match)]`
>     help: collapse nested if block
>        |
>     90 ~             TokenTree::Punct(p) if skip_until_comma && p.as_char=
() =3D=3D ','
>     91 ~                 && nesting =3D=3D 1 =3D> {
>     92 |                     impl_generics.push(tt.clone());
>     93 |                     impl_generics.push(tt);
>     94 |                     skip_until_comma =3D false;
>     95 ~                 }
>        |
>
> The lint does not have much upside -- when the suggestion may be a good
> one, it would still read fine when nested anyway. And it is the kind of
> lint that may easily bias people to just apply the suggestion instead
> of allowing it.
>
> Thus just let developers decide on their own.
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Link: https://rust-lang.github.io/rust-clippy/master/index.html#collapsib=
le_match [1]
> Link: https://lore.kernel.org/rust-for-linux/CANiq72nWYJna_hdFxjQCQZK6yJB=
rr1Mb86iKavivV0U0BgufeA@mail.gmail.com/ [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied (both patches) to `rust-fixes` -- thanks!

    [ In addition, as Gary points out [3], the suggestion is also wrong [4]=
 and
      in the process of being fixed [5], possibly for Rust 1.97.0:

      Link: https://lore.kernel.org/rust-for-linux/DI3YV94TH9I3.1SOHW515524=
97@garyguo.net/
[3]
      Link: https://github.com/rust-lang/rust-clippy/issues/16875 [4]
      Link: https://github.com/rust-lang/rust-clippy/pull/16878 [5]

        - Miguel ]

Ideally, we would have an `Acked-by` on the second one from Binder
maintainers, but it is trivial.

Cheers,
Miguel

