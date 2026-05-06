Return-Path: <stable+bounces-244345-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDPNBJf9+mnjUwMAu9opvQ
	(envelope-from <stable+bounces-244345-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 10:36:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFEA4D7F1B
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 10:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01484300E02B
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 08:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612823DE425;
	Wed,  6 May 2026 08:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNaXgLCA"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28473D0907
	for <stable@vger.kernel.org>; Wed,  6 May 2026 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778056594; cv=pass; b=pGlXjLy3WImReP2+wx4HCO754J7/hCGlQrrm8y3IBKmxJ0z48pNpMO70CvAe2/d4AEvdSOmgJ/lWkQ2L7n5yuzTAP1euVW5xLfukX/ILdq0qiv6Wfoypt8d7qAtuLHcPEalknn8voMymoFJXSrbzRNs4qqJcf7YBLFnd/fQ+3pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778056594; c=relaxed/simple;
	bh=dS9TgirgJNLrunDgjKnae2iSJPF2xTNwFtcU0v2imFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdSC4vhyToIpUBTxDtOhuwVQWlBekC07HDw+cpl4yyzNnWR7jcS9uwUiDuVW+A825ZYrmBY7TQDg/vD8yWfluCPeJ+pKpLzWsPpnUbodGB/Jjl2OLNuLzhIXbI9OqbZiwwrMFaxz9CEbro4Bo+t/w79rB8Py6f3zY0P8xbGuKS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNaXgLCA; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a860667fabso5016117e87.0
        for <stable@vger.kernel.org>; Wed, 06 May 2026 01:36:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778056591; cv=none;
        d=google.com; s=arc-20240605;
        b=QQPW6vE79Mo7hvwBKr4XjgsfowHuwIp4DFD79HMtpV8sYo802jwePAZrG3+/s9URU9
         QhbaPPUWRJPeRZA417TUrPuxinDQ4t0/ju05tywXeEb9LtkfJRdtgF+KiXJBNeoIauhZ
         GhBnDUIIu0TU4nKWOy698t2PXq96wiy08ekq5DiS7cLJJlelnCNQKMsQ1LCurOWxNL5R
         7TDLf9ok639ac+JBZCKapvp7/FYJAhtax/2GbmfdUxsQXIeV7q/Ju7VdcmDJ4e8vuZqj
         ELNRwTycbNT99EavMbdb5DvwbzulEFLqgiLVN6/FGsZkXdgmB+0ZxsN854AaPB9bt0x+
         hp8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iJN1jCsJkBciMc+1+SZHTiIpvUTkbx/J2kTZk80x++A=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=ImWXareyJM72ZZZHALUSaOW4xqdVYtrWlZBjQS7y5pue+LiApM9t7MPTHZxRiovoT7
         iAvT4qiB5ETnhWxw6CX09Mgcujn4K4vGfTpuEIQkw4T6igOeDZ/N/akmngfSLqdidjQT
         xXTdqWg0RbUzmBcSQxbndotg04fRR34mHXO75kn3IM5fjUxjbUFE5Y1YuZS6mx4ifmz+
         6fiy6z/W7EWS+ryf2wLkYSDlaoBvMRO9CnoHnmKwli4MaMwbSJgkjF5bOsrLz5TN/irl
         GpXGFf50fvRSml3UY35dMZU0rQiMKXBpwyDcFGRqFLNMzZ2utZJIW7wRwos6HxEKTfaW
         LoWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778056591; x=1778661391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJN1jCsJkBciMc+1+SZHTiIpvUTkbx/J2kTZk80x++A=;
        b=PNaXgLCA1HEc/8Ib+gsX2eNS/8TUpjTJfuDIypptqxaHLc4NXfr6VNpFckdi/PZsHd
         A7ybADlwonYTafiSxZb4Q0iT183sk3JJwX3wAJcLbvJCP58DxpaAZibbDkZKqkNl689S
         Gdo1XbXmVBBKhUFcX/lKooAoqaBcIlAWE537KoKt50sxaPXl/cC3l3hB+SPzzjSGi0uN
         +HaMrbK5bbyvWai1SprAa2LOI0NHBgDzgKUI4+bCgg/dYWghN2xLknpOUF3I62tyQx3u
         ZB16cJgbdvA9e+lnp5+Pm8HXV0ZnEcE35bRMXjK9eIwJVC20CYFinb7Hug+j3JF30+mF
         Z/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778056591; x=1778661391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iJN1jCsJkBciMc+1+SZHTiIpvUTkbx/J2kTZk80x++A=;
        b=kayvaB3dp/smE112P+lr8PQE7PlQPHsA3NsNRgfORv6hvvJJdk5g9qqcYajYEjRPCb
         Iw8B/mWjx1XJUNh5e7Nqu6Tka0sn5oKx1Em44jG6mCWyjbRO4bH/tQtkWRsR2f6qC8YJ
         xNopKZNktbDCl8/LbptnOJuGu3mYuZL7POqKKUbaeTQnBPI7aHT9TiBHhk3G0QkP+Cso
         hEhuHqtvfc6SA0/XbmA5Acq0qf1HhapnoN1/x4ECUzCy6FQ0zu3M98Jth6y7ZpGDZKoG
         5ofOhj54rPwTQ+HZIBGTsZhq34fovKzqDeK/zfE62Ax3vtD//QA/e6yxH1jC1LRfmI5a
         V5sQ==
X-Gm-Message-State: AOJu0YwKmaAov8V86cTcAmCL8WFObtqpMgnnpM3bC1CDIw0vx3kqCdJx
	zbaPLXUMkpum/XtpI/MTa1Quym8cBdlASXYUFy8Qv83d2KnOncTArUuW8JyQkHz+tZw0lC7Y9pW
	w0UhgQN4XOasDu6j/qEeaVlZKZi3YnJU=
X-Gm-Gg: AeBDieuSj72JPvmBs369FATCWqnnN4UnVIFvTe+xkkfa/dqDAyZv01xwfzxAWqSh5Xe
	GJG6ENHbTz3ckz5kmEdTNh14Z3dXkOnoNB+dVD7MGBGPNk+bCSXJjoSXurFDQcKWgx6HX75ajJM
	HTCfreEeyiyR8sD/Y9rUYHeTfjwVnL/dqf1hQ7QsREvzvsdM1ad/q2D0/eWtW0Rg/e7rvQF8xQP
	weQCc0m3vmmmXOcbXNJ8vudh2rJvIvs363zusO/Z5C7fOs4xQvYZCVJT0bgnYdNV3Qm0hnPvNtN
	uEPpgnauRv6AvQMyjz2Fb8hL3qwXWiOr3XOUhI7bPn4h/CdrDw==
X-Received: by 2002:a05:6512:1191:b0:5a3:fd83:13f7 with SMTP id
 2adb3069b0e04-5a887ad8e1bmr915708e87.6.1778056590402; Wed, 06 May 2026
 01:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504135142.814938198@linuxfoundation.org>
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Wed, 6 May 2026 14:06:17 +0530
X-Gm-Features: AVHnY4LEVPqLoosgK7r6DTP2iJjJh7U5EtQ3o6nZFcoMMJm4VKaytZNR80oKBBU
Message-ID: <CAC-m1rpwoyMAGfh3Rhj6Yo4CR16fZ4V9SEum06jOcM1yr=BzoA@mail.gmail.com>
Subject: Re: [PATCH 7.0 000/307] 7.0.4-rc1 review
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
X-Rspamd-Queue-Id: AAFEA4D7F1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-244345-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]

On Mon, May 4, 2026 at 7:26=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.0.4 release.
> There are 307 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 May 2026 13:50:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.0.4-rc1.gz
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

The kernel was built successfully and booted without any issues
in the virtual environment. No dmesg regressions were observed
during testing.

kernel version: 7.0.4-rc1
Configurations: x86_64_defconfig, defconfig
Architectures: arm64, x86_64
Kernel Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
-stable-rc.git
Commit: 4a299534048e330448f6cd13a87bb7d23549b6d6


Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Regards,
Dileep Malepu.

