Return-Path: <stable+bounces-158996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 764BDAEE799
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 21:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10C83A3D96
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 19:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87902D320B;
	Mon, 30 Jun 2025 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGPwJqsi"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8B11A23A5
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751312189; cv=none; b=V5YJ1CLiNvEXZMgKBXVE0+1bwTKsTQnBWRIDRpgCGlSimk+fvzXPeuvcukzNj6blgX+v2HUi5vsuDUhpFD5d3fYwW1MwoloqW2NOe7fAdOAWkdcdjEHRUv4MCshF2NuxUdMn8/pIL4356yBHUcJZ7JGDypLLOPBvknlSlB/VXW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751312189; c=relaxed/simple;
	bh=5TpnHzgkPKZyd5eTFqOI9O+gnDg/EXjnpEK1/f1p6E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=alF/QtbWgK0xKxf/tcpbnKd95+d86+ytZgRgfyFaN0OTddcgnNyfmsKIIZx/OSuGr2GeISjSQM75V1hRSaY3xpPF7zqCNPVdzQHczl9zQP5pI4zZijQDP20L4GUk6klcmLU1KbxrXxPFyTwIzzRE7RoKHFmTBmNfCf0VQPZpPxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NGPwJqsi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751312187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/CTPK4eSk+4gUQuoW0j4Bt7UJobRVrOn0d8k/XSxzeA=;
	b=NGPwJqsiVR894GQ+EfqsjEUAGSGXCcTfgC8HikYb3UCszvEuHXJRRESFLenlDVovjOoAmz
	o10yYfis9531DdkLwZHwPyNt0YBe4r05+lfnvy3MPUY0x4jXh5BEyJRR+9tWTOsQHBfULt
	x0/AwfC1qRBSzmXTMP3nvCiySoz8r4s=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-rGQL1t4xOkaU12F52h1hdg-1; Mon, 30 Jun 2025 15:36:24 -0400
X-MC-Unique: rGQL1t4xOkaU12F52h1hdg-1
X-Mimecast-MFC-AGG-ID: rGQL1t4xOkaU12F52h1hdg_1751312184
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3df6030ea24so18491085ab.3
        for <stable@vger.kernel.org>; Mon, 30 Jun 2025 12:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751312184; x=1751916984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CTPK4eSk+4gUQuoW0j4Bt7UJobRVrOn0d8k/XSxzeA=;
        b=i1Otoc0pb0UfrIpIpv/a2DvXRn7lFurhFma17atTsf1fHokY1/rUhwJeOlgfFostfc
         ahfOf3KAEO3m9KjCvARBNzT40roihAltUKoGHRn5l9jOZ81dn/fDAKVu/7IU/1P6ShR7
         nC2F/e6HBQrnn2wDRshAQDJW9eE0VGn16V7N01mfrmmlk2T7wRbKedMq3ylWDtUdKrmj
         XBLDds7Joxz9JSlk/jKeHjAUkD4+aGTIwUPlHXrwVeQGmgfmv5C3uv56QbBQVHJkEFFc
         O/RhWeqERgmwjEu68NQwJgrh/+gxCZaN52EOqWPR5LIMnVK58BU6oSLmeMA9Ysj7VgBc
         GIgw==
X-Forwarded-Encrypted: i=1; AJvYcCUKJSSpySeNrNACt4g6mHQkF5MdMpx3ZFfGyn2X3wPbftR8qL3VP+VXpLsRw5DiTkdDaKFH4Z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgeV5Xh9hl87ZHWd3Ryj7IeBmt86p44zmuCISxYFEVwl1dGHMC
	7WJlaDTKI56MY6uvUTiwTojAclr19+JuCgp/rv5ZamhakpGsDSH8OHa287sAyNrW6LoMQJR6MyI
	eF7m2bEXTHfhNiWRYEAO2/8yqYwS5LgaO6tqxufQMXba9npxTjqd/pFrdf3JFIp51iMnx+THHdZ
	x2rdYO6xXv+oA1e3dx7j65Dq5hWTFa1zTs
X-Gm-Gg: ASbGncv+TsazSBs26j0oJFKbLzuzGa9RLjRFIl9WGESE4KZu2latODmIBvKOk+lnNWN
	GdGBgw4iLUwMOT9rQQhqKtxycKOU6oKnw5XDlriq7CilPe2dYNQWCqyEIjBD/Sdl6In2w/Dqm4Q
	SQZvvNr+XxJxr9NV946zTb23tShmpyQgpByg==
