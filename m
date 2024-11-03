Return-Path: <stable+bounces-89580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA959BA399
	for <lists+stable@lfdr.de>; Sun,  3 Nov 2024 03:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA6C1F23029
	for <lists+stable@lfdr.de>; Sun,  3 Nov 2024 02:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59F81F5E6;
	Sun,  3 Nov 2024 02:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="orqjFAN3"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AB5C2FB
	for <stable@vger.kernel.org>; Sun,  3 Nov 2024 02:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730601685; cv=none; b=bTvsxddb9sn7MyevPsspAEg2oZoVsmeDocRg4IPT5CjaLxeV+yVvDihgkMqV8RkvQnUu0M+2Heuanm15wQiap5Oy9suGfxzSlgGP1lNgcWjV+HJRd1b4+ascz/prNW4gWarsU9HpEt3FZZ9tBPfLlwbGFK/aykzJ5SXhHw7d7no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730601685; c=relaxed/simple;
	bh=l7ZwXUghr6HCHIhy7JesiYkdZ50rzjv5qOuEExqaYTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YApkFkMeYhfIDx7LBPXsPnEwED36xmS3trIoihVM+Oon3s91g/2IqNCSN28QiCpcaEwREsXZwwxw/RgHDCoq7G5uOnxw8z0UHEDdUx4Dl9VaCFSaPTJ/8RYzReHmCrl0S2DrkAcg9VU/kX7n2KUubBf1F1sB64YRYZRUew77HFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=orqjFAN3; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b154f71885so269930985a.0
        for <stable@vger.kernel.org>; Sat, 02 Nov 2024 19:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1730601682; x=1731206482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+i/lDylJ2UvitooQ4I9k4a3zfRj4ivl685Uy2oNNEw=;
        b=orqjFAN3lkt7jSaEXzyTsCoW0d0ex1RdFQwhmVhxebDPEY7FvyoF2a/0zIuRdBISHP
         hgoTws/E7ua33Ta00jCVfVdM2V32Tm+MAozlm8s2bvrXY5ZVXpfMsN0iYvcVmpolugRz
         Wtd26W6t4sd5Z5+FIF6AvDSDPe9ce18mhHNml820BxyqbAY8z2tvZvY3fx43ZF276h3i
         ZJ1JL1Eattoie2+FEzSm3Z86eTgbZdOKHuRV4seXrrruMe3bXAa9OcQVZNE0IzmMIo0p
         qbZl0m/7DYB38MMAxsGmSPSkINTpubgGUoFDdd0RxOXigJV/7pkvGAXqlgto00do4AoY
         aeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730601682; x=1731206482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+i/lDylJ2UvitooQ4I9k4a3zfRj4ivl685Uy2oNNEw=;
        b=nPlEC+Id22QRYO6PGDqZi7y2dNZYC+WniCO1LMJUEc2ux1kzhvAZo9mkgmcK57hxvK
         XNIx0VO0fD0cBY5D2b5C8lQ2FhFChcjSp7tZP7Fvf0LO2ybp7EmD3wxyKMXejpIkTykB
         HUUr1WRaUGGyp9tDiOs+xQhbWfDQzKSX8HSQ1o4c+0XmQRrfOBZNplhU3Wd2EdJmV2yv
         DR6N/Gm5RwNNLMHj29zA2qeeXlJXDXldTvqfkOT4nQAmi1fvDR3ocVngcb0qa0wLAJtd
         bVURE1TyXaavz1EAk+5ep0E3Ou84OSJuwTXxbNSQNQf6JAyrE4f63pQPFU8eIFcK85IW
         PsaQ==
X-Gm-Message-State: AOJu0YyAdOwdP8zCg1HdPqyK6o7n+yAe8I6xh0D1wDv7NVuc8rEf3UzF
	trGoaKEEPWrLSf8Bz/ElRyrF68tntHwxI59erLwqWgqvIvk6nGchMsXTP+GspV7So7bpks9I8Yk
	=
X-Google-Smtp-Source: AGHT+IHgOI3v8nN+o4RVbLuONx2AfdgVde3uk1rhC4DInmQlhwg9Q7umLpV66DdlJyuvaINYUn0OEg==
X-Received: by 2002:a05:620a:f02:b0:7b1:4a48:56bb with SMTP id af79cd13be357-7b2fb9d8201mr1097008285a.56.1730601682548;
        Sat, 02 Nov 2024 19:41:22 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::9dc2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462b0d8faf1sm30934571cf.76.2024.11.02.19.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 19:41:21 -0700 (PDT)
Date: Sat, 2 Nov 2024 22:41:19 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, gregkh@linuxfoundation.org,
	sylv@sylv.io, andreyknvl@gmail.com, kernel@gpiccoli.net,
	kernel-dev@igalia.com
Subject: Re: [PATCH 6.1.y / 6.6.y 0/4] Backport fix(es) for dummy_hcd
 transfer rate
Message-ID: <3f678883-75e3-42b9-8f30-56b5b4c4379d@rowland.harvard.edu>
References: <20241103022812.1465647-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103022812.1465647-1-gpiccoli@igalia.com>

On Sat, Nov 02, 2024 at 11:13:49PM -0300, Guilherme G. Piccoli wrote:
> Hi folks, here is a series with some fixes for dummy_hcd. First of all,
> the reasoning behind it.
> 
> Syzkaller report [0] shows a hung task on uevent_show, and despite it was
> fixed with a patch on drivers/base (a race between drivers shutdown and
> uevent_show), another issue remains: a problem with Realtek emulated wifi
> device [1]. While working the fix ([1]), we noticed that if it is
> applied to recent kernels, all fine. But in v6.1.y and v6.6.y for example,
> it didn't solve entirely the issue, and after some debugging, it was
> narrowed to dummy_hcd transfer rates being waaay slower in such stable
> versions.
> 
> The reason of such slowness is well-described in the first 2 patches of
> this backport, but the thing is that these patches introduced subtle issues
> as well, fixed in the other 2 patches. Hence, I decided to backport all of
> them for the 2 latest LTS kernels.
> 
> Maybe this is not a good idea - I don't see a strong con, but who's
> better to judge the benefits vs the risks than the patch authors,
> reviewers, and the USB maintainer?! So, I've CCed Alan, Andrey, Greg and
> Marcello here, and I thank you all in advance for reviews on this. And
> my apologies for bothering you with the emails, I hope this is a simple
> "OK, makes sense" or "Nah, doesn't worth it" situation =)
> 
> Cheers,
> 
> 
> Guilherme
> 
> 
> [0] https://syzkaller.appspot.com/bug?extid=edd9fe0d3a65b14588d5
> [1] https://lore.kernel.org/r/20241101193412.1390391-1-gpiccoli@igalia.com/
> 
> 
> Alan Stern (1):
>   USB: gadget: dummy-hcd: Fix "task hung" problem
> 
> Andrey Konovalov (1):
>   usb: gadget: dummy_hcd: execute hrtimer callback in softirq context
> 
> Marcello Sylvester Bauer (2):
>   usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler
>   usb: gadget: dummy_hcd: Set transfer interval to 1 microframe
> 
>  drivers/usb/gadget/udc/dummy_hcd.c | 57 ++++++++++++++++++++----------
>  1 file changed, 38 insertions(+), 19 deletions(-)

I'm not aware of any reasons not to backport these commits to the stable 
kernels, if they fix a real problem for you.

However, it probably wasn't necessary to post the patches explicitly.  
(Not unless they required some modifications for the backports.)  I 
should think all you really needed to do was ask the appropriate 
maintainers to queue those commits for the stable kernels you listed.

Alan Stern

