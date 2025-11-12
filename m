Return-Path: <stable+bounces-194602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8117BC51C9A
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 11:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87979189A8B6
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 10:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA511307AD4;
	Wed, 12 Nov 2025 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ED27z4KD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451D9301473
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944909; cv=none; b=bfwKhPvQqNEUjPJ2j2X6pVFZhY8djmm0KHra4nAWqajwA0MDA5918wbmpYMlVd9G6U+/1cFKycvkE/SZ+Am0TKlawgtHjr6PPb4NWCcCno41jePgqWh3N5Za6513+f35df87AzRNyAATamkB5EzzF7pk3hBuZBKqn/qsqN60trE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944909; c=relaxed/simple;
	bh=82sfAS4BKz1KNiaLNqx18bHdwdUYK8X02FBvH6vmN1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGyIVVOo/eU075kl4h1WUGn1IxYRsxK+PRjCSKvZeMIx38MmkYU4D8bQrYN8ZAvblfyOSLSz6sh6FgXkqVrcZaincVkcyHnrwCthmjja/Eq3HM7Bci/9NIGtpGa0LPbW31TDQ4AVOmf7MgKz3hVbjcccdcJvaeo+O9MuR+u2194=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ED27z4KD; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b8f70154354so94009a12.2
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 02:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762944907; x=1763549707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQJWtPZk17V4l48RMFU2vUfDUBcuLAHxhxXOZo4IqCg=;
        b=ED27z4KDla66atEkRYysJmuTML+lQHJxLuAp3jhRIY1+XlSwW+hrhyNhdm0TrxwI41
         iBlsA13sWRigSXpGnp9wOKsIhOi79fY+8GWGAg/2xPPHITEM4I6Ao+gB/jOUHJUFTVVj
         TQkwS0vY2dv8SKDri2fAeJe9ThGageatQMLTcaIm9jKEdqvsQDKdC+OQqWvXN8ctirmd
         GQH0gOU5QuNuhBkqkdeYagovW+jnqwiJEQ4adTMDi9LqLpJ23QSrIfb6Pu1pkK5N18RB
         5IRMoTMy1qE45ThKmUaMd/5hReGtC2MaBdD6k7Eci97Cb79IDn8lQZiN/kHZ6r1geQ/x
         lQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762944907; x=1763549707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kQJWtPZk17V4l48RMFU2vUfDUBcuLAHxhxXOZo4IqCg=;
        b=kxJQ+71caUd/g5EOiVkZuG5LZ1D4MZnbPMQoUUhFuvS9i+yykpzIjC661jqWBOUe4x
         kwfGFOyoLusUrHoyKQHX0Yd1WmqtbyGoUCiTyLpIvfCK2pi38/O+T5kYZ5t2Exb0UIx1
         y8c3JiYSc0WqUEGI4kGSJSoK8153yr/ZWFCSGaK3o1sMmep/L7ILA7bYzSB827n9kAs+
         QJGPIYTX8a9oznhgElc9CPCZfRxaeNNHw/0Tcg5a+rTF/4zjECORQg8K6+fnb6wUDSQp
         NjxNFTiH8MYllbtz6J7klhiJtqgUKQ76iT2FDom5GyB2duuCYXTKrq9UjUaI4QMOPtQc
         bfUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4elewVwF9rQuCKs1n9aPc+xYMPoGJ2o5NuQjCJ2UQ6TvAFqIudTFvP1Qy8fLmrnC7jdRlnBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKOGTRivEQJPJMkjV4MYV1EhKbBIGDxUNwbyqcnZ1EKEz3PYFT
	lQnBnzooPsNeZQ9U/ztJje9R87O5TniqsZySwXiHpJbxWuB5UknYQ17lTBwBEz/nIud+bdXaulg
	T7tf1TwYS99MDnEQqlJqlvrTbNCsNi4Q=
X-Gm-Gg: ASbGnctPsIl2w3RkkRn8sdb7sABQoM+XQqAMhgq3moNpe35/L/sfh/5R93qk0H6flT9
	mb9yj+LGT2JLcYmg32505znTHpzW7/aCAtH5tEZAblqfWKvGm1ViGLF6cKcDy8zzGRqY5FDYhbf
	gILlOIMFb7akWT979z3UOuPJemGBGy4SBrPHT7NMbGFIBV6BtZajMaGgt3cLk73I1MHuUV+sFPP
	qnY4HEwAlD1e/K1nbV0mzDUOS68VDYqmwFQpxvGfT63PBT2Rj5848pOr4hWe1jxGv8l3ZwInz59
	dVBGW7ROwDn4/ZvGb/Qu7HeTUOSZ/MAm6btL5yO4ifRazM3iI40hybopiByKLJlY6U+gJ5/Tiav
	JwEk=
X-Google-Smtp-Source: AGHT+IFsTy6OYScG+CerWDpgPGJvvrpZZa2slmzCw2p2FhMd++qGQwfMjY8XkE5BZNsi8aZK27qX30hA8hzulfn8Qac=
X-Received: by 2002:a17:903:2282:b0:297:df7c:ed32 with SMTP id
 d9443c01a7336-2984ec8fb37mr19636225ad.0.1762944907518; Wed, 12 Nov 2025
 02:55:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-resource-phys-typedefs-v2-0-538307384f82@google.com>
 <CANiq72maV_j1uV=2nPGbTgRabnk8cpc7TNN_FQ+ou52OpZ=k6Q@mail.gmail.com>
 <aRRgbZ67cuW4ZoBN@google.com> <aRRkzrUw1iYNt8KJ@google.com>
In-Reply-To: <aRRkzrUw1iYNt8KJ@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Nov 2025 11:54:55 +0100
X-Gm-Features: AWmQ_blEy9lDgXUuRaA9PFmJsOL5mkEF1Q6ty6i4iYdlOSuG0l-50NngYkbjG7o
Message-ID: <CANiq72kEYWbQ_yqJKHoa=ffereCun4A6rMudrcU+qBK_Npks8g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Rust: Fix typedefs for resource_size_t and phys_addr_t
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 11:43=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> On the other hand, I think that the first patch qualifies as an actual
> fix.

Yes -- for that one we should add a Fixes instead:

    Fixes: 493fc33ec252 ("rust: io: add resource abstraction")

Which means it may go to 6.17 as well and the "# for 6.18" part is not
needed in the other tag.

Cheers,
Miguel

