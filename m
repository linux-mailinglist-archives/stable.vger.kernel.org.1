Return-Path: <stable+bounces-60462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10B49340E4
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 18:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68CFAB21132
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 16:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CC11822D1;
	Wed, 17 Jul 2024 16:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ms+m2l17"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431451DA3D;
	Wed, 17 Jul 2024 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235592; cv=none; b=a1zu+zZ3vLv3eveFun9gm6t4PcnoQ+rlKCrEtvbR6VAPDS3/TQKjKsZH0cXnXA1eNeZRo53tZ4TvN+XTFBR4D4qaolhhuDpuqbEgADhmVFFet6TgMX+cHidlaKniOjzPKBy4v4gpZLP/KPicSyf9N60WSWwl8MDBk15YwJRNr/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235592; c=relaxed/simple;
	bh=mxNwzUHCOG9jYGJTYiamF9b2tAFA/BIcOgkhYSfa42s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DrSPsNPaMEo6IXwC1NqOKzdWDg8DGcrSIofic96YeX67aB2P2r4U9t4tjm9+JRdBjC8A1aw9n5vuIUaq+tD/0G8gjQm96v/yLHyGXsprKXqwyzWN1yc3mxVm5bRDUaReHxwo55AoSwHV/mVfBoiejZbD/qhTfZD0bWStrccwFOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ms+m2l17; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4f2ec49e067so580039e0c.1;
        Wed, 17 Jul 2024 09:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721235590; x=1721840390; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tHQtXLMNbOp/9H52ihtJZHtD4sWGknd/z5BrAPl4dOI=;
        b=ms+m2l17h2bCayWH2Iew7Q7+pfaesy1IVRHbrnX1XUE9Gz6pk0PO6LWYh1ZWPn01Pa
         wtp2dPYy4Agr+gRPVEgU0B+pdPiDvwRqvHM8z6AsK+SrTrx3qH0Z9wZZgmRlUlU9TM4+
         U3zHvxaNxJocncAvnDK9F05ckQrsoFK4fWkwGIkglUhzqU9HLrnBdqNU9LiePCEcJCmC
         awAhE3st/N/Sp6O3NHx5Jq+pH3oXVzJ5unbEsRx60PCWQYZF7DFu/t7HzXNPxVCKQl+Z
         xcqO8EBEclWmrNpy2L/u3vLXHGkwXa/gDktiN2iRnZxqzlQbBfFyIDSDmfKUfifCk/4R
         upYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721235590; x=1721840390;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHQtXLMNbOp/9H52ihtJZHtD4sWGknd/z5BrAPl4dOI=;
        b=TiiY6uoEhm4RvtCmD1Qzt/SfcG/XvN36VDDQVz5rl3/WYuFYI3srji6KyJLV721NHd
         1lwRhbSvXDzIkeonizFN1we3xoZfPXgFiCvG6zC16ycdbI8T6VWjsOyKyXqrDoIsYnPX
         QLKxnxdBOM4MRtjEfYtOATP9dPq08yFRuFZjWYdKJlickq0m/KT7vSZCnjobkUD+Ri/r
         Eym9nMI/n2qBqeKNC8LHfiqMvn4XIA1PV/V4hIoo0QFDhkWN9v/JqZyG/+d2U/6rwTkb
         Rj6U134JifUvbKbyTFvwIXm0Dqo9xo9252r9NiEk6RpVmATZuDn5Ma2eOyYM/yWvXeWp
         JaTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBznCj/WbGxI1zdk4vWfGmZS9ifErVczu6LRuQVebLHnIlw0+fe8ii4HLJAwHyeo6GiBrR3xesL8tGDa+nJ1RVfu174VpPd5E/9FI0
X-Gm-Message-State: AOJu0Yz/YNgs3vCyUnyns0KBO46ZtroKXTOh24Gv+zC7tfNoNxrxNSHG
	aXPA/p6F+YtoZ6x5LZVea+DMJhSpIRUPyI3XYVhH2mpNQj3R3tKcmqPhXxu1VP2rPadbG9VG1Je
	qlshdm/rS1pe1S4+CfkjxsN+nN2c=
X-Google-Smtp-Source: AGHT+IHfsRAQUUXXE1wVKkT+EW71tx1zW1Q98QVJKjrnenc0Jn0VhG5UdoXJfWQx52l36Oxp2F7hJqwE1iLxkKVV38A=
X-Received: by 2002:a05:6122:d03:b0:4f2:f29b:d281 with SMTP id
 71dfb90a1353d-4f4df8ec4f3mr2686360e0c.15.1721235590186; Wed, 17 Jul 2024
 09:59:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716152755.980289992@linuxfoundation.org>
In-Reply-To: <20240716152755.980289992@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 17 Jul 2024 09:59:38 -0700
Message-ID: <CAOMdWSK+EOBJwWrCFJP_+=A8guA0Z_TrOsBc3M82QMXbO1iseQ@mail.gmail.com>
Subject: Re: [PATCH 6.9 000/143] 6.9.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.9.10 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.10-rc1.gz
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

