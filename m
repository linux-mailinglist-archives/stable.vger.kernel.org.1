Return-Path: <stable+bounces-10867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E55B82D694
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 11:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB61A1F218D5
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 10:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44877EAF8;
	Mon, 15 Jan 2024 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMiQLrie"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D06E568;
	Mon, 15 Jan 2024 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-557ad92cabbso8260318a12.0;
        Mon, 15 Jan 2024 02:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705312848; x=1705917648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uj2aalIqkRnKw3Jh+x0FJKzYvIfpX+EmzSwXfzkCeTY=;
        b=GMiQLrie8T+/NorkXRvXNCL6+L6zqK8UDvek0QIzxB56r/SJoh8buCVxlY04yLMWqm
         P9GP01KJO8IjOfuFlgT+1pCHInTgtf25+R+iAaRXs3wFq+RO6744cUV30SSkONVZTd6/
         pUVwkvirzanQssf90Y7gKncn3ZcB1WJ1HRVbbrBLIWWLUxAP/jVMXVHg1H8rsnXRjIft
         QWYevvhbXD8FMEovoW//IRJPKW3mgG5ZSWUfDRVut/9U1LeJ7OElqPWxyN4qgS3bPyi6
         ExvWPYFoQH6EAtf58jssGyLxVuR7rol5rBdJYv/z5Z9uuBAOvemzvsQJRroCJzKAtgdX
         fnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705312848; x=1705917648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uj2aalIqkRnKw3Jh+x0FJKzYvIfpX+EmzSwXfzkCeTY=;
        b=i27JkXtFXKbrg6PD0dNXJDekVDZIix1WbjooYeDKxTLwRj7ra0Ro/qp9sYvR2VR+27
         wbQ8WtiCCkkGKzhS1Zz5kCOGiq3eTtGAbS08CrhGFRVUbUNU2nvFGDrUtTu+api2hj3v
         Io5X1d0sVEH+qosVJk5kC984sbdK60CXJdLWgio4hUKBb3dV90z6sPaq4OhJBktCAFhu
         Rs03+EW1QMoGEenH9IBupPVptuDojN6xM+arFnY7drZ07EzuT4Mt4d8scVAcwXx/i13f
         G2mT7rBpJLOugOGRscPWxzWYWMWvfijfVtqG79i/GBf8/zMar5hswr8snC5rOzsMAvi+
         aKyg==
X-Gm-Message-State: AOJu0YzevWzqtlOzJIX5SdnMKfX8HSPusNuzsNJkKRC/3dDt2kPKdO3T
	zFrgBqg4TvVNZEBsCeP2W0ASOwG5ou13AQGB3pHE5NDZFaXMEA==
X-Google-Smtp-Source: AGHT+IFpMD03zihIAykom+PB1F28jr/R2Z8Ne7OeKsZ9DBxxhU6mhLOe/tSuvReUc8HhKlgl9kTv6RZJ5nVcPQmhshM=
X-Received: by 2002:a17:906:349a:b0:a2c:3380:d363 with SMTP id
 g26-20020a170906349a00b00a2c3380d363mr1285364ejb.258.1705312848097; Mon, 15
 Jan 2024 02:00:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEmTpZHU5JBkQOVWvp4i2f02et2e0v9mTFzhmxhFOE47xPyqYg@mail.gmail.com>
 <2024011517-nursery-flinch-3101@gregkh>
In-Reply-To: <2024011517-nursery-flinch-3101@gregkh>
From: =?UTF-8?B?0JzQsNGA0Log0JrQvtGA0LXQvdCx0LXRgNCz?= <socketpair@gmail.com>
Date: Mon, 15 Jan 2024 15:00:36 +0500
Message-ID: <CAEmTpZHcXrPTC15KS9SvC6auK1G2nugny_wQA411+9CXrW0dgQ@mail.gmail.com>
Subject: Re: kernel BUG on network namespace deletion
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, netdev. I have found a bug in the Linux Kernel. Please take a look.

=D0=BF=D0=BD, 15 =D1=8F=D0=BD=D0=B2. 2024=E2=80=AF=D0=B3. =D0=B2 13:25, Gre=
g KH <gregkh@linuxfoundation.org>:
>
> On Mon, Jan 15, 2024 at 12:19:06PM +0500, =D0=9C=D0=B0=D1=80=D0=BA =D0=9A=
=D0=BE=D1=80=D0=B5=D0=BD=D0=B1=D0=B5=D1=80=D0=B3 wrote:
> > Kernel 6.6.9-200.fc39.x86_64
> >
> > The following bash script demonstrates the problem (run under root):
> >
> > ```
> > #!/bin/bash
> >
> > set -e -u -x
> >
> > # Some cleanups
> > ip netns delete myspace || :
> > ip link del qweqwe1 || :
> >
> > # The bug happens only with physical interfaces, not with, say, dummy o=
ne
> > ip link property add dev enp0s20f0u2 altname myname
> > ip netns add myspace
> > ip link set enp0s20f0u2 netns myspace
> >
> > # add dummy interface + set the same altname as in background namespace=
.
> > ip link add name qweqwe1 type dummy
> > ip link property add dev qweqwe1 altname myname
> >
> > # Trigger the bug. The kernel will try to return ethernet interface
> > back to root namespace, but it can not, because of conflicting
> > altnames.
> > ip netns delete myspace
> >
> > # now `ip link` will hang forever !!!!!
> > ```
> >
> > I think, the problem is obvious. Althougn I don't know how to fix.
> > Remove conflicting altnames for interfaces that returns from killed
> > namespaces ?
>
> As this can only be triggered by root, not much for us to do here,
> perhaps discuss it on the netdev mailing list for all network developers
> to work on?
>
> > On kernel 6.3.8 (at least) was another bug, that allows dulicate
> > altnames, and it was fixed mainline somewhere. I have another script
> > to trigger the bug on these old kernels. I did not bisect.
>
> If this is an issue on 6.1.y, that would be good to know so that we can
> try to fix the issue there if bisection can find it.  Care to share the
> script so that I can test?
>
> thanks,
>
> greg k-h



--=20
Segmentation fault

