Return-Path: <stable+bounces-39194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8828F8A155D
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 15:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B84E91C2151C
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 13:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F3C14C58E;
	Thu, 11 Apr 2024 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+1jf/Sa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D1914BFB4
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712841277; cv=none; b=hYIbJNLibRLFSMYGmNSiLwoYodrjoWFCHoRqnmiMnS/7nMPiNxUN+3PbDRPmUrbMz4hnhLICNMtZDKlBEifTS26yGPSey6ZLsstnrbJls9M6KEElqQ8BMPz9LSJbvdd8DFkNxcYHiky0wGJeJDcqC/Zok3lUuAB0suzD8KHDdj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712841277; c=relaxed/simple;
	bh=RnsMzTZ7QoIRQ13sYwk/A9HIT851PbLvg+eAKN13xr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5jTnN3mKly3nPxzEikuboFyKGlQYxkyTNh6YkK2+sqUvcSLnHZJ2MLT0D2aPdAQDNBnsaDv4JQXRvFuYxPK5npQraiNJY3Ykn1Wo9ra7UcOO0HsO+lyILp9W1XeC0akf5jjyCO3JagNvWvqKz3s6gUTP6WmgG0z24zSTXJIVFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+1jf/Sa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C917C433C7
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 13:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712841277;
	bh=RnsMzTZ7QoIRQ13sYwk/A9HIT851PbLvg+eAKN13xr4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P+1jf/SaOtuVvW5E7u9n75PevbkY7F/2uyL+le1INpfT0yMiBDJfWUA8QS58f4X9g
	 0Fm2tj00LPOSDjDxmUPUVVXQYtOOKDEIlTsGaz1umyrMwZZ3nNhD4QnAftmxWQya7a
	 cie9yDLAN/sX2ijawmxxO21tJbnGLzizo9ZfeDSXfQ0XBgKo8FdP8i4jeLTqGbNYGB
	 vDy97DovZgLPu65CpyK+Ze99IWvjueC2lqt6plx1fZYlHZR1ks4rnjiPQ0nJlMd69A
	 suIX0408JM3FDx5B+iFLigzgheY7jjmQkrBJ7n9NpHn+JF/Urhhlj2ZLj1YZBKPdn8
	 nV/JHyZgNFuLA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d48d75ab70so106326131fa.0
        for <stable@vger.kernel.org>; Thu, 11 Apr 2024 06:14:36 -0700 (PDT)
X-Gm-Message-State: AOJu0YwymPc7O9Nh4ao2ZqOtJidPtvRmZ9Psrpyiw0sB4A+Yd7+QhB/b
	cvYAH8eoxqaYoIkD6DCfmczv682Nac7CEuEpvIIDLQeFINSy/4CvbwjGH1e3Yl2JDd8OOEl51ts
	CtzeeUNS9XnKOgUYARzCmU46wDhE=
X-Google-Smtp-Source: AGHT+IEGqU7TtIEoI72jpUT/+SqRTnlPoecWJbLz5+PvocY89fGut4Aqi0jFWNylo4EZwXgDmD1Okid5gGMuJ3pEpBk=
X-Received: by 2002:a2e:a584:0:b0:2d8:7363:ff36 with SMTP id
 m4-20020a2ea584000000b002d87363ff36mr4254409ljp.37.1712841275368; Thu, 11 Apr
 2024 06:14:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMj1kXEGNNZm9RrDxT6RzmE8WGFG-3kZePaZZNKJrT4fj3iveg@mail.gmail.com>
 <2024041134-strobe-childhood-cc74@gregkh> <2024041113-flyaway-headphone-df2b@gregkh>
In-Reply-To: <2024041113-flyaway-headphone-df2b@gregkh>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 11 Apr 2024 15:14:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEagP6psCc=YcpV9Ye=cMYgu-O8npbzH4qaN1xxe=eQDA@mail.gmail.com>
Message-ID: <CAMj1kXEagP6psCc=YcpV9Ye=cMYgu-O8npbzH4qaN1xxe=eQDA@mail.gmail.com>
Subject: Re: v5.15 backport request
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "# 3.4.x" <stable@vger.kernel.org>, jan.setjeeilers@oracle.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Apr 2024 at 13:50, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 11, 2024 at 12:30:30PM +0200, Greg KH wrote:
> > On Thu, Apr 11, 2024 at 12:23:37PM +0200, Ard Biesheuvel wrote:
> > > Please consider the commits below for backporting to v5.15. These
> > > patches are prerequisites for the backport of the x86 EFI stub
> > > refactor that is needed for distros to sign v5.15 images for secure
> > > boot in a way that complies with new MS requirements for memory
> > > protections while running in the EFI firmware.
> >
> > What old distros still care about this for a kernel that was released in
> > 2021?  I can almost understand this for 6.1.y and newer, but why for
> > this one too?
>
> To be more specific, we have taken very large backports for some
> subsystems recently for 5.15 in order to fix a lot of known security
> issues with the current codebase, and to make the maintenance of that
> kernel easier over time (i.e. keeping it in sync to again, fix security
> issues.)
>
> But this feels like a "new feature" that is being imposed by an external
> force, and is not actually "fixing" anything wrong with the current
> codebase, other than it not supporting this type of architecture.  And
> for that, wouldn't it just make more sense to use a newer kernel?
>

Jan (on cc) raised this: apparently, Oracle has v5.15 based long term
supported distro releases, and these will not be installable on future
x86 PC hardware with secure boot enabled unless the EFI stub changes
are backported.

From my pov, the situation is not that different from v6.1: the number
of backports is not that much higher than the number that went/are
going into v6.1, and most of the fallout of the v6.1 backport has been
addressed by now.

For an operational pov, I need to defer to Jan: I have no idea what
OEMs are planning to do wrt these new MS requirements, if they will
apply to existing systems with firmware upgrades, and if those newer
systems can run on v5.15 to begin with.

@Jan: if this v5.15 backport is important to you, please provide some
more background on why and how this is needed.

Thanks,
Ard.

