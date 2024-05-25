Return-Path: <stable+bounces-46181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AD58CF017
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 18:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49DD6281C8B
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 16:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2084285C41;
	Sat, 25 May 2024 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Di7zxj4P"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0489958ABC;
	Sat, 25 May 2024 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716654322; cv=none; b=sp3+u+vdpehnDmRIr42NuUQDjjbPgsBZvj8cNlB+FbyZNLVr8msbOBrSEbsdFEieBLNS6gtuJ8IgVDfbz8pP6FAed0oMO8t/etZGU4ddtHyn04phJGPysr21tZfNLASsNfZ6OrfXszvvWmp1pvWeh8WLhGaF4I+P3WZAVp7UlEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716654322; c=relaxed/simple;
	bh=CDoezN/cnm+4Pu8Bq66dbl3Q3Ms8K77RVub81VerADY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFDwItdYRTuXNOHT9BsMzNM7I01cPsY9N8uUFgLXDDLGa1oPuoLQDN1ySHI6aNRLZ7nY4WzFklA/XMQtrMgdIT+J+RgHpj4pavE9PV3EYX++/jdD+OOZfaGzyuY5gJ33qXwxY6r0NbHn7FSSC/o8GM1oSujpzQ112p7ykzp6pHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Di7zxj4P; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-48a417fd190so273589137.0;
        Sat, 25 May 2024 09:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716654320; x=1717259120; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aBQ51bjr/Gtj6cpZQIo3jX22kyKsrWWP+TGZyC0i4bE=;
        b=Di7zxj4P1UoRWux7ptbmdedO+PUrC75bzVworpoSdWmHL91P/z2gjnNdDTSaZNQLso
         i1u+fyDANQEozVYIbyPPY4xwECbCGoXL5bBeSWJlB/tWJNbhwuQJ3scIvBwPA+/1j1Fw
         bD3T3xN/nmrxOVwEsxt8Uo9EnxxtF37Z2Yw/XlKPykihVB6pFyPgiPQzbj8pB9TcbyeO
         V9XcsImJoMkz1pw8SxWqsEDHzggbnXxm+VVnMKAa9Oiqrxd1M5ER/XUHgGJFDmbcIZdw
         pt4ZShf6Ku74VuLiXje6fLk7aNsE1huDw6k3TiWpmOOSZSaLL+t94xAfdfqLxDzMBM3H
         OOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716654320; x=1717259120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aBQ51bjr/Gtj6cpZQIo3jX22kyKsrWWP+TGZyC0i4bE=;
        b=WJf863iCjGdhz+vM4Ui4X3JJ6S9+BCjp+mSBTiJKQZB5bFZnemOPcpX99VOuCYgSod
         PZ9Lsrn33TKNYFFKKQPgCFJY8ZnIbrf8qJNfXBWmSUUWNoG47t7zG/nxeISBkWOgTJuw
         hzksTfZsTGZeKzBV5FPsguT/duO+5P2GJWV8qHkpJRElHXRw+1R/j3B6hx9vAZWWr+lM
         v/zFvLe+yHezD1hp5NAtP5Ir8m2194JZr4jCYzmDKMjsq7yJSs3/Gj7JoRpZ/CHA5unA
         Hwy5RXkBsNV0wjHmuzrfcxza5cJpBdWOMDEs1o6B/QYTnux91iYzFDE5Bb7HCcNetU1i
         0STA==
X-Forwarded-Encrypted: i=1; AJvYcCURTfuEGpmNA4/vZtZLrANl56anAoHpr3iuV0JU+LV562ot5j6c8gJ0XqE0jH0D5qNv8ria0x3chYFfwpiuV0Ahs8GRoMVOizmjEaD9
X-Gm-Message-State: AOJu0YwJULcuqX7jc6VrVuRZI7/jV4+BLtgjZxGyf0RH2Y0vpHUPYF0H
	o3A95wKqNlQMIyureLjISfoqbfz2jmB2+2dWvRN0jdFpELnVSInLpBHodEYjroHv1sawSPYkrtc
	FkeO6yK7rrDN3fakCo2/z9YpA7jQ=
X-Google-Smtp-Source: AGHT+IFAUX7e9WvqCYrBAgohlMPp4hZBzdQjAPfYVbxRpcPyAxgxcqsL6QxuCPh99yfgzuYAtwBvZ5XdSqwkB/OXZfY=
X-Received: by 2002:a67:cfc9:0:b0:48a:3308:f80d with SMTP id
 ada2fe7eead31-48a3865a196mr4896717137.26.1716654319788; Sat, 25 May 2024
 09:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523130332.496202557@linuxfoundation.org>
In-Reply-To: <20240523130332.496202557@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Sat, 25 May 2024 09:25:09 -0700
Message-ID: <CAOMdWSJG-1L7KG9mwFBMz2jLZTEN8C897822-hWN16U=Wo+Pag@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/45] 6.1.92-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.1.92 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.92-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

