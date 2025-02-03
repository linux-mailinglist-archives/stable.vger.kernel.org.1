Return-Path: <stable+bounces-112030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D60A25D79
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 15:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76C4416C4A9
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 14:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114482AE96;
	Mon,  3 Feb 2025 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6jDgMnD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF64A12E7F;
	Mon,  3 Feb 2025 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593851; cv=none; b=bVEUw1nV6mXDil2s/9lj4fO5eSsriOQ4vLPuYZtkBFXnQgsTbxMbgyP5z3UD2fgHsBFGBOpjM2mKNjiFbNuKrWDmcH/NLBOsKgbXGMadrXAnOYExEfkgkT7ao4fB8ZxwvoKmLcSeJf6rQYUG/Yk1rP5b5nU+klKplDOsbxW0oF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593851; c=relaxed/simple;
	bh=Bfgflru5YVUFZ7ASMuqZW3PVCjyXOqc2p/+ZP2Dkh60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJc6E11HDwiaEhUoPRN8WegJEEZCxE3pna/GDuxniFwnFeqdPrOax6i8mMYoktQ9uR8Cui8HImOPakkFOkSDoMeDua8JqphV+ZlaNtRC7xrKbNrco+HV6MvdTJjdBro6tDyr3SKaOnFuDPBdozkeR9nMh+94Nos5HLJTI4jiPTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6jDgMnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B1FC4AF0B;
	Mon,  3 Feb 2025 14:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738593851;
	bh=Bfgflru5YVUFZ7ASMuqZW3PVCjyXOqc2p/+ZP2Dkh60=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K6jDgMnDq0dFQ53xBeJlxHnrJ8I1u9KJ8+uPMaNhaTJItahic44qJacdAAURpIvBx
	 dKvXbjXpnLur7f8DxhsAKpeMOCLaBs+4CTc1zvVC9nFKAzRNLBRjo9vGPja+IegMen
	 lfyJgQq8NZvoyzUw53VwORArNMQ80/U4rMFp5L4qPh3R3xWeFlcKK+biLHezLdS5kH
	 h59emgOgacqSw4rUwe33U60IZFnjBInzGShlo3K4w0O6h2SYKr2l+w5pZQi5rAv9cL
	 WvdwuJnJP7QjNJillek3Gq3n3QGvirefve2DclQfDPXQ9JwsdxtX1GL+AUHchFBYwy
	 ZtkBz6uS6I8XQ==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab2aea81cd8so804746366b.2;
        Mon, 03 Feb 2025 06:44:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWc+LsTIwhipO8sqEQ5q/2lu1GoSW7ABN7AgHe/uAzNYWq5LZXIan5x3Wz5sJHIPVyrmSXGpbf4Teg6dSM=@vger.kernel.org, AJvYcCXWLF83PIjhcZFxUQHfdRoftzRdImNJx4NAfjqrlAdyV9zkPyykM8cp8plHb6Tq7KOSWTpS74yLrNhF@vger.kernel.org, AJvYcCXx7DQLEIVZ+qlJ0GMj993YM3HS/wvN0UHUX4O+6F23xp5VP472IbdRKNAt0T1wGP821+Xe3uzK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/fMIoNlJRH1L0Tu8g31g32G9Giza3e7KfSeHLP/2uPzPzIx3m
	g9Tfcb35sIXi31OCax1t21Skw1PtqrdipssSRiCTQ6DvpSPi/tGcEJrlu4Yg6pST4lziHye1uN3
	lSVL9KfHJpr0E4NSd6NJFNt5ZGE8=
X-Google-Smtp-Source: AGHT+IHzBb16zo7Eqvl8nv+wE/dsWdiP4hvDhKPVsonuM8YRvFst+h9o+ztWSsOT/uRCJ18WfZUbNAZWihtZC0ExQa0=
X-Received: by 2002:a17:907:1ca7:b0:aa6:becf:b26a with SMTP id
 a640c23a62f3a-ab6cfcc67f1mr2458273266b.9.1738593849864; Mon, 03 Feb 2025
 06:44:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131100630.342995-1-chenhuacai@loongson.cn>
 <2f583e59-5322-4cac-aaaf-02163084c32c@rowland.harvard.edu>
 <CAAhV-H7Dt1bEo8qcwfVfcjTOgXSKW71D19k3+418J6CtV3pVsQ@mail.gmail.com> <fbe4a6c4-f8ba-4b5b-b20f-9a2598934c42@rowland.harvard.edu>
