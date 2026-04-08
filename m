Return-Path: <stable+bounces-235287-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4H7CFZLX1mmPJAgAu9opvQ
	(envelope-from <stable+bounces-235287-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 00:32:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DB20B3C4889
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 00:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F0E830146B3
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 22:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A173A3E74;
	Wed,  8 Apr 2026 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCrRBaw9"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B98B37D136
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775687565; cv=pass; b=W1Dv92npVBcvE4BV90D07l/8ICVQjo54BUlxpO5OBhCTC3ybWNr0eBigvjeDmQgw2CZZtTBezEIZ8AGotLr9sRETNJ2EBc9inpDRrZATiTGURUeyL+jWC8iNMmZipdRA8G3KuXT0iozXQjoupi5jZnShMEMRpzd8BfgLcqxN6nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775687565; c=relaxed/simple;
	bh=4hVu5AMFx74Du4EKUXeyAzM1O3Hk+cEhA3SjQYkryjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGw8/sva3bJh14laUFDt6eTGnfrjeA+7YXsLcW7T/YabkMvT59R2nVwYrtK913a/pwm3rpdWkXM1Kl0tXT/zuG4vk9uCDGgTvvtoxGvjOcsiVALrshu9p1Hy+oJKaWN3Q+xHKFYWpzsTQMLP43ptMo9+/b08hxz4vZQV+SKgRYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCrRBaw9; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a2c500750dso233923e87.1
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 15:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775687561; cv=none;
        d=google.com; s=arc-20240605;
        b=ZhMOQ5W8V38hsKIxVUbDpxYODx9FD+e21Q/uBA/RqOHE4oVtkXYJqgIZ90umcEIFnm
         ySAXewF3V/U5sRuaYwqcSgY0U1B7Iyr+NJHv53CyjjpzETiSW7iqyx3wiFOeB70LMF5t
         Gx5vcUXOwifn1TftjkbO/t+Q+PaRIv+YQ2LG8QjdJuQmrzjdc3bDMUr1KSa8LrtMU4xi
         tiB/Vy3lGoBcfWTUyOoC5CKT/nwNkca2YeoJNyp+bDVBooSQIXT25Hr6OeGE3ZZsXTXy
         B3LyyMSWjTaA1Yom4Jb9JhsglZ+A8uXc9bjM2+qq76HI8tVhQEbI+quDumXNsjbXUSRp
         u7OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ByzcZBfhzWS3WwjWKkRG3T4PJ/8xweSH4/lUBfwIOPE=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=T4VwRoL/2F4vFBYp8KpsP9iUn5aoibFvN5o+12ubbLo4aVDihUX47DlxKCTCioTQwP
         vnODaO3gQ7orf2PWjwhO4fqdVOiaxjIwjMV4dRNv6y5NfEzgr32egC0GYaUS0wEbZXKu
         z1KPp2Mco2wTHK0dCiVDttz36VLCk7tbt5RtBgYSviyp0ZaWAINmCQxrbrdmluMAqZFE
         GtW180v1YdAQbp/SczW2LZ68Y4zt1QdQTJ74IUz4vEDtFusUt0vJMgjcjGXx80Gjx/cg
         hNT0h6XWhHjJaUw8Bj+7QKJb+LIgXm0lOfHTUlwaTTqekW6CJQIj+YUIb+xXBEXAqPOg
         IEWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775687561; x=1776292361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByzcZBfhzWS3WwjWKkRG3T4PJ/8xweSH4/lUBfwIOPE=;
        b=aCrRBaw91A0DpgVXix6FibrCbPmizitAWzk1A8C6GV19fjpT7ypseATGk/E+9O36UJ
         86EZt/Q+u9CNwLsgSnR9Z6HuGKUXN5xKijtxsCZnZPxIvvwaSq1fdzbhIAxANrqntOiD
         WR6WBQAv6Hju4SSFDOyHKbM7XhziSQ0hOrBNa6unCaocvKJJ0WB+TwMVcyNzzOGoRVXg
         S8qON9i23zAkrHy4cWBhxApfHBh9Rrpypgk43FqiktKW/t2Xa9KINYDYqA4qE6LzZnz0
         LuJNhe5od9OsX5Vk+CekeHe42Zf6GZc+Eqa1Mo2tiwnBLotqdT15UgAQYbBnrvpGbgYq
         T2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775687561; x=1776292361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ByzcZBfhzWS3WwjWKkRG3T4PJ/8xweSH4/lUBfwIOPE=;
        b=ERf6jEmoNXsWRZZk3Sw5uh8kHlW6/0nRQxglA+A+OUIOgHyqkEXk8RFl7NF0/TVC0D
         lorxrouivmx3BdRULg71tmLXy0xpvaUIjDUd/gPrabJQE1TjcHew/CuYP5N9I8AWUWbO
         GaGGkMs09KT8eJD/EcYdHuee31Acit16LyvmHLj1XgLjTiA7DpbuVlhMydU6QalEBboc
         Ox/WTRhZC+q6fs9B95dxfhkr43TAueqT7l4Kz0FDNuZiIHlJe6vtlwT0TuclXnIAZRaN
         FaTJbVjGK6LGD42YtOduttr1loyI78XSsWw4mI1FT0aWfKU7FNykBTJsPCsl4gJwHto2
         VhaQ==
X-Gm-Message-State: AOJu0YxbzlD5fBSufEdvH4m1/16MuKoVybqLpO3z8xTaGfn3HrT9MBjt
	URl6cxX0u81HIIee97A3d68TVn6QgT61g3IonkQehvWGF5N9RKTXOG7weUXoYKq53fULg86wXVc
	V2w2axTee2L4slR1bEB+sRxlNkilQrko=
X-Gm-Gg: AeBDiesqV6yu22yOk50tp74SjUt8jXgzzk//HsPr5jN9aoMOE67CQWcw9htX1yLARXa
	v2SGOWhKc1iOcX3xuedOGebM3mLfZRtcsL2xikrq98VU5jxxs8xwH+HpmxumR9AQ6gUrcC/qjHW
	1fBZeIp168ix+tCaB/4FR67V1MJ9FwDxxM0fRnJK4s8MEGd4AjMhjLh2aQgsxloRMznl2VnVxXK
	kLOyRyNFI6lIiKdCCM9XObGHwDGVK7B9iX1BT6GLIsmhhqdzboAruu7J1LoOQir7EDi9KmD80Ik
	4vR+3jbfWAKwFA7xsRpJGoZgLbxGxVeN1xUV7+ZO
X-Received: by 2002:a05:6512:33d3:b0:5a2:7b74:3c60 with SMTP id
 2adb3069b0e04-5a3e7c46a50mr537524e87.33.1775687561218; Wed, 08 Apr 2026
 15:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408175927.064985309@linuxfoundation.org>
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Thu, 9 Apr 2026 04:02:29 +0530
X-Gm-Features: AQROBzAtEbogomq4KyKNIbCpugVE-wqtw3b7mUoqya-hRf7ALQRyeOjieC_Muto
Message-ID: <CAC-m1rreAyZMXrJ5p1pR27Nwsiw_UEo6u-=OkOT77MqPYCgr-g@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/242] 6.12.81-rc1 review
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235287-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dileepdebian@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DB20B3C4889
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 12:12=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.81 release.
> There are 242 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 10 Apr 2026 17:58:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.81-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------

Build and Boot Report for 6.12.81-rc1

Build and boot testing was performed on version 6.12.81-rc1 using the
default configuration on both x86_64 and arm64 architectures in
a virtual environment. The kernel built and booted successfully,
and no dmesg regressions were observed.

kernel version: 6.12.81-rc1
Configurations: x86_64_defconfig, defconfig
Architectures: arm64, x86_64
Kernel Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
-stable-rc.git
Commit: 725a3d57414632c8d5a9c12e066813909965d1c8

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu.

