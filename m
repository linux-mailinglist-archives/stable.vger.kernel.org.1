Return-Path: <stable+bounces-192558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 940DAC387C0
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 01:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 883EE4EF36A
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 00:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B261A0BD0;
	Thu,  6 Nov 2025 00:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3IBbOEv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ACB86359
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 00:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762389075; cv=none; b=XTDpHRZDa3+X/q9+zKJGmJeBOT3ojruss1nijwrm3Nm91dGUcdRUSiaWZi7kj1vKs5dJ0zx+AI/nXN5a+nQ2mv4JSFU7UJE9OeaZgsURh+/GB8IcORftfxn3RBIrkHwjneLEqXkdOsy5BEEo7SKRs1spAbGR4CUpZp7dd9B0b9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762389075; c=relaxed/simple;
	bh=YwK0dzjnIzie+cIro6blVg+02ewp8AJjSQ0wXem3n/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jB2Ro5H/HizuMllTOR9FutcjHjdzx04nIRsyo+e9JTn1knJt/Gx+O/7/9NRkf0Cs2a+vkMeCVhxfzAyXwC/Z/aQNtOSjcnSKmH+OQxe00Ca5ZSOmVhPgzJI+QHb5PZhlCopVwPuP2XY/xIHHdy8188TTUiqgeRmtPcVdgjADS6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3IBbOEv; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34188ba567eso376311a91.1
        for <stable@vger.kernel.org>; Wed, 05 Nov 2025 16:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762389071; x=1762993871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npZ4ZHY9IYcq8FuNNSe7GYz7F1gks+mG+CKUhrgqFF4=;
        b=X3IBbOEvaTR0osHfmPIqFUzCc9w/RJRN5XyXUuJvI+tqfRELdSQ85gLuYe48PcXdAh
         5/Bb4rfNKlTRgPrZwEqQduy1SrM1Eityac+3Erk4ZW3d9j7jg88nkwMeXayA/Nyz+yfs
         TAUXYmBDhgT7TkD6QJ6O9F8xMTxOAP6DFNjecI/3FvCyD429ZTuGwYZl6iwONuIpbGsO
         HxDSc3Fu/xj5zuft3ElTGekwKyA4/hfWGzw5QhkJ4+PBOAje++WJbzlggCWZ1WkcTK4d
         klVZoOqzl7KA0ZqEtGL4Bvjf6raFfL31+v5q6Jd75OAZUmvAAsKNaI3rthdWSH+PeH2Y
         8Qhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762389071; x=1762993871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npZ4ZHY9IYcq8FuNNSe7GYz7F1gks+mG+CKUhrgqFF4=;
        b=QPgVuuon74AJde4/GZ9uRuhakOJ8WD8KXlGRIACTkn1YkD4jqPFZizRjddzton8Uua
         VCIAxOBTOLda3tC+RjgatBiHWc33AVsSIg4InKta+2fqC0BcHx2GHrxMy0gQNmUPUBL7
         zsc3nNyDZ/kx/iYiRu+1Gb40Kgg+f2IHfDn3cAzkejp2MrXMPlToYlN+JAqpahgQWdA8
         vnXnFgdrGkxu0b9ltYsmuXLDLvAw7sZKNcxqFHhUiKyL+jO1OjSoG32tjo8kroOnlg9c
         m5EeLFjhF80jpvgEgL1G7GvUjmZFYO8XfVqFUt3MqjBlucoiH90rJwvp8X2ngFAUWrjG
         eoXg==
X-Forwarded-Encrypted: i=1; AJvYcCUrkVz9r62vvl0PAySwjkpApnf0NBDorIDQoTnHXLiBe2YFFMAS+9lw89PlcF+G8v+XBlTuoNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YywVOTn+806BtAG6UUrbuWIuDQjbNr2bgknPgGrY+qaVKul2pBO
	FuzeuRLo1oKXIgw22xEThf/J1DparlA78jGTgCo6xuODp6MjcV5bcBHBRRGEKIt10KChGZXexc8
	77nzRkL8+gCvxZNYxwV73NdibCxaVGmg=
