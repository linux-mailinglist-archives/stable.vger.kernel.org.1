Return-Path: <stable+bounces-127275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F487A77109
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 00:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070AC16AEA7
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 22:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208BE1DDC07;
	Mon, 31 Mar 2025 22:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OI3mU6I+"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609373232
	for <stable@vger.kernel.org>; Mon, 31 Mar 2025 22:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743461294; cv=none; b=srpgw8hCUN5hLdb4LRB60Ci6dvxfwKK1P8W3fOdTRVeaaHFSrx8ZKYYvBZEU6BNeY21+nQ+PeeIOKj6GHrCSnEw14ng0UCX+hvQ68oRBQGEUlAahcDWVQ1HqgcOEKLh/72aZ4Q2Q5yGkKwa3mlru1cnI+zKvqqqTyED+R4XLWSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743461294; c=relaxed/simple;
	bh=BSR/YE4VvrCgWKDYqFdKKPAg9EdcDDdcnOlXgIqD1tM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwCi4eTVYymKszbWxwmihrJVU/N8bQR0JErdUWJda0ivK0KNFNts1AyG+959KrB03kTejSyu5p0u2FTouW7MbiSLP2+fnDRp4alkNHFmG0i+jT5wEx7XFQTj9PzpDEqGhIOcXF2IIA95llh1Vh00ELaHA09yE1FPVOxk/csDfKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OI3mU6I+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743461292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCziBBZkDoyw5CJSLALhXd9AzxzhbuF2cQ278j0EGf8=;
	b=OI3mU6I+m+FPJIDo1kSep5sIYKQCr6RahrByIoz+Ntsg2MkCPtNjR0mdpGfsjBNlRk13aD
	rMvrDcnedsev1Uf8cLlHRsfm7ksQiDfEiPO0b6npEHGkUisAsFe1Q9KdFHHOETLV1pR5xL
	jfsLtLePl2KGNFuxz26HzPG3yum6AYc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-_y2FMAziOk6ihfLED_qM1w-1; Mon, 31 Mar 2025 18:48:11 -0400
X-MC-Unique: _y2FMAziOk6ihfLED_qM1w-1
X-Mimecast-MFC-AGG-ID: _y2FMAziOk6ihfLED_qM1w_1743461290
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22651aca434so90989315ad.1
        for <stable@vger.kernel.org>; Mon, 31 Mar 2025 15:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743461288; x=1744066088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCziBBZkDoyw5CJSLALhXd9AzxzhbuF2cQ278j0EGf8=;
        b=Asw5TxXNeJAiUgiA+bdYvxa9V0s/tYghqqXxlcw0pXQ3qA4fsr7MUmvvYlI6rZSgn/
         Kgf13qWYJXK8lPTov19X+g9VXVuwtcICaG5Er5gdSn3iOuAtJ5xLEyerDFwBJneKFGC6
         HK6AQydY9ZVHd+xFa5GrO9Y7vEHG7krpcDZyveShAwVFsFdyn2ZrbgxbSD5A00tfF86F
         fD4bugylFu0HSPH4IKtakREbTaxkG+pQybUkdGyEQRPJXDbTlojUvrFVcHSKUBIvNKwZ
         Vnqhvc55ng0jiLMp9DVyfiXmcv0Lek0HRqDjnqx2GYnEMCcCN7/7c8sBQP/3kgG1t1Ff
         OqEg==
X-Forwarded-Encrypted: i=1; AJvYcCWhFWiqFxywi9LG17ZCCI04iMBMb9EWYoOFTdpsjAAHft2FbJZEAf9QlXU5N+/VFqcOVlk3C/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgigOgkKYdL0UilTvPxbuUmYHUnxFmBvQ/ve7diHXTv1LO7OBh
	/jh4qOxg4A9wUG0030RHq7Rxe/X59CKs1Wv3O7v4bhP+lJD7YS3ezBExlhFC0wSVc8O6CKlctWR
	4ZKK1LfPJbL7zRef0Ye5JfcbjKNHdTAcHC2HV/rPX1ZrNcnFDJQS/hfe48Mo5rWA6YJl1JyTDrS
	50OztUuPR3tUg1Rt0cEsMhjICSC0Ilf5LHPeJG
X-Gm-Gg: ASbGncv422lNorMgyvsalX7TbOG2tCv2uHvXtgsQTwqEsGZAdLEYyar8PXWhTPTW79c
	Xnmyf1oOeQgmW2A00XJ7l13OSjBTu4YMk0HecI8M/AQW2ffaZJ+NW9DdYWaTZUsGXKe9xHMw=
X-Received: by 2002:a17:902:d583:b0:216:7926:8d69 with SMTP id d9443c01a7336-2292fa0258fmr171378895ad.47.1743461288578;
        Mon, 31 Mar 2025 15:48:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnNrcz1PUNJsG7W4Aog0QsyUnRmVX9ycU5q46kOU1d5/CiVUvTjxAVQPgPwi30MEfGIB9IQEPSlUgjRKE8e4g=
X-Received: by 2002:a17:902:d583:b0:216:7926:8d69 with SMTP id
 d9443c01a7336-2292fa0258fmr171378595ad.47.1743461288141; Mon, 31 Mar 2025
 15:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331193656.1134507-1-aahringo@redhat.com> <20250331223154.1fd4b0dc@pumpkin>
In-Reply-To: <20250331223154.1fd4b0dc@pumpkin>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 1 Apr 2025 00:47:56 +0200
X-Gm-Features: AQ5f1Jo0x_vIcaAtoeOm0IQjnrEDud_mqJISb-oUg9IB-eG_dm7BGB9V0hiCLU4
Message-ID: <CAHc6FU5rbJ1=Y2CRN2Wh0kCxbqrKT3ApZUBF0Rw_nUrTDEtNng@mail.gmail.com>
Subject: Re: [PATCH gfs2/for-next] gfs2: use delay during spinlock area
To: David Laight <david.laight.linux@gmail.com>
Cc: Alexander Aring <aahringo@redhat.com>, stable@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 11:32=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
> On Mon, 31 Mar 2025 15:36:56 -0400 Alexander Aring <aahringo@redhat.com> =
wrote:
>
> > In a rare case of gfs2 spectator mount the ls->ls_recover_spin is being
> > held. In this case we cannot call msleep_interruptible() as we a in a
> > non-sleepable context. Replace it with mdelay() to busy wait for 1
> > second.
>
> You can't busy wait like that.
> You've just stopped any RT process that last ran on the cpu you are
> on from running, as well as all any interrupts tied to the cpu.
> Also consider a single cpu system.

I agree. This is easy to fix by waiting after releasing the spin lock.

Thanks,
Andreas

>         David
>
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 4a7727725dc7 ("GFS2: Fix recovery issues for spectators")
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > ---
> >  fs/gfs2/lock_dlm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
> > index 58aeeae7ed8c..ac0afedff49b 100644
> > --- a/fs/gfs2/lock_dlm.c
> > +++ b/fs/gfs2/lock_dlm.c
> > @@ -996,7 +996,7 @@ static int control_mount(struct gfs2_sbd *sdp)
> >               if (sdp->sd_args.ar_spectator) {
> >                       fs_info(sdp, "Recovery is required. Waiting for a=
 "
> >                               "non-spectator to mount.\n");
> > -                     msleep_interruptible(1000);
> > +                     mdelay(1000);
> >               } else {
> >                       fs_info(sdp, "control_mount wait1 block %u start =
%u "
> >                               "mount %u lvb %u flags %lx\n", block_gen,
>


