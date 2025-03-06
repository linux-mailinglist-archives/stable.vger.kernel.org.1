Return-Path: <stable+bounces-121230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 474B8A54B3E
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 13:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5BB1710DA
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 12:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CD32066E1;
	Thu,  6 Mar 2025 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="jQi8hZqX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A774F5E0
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741265716; cv=none; b=PHzbiAudLK5bIxTaJYL4TqJWZcgoX691CzGBPdmLc/sOim+DvnDj8vYcy/bykKQzVn3O+8mYIOgbYWmaeUGrQSF+n8ioFivFylt3OEpRFOpDmUH3a1qffSPHtKQd7RW/lzq624fojdzXQPJBZrfLWUQy63h1lBymos3cSRHqUbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741265716; c=relaxed/simple;
	bh=CL8xqMbDSfXJhqryd6RGNfCVZzu0ssYGv1JLaVXfKDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFSG1KuCWOqtyPZ1pM84a/20X4eGzPT79AwzyINZi4/X/weV6X0VjmVt2lj2Rmz94m+1PPKFFw4pgE1owgVHjl4WsBz2xJnblBC7WsGIcOmjcfeU8PrgGODseTxkx+srjzGC7mL6XN+UHoz5dMAzHgwPcXK7K/W2Iay/1W38lXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=jQi8hZqX; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2feb91a25bdso972181a91.1
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 04:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1741265714; x=1741870514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ccc/H2dnyXMFfYeHkIhobLxEoO1aevmdpjSTBRDha2k=;
        b=jQi8hZqX+1fmPbgQm5Cxx8eDfA9IEDvxuZXTmdqS1PclWw+rp5Zs12L3KhE5Gj5wjk
         Eb1L+yGE+J5z4vHP3ISDoFMaAXGmChxxGUm3r13QhHsVmAcygKlQdow8Y1A93z1lZCHY
         0My/e0PGIxH2idRBNMhWC28qVLg/sB/xmeeuMDDCl3PjZ6EVK5KNEvssHuZy3M2cT2GB
         FomNtajXkrpT6CKtjDP5EJAkL53MClvHlyfJQ37lNXhOR9c6ZWXFsldaYXzuBJ79RRc0
         Fp56QFfG+4Gw+dYxg+AUFUwlgjNqZLuZjSsKeZqO/nimAxxxctoT5HzSdwtSGyps28SG
         qVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741265714; x=1741870514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ccc/H2dnyXMFfYeHkIhobLxEoO1aevmdpjSTBRDha2k=;
        b=nwRqXaxZ4h7ex3KCNiBHdcMa2V+6smAXXNTXR5MRf3+Kg5KhHs6L8wSfSItfb2hB2z
         APuypkudDzL/JP4IrrC/65peRUYx4NsG0Qsb0PBjipoNbucIfPfn/Sg2fU6F4i8DqbUH
         DS8Xv6y9Gk9JsBkSBBh6Tt8y5PlP3Vc9tKUMNMTWYfzXmnAX3xxWnCputKaPX7+0p2PM
         GNPhLIadzE62j1d5QgHCz7Ce0Tci1wHIoM85sUx3hJqDCOeh0uAIu69UEIqDykVZcLuO
         /QcHXu1dmCWWjxWZ+/0oZA+gEugE5PPi/3NVsqMYrP1ermELbN0g6AK6HlPvCn/b0dmr
         rO5Q==
X-Gm-Message-State: AOJu0YzNO67KC3PA6Ga/Lsco9EBzpSDQNsrFMsGw+VzcvcxQt89AFwgj
	JHM9BUxu+MXVGbr+dGlFNBPvDxU45pVvhGrqGHRsxEAVQFdxemZO9EyC13QtcFTTW45NuT9cmtE
	VCPTTjpz32iT/dLEhaX2z0Siom5aLy/KhftXiPw==
X-Gm-Gg: ASbGncuO5vX4TG8cClViWV6HfJJmRGvagwHK6RaBml1xohwfhMA4yGwYJIPxc7DiWMy
	Lc+rjuSw9GhR6aIPWpyAxGi2cv3YlUJDQgn7S6ZxUPR/V5f1IWjTy1DPSnQSJAnmWLE1TplJ+Qr
	oTMUhmn/mdHIKkMd8rqXCDls0z
X-Google-Smtp-Source: AGHT+IF7OiPlaCSQEnsXNBjhCDFUemUvQa+NRtTs/JSJ9+1Qyh4+kePAcg2WzwOWcgqtz8B61BAqo3R1eMqK+BSPwLY=
X-Received: by 2002:a17:90a:8c18:b0:2ff:5e4e:861 with SMTP id
 98e67ed59e1d1-2ff5e4e0a25mr6281780a91.24.1741265713650; Thu, 06 Mar 2025
 04:55:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305174505.268725418@linuxfoundation.org>
In-Reply-To: <20250305174505.268725418@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 6 Mar 2025 21:54:56 +0900
X-Gm-Features: AQ5f1Jpv_EZBxAwkR3XhpjU0MlJG0w8trjkFHUomYWnS5F4PAVsYZYvVmcl5D4U
Message-ID: <CAKL4bV4TstXsNOuvqKb7shhdykg73r+zAP3MLQsf0nvGYYT0Rg@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/157] 6.13.6-rc1 review
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

On Thu, Mar 6, 2025 at 3:14=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.6 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 07 Mar 2025 17:44:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.13.6-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.13.6-rc1rv-g30be4aa8b957
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU
Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Thu Mar  6 20:52:49 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

