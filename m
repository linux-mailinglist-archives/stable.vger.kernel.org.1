Return-Path: <stable+bounces-161392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C52B3AFE09B
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 08:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B27533A61C9
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 06:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFAC26B96A;
	Wed,  9 Jul 2025 06:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="DfpC7Vf9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B05F1B4153
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752044115; cv=none; b=e3zQAf1LvcOEuBaoIL9hbEKoTjnMOHyO4AFMnJNuK/HiZFTl9b/xBbxTLIJWBfNvEEbnfhqi0p/8CajrQqZZxYNadchiytgUqdlFjsZfQia0HlzqSKz1NmvrT9iFMh6i+8dWcfp3JQ09rnrpEvfu+K6dF4v4gt4H9VwODWBuurw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752044115; c=relaxed/simple;
	bh=Llz36kufN52xm0i4d8RFpEM5cFRnEKZ/vBmybKKThBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Un5foFa68YAVkKPIiJo7LPv7fckiy+ssCzUx+sgnlyn77WcnXd0fUe/C3nYGKvckv7E1QK5OoSC5AKuNkwVPK4bBCwSSxQ6Sc/ebY6Aw5wd3aywZEZ4hBXjgGSSLSIPMvipaOe6F3z+66CcrJo8t1hPakm4BuiY+eFHjhKZsHII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=DfpC7Vf9; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b3182c6d03bso6112096a12.0
        for <stable@vger.kernel.org>; Tue, 08 Jul 2025 23:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1752044113; x=1752648913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxSHhqCIu08V3Qwag9o38Kp5WRa0opkmxc/P0igOUiI=;
        b=DfpC7Vf9jJptE0mcyvdR89c40XpAb25s4OioClGlgdthuWEy+i5NJjX4hI1KhUcUox
         NrOjO02EzWuATNFdxUSK0Am73fKkXxmzzMG9F7kzrMPm6c47FDyvWc+BfpVkpQ3/OUdR
         GC6YbgXnBL/LzF6ruu8aSoRSOBLUZ4hK+Kj9ojOGA65Ewm2GDwb8xmBN7DjEiIUthoa/
         INwzmpQwSHXUoZmoyAsCBMZAdhaP6OajoBiuhLC3ywZe/Ri/cTcE+RQQEqFepmLs9OcY
         +z3Z1ZxwqYCypv78SwZFo/srMLrrTKtg6dR31v7+qdQHuG+8SUuCKX7HFicVX/RvQv87
         KifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752044113; x=1752648913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxSHhqCIu08V3Qwag9o38Kp5WRa0opkmxc/P0igOUiI=;
        b=d6K1Eeth7S3OPfTPc8GINMPDlOJkM9QOTkcw6uruCzDubQ4+f91BHJTaAUHP8NPSkS
         y6hi7a/Cjis0lw8ZrsAxB5hypiLwwtT9aQgtHLkxY9S0x7xXBUbX2kZr9Zy8B1bId5w/
         ertFx+N78eLKNPfxoHEaO8i7dglqBwstRl9kNfNwFbtcZOz029sTpfE76OpJq7OZBqAO
         NcsqSEr1c26KykN0XjFxLXj1F15XXbJG5Ne6qaXyliqYerZi+u6lufKVEN3YAwZMpLFA
         ZIMhUfgq2h0oEKx93maU7C1DA3Yyh5eXLD65SlbFMKTKnm53eDsQmUR3z1xIe82nUEu4
         0vBQ==
X-Gm-Message-State: AOJu0YymXXb5Am0rEziURzV5ta+fKQRBPL4zpCVZ5O1OSVaFlo4HRbd6
	nE6kvhqvErhk2udA6Wm9JXLNjV6GED5an+vXRVNg9tzxntrFfyCfVSuUPU5B8mwR2W3HyczxSpi
	wb5dOzslUV7N8T4oUKtwWxUA6aHWLYIXO1NgC9Xw2mw==
X-Gm-Gg: ASbGncuLSFbnEyU37PX0Ys8BfQmGBjIUTwe/juDtuoRJ4IDBxZdROROptsYRWRfJ3FT
	nWau8hvoSxhEaJxwQ9WGGTwX1JfmYHVDtJrO8PMiYqJe7vs6YTiFLPnq54sBViBRO0s8MRA+OYr
	Yx6le1pBF2E/H3HhygmoPXd/ZFKNfK4lJJhJNjIrQDKi4=
X-Google-Smtp-Source: AGHT+IF5H0//doa2nKgKyMBFHav2Tca1UhHeZa/y5+70t9CTKpzojdZBrhFAhrvWQGEyl4cbrKijcS3La+7jkZmxDZ4=
X-Received: by 2002:a17:90b:510a:b0:313:f883:5d36 with SMTP id
 98e67ed59e1d1-31c2fcc389amr2109500a91.1.1752044112748; Tue, 08 Jul 2025
 23:55:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708162236.549307806@linuxfoundation.org>
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 9 Jul 2025 15:54:55 +0900
X-Gm-Features: Ac12FXzuUaKQ0Ks2xEiZvI9ZcmwyTtrC1KBrVsD1P6JK2q27gyC7Ngbilk0Vh6g
Message-ID: <CAKL4bV5Q1eGnsOXbf2bL4kjcU8ZGn5W+bMPKsYzBNqp9OxY2xQ@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/178] 6.15.6-rc1 review
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

On Wed, Jul 9, 2025 at 1:23=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.6 release.
> There are 178 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Jul 2025 16:22:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.15.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.15.6-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.15.6-rc1rv-gb283c37b8f14
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.1.1 20250425, GNU ld (GNU
Binutils) 2.44.0) #1 SMP PREEMPT_DYNAMIC Wed Jul  9 14:44:32 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

