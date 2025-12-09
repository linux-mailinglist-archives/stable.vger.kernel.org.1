Return-Path: <stable+bounces-200426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC27CAE931
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 02:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C57D930210E2
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 01:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A93257855;
	Tue,  9 Dec 2025 01:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byAVSqdt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E2523ABA8
	for <stable@vger.kernel.org>; Tue,  9 Dec 2025 01:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765242129; cv=none; b=WESjKXEywCizs8qTZdu2jZTk9c2MMabQR8EiIyqTGARHPJ6dpT6+1+p2nOd8rpSakRON54PGkQFGQNxN7Y+XOxBPBXDI7I31l6uXmFblLtGmKBJ6dNgzpUnmlueLnLRKqR4WlSjfzKkYPFaLKuQpMO1O1iwdxx/g9ynzu2CGbds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765242129; c=relaxed/simple;
	bh=uGDKEPLMykAWOcUlNHu4PNNG58YAB3acR8KWNtoonC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=epv3RVh907BA1K5uRnIQDDboQKR8/V4Do04jqYMorRXDg1+XZ/mQuzFb0JRMJEjVG/iUGIcWBAjGVbvST3mg3w6Pt7q8yrT8rVCcQn1pfs/us6xu2yAs1i7OpOAWPzrGTKUrJFAtiq2lRwVTTl8rBNoWD5HYrq+9ix4AYlV8GLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byAVSqdt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29dffdad925so1675715ad.0
        for <stable@vger.kernel.org>; Mon, 08 Dec 2025 17:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765242127; x=1765846927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGDKEPLMykAWOcUlNHu4PNNG58YAB3acR8KWNtoonC0=;
        b=byAVSqdtMQ9nrVS6QpEwAX6eH3lpYalHkUTfEoAnSlr9bXFTEftqFp7E16N2zzQDnO
         GdwytJmuzM1lac2lRtc2n2oXlfcH1sfDhAenNzfGESrMmiJFnHmQqW5DapD59Yir+jPV
         Ov/gPhXap6KFW2sEyjRTM+Z8rABH3ppzwfx0ZRNh7/6361BuF3risKfUM9hmBniPcB+0
         9NIlt4BZ07aOQx3Mb+s9S3wZbXQJJXvbYDKCSxAItynaPEvcpl8B02cG2iAkqAKvhlLZ
         GoBBGORaEmxmtoAuoU/CcQiCuJQ93F2CJ8D1dp/9S/rx+YyzpqIZsiQHtD6DWnvrcxdg
         jWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765242127; x=1765846927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uGDKEPLMykAWOcUlNHu4PNNG58YAB3acR8KWNtoonC0=;
        b=Zr7rKEb9nAX+8eiyON5oVLbFIiV9hKQzQ62unVtMGbv8n63SDPC/HP8vzGp9TReNuW
         OIzg/OXXxQvq2J3Q8lV+QBLQBK+X8Yk9mooOQj9uX4ckxWX06QjE4da9z3bzyKqYVmyl
         b6zKnyUH/xNOi26mBWKapjn5j02nxRvleEtlONHotaKvj9g0av+lk55APlDjhWP4p+ye
         uDkKKjfszxsxhc4EZg88MmDjbhwQ5SiQg1tzRr9Z5zJkl0mlDTe7QgSbQOwGK6ODG6RK
         xWn+qJcwkN6a7ciLoVwLQNeS3HimDFQgX4wbq4wFP192Eus+Hutc3YXlCxTuB0XDYbmX
         9ung==
X-Forwarded-Encrypted: i=1; AJvYcCVg8UyPkpI0nh+8QJ25/1Ko3mdoL4eCHY8zXNtiJb3fS97FoilTKoyZpumy8tYkfOfM9u3TxF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO0z/Q+x3wySUu9V1+ETaA17THfIRcGl2SUDbyCucDiqmXpRvk
	1TujDU2kVgi86chWsxvKpkMcUjSSW/A7qEc9z4bMq7sDbaCEUf3NWb3XKKtyl5Pn74QbNJoaxjx
	0CYnHu4n8iqnAKyI1WsJlRdZ154V6CV4=
X-Gm-Gg: ASbGncvncM50T5JXO4wuTWg5HmmV2ilRTbhLsVNZpDyILWu61d8T9IxaZHORtv7hBqy
	Itw22Q2IJE8AL2k10ZxqdBD47wnvceCkfIZnCZSOAlS153Nkf7NBEF9ALeZbQo1QuoPrxdmQQl8
	NApNpAwAPd00Y3wGMxlp3POjbMGeQ4fFAAyEaEdAha4u4lsY5ematbxmlUqf8oQMEvszpBCRgm9
	FUwpfMzBE1lTklVEyG8mIQQRbgHzAJUNxWbTk7dYDDcx4l7PqucZ4MRBNi45zrCSBglmaBdc9Fl
	xwrUJPJpUNK+UwGzvhZUJQsjqTb2b0GaGMrclOaRYSPOeHeVfSDdQhJr6uwSzkeJAoqQn4n/zYx
	rTbqq6hKgzpvP
X-Google-Smtp-Source: AGHT+IFrO5rf8fm5a9jJFe7v3vjVPwVESbCkXsoFTsGXBEpHYY8KdvibjzeUj8jNBuYb3/OZTmby9/KV/YRy3eFlwR8=
X-Received: by 2002:a05:7300:b0aa:b0:2ab:ca55:89cb with SMTP id
 5a478bee46e88-2abca55980emr2194053eec.6.1765242127202; Mon, 08 Dec 2025
 17:02:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
 <20251208-io-build-assert-v3-3-98aded02c1ea@nvidia.com> <20251208135521.5d1dd7f6.gary@garyguo.net>
In-Reply-To: <20251208135521.5d1dd7f6.gary@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Dec 2025 02:01:53 +0100
X-Gm-Features: AQt7F2pcCQwCzQQDDMpHjtqZugmca2-gRsmgHNhTBVCuGzfGkmQoYCkGIWj-Dlc
Message-ID: <CANiq72ksg4Ad8vk1tjH-fVAhUQUcRpuzR2cogKnGHPTax-fc9Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] rust: cpufreq: always inline functions using
 build_assert with arguments
To: Gary Guo <gary@garyguo.net>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 2:55=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> ? If so, I can send a patch that adds this feature.

Sounds like `consteval` in C++20, which is useful from time to time.

If we add it, then the attribute form may make a bit more "sense"
conceptually (and we already also added the `export` one).

Cheers,
Miguel

