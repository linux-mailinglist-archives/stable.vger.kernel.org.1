Return-Path: <stable+bounces-191768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E23E5C22670
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 22:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7205D3B744B
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 21:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307F430F534;
	Thu, 30 Oct 2025 21:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wajr1gIA"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2F130AD05
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 21:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761859257; cv=none; b=h3uVyjsqTWc98qgY/Gu0UoySbbKtUbFXN2Xf0SR0AmA4genxNtSu5ImgyoP0Ed9XPJeTpXaumvSAYuTcd9+xl54B3+rt4AX/Yqc1BZR43LoeVTDxNvmeGqdtJdVEI97thWrKlfbBU0s9/qqvXQXr0V9tYnSMbkSgDIbszgO66qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761859257; c=relaxed/simple;
	bh=CGZsPh7Qbfn/nNuOdzcx2n/7MLAO9wVoGxHMiJBblc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MR/7ccmAw/wS+o+58XI5HaQL8Hhf9ivmZzzxJVDHO/AUs+ZE83NG/LnG4cniEQCI+zuyadLB3UpS3Ejw2uAt243bBwpffHBbE4p6HIuoOejN5qIRU4Q1E6M6qqbsjdyVjNZTVSYRQJg+7rroQD7TruPeV+DNwzLbsuh7KJOZC20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wajr1gIA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761859254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64JB+UtpAImWAb0wR7Piq/8S0upZ5fXa3L3mE9A1Ajo=;
	b=Wajr1gIAo9puMC3Hn6zPTOMJHpVqDHePlh3Bsk1jW+f+hix2lrSgB2YLK35WDffksaC0ux
	BG76YWKRb1lO7RIQf2GS6cO8RX68yNbOhrXtm87ef8hovIhIGe9D0i2+MV2HCTwzgHF2Sy
	itSviEoA485sogjJK4rOsk2z6Vuwzwo=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-moEtRlZCNBCG-v_p4voMMQ-1; Thu, 30 Oct 2025 17:20:52 -0400
X-MC-Unique: moEtRlZCNBCG-v_p4voMMQ-1
X-Mimecast-MFC-AGG-ID: moEtRlZCNBCG-v_p4voMMQ_1761859252
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-94389ae547cso168410739f.2
        for <stable@vger.kernel.org>; Thu, 30 Oct 2025 14:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761859252; x=1762464052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64JB+UtpAImWAb0wR7Piq/8S0upZ5fXa3L3mE9A1Ajo=;
        b=KhA0Y/vx08auIfTY92q4oq5eYAzY3afWQqGP+WGImMIMnL8cg4y9TjIpUEmewlc2E5
         eveQcs/y4dDv5DTFrxEWyquZ4Q0DJu+rfbjRu0dVhxB5VV8Gb0Sqtj0P7JhGPSMvggLQ
         XeGE9MrdcDUql45ZcWOkDfgP3xMKldQGDeHiD4iRNeYuX+UEPwwLtHokZS5QO8ejUwkx
         erNGuoanKLfnYyGtzh0nrWfdHYSvlwnZdYubbW3O44jJ59RdZDKvu4h+8TzcQU+sLOF+
         iQpcjRzK+eBGbkNCs81E4Ptur5zNygjl8TT8U5V0ouv6M0b+WLSNLiE0oOBJ/zdeIv/5
         nM1g==
X-Forwarded-Encrypted: i=1; AJvYcCX7vUZzVIB7ZgAGkEBtLvYqS9GuJ9SesxQdT+0UsqYkxbAnKwVAHolcwXwZ07WZJQttCQrvzxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMuNhe2PeWwzWJYKqfhWnaipAYGKr8qMPS3RYShUVvX6yNnrM5
	T5/cd0Mf5Eb8ihZ5aEqTwH+W85PsnaurqBrbTtCQpPRw5P8X64r83NPe5LFcrWDlB4BIWe4GXYc
	o8BXl+i/UN99c5zlhyD0WRp02DoiybZS9Jx7eBZAKp736JxBJtT5O1yAO3oj04blj6dHqABZ70S
	SUK3tuOjPHzG1R641dUi4nQAeHke1nlSAe
X-Gm-Gg: ASbGncvCZ2iDWQ53OOg5MJHoBUaSmUEdz7hH6MXUcMqbRusFAzQ1YFvZNNHEYCuhrj/
	Uafg3ua19sYmrCoq/QhWAx57+vvNqCNmG8/fmmGAfdboNrknnGzt72xU2bNWcQghDltQcOPcR1k
	6ehKp2HqUcqI4n6abkXuj6d7BiUtDTaAODOVF9ltV1uDqop08QLY7cGuV9jXi+bnjqQ+VXq9HBI
	iC/otLHQ7BTQTc=
X-Received: by 2002:a05:6e02:330a:b0:431:d73b:ea9c with SMTP id e9e14a558f8ab-4330d10a41bmr23034665ab.6.1761859252013;
        Thu, 30 Oct 2025 14:20:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgN2U5chlBfiWKlG6X8J0EwHZ36gcvfxX2xxWqpWDjQF/r2VlBL6lzYmiTHqCc/oyWbjNAh0fm35qStli7sTo=
