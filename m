Return-Path: <stable+bounces-238185-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILHyCSTb32meZgAAu9opvQ
	(envelope-from <stable+bounces-238185-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:38:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDE540723E
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F8F83008621
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B675A382284;
	Wed, 15 Apr 2026 18:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRnLmwa4"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CAA37F8B6
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 18:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776278301; cv=pass; b=ibCab4MZ0OvMz8QJVvDuld0JZ9AvOp3CxPkOC1rSEVnhF4X172qvpnfv3PXUswNlJqmqzV4Q+vaUKfL1LHBRTeutQxEoR682rSnLg6ieEHW/6CprF8wcieLseSOSTg4drpiE88L47/Lg25Ez9cYrN9IxwjHH8YRxNUuHde/iQ5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776278301; c=relaxed/simple;
	bh=slPVH7KAT97uurf4DQhYJlACVgz1LZV94Jrmei9PVtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0H4FZPtF9k+M3hjqxYPj+lHfz52JOWmbulTQVaTftTh0LyJUOoPr9BkEce6iG0LyAD9B9nNX8TzREzB16gMsLqTnsj0lRyMP6l4s+a92BzO0xqtDtJxpRBigdG/0vEZLntifyVWLyksZmB/S3B/oJNCx9Bt+KwOyr0b2GWv7AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qRnLmwa4; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a40b2bc96dso1018500e87.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 11:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776278298; cv=none;
        d=google.com; s=arc-20240605;
        b=aQhk98Xa0ztkKeayrOKFMh34VGEuCdJXrAuAy6DZTmwOJATOi1jS7FagUL3erbpzA3
         mWHpXGdzLo37OxGplaVHLvLrqXFOrIqNgVTI53CDLFa+07H7ZSepdkmZGCktVtNRzPtE
         vMVxyVeXW1ALtAyZJr1U2uNruqYwkTn9wzJkWVz+S/Bf+3mwExg/omfqDMnWkMK6hLwH
         ERDTzrTMnqA4a0/rNTk2stgG1RZJaSKRa51qtxS5U7Cz66Is2vG9oilt7tUpUnqzjNYN
         gYnq7InrSWqRjAjwfuAhyX5G1yEn2dap3a30iMzBupsz+Xm6QMTgWQEzPJiliz7iDVF4
         3niw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QlbkPCKz5ORUtXZreA85qlZUJ7MloMRBic9U1KgrnA8=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=bdMaP/zFOqlNyYx1PVrBzz9A1wHs3zTih/Yekpzaiq3urJ4+4f207V6Ff/lW8IVRXg
         j1q+P/zSj6DYUheqNogbi6KT+wjWGrrayyDdGLg+3OGqZx5wubh/O8cIWpk2p4JWKQDt
         8AdABrspx0eeqYIBWK84GpihpIlngUc8MamdgkisdxuvMIPhq6u7c7J1FP6u/OKBKmhC
         Om18cgYTq1foEwRkWkuae8vEjuPOWm3bKRzX8ZFQQfYUfIAySYRWMZ+ka6mwJ//GCzgT
         2eOHBbeubsGUX/yHkk0kSb8QtHmPNx8zsC0RVvJ3T9JsWigIk2vjATirX/ukcPq9GGkE
         nsFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776278298; x=1776883098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlbkPCKz5ORUtXZreA85qlZUJ7MloMRBic9U1KgrnA8=;
        b=qRnLmwa4ou/reGFrvxt/hdtoEXs6X8WL4sKQZ3KS6COK3QWA/Y1RpnhazWuJCKDmpd
         rTLUX5ZoJ1PsVJymJRiftM6zwRNoUPWsUpPRJpFN/rY1eUlm4JlHxYxliIkezpvWJtw3
         UWSq1QVp+jUXM6hXHwGTYdUwwyda6K6IwJGKDmqayh/y5MzlwS1c3S7rsj6DkUUDmBpN
         kRo4x2OhVMHDzx+CMVrPQcBahUc113YeHvow2AdWiueHe59e4PQw2XkeRhnKrK+dWwqi
         uKA12zDGsPkc+lbiGmj4NhdX1X6wlX0lIXYHWmoP+ed5AwzuZ3We+JOqXv7voWNsF52I
         wXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776278298; x=1776883098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QlbkPCKz5ORUtXZreA85qlZUJ7MloMRBic9U1KgrnA8=;
        b=loYm/1kjyMqumP3hVxHi4oGYIesfgjoR/3+L0jrmpZIttTx9XEKUVf0Z7GMJBLYGzl
         nNuK/EbnLEbkszDztIqsUGpbDSwykzhdhNSV2pBBR5p5354phnTcAYS6K1h+blsbo20M
         3zXMR4E5TGnV6OJsj7QTR0XyGeGNZbg2lbjz3NA7HvyolgwTj5/1qqHjGAwhYzMazXKU
         gRALlGT9DXXYJi4fRf2djyZUx8wuA6/xKp4Yu9imaeXg5M+Q6wtYFTyjfZw591cAUsSC
         0ApNCxd/b7jvWEQrbs34MLm6K1YlXgsVsA/6yTpDavSDhTXEL7NNSxCP4EiKGFZ0ovfz
         J/OA==
X-Gm-Message-State: AOJu0YxFE6kziUY5hvUTgBYqz8/uOJJt1JQFkLt9gRDZTyauIfaRHuLd
	F85XLj/oBEMBKoo8GpUwQ70ESeN0xSLsXTQ+UJsgCnqGxhkqrH7EMx8ky22G9OTMAE94zSMRiUA
	kSD95VeHkkKupLUbO8vqVdA88DwKuKUQ=
X-Gm-Gg: AeBDieuX3OBKizajdx9gHfzvDR1CgLE5/HJPYDzhHZ4gGQpKI25CEUsVp34dpoy+KNy
	h+S8/BJ954HDLKl3vPn8Bv8Q2ZW4NA6bESJPmUJVcZ5o/r9otpE6XSz9sHKWPZMfqCtbXfXow8b
	0iGar+XC2xE6pYjLSX0GE9wuW3Ojp4gPbbS7IIOHt6cUb5Jh1LA+og9AJMCagg/LDzJVvlflUCN
	02YqnBclfj4B2zGVN3Dsz8VriVWlNyR7sARIit+BWVFiIpfbszN9TM9wtZP/Q5S2UJ9E0gY9qZa
	86660Aw7g4es01ZBEZI6biHRX6kheNPLpNMiLkB2
X-Received: by 2002:a05:6512:15a8:b0:5a4:6a5:9910 with SMTP id
 2adb3069b0e04-5a406a5d109mr1888946e87.23.1776278298070; Wed, 15 Apr 2026
 11:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413155731.019638460@linuxfoundation.org>
In-Reply-To: <20260413155731.019638460@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Thu, 16 Apr 2026 00:08:04 +0530
X-Gm-Features: AQROBzAL9aoOyA0zvUT9GzQWdqIEYbCWhFrCe0kQZglDihJh8HkzlZ5f8JSvzGo
Message-ID: <CAC-m1roQqpjNpUqiGeMXQyvAs7tAVEH-+-iJWOV3BfCgxs9tSQ@mail.gmail.com>
Subject: Re: [PATCH 6.18 00/83] 6.18.23-rc1 review
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238185-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dileepdebian@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EDDE540723E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 10:03=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.23 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.23-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------

Build and Boot Report  6.18.23-rc1

I built and tested Linux kernel version 6.18.23 using the default configura=
tions
on both x86_64 and arm64 architectures in a virtualized environment.

The kernel compiled successfully on both architectures and booted
without issues.
I did not observe any regressions or new warnings in dmesg during boot.

Kernel version: 6.18.23-rc1
Configurations tested: x86_64_defconfig, defconfig
Architectures tested: x86_64, arm64
Kernel source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
-stable-rc.git
Commit: c600baa82c20a9a0840400b7f5117753647ff9d7

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu.

