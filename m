Return-Path: <stable+bounces-163038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ECAB06889
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 23:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E686F4E069D
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 21:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5412C08AD;
	Tue, 15 Jul 2025 21:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="cBO8R3Uw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9F02C08AB
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752614849; cv=none; b=tyyy59TJbzn5+67GOIS/+pIq67Xm3DT3SVdVPWaYbnHGaXjEnTApSWiCKSG71lYNZiZMoAhJEKdibaAyddAZz9BYDRV52N1x+XsRuzGaKENsdJkZzu9NiAk6x3/DizbEBvdZqoxKD1sDmaKo4GFxsDLBXNORTMdTD6opMxbUXCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752614849; c=relaxed/simple;
	bh=D9HEnKpqxTaHq5dlDfw7mwWkvcUfEgMavo2bCfMr8us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRoatp6Ff0eFPyG43TRp4dFKffN9Ib0afwUeMC8jzOM1Vrxr1YvtAg2WRxMIR2KeWT9PfS9DsRDCdz0ABFJlaStScE2dXrcFYSqRgOOs7H1XvdIpAiyoMu9s4zkBnN1B0DSUfYgvWv0bHDLEeTU2oOsyU5XoqyN5Clcff2qWc5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=cBO8R3Uw; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b170c99aa49so4462844a12.1
        for <stable@vger.kernel.org>; Tue, 15 Jul 2025 14:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1752614847; x=1753219647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOELzqJhc/ryZF/a1QLEL+CHjG5U4uGeHFM65aS5DO4=;
        b=cBO8R3Uw5COKIqDiWuGdutCVaP+AazI9h5iMBKlMYQnEokN4IFYhVNZ+nVHWoqN6q0
         x+JK8FRF+YtJNV41RGo+GOl9xHQmb7vRScJTfEhM/sA9gkAihDqBQVR9FINz0cPiIDu5
         bT0o9+u5vJo6jD4If3STi61q7HkfYTcLN3aVHZ/GVDifkD0b7hcI7FYOpAPKpVs5Rb1K
         SuQqK6bkrYce7NsF4ltc5BvbPy8LuAh8yWZLNswJbbcWX9U87fhAACZSUWvQgyqrBmQh
         viUovU/9l9TngI2XdUGakudUJNSHeNO9yskbM+0QkdRYWzgxC0CfOEllecmGIgMqUE+u
         hGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752614847; x=1753219647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOELzqJhc/ryZF/a1QLEL+CHjG5U4uGeHFM65aS5DO4=;
        b=AdpuO8Gf3xH79t2BlDHZUgKeAvR30LMp/nBu6qSk1mL4ngi9nU3sB8NVImyrZBWrdu
         5ghBNkOAaIK150PL+bxlpuO/W2q6jS6zTNNvr77gz9nzg88ICnwZmKX+VwYUsuv/vKih
         vMxq9v59BMUaNlXqnDj+msVTZ8trjtCxnphFA57lCUYKkz/ENsySuNK846SwHYlZ+HWg
         aJJ2gkn1BFGWgJr93xHJ3VO0lGLgvmRWbpRuM7Ya2TVE/4WJMdtoEc3JjpDttRsohh5m
         rJoaejq0wHMFHDDUUa6V/1U08jfhhF6QtqJdKIl046wJN/ndT4XM5njmKqv+RumDFhlF
         KC/A==
X-Gm-Message-State: AOJu0Yxg4h2eG33WGWRkItUKkEGngDmn8jlZ+VXp4AHDeeebuwwcT4rz
	QAd+E+zOAENvUAczBl88i2yeWbUEMC9bXYjBsvyyhEal1E4QygiJcHiZ/g8hr9/UL1CJ+iqGVTB
	0SkSCn+UmOE+vJsT6uO9rk9vIbjz5+3SZxLWEEVhF0w==
X-Gm-Gg: ASbGncvMTIKG5jt02kQPZwvL8ssvwRrfnUR0piExVSyvo8MBVhuUTdQ/u1/O4P0FP1I
	16Z6sfGArI3d+dJXlFKE/Aht/nJNUGdJ9cW8Nx9p8CiRoNAv8qbrrgZ1Tk9ivtifdrlLxnJhibP
	u21ReIYPzgRpefV1aqmxgM8VBGkxPSoeo01tvPKKBN1j+Dkz0/1Ptx3cdC/3wXOhQq0Ly8rSJno
	aUmiS1c2d7mYVYWOg==
X-Google-Smtp-Source: AGHT+IHIMG5AOIEO7NWtr7b7qQXOwUwyu++a7MBGcUjFW29Fo09J23bRD+O0k/Yj4fz9s6Q9Ys+GEoOzZBuXDt2FQCs=
X-Received: by 2002:a17:90b:4fcc:b0:312:e1ec:de44 with SMTP id
 98e67ed59e1d1-31c9e77050fmr1014801a91.27.1752614846758; Tue, 15 Jul 2025
 14:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715130814.854109770@linuxfoundation.org>
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 16 Jul 2025 06:27:08 +0900
X-Gm-Features: Ac12FXw_zO_5hI65OrUKo80Jj8hMmAumQxAUZ4aSIH3foYyd6ktRTVpXkyDcl4k
Message-ID: <CAKL4bV5npxPDCt6dsmJLSjVxTTnDn7GyJ05AgPF3Qh2M3NDY_A@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/192] 6.15.7-rc1 review
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

On Tue, Jul 15, 2025 at 10:50=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.7 release.
> There are 192 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Jul 2025 13:07:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.15.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.15.7-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.15.7-rc1rv-ge6001d5f7944
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.1.1 20250425, GNU ld (GNU
Binutils) 2.44.0) #1 SMP PREEMPT_DYNAMIC Wed Jul 16 05:56:57 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

