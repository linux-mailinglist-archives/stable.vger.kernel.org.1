Return-Path: <stable+bounces-18733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 404E38489BE
	for <lists+stable@lfdr.de>; Sun,  4 Feb 2024 00:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4801F24300
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 23:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE7A12E68;
	Sat,  3 Feb 2024 23:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="d4hmAW8l"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFB413AC0
	for <stable@vger.kernel.org>; Sat,  3 Feb 2024 23:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707001682; cv=none; b=Dpu8McydrlHNVtENvz6KJIC5CqYk4i+YLsLfJ2aQdAzVK0yWRsQ0AOM9+9TYwyKrxObrm3+D42YPMvODoyQnvIhVJ74NIklnglLN35od4dt7o5IzWLU91F/do64sgo6XeKfKTCqq5YjDDH4MTjxaHyncNi11U+njugNGZOX8ong=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707001682; c=relaxed/simple;
	bh=7p0zw0Zru3MsWw07ScgwZWkx1CMQuefGCDRebXcKKrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHJnoTQKJmjJXjjYVUHIa6umCYMd211uhYnm/4uJULejjFoTDdkZZG9KDWsD4h2DZm/8sP2GaJxR8hwEH81lv7Cwy0j1e0teXc3vA4DfN49qGvRxGWHBLZHc6Rz2pFvu3jkQlVCKtUNY8l3BtKMWeVPGFgMl2qEWLmC8QvWtyTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=d4hmAW8l; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d746856d85so24867195ad.0
        for <stable@vger.kernel.org>; Sat, 03 Feb 2024 15:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1707001681; x=1707606481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+bcyaVUeNaxyEoXSbmvlmjxUQdhkegwt1YEX58Lwf4=;
        b=d4hmAW8lGEhZsiFd/ZL3E/nXwEMy5V0Swc6+XAYhZ4uvufzHC2dNkMUm92aeLLPEhw
         XLHlsfPOSky0LdSVx0iF/G9w8jz7e5TdtvJoZbVxq3xlvFbpU+KnKpn/ODUNDRnSc3TA
         S3pV9l/YndwwyfW6SA5b5OYF2+ZFLez4FeMAdamhKM/bgWUSKuyTVCgFCExEbAg0EBps
         KDvNz+vIkoxmWe0z5Pid8TI6Kn7UAaYth+mjz7PDPiT6YwtXYAvLwUm2S7NlWPFgrnj+
         fDZMfWXP3QZY1xoJwmWfgiLeCwzM3bIwdZvnube9B/5wpOwshdTSp7w8ER85vP/hc7bB
         LwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707001681; x=1707606481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+bcyaVUeNaxyEoXSbmvlmjxUQdhkegwt1YEX58Lwf4=;
        b=rvAc7AozO9saZpry1wf+alqb3KLwczexJ+SE7l7D2K9YFt6RVCixa4ZKI6H1M8C9Y5
         ZQaSzOLDwTZmaJVenGNZi0BqRAWJ+CDecwQwY/zKThVRvq5WuY8X8XXLS70B1+0qjpvD
         xNJeSjfOiRWR8Bs1s9pTMZPDrshM5x/GXYJ8hhWCqWqhHmdRtxVddmGKItuAbYgEfMdC
         k6hO9cPUFFhCezIq6jfjAsElDY9ILRpsCyLxGGtkSEe5FIf20drm5e3KdcWOutC9FKFR
         rtL+FSJnz4u9PzgflrHF/sjC+BLO4CtWW0EqmNS4Pk7QkEX04ZY6kneZVPXVDo8DoY/Z
         UOCA==
X-Gm-Message-State: AOJu0YyOPf9awh+sCqzW8tc+GJ+eJukjEFYHXdRuP6T7QLs08ceeAzzJ
	KkwMR5dQiHjSekmyXfD3Omuld8MQ92CTUbA3rLTT/zJug6wRJaKiCE/bc0MwS++oiSlMz9KN8FH
	jx0Sj8tmViyuOtg0gGikydiFXu/kFMUdmCTWQTw==
X-Google-Smtp-Source: AGHT+IFhdozQG1G0hMbTqVxDG5libdTTSaFkdNxFFWC7hBg7ttK+Qdlvater9xOWBPPUyrohBpk/ISI7HXXI3zOZug4=
X-Received: by 2002:a17:90a:b113:b0:296:1da3:c9e5 with SMTP id
 z19-20020a17090ab11300b002961da3c9e5mr5159730pjq.4.1707001680720; Sat, 03 Feb
 2024 15:08:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203035359.041730947@linuxfoundation.org> <CAKL4bV59sRxqmyn33Xyh9uU8EMxytfqqNFAKxAdFALdWXzr-pQ@mail.gmail.com>
 <2024020321-predict-twister-356f@gregkh>
In-Reply-To: <2024020321-predict-twister-356f@gregkh>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sun, 4 Feb 2024 08:07:49 +0900
Message-ID: <CAKL4bV5OV8JBr0LFAmXyaqb6N3ir-Jsaiqtfc7FDx4dduFq7Hw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/322] 6.6.16-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 12:57=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Feb 03, 2024 at 10:48:48PM +0900, Takeshi Ogasawara wrote:
> > Hi Greg
> >
> > On Sat, Feb 3, 2024 at 1:16=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 6.6.16 release.
> > > There are 322 patches in this series, all will be posted as a respons=
e
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Mon, 05 Feb 2024 03:51:47 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/pa=
tch-6.6.16-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git linux-6.6.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> > >
> >
> > 6.6.16-rc1 tested.
> >
> > Build successfully completed.
> > Boot error.
> >
> > After selecting the rc kernel in grub I can't proceed further
> >
> > Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)
> >
> > Thanks
> >
> > Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
>
> Any traceback report from the boot error?

I checked the log when the rc1 kernel started from the kernel that
started normally, but there was no log of the boot of the rc1 kernel.

Symptoms include grub starting, the screen blacking out, and returning
to the grub screen, but no keyboard input was accepted.

The problem was resolved with 6.6.16-rc2 and it worked normally.

Thanks

