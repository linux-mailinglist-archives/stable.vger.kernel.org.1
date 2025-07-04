Return-Path: <stable+bounces-160170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA84AF8F0C
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 11:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F9F3B43C27
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 09:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815EE2BEFE1;
	Fri,  4 Jul 2025 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHSfCE5W"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7288E2EAB6B
	for <stable@vger.kernel.org>; Fri,  4 Jul 2025 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751621515; cv=none; b=NDpqVE+JLsSDAzFNpSK3dZBBc6EFQOGjTqwsc8bxrO1OUsJhMxNUQ/hkfW5/ZKQbo7wpkYoKyZMLim9UL85ylh8qjJPdrZ+6iQvQV4GAmtwr3Lfg91SJaZRTIA4vs/4iVrEiAc5ZZ3c96Ba4+GXfNTFOvt3sZx4+++1oiEXAFqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751621515; c=relaxed/simple;
	bh=HEKjx6kiNgJx80yPDYpila9NycdeKP2KZAxeTd0SPJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMtpES0+u2qX1aQ+ypKhtMrC/Bv15OjyarRC3yS7aa03BFLNPrsNa8jnzbGUqLi/VRjmBULXtMvBC3BZ/3gBoklcBTInKLzyunHiijlS77+OGNd/cNiy3pn+P5jSedD1AHPh08Dbvvnw4hhKUgd4GmqZmfsvVHqDHsU5/HnwqTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHSfCE5W; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32cd499007aso6068831fa.0
        for <stable@vger.kernel.org>; Fri, 04 Jul 2025 02:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751621511; x=1752226311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QP74elfwQA4UMvh+wEGCNI/zuNJVYVWDD/IPoDj4LD0=;
        b=HHSfCE5WS/p1xP3NxeeFvUPZZO5xp1YOFoVLDCAPMDxklFk0Ub9U3nefXWGLSXAWyp
         VsH7owkggJ/bV6AfvMOP2ykzi5G/yLY7EPUHhWlR0hA5HP70qDpMValeF0DkdRxgQbgm
         JTnTU5YzjIn4mLkxcROTlz32sVVfxZ3NIJksXZVSiYFcnDTsaujxcoayxn/xqs9uzxTM
         oHtJ3gwnuLVr7OW7nn7DPISgQSBETzS5xJMa02HuPL9prZxJowSh1V1Z42Gnr19ePLEG
         Rvaug6VgX3jkJ4vmge+sgW7Yi774giGX1lmxRrdAkch5daYpp3mmkAq7Soc7dbzhWti5
         597g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751621511; x=1752226311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QP74elfwQA4UMvh+wEGCNI/zuNJVYVWDD/IPoDj4LD0=;
        b=KnTlBk4nyixuEmoa3VWS7YGef5k7Wi/GETrwqlcpGT4I5dzf5O5QNEtrS1rthzooEA
         eQ51mjB7qHzxz/lDHLzA/8JrmTfzAJM3oYiunvKHf50UFA6kn+3O4hx0Z8ntLk1YPcdW
         qOFsSCspe0QFzA2dKsTnh6zBkr9gJwSaFruAjvxKr2qIWphPAD/2/GzblBiVIFse75Ns
         UrHi0ziZtNga9B/jsDq2V0ASUwIUN88MUwZeYu38x4eLdgzrJR3syxKYenMYy7SxVRPo
         8LiyeDx1rjhLOXs9Qj4chVhpS6zCOpDxNIySMFvp41x4WbscWWaH8X+ipiIR8OZ++d4I
         sL8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUeFOQyg/cGNtYNBffMjO65a11L0hsbVxZnuYyZY+UXpmdFDUWkhVqp1415o2Ypw5CWrrR1R0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrSrihRFzAWeAKa52ykxzMCvSFf4/x+WWESS90yPDxhB9iVy9L
	WTwTHEzb1Yvj1oAGGhLaZUJazUKyIP2CKs/eQHrMGKke5RlhCaWaymZUYuqCL9OAd9C8Du8yrro
	OpqnkiMv6SYHdzU7QLBuYuGruExXzpqWKHzP5auk=
X-Gm-Gg: ASbGnctcWHlMlqxXZ9oqxjJ5nfZVstJ6GTV6Uc6SUSGqh4wPTpAXVeN9giMLc86jzdx
	qJrHqHYXZe1sXeMXZVnzY377EDqSn9/k9jEKPn+P+UP3KVIydbn8dxHkgTMhVpdG+zgwLHfQc1e
	x3WP0Iz9xHFOmGMElalVuNhEG1ZriBz90Zh4mkBh/5+SRdBPrk72Yb8aY4BglM5SGBqiF001PGC
	ES3
X-Google-Smtp-Source: AGHT+IGX7MtU3lIUJD2vhSExWgsWUDvncQhFbQ1k+wVir/z73D8luVI89blDvSW2UDlxO/H1Suvi5U+tcTOmWYDgw04=
X-Received: by 2002:a05:651c:4185:b0:32b:78ce:be8e with SMTP id
 38308e7fff4ca-32e5f61876bmr5886421fa.32.1751621511294; Fri, 04 Jul 2025
 02:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624134840.47853-1-pranav.tyagi03@gmail.com>
 <20250624191559-d8d1fb6d1407e834@stable.kernel.org> <CAH4c4jLg+X-2AoC6WgHVkS7gR1Vr2zmEy-Sv-oey8sg0DU6ZeQ@mail.gmail.com>
 <2025070449-lubricant-bullish-4653@gregkh> <CAH4c4jLL8naS6R=8gRaVYK-bJ-oi6ioT1qmvUJy=QVzL0PBi+Q@mail.gmail.com>
 <2025070412-underline-email-3f4d@gregkh>
