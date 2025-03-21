Return-Path: <stable+bounces-125751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 360A8A6BBFD
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 14:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECE6E189537A
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 13:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F075E38FB9;
	Fri, 21 Mar 2025 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="wOkiygT5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1913CA5E
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742564867; cv=none; b=RS/lR2JhxR8PULvKWYMGCCebel+KkBb1asCQ98/DSbuqIHio2JaLp2QqUVLusWmCFHCM/lceZYHlcyx3nJ9DVeA4rv8tBdG7O25d/90Mf75lXJHQqxEp+UQv+0qOhCdspdfEvCmqbJ/Y5a/YDIKhJ0DTDOXAbSrtP+sFryOPQDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742564867; c=relaxed/simple;
	bh=zto+hD4T8Rl0wGhIV/0xoa9IwhY4ZDqaQa3d6Xj1HKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGiNdYjoNbuqt4cs1lsmMs9VozcDCdlJbN0BbuZYlgPdG9z0sge0d+vGd9vECb/y23hCCcCH/G3FXSbszk1U/BN/03GBTc/1Tc6BLsCUdVtwoWr7KLlIeku/2kkGbrfnRo0c8yopgv2u90HqM6npMWvuBEDgPE4xdgCeF5aeKjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=wOkiygT5; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3014678689aso2886410a91.0
        for <stable@vger.kernel.org>; Fri, 21 Mar 2025 06:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1742564864; x=1743169664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8nQgLdmlUqdr9aYe+VPc8RjHS/d3j/W4qOBy0BpvdI=;
        b=wOkiygT5XK5gKLnLsEQp3gFauTepjz0CUsmqpUhuGOX6J1HoAitIm6bVkqJvPYyRDZ
         d7NmNKOMhXFHp+Z+rIh03cr6VvB5KU06Eho0GISuRUToruQoVUordXQxM/wcDWNXo9Hc
         XKEPj6kcWHFm6aM5Ojp0gtR5Ys7xZXQ3u1xmtB5xj7Lxsv5LB5HpdA3cEAZTNd2qqfou
         1nkVoTz9Oq9nPsy78OpjqGSzmDGN0XvK3+ejAxjMco8nJwC73E39Vq2vCYM2+q7qyjQp
         YYqk/AHZ/C4aAWTwrxXgF5NcdBMdA80IVJEbWEtYaKPjhSZCpUg9K6YG340r/m593ygv
         KHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742564864; x=1743169664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8nQgLdmlUqdr9aYe+VPc8RjHS/d3j/W4qOBy0BpvdI=;
        b=tlugGXFIvsOKNvoautXw6dr/oGsOLqFE5DRujfYwalCYJwU0dsLiWYz60dDRxsWlDr
         FwmIcDCCkw/d7hiDcpN5+zpaXq1DRLMLX0+hoeJpd1oH+liY9qR9qPyKHAwmb5Maw742
         VRQfhQZzG9RDV9ZOnDEWBvCnoYoVFeA0oQ6bUfbvYQ9WFKdnXqGbcvjHDDntdgCAgjTu
         +0eEC32DJ9VnnVeFKs2SKSNUoRWHEivwUjYSt9Y+OhLH3RRDyH9EtBZw9xYoIi1l9KA3
         v48tgJz592fkLIFh2S5YV71EwHHk1L+LdO4Zw+402olpZuxEUn+MJG4cF+ijSJaONUr+
         urkA==
X-Gm-Message-State: AOJu0YwAkDtDtaY80+K/Nj8QWUnvMx9LdtQbZmb2QeTKg9j4fx9P3pm+
	Sko1c9G/rApI5ArPr4vUKhskeOsmtxs8cmRs6EYvqmLVD8US37Q+awQ5JpOv9yGBOM6xoQfupoe
	nbIFnkS8+tebhcTt6uZibT7Q/RgPK+tcYPzhsRCFKZtXcs+c217zD2Q==
X-Gm-Gg: ASbGnctAbkfdwmchVVSlLuGUOWPJZFvi2XyCSRgJbj3Y3uFECXA9g1KMSgtAMIiX+vh
	VRhzZTlNnRwh9vyeDk+CWeWL/g21TWp5yYoj2/h9FmtkHFESKlj0Aam53zS1gN+WpJilZo6F3Qt
	EDbQPtXDmKifBCcpmdgJMCpQKDIQ97Bt1j9Wa7
X-Google-Smtp-Source: AGHT+IG9gHzXZS2MDHa4IE9fwTzJ1H0FhHqAo4iMsZRn/mh9NpHgxYoGlNF8O6uvXxiYLj+Zs6L/giMBpxyi7SPgYGU=
X-Received: by 2002:a17:90b:2dc8:b0:2ee:f80c:6889 with SMTP id
 98e67ed59e1d1-3030ff07367mr5795406a91.33.1742564864003; Fri, 21 Mar 2025
 06:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319143027.685727358@linuxfoundation.org>
In-Reply-To: <20250319143027.685727358@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 21 Mar 2025 22:47:27 +0900
X-Gm-Features: AQ5f1Jq_-0xkKqLvecUc-RyuF4NKyutsPZK2DjPZzNY6v7pHHsBsKKACW7x7r0o
Message-ID: <CAKL4bV6JL0A2eqhC3wkppUyJLEXfTZW9qqVOHnY4p4qy8zLjAw@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/241] 6.13.8-rc1 review
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

On Wed, Mar 19, 2025 at 11:35=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.8 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 21 Mar 2025 14:29:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.13.8-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.13.8-rc1rv-g14de9a7d510f
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU
Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Fri Mar 21 21:51:52 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

