Return-Path: <stable+bounces-15645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C0183A897
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 12:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74DED1C21F30
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 11:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1971160DCB;
	Wed, 24 Jan 2024 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="hYv6FJLu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B4C60BBC
	for <stable@vger.kernel.org>; Wed, 24 Jan 2024 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097520; cv=none; b=eECVewSCh7UJImGj8uGhYEAR95iOHn0b0d2NKRU5xq5MFBWNMfZIYVXE6nLD1t1lc+buwTUAqYoi+oD0ct3xre+rAA4XfmS3j8hpB7yy/vHGNZDVjfvbxHPTA+nA/9kC7TUBeO525FeG747la2ePnoS2MPTMVGnPuuw89NH3Dmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097520; c=relaxed/simple;
	bh=2OMwQYIyKYq2QrymAVBBUuMzBZrJ/QI+2BLpsSS/wEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkpXRYkRQMolDaZ7eQUCvLiaVRB1OHUxhDI/cmZex/Iv75e5mNpd2dz8P2ByEsq32c7JSjmeMCv7i/TJdH/aV1uKUjloD4fFCAGm0hjdhe6772jNE3uuuMYXbeBFPnZspaHOmgBiqsgOLBuqoO4xypqB1kqquGYkJFcyEHEA0Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=hYv6FJLu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d50d0c98c3so51140335ad.1
        for <stable@vger.kernel.org>; Wed, 24 Jan 2024 03:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1706097518; x=1706702318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NSIi9kYH4kmkxlVRt8YH0clIrcU+K+qQZf81qv0t48=;
        b=hYv6FJLucgaJBAbNkrDO8Hy3mFz68KEvwUynp5hKBHAJvJU/X72leKZgTL+htReLM8
         MwGaBSO+Dmb0NQxJ5c9stagYe+fUaWOoqirTs364D8eM/naeuMCskH6E1Td6BRL5ySgS
         LQ8q8eJsVwyytv2OJiE67UxwpkD/r+tSW7DcEcANheDDs3U3nKBgvuBmbAdIRIjPJ54c
         fmL1VgKwWKmdbmkaltQfjlSosuDPlyktpIGScEgRqwZmDc73eU7jUulbh8DPoFUfPuGx
         6leJpCNld1UQiqu+mYpUkTITBl+K1ay59NmnBb7FFkmffKxrf4vTKUi4xp0rB9eycYxR
         BXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706097518; x=1706702318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NSIi9kYH4kmkxlVRt8YH0clIrcU+K+qQZf81qv0t48=;
        b=q9aU5TwzHmILlaYSr6SuERos7jmif3l9p1CJNLASFCqztsbhwrnoTuh4ORuC9xJMvb
         6e5xNF92cfqwxXb71fiwVFf8gcEeQaBBfPwK0DcioLs+BqV4dspYScoEVQHOxHx/+0CP
         lYeGb0Tj7ippZjEX0ZxRaMGVGFv6xHBuzr3gK3XQyoFuvrInRNGxKN+5Vq0l3D4ukttj
         /BEzgSoeq6+5CRnJXScyyls0lF9ITJSq+6YMaq+D+Big9Jyh9nAQ6iQyvhIhHRu6F4LI
         mHVMZYHK/MPIETQgJs5QoX7C/WCZ80qT8XUjiAhoy4XSICxtj+yd+vPCDwk4HoaZdhgx
         U69A==
X-Gm-Message-State: AOJu0YxPo72VKPwphOKYrSxlM8JWCXq+c5pSzqEZ7+HgC14Nd8XgMTox
	CCtwa8ZRY7nyWmFw8FPJx7YTIRaNSq1Tb2pHDHJnvIbsoBTljzg+fioRZFlmv6tjnBKI321wZxs
	NOp142o2O+j/EGjSbQckWUAf0J9DxxN+IckA5KA==
X-Google-Smtp-Source: AGHT+IHtGgZ55t56cQPQMUGbeBxtNl46eMANJ70ZzKQDIlpS1pOQaJViGbCIAFKqVyUH2zZvzMGT36QM/s/9q3Aii6U=
X-Received: by 2002:a17:90a:7101:b0:28e:84d4:6ca0 with SMTP id
 h1-20020a17090a710100b0028e84d46ca0mr1491924pjk.20.1706097517811; Wed, 24 Jan
 2024 03:58:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123174533.427864181@linuxfoundation.org>
In-Reply-To: <20240123174533.427864181@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 24 Jan 2024 20:58:26 +0900
Message-ID: <CAKL4bV5AXGh4DD8fBjYF1gCuFcKTSYcXxdg1wh_1OsorV-TqZg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/580] 6.6.14-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Wed, Jan 24, 2024 at 2:47=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.14 release.
> There are 580 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Jan 2024 17:44:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.14-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.14-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.14-rc2rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Wed Jan 24 20:06:42 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

