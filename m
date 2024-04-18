Return-Path: <stable+bounces-40193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D822A8A9D2E
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 16:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1B51F25C59
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 14:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D8E28DB3;
	Thu, 18 Apr 2024 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9j4gkR9"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58A71DFC4;
	Thu, 18 Apr 2024 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450834; cv=none; b=k0/DoG+dVEw+2XL0OG/cQe35R/4GH087TWQCrNN0RVZuRm4mzZOmtb4aVxmNkfAU6/HFT80XncK3CfR+qV+f3rsEO2ucuV3hHhvEDJkATBVlNhdP+a2gprSJUIhd9g018tf7YwB9hSHcO68LUY9fJ58adojLpaBtoRCcAu5n3us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450834; c=relaxed/simple;
	bh=RzkZ4NJ0NC6ZEDfgj1yk2bDFK20UepmJNZheivhWCA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8Og4VqsqX9dsvYXH9XQtsFJ8Rz1zTxbf5cVsX6brq836JBxHrDzrjL0NRZF3gp8X+zNeXcZnDuN6zEQ9cH1UIKlB8lFm8ozSC5l0Xr55WYoiC5SbS6EmgCNoWJe6AL1i5qPvPlA68Yh1BXU8/TduXhIlsFanxesrjXS5ERKYJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9j4gkR9; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7d5e27eca85so34933139f.3;
        Thu, 18 Apr 2024 07:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713450829; x=1714055629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=748BDI+jvXbu20mK6aC5g91cz3/RNA8v08jpDyQG20s=;
        b=G9j4gkR9XCdAfK2gbWZtX5gQRv9O6XFPGySoBIcZWUVQVsm6BQxDurMYjG5ok3bT1u
         zh8rY1RR0vn8YsrlmW/2EfBSGe/c/0wHL+QNZTIDZG4y/2KBFwxkh8YGNEQoZtsOXR6c
         O0cZLQux7Jx0NrW+/+gMgFE8P4DY9lFm9LjKeWZXFhfmmDxloGLbvZHoBsqC/OgCSsRg
         cG5WgGxMrwznq4Qv+Wdq+oURzyWD6ur4Hy+TFDaACZ+FDVSPVdfJL4BOfnzeF9dYpOTa
         6FpYxOlL9PflerA2XoQk+d87Kp7kqUScWWrGRVGFMRfXQWWk9Gw9OgrjXQJxbPDtieyK
         rnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713450829; x=1714055629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=748BDI+jvXbu20mK6aC5g91cz3/RNA8v08jpDyQG20s=;
        b=gTBu5TnS9KXiOJ3bJw8+capfdVPz3QU7HrAR/sA6tLPA21njHEahdvEpbBqF2p5s2y
         nMiLqmvyBY38zbddxKnFrUp2N1mPocS8yg5Yuhw6xD3PJhGhBC2mcHteS6iq4CXMQBHn
         01lue8vX9d+kspZwoA9CU93Q6n21CQQjUI2OkoU4OCIw/7vDClwxK/4QC10/kqrz4pub
         2Ypun71zW6QbR5AnL/2hOeI3jEdl+MoyfXKgMdXD2Ab9eNmvDZBhcEfhy/9AAwKJ09/s
         xQKVteW+LO5pFB9vno/DvYFIlzMNzkygb9qK1DfqJpwnL2FIwcpko7E4ELk6Ry/YM/VX
         FAYg==
X-Forwarded-Encrypted: i=1; AJvYcCX5P7FMKE42+YYk/6lkKknE7TTXox2H5RRNfjQ93zgxL+YduNcNW6AP1NBcsSt8SlXkglWQMnTEfcjin+yu0iL8SKEQUSXwI8WE6WT4llrG+k5BaGu/lhck4D2/H/JL
X-Gm-Message-State: AOJu0YzheyNuqjNVEE7pfbIFQsr7kmoJ/ZCaHbqduulMK2LjK5LYe78W
	CEUpiM6wn2H83OGnIOWW1bUGq8xwRrFquzt/u4Bhyio37oz/9iuL2f5sonTGIDTz7yrOpqPCJX0
	GIRdzLY46aimLAlvGLJ9xxVGUmkNgRQ==
