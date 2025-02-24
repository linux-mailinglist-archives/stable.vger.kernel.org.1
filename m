Return-Path: <stable+bounces-118701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DAFA4156E
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 07:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F363B64FF
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 06:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107881DE2A5;
	Mon, 24 Feb 2025 06:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PBEqBgS3"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11681DB15B
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 06:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740378871; cv=none; b=HtYVL0iYhTuRql56oOGhCOt4pNy/oWVratMECffp3cj+o016k5f7Evg1+rx1EbgOc//DtMIyJT5D2IWRs9Vfaj+Psx9Sc1b39FJJ0r2QEVi8DTSTPhu/hUT82nO2auUIStRPKJUreh4eSMHKAYF4s7ANVmaXGp5Z0B85k1iDJpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740378871; c=relaxed/simple;
	bh=fQDRfw3EhrfUd3Fny4Nab7kzxfYkmF1PMtyrdiyxXes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDDmC84KyCSvYgYpsKYIaznEhquqwtIof6POWXeW6EmWLxkzpR5vcy2ECX95QTYjrZu7tJenJRHikQgS7DmDJ4lKO4fZBhTH9ynBvQy2pfzbwNMwzMbjI8JgO36dsbKZqDcO5BXmmCtVlAOR5L2afw56eXhq9Ly2fTxDOzy9M+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PBEqBgS3; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30738a717ffso30801021fa.0
        for <stable@vger.kernel.org>; Sun, 23 Feb 2025 22:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740378868; x=1740983668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UDmIbBVBrmOqaPqtm3OIVdTs+1YkPggGmmD9ociAVJQ=;
        b=PBEqBgS3YR41UqftH4NkXcKxWKThvVldMJUUckucV8R5jFl8z9Ib/PROfOljIeZE47
         XMaH7wGtwY2fCfhSutNBjtLMKu6HnzKLE9IpJgBVlFIC2Od7DIhx4522fOA4xw7zwLA6
         KIziMosLwMCAoqbHCxQI1zpbuq5sUtkfHIB9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740378868; x=1740983668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDmIbBVBrmOqaPqtm3OIVdTs+1YkPggGmmD9ociAVJQ=;
        b=J8HiOuaQiLr8F1ORf9odT6/EPhaIbIkjC6yoQ+Y88IlfTBvnBRvMnyraWZw8f41ek3
         JuDCU8tjvP5hioXsQ19cgYeLjz6UUWRHIL9WmhoSIjmEdYBdhbUKVNdBh+YM8Pip+10l
         s7WfoR1ew9kdtC2b43Mfic873F+5vY3LoYCh9pAlv1fX9aAk9MthTzI9vJhQZP9GW+K3
         tB++ARzO+hmTKsFeBBExoUUZgSBmm/wpKTYzaLwvarvrxMLeikfjSAfyYmbZD+a9Pzze
         OU8R9tVz9/nAEUt59zzArEUHTKEIqVEdKfx7E4aoy7i4XPV6LUd7V+Id9usjPSRs3CKF
         zR2w==
X-Forwarded-Encrypted: i=1; AJvYcCW/3S+5rkf38PLnl/e1sTBo7btx10QtOlqCgrKc+qowXgsXl+m7vLcFXbcuUUeQgMX3n974hdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuqAe9EWTmdFAG/0Cnsku23pYNoiWjIlMjrmGhQGDjEg8NXx5q
	mS2fQFmKlBDH10CsUWlin9lvbDJ8RyqDxoH+ZofVqbxWIlBdkdWITEaVW2c2J+eUHgpwwQGSEeV
	Wjg==
X-Gm-Gg: ASbGncsLVqB+XoHW6uma/iFVibwqcBtGS3PWfkooALhwlEHLjII7AjfTfe79i3Vv3qc
	ssB/1C6kBfC1SFRe7qxBgGiUiBbqrwsdi5V+MLMYCP5LSTY3P18S3WIvrG6v2//1lfHTfViVFok
	FjoH57ryx9TKB6vUF+z014yFW8fuIc9g/A+S5VJUDlKxZgsfQvR+bOlGJxhuB9BgtB1T2i+m3ss
	r6Cohek87VtF6xkpArc76oTQ7AwDnlDWudZjty9PBbJ+58dKlZMzVde8RyqLliHXAitBjV/lKDM
	hS41UJCduW2BT1QRhJk4Uzm6PNF77x/UZTxEHy/4UlZ7HtzXW60AxXiTE7p1eGig
X-Google-Smtp-Source: AGHT+IGbuiGC3IhgUduZhFnQP7KcwSipD3e4Jf8cXccOD1kzAG3ejaGtDKnX+CqxR04W8nPqoIuFWg==
X-Received: by 2002:a05:6512:3f20:b0:545:2d80:a482 with SMTP id 2adb3069b0e04-54838d3d881mr4115099e87.0.1740378867888;
        Sun, 23 Feb 2025 22:34:27 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5462f125a0esm1490883e87.24.2025.02.23.22.34.22
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2025 22:34:22 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5461dab4bfdso4965665e87.3
        for <stable@vger.kernel.org>; Sun, 23 Feb 2025 22:34:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXntKC2i46qOL0Lar5YTtlREkHq2lg064fluS6M4lpnfaV8PeC2HfVYKdlifGYlBNvqppmLIUc=@vger.kernel.org
