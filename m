Return-Path: <stable+bounces-42871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 156868B89F5
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 14:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467CF1C219AB
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 12:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A9185634;
	Wed,  1 May 2024 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="aS+66/h8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EF27F49F
	for <stable@vger.kernel.org>; Wed,  1 May 2024 12:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714566350; cv=none; b=L1wl1h9zvCoIY7RqE1l6aqrJrLkDaEDO5POYf6DbjQOf022kbNOPTcPOnofD+BN4nZjfmttUv0kQqjLqaKGqNoifJh97FbVEe6QCVbHU5XGvIeWE64aJRnLu4FvyDLOb+C5S12Pgm8UgzUKZD7uV9HWoGsqsrb5KJx3dJY34AJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714566350; c=relaxed/simple;
	bh=NSwHWAOCmxw85tG4MpaDkx4K6KlMQMGRZ9GWBGkHOuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7l2b82iuOIZq47DgJCPMPGHisnTmZYkY9E3jbl7SSnbkGUBRltnRYRn6ObNb2q71+OkeP/zgypHFsmgJx5DDV3C4u2hTL89KaKfT7VMgPke/M4q8+V9EHGc8g8AkrosAWybV+d595JLQXN/z2qf9w25vJreiim25UGed0N7kmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=aS+66/h8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so66803035ad.1
        for <stable@vger.kernel.org>; Wed, 01 May 2024 05:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1714566347; x=1715171147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiVKU3GODS4dwlptSTMaoTCW/CBkEG4u9gcmVKIN794=;
        b=aS+66/h8a+lR/RBQ46xAnMPWozJ8dggz3K8j3nNKgwIoE1xr04vxfDdL39XBvNqErY
         rlu16aR5hMQzTehH2Z97dkkwVlHnx5ndvYGHoS20BDHgsOrMlY/rRUz+DpRg08RbjpGV
         aKmu4VNukrPCKJm3VQ+6/L6HJT9k5crncyndMBe5nrlUAGTwOysSrh3RU1vOzKQ1W4KN
         /W8xAZjKyE7l3QpwyACQMOVinGiRf2oTHWfr3T2PNNMwp+b4+LwzU4Ik8VpcjVQyAv9+
         s5zhfJ2SDlC/vzGpICh8Bfw9miqWtyaHfYg8t0egnE286WLOyVdCRcBQxfuNe5kABK9e
         Hc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714566347; x=1715171147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JiVKU3GODS4dwlptSTMaoTCW/CBkEG4u9gcmVKIN794=;
        b=XwIhqUggh8TseVdcwvC2e9GmJV6ltLzrFTEFMzUl+q7pegB+q8CQhrLhnKQSmXfxcT
         oIt/QGE1jVBYUtdzJnCvgXSooSFg0XqmuAACYvfvpOgRMIjW/7jsaE/CdR/NIO2I0XFR
         nUIZNbnhw5LZqARK62CrjSyjrXlO2baQSTDBjExoUilx7ISx2uqQKOMQfAm1eEEYa9q3
         dQp5WVY64qKm3h+LzU3XIRKAWJ9c4LMZzkE3Dq6EUqnsfkkTjutenIhpdUnp6MhozVk1
         4RIoewafo4D9fBRoaa5EvOb5cxRRVqek9/fHBzD0FVoTRLkKqy+nCHX4JsMzQ4XR0UmD
         66+w==
X-Gm-Message-State: AOJu0Yy6KJpTWPKyc7PqigP01M7dooHKz+jx8hbS8r8uCHi1xpHY6ImD
	wubqz8QOEIXC+983y/YkSgLFTvpEVAIuXR2bAEwCKzvvRh0tSg976rm/JvvWIoqxa6k5uF5p1ui
	EKZW3GYeook4lS1aDu0rMNUucXikNq9P0roz4qQ==
X-Google-Smtp-Source: AGHT+IFu7bWRAod+fNBklmqwmdOx9dOl716oP5Qi4fuEP26czGC5fQL/lUqerfzxAy382qDKgagM6DDf6j+5N6sB8SA=
X-Received: by 2002:a17:902:cec1:b0:1eb:1698:ea0b with SMTP id
 d1-20020a170902cec100b001eb1698ea0bmr2947039plg.6.1714566347519; Wed, 01 May
 2024 05:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430103058.010791820@linuxfoundation.org>
In-Reply-To: <20240430103058.010791820@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 1 May 2024 21:25:36 +0900
Message-ID: <CAKL4bV4UNZTAwz1Lge9qXfSA4dRwZp1NVgv3kXxiwzEhPxfDyw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/186] 6.6.30-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Tue, Apr 30, 2024 at 8:08=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.30 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.30-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.30-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.30-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20240417, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Wed May  1 20:29:45 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

