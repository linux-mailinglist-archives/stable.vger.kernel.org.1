Return-Path: <stable+bounces-71408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CEC96266A
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 13:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108C6281F4B
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 11:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C9F16CD2D;
	Wed, 28 Aug 2024 11:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="zgWcFE+m"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC7116D334
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724846041; cv=none; b=rDb0mM9Kynjo09uTYZuqkbGukz8yrpQk8COV3KjyCpogoRzykkOI4Q94X12hxDNWwzFYG91ZMUV5vvb6UVJ5mLj7GbMCk4Q2RLK2iz9OnlVGhoAP43YvoAH806Y+lagFmgX45ghNH+/Lv1KM7z5k2jgOY26G5G9yjBla+TLS4d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724846041; c=relaxed/simple;
	bh=O5gRyO2dJwvVCjf4Lq+k0i1gW54cEy1YRZ2SK+gyhV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGI1ptCfrafj35iLdlq1Rp1WiuQm7zIg3UjEKbB7i2Zf9wIT97dFu/hcvxNv/68hpcYg5VvYqkprSeZ9Kim6Mgf/8s8J/AMFX6MtYDFGJ9bHd4BsE2cn001Zg4r8V2V6Goh2S6ppiTz96tvGAYZtlFbobLwYg/Ljb5nou3eBu6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=zgWcFE+m; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3718eaf4046so4841112f8f.3
        for <stable@vger.kernel.org>; Wed, 28 Aug 2024 04:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1724846038; x=1725450838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDiNvFz6rdknbMnlsxqJINMU+j1qzEyGSwhUAud0ULQ=;
        b=zgWcFE+ml+/r5/ba8olY5XcoGUyapqtZuxK+iQwLRbjTA4Ex3CT9E/Bl6ZH78+vxWU
         BAZcX0243YQwKGBIvng8Z0X57NhRjp1TGYtjAuJGLLGjqHqGvXQRXm/jh0lI6YG9yZKj
         pFJ6uzII/XyKOredsoBPr3eJN2TfP3kxOUEMcNXV3pE6AymrsT4iNxedUIEI45Jirws9
         /ZKU4zcqXmAsBL4SneSJpw0EU/JEa106tnp+Iv1nRXqnzqRaAF/8Yt+1KLA6CTsXdcxq
         M6szVjC8seJ2+DrE1VMIiJzFiP7I4fBi+8EA+qn0NbKJWg/HNq8bV1a4fiaVGWJLm+lt
         VE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724846038; x=1725450838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDiNvFz6rdknbMnlsxqJINMU+j1qzEyGSwhUAud0ULQ=;
        b=YkAfh6LnyR3V4lyXLr1ar2I54x6/B8q2DpWESCRc+0JmHNervg2AWaapfQ+F55dZ6Q
         K664dNVHfPoX+yo2DLfRbs3y1tmVlJeOVYDjBAavMO2pI+N2QLLflJ3jn+IdDYIEUjxc
         3TUzqTKQbdGhKcSaPfrHCaGZFA/7RoXZBFsvggBsSZbPt6/7j4xxTTawlRaAHVZmt56o
         ZxEcMnXP0nYF99k3lqqdgQ5SPk8wpBVI2IML2DNH235ZMnwOZCjQfjwPTdL97MtLzK8k
         sNGXX+wDOslro4KejMG5ZpRwWiw2HX9TTlwptOfmfeeQ+a/DqUal9O5KWfrvL4hvC2g1
         LwHQ==
X-Gm-Message-State: AOJu0YwqV3gw4te/OE4w95Y8eHx8yqt4CFaFKtLpeY534ivFoFe2q59v
	fRWEoq5cX1np7H9+v922hRoegaK9VTdPyMKiyjzUFgJR84ocyGgjM7n5y/9ZrFz50+qmhGHt3pz
	svdD/gmkt3YYV+vssEbnOYVHEWdAkXfIiqE3J1w==
X-Google-Smtp-Source: AGHT+IFMWJPVBATysLtHqzNH0xeMJFF+wNbScXEeMxIJsqKta5Qy2aj8q2fOfZRtrVc3Zz9FY/1UkXj5heT2s2GHOug=
X-Received: by 2002:adf:ed11:0:b0:36b:3395:5363 with SMTP id
 ffacd0b85a97d-3731185600amr12989156f8f.16.1724846037761; Wed, 28 Aug 2024
 04:53:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827143843.399359062@linuxfoundation.org>
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 28 Aug 2024 20:53:46 +0900
Message-ID: <CAKL4bV6Jhp4pjBbkCe7m5639CmFMv98SF0aVg4SkksheTTOpXA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/341] 6.6.48-rc1 review
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

On Tue, Aug 27, 2024 at 11:42=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.48 release.
> There are 341 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Aug 2024 14:37:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.48-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.48-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.48-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240805, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Wed Aug 28 20:10:31 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

