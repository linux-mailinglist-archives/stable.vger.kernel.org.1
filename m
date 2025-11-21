Return-Path: <stable+bounces-196557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ABBC7B509
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 19:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4D13A2725
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 18:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EBB275861;
	Fri, 21 Nov 2025 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvk1mOID"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72F4259C94
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763749472; cv=none; b=TZSuZDJbOv6Hi4I/5RNSNh3/AxAGoRPEkBy7sZrMIs4sI4DPkm4JuD+nYyDkpvCgXWgXMXTmiykcsYg7r+eMnguoXxXa0ZiTHksDOZ9TBToZvGJiS0FlXm5W8p5wnW5nphUb2saKV1bbZ6j90SvM3X5Z24B9ooQy5QwANbAYq0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763749472; c=relaxed/simple;
	bh=jNCChF70TmcG1oxsqs2yj42USLaIEY76NYg7HDWfwOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N0j7IsLxaEN9U2zKpt3LRBhm67C4/6djkHTTBVkes0ZtgTYlbJUo/6dwJZiuDWm1jrdXui8M+cNsjWDrYDs6nDLOSvt35UfO5ByGwvGZRkcqhMJhXB2B6BnoeYhwfWrPD3QoFLyanwxnxZOoEOSIQ1GuYaL8AXO2oZXw/NlrX2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvk1mOID; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5957db5bdedso2300235e87.2
        for <stable@vger.kernel.org>; Fri, 21 Nov 2025 10:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763749469; x=1764354269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5mWUnL4huWsnw5EWuPaRB82TmFIMgBdgOLKjzC8Skc=;
        b=kvk1mOIDIj4Id82dXYtij41yJatlrrLN6MlmCdAaqy/MnjVi8NG4S/h9Ik3klrEnVh
         yhkG5uG99x8/QO0U+0qhyhbzKJ6y+F4XKhUPe7wbaitXfOWUSCaFYW7baLc2vO3Rq0xK
         jGSuTDQ8xwchqc+psPazyJMqB3LL+8krrc2MGjOe2pt8EcdLWOis7SrN0rtR7MFGrrUE
         pLISu5L57CW9avkRpee0B56s8745WXJG6XQJ4vPGBkcuIRbLAKsnmgzx+Lq9wFjDVWwu
         bgo/s6cthiB+ORnEaHU3jiJfRxdevgObhnQBK5DJs5WLvbNozNQRYqh1KYfuUfjkIEWo
         hgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763749469; x=1764354269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O5mWUnL4huWsnw5EWuPaRB82TmFIMgBdgOLKjzC8Skc=;
        b=p4ACoDia5LA1F1Ew2L4lXcc1R63c9EWvEPFOA87/tZNtvKFswG0dA9b2q3F7d4NXtY
         U7rkpguVB6WULrrk88VAvVr3fapvfBs2KbNoOxbyv6kkseJVkzqng95IMY8Qc9Y2VtRW
         Di9w8H8KP9jCOeoT06pfGVYUoOBt9jnWiEemU3tZBq0gdQJL5I4Rj6MDuk5zBPp1wIPN
         hr2ANY/89dwVd7JtQsMkhT7N9NYdSnhEahVn9w68v3JlMLa9wPyk+QiuptfWfhdT3ewc
         yX5qcD50pKPW/shdcOIux01RIgYtxNKaWeRmGVWedclhRZ1Bfu0VVDXa0FnH8sY5cqvI
         xpCA==
X-Gm-Message-State: AOJu0YzP5ndSGMCvCFS1YBkpz33jFhU5nMC+eAQ03ITp/6OyHezC87fh
	3V/c34qUrQU5+YPmLuvwStAQaDaaB66QNSxy7rQRV+xM4bwr0MknTewHBQhWNeagmgcB+AalfgR
	jumO0NmO16XcSSz/JNURRNsT2OPTIefU=
X-Gm-Gg: ASbGncvIancnkHxVlQFt8rm6vW9zNqGj20VSNbeB6TaarN1y4KuaGBt0IQxuKBfbwRe
	s3ham5zYe4imfJRUNqbrc7WsdnnrFOozipA/Ii52b3IVp/FdgYt9PU88jprSK7AXj3L1bm+FnGw
	7o54SQMgKCbJ3k1mlzj+50WOX1YLqTCIuAdQdkKoN9VEjaLU6fceLFytLTQbTFim82zd7C8iu8A
	auJBTOZaQRPYZg0CUw7kcFLkBIY2nrHjTn2GSae5+EJUlnjTP7JHxUdt0clwVhdLWlmIj0=
X-Google-Smtp-Source: AGHT+IH2KMPGKNydn7qVBYyXp308cBa89ak1G75ivZYx9VUApmkU7FL2M6S133kw4HCcg1ICiDcb2fxuCsx5UyJ7ufg=
X-Received: by 2002:a05:6512:3b8c:b0:595:83c6:222a with SMTP id
 2adb3069b0e04-596a3e62a27mr1039627e87.0.1763749468725; Fri, 21 Nov 2025
 10:24:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121160640.254872094@linuxfoundation.org>
In-Reply-To: <20251121160640.254872094@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Fri, 21 Nov 2025 23:54:16 +0530
X-Gm-Features: AWmQ_bkUWxBZOylRnsOR5UY-ThzszbxIaDsx9VMfs0sdcxAJcJiK_1oL-VyEuVs
Message-ID: <CAC-m1rqiy1gNYFw3GCiujNbXvScPO+E3D=p4b-fFPkT6R0Qdaw@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/244] 6.17.9-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 9:37=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.9 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 23 Nov 2025 16:05:54 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.9-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
Build and Boot Report for 6.17.9-rc2

The kernel version 6.17.9 was built and boot-tested using qemu-x86_64
and qemu-arm64 with the default configuration (defconfig). The build and bo=
ot
processes completed successfully, and the kernel operated as expected
in the virtualized environments without any issues. No dmesg regressions.

Build Details :
Builds : arm64, x86_64
Kernel Version: 6.17.9
Configuration : defconfig
Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Commit : c2a456a29ad6042b4ca41d6d1ab4604d60e3bef9

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu

