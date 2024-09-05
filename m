Return-Path: <stable+bounces-73592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EC996D7B6
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 13:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95658282BC1
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 11:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C551219A29A;
	Thu,  5 Sep 2024 11:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dxS/x9r4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075C41991B0
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725537346; cv=none; b=tzf2KO0g2j+r6EPWnf9kCf1lhv1Ha6z2Z7zpewlFZ+6cS6d+/bLrgGmF+3Yo44ckHAkqZjzRNqyRxhZjM/UN/UfLOzpuqnDuh+fS40+4e9xumX3+PSEzKYlZrNEr6D+0ZrrVkNicjzzXb+fDBz0zjbPexbyg2W+KyhIG0IanAbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725537346; c=relaxed/simple;
	bh=9NJQoo4LMVMggcZzkDEPcmdJE9FtDyLAQZGKEsY1FLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YimIWWfjFdbFmilpf4MSRfcXFOMg47kaIF95T8tA/zDdQT81Ftc007/b57jjxE35miKmuw8PjiRC37J14R6SsNAXOrSmrHMUshKC3AAKZjfzKmuD38sxP8lfiECWYJqstLbseB89A0qvGr0HVV7giq6Vnz3gXYWsUhybdK4EpKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dxS/x9r4; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-84305a83b06so206891241.2
        for <stable@vger.kernel.org>; Thu, 05 Sep 2024 04:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725537344; x=1726142144; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qRJcGcRJNx1TW5diCULQtEUQCwcWsO+dA/2EMfBnxLI=;
        b=dxS/x9r4fnXUO8Sd5c7lzNjpGSYaqpWkZGldn49M6EKrgg9irH6NeVlzockNfDLKdM
         /PNz599PPijG7w10HNPuKeyXprzt+X7iqyKCjMYW8DZrMSbGrk2QjLJSVu/CWOcgFtgT
         EuVtC7ObXY+dMuSszgD1w+3P7xZoXCUILWXK+brkyb/FWnM79D7EbuqiuI7U8SW8YhMa
         iMIngGBBBhUGyhIYjIZbgkTQJwZghczrY4Jc7e5/X3dwHV57YsWjYjH2d2doj+EIcW8C
         yD5U4pTX0xbOuNztVgrk8IaWCqWfdXsB4E/DNqqEBXgV/60lgWuboSOhlFruEVsf16HA
         jNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725537344; x=1726142144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRJcGcRJNx1TW5diCULQtEUQCwcWsO+dA/2EMfBnxLI=;
        b=CnwXzUzOrNPMSqcao50nEPb0454WdOXLjrYIMq7WGMniD92r2e0zewsZDJgytn9eWn
         ShXoKWYucE2Rz8xXi/+eE3PysUyPrZaWvM+Rlj63nCs/iCVDG7Fvm6FpCX9+ouCXI4pG
         oV4CZw3hRZ2FpopxLQAQpRfKz43J1lBSR6AY2pRNmj3Zv1XlZ+RjoXd1fqDHY18NwPU9
         URblY99tX4UD5tjZBn4YfurAmasqa3D1Uc3Smu6MC136o17yajHmcsTxTkiic7sA1U2E
         outK8iUGjRuvtyyp++tp06h6kPiNwaGME6jz+A4D93sH153U6NALd6pO7Iz+vqSmNZe5
         twcA==
X-Gm-Message-State: AOJu0Yy43l0BEoBIbg12Pw1LUwbGMg0NrIhXDpxPzcFhD/xuJdwu1ZrE
	PElzIbJrkHCLSiWN7X85i1w4kBGR7pjD7UuEMMEjp3bY7uQYKD+RGG8hvmeuGRAwocbiuUAQxJQ
	iODa4qGiwC3hDo9yrNJt80uVsQQeR2cwSQU4rjg==
X-Google-Smtp-Source: AGHT+IF81MA398iZ6b4Y3eucXQLIDL+C3dpW3/7905P6ameFiZ7xV/TUXSEnEfZ4bjIqf/xqhw7rYHJecNOySvu0Zrs=
X-Received: by 2002:a05:6102:26ca:b0:49b:d24a:6860 with SMTP id
 ada2fe7eead31-49bd24a6c82mr1314728137.8.1725537343801; Thu, 05 Sep 2024
 04:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905093732.239411633@linuxfoundation.org>
In-Reply-To: <20240905093732.239411633@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 5 Sep 2024 17:25:32 +0530
Message-ID: <CA+G9fYsppY-GyoCFFbAu1q7PdynMLKn024J3CenbN12eefaDwA@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/184] 6.10.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Sept 2024 at 15:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.10.9 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 07 Sep 2024 09:36:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The following build errors noticed on arm64 on
stable-rc linux.6.6.y and linux.6.10.y

drivers/ufs/host/ufs-qcom.c: In function 'ufs_qcom_advertise_quirks':
drivers/ufs/host/ufs-qcom.c:862:32: error:
'UFSHCD_QUIRK_BROKEN_LSDBS_CAP' undeclared (first use in this
function); did you mean 'UFSHCD_QUIRK_BROKEN_UIC_CMD'?
  862 |                 hba->quirks |= UFSHCD_QUIRK_BROKEN_LSDBS_CAP;
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                UFSHCD_QUIRK_BROKEN_UIC_CMD

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org

