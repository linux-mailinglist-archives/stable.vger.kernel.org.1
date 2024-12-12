Return-Path: <stable+bounces-103920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562639EFBA3
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 19:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0A028D3ED
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA521D79B4;
	Thu, 12 Dec 2024 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rl3pSDw6"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D371D79BE
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029542; cv=none; b=LfnC09N29g3nxW1UDlFuAjvh00ZBENymiUqz+WvG0SI1U1sBnjmAAYOg3Jl9nvnoZ9q6qo+QQmOKNhi4DcO6t8TkZx7QIbgukYKZNM331WRJDx21ui676SU50nNceNvj3n4z+m62ifx3RaB//Q+G0rrraLH/OmEaOurRUGwrGkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029542; c=relaxed/simple;
	bh=eGl6q1lGo+ZKyjE4nTCpQAPomw6RjNMUUm19MSBPN1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIv5Lcky/LSjt618QmRHr+rleAwlRqtjUpUKFI7rkNVx+FE2tTke5uqMBGZ4o+k4wFB479yIB6UpjOa1ebrts+b/1RCpOekcBrlKFyRr3t7v0f5RDVWaOKB1tn3JJjXn3t/LOCq1J52CIHE8npu07ESOx3wa9lYxp7wiCV13wc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rl3pSDw6; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4679b5c66d0so15001cf.1
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 10:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734029539; x=1734634339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2lyJoVCx88iUREU3+pyBTGh3Gt4EokCf1BI8wZaJvU=;
        b=rl3pSDw6MF164Ljx1aMy3KMHkao/NQsAJWJbjbTZWT+9M5szmph9HTd7Buw0m0zE3Q
         dsEm8dszlO1Hgeuscy8iBQclUhdoSGiUSf6uIZmZ5/bScBOPCp0N08+ydKFrmc4Ik5uU
         X9HzkAhJbOqYWq8vgHELDYvwTfpg3zm9chTrfLpae6wNQTcWHuwlGh/05Trir5eLSV4m
         DQJSjfc0TCP2qyxnoJZGMVJT+7FzUceO4XAM6m9xc1PUvBkwFmFuVkTEbQ3HjhNk572g
         feyGNR5735ikK1ka44V9gusxE6byIaWuUtDOUw+sa2utSF8AEHN9z8mMETEZJ8t/UC9Y
         S0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734029539; x=1734634339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2lyJoVCx88iUREU3+pyBTGh3Gt4EokCf1BI8wZaJvU=;
        b=qqzOrY1UQBxjo7n4KEJTyQQ/rVXPP47LFKpPfEYFfDKmOIPwv3XBhQWRzyVajbTbSa
         j90WZm0VG39WDm+YXSEmcjM5oAZVePFUgJAOMGtgGI26a6UnsizKVnFIcQoe38qQq31Z
         LSlc56cfMKqFjXuof91oorY1Lre9tJwMiXPFR+gAPr7xOMsxcd3kv+h8YT/KidDAzq4b
         y7Z8jMCOzXbkedXw5PuWdyXBnInF9fR9P8362M6Fy0Mvl2UCuKWHg4qZiF8/m86NQQoS
         KMY7IOZsp9M0zevINaS2ln6p2BcEltv3m4KEtEDHFFEytgNma5LiWW8FKUu4ECX+P7oV
         +I5g==
X-Gm-Message-State: AOJu0YzAS5wFiGxYhb1K9AmX43j6staaveyBMz3oYay2fJxIAysIrvwO
	NbfEQ5RWH4PR7m0L5UKAsFv45YQXd7nPFECB8RWTaK1Hlce6wtoKgwQmFS9aOm1X6+mXJXj/t7V
	XoLe9G3OFM2u1gstlVTIArf6wDyFuW/TvyfP4
X-Gm-Gg: ASbGnctci+340NpPqVysJNh2gMrb7zhhr5TiD3Zw0pbL4P2nSiae9fefshN0Tb6/AkY
	qbFcKA4+uX1HMeeiL7qYr2cOEptm7NeYk7+ZPJ6Zb2PLblB/S02CbiUtAq0ewBBIZySTH
X-Google-Smtp-Source: AGHT+IFybzSrvMFfFq1SXdNHFoUDqJ9ork3WhMSGTevWEQ4wqLtRldbG4yTi4w9XO89kLYvdI0LhUxkhh/2SSyI+c8Q=
X-Received: by 2002:a05:622a:1c0d:b0:467:8416:d99e with SMTP id
 d75a77b69052e-467a1003797mr1390071cf.21.1734029539214; Thu, 12 Dec 2024
 10:52:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024120223-stunner-letter-9d09@gregkh> <20241203190236.2711302-1-rananta@google.com>
 <2024121209-dreaded-champion-4cae@gregkh> <CAJHc60zMcf7VZKwc61Z3iGaWHe_HayhViOv=rdFxwoRB=AyH6w@mail.gmail.com>
 <2024121202-gradually-reaction-2cd6@gregkh>
In-Reply-To: <2024121202-gradually-reaction-2cd6@gregkh>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Thu, 12 Dec 2024 10:52:07 -0800
Message-ID: <CAJHc60xTWgCFdQ-Hr0qCPa=FZKK9+8=c44GgTzkc-YPX-jToWw@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: Ignore PMCNTENSET_EL0 while checking for
 overflow status
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>, 
	Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 10:07=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Thu, Dec 12, 2024 at 09:41:28AM -0800, Raghavendra Rao Ananta wrote:
> > Hi Greg,
> >
> > This is an adjustment of the original upstream patch aimed towards the
> > 4.19.y stable branch.
>
> 4.19.y is end-of-life, so there's nothing we can do there.  But what
> about 5.4.y?  If it matters there, please resend it in a format we can
> apply it in for that tree.

The version of the patch from this thread applies to 5.4.y as well. Do
you want me to resend it or will you be able to pick this up?

Thank you.
Raghavendra

Raghavendra

