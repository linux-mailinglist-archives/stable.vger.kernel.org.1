Return-Path: <stable+bounces-126709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A385A716FE
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 13:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197FA1894554
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 12:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF701E1E0E;
	Wed, 26 Mar 2025 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="WjfcLfDt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61037158A09
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742993811; cv=none; b=NVXYiyCtqAyjaQfQvvlIbusuhDnHhD9thf7KxK932n2dpgJyyb0GHcmDL5TG6xkiLz70v0fjEjSbOHdjNChOFKGjTr4fdrsCNyV/YIn4lWGxmgtfo5PcYx3xpUUAMIdTGXz/lWwlwVd6BFmzar8tqcGKsllY9wVIl8/4IaxpTFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742993811; c=relaxed/simple;
	bh=xvdRNCWSoMb4LFMgO8nhLmxtocYZrWldrhUAbUspffI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kPvSlEt8ZZap/Sv7WEcQw0ekEWrGhlHf5nz9QmMo353beWno4OFkoCOvx/LSG4rK5ffXuCTivuibWLGxRA9gV2Es9aHeOXvl6sK+PsSutsUqoGmOSw4EZNcRD9weqKBm15Lcos5Fabn+WbbRK7pkdWGwLNug4TOtGRK0LVAjLyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=WjfcLfDt; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-300fefb8e06so11874117a91.0
        for <stable@vger.kernel.org>; Wed, 26 Mar 2025 05:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1742993809; x=1743598609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRQTudAEXM13GUB8NKDUowp/QnTU6FFua+8YuPXk7Rs=;
        b=WjfcLfDthWyohLKliE5IJApO0G4dYpBvNwIlZUDZx+Zh1w14DPLUfCZVSeapDnUfj0
         Z9M9Cish/3QTFlkIGtiOJU/Q3tGGT5m2ODDVOlyWo2bDnV1IzCZe0zz23Fx6gzUiFQIq
         wRSEbursI2uvzdrU6QrBryyjVKTsQANZf5Uyhdg9bMimckPmF5c9SS+00BhxluwX5Ad9
         TNzMLLXMOL05m5xwk3uBMs3vLUumLW7hZhNwe0oGV6NehT7M/6gAHvKLmicN01P9wAKo
         IA2VBYATDTrOgqUM0kDuAAXl7KvMFEzDgxvl8mir3xxapsd8Fvj4iMIvh/ILT0Koymdt
         knZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742993809; x=1743598609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRQTudAEXM13GUB8NKDUowp/QnTU6FFua+8YuPXk7Rs=;
        b=HyMMQSSv7PJxmXDwOBOGfzhzhUsdUqlSRt+8I5tVzfoUuTEz5q0UVSLPop89R4q/9e
         Ndfs+TrlRPYQQW2BPMJYUj7dswrGbxAy7vkGhyLJWrCV6En2WKTa5tper/98SGrht34k
         IJKGRJYW4Mia5xXeqAbJYhq/A9ArtO+/iN2YG07Tqt1dKA1cOFMNloBUg+j0Kn2/eHEl
         q43U2tooi/gfMR0dP+uXz+p0YE4HuiIwyRIFqo1zpGJMo+TZRxfIFcOXDCVW/QYFKJHI
         r88G85LuZ32P62B0SUn12eOC0Bd1RsTybMKktsZsKqTSHdwfHxF0pJYaF8OZfkCRZhs+
         NAcA==
X-Gm-Message-State: AOJu0Yzo6veSBSYPpTxkg1QgMnPr5tPr1+n7dQQoMxnu9ueDsp5sVaL5
	pij+jY1PdMifNiqu8zvE7YeLUB4p827/VHKFsda22TAnB1IpFp7YK31afpm+sTmdtFlmZGqjsXq
	jUzxL4hqwfQ8bYFuI7IRgHNlQOF+Xm/F2Kg88pg==
X-Gm-Gg: ASbGncsobXt+PV6rEm0ni5WLNqvcJ6avKHIkHhe8fN0wgDJx4Z5l+T35CV7znEBbKB3
	HOqyFpY/TsdrbU5fLIHzQWvL/ndMfi/mG7Tu2C6LTED4dykW3f5WlHB8RylE3xCCNL4Tu5yh2+a
	UeEjFrODuqp46qa6rUj1s+SmrGSg==
X-Google-Smtp-Source: AGHT+IEHnIi6oFcX3sSPTlCWyPe5+ORCR0E86AOeljuBB1GhwoNwr9EkT7VwDALSkS463AkNJD21fbYSqSYAoxTdCy0=
X-Received: by 2002:a17:90b:554e:b0:2fa:228d:5af2 with SMTP id
 98e67ed59e1d1-3030fea0d35mr35976364a91.15.1742993809451; Wed, 26 Mar 2025
 05:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325122149.058346343@linuxfoundation.org>
In-Reply-To: <20250325122149.058346343@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 26 Mar 2025 21:56:32 +0900
X-Gm-Features: AQ5f1JoR9ImdCw0Rs5T9hQLB-tj_Cg1W61XlOGDrmHp1wfzXHUlPxH1S6OVVqCA
Message-ID: <CAKL4bV66BuvB=-qkecDrkRw9AwOxv7pF6CGz_pLX28DQ+Dgdfg@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/119] 6.13.9-rc1 review
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

On Tue, Mar 25, 2025 at 10:13=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.9 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Mar 2025 12:21:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.13.9-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.13.9-rc1rv-g3d21aad34dfa
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU
Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Wed Mar 26 21:01:17 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

