Return-Path: <stable+bounces-144410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7D8AB7580
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 21:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59C8189FCDC
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 19:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B192121A43D;
	Wed, 14 May 2025 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFhIGPHI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0247E28CF61;
	Wed, 14 May 2025 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747250018; cv=none; b=DX2J3IcnHQvgXU84juhB1t4KCHNeUxBxQ/Sxom97YHF43G2VYMjzYQ2lXD+9tSs8CaVXUBKJuzl/f+MEp/o64/Q5q3eK1cjqBpb8MBxdtfcy0Oy/K4kb2rNO4RuxW5iGq+x3kVrRoFOl+Mw09pC52Z3rDnriLmUaTRd59FLJm/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747250018; c=relaxed/simple;
	bh=zej9SKmqO0dcSNjbDPLn64QOUs1HxsHwCa6psbgi4Ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lGpRnwhDE2lvCoxKC3ejzKgRx3xdteP1IkbMcmz62dKxqhnezrc/1ex/bxxPXsqtIBIVcushFRpfNRJX/NMbIXwNNQ0XPyJmCzkKOOU0d453RscehI3j6ANLzI/gCvzgc+3d84zfSm3bocj+VIaX/ASyCILq/+yoZAcG4VeWFCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFhIGPHI; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74068f95d9fso242622b3a.0;
        Wed, 14 May 2025 12:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747250016; x=1747854816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IO3ZK/e+O3LrZ/4Tf68RHMgwIvolbp2ZRRlQwKLIkIM=;
        b=RFhIGPHISnv1rZ36oKidnXMxdVHmLe0vEA7LKuckv4dFtpHMkexF5+3YO9NckNQF03
         kTJiBAseyRoU7DhQBCFeLMkrPPYe6nREx912eZ8Gc7F0inwFRpwFZBljOUBS6CZklGXU
         hFhqsLugSfjSSYfXWHUtNyGIcY75G4lOrLfsEv3+C56tEz6WOJ0xvAoWGYHo5esw6o9m
         x72bgaMnzKEapJZZNtIAOFZYUys5nAqtye6JhfNQ0qpi9lLLjTR+IQM9t3bIXUKMxr2Z
         cOGfnqAaKeBW2jq478ZwPj1uhPRe5KV+UynbcJ54qK7pwmQBDSH3ITOzGs3D41m9/wJn
         4QSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747250016; x=1747854816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IO3ZK/e+O3LrZ/4Tf68RHMgwIvolbp2ZRRlQwKLIkIM=;
        b=WX4brA701zUk4LjqiVSj7PorLlRyyLVVRWEysN7NexlxURMrc8P6RuoFMHmdFHz0G3
         3TEJLJJtNB1X4kPT3EhA2OZ9LLwTZ1niKfpMae8Dv0f6UmY+bdYKF/ApuZea2qQlO9/3
         ANqlVrU7rRo+QCNZmW09VuCRy0iND+VBi7XCbb6ngTrfvJQE8iQn8wayMuqVsuB7AmZu
         ZVcrjkQ1WY6T6jOwewb0zk6nh/7Hx15uHDC1JMo2VnbnA65o3JFS0XFxRw4kUuh8G30a
         CvIP3y+GvH5Hz5VgZlXg1C0qX6m3oxtTZkS6GND4y28Dlx+EmksXVoFIhcj8wvgIfTyp
         Zf8w==
X-Forwarded-Encrypted: i=1; AJvYcCUt9kEsgOz2CwsfA8+/ODEzy9xj1WablZy0L2fku7McBtSQzfIabigZkxSELX5oLiGlU2fm7HDA@vger.kernel.org, AJvYcCXiHhlys3MHFj2hJ5JRwVelThm3GQnQ/yJucsMS0qZbpq7Lmg882EbErSmaRwZGLH/Iov9Y5ietisKWvG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZBmVDVftO81sDcEOIiltkPVx39h03qT4A/18tJfGsIuaNggZY
	QGv+5XHDmaT7Di9x1cKDxk6PTYMtwxHr6z4J+3wPDjEnVWpzRi3JtfAN3XGY43XH05UAqNXfsvb
	c2h/UsP91sHm/x3fbTUbmkacdODg=
X-Gm-Gg: ASbGnctllSHwST7SAaH3LUS1iyXVDRgoVXXekHYTa6Ne1tR5SVKhdufgw/PgYQ5LfN4
	XlFkuW7m4yezeEjL+CZi7mAW10EWvm45nfOzvNRDuC4lWYXgehS9FWsATEz1hMHyqF+i4tIPPTq
	BZATjoE6mdJY1HMVMrXFs6+frF+LcO9C8=
