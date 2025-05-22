Return-Path: <stable+bounces-146064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFB7AC0921
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 11:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5A63BC05E
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 09:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C261EDA3A;
	Thu, 22 May 2025 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+D+mimX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE181C3C04;
	Thu, 22 May 2025 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747907762; cv=none; b=Vv5d9aT8nJ8L9lc8BtXbfFxx10xT0UPrJh78E0XQ4gUzutoIeFVwa4I4yDp9JR3hb8oE90jrwjIOEAu77mV4B2ZOe3Dk39BobPNn3vVitAElvbxsJs4Iet8cImbXPYwy4+cGS1MjsgBEUkzq9VI4yH/dHsH4gt2LCAytnLXq0QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747907762; c=relaxed/simple;
	bh=zZQDvy6Qo42/2W4QwFrXPUZcYGV2s/FRajduLAvDQCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+Lfgf7f+44C4TVVhp4Xw/vWDZdcDqaZht+lUnUSxf0IEDHBup5gh3sA7xFzuCufKkrkvr2fp1v/kMDMoWTyuYRrLa9FckJuGzgdfB+SekWcTmPgcg3tLcnHlVfa0IxiL8lbiw4D54nB2u3NrBydgY/hXqSVFQY3eSRGtnSUji0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+D+mimX; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23179999d4aso7267805ad.1;
        Thu, 22 May 2025 02:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747907760; x=1748512560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G09KB2onuKyHVmfE50lXFfjm4aLc9EdRitHUC4rY5fE=;
        b=T+D+mimXQ46By4fAZkutHRPKovk9gCqPHKQto/nypip1KEu2bvlhtaQwQ0s+Icz/do
         mQjSAbdXsOflzFt4QL73H5lA03x4MYJ8GChmX0D8p4vRrC1eyZ0W0zNjYBgSCYmFo2EJ
         Bu5Yc00O/Y72nN+aGZFxs2QZq0TDOZbcVC5sjk0dKysdhErTP5zshz0LGHk3oRZ1lqv3
         C4sAufye0lSEgHL7PdZwXn6PKvbKyBypX67v4svSpiyL7g3vStdjdxdQIxgWbaJYxEfw
         bPphNio599WbK09AsRV0IhhrmQgk0lXGHYjAyQGDDJ03F5QL3EYMXq9EXqZJD1C9jx8O
         Ky+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747907760; x=1748512560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G09KB2onuKyHVmfE50lXFfjm4aLc9EdRitHUC4rY5fE=;
        b=r7loNg5bKTSHA2YiPiTtu+zvmy7jPC2j+mXYzFRnGBUf13NuqHK/fmLkqYBpum50O7
         DtwdeYtI5LFiM7XhylwEFVsQToviR2XH1+NuDracaWCAzKyimrEHMtWV/m6tugCjXKJf
         2aZxsMpW9JSGnU51I9AcsQyOsyo9iSSq/mJwgbTSwAU09lc5z1x5fj4qvwL48nO1tPDu
         bCG8DsQMQd0/luz9EvaFunlzE+Pg7v7h4H4cDqJCTwj9uPOHY0iXnX8z0EL0UE5IQBcU
         EswDELAW7+J1oXNSav3wGhpEkimSunEKWEme9nK4D3jycYtSWcf6PM7RNVTvyXaOPf2W
         kplw==
X-Forwarded-Encrypted: i=1; AJvYcCV76uNjzKErdG2y3L9Xwxh0kVptu3vvU8+GQW/5TeXsnHc0XNliyf/GBM8L7Mr1LwHeG2iKP1FUuXPo13pG4A8=@vger.kernel.org, AJvYcCVev0TBH15CS65D1FdHkCcklitwgDHiWZi0q2/HWYnYyXoDzjrkpHO0E6bMIT2fG5aVMa+V5VZ07PsnzhQ=@vger.kernel.org, AJvYcCXAAE4xFgPCCUPQ8YW+Iu5PRofMmUwawi1aelOQW4nNsoYSaOpRlUfxPr0g/HhcviiZ1eQaNbAg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9TiuonZZzRH5IC1/llKRUSawtWpE4GR9Xqsu5CfVnZRSmTD3I
	b3o/hXGugEQuFWR8MViLXavfE3fonuCm0+uvFUKDjQfG15fHBG/kaASUqTvCCnjg/Sb+1ZUGXlg
	D/Io2kvGvuP4h/Ui8xGkVh+xuIQmRzUA=
X-Gm-Gg: ASbGncshv4oM9h7V4pvwppUa7WK1qD0StpaPvqTa7cdfLYlUkF9QiyU7RbrWfNBUhoj
	C7OQ9yKKVuJFDN6RnFCxWjM9nzVi0iOQ5oMIvTZa7Pwvi5m1pFdHgtE8I5xQEdcJnRp8jT8WStP
	JpFc6jrdAOgNFgFMzAnGJHOp1GD2OBavcZ
X-Google-Smtp-Source: AGHT+IFYIWC+n60Jh+NK0oH7ocg0CH8rKVpjvpng/mDoRMQvt9OfeYljH/Z2woY7cuOpizBcWnXFwX5FdQwCp7RVY2c=
X-Received: by 2002:a17:902:fc48:b0:224:88c:9255 with SMTP id
 d9443c01a7336-231d438c7f1mr136853785ad.3.1747907759865; Thu, 22 May 2025
 02:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520185555.825242-1-ojeda@kernel.org>
In-Reply-To: <20250520185555.825242-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 22 May 2025 11:55:46 +0200
X-Gm-Features: AX0GCFt5zXlczwrJWYedrmHdatCH6TtH7LDmwwL7WwbulsfmTEouK13Fcs43C90
Message-ID: <CANiq72mPJDA55t=TGz3wFBBch9iPxjQ0V_CV30XR6XijWnh3dw@mail.gmail.com>
Subject: Re: [PATCH] objtool/rust: relax slice condition to cover more
 `noreturn` Rust functions
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, Kane York <kanepyork@gmail.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 8:56=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Developers are indeed hitting other of the `noreturn` slice symbols in
> Nova [1], thus relax the last check in the list so that we catch all of
> them, i.e.
>
>     *_4core5slice5index22slice_index_order_fail
>     *_4core5slice5index24slice_end_index_len_fail
>     *_4core5slice5index26slice_start_index_len_fail
>     *_4core5slice5index29slice_end_index_overflow_fail
>     *_4core5slice5index31slice_start_index_overflow_fail
>
> These all exist since at least Rust 1.78.0, thus backport it too.
>
> See commit 56d680dd23c3 ("objtool/rust: list `noreturn` Rust functions")
> for more details.
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later.
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Timur Tabi <ttabi@nvidia.com>
> Cc: Kane York <kanepyork@gmail.com>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Reported-by: Joel Fernandes <joelagnelf@nvidia.com>
> Link: https://lore.kernel.org/rust-for-linux/20250513180757.GA1295002@joe=
lnvbox/ [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` early so that others can benefit on -next --
thanks everyone!

    Fixes: 56d680dd23c3 ("objtool/rust: list `noreturn` Rust functions")

Cheers,
Miguel

