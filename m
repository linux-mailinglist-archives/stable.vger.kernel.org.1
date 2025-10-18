Return-Path: <stable+bounces-187803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D454BEC642
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 04:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1C1189A6F6
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C30274FEF;
	Sat, 18 Oct 2025 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="XDFZNX71"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5413595C
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760756347; cv=none; b=fdOD+rQI20IqIoNdumVQB3pI4kjcU2AuV7kULE+hBdJhfuk1ll9/Yozu7Ma/CjDszVAzintldSdeU7fKn3MthSzQ6mAtFVewgyDUnEWI5wujyTR785rr4zG92q4QAFP6irJPiMJ7waVyUIMuC+f61ExVqCcnTjJa0bV+jYd62Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760756347; c=relaxed/simple;
	bh=avVGw9LT9zS0e17H9AAedFjzwv+qTWY1VdC50gQsxWc=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=dNt3b0DeQMAcOsCAkYM2IXDzmyqWmoQKANLqfZqqh5ar1oZyZtNxgEpoZmWM9U78JO9BYHxSm4WkrlxX9S/B/72vCgg71RrjFz+cyGUe7Ou9ABmCJiAH0lsRMNIxm2JcziR6oMpasQnbjqfxmkEZBbnpDsGOnNeW0/eaVnknLKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=XDFZNX71; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-782e93932ffso2339900b3a.3
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 19:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1760756345; x=1761361145; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORodSjJAFFZ+u+HOlRGpup04hzo+9A05ri+ymgs0NUc=;
        b=XDFZNX714Y4l5/S2J/iFFXFhSbNx+u07pzrkQjZLWe1jMSSCKskZhi9agP4ttaLV20
         TawB5kKdlfUHZQqbxWWPO25T/ILqo3uhfZybT1JRj7UZXEStvXGbHPXv1EmdHDisB7Nh
         tDHlRpVdfZDcUqw3y/Z/Tsjr64y+2ZXRTw3kVxOy2ahP1pm4nniUxpTg3BdeWYcT9Od6
         dx4CxmvA4eG03wow9l5k0Z3yKId6xYmn1Jtgex6VJZhquBltqRq4fhe/MLNTByRKeqMP
         mBCMVStVeLahGGQa60vQPbu28KJMg0cTUTzhzC+dx7ycvbCA00WMaxe46GA6/YRE92Rx
         nRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760756345; x=1761361145;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ORodSjJAFFZ+u+HOlRGpup04hzo+9A05ri+ymgs0NUc=;
        b=Kki9KXwEPkPx0gmE7oobnKaW3ZNq5I7Nrhx8rkLv0ACDkky0riRlczcZzdpoXzNZJi
         4/up7IAP3disuUX9xmhSb0nh+ups49mEqDRPKkeZdkY/56yFFG8If5KEeO6GYqR/CsrV
         FXf6do33/e0Dh5vF+LGQkXcgyAty9EwKPs+y6wxvCEPSMqHewhNiM/MJFy3m7VOBt23Z
         zrLzjKOQKomLbvbYO8t68b1amG6aVhF0wluaGJ8MSIbAL3fny/pP+lWYAa8TcygTz+TP
         s3PoOeC2Znew5zvRmmfwHVwNnLiGnFLSFl9iUW6NJq+HZLG0Z1D2Rf1cJA51VPPG56zj
         Jxtg==
X-Forwarded-Encrypted: i=1; AJvYcCVxUhrTU8Wc7mzTVkjPmqpKuoVWhwzzse9XhOAMVHh/EjYEhwXBD9llA0hPlfgwvHHon4gyAms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdEJUY0hYejlZxJziwp7IqoT9Kj/2xUYtX4tvsICpfUsCaOV6+
	SDm++gRD9+RTCaDTGCgz1YTa7Rt4LlX8yuYT9EQwHqVxwxZUNdHoSRL5F7sE819EgGQlAEqlkjK
	HLaGnZJU=
X-Gm-Gg: ASbGncsG54W6IWpinhVONwcwcFKqJF/oVmjvQ/Zl0UJ3/tZDMpTixf+1QJWeWqVYIk4
	4qk7oMGWahZFHGwxsPXUIaqochUthPNsL7f1odX5dNBMSkGYdMTnDjj5Zmb7RTVi1dKoQHW1Y/j
	CnPi1peFFzKgZi4FtiS696KDApm899cGUyd8LRjrv+ffD/a+98v8+cRGSAndqFz5W6jTC/kB35n
	2JWWtb3EBOiVkbjQPeiLwAGmuHGZiD9ZnvXIUtOsBjfTpt9rCeLjaUPPqKPLtbBmUvu5Ud4jLjI
	Lz6W/gt906oqi7nWq6CP2WneCSfdDxHxttI5qxujlx5lpjsB7yT18/uqD77Rq/fX87rAguB/Wr7
	gHayIVZ40t7Oqsclpe3LmtIjkyqwHCRGn1AUEzPohyNr1X0bjqIXRbpm3PkeV+pg0RUxOLan4Fj
	vKYS7B
X-Google-Smtp-Source: AGHT+IH9kOZzNoNSDKt9fJP63MNBI7l8T2JpXFieIZkug5CfkNqhZI2v0/oN77GFshqae2CU3YcHIQ==
X-Received: by 2002:a05:6a00:886:b0:77d:b0cf:ca14 with SMTP id d2e1a72fcca58-7a220af0525mr6637784b3a.22.1760756344648;
        Fri, 17 Oct 2025 19:59:04 -0700 (PDT)