X-Google-Smtp-Source: AGHT+IFT+FfdwZ/C4OC8Z5bzAWzrydxAniftNggvWr7l39jIYvywhkaAwImtMYlNPn3dawc7vtaoYGP0E90H67XvgCk=
X-Received: by 2002:a05:6e02:1c47:b0:36a:1f5d:44ba with SMTP id
 d7-20020a056e021c4700b0036a1f5d44bamr4111208ilg.9.1713450828920; Thu, 18 Apr
 2024 07:33:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ded9d793-83f8-4f11-87d9-a218d10c2981@gmail.com>
 <20240416193458.1e2c799d@kernel.org> <4b0495fd-fab5-4341-9b06-2f48613ee921@gmail.com>
 <2024041709-prorate-swifter-523d@gregkh> <17a3f8cb-26d4-4185-8e8b-0040ed62ae77@gmail.com>
 <2024041746-heritage-annex-3b66@gregkh> <ZiBOHF24EDoaI9gm@wunner.de> <2024041800-yelp-grimy-1819@gregkh>
In-Reply-To: <2024041800-yelp-grimy-1819@gregkh>
From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Thu, 18 Apr 2024 16:33:37 +0200
Message-ID: <CAFSsGVsYBJdB0-ve_bxFU8Ps-MS69YSadxqPe39X-6ui5ECiWw@mail.gmail.com>
Subject: Re: [PATCH net] r8169: fix LED-related deadlock on module removal
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Lukas Wunner <lukas@wunner.de>, Jakub Kicinski <kuba@kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 11:55=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Thu, Apr 18, 2024 at 12:33:00AM +0200, Lukas Wunner wrote:
> > On Wed, Apr 17, 2024 at 09:43:27AM +0200, Greg KH wrote:
> > > On Wed, Apr 17, 2024 at 09:16:04AM +0200, Heiner Kallweit wrote:
> > > > On 17.04.2024 09:04, Greg KH wrote:
> > > > > On Wed, Apr 17, 2024 at 08:02:31AM +0200, Heiner Kallweit wrote:
> > > > >> On 17.04.2024 04:34, Jakub Kicinski wrote:
> > > > >>> On Mon, 15 Apr 2024 13:57:17 +0200 Heiner Kallweit wrote:
> > > > >>>> Binding devm_led_classdev_register() to the netdev is problema=
tic
> > > > >>>> because on module removal we get a RTNL-related deadlock. Fix =
this
> > > > >>>> by avoiding the device-managed LED functions.
> > > > >>>>
> > > > >>>> Note: We can safely call led_classdev_unregister() for a LED e=
ven
> > > > >>>> if registering it failed, because led_classdev_unregister() de=
tects
> > > > >>>> this and is a no-op in this case.
> > > > >>>>
> > > > >>>> Fixes: 18764b883e15 ("r8169: add support for LED's on RTL8168/=
RTL8101")
> > > > >>>> Cc: <stable@vger.kernel.org> # 6.8.x
> > > > >>>> Reported-by: Lukas Wunner <lukas@wunner.de>
> > > > >>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > > > >>
> > > > >> This is a version of the fix modified to apply on 6.8.
> > > > >
> > > > > That was not obvious at all :(
> > > > >
> > > > Stating "Cc: <stable@vger.kernel.org> # 6.8.x" isn't sufficient?
> > >
> > > Without showing what commit id this is in Linus's tree, no.
> >
> > The upstream commit id *is* called out in the patch, but it's buried
> > below the three dashes:
> >
> >     The original change was introduced with 6.8, 6.9 added support for
> >     LEDs on RTL8125. Therefore the first version of the fix applied on
> >     6.9-rc only. This is the modified version for 6.8.
> >     Upstream commit: 19fa4f2a85d7
> >                      ^^^^^^^^^^^^
> >
> > The proper way to do this is to prominently add ...
> >
> >     commit 19fa4f2a85d777a8052e869c1b892a2f7556569d upstream.
> >
> > ... or ...
> >
> >     [ Upstream commit 19fa4f2a85d777a8052e869c1b892a2f7556569d ]
> >
> > ... as the first line of the commit message, as per
> > Documentation/process/stable-kernel-rules.rst
> >
>
> Yes, Heiner, please resubmit this, AND submit the fix-for-this-fix as
> well, so that if we take this patch, it is not broken.
>
OK. The fix-for-the-fix was included already. It's trivial and IMO submitti=
ng it
separately would just create overhead.

> thanks,
>
> greg k-hj

