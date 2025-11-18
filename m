Return-Path: <stable+bounces-195070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F2AC682EB
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 09:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 747FF3466C5
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 08:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC7D3090CF;
	Tue, 18 Nov 2025 08:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gd+H+cmc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A6D283FF0
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763454022; cv=none; b=VvJaD4iaBdcEptHb4WA0P45HGDKSypaeYfbNEnmD6rWd1hS5uzZ5B+BxfJ8AcN8PVuboc8ctz9xbCiosABUSogCI/BuQvwd9NlTNVzZu9FmS0RW/K95UHtoJX2HMFCSfKiD0QI/2s5BWhm/vlPMylOb/CInLWaQ1zs8LxZsELQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763454022; c=relaxed/simple;
	bh=tsv/EMDpwgvAMp1Wh9tt2j5947xk6cwt1WCvp2dNq/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4yo+myEBKrwfGn2BWnImE+iuaUOtQrrAGSLPFIBeLBkpd909By4rIAinCe+q4L3EAu2YqewS8LPC6UhiryXxxekQkHruSerbXqyzcT97rbvmPQsaQMYXSO6S92yZ8ki0fVYhacMyJFylqXby5zg9TiWTHZPiPx7LBHuh3bmiME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gd+H+cmc; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7bac5b906bcso476361b3a.3
        for <stable@vger.kernel.org>; Tue, 18 Nov 2025 00:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763454020; x=1764058820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tOwn5GK2Fu+zzZaNyEoXzKOFnYSWxRdIcRrprXu2dg=;
        b=Gd+H+cmcP7UoK79zWeZgcZE/8djU8+/+w2uHcQ7o4R6tcI8AJ7EhR/EBSbmOUHQEiA
         Klu8QTgcyGBZL8gN7z/zaxokLY+wGpuYod3bZPELAV7kwdYnDqxM1C47gr3vQczfyCdx
         uwamJ1YrBLAEvvn4EeFmI8IyuU+R6kg6FG6wSrtK8vnnZzDoe93sAfLhhNRScAJ8VCWw
         EmCVjU8M2mCIXqJGufj7KBjn3mTkD2b2pjY30A7ow97aa7vQQ1TeuI+HfRmhqXPh6gtV
         sD/EB9VnBnNhtDoceQghi5xVEC95JsUvLvRCsVXH0/Yt67F62OkhTA6Pm+QoJEaBFNBv
         pycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763454020; x=1764058820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6tOwn5GK2Fu+zzZaNyEoXzKOFnYSWxRdIcRrprXu2dg=;
        b=prSCy6S4LqwLt8PoyALJ8JrUE6RTrVjeIxrnthdvx3IR59VtNDrko5NgY0+3C+wY17
         v+5ZcEjDC7FamgGNZLlmCT8UHbjtQtY072Z149g8Gq1v1sNLJX2jSY7Mp4EKxlkbQbco
         6KeS5VYtu0mNsx0nMUeZhNNXAlnE6VQzmLf/DggNJu8bUnzcgsEtsJyaMVq99vBep57S
         wR+HtWNngu2pC1ORv6bT0PfSTbGINjI34tWRKmTDnx/4Ess+UuY0fyByXeMguNg3FFKO
         UeQFhu++LK4QJ10/jm7W9rIr3sn5yNRrQP7hoB50sy+JcH65HrY9SES3Imo1RQUuBGoX
         OBxA==
X-Forwarded-Encrypted: i=1; AJvYcCXNtDPbmuVBe/vmbU7yOj34xRcRy0gBNiGMXukmuuUN39N8Nk6B0SCRsIUZiNRcROdCB/fhTK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwknQPma4tVSgfTjynYwbj5ZNM86D9g8z9q7ZVth2RUmjb/zowQ
	o5M8x18JxytR5C6B76FA2UzA951uQeQVmVVM51dxEw9PsBY8NmtDm5migOvi7LrE/luEeLZSy7F
	LcVb9THJ1xgX4U4RQJJCiT8Z1Tm2m8D6T2bdM9bo=
X-Gm-Gg: ASbGncuO9/n1S/1tgBSj3awcO9jtfyiyBXEJvjqZ+zhNH5KAsJgpNDUU/qPRVFPcvpb
	SOk4jvgN19Qc66y/RhOZbI3ks+DvNZjPLREupZlBnap30BWuNwG3xlZ4KxJf51NHKnWtNxTMX0m
	Z/h3PMyli6wq/jhAStL0Bf2a85Ji/ziTPeFVW7MoKPaa/W9DgQ1zzBTxJwCT1hqmG42vK3IsWZu
	P0ofS52FFJP9Mtj6RtjMsgYCloXsPpRINzoW+lDvI2LVr7IBOmwJ/xpTOgBX3gv/b4OP+odjTEQ
	/lyF/eB5KmG2IwRZq5a7davZRjKCUDgJxrHkMwrnOtw3+DeFUCGcLx09fDNv5f7HRgdHWTJUyQ4
	ha3M=
X-Google-Smtp-Source: AGHT+IGFev7EmzbnBp3oCU5tzJS72YlPe0fQcsXeEhETHRdh5xiHxqgJbvANso1btJz7XhrfDTY/gAumPDbcpOU2Bw0=
X-Received: by 2002:a05:7022:f8c:b0:11b:1c6d:98ed with SMTP id
 a92af1059eb24-11c7911fb1fmr726027c88.2.1763454020327; Tue, 18 Nov 2025
 00:20:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118072833.196876-3-phasta@kernel.org>
In-Reply-To: <20251118072833.196876-3-phasta@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 18 Nov 2025 09:20:08 +0100
X-Gm-Features: AWmQ_bnx5UkMI3RaBr2xr8orUONtN2aER4njXO5kUBVtOQLvb4hCXcfSlbSPWpo
Message-ID: <CANiq72md+0Lerj+kqr6QiU6ySR3XjRzmuBiLjkpWWieM72wyeQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust: list: Add unsafe for container_of
To: Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@gmail.com>, 
	Christian Schrefl <chrisi.schrefl@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 8:29=E2=80=AFAM Philipp Stanner <phasta@kernel.org>=
 wrote:
>
> For unknown reasons, that problem was so far not visible and only gets
> visible once one utilizes the list implementation from within the core
> crate:

What do you mean by "unknown reasons"? The reason is known -- please
refer to my message in the other thread. It should be mentioned in the
log, including the link to the compiler issue.

Also, I assume you meant `kernel` crate, not `core`.

> Cc: stable@vger.kernel.org # v6.17+

No need to mention the kernel version if the Fixes tags implies it. In
fact, it is more confusing, since it looks like there is a version
where it should not be applied to.

> -                let container =3D $crate::container_of!(
> +                let container =3D unsafe { $crate::container_of!(
>                      links_field, $crate::list::ListLinksSelfPtr<Self, $n=
um>, inner
> -                );
> +                ) };

Unsafe blocks require `// SAFETY: ...` comments.

Also, please double-check if this is the formatting that `rustfmt` would us=
e.

Thanks!

Cheers,
Miguel