X-Received: by 2002:a05:6e02:330a:b0:431:d73b:ea9c with SMTP id
 e9e14a558f8ab-4330d10a41bmr23034315ab.6.1761859251559; Thu, 30 Oct 2025
 14:20:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029191414.410442-1-desnesn@redhat.com> <20251029191414.410442-2-desnesn@redhat.com>
 <2ecf4eac-8a8b-4aef-a307-5217726ea3d4@rowland.harvard.edu>
 <CACaw+ez+bUOx_J4uywLKd8cxU2yzE4napZ6_fpVbk1VqNhdrxg@mail.gmail.com>
 <CACaw+exbuvEom3i_KHqhgEwvoMoDarKKR8eqG1GH=_TGkxNpGA@mail.gmail.com> <808ef203-528f-480b-8049-8e3ca4687867@rowland.harvard.edu>
In-Reply-To: <808ef203-528f-480b-8049-8e3ca4687867@rowland.harvard.edu>
From: Desnes Nunes <desnesn@redhat.com>
Date: Thu, 30 Oct 2025 18:20:40 -0300
X-Gm-Features: AWmQ_bl1wn3R3GndEnSFQiIw3Wd6SkEV3lEJ3AdQr91tni6FAUp7Z-tdPipamCw
Message-ID: <CACaw+eyU8jDVibLk4QQX54D6y_-owByXpo9w0p_dk7Wv7hE4iQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: storage: Fix memory leak in USB bulk transport
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	gregkh@linuxfoundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Alan,

On Thu, Oct 30, 2025 at 10:52=E2=80=AFAM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Thu, Oct 30, 2025 at 01:42:43AM -0300, Desnes Nunes wrote:
> > Hello Alan,
> >
> > On Wed, Oct 29, 2025 at 9:36=E2=80=AFPM Desnes Nunes <desnesn@redhat.co=
m> wrote:
> > >
> > > Hello Alan,
> > >
> > > On Wed, Oct 29, 2025 at 6:49=E2=80=AFPM Alan Stern <stern@rowland.har=
vard.edu> wrote:
> > > >
> > > > On Wed, Oct 29, 2025 at 04:14:13PM -0300, Desnes Nunes wrote:
> > > > > A kernel memory leak was identified by the 'ioctl_sg01' test from=
 Linux
> > > > > Test Project (LTP). The following bytes were maily observed: 0x53=
425355.
> > > > >
> > > > > When USB storage devices incorrectly skip the data phase with sta=
tus data,
> > > > > the code extracts/validates the CSW from the sg buffer, but fails=
 to clear
> > > > > it afterwards. This leaves status protocol data in srb's transfer=
 buffer,
> > > > > such as the US_BULK_CS_SIGN 'USBS' signature observed here. Thus,=
 this
> > > > > leads to USB protocols leaks to user space through SCSI generic (=
/dev/sg*)
> > > > > interfaces, such as the one seen here when the LTP test requested=
 512 KiB.
> > > > >
> > > > > Fix the leak by zeroing the CSW data in srb's transfer buffer imm=
ediately
> > > > > after the validation of devices that skip data phase.
> > > > >
> > > > > Note: Differently from CVE-2018-1000204, which fixed a big leak b=
y zero-
> > > > > ing pages at allocation time, this leak occurs after allocation, =
when USB
> > > > > protocol data is written to already-allocated sg pages.
> > > > >
> > > > > Fixes: a45b599ad808 ("scsi: sg: allocate with __GFP_ZERO in sg_bu=
ild_indirect()")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Desnes Nunes <desnesn@redhat.com>
> > > > > ---
> > > > >  drivers/usb/storage/transport.c | 10 ++++++++++
> > > > >  1 file changed, 10 insertions(+)
> > > > >
> > > > > diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storag=
e/transport.c
> > > > > index 1aa1bd26c81f..8e9f6459e197 100644
> > > > > --- a/drivers/usb/storage/transport.c
> > > > > +++ b/drivers/usb/storage/transport.c
> > > > > @@ -1200,7 +1200,17 @@ int usb_stor_Bulk_transport(struct scsi_cm=
nd *srb, struct us_data *us)
> > > > >                                               US_BULK_CS_WRAP_LEN=
 &&
> > > > >                                       bcs->Signature =3D=3D
> > > > >                                               cpu_to_le32(US_BULK=
_CS_SIGN)) {
> > > > > +                             unsigned char buf[US_BULK_CS_WRAP_L=
EN];
> > > >
> > > > You don't have to define another buffer here.  bcs is still availab=
le
> > > > and it is exactly the right size.
> > > >
> > > > Alan Stern
> > >
> > > Sure - will send a v2 using bcs instead of the new buffer.
> >
> > Actually, my original strategy to avoid the leak was copying a new
> > zeroed buf over srb's transfer_buffer, as soon as the skipped data
> > phase was identified.
> >
> > It is true that the cs wrapper is the right size, but bcs at this
> > point contains validated CSW data, which is needed later in the code
> > when handling the skipped_data_phase of the device.
> >
> > I think zeroing 13 bytes of bcs at this point, instead of creating a
> > new buffer, would delete USB protocol information that is necessary
> > later in usb_stor_Bulk_transport().
> >
> > Can you please elaborate on how I can zero srb's transfer buffer using
> > bcs, but without zeroing bcs?
> > I may be missing something.
>
> You're right -- I completely missed the fact that bcs gets used later.
> All right, ignore that criticism; the patch is fine.
>
> Alan Stern

Thanks for taking the time to review my concerns.

Since this patch is using the style of the patch 2/2 patch of this
series, which I'll drop, I'll send a v2 of this patch using the
current code style.

Desnes Nunes


