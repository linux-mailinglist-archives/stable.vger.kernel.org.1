Return-Path: <stable+bounces-164848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A3AB12C7F
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 23:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1741189F0D7
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 21:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755FF21B9C3;
	Sat, 26 Jul 2025 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dzNPhLLo"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F97F1FBE80
	for <stable@vger.kernel.org>; Sat, 26 Jul 2025 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753563694; cv=none; b=kXvG25B79fYSSe+LNEpn48k9eCOKPa2tkAKclkJJM49BLXRpNWAFmsNvm3JArR9ENzxRowNuxXGP24SKIoGohl/BU7dnkTDXHiuDpQuDbAQenbLarytdr49IuTOCfbJiMpWV109Jlafr9jTDJ72/rS3yOGNDu0clvmOaeXkJCDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753563694; c=relaxed/simple;
	bh=GOOK+NKSqEawB65E8IgBt4psR5xQS3I+Ix0GnU5cvbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXNaWlzvM9FHC3Hq57cqDY1PLzrgY4xxhlNs1CFbar65TSQ9rtMxnPm+Ok+irjQAQLIPGnYtUdtOcUCFUEqiUlL4t7XEhZU7Au48iBPPlUIoXq4BltW8xjlPpdowB/KjifqtsY7/RWe7n6DH+8q5Fczdm8iju4MLbBoed/6v82I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dzNPhLLo; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3e283b2d065so153295ab.1
        for <stable@vger.kernel.org>; Sat, 26 Jul 2025 14:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753563692; x=1754168492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9x4fJxfKzaOWGYLSu6UptUSjwhrzaz0p9fgAriJd8/o=;
        b=dzNPhLLoPrnwwuVwkdGMUHlGGzqygzbnBOncbw2UTpcBu4goNE2AriuImgCpl5oaEL
         smS9azGCX3obUllUHLltFbN/2dhvPIPjomOpxDpmxZaLsmZqzfoEu1hy7IYMiwkS4B/U
         /UGdndgd0bpawluqE54nOnStV6ovBG0cEXSVhe0VvyHzzju3I+MvoYBSFPIQPUKM6808
         e+Vgui9ImsVcOOtIDX337+WA1fl6u7mVvgj7M7gUgl4aN/3/Hzadi31fwMGNWddTMtNJ
         gZ+GpuyBW8GdcJOsDRn9QiqlDul/SfQEOFeNOqF91QjkPhqfK3gXmEeU9ZQOZs3+zHeq
         svmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753563692; x=1754168492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9x4fJxfKzaOWGYLSu6UptUSjwhrzaz0p9fgAriJd8/o=;
        b=pMawrOzOhGFiigqa0PPcxOBcRphXThD5X0nJtuIQigsnirPTaI3ksLNDuDLxdW7VS/
         8Hv/xNJWfkt2c78IWR+WXOcuhjDHlunjEG7U0hWzXWcahm9IGOR7QvEPenya3UkM2MzR
         sBcmFYynQGDSFjNezQrHF6V2oG8luXAOdfFsN37DRIXOc6kVnAglbyYEqOXogYuQ2O7z
         fDeU21m/JvwdAxwpvrT+vqd36cAv1SDG/19d1re3HF4pyJIrCWkJ5NwlLGcT20LpKOkP
         lLFPgT1N7ZoDyFL/0DIzcbwcVOahgE470LF7kX24+2b5NXI9NpY8KDQdQmJin/oiAUuy
         /Cxg==
X-Forwarded-Encrypted: i=1; AJvYcCWP9/qTgAhPzMboZ5i2oilJgK1cCnaptpdIfweFaQ/d5ryouDCMNdsfGVqKFTHwEWpEnHaN9zI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7gemxs0eayUfxRPeIQlTffX0PPT4CUgfHrhZqOxEcYTPt3HCE
	m6ukjkjo5xa5Q20973vmL63Ll9aiE7AW1vPHC+FFrcj2lpIhNRA5BTX0XUcQteynf6+//z2xmFR
	0YY9gIr4kIk4T+R+6r9IfnVeBtfvcZUu2qVBHanzT
