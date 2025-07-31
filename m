Return-Path: <stable+bounces-165612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4A2B16A7F
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 04:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C797F7AA3C1
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 02:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA782367A9;
	Thu, 31 Jul 2025 02:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="rPD6TO4T"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2196F27450
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 02:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753929599; cv=none; b=r6uLT+kSHQ2vofNAZP7t2cde0OfsxgQfikGEZClLyCNae+5K43o1Avznfq546KqIuNdxmvaRZj0fSUNuDTeqOLedLirFS7tTO4VsBMZ/TYOZfv8SR6hL3ItTFbunYULVxrLy7FWruphwpSKRaCvEcn/o6LFtzTroxNvaYRm7YNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753929599; c=relaxed/simple;
	bh=/ywKHejRlAU8NaBUfYedjpYE/KbEhNXMYBNdpYwavAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dp+7N2ABGvE37ECacpHeuNqWyjaSY94bwzdSyeTExHiLuAi/RJNw69OE7EzCW/p5pDS5DDj25I3vWy5ORhxvd4lXrgrHgkOPHtuju4b0qZfKtGWe2ktaFQDWi4OogKDwEwaoHoJ7CgtExn38CxLhhXa4rNBlIY1l392P6skPfvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=rPD6TO4T; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3190fbe8536so478905a91.3
        for <stable@vger.kernel.org>; Wed, 30 Jul 2025 19:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1753929597; x=1754534397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gik8kQn3CflT6JngBBYv+kUUKNngOz1ckMzDNY3dGCs=;
        b=rPD6TO4THGAE8vjsmrJyHFAzhgSwj7Y4CkPjq9NFL1Ic7iENHvgTq2cqRG4K+lzNJs
         NnZNP+3lGwjnp+h8zWGsL4L1o5H9JXBx6QE3trupV4cx14ZimztXpQ7vyjzY9SXDdMr1
         1DzcrPvsKiZ/93PJtMfTzS1Z1hTnXLPMS7J/AVRAVCjbnWETobNNXcm9x8TNHUnYL7/J
         smmTYWApBIQn0J4HVGBf7/10a5TerlDJ/tP/giHy4S5vfFYhBnAcs7tfn/GXo2ama5mG
         AfSNV0OQ0Z7nCytQjQNQ+N4NJiBQGQLAPxbJsqzl0yqZseDNOKQdfnF20i/MjeCTnI94
         prbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753929597; x=1754534397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gik8kQn3CflT6JngBBYv+kUUKNngOz1ckMzDNY3dGCs=;
        b=eENp9Zk2rhlzm1L/IfK8YsO+fXPxJZPMaALGdkVc+ugbbs3XATzx1NzvZmUftA4zkm
         tEAgEiIE/A4/9ksRIlC3fK6wYIu8nTAAJHbkErlFk4PD4jv82hLQDiYf0DkmrnrGBNbe
         55IorJteWtuy8DmVmYuWL1dQ820UZunTgSPOGgS7VOpeomlrv4TW1OG0UC3CSjU6AYqY
         catSvr0OkDFxlD+cBIQf827DMSx7Nn+tMXHcOnUbyrBU0mJjxkPPHZnagRuHqW77eWuK
         1spx2tqcV7pOI4KgILLUzV5AL+j6so5QphLr0HKBYEMP4uBgHF8SnMVa/34Fkj6hcAyS
         sGhA==
X-Gm-Message-State: AOJu0YyEjqpsF9OIXMT+Yd5vhA0s25T1NiZrpcxdm5iDsMQhK4FcnaER
	qq51gJ3OXVYl9ql7LX2qh4L7P9MtPpF3BjRMksuwd/rYx8Po1xjjnre4ZgwzACA/aPqnWSHGVvJ
	OKmyLstmPd6byIvxc4vxpsSBShRYqc7XKPYoS32oOgA==
X-Gm-Gg: ASbGncuMcO5ZRdgGwCvU9BSVP+b1rmWCAVD8d+j4W4FDl/w4OZG/DHJmFOVc80fT+ck
	19tEV1e3ghVhwfwVJS29yFsI+ghyPeD7w4EqcPdamXoR3dBRtKsV6kdqpaG9GZEeRPDI5PMbWLb
	j10wUW3CEGkPIawu6e5fZjGVeS4YEJOJk6MJdEu0hVv0ibxLDb7n7Y+HdxaFTIsHnh6XjpRWDC6
	YNUiw8=
X-Google-Smtp-Source: AGHT+IG/yzJp0Zgl3QCj8JLwCRCOvmPQJgUimI3WOMMUebwa9O26lDVm5Bh2U+dtqirpR2I3YBUaWNWHtOPoD3Edbu8=
X-Received: by 2002:a17:90b:55c8:b0:311:f05b:869b with SMTP id
 98e67ed59e1d1-31f5de58622mr7607661a91.30.1753929597272; Wed, 30 Jul 2025
 19:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730093230.629234025@linuxfoundation.org>
In-Reply-To: <20250730093230.629234025@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 31 Jul 2025 11:39:40 +0900
X-Gm-Features: Ac12FXxxs6pohzDYfR3q2pxRI0B76mYhfNwsHqFTuOdiVngA3WZUVCPz0nIqHHM
Message-ID: <CAKL4bV63xNamSc_5tDuO3uXh7VRnG35F=q5Mo++nivZYWmVH9Q@mail.gmail.com>
Subject: Re: [PATCH 6.15 00/92] 6.15.9-rc1 review
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

On Wed, Jul 30, 2025 at 6:53=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.9 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 01 Aug 2025 09:32:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.15.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.15.9-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.15.9-rc1rv-gd9420fe2ce8c
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.1.1 20250425, GNU ld (GNU
Binutils) 2.45) #1 SMP PREEMPT_DYNAMIC Thu Jul 31 10:55:42 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

