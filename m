Return-Path: <stable+bounces-35595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0777F8951E5
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 13:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66F86B245E4
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 11:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076C36341B;
	Tue,  2 Apr 2024 11:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="SD+ylnYY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B1060266
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057572; cv=none; b=Y2gRxOgmAkQM9niKNoETX55V+b8ZFyVyM/dnepGb/0OkKWfZGhcDsQAEUnNtsfEQwn559mlRiCZCzcA3PxI2JC6ViCqFsrwpfrALUwqM1XkEZFyAhHH7HfwzUIGnl7Q8q9c/Z4AkrEb1tx5u68X5FgOCfX+b9ynXZJBZMgO+wvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057572; c=relaxed/simple;
	bh=YRmGqypfvRqmg3mcQPuCwYHUt0Glp5uhzSXwBXtnwMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMWQHWRBbobEvYGlx8ctCjGnMudTYfWLbdYI4fKROBQTzQh4ktNxvuav6emuP1lg8ORwX1fBZ7UNyQRTkBizNHw6XTt0fIMWJPnDsySiaBVXG9zX8B8N8Z9Sjwj1EdJtYNwfJ6Y/J2XcBjR4HBjp4A7DgtpIaaHX+tor0crr/2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=SD+ylnYY; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2a07b092c4fso3826386a91.0
        for <stable@vger.kernel.org>; Tue, 02 Apr 2024 04:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1712057570; x=1712662370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWJ1eWNsf3mDKXSgx9qyOAX+jE4gBs0xL5TwqXBogn4=;
        b=SD+ylnYYl5ksxZRaLXdfpJjlANPjSxBnLs7bxHMnNf++xrPJf2fHzCobbYHVOYIAv4
         NGRFpha5Iouu5GlAhX2tlY6sL37eo4cfTVoQb08mTm+7O7bc+IjNdwjDJHlxkLk5IYgz
         bVTYwbGmkZQ2xkoMpVM1yZM4iyKJOmz4/d5S0H4pT+srs7xQBrbnLbkCHpsVDjkf5BxU
         apenIiPq14MGrIPtMNIAhTFpo8H2jbjzfu7OV/mSJ6SktxiQKjZJTn4CzXRjC7yWUR6g
         5zcr21De3A+f43CcMIRYtwox6eI5fSMFOPEjjKSSXRPB5akdP5A9CRWLHrgmWRFKEWxD
         1AiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712057570; x=1712662370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWJ1eWNsf3mDKXSgx9qyOAX+jE4gBs0xL5TwqXBogn4=;
        b=F2QnPOFRXUVbHWxgSO35KtN208CKBQmQotD3OjI2isPsLfn8HujnckWdVy5+pyNfTA
         mk9n3/gP00Q9oxo7KuJT4aPTlNdEJtpOtOM2WuNlYwVcgFPsgHhZgF5Mtu74gnqPknW/
         uVf8vJvq8fj/UPJEiTWFXHrY5VKmSa1gNo5kEfCB7QCfMwCgSBIUT1/qMoLxCyGtl/ev
         lWD3Z3U3uZ8LQCjQyp5ykjqTgTw2aKYyOA2bEcfrOGPWvqaaTuZCl9vlIQpz1rUpkkmI
         lr9adeV5IpTbHSWx/+3GO+IkxTV5kyFRCLaXZwLBA6VsufLQBhE7P/thu7N7VVRfWx+p
         y+Wg==
X-Gm-Message-State: AOJu0YzPPWe49Yjhwnl2QLlCk4UKP31vH/m/xBDKubsvPJ9I4UFaj9cj
	M/V/CHQiaqAgSHlVtRtMfzCFZxH/grYM6yl3fQiQHdFnSQIR/4LZx9cQM+WNYE2WDwYl5TC65mz
	e7D36+C0iwqBlZ3RkKg8xaE1yPl2UvfTI1tRovw==
X-Google-Smtp-Source: AGHT+IHx7EUuj7nvRf9Fi4J4iGIeWWtS0WlmsxgcMUaOaz7SMmHrxBW5v4aSmkZaEIencF5agCUbDZwn4zRGfIEOf2I=
X-Received: by 2002:a17:90a:a092:b0:2a2:2dad:66a3 with SMTP id
 r18-20020a17090aa09200b002a22dad66a3mr6122871pjp.13.1712057570207; Tue, 02
 Apr 2024 04:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401152547.867452742@linuxfoundation.org>
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 2 Apr 2024 20:32:39 +0900
Message-ID: <CAKL4bV4EQ0SMMCE2fYqovSm3PHThObmKHNJpaNSNOWKGP59CDg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/396] 6.6.24-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Tue, Apr 2, 2024 at 1:36=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.24 release.
> There are 396 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.24-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.24-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.24-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Tue Apr  2 19:48:41 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

