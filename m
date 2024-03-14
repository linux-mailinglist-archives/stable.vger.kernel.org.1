Return-Path: <stable+bounces-28127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEAC87BA2C
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 10:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D151C21DC6
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 09:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFA46CDC1;
	Thu, 14 Mar 2024 09:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ubFCNPhe"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1536BFDD
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710407711; cv=none; b=RqVE/ozkICjgScIMbPGDLC5IaKq5tQHVHu0j+3zFrck81s07G38KKcLCjwbKsptzSXRTXYcslH6KhZ8WwxBWgrFRuTLgvxrJ27tq2EYMw9VZPQii1lfKXVO4loa0ReJqvtI+nq1imw9f3hpp98vbKSvt9Ts8u7YCdi9FbH7zT2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710407711; c=relaxed/simple;
	bh=lE/ZP5Tkvx9YY0FpPfk+sLpzNiYxoj91aWi14jou22k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXG7TAEafAfBd6F8DR9XhdMKAUtEkhGdgBOjmyRhVkmi4RW0EyEtDXfxictuHLIHgXglNoweKqxa/AX1Kh4R2i6fV6upY4AdMUQzWFm9pnpVlSGwSgqzIYf8KfgWUZN0zBAtn7E6qk2XjjJLrcR8IEKQv6AsPC9GnL/SJYv/i8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ubFCNPhe; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6904a5d71abso4291736d6.1
        for <stable@vger.kernel.org>; Thu, 14 Mar 2024 02:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710407708; x=1711012508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lE/ZP5Tkvx9YY0FpPfk+sLpzNiYxoj91aWi14jou22k=;
        b=ubFCNPheSIZ9cs6MaZxKWElEVqfL+s3kamjXeBCi5TL+nFgDVocsEf/N34w/gQXVeR
         0LqK5N5L9cob0jrM+f06EPxadjMNgbXM10e4we3+v20YN4+oZzGSq809ILziIuLklVf3
         MBm43VXX5DXR9vpuXWhLQJkZrcstImmNuzovBiJ6kUS7KGdNafB6ePLmas1Yg90DDG03
         whRbVMEzHbrjEoARIstnlcsrPPjeL90l7fJUSi7+N1nlhc63QTNiYR/XCWHbWFoB4enw
         T02PnMckcF/xjSPGoeMaeSN/Mx2E151p/NulWThbpZmFZgW6TqG22w6hjIaIO52cbznP
         R02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710407708; x=1711012508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lE/ZP5Tkvx9YY0FpPfk+sLpzNiYxoj91aWi14jou22k=;
        b=rpeQKZzFtwm5CkcS/miqlfYhR8+hvVxV9cRjvNZGcm+XJQv18J0X5GyJvK84vYfUUA
         xIzsiwtxX7s4w5tF142F5yDFdmzLh2CqQpopo1qfuXeFA6ht3Y5HVtJIP3Ckc+rDZkPp
         bolhGgoOeDhPSIqTGTEQ7DQYipj0g5oONXVpq73AstBiLoHUph6U1GLxmal375jcWMz/
         WVdSvU92uRAwb5tx89E89/ubsVIuMOoXS042O9ImmnOuXIJ08nWYMCK+oUFMk/Dq6Qr6
         HoNWUgYVPF53S3xYXaLqV0CWjif2oSOK+j9ys3NHG0Wt1o4VaQflpsRjbvuS8X4GbS/G
         t2/A==
X-Forwarded-Encrypted: i=1; AJvYcCV4co/WWfQLjC1fkDQQ7rfOz2kVio+9uprUfXAV4cHGfpe+7iMVJ5rAVej0wJkDcCuL6oxeOUH4nDVDgQxf3//DSU2H6KNR
X-Gm-Message-State: AOJu0YxZII/KQybDS6p6zp1I/MIRVXU1xyYm6DdD7EPAlB0hCKvkJMy8
	H9XbKMIy5+mP1cynQkNXP7M+s9JUBpWRZVt3GbzPW0WrgN+7r1izHuDQdTWl9w+3dgpDIk8yHcM
	aeo/CBlgR64XPDLA2TV6WZN1REcWEiNqib5IP
X-Google-Smtp-Source: AGHT+IGfMznYIETWqpb1PprXePzqaigF18dojgQnMhgp1CmXhdyU8MIRSF4qLWE020QEL3knnSBFKCRcRErOBRLrkgE=
X-Received: by 2002:ad4:53a6:0:b0:690:d719:d575 with SMTP id
 j6-20020ad453a6000000b00690d719d575mr1324895qvv.43.1710407708463; Thu, 14 Mar
 2024 02:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313230713.987124-1-benno.lossin@proton.me>
In-Reply-To: <20240313230713.987124-1-benno.lossin@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 14 Mar 2024 10:14:57 +0100
Message-ID: <CAH5fLgjMkWxqTxZKt_w+V6X1qfUzosTbwMxDVXUmw_qTdzYP_A@mail.gmail.com>
Subject: Re: [PATCH] rust: init: remove impl Zeroable for Infallible
To: Benno Lossin <benno.lossin@proton.me>, Laine Taffin Altman <alexanderaltman@me.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, stable@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 12:09=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> From: Laine Taffin Altman <alexanderaltman@me.com>
>
> It is not enough for a type to be a ZST to guarantee that zeroed memory
> is a valid value for it; it must also be inhabited. Creating a value of
> an uninhabited type, ZST or no, is immediate UB.
> Thus remove the implementation of `Zeroable` for `Infallible`, since
> that type is not inhabited.
>
> Cc: stable@vger.kernel.org
> Fixes: 38cde0bd7b67 ("rust: init: add `Zeroable` trait and `init::zeroed`=
 function")
> Closes: https://github.com/Rust-for-Linux/pinned-init/pull/13
> Signed-off-by: Laine Taffin Altman <alexanderaltman@me.com>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

