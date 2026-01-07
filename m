Return-Path: <stable+bounces-206236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4C0D0065C
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 00:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3B073015848
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 23:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29A676025;
	Wed,  7 Jan 2026 23:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="oajd+i9C"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083813A0B31
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 23:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767828751; cv=none; b=t5XWRIsxgXJzuKRsmz4tfceFlxFqMDeSi2DKQETFiLK45UQ6rYQrloOmnK5ZKnbJiz3Q1cUSkYd3laXkRHFqvgeZdFLgst2gSvGcPbuxhKq6gp7i8ZHlxcYrB9RxVcLxFaRbN/KHKOuoONIBJCTml13pCXjQXbhW/ip4Ut8R324=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767828751; c=relaxed/simple;
	bh=uEbRyNx4dbnk3va4dkb6nQGKaRtW5j4AqrcIBxjnGe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=spWs56Mgy5CDhW7ARI8mmXdT0IHx9wNkgGSwRFWN+9vzbXXZaPoMH/qFA4LCESaOiNAKEnbTGnKwxx/PzdvhGF5uT5JmItVPm/bSfhRBkY1f4HiN2sRrUpDdzdaFeDCJlGLleuq0wyUWw6IM0BZgFJRxg+IflJF135yvhjKT5RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=oajd+i9C; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4f1b4bb40aaso13814941cf.3
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 15:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1767828749; x=1768433549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXU7HG4DiGW9EYR6wyIKez8sdkatjxPlrKyEoeiugvI=;
        b=oajd+i9CT+gSHbIgGsLbInIep3W4lVKFDNWvkqztM1EGnANlAAWzlNGmR3ZnqJAXmO
         dQXOKociMN95lyde7WPnOJrvvhkwxybQeIWGfUD+7sXM9M3pjjShR0IAZYxHBqBaLUDa
         OwS4sAwFUwzISQIP8sn5oOyd1HnV82XpsNa9AiJmSWkhIer/Ca1Wd7C4I6QX3M+dQdX7
         iW7XfHBfBlczQSisFlioXwhGgouuJDj1n4gUNXEQJKcQHfl3cHrqnHmI2Ojysge8EiJi
         j6y6Blx2UxX4CgrLVNK2kV0NSlLT+8uIkNeMO5cI0AJVrLxmNsIYzjyEVCFEE9s6zXFN
         xh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767828749; x=1768433549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rXU7HG4DiGW9EYR6wyIKez8sdkatjxPlrKyEoeiugvI=;
        b=RmjUfLtFbhzkg15jj2pn5EanqyC0WcwKv/d247CC3aY6Re/d9HDUM+RHyUcA4yx+5i
         NIHAbSdbkYW1xMIeq9kE/5DspHJIgF4MOzpjgMTQ9meAw2bJ7MyGGVaW9Ak/i9rNu0op
         X6kC6j8Ono0n6nNVHVXxgaEfdNp/2my3MmJLgq0oB/hHh1eWe1Ep9cRoq8cDI1XBQfvJ
         G8iuQph45ObhVFTUaT80F/K1uZdOAKDNDzMSZrX76HfpcR5qrMeU6bKvgFwR3ff0/UO3
         VexG+jN/xyc122CgjQFGdeddA6L4/V7zdgimTL9mpLchr9SP08RpANBFuzsrROZMMYi/
         mEpw==
X-Gm-Message-State: AOJu0YxE/RPHsvhnD2TyGcBU8H2oGyGArtCc3WdWi3l+V8k4KyJaq2Xx
	soAFW5S+eTyN/qxWtFwdFQeCKqK6P3FetSVaccQy+C3oZvzO2s8IiC5EK63W+kh4N9Q7oR6nQpd
	mWWZCd18/yTHZWlfcRQgARerbbe+otVRpfBGl5xS1SQQ8j+sLCf2lnbDaWw==
X-Gm-Gg: AY/fxX4qVdNx+MkJoCJCxa8O91/zaYu/58eYOyuPKeGfPTDTJ3YH+l3DBik7aLQOqGg
	b8Z8veT4aqQUMv0xjaikJ+OQwvsn3S0VtEJA5rL7FXq0nBHp4gfYjkEIg7I4jWs5GDdcLLt+sCz
	Z+dKlYaHbG7RkSsJmqJimzYq8upmsI+ev/KpPjBQnN9+1hme+AXai2nM+ZqzKgccevAEmjLdsYD
	hsgYdHacs518W8udx4awoItubIr8ADiX8F7/Zy5j5Wmrf+quLUJIf+/hG4sCGz+sAezp47g
X-Google-Smtp-Source: AGHT+IH1LByqW7ZLrFp7glgjZt3g2J6ITYVw4T9fJNyN01hTZ7xZ2tadzEjfLG1sesulQCTiO3En4id7s6uBsJYgxU0=
X-Received: by 2002:a05:622a:1b8c:b0:4ec:f6d5:ee46 with SMTP id
 d75a77b69052e-4ffb4af497fmr48506811cf.78.1767828748846; Wed, 07 Jan 2026
 15:32:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106170547.832845344@linuxfoundation.org>
In-Reply-To: <20260106170547.832845344@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Wed, 7 Jan 2026 18:32:17 -0500
X-Gm-Features: AQt7F2rjHXXS4VwdsUEM_LyelKMet1mu2lb_KbzqRAyBq5WcDAPhpkZeVFckzz8
Message-ID: <CAOBMUviKjNiTkgvipUTVwzwnKO2-1RoAc+uxM+uwyRSceeQHHA@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/312] 6.18.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 1:41=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.4 release.
> There are 312 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 08 Jan 2026 17:04:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Intel Core i7-10810U

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

