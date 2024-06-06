Return-Path: <stable+bounces-49904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509E98FEF84
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5281D1C20A98
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327801ABCD0;
	Thu,  6 Jun 2024 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T0ggKR6R"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEDD19AA53
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684066; cv=none; b=NPIRUNLR7a266R0COBGyywdeFD7nvI7JVqVroIJViFGrBzvnaDDYqBFW/qy8jkdfBFhBAKLC797O+0MLmio8+w7Xlto1vzhdfFX1WTXgiBzZrTOJfHNeY5OBmcU5WHiXC2eC4myJg3sZTcUHQkknSHN+7WfAwIBlNVgFc6mYvJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684066; c=relaxed/simple;
	bh=zgz2bLOFJRkBwOEW5RaCFDEbiZHMyOTfAejaJyCZblg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4GqnzEcooJ4vef4wo21YdyRsFaIc7xB0qP3cG/8MKvvLk1krrsGd6NeToX8OcDu1FxA+THtTIT7qmASXfOWKU+HLCg1mu/AJctLAkRiTx1sjM3c0EPCWw67dmmyxo2phNvNANggHc56Ts6M2+Nhh5X5AqKdObq7dkNnhMdL3ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T0ggKR6R; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a44c2ce80so1166535a12.0
        for <stable@vger.kernel.org>; Thu, 06 Jun 2024 07:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717684062; x=1718288862; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DXB1vdhxU7ozzaIOv3LXxHYx4cJj0wQEg5HvR8ydDjc=;
        b=T0ggKR6Rr9DJJ0xca52554+6PUnuOKGLzlJ8+TCCjQLBBPjXncDYJgHL/ILrnmeCWY
         gr3bAJIRdgfItiYNELe03WZE5iucyBWi/vSCdOdXUR2y7A9l1vWMzWcBINT/37d5ouvY
         77temUAk1dpUQAM/LOZL1c+VrgshuG/vVAy25/EQsUmvUjPUINRt7aynoSK7WCfIQ7MP
         4kwLzvoG+l0elZXqYKx2NflaMUTXVXUr2EdLbcT5horQ5FGjC0NdpgglM86sAh6O+hmF
         pNnEHackePWRXLFLl2Tor2Mh2n6DIGRddAg4jgsssqtm0pJH4rifyaqQZMcYz30octAz
         OWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684062; x=1718288862;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXB1vdhxU7ozzaIOv3LXxHYx4cJj0wQEg5HvR8ydDjc=;
        b=SJG/KN+wFYBOoBKgvOCuEXrpZqadJsEDagiokZGxRuHeGQcCsgTEdnYSV2ADemReV8
         +35dFTh6U4Y3pcnVY+bXT8UFQ8n5jpXwQ69eTz5+HbLVeLU4me81hySfpTNjmhFw/o+G
         QLNWY1Xvd8UCwZ0EFwuWrbFJWGBoM/F3v7OaNg+0TrpFyKIUnngXAnIh4Cjtd70mmi48
         e6a+e5fXnLkrWeNUwJKcTNdwrV0nmGqJreNCdYDijPREG9zoWK20DTVLucbRfAlrcUkn
         n0qCX54VINAxChaK9EHJbJywNHAE5W5m8WlKWjmCBVrXX8+fPvo2nZsdDH21x5Xd6x+0
         u4YA==
X-Gm-Message-State: AOJu0YwU0DtITdXdcqEyTkQT+iKqGeQPi3nymME3PGpqOMZQR3ARW6vd
	VXMaueCCSJcTxgmKkbv8zl4J71UV+AFCLZS7ZsB/ieVPa+2YmlIx+4JfcEpNvq+3v54FjnE2fGy
	eqtNbtPCJr/E8ZBp3702nqjNcp+mZTnj9Z87kDGzu2ot5geyd4yoXjQ==
X-Google-Smtp-Source: AGHT+IGu9Nb7LzeYBiQRctkm+Mte+Uml7Mcg4Wm54UUxwsCVucNqjC5EhuyxtMfysFzkWUictLWSdMHJTlM05oWiqTU=
X-Received: by 2002:a50:d5c8:0:b0:574:ebf4:f78c with SMTP id
 4fb4d7f45d1cf-57aaaf0eb41mr1306728a12.7.1717684062055; Thu, 06 Jun 2024
 07:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606131651.683718371@linuxfoundation.org>
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 6 Jun 2024 19:57:12 +0530
Message-ID: <CA+G9fYu+5dfJMBsZFECzkWc1cxzqWNNHpaKfOcZhZ4frUJNCOQ@mail.gmail.com>
Subject: Re: [PATCH 6.9 000/374] 6.9.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Jun 2024 at 19:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.9.4 release.
> There are 374 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Jun 2024 13:15:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The Powerpc build failures noticed on stable-rc 6.9, 6.6 and 6.1.

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

