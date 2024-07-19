Return-Path: <stable+bounces-60616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D97937935
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 16:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F328A1C21634
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 14:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17A3B660;
	Fri, 19 Jul 2024 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="McZ1aXbt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10C7C2E9
	for <stable@vger.kernel.org>; Fri, 19 Jul 2024 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721399509; cv=none; b=gOw4RGPXK9zaym26djjfb1nU50yeSdd7tp0gA1TNHyHl0LJyKCaYldG86EkIZtWaq5g1j8YNYPy6y2zQw1ky+2omsJQTLGBtyFYRi42G5DPz9JbObVQGGJl5fQJ+UPdPXlT28NIZMYVQzeIqU04pDJFuSMW/yoSk5zfDa8k8EtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721399509; c=relaxed/simple;
	bh=GhrFRKfnNZV4ejBthLxu3KUQxqgwujK/kThLQChzwHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LI5gBO4sQ387m+neyi1G77SeeFHA+CrWHiRFQIZutF39SOVrexebemzvYHc8cGHMDw08qLbOQrPGtbeRSvIzCnlYYCKMiLDpMM7gyoKzzwETVYQ7ZRgV7dAl47wr6Rnqoq2IRtNtMuynQapCOOYSPEOQ1N5kxhfwQ7KbNSgvbh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=McZ1aXbt; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4266edcc54cso47865e9.0
        for <stable@vger.kernel.org>; Fri, 19 Jul 2024 07:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721399506; x=1722004306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z++eInvMqZjmxYQNqbepqz4rucmQCis52qn077CHf94=;
        b=McZ1aXbtCyfD874Lz0AlugGXCXdwZO7sH0a1ilbfN8KBZuuUyJ9mEhDsRAouUY6eRh
         HYKmvaBMqWaxmSbb55NiPGEh2BShTjHyxGyOhKBfm8XXIUdzRA8W/5KUjjxpSnv24SYZ
         T0cctCOGyVKHVEOckJ9cq7lyYbD4eMjv1NLtyv2NYtvNsVS+luLFcLt6ECvsum0/BQHT
         uJtJUQuoLyHTDD4Au5wcdYLVX9PF9w2c6fPPKBTj98nGWrw4NtKi0pVcV8qJMpXETadT
         DLfYjZPOHq/l09yv9VY52XRpc/nnhpwiXPqqTjInF8lskQGDcitX/XohB7lPrrA+QzF9
         qagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721399506; x=1722004306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z++eInvMqZjmxYQNqbepqz4rucmQCis52qn077CHf94=;
        b=uXMmdsPT8aMDnd8Oin7KuuGoJQZ0Lb/I6OrEp/xCVSmGQK6R8o7Smqt+F71bV7jRG3
         WtVFtZsznQ5c+EkWPcLzVLYnrxb7a1MZnRlEXLhsDe8E6sv8C4TV3cJ1U/MWNuUh9MLQ
         cK7eYM8edMdiaY+ABMkiz7dT6ITkLfokHeeKQF7gKxINmaitOOWyhF2yVFD75bn+bBCW
         gYhGr1KyNWDJJcLHwKDcOAvk3n75wgfsGiqtbG/W+1o3jkbB6PZOZ4HFuDdgMZJbQSaA
         1YKsCMeeCtv0ckoCwCdB9iGeZBLekCD/RoNGHl5APbchRZOp6ZqaTPiL9emVgqKUGXPW
         JbpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuVyNgCy75/S8oDVhM5wmv3ERjJrLazGUuksUiacroGLEKAf9gr1z066Mvgf4tyxUYYlfDZzKcdY7ZMciBaHt1DYyJ/00n
X-Gm-Message-State: AOJu0Yx9+SeI43+5jLROSq+qqEp+iQR+QSJRnv+k3l8MqL2Yx4Ji06qY
	7pQmt/KBtZzlpBPiVzr4de/PnJy7U6z4iMWYp7Ctq67MjjFeX58YLzILAe22c6wVxS6qgENX7HT
	rHQGNfn/rkMN8qPsmEkBq1bOiWLwhX/psb9KQ
