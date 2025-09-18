Return-Path: <stable+bounces-180529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9540DB84CF7
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 15:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42977C3C45
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 13:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C574B30C37A;
	Thu, 18 Sep 2025 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FdjDPtze"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB29930BBB7
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202095; cv=none; b=PeiqTBGxI3HKZlDjIktw+Rp0StHbjmOR1xwK65P848JQHWxGI6jA1u8+jjlfbT5dvU+RbCqVuLvIXc27J9wAgasZPAgJuSpAMv31j7FsJaiKfms0IH6xWchBlZmTCYHgPk7k+V17339TCz+qgdEbyZRPKkqxF0QH5M3WzE3Oyy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202095; c=relaxed/simple;
	bh=Uo4HGmijL1iQgbMg4uhdWXoXsg7KT6SAxbbAAkAr18g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gemPfVNJAx/ANjxs/fjWeg9KZFLWSfC1pK7ndJbybiyRf6nrU6wkPJveu2MiV7fHM+qKvWGyhF7WzHSq834E6rhL7vRK4mNuktfy1XcszE4s48sUn/j3E1a5kA153uE8qN0l0wP+Aasot2TxzpT1D76sWc87HSwy6gyKLU7mx28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FdjDPtze; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b606291fddso562031cf.2
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 06:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758202093; x=1758806893; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tUNolTQcgouJkWXCDG6MbN3B7+59q/SI4c38sI/f7/8=;
        b=FdjDPtzelD4tjAOCR3fAccHXQzOzzCVlUaCI6zN5Rjq01fxBzXfrYOkhf0LW4+kLcI
         L581kgLNZNiv2q7NZTibyg6TM0zLJnczorsPsFUjPMTBtC5NywTeNxQqORvOI06XRCq+
         64pHZfijsLN4Vn47id4+NcmVAtgxbt0lRpRT7nZMeF933kVt/0vo2DUtCdGMsoOnccbM
         6M5IiokqRBCJDTux3tdW80/7qaTgtEzW8gu0LvEZZCBWPtO674tIPpPGjnoPqrZhQOrR
         OT0Z0U6cA+MOYt0ueSHJVJ8lfrJFKASZvPMrSPhm5qth0YJmuozW5TVFj/uNxW27oABH
         Yy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758202093; x=1758806893;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUNolTQcgouJkWXCDG6MbN3B7+59q/SI4c38sI/f7/8=;
        b=lYi0+oA05tP8fsHdtexF4oQpN0SGVVH8bG4123WP2k7P35xQ4esfeqfrCmL0XA2xGO
         3slyePFdvcF+/zOUryGIFoKwBELdObFxc2Kti+aU9hdeKh8Ri85L6dT9pug57GG82766
         kY/1yur4LnrqPAU3+4R0doKSTcSZR7qm0OAGuNxJxh+rRTh3WLjXNmLVLyEAPr6xWjgi
         mp8xHr3XH4V+nKIDKLCGQUDZIRXoC8yLJP+ER9eP01wJojvDCenuoIHSomjAgwQPmLIU
         YgPPNBUjpKIobwp4iVtvd4lfv/NesZK7ftaY2N5nJiHfkRsGInesw54o2a5gh5UGqfSY
         zhuA==
X-Gm-Message-State: AOJu0YxwQ6Aw2qLeWVC8AVYxJff6Wlq5Cyg7Y6G3sPAJfeGCe9EEAkp5
	oT2v2+5id/eTHwEwlbJ40jWaPv+f3ELB+1mXgot6RqOqea3q2Ola49/KLw69i5nM0v5+3b2ld/O
	NsOxLa9E2PXPPVFCGtFhp7lhO9vRRezAleKEYPhLEUgwI2tIepbh/RTQrfw==
X-Gm-Gg: ASbGnct1TaKgQosqVODN/TGuqzkcD9lob053y+saD1iWpM1DtlZ2SWVkEW0JnQuyN6s
	F0a5Bx9yAG01xvhfcFEDvcevEJZLZTzo+EopHBLhxEInYeAAD/EKo9CsmzGPSuqanbt7Xw/eT/i
	ciIXJddBJzxJP3CmZspCob5HDRSFx3epbt2sbA2M7Mc/O3n40bgG20UPqT34suklXsKaNFPZsdq
	e4/BGgznmLAeQG44cz//Du+py3JfwPkYyAIf4VvcbsvWzMwc5xGSF8EZNI=
X-Google-Smtp-Source: AGHT+IGG1jIhGHKRZY7W8sUafuow8PRDueZE/olQQVTbSEj3fkdgWUl1XE9/jN4v3lTvkJ+Pwv1rYCrx3bZQzI6XG9c=
X-Received: by 2002:ac8:5e53:0:b0:4b4:9175:fd48 with SMTP id
 d75a77b69052e-4ba5fdec15cmr43627421cf.0.1758202092667; Thu, 18 Sep 2025
 06:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917123329.576087662@linuxfoundation.org>
In-Reply-To: <20250917123329.576087662@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 18 Sep 2025 15:28:01 +0200
X-Gm-Features: AS18NWBXC4NXI6frSic_5ZXkZR1iZr1QKJv-a6qUPIBbwfHXqxFk1OH_y2U-vbE
Message-ID: <CADYN=9Li3gHMJ+weE0khMBmpS1Wcj-XaUeaUZg2Nxdz0qY9sdg@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/78] 6.1.153-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Sept 2025 at 15:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.153 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Sep 2025 12:32:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.153-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

While building Linux stable-rc 6.1.153-rc1 the s390 allmodconfig with
clang-20 toolchain build failed.

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Build regression: s390 clang-20-allmodconfig

Build error:
arch/s390/kernel/perf_cpum_cf.c:556:10: error: variable 'err' is
uninitialized when used here [-Werror,-Wuninitialized]
  556 |                 return err;
      |                        ^~~
arch/s390/kernel/perf_cpum_cf.c:553:9: note: initialize the variable
'err' to silence this warning
  553 |         int err;
      |                ^
      |                 = 0
1 error generated.

The bad commit pointing to,
  s390/cpum_cf: Deny all sampling events by counter PMU
  [ Upstream commit ce971233242b5391d99442271f3ca096fb49818d ]

Build log: https://qa-reports.linaro.org/api/testruns/29914085/log_file/
Build details: https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.1.y/v6.1.151-87-gb31770c84f52/log-parser-build-clang/clang-compiler-arch_s_kernel_perf_cpum_cf_c-error-variable-err-is-uninitialized-when-used-here/


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.153-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: b31770c84f5240661141c61344d502129a9bda56
* git describe: v6.1.151-87-gb31770c84f52
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.151-87-gb31770c84f52


--
Linaro LKFT
https://lkft.linaro.org