Received: from 15dd6324cc71 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff34e72sm1137538b3a.24.2025.10.17.19.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 19:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build) call to
 '__compiletime_assert_1093' declared with 'error' attribut...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 18 Oct 2025 02:59:03 -0000
Message-ID: <176075634339.3430.9711342875643201385@15dd6324cc71>





Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 call to '__compiletime_assert_1093' declared with 'error' attribute: clamp() low limit -7 greater than high limit 15 in drivers/net/wireless/ralink/rt2x00/rt2800lib.o (drivers/net/wireless/ralink/rt2x00/rt2800lib.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:29836e043a505e7ba05b17f7c0169fdf1043b303
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  a32db271d59d9f35f3a937ac27fcc2db1e029cdc



Log excerpt:
=====================================================
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3980:10: error: call to '__compiletime_assert_1093' declared with 'error' attribute: clamp() low limit -7 greater than high limit 15
 3980 |                 return clamp_t(char, txpower, MIN_A_TXPOWER, MAX_A_TXPOWER);
      |                        ^
./include/linux/minmax.h:218:36: note: expanded from macro 'clamp_t'
  218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
      |                                    ^
./include/linux/minmax.h:195:2: note: expanded from macro '__careful_clamp'
  195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
      |         ^
./include/linux/minmax.h:188:2: note: expanded from macro '__clamp_once'
  188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
      |         ^
note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
././include/linux/compiler_types.h:297:2: note: expanded from macro '_compiletime_assert'
  297 |         __compiletime_assert(condition, msg, prefix, suffix)
      |         ^
././include/linux/compiler_types.h:290:4: note: expanded from macro '__compiletime_assert'
  290 |                         prefix ## suffix();                             \
      |                         ^
<scratch space>:112:1: note: expanded from here
  112 | __compiletime_assert_1093
      | ^
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3980:10: error: call to '__compiletime_assert_1093' declared with 'error' attribute: clamp() low limit -7 greater than high limit 15
./include/linux/minmax.h:218:36: note: expanded from macro 'clamp_t'
  218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
      |                                    ^
./include/linux/minmax.h:195:2: note: expanded from macro '__careful_clamp'
  195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
      |         ^
./include/linux/minmax.h:188:2: note: expanded from macro '__clamp_once'
  188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
      |         ^
note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
././include/linux/compiler_types.h:297:2: note: expanded from macro '_compiletime_assert'
  297 |         __compiletime_assert(condition, msg, prefix, suffix)
      |         ^
././include/linux/compiler_types.h:290:4: note: expanded from macro '__compiletime_assert'
  290 |                         prefix ## suffix();                             \
      |                         ^
<scratch space>:112:1: note: expanded from here
  112 | __compiletime_assert_1093
      | ^
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3980:10: error: call to '__compiletime_assert_1093' declared with 'error' attribute: clamp() low limit -7 greater than high limit 15
./include/linux/minmax.h:218:36: note: expanded from macro 'clamp_t'
  218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
      |                                    ^
./include/linux/minmax.h:195:2: note: expanded from macro '__careful_clamp'
  195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
      |         ^
./include/linux/minmax.h:188:2: note: expanded from macro '__clamp_once'
  188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
      |         ^
note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
././include/linux/compiler_types.h:297:2: note: expanded from macro '_compiletime_assert'
  297 |         __compiletime_assert(condition, msg, prefix, suffix)
      |         ^
././include/linux/compiler_types.h:290:4: note: expanded from macro '__compiletime_assert'
  290 |                         prefix ## suffix();                             \
      |                         ^
<scratch space>:112:1: note: expanded from here
  112 | __compiletime_assert_1093
      | ^
  CC [M]  drivers/media/usb/gspca/spca501.o
  CC [M]  drivers/isdn/hardware/mISDN/speedfax.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192c/fw_common.o
  CC [M]  drivers/media/pci/saa7134/saa7134-ts.o
  LD [M]  drivers/media/test-drivers/vimc/vimc.o
  CC [M]  drivers/media/test-drivers/vivid/vivid-core.o
  CC [M]  drivers/gpu/drm/drm_fourcc.o
  CC [M]  drivers/media/usb/gspca/spca505.o
  CC [M]  drivers/isdn/hardware/mISDN/mISDNinfineon.o
  CC [M]  drivers/gpu/drm/drm_modes.o
  CC [M]  drivers/media/usb/gspca/spca506.o
  CC [M]  drivers/media/test-drivers/vivid/vivid-ctrls.o
  CC [M]  drivers/media/pci/saa7134/saa7134-tvaudio.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.o
  CC [M]  drivers/media/usb/gspca/spca508.o
  CC [M]  drivers/media/test-drivers/vivid/vivid-vid-common.o
  CC [M]  drivers/isdn/hardware/mISDN/w6692.o
3 errors generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-17
- config: https://files.kernelci.org/kbuild-clang-17-arm-allmodconfig-68f2e7b55621556c1f205610/.config
- dashboard: https://d.kernelci.org/build/maestro:68f2e7b55621556c1f205610


#kernelci issue maestro:29836e043a505e7ba05b17f7c0169fdf1043b303

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

