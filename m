Return-Path: <stable+bounces-224515-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALjzAxI+sGmohQIAu9opvQ
	(envelope-from <stable+bounces-224515-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 16:51:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5AC253FC4
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 16:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D2B731784C2
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 15:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739413A9D9D;
	Tue, 10 Mar 2026 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TU7jcKyH"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7699C3A75AD
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773157671; cv=pass; b=E7wVkcLo39Ukq/Gr9vOPm2y9P0GLImjzq0iEhxErCphrjAniNsqD/fPDSyIXfF3GLNe3WRCgvvjUG3qYA95urbLqazOTiQRMXf2MSvC7Us6oMaMgxtnAX8lROJjreBAVmXelzRc95hKu9QDADjsmmH+8hCLoDtKsJl1iSHPjvV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773157671; c=relaxed/simple;
	bh=EHyZYX7N2Ag7kGgS8fkw6KB+dSa0nCGCcgdsjQfQGSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzrAIwvf2uNiH+Igzozz/YS5NL5v3aR88VeMSPpgweG7paI0DCS8wDkzEMiayMadkORkBWtb/x0VtybZH1ifYgbWtgQEVg1GJ/ufZq95OE4RIZkp4FHI831537E5n+2bo1SpBIZcvbmszoUmeT3l+1rdBe3eQgBdR+qSLfoO43U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TU7jcKyH; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a12cd0bd79so6552357e87.2
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 08:47:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773157666; cv=none;
        d=google.com; s=arc-20240605;
        b=Z11btmRJGL9MNAfPah+qpZ1IxOlKH3bDhVZM0aONnGrvIwnzmxvyoEga7gwPUsibcF
         j591D6NWeB/QYpcf4UMwCMXXkCDyjjbcrxoGwA/DXMErFRPCD+F7Bhd2u4KSOa2b9Tws
         ASxvi9EJJOrPapHq4ldZlGzZmKdFdZovNgtmmc4wCK91ldkwJ/k8qzaYeAVb53R1rl9k
         ledNg8UNS8TXxzVkyfeUWjrbephEj/z82NxmFm1BZvjJNnTmwGNpEt4D463eAoz5mRb4
         xLFgEzC9xBvYyXX+iWIXBWI2aPlqPBNxXFXd7TXtQG6XIjjblFLkIBeMHXZvSL0fvo9q
         zLtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cCAAraqL1xyqLdScJ7c5oXD0oyUTfhfAt4hvbZXuzlg=;
        fh=nOCGkHUh2KeDTa1SL6UayRrJ5tHle296sB0OcOvBXGQ=;
        b=iaV91jasuQw+WDfwoR7y+Ad+XHJfMFZSKpaa5Th9trOfKBbZhCZKo0G/HZLuWXeO8i
         Z4TBRLuZ6xceSL5iWDJKw9Va3xYBO5oVT/t5C/f3BxsHRrOko65/mc6kTuFaLP3sSqJQ
         Pa0Og8JQuVvHW/BHK37ZqgAYIf3b8QOsXKYOZnwXlx7OLrLpboLnUP16If1eKe3UBj8+
         FkFucH6GwpC+sS7AjNYaZLDoe+iSf77iN+c2PNEOZVfJMxSlMQv+dJAIAA58JeNp9JZf
         xU3HyC1zXoOwB6urcTE1Qs8asVuC9wOzrgHPcP7CWM7qpW/qPysXu+7ARV8QOUN9Vci6
         mZvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773157666; x=1773762466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCAAraqL1xyqLdScJ7c5oXD0oyUTfhfAt4hvbZXuzlg=;
        b=TU7jcKyH7Sw5S7MRYToTnrEee7sfUOVM8DG1ebGv+QZ9nnTGAE3gLhf4yo0tS8NwE2
         X+i2N6yURGB/yw5YfFg7XxyQrhlg9n9gexRd7FRYDYNCH1XDiVKUNjYno1bVbG+1g7+g
         i6P0lM7BrnXZ5B+ghM2nw/RjuC1QYYr+ASz8TX9rC3/7XLAtCuRw3tMbzeQ8s0DgAngM
         owXCfQKh6vpJm3qPJJr23g3tnmVlp3GrPPvlhpNbueVU+N8QoSgWHSfJQx7Ec1x4DWYC
         I61zGGivv2oFw3uWByglhTYQiWUhY80mjA0PtvPRIdKiYRq7aDlXif9+B3vNkWTPFkBR
         GT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773157666; x=1773762466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cCAAraqL1xyqLdScJ7c5oXD0oyUTfhfAt4hvbZXuzlg=;
        b=cmREtoIgwROfzh/M8I9kzdVbM1+R7MH3YANUYVhiDOBnFDsWGd2KACY/szAhyhXVur
         upi4vnbZ9X8w97raci9N9b2K2WETzUCADYDh0Uj9iamKZ9bByxsDaU0mgulMk0bIxrRd
         xh0d9cE8Q+d0mNFmLbT0pf04QfwijWU/ABdiBBTq7uxpzSNx9BfHtzdwRWx+iXSzl8ka
         NCW5BD45yktIYALRMUYtdr6KHT5ix2glo/osUvdAJDIZELSVgwvsbEaNLygDmjrQGlKR
         5yL08bIu7MxhHDxCVegLp+BDwtL/6Nw9qRc+3iNRLZVfHB4/Mnr6yFFyllWCjy4cNe2G
         bWvg==
X-Forwarded-Encrypted: i=1; AJvYcCX+r0FBH4cb2C04DD2DcJV1RKlNldPGImvlZQNmkLWN7qmGwOu7i+ONr2d9sfNzYJfYFC/ll0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfyHNjAs0XALbakKI9h8WCO+5VANqJtzAZtQ+lwyYGQ7p8GePo
	8+yGN0W4Bl3cJcReKL/5md0cLBMGb8iY/wyAAZMHuqxdpRdHbfo7+/4/ORFLIgnLn/EUYzScSi7
	q/7TzDzxFHVqy78t0/5VfxcSYCHi0OeQ=
X-Gm-Gg: ATEYQzzQPn9LPZKLRB4jK2Gvd1neOCEbHHZX1o5482bGXXZlrlMyC0ZBXXZsdM1tFVN
	n+bKF/NGBtMc5C7J55kJs2j6CKiHxU0Yiej/3YIKBeOS7NdlQUsr/nzJX1g8CedPOS1DaZ+v+Y2
	VOTxChBTPIgfmJvSlxpLJ6y8lo5hkPibbE4Xxm/ufa9B/lSVZ5S9IN26pqpaUJbs+ONUMFeninb
	5M21dkyf93qV4r6plsXOOAidRT+nALjP/9A8LV/RLXIVCnzkasptDV+225i8SEuJZcA0RM+mnu9
	e6bcPQ90FfVbs0LiTmy+ZCRgH0h8h8K55jJbG3Fi
X-Received: by 2002:a05:6512:1109:b0:5a1:422b:dc0 with SMTP id
 2adb3069b0e04-5a1422b0ed0mr4137551e87.26.1773157666153; Tue, 10 Mar 2026
 08:47:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773140654.git.sashal@kernel.org>
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Tue, 10 Mar 2026 21:17:34 +0530
X-Gm-Features: AaiRm53OPfP49ME5AEVwojA0eEJs_aTtVA6RtOSPJr4AW1MZH7v6HCVm-4alwC8
Message-ID: <CAC-m1rodmWhAkFPNUaLfG9w1iOm9ORm-xR34PxNXZ_tFzFtpNA@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/311] 6.19.7-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org, patches@lists.linux.dev, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6E5AC253FC4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224515-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dileepdebian@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 4:36=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
>
> This is the start of the stable review cycle for the 6.19.7 release.
> There are 311 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Mar 12 11:04:16 AM UTC 2026.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/rawdiff/?id=3Dlinux-6.19.y&id2=3Dv6.19.6
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.19.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha
>
> -------------

built and boot-tested the linux-stable-rc 6.19.7  kernel using QEMU.

The kernel built and booted successfully in a virtual environment
on the tested architectures. No issues were observed during boot,
and no regressions were found in the dmesg output.

Build details:
Architectures : arm64, x86_64
Kernel version: 6.19.7-rc1
Configuration : defconfig
Source : https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Commit : 2867504d9c53260444ef95c17adeebb724395237

