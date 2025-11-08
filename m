Return-Path: <stable+bounces-192765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEF7C424D0
	for <lists+stable@lfdr.de>; Sat, 08 Nov 2025 03:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9097F3BA09D
	for <lists+stable@lfdr.de>; Sat,  8 Nov 2025 02:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73E0231A21;
	Sat,  8 Nov 2025 02:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZkXb17V"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE0134D39E
	for <stable@vger.kernel.org>; Sat,  8 Nov 2025 02:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762569073; cv=none; b=F1LO6WzLkmq83/SDKc9qzB8m4PvEFxA4k6hliU3AhCyth/1lWHZp+OjFtHI+CPXFETMPySR7YxynYlSxSWyQkR816625mBdTRz166W8SBfOq/Vo1AkhQCRh+VJJnEJghLPy7Kge+wy5G9TurM/kor+3c7b7PyJMFamnNS27+suE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762569073; c=relaxed/simple;
	bh=hEsds1aJcMa/MFnGEl+oWU8IGfV52JAmFi/ogcjALRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJCFrEpyIhnmc7ohSKK78nFRoKGjwiCoBgB8luXZ408/9NmcfN1AsCkPfOUQd03iEaZRIZyXb2jwYGERAXUAX63Rgb72ZzKDbxBu3wXk5VyEfd/8ovTqZ1TIAQhE4WoIV88nLgXOGkSlYDlZlDBosPBeQrfxRWnP7fd7/GCi9wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZkXb17V; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-340ad724ea4so140404a91.0
        for <stable@vger.kernel.org>; Fri, 07 Nov 2025 18:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762569071; x=1763173871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ywt5KnXkAWuPtF4O67B6+CrKeKvSZlIbIOBaVjdLrc=;
        b=TZkXb17VDXSi/hdNX1nnsUIBUikCDSDYabE2oBnc3ou2BnHl91qhrr8ryuMls+eW4+
         iBXg+fLjOHRcvN1gpg3FLTPwA+TPMNItQ5PAdWwL6eO/+P80WsaqPG5lW0A/6WkRSK6i
         G0uqVqIw0XwaQyN+EFtNoxWqKoEq2gH6qLe/3FqLdOVnIU2YOKl9HUQ4qvaE3EYaoNvg
         BJUKoX6qqzMmXobdQdas2gzy6c/RVHzxcq5XErBAC1g3FACKOP14RVuGsm23EvyndIyz
         d6LBl2nTzq/foUEHxJLTbB6OLk2HIPjAbMBL7I6bc9mns0h52vgFl8rCnvytZPYOcoji
         X3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762569071; x=1763173871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Ywt5KnXkAWuPtF4O67B6+CrKeKvSZlIbIOBaVjdLrc=;
        b=hgU2jXJQFCNCnR7AMO359NtHvKIwalfrJzMExMruJ6peBjlZVC5j/BWAfStqgLKwt/
         X5Ri5JlQQzXu0kv+nqbtKDiAeBmDkRy5fOyF82BVOfbBk3I2+ZMc8oRrKtFo8NNB3wJG
         xO9GXykKawQJrLuoueciIIa2z8BlbqehzM0XBXe3zzT8QG+hKNK0JF6eZpZCON2ifG3+
         vVu+rUKytcqAec1nblkwYgISLDwRj9Px930DDyNKa+U10hb12JPt0mURuY/ayhF4+mxq
         KX+gQmS1nT28Xe5enOR1QoD6Ad2q3hYee8Tn7zx7SVtTnCRjxdL8ly5do5uxy2E3mVen
         wBeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMEiJUpTNUV9gSBHpgLhvdqZ34LtNJeQh+koq+RqcQQfEFVJZM/7ISM8bwhZqAjKDWTGZc0Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiBZpWgqMQ+UiFatFxkYHkIQxL2OYUdkO13dNVqVeCmjONPrGt
	EEN8onTQSFtZ88ylF0v4vyqp35yE5tdxygY8+7Xn4kixGetZVN9yVJXq9K9ntVB22wSDAZKGfxp
	wNYBM6pXOJN+vDE5Q50nUM44O3qbkGRk=
X-Gm-Gg: ASbGncuUKH08UmlEDk7qGLt2cMvp932AfWTcFxKJQuEjA4NbaBZWRFSQD923VifzYj9
	2dOk0xC9yhuUibTcQMARS7MRcjAAwo5jIbVRvcbv00rdqcBRE0YQY8Cn0tUbYmzHo3gCjsirKZd
	Gdf/exAZ4hKqPfSgPD9J1XaOuwWY4MIV+riiLv/lmw9ECVC2DEOvofSu09NMz5nDFPNkIEUjsTe
	ixUgkUPoykYv6cFaxYQLHN16pA10BWyljlQeWxi+nQWz+8tMm6eASPrGTEWCqmLrFjKo76B6Fam
	mlWi1BrWmXVUUoyQeFBcItv+Xs/IjiNsdFVCkTe15AlSddYGiAWEnFAdYTso7daA7HtG7NVBEVN
	fBuY=
X-Google-Smtp-Source: AGHT+IEPt/zum4mIPzur6pOWm9ugmaOB4ZnZwdF37jH/QJbMUq5i1HmGSC61s/z25m7jSEylTziMZI9njr8XmEb4iEk=
X-Received: by 2002:a17:903:ace:b0:297:e67f:cd5 with SMTP id
 d9443c01a7336-297e67f0dc3mr6100935ad.7.1762569071389; Fri, 07 Nov 2025
 18:31:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251108014246.689509-1-ojeda@kernel.org>
In-Reply-To: <20251108014246.689509-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 8 Nov 2025 03:30:57 +0100
X-Gm-Features: AWmQ_bntWx41R6dVeerjev8Ne9qVeKQ30TdFKSebUZNEnjznMYZ4D9bO5nuNd7o
Message-ID: <CANiq72nKC5r24VHAp9oUPR1HVPqT+=0ab9N0w6GqTF-kJOeiSw@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: skip gendwarfksyms in `bindings.o` for Rust
 >= 1.91.0
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 2:44=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> note that `CLIPPY=3D1` does not reproduce it

And obviously this means we have to special case this one too...

    $(obj)/bindings.o: private skip_gendwarfksyms :=3D $(if $(call
rustc-min-version,109100),$(if $(KBUILD_CLIPPY),,1))

There may be other cases that disable the optimization or similar,
plus we may have other small crates in the future that could also
suffer from this, so it may be best to simply force to generate the
DWARF with a dummy symbol from that crate for the time being as the
fix:

    #[expect(unused)]
    static DUMMY_SYMBOL_FOR_DWARF_DEBUGINFO_GENERATION_FOR_GENDWARFKSYMS:
() =3D ();

With `#[no_mangle]` may be more reliable and it also gives an actual
exported symbol.

And then later do something in the `cmd` command itself or teaching
`genkallksyms` to auto-skip in cases like this.

What do you think?

Cheers,
Miguel

