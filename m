Return-Path: <stable+bounces-83649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638DA99BA13
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815F41C20A06
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA21146A63;
	Sun, 13 Oct 2024 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CUp0Wd8/"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2870384D29
	for <stable@vger.kernel.org>; Sun, 13 Oct 2024 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833382; cv=none; b=NlctbGwgEatDxx/5IwonuarECpTYnN5d5dsLC4v8lUOkabVTCwyDq4xWb5OLvfRdylTrbo3UTFCj2j4qGcebneMPtBP6h+zSanMtAxEsiZ7i3U8DZru3Fz6MNo7nDmga6Y1C939qgFBQ6NrVbBJIH7xoCfDMs1Fhs3rPUXpu++E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833382; c=relaxed/simple;
	bh=3o9IB1LL95xgWvjhPFczpIo7MARvr7NooRhwCI6cl90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcW/qo9wHuSbgAPHj4c2kIiwhzrL8oLMy2PBVTDMFE/1/N+V2MBD64gptkyWZDsUMWMhzQi/5tt424JCA1nyHaFxfJfoFuQw+woUp1txbi+l5ON32xIEuMEbiYq1CLjTC85Urf9nLbRLvZYTfVoGWlL9LdUpUkoQKX3IMk8Vemw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CUp0Wd8/; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so454205ab.1
        for <stable@vger.kernel.org>; Sun, 13 Oct 2024 08:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728833380; x=1729438180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmCJ5852Sy8b2LDgs36R2GQsBBat9A4rRP0NggvW78w=;
        b=CUp0Wd8/if9WR5A+SRcMz+mqxAXCb08Y+eOycBEcAeNfYi9WZvKkVxmHMwWEhSpsbH
         kWE6SgcuZy1NskHvpwu40PKjzj9OO3uTgX0TyY3S/FsZN+/Bu0MPEAHmKFlMSenoQ+u3
         Acgzw85VO8xjXc+oTeLghf/mkk3+u1yYaK87bbAVLjWA9golBjlsw8HygkJXE8r52c2H
         4oe2Hck9v4LtE31LoE9nZ4ET0axFwox7rRYJNZODev7wwx6bhgCNtbl58GZQMb2Frzul
         feHSdwnsfFUQJDE3O6X/u2EDo5yUTk9spGNPYZQWI8KD04VnC27GuZ0ZVYGIA48GLrds
         +WuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728833380; x=1729438180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmCJ5852Sy8b2LDgs36R2GQsBBat9A4rRP0NggvW78w=;
        b=B/e1eMlRexljtPgUTzr2y2TexvX40HrMOehOBbjbyp2eKC67udUVnIGismW9nSkYxR
         T/SCSDCepbz27OfiOOk4HlCftpzfrf3FrQ7dpQbViT50Okpf6IOekhg+/9MkUUDvPJU/
         2YSPjuILUbKSMIn4nklJE4uS7ZLVWxNZDkvKG2z5cfmgjopl+fJVdmQXMCzFXuXk3Hmq
         sPFyfN44UU4hULs/zX76Cnjq4oYN69O1iX7SO/Jl1MEVX7Z2L7xrEkFu1M6wwMXkKqHz
         x4G70Bmp0veZDz0CTwKzFDiLnCLOesnlZj6Xnl6NGZOWCtSHejSUxSF1ZqvmWDvIZyxr
         sJ3g==
X-Gm-Message-State: AOJu0Yw1P78ra3OM4htSuIvt8Ac4wTBaj31I4CXrMPFq9JYpneNlIVK+
	N8BFy5IQ/XXnSJyDVqOyWsthaH/Q58u0a3HfgFMQxVzbnMhYUhVqDQBIlsseXQ==
X-Google-Smtp-Source: AGHT+IEBdwoE+A0XVWOPLUVAxdRWBzqb+FKFzGf7hKy8kcAhNj8EDsWpghy5ONesYFZ/jn4xdE3vbw==
X-Received: by 2002:a05:6e02:1a07:b0:3a0:a233:caf8 with SMTP id e9e14a558f8ab-3a3bd30c717mr3865335ab.26.1728833379982;
        Sun, 13 Oct 2024 08:29:39 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c3510casm50926645ad.286.2024.10.13.08.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 08:29:39 -0700 (PDT)
Date: Sun, 13 Oct 2024 15:29:34 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, boqun.feng@gmail.com, bvanassche@acm.org,
	gregkh@linuxfoundation.org, longman@redhat.com, paulmck@kernel.org,
	xuewen.yan@unisoc.com, zhiguo.niu@unisoc.com,
	kernel-team@android.com, penguin-kernel@i-love.sakura.ne.jp,
	peterz@infradead.org
Subject: Re: [PATCH 5.4.y 0/4] lockdep: deadlock fix and dependencies
Message-ID: <ZwvnXnLRLCiNhfmk@google.com>
References: <20241012232244.2768048-1-cmllamas@google.com>
 <ZwvX3kxg6OoarzW9@sashalap>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwvX3kxg6OoarzW9@sashalap>

On Sun, Oct 13, 2024 at 10:23:26AM -0400, Sasha Levin wrote:
> On Sat, Oct 12, 2024 at 11:22:40PM +0000, Carlos Llamas wrote:
> > This patchset adds the dependencies to apply commit a6f88ac32c6e
> > ("lockdep: fix deadlock issue between lockdep and rcu") to the
> > 5.4-stable tree. See the "FAILED" report at [1].
> > 
> > Note the dependencies actually fix a UAF and a bad recursion pattern.
> > Thus it makes sense to also backport them.
> 
> Hm, it does not seem to apply on 5.4 for me. Could you please take a
> look?

I'm not sure where the disconnect is, I am able to do ...

$ git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
$ git fetch FETCH_HEAD
$ b4 shazam https://lore.kernel.org/all/20241012232244.2768048-1-cmllamas@google.com/

... with no issues. I don't have anything on my gitconfig that would
change the default behavior of `git am` or `git cherry-pick` either.

Anything else I should try or look into?

--
Carlos Llamas

