Return-Path: <stable+bounces-160525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76311AFD00A
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5581C1AA0339
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FAC2E2EE5;
	Tue,  8 Jul 2025 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lkSsGTs8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85052E3B03;
	Tue,  8 Jul 2025 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990728; cv=none; b=oioaNKS1PLLUec8Qjm80prbncHC9ezSwqNYYMA8viBarrD47OiFn25WwCQkjOwFo72KFxtjX3OBttTWmxn3ESdnqS6P7oFnoHsxofBOUTLPqO67SzxbctYyrClk2ff6Pwuc8UyW4yfY/iYu7b3V5PGd1Zj03NRCkW1k5ruYnar8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990728; c=relaxed/simple;
	bh=njlSf049HgeVwS1qYFLjUyYCR3cWn88GL4Ar2RuTuFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0tAw13Xyo/yP4LlvxHdNnOiR7OehyMujew/9LWYTRoFlpmJIB9vbfTH8eGCkzMCM55TidUGC3O83tftICKLw9jsFy86N3IhXnF1wHmhhujorOjw3bfC+x9Sqf9sBP1h9q0WpihxHpWxen1ICtpwYFk1nhH+lwVVf4CewWSHUws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lkSsGTs8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-236377f00easo58381525ad.1;
        Tue, 08 Jul 2025 09:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1751990726; x=1752595526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcrq9Px5GbWJiB5AxSdJQdkhbTPu1vrVrShHO1zRmfQ=;
        b=lkSsGTs8bVNFWDMwqA1t1ZfI8sOrmVPsdehssUlymBUmd5wyuagntjzRPG/YL7It3/
         SsF73bSyMaXbpz7uSNzDYVS/p8kN12QLk8IwxKWEJxuXOzElE58KsTepQlDMEm5W+00k
         n8OH3f+1PE18X50Zf6qquQ6h2phQNCem0GHRCngSUBV3SITEc7Io7l1icUCvcmYS82zY
         RxLxO+bePyEFIl7MueV5LZ6tkh6lHBZL4RdhJAd3tMOiLXit0SvzQGGAcw0wTRIHYEQD
         vOP9JGXMclex+EKF8kTPJorFXPzOZMYP48y6iSEbz7OOF/V7I2CXW4+HP4ah6ftgkFho
         5BFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751990726; x=1752595526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcrq9Px5GbWJiB5AxSdJQdkhbTPu1vrVrShHO1zRmfQ=;
        b=AC0bGN5Umur7QCA2hxcZpOx9bWTbvLAFVPhRznwKaPEl5bEC+S4xhRLTJ/hqgMRzHt
         GHa0vAoeBHXENIaj0ONazjYfK8QAC2/7Quit48GKwpFKJP+M5wE1pfRZplGCtpOuPfj4
         +HvP7fn6xX/SsRxXz/sPMLzKTNqvYzggRjN49zljm7glyac3ksnrro3NkgQUwxeLIlBn
         YlsnesdDyNJALRuMVJAGOVz1NsrPaXikMPpchcVGxAXdUQIbRmAhoVjr0wcTQt0iVBwi
         INATL4breelKcvQl20juLBvunxqOeL5T7H2z43Ow3GENX092MU1YgLuaN+4U/anRUM+Y
         1M3w==
X-Forwarded-Encrypted: i=1; AJvYcCV8mcV8+Qey2cISUJUaS1F3RmMc6o3k620AwLblWdwr+zxpPaJnzsdgJ0d4Pk7xqUcU1K5hV5cd+XuGPC0=@vger.kernel.org, AJvYcCWcQLYn0kj4SLKbx5ZoKr8M9zTaS4vMYGGwwKhh2GzUqwjp0H1S66ZAaY5n3yojfmsaM4Ka0kxe@vger.kernel.org
X-Gm-Message-State: AOJu0YxDUyaS1O9mVHIc18HiDMCaVRz4H3Gt8utwHXWyQhVQ1uRPN2+D
	aUF3Z00rwbCautoiEG9lzULIDev0vkMBgkIzUhou4PneWQxXqeGYQ2pUvobu8OMZWmwECC8SIeP
	w4oFvUG3Z747nvpCmDeaPwIlre1pBi+7e6w==
X-Gm-Gg: ASbGncsZESPWkj0kGxH2oSFHrDDoZP3mUkz98OBUe5X4GwliYozGzy9Ow+kN49AhTXj
	czYfW8oyVhVH3++Fcz8i/u7wl2S2Y3JUv8gZRis9DEKjxZ24BWrJzHyzJUtsq/Ya+VT51p195C8
	uNIJArpuc742MerEjnI9gBLJw2HRyx9lofllNVcWa7oGsiLTQyDJ0lxGIWLGeza117XndvWzB26
	P8=
X-Google-Smtp-Source: AGHT+IEKVOlvfwl4eeYBuBVlq9Q5WesCQhGMUTJNOVwhBmexAudJe11ZvEDS+PJxNLKpg7tENHSnBWeB5BP04yZ+yrM=
X-Received: by 2002:a17:902:ffc7:b0:235:f4f7:a654 with SMTP id
 d9443c01a7336-23c85e2be38mr294917555ad.22.1751990725856; Tue, 08 Jul 2025
 09:05:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623130632.993849527@linuxfoundation.org> <70823da1-a24d-4694-bf8a-68ca7f85e8a3@roeck-us.net>
In-Reply-To: <70823da1-a24d-4694-bf8a-68ca7f85e8a3@roeck-us.net>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 8 Jul 2025 18:05:14 +0200
X-Gm-Features: Ac12FXyLKp-u4KETpYgI7t1oSJJS9hnhBb6_II1awELD-8NQbOBh3d0_lW58pb8
Message-ID: <CAFBinCD8MKFbqzG2ge5PFgU74bgZVhmCwCXt+1UK8b=QDndVuw@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/411] 5.15.186-rc1 review
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Mon, Jul 7, 2025 at 8:05=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> On Mon, Jun 23, 2025 at 03:02:24PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.15.186 release.
> > There are 411 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 25 Jun 2025 13:05:51 +0000.
> > Anything received after that time might be too late.
> >
> ...
> > Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> >     drm/meson: use unsigned long long / Hz for frequency types
> >
>
> This patch triggers:
>
> Building arm:allmodconfig ... failed
> --------------
> Error log:
> drivers/gpu/drm/meson/meson_vclk.c:399:17: error: this decimal constant i=
s unsigned only in ISO C90 [-Werror]
>   399 |                 .pll_freq =3D 2970000000,
>
> and other similar problems. This is with gcc 13.4.0.
Sorry to hear that this is causing issues.
Are you only seeing this with the backport on top of 5.15 or also on
top of mainline or -next?

If it's only for 5.15 then personally I'd be happy with just skipping
this patch (and the ones that depend on it).
5.15 is scheduled to be sunset in 16 months and I am not aware of many
people running Amlogic SoCs with mainline 5.15.


Best regards,
Martin

