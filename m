Return-Path: <stable+bounces-192523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8C2C36B87
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 17:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AED264734C
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 15:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBEE24469E;
	Wed,  5 Nov 2025 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vo0qZWCG"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C32B661
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762357817; cv=none; b=j8XnsdgrTKL+qYLkwgsFepOpmc9djNq3rC6zJAT4VXlT9q/O1VmtVLsYLko98s5uF4NHZ01j0IuRYZrelfsY3ck0sIfcqWCylZk984ChCwykCgBZJeVsFITtg+iobuh/LNETc8wBV9arA+t9RcpiD/fF3Cqcf1wWu8jmcx2OkOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762357817; c=relaxed/simple;
	bh=hdq/GVI2SGoWK138x7X8PKK2wycYlsaIeDm/ZhRRxLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAtRNeeDHa4BahO/nXEEsXUvHbGXwGmfqxwrB4R7z2IvLcLk0YNXKrDfrr8TmWtIZtlPkjI9u0BzV4IcdylDbZgzOW0WboJzF7bfrKPLZ1qJ4I0e86I7hnPug79CO8fNRYLFrpcd2HJmk2EEcD9kVeBMAEcJDspkbNxRToSZd9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vo0qZWCG; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ed75832448so12238511cf.2
        for <stable@vger.kernel.org>; Wed, 05 Nov 2025 07:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762357815; x=1762962615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqiWytgC8JjSUZSjwiIgPuw7W0sj8LhImNjBhccChSg=;
        b=vo0qZWCGl/CRh/DKrpIwhUvL0V5/IBELS+92E1anvC3w4T3cJyeK01lfWRyQsZVzx1
         AC22gjUUY55Jxj6+DiKXjbpj6x3NXSpYvXUAaXgx2uNLS8euszhnbctAx72yZ7t8KhPd
         GygLmIVDmddAwHx1wKxgJCbm1ANnyHxUjVst/v3LQkG4pUFWY77RnHLSVZOBbB5otAiL
         jbb483loI4Vpknfhpza1irIqYhDCUUJG5dLG1wucGI2ojc3TAwRiJid9elc3ubE8ZOz+
         KG4ve1NZAGAxNHweQPInM7OKcMMsPrMRvoaaLjAIyUL4M6k8jbumEgDw2KIMfay7R++h
         yTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762357815; x=1762962615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqiWytgC8JjSUZSjwiIgPuw7W0sj8LhImNjBhccChSg=;
        b=E9ZyCv06XRIi0+YChj3rLuq9mGXJBTaqbeKHaRqzHhA2Z8bbL8q9NnF6+lrc4rdTi8
         oIxNiO4UPEU4ziDG9Nokcy61H7m0j8gDw5897tHk0GmPFDucrVlYRne6n4N/ALiH9xwb
         Aj9M3Uvmc5kf0mwcKz7Bes/6Ya4XH70mRgOjN/7+4Rh9HI2MNpSJfpBc6I0OiDBkNMQ6
         rRizeKIr8TZ3KqJCyeZUz1Y/zbmelKLIu9fdr1ndENjoPAjw5mwuZVaowg2KaNb4U2O6
         99WD0QlPAuUtP+PrVgFCCHBJm0fXJN7cKgJhEoR/uH5muFAWlfNC41QYj8X+UAYdE50F
         1dng==
X-Forwarded-Encrypted: i=1; AJvYcCVPFT/oE83kt6TNPmXtltYwZhakf1TYnF8KEFMzB4AX+ZUsn7LVbRmCRPQcP57MHkEaVdh3sWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVUivQoW/tELe9USaK+XdSNeLw2HTPTsptAdJkBbkc46oZ3Qf/
	iF6pdKGgD+1XQ/CtW88vX82tYizRezcue9xoOA0r0O2kLqx0FFANcAZoEzV+G/+Bha6abnUgyt/
	WI2GK0bZoXY9x8EWFj/44biZ4uToebbZPR3M/nVgG
X-Gm-Gg: ASbGnctOWxzdH8TomEXRAKnRkkm8WNjQmaVHjuXHjBfj6wkanro4Uhj73BCezCcmdqY
	X9839LVTRnU7Zk84kF7bRbS6vPT9aQ+VIqYbCRlAtg1p5Ac8tcFFlwAnoH7Hyd7gAb/svel3oDe
	8FphBSAYSJcSjg1Y3dn2dz/sHSBHMCQHA9rj9FN9TIayNpFhn1tYKl8jK6CpDQwY1wGkcfqq/Y6
	mrKYfDx+9qg0LlIp7twCLxB1mjolyJ8wy+Z/8hIr+pvzTMqPik9OqlddwwKQ9DdNWkFosQ=
