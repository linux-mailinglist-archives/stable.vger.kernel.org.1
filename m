Return-Path: <stable+bounces-161439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CED0EAFE8E9
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 14:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DED21C47DE6
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 12:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1622DC33E;
	Wed,  9 Jul 2025 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XiqhXepX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3940D2D8372
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752063951; cv=none; b=RBPEt6PEZWxmlSo9Vxv/i1V0Usmn+HvRngnI4FZu8JwNvkxpX+gHGDXvcZW5wrfGr9LHB9cMJw7ItifME7u7svq72lKzbdxLywXCrrS2CXBoulwKflK9Oo7IL/syxONrl5BW1EPsSRm4vBalJz43RgkniYnXUkPF9niBb37UJ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752063951; c=relaxed/simple;
	bh=wb22XIikD2qATxWdRxTA3iHhTy4uPTHwNH1Z3aIBhaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IpWASnL8qUNBeOHzG+8ATjXXOSEd5Lai/ftDXcSBNdGINMSQGXNOI43QS0Ej2cycmJJ1X/Cl8cRezFyEdA45Lxs2Hd1PI9KiMXeBsLUzOAi8FgvghRLvsKOA93AA6VYJgrKzo5P/zFfwnOp/+ojsE79WHIj2uZjXr3i1jbLgMSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XiqhXepX; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-879d2e419b9so4307281a12.2
        for <stable@vger.kernel.org>; Wed, 09 Jul 2025 05:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752063949; x=1752668749; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S/q7TshKKoT7nXGacRLVg39PUcU9ha1HeRSUxDk9nqI=;
        b=XiqhXepXn0fEjeU4tmuOgqv7YqcMSaCduiCGHfcqz1fz5fjbftcgf3429eZyTDgS+D
         gwBpwOgam1U3ucJmAXuO5udqNNKxhDahphTW7AFbFLJ2ZTMhq674zLf5z9YkDJKjJMMf
         PrUeSYWx5s+k814p8EOOwOogGiaqg7mtDywz8O5TzZ9i+8Qsrlw+kdciiaHTvPh6L/Al
         Apv5R2yVvqTfthL5UK85FSrY2Xsyj7yj0C9sgrbY3huWMv3eizjAOSR1UiZL5ss/hNhG
         U4Fngs16HQl8pB2jdFZA6gXeR7DmHWZK6/75Sz27Pz2oMTpRbqv0IIHtOOu51IpLbnP2
         fxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752063949; x=1752668749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/q7TshKKoT7nXGacRLVg39PUcU9ha1HeRSUxDk9nqI=;
        b=r2+RtEEEuil8TXkKMVHoc3qZ2BtEyQMLk/zHrOUzlQBZJzSgXiL3MvZP9poJYlT+tY
         x7sMdlEjgvQkQaEyernIoiYN+x3Cfg7nN7Pve9ZcukmKZx5EwWkAUXi57XNo5ziWJLAT
         LSh3jMiuqs5lEZVf9dbbu4aweSw5m3kPXy9FpYK4N2ys6GwBt2HvAOfpMTNF1gyCcBkq
         qSkX9Z/YaUg/auoogNB5Q7ZnG2aYOzVzqHBADF0DDu8BrY1BzZ3KHtqMfffCjBPPnG20
         Li0Zt9wvjKE56lxT7KBgJWi96hIz34NetwQNsROFmbOfEdH+4YLOd4q3c2LZsqW3PyJf
         7jMg==
X-Forwarded-Encrypted: i=1; AJvYcCXnXoEef2HtFmeMRcxx16GcYIBLRwjVP5o6Q+C5CBGPzx+oY9oLn8hNK5yq0DOYwXP0c8EMAlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiOV2RgzCkttToBh1FnEqaBtKNQc2W2XBgRElMnkPQkYCamsMG
	3MgUfFBiAsMrU8o20P5j4gLsuwCdcBBBiKoO2CJxobEwSH6XGJ9yfxvwU7U9PKUOtJBKzPDh/Am
	89Eh8suWJzle010Jb6YL5TDxEBNznvdKW3oddVd1jVw==
