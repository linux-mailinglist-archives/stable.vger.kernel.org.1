Return-Path: <stable+bounces-145691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CFFABE105
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 18:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C164C6AAE
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3839252293;
	Tue, 20 May 2025 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyGONqo8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493E921D3F3;
	Tue, 20 May 2025 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747759611; cv=none; b=dBko7FkwyWLGMRhbIB73nH0rzuY65YS4WnafoEsocmaacKK9rfLxNCqI6FdGoA2XPHT7LU/x+TAR5x2WwPPzpmwEy/u3RakO1WaHwNKQ8WlkXUAjU4Z8USd6Zy/NokUBPU8gOxLS+qPCSDtU2O3fHbPXKLQNevgmqa51pzYARwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747759611; c=relaxed/simple;
	bh=eFrPZPfo5Ncq3ZF7wLia71+eXKw/J+EQEeW+BQJouJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=icjoQzPv/pO/bTbKlZ/ptfNo762A0x6KHhOyPPZU14Q2wRf1/dB/yXU7IJ+LrQHeRfosg/HGCAOVnPCbmCbmnC0kjHNv9kXS9lghfJt5CScQSSGMSQ9LJs4DZDAgZPsddI6fxDfSJnnrsfcxzkPKr2TdywogrHCsiIDyRz5hoOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyGONqo8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-231d4679580so39349205ad.1;
        Tue, 20 May 2025 09:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747759609; x=1748364409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eFrPZPfo5Ncq3ZF7wLia71+eXKw/J+EQEeW+BQJouJA=;
        b=UyGONqo8UvDWuJSDrHy+Xk9QTdbqvEBEtYwLczdvoS4QUhdt+uS2jQOMr0p7lkaj2W
         n3GckB0+XXadNRCGmb6ORkfyuao2DmlksYRzORIU+oDhsunkG5TgLQCp1UCikv3Nhj8g
         E5SP/aGO1PnNP5Rn/iBFpgIa1X774WNjUirMyDJRZ5qNTwhirJt0om7r+Uh5ugG8PITc
         O3ZiLEXJzjaASkUBnNiql9y3uCNA1kZJqh4ugZOWq3326ot7IMNJK8AvtHgp2I2TcFMn
         vDS4e1thsCBK1P8na+Np0Hw718Ob3QFFJMg2mtz9qc4lQ6FdXW9FOTlV+hy5uWWhD0en
         /YHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747759609; x=1748364409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFrPZPfo5Ncq3ZF7wLia71+eXKw/J+EQEeW+BQJouJA=;
        b=xScLamKTJSLwSGc3Yl3RXS2/NGuS3V/DNJxTqmCgboTzLsdgpackDCzmjHUGYjnugr
         eP8u+FN2Xmpi3hBql0n1sAdRKMHtfSG0Go6a8xllmJGFsjwwVyDvdx32sWvSEpoYppEt
         k4YBoiNL1t2wkoZhGDx1kSNox2zZujfpGaxJs9/w6CTbW09wP6rmvMDfPP9M2Ww+TSWz
         iBQiGDJrGPcomDQmXcZJEGiBq0Kc0L1xZ8uFp3keYYR41CDlPo2px2xjI/S3Tj4i+suB
         ajlPDupljR1t7PcqPQBLpcf0/DVw60UtNqNqPgHVFiywYa966RTzv/zr1B9uTbC+nAQn
         qGBg==
X-Forwarded-Encrypted: i=1; AJvYcCVjhD3s2mkAdj4aXf7PU/nHDle+qQ2yt08STPedhOpBhAOiRe5CGByoQkGATbRMJBeyuC2Ygl5t@vger.kernel.org, AJvYcCXSlsG0Z36He1BUF9JA2kjLxS4N1p2+H6xhPgBwbORoJuXqf8KBV8MPl4cdBaN//DtAT3IIMAvwxW/WdGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyuxfCO75+p8ccziRmBBVmSeNQ/ZHBovvPcG/PYFcXsthlpoRE
	ntMAHUibI1Kq+dm7NRTFoNwcgia1968lDbfQq8lrwNbmT0SVuUK4W4iDN2MxzwOORGt5+tB6hiL
	pC2YI5FFsLNQru7zgm868CwXgSoMYPLA=
X-Gm-Gg: ASbGncuw5+ehvNir7U6G8oBXmxV6pVgjUYQmiu/4JxORwsajdFZUUmlnxbpXSehEvsS
	+nvNJ4KYV4U6VJlD+m/+CD/qyEb9++lQTb7TWiDMNtUg2q3e2E4XURWf1qMoQcyt4NnIflxseWn
	8+E/JJFt99RvYEecQT6wYGt03wsYxbJp+eTjtA3OjT4pOB3ss=
X-Google-Smtp-Source: AGHT+IHl44caj0Z3alYhYLDCxu1knUqfE+ABQXqzZ+BL3rwp5RUHZ+NtBnwoggIo/FPZxb0sRDX/YvncK0AEOJk/OTM=
X-Received: by 2002:a17:902:db08:b0:223:66bb:8993 with SMTP id
 d9443c01a7336-231d45c4e39mr274977695ad.43.1747759609403; Tue, 20 May 2025
 09:46:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520125810.535475500@linuxfoundation.org> <1750dadc-5993-483d-a238-2060484ac077@gmx.de>
In-Reply-To: <1750dadc-5993-483d-a238-2060484ac077@gmx.de>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Tue, 20 May 2025 18:46:36 +0200
X-Gm-Features: AX0GCFvp7A_0EISE7yWjC-MAbJIjbPj6CegJS-lvJVlnsPnYKSlegLj2FP9XJC0
Message-ID: <CADo9pHiGtsAUquS3bPobsT+8ONXUbvUjmREKwbb0AiXLiyKCag@mail.gmail.com>
Subject: Re: [PATCH 6.14 000/145] 6.14.8-rc1 review
To: Ronald Warsow <rwarsow@gmx.de>, Christian Heusel <christian@heusel.eu>, 
	Luna Jernberg <droidbittin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

Tested-by: Luna Jernberg <droidbittin@gmail.com>

AMD Ryzen 5 5600 6-Core Processor:
https://www.inet.se/produkt/5304697/amd-ryzen-5-5600-3-5-ghz-35mb on a
https://www.gigabyte.com/Motherboard/B550-AORUS-ELITE-V2-rev-12
https://www.inet.se/produkt/1903406/gigabyte-b550-aorus-elite-v2
motherboard :)

running Arch Linux with the testing repos enabled:
https://archlinux.org/ https://archboot.com/
https://wiki.archlinux.org/title/Arch_Testing_Team

and the amdgpu thing is fixed :)

Den tis 20 maj 2025 kl 16:57 skrev Ronald Warsow <rwarsow@gmx.de>:
>
> Hi Greg
>
> no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)
>
> Thanks
>
> Tested-by: Ronald Warsow <rwarsow@gmx.de>
>
>