X-Gm-Gg: ASbGncuxoTk3fOYNxjOM3yAylCybloGYxtWrAV8Oz08MtZlC977NCMccMRjHOZhvUEH
	YO2Ux8giO7Ptw+787gDHyoNGpLGZmP1Ta2jTx5IU+i37U2MZCCBoKS991dLuFGk8SL766IVe/jQ
	C67VPCKDKQxofrj29AStRw0ooPT912hFqnaQKYNQTCW8BlGs/926zIcnPZf6BRy4KhIQZm8Fd4W
	zj2EtxH
X-Google-Smtp-Source: AGHT+IEmA1DUIGHQb1RhToZt+PXTE893jXnkv9Gcbost3232KkW59jU5rvsNSTpPTWHOWmtITWmZ8sfC05S61MmnGZo=
X-Received: by 2002:a05:6e02:3786:b0:3e3:b0ed:2170 with SMTP id
 e9e14a558f8ab-3e3cbf79f02mr2916975ab.6.1753563691516; Sat, 26 Jul 2025
 14:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANaxB-xXgW1FEj6ydBT2=cudTbP=fX6x8S53zNkWcw1poL=L2A@mail.gmail.com>
 <20250724230052.GW2580412@ZenIV> <CANaxB-xbsOMkKqfaOJ0Za7-yP2N8axO=E1XS1KufnP78H1YzsA@mail.gmail.com>
 <20250726175310.GB222315@ZenIV>
In-Reply-To: <20250726175310.GB222315@ZenIV>
From: Andrei Vagin <avagin@google.com>
Date: Sat, 26 Jul 2025 14:01:20 -0700
X-Gm-Features: Ac12FXyA3quU2h7NGWT-ipBC-zbAngmnxqJ3Jg4xKgmnSzqf6a1vVrUdwUoL6Fs
Message-ID: <CAEWA0a6jgj8vQhrijSJXUHBnCTtz0HEV66tmaVKPe83ng=3feQ@mail.gmail.com>
Subject: Re: do_change_type(): refuse to operate on unmounted/not ours mounts
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrei Vagin <avagin@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	criu@lists.linux.dev, Linux API <linux-api@vger.kernel.org>, 
	stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 10:53=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> On Sat, Jul 26, 2025 at 10:12:34AM -0700, Andrei Vagin wrote:
> > On Thu, Jul 24, 2025 at 4:00=E2=80=AFPM Al Viro <viro@zeniv.linux.org.u=
k> wrote:
> > >
> > > On Thu, Jul 24, 2025 at 01:02:48PM -0700, Andrei Vagin wrote:
> > > > Hi Al and Christian,
> > > >
> > > > The commit 12f147ddd6de ("do_change_type(): refuse to operate on
> > > > unmounted/not ours mounts") introduced an ABI backward compatibilit=
y
> > > > break. CRIU depends on the previous behavior, and users are now
> > > > reporting criu restore failures following the kernel update. This c=
hange
> > > > has been propagated to stable kernels. Is this check strictly requi=
red?
> > >
> > > Yes.
> > >
> > > > Would it be possible to check only if the current process has
> > > > CAP_SYS_ADMIN within the mount user namespace?
> > >
> > > Not enough, both in terms of permissions *and* in terms of "thou
> > > shalt not bugger the kernel data structures - nobody's priveleged
> > > enough for that".
> >
> > Al,
> >
> > I am still thinking in terms of "Thou shalt not break userspace"...
> >
> > Seriously though, this original behavior has been in the kernel for 20
> > years, and it hasn't triggered any corruptions in all that time.
>
> For a very mild example of fun to be had there:
>         mount("none", "/mnt", "tmpfs", 0, "");
>         chdir("/mnt");
>         umount2(".", MNT_DETACH);
>         mount(NULL, ".", NULL, MS_SHARED, NULL);
> Repeat in a loop, watch mount group id leak.  That's a trivial example
> of violating the assertion ("a mount that had been through umount_tree()
> is out of propagation graph and related data structures for good").

I wasn't referring to detached mounts. CRIU modifies mounts from
non-current namespaces.

>
> As for the "CAP_SYS_ADMIN within the mount user namespace" - which
> userns do you have in mind?
>

The user namespace of the target mount:
ns_capable(mnt->mnt_ns->user_ns, CAP_SYS_ADMIN)