In-Reply-To: <fbe4a6c4-f8ba-4b5b-b20f-9a2598934c42@rowland.harvard.edu>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 3 Feb 2025 22:44:01 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5PQk5aSu13kuqZqXWvusyqKD7a6G7f56CN3F5HjcD0DA@mail.gmail.com>
X-Gm-Features: AWEUYZm0ERHSNnk-fYYYeWeEs86P_PnoJUYPR3CfzB8zjQkVZu_hzakqePnVLMo
Message-ID: <CAAhV-H5PQk5aSu13kuqZqXWvusyqKD7a6G7f56CN3F5HjcD0DA@mail.gmail.com>
Subject: Re: [PATCH] USB: core: Enable root_hub's remote wakeup for wakeup sources
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 2, 2025 at 12:55=E2=80=AFAM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Sat, Feb 01, 2025 at 02:42:43PM +0800, Huacai Chen wrote:
> > Hi, Alan,
> >
> > On Fri, Jan 31, 2025 at 11:17=E2=80=AFPM Alan Stern <stern@rowland.harv=
ard.edu> wrote:
> > >
> > > On Fri, Jan 31, 2025 at 06:06:30PM +0800, Huacai Chen wrote:
> > > > Now we only enable the remote wakeup function for the USB wakeup so=
urce
> > > > itself at usb_port_suspend(). But on pre-XHCI controllers this is n=
ot
> > > > enough to enable the S3 wakeup function for USB keyboards,
> > >
> > > Why do you say this?  It was enough on my system with an EHCI/UHCI
> > > controller when I wrote that code.  What hardware do you have that is=
n't
> > > working?
> > >
> > > >  so we also
> > > > enable the root_hub's remote wakeup (and disable it on error). Fran=
kly
> > > > this is unnecessary for XHCI, but enable it unconditionally make co=
de
> > > > simple and seems harmless.
> > >
> > > This does not make sense.  For hubs (including root hubs), enabling
> > > remote wakeup means that the hub will generate a wakeup request when
> > > there is a connect, disconnect, or over-current change.  That's not w=
hat
> > > you want to do, is it?  And it has nothing to do with how the hub
> > > handles wakeup requests received from downstream devices.
> > >
> > > You need to explain what's going on here in much more detail.  What
> > > exactly is going wrong, and why?  What is the hardware actually doing=
,
> > > as compared to what we expect it to do?
> > OK, let me tell a long story:
> >
> > At first, someone reported that on Loongson platform we cannot wake up
> > S3 with a USB keyboard, but no problem on x86. At that time we thought
> > this was a platform-specific problem.
> >
> > After that we have done many experiments, then we found that if the
> > keyboard is connected to a XHCI controller, it can wake up, but cannot
> > wake up if it is connected to a non-XHCI controller, no matter on x86
> > or on Loongson. We are not familiar with USB protocol, this is just
> > observed from experiments.
> >
> > You are probably right that enabling remote wakeup on a hub means it
> > can generate wakeup requests rather than forward downstream devices'
> > requests. But from experiments we found that if we enable the "wakeup"
> > knob of the root_hub via sysfs, then a keyboard becomes able to wake
> > up S3 (for non-XHCI controllers). So we guess that the enablement also
> > enables forwarding. So maybe this is an implementation-specific
> > problem (but most implementations have problems)?
> >
> > This patch itself just emulates the enablement of root_hub's remote
> > wakeup automatically (then we needn't operate on sysfs).
>
> I'll run some experiments on my system.  Maybe you're right about the
> problem, but your proposed solution looks wrong.
OK, I'm glad to see a better solution. :)

Huacai

>
> Alan Stern

