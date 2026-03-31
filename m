Return-Path: <stable+bounces-232559-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KF3qCO0SzGkvOAYAu9opvQ
	(envelope-from <stable+bounces-232559-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 20:31:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1114636FFAE
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 20:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7E52300AB1C
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C844237C102;
	Tue, 31 Mar 2026 18:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnbHEXhh"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182A837BE6D
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774981514; cv=pass; b=N8oxOFS/kmbJCt8t3OQfWuF5MeBNOA01FFB7OFMPeOo7l1LQ81UjTV+F7TLJpKGQKXB2XjcPgfFb04FrtRvFb1i4m0CTFVCRqbsHkNkXFsCgAKS50nTnYXQBgO7233PYc+FEFj88FYhmZumJeBCGSs3uvFWxRWKcAhHlqFrpJqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774981514; c=relaxed/simple;
	bh=vTWd/5txerNR6ocKIJ21Zh2GeUmfEADmayV6P1Cd3Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qEgMrL+dmHFSomcmTcr0afoDLKcCK9D8JgEUQIMDORITUPjvwkBDBG/8uEIVB0Bn0t60z7a+PDamv07DznsJKBR5iiYVkCR+E80lvBJtAgvz/TzDsZ2aCMzBETa5x12yliFOKLoutfW9kUv3vj4+sd7DHXut4TBTILm1Ku2O3K0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnbHEXhh; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a0fc5e2c59so6851939e87.1
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 11:25:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774981511; cv=none;
        d=google.com; s=arc-20240605;
        b=if29eZxpGGG0p03eeAVJMANF+4W5LbkmT5azhVJiLAkYIZTuMc0/j2F4TYzGw+4xCM
         G7EZfIDFbuEweWqS3HdgBomsWq7p76oTifmBplKRX261nTlns+tcOqPnanowDMd5JznL
         JF4fZKeHBrLxJT0VYQgqAtnn8oE/cH/A/MRuhG+Ahxfs7+Mw8P+Hz+GO4kUPpvHyiYue
         bpAu5ECureV48Vn7ShKxEUgxfvab4d8vVR7HsYJ1AqEssV8rTAvG+OPiDpCpcPqygiDN
         ujEYDa7Ymn+qFslGlYEcZ3jImgZrWxWaS8W+QtKjZcoRo7g8woPgezNLDhxUxAR2/tV1
         T13g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PntACFZQg5z9mtUa4D8HfpGNuTMnQ1Jh/pka0ARSWzk=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=fydzvBhJ2Np8Y325Pn8UgGNXyGsTZCUL56iqSZ4kDH51eX78r3nPZzCoBqSPYm7pUz
         KyTm+jM5ayDFM+IU47Zi901Xzx3CWfjgFuOuiDbCM1fVrflynjoqLkzUekLwDGbW7PWV
         JKMSDB2LWM8C0GT/89/8ceOZckRf4NsqmQOdrsp4wnvsuO80Pm1cP3/QPsRM3tf0jxSA
         GtYTk1DbZndHO4Nz9lAp2zrjL4//hyPDMBwNcnsiig4oAlpn0B1f75yFlzX1uCa36Q4m
         uPLXo0VPL2suLutorIeg62aHBT3X6V3K18byn+KYtVaxMDOipDfR6GQ/oFmMPmGiQsbh
         Aa3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774981511; x=1775586311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PntACFZQg5z9mtUa4D8HfpGNuTMnQ1Jh/pka0ARSWzk=;
        b=jnbHEXhhk2mHPAyeWYMOTwHZhYRExci0TcBTK7xm40GG/vnL2qpk9SV+YQ+AVwVfvo
         JzVTdJbpG+QRhiIRpUCH4LHb2Tz9QkuTWWl+TC/wtJrn/cCdoz7hZt/pvWn5NwoH/MUf
         WSvpW+adn2pOEWumfxoQDOyON+XfJXgAeYsLPZyusCsTZzeYaf0IGb39p6PX+pgY8Yz5
         u6ZlAlO8PTunhIIE/sIusdQnXRIkgMWy0puRluo49+q7p3epfyKcm4H49OEiOq/yR+3/
         naPlZjHyU+Dz6Iuv1caBITH7i6qw0nY2ovVDk7imD044qNTICO7mr4LKt9cyPcj+7Yu5
         YapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774981511; x=1775586311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PntACFZQg5z9mtUa4D8HfpGNuTMnQ1Jh/pka0ARSWzk=;
        b=l90x1x3rJxjue6xAVYMzbSqNX6qsL9wU/RLLc4M6Q1NpzPNc5Pz7Vd/Cr7udK9Kf9Z
         thNqBHdfovp1vBaCp3kMNSH//clq3qchU3QAkSgamfsNpvgrjbUjqGVETnPvJaZjR0zx
         zT10Ljl1v0N9U644KGNkm5gE+UN68PCVAtBh4LRvrg8N9JIuTqxdryPm9cchV6XYa+Bu
         Pi2tikyd57RTpKVTT63SFCfdBjGYVLRvNzkFrOjsvurgPyBBTvxHU0YKUBs3jmOwi8ab
         jpn9xkMwsD56cYt9UgdWPL1BkGr4wh//eupq3swUDg9XL2CccUue5G7wUTLyyHF1j5Gf
         cs9w==
X-Gm-Message-State: AOJu0YzYVUD09UH339PwZ94u5tkhhZGuD5AbKNL9EsV+bTbeg+YbkLsZ
	xMqv5AgrfOHmUGz+6e2G8VzHQyVnXbTk3KqFmD4K1Y/FasldM65eXDpLNMvDBZpuJPNkDY9242/
	/UT8M3GtvsZApc6nXihcq63oRRPU+YbUCFOWw
X-Gm-Gg: ATEYQzyacPD+3w5JBj+xyRAChnsJzaV/oWIzkvHzV67OgDOGatV8OMJFFqJCyCQBPkb
	cGMDYjYWm44eFxsH3ykAeJCwlGXQtX3/14cKjZLYShM6I3szeXmNRwBKtJ7N7qWoX2yyrmasOcW
	OO+hf59YLT6e4r362110qPPdbw3Z7CBRETzCOY0uqAOPDKAIlQ0g4s4XyHdiBm9KX5veBG0OuFJ
	/OpYz5Ef1onLDpwgy5LVrMoKGLhD1Vy92PY8EpMm3XjSJuTnO9e4fSFfkaLJL3lqkeGUgdxo5QH
	QQkVIKUBLkQaBRe4FAvDlZzeoZsr5wBbXJyH7yFxVg==
X-Received: by 2002:a05:6512:3047:b0:5a1:448b:317b with SMTP id
 2adb3069b0e04-5a2c1f3b10cmr176273e87.42.1774981511023; Tue, 31 Mar 2026
 11:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331161758.909578033@linuxfoundation.org>
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Tue, 31 Mar 2026 23:54:59 +0530
X-Gm-Features: AQROBzDJx3vNak3oGS7asZcNSCohTEGtmqc9XYuavS2Fe2-SJUVoo5tp3uAo77U
Message-ID: <CAC-m1rrRUvxNs==Vzb_myMdRH_nCFU6oPqhQc7+pHcZAoSBQZQ@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/342] 6.19.11-rc1 review
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232559-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1114636FFAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 10:17=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.19.11 release.
> There are 342 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Apr 2026 16:16:56 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.19.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
Build and Boot Report for 6.19.11-rc1

Build and boot testing was performed on version 6.19.11-rc1 using the
default configuration on both x86_64 and arm64 architectures in
a virtual environment. The kernel built and booted successfully,
and no dmesg regressions were observed.

kernel version: 6.19.11-rc1
Configurations: x86_64_defconfig, defconfig
Architectures: arm64, x86_64
Kernel Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
-stable-rc.git
Commit: 411f8a553ae8d2f6aa5462b6dd5f1d6e9103fbac

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu

