Return-Path: <stable+bounces-197121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EED19C8ED1A
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F943AE2F7
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FBB260585;
	Thu, 27 Nov 2025 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PasS5Tkd"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14048212554
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764254745; cv=none; b=iy6Qc5jTBqY8LziLwYRDJvqYwDL8l5k62VlMzMxPWcxqIHLsKiktf5go6rXakuZo7nUcLdehkPFjIHsYIafEPmhkryFYXc2FYniMn9Atmdn0VNhNbyWxIQm86/nLZ3KfQvlc6Cgxd6tVXfclC2IF4kl/ERwQMq3Xcg1+a8SDW/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764254745; c=relaxed/simple;
	bh=h5EIDn3zO1EiDd3St19AXwOI9w8MbbXuBazumuCPEMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSbu/y3SWFkVm50RrGhYvPaJ9uFRZQewEiTI2LAQQ80XN/ANlWbrbbTTX/JPQYtiz5s05+UQzG5ESm7/ZoRsGlJWTQ8MCtZmiX9SN3rBoKv74CGD07mRdykr5ZYnl7OBk/2aZ2IxJCOvSsloW5VPw3rRyubFygdEolPPwqyZO2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PasS5Tkd; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-594270ec7f9so983628e87.3
        for <stable@vger.kernel.org>; Thu, 27 Nov 2025 06:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764254742; x=1764859542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+1kriRHN1uh4HOZtssmXt20UfUj0H+WY/IsmcYezDc=;
        b=PasS5TkdVNfh/9w4PnDgXqwEZ9HSK/2OWjHTvYwd3K29+Fs4drUJW9OrwQNFrYNwWX
         /LteK5tgYFFZxXMB8WTSZCFeRT89aR8HGnkqrABZX2VLeZgwa53B+Nd/rgGqIN8DlGBv
         LSMgqknK+I5+VaWhhBqQ3D7QxfzizyxKJDINU38GlZKZh9g8yqKRQ+8Pw4CVte1KplLW
         uEtneUPj7ffvU4Z3uhGqwOWw5YMeN/abZmWlDPqw7z+BhtocMsYE/BiEFQzwF/IecjxD
         vqneITgyN1LxUfZXawJxXf5XB1ZGJUjNtb9T+0Mgq7Mo+8rARIq4xjo4ZWoRyXaTUGdA
         MLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764254742; x=1764859542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6+1kriRHN1uh4HOZtssmXt20UfUj0H+WY/IsmcYezDc=;
        b=AOjffr3e1IYg7nNxF5h87DcmcIsQb1bPNFntcw2pvWqfCcyvSrBkcIakHI3wohcqMt
         1D/VhppGMMW/k2DnF9UBfscpjEFj5S1pqbdJx0arzPuIiAAiFnzXzpionfHCyNiGbUQB
         PAJYb4r5xiCk7mu1iZO0dEiQ1Bfxa7slDPk6CEvp8pSNhvhKRcFR4bQmtcDZ1+a8M6UZ
         cMPpCKGAjWoUWNiHzH4qvJcaiJZHRlY08P129Gt9cScwNmoLrc2uSDYehgmkkGx7yvGe
         eidIsdHoF+ckQ/7yi3NrgA+CkCluJQ/9QAmH1iLuiQNDU7hPXX3nel/cz+m3kIRvKnoV
         vp2w==
X-Forwarded-Encrypted: i=1; AJvYcCX4WYw1soXzSFsXhQSuzG1D5NY7mQ/IL+QtQDaozbl7oTTcW1acKRQO8V05Sm2I/8H/E/AJKgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Diyk7qw+JM2GKKvhnhxElhLxWML6Ek0Wxtp1uaryiwfIJ/La
	3LWIzSiK/V9E/TfrexLzLBY3dw0qcX/koDhZjZIoeEioeQRSOsxDux+YgARw2oZfx0EW227pStQ
	IQXHA+63Nfa2ur7bMYJF/gz/gaSVCJE+t4+s5oPfIXulcGtZeCqNE
X-Gm-Gg: ASbGncu7lAMGBiKkX0XhINL9jgmqkN/T+qDVYc7hRsAQxFVRC1QXVedhGerF+mCC02h
	1ofbePRocpHB/wtcHKpsBp2aHIdVWdqsEwKinc9fn9S+V9HXR3+ubyxPb9DpYIgTWcCzy28oqRp
	lRGf0mYh3sTQUzJPVNVCaGHrwpfpaLQYbH8h/5Spm1wpO1OFgr1JuWpGmQORGAPcFnSOQZUlt0u
	ufn2piju8Eb1INwhrc4cTZXRYe1Uyc7sX9wO1tMqM9H0Ar5s1WWVnvK/tB3V/tr1E2+xk0dziZB
	G+lhtN2yZGyqZqsDCZeaaH4y4ds=
X-Google-Smtp-Source: AGHT+IH0Q2ZFJLjtvClPskF3iISBIyyRTqT34iTco25g5EqrP5Xu6hqpCr1IP8jCFiaH1jqmrq6XF/yVyLGIYyIFbf0=
X-Received: by 2002:a05:6512:3ba2:b0:594:2bcd:a15f with SMTP id
 2adb3069b0e04-596a3ee5322mr8447892e87.48.1764254741946; Thu, 27 Nov 2025
 06:45:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125102924.3612459-1-ckeepax@opensource.cirrus.com>
 <CAMRc=MfoycdnEFXU3yDUp4eJwDfkChNhXDQ-aoyoBcLxw_tmpQ@mail.gmail.com>
 <2025112531-glance-majorette-40b0@gregkh> <aSWXcml8rkX99MEy@opensource.cirrus.com>
 <2025112505-unlovable-crease-cfe2@gregkh> <aSWl95gPfnaaq1gR@opensource.cirrus.com>
 <2025112757-squash-hesitant-d8d6@gregkh> <aShagMFXfpIYyJPO@opensource.cirrus.com>
 <2025112721-suggest-truth-bfb4@gregkh> <aShb2K1brBmQtioZ@opensource.cirrus.com>
 <2025112716-glimpse-deface-db74@gregkh>
In-Reply-To: <2025112716-glimpse-deface-db74@gregkh>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 27 Nov 2025 15:45:29 +0100
X-Gm-Features: AWmQ_bnni4wOvF6-WtXISj4bGGPPUinP2kwDFTVmzUUpgiQQugMmb5gjdD5M_bk
Message-ID: <CAMRc=MegBo8vxEMd=9tt91SQie9u9_46Z00jzzZXGcvVQs5w5Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "gpio: swnode: don't use the swnode's name as the
 key for GPIO lookup"
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, stable@vger.kernel.org, 
	linus.walleij@linaro.org, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 3:17=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Nov 27, 2025 at 02:10:32PM +0000, Charles Keepax wrote:
> > On Thu, Nov 27, 2025 at 03:07:48PM +0100, Greg KH wrote:
> > > On Thu, Nov 27, 2025 at 02:04:48PM +0000, Charles Keepax wrote:
> > > > On Thu, Nov 27, 2025 at 02:51:50PM +0100, Greg KH wrote:
> > > > > On Tue, Nov 25, 2025 at 12:49:59PM +0000, Charles Keepax wrote:
> > > > > > On Tue, Nov 25, 2025 at 12:58:30PM +0100, Greg KH wrote:
> > > > > > > On Tue, Nov 25, 2025 at 11:48:02AM +0000, Charles Keepax wrot=
e:
> > > > > > > > On Tue, Nov 25, 2025 at 12:43:16PM +0100, Greg KH wrote:
> > > > > > > > > On Tue, Nov 25, 2025 at 11:31:56AM +0100, Bartosz Golasze=
wski wrote:
> > > > > > > > > > On Tue, Nov 25, 2025 at 11:29=E2=80=AFAM Charles Keepax
> > > > > > > > > > <ckeepax@opensource.cirrus.com> wrote:
> > > > > > Do we have to wait for the fixes to hit Linus's tree before
> > > > > > pushing them to stable? As they are still in Philipp Zabel's
> > > > > > reset tree at the moment and I would quite like to stem the
> > > > > > rising tide of tickets I am getting about audio breaking on
> > > > > > peoples laptops as soon as possible.
> > > > >
> > > > > Yes, we need the fixes there first.
> > > >
> > > > Fair enough, but it is super sad that everyone has to sit around
> > > > with broken devices until after the merge window. This is not a
> > > > theoretical issue people are complaining about this now.
> > >
> > > Are people sitting around with this issue in 6.18-rc releases now?  I=
s
> > > 6.18-final going to be broken in the same way?
> >
> > Yeah regrettably that is going to be broken too, at least until
> > the first stable release either does the same revert or backports
> > the same fixes.
>
> Great, we are "bug compatible!"  :)
>
> Seriously, this happens for minor things all the time, not that big of a
> deal normally.
>

Just my two cents: this feature interacts quite a lot with another new
feature: shared GPIOs in GPIOLIB. I've already either queued or have
under review ~7 other fixes. Since in stable, the code from this
series would not interact with gpiolib-shared (because no way this
should get backported), we'd still have a bit of a different
environment in mainline and stable branches.

I would very much prefer to revert the patch in question than worry
about divergences in logic.

Bartosz

