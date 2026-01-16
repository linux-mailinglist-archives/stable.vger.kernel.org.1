Return-Path: <stable+bounces-209985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 891AED2B4F3
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 05:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D2C83012BC2
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 04:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542A2342534;
	Fri, 16 Jan 2026 04:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="Rdv/bg5S"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CAB33D517
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 04:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768537399; cv=pass; b=cbxh0qRMM6Lwdkrlf0VHn50D/W+AFBmXv0xOWbCax98pOAgIFmVXxq6w/+dovoeHcKuReFZV9Tpr5r7kmaQwNewZjCU7hZy2GNUiy6hNUJLc8HI4O96njqU70LriWkDa7tXiGF91Ez8qPGqVUxm+0EiUdubAKp86vYnJLJnykyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768537399; c=relaxed/simple;
	bh=oIc/W0gXzZh1uzQpfxKweLLIwk6rO7k6iG8RXQYPZ1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jEb9wBeNtKhdFHEe8aR6RKYEzBiuaEu6SNGhuGriyLESV+4YxMAATaRYVpsFijqZ/qv52llg76qiBvpKbekOz3rHYECCP2BqOMxvuj+Su71PauFCXoyqEYDYHyKWDNKtJcytjjDd7LyMpunO3XPPzssHp70sKapXIjuwwTeJLic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=Rdv/bg5S; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12448c4d404so771999c88.1
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 20:23:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768537397; cv=none;
        d=google.com; s=arc-20240605;
        b=VjGlip/meWTSRulOCTfLf+BS0NAkds2B/jvPU2HY/LDJaCRgz4ApXuzII39r+aDee1
         xL8caoU/WRLIOnj6RRBXJHEeOxirKIjSb7lckReTYA/aYT+OcJGXh4Svee2CvomRA3Z0
         lWiRLC9DJ/T2KwqR7OGA6kME/7Hibg19b4TnoCFG1sL1AsxlWDCAhjVlJ25smTtjZY3k
         5B880k7XDcRZ+WpWukNUF8jgutdqMY2qY6OxyEreb64OAqFROyKiSDP4xaRKBffki/T0
         if7bIovnGY7WDNtqoUK9+p+jxikPT9rulyUcun9Td/AVn9n/7fNQEku2xCNOYLEAzA5D
         hj8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mh9FhGoq8sm6eyeYNTJAWc8S8MpG3hZZAO2jpyOlG4k=;
        fh=bN1N9u37F9sfpeWZ2mDRMBHW5qqsdrFlcOzPW13gTq4=;
        b=cfh6fddnjfx5Q4Y1bvdlTui08fHZB878SCvwtv187Hv0hEXYTl7RAlwqG9LSrU6CIb
         zZAh/YMHxudcL08xGh6bRP6dUlzmDIqF5/fqJxFrzAmpbgFXouH/v5bxuQS+kA2mri+r
         wiFnsMbNla31nUkRhsTPOoTijnlYsKfFUF+ewXR2p/ZK+UWzRR14w3uMskdfHm3wSL8H
         S+Xno0Xy4VZjWqcOyuD5DQi7YFUTZKBN7j7PXHZi2bRWF4KxALcqPUuniR2vS1IxtjYj
         qeqNIqPwKMTgKbJiZAHLlwsEgttjHqIXOGfcNf4ExfnVxW4+sHenn6h+2uif/TCQfjkU
         3p9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1768537397; x=1769142197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mh9FhGoq8sm6eyeYNTJAWc8S8MpG3hZZAO2jpyOlG4k=;
        b=Rdv/bg5SZYTMpxbfW04ovJnvU8QYfzPRtSlwR92WNGqrJEndRRQ9WjT5IEq35tq2Bh
         +906QP+896Ioze3fhDjSP49ieMNG9rffOPiP9ESMmhW7Q83MX19axs4DXqn3Kmf1TpnN
         oihNkJF29DZULlyQ2UkSbZRIM0TOWJkn9xLbmKSa1fv7YZg8HWtUkmM/lbA/2osHcFhA
         6M22OntL+6na0MQj/HoI+hx5G050zJx6odOu/4fcWnEkJ63G35aeAP3REzCLTXJfQu/I
         ZHHO7nQWD417CaNvmge2gPNzxpvpy9Dk/jt45//3ZEbvJYr8NEGssWuGCR4hRUAVNGaZ
         qswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768537397; x=1769142197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mh9FhGoq8sm6eyeYNTJAWc8S8MpG3hZZAO2jpyOlG4k=;
        b=dBiha3ydDYz+J6FAq5KSa0Zrs5/yzDvFzkMlgwECcEIR4k6WcYsv4yvIAOIXfZyGCJ
         +rFtLWojR7JpRHAkFTC/nhCPq9ME0xgtygRubW9QppiPYDP1j07YEuklWixcj74UN550
         MKOgxHraPqan5RR0F3iZj/Q623c06JTsJLRcyfUr7BJCX8g0BUJibXoK1C7CsOiFULlP
         qbeV6G4H/+pXN+AxaK3fJ/mgDLS+f62xQWidc7UUXXZ2xK3PWw1S6TO7CXLfCj8ZPs4z
         qdTEgg5sMO+T+Atmx0e/qha8yJD0y/16ZfmnkrhHTXM0t/knXUTA1OYkwaUZ7xjX2/tZ
         sJ9Q==
X-Gm-Message-State: AOJu0YxE/fBrvHAZwhCxKOzM076ChueneWn1nJ4EwpGV4N8DeWD/GY4q
	9NObVWcbKdpx9btFvVgH7hpwmGYt7RucQOMwprmOBh6VGDDTdql3gIX+wDY/JMSDubpI1l05L5w
	478QoyAa7eRBKNSutZJwppBjN6tSmJuhsWerYPppObw==
X-Gm-Gg: AY/fxX6LO+gwca0bmgnsd34jMCsCMp8AnkNhB2zT9GKogkJklMtolt5vQi5pMxitiK5
	ZGLIRs7yb4VuruTOTqIr4jRmUH3Q4NFLAZ5/9F7WUY4lB9sKczj0Gi0Cp03kPgGRuuar1XWtgtZ
	oZ8IzkRE1v7AabSBu5XGCRwL+tl195L0FmYs9bbo5WOHwikdXNMv8FdfabBps2/cngahddbNmFg
	Z5hl/Sk799t35VBmoqS9Yl8JQysXt30KZNjaZZwZu3CMw1oXS+qTgkCdT5hwyHxPQ8E7W9p
X-Received: by 2002:a05:7022:2490:b0:11b:9e5e:1a66 with SMTP id
 a92af1059eb24-1244a72e86fmr1741303c88.14.1768537396781; Thu, 15 Jan 2026
 20:23:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115164202.305475649@linuxfoundation.org>
In-Reply-To: <20260115164202.305475649@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 16 Jan 2026 13:23:00 +0900
X-Gm-Features: AZwV_QhAOt5D8K4FCRVQ3uE5njNkZ01Tql0uDAMEtJD12DsjTp_Gz93cS0619uI
Message-ID: <CAKL4bV6i5fAq5Tf9VJ1Yv_X_jj-SHX=8CX=tHKAxwCQStDt84g@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/181] 6.18.6-rc1 review
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

Hi Greg

On Fri, Jan 16, 2026 at 1:54=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.6 release.
> There are 181 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Jan 2026 16:41:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.18.6-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.18.6-rc1rv-g486e59ed73a6
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20260103, GNU ld (GNU
Binutils) 2.45.1) #1 SMP PREEMPT_DYNAMIC Fri Jan 16 12:22:57 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

