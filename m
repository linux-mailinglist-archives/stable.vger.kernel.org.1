Return-Path: <stable+bounces-136743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8D1A9D7B4
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 07:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A9A1BC111F
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 05:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981E11A3163;
	Sat, 26 Apr 2025 05:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1vec6Pi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4766A22F01;
	Sat, 26 Apr 2025 05:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647040; cv=none; b=oGQZR5GoKX8rLUNYHKp/Wew82VTIP/YaMz3Se0W3CPoAr8wAZoHMdfCAV2ubfntjQG/rZrZDEFsu5gdSCUjH2NIzVOOKbVTzRWmPOHDem+PbQ+2eMM5SFcWv5jDo4JOxDXTW3EA0hMeyU7wjlo4uF87IgD/DBpr5o5HSva1RIaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647040; c=relaxed/simple;
	bh=EuGaXO4AUfqge9aIu3U3/cXrkwZjHu3A2QfX97QhXTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwM0WXUbdGlZA5LqLooNYQouKuMssI2tg00gysxP7BpcimnBl63V0M/YgIa9K3a80Coh3sRTWM/lAPnqWA6tP+MLpsivO9uSfQEz64IiCoN1nym4S/hBD1W4ShG6WRaR402KX7gwg96TtGCelCHu5JBHoEQ+EEP87EMM537anZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1vec6Pi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95909C4CEEC;
	Sat, 26 Apr 2025 05:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745647039;
	bh=EuGaXO4AUfqge9aIu3U3/cXrkwZjHu3A2QfX97QhXTw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g1vec6PiTS5hnnXT5+r1D22bj9uzumUJtcPUoYAjcMwIevE5RjOFuS0ef2RkRoX+H
	 4h9LpQ6ferxW5CZXoF68fvy4KmHJ0e+8U70sPYI7i1HsiKisubQqpymvTyetIVcnMb
	 /2W5hElxfilWLx+/g5Y7lMtowN/5OvP21KU12saGFehoSt8fIiNahuZv7uemKN4O9w
	 U0E6AmOuQFOQ3ZFOgWNtfO31PGj8NIFC7/o8RQn/b94aAYGQRwJJwZPOomtqQCQw1W
	 +vGMm8AfZ3htGUDKNX4zXawK14inor8mBkXhzBm4ERN9HYJwKXTad2fh+eL4F1mODB
	 2++IMnXgojzlA==
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e6405e4ab4dso3397549276.0;
        Fri, 25 Apr 2025 22:57:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV3YKh9/pWl2bBaeS8QZvGYdVMcNaV7c8Rq8wDmsgN3f4vrgFV9c5+S0WSNANQQvP7GnvpD3zr7Z/W1DIjGu/06BhAC9/c4@vger.kernel.org, AJvYcCW+E16WFhzDiCDebPxTUG5Px4qtKrz44fDrFwPRmY6Gop5+H/oLtoOM82GW4hagmnko4Ch6oxf+beZen3Q=@vger.kernel.org, AJvYcCWrc8QDoJn49p9ZBbfJp2vleZ2GFL2XXjmEWDVZYgmtt1J3bIkhXjT0G2MWoyHibgTxgwYyV4m7@vger.kernel.org
X-Gm-Message-State: AOJu0YwUOaD+0QP2sv55XEb9x4i9D1/76BlPmlJ8tL1sfNo9jXS7lr1q
	r7eAynRMXOoD2hBSeMAw4/Rs4V+xegrKd8IZKCGh7rkcLwXDeQtRghhhFdk4qvTTqQmHXGjJDHV
	VAU+fshseNOI5G40lvaR7t2in/OM=
X-Google-Smtp-Source: AGHT+IEAUrMAb4lbk41X/zXeOwV5Q9goltln/OCwQoil3huO4u47ZZisUzs7Nl6JphjqqoIjeypLZ9IginYBDCo+fNs=
X-Received: by 2002:a05:6902:908:b0:e5d:f98f:6f33 with SMTP id
 3f1490d57ef6-e73051a07cbmr13356033276.10.1745647038911; Fri, 25 Apr 2025
 22:57:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhROjCvwaEJ1-Vc9SQU-x3wmZjeFknxkFGJcpPL28fGm1w@mail.gmail.com>
 <20250426041542.23444-1-alexjlzheng@tencent.com>
