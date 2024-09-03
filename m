Return-Path: <stable+bounces-72821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF3B969C33
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 13:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA861F24975
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 11:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E5B1AD254;
	Tue,  3 Sep 2024 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="1W2fpLkc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF231A42D1
	for <stable@vger.kernel.org>; Tue,  3 Sep 2024 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363717; cv=none; b=est2f1I231oNEMCGM7O+2R/Na4OTYFnZQVMefVOcmn17RCoyttQFswzxo6YVW2ouiRCNqjt4WNOkItka2HVcE7kwYTtx5Z3KnKO4jNa7pcEeQ5rdaaL238Ozie/9XpkEHldDTt9/d6oJCt0Lr77paz4xQ+UxwZoVK1++nmGpz2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363717; c=relaxed/simple;
	bh=27rmC43+DKIhGwj8M1M31H9C6n8kaXdoV4uvdxhuEgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uf428Xg1xmzhP5NR4OJi4K3ex4xg2dJyhZPWPjSzZQwmra4DaYsu7un+77fSAPJsLyRd9BADgOjhYjGMDeX1A8TdI0pMR/HqYCfGg9RM0M3pXesgh8tdk6/KI8yR0S05BoqJwT42RgURXBto3oizbaaDHkIIHF43PNnOW+V5aHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=1W2fpLkc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42bbd16fca8so33578225e9.0
        for <stable@vger.kernel.org>; Tue, 03 Sep 2024 04:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1725363713; x=1725968513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCRTP/YrsWgFoEXAwptIQeI3efMclrmBYYYgqSK6yfg=;
        b=1W2fpLkcq5VaTLaNuWnQ0+HRRsKIy1oaq6ehhud1YZHmPS1Uk7lo9Iz1FetgJUM2T6
         rdGMblqGRWjERSrleVvo27a9bMwPP9K9W24GPiyPHyH1O+0QM1L+nk9NGm2ee0DX+oGG
         uh8bbkiQYwwTfO2uIEjErRjX4bNdQ3kfx2X1br+m2yTa/dFK2IjakSGq6CIJgKL3re+U
         YFP7Xm8Yc/CJubboLM+Ep0vE+T76J+naBddfdPsGsNBCREy+2bSE02XELzysUISgn1Rd
         jJH2L9mqvp9okYAy+BWbQc+IfU3rV8cMv5cduNrJZzDFcAg1HAFOnjr8SrCdaYV9IwM4
         WPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725363713; x=1725968513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCRTP/YrsWgFoEXAwptIQeI3efMclrmBYYYgqSK6yfg=;
        b=sGSLfEBxyIB0e1hXcH2xoSlwnu+GKq6P8DWbxIwcUbRocEOs9mO/PCa6PdWTxmPGpQ
         LSklDAbA/kK7RBE0pmNKtW9fwWxxg6VyQUTjL/CiBwJAL4u0Rq6eU6mMgSG0szpVSd+M
         ka5J0i/CPZpUIRW76YgKMu7WaFassFyuSGkfQyEoJHA5VEp7yEnzIKcHUFArV8N4kE/Y
         9e6C/C/9a4OZ+Y+2drWstXtAiuwu/mzjs7Mb5P2l5Ir4twIiVvq0Fyn1wQZaXLx6ynr1
         HkEOVT2KzWlx+mYoWJoanOtKQQQcFqAA+/onyjXgFNe/2WZujQE8+QLz8AYuIftNKdwR
         uM4g==
X-Gm-Message-State: AOJu0YznhSZfz9oMmvfGUf4136956VTH2Zo1PORFrVyeYMOzZ7o1dhjy
	SrFHzXWSDk9XuBcj+lU/Gt159NF4yjnrMHzTtxksgV9ce6soQejUea48Ri34UL/QMYN8l/mlczB
	vOwxlMWzlTfuIbBswI5AmpOMvlp/n2qCjK49TMz2+AP9WTnsbcn9+jQ==
X-Google-Smtp-Source: AGHT+IGa92m2LMCXflLaiEs4By7t3Xb4VTHpL+lnmhdtVI77oh5nvoDYjhC/3FmPZ3/culI72AM73cH8LI2Ukit6TGI=
X-Received: by 2002:a05:6000:1147:b0:374:c283:f7b7 with SMTP id
 ffacd0b85a97d-374ecc8f661mr2369288f8f.21.1725363713010; Tue, 03 Sep 2024
 04:41:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901160807.346406833@linuxfoundation.org>
In-Reply-To: <20240901160807.346406833@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 3 Sep 2024 20:41:41 +0900
Message-ID: <CAKL4bV5SRyAq6Q6e7jQ5tvk6bDKzbuk-x5vnhT_TmBpHVchtRg@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/93] 6.6.49-rc1 review
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

On Mon, Sep 2, 2024 at 1:26=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.49 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 03 Sep 2024 16:07:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.49-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.49-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.49-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240805, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Tue Sep  3 19:41:58 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

