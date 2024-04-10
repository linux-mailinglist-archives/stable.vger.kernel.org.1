Return-Path: <stable+bounces-37923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E51A89EA1F
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 07:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85599B230A2
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 05:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ED619BA6;
	Wed, 10 Apr 2024 05:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDAj3/ep"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FCF64A
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 05:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712728308; cv=none; b=sUAqzcJ+5kIGdi2J+mIcMrFXqUQBx8iIPqgaV4JWklWUmCQF/6PgH54+oZyenc/h3neHe8u1nnIY+3mIYN9Y3ZvqhQ50SjCqd0MV3beUr6LTfLY2BNczrVTsq5IVRi8rzNOuqZsr3qha2H3gkoa2bhjV3yg6wVDbf6oNyOagTx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712728308; c=relaxed/simple;
	bh=d21ABUaAeM49mDODmGHgyptj1kZp76dciccp4VYKZOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0NU+K1N+YP9RCQ1ULfKl2u1tmLYQ30FBLvOmVVhIQNjEsuqfPbKJogVLlfrauMKB3Efeg1F8btro8nXqahQmgUSfxSGIJbdjOtLZNHCrW469fttwM6uq75DOhAvyrsZ4NQ9eMavlCRdVskIefJQrBUJZInnkND4WrQFuxlDPBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDAj3/ep; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516d0162fa1so7611332e87.3
        for <stable@vger.kernel.org>; Tue, 09 Apr 2024 22:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712728305; x=1713333105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSArN6/OVbrbmYht0HRQ00vU9J3c0dcl+tFZrerzs1g=;
        b=YDAj3/ephd9MyQhAtZsOghpvmXoS1wkIjtA9f9RjbtCqkM2Nxju4WRpLTccvUwKtKl
         s57z2znOV8/Nkw/Ns1GPZishbwA45CvR3yojSFuUvNmzndFKVPgWTQzLKbXiTJhAeObh
         meMmQjBnAvnWyuqdDkcWqooXf8oefbw8NzONXttKTNcgtE4cNI8Ed1GKNSf87w03Zl7u
         zj10HPEBdF6NY4Yi5LmOs1pqyC9yB4u68z7U976c+cO8RpOwGwLbQCDYYDV1AY8yHD5t
         owm0Sduclz/h7FnxQl6ch/9oI1S9lAVqaVcpcGwgVqK4FnlsOQmKpXkLUZmrtd3yXCtV
         n7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712728305; x=1713333105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSArN6/OVbrbmYht0HRQ00vU9J3c0dcl+tFZrerzs1g=;
        b=FxkqX1KPZDWsqdDJqfFO8oG0UcZhiQi9Bk4aEYgjCI94rb1vYxcu5Yxq08mocTcX1y
         Hnu9AHdCvGW31LS10xXDvivVaPfLB3qIo3/TmoxnHUDn48TCaTTROsTqOHLphm6GeXQy
         93O7QrD2GMWsxIyD4eNajTBZ4RIGQqk2j+Tt4hhy9eq9GPmo82wb6hjXxMKw5fTwaioX
         OTYdy/VHxlKA/B034pNxdTj35CDODYYzwCYpozBB9A7hj0W96w1rpD1hWLLdql/aJrd4
         2aU44oF6y5oVJLtbx/r0H/rWORpcbPPcCVQb0BkyqGz5xmDuINGov7WXmxKQARE0xjWp
         Sflg==
X-Forwarded-Encrypted: i=1; AJvYcCUhCQVjgiwIl5nFgrAx5LPvHcFFijGy6PNzboZbBXO7MQ1XBe6v13kotms7hj6S+4+XiFY+lWY2I6kRu2wxGAEvLB+Ww4xW
X-Gm-Message-State: AOJu0YyGjYTKqF4hvLo24LCXESPIdYTX3AtgGvB22ttpWeixCXnGD+7+
	KZmI1mxe5DPpmfx8c0Lf5D0Mulw4t7JRFo4CRtxPbGnlOdP6ry5xwz+bgVTRwtvmKziqHkgr0JU
	VTmJ2dg+520sYCTccgzZH1kVisIc=
X-Google-Smtp-Source: AGHT+IEh023x91Y5leov2wRO6be2Xl5NdzENRttgFWf8OZ7h8uxIUupbzI5IhrBDbI9i5Iit10tk877dlnRfatEggzg=
X-Received: by 2002:a19:ad03:0:b0:517:bb:fbb4 with SMTP id t3-20020a19ad03000000b0051700bbfbb4mr973374lfc.66.1712728304735;
 Tue, 09 Apr 2024 22:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFTVevX=yujOXoDJYRJWuPgvWfVYUL5ZmoKfy_3u5qHi741Sag@mail.gmail.com>
 <2024040512-koala-landside-7486@gregkh>
In-Reply-To: <2024040512-koala-landside-7486@gregkh>
From: Steve French <smfrench@gmail.com>
Date: Wed, 10 Apr 2024 00:51:32 -0500
Message-ID: <CAH2r5mtcvQ7Dp5Pm-0XJHdYB44rkbrRG2OpDRQV0tB53vFFdSA@mail.gmail.com>
Subject: Re: Requesting backport for fc20c523211 (cifs: fixes for get_inode_info)
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Meetakshi Setiya <meetakshisetiyaoss@gmail.com>, stable@vger.kernel.org, 
	Shyam Prasad N <nspmangalore@gmail.com>, bharathsm@microsoft.com, 
	Shyam Prasad N <sprasad@microsoft.com>, Meetakshi Setiya <msetiya@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 1:35=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Wed, Apr 03, 2024 at 12:34:43PM +0530, Meetakshi Setiya wrote:
> > commit fc20c523211a38b87fc850a959cb2149e4fd64b0 upstream
> > cifs: fixes for get_inode_info
> > requesting backport to 6.8.x, 6.6.x, 6.5.x and 6.1.x
> >
> > This patch fixes memory leaks, adds error checking, and performs some i=
mportant
> > code modifications to the changes introduced by patch 2 of this patch s=
eries:
> > https://lore.kernel.org/stable/CAFTVevX6=3D4qFo6nwV14sCnfPRO9yb9q+YsP3X=
PaHMsP08E05iQ@mail.gmail.com/
> > commit ffceb7640cbfe6ea60e7769e107451d63a2fe3d3
> > (smb: client: do not defer close open handles to deleted files)
> >
> > This patch and the three patches in the mails that precede this are rel=
ated and
> > fix an important customer reported bug on the linux smb client (explain=
ed in the
> > mail for patch 1). Patches 2, 3 and 4 are meant to fix whatever regress=
ions were
> > introduced/exposed by patch 1.
> > The patches have to be applied in the mentioned order and should be bac=
kported
> > together.
>
> Then PLEASE send this as a patch series, as picking patches out of
> emails that arrive in random order in a "correct" way is tough, if not
> impossible for us to do.
>
> Please send these as a backported set of patches, OR as a list of
> "cherry-pick these git ids in this order" type of thing.  But spreading
> it out over 4 emails just does not work, and is very very confusing.

To make it easier, I recommend we wait a few days on this as there is
one more important fix for this series that was recently found (by Paulo)
and I haven't sent to Linus yet - then can send the complete set
for at least 6.8 and 6.6 stable.  Do you prefer a separate email
for the 6.8 version of these, and another for the 6.6 rebased
version of the series - or all as one email? AFAIK she hasn't
rebased for 6.1LTS.



--=20
Thanks,

Steve

