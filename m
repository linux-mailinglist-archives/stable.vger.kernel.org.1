Return-Path: <stable+bounces-80644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD0798F0B3
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 15:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E201F21AB6
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 13:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A32C19D065;
	Thu,  3 Oct 2024 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="x5Fj9Lgx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B0819C57E
	for <stable@vger.kernel.org>; Thu,  3 Oct 2024 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727963102; cv=none; b=KVFuoc/IkZt65x5dI7DJ7bmhUHWlzmMO+fK6L0hMgHkRQn/IPYw164/qP+PfzR8zzQIbKdckbWFDfvTjLZUOD6JpPtBbCFSxb5/gUEKCbo2oMtV96+YhGrtKz0+hL827dUbm8lChRNdD5DJbOIsediKnVdD/JjfhO0STo30GLoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727963102; c=relaxed/simple;
	bh=RD9U78fWEr2OLYZ3hHe/2YSy67zB7CeCkzI3wXX48WM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hiYwyN7g9Q2cNZpKClGMexyQuB74nSFRUdSsYWbfMiFKbqhgb9Oxu14FBBLwXxLsmzPr/xMPcNadEky48RBRxMzusPO+t3HwLhTR0oLlE5DnnmgZSA/eP76HXq/ZTeOFSz2/uFGIa3UmTdMW3yWli4iujZT5ZNkZidaH8daswR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=x5Fj9Lgx; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37cd1ccaf71so1193237f8f.0
        for <stable@vger.kernel.org>; Thu, 03 Oct 2024 06:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1727963099; x=1728567899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwqEYZax0+DPVB+o/bD03kfHhlCvltBh2zIbh2geEME=;
        b=x5Fj9LgxTSx5AcNidou4LGv3bltkp4PLejDiuFwKMAC7vJ3G9nyza/rh+4GE2ErNcH
         lFepYchrVhd0oKzrJ2XpYd6D56MypMpTly43hGuIAVUne44DukgaKe7JGHosT6wMR27D
         g/GDWqdpbova69+qTpwkfZ5dBuIiZ/3qrNyYLF25skfFnKjIzL5R4P59oZ6CeygEdQFu
         s/DxBpOnIJlzksd1QhjANei5NgXFABUHtoN8H8ZB+ZGx17BiGy7a8Jr0VZqnwZzrRsmL
         LjFSHsaPF6LKKrlLNdaD45A2J7Fkmf9FZAuSxuHDB79iC5u3F/TwaSB7u1idvRNe0PE1
         FzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727963099; x=1728567899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwqEYZax0+DPVB+o/bD03kfHhlCvltBh2zIbh2geEME=;
        b=wQWKkl6QCaZ6LEoWDfBsMycL8dyhVYvSjA6MjcfPyt7aGQMR+9rAgmLYdhybhFT0vp
         TbqJhEBHZj3tY9BqoKVutIZYc7TdV1SakvLfa++VhZ2l2fEDxb9PVrkzKRxhQMkDB2AF
         vmvoFZqeZPzzzvNyLcByYeMhSTXGOgx3eBmzX6UCDgKsLj1slZHfKzkJ4tWg61fbXfy9
         ho9x1dFE9zj7QT3oCmJOWpvxg+RKVhT3A2SHxRnAaLTd9g999Cn0y+mGtJeJZFRcqAvp
         iw5Z64aWStNSacwCRFPXJEUdweHD5W8/xvz35ppEiUJ+Vy8nZGVojFvayp5Fw9mFtu6d
         GyPA==
X-Gm-Message-State: AOJu0YxcvvIyDh8vPuSYkv1wg3//LKu/U8ogwAOAtDY0N353GH7qeYu0
	Hbsu3mgnQiLjolZqKXq8C7RhpUK1GVpnw15KFhxey0wGCeDvhzY+NPkBHID8vUNz2bqVNmlCkup
	0CDsZsXbQlMytppm87w1argnivLciNnxRfpbfAg==
X-Google-Smtp-Source: AGHT+IHmzkBQRnjRJ/DhHK4cysIpn8dwbmzLNUFnK46MKOshNcu+lFN6+0HCNvQiySIFkEeJ468TQlxLcdVB1Cj84vU=
X-Received: by 2002:a5d:550a:0:b0:37c:ccdf:b69b with SMTP id
 ffacd0b85a97d-37d04a5a005mr2036695f8f.32.1727963098488; Thu, 03 Oct 2024
 06:44:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003103209.857606770@linuxfoundation.org>
In-Reply-To: <20241003103209.857606770@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 3 Oct 2024 22:44:47 +0900
Message-ID: <CAKL4bV5zK5k7uX1DhT-3=AiK1XWzsQe-V-d-vXpyJ31NSHOTLg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/533] 6.6.54-rc2 review
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

On Thu, Oct 3, 2024 at 7:33=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.54 release.
> There are 533 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 05 Oct 2024 10:30:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.54-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.54-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.54-rc2rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Thu Oct  3 21:30:01 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

