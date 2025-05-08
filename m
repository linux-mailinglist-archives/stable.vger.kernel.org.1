Return-Path: <stable+bounces-142843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7031AAF970
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 14:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489EC4C024A
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 12:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F3B22425B;
	Thu,  8 May 2025 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="dK6g3GB4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E9B2222C2
	for <stable@vger.kernel.org>; Thu,  8 May 2025 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706353; cv=none; b=IKA3yF/BZgmxizg3L9hMoN8ZGBSKwo7sVYI8rY5S/iRdtWRkVybue+3ACyxzNekq1L4r/MmK8v71JC0r2fSmzHl9ZJX1QZsRCc76w928J27W62w0ksILozfmH9dMepk+zsvQryGpHXehLSFqqPftaL/FObW90UTgid82q2Nm5B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706353; c=relaxed/simple;
	bh=YTlEjrVaZMORPcdtqbke0C4y8V3UF0+iZCzRvxQRU+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Br6jA9qtAnGfX1pdKvDkkHv9EoMSaeEx19Ti9jqaUyU8vXSbAxFpdOprEldENWSbvrsKsuk/iCD1/jw4JTfwPIem1pYx6YbEG86vNqCXQYCPqBxvjBoJR3x00K4iaJAkm6VUHPG9VpsaggdhfxF7k9z/PslH+tC1Jgkafz6CMcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=dK6g3GB4; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b1fb650bdf7so501687a12.1
        for <stable@vger.kernel.org>; Thu, 08 May 2025 05:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1746706351; x=1747311151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0GnN2zLN+jwcqw/AYevnBc6HDx0sVBLUkFkXjcaYbg=;
        b=dK6g3GB4iqqxMCMk0rsihfzdiuOAnX33s56Y5sv1IGBmDm/u02J/LVyRNTm1ET1/xt
         defyHwTHdbtc9fBHgok1+wGRsUFnt6dJsIBOJeRP/iE1KeELVM6sMxXMic6Klmce9LyY
         M8G8wk0f0quIuPBhDp+AI5j0s4FhmgEaNvLFrw9L+egcOoLHgKTrMnzRxkQJZNB3t6xg
         sGUV39EKm4ZF1ZLE530yG4Zy3fIEV/IyH6ZO4yKlnHS2V+MRbbm/PsJwO8E3aHAJ7D9b
         JghZiEkDAxbOz5Ch8NacpQUHVmLofgG9WS5WfDhKDydu50j/E8ZX4H+u5Ks5TP0Pb0OX
         r27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746706351; x=1747311151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0GnN2zLN+jwcqw/AYevnBc6HDx0sVBLUkFkXjcaYbg=;
        b=vMA7VuBgSXIWdyincdKIkTE1rVTrpbva47CGV2PIrBUO5pZec3wQjVfRrbZ9Cshjct
         gI43xQTr7ZBTZDhWihmDLkiybri66K3z5759r+cPihAOvx9k7VC5poc+quUQzM0J2Qr+
         GwhKI4ne7TaY/sJhu3LmhIChovzG089qM5g6AanzjOODGYY6FfuSboxFKVFqA+sGwrur
         8PbuVdjrRU3L2S6PnFKiZxofxoq6Q+e0cVvr9UUN8P4KNq+d3Ug1/6dt7XtsEDdT7//e
         CTxfC5c0/6vvy6x0lJ1IzK8U9igDC4DmRtNXFSuPcecdLFxpNfYH5EqaYbmkngdL+bhS
         tc8Q==
X-Gm-Message-State: AOJu0Yw2x4Sb66zObuDJ6LsHX84xf8z7zR/UFCo9cTs9QrgGMNKvedSO
	f94nAsUipSO9ELWqf66PiOU8wa3gP3lgeSig6cPShFD/z3GgUbDtavu0lkczjg6kk35b8dT6Fnl
	oFn8I9eacFcHhwhg23cDK0vV/xa+BKULMYDw/ng==
X-Gm-Gg: ASbGncuwdOO3qeQXrfrnVOGHlEZUJG0mmelT+isZfDybCExYXdYVcUcSXAKHgCfVluL
	UazNxvzzVB+jhXJ8r5fTC4F79nLi8kmEogYyshWUlJeB/Cj9XHQhYoN5p5rNvVapZmTGL3c5855
	TBcTzWpoZkcNyubgn8F2e0Rg==
X-Google-Smtp-Source: AGHT+IE5AaZc6k+qedv3ywSbWB9YaEJxg6FlsqvBzg4yPSs5n2Jeme8sRai66OYETNlq66zkPNs4uU3wMHLIl8bpXHo=
X-Received: by 2002:a17:90b:3e89:b0:30a:2196:e654 with SMTP id
 98e67ed59e1d1-30aac1b2907mr11342735a91.15.1746706350545; Thu, 08 May 2025
 05:12:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507183824.682671926@linuxfoundation.org>
In-Reply-To: <20250507183824.682671926@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 8 May 2025 21:12:14 +0900
X-Gm-Features: ATxdqUH2P6CaWRpb5gIEUbHMjZ59qZg07BG41t-BPBu0QIMK8pwNTdQkClHsJ_Q
Message-ID: <CAKL4bV76YR9PX1KYY3PF59yDqGRH8koppGbhU7YL1244wPc-jw@mail.gmail.com>
Subject: Re: [PATCH 6.14 000/183] 6.14.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Thu, May 8, 2025 at 3:50=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.14.6 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 09 May 2025 18:37:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.14.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.14.6-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.14.6-rc1rv-ga33747967783
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.1.1 20250425, GNU ld (GNU
Binutils) 2.44.0) #1 SMP PREEMPT_DYNAMIC Thu May  8 20:39:36 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

