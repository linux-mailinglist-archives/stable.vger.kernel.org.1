Return-Path: <stable+bounces-176519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6856FB38745
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 18:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EFCC16C3B8
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 16:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3902F3C0E;
	Wed, 27 Aug 2025 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="k0tCVVQy"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3FF139579
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310664; cv=none; b=GvMiBo8tDAokionwwS/p2m0F/lVE6cdQTB3mZtLiDTWQp5MLMgM4FG4IiNDfpCvawKZfffBO+le3UfCescGTOX2UV9Z7O+wFdOKlbwuCP/S8NSsqE7JulvHHE2VqN+RX6utv6OMkkDtC7RnQwHNIbXmQaqYtGD6TcH4Xv7gZzc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310664; c=relaxed/simple;
	bh=Q/95dte0FRIox+Mc0zMjJdCZnOlDTQ2BO+SbNB3I05A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URMUqqo4na8k+17vj9ynj0PwbNY7VMsM1C7L1Hu6yVOPPTzTm4YoFTbG1qr7Xm9WEOWUZCvejLxvNqx2JovV0Ocn/QLNzQNEQZOiZhTP3bUM+M7dsGr5ZMsTNLoa8Uq6MbR4fZqa8EMePkM9o5MaU06vD3bm78LzNXB62v3SCys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=k0tCVVQy; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7e872c3a0d5so8941485a.2
        for <stable@vger.kernel.org>; Wed, 27 Aug 2025 09:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1756310662; x=1756915462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0O01BKWKJMhnsa1JrRHWzprMGs/4GQnb9M6HdYZRlFI=;
        b=k0tCVVQy0BGT6v/j/4Wz4bqPwb6y1GeVaDRqfdD6Wsq1/XWRD01/HSQa36nE/9s3vZ
         dM79Nzco9S8w5llTw59rPgFYaVpC8ZYP5o7cdiQCT/bTxkoanLrWQcB+qqIMhMq945CU
         H4XbQpc9ZzDhm8H0nPx0kH3Z/jE1vbtQMpKJYzUDkOsPFLp0lFFiWarjaQH7Gdnh0Uua
         5WVs2/riy0EdVqJf8YkQ4caX1sce5MYfp/q27JUChJyij42LHiynyZ5wMgSbWmM2En8l
         HiOXzlRtuiWAnzW5kBJS4SVUrEtPAkQWXLFJnpy2045H3SPi/XvZum+ea97ORmk5ndW5
         XKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310662; x=1756915462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0O01BKWKJMhnsa1JrRHWzprMGs/4GQnb9M6HdYZRlFI=;
        b=nmO4DKsE8htmBVRtnyY4bx3zd6lx38UTBbVya6spZOk7zI8JKcG+17CX+2LefZoeXA
         E6NWb7by6J9454+VngOFloYQ3XQUpFWNGOgA4moAiXe+PMpiby2yQgrJxVEab+ui9qPe
         3tZcX8lxCgf6qRwARaiEnwY/tlmSW7vAxLJX9i/HnL/3xMbmSNLFxY5Z5sT6dBj1A3bF
         h5l+I70XfdKgRNv/FCl19cEF1Cry7DAV9kcnEPKxGPRd8y2awppTPJUOoZZx71p6USNg
         3gPdP/LgkTDLV78pZ83ZNqkPU6XCo5HSr7+hE9g0IY/jP9jNrjz2gg8AmTKpXsvX6cE0
         B0Fw==
X-Gm-Message-State: AOJu0YyeawKIq3MmlJAQQs8hMuAS6SODA1d3vrMnndEP4kwRiUhmw5hV
	/cZ8jd0MNUzy71zbMFDJNAQ9a4nExXhiQdF+nOf6IoqWtREIer2vXeyltD9IpQ0HWiZarvFEe33
	8yjHeyJP310yRImDNucIONfUYIiwlHGNHIsLLCrIorQ==
X-Gm-Gg: ASbGnctj2OmbEXELxl1cIO3ANTuoSh4lr6eOolIC5Ay6AXKdMLDGdjdZ+G0ujY4POB8
	0ttx7rpqbKfW1zBvvi/OJYkYfBAfgUF8pS3Ig1Tx3g9XorGim7+UYb9ckOGXf+KUBkzlGpmKJb8
	afhCSVAan6ZRWrlhAyUaPdxNXyTz3/M4wdzh+MrMapNKAXMnozYEjWMkyEG77qovRdUWoyxiRRq
	2kQAQQt
X-Google-Smtp-Source: AGHT+IFs/mwXa9xjC6cm8maRYL98DbbuhF4eeMipGDRxTRqWXTH3hzFo9Xw+umP930+5MgqlefdPLnRTlR8sFlKKbSw=
X-Received: by 2002:a05:620a:171f:b0:7e3:3065:a6b9 with SMTP id
 af79cd13be357-7ea10fc7a86mr1947926085a.7.1756310661271; Wed, 27 Aug 2025
 09:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826110915.169062587@linuxfoundation.org>
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Wed, 27 Aug 2025 12:04:09 -0400
X-Gm-Features: Ac12FXzyI1vWTwS2g7VCl4GpPis8V1-XUBHCDNtNCGs_MU3ZX-OEWDTPVk7Brps
Message-ID: <CAOBMUvjsdK4G-eDqQksd2Nguuf-RmdiY7vmkYRLDrtPpwk5rOQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/322] 6.12.44-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 7:13=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.44 release.
> There are 322 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Aug 2025 11:08:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.44-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Dell XPS 15 9520 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

