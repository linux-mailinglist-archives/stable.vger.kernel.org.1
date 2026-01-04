Return-Path: <stable+bounces-204578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD7DCF14C4
	for <lists+stable@lfdr.de>; Sun, 04 Jan 2026 21:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0060300B83C
	for <lists+stable@lfdr.de>; Sun,  4 Jan 2026 20:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9582EBBA2;
	Sun,  4 Jan 2026 20:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gn5YfUlS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619D52857C1
	for <stable@vger.kernel.org>; Sun,  4 Jan 2026 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767560020; cv=none; b=L4ZfYlLJPkA1sBY8TVWS8HjGxC+iy1munuPU9dsH8EPFLzp/ponVbgJCumYCUO/aHkZOXTdXS2R9Qy+LYAjOrysHB5fYX9R6C65mbtXZEXt3K37ouwj2gadka+yNiWTvmHSpzoRCJOOUyEr6h28NFXc5kKfK1PEAp1h9Tn8ToYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767560020; c=relaxed/simple;
	bh=sK5xKgJux8sT3Sx9ZUS8NtOGkJPrQ0I7tH8PhjrPm4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHB1ufjH4CB+sAd5TwM9QhKpSwuKcajNCywVjRRFitNGXVcE00MfNFDF+Gk0pOFhu7HjBFEjmuqGiuD2E6bxXBtGnDZfKe5Oqeqok/l0o6fctgWD/HPEyXoT20euLY8tOsch6zioOtSqWWNj/cEfil58fNXWTKFtl+vz+KPi2Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gn5YfUlS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a097cc08d5so36093725ad.0
        for <stable@vger.kernel.org>; Sun, 04 Jan 2026 12:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767560018; x=1768164818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sK5xKgJux8sT3Sx9ZUS8NtOGkJPrQ0I7tH8PhjrPm4A=;
        b=Gn5YfUlSE/MZYy058WhEIaVWq7NaQKUZD8l3Aux6Pl0aC6r9507k50CKLswafbHRpN
         tKzmyO0F9R6LHvkZMPSXPupYBsOmydl0bDSAzZqktg3da3wVzExGlc+TVtilZwPKHgpM
         V1dQvqFgOpaYwXFkbQ5yTX3RvKxOMwblQghyYFqT+krfjRa5GGYc05WrHvkssxgpoC0q
         u/0kTjfXGXdcOg5LiS5GlXrLldJa3sS9of6oy19Bkw1CkROhS+PKzzVtLzJx0qOTpc9Z
         GU+WDfyyN+Tkr7Ui+5LmyVH0DkMSii0bN8LFAt6ZsnYSlTZG/Dc4D+uP/0Ec2fmahWfV
         Lm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767560018; x=1768164818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sK5xKgJux8sT3Sx9ZUS8NtOGkJPrQ0I7tH8PhjrPm4A=;
        b=og4d3oKOfQX6HCAb0fKMZhdxHvgxoDvlri7gpVy2aSkhI2jgNi9Z1GmI6mEXi7m/TM
         OMM/VRajAK3ZA+mJcxdc0MeXPxd5Li70eh8QsdjaNiYT/hzeQBbDxErsSFYLG4uxfUBo
         eb4vGO4IyGPq/txRgX29cuAe/AWX9LhIzCi5S326qJUEg7e9yiYsVMyMKm2oAYL7tn6r
         qybawKkgAoIdz7wHCENsJtBvBI/ZI0oBPbjFbLrJGhKl8OfWZJzY7E2nD0lHFcnjNgdL
         rhZo4qEHOw03U8125MEK8luduepBBIoZOvltmoT5lWlCNn6R+Ao6PyggVIuOd1CKk9QZ
         +QPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6oQpXdBWihg1XuVUUL/ymty88yWfE/WguceEqNCZi07hN9ScEnt1VCmDVZYXRKEb74khVkHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJCz1gV1NYdYNyb2QJw2wA7Ws4DJj9nRV3L9Lc6+92erOBg3Vq
	s3l8G2oOcbTwseyHjPhhx9MYId5GYCq9qCCZExDr0voyZ5PbHKSiyrpuFkBXelLIlZt7R+8q7af
	W6WDy2i98O4QRfg5Zl+X6MQNkBgX0QsA=
X-Gm-Gg: AY/fxX7Itcj2tVdSqLCRvBairhTd4Qw4nIG3NuJIshhz2hetFb6aZjW1GfatLVUsGi7
	+KYvyhFgqljr/ZAO3X5oBzVl3OdmwP70/GGwMjWSe+DphcHkLFnXweD66CHscIIPA0E479HR8HJ
	XeP2LxUDQbOWd+67qAp0uwABinxLdPA2VNJ9C5eaHXUypwsZeDeONuzZngy7cbrVOntp/O7aVFx
	pj+8zVtPJPqv3kRLtBtdqZZjS34G/KEyV8tr8TwRV2UF5J3tBu5lh8hk4RvDkrHHuYJ7nAWwfqb
	0c9i15IYvB7XR4LQ6t5rkKibn1wWRdEz8lhn3xtoBE4/kmuxOqLBGQBH5GwljYzeZk/nEH9zGB9
	zqn6hQrrF+0OR
X-Google-Smtp-Source: AGHT+IEY5WU8qdT2x4W9RhyaoUAIxe/Revt/XcUhrg0fBmvqp9LK2uRUv+DpO1/rHFugYJh7v9P+cWIgLbf4IU/ffNQ=
X-Received: by 2002:a05:7300:e9ce:20b0:2ae:5b31:5dc with SMTP id
 5a478bee46e88-2b05ec6b143mr17044785eec.7.1767560018452; Sun, 04 Jan 2026
 12:53:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217150010.665153-1-siddhesh@gotplt.org> <20251217224050.1186896-1-siddhesh@gotplt.org>
In-Reply-To: <20251217224050.1186896-1-siddhesh@gotplt.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 4 Jan 2026 21:53:25 +0100
X-Gm-Features: AQt7F2qb1EDeyLmlG9hUTUI1fBPD9sLv7nfHHvfBJvOJxdTKvQkzrqD3Rmnu53k
Message-ID: <CANiq72n0BtCxAsXOaNnSMWC-aW2bNTPzN=4VGb+ic8YA6jhsAw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: Add -fdiagnostics-show-context to bindgen_skip_c_flags
To: Siddhesh Poyarekar <siddhesh@gotplt.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, stable@vger.kernel.org, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 11:41=E2=80=AFPM Siddhesh Poyarekar <siddhesh@gotpl=
t.org> wrote:
>
> but clang does not have this option, so avoid passing it to bindgen.

This looks indeed correct, although it is not yet in a released GCC
(testing quickly in Compiler Explorer, GCC 15.2 doesn't have it, but
GCC trunk has).

I will apply it -- Cc'ing ClangBuiltLinux and Kbuild so that they are aware=
.

Thanks!

Cheers,
Miguel

