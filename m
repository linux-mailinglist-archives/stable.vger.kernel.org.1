Return-Path: <stable+bounces-55839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30209180D0
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 14:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9E328AC0A
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 12:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72888181323;
	Wed, 26 Jun 2024 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLTpwX43"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9BC180A7B;
	Wed, 26 Jun 2024 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719404344; cv=none; b=NX5Re7znpOzPDy8+/9tgWR6Unt7VSHSqje3fjhyzC3xwM6x5lPbZJ8OVkdZ3e2K3UBHz/DB0iR2s57XcyV7Gt7H2UMEI5gvXaQXoruIfwvOh6UvlniqXieo7IYkP3pN63h5BeYIoGrBy5h530S3hnQhp7Xesbo7fKNpeJVD17jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719404344; c=relaxed/simple;
	bh=56dkKsWwS6gT3chl9n/33P6uCAEWaG+N58h+O4G8UQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrrXG5wDpxkD9wkvjeglZJC3gaOFAux59dVjZS2Nlv0SKvEQxQheDQANrKxgFd6wDVBNNXk1GlmBth5XOFTjADZCD2HK6elTjFfxgPsTwW1tFn3Fmmfe1obmSwtv9GJqPyIbO+kLAPTX4246GGob2qkilxBxjUQ+Rgo8hnS2DX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLTpwX43; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6fbe639a76so86609566b.1;
        Wed, 26 Jun 2024 05:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719404341; x=1720009141; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cEiETu+xNt0IYUh7HRwOgMHLEPTYFNW00L5a7FsgGcc=;
        b=GLTpwX43nzpk7+Y1YAV3SANzNrRHZbAp3B2VaK1bhD8hJabnkQ/Tueyw3eHWFuxZiq
         6UH/JlQFExPdS1JaMDKCeX3et/rUiGvENz+lYsO6rngCad/ZhYzmVeRCb0QWN0A4NG5R
         dLGC9wnLMAiX20Y6DLng+Ka6wuW+qlcJdnR+L6uPNqoVIvAqd+F7wRHxafChDPt2GQyl
         ZSwJ1j5zfQ5ARdSKAUBUXneQdKHX65oXV8tYauHyfKZwgE5myIp4FuzPH2fqUF5SlfVQ
         5owyxjsR00sTgD0mzBN0fNm0VazvoAJQJAOcRC768LSe54g1YSE3GBSqNWcIfKcME8C9
         yd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719404341; x=1720009141;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEiETu+xNt0IYUh7HRwOgMHLEPTYFNW00L5a7FsgGcc=;
        b=D7LLVd7BNyvfO/cblmFSZozZ/aKO0A9AFgpRHVWCvLAyEV717nsyaFuTd6XhVRJnwC
         R0gyhcopDUpNl5gys+V4hwjb5IjfaVkJg9/ZPQIq+/lrtjE64g+ie52Y0bdD5wpaR2K2
         wTKLd++Lz/Ce6NDRpGmFBtJ5G//pdEowdNOvOv8+8zdncjqxP/Yop5UiLfLefEDMfrY2
         tvGY28DrZVYEuHYZsRBvXamIoReV6XZl2Fc/nigFWIudzMTCJ7S22rwqS/s0KzVHEFTM
         94i/unUmNd8ChFx1jkracgXGFHRXPqdeEW0ymQvRYt3tKqCKOW8+/TtOr/midynVl9lD
         z7qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHxiTrhFnvzCjYl2ltkdFxDLQGmfLv6KWlwvtjus3D7wrt+T2p6tPOz7XsYa844AsoCmw+h3lVHQ6o6pMTjR+Fc+lM/rUeByoY3VsF
X-Gm-Message-State: AOJu0YxKho4MBnEFGg1gcqAb8H3CTjKkLQXYa64uTphhr8wyGKkrJeaK
	TiETJPV7aJGgshXeijEcRKjhlNEfZZbYy4Gdrm7sLgUVi5gauMqQ4n5gDknaqAYhEvmqX3kF3eM
	ZHiriWMnE4iduiRQ6yqvMtQVV7mQ=
X-Google-Smtp-Source: AGHT+IGSQHt/2tK0iZI5vAD3vfe2hzBW25voA5HAWCa5f2Gvd2zcJJ0FNmsRkR1DGpgP2T3jsjGeOlqYW45SOJTprY0=
X-Received: by 2002:a17:907:d506:b0:a72:7a71:7f4f with SMTP id
 a640c23a62f3a-a727fb4082dmr230132066b.7.1719404340670; Wed, 26 Jun 2024
 05:19:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625085548.033507125@linuxfoundation.org>
In-Reply-To: <20240625085548.033507125@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 26 Jun 2024 05:18:38 -0700
Message-ID: <CAOMdWSKFTJa-Q=OMV_50uPrJdgQHCdYfR7uT27_9=dP3B3YzFg@mail.gmail.com>
Subject: Re: [PATCH 6.9 000/250] 6.9.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.9.7 release.
> There are 250 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Jun 2024 08:54:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

