Return-Path: <stable+bounces-191683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02135C1DED7
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 01:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40213A599F
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 00:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7521E51EA;
	Thu, 30 Oct 2025 00:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HoJR5X5m"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97771E7C34
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 00:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761784621; cv=none; b=DMRt5SV1Vwnr/ydLbQIq/JvHNUL47L9WWr3CUab1Qz2hba8Bfq6bEvBKwvDjEg16OT9x2S5lK8ii302fxwSSeHI7+EtJpK4vz7P0MDzvOg3JirxQROnX6rl+MlbXP5jZCVc+aHUkwc+IRNajC9rWHNWtBpIWNOewFvp4J4j/hlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761784621; c=relaxed/simple;
	bh=vc+Z4vwJmfybJI6vUwSlj+i4Y37gu+pDm/b5oN1SdWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBCp80iCtI+LdN3zjAPtTZP1Sluqo5X5k7zDxtFZYjSSpwjTRSqe343F0AT7eGDq0YTpCoE+uI6iKAfZAqObxKal1la6o6EPQCZ893Vf23EBQeucIKzxsK0EwUwmO53rFUYSMVcBkFZAZKaUDrU9toAdL0lHg/oXTW8+vwCqKpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HoJR5X5m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761784619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RpdMkLEBxAzGgTMAiZJaINSdgkvujrmbEy562gQUFuo=;
	b=HoJR5X5mrJxPh9yCxSrpfT5MLOXHoJq0CZtiTTslOVj8Eap3upmQb8yARzRIIjl+z2dRi6
	ti3tlLLohv+InFexAe9qcRBl77KjSwzWniUIuAl+2Gxxl4IwLb158eo8OU3kcIn51xrI0A
	gx2YOTYwLYhtSHxH1/kiTzFS7xa6V5w=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-yfGPUn0jMWePk0OkpTCOSA-1; Wed, 29 Oct 2025 20:36:57 -0400
X-MC-Unique: yfGPUn0jMWePk0OkpTCOSA-1
X-Mimecast-MFC-AGG-ID: yfGPUn0jMWePk0OkpTCOSA_1761784617
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430cf6c6e20so7744935ab.2
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 17:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761784616; x=1762389416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpdMkLEBxAzGgTMAiZJaINSdgkvujrmbEy562gQUFuo=;
        b=T+riwnKPO2p/SwpR5AxHfTRSoYb9QirtU3V6DfuuTEQvB8Ky+MgmUoFlrdcHyNKr4Y
         8yp7YuILGlxWY5vEL4s1WV25fI/l9vXGuivlq2EmUT3/aecDpVlndPTBy9xt0gvB12/O
         LKngdui0jIucDlGeyARZGOK55KFBWpTkOmdKs4M3Mu28uAw3Hs0jgwGWyfqyZulh3/Ad
         Vf7ffoetJfQaphS612+FW+gVDdOwxDgd6+s5veaMsf5cV2DXaRhw2W9DmS0nz55qGQeR
         sQJ9UlbF5HqpXIUzdiImEBYn4YxnnDwgDP7Qc80GheU7DwogPleR3sTwkP2Tqg6bkw/f
         R73g==
X-Forwarded-Encrypted: i=1; AJvYcCVVJkCKPRYaa7y/b8vdHclLMr6QzZvuVEKQ+b4UNDzCeQQ3O6wyc4HbMyCyWYYPKRooGj8cpqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPLob8ODqJHANMe6e5Kgwe5VWr4dUiX6qbNcaCJHjWr5BP3zii
	KPru5o+0le0UNIkgcwv9uHHfPgnJDex7EhcdbfsEZPOYiciHsVgmpiCZGpxXkAwZ1jxulyosgFM
	CVnztZSN2pRNb7FKl3EO7+sddrZ3E8UPm9CcsC9niroFEvJM90d8fHYHCjoh6k5LWaFOq+UkrUG
	pm/sUAfb1bBw3F3ShC/wQ3hqLjVkkXSPzijZTds8EN5CE=
