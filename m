Return-Path: <stable+bounces-109171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFD2A12DE3
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 22:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB0E1887E4A
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 21:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DE11DB15A;
	Wed, 15 Jan 2025 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="OkvreKIz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2AF1D61B7
	for <stable@vger.kernel.org>; Wed, 15 Jan 2025 21:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736977487; cv=none; b=XC8zynPknEqIBtLiLr7UaAYRhJjGcJYuM4YATlJSHMP4YZZHWu4X+UFfHTL3qP64wuPQFjELDJNANE2f6oMsNoYGZahPLirhRW4ySGtx2vZjazAKlwjojFgK4Ze8lmSX5DwO8hV7SJaO22dkPmijI636KFmH73RX/ykaVNTHLig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736977487; c=relaxed/simple;
	bh=ktwr+Bks+JGEYPz2bxmRQo+i2FTLq9SbvvFZOGDPuBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HILMyFWA3get6dW0kTPAJkTizFTRSd/JU+pmjIQETsOVKSjVg/zAQYcAxRXLiAZRKVmlvvWHR7vak/5/Wka9LnddPU/boxFunkqQu6WNlJVr2Jzr7jDEodIXAEondXXSYCEZxCSrLfQuRm4syTPVS4yBo2HnvdkKXJzEF1sZJQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=OkvreKIz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216426b0865so3026515ad.0
        for <stable@vger.kernel.org>; Wed, 15 Jan 2025 13:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1736977485; x=1737582285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvB57iWG41YV/c5cBE56VtHaQNyu0vUymV/5xtD6lV0=;
        b=OkvreKIzB121R1+IskNdkmtiC3BiK2qY9B4BsBR9SnfXkLKylUW+hBiD+qSqIBUiwK
         DFatjBOVIqB3jo6TmGXXgafR27PeG9CoY/yA3QtfM9Fxv6R7wajFyNEOquLQswRcqP++
         0oUXjGJdRSKciSCwaFU7X+j0Ni4iLyUpo267xR8tbycDRHpPawyTvirkMwn5GFpTfcTk
         86ZUXLvfXX14aiLImI6jpIJXb0tRcWLH87mnBviMydUnZya7hi163UV1F3OZs93/B5M4
         51CnvL/M+kII9RKR0e9vUZmoqEWxuPHtPamHSk84FBFFhn+9YfG3oQVfB9bhRAVHdWfL
         edZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736977485; x=1737582285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvB57iWG41YV/c5cBE56VtHaQNyu0vUymV/5xtD6lV0=;
        b=n/WAvyK41F2IYqSY3PxibYbOTyLRI0+lUzVLnLEMyYZPhtizWEBYvFz6ZGuH2TJFhW
         GK84eaX4Orxq7yph5ra5W3HoyCUarvEWOJynQCTqe2hfodystAz1LyIOxo5fCh2We1cC
         TiMC9FkEHNhTnfrsuQQbDszOawoplZ0rsi1wdgxRc1DVuj1WU/5tR/qMQJqzaERt8EZE
         bLXndC/vrB1kQHXSYsxu432FePtC8hYCFBwl3zA3LGVhqENeTGlg802IG7pKmwFfQiyZ
         EStEEmxr9W2V4CkCVBFJVtjkrWyKbnG9Y6WB53vSjMTC6cBCyTU+6Dt0tLoyLts0gcev
         ZItA==
X-Gm-Message-State: AOJu0YyUSgQ7UuUX8uhV+pR2kq2uTTI3lJjT5LDGStxG6hPstVwExHuY
	zdAZrEQlyw/tCmxUOyOdPyFvkWIJeq5A3CItuv7+Txs/y8WFzrfpQ9jT8QOktN+N7dhSCcAg9w+
	vVhb61qZNQQ1E5+0+f0vHloAhg/YOvoWA/NSqUA==
X-Gm-Gg: ASbGncuLDvibCgCXhhHCTJSEnRJvJciKi2ouiNCaCgoBp7zMsE5wMIO57+8ygsGzmM/
	JmeKrlRYWeuPMlRI4r7pVU569A6KOEbLtnHXGJQ==
X-Google-Smtp-Source: AGHT+IEYXpdn8fhLD//ERvKhi9v6Gra5TD7+h5eUOjnBpp4kMpMLPDHNmKwnTBtu9gBF333DQqP6e4pfNsr/yGZ1IAo=
X-Received: by 2002:a17:90b:54cb:b0:2ee:8e75:4aeb with SMTP id
 98e67ed59e1d1-2f548ec9267mr49215825a91.17.1736977485235; Wed, 15 Jan 2025
 13:44:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115103606.357764746@linuxfoundation.org>
In-Reply-To: <20250115103606.357764746@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 16 Jan 2025 06:44:34 +0900
X-Gm-Features: AbW1kvbcxzww3783hiPRGUKquUIKhrVkJWtiveGXMEw6BJ3sW6loCB8MgyXi2MA
Message-ID: <CAKL4bV5XnEP2ZgqGeHCwX-c0X5C4rPZ7iS0EUNW-hVd2TCHxKw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/189] 6.12.10-rc1 review
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

On Wed, Jan 15, 2025 at 7:45=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.10 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 Jan 2025 10:34:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.12.10-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.12.10-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.1) #1 SMP PREEMPT_DYNAMIC Thu Jan 16 05:32:18 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

