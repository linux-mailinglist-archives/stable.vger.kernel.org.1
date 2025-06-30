Return-Path: <stable+bounces-158998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F9EAEE7A5
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 21:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A34F1BC27E8
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 19:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC62C2918DB;
	Mon, 30 Jun 2025 19:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3MAniXe"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FF425D1F7
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751312330; cv=none; b=qUcuvmuGDOt7wmWP4xwGdJfJSC5lgR4oPjhh8/CSGvBltpnmteoWkmlsamgmcuyiMfDdE6E0NeL8+qZQELfeEEUOmbqjEIEd1c3EsMqZY/jSpI8BlbkrCfN8tv03KU2ohqnJnhyH90ndxLTomIfpj7neDVh4OE8ZdkskXBg7VyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751312330; c=relaxed/simple;
	bh=zqOedF4W1acrWB83NCr7yyAwoGHaZafCuVP1mY07zac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzmbh4EKYwUHtNPhbWfaGX8qxDdINf5lucJKmO0AZZesahXTzAHjRrFhEKik6WUivHcz5mscsvrYiLkONCzO+ftnllAJiX0Eu2zP3gsZTLV4/fFtAAEb2BaAoph+zt2bgTRAeDNnWW/22+agAt0JdRLiaZYaJlCVb2ZpDXrwOSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K3MAniXe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751312328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oD0tbuaxponDHy3qN8C0494OXCQwyjvpmdeqroxPwDw=;
	b=K3MAniXe+5ltmLsQ2EXRGI0Kn374K48cQIjs4IjkAGraph0F76KZT3WjQK/o5YQaIoDNmV
	/BGbu4OTqFWDJ+42D17IUw2ZYC8IH5XCmBR3KDnEUyRq1PbGS3XcGc5jBYZkqzZdWxdcac
	EhctRz3lgpWl7u1+U0tAz+Lh9/PHQzY=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-crCFDE6zPfmbq8hzMfyfwA-1; Mon, 30 Jun 2025 15:38:46 -0400
X-MC-Unique: crCFDE6zPfmbq8hzMfyfwA-1
X-Mimecast-MFC-AGG-ID: crCFDE6zPfmbq8hzMfyfwA_1751312326
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3df2d0b7c7eso29722205ab.2
        for <stable@vger.kernel.org>; Mon, 30 Jun 2025 12:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751312325; x=1751917125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oD0tbuaxponDHy3qN8C0494OXCQwyjvpmdeqroxPwDw=;
        b=kBokErseRGJj/f7aYDQCbSPxwC+j3k69eBj8X6MMyppytwDLyqGjUIfhGGJGtkktOJ
         wTWmXzhpgqkLLxR3QErM1JajmwPpFDhskVc5NmrQnLm3QbKEPkEK4jp148fHHK5cSEss
         CdWqRlNlBRa+H2YtqBzeqPAgiEmgbz3eFwNF1wQEDwNNrIx8CvbF2ggsT2NKJG//x4Gh
         jn02/T0zU0bRC0xuMc7ZxpRbDfEscObFAkca32MALJw+EXpehLCk6bkSiZUT7PAGAjyc
         9GOkIRwTE9zubQRm5AVzaJDAZhbLvYoFEBcdRX8WqCt4OFgQEqWYDCjpc42SGlbva6Bp
         Yadg==
X-Forwarded-Encrypted: i=1; AJvYcCV1O9llykwdpAe0xkLq3N9Kc3RzEuuiHrnm27Kownv1IvR0IWZuIoqx989XZEyV6pS1LVf0bTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMwCX2q0ELJHIXm6lQSd6rvEgPDgOQhdHo1lCLNeg6rQvBRLxx
	7cCMIrXFmicVJdKhsLSoxrHEjB26OphH7jzG3L0NGGsu/ClvGsAlv1RcGJRygxaQ+UIvRr/7+FA
	ze5+ninwmJY/sXWJHxE4RftSUOFZURK0EdcDyANQFBaqeGOnihTma78T/TnNfaQj8bPl8lUbRKS
	JrcIST0sneh8mK5Bb+0QIi1InVS+PpQ1lW
X-Gm-Gg: ASbGncv2mk2ToDggUDXViUTb+eFdXGaINVzjhc6i0gilyb4OyyUryr1nq0rJl+YYdIp
	j2YOGPT0T9WToiCykF+ZzPhbolAWLiLgmxf29N5iFYkIjU9hotlacA1zHeHt5j7UAkRIL8CFRB2
	fiZazKe3kb4J/+PS1iRJtDMnkH0NbyYBD4Bg==
X-Received: by 2002:a05:6e02:1527:b0:3df:4024:9402 with SMTP id e9e14a558f8ab-3df4ab78488mr158020485ab.8.1751312325679;
        Mon, 30 Jun 2025 12:38:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj63Zu4chAlO3nwkmxFrLIHzXRdPp9LE0n5nOyaxxe57ddbJANgCo/i9LGvy3628nLn9G8EqMjdjEnVj3VXIg=
X-Received: by 2002:a05:6e02:1527:b0:3df:4024:9402 with SMTP id
 e9e14a558f8ab-3df4ab78488mr158020135ab.8.1751312325311; Mon, 30 Jun 2025
 12:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630150107.23421-1-desnesn@redhat.com> <2025063041-concur-unrefined-9dba@gregkh>
In-Reply-To: <2025063041-concur-unrefined-9dba@gregkh>
From: Desnes Nunes <desnesn@redhat.com>
Date: Mon, 30 Jun 2025 16:38:34 -0300
X-Gm-Features: Ac12FXyAkCe4-5qlTdVi7CFbvyYmzCuJiAW0H_xcfUV1Klx2no50cvU9ATC726Y
Message-ID: <CACaw+ezWFLhE8=Uc4bHYWu9yF8-ncADZ3oRMMe1t2HaQ+UhNyQ@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: fix build error in uvc_ctrl_cleanup_fh
To: Greg KH <gregkh@linuxfoundation.org>
Cc: laurent.pinchart@ideasonboard.com, hansg@kernel.org, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Greg,

The compiler is sane, but I ran into this while backporting fixes to
an old codebase that still uses C89 due to legacy support reasons.
Furthermore, you're right; there is no guard() in my code base, thus I
had to backport guard() with the old mutex lock/unlock calls used
prior to guard().
Indeed - will focus on all of what has been said on the v2.

Thanks for the review Greg,

On Mon, Jun 30, 2025 at 12:42=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Mon, Jun 30, 2025 at 12:01:06PM -0300, Desnes Nunes wrote:
> > This fixes the following compilation failure: "error: =E2=80=98for=E2=
=80=99 loop
> > initial declarations are only allowed in C99 or C11 mode"
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 221cd51efe45 ("media: uvcvideo: Remove dangling pointers")
> > Signed-off-by: Desnes Nunes <desnesn@redhat.com>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/u=
vc_ctrl.c
> > index 44b6513c5264..532615d8484b 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -3260,7 +3260,7 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
> >  void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
> >  {
> >       struct uvc_entity *entity;
> > -     int i;
> > +     unsigned int i;
> >
> >       guard(mutex)(&handle->chain->ctrl_mutex);
>
> If your compiler can handle this guard(mutex) line, then:
>
> >
> > @@ -3268,7 +3268,7 @@ void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
> >               return;
> >
> >       list_for_each_entry(entity, &handle->chain->dev->entities, list) =
{
> > -             for (unsigned int i =3D 0; i < entity->ncontrols; ++i) {
>
> It can also handle that line.
>
> Are you sure you are using a sane compiler?
>
> confused,
>
> greg k-h
>


--=20
Desnes Nunes


