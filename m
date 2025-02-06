Return-Path: <stable+bounces-114072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C897FA2A796
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 12:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653211656E4
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 11:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E04228CA0;
	Thu,  6 Feb 2025 11:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IhxYRS5F"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D493C209F3F
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738841848; cv=none; b=HPD64ZspiGEOwNN9RrLHf3UUR/IUuF+As8ENZWOo6/MBGLuK74tEBGpq7qHD5FvAexsUQg5+XBnEFnlo9PvyjZfjzQQH4WxZZZnK0Zv6c2c6ra30TE82Y3KyJ85p+uaec3Qg85pBAV2Ak+fjpr9ApvYc4t+68sfPVXeA4NEGIRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738841848; c=relaxed/simple;
	bh=WcbLGJwq4AcwSHGQ2m2Nfejx19QckbRwA20i/pxYIw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhvRfyawUO1FltCXSfHPNQQP5B3JMXSaMPLgGp39xhcag++s3V/mNu6ywXbcHjkNzk/PZ61ZnjHAnajy5XgfcknfAokjrwhYTKM/qyxyFfgueHcBET/I88Mrq2LGCzplA1KM/pfqy/0HnejZ/UCer2Rk/L95MlNw1Gt5u1yUnm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IhxYRS5F; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38be3bfb045so1185400f8f.0
        for <stable@vger.kernel.org>; Thu, 06 Feb 2025 03:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738841844; x=1739446644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D32KWc9ir9C0HEQYeaVgTviYL0YqMb8Z6Iw4EEOaB2A=;
        b=IhxYRS5FksK4NkBSBeTMULk6t6yY24snfJhlFOVImQSq9lbhsJIK5bEe082aq7PZpH
         PQb5MmK63O9fEra//4k60rbg51EslyKt7U1gFOZJcC6HN3feitWoRtxgtp2Dks4I7FFY
         GG+/27dkkaPQePAOn4y2frrlZ3cDv1dLC6SGYrQwWuS8WTASMW33TbkbyyYjBiH1hWsz
         Pb9Wfjq+j4pqt2j32n2me9zKoxwauJEodYaPX+Uptg8aSf/gE4yfwFLZya1IXTSXl+qt
         VqaR4DveqMd4IXC+gqvvFIXFXgZPLpkMZ+miQRe+rX/xjugeh46t/6Mm1np/M7CWpOWT
         EMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738841844; x=1739446644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D32KWc9ir9C0HEQYeaVgTviYL0YqMb8Z6Iw4EEOaB2A=;
        b=tZwS5jTQPz9g4t76sHJFKMdJe+PM7cHkPQ/cFQteWUUdvnF8mj4/kAL3OrJ/F3Y/8x
         FA0NjmEUVP8afBnC83a14RTVseKhRcj7lgu2DzYGlXBBBuoELArS5FKNMup7h1DAY8a3
         LIKEGSOc1T83APJduC0gR/tUma7ELNx9Dijo/9JMwQeFmFVXXAmCDeePu1gP1Pi2WFrf
         S4odqps+xXtcwIDVVoElWStXSiK2LIxdvV1FIPTb7pS8sm7myLOenO/Ump+5Vhe2ow2Q
         CaeL8aabpfzKaIDcIeo954PBynGVg7PfJqIGbnUfTG/E5Sdr+L9Z2xbNZ8XFwEtcGtYq
         eyhw==
X-Forwarded-Encrypted: i=1; AJvYcCW9ptbTF8gSsy7ZsVtDvR3Rq/TW4/qZVAk7CTSm+RPWpqwRW9ktiewCvIhddg32sbPzipLIjMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfj5U70UK9G+scWPlWR6rZI8AGnP+IJoP3BY6GNvsRqWl1jzVu
	QwJA19MkRq+yrw8gFL+iEumKTISgTzb6BtpcZjQynxE67cDP4Ddd25n4ICveQ7A=
X-Gm-Gg: ASbGncvUa5oBBKi6Pnl+SvhzbMpgEuiPlVLu8JSIxnz+JB39WGNTWlPx5nbIUFy7G/l
	I47tODfkNuzopkaqYZLUIUSv8U/UxksDk0wLQ1DIEQCkZdN2ycgjlWbrfciJ17DGRMuxUS/NLhK
	DS3CBOgU7tD0FgLDQvnZetPEvR9yZTE47TMqTY/appncrXnWWus+N6B/j+4yvETm2yEzB7XUDH4
	dIC1Aeoa44R9bdXkK/SOHFxMgKxF/hv9gW/vi2BQVsMXwr3V4leZapL/c/OmhyWD9cKIV1F4knv
	7IAUKSq2zpnHUNpd3TMG
