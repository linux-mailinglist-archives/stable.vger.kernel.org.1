Return-Path: <stable+bounces-155300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F298AE35C9
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 08:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8090B3AFB6F
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 06:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4721DF75A;
	Mon, 23 Jun 2025 06:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHwOoNRH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3381DF742;
	Mon, 23 Jun 2025 06:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750660592; cv=none; b=DIaXuzdUENAdf691ArbVyaboux5y0ztDxpcX+Zf7gu5mQAHg2h4+5bVssgabD/CQqamiSP4bnDPQ1sCHPim2SnvM+RKD7YivWHMQ1fIOUe6jepRrWD4/lTrC38GGNr4Yy0Yfi6I8mGHEJXrkue8WhlA0H9ctEq+fADjNvVp9BLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750660592; c=relaxed/simple;
	bh=MQqIQaqFTcceO2ptgIhJ47aNU4rFFFRQHISs+6wARKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGwZ3GZyTRuzukC97Nhu9Jgw93mvekgvbul4sNn38eNJ/X3jr3gZhqmPTEkmoWILkNgmFwJQyHK61wP8BIln4P4j2Yd0Ui/3yTEDYQuDJnkAX5hqFbjuOe6ojUljY8FRrj00gEZ3FPkoTPD2u88wYXToFcAfdH/oh5t09v8EI3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHwOoNRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26DFC4CEF1;
	Mon, 23 Jun 2025 06:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750660591;
	bh=MQqIQaqFTcceO2ptgIhJ47aNU4rFFFRQHISs+6wARKA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GHwOoNRHp1esb+ZtXpBZNf3KevC/NNQVWqpO+qjTC6nwzTsyosRLXVqUDIxauTqlo
	 8jeXIP7NCOeYvdeN41bw+e/t+UgZ/N++k8LYbNDaHzQWGibVuDBF4B0Vn84RTqJ8QK
	 Gp25FmdHKzcr6GXuBFycxdqutlYeFIF76fwYGL8Of3Vsuckom9LTUo1cfRI/lgPl60
	 sgnsTNhtfUyYG3iZSamLea2sZLoyuWaYWBpZSdrh2R6R81D/4uLpXGG7u6i0CppRo0
	 G/cHcLUZItb/LA50OGULMGiwy+A/D0tviqD8vGTIOWbDrR8ww8nIYAT05q/kPS1MQq
	 Os9IcCLUclLng==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-acb5ec407b1so625467166b.1;
        Sun, 22 Jun 2025 23:36:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNG6AK8w0X788rMQPE7x6MwCkXm6YCn2kJfJIwObIwALS2QN+GsxD5J4LOjPDhJpCjX48oEhqa@vger.kernel.org, AJvYcCVqIrXmw919aPuzYvYkIc7AilZLrJWGnupCAGyO/SeEDOhqWSFGA34KCTnglgBld9ladUBOZNzJ5DSreVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz08D1GOIGRkMAzxKg5Db2aPvCdgUBj2r65CvAAQ3c2Y6i+vo1o
	+SvOjxQytxVaThNnyh1N5YyBOoq/o3spv1dfbb4hE7+6pwjI1plGSGCnphkrIjA1VS3MxDCxtLr
	3miFcKXxwL7aNDBiVjjNyfduVqyK6ips=
X-Google-Smtp-Source: AGHT+IEA6COgDBs0qwjVGo1C38N6TH3X/9OjF1VirjRhwYLxZrK2V43Ve2GTAq5zQkmiKr67gpJQ7dzJbondmWWGwus=
X-Received: by 2002:a17:907:6088:b0:ad2:3fa9:7511 with SMTP id
 a640c23a62f3a-ae057bb8dcamr1099998066b.41.1750660590450; Sun, 22 Jun 2025
 23:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250622110148.3108758-1-chenhuacai@loongson.cn>
 <2025062206-roundish-thumb-a20e@gregkh> <CAAhV-H4S=z5O0+pq-x9X4-VjYsJQVxib+V-35g50WeaivryHLA@mail.gmail.com>
 <2025062349-proximity-trapeze-24c6@gregkh>
In-Reply-To: <2025062349-proximity-trapeze-24c6@gregkh>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 23 Jun 2025 14:36:18 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7r-X-t0_i-x=oy2Gin4-ZMhSVwXtcaygZdJ1_J-zD3dg@mail.gmail.com>
X-Gm-Features: AX0GCFvvYomJBYKcVNajSqdnUm4ssBmny_9ZzEH6TG458ktGPVd3agNJFs8hSLU
Message-ID: <CAAhV-H7r-X-t0_i-x=oy2Gin4-ZMhSVwXtcaygZdJ1_J-zD3dg@mail.gmail.com>
Subject: Re: [PATCH for 6.1/6.6] platform/loongarch: laptop: Fix build error
 due to backport
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Sasha Levin <sashal@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, stable@vger.kernel.org, ziyao@disroot.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 2:28=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jun 22, 2025 at 09:11:44PM +0800, Huacai Chen wrote:
> > On Sun, Jun 22, 2025 at 9:10=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sun, Jun 22, 2025 at 07:01:48PM +0800, Huacai Chen wrote:
> > > > In 6.1/6.6 there is no BACKLIGHT_POWER_ON definition so a build err=
or
> > > > occurs due to recently backport:
> > > >
> > > >   CC      drivers/platform/loongarch/loongson-laptop.o
> > > > drivers/platform/loongarch/loongson-laptop.c: In function 'laptop_b=
acklight_register':
> > > > drivers/platform/loongarch/loongson-laptop.c:428:23: error: 'BACKLI=
GHT_POWER_ON' undeclared (first use in this function)
> > > >   428 |         props.power =3D BACKLIGHT_POWER_ON;
> > > >       |                       ^~~~~~~~~~~~~~~~~~
> > > >
> > > > Use FB_BLANK_UNBLANK instead which has the same meaning.
> > > >
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > ---
> > > >  drivers/platform/loongarch/loongson-laptop.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > What commit id is this fixing?
> >
> > commit 53c762b47f726e4079a1f06f684bce2fc0d56fba upstream.
>
> Great, can you resend this with a proper Fixes: tag so I don't have to
> manually add it myself?
Upstream kernel doesn't need to be fixed, and for 6.1/6.6, the commits
need to be fixed are in linux-stable-rc.git[1][2] rather than
linux-stable.git now.

I don't know your policy about stable branch maintenance, one of the
alternatives is modify [1][2] directly. And if you prefer me to resend
this patch, I think the commit id is not the upstream id, but the ids
in [1][2]?

[1]https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.g=
it/commit/?h=3Dqueue/6.1&id=3Df78d337c63e738ebd556bf67472b2b5c5d8e9a1c
[2]https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.g=
it/commit/?h=3Dqueue/6.6&id=3D797cbc5bc7e7a9cd349b5c54c6128a4077b9a8c6

Huacai

>
> thanks,
>
> greg k-h