In-Reply-To: <20250426041542.23444-1-alexjlzheng@tencent.com>
From: Fan Wu <wufan@kernel.org>
Date: Fri, 25 Apr 2025 22:57:08 -0700
X-Gmail-Original-Message-ID: <CAKtyLkGyaoHr_xVGrWCTSFkqyf8b+hkOX1A0vyOpZUkTcTGtvQ@mail.gmail.com>
X-Gm-Features: ATxdqUG7hYlINfjIqdbRB9oRJuRhxFnLUSnkOZ7MgMMeCIUrNqeNgZQcEfySDso
Message-ID: <CAKtyLkGyaoHr_xVGrWCTSFkqyf8b+hkOX1A0vyOpZUkTcTGtvQ@mail.gmail.com>
Subject: Re: [PATCH] securityfs: fix missing of d_delete() in securityfs_remove()
To: Jinliang Zheng <alexjlzheng@gmail.com>
Cc: paul@paul-moore.com, alexjlzheng@tencent.com, chrisw@osdl.org, 
	greg@kroah.com, jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, serge@hallyn.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 9:15=E2=80=AFPM Jinliang Zheng <alexjlzheng@gmail.c=
om> wrote:
>
> On Fri, 25 Apr 2025 18:06:32 -0400, Paul Moore wrote:
> > On Fri, Apr 25, 2025 at 5:25=E2=80=AFAM <alexjlzheng@gmail.com> wrote:
> > >
> > > From: Jinliang Zheng <alexjlzheng@tencent.com>
> > >
> > > Consider the following module code:
> > >
> > >   static struct dentry *dentry;
> > >
> > >   static int __init securityfs_test_init(void)
> > >   {
> > >           dentry =3D securityfs_create_dir("standon", NULL);
> > >           return PTR_ERR(dentry);
> > >   }
> > >
> > >   static void __exit securityfs_test_exit(void)
> > >   {
> > >           securityfs_remove(dentry);
> > >   }
> > >
> > >   module_init(securityfs_test_init);
> > >   module_exit(securityfs_test_exit);
> > >
> > > and then:
> > >
> > >   insmod /path/to/thismodule
> > >   cd /sys/kernel/security/standon     <- we hold 'standon'
> > >   rmmod thismodule                    <- 'standon' don't go away
> > >   insmod /path/to/thismodule          <- Failed: File exists!
>
> Thank you for your reply. :)
>
> >
> > A quick procedural note, and you may have gotten an email about this
> > from the stable kernel folks already, you generally shouldn't add the
> > stable alias to your emails directly.  You may want to look at the
> > kernel docs on the stable kernel if you haven't already:
> >
> > * https://docs.kernel.org/process/stable-kernel-rules.html
>
> Sorry for that, I will read it. And thank you for your pointing it out.
>
> >
> > Beyond that, we don't currently support dynamically loading or
> > unloading LSMs so the immediate response to the reproducer above is
> > "don't do that, we don't support it" :)  However, if you see a similar
> > problem with a LSM properly registered with the running kernel please
> > let us know.
>
> I don't think that not supporting dynamic loading/unloading of LSMs means
> that directories/files under securityfs cannot be dynamically added/delet=
ed.
>
> The example code in the commit message is just to quickly show the proble=
m,
> not the actual usage scenario.
>
> I'm not sure whether existing LSMs have dynamic addition/deletion of file=
s,
> but I don't think we should prohibit these operations.
>
> Moreover, since securityfs provides the securityfs_remove() interface, it
> is necessary to handle the deletion of dentry whenever it is used. What's
> more, we have EXPORT_SYMBOL_GPL(securityfs_remove).
>
> (By the way, the reason why I noticed this problem is because I needed to
> dynamically create/delete configuration directories/files when implementi=
ng
> an LSM. Of course, I am not dynamically loading/unloading LSM, but
> dynamically adding/deleting directories/files under securityfs according =
to
> the status during LSM operation.)
>
> Therefore, I think we need this patch and strongly recommend it. At least=
,
> it has no harm. Hahahaha
>
> thanks,
> Jinliang Zheng :)
>

We have added securityfs_recursive_remove() for this purpose.

To the best of my knowledge, IPE is the only LSM that will delete
dentry during normal operation.

-Fan

