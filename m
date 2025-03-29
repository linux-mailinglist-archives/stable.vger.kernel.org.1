Return-Path: <stable+bounces-126987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798DAA7540B
	for <lists+stable@lfdr.de>; Sat, 29 Mar 2025 03:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDA497A7CDC
	for <lists+stable@lfdr.de>; Sat, 29 Mar 2025 02:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653FB250F8;
	Sat, 29 Mar 2025 02:43:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E15B676
	for <stable@vger.kernel.org>; Sat, 29 Mar 2025 02:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743216199; cv=none; b=mnkBdQcYl4Agkgqffd2uXtK6h/dLYev6CMHbloktNaNMwLVHmnBTVidK8GsDgsdGNjANHd2LIYcDkcor1f61m+WohrDkUP3DqjsZQHy3CksDBstei5zEoS3UCnsyfKuekst1yEHo+HvQdOBEOtyJQ1VBp+TFEyhRCb9IUQHlIVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743216199; c=relaxed/simple;
	bh=HcIGeBrGMpCMxWsLaMVzZX0Pv11Can9GqBFjhYG624s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NF91aCtfklJuAs3MpIR7IHSTpRlBH6J/acoRMWa+Wxr7vpbFnlpKkbRqM9V9kWFtRLKvlPi2g+F031abiJWfuuaKCIgnI0mXVJ4tYIPG1VpKr1Gyety4jcIvZRJjJyrJR7y2r4TFEBjDlXC5aR0yOLGjFLm0JFKFmHfWHI3eez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [209.85.219.173])
	by gateway (Coremail) with SMTP id _____8AxTWs8Xudn9xCqAA--.21907S3;
	Sat, 29 Mar 2025 10:43:08 +0800 (CST)
Received: from mail-yb1-f173.google.com (unknown [209.85.219.173])
	by front1 (Coremail) with SMTP id qMiowMBx3MQ5XudnhMBlAA--.39722S3;
	Sat, 29 Mar 2025 10:43:07 +0800 (CST)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e5ad75ca787so2566901276.0
        for <stable@vger.kernel.org>; Fri, 28 Mar 2025 19:43:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvIruijcShdDK60a8Okps95iKmz5fZk0DWJkFqKxVdhJIBeXQrhI/ftKuNjTHI5L+3BLtHf5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/1/eqRzl9vfAv/hSzjpTWmIEnhLdZDcOuI50XQAkhIHCaapAi
	uy8/xc8LggX88aUOW0XJRUbT5LyoxtftN6TAOm3fcktTscBL9ODBjGE5WT/J+ARPz2NziP51+hO
	eZ2lrjTec5U8KRrBe7F8u5hDbs+ECkluE1ZUhcw==
X-Google-Smtp-Source: AGHT+IGk4jLVMMvZ9NO4g+M6cXpWM89jtepREBCULlvcxr5aiChB5Hx8NjFVELFpjOU4wIk0eMDYI9EFrsKCf5pBsNY=
X-Received: by 2002:a05:6902:230a:b0:e61:f51a:a79c with SMTP id
 3f1490d57ef6-e6b736c36f9mr6818089276.19.1743216184810; Fri, 28 Mar 2025
 19:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304073554.20869-1-wangrui@loongson.cn> <aab657d72a3ee578e5c7a09c6c044e0d5c5add9a.camel@xry111.site>
 <CAAhV-H5ayw7NxbSbCeAFaxOz+TZ8QeghmhW6-j2B1vTcjYxsJQ@mail.gmail.com> <CANiq72=AZ+CN4SScZcnRBpkS8ogCaZ=Uhe=k7fhGCVyecyRu5g@mail.gmail.com>
In-Reply-To: <CANiq72=AZ+CN4SScZcnRBpkS8ogCaZ=Uhe=k7fhGCVyecyRu5g@mail.gmail.com>
From: WANG Rui <wangrui@loongson.cn>
Date: Sat, 29 Mar 2025 10:42:54 +0800
X-Gmail-Original-Message-ID: <CAHirt9jg2hMJDb7o2H33-6DqnF0boUwdfiwmaJahg5C2=sPi0g@mail.gmail.com>
X-Gm-Features: AQ5f1Jrp_Grtk1mM9tgpZbrZSf0byvB8hoYloKhjBdo_j1DwQ_sq-aJDwVxK7Po
Message-ID: <CAHirt9jg2hMJDb7o2H33-6DqnF0boUwdfiwmaJahg5C2=sPi0g@mail.gmail.com>
Subject: Re: [PATCH] rust: Fix enabling Rust and building with GCC for LoongArch
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, Xi Ruoyao <xry111@xry111.site>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	loongson-kernel@lists.loongnix.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:qMiowMBx3MQ5XudnhMBlAA--.39722S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF1UuFW7tF1xAr1DJr1DurX_yoW8Xw1rpr
	WkKasrCr4kKFW8t3WxA340vayjk3ykurW8CrW5X342v3Z8uF1SgrW0qF1a9Fy8WF1kWw4j
	vanF9a1rKFWqvFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8yCJUUUUU=

On Sat, Mar 29, 2025 at 12:15=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>

Thanks for the review and feedback!

> In any case, the usual question for these "skipped flags" is whether
> they could affect the output of `bindgen`, i.e. could they modify
> layouts somehow?

These "skipped flags" won't affect the output of `bindgen`.

>
> Also, it would be nice to mention a bit more what was the build error
> and the GCC version in the commit message.

To make it easier for the maintainer to include more details in the
commit message, I've attached the original build error message below.

  BINDGEN rust/bindings/bindings_generated.rs
error: unknown argument: '-mexplicit-relocs'
error: unknown argument: '-mdirect-extern-access'
error: unsupported argument 'normal' to option '-mcmodel=3D' for target 'un=
known'
error: unknown target triple 'unknown'
panicked at /home/hev/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/=
bindgen-0.71.1/ir/context.rs:564:15:
libclang error; possible causes include:
- Invalid flag syntax
- Unrecognized flags
- Invalid flag arguments
- File I/O errors
- Host vs. target architecture mismatch
If you encounter an error missing from this list, please file an issue or a=
 PR!

gcc version 14.2.0 (crosstool-NG 1.27.0)

>
> Finally, regarding the Cc: stable, I guess that means 6.12+ since it
> is the first LTS with loongarch64, right?

Also, the `Cc: stable` is indeed targeting 6.12+, as it's the first
LTS with LoongArch64.

Thanks again!

Cheers,
-Rui


