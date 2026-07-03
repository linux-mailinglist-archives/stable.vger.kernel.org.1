Return-Path: <stable+bounces-271753-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gVJbAl+pR2qBdAAAu9opvQ
	(envelope-from <stable+bounces-271753-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 14:21:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC8C7024DE
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 14:21:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="VFhT/HDn";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271753-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-271753-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A14830160E1
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 12:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7273D1CA0;
	Fri,  3 Jul 2026 12:21:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FA23D093E
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 12:21:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081303; cv=pass; b=Bo0shpRTTjpvRE1jdwBCBgwI0WGk8Ss8yKsl2Oj7D9h98YDrMRbg/Mu5+MbnueMcMBleUdsOhxy+wenhIZsN7qYTQ+I4oBYINF6sdNQ3IKyBPNnUu0cFywJVz2tRLeLAL/b3TA9W1gKcp8ZgpXT6HOJ3JlDaon84YpNiWO1Xtxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081303; c=relaxed/simple;
	bh=e7AeLpfI/V+IZizL+0VxFnbt6XslONmPoQZ28t9uKEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIsIlKVC/iOW8fXoO8d1sFdl6Czvd3tfSE/S3HH8ohwAOdg0W5664fsGhx0KhjmVsmUUINvDuNcCDj9+yqJEjg+zCO+A12tnrKSGJMppdtIrq/Yq1o6r0RnNhvDi3uZ52KyUnlK2yi8REynOl8WSXa+IFyvxevIv8yFMWz8K4Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFhT/HDn; arc=pass smtp.client-ip=209.85.208.173
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39b38d3c929so4575401fa.3
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 05:21:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783081300; cv=none;
        d=google.com; s=arc-20260327;
        b=NyS7Cs/m5E3MrsMpdKAGAR9aY4/E/KbL+Fru1ZNR9Qnc9zoCITI5nQZVJMshavQOAF
         vMCq9g7anEtAH1+m2IozamCLNk0T09FgEDeCk+qnQZG72iFRnjHGex9i+e9edevAeDrG
         qdiUMXcpj++QApV6cxhjMvXZcSJNdB8dQWSWoWxVjLEJN/HADZtOi0uFF73011+9nUMC
         FVS6ael/Dn4cjA+cwGmukK7KfIArRRiuQX2tEgjDWWVliZIV4qf+UKX6phR5y3ALgV2b
         tsurNnqx5zzjg+6woRFtegVHThtJWjJuSfuhnI5yplcISM3YnDfqwDqdDzGGp54S0XVE
         bwOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LPBk8ugS/kgMy/u15yq0CBcBrSjlFHrN86r+y6xZUes=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=sP4nreMvARNfR9TVylSSkvVLYFujs5gm+NUYFda4Qj1yKCVo73dU2ONVRSewzbs8vx
         Gw+Zu66QrWFc7NYPMyrvnBN1yTwcNZPsIrHEtNwyDhXiLnzhvyyJs64Skqe0hNB5HVjz
         DHfRKa11ZLm4jgwAamJYEXht/El9W134sSYPDcswcrV3dLFEgW75urAFJtTF2If2UxRZ
         7hgNu72OItiS/9OZrHIrcZYn8MuC+wz97PKuhK2EUEjVl/aPFtb6uQoKpwpmq6ex3Vum
         uHDXJVX7f8oN/+XGqxBZtQdqMJYa7nmcyXezgJpTcRehxlX9GyfOuDWwR2HSXShcYDwR
         pT5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783081300; x=1783686100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPBk8ugS/kgMy/u15yq0CBcBrSjlFHrN86r+y6xZUes=;
        b=VFhT/HDn6mybHqv9WRPoaOwkIKu80LKlYsnJbiIk0pZFMCLnghowT+6/X3Knd5WbcU
         O1m+MAFUGGXAZRUSxChehOwpdD5SSacnXgMEeIR2G/323dlgLGKIkaeaCvRbzmQAvkgL
         HwDEHrepkv9pApuWsbQnszjKjfA76wkDY6K8h24ydEvjfHVz1DqAfnx7mnFpXZCDzvRf
         22H8J+GY3RWhdWznyGPj16AgcltVne6VaZWTN9HjDjdYV7g0eyIQc97PMxz5YcHgu76B
         z4tZlg7SQHIvztkkL6QwKJSvcvIdRp2AhRYRUxpHwNBy2wyk+kLPX3LkaevU8mrIyQIK
         w1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081300; x=1783686100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LPBk8ugS/kgMy/u15yq0CBcBrSjlFHrN86r+y6xZUes=;
        b=l/YnhmWKoJeq8qqlvxc+5f6Sa6hzmHyud590A0oUzpVrkUxBfzjn+pI7esk0g72ph/
         PUNe3Q6mffokB5fhId3DyVxsFyE+T+/faxFPtI2ObxxMSO2bGTOfVdlQLCqy8Rg5GCdc
         8aV0ds91Pf+1+qKmsvkiW9W9ProX80mi00ps+S8ER3BxwEGTohM3ZU4Paxa4dryoKbyy
         V3LvC5VdnCgOoodaKWZyWNSem9jDHAAmwb5unyw7Xt9JseA0sIwwPSmXItBiDvKdXN/5
         xoyjwjJCWCo7kYUOIXMjRRGJJC3QU5SEO+3yIdaQhlqYDK0uojGN4oF+Z5w41gMvoVTs
         lRIg==
X-Gm-Message-State: AOJu0YzUsFqtRhRNBzKSLcj0miaN58lxi81suzZsnBVDIZhmpHoV5YIR
	h+rHoVXb831d5LgmGX/zW64Llm51Lcm7bMoK9V7feo+/uSx/4+2D3U5ibEulFVAs6ojna7MZP1+
	W0dRd81KcoeKGY+wcz7oZkmz6gBz48O0=
X-Gm-Gg: AfdE7cn+CpCEYc6Mq/TTq5H0p1jrPDrpNDPHoShFbazqJHJEPCbDz5WGmF5/Ntbq55W
	bFJmvpIcmvICiNTmlEwzNWYDMoqczY120WPBo1bB3BhzsS2CdlapqNrvy4xNyTcxGG/DdRhNKb4
	oj8yU7RbLFPuo3vufhtnQfLIfsgG+NUXNuj5VacJYPXJa3c+b6pnEYuORfkXU33NsAQeksaKhb9
	9sNYWSYLcW+RjAT1jvyLQGy/Hua/GXH7wY4KBeufWhlw3c8fSX2rBhAiwfYIt/TzmCcoRTqdN80
	TPYtYCD2LEnqP4SP4o+dcFqFySLMag==
X-Received: by 2002:a05:6512:6887:b0:5ae:bf95:38e4 with SMTP id
 2adb3069b0e04-5aec679798cmr1666596e87.3.1783081299489; Fri, 03 Jul 2026
 05:21:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703072822.817328079@linuxfoundation.org>
In-Reply-To: <20260703072822.817328079@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Fri, 3 Jul 2026 17:51:27 +0530
X-Gm-Features: AVVi8CcM4kfM7lzOEdj071SFlE-qqUn8hYlhEnpvzVa2yugxgWc4NOB7MuYiVXc
Message-ID: <CAC-m1rrUUkGEGkQ8sxZYss1c02pCGyfAp6fyPzwTpWWN=tPGfg@mail.gmail.com>
Subject: Re: [PATCH 7.1 000/121] 7.1.3-rc2 review
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271753-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:broonie@kernel.org,m:achill@achill.org,m:sr@sladewatkins.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dileepdebian@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dileepdebian@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FC8C7024DE

On Fri, Jul 3, 2026 at 1:08=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.1.3 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 05 Jul 2026 07:28:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.1.3-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------

Build and boot report of 7.1.3-rc2

The kernel built successfully on both x86_64 and arm64 using their respecti=
ve
default configurations. No build issues were encountered. The kernel booted
successfully on both architectures in the virtual environment. Basic
boot verification
completed successfully, and no unexpected dmesg regressions were observed
during testing.

Kernel Version: 7.1.3-rc2
Architectures: x86_64 (x86_64_defconfig), arm64 (defconfig)
Kernel source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
-stable-rc.git
Commit: 19dde9778fd8e8fb700fd3f9d29be0eb4376fb71

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu.

