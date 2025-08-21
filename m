Return-Path: <stable+bounces-172211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43837B301C2
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 20:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B118A6001BD
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 18:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A594C6E;
	Thu, 21 Aug 2025 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPvy9a0Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF7B3054ED
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799912; cv=none; b=MYBJ7O77Po83QfB3pvX7y8h9sHe8EUa+YDirGI+pf52zGeLK15ETXXRBHp1RgOHPH0ca6wNcv8itqGULJJcCFdeIyl4piEqkysPZhoKC9LdgxKjfNmGwRsLOaJELzAkeJgezZbCsS4QkyQyo6OLUivf2xwL2ET/pDvLoqPvWKmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799912; c=relaxed/simple;
	bh=r2Qq0121Zy7qmPJtGbjdDDoRVirmmaNtoOkITw4RTvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5M58bmB7VsUqSRsGZ66edrJgu2T66lInIW3BphUlGR2bOxewNuZ6MVhCDlARuaJ30OfzpIM6IuFZMme8NBmF/Ul8GSkLDT+fx8u2tJh9Qf2RVbYUL6A0aEoXImlBJVq1XH+dF2CKDdYQVDN/06wjeEp4toKKolcQjT0tDhRWGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPvy9a0Y; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-30cce5c7f1eso1128294fac.0
        for <stable@vger.kernel.org>; Thu, 21 Aug 2025 11:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755799910; x=1756404710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQkE0seXAq/T3Nrv5ePjrAqrwGHMqBbMT9R5vFioxIk=;
        b=UPvy9a0YqE7431zlYAxBmmWySCbLnXOWvHF6dGWNMbzzThjjPimfEmUd6N/AnGHK7T
         LXi6LcWXo7O8ENzDw7LBF0mue6DkzYKxf2l3Z3cv+GBrJasAylKNcpQaqpMB6iy5HEua
         dMNfkdr9yRCCkcWBepBmTXfAdcymQ3ihbUVlT48eFCYYjMtGG07U9y82m8mshrZeLIu4
         YmscIZNpP1gKxfIlFDwdj9rv9nHP+N0hurBiofTKVEn6M6/xtx2Bbdb8vdMq+HdYgdbT
         XPRSsdJw6fXTLfViYYm+lPrn+NSrttB2alAYcXR8MOuTJFzr2Q2XAy+7ElWmErxkrkzX
         diDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755799910; x=1756404710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQkE0seXAq/T3Nrv5ePjrAqrwGHMqBbMT9R5vFioxIk=;
        b=r4dbyUibXB0+/HgcOgwYhwnHuGbuYYktlaFaLiZOohexm9vNw19rFLyGIX3wo9pRCv
         n0dbk/o4e9mG6a414R+G9SEcXiImecNMwWxsLnvKvYL1PajjYncEQ4Mxt1/RxkLg5F3K
         Zcd4CCyZn76zdXyn08N/fXYibEGj9NeqDA38G/TJ3RMiTvLWqLCjSzS7iAns/bMxb1Ec
         wZWvzXUmJ2hy3PLFNls1VAFFMym9onYLCJ/kGKVD/+8pCIkF0WhNG86XOlCuSsJY5zm+
         HwC3cQEnHIy3nGOQ9bukFpSuxO8p7gySBCJsF0BBhazjcY0pifU9WdBRIJ6eeKL/Z16q
         29zw==
X-Forwarded-Encrypted: i=1; AJvYcCW2/ImS5HhdG9d52laMJXYcIC7eeqepF1493M/7isUnwqO5EB3yLt/usl+OZ1NzHuuF1fkNRCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt0hqXRRm8Qk9hevL+uVGMBa/qUuAFkUeVXHzHLofeF+MIbQyJ
	48h2vK8sA6PHx+P+4zEHiXuTGb8p0599xtwVjYpKlWA/WVGZ2VKp7R2ZYXB9p/LKxTa/dZAHc5o
	AAJxoZywPXJ4P7tcn3TPz5/7cd5LIkfuG43Th
X-Gm-Gg: ASbGncszSuhwiot/+Xo0yqSVJcEt6hVWPDjL63IHQGwuMHW+Nw68xYT1u7TkLjP/Oxq
	CuEosCj4K3/E432a3PXVrGz8HmwwtRollwkTKF9P77xb+MT+lRgql9h4wnXMkH9/SkAXj0xHcY1
	CAbV8BbGLdS24A5GITyz+GfkPFoM324zZ/P0n1G4Tb/p7ihGZSlDRtVQuRbT9sHsd52Y1Kbgp94
	xMR
