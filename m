Return-Path: <stable+bounces-23568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0E18624D2
	for <lists+stable@lfdr.de>; Sat, 24 Feb 2024 13:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2D91F24E77
	for <lists+stable@lfdr.de>; Sat, 24 Feb 2024 12:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259C039AC2;
	Sat, 24 Feb 2024 12:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgil4PCG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94728250EA;
	Sat, 24 Feb 2024 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708776358; cv=none; b=eInhgVpOj4ZgciKFR+3onGDSieos47YawAInXSmcrxRal4qvwk7TC5JsQb3ciJf65YAH5Ogdl2hhs77KVeB2FywliVTW20ohkJuZqyh9DN6vi9Ihc32rv2/meLM5BWBdV69O0kUZ5UWtiW+E5P7W86gVI5xS58priHKPZXAxTeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708776358; c=relaxed/simple;
	bh=WoeM9pkYScJ13mRMUgF7m5PiKSukf6CCH4U6G0G8quw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKOnXvo6pNuVZhumb6icMXsHEV6gPxyWkBs7jPmGENZa2RRBYZzlLME7MNEcOzVuOaQ2yMlICngQ9W1Y4eXD59CrjxK/yBk3aa3joXOr2NvFflIUTlHuNYYK47/HAfCg2PQiSjAd1kpRBB909h1ixfE5/h9pcAoBjqHtbCaCNKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgil4PCG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc1ff58fe4so12046125ad.1;
        Sat, 24 Feb 2024 04:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708776357; x=1709381157; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jVmIKF7lK0wpWcNGGxp8g+5cZLXrG8hwcYCFr/14wjo=;
        b=mgil4PCG0HfpFGwHuJlmS43DmDumPMUSOq95djmprMQUbrzbFIaYMM8hi6Ezq1mhs5
         NHs+dJhweJgytWCadYliw/nJHeO8lQh7Y8D5kwZCm4GNt1ftTHQlvnFsWhhbuAa7XG+E
         KiSfJxTg36aEJjzjaqDU2V61oMfuz77ieak8SesPFfiu/PzBtcV10Jo4tKBjpzgJDe1A
         8IFK0ey/8fZpfRjUGU35sLbeI/ysRV9hHl7TLjRcUIPAquuHPtpplfEswie3GK9Hl3bA
         y59ham0BZkmKi5hpu0IMct754Mt7pMFcjz2EMcgwchH9E56iN8VKYu2w+tow8hyAhcvc
         e+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708776357; x=1709381157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVmIKF7lK0wpWcNGGxp8g+5cZLXrG8hwcYCFr/14wjo=;
        b=DWjOTgLG0/iIerSpVGQGJkIlCYhDXrE/2hxnGZ9Re0xgAGDxxMy3Efr6E7IZIuw+yQ
         ruZHD+ohHbG5r8GDe8JBWS0ySpK98VUHhlTjW4xmq1yXxS30k1+opbnMXkiGbCIBuw9d
         ls2CseciCb1oJ2DS/YLu4ddLP0h7lqsfMapQL3Q3z534Jpf9tDdsQZLMK1EnQBkWH/cq
         H+AjBkRfwEzxHjeUsN2yrDry5qi+Qj/IDyMgOauAvb4rJRiIBFOHwMusoZmkkkUQ4prM
         lVORGiYYK5PnPreUAutbgckhryWRQbvpYF/fHD/qDVAgtO7vneNyddxs0gCpbql9jCSG
         iCag==
X-Forwarded-Encrypted: i=1; AJvYcCVSaWsA5jP8sjds53w1Pn2TnoamS/TqSzzNWTl65jjCllhIl+3BOnBqam5/TUq6Bq50v1yg9WqUzkcbQUJVOcVdLzyYlB52cRNVno8V4IeSaICRG75Z1PvWLP6z
X-Gm-Message-State: AOJu0Yx/DW2XPukEcnRQebtObC8i2lGmXwMsGjiv8GCGNF3V+DHodb3+
	OsDxFrtAqoBrTat9a4JpQjDEZAEJODTd+xPY+737E0txwhTkAnlN0CeCQ5Bdu9HC2d59UdXPnX6
	LYtdentjEUpz8Q0lxQtcE34C+p1w=
X-Google-Smtp-Source: AGHT+IEDf/CY21pXyW11YD3yAY4DigFTF2b7ry3qapyV/+CUjf53W5pQPLfPk/xW/mlArK4EmqKkKPZYMhxH5gVvgz8=
X-Received: by 2002:a17:903:94e:b0:1dc:8507:e163 with SMTP id
 ma14-20020a170903094e00b001dc8507e163mr1362318plb.28.1708776356696; Sat, 24
 Feb 2024 04:05:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207110846.25168-1-qiang.zhang1211@gmail.com>
 <2024022323-profile-dreaded-3ac7@gregkh> <ec2482a6-a19b-4152-b51d-13c812eacf64@paulmck-laptop>
 <2024022430-uninsured-zoom-f78c@gregkh>
In-Reply-To: <2024022430-uninsured-zoom-f78c@gregkh>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Sat, 24 Feb 2024 20:05:45 +0800
Message-ID: <CALm+0cWi0N41CuXsBS5NazxZjOgX1apGVQ-49Q2jD_SKP00G_g@mail.gmail.com>
Subject: Re: [PATCH] linux-4.19/rcu-tasks: Eliminate deadlocks involving
 do_exit() and RCU tasks
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, joel@joelfernandes.org, chenzhongjin@huawei.com, 
	rcu@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Fri, Feb 23, 2024 at 11:48:49AM -0800, Paul E. McKenney wrote:
> > On Fri, Feb 23, 2024 at 02:15:30PM +0100, Greg KH wrote:
> > > On Wed, Feb 07, 2024 at 07:08:46PM +0800, Zqiang wrote:
> > > > From: Paul E. McKenney <paulmck@kernel.org>
> > > >
> > > > commit bc31e6cb27a9334140ff2f0a209d59b08bc0bc8c upstream.
> > >
> > > Again, not a valid commit id :(
> >
> > Apologies!  With luck, there will be a valid ID next merge window.
> > This one does not backport cleanly, so we were trying to get ahead of
> > the game.  Also, some of the people testing needed the backport due
> > to the usual issues.  :-/
> >
> > Any advice to handle this better next time around?  (Aside from us
> > avoiding CCing stable too soon...)
>
> You can just wait until it hits Linus's tree, otherwise we do get
> confused :)

Hi, all

I will resend these backports to stable once they enter Linus's tree :) .

Thanks
Zqiang

>
> Or if you don't want to wait, put it in the notes section below the ---
> line and say "this isn't in Linus's tree yet, the git id mentioned is a
> lie!" or something like that.  Give us a chance to figure it out
> please...
>
> thanks,
>
> greg k-h

