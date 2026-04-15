Return-Path: <stable+bounces-238113-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHsHEQmE32nSUgAAu9opvQ
	(envelope-from <stable+bounces-238113-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 14:26:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D4E40439F
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 14:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DDC86300D4E9
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 12:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD92280018;
	Wed, 15 Apr 2026 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEbjN8Qr"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4207A26A0B9
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776256004; cv=pass; b=e1yld90EzzEayO9EwNanpVfm5pGAZvxMUraDsUgZKJkA0p3jaDk/kCPETD0UYl0vE/xyO1F0kErlbQ7f1A74sM+yoeKM3CMCmpOprjv3JdvaJmLz0fcJakVgJOj4laKx9pVd0FY+7gLcs+q+uKVPztFcyMQALIV1TiywGP5Da08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776256004; c=relaxed/simple;
	bh=GEeHQr3KyW99nqGCoP60H77ymExJJnsL3KEri2OiJEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejOF6bYjYWUI7hWx7ulKpaDr0aGnDY7ZmpALMSsLTukLwZ0OEGpgJEZn3SQUjr/pwmclVU4yIRAtKoF8KAEvTPknpEhxAP0/UYoy/wON06/LgjHmg0uojRnpgbuBBC1W4UxeXylSI338BNP5ZEJnP8loLhQRl/9r11TqbLwYLn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEbjN8Qr; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a3af1b7549so8436051e87.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 05:26:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776256001; cv=none;
        d=google.com; s=arc-20240605;
        b=Il3Im50VYuEWSvV5n6YTBESuwvHI3H+yDrPc+5J5XFPOtaJinjzKl3h/FOtab0q9cv
         LQJgtSAf4rSE8ZX+Ng7Wj4CVPQIUTkaU4NtcTuMgeG3C2iPVld3I9t+m47wauCcz1nqb
         4rlU9HSOZ+RyuwNt5hUXNx9lY0LohIp2EuQAxVFjPNzCvgaCFET/2iV+3l4NIJ7+ksdV
         QOq+TXQaDiMWtwxnKQtigiTL1lLriwydzPkZB9zi25BUPpkJYMuOwefeZkdj5pNCtk5c
         poRH6qAaPqikZazHeQaFID1QwNb5J3N2nZ65BHejyFqe37MPwNYB0e2qR7ZBIO25G5ka
         tiyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qUV1dTOfFSErWpSsm2W8MI+dW7Ua6AIcmXKVwDRvbSY=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=kaX+VDq15PIS3H8xDPctlkj9P2dqFjtQp1B2lHzPwGDZKtrGhTGF3WlctMrtcBLMqI
         FUKWVydHQPEDTIUzruwMufPRBCCeHe1hoAbB75IcjIq6ETkD3azYMH8zufVFKcdgtkhx
         IdyYcxwURcIZylg8IPluLeh46xy8zFIB+EtuZawgRhB+IOl4ZY274UcjojJXaHsX1SNH
         MOyGs3wHrwE4yFP5GHNdEdxNiWIUmpYyxojeJd9YtahTIMc6hWLGpMxPncq+kKGRSp2j
         B8Ervh4WQe2MQikdwJAXtuU1gCpHQ4NSF1laXEWkaQEqMBn/WSNf9CnClHYcPP8CYlQa
         lkEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776256001; x=1776860801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUV1dTOfFSErWpSsm2W8MI+dW7Ua6AIcmXKVwDRvbSY=;
        b=AEbjN8QrYqcyVMCyJ5ucc5Zt/4rWYDyH256UdGXELp/juL6BT1gbiZH1sprMdwqzBH
         2Hmkt+TDqMIMVjF9Ih8th6hQOdRkLaXtbxBhaPCVOkfwEksaNvNTC/O1UbYeiJywq4n9
         0R/URUOWl0KWHwnpXnA30ZUcyUDvkIAD5CM6D26XGjvIPcpjopiJy5jPNv+uOqrbLlUx
         H+ASkGBUOD2fQJxMYK7YFVHO/yeBVwtsdUJ5vwbvfdVzoerM/N86+rfG9Il3D+DObcIJ
         LbJQBu+hoy5+YUSG9tTXW2vZLkfBBvzO7MsEJclH7kR3bkzIzDST+HrbtXATSWnFvIRh
         LbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776256001; x=1776860801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qUV1dTOfFSErWpSsm2W8MI+dW7Ua6AIcmXKVwDRvbSY=;
        b=o8wCqMFT3H9jUDui7gL3pIDAFW5CesU5NMfUOI7DWUFnTuinLnsbJIQFwsjjZ+u5jr
         MARf6Vgk3l8D75YPDJA5NcVgyg4yoYTlaLDDY0lhk+kvSlZBD64JYD4RgHg7FjQsbKcb
         F5bHLXMpyKavtpdkWOOLY9DAaWOky1Lnjuxg+iGIlSp1S4Y8SMVj7xQJZp381OW5H9b+
         ySFLSKG6aSfc9p38hzPbnJemVihYtS4AxH9ochONpaER2dMb92qG2naSU8DKUZ1J8p8O
         v2AF3jTzJ6mvcluyE1eex4IrVwnjD1eGmrKP7EvRO0tzHu82JvSDz7Vb3Mwy7iQpGG8p
         2SNw==
X-Gm-Message-State: AOJu0YwhdDDzHUtQnOfj/njfLbXPymlrsLN17du4csr4CVJLwyXwBxCq
	a+Ztj4CD8S5qVWuMI+T7IuWTDXvM2dRgXhTfDRQTibzvaS9dLEeOY2IviFtyyuMbfsijjkGCAjq
	k5UWRan1PV/7GIWvTkRRHjVYooW3hAPk=
X-Gm-Gg: AeBDieubLgQpECLmc4fA7l3yCONhiLIe0iEzYccGrkY+OPpKQ7UblrzEhJyiiehBIEz
	B9BBLHH1Q+jupIX6c2CltZvEZOqQ//W1RNV8wQT8wyWD+HFk2POhLsDQPIu+cQ+hFUte44XTIss
	Xfw3Aqoz6fsaFKxdgGnMQyO5u/RFVMkINQNRuaqPiuZ9AIJ0Rk8n/91PqeLtj+pIMD38EhV5h28
	ySxE6CWOfhicTZDmo0v6rpFetIuPZvbMcWZGjUumzEOTHugql7ik+hdzHltrIo+2AHZyrlZOqgh
	iF/WoiVQYwVe/psH35lTWcFBFyiJmXryAmDIOkP7+TeyZInO8Q==
X-Received: by 2002:a05:6512:3d18:b0:5a2:c62c:1edd with SMTP id
 2adb3069b0e04-5a3efd78d9fmr7649424e87.25.1776256001069; Wed, 15 Apr 2026
 05:26:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413155731.568515178@linuxfoundation.org>
In-Reply-To: <20260413155731.568515178@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Wed, 15 Apr 2026 17:56:28 +0530
X-Gm-Features: AQROBzDMaHVELjOLmt_LmQKQ854O8io-UBrQ5UQ56tiNjfT4Q4VKgjvAvqu7LZw
Message-ID: <CAC-m1ro5_HUtk2gC4wSdatR3LvFzE+Mu36qt=W3GR3sEf5NKPw@mail.gmail.com>
Subject: Re: [PATCH 6.19 00/86] 6.19.13-rc1 review
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238113-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dileepdebian@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D1D4E40439F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 9:35=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.19.13 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.19.13-rc1.gz
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

Build and Boot Report  6.19.13-rc1

I built and tested Linux kernel version 6.19.13 using the default configura=
tions
on both x86_64 and arm64 architectures in a virtualized environment.

The kernel compiled successfully on both architectures and booted
without issues.
I did not observe any regressions or new warnings in dmesg during boot.

Kernel version: 6.19.13-rc1
Configurations tested: x86_64_defconfig, defconfig
Architectures tested: x86_64, arm64
Kernel source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
-stable-rc.git
Commit:

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu.

