Return-Path: <stable+bounces-100259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AA99EA0D2
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 22:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4311661F3
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 21:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142B017BA5;
	Mon,  9 Dec 2024 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krrpZWhK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8A5199FAF;
	Mon,  9 Dec 2024 21:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733778364; cv=none; b=ONz5YqbldMCiS8ilnIwRjOyqwS5vjSj8jSpzAGwB9UbEhumjHifRR4aUBBbg8lo55rmhHlVwC5rFKZ3AssbuSluFNfUGzVx8WDe5+TvMatvH5un2nz0EWQK39qnbbf/OF54y0DgAPESPc5cQhRAfKZTX9ny4iIc1MoW3/McvPRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733778364; c=relaxed/simple;
	bh=IQz7I9YsENov3q06x8KJv/iXVsOJdNRaOPPv+jZyDqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=osSWit8YtcEuBQKRYYSbmopt+f2JH0ssMy3udjrRiXcDxaW7U+HYGpck9O4oEyditghdx3NpMTl4qhEyEOvIcfwq1CFL/eV4/N/3IASp94qFQ/FWKUDGMDm0QB41FB4smoE7bxik2x+JTQ7PSIyFbHNoYg8o3rQ/pe27u4ab7+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krrpZWhK; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ef7733a1dcso554595a91.3;
        Mon, 09 Dec 2024 13:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733778363; x=1734383163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQz7I9YsENov3q06x8KJv/iXVsOJdNRaOPPv+jZyDqA=;
        b=krrpZWhK4L0pTSWxdNIzHFfjColUWfn5UOUjEW+hGWXe9NErZxedkURooidQ9ozQ9l
         RTskK/9XlPqED919SVC4oEEkVTXyMLzixPeLgvu7E1CQjGLwl/HyWKt9zj1opLaN+e8C
         K50FFQvRSgKIyupX159vt540Yi/joJOeC8GbyFTgMtm5TY4xLvauKpCFc4Rw5fPW3k34
         n27XzEglZinug+QS/F5e1cLJoVA1bzpPYFq9tjRZOQBE/Ut09imbbR1w/ILlZG/T9vmx
         P3tSj0piWcaOK7dvSKTHhOjCl1J6UbtsSAD8Q/SMKfE5AKgWUW//xxkx53k/VsAAu8Ws
         aRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733778363; x=1734383163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQz7I9YsENov3q06x8KJv/iXVsOJdNRaOPPv+jZyDqA=;
        b=WNq8fBZton3KBKZr+IjzUTtLA9tfvDrVlvGubvAXoPQTI2GSqfOle/a7ths1YjvyNe
         lpuTXb2N+7Sw64JWxcV0lJglgak8pduouvu7Sy46NaENqePokSsw+WixzaIGkAmdLdW2
         nOMFNZpLlN47ACMQQDhzhUBiCl//s0JoHcTVnr6Wx2kRShu+Gup1zMvrF0WRGn3fe5aW
         Z3bVttGI1w9oXFFf3B3HjtUE2aonkII2RDBsBIhssyiC0aIJtwoV6wULcOqWSSOLQmY8
         v7H4YJHdEPm8uhaC2QC5BnkOLkn81JFrdKAoCwSQLo6MuQKZvr4Ly1GkVYTeK+q5BZPy
         EopQ==
X-Forwarded-Encrypted: i=1; AJvYcCU73v8QKoFBAI+cErnlnOQOFi4qvULrHYBLXLF8rZKyF39UBGpBF3dhhXC5J7sICOmSoLxVG3HR@vger.kernel.org, AJvYcCV0iFL3LuVcCZJIuqQL0oeS+PHJn3RK5YB4dlRlb/8121LLUQ2ybk017ZA560ClhauoCHnAIFd9pEiR7tK0zc4=@vger.kernel.org, AJvYcCXUpD/4QmqXpnxkShBsco8qi7K2NGZ4pWL5/vM0Zamr/YRciEJTGdSYENjyoKIg6Qt05UfLzYGjRnSnFMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4hYtmJMjLBc2IPVhnlgJ9cSzCsL3HEcMwFUaoRGphna+PSZzp
	T+azFRo68wEMB1rVbxjYEVeK37LB+sQ9xJIR6RqCG7LZbvx5frRf+dFhcLHCyybK/Fs3slk3G1f
	bkw2kFXDiJ21Ih0GlnuPvJdsUIcc=
X-Gm-Gg: ASbGncv34KxgcVR1uEsXB2uq38PewtE5bzWNqsUz9+/Fw3hDhKqOGxFKY/dYAjqW/Yw
	b5kvfcrIcVMzRVOxihS67b0EcQBcWXUI=
X-Google-Smtp-Source: AGHT+IEJuFSakMcUFac7J+27s9Uiqv0/HxdJEeZ6mEWsh67Ic0D1Vr0Ysw5dq2xEnh2AhHs3kAjxKYrNJLgxZGF1gY8=
X-Received: by 2002:a17:90b:38cd:b0:2ee:6a70:c5d1 with SMTP id
 98e67ed59e1d1-2efd484c303mr569161a91.3.1733778362678; Mon, 09 Dec 2024
 13:06:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125233332.697497-1-ojeda@kernel.org> <fe2a253c-4b2f-4cb3-b58d-66192044555f@redhat.com>
In-Reply-To: <fe2a253c-4b2f-4cb3-b58d-66192044555f@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Dec 2024 22:05:50 +0100
Message-ID: <CANiq72=PB=r5UV_ekNGV+yewa7tHic8Gs9RTQo=YcB-Lu_nzNQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panic: remove spurious empty line to clean warning
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 10:04=E2=80=AFAM Jocelyn Falempe <jfalempe@redhat.c=
om> wrote:
>
> Thanks for this patch, it looks good to me.
>
> Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

Thanks Jocelyn. I thought DRM would pick this one -- should I pick it
through rust-fixes?

Cheers,
Miguel

