Return-Path: <stable+bounces-195119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4027CC6A9C8
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 17:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 3D38B2B732
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 16:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1379A36CDED;
	Tue, 18 Nov 2025 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NbiHbK8s"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED4636C596
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763483213; cv=none; b=p1Qkqa9pnXjc2JTgroGbLmLldUg9AMO6SCFPtuQTBr/W4khSE/nKNJ4X1Xv3lU1KQxRYImiuTb1bc1DPNEfMlv+844dzC6IJa/n+x/Ucs87MG1/iJ2BjicdM8uIq4ZsfxRtQ8TG53CYW9aptAC8js3GAVqpjuyuSVYPirfXDrhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763483213; c=relaxed/simple;
	bh=FwtecA3cou5swpKk+7V9h8LfHIUHPkUFVZFloQEb+dQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pC2sU3pUNayNb0Ts24SKJKkMGHDMFqjf7ZZJYmO5hPCYP0oHtw2KUN1Udoteju7CUdXuO51JDQAbXsNRTAB/Y2CTVd9LybHLCZrRqh9jP+ZNL8IFyS2gdjpoDmD3/p8jN53GTq5gjXKF8gC8GtXJ8aiBA2ZgN5Io8NIXL3yJQMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NbiHbK8s; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-295c64cb951so242955ad.0
        for <stable@vger.kernel.org>; Tue, 18 Nov 2025 08:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763483211; x=1764088011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwtecA3cou5swpKk+7V9h8LfHIUHPkUFVZFloQEb+dQ=;
        b=NbiHbK8sCl+nRR1cXVIWdYqN0I3VLsKCKKWXS0wPLrvekyqFENCVxrsZSfo47wLxTw
         z//TfUqJslTZvJ7bQSfH33MtR3xV+GmKEdC6onwso6GT5UW+RIoIrZf4en+KgLGz5Nct
         2wSjImMNMkayjuFvq0UGue3kgZ/m9LFxk6tWEzSS3SHOSoVEldvwX3LjdMWSfznyiuTD
         /YyB00J6YMdyn7K77TfxB1eB1otkKcXWVI1j0ixgMAUqQb9sw0JgDuuBGzZhIhTw52Uj
         54tEhDKt4ruVyIVDYVg48gLevDM0KSo+NBDP63zbu5OVjHSE5rJBlAAWXkC1vVkZvp+L
         7mcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763483211; x=1764088011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FwtecA3cou5swpKk+7V9h8LfHIUHPkUFVZFloQEb+dQ=;
        b=Kygjii4SqHvtxpsF1vTKPwjJATVN5qobujU7v+BW/ZMEDZF+CVKi7CfDLGtzt1UIEl
         n8WjoCZQGbJjC1SKD0QU8RbOTPqeamCYMm9w5Qbv74jos+AFXtzXwm4nRBRn8XkmNcL1
         MIKd14x5EUR2YfllDqruNoD1tARXltZG7f7mIw1eK9sgC1ODoWi7hl8sNUka12U7Y7h2
         2ZXNZeZL0PWx4/IhObOQWl3sOIA/1qo7bmzmpWEUyLjbNiv8Gne9OYk01UAXfkWFqS63
         DTtwKgSmpqqsZUQMO2XP6UVD4diwme8NXmvmK4BTXSErXCPorzPdDSgLD1A/cgVjAW24
         4R2g==
X-Forwarded-Encrypted: i=1; AJvYcCWblbaYOoj0qzzsQ+mcDfwbC3WQbalam6RSixVoph0BftGFsjNGRibUAqoYeLu5MH2ibjb2kyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVyacHenNa31atMx0sNFqtdD4LFUK769xXX4+nISukY0d5zIvS
	qFezarwtVsxeRrLh/FKk4eqEZ9KfhWpc0T6vt0nMeC6zkMrC61dizH0fw7fo5gYdAtGdUEPJW/v
	JOGaYa1TFlc8nLCid7mOXX7HafF0TgNQp+fOu9YKi
X-Gm-Gg: ASbGncu3JxxwPd3ejLBHbM0YNkMrtGAEFyuLzzGg+/EYq79PsVQbjahIJI8NFx3sZZu
	+7kZVC0IEYRqA0jKLv4EnmdVgU5DAXGsjJij3FdsBwxWwgib1wDpRPL9pduZsgFzfFcIsl6aKpa
	56NtztEREB5Ecx4F9pJR3sFn+Q5zepMVIPfMXDpI5HK16aznN+APde40bCmbdZkBJWv2S/kbFiD
	37l3vtR2X/hFhKXt4+wqNqp1jxA4usfG2LqhS4fSvCfPjsUxZSkfj00h75z+BDJ6HVqc1j2+fC6
	j8I=
X-Google-Smtp-Source: AGHT+IEttx3J/mC4gE4KpQ4cPRjj+rRjuHjvkWN8RJrR+j19dbMNf6uYkFpkl0xwq9jCxBWF224ugSC9ScsaeVYU4f0=
X-Received: by 2002:a05:7022:4387:b0:119:e56b:c1e1 with SMTP id
 a92af1059eb24-11c88f6e153mr87381c88.12.1763483210529; Tue, 18 Nov 2025
 08:26:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110131913.1789896-1-ojeda@kernel.org> <20251118145741.1042013-1-gprocida@google.com>
In-Reply-To: <20251118145741.1042013-1-gprocida@google.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 18 Nov 2025 08:26:13 -0800
X-Gm-Features: AWmQ_bkpM4OnhqoM9DwukpapoYV-fxdR_ddUQfMp-wv3ty5dsyWJZ2MH8TZJaP0
Message-ID: <CABCJKuc0ZwN23MX4mV=vVne1giR=iWKSvqFg1oKMqxUcnOWiCg@mail.gmail.com>
Subject: Re: [PATCH v2] gendwarfksyms: Skip files with no exports
To: Giuliano Procida <gprocida@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Giuliano,

On Tue, Nov 18, 2025 at 6:58=E2=80=AFAM Giuliano Procida <gprocida@google.c=
om> wrote:
>
> Hi.
>
> > Thus do the last one: don't attempt to process files if we have no symb=
ol
> > versions to calculate.
>
> This results in the -T foo option being ignored in the case there were
> no symbols. I think it would be better, consistent with the
> documentation and expectations, for the file to be produced empty.

The kernel build doesn't produce empty symtypes files because symbol
versioning is skipped for (non-Rust) object files that have no
exports, and before rustc 1.91, we never ran gendwarfksyms for Rust
object files that didn't have exports.

> This means that just the for loop should be skipped, say by adding the
> condition there with &&.

No, I think the current behavior is correct, we shouldn't produce empty fil=
es.

> If you disagree, then please update the documentation to match the new
> behaviour.

I re-read the documentation and it doesn't really state how the -T
flag behaves if the tool is used to process a file with no exports.
While this doesn't impact kernel builds, a patch to clarify the
documentation is always welcome!

Sami

