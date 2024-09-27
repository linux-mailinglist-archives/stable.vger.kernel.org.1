Return-Path: <stable+bounces-78131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1BB988891
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 17:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EDE61C20D46
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 15:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C371C0DFB;
	Fri, 27 Sep 2024 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFeghKS2"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD7818C021;
	Fri, 27 Sep 2024 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727452387; cv=none; b=iphCcf/Li74UeqE4Yl3dTnHuAvAewB8KBINquIWVNLYiL3tBhmm69pVLlCOtcuBzxr47TS98yYGSVy3gb7BRto3fEc6HMRYsCa/2TPZAVSpfLYeiA3CCKLsCspny0b+rCurx56uAr8rwCil5jrxU3Mo8G+98FLHnVGqoCrgfZFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727452387; c=relaxed/simple;
	bh=mjGIhCqeh99aX0Y0fr4FUsgwcFlLw+CZQnGWXM90iBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqaXJmDxIi9dK9ayavrfS3lUflATzk7pSKTGBQJYLkxoh7QV3OOYPVapAEaeDZZ3/Q3YvvPcrzuf0OJwru/AOlLLhFOM+mSeWroPM35QPBSF0rRfLHZPlYAqVi7sj4HuW7lP3Hm4HN7dkvgSUwn+zPChZnqy/ZhwLz8i46IgP+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFeghKS2; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-49bcaee2754so715157137.2;
        Fri, 27 Sep 2024 08:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727452385; x=1728057185; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4BiMluZUmH1JGlBxZinaGp4urWPsU4oh4J8N2PfMdr4=;
        b=cFeghKS2aogNQ0qINGAdcxTy97FU0RsSNRbZV5oghIVoWtDmEfe4W9IoKckKpU1E+G
         8Ymi6vdCNRv0pqKD3DRrBlI1S0TWgnV5sXfX92SY73VWA3rPttffau3bUitb2LB0gGGa
         EFHKxotrCR/CwwrUPIUYZndQbIyMZJpGa15jC9MZLBwaqwnKUpmAMRHSLnDXAejHKat+
         M2JYXok5FC1y6QREFodvdM7b9e8LOkjCaKsmzjy6GKpjZSWBtZU93uuAuX7X3rquQDXL
         ykC9CiRiZXjzCkqEGqgEx3ADew2ijYiJO/pL5knYWa2a0Bef49c478QIre3sbCoIGuy4
         1Abg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727452385; x=1728057185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4BiMluZUmH1JGlBxZinaGp4urWPsU4oh4J8N2PfMdr4=;
        b=h8cyykYibroiK5j6NA8ZgHpbTrLnFs/cjzrDBrWGRSKcNhFNX7+XjhVjPBeRJ4MVuB
         WQ4Hy8TkYve4EhF37QeXzuGNWhpOhhgxCqaRZ6X+r9pQ7txgjzK/QwJW22+8fdnQ70Dt
         LC04sEuYuo0KmwmXyvirGWJoUpyWsV0GVNle1a/iLjYD/XaZASn62KqgGu/XOk5FRgPW
         4XXvmZZ8BgprHUms5JBqLQL9yvK20Im1P5r8N1Hi2RN6sSJhCUTohQKin2WHoxXJ8Z87
         tPvW4xN5BSCIxZNOqvDlmQ8W6Sj+VbUJa/rb/+6ppp+qvqnK8WAuphaMsLJi7Pxc8p0t
         sM1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8hHkd/HWpnE952TvBuS0B7oQZ7Ho6w1ZDrqv8KVajHsH2tTm29ehGK0BA89L8ugXeu216mIyn5dv+2VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbB+ZFUDU5MboafO2HxGxSQyFazyFORStZkEpf2dv1DXKU/Znq
	pKZ3iWskOR8+0vFZLoxBzeizd9VoSnPMLQmUp5qR7jMkQvx5EPbK2d0pT2KU00wlxsaSpWfsMP7
	u6GDY/5xvGS3kNmVYl3U6vCxi4MM=
X-Google-Smtp-Source: AGHT+IF5LtoCyQonXFQos63YxjWAqziR360Po3cMod+Wzt0mpCqneWqx47LlZAcAKVWzNjcZ1JM3nDXlSzixSss2UtU=
X-Received: by 2002:a05:6102:3a0a:b0:49c:1060:78b5 with SMTP id
 ada2fe7eead31-4a2cefee0famr2889730137.4.1727452384622; Fri, 27 Sep 2024
 08:53:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927121719.897851549@linuxfoundation.org>
In-Reply-To: <20240927121719.897851549@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Fri, 27 Sep 2024 08:52:53 -0700
Message-ID: <CAOMdWS+OW55rWa4FnHgVG0wVFA5TB6Qq-auLC0ty5dUMHLBnOQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/73] 6.1.112-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.1.112 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 29 Sep 2024 12:17:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.112-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems.
No errors or regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

