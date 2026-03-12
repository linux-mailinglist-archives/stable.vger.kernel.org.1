Return-Path: <stable+bounces-224816-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOUuIwZysmmuMgAAu9opvQ
	(envelope-from <stable+bounces-224816-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 08:57:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD1326E860
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 08:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FA0230292C4
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 07:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166B73B7772;
	Thu, 12 Mar 2026 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ubq2Nm2x"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79653B7744
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 07:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773302269; cv=pass; b=H0GO06yGbpMZqDIv8AXIomeLPMa0W2h1wK/UVjmf9tOc21iIDKHsJavrAp0BDj0cVrCjFUXUxTLcO8odN+bWkcy9lka+f2g7C0o0IW/C2H8oG6Q7aABgMoTVSx++lG9YO8UW37qwAR/zNFE+R373iQ7vVhrC1Veco5085hOd+hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773302269; c=relaxed/simple;
	bh=b3927kgBfFIgfwwOc5KyVGPhOpw7Fya38ycFO4gG8QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRPqJEe69gygYgn8XNqEWbLNW2aGk02OH1XYJbyMc2sToHeHXuUZpBI/ANm0T0rEWoqvlhdQno70At3J3khTm5pQEkQoI6OavrhSemUDP0Mt8cuNNQEnVSUnCVaJS5rsI+W3jty6l5rfhwvxpz+35W1YdayY/c12JaNFGKez7/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ubq2Nm2x; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-128bae6a35aso35395c88.1
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 00:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773302267; cv=none;
        d=google.com; s=arc-20240605;
        b=NG8WjXLFrd/8OQgN/3QIT9s14v/AL2wqxr3KNkccS5vDKYHROAAsHkJAaFrmh447qv
         ulsqaqJ3Ykc/jH82iFGRkvNYlIa2gi526I6N1p0RcU40wOVS/ZcbsYZmr0UkWj4PjmTc
         YLKWC132WEKMbuVaQlDNjsRwix/nqC92iygOWkFHFA0qcLIDnmv+Nn4FHlONZlj9SsMD
         ARb1UzlTMh5WFQE8PTBA4LhSB/JVnPM+7acdCZDUxgfqfED8pk4O0tfXaCaJL2lUIJ9Y
         cC/Zvz4hGxH5BqQo5ysFcfvKkQzC8nLNGVwGV0ewfz7KTDNBowTzqaTlwQftPtqcEA4/
         aHJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LAIZYi1tx+DAT8oVifXMbEn4vtNErwbW0ZEBgH3QCzM=;
        fh=GECqONTJ1i0f4eYQD4PINkf2RZ3tOK+GGXRgcu3FZGM=;
        b=MhvutU7Mii+PXVsKiAMDNt0rkW6wJTPF50ptfNrAqUx7V/n550aStqC2zboYmp4Xd4
         RvOJs8LWP3t+8xbs62aDX6DX5GJY5loogYhrXUol3+F5Xn6d6gL8GbJu3DOyiKlN7hiw
         TnDg6r5UPy50n8ya5yNk/iyuqRCgWE6ClrqxjiL3P0P94fvtmW8MNCQfUdIZX+TdCsON
         IbV1GSMatIMvHRjW2TEu4s4ab0hi1/qoNxpB6IQet38gyH42ippMBvlSEKycSAks/aBo
         lWJzkqtQsfpOeT2/U10vRveuqhAiTgwDucswLZ4V+yKPCGzacLXBi7kNGIc6iEGqu9Bf
         tV3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773302267; x=1773907067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAIZYi1tx+DAT8oVifXMbEn4vtNErwbW0ZEBgH3QCzM=;
        b=Ubq2Nm2xXPsbIkP8qJc1a3Pi5lIxF1ERW8y1eYJJraUeYWtu6TSZHc3/SNya6jKYRp
         KLPOkzMUpDjcj7TWE4XCiHdONrVrQf12qc1vwkjdhS3xeK8TevWxWJv165i2ASBcBMcC
         4WaSUuwuYT/wcct9sCC9ShBmsOE3ZhafSYfPrLTvbecCPQY6plbnY3zjnsXYXLo5Q4rC
         QY3JP+0/8N+ALtIuuWxra2vPLP9WlR53tZBPJsVO5R/aswWlhMFgGQ68muuy/j8SOxqu
         ZCGx6ds2J4R+ejriE59iQPRSVtrtM/o9R5KwOZXyllxnx1ciosyofrAYa2GWodnUrov7
         c5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773302267; x=1773907067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LAIZYi1tx+DAT8oVifXMbEn4vtNErwbW0ZEBgH3QCzM=;
        b=RPt2cFCZt4vUUWizxXaQ7SvC0LO0W+VZro7M9IbR9+asdlacbiBv64B9+UEMbMX2OO
         i+lSroBgkos/wVssOTbFHvdhsOCYPjgm8Js9g7G2L8osq8C7FRPtchuK1/eUZj9O9fns
         NjHCCeHnUOrSvI0qOGITSG0NGb5DS1YoO9nQVu40n3OV4ELHKIYvFLFbgdSpfFIltVK/
         aQ3C4vTxsOr03QQBvxV7bMBuUppyHtawRBH3X0kbSlAYH1HVk1UgRQn8EutfwMyshwMj
         bNh04XEOUSLh5w8RrIOFKaLTeQp5tdCx6JZ6cvCtv+t8iyWV3SPcudAjXtI2syHcg/hA
         gGPA==
X-Forwarded-Encrypted: i=1; AJvYcCXZZ+JkwMs083/NRmTYmNJlr9HCt6zI93EF8rzcC4iu2EATFE0XjGx5bsLkPy4a5VVKkenNqOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYydxxjokgfNQzOCRCIHINPHZhN8fwdmb2wVo7Rh/HrdZJKJw2
	z0jVpcvV4JmL3D2Ee1zOykTZpmK4oGIVywqTSkJylQkMtQPGM7qjtmhc103trjNH6NR0SgMs8LH
	BWL/QnQSjq0LyA7ucdTjsnMqQJF1EL4M=
X-Gm-Gg: ATEYQzwTgoITnnK00LAiWt8OJBfMtDZ+KF3xuKAbUe4At2pMn+G3Ry+FoW1dUQbfZPP
	DK5zwzpDS1DLt9GLCYuGT07M2pcQ+4iuFH0HpbpbXwoyfQYafMzD7XKSpHIxWbJHZJiiafQY4IO
	s9L4YbSrnqLWKR5A/KcnxX/Wc0WKdBaKMg8b57JpAfewCbY5rQwd+HDh/DyBjORVV6sfUHd5p8P
	gxJwVhzZeICwZyCxvC607QEJhE+vqVzIQcJyrY1f4HbOOWskXs3Hg+CcHJ7I00pW71mNh8/G+9b
	PKSOgZfc9S9u4/faa8ciemMz+M+OXa/SDd+m5WfpZ/E2L1/3Oj+JpyDUGUTL+jDqoKUIsF/x486
	akE7qpEDL1qgj7OX0E4p9chM=
X-Received: by 2002:a05:7301:2b06:b0:2be:2b8a:9523 with SMTP id
 5a478bee46e88-2be997c4881mr290640eec.0.1773302267434; Thu, 12 Mar 2026
 00:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311105056.1425041-1-lossin@kernel.org>
In-Reply-To: <20260311105056.1425041-1-lossin@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Mar 2026 08:57:35 +0100
X-Gm-Features: AaiRm51Wij-ad7XIJL96sGShdoLG-JeALKtfG2RMEOYfpUaWxPBGVgxOuX7riXU
Message-ID: <CANiq72kk5_wzA9izJ3YPWUcQGiEUQmCif+iqFfwK9b_5mq145g@mail.gmail.com>
Subject: Re: [PATCH] rust: pin-init: replace shadowed return token by
 `unsafe`-to-create token
To: Benno Lossin <lossin@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Fiona Behrens <me@kloenk.dev>, 
	Tim Chirananthavat <theemathas@gmail.com>, stable@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224816-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[garyguo.net,kernel.org,protonmail.com,google.com,umich.edu,kloenk.dev,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFD1326E860
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 11:51=E2=80=AFAM Benno Lossin <lossin@kernel.org> w=
rote:
>
> We use a unit struct `__InitOk` in the closure generated by the
> initializer macros as the return value. We shadow it by creating a
> struct with the same name again inside of the closure, preventing early
> returns of `Ok` in the initializer (before all fields have been
> initialized).
>
> In the face of Type Alias Impl Trait (TAIT) and the next trait solver,
> this solution no longer works [1]. The shadowed struct can be named
> through type inference. In addition, there is an RFC proposing to add
> the feature of path inference to Rust, which would similarly allow [2]
>
> Thus remove the shadowed token and replace it with an `unsafe` to create
> token.
>
> The reason we initially used the shadowing solution was because an
> alternative solution used a builder pattern. Gary writes [3]:
>
>     In the early builder-pattern based InitOk, having a single InitOk
>     type for token is unsound because one can launder an InitOk token
>     used for one place to another initializer. I used a branded lifetime
>     solution, and then you figured out that using a shadowed type would
>     work better because nobody could construct it at all.
>
> The laundering issue does not apply to the approach we ended up with
> today.
>
> With this change, the example by Tim Chirananthavat in [1] no longer
> compiles and results in this error:
>
>     error: cannot construct `pin_init::__internal::InitOk` with struct li=
teral syntax due to private fields
>       --> src/main.rs:26:17
>        |
>     26 |                 InferredType {}
>        |                 ^^^^^^^^^^^^
>        |
>        =3D note: private field `0` that was not provided
>     help: you might have meant to use the `new` associated function
>        |
>     26 -                 InferredType {}
>     26 +                 InferredType::new()
>        |
>
> Applying the suggestion of using the `::new()` function, results in
> another expected error:
>
>     error[E0133]: call to unsafe function `pin_init::__internal::InitOk::=
new` is unsafe and requires unsafe block
>       --> src/main.rs:26:17
>        |
>     26 |                 InferredType::new()
>        |                 ^^^^^^^^^^^^^^^^^^^ call to unsafe function
>        |
>        =3D note: consult the function's documentation for information on =
how to avoid undefined behavior
>
> Reported-by: Tim Chirananthavat <theemathas@gmail.com>
> Link: https://github.com/rust-lang/rust/issues/153535 [1]
> Link: https://github.com/rust-lang/rfcs/pull/3444#issuecomment-4016145373=
 [2]
> Link: https://github.com/rust-lang/rust/issues/153535#issuecomment-401762=
0804 [3]
> Fixes: fc6c6baa1f40 ("rust: init: add initialization macros")
> Cc: stable@vger.kernel.org
> Signed-off-by: Benno Lossin <lossin@kernel.org>

Applied to `rust-fixes` -- thanks everyone!

    [ Added period as mentioned. - Miguel ]

(We will need to resolve the backport for a bunch of stable releases.)

Cheers,
Miguel