X-Gm-Gg: ASbGncuIZmQ/kwr0OLj6I8eB/nmpt2rWA/ziYJEEqFmwd8XwSH6+fTg4dYJfjuJAa0z
	VUk173DoA4J9k96zCV89ihCbSU9ZXSRvh230JHNNszubuIvWgJTSRrZnSoKB9DZrwLeV5/FRq5T
	WIpgp8TPS2OM8F/QPvcBEVnRFmSgSh2DMiwnQEOlBsIUZJkzvlSqKEqSA5KWBZDjlvkFQ8VMvvh
	KbuQ5427Os3ySsh
X-Received: by 2002:a92:cdab:0:b0:42f:9eb7:759b with SMTP id e9e14a558f8ab-432f9044dffmr57158545ab.28.1761784616634;
        Wed, 29 Oct 2025 17:36:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZuijjJOo7FLk3K/tPaprJFeBWImzkLs7KAevx4fRe2hGV4YYIEo0lHTFjE0zedcBVsWSD7uSDSINEiDu/904=
X-Received: by 2002:a92:cdab:0:b0:42f:9eb7:759b with SMTP id
 e9e14a558f8ab-432f9044dffmr57158385ab.28.1761784616273; Wed, 29 Oct 2025
 17:36:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029191414.410442-1-desnesn@redhat.com> <20251029191414.410442-2-desnesn@redhat.com>
 <2ecf4eac-8a8b-4aef-a307-5217726ea3d4@rowland.harvard.edu>
In-Reply-To: <2ecf4eac-8a8b-4aef-a307-5217726ea3d4@rowland.harvard.edu>
From: Desnes Nunes <desnesn@redhat.com>
Date: Wed, 29 Oct 2025 21:36:45 -0300
X-Gm-Features: AWmQ_bkf3Zl0zsrq7ig32Ls3dqm_dQGASmfXfNZq2huLPMng2uafO8z-59mTHrg
Message-ID: <CACaw+ez+bUOx_J4uywLKd8cxU2yzE4napZ6_fpVbk1VqNhdrxg@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: storage: Fix memory leak in USB bulk transport
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	gregkh@linuxfoundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Alan,

On Wed, Oct 29, 2025 at 6:49=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Wed, Oct 29, 2025 at 04:14:13PM -0300, Desnes Nunes wrote:
> > A kernel memory leak was identified by the 'ioctl_sg01' test from Linux
> > Test Project (LTP). The following bytes were maily observed: 0x53425355=
.
> >
> > When USB storage devices incorrectly skip the data phase with status da=
ta,
> > the code extracts/validates the CSW from the sg buffer, but fails to cl=
ear
> > it afterwards. This leaves status protocol data in srb's transfer buffe=
r,
> > such as the US_BULK_CS_SIGN 'USBS' signature observed here. Thus, this
> > leads to USB protocols leaks to user space through SCSI generic (/dev/s=
g*)
> > interfaces, such as the one seen here when the LTP test requested 512 K=
iB.
> >
> > Fix the leak by zeroing the CSW data in srb's transfer buffer immediate=
ly
> > after the validation of devices that skip data phase.
> >
> > Note: Differently from CVE-2018-1000204, which fixed a big leak by zero=
-
> > ing pages at allocation time, this leak occurs after allocation, when U=
SB
> > protocol data is written to already-allocated sg pages.
> >
> > Fixes: a45b599ad808 ("scsi: sg: allocate with __GFP_ZERO in sg_build_in=
direct()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Desnes Nunes <desnesn@redhat.com>
> > ---
> >  drivers/usb/storage/transport.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/tran=
sport.c
> > index 1aa1bd26c81f..8e9f6459e197 100644
> > --- a/drivers/usb/storage/transport.c
> > +++ b/drivers/usb/storage/transport.c
> > @@ -1200,7 +1200,17 @@ int usb_stor_Bulk_transport(struct scsi_cmnd *sr=
b, struct us_data *us)
> >                                               US_BULK_CS_WRAP_LEN &&
> >                                       bcs->Signature =3D=3D
> >                                               cpu_to_le32(US_BULK_CS_SI=
GN)) {
> > +                             unsigned char buf[US_BULK_CS_WRAP_LEN];
>
> You don't have to define another buffer here.  bcs is still available
> and it is exactly the right size.
>
> Alan Stern

Sure - will send a v2 using bcs instead of the new buffer.

Thanks for the review.

--=20
Desnes Nunes


