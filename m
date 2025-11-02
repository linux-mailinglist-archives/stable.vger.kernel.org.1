Return-Path: <stable+bounces-192093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C62C2986C
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 23:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9583AE1BD
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 22:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256B821FF35;
	Sun,  2 Nov 2025 22:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9oUVqV7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6872236FD
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 22:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762122052; cv=none; b=PfGv8N+6lehkNK6rPpl9pTZ6UX+v/SaX8o3UkK8HeQ5EDElucx6dWJYvtixsERvQTo8YPEhwi3J86YbqOfK7ND893PZdVaXBAO6r6w+tbF4nTqiHXtMW35HK+QVwAOUV+NHK4stL7i6UkvqD7d6jenDMungnBuuVKcjQnQ8uBoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762122052; c=relaxed/simple;
	bh=WT7V+mIh7biSb9hoQQKTPcN5LrBBwROnmw3huldzWHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vvn6a3QlyWJTtN+Omov2LogrRJckQCGWAN74N1sRqCaMOZtNN8LlSZQj8yxfDXPyXytxUeTQ8x4a2jsMHC5Upn63PKkN5n68chGT4fsataUdCWzVUms3rLnjU+LUkEY0ok4RgVzDZq2Jrlpjx2iivEFYy1FrBlzL0qCXDfVah6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9oUVqV7; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3307e8979f2so679531a91.2
        for <stable@vger.kernel.org>; Sun, 02 Nov 2025 14:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762122051; x=1762726851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldh/rrZAKoIw8nkk3grHKnCTpuj+wVkO9BtM8FlPSJs=;
        b=X9oUVqV7P1rOUBrqf086oFJ51nz318w3F3ADuNBXg/gWop7pmvDi34Sq9j/PWbDrmx
         cgRUQD0YzJNi13LkMEYb++llpAt0BteLJpoyTbHfeABNE3AyFMPjkJG1rbI06lxkniZP
         NgSnoKp6tLGjLAL2Q0MVtOZKacBQwyXZriOu6K5fqSdtW1GlAVJQiwgHYJ0gM19XOnW0
         qDZutohzS7lzLziaPN0GCwRN8Mh2/Obky1ZNSOL5c+U10tAQTs3D28oeShHE4N9qY1E9
         /KOfiDqtCyZk+Ko8JMN0QEuCCUnYnFMfCDTueaZxkvUrdMKltok28ktEbeLYXnNwOIlR
         e7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762122051; x=1762726851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldh/rrZAKoIw8nkk3grHKnCTpuj+wVkO9BtM8FlPSJs=;
        b=pPYxkVL+mRuLOaibgTlitfSwlNtyN/awhmboqUGfws71LN1kGbZKdnZ8q3Cy14+DBY
         +AN7Xh4Q/Jl4Dy03gCIp+Btvb2CCaa8bwwJd7ka/lBu4f//oCqoKRqi7VG6X5VZzMPmp
         RjSnO+N2+MXcU2Ge75Vggs1vn9uz0Cn0VSVCT28aaYjnPCr/e3+e8CaMoIyt3hcXaufr
         9kX6ex5cornSTgsVnGVrUMvWGCKQ4GUsdk8qtClZ2vgBKo/VWw+brWH46FxbJPs/A4rd
         mMO5dIGZrwTIe9xQ19jfmeEXELMZrtS69HgCT6Fsf0bpOdILfMUqjwAhvMJvn6Twd/p7
         +ksQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcm9I2ztg+Ax37s56MiwTvfTS5edZ/879xO0frt+DC5wZa8m5eNnEbr6oA7PutWI6LWbP1cpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx+RNEma6oieizrZjMalytErRtm1DMcdPA5AvNMtn5yRVp3kjw
	ZycrSIm8jSp6GPJ9aTlU9zmmoB5f+qgEJCdVMbWSXBXdEOsjHN1Pl3bSeJMIJAnvAi9ggun97z+
	gd98gdilu+8VFq7HIrFXB7qzHD/+ezkc=
X-Gm-Gg: ASbGncv4Md4Pxlq744QocYk2T3IxUB5TTDMIqWP8atgQDxLvDcOVdqI981WysEN3kBB
	Fg3rE5+8MHDLvE3nBlFmyyrk9++D7ZURS4U3vXicGSXvvNUWEdaMmK+Hj7l8PI297Ee5l49NSfL
	/+KY7Vj+QblPoGtU7x2O2Ip5fgfWoxhUc/IiaVLnp7FPs0rwocTm417+5Ima35vVMVrgruU7WRT
	U32fxL/mjZtXyhZmSIU/3gDMpRkCf43ifncgOBBWet7coVK1WtJySPEwdSivgJTiQGSpBTGiLX3
	UXTVEcJ9Pr1Vw9xAJ7UJEmVEnKCKisrLx7c4kZYNrK7fpm5IIsPP+e2bKLgzGglwzg51tp/jsC0
	PWJI=
X-Google-Smtp-Source: AGHT+IHryhoTOrFuU+nX2/XXVf7kh67HIj6pJAwGZM07cNYk4Ch5KXgJowgB3YhvDy4LBmrqXMtVIjcCmU0HL6FeUno=
X-Received: by 2002:a17:903:188f:b0:27a:186f:53ec with SMTP id
 d9443c01a7336-2951a4da98fmr50067215ad.9.1762122050659; Sun, 02 Nov 2025
 14:20:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029071406.324511-1-ojeda@kernel.org>
In-Reply-To: <20251029071406.324511-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 2 Nov 2025 23:20:38 +0100
X-Gm-Features: AWmQ_bmo-1G4gStAz5BNMs8sUlqk3doCuOqq-d5OyHMqc8oaNkX_-Dz-ZcwIf5I
Message-ID: <CANiq72k-7f91kNrAAnwFoRYyFYjRB+mo3PCRFzTkn7E-7xrCNw@mail.gmail.com>
Subject: Re: [PATCH] rust: devres: fix private intra-doc link
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 8:15=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> The future move of pin-init to `syn` uncovers the following private
> intra-doc link:
>
>     error: public documentation for `Devres` links to private item `Self:=
:inner`
>        --> rust/kernel/devres.rs:106:7
>         |
>     106 | /// [`Self::inner`] is guaranteed to be initialized and is alwa=
ys accessed read-only.
>         |       ^^^^^^^^^^^ this item is private
>         |
>         =3D note: this link will resolve properly if you pass `--document=
-private-items`
>         =3D note: `-D rustdoc::private-intra-doc-links` implied by `-D wa=
rnings`
>         =3D help: to override `-D warnings` add `#[allow(rustdoc::private=
_intra_doc_links)]`
>
> Currently, when rendered, the link points to "nowhere" (an inexistent
> anchor for a "method").
>
> Thus fix it.
>
> Cc: stable@vger.kernel.org
> Fixes: f5d3ef25d238 ("rust: devres: get rid of Devres' inner Arc")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` -- thanks!

Cheers,
Miguel

