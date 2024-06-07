Return-Path: <stable+bounces-49994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CDE900BA5
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 20:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F31BB236A8
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 18:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC5E1D6BD;
	Fri,  7 Jun 2024 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQQLR5ec"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD541957F6;
	Fri,  7 Jun 2024 18:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717783206; cv=none; b=DAUbbzXDhqb52MAsKWJdpzfvX6Kc/l1Cy+IrUlZPo6sasF1rfP0jEnZ6MTmZNLRJS+caXCvPtyZXgqmHoWsW3j0X3WZRPG3OKJC1V4wYGTH9SNcDQZaZlQocvfrKngHOBZcPLtqDvohFlYSJUvZdaygDmUErnruAi0yLFPMNuHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717783206; c=relaxed/simple;
	bh=ORACpY/+WSqScKc7lPlj87lP6hmkqvGD8jTFglZratU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qq6biTIqxDQsPcuo+9kmfm0t8JSA98FSHiVEXWlF7sYw0P+0ikXbDI5zKA5PRAD/sOw2omz0cWmbKNK0VZCffkr/ZkCgEnV1QgxaQChIY3yu2Mg3ZX5XM+4wD8yZnDbgODghDf8LON2Mce+KAHwyDjCuFbN1cc9WhnyaBVsLCNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQQLR5ec; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-48bd2a9fc5fso823363137.1;
        Fri, 07 Jun 2024 11:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717783204; x=1718388004; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7EhH6vaIBQdb1uBEieNVOyydAgoIsiXtNo78juieCB4=;
        b=XQQLR5ecpgpH4Lhru3Qe9nA6uLZb/zEfLes3EGIPxkebVdXdoeeHDja5SMQt4Bq6hM
         aCUbvJS+zaD3Nrq1a7fuABZbwsRd4pDHPTBZpJQ9OO/Jc7mLfWBScCkXoGOVB1cSLlqg
         UrEnqq1jTeh81oOw5sXT9hJmcyy+KK1doLisUYlnE6XTIhxCYcsXBBmVtWuVTeRY8Ef4
         zX7CnxaIq3Um4Bo2M3cZ7+e5px40DgwfYlIKT/foQ8VpST5lsvDIHB/jctQwsoLE8YPL
         vJC1CE36zOopJfStk3Jt+HVXfWxE6ug2NTDl/vycN7asx7DCR3l8CIAJMp+XomHyaxas
         5q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717783204; x=1718388004;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7EhH6vaIBQdb1uBEieNVOyydAgoIsiXtNo78juieCB4=;
        b=G+JSTZ0izTkjrJsZWv9NPdnDhK8+6T4VcgcrJ0qT5dhHZNIZY5F4So7tL7mpzBzXao
         AIMAac/VKJ7eaaXfh3n9KfsI+7G+FunhKhNWRGYKnDRNyQTOwTwSKTP67BqO3oMOWFq7
         bcz4FCOqGACqTXBKDJcrehKH7UUiHwe6pVBBv+nR8liMMtD3eqJJVDIiX8OMAyMgx7WE
         JDCMQBXL3W956avLZ9opL9jIiR403BRczvgUy0IvS4Si8CfmxudSJkCupdtK90QFwKQn
         6YOhACVYl/vR3646r+BqarKKg0dzy9BaKmjxcz/J1gsEgDspct8S39xQUj0pUjeYlHLh
         BxMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP+hEvftI0btVXtanPNVBtWEddunJFq27C4sAMIOrXX38nnoD2RPF+hwOVqqAYwJACB+qBlO7UN+b1D2vuZkxamiFIdH22BUlfGv+A
X-Gm-Message-State: AOJu0Yysgs8a4gpYXByQkaIYUiYuwBKPdHzgVPetH4sBZgQHosYzcrHj
	XU6uc/BsyxNlv3NoIsA2g4mQUVquESe/SFryZK1I0hIWDIADYEeXCXkCx/ZOGhBlHc1pdaxmEjL
	+ABB9168zr4+WcUk29rgLcU9UDO8=
X-Google-Smtp-Source: AGHT+IFzsGF2lOI5dkNOTbgZy3wS2GYlGMxr6RI9Dk3Ib3eUM9JzBK4G12uxWeICPfFuZsnSc6JqNCaMN+P4/LgMyf4=
X-Received: by 2002:a67:e351:0:b0:48c:1d7a:bdb6 with SMTP id
 ada2fe7eead31-48c275dde03mr2856429137.18.1717783204330; Fri, 07 Jun 2024
 11:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606131659.786180261@linuxfoundation.org>
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Fri, 7 Jun 2024 10:59:53 -0700
Message-ID: <CAOMdWSJL+=cZnNKbpxbo9L51CXkmAp1MOynNpREv5CrB4OfUZQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/473] 6.1.93-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.1.93 release.
> There are 473 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Jun 2024 13:15:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.93-rc1.gz
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

