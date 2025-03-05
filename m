Return-Path: <stable+bounces-121119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F82A53DF2
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 00:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73B43A43CF
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 23:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FC520B205;
	Wed,  5 Mar 2025 23:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y17ZoXbA"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95E81F7076;
	Wed,  5 Mar 2025 23:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215765; cv=none; b=LLPHlDkcEH8JYVYs5hC2fJwPt1DFd+wI4b95zLiqIx81Rmd/hN2hwyJXcAz4J0r9XvMaz2ZYEM67Sk9+Nm6DuQq0OAesr8qKGRTeBa1heUXJriVXx+kHL53ybVqGqzDAByWrUZZxNd/jDLBOmUIRZwonKEJBjTV/FwJ6AfxWAWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215765; c=relaxed/simple;
	bh=Iao+jiYlJurNBU+Jal+YJXayXPoB55IWkVHQUQFmdYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rz4uYkZGSOTDUJxw4xs0tookdVUqKxKLCqBPeEaGHmtAv40sl4ePH2WdN5qEVclDRth6v71VvejWBN+fHjId2q5gceTMxKNhWMgjvz5RN2WtQvh+mfykIAaa46PCpkJvSqfZYTOYZfFW3W56bL5/Dypt8FoKjRicgbDPq43HcvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y17ZoXbA; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30b8180f111so2351fa.1;
        Wed, 05 Mar 2025 15:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741215761; x=1741820561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izWOF8CsHky2P/9iHwoyxsx4mkcmRlDtGIMSFLIO56U=;
        b=Y17ZoXbALpGJUzYo4WxuwGrSxK2RAdiINqlvNmk8gDAL813p8xs8xoLal3fBxoytKD
         poVXsLgIOYCiGDOP4H885YInbsBetEgp4bSyXu/+Ek7wpTvGb9yMZmSpcCK5u7IsH6Mb
         Bwv/K7toL006XSH6YKlca5GfXbqrHFPJU92M8x5rbRdDu1tFE4O7fEGLe3NNhpnbmpjo
         ysn/h7bCWiz8j/kkHWF5tnW4AxUEmoB7V+9XxHMjFe0rTBsGOFQCsMR2tQNihCVyDLzR
         raExyDwTJ/VkPDH7/szT8rgzI629iFCxJoNench2kl+LgXTNGhUwS1cgVOYK5R4qsy99
         Pypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741215761; x=1741820561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izWOF8CsHky2P/9iHwoyxsx4mkcmRlDtGIMSFLIO56U=;
        b=KUsIMbF+iT3ljaentuL9OqB1AMX1MmsbwArTU87xztsaR9xxyEqwRGBELhHOWwzZ1H
         qpJr3GdZmF/TSVs7yBmpkNMdEVLhR4mB2tGd2ykI2Dn9vNHc+4fQWzbJ74BZDlE9+xRI
         huh3pzhfhzlaJkPz9kTC9FM43qsEjIPxpOPD3BEXLUADuf9qEjR3nFcY7FYZwxI8fMtf
         rKmXRgBx2mmvqLtF+OL3po9WvLNV/z4r243fKGj1/i36LptLNDwwCmj9zq3WgaRLKXJb
         f0g2SbFahM+GyUqjro+U3rSjfLAbWUZZ0BHP1/+TGuCYEnHCkB+VbSwJuetKdekYHrjj
         5cSg==
X-Forwarded-Encrypted: i=1; AJvYcCV/sxGDtMGExsgMdeV/jQTF3d9iK2VzleAZu63RBteR5IaVkokHVOXye4U7E7/DIAkyhG8K/Hyim9fOiiw=@vger.kernel.org, AJvYcCVw899O4/IR4zlNnViG0yE9UwalyBNYY95ROOkTkaZa2NJsP0CKPpgUZmQZBzp1YnSe++7Akrz9@vger.kernel.org, AJvYcCXOYVLCS311pWcGH5tcJRHnMPHWee62cqbtD0oJe/DH2uPMivFZ26DVmnthY9/8d07RKTx9njJeZuhvxt+iSOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWzr7B5GKViQTjK2Y9HT7mIHP7RCpO/8vFaMMXUZErrApnc0IH
	BFvFGXKRwquSVTlXWoYJsz69/RiFiwkXZoVDP8DTwwhVHPvBwur6Tb9DUfIdkOsBYUW8fhgnQk0
	xfRDQU9zlfytRq7Oa6gTTnBsOumw=
X-Gm-Gg: ASbGncsSPd6g1uNVuuj1HI774aQs+VG0D8wSPU+revkELeuidjO8/xtN7mGF1Y7vfXq
	l1KRbtgawRHynrKZBkr1Eop5psooC1wPhL41p12Sc2Op2RX/eHrDMi0jIX5vF7hMxD/E5Up3kZH
	Gu4nn7sh1DL/3EKnTKcuTIUjUkIA==
X-Google-Smtp-Source: AGHT+IFgtP257f6CJPPlGgp0Mz4N6wXK4lbpecY1MTmq++5kQnP+oXyBJShSGDpA8ViHYOd+XEJ/nd9uaG1NVW6qMNQ=
X-Received: by 2002:a2e:ad83:0:b0:30b:bdb0:f083 with SMTP id
 38308e7fff4ca-30bd7a4f453mr7462081fa.4.1741215760401; Wed, 05 Mar 2025
 15:02:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305132836.2145476-1-benno.lossin@proton.me>
In-Reply-To: <20250305132836.2145476-1-benno.lossin@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 6 Mar 2025 00:02:21 +0100
X-Gm-Features: AQ5f1JogUvU_Wn9QEArgNWTh9ZFR7qOXnwwWFHmkzJXKd3bHMMqjcCK2czztXSs
Message-ID: <CANiq72=LSN3GuhEsnRYY7DrGNBvQevAjvj8q9aoHRHffwMkXiA@mail.gmail.com>
Subject: Re: [PATCH] rust: init: fix `Zeroable` implementation for
 `Option<NonNull<T>>` and `Option<KBox<T>>`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, stable@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 2:29=E2=80=AFPM Benno Lossin <benno.lossin@proton.me=
> wrote:
>
> According to [1], `NonNull<T>` and `#[repr(transparent)]` wrapper types
> such as our custom `KBox<T>` have the null pointer optimization only if
> `T: Sized`. Thus remove the `Zeroable` implementation for the unsized
> case.
>
> Link: https://doc.rust-lang.org/stable/std/option/index.html#representati=
on [1]
> Cc: stable@vger.kernel.org # v6.12+ (a custom patch will be needed for 6.=
6.y)
> Fixes: 38cde0bd7b67 ("rust: init: add `Zeroable` trait and `init::zeroed`=
 function")
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Applied to `rust-fixes` -- thanks everyone!

    [ Added Closes tag and moved up the Reported-by one. - Miguel ]

Cheers,
Miguel

