Return-Path: <stable+bounces-120073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8B2A4C565
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A8CC1632D0
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 15:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1D92144C2;
	Mon,  3 Mar 2025 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8sDQjiq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F69123F36F;
	Mon,  3 Mar 2025 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016446; cv=none; b=tiVeOqGN4rDIWP3zKcMhhyys3GHgxuKXFb0YstqhzJFn+1iRO6aa/SywCPhGBIFZUIjHQj6rTd3vfotSFX2W3auSA3wcgKnu9kmHbNDRdV0vwvXZ4UQ39PvFBbEgKS3shAJl/gkSMj18RjyaJVfpWJ4lfwgjvGN6LJ61qpfS+Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016446; c=relaxed/simple;
	bh=PCzFztrWosUeWk6L97jFw2j8+FmPuQhKLe8itmVKSyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cebRu4xrL7mdV5QR9DjdjhuO0YBaj9CZGnfkgER4TTzoPhRHUHI60zk0SCls7BBXoTxRm2lFJ50Ug4nDF3sOWskU7uClHNhfiwJavjkL/hvJQsJA7hGc9iicpKlN/gE+qiZCFPgXF+Owa4HGuVt6vcZkRDS9BV0Q+kpVqTMqIJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8sDQjiq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-390df942558so3641227f8f.2;
        Mon, 03 Mar 2025 07:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741016443; x=1741621243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cHWcGb6/82XLxoaKsbI43KUguE9A6MTYe37LiujrCmE=;
        b=C8sDQjiq04q3ncudxGzwFjxZ2AWHhObRLmqlpzKwOyvYxvbMPP0d3cjOE3opkKYIBv
         wkw05S2fqyo6EgIaLJ7EA/KNX/TcVdkyxGbvkdcU37cxOSla+iNhoDN07uAOqWtdwKko
         WDuXq/WN1rQt0+3O0conGB3cP9tzaI0xx+wX2RqzCbUgCGVjxhASRpUl1jRjSQRFIA6l
         x9aR4WSA2P0y7EWuG1bRBIPeVnZcKNxutbhsBjtPK3yHPbsl8LDVh1bCFvT6cZIwMAeu
         6uYsercee5dvNFsYfe3cC2CUE/FKPgdqfuClsJ7DCcxFLPqsTlqpo3EGb7iY3WjFaM5z
         LiOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741016443; x=1741621243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHWcGb6/82XLxoaKsbI43KUguE9A6MTYe37LiujrCmE=;
        b=PsECOlA+JwrQsV1iNYgtB7c4n9KezNqBFlPKoowjOP7ubcxqw/1MGxaPz2uxoB62m4
         r8g1Mshwc8NgYAW9uNMX6BW49RPYFUMMQNaMBhzEPhcZnzEouikYXPcOy61JO0T8DeuW
         NYoJKOFG7Y113KqfBU6/0GiT7kusZmOqhjptA2OEH5bEndOf+4BRITypdsp/QEH5V0ai
         sf752lM/xpGsOZOIsnkNchqnuJxVK6zWuTSnDjBqMGRJQLCgWtg3MDAQqEhelfIWSkw6
         N3rg0Vbwj3fhu2V53Dn8DCLQXicOmGWM3rgveJkyN6e0If79PEBr40iIHzG3giZJD/1A
         1Okw==
X-Forwarded-Encrypted: i=1; AJvYcCUR4jhhkIWwV8vsbh9zK64QE7TAlw5wmyGJEONaj38bvrgOPB8MFq2mlflSzLqspjfq6VXKV8n9nKJykm4=@vger.kernel.org, AJvYcCVRFDcqKXi3LpmunYKJEWoe/hTPVnEk7ZUesyjZz4aKB8buO0XahBtKB4SLMoX669xJoki1HyXm@vger.kernel.org, AJvYcCXkQlMmErihTybqnHcE5aWDb0PIsNSylWA5OT/dREy2Tjzuo2I13VW45W5OYnBNELN0WhwFGm88yBj1nAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIcj2nkT74P1CtfGhD8FxKctY5sUAazseSmk/F+4fhSclLyE6q
	Y5dkKW8xC4DH80B2dsAZyhvNRfJOE9nL/S40cRflH6/U7sjwsZQH
X-Gm-Gg: ASbGncsi6T7PoRdIOWXZtLYmNwUy8wMXu24ewYafetd4WvnKMWYOPXyeTzfscBi8t54
	bUZcT3hE6tGbmjhwyjqJqvpmVzlh+E8FMhhXzW++yppOSg1nbovPX3DR6epMgOjMLdD6+72aXU5
	nGOx4VZw5/HLMwo8bpeCyEUfftN6xoTCtRSqAXohRAwvlzZPzYBfqkMFvb0S+AUv1216H1ccrE6
	nzpMTN3wn9pYFtLBoDXqOFYiD/GaiN5vwrvlvgWlHQkyC5+jQPihXrfFL2eQxe/WNtIqBjn/XwC
	U+lW9x8XSHD0JokULsjoIqYJtFhTeC+pSBCWHsQf7E1svM2Jc0P6l77n0s7uMemcQ1EV+wVsJV8
	ub00akVN8MxC1gGDYEs/F6GvKAxQvKDI=
