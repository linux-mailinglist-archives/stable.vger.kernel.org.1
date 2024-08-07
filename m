Return-Path: <stable+bounces-65936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 738BF94ADCB
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 18:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE36281719
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912FE13B293;
	Wed,  7 Aug 2024 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MtPtEs18"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394D713B2A4
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047021; cv=none; b=hyB6OEOjhPVTIKZgYlno2zNaJDVxwsDYNysad8gA4NY1dy3r+gGcHHTR62fmnLcoTZa1OuOzQ7TwrxP7PtyzNIBSzo0x0t1TRxyuURBV4SpjPQamBJLhdRPCAOqLmNtAd4heVzIPiudJZmDrznSh9m6RSVUbpYBFUEtE2HCw31I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047021; c=relaxed/simple;
	bh=OgG5FkPyqJ3g8dMt/FWtdyTIWNMfZWJGRxcmdRefgqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAnQ6xVb4EIsKLREm+ZHUVXjWPBBZsl56bNVInSCYuKq1AA+HpKQv98Uc8pFFY9hIqT6Lak+3DWiydzgyrAKlpft4TV2tu8SG9HTJWJcwzC6GH7uCupJJkpIMv+6JMTNLrELy+yw5Gr6UAb1y3GxQZng+MahIfoEHDsG+KiEkes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MtPtEs18; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef2d96164aso20914961fa.3
        for <stable@vger.kernel.org>; Wed, 07 Aug 2024 09:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723047017; x=1723651817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUUtygdalO7bk/Z6bCE18XjlV3un6MN+ioDxIVvCt4c=;
        b=MtPtEs18epatGtgPDzfY/pUra369AHPcA301BcCKJBROLkg4qA3NaLmB1KBeNstEKf
         LCEaG7xudc2ZyiZDU8gwAltfMLgdpW8wfAzUyy0Dw0C5e5nGAbnbVAskEx4O5JyHZW40
         zU4EJrbWxr/PZy50krKWuRs1QfZH3Ds341RlnKa1NdT3KlSFWla6iJMMkO2VLedVI+gF
         qtXoV/ReHdeokJdWgjMiVWsIo5npnDMXKmaIy6dcVVeCtqa9zh0gH2w+TLux/dltnt6P
         GDFi+yPhSdJxudF7LGlsuCBvm9T68ahfD6b77GergpkB9pjwW1gYPPnXW5MTWhRqqbzE
         mjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723047017; x=1723651817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUUtygdalO7bk/Z6bCE18XjlV3un6MN+ioDxIVvCt4c=;
        b=Rm53HICDePP8szuGvUIt2m8WjAiOlUhO4xJVAmp6jWmL9RksflG5I+AZNHLDly+dOq
         vZyMID/DyQDs7rK8NhHkPqJuz0S2PYxfGL927jYlEpPcN9AYkjeQ3MWSkBuUOv7mQlsy
         /eZsRhlH0gQDHRqzOyA+wqzTif3Iu9GomvTxdzL8mQ5fhBB9EbLhnpMwhV1Le58Ahp0m
         62yUCA/0sxsFK6GeVfA18t6iur2rSGcLba8I/cmdfx+7TNOW+1WLuGPgItiMZfTa4M67
         YAfkbJq4MFTmkyrSiTDpfVNnfuGGUskMSnif3aOyU1JKeqq6/oEa1X/IDB8XpH7DX9Xd
         3fvg==
X-Forwarded-Encrypted: i=1; AJvYcCWvzuT9osUDuPUWYEaA8DG6TLqlWyIc2StMLvKue22i5zCFFTiJQwUkpxKJG6Q8/tuu3CIW731UrgM5lC8SP94NSWJJpoMK
X-Gm-Message-State: AOJu0Yz4NXf+3TN11ZSNGplaEWdntT4f/JEEzFa3lDzND9GTm1J5FF/a
	fk0RIGITAs2S2+WhpRiwXtP+OBIPWbyfzvn7zP0zkQd3al7+ceFvu+hQUE8gXSlUZrgxG+l3SkM
	7wqyz5x87Dno7FV9cbgCAx2VGZNeAUMYD05Qov+GzeGrQ6vNZ
X-Google-Smtp-Source: AGHT+IHEWInsCOqqEyAAKTFREMgwtNF2XkETEMY50w2xXFDRm1D0SyYaIKGDCa8Iiu3gcgY+VFTdUuay84RUe3n1sQI=
X-Received: by 2002:a2e:8199:0:b0:2ef:2b05:2ab3 with SMTP id
 38308e7fff4ca-2f15aa87000mr114819791fa.10.1723047017145; Wed, 07 Aug 2024
 09:10:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024080730-deafness-structure-9630@gregkh> <CAKisOQF_g-tU8BSEvR=Phsi7OFNZH0R7ehnnj8Qam-H6OzSAow@mail.gmail.com>
 <2024080723-hardly-trickily-025d@gregkh>
In-Reply-To: <2024080723-hardly-trickily-025d@gregkh>
From: Filipe Manana <fdmanana@suse.com>
Date: Wed, 7 Aug 2024 17:10:06 +0100
Message-ID: <CAKisOQHy=Z7cmsBX4AFEjto1MragFCaaU2KqQafoDQbiVVxqLw@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] btrfs: fix corruption after buffer fault
 in during direct IO" failed to apply to 6.10-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dsterba@suse.com, hreitz@redhat.com, josef@toxicpanda.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 3:17=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Wed, Aug 07, 2024 at 03:14:03PM +0100, Filipe Manana wrote:
> > On Wed, Aug 7, 2024 at 3:03=E2=80=AFPM <gregkh@linuxfoundation.org> wro=
te:
> > >
> > >
> > > The patch below does not apply to the 6.10-stable tree.
> >
> > Greg, this version applies at least to 6.10:
> >
> > https://gist.githubusercontent.com/fdmanana/96a6e4006a7fe7b22c4e014bc49=
6c253/raw/f29ff056d65ae28025fc9637f9c5773457f4bb9d/dio-append-write-fix-6.1=
0.patch
> >
> > Can you take it from there?
>
> Nope.  Please send it in email form.

Ok, I've just sent it as an email (with you in cc), one for each
affected stable release.
Thanks.

>
> thanks,
>
> greg k-h

