Return-Path: <stable+bounces-256506-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IE7+KcEjGWqVqwgAu9opvQ
	(envelope-from <stable+bounces-256506-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 07:27:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A59B45FD586
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 07:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82D513016B09
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 05:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8FB39EF35;
	Fri, 29 May 2026 05:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKGen9zt"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF59E3A1690
	for <stable@vger.kernel.org>; Fri, 29 May 2026 05:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780032443; cv=pass; b=YSBzFRUVide2wK06uqvUHsSBmztqlmT36t8Ei835oboGxpYs0ExRuoMjGlTYNf6Mc5CvIsL2aNhfPyvf8muH5U6gxHVDR17DKn5RITAzdBZZj1su7UYWBWtW0KpBXCVDjk8P4eilx7iuEHiCKtVLxwM0FO6Yc2JhV9JN9bOb3p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780032443; c=relaxed/simple;
	bh=MUXgWKwbXep5RG7+umAlMuGw9dCMPtNGKkuMHnQffV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Syz3KfcevBZlzJ2aMc12G3xfdlfue+LvxXH9NiyyVRw87FvvQMs4PWNdhMZ6UeTns93Xxxg0MXZPENNJngLFzCV3X5B1tjmXe7ZKS8UxKwE6nI3qy8GlvRdV0ZD94Nd/uGGgN/IJDvN5yQfvLixKMlRb3x/mlIqP3PvD/JuII80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKGen9zt; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-304b8ced372so3987962eec.0
        for <stable@vger.kernel.org>; Thu, 28 May 2026 22:27:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780032440; cv=none;
        d=google.com; s=arc-20240605;
        b=denw2c+8mewdeA87k3AZexlaMhdwjwob2nZLeQqcsaJM/xTAHpvWYqm0wW1ECfhMOG
         hDFCa2dUi9xf/yKiMV3mXZv47RGNWJwThJYwZwhNHLmD3nCrb5d2mLygeQTlLdmzoYY9
         IX7/Qba8xNtXEkEp1AEjl/Wh8nvaaZ7jORSNZ7SsNKLQdMuLu02ghHIlhUMsRoilkMV8
         LwIoXkCncmC24xBdM6a+EHgAjr+TOFVn3gCdkjCCyqb2eUHpvyg7C7RBN3wRVnCx/qR3
         YzyVcE6i6EWca9Q6xmm3W9A854YLAOlLkaB3AA18LJ4w9JCT0EAKKNijYCBFaz+TWnwb
         +7Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PvM+MHSHZ+xi/ne3NmT80GH0uDwpYd2vFIpgtDMVLSU=;
        fh=ZH1hdZSdmbTzG7nN5TxMMdJtW57ZGPw2eooQ0s3pOjw=;
        b=BFhroc6RwDSiWzCOM7QBVHIauurIwm15po6q25dLykJ1QZtlTa8bE3EGJasDZgz7Gx
         3uvtza2G5uBkIVYjl2dPgQg79q/dV7wnhnwMTLZL9e06l39mIKqqwVgavZ4lI1A7kRuI
         9tzpU05wnR/jCfM54bNsrsHEdRmIBfOEi53LGJfpBZfH9Z8igsjxQG67Wyg8osMYvK6l
         WnQZStxf/Zul2ApNxmI33AiF3usgKBRW0hpC0F5suCw1fKDU1oTDqHy6BGNHV0RILl3U
         SSBcKKRz6IIM9JihE0Y2YxXXIAoByOwBBaxtvLQBMw3G0bTIJ+ijYP2OXtJRRdGaWdc6
         SUOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780032440; x=1780637240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvM+MHSHZ+xi/ne3NmT80GH0uDwpYd2vFIpgtDMVLSU=;
        b=VKGen9ztxajO3V2KlVgK8vpy4U/1vTuJznDP24jqVjMZr6yxC4pan3Ovur1/JkTO0b
         eFL0ykhfpGPTQRlDwVZ7BJZGg7AIr4pwheHvOVmLJqD0e6sdJ2O7adz1kuSvoRhw+Re4
         6yl1vNH5+i86EB/2dpQdRl2SMYI7dZFJRSrCTHb/F8Vm53M77mrEqlvMypuA/bKCeicc
         +nvPElh+OBTwMSqJlUJpG441wTU/WbnmX1VbUe1nGWMRVbxMFgkf2ZqUqjLqaWexwbBK
         Br6ixi4c6VU1hwJV0/I8053JokSLcCA5Gz1z4kyz3WHolzG3PORB0n3Jo+Ge0hOJSJwb
         Ifbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780032440; x=1780637240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PvM+MHSHZ+xi/ne3NmT80GH0uDwpYd2vFIpgtDMVLSU=;
        b=M+CWYJUxMx9RbAAyrpTy0DZiOYoEPNpR2dt3n8jOL2ihRFS9154W/eJYzDou96nTHF
         B/PMXSBTXp4RYhrYdgCQHQ6iv50yZ+Ind+ZZ0WRBkiFG/tW9I0X8pdWeUiVqdgOlZrDJ
         k9KoJf7wcf8X/uQK10sBltMj/M0u9HicZNczvwdeG0BEoiCToWIRKREs/x3kR5pfqfZw
         rc3rEjFTP958yqfnowpQRydK10hHWkodlQhepoAjwqGKNWiqc+W5q8zGETWaukIKQcNh
         Gq7tUg3NfEGBUAtz2vJMEIMkUlLza69Dt6CeKoj/IP2iUokFrUEuE6AUoQNDu4Gi2ue+
         A2vg==
X-Forwarded-Encrypted: i=1; AFNElJ+Id0f/aeP9bKP/3r3to/f12fi8GsRNl0BBn5t8+OzukD4EXpUMsH8C+tvsvcVCXW2gnuZQHyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdyaEOl5HX2vx1Q2m0o02KiKLk1eVYoNtAaVeClUGmvtsy8XEc
	BeAk+yi4UbxSr9unJcTMeQ+LXrAhIdMhEOs4qsgjKArlRQ9g6VCtCh8x6W6Xiwv20xPijrIUEtC
	DOdPH9Fj9dEKgHeuq1sCoIKU1GzBb6/4=
X-Gm-Gg: Acq92OEj3IfvIwC4GK8oKOy+5rdTzOGO6/0rbRUIyN2Kt9EDrWGGTYTfBpyYif3hNU+
	3ZiouYUQ7f2cqN8qTS8F28iev4+hpmuUmAfD/Bd3lqioTgHhXrkVTv5anozX2Tm3muU9/NPx+F0
	T5F8mki5TbKBf85kjyHcH53T+80ApA8eVMWVQcCeHTbatCFey0YxosA+eTvGXh4XUJPFhoaCUXY
	Wq76nWhAmrqQrr5m0OktNNcIHn7Nv5mBxETcJnXUyEepGJOoIbvtXZ6lBrIvIJBnbchmA7izOJj
	SS/XoJOS71C7EREx3v39/o5vLUAhz3MqUFWJqBbt3AwRGs6t5k3N+NYcy/mi6R+7RA6HpX7Y39M
	IPIlnPZEp7U64156okPRflOlqlv36PuXWkzeqmZfHsxdfQOUsDD92WJt092YU2pUfQTRTf57ZSC
	bK/BOokIKZ8mO8ITgopURV0wk2CYvKS8gfs69m2fcEtVCS6XFT0k9VJWmHjDU=
X-Received: by 2002:a05:693c:834e:b0:304:ed85:5f43 with SMTP id
 5a478bee46e88-304ed856527mr200456eec.24.1780032439839; Thu, 28 May 2026
 22:27:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528194646.819809818@linuxfoundation.org> <CAKL4bV73k67Qg1dfhPV18S7_yTuVzkVsBLO0sMsdESoDZnwLcQ@mail.gmail.com>
In-Reply-To: <CAKL4bV73k67Qg1dfhPV18S7_yTuVzkVsBLO0sMsdESoDZnwLcQ@mail.gmail.com>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Fri, 29 May 2026 07:27:06 +0200
X-Gm-Features: AVHnY4Lek4iSkv4QOXfuiv4M4cWEdrmILjbTgn-2XJmNAcSjZKsb95Ym6qDUTbk
Message-ID: <CADo9pHiejnrVUz2pSA4kudUwefUU5Od5EbpMUsSaRDkCRRYTzw@mail.gmail.com>
Subject: Re: [PATCH 7.0 000/461] 7.0.11-rc1 review
To: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	sr@sladewatkins.com
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
	TAGGED_FROM(0.00)[bounces-256506-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[droidbittin@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,futuring-girl.com:email,linuxfoundation.org:email,thinkpadx1gen10j0764:email,archboot.com:url,inet.se:url]
X-Rspamd-Queue-Id: A59B45FD586
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tested-by: Luna Jernberg <droidbittin@gmail.com>

AMD Ryzen 5 5600 6-Core Processor:
https://www.inet.se/produkt/5304697/amd-ryzen-5-5600-3-5-ghz-35mb on a
https://www.gigabyte.com/Motherboard/B550-AORUS-ELITE-V2-rev-12
https://www.inet.se/produkt/1903406/gigabyte-b550-aorus-elite-v2
motherboard :)

and a Dell Micro 3050 with: Intel(R) Core(TM) i5-6500T CPU @ 2.50GHz

running Arch Linux with the testing repos enabled:
https://archlinux.org/ https://archboot.com/
https://wiki.archlinux.org/title/Arch_Testing_Team

Den fre 29 maj 2026 kl 02:11 skrev Takeshi Ogasawara
<takeshi.ogasawara@futuring-girl.com>:
>
> Hi Greg
>
> On Fri, May 29, 2026 at 4:56=E2=80=AFAM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 7.0.11 release.
> > There are 461 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 30 May 2026 19:45:49 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patc=
h-7.0.11-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git linux-7.0.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> >
>
> Linux version 7.0.11-rc1 tested.
>
> Build successfully completed.
> Boot successfully completed.
> No dmesg regressions.
> Video output normal.
> Sound output normal.
>
> Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)
>
> [    0.000000] Linux version 7.0.11-rc1rv-g547c0212c36f
> (takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.1.1 20260430, GNU ld (GNU
> Binutils) 2.46.0) #1 SMP PREEMPT_DYNAMIC Fri May 29 08:35:15 JST 2026
>
> Thanks
>
> Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
>

