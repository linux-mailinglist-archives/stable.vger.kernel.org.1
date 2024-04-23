Return-Path: <stable+bounces-40560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9801A8ADF6E
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 10:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25BF51F25C8C
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 08:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA79C53390;
	Tue, 23 Apr 2024 08:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hvApQ06u"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFA251C59
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 08:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713859546; cv=none; b=eLBV0vvfC+FjEB1U0Y9AfisIHdch0rHJUTGWx/yEL4qzursElciHR6F3toug3KeIb/5qU4Dooe+dJu9QaKSHpjsO0+o+kcVsk0Ywzw0pcgInXmXPiEEt3S446OdYaJWgB4Vp5jMRhA1MerM/IEofDX8K8Qr00xblLqNEK0j/tfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713859546; c=relaxed/simple;
	bh=S11t6t3ohRdU56HDQ5vYI19DYKIlXEPzPo/XjLCWaUI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mjqjYopGAMNDLu5KHQue9/A93gf7shTOTUOT8SR6XfYXteWl8cxA2Ei2KrRgG6cVxMll8tp9TyXgGTUAp0P7tWFFmbJuFV4QZ4o8WAPBZfHJW0g8dKBb5bMpK28qeTvkKWXCH6omfCZ3LRL3utSQslz2Ir3nFYazBKMyIx4+RH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hvApQ06u; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-47a0f54fb13so2165460137.1
        for <stable@vger.kernel.org>; Tue, 23 Apr 2024 01:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713859540; x=1714464340; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JEJUw/erT4Sfy3+z+aWWGpcKxl2sQmHX6b2c4tYmQ2k=;
        b=hvApQ06uTChV1n7aJqx51Pr3fvJnnNVAoBV3pSfGtAJBJOSl99Wh1vVrVyDGFztSdA
         FoBo/sSNNc22fJ1skQddUvBZCRIGhc8TI5vFvkhuqsdQuwjhEhW3CqcOZC/OEZWUnd8/
         X7T+TI/qcxSFNShNR7K7+8IIpz1y+kuvIiNHuZxXWIybK6zqVflpJjEokr1hdoOVCnrb
         J6ZIJh38D0VzofFvrrGlZNYPAprSrdl07yu3xs6dr+52H0cOBpHeOZlW2MekfQ2Yajmu
         EEXiWGcUUoJOabHMg4R9Vk6pNhsQ0otvi7RRCU0Xo2Rviq5l5ICbeU4eiCm+iM1nca0G
         KbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713859540; x=1714464340;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JEJUw/erT4Sfy3+z+aWWGpcKxl2sQmHX6b2c4tYmQ2k=;
        b=PNZt1aQyzT4gmI8ezbUow0RQJBGk3e3/Zv9ZmqL2nDf1lk+BRE22oLMINqONlESdh0
         tYy5/Ety9NjOIhcS6DB5jk1m6ThX19o3fXiU/Ab4L00jD8n7kWMEvF0j60KLsuEi0pmR
         u4/zTkC1ZovTc7fCDfRGFmeW7nL8HkPJI0GQERnFM5KeXfUl8fvgutwyu1porPFvJwmb
         xEfQdiVm1GPPNKatOUmtIsG49lD8Se+eFsoHFScOhttpyxlaUNezqw3zjOTnO75BVjpr
         1A0yj1Q71gRjak1uKiFJcGtuEKUECBNgIRU8d8agkYEzapIjiiTOaQvExhzn586HYWGJ
         MJ2Q==
X-Gm-Message-State: AOJu0Yx4cfBRlKV3dlviTRIc1xcbuPfJdL5Hkp2QxlAZAzEdNKTZXah5
	wr47n/HniJXmoMFqoZ/EY6c6f6s+0QUY56mL8jfnZDWHZ4vCMdcGVBoG172YZFQTcE5ef1htadm
	aa2uSWfzZSunmZZ0CKWbIyxyB8q9gxEYwpM0SMr/mVkmmHP3eTHY=
X-Google-Smtp-Source: AGHT+IEEfvHpJuOZO3bhpHZYUNA1VysN5yiPfbxPzfA5gjxsnbOpcw3aOcepncCNlErP/2Su1YqiJW+1Ztx3JEntGwM=
X-Received: by 2002:a05:6102:3a76:b0:47a:516e:2d5b with SMTP id
 bf22-20020a0561023a7600b0047a516e2d5bmr13119314vsb.26.1713859539968; Tue, 23
 Apr 2024 01:05:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 23 Apr 2024 13:35:28 +0530
Message-ID: <CA+G9fYsyacpJG1NwpbyJ_68B=cz5DvpRpGCD_jw598H3FXgUdQ@mail.gmail.com>
Subject: stable-rc: 5.10: arm: u64_stats_sync.h:136:2: error: implicit
 declaration of function 'preempt_disable_nested'
To: linux-stable <stable@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc: petr@tesarici.cz, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The arm and i386 builds failed with clang-17 and gcc-12 on stable-rc
linux.5.10.y
branch with linked config [1].

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

In file included from init/do_mounts.c:7:
In file included from include/linux/suspend.h:5:
In file included from include/linux/swap.h:9:
In file included from include/linux/memcontrol.h:13:
In file included from include/linux/cgroup.h:28:
In file included from include/linux/cgroup-defs.h:20:
include/linux/u64_stats_sync.h:136:2: error: implicit declaration of
function 'preempt_disable_nested'
[-Werror,-Wimplicit-function-declaration]
  136 |         preempt_disable_nested();
      |         ^
include/linux/u64_stats_sync.h:143:2: error: implicit declaration of
function 'preempt_enable_nested'
[-Werror,-Wimplicit-function-declaration]
  143 |         preempt_enable_nested();
      |         ^

Suspecting patch:
 u64_stats: fix u64_stats_init() for lockdep when used repeatedly in one file

    [ Upstream commit 38a15d0a50e0a43778561a5861403851f0b0194c ]

Steps to reproduce:
---
# tuxmake --runtime podman --target-arch arm --toolchain clang-17
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2f8pIb4fiJ5NY0zeALMmUnqnaa2/config
LLVM=1 LLVM_IAS=0 dtbs dtbs-legacy headers kernel kselftest modules

Links:
 - [1] https://storage.tuxsuite.com/public/linaro/lkft/builds/2f8pIb4fiJ5NY0zeALMmUnqnaa2/config
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2f8pIb4fiJ5NY0zeALMmUnqnaa2/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.215-32-gd3c603576d90/testrun/23479825/suite/build/test/clang-17-lkftconfig-no-kselftest-frag/details/

--
Linaro LKFT
https://lkft.linaro.org

