Return-Path: <stable+bounces-235797-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCG2Els+22ko+wgAu9opvQ
	(envelope-from <stable+bounces-235797-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 08:40:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B77CD3E2F12
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 08:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1243A30219B2
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 06:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C4B366575;
	Sun, 12 Apr 2026 06:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVDV4AjQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D1F33F591
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775976023; cv=pass; b=Ae01AkXau2DAXnRp/Of441cwcdCsTuUS3egARRBfQ6ILeESpClLv+0fjX+ffFxgEBW7SSCinAulPDzohHtEx023X30eEiRlKGqby7aVQPzofRnMF0hBryX68MdQF7/TJjNTWWXCS1lkYmTVUekWanmrkZ1LUtauyhLEz7iO50as=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775976023; c=relaxed/simple;
	bh=a604DeiNAPyMT/Lkekno8TTnpz8UJxsFOLOcq9BBqxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlvW1eXaCXw131YPC32bnKgjwoiIlD6+NmFfkbWuY0JvKEwHlVz/Bby9vNqSIED5lS0G4TYO4xM1UchRvAiQRHHvz7tNQ9Cql6E3JKAHK5gMpjIVwvqzBLot3363yxZJ5zKWSeX0iHxQhQmbCm/8wjaVVY/SqkMwoeSlGbrz1y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVDV4AjQ; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-651b4d09141so755082d50.1
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 23:40:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775976020; cv=none;
        d=google.com; s=arc-20240605;
        b=ZUdMr1d7KwycA9RxiEwExmRrsbYvDUysmyqFZOl9fGt4l1mZdvLEY6KHWv9nwj8+hb
         eMW4EGH1co81sSLhyi5TI6kkuDhRfFaiGmPBZyrNibONfaICUZCsIiEfk3syOsf0+eyD
         jAjPwnS2TJctRAUQ3GextcnYLrCr3JZ7YJs+2Q3Kvph4n+0eGZehxmgIq3QPB4FQGoct
         /m9kNB1ZR01uz0Phxd+TprAt1WVgjilKm83ESt9Qyuo4oSio8LW+a1ptqI9cbsjhRe8F
         1naRzlwxH3cYKKTkM5kGCn8XbChiAVbhb7nW+U36eO7j8ycd83QGUCDx9hXZ9ZCbv2Dd
         WnuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=353BGQR5E+FUbDTTQca9SIYSG89yYQ90FU4wNhB5wTM=;
        fh=85tMOFDMORkedCJrQVXtUZSkp6Vm6TWlbbsREyTR+Ag=;
        b=NFDb/8rC5RpGWwrwwjr44eCjSRuvgCrZFf8R/o/Sl8mgFzFK6iUhe6c1sYlFBzgH/O
         8G2pS//BtMWYwO6tx35mwBhUSigPdkgvmvWqGzGJhz7LaMAwMUkG4v8ucMZ+edinNQyH
         rU0/vjkqK9MuvutBJbSvPrH38qONhLFmapoJpLOHQEYX9oqU5ifB3ZtP9+sL3Ie1fGHr
         7ms4c+omB9h+3ounL1REjJMULTuRqv/1q4BJJ93od+4xrDryRgqyjhW93L3i9pIuwiDM
         DFoWMMD7YxrPIKccdWJIDmx+5IGTCAxRcTNV+tHeohtyCtjVCp9GUGOVcy0nqc/I5in6
         O48A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775976020; x=1776580820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=353BGQR5E+FUbDTTQca9SIYSG89yYQ90FU4wNhB5wTM=;
        b=MVDV4AjQwqUIZWMIWMEKKC+C2a9ouvJYGqaFkYnt75JOYR7GqQI44z3D3wFQHmTOGZ
         tuSBBUPTo1iE6Y5pbH8TaQXJWpNmFEJOKxREbrF2evaFC+ZRtjZ3J55BzgLwCxfUp00g
         eAI57Xjgdm2c+YknnE1aBaXqbGAgVWFcH5Z/p9XbniANt6mEWCA18VsF8787M8O0T1le
         +/8CmmPWXSGa6mHTUQ7SNFoMiuhS1vctH0fEJWWa5E/HkZ+geaRKUk53bU/fI9MpwSqH
         0ITfzi4/HGIhzAKQygkuIlzVmXE4YdR+pFe05pSaDMSRs28KBJ+MDTts2Jl9viTwRfj8
         p7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775976020; x=1776580820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=353BGQR5E+FUbDTTQca9SIYSG89yYQ90FU4wNhB5wTM=;
        b=Hm+R/teqwWAXQWNZqYoqb2bhf9msqB49wPGz3De0xUwFdzhcWxyldl++9vecxj4+pK
         IUao0oA2tEE+J6QdtzOLHt79yU+1tR+Msj0aJoPVWiH0ow4+GzAUcO815XyMilOo7S8h
         7Cr7GiQ06VGg9SlljXDii5kfC1+XmfnSrxyrzFYCGsXGCPeSbdle6rFe3p3aqGpaFQSZ
         mwzvMP5JlXI+yNdTRtqnCG35Hv/ZozCxievG+uCrmB9NUsXJdok00Jk7PZbmt5okjyG2
         cwjKutArjv4rCDgynMgcEOzq2U+EUySRnllPmhumoGbqWKK6DlZU/tOzyshdyV1rZ/rF
         NCPg==
X-Forwarded-Encrypted: i=1; AFNElJ9lB/SfWT4r0GUU20Ecl2YTL1p7Ecx9t3347NwDCxweAa1lU4QWjomB/tBK763TkNwgANIfgiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzbQaH8KD93XJS5m+O56a7CoNS8dRdg3CHyzh4Rp52h1Bk52kI
	TUobj83k+XT8rejcyuIS5qrbfs6tYFftq55brAK0biufild+mpbfHbhNLV2itLrzvuV44iFLnhl
	gq4+0nnkeRa7J65PfUwnbn41uiJkDVfI=
X-Gm-Gg: AeBDieuBwAMr+FtyKtPqUq3IbJfj8vTpIcQZ0unomL9+fryals31M1msU77pqWC3iva
	k2dloOjvo6weWyPi6uzizDHbyTv7n3szb5guJyTRQQcrznTnBAcCqS98dYoSR1tA5vuXFb+ryqS
	nNZKrN5ERiyrIuPeu6X22CHwXg7nxYP88qiUqJnXR23EMpRWr1jFP6w/eZauJxtHbQJoYSSZunb
	r06iqerIQAlKqQTe/KlIpMUMUleTFAPbNZpMPME9e2N9WsRxIQFlwjBYrfGUdU+jxV5dub3vhyR
	JDzilE0=
X-Received: by 2002:a05:690e:d4a:b0:651:8abe:ce47 with SMTP id
 956f58d0204a3-6518abed70amr7968580d50.5.1775976019736; Sat, 11 Apr 2026
 23:40:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411145726.2299438-1-lgs201920130244@gmail.com> <69dad954cbd27_fdcb41005c@djbw-dev.notmuch>
In-Reply-To: <69dad954cbd27_fdcb41005c@djbw-dev.notmuch>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Sun, 12 Apr 2026 14:40:08 +0800
X-Gm-Features: AQROBzBoQieHezjldgST08cWePETtgJOGA36kUbkZPgBK0CARxWtw3VoS8begvg
Message-ID: <CANUHTR8krObfwdkV9PFkfRcWgiVwSMfmKD0U=xY9_543KxZqTg@mail.gmail.com>
Subject: Re: [PATCH] device-dax: Fix refcount leak in __devm_create_dev_dax()
 error path
To: Dan Williams <djbw@kernel.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-235797-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B77CD3E2F12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Dan,

Thank you for the review and for pointing that out.

You are right that my changelog overstated the impact. I do not have a
concrete use-after-free case here, and the practical issue is simply
that after device_initialize(), the embedded struct device should be
released through the device core with put_device(), rather than
freeing dev_dax directly.

I also took a closer look at the release path. Since dev_dax_release()
already handles free_dev_dax_id(), kfree(dev_dax->pgmap), and
kfree(dev_dax), and put_dax() is NULL-safe, the post-initialization
failure paths can be simplified to explicit range cleanup plus
put_device(), once dev->type is assigned before device_initialize().

I'll send a v2 that tightens the changelog around the actual lifecycle
issue and cleans up the error paths accordingly.

Thanks again for the guidance.

Best regards,
Guangshuo

Dan Williams <djbw@kernel.org> =E4=BA=8E2026=E5=B9=B44=E6=9C=8812=E6=97=A5=
=E5=91=A8=E6=97=A5 07:29=E5=86=99=E9=81=93=EF=BC=9A
>
> Guangshuo Li wrote:
> > After device_initialize(), the lifetime of the embedded struct device i=
s
> > expected to be managed through the device core reference counting.
> >
> > In __devm_create_dev_dax(), several failure paths after
> > device_initialize() free dev_dax directly instead of releasing the
> > device reference with put_device(). This bypasses the normal device
> > lifetime rules and may leave the reference count of the embedded struct
> > device unbalanced, resulting in a refcount leak and potentially leading
> > to a use-after-free.
>
> Please do not list "theoretical" problems as justification. Point to
> real problems.
>
> > Fix this by assigning dev->type before device_initialize(), so the
> > release callback is available for put_device(), and use put_device() in
> > the post-initialization error paths. Keep dev_dax range cleanup explici=
t
> > in the error path.
>
> I see a more straightforward way to address just the practical problem
> that also incorporates the other feedback I have below. Can you spot
> that and fixup the changelog to address the practical impact?
>
> > Fixes: c2f3011ee697f ("device-dax: add an allocation interface for devi=
ce-dax instances")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/dax/bus.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > index fde29e0ad68b..8753115cd371 100644
> > --- a/drivers/dax/bus.c
> > +++ b/drivers/dax/bus.c
> > @@ -1453,6 +1453,7 @@ static struct dev_dax *__devm_create_dev_dax(stru=
ct dev_dax_data *data)
> >       }
> >
> >       dev =3D &dev_dax->dev;
> > +     dev->type =3D &dev_dax_type;
> >       device_initialize(dev);
> >       dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
> >
> > @@ -1499,7 +1500,6 @@ static struct dev_dax *__devm_create_dev_dax(stru=
ct dev_dax_data *data)
> >       dev->devt =3D inode->i_rdev;
> >       dev->bus =3D &dax_bus_type;
> >       dev->parent =3D parent;
> > -     dev->type =3D &dev_dax_type;
> >
> >       rc =3D device_add(dev);
> >       if (rc) {
> > @@ -1523,14 +1523,21 @@ static struct dev_dax *__devm_create_dev_dax(st=
ruct dev_dax_data *data)
> >
> >  err_alloc_dax:
> >       kfree(dev_dax->pgmap);
> > +     dev_dax->pgmap =3D NULL;
> > +
> >  err_pgmap:
> >       free_dev_dax_ranges(dev_dax);
> > +     put_device(dev);
> > +     return ERR_PTR(rc);
> > +
> >  err_range:
> > -     free_dev_dax_id(dev_dax);
> > +     put_device(dev);
> > +     return ERR_PTR(rc);
>
> Please no gotos with early returns, that makes a mess.

