Return-Path: <stable+bounces-91696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 469D39BF40C
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 18:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8591F21967
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 17:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E391DE4EF;
	Wed,  6 Nov 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="06BEoH30"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197BA20605D
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730913055; cv=none; b=HhgJsdzx0A+fis5DKFhTxdNG2Q4VebeQaxHmOoG3DiLM6tqaS8x9k/Toe+mbK3t8q73T9HdD/OYUFbcUx/u/xoNSEL8bPLkbgI6Hm1wjpm1Qa8Nrq6NvW1W6tE71kPZ0ALAMWScxrcJgDmiXDnCDvL9OxV7KOcvgwZn0a2Wn2H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730913055; c=relaxed/simple;
	bh=FvukfTEL1bWKjDoJ5oZqdA2GnBijHiIPloa6eleGgNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+Kjxphjr2dbZBthzrQhyTvSExME7mJ+CIHgualMp+XquJALHkPsx17iTw2YC+eXA2uedZnx1TOubdNdFEgSgwUindS1kNympVapR/5O7dhdCnBJyOAy4yjDOsITvZVPcelNco/ILon7sxJcAmuHeJum9TibXT80KqYF4daMYEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=06BEoH30; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460b295b9eeso256941cf.1
        for <stable@vger.kernel.org>; Wed, 06 Nov 2024 09:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730913053; x=1731517853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsE/7ZCffAQOi0z4JToWVEIJiFwRhc9hxIYYUSyZtO4=;
        b=06BEoH30Ox/FdqaIm9pUKAD7g1K+Ts+2kIPBNud5GlYgSV04N0pBtQz1x2+E74+IM4
         1kmDXprBUgwIYxHMGZplbm2QeOEpuhXH4l2mBmAqZTsV4B0g2iHbZICdr8smXvUrICuk
         0pmkOCG8k18eo1V5tuxBxuzXlQ6P0SX70w3pcxTNshjMwIhK/6j4Pqx69IdyUP9bP1U+
         2MOlGURiCUPkZukFmUdXBMBkKNPc41rO7eiX6iSwEbLRWvWi0AmbKsHwPkCy/bir8yFg
         RUmRhVS6O8m1H4b4+dw6C8Gw3pN4n5d+D+XWEWYj7Oo9J27JWu3BYLTVHqAdf0ds+obb
         VlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730913053; x=1731517853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NsE/7ZCffAQOi0z4JToWVEIJiFwRhc9hxIYYUSyZtO4=;
        b=fOMwMecNBdJCb7AtmMx4NqYNqcoOAk82lvp2DCVQkx0zdMXFr2pfLkRtST5uOSlEDE
         /Q+NTirm0RYkiFLpXrhRbUVHvHZMySNARzH+v3v+++dXXOW1+dnvuNoD9A+6rTHJvt6b
         S9tQvk4C2HWmz7fUPTfJdWxiMrnT+KhuiCAw22+3qyjY+pnxN6zwGDCJ1g3lf0JW0ORt
         kwOV1sHdLUsebPiKjc6Yz/njFwE0GG9YHOp6UXibSul4G69TLumXtFZAq30mPMd89QUI
         uIdvUwBJcTKVIEGltOtguZZczegKH8vMsx1mK0nWxdLjM98q3sC5RZsKf9psJlNb14BZ
         ZNiw==
X-Forwarded-Encrypted: i=1; AJvYcCUkP0lUzB+JmUYjCj1VpscqwYCfOD26O29/XuTOgEdibRxxYVFV1BxMsYm/L885IgxKfuRrGyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWKKJNpBrhl8BOU6r82fr72AW9qxxpZ0m60RgTNTS13QkegD4v
	BCA2SPXj1y5sEMK7tAyaUXCEv8NOZcBYXyr54tCzMsvo/zlv/IAd4q3ZEJ6CQBYeXGZgWsrVVAr
	fi5FcL8CNlmznXj/4/ji0NA9N0lev3z2p2NhQ
X-Gm-Gg: ASbGnctgTXw3o4emAkcopFaLsPbdZSd3u3/4mf1viuSgt6lJL0cIfRpZoljgjlKJKYf
	rWGVD8ubOfNqMewK9lkgSq+H74zqcB5TCEnml7WFjtYxzlAXhIsjGwj5keDhi
X-Google-Smtp-Source: AGHT+IG4NFWbvUtyY0oIvxTGrRJvSWSDUntbD/9G9q1gPP6/HGFidIeO+LQ7lnPUeNVHrPTR1fHDJnk7auifJQhCPjI=
X-Received: by 2002:a05:622a:528b:b0:461:3e03:738b with SMTP id
 d75a77b69052e-462fa619d72mr555381cf.19.1730913052708; Wed, 06 Nov 2024
 09:10:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021171003.2907935-1-surenb@google.com> <2024110639-astute-smokiness-ea1d@gregkh>
 <CAJuCfpEAKAePqbB74j8iCQ1JXrvZQbELkAMzdT7dWtvdros-Eg@mail.gmail.com>
In-Reply-To: <CAJuCfpEAKAePqbB74j8iCQ1JXrvZQbELkAMzdT7dWtvdros-Eg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 6 Nov 2024 09:10:41 -0800
Message-ID: <CAJuCfpGf8xz9Ohsh2mtbyWc7xEU1QSSQapoQ4ZTwFfiJLmPNMA@mail.gmail.com>
Subject: Re: [PATCH 6.11.y 1/2] rcu/kvfree: Add kvfree_rcu_barrier() API
To: Greg KH <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, fw@strlen.de, urezki@gmail.com, vbabka@suse.cz, 
	greearb@candelatech.com, kent.overstreet@linux.dev, stable@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 12:20=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Nov 5, 2024 at 11:09=E2=80=AFPM Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
> >
> > On Mon, Oct 21, 2024 at 10:10:02AM -0700, Suren Baghdasaryan wrote:
> > > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> > >
> > > From: Uladzislau Rezki <urezki@gmail.com>
> > >
> > > commit 3c5d61ae919cc377c71118ccc76fa6e8518023f8 upstream.
> > >
> > > Add a kvfree_rcu_barrier() function. It waits until all
> > > in-flight pointers are freed over RCU machinery. It does
> > > not wait any GP completion and it is within its right to
> > > return immediately if there are no outstanding pointers.
> > >
> > > This function is useful when there is a need to guarantee
> > > that a memory is fully freed before destroying memory caches.
> > > For example, during unloading a kernel module.
> > >
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > > ---
> > >  include/linux/rcutiny.h |   5 ++
> > >  include/linux/rcutree.h |   1 +
> > >  kernel/rcu/tree.c       | 109 +++++++++++++++++++++++++++++++++++++-=
--
> > >  3 files changed, 107 insertions(+), 8 deletions(-)
> >
> > We need a signed-off-by line from you, as you did the backport here,
> > please fix that up and resend this series.
>
> Doh! Ok, I'll resend it tomorrow morning. Thanks!

Added SOB in the new series posted at:
https://lore.kernel.org/all/20241106170927.130996-1-surenb@google.com/

>
> >
> > thanks,
> >
> > greg k-h