X-Gm-Gg: ASbGncvGDNDPIWMFSIzK0HdCw5wVPZ6El2uqTJkk/dLcSomIIoKHG0Sw8rSxc7AiW5q
	B7BQ8e2jhS4p3iQ/KSX7pXVXR1s4YV1kKP1pfJF8WtliyjdBwZSUjiuLmmee9YHigGh86fqauwO
	1tVrLdfXd86JBdoeS0w2sVunzq1Xb41yEimZScT3Jpd3HJHf429GsxB9kH5v0F5pPcHidH0UQwJ
	Dfm
X-Google-Smtp-Source: AGHT+IFcpLtOMbOqJ/FkYbFJ6ZieYCRLYBJIVZAFvoK2D08JwArVwDsz9XqCBlbkUqhACkrjBfuJcYeD1mdTmH+qlOM=
X-Received: by 2002:a17:90a:f6ce:b0:312:daf3:bac9 with SMTP id
 98e67ed59e1d1-31c2fe15c5cmr2399918a91.34.1752063949445; Wed, 09 Jul 2025
 05:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYtK2TLbpo-NE-KUXEp0y8+5zXNVRFkqdMjaGgcNFFG77g@mail.gmail.com>
 <2025070924-slurp-monetary-a53f@gregkh>
In-Reply-To: <2025070924-slurp-monetary-a53f@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 9 Jul 2025 17:55:37 +0530
X-Gm-Features: Ac12FXzBT0KHq5ReF1wh3qeMehbB0fUcTYzXrsEznaZ3aV6CJ3ajCFVqPCFB3rg
Message-ID: <CA+G9fYurLq9o_PSbQKCOmSkQfa5-qtAu2HR1PzySBmJM4C4F3g@mail.gmail.com>
Subject: Re: v6.16-rc5: ttys: auto login failed Login incorrect
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, linux-stable <stable@vger.kernel.org>, 
	Jiri Slaby <jslaby@suse.com>, Aidan Stewart <astewart@tektelic.com>, 
	Jakub Lewalski <jakub.lewalski@nokia.com>, Fabio Estevam <festevam@gmail.com>, 
	Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

+

On Wed, 9 Jul 2025 at 16:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 09, 2025 at 04:26:53PM +0530, Naresh Kamboju wrote:
> > Approximately 20% of devices are experiencing intermittent boot failures
> > with this kernel version. The issue appears to be related to auto login
> > failures, where an incorrect password is being detected on the serial
> > console during the login process.
> >
> > This intermittent regression is noticed on stable-rc 6.15.5-rc2 and
> > Linux mainline master v6.16-rc5. This regressions is only specific
> > to the devices not on the qemu's.
> >
> > Test environments:
> >  - dragonboard-410c
> >  - dragonboard-845c
> >  - e850-96
> >  - juno-r2
> >  - rk3399-rock-pi-4b
> >  - x86
> >
> > Regression Analysis:
> > - New regression? Yes
> > - Reproducibility? 20% only
> >
> > Test regression: 6.15.5-rc2 v6.16-rc5 auto login failed Login incorrect
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > ## log in problem
> >
> > runner-ns46nmmj-project-40964107-concurrent-0 login: #
> > Password:
> > Login incorrect
> > runner-ns46nmmj-project-40964107-concurrent-0 login:
> >
> > ## Investigation
> > The following three patches were reverted and the system was re-tested.
> > The previously reported issues are no longer observed after applying the
> > reverts.
> >
> > serial: imx: Restore original RXTL for console to fix data loss
> >     commit f23c52aafb1675ab1d1f46914556d8e29cbbf7b3 upstream.
> >
> > serial: core: restore of_node information in sysfs
> >     commit d36f0e9a0002f04f4d6dd9be908d58fe5bd3a279 upstream.
> >
> > tty: serial: uartlite: register uart driver in init
> >     [ Upstream commit 6bd697b5fc39fd24e2aa418c7b7d14469f550a93 ]
>
>
> As stated before, those are 3 totally independent changes.  Any chance
> you can nail this down to just one of the above?

You're right, since this issue is intermittent, it's challenging to reproduce
consistently. Pinpointing the exact commit would be ideal, but it will
require more time.

>
> thanks,
>
> greg k-h

Thanks,
Naresh

