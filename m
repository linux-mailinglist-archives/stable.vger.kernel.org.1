Return-Path: <stable+bounces-191688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94148C1E603
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 05:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B84A3A84F3
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 04:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59E22EBB96;
	Thu, 30 Oct 2025 04:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2IiS5gf"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41E9261586
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 04:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761799381; cv=none; b=qlRVS34vgH31grA2FMy5yUEwBfpHcHfcY0iWMlMYsppQwU+72Lyl3p3TbH3TquaScVjTu+J7GrVW/X6twPw9qLmdvzICQtHHOWihfnvakOYz8MLhCi03UlICuAGNeyR6P4+UM1uDSGOnYvci/V58Fe7Gr951oMyxobeRY3Rh8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761799381; c=relaxed/simple;
	bh=MM/27vDFOENHfbbDXz2+qgipNjDt7Jas94SoYZixPRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEpWPwl/mT+LI4GK4UTAdNweJLa6SlQrO1Z4RfsupJwebrH1V96c/KErhHXKzovql0WwJqihEIbH7/PwdIHxJzDnwsqFWGxJJhMxc22DJfs0mMCf6N09NMuwiUNVd56CtQ8IiwWt6LxLiR5mZCvWi6p/xKlLWOs9SXvVLSB95mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R2IiS5gf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761799377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/YCYJ0gKE2kVZG+zLywOGB+upmVtVXPpgC1uB4xQIk=;
	b=R2IiS5gf3jk+4t9FVaatRPOH7QmgzUyksdQDg1mRcwOVunyN6R50bkHgohR1T/31G9Fc59
	47WoZiWkuPPZFLm2f7pGloLUqD7V0GE+K7CNPx6cIGJhDoSKLozga/AAV4stmXBH4xX7lb
	KDVukE2MWljTRCKCCoOsZwcebTCdSO4=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-W9n_eQCANKWNogMk6xJSyA-1; Thu, 30 Oct 2025 00:42:55 -0400
X-MC-Unique: W9n_eQCANKWNogMk6xJSyA-1
X-Mimecast-MFC-AGG-ID: W9n_eQCANKWNogMk6xJSyA_1761799374
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430b3c32f75so7382115ab.0
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 21:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761799374; x=1762404174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/YCYJ0gKE2kVZG+zLywOGB+upmVtVXPpgC1uB4xQIk=;
        b=tRspZ9nZCQ8+t3sEBGUSxze+lEdgvUX3hn7guy7kCra2GxIPV1FasQ/Qc7wZQVDmv3
         tgEKQvR7f5VxQLEBRYq8NLEWMUzENYFR6BsXZGTOWk+/WIlFJ0cjHOXSPWWJlC+8zV+T
         +XmS1UVowoR5yrM9tcHy3aBElUSY1Prv+EBGYFEjvHRFeCV8p7b8qZ2fWbkGab2Qyj5j
         wWTHKA9YPo+BuRg9+2dH8MHvfzQvH7+iSNhTnw8kw/aygZMPWmgu0Rn7HJude1urzBPQ
         RFoNfjPOk+Ix64QVDQ1O8wezm/r7BN4VZwwwAYQPJfOAHNouLz2vunIAyTKEOx2hEjXE
         MTEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy8VrxIrwCAj6N/iVfiKdJJpcAWLThuI/UQzqg30P0J3yv/9HJuUGN1tvb0xODonrfwaoDEeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbTDmw0EtpECJSxYeNhHYD6X4sKq6aLRvxWAThRx+zg8I7a064
	AryP3LvUalvGVjdaXeL44VlxxO26e0SlPb6FeF3DmU1Cra/uJRRyYnbGkc7d9ZrTCQZ8XTlG2/d
	NsEejAM//d64wLez+SQuGCZzQG/9c5Av3wQfsQaqIIm8XiS5kBu5l0aBIWRUlmznI78Ixj3PRKl
	H4cntTnb6+o7euOUGXykwvGWWlMSetfLAI
X-Gm-Gg: ASbGncvWNWs/ZJj30E3npw9G7zCFPQtfOnnVM8tejuI4qtEnBDrFFRZnx17cZHjV47p
	EEzLcKeTjEku5Z5iJQ+5bweZ8M9pJwbMmhHZY6DbA81U4k+9cHSisc0lSS8QSu4wSAjsElPLFqk
	cgAwdDrjFn4bKA4Rfw9G95QXY7x4dtAMvCx471sKK68UCeR1NaL2kDDQizXA6h2Z1S5kUbX3uiE
	XkpBtsIhU8KEOAw
