Return-Path: <stable+bounces-211403-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJcwNaWrc2nOxwAAu9opvQ
	(envelope-from <stable+bounces-211403-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 18:11:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF1F78D45
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 18:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D73B3049ED7
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 17:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450EC2F5A13;
	Fri, 23 Jan 2026 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeB0P7/z"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7113A2BEFE8
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769188153; cv=pass; b=TfhqB/XQzYmW8ZF8UbgR/0zu+4ENbTF4dpFKUyGSCogUZBlg4ic1CdpdBiLDjulmuQLic4HscGke3EiQoXZxb1Sg5Zu+Ey5MOXPnjqZSeqzHXVVRwMvPWcR1TumrL8I3W7emrhqkVer53kc9+l/vsnTm1wDhFvgnStNjd16qZno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769188153; c=relaxed/simple;
	bh=baSVTO5P4JEdejZ7McLW1ShJqiWIQIoZuEP/cZI3+9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imAZkx7o0VnvL9F7gK1mslc2DXVCOFLwKwexWC/tqT35XsMjkXvm7h1asj2l+NYYnFMn9omA81xyG3/Z5OSHKf4vG/mM6V5pHMen3msMRqhMUgQLIqx0HxZMdWw3LrDcmKuWDas00e1H9d+iWDDFmErOlAdnt3/SuyNwm8r8qiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeB0P7/z; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59b9fee282dso2259264e87.3
        for <stable@vger.kernel.org>; Fri, 23 Jan 2026 09:09:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769188150; cv=none;
        d=google.com; s=arc-20240605;
        b=LB0h642UASXz4PpREUoCKSasrOdlHjW08xLifs1XHGMPNgxF9SuaFRh7rIw9JgMc1v
         PZNcEExZeuwNSEzX47Er6GBgFNdJb3BcCtKsG0hoJx25JwXKN4YECkDDtzfCu1dq+ekT
         Fk0oUIX6y7ZcHfPFfD/Z3VyDwPp+dMig6pcvECbIb2chFj/SORMATrA45Xi9rklPdTom
         e8DId/NswvoN0vagEkmNq+3ORZvs/Kp9X69OspvUFXvJoJrlrO7a1w0rk3Y3Er9uFe0e
         qMZ+M1ynjXgxfptOjoUoO+l5g+Dc/XVZdIsCKV/jt9MxZoE35iXGun7gYP2DRC/KXziC
         a1QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KDi1jMTaR6KPNr8Xb3B/fDVI4Wv8VBtbYg00h50ejLw=;
        fh=bN1N9u37F9sfpeWZ2mDRMBHW5qqsdrFlcOzPW13gTq4=;
        b=kTqvH6HN5GjjCkgMVa0GNnC9e4WQrkst1tPirYo4x6F9x0i+mp3qCkNBRkG8Kh+58/
         xz784vl7w4ixy58Prm2iltx02HpMisBfFa8oHmmQV02TzBJFN/dDPmey2mTW88h3JH7J
         5+8x57evS432L4cgM9RCZWPsaEl1cotbzwVkYRjviOfR4E11zYJr3UVqW5Wv7BeBhXq2
         UhH6VF12WJtXlBYKqtOvETJjb2PMOBErM5P83uFAqvTaWJnvpou445cls+35PFdIw/Jp
         OMGTjQyFRyPZUXKfndW5LF/pnvr4i2R7tbsiBSmkmvsJkaQcWXauezl45Ln73nZ6JVHX
         vIhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769188150; x=1769792950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDi1jMTaR6KPNr8Xb3B/fDVI4Wv8VBtbYg00h50ejLw=;
        b=IeB0P7/zDL2nm5REWEwvMrY0hKHL6lsjaJCZ1TEjxp3b4FmhzFbqxU2nEjOV8x0enz
         GC2YlywHwbMFKG6rSxyXM70+7OsJjZiCzEY0q4pLOmLXe1nRlJgTz70a84BU6ETSYrRa
         MhbCLZhXwUAddm17Vj1lMnbBs2NTMWXDpMJsTQCoMdCY7muav7ZdgUhcRIQ1DyOyhAQ7
         oFxawTaqXY0ltkp/UeJlQFP9pbqopEvv2WM+3rlut3EeRqguMzi3eA9iAFMrrXCfBBsE
         L29keYCVEesndRrj/Pj1Ir4CS78lAh/v986FAvwTlAxSVwn9jDSnVskM6UyHBEjVHN8D
         IKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769188150; x=1769792950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KDi1jMTaR6KPNr8Xb3B/fDVI4Wv8VBtbYg00h50ejLw=;
        b=rEVzFXlpq3LQdmB/TR+CRARiO1LXZG4Ja45jkcclK8kU+LWm8z6yb7KJydX8S1rhO/
         o6nTe0KrhRNMxxFZmXCrFz8b9TEZIC6T8MUmdoVaFecQmngB7Sr3aqDn6DqP0tgi+Svs
         KEhTveCakv+K1cHXo3m0KjADnM+hFVyQ+qAJHbG5fH0cGu1pAK3xp1Pi2RPQlaQ2z5EU
         yLK+gfTHOhiEzSmG2c6+p4nJ/Zy7DwzN08NfeyCAgIT8JE1fO19Gt8cUsXtFqiYwiLJw
         SqjvW5OmWmdobHwHSFxMq94rlf1zDOls+U+4lMhoVfAMYaQwt4bsgo0/A9SbantdO1kA
         wRAA==
X-Gm-Message-State: AOJu0Yy2E+tqUrzHfShhhaN8s9A9Q+GHiHeEi/fFOHs/kKSEYLPKjLCh
	Zp90uMk9diGWhaQrfrGYfn+6Bq6TRRSVNmYJ5JF9sBEWMQkT/3WBzwNODerc2uCSOlZtl52Hsg4
	euzTYhfIrkW+SRT+joJyUUwcsik9GYZ0=
X-Gm-Gg: AZuq6aLvHJMuA6UPF1XVdwbpjSBh2pGx8VSRfRtLxTiSDR1MaISC+Fzj1VGcZFYEH0i
	YitADgxjXWoPdEbAP7JKrmAi5tQYAxTgIRsuxQTlZe2diI+5m8SJ8pw0o97ESqV/N1ySfHGfCaf
	7YKNlZJ06bqYg2HS2GLyyc6X+XviIwGluqMVCZuiFq7qWXepYjK64d0SmKdAWbHNh36L3rWm/Yr
	mXA/G+e1BDUGqHm4NFIUFEsxIcizN5Fzwg+i/v3QWoCC6/JaNzIFpVZBIoYsB3YGhq8gK2GxuK4
	pLH8SmfJac8FlZRA15OGSV0jAxVQ
X-Received: by 2002:a05:6512:ba7:b0:598:f283:e12f with SMTP id
 2adb3069b0e04-59de48f3b4dmr1160430e87.11.1769188149316; Fri, 23 Jan 2026
 09:09:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121181418.537774329@linuxfoundation.org>
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Fri, 23 Jan 2026 22:38:57 +0530
X-Gm-Features: AZwV_QjTA2OROAQCVcF7Fgzm2P5YXYzI-sYXuCwZDz88Bj-LHvwUJ9n19S-RNn8
Message-ID: <CAC-m1rqcA9e2-3NYKagEahZFxYuNBs8yzpVUEeU=WwZix78f7A@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/198] 6.18.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211403-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5AF1F78D45
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 2:12=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.7 release.
> There are 198 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 23 Jan 2026 18:13:40 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.7-rc1.gz
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

build and boot report for Linux 6.18.7-rc1.

The kernel was built and booted successfull on both arm64 and x86_64
architectures using the defconfig. Testing was performed in virtual
environments,
and the system ran as expected.

No dmesg regressions were found during testing.

Build details:
Architectures: arm64, x86_64
Kernel version: 6.18.7
Configuration: defconfig
Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Commit: 28a73c31d7f5d9d2276c92e1d4891c18a5631e6e

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

