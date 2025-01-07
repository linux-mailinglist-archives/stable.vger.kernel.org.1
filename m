Return-Path: <stable+bounces-107828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D96A03D66
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 12:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D33B1884805
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 11:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CEB1E9B32;
	Tue,  7 Jan 2025 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5NP1A2F"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4017B1E377E
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736248509; cv=none; b=O7hMEi2NUtfcjBqUZPQFb4C61R41wuUPkuFD0cCHodc7Bo16TqV5EZqgs+5JqAaAdY7IHS+ru5GRNg/SStsDgrGID3/Okr5CG7RQqKurgJFUW9X7skH+k/ZDoOJJSJuTsOGtksntbnx7cvlrX2Q/UIKNLkdJdVrnjR5sl7SHw7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736248509; c=relaxed/simple;
	bh=KgIY1FKTRLzpFPckl123BoGuHK517RwR0PXKjce5B8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrVyZYWl+I0QgFiKHADjk3RYRB+N6vqfSlQX8GNTpBGki8Rlpf4GPDLin4WrekMNmAwwSC8IU3KgLxi02ohHkeL/m1He/4tdlARrdm8goffnq77JqOB1VUFoikjhpU5H8GmFMOLgjWNiZxSHEDXZpXDwD7reI2+/6IP30zvPm5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J5NP1A2F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736248501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uUaJjpsVXRoORRkXE0LhWYFr2HvlCV5BeKiI5SY7cGE=;
	b=J5NP1A2FXqg6yG9bdrwaCtb04LDtnDQBEyATWVTys1Jjid+ZSEgy5FGWaky6kRhAOXHNtb
	cHj72BkrAmbaaqJa5uHbFsaNl0cZjYcBHel21IOqVsdqhoD+HapQYxyAKnVx2+vkkQa18f
	+cqrLp9/gabWZu8g3rkdmsgr3NI/nFI=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-1rT6pCE_M0WRlQ4Wez06-g-1; Tue, 07 Jan 2025 06:14:59 -0500
X-MC-Unique: 1rT6pCE_M0WRlQ4Wez06-g-1
X-Mimecast-MFC-AGG-ID: 1rT6pCE_M0WRlQ4Wez06-g
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e549e7072fbso5906280276.2
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 03:14:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736248499; x=1736853299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUaJjpsVXRoORRkXE0LhWYFr2HvlCV5BeKiI5SY7cGE=;
        b=a1NUIrlrqKmQp79UHK+bhHBsTA9Y6BCOjTE0LeQMWiFYvmxUv6w7Xyd7gar5yeDRo/
         WbkEnZ1T2cwMgwQH87DJ0pIdxHJ5yJ4ow5kFEv+MeCS8rp6vqxe+wW5vjjLl8imLK/cx
         WXF5kr9a8nzGz/LL0CnELq5E4fk5JOIizHNA7+KkXQhlvtkSN/AsvPPtajKs72wgvfbi
         m57livBaxzNia72v8eAbbn5vNii9JgXXTW/gWCzOFLPcIDNkcCQMivDuANIN9IQGG4Bx
         hSgPf/FWGn9Y/af1h7WrChGkpRrYAn5nXcy610EihvlVtcg3aJaoUaqT9UWOj5JEQqzu
         +SBg==
X-Forwarded-Encrypted: i=1; AJvYcCVsVxvSRrKfZvJqucbdRUbrl+Q0UOGNm03Ub1iHXLFTKrXn7JigdCLe+EPvVhUZg6jpC7h+6ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiHwkPpf7REVje+QHstg44JmTxJVC/abi8dB6PbTq8H5W1izbu
	m1mZ2TSGDTPUciDrGRdOC/teegqXpL/KJqAl1rIHOGFrf95mMnc++eTnG73Glw1rw9JvqwUFN3w
	xHDaFFBZylISasIXP0MXwcRyqnyQd1noI0yMP/H7elqIA+0nQ0OGoi97Grt2h39UtZWsycKgiz/
	xV1O+pxjTpSpB98PJbcFO1ZGseJn2n
X-Gm-Gg: ASbGncsF2tESDoe4fY22lAvOefB8ipFFgJVPHVjXck1lHjAiSzrvHZl42CT5htpsCdz
	+lYwWIvGb0uuJnYsrb4n4CUVnJnjBIJIm3qfnkQ==
X-Received: by 2002:a05:6902:108d:b0:e30:e39b:9d72 with SMTP id 3f1490d57ef6-e538c256ae8mr46408485276.16.1736248498818;
        Tue, 07 Jan 2025 03:14:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0ys7pp3PYltb89+odK6t+kYDNIkFvej+sUkqUbFdO92SoUUTkU5SmXGH5z1d+W38E0UsqvFKyZQCcN0GlvkE=
