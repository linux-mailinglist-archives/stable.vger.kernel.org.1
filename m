Return-Path: <stable+bounces-194523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA6AC4FA2E
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 20:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED48189D4C2
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 19:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3EC36B071;
	Tue, 11 Nov 2025 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOWsf+Wy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361CA34F491
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890320; cv=none; b=UGw45vfec9lriBWu0fObxq3pG581VCycfnbr29O1r0+t0oxJa1eqLPw1lmpfKgrmdfhEmmoV884YNZcp7vB4d3gjD+UmB7u2fn+ZQ77zOqxFtrHAbsNTEG/NoCgXIh0IcRgXkNJ/noNeGM47hhkniK/gCjt73TiSsPPxIq7j8Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890320; c=relaxed/simple;
	bh=Sg7FhLFPHYhYHz0dhqTZ1MP6Nbu0jdxwfOGdyNc5gt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFWQhuU1NoYUZH4NgWCxI2PVm17rtaqVgjF/u7zTIGodHMTLOet9jvcaMcsRYuyRn8gtQa4i0dDBovo2T0EUCJJbkLy8wcmX30RJzyYKni9HkpxW6eS3K+CiEq98X9vpxz7aKp7jMTjlalCdzcj4uWLdsDbOV91oOw/dnwDGpb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOWsf+Wy; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a9fb70f7a9so11000b3a.1
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 11:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762890318; x=1763495118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sg7FhLFPHYhYHz0dhqTZ1MP6Nbu0jdxwfOGdyNc5gt0=;
        b=eOWsf+WyXEw/eSF9CmjV7HIDweZC0asEzb85mqYKzz9wg9h3Fdpm+mS73vV/5Ri0q4
         t8upNUavqVuqv1KuNaDwbNcMTtBmEav4/wRRVAiTOGmNkbKa7JYB8Sr3/GutmNH1zy2b
         sifoMj72Cs8fBjjrfh0B1yIsNwfW1QhayBnLG5uGcBynT17eVAjrj9w8qJgEMGmXwmvS
         KNqDLm1LQdTW45V+nMxQyCR6IuZZ5AEvh72qA2Km/jLtdUtLXA8HsON+YTh7klrydLoW
         gbXlNtwgbm0lWwyAwSzuYEffId7REO1vPMVZZsuaHTmVcPh642HqHwn1o3As6AL1BJIl
         cDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890318; x=1763495118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sg7FhLFPHYhYHz0dhqTZ1MP6Nbu0jdxwfOGdyNc5gt0=;
        b=n3hfqTEmKTJ7mgiOjbgrmwisGFklKboWNa5yn2Xhs4SB4C3toJk4X7sZUBE5LQBd6s
         Kb3qqFdjD1Totgy3yqK0o+GrGv4AYOTpYoutqsGoj4AX454aeWaTqVwq+g+hblJIQc4H
         eaE/nJkHhCZwOTElbBogy60T6wBMlkAZxKO02M7cheSfVm68zyMixYcyLmoveXDQAvr9
         x9NVMuubpsLLcNkfa9oHSXY/nZceoB3UOFA1+xk880f8ya9ZTZPqsuk2lLyhkOJTZIgQ
         /+1NDA6raAouDA3VQ51oCQ4ZhwoQEsWnrWvgCq/ejC9pZXjkuzUyagjB4IQQR/U6142K
         0JRw==
X-Forwarded-Encrypted: i=1; AJvYcCX+qmjdaxT0Ed9weizp+W/zFmR/vfZCviLvANtQGBkh9lENccvC5HInnRhpnkkKzKO2QLNakLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx72KhXjEZfpy0xmAAgv3u7fTXWTPV1etlNUjYcO1x9GJ+/NsBR
	QDU15SAKiP6eetRrW1ezzgnBxzHlF3JGPdd8EJNaVIhcIJCehTtyLqW0Fx2x303VVpdaSdGuL/A
	0qAonPmMSoN0g44jFYmhfVB4gZuWx6P0=
X-Gm-Gg: ASbGnctZYcCA0O+ms/sdqZ06jgdJgGA8/q6YDi4xzc1oJ7VvyduiiU+yOjDT3fIdKBB
	U7mQHUdito9rvJzYywDBvPnzo1hURa+Yp9yrz5/f7MXYeAO2B9PqqLvx9x1aS6JS4Mn5C4S4g1T
	H8LTiSaIkWg0hq5buxPSrmxSE76FKSd93RrB/6vqF37r2N6jpSGUfA4fM7c8qGoKUQ3cJ0yFuYH
	IZVu3+5/NN8fBb+1zsyyLaxbS0hBxUASsAGIDVguWSGFFUe/A32OmqZs28Oqy8mF3SKXonLX930
	7BI4KTlNcT0pc0xfQTXPGLh4zdr5TUhfAGZ2orvMQLsbjIcdNzleVO9+BlA+NM421kZHZKecZRj
	75LU=
X-Google-Smtp-Source: AGHT+IE5zjw8D+my40d60Ix41uKXNSt7HOnLAKKhJi0H3LCnV5CTo+qFPBfkXgqbqQK8w6cViFfsGq4E6L6246te+k0=
X-Received: by 2002:a17:902:db0a:b0:295:70b1:edd6 with SMTP id
 d9443c01a7336-2984ed884e3mr3098505ad.3.1762890318029; Tue, 11 Nov 2025
 11:45:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110131913.1789896-1-ojeda@kernel.org> <CANiq72mjFobjfQEtNvk9aA+757RkLpcfmCCEJAH69ZYsr67GdA@mail.gmail.com>
 <CA+icZUVcHfLru9SRfhNGToiRmyOY+fLw-ASEvQakZYfU1Kxq4g@mail.gmail.com>
In-Reply-To: <CA+icZUVcHfLru9SRfhNGToiRmyOY+fLw-ASEvQakZYfU1Kxq4g@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Nov 2025 20:45:06 +0100
X-Gm-Features: AWmQ_bkZOKXuOXoFqnluk99fIIrWIqE98EcoUgehQR7XEFroNIarOWjMBHltciY
Message-ID: <CANiq72mS2SFfMsMgVvmR7dgBpYq6O23Gx9fQmDWuaqrz5sVNYw@mail.gmail.com>
Subject: Re: [PATCH v2] gendwarfksyms: Skip files with no exports
To: sedat.dilek@gmail.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 4:25=E2=80=AFPM Sedat Dilek <sedat.dilek@gmail.com>=
 wrote:
>
> I switched over to gendwarfksyms in the very early testing days.
> Faster builds. DWARFv5 fan.
>
> And was using v5 of Sami's patchset against Linux v6.12 as it cleanly app=
lied.
>
> Last week, I jumped over to Linux v6.17.6 and the next testing will be
> Linux v6.18-rc5+ (upcoming next LTS kernel-version).
>
> I will try this patch - might be you will get a Tested-by.

Sound good -- I have applied it to start getting testing, but if you
have a tag in the next day or so, I can add it.

Thanks!

Cheers,
Miguel