X-Google-Smtp-Source: AGHT+IHpYvv/zDG4i03lgS2R3xg3LkmpfRk52jhg17y5N5GeiW6M8nXkkM0Wq0CqmV8YB3R3Sm/1rA==
X-Received: by 2002:a5d:6d06:0:b0:38a:906e:16d0 with SMTP id ffacd0b85a97d-38dbb2ced02mr2406806f8f.21.1738841844030;
        Thu, 06 Feb 2025 03:37:24 -0800 (PST)
Received: from localhost ([2a01:e0a:af6:67e0:48f1:a46e:2623:227d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc2f6aeafsm625513f8f.20.2025.02.06.03.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 03:37:23 -0800 (PST)
From: Theodore Grey <theodore.grey@linaro.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@denx.de,
	rwarsow@gmx.de,
	shuah@kernel.org,
	srw@sladewatkins.net,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	dan.carpenter@linaro.org,
	anders.roxell@linaro.org,
	arnd@linaro.org,
	david.laight.linux@gmail.com,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH 6.13 000/623] 6.13.2-rc1 review
Date: Thu,  6 Feb 2025 12:37:21 +0100
Message-ID: <20250206113721.2428767-1-theodore.grey@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regressions on the arm64, builds failed with gcc-8 on Linux stable-rc 6.13.2-rc1
But the gcc-13 and clang builds pass.

This was also reported on Linus tree a few weeks back [1] and also seen on
the stable-rc 6.12.13-rc1.

Build regression: arm64, gcc-8 phy-fsl-samsung-hdmi.c __compiletime_assert_537

Good: v6.13 (v6.13-26-g65a3016a79e2)
Bad:  6.13.2-rc1 (v6.13-652-g32cbb2e169ed)

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

* arm64:
   build:
    * gcc-8-defconfig
    * gcc-8-defconfig-40bc7ee5
    * gcc-8-lkftconfig-hardening

## Build log
In function 'fsl_samsung_hdmi_phy_configure_pll_lock_det.isra.10',
    inlined from 'fsl_samsung_hdmi_phy_configure' at
drivers/phy/freescale/phy-fsl-samsung-hdmi.c:466:2:
include/linux/compiler_types.h:542:38: error: call to
'__compiletime_assert_537' declared with attribute error: FIELD_PREP:
value too large for the field
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                      ^
include/linux/compiler_types.h:523:4: note: in definition of macro
'__compiletime_assert'
    prefix ## suffix();    \
    ^~~~~~
include/linux/compiler_types.h:542:2: note: in expansion of macro
'_compiletime_assert'
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
  ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro
'compiletime_assert'
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~
include/linux/bitfield.h:68:3: note: in expansion of macro 'BUILD_BUG_ON_MSG'
   BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?  \
   ^~~~~~~~~~~~~~~~
include/linux/bitfield.h:115:3: note: in expansion of macro '__BF_FIELD_CHECK'
   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
   ^~~~~~~~~~~~~~~~
drivers/phy/freescale/phy-fsl-samsung-hdmi.c:344:9: note: in expansion
of macro 'FIELD_PREP'
  writeb(FIELD_PREP(REG12_CK_DIV_MASK, div), phy->regs + PHY_REG(12));
         ^~~~~~~~~~
make[6]: *** [scripts/Makefile.build:196:
drivers/phy/freescale/phy-fsl-samsung-hdmi.o] Error 1

## Source
* kernel version: 6.13.2-rc1
* git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git sha: 32cbb2e169ed556d3d60e8ea56a138cef824a28a
* git describe: v6.13-652-g32cbb2e169ed
* project details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13-652-g32cbb2e169ed

## Build
* build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13-652-g32cbb2e169ed/testrun/27199349/suite/build/test/gcc-8-defconfig/log
* build history: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13-652-g32cbb2e169ed/testrun/27199349/suite/build/test/gcc-8-defconfig/history/
* test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13-652-g32cbb2e169ed/testrun/27199349/suite/build/test/gcc-8-defconfig/
* kernel config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2scp7tWHD0J3Iyj4KIMuqDUMKSF/config
* architectures: arm64
* toolchain version: gcc-8

## Steps to reproduce
- tuxmake --runtime podman --target-arch arm64 --toolchain gcc-8 --kconfig defconfig

Links:
 [1] https://lore.kernel.org/all/CA+G9fYsHGrgZsEEVvP0XMcAhLyCYnrCPgZJ1puT6cfQBCGUB9g@mail.gmail.com/

--
Linaro LKFT
https://lkft.linaro.org

