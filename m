Return-Path: <stable+bounces-80685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A5398F85D
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 23:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A0C1C21CDA
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 21:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35B51AC8A2;
	Thu,  3 Oct 2024 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6HXYByw"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E98012EBDB;
	Thu,  3 Oct 2024 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989223; cv=none; b=IgYQ1jPLjORn3u9cSVc2ia9BhoE17n2GHogGhWLqtkPoW0x2IIgBQF4480j7aEDzqIoNPWti1ehlT+WHA2PISEYpoKDa/aCSFlRu6iICu0FfOP/3MOnChPiiZIFKNTeKp6UCugOlhkwL4FTw1zZTjb0SRug/uNT3F5f7gdXIxlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989223; c=relaxed/simple;
	bh=B/mEJFQjIVDAe69T1T2az2vyC674nGoigk3NKTfT6y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0QZzYxudG5auOQ7V/bi0eAgazMkQNRzaKY223it5sMr0t5i6HowC4VaM4OILpDuPiiIxmKg8snAiGov/VLyWNev5s53Ef/Z/F56stX5k6Z2JVCrkO3ahgbDDug1Aj2lWWBbk52QXYFqrUbAS7Vl/81UPjO1oTItfdf7JekuYyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6HXYByw; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-50792ed3b0bso438941e0c.1;
        Thu, 03 Oct 2024 14:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727989221; x=1728594021; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2RtfrwlKWWoE8117z4p0dEnqNdI0EcSIuAVNsBuCR8=;
        b=O6HXYBywUdqePln8bXPPNtUDtQ5qiQszP8PUmzco+Gv6jdMmUYV/ApNaT2meCl9nbC
         oVqveNLbiOIU4LSTb8SaxviLnXUqGbH5eji6Hr3snvPoxZggmKRXSW59zCmtIN/3Um5d
         JCeI+WKXZfMtQWCl3HULzmZ14RhGcUz5NxExggELkzwecMKTE43IbToaR9kOrOoeTTWt
         fELDlP2tlCHnYbZvZjVVYKFUqdrw6iRskL6mkrx7fGbobdqReB+8S5j7TJIC+B2tVmr9
         jV257nJHm4SpzuFzDOJALzaQ2FOEuQxJNqnBxmPxSRDcmSapokr+4+7uQlA/suqbTdSl
         WxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727989221; x=1728594021;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q2RtfrwlKWWoE8117z4p0dEnqNdI0EcSIuAVNsBuCR8=;
        b=MaPFDbRkdhFEK22pDNwmT1J0F9S0XJkVtm788d8nguST3LEwBY/8eTiu6OflHsuBsu
         yaXkmRWllyqiESrPgBF9X/yay35oI+MQeFWMYhmcBM6i3yhWMomsPqha0MCIrZi007AH
         WFcAqTrHKXhUxwpju5bB/t1dDLedAs29NzAHTgbuC53wpTiPcwq4g61BvMTMpPt0VF59
         KHZB/2A0MjArEkImuuHgrU39N0C4rwN8HuxlGt/pcQa2zfZWOzQB3IbEWKGiZKl4I/6M
         P7aGZ0IYSy9eNIxlK5h6IskEfkAVkc2f3YW7eGWqzQOubUf9Hs87eQqTelDkt6G4hU7H
         5CJA==
X-Forwarded-Encrypted: i=1; AJvYcCVuwQEsN1rgcPQkyeLjq0rxmjyhGbP67ECHmV9akvfd1hAhTrnUKlDX3I1gWQnCy9QUYiffLobjfl/leUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGC9Y+QOfrW+j+3TASvlpnWnoReuEyHZdLR3YPIf1E4CylVAAz
	BrqFDN1e4BFIxss7KJbur/KGeOBkyzD3LON5PwahGcIZPtrf9G+hAkT5forOrR0J0LqnLJjjbH6
	4KYBhOzFwe4GQ7ExecclEd/lx1P5R7Q9C
X-Google-Smtp-Source: AGHT+IFQt+0ncED03UA9OizCJy7paZoIVwdW5TU+6QFXLaL+7JpxsfhE2+mV6YUajDSZ36Da6FoUl9iulnMjwL7yezw=
X-Received: by 2002:a05:6102:3f44:b0:4a3:e55d:eff5 with SMTP id
 ada2fe7eead31-4a405768721mr930660137.9.1727989220991; Thu, 03 Oct 2024
 14:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002125811.070689334@linuxfoundation.org>
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 3 Oct 2024 14:00:09 -0700
Message-ID: <CAOMdWSLcpMRDzmJ8qBwnz=vo2sxH8hW=sPpCTwiBbP0MZbyftA@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/634] 6.10.13-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.10.13 release.
> There are 634 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 04 Oct 2024 12:56:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.13-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems.
No errors or regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

