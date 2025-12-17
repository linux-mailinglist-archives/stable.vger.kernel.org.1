Return-Path: <stable+bounces-202798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF391CC7569
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 12:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF1E4300A29C
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 11:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F285C350A29;
	Wed, 17 Dec 2025 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="K02+qSKP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AC9350D42
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 11:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970998; cv=none; b=DGsSyWR6JUM6gp45Vu6MttWHoRFqkVEvKxyuIBSvY0eCuJuK9gsP6mfJBzpn3Xxn7/5TIy3oaQuAKQWTnwmqq9WmTD3oTnI5yJ4YQnglnKaZlFfpjBQfAqU7RBdn6vZt6EP0b9RtrLkAIZd33bB0xeCD7+D/lMTictclHQNOAo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970998; c=relaxed/simple;
	bh=+eORQnfNHkjJr6Xg2rWitskVn7+r5m0p1og7dg3w4bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jB6IO2WmrrpL+Tw4agR9fIVIUDCEaDR/Te5QHVdh5Fbg4kjjtCoQ9wHJkZfFHEXn5xEv/xXyZehvMpLELXiv2mjih1vR/X+51hO5F92b+IgzDNHyAVNKeAH+QUTqkDjN+jFrLLB3iyjE2JbqwjxHCjza7TbFKWSVLADOgNSkOYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=K02+qSKP; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so5365415b3a.1
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 03:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1765970997; x=1766575797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/bisjBvmzi/1keCLo+ftK1ux8Pzt0W77oVsy9zZJxE=;
        b=K02+qSKPNEV3e567XKNcIBZE2Av9TC+fHbzvkrHo0dzIM4s0dEjFhu4EajHFoHpTDd
         u1QOL/Fo/LxvbNloc9TDkZonJNnzVNP5igPJSWK17iE7GoNJ3V/U8xfl61gyHW0IZk6B
         GJ4P6DszePSULZ9//bCwVmaFtBqmKV11dqzsggcC/WJQ60Vqk3g9jue12fr+VdiHroA1
         SjzNRiPAFspgvF24w3tGFnDPY90gwX0wHnEu9bzJk5R0PYpy41uiuuqmTegKdvjXz+N+
         B7hmiTvgkZLvadETUyk/nhWtBrwrbmcSerb4i7JN/TjJ4+Perf/kwSFxh2kCWpD4pUTq
         cM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765970997; x=1766575797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V/bisjBvmzi/1keCLo+ftK1ux8Pzt0W77oVsy9zZJxE=;
        b=SeSEdmLudnUP3Y+GT/R4dsP/85KlYoXMM1pfimNQRMdHS634DbxArpU5LHDOrc0pvo
         JNA2Hu//cCiXQDUY9ShxNd0ZMmkh2s0WLPQ/ZRkhVsMJ6tgTa5K0z6/wZf6e6EzvhFpW
         9US9FC0GcUOahN0CzcKL4Ja5WrCJk0gtAXnJnZJaeYZhpnk8Dlf1iakmUKyuHFWuX73k
         4Dl3oUCR2/IvsHBVvNfRA3j90RRy+4m6G8i1h0ggnIZkZv3VbVsiEG+nsl1zo9eHnF04
         j4rgQO74L5jePrQyt9WI8++H/8KzTi7jfyVunjyxKadlhfCYKKnLygEhkB2ArVrtSZPL
         pNeQ==
X-Gm-Message-State: AOJu0YyB12paewsijmvUTNfnFEAiUoU2Gl7HhxkDeWhiMwRKqmlduC76
	rlaCcMZcrKQyieN1zJtYxNyCz4uu+VnzqPoLaQrIEWTw8/eDrAEHQUhq1GcZsUsXjletEPbasil
	JGUwEqq7ChJZMta3PaKi+e/YjAWmPZJ2ueUUcSWDF/w==
X-Gm-Gg: AY/fxX5zuMYzPUevtyeEBck3nNtkKN2/vFB3olrhhjwzYCQyYRDZURbqC+2q86jo0h4
	cdDs3XfOMJFJY0h4l3obw6z3riKl2f8a/3J5wvGeFNWFe+LsMghPlysDd3CYfPr2/TFQr/S0FzB
	0hU3d89ZGjqy2UbEvPJd48vVojB8kI4If4XTO3OD7ZOTzhjXtVoDnZu2/Tn8H2f2blspMK32ATD
	NP6n7OBm19fT3lfmPmz6ZcnD3we9iNRhxhO6p5frjZHNYegz3X8CiQRbiU19lJAM0IsDhYU
X-Google-Smtp-Source: AGHT+IG9P67VgmuMOXLvK3GgX/2Zc+rw7osjUXxUy22ujhVRSbgY3iniAtS3kk2B4eaDG4h3v8T9DTPeaAN8joiuMaw=
X-Received: by 2002:a05:7022:f511:b0:11b:9386:a3c3 with SMTP id
 a92af1059eb24-11f34c395a3mr11192278c88.46.1765970996468; Wed, 17 Dec 2025
 03:29:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216111401.280873349@linuxfoundation.org>
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 17 Dec 2025 20:29:39 +0900
X-Gm-Features: AQt7F2pf2_9_E_Ow300D-yxZEM9q8XXfC7h-VNZnJ61nSNkFexdW4YoCWiUN3HM
Message-ID: <CAKL4bV664OmkNuNqTZTKMjwYUBNSZRxQMM=wuwdFZJEPSVUNVQ@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/614] 6.18.2-rc1 review
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

On Tue, Dec 16, 2025 at 9:53=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.2 release.
> There are 614 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Dec 2025 11:12:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.18.2-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.18.2-rc1rv-g103c79e44ce7
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20251112, GNU ld (GNU
Binutils) 2.45.1) #1 SMP PREEMPT_DYNAMIC Wed Dec 17 19:51:45 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

