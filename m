Return-Path: <stable+bounces-66099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE85F94C728
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 01:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986562859B4
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 23:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD0615D5C3;
	Thu,  8 Aug 2024 23:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="malC2YKY"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7FD156257;
	Thu,  8 Aug 2024 23:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723158194; cv=none; b=c/6A4ATo/mPpUOdX/L7/gs1iz9L4MQyiH50RPdlQ5WxEaBNWFNAmVV0FC+PYVMcSykuUt4TW7k2FHkuH59gqklXqf8XafgXuo3pLLeBQ1R8YY2lGul/bHmt2A8z7opUU19Sd+SPtn13mEDoHGbF8AywEb/LkfaIJ/CFUrQ2FVxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723158194; c=relaxed/simple;
	bh=RWOEBneEsGpeeX/BLuOcLXfO3oRs/VUy5GTvzYRNu+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLsGJeJJsultf2Hkiivkj9Xmd+sMpX9XU9pgoKY5DXHF2uPqULa2kJPxo0x85kNOb+neMRxO0OaiK3mOSJ4fxeBMhF8zV2JRRv9WoQUIIClI3TmHp880ZJOnKH1gIMYGLj0mcD3VvqkNHH5SEzRreOVSHw2qcY65sXHtQlZPw7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=malC2YKY; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db14930a1aso1068879b6e.3;
        Thu, 08 Aug 2024 16:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723158192; x=1723762992; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yAGQCbZhGGSfb2shOtWzL6tNjqUA+2izhtp7nnZqtgM=;
        b=malC2YKYWi9TY8xI6/L455lGUUbLx6r/oL4l9/Pws9G4EWCO1oiXZ/PibRFHIlKNnG
         NDeSeQlfztCeBND+bNONXanfrfcHE0aYJfLnOaakE0omTQxkVi2k1xhyx4z0aBjagsEa
         +feHtkz4xy4scIVKE0vjc4+Lz2mJ/9aE9vTVavYG4sCEHCnvcHguaeQdj7RbOyC07kB3
         +naADR/KH+l5xnSOEaq5WT5tmxmAsLnQpXIxzCy1mwvM7kbmOgmLSxwPqLZ678+x2zQw
         26F7RMBixHzPisL/wLbeUSyXu6PSUn6MtHlfiKKhJiqcmuRssCTfqg2g7umed1z7SOwh
         NzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723158192; x=1723762992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yAGQCbZhGGSfb2shOtWzL6tNjqUA+2izhtp7nnZqtgM=;
        b=rmJXjMB4202d34Qppdu6TqIB/Sn6ah71kMxZfFHv0Flq0/G+6Z8oDIeMDOGgDYocH8
         U6242aNWps855RES8VG633gMI+72G1fj1cbsF51DnGatm0EjAvYejgpBvSG7nYiAlZOj
         oqF1zOC/mloPNfvOWHxPcpyZt/yQSYraGvl/SH2vHgEm0MsMTcPifX4DEF67ysWeMiU/
         8PT0VKWNPNbrz2cxrqaolOnypQbjvRIH/8WRt9DeYx81E5EM5wPe41EIip7bsDmROQHa
         2SqFJRMsRyNDQfOITt4O97fULFC3NoaX6iMV1za9ChKmQDETr+NgeoOcZzfVhO29wHSn
         uWGA==
X-Forwarded-Encrypted: i=1; AJvYcCWwtAeJ/DUAjmYeK/ZP1iIEW13ypfWKuQiA3Urdvcc2Ahrpo1MVwvtqlJZIR5U8R1YOnbTqEEOxESn3mig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIXAuNPyUbPPyGoSup8DFtUIHG2jW+BWMc9+YQddtWdVo+rWXp
	OJWuv11jFEOhZ5wGDNRjvpbntRIBw7CCHV3rwsrChIVUlA2ALo0xtFj8uXBO7NW+WPBfGv8FlRI
	BvavhvR/n1G6+v7quZDH0hO8QP/Y=
X-Google-Smtp-Source: AGHT+IGPKcJ9znziyGOcJ+0eRd0csLuu+W1Dx9VkXMQnAqfpJGArWUcFzXeFPh4GROY/NuffsNGlfVvX2rUvxe+qzAU=
X-Received: by 2002:a05:6808:2016:b0:3d9:dabc:7b8d with SMTP id
 5614622812f47-3dc3b46213fmr3298346b6e.48.1723158192188; Thu, 08 Aug 2024
 16:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807150020.790615758@linuxfoundation.org>
In-Reply-To: <20240807150020.790615758@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 8 Aug 2024 16:03:01 -0700
Message-ID: <CAOMdWS+upkbMbE82CmtKFgRb9shEcq2izJEBHsKW-AusiYxOpw@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/123] 6.10.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.10.4 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 09 Aug 2024 14:59:54 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