X-Received: by 2002:a05:6902:108d:b0:e30:e39b:9d72 with SMTP id
 3f1490d57ef6-e538c256ae8mr46408473276.16.1736248498529; Tue, 07 Jan 2025
 03:14:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241231190434.438517-1-lkundrak@v3.sk> <eacf3201-2884-48e3-b54d-2e52e16999be@xs4all.nl>
In-Reply-To: <eacf3201-2884-48e3-b54d-2e52e16999be@xs4all.nl>
From: Lubomir Rintel <lrintel@redhat.com>
Date: Tue, 7 Jan 2025 12:14:47 +0100
Message-ID: <CACQFvQE6P0zdxcOCz4YoTyp2eJKfezRgy9i6GYLLH6=U_PWFTw@mail.gmail.com>
Subject: Re: [PATCH] media/mmp: Bring back registration of the device
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lubomir Rintel <lkundrak@v3.sk>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 4:19=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.nl> wr=
ote:
>
> Hi Lubomir,
>
> On 31/12/2024 20:04, Lubomir Rintel wrote:
> > In commit 4af65141e38e ("media: marvell: cafe: Register V4L2 device
> > earlier"), a call to v4l2_device_register() was moved away from
> > mccic_register() into its caller, marvell/cafe's cafe_pci_probe().
> > This is not the only caller though -- there's also marvell/mmp.
> >
> > Add v4l2_device_register() into mmpcam_probe() to unbreak the MMP camer=
a
> > driver, in a fashion analogous to what's been done to the Cafe driver.
> > Same for the teardown path.
> >
> > Fixes: 4af65141e38e ("media: marvell: cafe: Register V4L2 device earlie=
r")
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>
> Should this be your redhat email? I have a mismatch between the From emai=
l
> and the email in this Sob.
>
> I can fix it either way, but you have to tell me what you prefer.

The @v3.sk address please.

Apologies for the mess, seems like I forgot how to use e-mail.

Thank you
Lubo

>
> Regards,
>
>         Hans
>
> > Cc: stable@vger.kernel.org # v6.6+
> > ---
> >  drivers/media/platform/marvell/mmp-driver.c | 21 +++++++++++++++++----
> >  1 file changed, 17 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/media/platform/marvell/mmp-driver.c b/drivers/medi=
a/platform/marvell/mmp-driver.c
> > index 3fd4fc1b9c48..d3da7ebb4a2b 100644
> > --- a/drivers/media/platform/marvell/mmp-driver.c
> > +++ b/drivers/media/platform/marvell/mmp-driver.c
> > @@ -231,13 +231,23 @@ static int mmpcam_probe(struct platform_device *p=
dev)
> >
> >       mcam_init_clk(mcam);
> >
> > +     /*
> > +      * Register with V4L.
> > +      */
> > +
> > +     ret =3D v4l2_device_register(mcam->dev, &mcam->v4l2_dev);
> > +     if (ret)
> > +             return ret;
> > +
> >       /*
> >        * Create a match of the sensor against its OF node.
> >        */
> >       ep =3D fwnode_graph_get_next_endpoint(of_fwnode_handle(pdev->dev.=
of_node),
> >                                           NULL);
> > -     if (!ep)
> > -             return -ENODEV;
> > +     if (!ep) {
> > +             ret =3D -ENODEV;
> > +             goto out_v4l2_device_unregister;
> > +     }
> >
> >       v4l2_async_nf_init(&mcam->notifier, &mcam->v4l2_dev);
> >
> > @@ -246,7 +256,7 @@ static int mmpcam_probe(struct platform_device *pde=
v)
> >       fwnode_handle_put(ep);
> >       if (IS_ERR(asd)) {
> >               ret =3D PTR_ERR(asd);
> > -             goto out;
> > +             goto out_v4l2_device_unregister;
> >       }
> >
> >       /*
> > @@ -254,7 +264,7 @@ static int mmpcam_probe(struct platform_device *pde=
v)
> >        */
> >       ret =3D mccic_register(mcam);
> >       if (ret)
> > -             goto out;
> > +             goto out_v4l2_device_unregister;
> >
> >       /*
> >        * Add OF clock provider.
> > @@ -283,6 +293,8 @@ static int mmpcam_probe(struct platform_device *pde=
v)
> >       return 0;
> >  out:
> >       mccic_shutdown(mcam);
> > +out_v4l2_device_unregister:
> > +     v4l2_device_unregister(&mcam->v4l2_dev);
> >
> >       return ret;
> >  }
> > @@ -293,6 +305,7 @@ static void mmpcam_remove(struct platform_device *p=
dev)
> >       struct mcam_camera *mcam =3D &cam->mcam;
> >
> >       mccic_shutdown(mcam);
> > +     v4l2_device_unregister(&mcam->v4l2_dev);
> >       pm_runtime_force_suspend(mcam->dev);
> >  }
> >
>


