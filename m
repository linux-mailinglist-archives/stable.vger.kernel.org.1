Return-Path: <stable+bounces-89392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8709B749D
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 07:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02681C25223
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 06:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAF81448E6;
	Thu, 31 Oct 2024 06:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3vkJS3t"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188477A15A;
	Thu, 31 Oct 2024 06:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730356419; cv=none; b=J9ndDoieTqyCklsCdO5lkeNjfky4Ts34BgzLyEGNUDGDbvYLXMrIP2XdwvvDR/IhBUaTgFGhWIkc0/PodpR+7/KCCbbsbz5d5wqWx56R8AshCi4kXO7GDmcUrX6CHfeuvTNuCC2EgXj775tsNE5FFOmv3zNh3EzGMCKcQ/8BZGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730356419; c=relaxed/simple;
	bh=h3A6usIImJggTbl8niN7j54dxWCAOrho3c/gOkpI1Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrZl9EsXv9IRRQX7oaE66qUt7rhzjOH1Wq0h1cKluBsES5j/Vm0y5Dd+n6ox1zq4/KBrZCFyxnd6vOW46Hp3G7Ku+jnL10AvlWNXAAl7PrLhkXhnpUxmv2muYXxWAkyijoW4rIR/nChxSm+HjWGw41D67haGcpCO0dH32330Hk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3vkJS3t; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99cc265e0aso81174566b.3;
        Wed, 30 Oct 2024 23:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730356415; x=1730961215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UK1H6ntBFGD6fnCHyPbd1B/5kd3XON3dNEEHD/SIHWc=;
        b=P3vkJS3tdAj3RLaBLz49bcLtS3FXIy1BiABCEe0PPdsJCKZXmwAtWRigy9VADpSJon
         vOiMbtF43vP2/bEHRHajS2GgAFaA94LHY4HGCgS9Mc4hDLS0As1KmDi4AB/Of0DSYkpr
         HtBBn5nKjFg5jMFi5E6FkmeyyKSSQAeysbEgfg4t1drmWk4S+GrmiUuqVXeB8PmFWFII
         YwMzaPkTGqi058wsFnvKCdwUh7/5xOiTv+cjh650De4NnHVh+kdExthfNwy3IoabbQAc
         sqECzM86bkf1nenlBB494kDsZX6fQtXb+sq4/UxJ3QM/RH/wEwA41Fr9M16KGDJ4bnbi
         LEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730356415; x=1730961215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UK1H6ntBFGD6fnCHyPbd1B/5kd3XON3dNEEHD/SIHWc=;
        b=Ur6tzNYJL+M1ETlTomgvqxoDpKv1WqMbDeseRyM8Idsy3eJaAiQ95XipF7zenpv4mV
         Y05aJg0FUtyq1rL+dPEDEKxp4tuygF0ATLrn/nMdBdtFaAILBfaZ3Tz8SGt4vyAhuKDU
         f7Dt7V02VR+T8/IZF4/lxezuE5qcr7ihw4OU9IWlv7avynKZOPV0DKRoR6I3UPcg9ePL
         t2Qv9e+oGvRv0LN2YDZDh4WZn7jFBAgpqZJJw5hyiR+cXzvVv2MMHi9Et1hlsy/+/eQP
         6f9DWoNfr/4LA8xmqUOdlhgwIWJXZKVyGoNWU1tWakwKByUh/wN/6E7CYot4CLKMGx1M
         Z5Nw==
X-Forwarded-Encrypted: i=1; AJvYcCU5R0yDImPWrRBlc8hnVtsLS3qLrLGzz6sf5apKL48h0eb3Rjm4ni07jOT0uWpF7okLeDvjlu6g@vger.kernel.org, AJvYcCWPsAOb/VSoUELO9UoitRcGmzq/jaYo2D3Z5urA274sHxc06nuPhUWV3IitxaCOP+LOqUvDYFxxGr0l7fHXtic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlZ2RaHPcteoKJGqTvgJa/3jyM7qKpZrs7QSSSfIR12xCudXFF
	aQlj1c24KU18A9PFzvhdiji6GbcnkSJAByLpbGE9tyJuct3fcGnIisigvlWB