X-Google-Smtp-Source: AGHT+IGL7epoV3JxPuVAZBmXv50n9ruWohYM79Cz/AFuK5389s6ymRdaTVuwUkUv8UHdtPghyl5+rpr7nFVp+k4bPA4=
X-Received: by 2002:a05:622a:50c:b0:4ed:608f:b085 with SMTP id
 d75a77b69052e-4ed72330116mr48188281cf.13.1762357814466; Wed, 05 Nov 2025
 07:50:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACueBy7yNo4jq4HbiLXn0ez14w8CUTtTpPHmpSB-Ou6jhhNypA@mail.gmail.com>
 <CANn89iL9e9TZoOZ8KG66ea37bo=WztPqRPk8A9i0Ntx2KidYBw@mail.gmail.com> <aQtubP3V6tUOaEl5@shredder>
In-Reply-To: <aQtubP3V6tUOaEl5@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Nov 2025 07:50:03 -0800
X-Gm-Features: AWmQ_blOVSXRRuKdEbWUc_1BRTQAqNrcY5trU04c5gUTWWYtSlNRJ5P-YSXs5vg
Message-ID: <CANn89iKg2+HYCJgNBMCnEw+cmJY8JPk00VHkREc_jULuc6en5A@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: route: Prevent rt_bind_exception() from
 rebinding stale fnhe
To: Ido Schimmel <idosch@idosch.org>
Cc: chuang <nashuiliang@gmail.com>, stable@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Networking <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 7:34=E2=80=AFAM Ido Schimmel <idosch@idosch.org> wro=
te:
>
> On Wed, Nov 05, 2025 at 06:26:22AM -0800, Eric Dumazet wrote:
> > On Mon, Nov 3, 2025 at 7:09=E2=80=AFPM chuang <nashuiliang@gmail.com> w=
rote:
> > >
> > > From 35dbc9abd8da820007391b707bd2c1a9c99ee67d Mon Sep 17 00:00:00 200=
1
> > > From: Chuang Wang <nashuiliang@gmail.com>
> > > Date: Tue, 4 Nov 2025 02:52:11 +0000
> > > Subject: [PATCH net] ipv4: route: Prevent rt_bind_exception() from re=
binding
> > >  stale fnhe
> > >
> > > A race condition exists between fnhe_remove_oldest() and
> > > rt_bind_exception() where a fnhe that is scheduled for removal can be
> > > rebound to a new dst.
> > >
> > > The issue occurs when fnhe_remove_oldest() selects an fnhe (fnheX)
> > > for deletion, but before it can be flushed and freed via RCU,
> > > CPU 0 enters rt_bind_exception() and attempts to reuse the entry.
> > >
> > > CPU 0                             CPU 1
> > > __mkroute_output()
> > >   find_exception() [fnheX]
> > >                                   update_or_create_fnhe()
> > >                                     fnhe_remove_oldest() [fnheX]
> > >   rt_bind_exception() [bind dst]
> > >                                   RCU callback [fnheX freed, dst leak=
]
> > >
> > > If rt_bind_exception() successfully binds fnheX to a new dst, the
> > > newly bound dst will never be properly freed because fnheX will
> > > soon be released by the RCU callback, leading to a permanent
> > > reference count leak on the old dst and the device.
> > >
> > > This issue manifests as a device reference count leak and a
> > > warning in dmesg when unregistering the net device:
> > >
> > >   unregister_netdevice: waiting for ethX to become free. Usage count =
=3D N
> > >
> > > Fix this race by clearing 'oldest->fnhe_daddr' before calling
> > > fnhe_flush_routes(). Since rt_bind_exception() checks this field,
> > > setting it to zero prevents the stale fnhe from being reused and
> > > bound to a new dst just before it is freed.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 67d6d681e15b ("ipv4: make exception cache less predictible")
> >
> > I do not see how this commit added the bug you are looking at ?
>
> Not the author, but my understanding is that the issue is that an
> exception entry which is queued for deletion allows a dst entry to be
> bound to it. As such, nobody will ever release the reference from the
> dst entry and the associated net device.
>
> Before 67d6d681e15b, exception entries were only queued for deletion by
> ip_del_fnhe() and it prevented dst entries from binding themselves to
> the deleted exception entry by clearing 'fnhe->fnhe_daddr' which is
> checked in rt_bind_exception(). See ee60ad219f5c7.
>
> 67d6d681e15b added another point in the code that queues exception
> entries for deletion, but without clearing 'fnhe->fnhe_daddr' first.
> Therefore, it added another instance of the bug that was fixed in
> ee60ad219f5c7.
>

Thanks for the clarification.

