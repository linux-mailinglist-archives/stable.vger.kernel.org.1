Return-Path: <stable+bounces-7835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7FF817C61
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 22:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD628B23C18
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 21:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B7874080;
	Mon, 18 Dec 2023 21:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="rHDetb2A"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837E47348A
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cd82917ecfso1790204a12.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 13:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1702933588; x=1703538388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36mhB37dzwFYxTc31wi9sEgexn00u1r64ISHaWciqdQ=;
        b=rHDetb2As5dvxj/ZC0sfTVAeo7dFK8KOERk7H4/wNR25i8oaRgyiIzynyMSCNp7hju
         P5pzrNQCmHo4jfFPElySXR0R6AVWCl7gZLzJnTKM+o7+7ldjSQqyBX0PBMfVe80q01fA
         F2RJqw6Fz2SY+xN4G+81VpTpqNLnoA7BPRpZ1kzedda9dQoO3NQ9EEe3emTnWNGzpl58
         X/E3YWaSDQ2pIsPB/r+Omej8rmCGY9bqO1tUhrS1q0TIx5ABSR8dRwcmX6XS0DDVVRCp
         uU/1OHJNjwx/xfDFMAy52SGPSOOGB+YTsiT1QZEolec7e+/1r551Qeg6lyV7UiSkp6ng
         lV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702933588; x=1703538388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36mhB37dzwFYxTc31wi9sEgexn00u1r64ISHaWciqdQ=;
        b=oBCtqvr1PRvqLGkSqc00n55BC4ICdPqnJyvdWb9YyhZ5B/DB7jXcYviBwEqbkyVqfr
         TIMFmDMfhfDf9+rJW4OUCi4RKfz9NEyc9AsDhRfpz3tQvk09RzqX+hMzeuZhE8lZneyM
         YeRH0980KLGsvz2Oo8sbV14DPtJpmzzu/H6glteeZnxqrQECrQSqNZ6qLrGPFBIpDYkM
         fCWCQiKo7cTb9vsN5EZRPJBixGyONo9qZaGa81GG2pmZn5dPN76Js9wZzSt9gFyPjfI+
         fMsm9wohuV7qEphFAiRfK88fpfMZBAdCEZUbG1HOZ9SOfPmEe7yyS4u87XBw35AFH11O
         xRkg==
X-Gm-Message-State: AOJu0YxqTzDuZNH0Tq4uaVxKOr0bpUY3Xz95O+b7qBCt1g/tgRRHLQg9
	YpTsitwbYp81r9gRmEp1kvRLW9vhthnEiKugiVfT3Q==
X-Google-Smtp-Source: AGHT+IFFWWsdRy/k0ymydJWK4zCUV+/JpG5DWtGZvqI5npFftIQI+RFLb8pwXUDFXBX91JKoBQDgehNmTjwj65jWClo=
X-Received: by 2002:a17:90a:e50:b0:286:964d:c with SMTP id p16-20020a17090a0e5000b00286964d000cmr11000939pja.86.1702933587789;
 Mon, 18 Dec 2023 13:06:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218135104.927894164@linuxfoundation.org>
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 19 Dec 2023 06:06:16 +0900
Message-ID: <CAKL4bV5_vptGgsAC4NAYUhr-cknLTwiyR2z8JsvUwoDvmxKy2g@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/166] 6.6.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Mon, Dec 18, 2023 at 11:03=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.8 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.8-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.8-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Tue Dec 19 05:38:30 JST 2023

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

