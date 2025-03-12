Return-Path: <stable+bounces-124142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90954A5DAE7
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 11:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096D73AA232
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 10:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DAC23E342;
	Wed, 12 Mar 2025 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="jlLszTkb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127EB23C8AF
	for <stable@vger.kernel.org>; Wed, 12 Mar 2025 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776744; cv=none; b=GZzzD+i7JXoijhMG/2ndUmk92Skxe27l6SfJ+FhL1nGTHQLbmkIYUvh3d7IIN7I6d7gqT+kLkYdYVRUb4bVYMpRvG67MlIHMQST3Erapqq0iVzGwSDqFwBIGtpqNCEVxYskuKi1q8yi7eofpoh+DHBEYVT+rBsD0pdFjjuFx5LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776744; c=relaxed/simple;
	bh=gjbUH7kAKKc/+1hKX36//HYzvvD9fqa3xfDCPoqEeBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NkyITtdaG6j89J55sZb1wRhscgQlN34UEVivvzcTzGy3BDKMq5UUee2NsiAg715+gOxyfUnrxucnuGQk/bgI6Mlbca346CRZ2RiJnnXSG39nspXtX3Pni5nHuk86F6IHj+D2I1FJqKY9I3jbvviPiQx5F+BYRNddzRfngHqvN7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=jlLszTkb; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so13275243a91.3
        for <stable@vger.kernel.org>; Wed, 12 Mar 2025 03:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1741776741; x=1742381541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3+PiV+uBaafq4RBHeVzsDnDBDg3GEz+NalwGRbaU3I=;
        b=jlLszTkbrpbkuDSibxQVNvAlG/6lTNYiZW4qlA0j9d1c0DYOrXWUmVp8yhUdvOOI5p
         VIxh2urfncvn5hzxXXeQk12vTj3p0JPH4j2Iur5oxaLsU9c+HwH1LycFUogiwSmjYv99
         /tFBrgeKL9Gg3UCnyfq2nY9nfmzMc/SH+4ndEcSrYaoIl5rxJbVthYGevAPoVKgb39Sq
         nFkbwxp2LTxkJJ0L2P3FsL5g9JlFEXWBtyV7A4QnZIafT8W7XyV2xFPxibDK/kGqY1O+
         w3YACDyfDW1UGwD6aTA9w7J+tGfGtZnzAC3Gzrc1hvcbCwM8cxWolzuKL8z8rAUGXsbX
         epJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741776741; x=1742381541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3+PiV+uBaafq4RBHeVzsDnDBDg3GEz+NalwGRbaU3I=;
        b=TzFo4N7x/4floxjN6R9xMMsLbpAIZ4cgm7ye+zNHdp2V2+oWQmFokJdNwPxNZABsdm
         pM1R4ntC6ctzS/fofAB6wQvYJhASJTQeLSt7rM38VUYXumeLMnJmTdYbj/DOfzCKz+lq
         rBNd13xVjm2T7zVaLmjAXxBwyJ6Dn63GRMSNNZipxEuxVJjbnDGsTpfuIM0nOdeB+mnQ
         u7AftF5PplFZhMkqKLfomydM80FkKrFdMf5+FzV+BxQzwIDNhsci1ABA1nuJoNeGlJna
         d2GJAIw6xjXGGB9qD77bZwhICWdGN31o4zviN4kbAWW4+UMHrJhmO6qPfGUUf9DQ8Q2H
         071Q==
X-Gm-Message-State: AOJu0YxbPozJqyEMSQLiR9DOxEXSkO3zd4MsTOvirFclTAFYj2jAPRo0
	1VQ0dfYc/l3gfFLsY4Fp7VCdaf7ALKGai1pC1PtAAHWeVkVlYYGK/M4WzwqoeGykkWd0VcWOSq7
	UZjokdQh6cnmq67f61Ixa8EVhVaVrPyiRFRp0BA==
X-Gm-Gg: ASbGnctvzfZMJj5elI+SX+XLyVtphqiJ1/us+193cJkve3vP/m2Ejm3JTbUpyOb88z/
	/OS0ZR7brdElyseqlMX9OBwhnXlNcIjdqF5P8thLDWtlEjR9thD53w41n634FSLjoDm+OMZECc0
	yZ98uInrBcYV+0SUba6Cj9KFCDmA==
X-Google-Smtp-Source: AGHT+IGXx8ieZdctema6C598fuszKIgN/8+VSXT227UVWm6XgcSn9URsXMi9AG+8LL43/vYhgBTSwNHH8ZLeDEUYwIQ=
X-Received: by 2002:a17:90b:3f04:b0:2ff:53ad:a0ec with SMTP id
 98e67ed59e1d1-2ff7ceaa31dmr28985099a91.21.1741776741223; Wed, 12 Mar 2025
 03:52:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311144241.070217339@linuxfoundation.org>
In-Reply-To: <20250311144241.070217339@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 12 Mar 2025 19:52:05 +0900
X-Gm-Features: AQ5f1Jp4vzwvaXW8Cwgt2_Y6jV8MGhoF-jpghBXlm-wtunoGhrfsN0XP-137aQc
Message-ID: <CAKL4bV6jjxYR=x5=r-bed5Hck5ZmOAKTdM-PxL9-JTG03WndTg@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/197] 6.13.7-rc2 review
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

On Tue, Mar 11, 2025 at 11:48=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.7 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 13 Mar 2025 14:41:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.7-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.13.7-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.13.7-rc2rv-gfca1356f3f51
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU
Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Wed Mar 12 19:21:39 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