X-Gm-Gg: ASbGncsWEV8BtwQS2SztRzySWzTK7XF+fyW7fFvA/vSaY+dGipITnNvlprtW8h18AJB
	cUAV5uV6pj22RbbTIB0qTVd9wwVgoJEnh/zpd/npu62qheBEzFsFhxalWa0gglbj2miuvEuNdRN
	6DHiSFAGlyloA50ELBYLKfmWwmLK5Q15Oc19Frb4yMmk5FAYvAa7CZ8pPRZrr8hKFDEvUtQfHHJ
	kqwKxCQ3sWCS8i4Cy7RLLMCnw2XCD5pwILFN5e0hRswIiBkVEK8VSsw+5l7kA==
X-Google-Smtp-Source: AGHT+IHwES9bDUP8SbFObycvgyOEk5THTTrkQ7ePguRlLgOcH2Ti5zcYIrhYryoX80izxcM+hg6IjqYm2Yv9QgPGk+4=
X-Received: by 2002:a17:90b:1641:b0:32e:3830:65d5 with SMTP id
 98e67ed59e1d1-341a700a3bemr5949611a91.36.1762389071497; Wed, 05 Nov 2025
 16:31:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACueBy7yNo4jq4HbiLXn0ez14w8CUTtTpPHmpSB-Ou6jhhNypA@mail.gmail.com>
 <CANn89iL9e9TZoOZ8KG66ea37bo=WztPqRPk8A9i0Ntx2KidYBw@mail.gmail.com> <aQtubP3V6tUOaEl5@shredder>
In-Reply-To: <aQtubP3V6tUOaEl5@shredder>
From: chuang <nashuiliang@gmail.com>
Date: Thu, 6 Nov 2025 08:31:00 +0800
X-Gm-Features: AWmQ_bmJbeEEhs1HgJzOSB3cbz-wmgiV7SpPt3It_0aKQ1KdQVVYbK5786sv_X4
Message-ID: <CACueBy6LKYmusLjQPnQGCoSZQLEVAo5_X47B-gaH-2dSx6xDuw@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: route: Prevent rt_bind_exception() from
 rebinding stale fnhe
To: Ido Schimmel <idosch@idosch.org>
Cc: Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Networking <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, your analysis is excellent and makes perfect sense. I can
briefly describe the issue.

This problem took quite some time to analyze overall =E2=80=94 we enabled
netdev refcnt, added dst tracepoints, and eventually captured a race
condition between fnhe deletion and rt_bind_exception.

In our environment, we use the sit driver(ip tunnel). During the xmit
path, it records the PMTU for each destination, creating or updating
fnhe entries (even when the MTU is already appropriate). Because there
are many data flows, the sit driver updates PMTU very frequently,
which leads to the race condition mentioned above.

Sorry for the brief summary =E2=80=94 I=E2=80=99ll provide a more detailed =
explanation
later, along with the patch verification method.

On Wed, Nov 5, 2025 at 23:34 Ido Schimmel <idosch@idosch.org> wrote:
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
> >
> > > Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
> > > ---
> > >  net/ipv4/route.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> > > index 6d27d3610c1c..b549d6a57307 100644
> > > --- a/net/ipv4/route.c
> > > +++ b/net/ipv4/route.c
> > > @@ -607,6 +607,11 @@ static void fnhe_remove_oldest(struct
> > > fnhe_hash_bucket *hash)
> > >                         oldest_p =3D fnhe_p;
> > >                 }
> > >         }
> > > +
> > > +       /* Clear oldest->fnhe_daddr to prevent this fnhe from being
> > > +        * rebound with new dsts in rt_bind_exception().
> > > +        */
> > > +       oldest->fnhe_daddr =3D 0;
> > >         fnhe_flush_routes(oldest);
> > >         *oldest_p =3D oldest->fnhe_next;
> > >         kfree_rcu(oldest, rcu);
> > > --
> >

