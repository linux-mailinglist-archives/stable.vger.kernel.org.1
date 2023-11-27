Return-Path: <stable+bounces-2792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA477FA87D
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 18:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B831B210EC
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 17:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D33B3BB3D;
	Mon, 27 Nov 2023 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GH0GJ9Qn"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF456186;
	Mon, 27 Nov 2023 09:58:15 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-58d1b767b2bso2292749eaf.2;
        Mon, 27 Nov 2023 09:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701107895; x=1701712695; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gbVUsMmhBFYQhL3K5acsfFEdBlZV/KGoXmBwjmEvAxw=;
        b=GH0GJ9QnJaeQIyYRdpNMXFfjbMQRyKu/MfHOBYmPVuV/bNUC/heR0w3pjNSNyEaTNU
         K46rpBvkXNnn7C3WgujKnM6c4HM+/ThxnCFal/alaR9tKops+vdDhzNsPA8iheofQ3Gc
         tlREYqmteCoUTKH6+udmXRtnMREqN4ZqKXcT7yZHaeTe2NzUveMb0LW3K4E6do86plMy
         w08FkMDEX2k+jZrFY2AbgAFU9JjZWrEuaAzJGU5LqGi8yC6rJo1g81BH1nHALt5ir+W4
         IGp5hPMqM2LQDK2TAMVy+dXQuNurmrYLmNJKB/EBhS+ntUrtXBEYLk4ey7zJ9b+s/4rV
         CkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701107895; x=1701712695;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gbVUsMmhBFYQhL3K5acsfFEdBlZV/KGoXmBwjmEvAxw=;
        b=bOMSBRwkAkdtRK0L/+8gstgN0iRn97afXYGKVh7k1kFSru3ruuIPEkOzV9lCepyO+X
         HG3KCzTRSTlWrsBkapXpEf7VEJt1J9Q99ksZnfDbqlBjkSQn+FL1AADGlrUfQrk+o/Db
         Lpy7qT+50w/Ta+L8Vi7zt+XBlZTYgvbe4rAzKADl0XXBAHV0UwPQQmz1YLIRyhemogXO
         eKoHpWMRBQH+LBIA0fUvdldDQnT9ApqNxGo4X1AaOeoqYqSiQkFlQEkxVJTYjRQBdKCm
         DghXBwjh9bCl2zzP/k8QZiJN2bvIlZrG6JJ947HJHAEnD0MMAYaVp6OmZ1ZBj9/NWLZH
         RRaA==
X-Gm-Message-State: AOJu0Yy5GZkOolc9042rKhbxvULtgpQnufbsFbCje1/SFEiF7pFM5pc2
	1Umu0rK5ZimzsYaDnA34yy16UMuqZzS2hD/hRW8=
X-Google-Smtp-Source: AGHT+IEQvQcO5ygU+WPtLyMNZuQgwtHC6e4Zk9S9tzuV6H91tnxuiHnljv6ue6dwtR8xy5TU2B0P2NPhEvaXmHpGFRY=
X-Received: by 2002:a05:6358:52ca:b0:16d:fd6d:58b2 with SMTP id
 z10-20020a05635852ca00b0016dfd6d58b2mr10877692rwz.17.1701107895165; Mon, 27
 Nov 2023 09:58:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231126154418.032283745@linuxfoundation.org>
In-Reply-To: <20231126154418.032283745@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Mon, 27 Nov 2023 09:58:02 -0800
Message-ID: <CAOMdWSKKEQ05J5UYXj9oGUYfitkReFoS5rBKeDMXo0vUkd6L_Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/525] 6.6.3-rc4 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> This is the start of the stable review cycle for the 6.6.3 release.
> There are 525 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.3-rc4.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

