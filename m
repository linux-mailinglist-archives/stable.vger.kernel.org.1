Return-Path: <stable+bounces-171669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6F6B2B441
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 00:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB2E3B6CDD
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 22:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D372727EE;
	Mon, 18 Aug 2025 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="DIoaKrvB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB13825F79A
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 22:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755557740; cv=none; b=OiVdDPz/u4Hi5drazuzMYE7L1e3YQcap7oz/zlCDLq4Sb22WcLoh+V5gZHrlzjhkKPqtnnwSSqA8r0AcYBZjg4MCvpCtWU1ySKTlMVJSqL/sXRk/RTnLcmHQD4wngkWB47nn8xsn/6JuLkpbmCxi8x7jjadWPbBTmH+Qibh9j08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755557740; c=relaxed/simple;
	bh=QNNh0svKJP1IXn4/YVFb/YlCZ+qTCyfcsqfalwr+f18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JT6tykCCEDUQBn33QYZqgssCQGu9kRa7yuErvAv3IBtjyySrY3W3KupUaqqzrwNcvm3oH2Lu/6VmFNuSFKB5Fh3+toklCgkAceXZGUJZL9zgwUgk6FgsTlTgkXOVIobCfBskip/l3CU9YGa6OMgZP7tPOmsIJ95TqUZ/WCw7ivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=DIoaKrvB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24458272c00so46623265ad.3
        for <stable@vger.kernel.org>; Mon, 18 Aug 2025 15:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1755557738; x=1756162538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bguXmGTgN4Bd/YvdzOLRte6SvfHtxhwHEfPN/3mWt+M=;
        b=DIoaKrvB5ZQ0RDH2rzw8RXUnBzopq7VYTWeGCD/EuHkOb0jOiYJaJ16gclsQwv6ReY
         foSIWMpu7x3DqqeeT7uA7XYJsn99+FeVHzGaRq341C9u1vT8fonGHLQE5Ki/nHgM2Ji9
         l6BbLBeiwdygSexYAWZoCAjYUXMeNKJmN+DMaI40+c6ttifv2YhlDxziFKxnu3geWQqb
         iVV7dNm4klfedy6YHACNZvYPmoQtY0OTbq8zK8wt2t00SXBy4HT5iYHlucRJl20eysEc
         DIcj4kkEW07z03UVLKM4PPgdMKkIwWQLdvfJAXVCwmKP8MXgNg8lDB9dJTeNbjGsE/ku
         C/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755557738; x=1756162538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bguXmGTgN4Bd/YvdzOLRte6SvfHtxhwHEfPN/3mWt+M=;
        b=Gf0Z+lyNdccQi92+5EHM5ihszuoQ10rVSqU8xEKB+sFl3O+i0SfzMQL2y4x/qh2yYQ
         0Rz8VZl2ds8rStJGsked2aYvshiChV68z57C2t29Lgt3jy0wDMyZIegPM/wdn69O+flq
         8zwN8tizkDse8keiMv09LH+m0vaT0m2wnQe+Olwn4/df1RL6FAGCtmuDYFyLqLISxHSj
         qbhoFbypU4CHFzp8BZXytt+vCm0txFi/l7dVVDjnu5IqBXNqfbOuwibgYj+dzib3n7je
         Cd2Sn9Sk37Htz++V5F6KQl6VWiN65PJi5oUoOYvpNMJ2XivOA7gxLkyUauYW+iGtANnL
         WESQ==
X-Gm-Message-State: AOJu0YwjHKrREFY2k636M6TWSpFWjT3jvyTP/WKHPAHHx6j32O+0oxUM
	JA5lLFQJSdtM+el2v2Z5TWEKMWbS0rYAweXpGPlzyLNhgaVUYSfcef6+G+r2kRQI+VTKyiOl80A
	sTs0dAH3AE/rsk3er1o6MXB9jVnsbypIUhwFFOQtWeg==
X-Gm-Gg: ASbGncvucEn72Nx43fFvE7hRmZ8+9W60UGV+75bkjVGV/BOtGSijZ38zqyWiwixs4Lh
	DaNtQOUWE+rUt7vLtqZyzrYjW1708ET8eiZN9FCb7bsJzyzNZAiXmQltyPRmVhei77FPfZ8LtG9
	HUY8kqIVSxVygG86Mnr8vKs1fXFUASfUBKq6TRJxktstGgGfkkw88lHpEQApXqDrM0S86efTTft
	wMep3DgjLQv0//szw==
X-Google-Smtp-Source: AGHT+IGqTfusBp/Wl3eLH4aesenKmL3K7AJRG5soO/sO56C80oHv6CHuRlAmavvZk/O/Ni2sX6LrwrU3ST3yiXgay2g=
X-Received: by 2002:a17:903:2acb:b0:244:9c08:a7a4 with SMTP id
 d9443c01a7336-245e04e5445mr4807265ad.48.1755557737869; Mon, 18 Aug 2025
 15:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818124505.781598737@linuxfoundation.org>
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 19 Aug 2025 07:55:21 +0900
X-Gm-Features: Ac12FXwY6QkznEdzaO8jRF6Tp2__SGYg-Gz6V1qvaRIC3MuAi2b8APUfwkE869s
Message-ID: <CAKL4bV6dKuszLrLP=QJwegSQpCZUd2YowEsmZSNkzChdHPt-8A@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/570] 6.16.2-rc1 review
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

Hi Greg

On Mon, Aug 18, 2025 at 10:53=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.2 release.
> There are 570 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 20 Aug 2025 12:43:43 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.16.2-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.16.2-rc1rv-g7439b60c7df9
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Tue Aug 19 07:00:35 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

