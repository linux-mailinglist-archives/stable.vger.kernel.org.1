Return-Path: <stable+bounces-107830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2080A03DF8
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 12:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC431617F7
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 11:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A941E1E3DE8;
	Tue,  7 Jan 2025 11:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="OAwIoCUl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75ED18A6C1
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736249807; cv=none; b=lkwvH5BToqdMoGYfScD9T0SuiMe81IS91j9ab/cVREO7brOT3eHSzaz8ko3hrQcKgaTy+CxmEoTsMZh2kWu4nCPanF/sHvi1II+KWFOIYt9apynDsavTxxtzmOLoZiUUGyd55WZWBD6cwaeJ0q74JwzhI3oZcGxUSx6Dryjr/0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736249807; c=relaxed/simple;
	bh=Y9BesMiV9uMCy3y/CTJ8dLA38nejyMoFaiNgq7Tq74A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nY7PJ8qst6KG2vUb/YQc1I0zhI1K7IBXRTZE47r7tAz+8UKzhyCdJTMJm+dqQUg53D0M3Zw/9NoF/XvtNYQYcBXVaZsFy0tDrE6KM1aOS8LY3eQfho4dlAl+YdNWXaeG91TGWCMT3FuXMvZtsScL0YKcCdTQxjDuzDSxFl4UQ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=OAwIoCUl; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef89dbd8eeso16666537a91.0
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 03:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1736249801; x=1736854601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HezLHe4o9o/F1dzK4dU9Wz6o3ClQ7CI2rKrB29RoRCA=;
        b=OAwIoCUlAt6ohk7ziQSrKP7R7aKR1hW07UKH7MccqOfdFq5wGRisXKpfFsYuPwJp7a
         gWVYyM3SXdye3G0FHMcIXhLiE6ZjGeKfPD1EoquclvmfV7fBSGC/KLKM+VRu8RKTCUrY
         8MXhQtm9iN07vv+Ke1JY5++QYSLcX7Gmn/lWg6lnVWVkg6MitJ6uNF1QPo+XT/x+Kn/8
         QaxOzzkF6+efiB1JI/69NUD982/eBA/zlBLhMslg9lpycuDKcu062pfBnxSkVVvpqFec
         d7FjiVnftIzNhDcZE3q+Kspi1jDC0r7wX9bydIQ1ZWfkReBR7Wd+FYPLtC8GOj8f586x
         gT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736249801; x=1736854601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HezLHe4o9o/F1dzK4dU9Wz6o3ClQ7CI2rKrB29RoRCA=;
        b=ckymTKPRNtsitqbWe409Hjchdr/J0xN9Mx4Y1jhpaFBL6UEaEY8RadcIBYBeXKDX0p
         YN+XM6LK1lhzstZNeND7xbdfqg9ctuWuyU0IUOnt783ZbE56vznd/xsysAva2MD0uMs2
         SB69ouZtcpMoJOkG/ZzKBlIDLvXo26vhds32uNd2sZEb/r2CHXj40gjOUEfyIYsaeQfC
         R47fLh2Ms7yFLBxucRLC4yMAm3s4/HE1+SSnYKbxjr1/mAwvh2yXrRWTWHZO4tvKFZ7X
         ufRl7lBFJt/uOywng9i6ZGyzB2PmXfOEUXgD35kEcH86Wnm+3j+2zJux2a77P0pn1iq2
         IDvA==
X-Gm-Message-State: AOJu0YwbD8+WVYWU9wIpyF3ADQgdf6ty1iYhR0vDx/yq65vlpKHUufXH
	ydNy8tyhVr+0zFsWV+BeSEtomRey5Hm3FWViPSqjRZ2DFQhQwnLEh947IsXZm3SzMcojUWTvYBk
	YTqJ2IixpHPSh8HXaix1KuVwauAJuqdhpSnDLOQ==
X-Gm-Gg: ASbGncvWlRSlVAcjPaDDJNrHWBPJoXUu/qsUZEjOvFK9Y9x9rhTQtWrayyO9jqwCHlm
	4c1SP0Iwes0HujQoHIK4soYnK2w0Zbl+B+n6+
X-Google-Smtp-Source: AGHT+IEpYwKsbS+mCPDKNQglIw0fFMHrX0/2J4U1AUgg44SrAqTO7vSYUXvw4K7xW0AF8enbL06mVLQWtquxJUldXJM=
X-Received: by 2002:a17:90a:d88d:b0:2ee:863e:9ffc with SMTP id
 98e67ed59e1d1-2f452e4ace5mr80833760a91.21.1736249801195; Tue, 07 Jan 2025
 03:36:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106151141.738050441@linuxfoundation.org>
In-Reply-To: <20250106151141.738050441@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 7 Jan 2025 20:36:30 +0900
Message-ID: <CAKL4bV730JK+vXvpd0jqWfEPtN-tZAfud3F62ONvp48J9Bqxjw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/156] 6.12.9-rc1 review
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

On Tue, Jan 7, 2025 at 12:34=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.9 release.
> There are 156 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 08 Jan 2025 15:11:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.12.9-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.12.9-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Tue Jan  7 19:51:46 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

