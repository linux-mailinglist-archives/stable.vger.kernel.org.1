Return-Path: <stable+bounces-25266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2B0869BC4
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 17:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA53EB22FC1
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 16:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F6B14691C;
	Tue, 27 Feb 2024 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I4mwwlWB"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22341420B3
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049697; cv=none; b=M6Vil02KXe2+XrxW7bnyleQG3XfH8v7nTIKXSPCmWoqjsMNGbPYcMJFAK+6IKD7I9EPDNwUh28LQ7BRny3dAeTPZrH18ohG1b2ECljDSnulkNzcgPioT6jX0jFoEdiYFI03xRjSqYdu4FB1cj7O0Duk/mfvScPzLuKsoMHItT3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049697; c=relaxed/simple;
	bh=YcbXQMW6orIGD2J32M5lewwEx24IkTPl43MiFtSywpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h5x2Y8Z7i3Q7cIXSK8Siz0lArxz6El1PsPmf1C2spKiJsgbRZ5MycDhH1x4RasT5tbxpGomJRtv2RBU3LLLBP5gDj7oYHzlhQNelsbR4YLrPRAev75P1z2VM4soMuDNfqGEpR7GIpglhvj8ZLbM6qVNbdbzNe1g/GmWpmoyH160=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I4mwwlWB; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c1a3384741so1462458b6e.0
        for <stable@vger.kernel.org>; Tue, 27 Feb 2024 08:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1709049695; x=1709654495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ac+DW6WihzpCoOAFiLjFcHhP6f2iYTwciWP36cUV4HM=;
        b=I4mwwlWBWiZMVsYyZri+BrABvznzJdfpLDhkf6bWJYaTPX71+h5/owfxnSjWNfpkAY
         nPAdR0wGWT1lxu/+UQb3/bQyhQWeavbcexWPhORfXfQR6jV0GV5VtR3ENgGtuv7WXUCA
         la/fYWCwguC0k9foii7UY+o/2LPWd66tZP2LUIEnpfv1m208fqfjrBKVelMIO4mU9P/G
         2yppWWb5N/tKS4kfxQfQoRWaeK0L5rHiu1aC7I8zhzQ9lE7CNPfetjuk5eVJwmU3KXVB
         IJhTc2PzPUuylsC0lz9KYnBBhdGFEUzrwK+UEKqtz6nVjEvUcwYdMx1OlyaKC1QPOz7S
         Vp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709049695; x=1709654495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ac+DW6WihzpCoOAFiLjFcHhP6f2iYTwciWP36cUV4HM=;
        b=eIL8VuJtayGCzc5ix1oGF/NopIbVP9plp7wuTbqJ6Y627aQ5r/Lj6DeGmHU40TL/9O
         vlaP5/9W63ndukpHahnVgl7269IViqbI6LuC1u+QUvGi1d+3UaUohA0i7KGBjesE4o4C
         hCvlbHDIb/4JDhBmY3YSuKSxqwXfmG6VWLGU726oWbEKUCM/eP6+Jnt2S0fKLUkELqsK
         CjAWBOj8G+P7m1HzMKwhYqjNjOC/0boNnA7+oaAOTp3rnaWwSvNSZBrn4wOwYNG8DK5p
         3jMWJ9TNw/LNepgXO/y0y1s5JMB68zcKlP3aQNV9Xs41ELK5IAWR1b8XhNgpglzVcxX8
         w1RA==
X-Forwarded-Encrypted: i=1; AJvYcCXOwZgx6nlzjSjZOjBJitrseO55M07oRMNcX8BdQ+Jr7rV51gK6mKz8g9b7rwYxgqnQqdtPcvtBn33DNXKoceQjtEDWKYWD
X-Gm-Message-State: AOJu0YzekxOKCtt7oeG0TqLsMeEUcxSmRIXIaf5C31ZeEhrT234VOTBI
	uohOwpkYxIKpw8V2txYH1doPwVYj0YM5ua34ID7HShnSWSADvhqEbm6SVenstS/euzO8s4lOqsJ
	U5zNYxBNM8H0WQVOQMaPJw/aGEJKeoEhBG38D
X-Google-Smtp-Source: AGHT+IE9MdMFU9x6FoxeTlyyLtbrwrCH54o03/D8XMEA7Si2aBMN5Aya/Dkp9vESrpYl2ue09rzvpreM73e0UemlMqU=
X-Received: by 2002:a05:6358:5e8c:b0:17b:5d21:e86e with SMTP id
 z12-20020a0563585e8c00b0017b5d21e86emr12410573rwn.3.1709049694861; Tue, 27
 Feb 2024 08:01:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223190546.3329966-1-mic@digikod.net> <20240223190546.3329966-2-mic@digikod.net>
 <CAHC9VhQGLmeL4Buh3ZzS3LuZ9Grut9s7KEq2q04DYUMCftrVkg@mail.gmail.com> <CAHC9VhTUux1j9awg8pBhHv_4-ZZH0_txnEp5jQuiRpAcZy79uQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTUux1j9awg8pBhHv_4-ZZH0_txnEp5jQuiRpAcZy79uQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 27 Feb 2024 11:01:24 -0500
Message-ID: <CAHC9VhQHpZZDOoPcCqRQJeDc_DOh8XGvhFF3M2wZse4ygCXZJA@mail.gmail.com>
Subject: Re: [PATCH 2/2] AppArmor: Fix lsm_get_self_attr()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	John Johansen <john.johansen@canonical.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 2:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Feb 23, 2024 at 4:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Fri, Feb 23, 2024 at 2:06=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > aa_getprocattr() may not initialize the value's pointer in some case.
> > > As for proc_pid_attr_read(), initialize this pointer to NULL in
> > > apparmor_getselfattr() to avoid an UAF in the kfree() call.
> > >
> > > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > > Cc: John Johansen <john.johansen@canonical.com>
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Cc: stable@vger.kernel.org
> > > Fixes: 223981db9baf ("AppArmor: Add selfattr hooks")
> > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > ---
> > >  security/apparmor/lsm.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > If you like John, I can send this up to Linus with the related SELinux
> > fix, I would just need an ACK from you.
>
> Reviewed-by: Paul Moore <paul@paul-moore.com>
>
> This patch looks good to me, and while we've still got at least two
> (maybe three?) more weeks before v6.8 is tagged, I think it would be
> good to get this up to Linus ASAP.  I'll hold off for another day, but
> if we don't see any comment from John I'll go ahead and merge this and
> send it up to Linus with the SELinux fix; I'm sure John wouldn't be
> happy if v6.8 went out the door without this fix.

I just merged this into lsm/stable-6.8 and once the automated
build/test has done it's thing and come back clean I'll send this,
along with the associated SELinux fix, up to Linus.  Thanks all.

John, if this commit is problematic please let me know and I'll send a
fix or a revert.

--=20
paul-moore.com

