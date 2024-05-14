Return-Path: <stable+bounces-45106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D5B8C5C0F
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 22:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF191F22EC3
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 20:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B0318132D;
	Tue, 14 May 2024 20:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUwvcQp/"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4852918131E;
	Tue, 14 May 2024 20:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715717356; cv=none; b=tDRae9+w8oXjFI++1Sth/62FQu4nFArnDlsYJv9p7dAJfJfCIM5TYYKTarF9cw8wQRyu0s9CGsL29aIG9ri1lT5QiuDP12yRPxg01dM7EezL/EhiFr7nyQKVZQeQt6SchW4oevEj4ACmkGzwbOuTjzxOUr006t2HBVRHuG7/0lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715717356; c=relaxed/simple;
	bh=+uoIFCvGVIJRk4s7hsYigwIzua9WwwOe/QuG0eGniAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/FLmg8IT131ygY8W0a4W2pFyTm5vvB9pRRqJLsNf889C0DScZsoC3G7UMhxGWFthBZMvplFyolXejqMARq/htvf8Fx8N01VM6Pvp5V5vCigTBjcJdOLNOciQMd81a1C70Q4g9fXHSyjcNO83VGNe/96dE6li8sOOqbuLbaJ1Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUwvcQp/; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51f0f6b613dso7615040e87.1;
        Tue, 14 May 2024 13:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715717353; x=1716322153; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=it1t5+uPi6v7OLKk/MMFS0PswUkDo02K79yDDA3ssT0=;
        b=HUwvcQp/PWh2bR1n7Pz4ZfMsQlYbGOHbLK4VQ2qjFywBdNCpXPhE7FLvH/tT9y1Rdb
         ON2/7mXNjED3TEgYVl/cEL/2NO8wRQmzL8gjuRI/tC9m8Q1Eh6ZbO4CBux3cLtB7DO9N
         JlccrOF4kmNE1NA2E8QZF5gEc9zy+nNiEaPJNi3s9aka//bw/hwzSQkhRl0P4BJ2o2Kg
         kqsBvdvA5FzeC9MSPbuTmwQbNMV04CT2apMMuXB1qSN83U0s9zIrginWL1AL3ASzFY6u
         MQMhxDTZNUDJvSdm0dHfAWJcnQAutg31JIG4Wu5hf4cROUfeu40abmSmYCsFN6yXaK12
         qjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715717353; x=1716322153;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=it1t5+uPi6v7OLKk/MMFS0PswUkDo02K79yDDA3ssT0=;
        b=ZGQ2aK1yWTcafvphCN2t4JLLDFNRO2Zn6yThXxS0ski+Qv45w+4dvPlop/EuRNcHln
         pRgV7tWFHANfG+hlHJV5yCCR+DUe2/uScv2GOoW6KDIlFNOHYXhF6N05Ngu5Yzgl3ar6
         RiDxxJVjuZClf8ZAdP3DxTTiKpjDsVD8HaD1PiEsuNA8sF8tp2Abm/tuXE8QmyQI8zQm
         dUqlk0VGvFz+IaZnLq9vz7z7nOTkv++FLtBLkEUDKMgr2vWSH+VXwOA5717UCXOX7Qrw
         iCi1qb0D1SfPbL9ph7D4rxiA3oYupBE4OyeziIDgT7n7GpdpANGNQ1cqixRs8HlHlaLP
         lbUw==
X-Forwarded-Encrypted: i=1; AJvYcCUIqv9i4QnReqxiXi5TEAt6SVX0TtcdjGw7Liy2QXsNWV7VJnoHDHg2urMfZo+cbzUqWVE2t/HAsqGO8K+BPxRPcOHAA34XwMa3vS/a
X-Gm-Message-State: AOJu0YwcAjxQd6SVDLhWN791/L+rb/oQh/U8wdHJEHvGaDfeO4YMB01M
	JHVON5WpGR2UN4NRVNETIKgEwdi9oEIVqywYRML2JA31RRFQ2NQQ1vTGp+Ih505K6egHC6R9Peg
	/8jNNq6X2pwPe8Vy8vV7oOuEWVVs=
X-Google-Smtp-Source: AGHT+IG/LK246gPxJGnzQKXI1WEdowT9ELP9f70gsfduDA9emWPXWQa2w51EHhaB7QwmOwxLD12mvLIwloULemMPJC0=
X-Received: by 2002:ac2:5f89:0:b0:51f:6a38:be0c with SMTP id
 2adb3069b0e04-5220fc7d370mr9122388e87.22.1715717353120; Tue, 14 May 2024
 13:09:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514101020.320785513@linuxfoundation.org>
In-Reply-To: <20240514101020.320785513@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 14 May 2024 13:08:57 -0700
Message-ID: <CAOMdWSJtHwT8SxBNuzyig9qfrwhw48ZQpTt2x+nF5cp1=XRY1A@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/236] 6.1.91-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.1.91 release.
> There are 236 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 16 May 2024 10:09:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.91-rc1.gz
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

