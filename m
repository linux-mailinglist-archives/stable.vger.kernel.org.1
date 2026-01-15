Return-Path: <stable+bounces-208450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC97D257F7
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 16:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93B293008C91
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 15:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8DA3AE714;
	Thu, 15 Jan 2026 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="On7bqg4n"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9063A1E63
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492294; cv=pass; b=ZlxpZi83Or5aHSIBlfsYxjrD0u3bD6t+adCvUrwlYxDQRPFs643rshnFb/iCfRQcxwWHOA3Qeup7Zri8CkDy2ZBZ3TIhsVzzMWMSa2/o+WDmixmUAZbjzKV0hNBSsEQkdZLaoE7yD+O7/sv/jwivVWRvj9P7IrnEzYYHa4VE2Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492294; c=relaxed/simple;
	bh=5jZOHI7cz/tFkCcOhP8OROvIBT3DGTiFcQeywBuUSmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsh9QwJDPv7M1UQB/23iArKnhh9rrolGyyEWws4YAN8CEQd3k+OilWc6r5QgO9WIPS4RTMoSYF4qysQQNHt9YW2Wa4pboe6kgUSgm25XvSzjRVCIj7RMv91vLLaPp295D246iKzrbfqVclG9nkg33i+dfLOB+x0OdYqpc7cOcQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=On7bqg4n; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-382fb6d38f7so8162231fa.3
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 07:51:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768492289; cv=none;
        d=google.com; s=arc-20240605;
        b=IpRiXWzXEJlHPXX7BzCtIgfp40jG001ts30Sg2+OxLi7cKPu4TmnuDQ29E+6J4kSjx
         9UPhMhZ2omZA7jtznEFeQL7BwTi9D+5z9Xm6rDbWefOYEcSog9PJ4YjF7zkaAbuhfPVa
         oAN628QJJDy3BNoKfQ59k9ImVCdpgI3Mzb2bXmImnAWyii4BRVJDCAvHg+u8PrPuB1S6
         kvzTFTmnuj9bm2Pm1NcRtdspaMqgKzqBkyyvc6GZLkeGiFJ6VEt+GFa56KZe4BHs2azk
         J5Ub7Uq2qmiMAJOEFpCjIKlRW074tOFGY5wmIS+wMlOBto+uSIBMFEapThNe93pStVNb
         9Q0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BLbV8wG5kDIJ8frOLw6GPwE++FJ1Hb8KJgZ7vb66YeM=;
        fh=13QrNKdN8Mi/9E7QoqzzQ8iemKkvz7bNnQQHwlxFBCg=;
        b=YXhXcKd6Pdsw6Q9QQtnYm8QLGO2xiGQHps57OoXB1TE47oU01yGDi0LK5xcZO2sTaF
         E8ORl5ghToTltOHy0EqPbq9p+r+YpXwfpJincBu/8ra9e0OSTizVHIYj4mS2MCcb61fL
         HmHR4G67nztxwl7l7vur0/BDHjGsm662HfYY0sYyP5Ea/xvLRcduZ/QlFF60cTNRrtRO
         g06+YAdq5BJNIwzATScgAwJQYK5lxou+UGhs563haBvrdvuHHsaRwgUpsOBfgwZmSh77
         qorj6bVUArCRojMVSCM+5UGGJsGXxCsv9K5BfFjUDorjNcV27OlZjKOhMNp8parWkXh6
         oczg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768492289; x=1769097089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLbV8wG5kDIJ8frOLw6GPwE++FJ1Hb8KJgZ7vb66YeM=;
        b=On7bqg4nFaVRC5n/YT04mltNUNXUk7sqOTpnl1nmKxvoQAC+/+WR7ZP1ejzWOyKVQv
         XQc770ejj2kvZvXmhHT3Yg+uFnkOurB+gKxr3Mhdh7itkQXDrDWeNhcLmFhMw+RnHyQD
         3oc42JoWdt3F0ZZ6KQnZmwgyElLZ2urdRplcIyOITA3188grVNJw1qOK4o/a57ERnpDT
         Ulh/qfq68D9G2uE68UGt5M8Wixenjj77ai/fmaWm2E2PzAop0lAKW/LBfncTJ//1xIo/
         mTHkqOIsQlCU+TlHHHvih09VRxFZTxwyOnw8NO0qLni0RGYCTnWHApuuSeZSdnKYb1wI
         20lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768492289; x=1769097089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BLbV8wG5kDIJ8frOLw6GPwE++FJ1Hb8KJgZ7vb66YeM=;
        b=OYKXDp/yeHEYCpPkMhVWHZwgEr7gA75+7/KlWbA2/Q5oGe93QgCxaipiM7MChrJGOg
         85Bghk9ZuQeuQ5PXKNT6RKshXS/BTEdapahMdUYYgb3+giCGBo09cFSohuN3kywql+Y8
         LCPeWx1Iu8CGmAfv+GkYVW9F/SWVIoX8B1WmDffyRIVFwu15ayJ3zrIyuYCsgI3zsl6d
         JNswY8cQj1IfmiU1USEyXNEiExPGNnfaRRUVOjaJzTF2Isl+Pp+xqALOgXFCcPossVPd
         4PyGoPD7isZNd83LhQII3xnpZ8dJJ2j3RDBA5HcgOKzrlEhiqnD1sXbQE6CI1Mq+FQ3H
         5WPw==
