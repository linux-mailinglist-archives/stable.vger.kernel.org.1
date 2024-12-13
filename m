Return-Path: <stable+bounces-104139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F47F9F1266
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 17:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725E91881B08
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 16:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC431E1021;
	Fri, 13 Dec 2024 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DretsWB6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822EF16A395;
	Fri, 13 Dec 2024 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108124; cv=none; b=vEIR11Huxt2Mbg5PRVi2eIrZPIyw490EGGfwSRKTw93eUnQVUEOfBOZokACaL7OSYGyLsJ9fV0IlOknxak9EmRfgfPTLmH1l7LIb/RAvBMA0j9wDkr8i1Qov9U61teg7qrejhJdF/+QAi2ioE1HtQmwqq82idSbwEmSLX9Ib+hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108124; c=relaxed/simple;
	bh=DY3G1tEAET+rKuduOG5mnAvxoOROA2irBpLrMWyo+Y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/rAYlmKnlkGmXdYxRohWd4xO6G1eZvJxLhxMn7XG3U3VxIjh6qztVN6CIwiYJ7Ur8j8X6MoNEo6lKh0ImLalcM/MV3KEklk78Z//N+hgvAXNYqdKd/wQltHycyz9A8htf2PbITgh/aV1dUSPDDp980oEBPvtkbwi9TGWfxT8ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DretsWB6; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fc41b4c78bso1045710a12.3;
        Fri, 13 Dec 2024 08:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734108123; x=1734712923; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ky0lIS9S3eaYrQM5awNSe7q/rYLMAUYMFW0ogX+uCfA=;
        b=DretsWB6yztarqBIwNIEOoFiGgg1R1R3ph/ekz6kwI8ak7z6M/HMO9W2QbF5zffeal
         7Ujsn/3Z/CMOSNoYI8eW2xRY+eyWLwkL3iKN4wDue9EzGNCDAo5Oyi+o1iqdflFf5q+O
         bInTHQITHvZwbcv03blM6bvW9HbU/jmaIjh0QNiVAfnh+u9yMyfZ9AGEHWZAp3XhHbUh
         kSr1lpkzA8IAzFoYFxHUwHPWsSOt/Fnw410taqaWSFNN2Eom4Hfb0RhzxdGRYen5oXaH
         uvHWg4T1nhEVbJ99y6Z+JHNhJCWbE7eVVV3dRO52fxuINCN/sQ/A6C1aKi/eEb0OVWwS
         nbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734108123; x=1734712923;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ky0lIS9S3eaYrQM5awNSe7q/rYLMAUYMFW0ogX+uCfA=;
        b=QJqm90MUC7e6oLTDyfcjmu2xBtPXECvWjDySK6nkBh4831x6SyB7F3SxEYFSl4lrYx
         rgvyIp5wqsZ64sroRlsaRTQJ7GqePue/4p6NxIwrlDLUdwgsnynBSLYEFf0q930Dmg6R
         zAyDMUoTE4FdKRwQCKM5fRMBycahz3/Wopk4IK3gHHD50/RRNyr/F3Laxv515KdT5YyT
         NW+OIi1z7qELZNe8wxjtIPaWdXygthOi/Ce8+VF2DMfxz/XjJFgU0r8wGRUmr1Z+CSZ5
         xAC5LoeZY4lDszgZcmO7xANgaVRaGSxDnOkHPENftCXSWYx36hVl/xapN4qhJWFg5J63
         f6cw==
X-Forwarded-Encrypted: i=1; AJvYcCV2gG5tPpu83hPU39OnskIM7UaMSSgHRM0rYHQ4A2y+vUjSp8UCrlbgcvm2jvBzxrh97TSfrDvq@vger.kernel.org, AJvYcCXHZYQHUL67A4Nn4rLYiydyummSOTMyZvrXZMrNcLKgpWHcvx2BNabMNKvQ+5SbhgdqOeS6BC/T7RLEdyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF/bpLSTwGuHxjHLnKo/Ler947V99SinMItdQ73Ah5RYDO+vR6
	ECICbHek8gk+GrGtc8gOXeWLuYCF4ny1g+U25S4h05zcn9Geu1O6JO+DKhLkDEtJNEx1G6palaf
	oMOnbDApMxKDjFbaV2mWHrN4AaR4=
X-Gm-Gg: ASbGnctJ/eHIGyjK7NW7ETeZiIqgZIIw2j2WlAKif5R3ooa1igCtQY8/WgaIizvPMuv
	lefYDKc69wqfIsonis5Y+sS/nuO3Eatu2sJWvkcBwjPHmk88uQnnr
X-Google-Smtp-Source: AGHT+IFcd24FZlpjUic/WsMfDzCsGJdnlZaR48ryc9Ed9Jt5q52x8F1rQAtl1jjed3NlptuAOvqmbZa8Hib0UrXxvcU=
X-Received: by 2002:a17:90b:3952:b0:2ee:db8a:29f0 with SMTP id
 98e67ed59e1d1-2f2900a6ef2mr4924037a91.27.1734108122860; Fri, 13 Dec 2024
 08:42:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212144306.641051666@linuxfoundation.org> <26e5acac-0732-4394-9efc-da91630a0a42@linuxfoundation.org>
In-Reply-To: <26e5acac-0732-4394-9efc-da91630a0a42@linuxfoundation.org>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Fri, 13 Dec 2024 17:41:50 +0100
Message-ID: <CADo9pHhLG8KFcPc-puqzOq00grvuceu_KPoxM2Z58Ob7e6A+fA@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/466] 6.12.5-rc1 review
To: Shuah Khan <skhan@linuxfoundation.org>, Luna Jernberg <droidbittin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, patches@kernelci.org
Content-Type: text/plain; charset="UTF-8"

Would it not be better to test rc2 now instead?

Den fre 13 dec. 2024 kl 17:39 skrev Shuah Khan <skhan@linuxfoundation.org>:
>
> On 12/12/24 07:52, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.12.5 release.
> > There are 466 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.5-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> >
>
> Compiled and booted on my test system. No dmesg regressions.
>
> Tested-by: Shuah Khan <skhan@linuxfoundation.org>
>
> thanks,
> -- Shuah
>

