Return-Path: <stable+bounces-128298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F369A7BDA6
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 15:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE6EC3B98BE
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 13:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3714F1EA7DD;
	Fri,  4 Apr 2025 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="WtorwnFB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EEC1C84BB
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743772840; cv=none; b=e+8Vyq1xQUnG6t/oaz8KlQ9Jq3OlgQSp9YNpGpsJMlkbO7b2K18pgNzbCbtG9XZH0ZPmjigNRAh8esORbQ4Q0cSB577Ad1WDO/UmnAkuvnsU+WDTUYZDQl8jhjlAk1xpf0zXsdeqJs4xaqwVW+jkxxPayJNBN6MTHdzN9EK5JEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743772840; c=relaxed/simple;
	bh=hJW5FZE9wzMGEzmWLYyjuRGd9tpoV26paptZV5/csOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=paJV8/rbkRZmy5zPyhhT+Ml05lrIRWws37HHNh+R6wEIrzYLPJbR6jWidYSQ7PyKQVljrSOtGib8YZ3/INYZnc9spscCCy6c7TPWL752zD3/HGoOQt+wFukepLhbezGcWj1/ggvhTF0Q7ik/WkXvTf+IOBZxn9zfQ+TkSQEOcwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=WtorwnFB; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-30332dfc820so1996386a91.2
        for <stable@vger.kernel.org>; Fri, 04 Apr 2025 06:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1743772836; x=1744377636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Kiqs1g4/i+eKRX3/NK1xn8WGoGucOOXfAlNORNd6cI=;
        b=WtorwnFBKvhqc7aCGs4hY59Ed/oSicPsTlVbibhVz1J6fJM1zC2iPbVKxr+624xUBk
         C3wDrIfA2FC2I+jo9D80B9WyoU4DkXlhe3+kS2WaNlw/B6zWyZzCP+y7uf9TQbnhVNkE
         xRrVJDiEixA9B9zhO5BeEu/uHvsJYIp6+wWPuNsiGcELmd4dNlMchjdmL5OEWNOJqi5K
         Bvgjo2FNx7IXXYSIi1fn4iMbLNF9/fOrvv8HXwESyznoZPtKhZUg1HVsa9V8J7Nr/xfV
         MHdBTlpmUxxb5UoyWCXLBzkBNSD5UmDDpDmXpuRwzSu/uDgiZMANd2P62P7Eprai5vqE
         4zxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743772836; x=1744377636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Kiqs1g4/i+eKRX3/NK1xn8WGoGucOOXfAlNORNd6cI=;
        b=V0hQGVzVVTKaShNbDuTQjFhMSzy1ZqOmtGlrqRD/Af9iXy4+aeURYJgy9jBCTy3EEO
         aPd0Znay/HfFINFgpyQRQz+1FH5qt+zmpklg3L7A84GlkgG2AwI34SPcah1WYUEYkl91
         7/zzWQP9/feMmDaOcWwdnl7GMxeUvxOD3RFJAXoQxXS+I2u8ONhYUYLaE5XRtrbY9yaB
         DlvMXRJDTvZ1u9HOoWbmCw8PAg8VNpJFPepHHx3gpwXLb1SwWrjIaZdnWZ4SX+7j6S+Y
         ZnG7LqGfhaFhYlaBdO9DQlIV0QyPSbjANrzrzGPITnIGjdryE1JtX4lDyoX3xeraPxhz
         LQew==
X-Gm-Message-State: AOJu0Yyr2Dj0w6JJw7pNdIgxUpd12girt4k0sJlmrLRDSfrC7oim3zVy
	fmZnv8rHQvzavwo0vPYc/dLUVmbimauwWil46G3DaUjiUeScLhCvE0x6dQ32cv1WCXwKVuNOGaL
	BbsA4furOtwsBoRADVVXGBxK2ilYTC/qI9pXF8w==
X-Gm-Gg: ASbGnculgiQV7Gpwe46x+u5LLUt4wgf35DnwAQwlOiXQ1lpARCItBrqMTzQNHgsY7Bf
	FFvGOuN1ZjyvLPO1KjcVbNu3zM/d9rRZazijwFEXFNjB/D1WjdtCUScx7d0DUbjgXUuqfqgEkI7
	5blQDRK2QQ97yfMrLB3LIW7tW2Rg==
X-Google-Smtp-Source: AGHT+IFulkjD6tJbY4C9BZj/bnJRutZmb96NKhGLWA8BRDLemCTGRD/MaqJKIKr0q132IsKbryprJauKtWGVOBdc1Lo=
X-Received: by 2002:a17:90b:514b:b0:2fe:b907:562f with SMTP id
 98e67ed59e1d1-306a488a241mr5725486a91.14.1743772836383; Fri, 04 Apr 2025
 06:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403151621.130541515@linuxfoundation.org>
In-Reply-To: <20250403151621.130541515@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 4 Apr 2025 22:20:19 +0900
X-Gm-Features: AQ5f1JrOLjXtchCUzPwJ2RZcncY7USR5UWmg9tb-6yrsTcTvmjvQ9nHhIM79vXk
Message-ID: <CAKL4bV6hBshXXw5ZCMV7XMOehheoEmwJ8XcDceXDwuUq15H1EA@mail.gmail.com>
Subject: Re: [PATCH 6.14 00/21] 6.14.1-rc1 review
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

On Fri, Apr 4, 2025 at 12:29=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.14.1 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 05 Apr 2025 15:16:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.14.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.14.1-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.14.1-rc1rv-g8dba5209f1d8
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU
Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Fri Apr  4 21:24:59 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

