Return-Path: <stable+bounces-131816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DACA81218
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 18:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5A5420A5B
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 16:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A1322D4F1;
	Tue,  8 Apr 2025 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mw1SuTOl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDD01FBCB5;
	Tue,  8 Apr 2025 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744128995; cv=none; b=cmCPEuWC7h8QIeN2QA/5zlSknWtdXCXx83OgHyGwzFVLV/nkdKtJrXfBDaXY5x9P/AVvfQasTQ6bfraTJtfGOqnbKLmJ+44uoYSTyE3Rf/9IXJbEux1j4NOvLdoqeD0LKpQvCFlcPAqOExBnZvSi2Z0ctJNuBBCQb7U92rqn/cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744128995; c=relaxed/simple;
	bh=orKI4QzESD9wMZ9qw0qgUjTGnwjhL4kJhX0jIVv3AW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9KDkcftvKywS3hnZDKRmR+3SHCGP+6bi/TqGMlr8xghTK4n09HB4OUKmUCJ3q9t2k8EZNMDcEwD4ZBIav2BI6OQtDEEbmV5q9ngjMmZu9xarT9gordexZTbvbx0/MT/d3mLv8n5EOX3lZTlHb3qkpRz4VuHtCfmho97wm6DuOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mw1SuTOl; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff5544af03so1573272a91.1;
        Tue, 08 Apr 2025 09:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744128993; x=1744733793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orKI4QzESD9wMZ9qw0qgUjTGnwjhL4kJhX0jIVv3AW8=;
        b=Mw1SuTOlgejt3eDlJwDL3m/6Il3xdvGlby1JvDq06TPUyr8UnKZRuM6BRcFhGAk3z6
         Q+DbJXx0uNiJVUa2x4K5hZZ0LvZROkokQZgro+hr44gH90tQPitwtoe6KIQPeiQrTztk
         3jNrBJDD6uSkbaw/EQVhXGQUy4v5DlurUiyBpUcUKNerPHU6BEw4mko+Gu+G2rscfSj2
         q3Xy/VdZahk5YHBFjyoWz2JdegwdJRfHYBIqCYGQ0QL5w2glsQ+RUgmHyWz9hQBW5+9F
         9xAaArUg7KxAr9ZxqsXJw+uN1fr3U3BTK9iABoyK3+pYkvAZS0i9P8HkpND27S20Vbt/
         65LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744128994; x=1744733794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orKI4QzESD9wMZ9qw0qgUjTGnwjhL4kJhX0jIVv3AW8=;
        b=q85CQwnEXxvezbKxDy626CIs4VxTPlH0QGCN/H+cUQg9nX9TDbGx4kxOfs1rILQjFy
         oRUTEGv0YrmmITl+cieT/XdC98aFIBQU9S7ig7mxEi92Xy6r2NeWETE5Bm0Rwz5J0IWg
         DMg224tWnc/PzNqf/a3kZWwESWLPGDTYOfdG9slkTVYeFMyJiqe6q7gUB63GdlGMDFoJ
         ErR1tOBwFGSeo+oQ7HPsydBzmhBfAnGD0ZRxC8uaBUR0IBw6TaVqO63EKxMtbPw/Wm9J
         HdrOmE656TGetZAiGPk1gkmVlgh8ZBCqh6nZPi+rSyLun+fzBjg8Sdtdkc2VoHMJnU7A
         EhJw==
X-Forwarded-Encrypted: i=1; AJvYcCUdYCn2iPXMVVfgANA2oh2O+2yXhifXR9xscUi+FjxInPhN2/SfQYPUQAZ2uKc82K5FpCJ1Rrzm@vger.kernel.org, AJvYcCW/912Vdy2TMzVSpo8w8MdDxPAhZLLipmNhBhQBf3d/rmY0XkhnoxV0SFJk38U0THDKn3QyBZo7ufK7ZtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM1mQz942vv/WL3UGfQvmqQWqc9P1986/mtctx9xD826P8XLm7
	T1mo+jsm2ihW/F5qwh5l/mDeguMB+dcPwlXvLP609+JqZjA6ygPnDJaIIGcF7UrkF+NqfEx0vRJ
	air1cltsni4mvL55d9py4zev5HBRZuZauWGY=
X-Gm-Gg: ASbGncsVFhIfWUrFNpifEk9WOxa1W61Y3EskX/MrLqsIKlc+Wy3eJOTnnRbbqS7lIh2
	s86gG/Z+gD9IHF7xskYcS/t3UtGO2osNDIrWsKe0ie/TUV+jQQX/jKQbzeoSpKPRoKgV5TQ/3t4
	+UV+rdFTtU9ieeoFR1UWJO+sIIuQ==
X-Google-Smtp-Source: AGHT+IG7GKgG8uZgOht0grHnJjUWE279jQAy3IeEDlgXFafHgHd+Rpu55uKmDwcd9TusFiye4aB0C1+lD4wymKWfH/A=
X-Received: by 2002:a17:90b:1648:b0:2ff:7b41:c3cf with SMTP id
 98e67ed59e1d1-306a4975f51mr8705504a91.4.1744128993599; Tue, 08 Apr 2025
 09:16:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408104914.247897328@linuxfoundation.org> <c06b17f2-fc80-47a9-b108-8e53be3d4a76@leemhuis.info>
 <2025040857-disdain-reprocess-0891@gregkh> <5924f2d5-1004-4f7c-ac20-3cc7752e5452@heusel.eu>
In-Reply-To: <5924f2d5-1004-4f7c-ac20-3cc7752e5452@heusel.eu>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 8 Apr 2025 18:16:19 +0200
X-Gm-Features: ATxdqUEySsXlfEC3HRl1p0nHWAUIvYJVAkFIwh7FAcER7rJJwEaHGvlhX1UeRgQ
Message-ID: <CANiq72nYw+XkHfRZDvS0GceTunxZXqiec2GXeLbPXvPK9OiB8w@mail.gmail.com>
Subject: Re: [PATCH 6.14 000/731] 6.14.2-rc1 review
To: Christian Heusel <christian@heusel.eu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thorsten Leemhuis <linux@leemhuis.info>, 
	stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Justin Forbes <jforbes@fedoraproject.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 4:53=E2=80=AFPM Christian Heusel <christian@heusel.e=
u> wrote:
>
> Thanks for pointing this out, I was also missing the relevant
> dependencies in my build system for the rust parts in the kernel to
> actually be built .. IMO it could also hard-error when you specify
> "CONFIG_HAVE_RUST=3Dy" and the tools are missing =F0=9F=A4=94

I assume you mean `CONFIG_RUST=3Dy`, i.e. to remove
`CONFIG_RUST_IS_AVAILABLE` and simply request to build with Rust.

And, yeah, it would be simpler and it would prevent the issue of
Kconfig deciding to automatically disable it due to unmet
dependencies. We were asked to do it this way back then, but perhaps
the sentiment has changed now.

What you can do meanwhile is e.g. explicitly check that `CONFIG_RUST`
is `y` after the kernel configuration is saved.

Cheers,
Miguel