In-Reply-To: <2025070412-underline-email-3f4d@gregkh>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Fri, 4 Jul 2025 15:01:39 +0530
X-Gm-Features: Ac12FXyTUAbFNUgOWc5nD3Uj3U7ESOo5IGQx0drLVhOVt21mOlYb4N_iEysqoIg
Message-ID: <CAH4c4j+7g5VsET7nzS4myzhPKLNdp6kKraWoX-YLv-5Tv1mHMw@mail.gmail.com>
Subject: Re: [PATCH 5.15.y] xfs: fix super block buf log item UAF during force shutdown
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 2:22=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Fri, Jul 04, 2025 at 02:15:46PM +0530, Pranav Tyagi wrote:
> > On Fri, Jul 4, 2025 at 1:58=E2=80=AFPM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> > >
> > > On Fri, Jul 04, 2025 at 01:16:01PM +0530, Pranav Tyagi wrote:
> > > > On Wed, Jun 25, 2025 at 7:39=E2=80=AFPM Sasha Levin <sashal@kernel.=
org> wrote:
> > > > >
> > > > > [ Sasha's backport helper bot ]
> > > > >
> > > > > Hi,
> > > > >
> > > > > =E2=9C=85 All tests passed successfully. No issues detected.
> > > > > No action required from the submitter.
> > > > >
> > > > > The upstream commit SHA1 provided is correct: 575689fc0ffa6c4bb4e=
72fd18e31a6525a6124e0
> > > > >
> > > > > WARNING: Author mismatch between patch and upstream commit:
> > > > > Backport author: Pranav Tyagi<pranav.tyagi03@gmail.com>
> > > > > Commit author: Guo Xuenan<guoxuenan@huawei.com>
> > > > >
> > > > > Status in newer kernel trees:
> > > > > 6.15.y | Present (exact SHA1)
> > > > > 6.12.y | Present (exact SHA1)
> > > > > 6.6.y | Present (exact SHA1)
> > > > > 6.1.y | Present (different SHA1: 0d889ae85fcf)
> > > > >
> > > > > Note: The patch differs from the upstream commit:
> > > > > ---
> > > > > 1:  575689fc0ffa6 ! 1:  9876b048d8f68 xfs: fix super block buf lo=
g item UAF during force shutdown
> > > > >     @@ Metadata
> > > > >       ## Commit message ##
> > > > >          xfs: fix super block buf log item UAF during force shutd=
own
> > > > >
> > > > >     +    [ Upstream commit 575689fc0ffa6c4bb4e72fd18e31a6525a6124=
e0 ]
> > > > >     +
> > > > >          xfs log io error will trigger xlog shut down, and end_io=
 worker call
> > > > >          xlog_state_shutdown_callbacks to unpin and release the b=
uf log item.
> > > > >          The race condition is that when there are some thread do=
ing transaction
> > > > >     @@ Commit message
> > > > >          =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >          Disabling lock debugging due to kernel taint
> > > > >
> > > > >     +    [ Backport to 5.15: context cleanly applied with no sema=
ntic changes.
> > > > >     +    Build-tested. ]
> > > > >     +
> > > > >          Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> > > > >          Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > > >          Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > > >     +    Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> > > > >
> > > > >       ## fs/xfs/xfs_buf_item.c ##
> > > > >      @@ fs/xfs/xfs_buf_item.c: xfs_buf_item_relse(
> > > > > ---
> > > > >
> > > > > Results of testing on various branches:
> > > > >
> > > > > | Branch                    | Patch Apply | Build Test |
> > > > > |---------------------------|-------------|------------|
> > > > > | stable/linux-5.15.y       |  Success    |  Success   |
> > > >
> > > > Hi,
> > > >
> > > > Just following up on this 5.15.y backport.
> > > > Please let me know if anything else is needed from my side.
> > >
> > > xfs patches need to go through the xfs maintainers for their approval=
.
> > > "build tested" just doesn't cut it at all, you MUST actually test thi=
s
> > > at runtime.  Otherwise, why would you even want this patch applied if
> > > you don't have xfs systems that you care about?
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Hi Greg,
> >
> > Apologies for the oversight. I had assumed that a build test would
> > suffice for a backport since the patch is already merged upstream. I no=
w
> > understand the importance of runtime testing, even for backports. I=E2=
=80=99ll
> > test it on the XFS setup and resend the patch.
>
> Why do you want/need this backported if it wasn't even tested?  Why do
> the backport at all?
>
> confused,
>
> greg k-h

I understand your concern. I came across the upstream patch while
reviewing stable-eligible commits and noticed it hadn=E2=80=99t been backpo=
rted.
I=E2=80=99ve also been going through the XFS code recently
and this seemed like a good opportunity to
get involved. This was the first time I attempted a backport and was not
aware of the workflow.

I realize I should have tested it more thoroughly. Thanks for the
push. I=E2=80=99ll test it properly on XFS and resend it if at all required=
.

Regards
Pranav Tyagi