X-Received: by 2002:a05:6512:3ca5:b0:545:2ee6:84a8 with SMTP id
 2adb3069b0e04-54838ee76c0mr4652920e87.14.1740378861858; Sun, 23 Feb 2025
 22:34:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121-nuvoton-v1-0-1ea4f0cdbda2@chromium.org>
 <20250121-nuvoton-v1-1-1ea4f0cdbda2@chromium.org> <df5693d0-7747-4423-809e-ae081c9aae92@xs4all.nl>
 <dffc8e0b-2603-4e7e-ba64-15691c11ff7e@xs4all.nl> <CANiDSCsMCSJMEsY3R=pnZ4XUTiEYuPz-N1kEX7y13yTzE6Dm5w@mail.gmail.com>
 <2025022426-lilly-next-72e0@gregkh>
In-Reply-To: <2025022426-lilly-next-72e0@gregkh>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 24 Feb 2025 07:34:09 +0100
X-Gmail-Original-Message-ID: <CANiDSCvr5Fz2CE7Vx5gk_r=JFHwpT-w=7GGgZ-MN8FkjQyp+yA@mail.gmail.com>
X-Gm-Features: AWEUYZneujeUqRzowTHsCuBd_481VOXalvBfDTLy1Zv-JKeySU-2ECz97LHUiDc
Message-ID: <CANiDSCvr5Fz2CE7Vx5gk_r=JFHwpT-w=7GGgZ-MN8FkjQyp+yA@mail.gmail.com>
Subject: Re: [PATCH 1/4] media: nuvoton: Fix reference handling of ece_pdev
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Joseph Liu <kwliu@nuvoton.com>, 
	Marvin Lin <kflin@nuvoton.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Marvin Lin <milkfafa@gmail.com>, linux-media@vger.kernel.org, 
	openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, sashal@kernel.or
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 06:52, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Feb 23, 2025 at 07:34:30PM +0100, Ricardo Ribalda wrote:
> > On Fri, 21 Feb 2025 at 10:18, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> > >
> > > On 21/02/2025 10:04, Hans Verkuil wrote:
> > > > Hi Ricardo,
> > > >
> > > > On 21/01/2025 22:14, Ricardo Ribalda wrote:
> > > >> When we obtain a reference to of a platform_device, we need to release
> > > >> it via put_device.
> > > >>
> > > >> Found by cocci:
> > > >> ./platform/nuvoton/npcm-video.c:1677:3-9: ERROR: missing put_device; call of_find_device_by_node on line 1667, but without a corresponding object release within this function.
> > > >> ./platform/nuvoton/npcm-video.c:1684:3-9: ERROR: missing put_device; call of_find_device_by_node on line 1667, but without a corresponding object release within this function.
> > > >> ./platform/nuvoton/npcm-video.c:1690:3-9: ERROR: missing put_device; call of_find_device_by_node on line 1667, but without a corresponding object release within this function.
> > > >> ./platform/nuvoton/npcm-video.c:1694:1-7: ERROR: missing put_device; call of_find_device_by_node on line 1667, but without a corresponding object release within this function.
> > > >
> > > > This driver uses this construct:
> > > >
> > > >                 struct device *ece_dev __free(put_device) = &ece_pdev->dev;
> > > >
> > > > to automatically call put_device. So this patch would 'put' the device twice.
> > > >
> > > > Does cocci understand constructs like this? If I hadn't looked closely at the
> > > > code first, I would just have merged it.
> > >
> > > Oh wait, now that I am reading the following patches I see that it was those later
> > > patches that add the __free code.
> > >
> > > This is far too confusing. Please post a v2 that just combines the 'fix references'
> > > and 'use cleanup.h macros' in a single patch. It makes no sense to have this two-phase
> > > approach.
> >
> > I believe this is discouraged.
> >
> > cleanup.h macros does not exist in old kernel versions, so makes it
> > impossible to backport the fix to them.
>
> That's not a problem, fix things properly in the main tree and let the
> stable/lts kernels work it out on their own.
>
> > This is an example of other series following this policy:
> > https://lore.kernel.org/lkml/173608125422.1253657.3732758016133408588.stgit@devnote2/
> >
> > They also mention the same here:
> > https://hackerbikepacker.com/kernel-auto-cleanup-1 .... I am pretty
> > sure that I read the policy in a more official location... but I
> > cannot find it right now :)
>
> No, it is NOT official policy at all.  Otherwise you would be saying
> that no one could use these new functions for 6 years just because of
> really old kernels still living around somewhere.  That's not how kernel
> development works, thankfully.

No, I am not saying that we cannot use cleanup.h for 6 years.

What I am saying is that first we fix the errors without it, and then
we move to cleanup.h. All in the same series:
1/2 Fix reference handling (cc: stable)
2/2 Use cleanup.h

That way the fix (1/2) can be applied without changes to all the
stable trees, and 2/2 can be ignored by them.

The alternative is a patch that cannot be applied to stable and either
you, the author or the maintainer have to backport to stable
(basically implementing 1/2).  So no, we do not save work by just
posting a cleanup.h version of the fix to the mailing list.

The even better alternative is that cleanup.h is backported to all the
stable trees.


Anyway, it is up to you and Sasha to decide. I will repost the series
only using cleanup.h

Best regards!


>
> thanks,
>
> greg k-h



-- 
Ricardo Ribalda