X-Forwarded-Encrypted: i=1; AJvYcCX4+TxpasLPHcy2FtLWdxF/gpn9N1tp/xAm25MYfot2xDOFZ/RT+6SoDJqfLQLeJMwfOag8NLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUT+5oI1/uDUiQxU4DOdijmYlHoMDB+d87ym7SAyPbJA58eJn2
	R2qF62GlMMFZWB/bU/zap33m3gx0EkpTVHKUSYwm9Yg+ZPQ1Z7ShlBnewA/8/Ea+uH9L6saQCli
	IUYJP7IzX6uluCPm859s+Y7W8X+wbphg=
X-Gm-Gg: AY/fxX4enTdvWRCBWpao5TFpoh7JsFCnSR+Uce6zjfqTo7eeSQRnIfboScomFZlDGfw
	bsqYlrY7NAmVM+tiedovRp/6GFFOM/Tdcsa68Y8DweQy2VeR/Zy/KfJFt/5B65C3pyqHl/EgPsc
	w9Z2F/Z4UWAiMQ2b9SKRfMV1Up5KB00lai3v0hc5cHnPpnrU88++S38g1V3AtDtLcO9xWg+BCyQ
	+KwX+bP6px/eN+DhH25VZnGtcy65UdXQDJEOJnHUX8u8I1ewUHDg/dndEKzA4BfKTFksnuiPwDC
	hU3N2TXzM0wpiWdBmb0ya3/2DMiEj+9JW7hdjfNF+Wa2yEIenqaDI5EXtZ9s5NaQwQ+VWPPx9EQ
	aC57jpA==
X-Received: by 2002:a2e:b8c8:0:b0:383:5a4f:2603 with SMTP id
 38308e7fff4ca-383841a426dmr659501fa.10.1768492288482; Thu, 15 Jan 2026
 07:51:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250517085600.2857460-1-gary@garyguo.net> <CANiq72neLdtGORQ=GMsJ-mVgWscrAw4CB+_2cfbR4gtju4+azw@mail.gmail.com>
In-Reply-To: <CANiq72neLdtGORQ=GMsJ-mVgWscrAw4CB+_2cfbR4gtju4+azw@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 15 Jan 2026 10:50:52 -0500
X-Gm-Features: AZwV_QgmS5MREKIO5CYv0cuexmqdXCEp7abbRQSIGNVpHXpWKf3VbWEU7Y4RQYE
Message-ID: <CAJ-ks9n2pXZWUePZVNbR_dtvtdjZ0uW2NknkA69UsFeUiCV_gQ@mail.gmail.com>
Subject: Re: [PATCH] rust: compile libcore with edition 2024 for 1.87+
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, est31@protonmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 5:26=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, May 17, 2025 at 10:56=E2=80=AFAM Gary Guo <gary@garyguo.net> wrot=
e:
> >
> > Rust 1.87 (released on 2025-05-15) compiles core library with edition
> > 2024 instead of 2021 [1]. Ensure that the edition matches libcore's
> > expectation to avoid potential breakage.
> >
> > Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned=
 in older LTSs).
> > Link: https://github.com/rust-lang/rust/pull/138162 [1]
> > Closes: https://github.com/Rust-for-Linux/linux/issues/1163
> > Signed-off-by: Gary Guo <gary@garyguo.net>
>
> Applied to `rust-next` -- thanks everyone!
>
> (I actually applied a couple days ago in advance of Monday's -next,
> which explains the following report)
>
>     [ J3m3 reported in Zulip [2] that the `rust-analyzer` target was
>       broken after this patch -- indeed, we need to avoid `core-cfgs`
>       since those are passed to the `rust-analyzer` target.
>
>       So, instead, I tweaked the patch to create a new `core-edition`
>       variable and explicitly mention the `--edition` flag instead of
>       reusing `core-cfg`s.
>
>       In addition, pass a new argument using this new variable to
>       `generate_rust_analyzer.py` so that we set the right edition there.
>
>       By the way, for future reference: the `filter-out` change is needed
>       for Rust < 1.87, since otherwise we would skip the `--edition=3D202=
1`
>       we just added, ending up with no edition flag, and thus the compile=
r
>       would default to the 2015 one.
>
>       [2] https://rust-for-linux.zulipchat.com/#narrow/channel/291565/top=
ic/x/near/520206547
>
>         - Miguel ]
>
> I also added:
>
>     Reported-by: est31 <est31@protonmail.com>
>
> since est31 told Gary in RustWeek, and we discussed the patch there.
>
> @Gary: I hope the changes are OK with you (I can put the
> `generate_rust_analyzer` ones in a different commit if you prefer).
> Thanks!
>
> Cheers,
> Miguel
>

Hey Miguel, regarding the rust-analyzer changes:

I see only core was changed to use `core_edition`, but other sysroot
crates (alloc, std, and proc_macro) still compile with edition 2021
despite all having been updated in the same upstream PR. Was this
intentional, or just an omission?