X-Google-Smtp-Source: AGHT+IHrr9YBrLn9sQLvv9G8Qea6GKS65yH4gF3sm1MiWjRHPpmtSszuwUV3S/0XmdJVrWRfUtzFedOc1Da+4fGqLpA=
X-Received: by 2002:a17:903:32cd:b0:223:88af:2c30 with SMTP id
 d9443c01a7336-2319813f8a3mr68289305ad.16.1747250016160; Wed, 14 May 2025
 12:13:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514103837.27152-1-kitotavrik.s@gmail.com> <s5pju6jp2k4ddyuuz2xydeys5lhashkbvwa2lmtw3dmtedupw5@sjdrgnhwsvza>
In-Reply-To: <s5pju6jp2k4ddyuuz2xydeys5lhashkbvwa2lmtw3dmtedupw5@sjdrgnhwsvza>
From: Kitotavrik <kitotavrik.s@gmail.com>
Date: Wed, 14 May 2025 22:13:24 +0300
X-Gm-Features: AX0GCFv_Ab2mxBVLmlLL-SGxsVO6LSKhx6O8AvU7eBN2fVdlcAp5-MKcNmSGZkQ
Message-ID: <CAJFzNq55Vg8TDVPpDbJVs9bVTJP9KL5i3h6jL0zY57UyGC4xWA@mail.gmail.com>
Subject: Re: [PATCH v2] fs: minix: Fix handling of corrupted directories
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Josef Bacik <josef@toxicpanda.com>, NeilBrown <neilb@suse.de>, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org, stable@vger.kernel.org, 
	Andrey Kriulin <kitotavrik.media@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>  guess the easiest is to fudge i_nlinks count in memory to 2 to
> avoid issues...

But if a subdirectory was in the corrupted directory(nlinks=3D 3), it
will be replaced with nlinks 2. And after deleting subdirectory,
nlinks was 1 and the problem will remain. Maybe should return EUCLEAN,
regardless of the mounting mode.


=D1=81=D1=80, 14 =D0=BC=D0=B0=D1=8F 2025=E2=80=AF=D0=B3. =D0=B2 18:54, Jan =
Kara <jack@suse.cz>:
>
> On Wed 14-05-25 13:38:35, Andrey Kriulin wrote:
> > If the directory is corrupted and the number of nlinks is less than 2
> > (valid nlinks have at least 2), then when the directory is deleted, the
> > minix_rmdir will try to reduce the nlinks(unsigned int) to a negative
> > value.
> >
> > Make nlinks validity check for directory.
> >
> > Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Andrey Kriulin <kitotavrik.media@gmail.com>
> > Signed-off-by: Andrey Kriulin <kitotavrik.s@gmail.com>
> > ---
> > v2: Move nlinks validaty check to V[12]_minix_iget() per Jan Kara
> > <jack@suse.cz> request. Change return error code to EUCLEAN. Don't bloc=
k
> > directory in r/o mode per Al Viro <viro@zeniv.linux.org.uk> request.
> >
> >  fs/minix/inode.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/fs/minix/inode.c b/fs/minix/inode.c
> > index f007e389d5d2..d815397b8b0d 100644
> > --- a/fs/minix/inode.c
> > +++ b/fs/minix/inode.c
> > @@ -517,6 +517,14 @@ static struct inode *V1_minix_iget(struct inode *i=
node)
> >               iget_failed(inode);
> >               return ERR_PTR(-ESTALE);
> >       }
> > +     if (S_ISDIR(raw_inode->i_mode) && raw_inode->i_nlinks < 2) {
> > +             printk("MINIX-fs: inode directory with corrupted number o=
f links");
>
> A message like this is rather useless because it shows nothing either abo=
ut
> the inode or the link count or the filesystem where this happened. I'd
> either improve or delete it.
>
> > +             if (!sb_rdonly(inode->i_sb)) {
> > +                     brelse(bh);
> > +                     iget_failed(inode);
> > +                     return ERR_PTR(-EUCLEAN);
> > +             }
>
> OK, but when the inode is cached in memory with the wrong link count and
> then the filesystem is remounted read-write, you will get the same proble=
m
> as before? I guess the easiest is to fudge i_nlinks count in memory to 2 =
to
> avoid issues...
>
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

