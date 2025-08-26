Return-Path: <stable+bounces-176397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D1DB37069
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 18:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFEEB7C8491
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25976280CC9;
	Tue, 26 Aug 2025 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmQ+k4yM"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A86C2417DE;
	Tue, 26 Aug 2025 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756225986; cv=none; b=ERLp4s4hklBT/p5ky6sezdrIE2gNsCzIp/+j8xHupXQRHy5cFQkzUZhOkppFacp3sfCxScag1jOVF90vDV12SkzLvT49rc83DhEPV490Yz3Tj8X2HgGDsEYA9GNWinwHnAVGP7xfj5FJul+oxgv1F3saQPIbG+fFWJ/cMFP9iRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756225986; c=relaxed/simple;
	bh=H3Y4RLs11uiIa5i47Ko7Tki/FNZ/WkWqgwFmBSqB9ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMELaJzbXXOFwId21gZdGHThZRHU8LKXLa8FFPrcI/AGLGWlDVDNeblHXJC8C/YsXNlAwbyq4Nq0C2UZziiW+ZyEt8f074AvpOYOKEM4TZ3QrSXo3JHg8u5BytLQm0fGHWXBEhejblTUuCDbhflFwhK1bn8O6DQ+slAq/su1UQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmQ+k4yM; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3366be380e9so21591531fa.1;
        Tue, 26 Aug 2025 09:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756225983; x=1756830783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=td+yL+G/QnImAGiUXt18toN6ra99vbmvbvRznOwe9oE=;
        b=XmQ+k4yMlWV1MO+FMpstpYSIR6XpAUuRp76stBuvACgSe4PftYX06GgB0OYaT7VwL2
         u77AdY7Up82lEDJcNWQSkK2FsDOF9W7pGp7DP83kVsyzRlY6D1mJmRaiNAK3/dLzilK/
         mgRcuVHcr83L/JlUFRJY92Q0hz05L0LKxL6zpi4ayH9CYJ5D7Qv6BF/3xS40l2Jm5sCN
         4xa+ZyY35rMHlGmAk3z38dMmT85YuPYoHL63aZR4tumFWt/IEGNGMbTAn/0o8P4oo4pd
         lrWAbHo1TpBXdm46HZvBSbhkSkBRw+8tElIelVqvqf8BPeruqe30HKBdvawln9q5PXKu
         VZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756225983; x=1756830783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=td+yL+G/QnImAGiUXt18toN6ra99vbmvbvRznOwe9oE=;
        b=KTOISJNGx8W83vacSvjfy42PuGWHQHD50OUrHdvXdldU+UTIT7/kH/kbM6faQIoI5u
         tCgn4KKzOLELVw+3zIWzTEJp+gov4a/LU9D1JEwDnApjE3vTFT54xb452fBESbe6sBUS
         ZWz86UVqham8Kfxexw/VxfSY10D+bEJGFaWBN5XllLw2GvXpX+HpGFXHBCjnKf4yuhzf
         CyH4N2s6jssPXKUHgfZaL1k1z6y/c+Qu0Gi+P5EaGPajRiEI4lpoNX+C+6AWZfxYZ1rb
         lPCfdLGUIrRoOzByZZiVw70YSmBn7WYhktyfbep7fett6ZJzK1p86WeYicSd9vxz+zMp
         GmKg==
X-Forwarded-Encrypted: i=1; AJvYcCW4171GGKWaYrRfpUPtkQMOLB9uOTUC03QdQSTTHEmkVZ6LxmA+oaglC9SkyxVIqOODHSXzJQMdE4TcI0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrtas8ki7/mituR0biVjfWqLtSjjeIhkzW9iMX7b1nmyl7oLl1
	3Oj6HrYf4cJcgNYBcq0rj+2Nfolp8j8XDU8yMSQRpGdueXNZRPhMJXXZaTh+AcXORnFMo5fiGoX
	2a+dPBGCZkcrzS52x6OKVOEJ6PNTtfSU=
X-Gm-Gg: ASbGncurTrrbJ3RgGTaQnWZlNASRgXJ/RygZ3hoAVx2mIT8XcHYy18zCWBZsc+k2wiw
	SMZo5d/FqC6QQ9csky0SysM5LNK8BWuQkCIEDq7Bs1OlejRvyrh+RaVyVj5T6jiRMvLYHgJSQ2t
	sl7rv9ZUJjABA/NN4kzeCznQeLLrC9kY55mYrVdx8OW9O+uFoAiVeLZWJ3l1azQkgvc8tYTB1uC
	JHMVPu92U2L6xBASZl3YMfNbbI4RePdKCmVNIijiWfMGzQSdUKSqRlEfffDyUSagYXrpysN
X-Google-Smtp-Source: AGHT+IH7CuzSpIj44VJr0hHFBbY5rjYgaTjZyN5HnnlHP6u47THUmC0DBE97XhgsPwXUTNSqeI9QAA45WIJj8l4vDUo=
X-Received: by 2002:a2e:be92:0:b0:331:f04d:e689 with SMTP id
 38308e7fff4ca-33650fc8436mr45773971fa.41.1756225982681; Tue, 26 Aug 2025
 09:33:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826110937.289866482@linuxfoundation.org>
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Tue, 26 Aug 2025 22:02:51 +0530
X-Gm-Features: Ac12FXzJlB4rzlOVUnLB_NTF-wRXJyVMNP9aIko-gLEuAfsPSsFz00NUtJUhctI
Message-ID: <CAC-m1rqahZ7=BoFcSAoZJdhAHHeen-+ZKUEm+aQsYyqA2ZO8+Q@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/457] 6.16.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 4:44=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.4 release.
> There are 457 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Aug 2025 11:08:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Build and boot tested 6.16.4-rc1 using qemu-x86_64. The kernel was
successfully built and booted in a virtualized environment without
issues.

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