X-Google-Smtp-Source: AGHT+IH5cYePY4LWF+yUbkxUmI19KRzSY9VkjyJnD/MWSa1UbpylRasKtorNCTewDJ8FF3suBgFD7LYcg9l9HBkHfr0=
X-Received: by 2002:a05:6871:54b:b0:2e9:42a9:be4a with SMTP id
 586e51a60fabf-314dd38b1e9mr45823fac.2.1755799909600; Thu, 21 Aug 2025
 11:11:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821163346.1690784-1-ekffu200098@gmail.com> <20250821175307.82928-1-sj@kernel.org>
In-Reply-To: <20250821175307.82928-1-sj@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Fri, 22 Aug 2025 03:11:38 +0900
X-Gm-Features: Ac12FXyjW6YGm8vBrKSBZJTi676GRJ_lE4WNPgVhsOLOvxK4NT6otMlFppJi6xE
Message-ID: <CABFDxMFk3TbzOcZd8tgLJtQTav0+7=BV98f9=YVYfea9ngCsEA@mail.gmail.com>
Subject: Re: [PATCH v3] mm/damon/core: set quota->charged_from to jiffies at
 first charge window
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com, damon@lists.linux.dev, linux-mm@kvack.org, 
	akpm@linux-foundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 2:53=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Fri, 22 Aug 2025 01:33:46 +0900 Sang-Heon Jeon <ekffu200098@gmail.com>=
 wrote:
>
> > Kernel initialize "jiffies" timer as 5 minutes below zero, as shown in
> > include/linux/jiffies.h
> >
> > /*
> > * Have the 32 bit jiffies value wrap 5 minutes after boot
> > * so jiffies wrap bugs show up earlier.
> > */
> > #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
> >
> > And jiffies comparison help functions cast unsigned value to signed to
> > cover wraparound
> >
> > #define time_after_eq(a,b) \
> >  (typecheck(unsigned long, a) && \
> >  typecheck(unsigned long, b) && \
> >  ((long)((a) - (b)) >=3D 0))
> >
> > When quota->charged_from is initialized to 0, time_after_eq() can incor=
rectly
> > return FALSE even after reset_interval has elapsed. This occurs when
> > (jiffies - reset_interval) produces a value with MSB=3D1, which is inte=
rpreted
> > as negative in signed arithmetic.
> >
> > This issue primarily affects 32-bit systems because:
> > On 64-bit systems: MSB=3D1 values occur after ~292 million years from b=
oot
> > (assuming HZ=3D1000), almost impossible.
> >
> > On 32-bit systems: MSB=3D1 values occur during the first 5 minutes afte=
r boot,
> > and the second half of every jiffies wraparound cycle, starting from da=
y 25
> > (assuming HZ=3D1000)
> >
> > When above unexpected FALSE return from time_after_eq() occurs, the
> > charging window will not reset. The user impact depends on esz value
> > at that time.
> >
> > If esz is 0, scheme ignores configured quotas and runs without any
> > limits.
> >
> > If esz is not 0, scheme stops working once the quota is exhausted. It
> > remains until the charging window finally resets.
> >
> > So, change quota->charged_from to jiffies at damos_adjust_quota() when
> > it is considered as the first charge window. By this change, we can avo=
id
> > unexpected FALSE return from time_after_eq()
>
> Thank you for this patch, Sang-Heon!  But, checkpatch.pl raises below thr=
ee
> warnings.  Could you please fix those and send yet another version?
>
>     WARNING: Commit log lines starting with '#' are dropped by git as com=
ments
>     #16:
>     #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
>
>     WARNING: Commit log lines starting with '#' are dropped by git as com=
ments
>     #21:
>     #define time_after_eq(a,b) \
>
>     WARNING: Prefer a maximum 75 chars per line (possible unwrapped commi=
t description?)
>     #26:
>     When quota->charged_from is initialized to 0, time_after_eq() can inc=
orrectly
>

I will fix it. Also, I came up with a way to prevent these minor
mistakes. Thank you so much.

> Thanks,
> SJ
>
> [...]

Best Regards.
Sang-Heon Jeon

