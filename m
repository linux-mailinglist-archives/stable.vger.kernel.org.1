Return-Path: <stable+bounces-158995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC419AEE783
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 21:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEC217A07EE
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 19:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C701A23A5;
	Mon, 30 Jun 2025 19:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QbK+FEdh"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E302E5418
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751312011; cv=none; b=MuGZw0q3DkNlefhsOwcp5AhAkQ+V8iP7q9BlIaBIxiVPkRWxFAO9QsOHS+hkRUeFQ3cvZKmqKvsn2D/5FWDv6cNvfpZUeHk5DE8JvKgLSMvNehQ8JyokAopOsuq4/9efXUgAyRIa9EuMRSeb4xBtUvLOpLr0O03+uUQPuqvQK6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751312011; c=relaxed/simple;
	bh=L1dWw3ul8yVaWeCdfKGPbkNq6yPKle7qYiNxccwTWIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciNNVjMInb0u50K3HkLlvmxdP/eJXtwfPgLksbkNmACPEyfHxr4hvNYybwwRHkks46qQX7VOYI3Bo5OsX9mWAum58waqVma2Q9A0xyBf0psJcqKoAZpHFd0ozvUyfPto6pOhypVJzbzq5fQbKdBJs6JWBV2nru0OX6oojqXWOL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QbK+FEdh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751312008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xLG9XHK+6+oCii41uDgkWY6xC+gN79cm3T8XpClkT4c=;
	b=QbK+FEdhOvMJAjk0BeCUtUdLkz5XhMmAOEEp31tY0lh2xuYQJ6ON55DhxWDcJIAD3cQuEx
	StVKcoOBoE10czjjM09DWQSBVe0LO6Ig1EccAexhu1xiHL8RXb6KD2/fkPl4qXkx0lb6dp
	oN5W71/TgT4/89FEacoUYsHsk/1if5s=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-yYbyR_e3PNOxmMSL9fl4gw-1; Mon, 30 Jun 2025 15:33:27 -0400
X-MC-Unique: yYbyR_e3PNOxmMSL9fl4gw-1
X-Mimecast-MFC-AGG-ID: yYbyR_e3PNOxmMSL9fl4gw_1751312006
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86463467dddso198656839f.3
        for <stable@vger.kernel.org>; Mon, 30 Jun 2025 12:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751312006; x=1751916806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLG9XHK+6+oCii41uDgkWY6xC+gN79cm3T8XpClkT4c=;
        b=TqjtQmaJJVkNdVGT1jlXSy19r4q4aqSvrXkHOn3Zz4UcYbNWvU3mCPwnQvPNbba9T+
         IkaLOf0VFTCjkUAkKNB1yp//MLFGB7bn+jNCaLuNQAaYPIW4UQDbtfd1CzZQJqDEaGb7
         C0nPDr3eSdEewoGNj5lWAbvXGxGqxfot95w5NeoCcxEjpRzIUAVGxwo8jHmMR5Z8iRS/
         SpsY6gEUUoJ0VSJeaqjnnEdm4ScUdjd8n3SBpFeiHqBYSkvxGMgvDtPt3GBkR/TdA9n3
         pVfOO/CuwybA5ObcSHOdPeSBaEG9IeZVJ/Nd93jX+tkQ1+5EDjXGhlosC0uXr7fjVZUu
         AU+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGL+xYYUweDOHdagZCeiUHSSV6JemhGr9J1Hn98cVEnpDq3dj+wXNyb0msdOOBCx60ikKXzQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDoPgCKKhMwmC9OY5qZrBKPjyZI79htBnXAqjItG2oMgrMvnjP
	Ae53FAlozsSwAa10TngI1LCxNa6foQZADXRAtDcaJuh+gP9vDZXlSCWZrr4HOIX6nYF8/QfZH3v
	b/9eMe/ev8i7osHpIALu29j10nzcBl5nuXFBzQH3+E4pt3tLjdZ5Yh1JV7urbXnbkdtIfIkfd+J
	Kkl3+cZf8EwI0j5ZX2uXWNbo7BhfBsl9ug
X-Gm-Gg: ASbGncsv5fISjEni3saif7Wi2kLQPRQeKdkaSKS7JiVM3kXr6uu0UKsoHPfzmOrvLjr
	6LkuypRioKR2ryKP3AJiWSvMTOFQ4dj90usceNpFsv1g0GMYe70/kNCtuv4jh43M8qQFeMm08tQ
	xkCQCkS/9+65WiUYfSeOP4BGFY+Gt+LBGmIA==
X-Received: by 2002:a05:6e02:19cb:b0:3dd:cbbb:b731 with SMTP id e9e14a558f8ab-3df4ab4ba97mr150694505ab.9.1751312006510;
        Mon, 30 Jun 2025 12:33:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLhV90dERUX5Cd1c5ylxgqUOBdppuowz9AEfillEd98+IoEDDYoWIMv0J5NlnbYP/AW4Dv2idc1WkdgUvuL7M=
X-Received: by 2002:a05:6e02:19cb:b0:3dd:cbbb:b731 with SMTP id
 e9e14a558f8ab-3df4ab4ba97mr150694345ab.9.1751312006196; Mon, 30 Jun 2025
 12:33:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630150107.23421-1-desnesn@redhat.com> <CANiDSCu83Ky-604gu2Yt34Wj1Km6Xh+TcPYzQxKZJNWdT7=m8A@mail.gmail.com>
In-Reply-To: <CANiDSCu83Ky-604gu2Yt34Wj1Km6Xh+TcPYzQxKZJNWdT7=m8A@mail.gmail.com>
From: Desnes Nunes <desnesn@redhat.com>
Date: Mon, 30 Jun 2025 16:33:15 -0300
X-Gm-Features: Ac12FXy--Z6I9HxATLzBVcIlb8GTaPJ1_nqz4ejlUIKc7XXzJzGy66npCNZsE3E
Message-ID: <CACaw+exN2qHSPpEmZBNBvXCkrzVUb_VCW7YfYYYaaLzNoOSebg@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: fix build error in uvc_ctrl_cleanup_fh
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: laurent.pinchart@ideasonboard.com, hansg@kernel.org, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ricardo,

I triggered this build error while working in an older codebase that
uses C89 due to legacy support reasons.
Indeed - will focus on submitting C11 compatible fixes even when
working on older codebases.

Thanks for the review Ricardo,


On Mon, Jun 30, 2025 at 12:16=E2=80=AFPM Ricardo Ribalda <ribalda@chromium.=
org> wrote:
>
> Hi Desdes
>
> How did you trigger this build warning? I believe we use C11
>
> https://www.kernel.org/doc/html/latest/process/programming-language.html
>
>
> Regards!
>
> On Mon, 30 Jun 2025 at 17:07, Desnes Nunes <desnesn@redhat.com> wrote:
> >
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
> >         struct uvc_entity *entity;
> > -       int i;
> > +       unsigned int i;
> >
> >         guard(mutex)(&handle->chain->ctrl_mutex);
> >
> > @@ -3268,7 +3268,7 @@ void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
> >                 return;
> >
> >         list_for_each_entry(entity, &handle->chain->dev->entities, list=
) {
> > -               for (unsigned int i =3D 0; i < entity->ncontrols; ++i) =
{
> > +               for (i =3D 0; i < entity->ncontrols; ++i) {
> >                         if (entity->controls[i].handle !=3D handle)
> >                                 continue;
> >                         uvc_ctrl_set_handle(handle, &entity->controls[i=
], NULL);
> > --
> > 2.49.0
> >
> >
>
>
> --
> Ricardo Ribalda
>


--=20
Desnes Nunes


