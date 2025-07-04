Return-Path: <stable+bounces-160172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A7FAF8F8E
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 12:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABAB04A51E5
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 10:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D018A2EF9DA;
	Fri,  4 Jul 2025 10:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="dZEKq0/M"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22EA293B61
	for <stable@vger.kernel.org>; Fri,  4 Jul 2025 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751623809; cv=none; b=BGhyyAey6jHV8sNPxOzFXEHAMpOL5lH9KvJfDpXh5UQJQIdV9IapixMXASL1IKHL3ShcM2ac9Qc1qZnlGG34g0Eoj2bKVG8/zC9lLlYl6yebWbic2NvnnhcHmz3UTA/vQXI2zy6m1+KnJ9ui0nF9NoBGHyuWwqsEMJIR5uDP07c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751623809; c=relaxed/simple;
	bh=BvJSQBbLCgsK0nHpn3Pabnf+DjFGHNKncR/GG/p+WXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UyKgTR+sQtOdYGHOFrJKVudeqbasgG7bpsQX4tSPihHeAGFn8eAMa8eLS/U0MlOZzE7kB6AbiiZE5DzIdsdFLJxAd0f6I8iQIfohO6CPlbwBWv+SGw0LZC+X4J3hJHs0lHPoKUCQa2DxILDa9xsrJqQko+SksjB3z8ykfUO5nag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=dZEKq0/M; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-31393526d0dso631832a91.0
        for <stable@vger.kernel.org>; Fri, 04 Jul 2025 03:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1751623806; x=1752228606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGomid6tXjDATmj2wPfvjxlPuB+5sxSNFD5zhmmdhyQ=;
        b=dZEKq0/MDYj2TgPwVItQIkcKa3XQ/C5iWfu0mzowkIeS1YaUcj0o3yxKYdrPyvtZY3
         hvTpu9Eq5q8J/Rj1mOphwiXK4oQUF0mUClv7Jkx/c4y98kBmA17TLYMgL0Zz3oHGVJ05
         bflY7+p65obG8FdWLokS2+K13hxN2MxsrDZkmmreEfSsyyonia0DsjtWb9REL8mEuk1M
         /EyKtOmZkRt6+VClqE97ngJNwV/Sfx6j2GTPf5FFSH8VO6ufd5IVCOSeXpvoEpb6yujN
         JT5F6ymD9G5+ExbCF6496VUtZohO9FqurS3Aw8WCl/Xa50I7QczXHON0r7cAVcwVnaA6
         KOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751623806; x=1752228606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGomid6tXjDATmj2wPfvjxlPuB+5sxSNFD5zhmmdhyQ=;
        b=Y/uFimITAWEuH6YnIxYfVVeR/zKp7A57vgNmjvn/7lbMXoCygihDenBxUhPXeKxR+y
         ujygQXb/y1hqAysKW+PUPyZQaSD9a5KtKwaAsnNgTNU/ORH/aMsh+XGM3z3NQIBmK9KW
         6ROytTqiZYaT1ZSCvOZfcPZId/C8l+Fqq+4gGaSdSdzwnF4qgjDTIzKMuSbBy9ZBgu1O
         986u7dLRaXPApuHzzLXvc2oeIBHXvWuwsGfiV/00TuYthCHARCA6OauugQI1VcFtqrka
         mlKwSzdkTWrprVRq/dTy/mBdSEaq+nHXPQ6uZA7XeCCYhQE67jNfVLCfxQ9NUGSVF/zF
         9Png==
X-Gm-Message-State: AOJu0YxmQmkh+XKeSM2wZVmJBxiGpcmKJ/hJOKBLqndyCD1Udvpt6ylD
	3Dre4UweRBrQItggU4qg6u7QyBOUouc82NfeYhtfdvhb0iEICCLpzWt6FUKinziU7c9kmpElGxm
	sNiF8BI+wGY/dMa2K/h/hb1pdQ3ulMIWtm1r5fGJ5kg==
X-Gm-Gg: ASbGncseDetu9keIOH/XPnIsKQOO4IHIKI32M1pttqEA6ZMEHu0bl5sRgnTbhsfJ6O3
	oZU9tF3ykDEKb/srU9c3+YMaSobFMcnsUjX78AlrHKdb1Y5L7x+BYzAnkk3zCcbiT9qr+O36SM+
	LxYypPDPdv51WymzJ6msEp3AQPpIMpiim2BRtTqSrCxmI=
X-Google-Smtp-Source: AGHT+IH4BxE99Ef0qUkehLWAfQZiLQKgyRZHUcLhWdiTkP5SU7gyIx7AeqV22ZhDCpVD2aL0hWTQw6EzayZ60F59q/4=
X-Received: by 2002:a17:90b:5488:b0:311:a314:c2dc with SMTP id
 98e67ed59e1d1-31aac451a00mr3813426a91.14.1751623805958; Fri, 04 Jul 2025
 03:10:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703144004.276210867@linuxfoundation.org>
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 4 Jul 2025 19:09:49 +0900
X-Gm-Features: Ac12FXx8MuFp5ghMIQFlEe6cTz5NY-x9cQoW3RZ4g18YXENAdqBUMD0S6cvI_8w
Message-ID: <CAKL4bV4mSvr9xRyrdYpopTb87BsbsBCj9t7jO+33PA5BRaFe_w@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/263] 6.15.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Thu, Jul 3, 2025 at 11:57=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.5 release.
> There are 263 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 05 Jul 2025 14:39:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.15.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.15.5-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.15.5-rc1rv-gd5e6f0c9ca48
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.1.1 20250425, GNU ld (GNU
Binutils) 2.44.0) #1 SMP PREEMPT_DYNAMIC Fri Jul  4 18:24:44 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

