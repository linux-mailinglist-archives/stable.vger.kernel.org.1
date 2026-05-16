Return-Path: <stable+bounces-248954-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBgrA9K5B2qIEQMAu9opvQ
	(envelope-from <stable+bounces-248954-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 02:26:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E01255988C
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 02:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DC0B3020A45
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 00:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5309C2264D6;
	Sat, 16 May 2026 00:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="AQvCtaRX"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E242C1F91E3
	for <stable@vger.kernel.org>; Sat, 16 May 2026 00:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778891197; cv=pass; b=PR3obtfpyqAcDOexMrPSZI2CExl81pqQwARSBZoQpZYncHjRVxZ2tY/ZD3B3roZd+Wm8+0nGcK/gnCUaSS6kb6KtFo+YxipH9HmKY6eywJQpswnKYFaoGVJWysyS6eOVc5e96Qrwab0KneoZSkSIum/OVrwbRoYnYU9H6Kj7QmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778891197; c=relaxed/simple;
	bh=dIIWfQgF6NrKg6ETYNLmA+FpnZ0vFs3JjzDdfduZHW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2CTKJvzNyCwOyhH/1MgCCaOIiQmtQ1MiIsNOtLOt9HZnQbQ9awcYVzeWwpB+nBoiikH20TlErtU13c23s7Iis+AcjIQ0tlOPBEdiMJpzfNKK3HE+Z72VJ5q0RdggTGtEacaiSzl61SToDrnrVB+EwQ9Kz/N3K1FyyweOsI04ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=AQvCtaRX; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1309f4ee97fso384586c88.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 17:26:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778891194; cv=none;
        d=google.com; s=arc-20240605;
        b=AynYnVbIgQiGixwwklMDjC8rDmTpa0AsDXhfMI4Bu8YMZj2pIohKa/RkLmbZWxUXcy
         8qefFZmR5X+mn4Y8kve/+xcCXi9Pvs+8pcPzd8SRxsz37jSpP6BzIFs+eFJvEwtZjSjB
         6XuIjaV1m5ti3i7dmU5l0Dpz5XR4UagtxXTLnSBZISQ63aQzSCQXuA4ZSxV2nxDixzxQ
         MGsVImhqsT+BaexFt8wUpN1AnNwfZmVKlUZzT40EZaJnoGpmtLsiIm+ozT/K5hUeRorZ
         7YHneB41kxUXov+KeHHiS6UNnxkkuqDOoCbmK/TGNvxfmcbElM6SQdPZiUdhkU+kjhtw
         GGJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BW1wsF1uVfc2+mTG/Ou2FeS75ZWI/1aML6hfMxBHNJE=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=dgJpWRDOCVBmFX4uKfQGQoX9ZJ8dCF+Vy7+2jkwioRR06g/zNbOB9nqf25jsI6RCBP
         JKtBP7DluF2QwSURArA7TtLU7fQM2PZCBCb2tcjMr1BAOwZtrHbjPD2i6x5tnwNjAYIO
         yR29f+TCXTJvNScGPfF+AuiAmfLMJhvxizXzo7llwHA2DVHdULSp7LFe3UPf42QD4awD
         861USENXrJXvvqZ8F3lYBkfq9ntFWKRpwMkaxxBdiVZ4Ph5xvR3R/D0+D1RAWoNHz9dx
         0y8LL9W2jkzjG/vl9hq3LiH3ecZKn6mT5BAGeM2lhd70uKxw1Z/zkwLEeCWWXzZkDdR4
         NPVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1778891194; x=1779495994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BW1wsF1uVfc2+mTG/Ou2FeS75ZWI/1aML6hfMxBHNJE=;
        b=AQvCtaRXXE7PSrXPdGT8wkqmLKfQ+7DA26HCYsKOO0C2y5j/4JU80nNwLa4ak4Blw4
         3FyxpkiyqQWsdo6DzCZ3oJq+ngLExDVMPpO4rZoYsKZUV7mk2f/axZMFE5+0S2gM4v+X
         j31u/I9rL0CFHPgsIFd+t1U75hFJOal9LJfj82jfWuUC/+VSTul2dvEG66ty1vWHbilq
         ZemoUysAKuySsxlt+31hQp8WZ7bWdCAo6ZfU4kMnWB8lo8qTqyLSJ+yj3AuWzOzJyw0p
         rDtNzcaxhibjkZfNn13YyvWD4XpU3pDejRNnRUyaRuGEf7ScKkHjGqk6M/Pbp6YG1hIu
         oA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778891194; x=1779495994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BW1wsF1uVfc2+mTG/Ou2FeS75ZWI/1aML6hfMxBHNJE=;
        b=JV/yq+W/Qgov0oNg9cZvuScRZqbiH1/bEV39oq6f2Zl5HrNDQygkjdfW/lBmneHFFr
         WonykjwbTetqOjGSAjzRZPtQIcS3IPGW+UuzHUAapltgdQy6KPVewVmrJIa4lMphIg3O
         PtFooRQca7IXmFdFYdALCMGJdiX4NZx/cytC+F9MocLDhKgzfWvWPfmG5Qvewo/2gnCp
         l5od2EkUBM4SdyNasPlvTD84Ctkr7/NjpF1TugpZwzrkc5brfb+N8Fz/SnqBOvpQY9jG
         mN4Ns1HDI2RlFITwjy/B90mBH8wrtBgv73re6WzErgpjRD3J9O6aC4qm+VY5+E/3wedv
         rtUg==
X-Gm-Message-State: AOJu0YwlHOkGWtsGd0sl1o+Bbl8W2W0XyRvNXu6VDb+g2rlQPxllNCsx
	t0I8pFLlRgpZK2foA33tHPxQSC/Y7o6MK0mrP0NZOVKDaVCeVtUaAbo+v8Z8TMMFwBIbbmch4v+
	gHIn71AyQg9ruKrFsjndbYdTUxNhFKmNXiX5JG/D07g==
X-Gm-Gg: Acq92OEkzEOHi2h5ddwE8F5P5wd4ooRP87VHZopfapibp72ibQCu2n0wGjRWWoFM1Tm
	+1QRzrn2O/sEQqM5uHVaaFurUg+MpTpiWDGy9gSO6ewHelNO7IzSgEz+ulgCwuHJQGe8beJRL+y
	aZyyXB5aUgfecx80YEltJsw3KJBUfBJpSQxDjipTg5b4iwdvy4eI3YpqYTaAAgKNAlwaGGhIT50
	H9z1xzgCev+USEt8+oyOIhAGrN6rrlvdm89u5SAAltseBNYOk5mYdZgZiqHep2GGl0sJiPMQxum
	YS/hYLhN
X-Received: by 2002:a05:7022:2586:b0:132:5d31:dcb9 with SMTP id
 a92af1059eb24-135047406dcmr2737099c88.22.1778891193923; Fri, 15 May 2026
 17:26:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515154658.538039039@linuxfoundation.org>
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sat, 16 May 2026 09:26:18 +0900
X-Gm-Features: AVHnY4LhZDZzxHCqHEtKvxJ7hgkJLOfAs--ulGb4qfLSXmqlJ2peGUyYPW59Fz8
Message-ID: <CAKL4bV4+e3UsQx7rv+k3J0XYGPJkFuxMUGN9Z76rDcUjrLdEFQ@mail.gmail.com>
Subject: Re: [PATCH 7.0 000/201] 7.0.9-rc1 review
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
X-Rspamd-Queue-Id: 9E01255988C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[futuring-girl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[futuring-girl.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248954-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[futuring-girl.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takeshi.ogasawara@futuring-girl.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[thinkpadx1gen10j0764:email,futuring-girl.com:email,futuring-girl.com:dkim,mail.gmail.com:mid,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Greg

On Sat, May 16, 2026 at 2:05=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.0.9 release.
> There are 201 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 17 May 2026 15:46:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.0.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.0.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.0.9-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.0.9-rc1rv-g64bd48307320
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.1.1 20260430, GNU ld (GNU
Binutils) 2.46.0) #1 SMP PREEMPT_DYNAMIC Sat May 16 08:46:38 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