X-Received: by 2002:a05:6e02:4702:b0:433:517:12d1 with SMTP id e9e14a558f8ab-4330517154bmr5696755ab.20.1761799374511;
        Wed, 29 Oct 2025 21:42:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt9jvD8/UAD4YNIQ8lvjCok/GXMTyKA3mEFewCXTrRjEo+XhUWMv41Yv0j4yl3O+ilY/8iIHy4AfBtMKIYF60=
X-Received: by 2002:a05:6e02:4702:b0:433:517:12d1 with SMTP id
 e9e14a558f8ab-4330517154bmr5696645ab.20.1761799374152; Wed, 29 Oct 2025
 21:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029191414.410442-1-desnesn@redhat.com> <20251029191414.410442-2-desnesn@redhat.com>
 <2ecf4eac-8a8b-4aef-a307-5217726ea3d4@rowland.harvard.edu> <CACaw+ez+bUOx_J4uywLKd8cxU2yzE4napZ6_fpVbk1VqNhdrxg@mail.gmail.com>
In-Reply-To: <CACaw+ez+bUOx_J4uywLKd8cxU2yzE4napZ6_fpVbk1VqNhdrxg@mail.gmail.com>
From: Desnes Nunes <desnesn@redhat.com>
Date: Thu, 30 Oct 2025 01:42:43 -0300
X-Gm-Features: AWmQ_bkkDA92_gNFS16WGMU6T-0gOF17VIutMjEeo_EgJSLjGrzLyts6m5W-l-0
Message-ID: <CACaw+exbuvEom3i_KHqhgEwvoMoDarKKR8eqG1GH=_TGkxNpGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: storage: Fix memory leak in USB bulk transport
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	gregkh@linuxfoundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Alan,

On Wed, Oct 29, 2025 at 9:36=E2=80=AFPM Desnes Nunes <desnesn@redhat.com> w=
rote:
>
> Hello Alan,
>
> On Wed, Oct 29, 2025 at 6:49=E2=80=AFPM Alan Stern <stern@rowland.harvard=
.edu> wrote:
> >
> > On Wed, Oct 29, 2025 at 04:14:13PM -0300, Desnes Nunes wrote:
> > > A kernel memory leak was identified by the 'ioctl_sg01' test from Lin=
ux
> > > Test Project (LTP). The following bytes were maily observed: 0x534253=
55.
> > >
> > > When USB storage devices incorrectly skip the data phase with status =
data,
> > > the code extracts/validates the CSW from the sg buffer, but fails to =
clear
> > > it afterwards. This leaves status protocol data in srb's transfer buf=
fer,
> > > such as the US_BULK_CS_SIGN 'USBS' signature observed here. Thus, thi=
s
> > > leads to USB protocols leaks to user space through SCSI generic (/dev=
/sg*)
> > > interfaces, such as the one seen here when the LTP test requested 512=
 KiB.
> > >
> > > Fix the leak by zeroing the CSW data in srb's transfer buffer immedia=
tely
> > > after the validation of devices that skip data phase.
> > >
> > > Note: Differently from CVE-2018-1000204, which fixed a big leak by ze=
ro-
> > > ing pages at allocation time, this leak occurs after allocation, when=
 USB
> > > protocol data is written to already-allocated sg pages.
> > >
> > > Fixes: a45b599ad808 ("scsi: sg: allocate with __GFP_ZERO in sg_build_=
indirect()")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Desnes Nunes <desnesn@redhat.com>
> > > ---
> > >  drivers/usb/storage/transport.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/tr=
ansport.c
> > > index 1aa1bd26c81f..8e9f6459e197 100644
> > > --- a/drivers/usb/storage/transport.c
> > > +++ b/drivers/usb/storage/transport.c
> > > @@ -1200,7 +1200,17 @@ int usb_stor_Bulk_transport(struct scsi_cmnd *=
srb, struct us_data *us)
> > >                                               US_BULK_CS_WRAP_LEN &&
> > >                                       bcs->Signature =3D=3D
> > >                                               cpu_to_le32(US_BULK_CS_=
SIGN)) {
> > > +                             unsigned char buf[US_BULK_CS_WRAP_LEN];
> >
> > You don't have to define another buffer here.  bcs is still available
> > and it is exactly the right size.
> >
> > Alan Stern
>
> Sure - will send a v2 using bcs instead of the new buffer.

Actually, my original strategy to avoid the leak was copying a new
zeroed buf over srb's transfer_buffer, as soon as the skipped data
phase was identified.

It is true that the cs wrapper is the right size, but bcs at this
point contains validated CSW data, which is needed later in the code
when handling the skipped_data_phase of the device.

I think zeroing 13 bytes of bcs at this point, instead of creating a
new buffer, would delete USB protocol information that is necessary
later in usb_stor_Bulk_transport().

Can you please elaborate on how I can zero srb's transfer buffer using
bcs, but without zeroing bcs?
I may be missing something.

Thanks & Regards,

--=20
Desnes Nunes