X-Google-Smtp-Source: AGHT+IEug+nKAS46phdWGXkvHURzvBIKWZnJxIArYvwyXJ9Wglql1zESb8pxgHZWephLZBnuQc7+2Q==
X-Received: by 2002:a05:6000:1547:b0:390:f55b:ba91 with SMTP id ffacd0b85a97d-390f55bbc10mr8267313f8f.14.1741016443268;
        Mon, 03 Mar 2025 07:40:43 -0800 (PST)
Received: from orome (p200300e41f187700f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f18:7700:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e479652dsm15109184f8f.16.2025.03.03.07.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:40:41 -0800 (PST)
Date: Mon, 3 Mar 2025 16:40:39 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Haoxiang Li <haoxiang_li2024@163.com>, jonathanh@nvidia.com, 
	brgl@bgdev.pl, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mailbox: tegra-hsp: Add check for devm_kstrdup_const()
Message-ID: <q6zovgtjvvzoessyaudn7i76ptoopnfnmaeviry7jbqcms3gxq@r3nwd3fsgs7i>
References: <20250219022753.2589753-1-haoxiang_li2024@163.com>
 <CABb+yY3wC5Rp4DJFL=61uyYyGtJ-kPTWks8JMG7jQpp=V3P-Zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e7yhcb4e6crfwy3w"
Content-Disposition: inline
In-Reply-To: <CABb+yY3wC5Rp4DJFL=61uyYyGtJ-kPTWks8JMG7jQpp=V3P-Zg@mail.gmail.com>


--e7yhcb4e6crfwy3w
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] mailbox: tegra-hsp: Add check for devm_kstrdup_const()
MIME-Version: 1.0

On Sat, Mar 01, 2025 at 10:29:29AM -0600, Jassi Brar wrote:
> On Tue, Feb 18, 2025 at 8:28=E2=80=AFPM Haoxiang Li <haoxiang_li2024@163.=
com> wrote:
> >
> > Add check for the return value of devm_kstrdup_const() in
> > tegra_hsp_doorbell_create() to catch potential exception.
> >
> > Fixes: a54d03ed01b4 ("mailbox: tegra-hsp: use devm_kstrdup_const()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> > ---
> >  drivers/mailbox/tegra-hsp.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
> > index c1981f091bd1..773a1cf6d93d 100644
> > --- a/drivers/mailbox/tegra-hsp.c
> > +++ b/drivers/mailbox/tegra-hsp.c
> > @@ -285,6 +285,8 @@ tegra_hsp_doorbell_create(struct tegra_hsp *hsp, co=
nst char *name,
> >         db->channel.hsp =3D hsp;
> >
> >         db->name =3D devm_kstrdup_const(hsp->dev, name, GFP_KERNEL);
> > +       if (!db->name)
> > +               return ERR_PTR(-ENOMEM);
>=20
>  tegra_hsp_doorbell.name seems unused, so maybe just get rid of it...  Th=
ierry ?

I think I had at one point used the name in error messages and had ideas
about maybe exposing some information via debugfs. In both cases the
name would've been an easy way to make this more human readable. As it
turns out these errors are very rare (I don't think I've ever seen any)
and I'm not sure there's a need for debugfs.

So yeah, I think one could make a case for removing the name. The amount
of memory it "wastes" is tiny and it's quite probable that it will end
up in some area that would be padding otherwise. Furthermore there's no
way this memory will ever be *not* read-only kernel data, so this is
always going to be a no-op anyway (well, not exactly, but it'll simply
be an assignment of name to db->name, so no actual copying will be done)
and hence this will never actually fail.

So I don't think this patch makes sense. If somebody really wants to
remove the name, that'd be fine with me, but I don't see a strong need.

I suppose not doing anything would increase the chances of a similar
patch being posted again and again over the next few years, so maybe we
should just get rid of it.

Thierry

--e7yhcb4e6crfwy3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmfFzXQACgkQ3SOs138+
s6GKWg//Sp3RbObS1Gi45lMzWojAPKio/JQYlJ7iVSZ10NQ12z3OF9+xCMtnHzI1
NZv157gxUYceA6VWVCCoW/KFpq8to7WIi1pM7JlkVO/RiuNS9YGeisdmu83uhtbh
3ozmQlBL5svevbPDGR2oFzqjDSBM/rKKg9X5bdKNb3c3UHU5sURZRRGw3psmNzbO
N8Y21HXi23YlSGGYFmjQl0VCvqHZVYs2pnMSrUt7sT2rhg2OSpxkUT2HUDl7Nw+J
l+5/PvAim2nJisFldBl1IKKtW23X4G+ZmeicnEgXnPrfCmPYUi7kKHattzLXsZbg
fmbu6LY+51SohNBePq9H2EAG+DjyxIRJtH7GIR6mejW6/Ta3aWNh9wACXQkk4xFB
P4MwU6cJlhixEAKZgAUFlGfu1WrTlozD3i7DDaP2tp2mT0h0OSCeE7K4JA20qFgO
HKRyWBvUG7Xhx/nSai/QiIhSlQ+vxsr1JdvUkayF3GVEXToJfsBrwCkjIGU+FLoR
pdnwY2oYsZvtL+4Fx1BHO6PC6XtDpmfrj1AO7lT7/AdqfxjZDHGl5O+r2MwhXJTa
ox86Z8v2wNOrzK/eY+9LNzfjE/1D1HGOBmUhZawxVccsvYjwePaiay/frW+BHOdA
GFAvwjY4fNl6ntfKvKznxBgtejEEsk/ZwJv6hlHO2xmIn9KVWkw=
=4oVP
-----END PGP SIGNATURE-----

--e7yhcb4e6crfwy3w--

