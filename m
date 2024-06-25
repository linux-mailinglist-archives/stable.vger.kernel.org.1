Return-Path: <stable+bounces-55769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D81C1916959
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 15:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5CA1F26252
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 13:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586EA15FD08;
	Tue, 25 Jun 2024 13:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="Y9LEpfbt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96027146A73
	for <stable@vger.kernel.org>; Tue, 25 Jun 2024 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323397; cv=none; b=ojof8KFnBLQeBjE6pV41ze8HiZMwrNlRa/UPRkAY/xnLFwXq1jgCfk1anZwBM5HmoXjj7pHNzoRrvP1LrKPJDLGuqil4sKLFvx0dv3vKnMwnyX/B6Q7uLrOFJgh0vabp8RBIC3gRpAwxcR/NiRGp0O4s5lj+psiPCRDV+hipJNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323397; c=relaxed/simple;
	bh=tNpmJll1ksRucbPOf2rcRJYDxSakaOfmTze6fQEjAgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMpxffnQGvBjXsBI0LlYxRvfy9lOpWQ06hc+YPCYUxjmz77cOfNAidGRJmVbUGeiNuUlKypJ7b2Ln/g/GsLdO7FMhTBPhZ/M/HxL66GDjMOdMOFhsIovsp46am+zpi8NVlumEa+iL23EPdKVmzKX2dtReT+7dW+hQm7aTyEe+/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=Y9LEpfbt; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-706a1711ee5so154753b3a.0
        for <stable@vger.kernel.org>; Tue, 25 Jun 2024 06:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1719323394; x=1719928194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOSzHtQDPIiUgYObK0O0Y6dDs3viZenud8mWqn+tO/Q=;
        b=Y9LEpfbtDBjTMvhSQ5E3wC3xgfXFxxINCRZjIqMMz4RucIXQEWPGUmaIFoRHxHFKWq
         T76Q/B0CaQd/88hIQbdLHen3epheSoMX5+WOCQTIySQVk6jNtjr8PM9AbHBRC/3iONmt
         JuUP3IyyG+1ATrteKqcc9NIk1lvW7C9r5ztc8hUaNH9Jsdqtz9BzTB80BVPJfuXPPQOF
         CQxYbJUGuuG5rrOqRGyMg5rrodltJiH6sro7EawQ2E38LHj42WbwKVxV+cTGpTaT9M4n
         eqX6CFjzSp3SLsUkHokdKARFcs0Yiipv1YFibOq/ZybXZOTIkFk6E8OgNMPWwSDmcVY6
         wc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719323394; x=1719928194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOSzHtQDPIiUgYObK0O0Y6dDs3viZenud8mWqn+tO/Q=;
        b=RtA4Wkv4bPG4+UoENOu80l8Cmr+dZyQRA/UfbO5T1ekIrjCA/pJ5ANIfZC0xafnchw
         eDlm+h1X9Ah3FePUMZwwnAWjeY+aZpzA58R1YS/BPWXfKOUmbsJOY88/tb364A++LIIc
         YgJslYtgntyDyWvQQ6KmVjHt6HliYCQ9uY3yyG2OF/yzBB7hUxaP6gwASh4uVPvAIoLt
         pMJEf9TTL3fZEWTX4XVEwiGZ9Ad2/hgvHa09803Uyq2L5pc5472PiEuUBNlsgbvr6kpZ
         g2rLW9t8XPZ6cWn8BKu2nfQRxnsCcCupcSF8V1HtSLA77RYF2GuOwbKdYqn6JVrB3ihN
         JbOA==
X-Gm-Message-State: AOJu0Yxkv8diIyTQQnJHGN+Tz8f/Xxex2LkpvMPg3/ytGFb5o17kM+Xi
	WWIbv4AR/gQYYTz+anHf9mPxDWga9TP1S0ACPiUtNofA8Uic8D1FyqUfG+cWNYi4SbsjqFMI3VJ
	2sq88yeV/VZwKAaucQVPN17fDvn6gQUkyEkE3vA==
X-Google-Smtp-Source: AGHT+IGukD7TL3VnIYSpdkVTf7oscbbD9B5o5/mEmcwIqPw5v7kMi+nq1AdyXTdqfXIEtbPOWU+LNjeL9LhM1XFoVoE=
X-Received: by 2002:a05:6a20:ba83:b0:1b0:2af5:f183 with SMTP id
 adf61e73a8af0-1bcf7e7ecd5mr6106084637.23.1719323393891; Tue, 25 Jun 2024
 06:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625085537.150087723@linuxfoundation.org>
In-Reply-To: <20240625085537.150087723@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 25 Jun 2024 22:49:43 +0900
Message-ID: <CAKL4bV708-YcfyLcuWSUSPS+aDa_Aas-F3JKY739MSVUzWFqxw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/192] 6.6.36-rc1 review
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

On Tue, Jun 25, 2024 at 6:48=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.36 release.
> There are 192 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Jun 2024 08:54:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.36-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.36-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.36-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.1.1 20240522, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Tue Jun 25 22:19:34 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

