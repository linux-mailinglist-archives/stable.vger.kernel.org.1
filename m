Return-Path: <stable+bounces-216608-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0QeSDhynkWnQlAEAu9opvQ
	(envelope-from <stable+bounces-216608-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 11:59:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAE613E895
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 11:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 109633011F03
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 10:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B9B2DECB2;
	Sun, 15 Feb 2026 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTffDRv5"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C7F2DE6FF
	for <stable@vger.kernel.org>; Sun, 15 Feb 2026 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771153170; cv=pass; b=Ym9n12nHurmLpKLj2V6R2EsMK51cU/OQ2pbaKJCHrpK31e1pivwYV0e6zG9HbLNaHkW7Fd7eF/U5NwzNGtSc2tWMQbRmLArLcy3NlNxAIEcVGEVMEj9ir+hgq7BZHS/UUjR9lZK0/hylrMl+yp5ahQwFZbHwxbylnI0N2G7IHxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771153170; c=relaxed/simple;
	bh=TOAJegcEhtu7NkrOnb60uubSW9SS0WjzepPMOON9eyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tsy8A8dO9ujUfEWJcaCq0JvpwNKcH1P8BKydoXC80uZnMkgsBQ/SONbr27xyU5A/qPwC2tn33po4YpBw5m0rHdm4oDrm7L8qP0ciVpMcPYebgxMR6oC4fyTv/5/rBDLr1CdKSN7H+aH5JLD67GhDvUfGY5N+wGRDqMdVr437O4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTffDRv5; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59e5c95a057so5017256e87.0
        for <stable@vger.kernel.org>; Sun, 15 Feb 2026 02:59:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771153167; cv=none;
        d=google.com; s=arc-20240605;
        b=FWa7mR0/nz6vUF7h0Tg14dr1b886BAGSHMjsIOPYzA6rj4BsHxrgBhz3bau715UZQI
         r/y37g80kFMJuq6H8m9pld+hQA5dsPe9Kmh9WJuBB9f9kzhwZtIb/1xO3YsYF6AbODF0
         nz6HjQPBPGAFiiK9mZ7AExZbIDZ6yclu2yZR6Pvc/Yk2FXs1FO9symdqfNrZRxzIeZ6Q
         sZYVRG75qMZdN5VsAKv/RlKmx9dPO2qGF0+KJgpp2dh3M9A76A3dCZHFyhHM3A1dcusn
         Qd51Rvdv3LOfDuTLP6mVyEBv/ryHigWcdPoj2SVyrSjxO9btkKFiink6JzeJMt9rbK4M
         T3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/AID5hOUAIZxGzgNR8lz3CVvcXcQ5J8kmxWIWetV/nc=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=ibQZNJNn4tvrllYijKSD66XWIK2UbsGC4YrQp32lHv5Hy6kdg7Mq2wJQ4JupiYxtsP
         cXnCi8nSK1eOoSec77Gs1hGrlZVCN9i8NPhLSdCu5dxMHfITyaktrSTnQIR1TbV2onFs
         aWCBHpK6KyhJ1yqVgibAPMg05DsahJwKkZvBT+O086VOVEVV9ayuHRf+nsfG7dOu/0BI
         GmIcMpsNcNw7yYS1VrxBcpBnTZuH9fn9n0p/ZdpyusNMwbnKR95bWTEUsoEESbXl19SL
         vr++s1uEqpz3Vv4TVuJT3/zxDJ0V312+Se0W9M4etIo2W7LQKi2rKk9oD48eiPRSZEhQ
         ahPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771153167; x=1771757967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AID5hOUAIZxGzgNR8lz3CVvcXcQ5J8kmxWIWetV/nc=;
        b=jTffDRv5YsYH+nKy+u/WhCOw/OQLFTu3Gx4vgcEw/0EsqCA83KRJrcZG3nEaAdtMPI
         ExX3PB+OUdJu1ix6GHVsN4Hk0BvE4VJNY87iB/jwiWd31dZSGxnEircZjFeIgvfEev8k
         /uJV6A4cklihMU58WEG6+tN67FAqdGwZ6J2/pFfg3OqxdxmjQbm8JcWW58g+WXmaJO4n
         nI0iB/7BGZPZIPb7jCtHRHLk9ANbI0JHkmDDy4WN3xNAIPZugm+1K+ipvKlq0YH+QuKS
         jJ7/LQwO8Cw9sJK6SgFIn7OFsb9953Yrj91Y2hyD5ABWK85wG9xC4ssmLStqTvBZ1TaG
         J2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771153167; x=1771757967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/AID5hOUAIZxGzgNR8lz3CVvcXcQ5J8kmxWIWetV/nc=;
        b=K+I/4fV85/aTcfooj51HoeKoT1topw5+STXWBNcdMMSSCsrIlehItdMG6ERUv41Mio
         n3lGhR9ToEuaxp/TvDumxxaH2ogzTOdTaX55N4E9KJSDsJvGmkCb56fuvmUXeSCX3L5Z
         ObsC/rDT89rXHrvM89ZFuk/MPO8L3itWYqJuODuDGu5fPCrz2D+wL71xuOF50XqNY30e
         hfSe2nkVWgVU+MOAAfOBg9s1ymSPhR0PKLqiUz8/nKa/tiJlE6notCzgJgFf0EqkqH4q
         G/KSCS0EJotaYXi3lDL4Nbh1UuaN7Ge8C62HpEMuMck4VUG4BnBOa4JsXiK5nkWE8Xnx
         Heqg==
X-Gm-Message-State: AOJu0YzL/sDKfVb9y1BMzTlMFEBjhoj5UFw/w9XEm47hclOJMDOvbYSf
	0W6pj+pAf8BYgqmt9rudhZIXNdSpzhWfj9KdFW4Og5Isln0Zrjt+hx40a+gw1SxihDd3AYq5LWr
	mciEwla+Iin/lVDDlYHuodWShS5a2A4k=
X-Gm-Gg: AZuq6aIR3fsJgUxDFQQijDzLRMy+c03GHS95P2Mja0s38egLKZWNxXbPP2HPd1iCAgM
	ZnwHYh7+7DmvNbI83bwo+PJ9cL79RAb0zjYdhQtEEO3bpHoFte32BTSLxOqk7HEZE8w75JbSUVK
	UakERh9Md7Da0A2L3OZmfYrS3uaYLlHRsqVcJEpF30HJ/bgR5XD2Nm1riFd+fj0zRIYhDq1vC7w
	eUcGptFSFgkne436T+O5otuPgQ0b6t76pyavv2jHx6782h/tDs8uwJhGvwW7AdstmRgK4HYT/ks
	H+DnPGiqHaLvSNdNOzW+GJGsnF303u3wo/XJvfRj
X-Received: by 2002:a05:6512:3408:b0:59e:6297:a057 with SMTP id
 2adb3069b0e04-59f6cfb7190mr1516031e87.6.1771153166608; Sun, 15 Feb 2026
 02:59:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213134708.713126210@linuxfoundation.org>
In-Reply-To: <20260213134708.713126210@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Sun, 15 Feb 2026 16:29:15 +0530
X-Gm-Features: AaiRm51XzX5HFwaCBQsVFAHLFio2cP0DEMw9cACKHq_SBPKzYKfGXKwU5kQcY_U
Message-ID: <CAC-m1roX0qFAf_ES6M=f=qLggY1do4v0WbkW76Ch4CWz7=Xehg@mail.gmail.com>
Subject: Re: [PATCH 6.19 00/49] 6.19.1-rc1 review
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216608-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dileepdebian@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BFAE613E895
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 7:21=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.19.1 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 15 Feb 2026 13:46:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.19.1-rc1.gz
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

Build and boot report of linux-6.19.1

Build and boot tested linux stable-rc-6.19.1 using qemu.
The kernel was successfully Build and booted in virtual
environment without any issue. No dmesg regressions
were found.

Build details:
Architectures: arm64, x86_64
Kernel version: 6.19.1
Configuration: defconfig
Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Commit: fdd37e7f30acd1978b8c205b62562dbe7b17b015

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

