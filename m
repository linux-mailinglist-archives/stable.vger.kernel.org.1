Return-Path: <stable+bounces-46180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D1A8CF015
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 18:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467DD281789
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 16:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9B385297;
	Sat, 25 May 2024 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRtWxuel"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A310C4EB39;
	Sat, 25 May 2024 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716654294; cv=none; b=rhqc0zCtPZ/Gy96XSzV80RzTSerRJYg0Z6IobGVaVMzDA/YMLUgv8Sr+nXJlzs+8eKdoLvao11esWrdSoc0JJmreRVbngIYuIU0ekI34elKRDm5xbEbrGNsBq0TYFlmKAGHAySPF3qBmYegfbgC5hi4CbpSNbukxC8ijih/500A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716654294; c=relaxed/simple;
	bh=86AVJKuhdZUAYzX2g6oF3oFG/tJCgWUrWARGlNXmoc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ARU8iMi2fiRionkKRYhEEeXKOzWQVCg7FaboPUmwssFM4BgjrKQjWad59z7KWq54u60RON/62kKLSe+78EDGeR8U0frrCBCWLXtTykfoSlP/qxp0cFJg8yOqFG4UmEtyqdYcURtjtiLWszsCXXg9BVTojH4zRq+ODLNYhPSuQ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRtWxuel; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4e4f0020ca3so685437e0c.2;
        Sat, 25 May 2024 09:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716654291; x=1717259091; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C10eo8thbRqiep/D1Jvta7yZisLgi/lEZwTUZMNg/g8=;
        b=DRtWxuelcgShaZiAb3YfVcBP7c7RhEWfzKUZcsyRtwF7XXCB2vgVXKtspYGLiOGIBI
         kaQ0d5HYu11MN4dppQqlwV+JBS1UN9+UpgT1xWRTbzxYdkyN3EYMHlR9BPIdivVk2dNG
         NPPKCI2tMwrhWSj9HyOeokWCuOoTygWwh00lq+6iY+caQ8zABFCIYIT9c5buftO86/Yd
         xQT2nFUkiH0e0kO0r0vHFuJRBTCLoxqP9qiLcMbJcoXc8BPOuw1WFbwITeGX1jZo4z4v
         i3AdSPb3ZCGdB8lzM9VDCH3HSwPDOjVzM8GYYgA+nVygRJsjQG7Vn/YoactCMlTpWvr2
         +u0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716654291; x=1717259091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C10eo8thbRqiep/D1Jvta7yZisLgi/lEZwTUZMNg/g8=;
        b=I4rV5kpw8ZYnXcVYDh+t5DZI3yBRIDhN6NWqrdRFG2NOqFJXxyZIW6yrwuJ6XL5N9I
         yBBBfc1TUEjbknGwZRSKnLTLmmOot6RYINn2QrcgY3pjPQNdaHZlhWOaBKc9H3LUe4B2
         9nqCa8JHUtBI49kYkEtCBlJSTNeeYHJFwfpS2IjacWfM1naL3Hed+lzwbB6VOQ7/H+Cq
         HcLP2aOvfhaUxvjaT5VZmx9hwwbAagyZvbJGpi8lZEQt/81lO3bUcUFj8gW2llmKxfMN
         gtFjYu5SxBAMPQvDSX3pPgWGrfhMqXmDw+va1yNiiNcOH32AODYMkRPJOO/+mfL9D5XX
         t3NA==
X-Forwarded-Encrypted: i=1; AJvYcCUmQgb8f2tQkcmhvoAF9WIjX9jiIMVsF8BHnRCucAiZRnA3ZS8T6SAp5oY9APYM+jgNvARMScPgVNgYAyx1Tu2x/BNXRC12/R5dMfUR
X-Gm-Message-State: AOJu0YyZydd+ILmnZHzxFKrJB7qpe/dTO7UH8OgYLpstox8mWUPJ6DGB
	ObR6xzBWyJjvcToQKKuM/q5isbahdaeaQcI8GL4xODlzddnWvNoEBsLS6ZtzQSo7b0/Cxkb2waw
	8u033A5afe94AWcgamzWcNMeADwc=
X-Google-Smtp-Source: AGHT+IFId4xEaD4/ofxKGNhKoPOyE8jZ3s7P0t1ilfqVQ1iQY6jvQOmdiFltbAST5U4WtGcX9TQp6jPRC5eHIOtj9zQ=
X-Received: by 2002:a05:6122:3114:b0:4d8:690d:c02a with SMTP id
 71dfb90a1353d-4e4f0230564mr4693418e0c.6.1716654290006; Sat, 25 May 2024
 09:24:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523130329.745905823@linuxfoundation.org>
In-Reply-To: <20240523130329.745905823@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Sat, 25 May 2024 09:24:39 -0700
Message-ID: <CAOMdWSL+_5+nq2ToLsyW=92u9uxWVL8z9Pw3=_mp-KX9_rwDWw@mail.gmail.com>
Subject: Re: [PATCH 6.8 00/23] 6.8.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.8.11 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
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