X-Received: by 2002:a05:6e02:1a0d:b0:3de:12ff:3617 with SMTP id e9e14a558f8ab-3df4aba3729mr168365625ab.15.1751312183698;
        Mon, 30 Jun 2025 12:36:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5OBjWuB+7mTlohU1GRuvBqPPbNy8Toed/6n+NrVnrOZfDzHRQR/D8D4AhYbheg//ZhwLibndaBuuWngB1530=
X-Received: by 2002:a05:6e02:1a0d:b0:3de:12ff:3617 with SMTP id
 e9e14a558f8ab-3df4aba3729mr168365385ab.15.1751312183324; Mon, 30 Jun 2025
 12:36:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630150107.23421-1-desnesn@redhat.com> <CANiDSCu83Ky-604gu2Yt34Wj1Km6Xh+TcPYzQxKZJNWdT7=m8A@mail.gmail.com>
 <20250630152952.GG24861@pendragon.ideasonboard.com>
In-Reply-To: <20250630152952.GG24861@pendragon.ideasonboard.com>
From: Desnes Nunes <desnesn@redhat.com>
Date: Mon, 30 Jun 2025 16:36:12 -0300
X-Gm-Features: Ac12FXyrTqbZkdz_CB2bOk0z33IvZdWhwaIYre1OeHTeEQcqtFwYYzxgNNpWDQQ
Message-ID: <CACaw+exXoVxeJz+3JdaW8peTo-zuYLez1Vw3+R4fpatjWVY7NA@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: fix build error in uvc_ctrl_cleanup_fh
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>, hansg@kernel.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Laurent,

Yes, I did see that commit and will send a v2 to properly address the
variable shadowing following C11 standards.

Thanks for the review Laurent,

On Mon, Jun 30, 2025 at 12:30=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Jun 30, 2025 at 05:15:38PM +0200, Ricardo Ribalda wrote:
> > Hi Desdes
> >
> > How did you trigger this build warning? I believe we use C11
> >
> > https://www.kernel.org/doc/html/latest/process/programming-language.htm=
l
>
> Note that the local declaration of the loop counter shadows the global
> one. I would have expected a different compiler warning though.
>
> The shadowing was introduced by
>
> commit 10acb9101355484c3e4f2625003cd1b6c203cfe4
> Author: Ricardo Ribalda <ribalda@chromium.org>
> Date:   Thu Mar 27 21:05:29 2025 +0000
>
>     media: uvcvideo: Increase/decrease the PM counter per IOCTL
>
> and I think it should be fixed (while at it, with an unsigned int local
> loop counter instead of a signed int) as it's not a good practice.
>
> > On Mon, 30 Jun 2025 at 17:07, Desnes Nunes <desnesn@redhat.com> wrote:
> > >
> > > This fixes the following compilation failure: "error: =E2=80=98for=E2=
=80=99 loop
> > > initial declarations are only allowed in C99 or C11 mode"
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 221cd51efe45 ("media: uvcvideo: Remove dangling pointers")
> > > Signed-off-by: Desnes Nunes <desnesn@redhat.com>
> > > ---
> > >  drivers/media/usb/uvc/uvc_ctrl.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc=
/uvc_ctrl.c
> > > index 44b6513c5264..532615d8484b 100644
> > > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > > @@ -3260,7 +3260,7 @@ int uvc_ctrl_init_device(struct uvc_device *dev=
)
> > >  void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
> > >  {
> > >         struct uvc_entity *entity;
> > > -       int i;
> > > +       unsigned int i;
> > >
> > >         guard(mutex)(&handle->chain->ctrl_mutex);
> > >
> > > @@ -3268,7 +3268,7 @@ void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
> > >                 return;
> > >
> > >         list_for_each_entry(entity, &handle->chain->dev->entities, li=
st) {
> > > -               for (unsigned int i =3D 0; i < entity->ncontrols; ++i=
) {
> > > +               for (i =3D 0; i < entity->ncontrols; ++i) {
> > >                         if (entity->controls[i].handle !=3D handle)
> > >                                 continue;
> > >                         uvc_ctrl_set_handle(handle, &entity->controls=
[i], NULL);
>
> --
> Regards,
>
> Laurent Pinchart
>


--=20
Desnes Nunes


