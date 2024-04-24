Return-Path: <stable+bounces-41354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5E78B0821
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 13:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB47286A3C
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 11:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF3015991B;
	Wed, 24 Apr 2024 11:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="MsaehRY/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A141598E7
	for <stable@vger.kernel.org>; Wed, 24 Apr 2024 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713957180; cv=none; b=caDAu9Chek/zEQcf/J5UhONSBkmBgs+ZezMqW7f3rFhs7OxBsqDBo5u9iXtbLWsnDRKAcbJV1Jlu2Gt5cZnrj4lq6Jgc7holeN5aPDFLRAKVDzXmKpzpb2xIc1YoRhFeF6YstSe8J9NztZX9AVK1y3fJbzY0gt7g54oVX7ngwrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713957180; c=relaxed/simple;
	bh=wmj+hvwsoGodyJmaSnIB2YJCBKYfRJbs/41MVJPknx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=niyCANza1XYlyDiR6MGx9CeKY76RMjy5vceC8Tc8pus7BDZW/dtjRF7CMRqnZfNjUtlDNIRViW5M72COUWilykioUdMvp8aWnA+IlXUTgzNtgnBHBu07ZaGSOAU19zPrVZ6OwTmfY+FmgjnnRRtHbxKrDv2fQbD1BPXDp3/gxXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=MsaehRY/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f043f9e6d7so7043602b3a.3
        for <stable@vger.kernel.org>; Wed, 24 Apr 2024 04:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1713957178; x=1714561978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jvc+crjB2MZ5Tq2wExAFBrGTQzTAygNqkxLF7Cs1xYc=;
        b=MsaehRY/Bs4ShWvL4MrCaGi+QlcjgrVPtRtK86p4qLFDk1yGT+7lHSyfOiRL9qpCvq
         S9KjEKW2iLM2A0aWmwTbrlaFrLyI031v+vCc5t5YkipUDdNp7963zN77QAyYTzfWMQC9
         f82p4T4Bjl8tM1FoxIOxLPaqLKICVGsmbFwKRgdrnm/YybSJ5MVrQ0fyPnVsK9ETw6ZX
         AfGvfnbsVrA8/ak0Bgv8TOrXJm7z4Nd7YuqsR71QCSL9zT9+bn8wtVic4Ngpnr0683XO
         iYDDgkIxf/GLeZECucIIUdU3XpQXKJ1STUncOdq3WTOyzYHtUsIIPJDpdWm6H8XhuoeN
         14RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713957178; x=1714561978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jvc+crjB2MZ5Tq2wExAFBrGTQzTAygNqkxLF7Cs1xYc=;
        b=r1ZY8R82psbuP8J6PLFC7xXZQNfIXvf6HRYUsw8/veV85dkJvfDjr0e+ab2M0Z+JxB
         y794Bi8BAQGLnRR3UN4Qe42u1CmUAI8l5Gp7gXO1swkksym9vym6c9FA/jeij6p8oR72
         tewDYwEro/V/EzeR/ck12O3iTlDqB2SujWDS2sr5gEhVcfXDLsCzD4NEgsxCRsNi7Smn
         0z4++G3cuU4DQwlkWPRsJPMl9/QYZG+oQ1E0uNKnEeXRRqnL3DxKpwWrwf2edQhQgelJ
         u2+lsN4LrkUwN/NxwTzISs3wJ2yfTUviwxP1IWO2Mex4ihaN38MeZ7hOpT8n76uNgH4X
         7lLQ==
X-Gm-Message-State: AOJu0Yzkun7xqNgUjShinQg7ZcF57dN3vQWCtBWaCsp1HoUcrEZhcBUo
	N3jVezraJV8Rju3Fb2IAxStCT2vr9bY6tnqSRHUDNuw2B8TrqGf2YSGcu1GdAFJ/Rf6vzjdZddZ
	5ZG4MdE+iRcXn588+uVkSqZAMbkHACTSdgw8Cuw==
X-Google-Smtp-Source: AGHT+IFcZaHSY2rAs7RgXGpaZVJigXC9oX79iU65HlIGhBiIOwEOvRFy714w1FqNIYaJfLgwqpFMCv02vu2I4l7RZoo=
X-Received: by 2002:a05:6a21:788c:b0:1a7:39a8:6ca4 with SMTP id
 bf12-20020a056a21788c00b001a739a86ca4mr2434665pzc.29.1713957177991; Wed, 24
 Apr 2024 04:12:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423213855.696477232@linuxfoundation.org>
In-Reply-To: <20240423213855.696477232@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 24 Apr 2024 20:12:47 +0900
Message-ID: <CAKL4bV6MWQQunGgCZRBzvO9RP=516Au2s-VD=16MfFvDgTGWZw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/158] 6.6.29-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Wed, Apr 24, 2024 at 6:44=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.29 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.29-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.29-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.29-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Wed Apr 24 18:35:14 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