X-Google-Smtp-Source: AGHT+IFNMOuM2Ozu/t9TE7DB761CXsT8ovt2MTO+o6AIVPKemZY2uzVuF5Rlijz+UhwAtN8UjKJbimcxfhFmlPq8Us4=
X-Received: by 2002:a05:600c:5683:b0:424:898b:522b with SMTP id
 5b1f17b1804b1-427d69c0713mr1140195e9.1.1721399505263; Fri, 19 Jul 2024
 07:31:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718190221.2219835-1-pkaligineedi@google.com>
 <6699a042ebdc5_3a5334294df@willemb.c.googlers.com.notmuch>
 <CA+f9V1PsjukhgLDjWQvbTyhHkOWt7JDY0zPWc_G322oKmasixA@mail.gmail.com> <CAF=yD-L67uvVOrmEFz=LOPP9pr7NByx9DhbS8oWMkkNCjRWqLg@mail.gmail.com>
In-Reply-To: <CAF=yD-L67uvVOrmEFz=LOPP9pr7NByx9DhbS8oWMkkNCjRWqLg@mail.gmail.com>
From: Praveen Kaligineedi <pkaligineedi@google.com>
Date: Fri, 19 Jul 2024 07:31:32 -0700
Message-ID: <CA+f9V1NwSNpjMzCK2A3yjai4UoXPrq65=d1=wy50=o-EBvKoNQ@mail.gmail.com>
Subject: Re: [PATCH net] gve: Fix an edge case for TSO skb validity check
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, shailend@google.com, 
	hramamurthy@google.com, csully@google.com, jfraker@google.com, 
	stable@vger.kernel.org, Bailey Forrest <bcf@google.com>, 
	Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 8:47=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Thu, Jul 18, 2024 at 9:52=E2=80=AFPM Praveen Kaligineedi
> <pkaligineedi@google.com> wrote:
> >
> > On Thu, Jul 18, 2024 at 4:07=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> >
> > > > +                      * segment, then it will count as two descrip=
tors.
> > > > +                      */
> > > > +                     if (last_frag_size > GVE_TX_MAX_BUF_SIZE_DQO)=
 {
> > > > +                             int last_frag_remain =3D last_frag_si=
ze %
> > > > +                                     GVE_TX_MAX_BUF_SIZE_DQO;
> > > > +
> > > > +                             /* If the last frag was evenly divisi=
ble by
> > > > +                              * GVE_TX_MAX_BUF_SIZE_DQO, then it w=
ill not be
> > > > +                              * split in the current segment.
> > >
> > > Is this true even if the segment did not start at the start of the fr=
ag?
> > The comment probably is a bit confusing here. The current segment
> > we are tracking could have a portion in the previous frag. The code
> > assumed that the portion on the previous frag (if present) mapped to on=
ly
> > one descriptor. However, that portion could have been split across two
> > descriptors due to the restriction that each descriptor cannot exceed 1=
6KB.
>
> >>> /* If the last frag was evenly divisible by
> >>> +                                * GVE_TX_MAX_BUF_SIZE_DQO, then it w=
ill not be
> >>>  +                              * split in the current segment.
>
> This is true because the smallest multiple of 16KB is 32KB, and the
> largest gso_size at least for Ethernet will be 9K. But I don't think
> that that is what is used here as the basis for this statement?
>
The largest Ethernet gso_size (9K) is less than GVE_TX_MAX_BUF_SIZE_DQO
is an implicit assumption made in this patch and in that comment. Bailey,
please correct me if I am wrong..




> > That's the case this fix is trying to address.
> > I will work on simplifying the logic based on your suggestion below so
> > that the fix is easier to follow

