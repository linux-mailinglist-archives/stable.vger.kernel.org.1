Return-Path: <stable+bounces-60588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF1B9372BF
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 05:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72A82826B1
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 03:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7198A10A09;
	Fri, 19 Jul 2024 03:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iO7R5T1x"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E755680;
	Fri, 19 Jul 2024 03:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721359522; cv=none; b=TfGRHSpwPH+P+Y39fBZIIb2+1mL15DwTyC4XwzfrR/TZe//2c9nJL8tDyyay7fdq9p2v1+enCH39kLQUYTgWJCyAoCRAw0wi0jbc7Ji5dkiK/x4k2a9DJvkXSlxx26JFTgEkkEaYXgLRUu/yNSM5/II+2t+KUMGYNNXdC0C3zEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721359522; c=relaxed/simple;
	bh=nBbOwNkWp3wBvGnwi2fHed2Wp1/xWtJWN4kdQF3ZpVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqqCSjZiAZkql5vS7/dBkpEj8Ph2GZ7gM6n0ugmJZUAwPeMUSXZbXexV9kJ+1a7FyJdw0NL4gUX/fq2c1DE6k3B1vMxKjiLLsXvz0WH9hCzetJ10GnwwT/wPBgqFVUxViLbXbLVQFsfPO0YlUAOs/sUGbDly+Q1jQsuIdMTdkWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iO7R5T1x; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-48ff82266e7so433476137.3;
        Thu, 18 Jul 2024 20:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721359520; x=1721964320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBbOwNkWp3wBvGnwi2fHed2Wp1/xWtJWN4kdQF3ZpVo=;
        b=iO7R5T1x7mOohxLCWhwr4a4YTg3dviLXZ0YN3NSG7NGW0HykJpVxxiu1HiDODuwbin
         huPbS5eylO0Q3jRJB98TBZP+uf/3Qp7StWupP5iQcJ0VcPWprF1zu9QrTvJrR3KCAI1O
         up5c7vkUmwAKXn3t+p48jwa64CJUZEnMnU2QacKDsjH4t+3Pv3YGS9CgDZ3YF6w1BXQM
         lb1SWkThlB//f7SExxp/NolPJNczhW/6DBdCkJLhOnMq0nTDMwceqnwv1zuIhCkRTE2U
         JVwKNXTo3Qym2pO4LK6zep2omUw5zUkozet9f1Z7pkoPWwFX2ECb7mmrHk2e9Q1dNfcj
         QOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721359520; x=1721964320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBbOwNkWp3wBvGnwi2fHed2Wp1/xWtJWN4kdQF3ZpVo=;
        b=LmGHnMqLaFdqxdYPww11EEXAvDnJfIyPhjOon4500GxAN2e0xv9j7Kly3tENJ7VYWJ
         5BYuk0uRPCJFFavck+Y8ytRQZvHuQ2JR+8Ag7WPRdat3UaSE87rkI4zuxVr/fU/tOhot
         lYr+lvf7yAsKNXZVDkVvp+vFfi/BxjxJryPqGQJ99QO/5efDVbzWYBhvRUAJ8hooLnxB
         o98Nu0wR/8K0z8BuIEPQfuI0HgS2zsI5ssBlT91vSC6yumvhId87TwLhq9F0+ZyEobUv
         SJH2QMCMx/nL9Az8hStqdr9qSamaBLnt5bHA0mNpiP6hQZemeNVQATQSCPz96nlG1w+5
         6dzg==
X-Forwarded-Encrypted: i=1; AJvYcCUzK+ckyw/DqbblvMnU8qPbobHjOduInKfBhcm0so1+WIgzZzLJCTotDuyGVcNZWD5HJXfpM8ZuqYSQ79ba3+C40jZYtvPQigQt1WD1sSKY6dXXcrkGCJWBm/rOeiqN
X-Gm-Message-State: AOJu0YxqZCRPg/hTDJY8MGhafkse5mUNrtfsLpYU1y4pzS+SgfAgfKjn
	J2R0uDU2Tdtn53XhNQGBedNh3A1nBLSa+a3p00jERa1UE4/8e3KybopTeM72VN5Smtme9LpMbKp
	BzPx8QdKrOuwb5dNi5cANxUCGneVYlw==
X-Google-Smtp-Source: AGHT+IG+j6hhbAM7cumaT0fUp9ey8EOdwghQ+oG1Mh+OTdw0VJd8hnFEGbPm/ldn3iy2Zzqq4l+sUJPaJ27je2HffyE=
X-Received: by 2002:a05:6102:3351:b0:48f:2404:ea7d with SMTP id
 ada2fe7eead31-49159906eeamr8720502137.13.1721359518405; Thu, 18 Jul 2024
 20:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718190221.2219835-1-pkaligineedi@google.com>
 <6699a042ebdc5_3a5334294df@willemb.c.googlers.com.notmuch> <CANH7hM6RA1-OLzu8dyz9b7oz+tiOmD0W7NAxyD9=c7qvj=+TZQ@mail.gmail.com>
In-Reply-To: <CANH7hM6RA1-OLzu8dyz9b7oz+tiOmD0W7NAxyD9=c7qvj=+TZQ@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 18 Jul 2024 23:24:41 -0400
Message-ID: <CAF=yD-JWDzc54_2bF2KkvKxDL3jD+COWUDx9_P5DVF7q8T=bJA@mail.gmail.com>
Subject: Re: [PATCH net] gve: Fix an edge case for TSO skb validity check
To: Bailey Forrest <bcf@google.com>
Cc: Praveen Kaligineedi <pkaligineedi@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, willemb@google.com, 
	shailend@google.com, hramamurthy@google.com, csully@google.com, 
	jfraker@google.com, stable@vger.kernel.org, 
	Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 8:28=E2=80=AFPM Bailey Forrest <bcf@google.com> wro=
te:
>
> On Thu, Jul 18, 2024 at 4:07=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > This however loops skb->len / gso_size. While the above modulo
> > operation skips many segments that span a frag. Not sure if the more
> > intuitive approach could be as performant.
>
> Yes, the original intention of the code was to loop over nr_frags,
> instead of (skb->len / gso_size).
>
> But perhaps that's premature optimization if it makes the code
> significantly harder to follow.

Thanks. I don't mean to ask for a wholesale rewrite if not needed.

But perhaps the logic can be explained in the commit in a way
that it is more immediately obvious.

Praveen suggested that. I'll respond to his reply in more detail.

