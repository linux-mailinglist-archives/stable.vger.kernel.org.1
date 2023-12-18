Return-Path: <stable+bounces-7078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DF08170C8
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E94681C237B4
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC5511CA6;
	Mon, 18 Dec 2023 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nJICHXrU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD691D15C
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7c45fa55391so816073241.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 05:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702907253; x=1703512053; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cA/E6cv8atZDrEKbxJ1M6XASEEFwjGkykB515p9AX5A=;
        b=nJICHXrUIJnHU7ktNbzvPv1bxe1zaAVR6RzPa1HjVo4/VeuX7c9ciyj1rrb+mis4MQ
         ohYylRhQY5pkQ4P3m/ZeHXE6+WR1XPvOsN3ig8vqlFpn+sSzhHCEWlCcRfIQrT/v8V/d
         4YdsOA3ZVlIUDGMgxav77sAsU+Jv3aMDg1Favdp+NYPlLwqTdVgS/HxZs3cjqenoDdBL
         D6q9PZ15Cr40YromhS4dKSVo46Cz7UNJ91TCQIHbuowD98KiaW69dAWELqi5s7FQngMk
         KK3VMkYrvBEF7vYq7p73iEKtaQC+5eYKjgq4bgIW1ckK0qJK6G8y+VkdTi8WJMCW6tia
         6pAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702907253; x=1703512053;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cA/E6cv8atZDrEKbxJ1M6XASEEFwjGkykB515p9AX5A=;
        b=kczXSojNY3z7XI7In9vJX5r3la1NspSIBaiiYwur5ZhOxjjVH6BiUqBH3yTJOYqxgz
         G2/iZ7s/nUuTEQVHSQvwvJ2n4c0N0yC32wystzwN5I7PdyAcQaVj525iMuyWlVTsyJju
         B/8CAAh/4RGPwPzr1R47JjZFEQNHDY26eu3CMu1WIo2ixVOw+iGdLloTLTgqq7P3TXps
         HiqOhKttqzIUFazi9znJGPEimScNRUrgh2QhbQXGr/PYdneVFTSuhH3Qhzt+nC4syH64
         ne36xZcBgamo+VYy11hbWtVbYx58sVwJPZtRsojX3RUSBP4t3K/eyNrp7fxP2Jk6Wi9y
         Jo+w==
X-Gm-Message-State: AOJu0Yxn4Fw6FpWmbBUyq2uNW3aY5bHGFNA1dPIJMUaiCYnwehFSStYX
	rJyWXkp4iF4UHqIwv++sPfVZceRZ3FZiUc4eZFoJuRS1JtbctdCkzOs=
X-Google-Smtp-Source: AGHT+IEwVWdOEe6ilNObtGoPzfILZYGNLVhXl/dsUjA1DMAlBlR/IL9uUqLd5AEM3XI0QkJY9ZJlALNQFra/6Y3vdBc=
X-Received: by 2002:a05:6122:208a:b0:4b6:c405:140b with SMTP id
 i10-20020a056122208a00b004b6c405140bmr832682vkd.19.1702907253178; Mon, 18 Dec
 2023 05:47:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 18 Dec 2023 19:17:21 +0530
Message-ID: <CA+G9fYupBYRYc5eAdHt6TH+xfoCRE31=FpDMS+-QY3b6rKPOQQ@mail.gmail.com>
Subject: stable-rc: 5.10: arm: arm64 builds failed
To: linux-stable <stable@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Maxime Ripard <maxime@cerno.tech>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

commit that is causing build failure,
drm/atomic: Pass the full state to CRTC atomic begin and flush
[ Upstream commit f6ebe9f9c9233a6114eb922aba9a0c9ccc2d2e14 ]


Build log:
------------
drivers/gpu/drm/sun4i/sun4i_crtc.c: In function 'sun4i_crtc_atomic_begin':
drivers/gpu/drm/sun4i/sun4i_crtc.c:63:44: error: implicit declaration
of function 'drm_atomic_get_old_crtc_state'
[-Werror=implicit-function-declaration]
   63 |         struct drm_crtc_state *old_state =
drm_atomic_get_old_crtc_state(state,
      |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/sun4i/sun4i_crtc.c:63:44: warning: initialization of
'struct drm_crtc_state *' from 'int' makes pointer from integer
without a cast [-Wint-conversion]
cc1: some warnings being treated as errors

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Due the build error following builds failed,

Regressions (compared to build v5.10.204)
------------------------------------------------------------------------

arm:

  * build/gcc-8-defconfig
  * build/gcc-12-lkftconfig-no-kselftest-frag
  * build/gcc-12-lkftconfig
  * build/gcc-12-lkftconfig-kselftest-kernel
  * build/gcc-12-lkftconfig-debug-kmemleak
  * build/gcc-12-lkftconfig-perf-kernel
  * build/gcc-12-lkftconfig-kasan
  * build/clang-17-lkftconfig
  * build/gcc-12-lkftconfig-rcutorture
  * build/clang-lkftconfig
  * build/gcc-12-lkftconfig-kunit
  * build/clang-nightly-lkftconfig-kselftest
  * build/gcc-12-lkftconfig-kselftest
  * build/gcc-12-lkftconfig-perf
  * build/gcc-12-lkftconfig-libgpiod
  * build/clang-17-lkftconfig-no-kselftest-frag
  * build/gcc-12-defconfig
  * build/gcc-12-lkftconfig-debug
  * build/clang-17-defconfig
arm64:

  * build/gcc-8-defconfig
  * build/gcc-12-lkftconfig-no-kselftest-frag
  * build/gcc-12-lkftconfig
  * build/gcc-12-lkftconfig-kselftest-kernel
  * build/gcc-12-lkftconfig-64k_page_size
  * build/gcc-12-lkftconfig-debug-kmemleak
  * build/gcc-12-defconfig-40bc7ee5
  * build/gcc-12-lkftconfig-kasan
  * build/gcc-12-lkftconfig-perf-kernel
  * build/clang-17-lkftconfig
  * build/gcc-12-lkftconfig-rcutorture
  * build/clang-lkftconfig
  * build/gcc-12-lkftconfig-kunit
  * build/gcc-12-lkftconfig-armv8_features
  * build/gcc-8-defconfig-40bc7ee5
  * build/clang-nightly-lkftconfig-kselftest
  * build/gcc-12-lkftconfig-kselftest
  * build/gcc-12-lkftconfig-devicetree
  * build/gcc-12-lkftconfig-perf
  * build/gcc-12-lkftconfig-libgpiod
  * build/clang-17-lkftconfig-no-kselftest-frag
  * build/clang-17-defconfig-40bc7ee5
  * build/gcc-12-defconfig
  * build/gcc-12-lkftconfig-debug
  * build/clang-17-defconfig

 Links:
- https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.204-60-g0b1eceef25bc/testrun/21731369/suite/build/test/gcc-12-lkftconfig-kunit/history/

--
Linaro LKFT
https://lkft.linaro.org

