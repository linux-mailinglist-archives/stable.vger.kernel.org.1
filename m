Return-Path: <stable+bounces-241148-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id R2QqGSM+7WnJhAAAu9opvQ
	(envelope-from <stable+bounces-241148-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 00:20:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BEACD468073
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 00:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 957CD300D6AE
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 22:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCC5382F1C;
	Sat, 25 Apr 2026 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yho5LfdD"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD2D3822BF
	for <stable@vger.kernel.org>; Sat, 25 Apr 2026 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777155614; cv=pass; b=F2nCIIzw+1xeyWAmzwMzmClSS/XZlUDOTTWsZz653M6zbLP76bTzCAe5YFikqQHBJ1yxvlVNkns2ZyxYWTORd5mW1w+UnD5q/jVZ/2C3am+5NmPl1IwwqwJvidul5iFF7jG1TQ2cmFxpMvU1mT/jNMUisyAU3/+EHbK7yUltOvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777155614; c=relaxed/simple;
	bh=PrYaB+nuPevR3vXc/LAPV6jrBso4CMNvE3hTiLwWF1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQfO2vQUroeuCSwozYra6t6qlPAXKQNSj8anFdEjIzExi8vas/RxcbKzGqhY8KSVo/Q7YLYV3IOjSxX4mqpgOUKBFkmJgpdnz4GuBWvrwhHv71oQmdqPkhFo5eDOUUVRnLHPix9Lf8v6BTvKC39SzBnthmO+R/s8osQZKnpLtNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yho5LfdD; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a3d42263e4so8872333e87.2
        for <stable@vger.kernel.org>; Sat, 25 Apr 2026 15:20:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777155611; cv=none;
        d=google.com; s=arc-20240605;
        b=iYebbKTbRTNHAWdkTRqmXEyyaChqJ98woGEmAl69k1+5/2AwnZjNsh05W9pGMcXCQu
         vTqOD3yaKsh5TdN0LLEBa5IRquJ/NLLykfxFXdoVgLOKkujEP++g4+yi+Olq0G/cTTqR
         pA8XxWwT8atm2p3dnc0viQppm4c4TrUy+CE4DcEqcIdfLssu0emDlpp1IBfTDB5Rkq8U
         UodhIeidmAeKaA+f7CuDPP7kHDQ5nJg0SDDe+GIZsLynzdeb5CB/ElXVTRUHQdncAeNn
         JTiaBdHnpUqmjQES78HoRPNE7V/OGOoP3GqB74cyBGjoHEJvCHFVhCQ1bhFxCJ6Y7/UQ
         VXaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2iwLFmkmCKwubEVSy1rfo6FTR9VvgMF9EWfGsJg5DJk=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=YCi8WDC61RXeR9U2t4ZxieiDH4gHUSdqmtjmbEKQ66JEMvvJ4O2zNIpZs0YlrTcbBG
         s7YiSkkigST+wJ62NOSIJWnlswSR5ai70B6POLoMXbGUVz3+Q0dVgenZzeaqVcc/GOFl
         b5A5VAKI4A2TSmfgLfI6PWdg/vE070IZY8aPRgPcuoyxQ9H5Hed8dkT5CcI0qgxOWEQL
         NMxfTk7CE1DwW7lkq1r7MuMlO3SJMo/YnjV+0nMPTRruB8J/u4Le1zYb7iDvdSbdPEx9
         y07yPRFdku8HVNCx2FwoULzR+EK1wQi2VcSvC9NAcVYq4UkIqGp+eUvsb5efTzxNSg57
         iX2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777155611; x=1777760411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iwLFmkmCKwubEVSy1rfo6FTR9VvgMF9EWfGsJg5DJk=;
        b=Yho5LfdD8RFOQHo7oXAqaFI3tsm9jNB9/hCLois+YruM150QYHB74BBgDodZWxNWff
         tWUVD6+xmhj8rgGRSYKFK127cPpKsLt7NG8qvO+B+WsPUwf8F+qN3HsMu88GGdfQjp3X
         VidwRElGi+s3iMLjnbLWAoP+5luPEE3gjOlsVTD70uBRrp6+oMDpt2SaQjBmAaNAXQy/
         p6JFqZ/kseZpE++JCgcXvHoLlKUMX29bAoKuNT4nk6Qy0vdmXd87Eydk8nrZ6iWimYj1
         Lx70oaWgdw7RXfHkEA6wxq71NL7BDprBaD3nyyYImgJdi+zWXctvyyDwF7bmgvftwF/o
         EdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777155611; x=1777760411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2iwLFmkmCKwubEVSy1rfo6FTR9VvgMF9EWfGsJg5DJk=;
        b=q2bFCxO3kA/F8XZfKO+BY3uSVyQYdHEJJiYMYvR1V7gjSDltp8ka565rPWcE4uD8Hx
         4i44jtNiz+cFnQxx8tAsQjd+iZZz1l58WF4o2X6nfWzZc3qxjqlz2sRt9IJDN/qTt3T3
         EMTAvQcFR5Yc+3kHvQFZrX14kqYlCY9Q1MZJTzVOuLpnD0sI+qpzStwhUSj/saGGBJRn
         YbmoCcqYfMk9cAp4l23vspYQyvkT17iEoi/DAsxsy84X99vx5DFBAcNKeK4ZlySGXPI6
         Wfs0q6mAA6ywXACMiZDNwOnDHaaiuw2xsi+1vCzXSxBO5CZESlG5i/HBpdp+g1IjSSAZ
         I6Ng==
X-Gm-Message-State: AOJu0YzdEGTjwNNNXJz6dzIFCYeRAwJgntGu9mn8DLW1gqi9HHQB/GZA
	a75/PvE4kj++IPzIbpLz+4K7io9cIPITL7K6RYZsBdvlP3EtRSrfzvLlijX25b1yM8vLW6fFYyf
	tBK85dMsyTxdPjJMWv4YGOxZxFC/UeJStaCpW
X-Gm-Gg: AeBDiesxBrwjlhDgtP7gxFkH7jTQK7He8k7D7O2lxzoSAETpSNvHeQ+x5zxfMS6So3n
	G5R4AGmWLXKb8Wz+P4y0anV6Ikg0u1U/7gUTQnynyuNYYnKKzlUgBYfvCJCXmp3ZpBWcfniTpnO
	1l76PQWMpwJsS5qamOMPbNH+99PQNnGJNizsdieJeqDEO7x41wzIw/MoGj74y730KvUDDDND3Xl
	YqKLmKzh8xp5VJ4sEMW27W4es7Fsv+nd/RaMWuLe9L0pntf7bATGqGAlA0xHjx2wBsdmp868V43
	HjIA4ka0pW6fJkU+QZajikicOaseNrN+idRgDbcRdCnVnAdxxZc=
X-Received: by 2002:a05:6512:3f15:b0:5a4:6f3:df5 with SMTP id
 2adb3069b0e04-5a4172e2d00mr11233638e87.29.1777155610465; Sat, 25 Apr 2026
 15:20:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424132420.410310336@linuxfoundation.org>
In-Reply-To: <20260424132420.410310336@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Sun, 26 Apr 2026 03:49:58 +0530
X-Gm-Features: AVHnY4Ky_m_JioNNP4XLWEamao25keQJUB08If5UpCJ6aWS3riLWE3AuK7Y_MbM
Message-ID: <CAC-m1rpZKzivfC2sw08ADJoD3F=gjk9dYZQoHsLFJNK4u9JLFQ@mail.gmail.com>
Subject: Re: [PATCH 7.0 00/42] 7.0.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BEACD468073
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241148-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dileepdebian@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Fri, Apr 24, 2026 at 7:03=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.0.2 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 26 Apr 2026 13:23:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.0.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.0.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------

I tested kernel version 7.0.2-rc1 by building and booting it in
a virtual environment on both x86_64 and arm64 architectures.

Build and boot testing was performed on version 7.0.2-rc1 using the
default configuration on both x86_64 and arm64 architectures in
a virtual environment. The kernel built and booted successfully,
and no dmesg regressions were observed.

kernel version: 7.0.2-rc1
Configurations: x86_64_defconfig, defconfig
Architectures: arm64, x86_64
Kernel Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
-stable-rc.git
Commit: ce7a64af92ed7270208a84dce3ee2e63614212e9


Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Regards,
Dileep Malepu

