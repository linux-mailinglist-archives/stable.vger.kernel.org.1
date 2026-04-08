Return-Path: <stable+bounces-235282-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFFCLXnD1mlDIAgAu9opvQ
	(envelope-from <stable+bounces-235282-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 23:07:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA34D3C3F70
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 23:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76F3230091FB
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 21:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2E537C906;
	Wed,  8 Apr 2026 21:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="op5aAVvF"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD4934A794
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775682418; cv=pass; b=TfejEdtpZfLpnw+Ip0ds1RFLgT51+d+J0HtSt9Mtq0JnFRR97ZuPzbwpU0/Eb+dzRBE4v7aAsrpjYQtgAPTwLpPRbdfpSvWm/bZPMEiL3hUClEJY3dWCGDcgL948kGMnOHMippWu5IMZpH9FVQWNzJI0o9i+v7I33d1LdtMa/yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775682418; c=relaxed/simple;
	bh=hYkns5toT0V2D4zbLc6ooeB7MXWi8+6q72CC0Yh9OQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLQ9KgzrLa+rQVS1ezNS0K/Pq8S0SIbAatnh1SWuJ7dZZwILUf2TjNh/rA0/SQuq7Akn2Ak/Bj7iSw5mPVOGeKosWJS1bMrHSryKy/g/tziBx+VCnITtvjL06rfgkZlV/SGbyujWmHJCZ9L9DUcL1Zsn59XFAiPTJ+kX68e1XA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=op5aAVvF; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a2b636b944so188442e87.1
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 14:06:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775682415; cv=none;
        d=google.com; s=arc-20240605;
        b=ebawpwQhl2eq/3BsJkhoLDoLYjadgsRRUrFKn9S+Z3dHo4EZAnyjHk7rn88Lmq2dDC
         fpUXzwDorz1rHQ5Eci/GmkhjkJLcgkmk3MuWU9pzqE2GH9F+CLwpKrSauN7QSX6I0As9
         scqhwEcZTX+KQIU4a2RUUwIKchwxXjiwmgnLkSmPCgS01N4lHKtqM1TF/cMShc4rLYcZ
         4t5Pq284eR3GKsPSS5mZoalO2CSM5qtvJVzE2z2u5xC9GCs2GzhmPRfZepDN9rK0JsI7
         AoNqHAlxOBBgrohS8L0rPJG22F50iL3474n1JJ8xQC3kEtWNLWyEeeHINaLSgkswXzk+
         GISg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YtvBDzOl3ty8gCHQBP+mvKiVADctnqQd/26TJDkcWUc=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=Wx/1w8l/KLpyzozucUwUDB+4MFJ+4ryBNyksnODLX5CXhpZpUV0hpLOVy0GgOqP1AC
         vYBgZ/1RzN6VO05BH1lYxXqpVyX/tlYzXvubA9EJq+hcIB/miBGKdhVsa9aB+AwCYMLS
         15ZXikB5AF3Mxdug2gmJGXF1bWrsX9pyfMtCUvtHG+vzpvQZVOAwS2mq5KLXrJeVYNsF
         +hk5i7GVf4KwRYPkgMVlflDL4I04q18OlGs8An32Wim+HpLBVWd1JydPUaItZa+K5oq2
         co3q5ad0/xZL7OGOYrAn1EpntbNAuhQw+0rAckgxI+sFGUkHoxOi4TDIE9L90ur9funM
         mC6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775682415; x=1776287215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtvBDzOl3ty8gCHQBP+mvKiVADctnqQd/26TJDkcWUc=;
        b=op5aAVvFEYMv+cYNh9eum2NTRAjEuzPdTWr+k7qHdahmNc5LnIQ92EWifvzGDQL5Ng
         lL4rSsYiLMzY6zeW6+ADcLiW+ir2vUwyUozxuG1AVpDMRJIZUpDULiMiMNZy68t3r9Q7
         ezFeNku34SQ8qKCO7wWGLFQl8LPD1OtbiviDP241i4uJDBvbcV9Lbiudq1eDDO5N+3nT
         XrqBGlsMgBJNAn/2eVHwI/4G28JrFbISNil+IJZO3V/T3iOdpUbn1Y4xaRYOVdXN++zn
         ihpaK98Dqg82VcperNKZNFft722KNaNQbJLN0vmxpWgaOjvSjXeoc/G7iDp79S06xSzj
         vg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775682415; x=1776287215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YtvBDzOl3ty8gCHQBP+mvKiVADctnqQd/26TJDkcWUc=;
        b=lk2KFgTUndAjF/h4F6iRXag4rQhUW1m2xebA/g7sKNX+qBmshkrBcy31jJPKdhQukm
         fpQTw8zjxh5YuJ31TKcR8kvoycDfBe47+WBjpHiHXuSUkq6x3c+LVk3Ovx4sOjjs2DUU
         LYUGBvrgffNN38cvzvp2qDyIaEAyM5Dj0KOk899xCRuwum7Hfj9PsbxpExhcmUQAHkSW
         ArrPmYjds1jlHpOg22BC7M18XY6D7bOwL1DufiSOV0FMGrBdQUomnEVKB6dECt8ygXji
         0p/GJt7PKEu8SspjOMqCltFi7xd9o9DPCVMkfYWsV1z/AIdiD0Lyu/j8ZCCTdBJDtcNo
         C6Bg==
X-Gm-Message-State: AOJu0Ywr4C63b9hFK2cFhmt+pIIwRTI3WLiJ9uMNVkCekxwurL/Ui4vY
	qxuDtdd88CgxEfpHXu2sxc9aVCoL07R2wvk00ks+F21UsDyBeCJRp7ASrpnMLghGXyCnXvg9oXC
	y780+MdyRJ+OH4/czGMd7KUznD3f1lLo=
X-Gm-Gg: AeBDieu4WY2455jkKeISDiekj4Bilzr6n7sUhUVSu1Efwm+WMjn60HLoVehRkJOm2G1
	2miAv+xT2WVVxvESymoRmHfwXS35obwMy3PxjP7FKS1jSruqGULCPhlVTDvyEKOKk4xgyBTts2u
	qIGl9e7EKZP9XJj3orsp7FkywQfx7hZ3sSaCxr9h4BnlMKVaAEZi6KBzrqhIbaEsHn1/BIu92DX
	ieDvB9i7mgsDyORLxSIqo6OmpKHThrOcQ42PljMmpldCBEGj7nvEoFFTjZIIa+DWB+kXGxQjoV2
	DDx9zG2x1cO4prA6W1i+EbLmNICSg5Z5ymWT0iY=
X-Received: by 2002:a05:6512:3b1f:b0:5a2:b43d:ac47 with SMTP id
 2adb3069b0e04-5a33754efb5mr7172806e87.5.1775682414811; Wed, 08 Apr 2026
 14:06:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408175939.393281918@linuxfoundation.org>
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Thu, 9 Apr 2026 02:36:41 +0530
X-Gm-Features: AQROBzC3WNywR7tJ5aKj3tpHiHnUXa9bzv0i76xR9qfAhm0cn-jnN-xUeeOkZSA
Message-ID: <CAC-m1rqrSn74FVxYpfMB-v15=EgcJG5Rp4R6kAhFw0k3pKf0qA@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/311] 6.19.12-rc1 review
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
	TAGGED_FROM(0.00)[bounces-235282-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dileepdebian@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: AA34D3C3F70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 12:21=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.19.12 release.
> There are 311 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 10 Apr 2026 17:58:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.19.12-rc1.gz
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

Build and Boot Report for 6.19.12-rc1

The build and boot testing was performed on version 6.19.12 using the
default configuration on both x86_64 and arm64 architectures in
a virtual environment. The kernel built and booted successfully,
and no dmesg regressions were observed.

kernel version: 6.19.12-rc1
Configurations: x86_64_defconfig, defconfig
Architectures: arm64, x86_64
Kernel Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
-stable-rc.git
Commit: 571831a3f83a43f64984cacb7064dc31c25694bb

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu

