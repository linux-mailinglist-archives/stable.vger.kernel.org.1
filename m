Return-Path: <stable+bounces-116334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D952A34FFC
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 21:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370053A4663
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 20:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC8C2661A7;
	Thu, 13 Feb 2025 20:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="oUO/2Q3P"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD44C245B0D
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 20:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739479978; cv=none; b=D1Ts3b4/Mc0Oa0YEtiFIYq1U07RJPx2OWIfcouMK5WAFc6xQ8YSRVgqDzEaftL8HpJT7SOoPDPUBcyXvBGx2HANs6pWuM/bdXb3/vENRtaAczkWLMbxExruSzfSldCorPHfqt4qJp0OGheBnGQfEhhQP/FVEmbIfp5HQ+7JrcV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739479978; c=relaxed/simple;
	bh=YQfOmSG7bhXwrXEI7g7HfGozQsPSZTjYO8leaGIMmsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tsBQId+pj7JciBBLtq+ELJOqNP7pREnVEwRVDJOmlZsKFp6eKbZSIki20ThKjygTQ8clQiFenjiin+8SzR4TKE9Vt8q41SCpd6JStqIRI2qaRNseWARQw12y5xoL2ddxfYInqIz5lG4We9Xrluq9C7LdaDkL/zB3WXtqZoRqWXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=oUO/2Q3P; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c665ef4cso18956255ad.3
        for <stable@vger.kernel.org>; Thu, 13 Feb 2025 12:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1739479976; x=1740084776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kD4jlIA09LlCQfIugtat8U7n/Mwu0d3vsRXd4yayRgQ=;
        b=oUO/2Q3PXsidHZjNIZDeRNCHZj9da8ZMHp0JlrZxMXWcpGliGuw5DkkzVzGPI4Pa7w
         8lxiZ6jGtHaSaPN+Uj694Q/odEkqOBynbhyONGBawHj8MdPtTI9LEVY/PgtlbGRv7SP/
         3Ud4vgE8b5aQZc0CSsAJwEgrrf2hFH264HbxU6G4gHXkk5Bi9yHzF0JBBw8mU8UTwByy
         skztsCQ7MTEPhT2Fsn1YsqwGf0VN77NKRalF7wGaCC+LmFjRw1LH3v5WSHLWVtqio1Pl
         CpxQ7VYElIbgyee3VlM/m4qmsRbwdAAQvHni6ykzTch+6hh0TBA4lkT1Ot+P3SAVcLny
         h4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739479976; x=1740084776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kD4jlIA09LlCQfIugtat8U7n/Mwu0d3vsRXd4yayRgQ=;
        b=pMV/yZc862smU1PfpnJpcOcgZtsZSvYuld5H5cKegE2/ocACrUveigIfDwS1uKlkTA
         inRogddxkYdhVeV0gmQlyjwIDzjX+erMBwhBYlhiwhNGxn9Jno+OpfKzcOXBLrUUGauk
         5K7SHd0L1s2IvXKc+rLehel1oOEq4b9BLHeO2PqWK+ALi8i3iCwKoLN3H12Wk0zb6og3
         SOhHscUfNXGvZdMpl6vuXduYghxxP2nvrT0kEW4EJTLePTo1qij8P0sHqxj0jXAtLfWP
         nX08PBBQ0CcCvYZDuv3git202KN+Uy2Ohpvn6Bq53l77GOFX/HKkPoGT6C1Ch99Zrf1O
         pTyg==
X-Gm-Message-State: AOJu0YzvSIV24nT4w2ljSD/2MLF2Py+pIm6Nm630VHhlyB4q96SbUFHy
	wKrOvk9MI8BJ3H6ptbZCoGUGeNdp/AjtlmE0KFwVmiluFLH0CxTfTz14FTAhBPi2KziRl/TzVA1
	dbOXajxI1Yr5Jw1wkEZe2HwoTx8oVPYldDU9ylA==
X-Gm-Gg: ASbGncsWhCdr/ky++CPuQAWCuK92usYYaLFL2cb/uZvL0FRSgRc7qCpu3HMwJbN3w3c
	nzj9z3c5+sOFPj5icBbTT9a19U/tiM5g3vxr8JfOS6XMGgJ89lvbIoMrDjEjDk+O1dURF/0I=
X-Google-Smtp-Source: AGHT+IHjzHdPOUuygC6NBlatxleab1j3jR6rTUbN05uLgsUD63sYvsqWUeg/8xCBEvwpGmkWUxZGnEHEHJM5LlFEhYs=
X-Received: by 2002:a17:902:d483:b0:220:e9ac:e746 with SMTP id
 d9443c01a7336-220e9ace872mr19612115ad.53.1739479975905; Thu, 13 Feb 2025
 12:52:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213142440.609878115@linuxfoundation.org>
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 14 Feb 2025 05:52:44 +0900
X-Gm-Features: AWEUYZnADGWAsmbaFXOyq0Ts9-qFL2MZJjpcjwmTCjML1qk57OFJC9AtigNj_Sg
Message-ID: <CAKL4bV58AGyft6AA5j5CV=Fvm+uX_czSmSu8a=sgdQqYygBjbw@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/443] 6.13.3-rc1 review
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

On Fri, Feb 14, 2025 at 12:07=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.3 release.
> There are 443 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Feb 2025 14:23:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.13.3-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.13.3-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU
Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Fri Feb 14 05:08:38 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

