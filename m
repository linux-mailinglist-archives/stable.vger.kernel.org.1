Return-Path: <stable+bounces-54672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEB590F85F
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 23:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45A61C20C8E
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 21:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0656878C76;
	Wed, 19 Jun 2024 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1pzdkBD"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A16C249ED;
	Wed, 19 Jun 2024 21:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718831763; cv=none; b=r6kSoIhFudpFmL1n2vn/al3jE6AOWB/SYocOTU0iJBh43Gwnhsu3HTOadQEYeGYY6veivBKtIUuPuN/yg0YSl2xQrJYa6k4t8P4SzUGw1gLy49Y6ZHC7VSfSWI1uF8bBAW/tdSHU3XOtYtNoKLn6vXHcxa07kOjhjNtMFDaZtSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718831763; c=relaxed/simple;
	bh=C+KO6WOHrjxoga94KRP33XIx6lWs1G8zXZg+g0TEIXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2dqrgnz/cWO6ctrhGp3yueIdP2IipI+3nXxV7sOUy44ErYUUZIxH515rgUe82TKYhG0gAFGE36AxRpvFvox8Iw9d7xbsr57tMlmSNSka198CoJDjs9++fCYuejcekESPyvn0pPaCX76uWhvmiNdACUB33yrihdeqXpLdY0nBh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1pzdkBD; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-48d9998787fso89999137.1;
        Wed, 19 Jun 2024 14:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718831761; x=1719436561; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P51anmAPzV9wYSDoUqP/bhaw8/p6FKuq0IY5YhnZqM0=;
        b=h1pzdkBDJl7Q4gYvljzeS1aQWw2JjrDU49t8sc9iARAeyE10SlbIOY4M3XP4y2Ib5Y
         04FdIuMu70/nJkSYfYOHq/wmbksg+ZOKvdjNKyVRFSxjeYZK2fSdXw2WxCI9nXmc/WOi
         89TInDw/zSdnb/f7iD+QrxWQUReH/TXWKp9NV/F5K+Ac1ucxAmSvm9rt58zJkz9Ye6vm
         7jN5mBGnyt3WenNKJ2tjgyHG1iubUcxbkvEJ+R1gHS4i4bA+JSpfHpr7/HRmC3lbjh7R
         +CcPvhDGkppt3ShtCK3SoT98eDc497m7CcpSGWju4zbedANeJmrGy+ylVoKDolvbwtv5
         5QPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718831761; x=1719436561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P51anmAPzV9wYSDoUqP/bhaw8/p6FKuq0IY5YhnZqM0=;
        b=TWus6vAxCYWo+z0F3k/kYGA4cMi6ORh1zdh8YQBYWKVUFfHYiSiQe7VQukquom6Di9
         S3+4mPbqRKPwv+wg2+CxpFDX3GGO5HtK2wcrJ4m6XF+fm7txpxZCw2UIKT+YcE1v3YHa
         UgFPl2n9J52x4WKSUelt5p4YnQh4Y3PY3pFzQeUK8ciN7sURP1z+kAHF89Q2xu6EEXte
         JF3amfilEpI1LXYFqX8D6Gt7lihQPlWRuTG0VQ/5aitxxdGYT/nYI6C5ydgGkGbUadsR
         wNecGwbuDXrdKgdLZJRu1Nbz2/HuA/2X/cnfEr8RgzdPUdS+8lLgrimJE9/6wdcZTnNh
         3XEA==
X-Forwarded-Encrypted: i=1; AJvYcCWsD9/WI9QpzbUqrPLBRVjWZIhDFvKx7iSj9FTsf7p9/+HwPCTY/ka5pDzx/HABrRNr7ni4fOZuCvRaLPd2ql8E+1vpSqt494fkXcyU
X-Gm-Message-State: AOJu0YzRhI58Wf1M4AX7jbsEPRKw2/fG/sHFmwyE+sCBu0bFhF94Izqy
	66RoSCJv4ETZDuahfqNQw7tfuCZ84kUI3uKRBT4qPElg5FuNEmXjzDhpqDjkIfzLE1lyWI7o/1c
	FZcoecvMlXNKr3bix9eaNB1PYV18=
X-Google-Smtp-Source: AGHT+IHUYhwn5CA+as4/BnMoW/s7G1P+1RaW4HbsMU7gltMXF/rPb1W5yXJHb/MReLCjSN3zDFFboHoNMbef0Ypr9iA=
X-Received: by 2002:a05:6102:317:b0:48f:1674:f5b5 with SMTP id
 ada2fe7eead31-48f1674f725mr2932551137.18.1718831761348; Wed, 19 Jun 2024
 14:16:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619125609.836313103@linuxfoundation.org>
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 19 Jun 2024 14:15:41 -0700
Message-ID: <CAOMdWS+Vk5Mp_EWUpzZYZjXHeqFXLU_XNoyxXMyX+QboeQkq7w@mail.gmail.com>
Subject: Re: [PATCH 6.9 000/281] 6.9.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.9.6 release.
> There are 281 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.6-rc1.gz
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

