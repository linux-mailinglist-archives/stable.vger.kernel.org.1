Return-Path: <stable+bounces-144888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E9BABC51C
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 19:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238A07A2CA2
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 17:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EE42874F8;
	Mon, 19 May 2025 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7vPJq8u"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3DF1DF963;
	Mon, 19 May 2025 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747674182; cv=none; b=JSH2EiEqC7Ke9kuJuCKXIBSmgv1cHlvFV9F/wytGsmPTnH7J1M8JJwc35LdqwAERVBGe+A/F74sCk/XIhMLH1WS3A/1qLjO/GeiJjFGJDL0qeeaWDJPPL7LLIMTrrwz7FT0LaTrm3Bwqwo7QSrVRWegzK87hW8XOIbDfl2YO+fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747674182; c=relaxed/simple;
	bh=dLkUJ3SdmyWzypJshGqqCuSQZ/CXnDd1H8MEMaxlk4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=go0idILoSExK7xv5B2f+h/9dpEJo5VKWfL0PMqh4obwCe3Am4T0xpBNaQGNAWOs6UFC0yE3fTu1DWRqTNaDl83sI+aefHWZnA6y0hBc/SbL1VcDbzs3pEpnYJTqr42nRgJ+2I5XMakkYuyXvj2HxBy9giz889Q3NGd6EmW8+zYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7vPJq8u; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22e19c71070so7750245ad.3;
        Mon, 19 May 2025 10:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747674180; x=1748278980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLkUJ3SdmyWzypJshGqqCuSQZ/CXnDd1H8MEMaxlk4s=;
        b=D7vPJq8uLTS77eJMBVVjfKXLvbtBDqQXZJFN9jvYyca8ORMjH3Khdskm9McsmEMCvH
         SJDY0O8EkwPIf19Q4Jgh3q6AuwuifOytn99HzGUkA03wP9ys8g8534PQlTUmXqU/Jkjf
         j9+NLbhRUW0EumCm9pIGkKcf3wwTy6ZCW60aXKqtDJCqCz51obhGJyUbQQoW5K6ez52M
         8S7NevuHV1+B8AM1Zo/qDusSEivw3Y47P+Lm2cLexqJawfUZ468C1ihpEJT/Czutiosw
         efIXoGKVd8SULufoBnA3OayuEvi5EGrWkrXaPnr4zbli/3+2t7+EM+AtSVYceAk4nprS
         4jaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747674180; x=1748278980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLkUJ3SdmyWzypJshGqqCuSQZ/CXnDd1H8MEMaxlk4s=;
        b=sjWU+nF+4DNvnpCCsDwetyp2VDsD9s5nizR4ngSrNzGh3qH1/mZ/IknTNxHnUat56J
         Fiz6M5kQlAsS+YKSFH92h1VJyhn6PkS+gvV4XzHd2FG5DWN2cjBYMVL+Zvhr3kyjBYiw
         neJAmA7DsQ1gIlpbOkE0eGaeu8VOq4Ksh+OJcdu8+94aAp/Zg3kkJRPfYQPGoAnNzTgU
         larGBaFb2jdQpHWokYRHTQr1mvwj6mkj6Qhd0cx2R+W7RWEZtLGV3tpT+qPBvKydrMI4
         UWW8AMWkM1xKvfuV/SKGE55+9fjcBF0nam9jogIYJfiAF/KS3bODTLrznJMLOGN/ySlf
         q4RA==
X-Forwarded-Encrypted: i=1; AJvYcCUNCF4xhwVcBK2wPUdliGp/A/mVeaQ3JEquq3GbraN/aN46Tbzvz6jIop8Jd+0iDymx7LoTD7CN@vger.kernel.org, AJvYcCVACHazgQB0fAbFWtpNEY/8zAnKUcyWXvPThWcK4A8PBLD8eurJJ2P+ZcX0TBGAC0J+KoxmwYqx8LGmVNAaIMU=@vger.kernel.org, AJvYcCXTBOgwKl9zs6HTdmUuant0Lu7qHCrZVGBVMDvxmN9DVlpReO+gVdJjaNdBJB2zhddu5xGyCMSnwMjx+e8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjlyRiPImYMDE0G3OrWofOHB/nkKy3O5nxcEeYiDHKLaMm6kqK
	+MtKA7sWXLrscNQ6MUT+Hl0obIkGQoRg4UTzFnT6EaIZUuyWtDbp60kTgyvVN6s9Y6//uWYeDaV
	craID05992Fizd8rM8pRg7mzZsWyq1ns=
X-Gm-Gg: ASbGncu53POEL6yiYuGMWhmFijJh3V9wkoOcd3kAEPcGg7Ciqx397edDrA43TFISkSg
	KdjFFhGhdZWeIwq3BC2IaCXTY5ehsiOADL7kZlHmPExEWgOwr0ZcNsXQLFvSew7Bwk8LTSlze3B
	PA9msvDR0JNy1yn5OITztAyQP2UUcmMkqU
X-Google-Smtp-Source: AGHT+IFbR/hkcZrextwiHSaNvyH4tAV9pXid5iCOxR5MP99p8ZrfDGeKZfpphVbbGXYZSk5vQ78hf1JU1jwExjH5G/s=
X-Received: by 2002:a17:903:2cc:b0:22e:361e:7572 with SMTP id
 d9443c01a7336-231d43bb4f5mr63483115ad.7.1747674180455; Mon, 19 May 2025
 10:03:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250517085600.2857460-1-gary@garyguo.net>
In-Reply-To: <20250517085600.2857460-1-gary@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 19 May 2025 19:02:47 +0200
X-Gm-Features: AX0GCFtaysJVcUQOMTcbPDH1T0mGXdawyzH-WpOc8Eu6TBiYqOuUj-gxkOrlqTk
Message-ID: <CANiq72kdReW=OVdKPo4CJ1b+DU0GbkLxOOmEh+5C7zW9NgFtaA@mail.gmail.com>
Subject: Re: [PATCH] rust: compile libcore with edition 2024 for 1.87+
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, est31@protonmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 17, 2025 at 10:56=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> Rust 1.87 (released on 2025-05-15) compiles core library with edition
> 2024 instead of 2021 [1]. Ensure that the edition matches libcore's
> expectation to avoid potential breakage.
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Link: https://github.com/rust-lang/rust/pull/138162 [1]
> Closes: https://github.com/Rust-for-Linux/linux/issues/1163
> Signed-off-by: Gary Guo <gary@garyguo.net>

Cc'ing est31 -- I will add:

Reported-by: est31 <est31@protonmail.com>

Thanks!

Cheers,
Miguel

