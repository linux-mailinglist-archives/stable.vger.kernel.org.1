Return-Path: <stable+bounces-49905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E501A8FEFBA
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 17:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CA85B2C235
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584851ABE4F;
	Thu,  6 Jun 2024 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GE9OG3gr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D27B19883B
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684132; cv=none; b=khm9Xge6xwM2CcPFkoRQcGzS/b5B3MPK7JCswOl5u0Fh8q2iudjnl6sbQclauKnpjHYg3T8dxYh1OMpsHfpZzCpYvws/Xp23Smzf6lyKVVfUn7oZAAz5mdunlgljBP45qORKlefMn5Ky+Y1ohdT4GxesNZCGOAPGlglG/YZ7CVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684132; c=relaxed/simple;
	bh=SuESpoipjH2XBuKfLdMHPYPL7Cn4gPPdzQBAHmXOeUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfTP08YjEsQhIgk3TPy4iinbf6JfoAyCdOUQJYau39WJ4cqUrNn4Y21noahkis1GJ6qikOHvhtnwNWmZbMfPO1KnxXmyf4/W9HU4hRD18zGXFXkRQEe4h8TS/ozR7fhFOJpFx0KnGDzQzEkC5mRMdAoEEY1un38gV7X9eoeWZKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GE9OG3gr; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a6985ab58so663327a12.2
        for <stable@vger.kernel.org>; Thu, 06 Jun 2024 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717684129; x=1718288929; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eWeMi1z4JCK+XMEvQCFUyZ6qEqWXaYSEpXs/63PCyO4=;
        b=GE9OG3gr6teeIM1KJnJLDYDmOPqpwHQbbPJVJWWRa8e+qvNahDSuBP9EMHB1Z9zCfS
         DzNtEaVZJJ4hwL/z53TzutQUT24hSRl6vbiND4bdn6PgnyWdAkAouTpQqx3hix5dexEG
         Tw8bNQQp+8XYUV1FNKoIkNbGyZS17Cbwni7AgaebK0j/Q00SVjM7qMXb+ha3Bf9aF/yk
         dCTxuw2+l6l3WLVfqbRE9JribsHXEiX8Arcmt1rVT80LET2F4DugZsoHkP5lSN5VWE7X
         2PmVnHPZe8vtZjOMA31F+a1+FJhF4m5011HBWuVUFIGBbED+puBLT5foYVRTEXYBuMO2
         ziBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684129; x=1718288929;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eWeMi1z4JCK+XMEvQCFUyZ6qEqWXaYSEpXs/63PCyO4=;
        b=oyqPIGwTakm/RPSKL+WD9jh/PZCgRRQPJ44YbRipc9oFIwOYmWSKgqffIqiDz/n2qm
         MQcEAfMaeroMmsrZX24ZC8DCzY7Px2NzhjoLqBJHLpGci/Qt3yiZFao2wRCxpsUhWt7I
         GEgHs+smVF4O4n8U8o/TJdwi99Qc1hYwPR4tzbjR+fseP0O/Nr1IJOFdQn9WZAT6/Wy6
         4+EaNn3u8ClD0dH7xzHvXAfF+KyEgehzKpWKXlKzLHRf7t4HsBry/J3IPsJxjcEyHjtn
         +vwLWs/d5G7pCWEhUQOMjlmRbbfMT0jjSzFrA3wUZh3m+VN4EXoPspwj9e+3xQcNDjtg
         RZMA==
X-Gm-Message-State: AOJu0YyIfHkVtbl7S1tLgsPiDr4oXR10Ff3p9K7j6FdPKOxOzitHeMeA
	VB70SIXkvDB1TYGfeA8YXZBCP/oVV+uppEcbx8hFsou+vphV/CJmkaYNJmXrCQjljbUsAWJXtnr
	3ZYURGYI7AfvYgTfugKZCQxf+wxQSECr1qhY+bw==
X-Google-Smtp-Source: AGHT+IG8pQ7JMnVsI3Te2WeC+Hdtmyjd7l9vtYflmm0/97yZOaS7cvIZtnWYmC1G8hdhlyHcRvLuuSiYPVSyaA6Wfbc=
X-Received: by 2002:a50:c315:0:b0:57c:4200:a958 with SMTP id
 4fb4d7f45d1cf-57c4200af44mr1264695a12.35.1717684128664; Thu, 06 Jun 2024
 07:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606131732.440653204@linuxfoundation.org>
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 6 Jun 2024 19:58:34 +0530
Message-ID: <CA+G9fYu2_bDqLixtW385KX5Vsnrmsi=FxQVgwUgnZ9qztSLW=A@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/744] 6.6.33-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Jun 2024 at 19:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.33 release.
> There are 744 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Jun 2024 13:15:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.33-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The Powerpc build failures were noticed on stable-rc 6.9, 6.6 and 6.1.
Powerpc:
 - maple_defconfig - gcc-13 - failed

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

arch/powerpc/include/asm/inst.h: In function '__copy_inst_from_kernel_nofault':
arch/powerpc/include/asm/uaccess.h:177:19: error: expected string
literal before 'DS_FORM_CONSTRAINT'
  177 |                 : DS_FORM_CONSTRAINT (*addr)                    \
      |                   ^~~~~~~~~~~~~~~~~~

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.2-803-gfcbdac56b0ae/testrun/24217279/suite/build/test/gcc-13-maple_defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.2-803-gfcbdac56b0ae/testrun/24217279/suite/build/test/gcc-13-maple_defconfig/history/

--
Linaro LKFT
https://lkft.linaro.org

