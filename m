Return-Path: <stable+bounces-235284-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMqdE2bI1mkLIQgAu9opvQ
	(envelope-from <stable+bounces-235284-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 23:28:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF773C4126
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 23:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E66C3015D34
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 21:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5694438AC7A;
	Wed,  8 Apr 2026 21:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jej4zhsk"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84DC386568
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 21:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775683681; cv=pass; b=Ra35MKmhvNejmAYejwOaAGpcjlSLp97R0qwNcQKwUH4xooOdbUbihALbwR0Q1RXnfXcijhAeMo/9E1heHuxYfRw7t/NNOB+nSj1X7r06Rs16YzEarwRrTgUVFHOT1oJ8lsKaUag76mJOQT6BNQySw0h4lQOg3Tj8KyOUiZwWK8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775683681; c=relaxed/simple;
	bh=aPnizP9b0OD1NHWgBL8tQ7Q3pBsJWHAwmODj1zIl+lM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDqoOZNRnuXH5SGRvwqK/vOCAa9B3e+TtNURTBURVGcZcSNypxXb4+OLnLq61W7CISTCJZP0u87FcuHwYX2CwQgGBA4pZGv5JgQA5fmsEwyT878jwn53FS35KExtiPspzHKvYCUdwhDXwzTSAxkCAwZqDQeU65jzvTJ7M6UyRk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jej4zhsk; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a0fc5e2c59so205254e87.1
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 14:27:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775683678; cv=none;
        d=google.com; s=arc-20240605;
        b=Ymb72sFYzZ+nSDan5G8oiTxMxrTDK8mpVh+mdg4L6QN5jzuFZCVynvRQZpXiK19Q8m
         qPUkATQtHPKIUJ5Q+Ub1AB5Vke5AgtIh5nd3x5NsA/IWNzn7FKySE5I7cgxjUXjNFW5p
         xXQoflypUSTmPy45evlfZaIU7Y7GlshdVCfvfF4WmVIdBRlLp4pnRb2hnbnJSAXoTttn
         LWWCvUloLcEBe7Fmv6SdSuu0AtSCNmjYIfuYBhdP1B6UVFb72NAvvYzuYL5gJGpKTt+r
         HWRTE7Lx7KlEWNeiZOgoc/4Ksw0GalF2DiRCuowGdnAcriL48oJv79xy90FbJYQ+93pH
         Cflw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5iGEsgY4r8/Vrve1iS7BbNBntHcD0tK+fgBtch+C2/4=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=dj62hgyuvjytH0MziWMfcVCUJ1tPJ0FqGLrwMcAHRJ6zR5TKryFDdupZKh5MD4dckf
         rb0YE/fr89ys0UCFt4hmZXLOQ9QGv8Ut7l0USnMtTkqugQ9/R3fGCTUo3sShAa8x/Fdv
         hO+EBh4fSHHRRPkBM6RU7FF1rlXLY11gpZqDgGQAIo+wzbZoyZVet1uDWpqzEOHxZj49
         hvSf2nWHQShaGg8+Yo3LXOPNgVCc/zNN9TFXqVHvFaa3yMWr4xNI7omdSpVoiaOn0AVY
         8Wbu/6D+dHRRDxnlu/Psmx21qd7K3BKxl9LsmZAaRpFkWAQ1S2j5PXdFhq91yNMf1clY
         szJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775683678; x=1776288478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iGEsgY4r8/Vrve1iS7BbNBntHcD0tK+fgBtch+C2/4=;
        b=Jej4zhskqzT1MqHOD5hzFx302dI2stNAh32/Hpf5gZ248X7ghCPZ48sxULUPgfkgYo
         6lQwrsjz/aJ+R3QTpmZ5JoJXiocSpn8fk6oAAD8oqX11NHZ/M9A6OPD+1fMnDgD1F9k9
         Mv10oyWIk6g5+ZFyRyvvlvdvp2MBjIRtOpi5NDpLkc1JBofTY1W588Bu+mRxrBuRsV6K
         Dd5AWfVf6UGt9TWtp+4hvVlekw65SG6HoylqeXgNBMgT375dZmYCXPGClqssk8c3MDDG
         QstgDZ7X1ePpaKco72v+Ny0xItkLgDMHx/yrLy6a3BAdLlQGMgdvgrrJ/ilZQSGQmYKA
         fF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775683678; x=1776288478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5iGEsgY4r8/Vrve1iS7BbNBntHcD0tK+fgBtch+C2/4=;
        b=eO2ykA+OQ9uJ+TUIzB9TppzI3VJL0Dw25yZYgPt28joexl0WZemHvBFbbCPSOEZImu
         RyPhDVKKP0MKIKoSifbs66wVmrWQOlxCdC5c3sd9ScUrLxqTPAt9CdTAyZSPBmnhODXx
         jWiLx7b9lsdRBQ8+SRal4TJ6Bw9fMcl0mxruS3b2weHw7LVCpKN1lYLzm5/0jvkZ2e85
         u13lRtOY3Ho5E7fSV4TlQuQGa/4qtpC9D3jaQePuvp5pD5jEDQZaWYerMe5nDfGKyoDC
         XvaAvg/TVDU49cnaRL2EnrcKRgqosErgb4u0u/7gBNYceKISRzxkNudh9kxpX7QpcCUq
         qXOA==
X-Gm-Message-State: AOJu0YzeZEZueqcFTvhyeOHhoFvvUlewo5BzrvKd0mVdFlfdAlQqZlf7
	0hrqiICItbBtUIvCFH9EpTmq2jf6GYgwweUUf1rtuUdplaeU90lgIiSFgqERODIY0KCSjFcON+A
	0gzrUcIEwWuLgKNi8yyP3GXsNrTNoKZg=
X-Gm-Gg: AeBDies8GrzkDYN3QWiqNOMIcSixUuf6R81uK2ADKVaJfFuPzXAqqmSDp+AIUECelMj
	m12mTB5DFkcMkhfL+DpHrQtJyfJf8rbeYIzs8en5DChycxFyc5kPOcBrPLcOps0+mreGFTK5wZw
	Wli3ijWWYNgSNuf4u3Poow0/IUbp7zj3BPeNiLPCxf/QujkP2J8Gp9YW0DmED0XqJ8iHZdMS6+n
	OscUXqwXWa3Figee01L6Dyz7wdq9SO+LUh6ExLigG8Ja6EHupNf/Th9p6PO7/gfFNGzUMF2bs7o
	1DUR72lEDpokO5iX+z7Uny23gYRg4K6DS8Hexfg=
X-Received: by 2002:a05:6512:3b0b:b0:5a3:d38d:c303 with SMTP id
 2adb3069b0e04-5a3d38dc68dmr5885884e87.41.1775683677609; Wed, 08 Apr 2026
 14:27:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408175933.836769063@linuxfoundation.org>
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Thu, 9 Apr 2026 02:57:45 +0530
X-Gm-Features: AQROBzAzdjB6HUBtd7EKhqAAVT_KbcstgZfWFRM-qg5aEgQ1Dx5PfNSrQguo58A
Message-ID: <CAC-m1rrNc30MHbYJPDo1t4Ad3C3TkYv1+ZjB4LVTT0_MTLHV_g@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/277] 6.18.22-rc1 review
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235284-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BCF773C4126
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 11:58=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.22 release.
> There are 277 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 10 Apr 2026 17:58:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.22-rc1.gz
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
Build and Boot Report for 6.18.22-rc1

Build and boot testing was performed on version 6.18.22-rc1 using the
default configuration on both x86_64 and arm64 architectures in
a virtual environment. The kernel built and booted successfully,
and no dmesg regressions were observed.

kernel version: 6.18.22-rc1
Configurations: x86_64_defconfig, defconfig
Architectures: arm64, x86_64
Kernel Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
-stable-rc.git
Commit: ef4577f805c0b4438b7900b9949ad1adc17cac9e

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu.

