Return-Path: <stable+bounces-126949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A6DA74E59
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 17:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52D33B93E9
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 16:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66D51D8E10;
	Fri, 28 Mar 2025 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILPKbkN8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791F21C9B62;
	Fri, 28 Mar 2025 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743178519; cv=none; b=o/J5c5rhBTXKjXCpTh1pDjgk+5jN5FxBKIjcJ0WD5pGtopRIPDabF4VWtZ7F1P8g2SuufgaiprxvCsg1arxXAQdBvmhfIioeV48arMp1EetfQccJ22GvCSgGrTG2uZcarqQP/HfXzrluZXp3CBjVmcUznHZ3lqbIOTl8F1r9yJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743178519; c=relaxed/simple;
	bh=CmGR1W9b2oM3HkNEBI2AYOFZPDQEfP3x8ljARqgGovs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AXMJq8aRxRyJqsK73b0nrI6uUNIVoryvYvh2o9YuQn9a8kxAJuFlYoHEa+BK12szV5y5hDtiyK2s98ikKCadth5oFIdCPh0C5rhS2V2+M31mJRH26BDZmPI2+EO5+0RXneR4npvCnmbUq5h1r75JpNm7Zldi2m7KTLODBum7uMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILPKbkN8; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-301317939a0so494597a91.2;
        Fri, 28 Mar 2025 09:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743178517; x=1743783317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0awkyL5t3rsWIxtC+GV3omh0jTpCEAWKwJhyhjRWrVg=;
        b=ILPKbkN8jNhBJxFwFxghgPwzNAsKkKIpokoiXDgOCk5K6J0CB4JOxsHDtYU5tTg2IE
         BeYvXtl+hmP3kS7KfqEw+REFoYGzoWcjMpi5LbzzrkNr3HI205zMc8KzGnjGPaymZ8U0
         v7sA/0s76D8+ybriRB3gWqrsU4GC2gTMkAYey92a5/mWEmvEC3yqC6xEadf3daA8JPfb
         lAH8y+Ov58QQMJgn14hPuqhP1n76mfTp1qIwV+blKvU/xzRp/ZgNgkrZEpD7ceggcPgh
         AcJPnaLPZFdLemph6L8dazBGDKVOp7UfGPvjbG2jv/vsZmn+dTUFDXFSRG+UheS37v8A
         1QCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743178517; x=1743783317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0awkyL5t3rsWIxtC+GV3omh0jTpCEAWKwJhyhjRWrVg=;
        b=AMkaaXvfscqZU1fmqTelfl9jB/3z/yzpzSYDMVD4t7nN7H89/a/K9caVe95B4PQf8b
         7I4nGnE/YuBQEJt26cYDdgUpbYbC3KjXEfxoVXMnNU1eBl8HMT371nvzu0HABhMoW3n1
         P91JTj4uFTYvKMfg2bHHbEZbyrL17/p6u0N6gdA3WPFwVLQqj+KK/RvxCzkvitvI39XL
         7xSkb40jx+UE6NPpA9ko/O368l20EcBwqWcTC00HZknI/Od0NPrO8EWgAxKU5cXepaWO
         KS2wqZYtbnhNfQLuvlT8pL4P4gB0ZOMarS0qnta02wspNNr9x4cXkQE18eqmcfUlii49
         VRvg==
X-Forwarded-Encrypted: i=1; AJvYcCUWRFCWj0D6baumGJCDiClDytuKLXw9zgkSiWctJx2mMCldHwFfTcgc+voALPsXWjbMQurcHDKTTfrs7ow=@vger.kernel.org, AJvYcCVbowUyczvAsgfnRTeqiaMnC07adRtxm/9Uohk7b1FggeMwa1Las8iNM0AXlGRH7hPkSEtNdN4k@vger.kernel.org, AJvYcCXnnX/8XhT6LHur/rk9d2PvoXQdgk91tS52mTwK452p2PjWRk8PYlHPNZPgZxK3GrxzrtfG+pe1yI0BIgr7JyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfTMxkE+/AJkiV+wRqRjJf8zlZQasxUE3UIXafE9Pefup24rhP
	eqrtElRTBc8q3rGiWAaftCdF0ylkxB0akmHniQ02yIZhASOKF9/nEVjA2mCWTeYr7Vg4ljbXvDo
	FaUnpSkD8McuINzxmIOXt7AispbQ=
X-Gm-Gg: ASbGncsg5r6um4xdCibffu5DCXlni2R6ECWMaqqvF7iQJdVROAMOD6V13jNA0us6lQm
	icL/87t8UBZrfNkhYsSt8RD46mZqWH1lLeXhdagrbH0rTl26Us4T809ZHWTJft/XRrO5iOvhLDL
	pBGfo8sLQ2rk6R4+UBMvzg8ty3/47PT5JfpWLP
X-Google-Smtp-Source: AGHT+IHpn0XubsSScUGD+yuythr0b0lI1lM1TZwBkmj8zcuCFyTDK4gsc2cQ9eJf+cEDv1Ie3kf5rbPpmLeZ1kOkj8E=
X-Received: by 2002:a17:90b:1a8f:b0:2fe:a747:935a with SMTP id
 98e67ed59e1d1-303b26fe5fcmr3944480a91.4.1743178516457; Fri, 28 Mar 2025
 09:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304073554.20869-1-wangrui@loongson.cn> <aab657d72a3ee578e5c7a09c6c044e0d5c5add9a.camel@xry111.site>
 <CAAhV-H5ayw7NxbSbCeAFaxOz+TZ8QeghmhW6-j2B1vTcjYxsJQ@mail.gmail.com>
In-Reply-To: <CAAhV-H5ayw7NxbSbCeAFaxOz+TZ8QeghmhW6-j2B1vTcjYxsJQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 28 Mar 2025 17:15:04 +0100
X-Gm-Features: AQ5f1Jp78m5RCykhet4JNZuQWUIdRgx13WqG26TPp7YpFZ0W88cx3LDq6ng2qvk
Message-ID: <CANiq72=AZ+CN4SScZcnRBpkS8ogCaZ=Uhe=k7fhGCVyecyRu5g@mail.gmail.com>
Subject: Re: [PATCH] rust: Fix enabling Rust and building with GCC for LoongArch
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Xi Ruoyao <xry111@xry111.site>, WANG Rui <wangrui@loongson.cn>, 
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

On Tue, Mar 4, 2025 at 10:12=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> Don't rely on  default behavior, things may change in future.
> Acked-by: Huacai Chen <chenhuacai@loongson.cn>

I was pinged about this one -- are you picking this one through your tree?

I didn't test it, but the change seems safe to me for other
architectures that we have at the moment, since they don't seem to set
any of those three from a quick look, so:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

In any case, the usual question for these "skipped flags" is whether
they could affect the output of `bindgen`, i.e. could they modify
layouts somehow?

Also, it would be nice to mention a bit more what was the build error
and the GCC version in the commit message.

Finally, regarding the Cc: stable, I guess that means 6.12+ since it
is the first LTS with loongarch64, right?

Thanks!

Cheers,
Miguel