X-Google-Smtp-Source: AGHT+IEud6sFVvRQfjPRKYoT1QQQ7MC58Q7hm9R5LyKZCEEoGoTjBeuZh+oWNPsz07OaOLim9cB1lA==
X-Received: by 2002:a17:907:7ba2:b0:a9a:2afc:e4e3 with SMTP id a640c23a62f3a-a9de61d5d26mr1793382666b.50.1730356415186;
        Wed, 30 Oct 2024 23:33:35 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e5664bb9dsm31886866b.161.2024.10.30.23.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 23:33:34 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id DED09BE2DE0; Thu, 31 Oct 2024 07:33:32 +0100 (CET)
Date: Thu, 31 Oct 2024 07:33:32 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Mike <user.service2016@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Sasha Levin <sashal@kernel.org>,
	Jeremy =?iso-8859-1?Q?Lain=E9?= <jeremy.laine@m4x.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Bluetooth kernel BUG with Intel AX211 (regression in 6.1.83)
Message-ID: <ZyMkvAkZXuoTHFtd@eldamar.lan>
References: <30f4b18f-4b96-403c-a0ab-d81809d9888a@gmail.com>
 <c09d4f5b-0c4b-4f57-8955-28a963cc7e16@leemhuis.info>
 <2024061258-boxy-plaster-7219@gregkh>
 <d5aa11c9-6326-4096-9c29-d9f0d11f83b4@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5aa11c9-6326-4096-9c29-d9f0d11f83b4@leemhuis.info>

Hi,

On Tue, Jun 18, 2024 at 12:30:18PM +0200, Thorsten Leemhuis wrote:
> On 12.06.24 14:04, Greg KH wrote:
> > On Thu, Jun 06, 2024 at 12:18:18PM +0200, Thorsten Leemhuis wrote:
> >> On 03.06.24 22:03, Mike wrote:
> >>> On 29.05.24 11:06, Thorsten Leemhuis wrote:
> >>> [...]
> >>> I understand that 6.9-rc5[1] worked fine, but I guess it will take some
> >>> time to be
> >>> included in Debian stable, so having a patch for 6.1.x will be much
> >>> appreciated.
> >>> I do not have the time to follow the vanilla (latest) release as is
> >>> likely the case for
> >>> many other Linux users.
> >>>
> >> Still no reaction from the bluetooth developers. Guess they are busy
> >> and/or do not care about 6.1.y. In that case:
> >>
> >> @Greg: do you might have an idea how the 6.1.y commit a13f316e90fdb1
> >> ("Bluetooth: hci_conn: Consolidate code for aborting connections") might
> >> cause this or if it's missing some per-requisite? If not I wonder if
> >> reverting that patch from 6.1.y might be the best move to resolve this
> >> regression. Mike earlier in
> >> https://lore.kernel.org/all/c947e600-e126-43ea-9530-0389206bef5e@gmail.com/
> >> confirmed that this fixed the problem in tests. Jeremy (who started the
> >> thread and afaics has the same problem) did not reply.
> > 
> > How was this reverted?  I get a bunch of conflicts as this commit was
> > added as a dependency of a patch later in the series.
> > 
> > So if this wants to be reverted from 6.1.y, can someone send me the
> > revert that has been tested to work?
> 
> Mike, can you help out here, as you apparently managed a revert earlier?
> Without you or someone else submitting a revert I fear this won't be
> resolved...

Trying to reboostrap this, as people running 6.1.112 based kernel
seems still hitting the issue, but have not asked yet if it happens as
well for 6.114.

https://bugs.debian.org/1086447

Mike, since I guess you are still as well affected as well, does the
issue trigger on 6.1.114 for you and does reverting changes from
a13f316e90fdb1 still fix the issue? Can you send your
backport/changes?

Regards,
Salvatore

