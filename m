Return-Path: <stable+bounces-45352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 143D78C7F32
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 02:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2811283863
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 00:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFB01392;
	Fri, 17 May 2024 00:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdWqWZyX"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12790186A;
	Fri, 17 May 2024 00:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715905763; cv=none; b=Z336qRp87yg4Eb9gxCZZGXtrB8IgrDGdyTuWhwjYamNGOZqkGJr74tvAthU7xfit5JX66S1O21Gc5gBFq89dFeJSFRU5PBuabl3xmKrhdwJiiklhc3Rl0B0K4coyuAxgugQIxi+Y02KIFVNtJG7AkWDjcW4HcLe0tkMb08J1jg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715905763; c=relaxed/simple;
	bh=qpRGtEbcpdaiFAoUh1L5jAnGzbs5qHszLJd42Y9C1J0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ji0tOSavIz370L1Jizq+dOpEssVMK7x8lX06akTqd6U7LfP/6wp3GN5IsTItIct9+i3ckl48u4Ay3oBECinXRta1d7qAzEPoIuDjEreEIqZB7GQPfADahUcUAdLvbqZygwp4EWCyXV2MmACCy0vZ8BFtQM3GKgbODZgodqdaVtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdWqWZyX; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4df550a4d4fso41733e0c.2;
        Thu, 16 May 2024 17:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715905761; x=1716510561; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UcA0xx5hZvyYeOO7QDNErhgsJFWGZEi2aPcF1osbRvE=;
        b=QdWqWZyXDDo7f4BpXh8yjFvP1DKNlu/nmk2VTr8HkAVd+3Zq+xVTPIjqybg6Xnf70Z
         0VrdNeMIyzXYmVtEYkqN0ZX0cz+wh0QCQ3OpKh0eSWjB5XwaFwikhyW00/u1k+pZzw7u
         bxOoM85m5BvNC+ZSy6NvyQoi3DeyXFwr5PB1PE4nlchwHxNm8ItDEfvzUR5Dkt2HRBtA
         y850uYUq4OtylQ1dUxj6MpQu2UIL8z/fqPC4TZkLZfKy0BD7R82/rkg2FDkEKe6I733b
         dBEdmAkLT/1Q1tPAtRNx8u/zME1Wg4LUea/gzZ5T3f4iU6T8Sji6U4ByGA6X01oXgN1L
         KLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715905761; x=1716510561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UcA0xx5hZvyYeOO7QDNErhgsJFWGZEi2aPcF1osbRvE=;
        b=tb7qJqmGuuW2wKILMBPCxo8Aq7HJhIofDCEe4dnlZMMDU1ryb9mzBKpjvehphYUW3T
         5pcC60ZEdwRD+Z57/3iZlwcptPZP6eGId2bX3pskY0aJSExWLJUEmYdww8LLkNSjPPua
         aEjlT010SAcbxLT2UbBDeRIop4El82CIQ7RJHWXlxluujq18WJspQUQ7aiJx84WNAXWZ
         +cad5eayNfmsE2UsWYPUzzwq5upRFXV7DwxALkyKk/5FMjYm9PN7/azc8jIgz+1SuObU
         3hrzHQZWS2+xvl0dPK5R0okVBZ5hEqT8yYRTR3cdO1YJWYcC6JsPh0dXkieGQV+tJUGl
         yALQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2DsGtk1UQm2ZwgqC7D1smPRWQMMWayKyPyCW+kaA5WtgD2WvCknOQu8qrv1din9jztlSZ1J3IZ/t2H/uWJRCXiy1NJHNAmEw/Ppii
X-Gm-Message-State: AOJu0YzTCYUu/+mAULpdxcTQuqvNxY5BWbcM0vE4pMjqSogf6KvNsea7
	Tg7GEDeWQyDq1meJEqVf84JThgnoOhVhQfQzfgzyhORLihl8hkDy9OmdAyAwHMWNSm8RahdVaQ+
	UewZxTVyco/s/89yb1HbxAs7UTms=
X-Google-Smtp-Source: AGHT+IGBWv2RO7UvUkrIOEyvNrZPRRwCwnMeoLbFJHWoecfdbq/BpcqbfupXycmKxAjvQ1hAwyiRkTW3CXYeTRzTduw=
X-Received: by 2002:a05:6122:d95:b0:4dc:d7aa:ccf9 with SMTP id
 71dfb90a1353d-4df8834b383mr18148990e0c.12.1715905760942; Thu, 16 May 2024
 17:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516121335.906510573@linuxfoundation.org>
In-Reply-To: <20240516121335.906510573@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 16 May 2024 17:29:09 -0700
Message-ID: <CAOMdWSJ01-cON80thPRnoCdDqyNwo0f-HpF=PaScytwLUnuZyQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/308] 6.6.31-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.6.31 release.
> There are 308 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 18 May 2024 12:12:33 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.31-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

