Return-Path: <stable+bounces-187814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82630BEC7E9
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 06:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64B414E05EF
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 04:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E99230BE9;
	Sat, 18 Oct 2025 04:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="sDgN19/V"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E73019DF9A
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 04:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760763549; cv=none; b=BbDpXNH/UXQJHdUx1vTUxsAp8Keqs4j6kHjcAI+qgBiJp5pHfv9qUwFh0O79ccAV0JP6/iwOomBGzKLSO2kxYKoFEyc/qAIufxVS6O/Kug58V1dZv4TuNIGaFiX9HdxomGqV88imhF8hQ8mmFRl5C7M9NNaXH1HlQNSEBchPIxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760763549; c=relaxed/simple;
	bh=upaR7R1nfP32T83Ewq0XF4ICnJ7p0VhtwjOjfWXipTg=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=iv5359o34jk6LI/81qrYv/NQeeSLduhzu8AaBk7+SESAQsZ7qoRPEiUdFPT7WYKhRW53BHPjkwI4QF26wG0LFQnl+JRWQNCOX/X4vqhcGFSnj+zqNfisVjTQLEwU2E0d0hrRlNV0RIl2ji6apXTe8SJBDlhpuaVn7dMhUyW3nQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=sDgN19/V; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b58445361e8so2853949a12.0
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 21:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1760763545; x=1761368345; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTnADxnliDwJr4QQrE9mp0ZGSL+EyIzby9+Lko3kFFM=;
        b=sDgN19/VLCgXH9+hFqNMgZVx61lKDE5Pa2skYtPHKppmA62MPclioQzB9+XrH7QBsE
         9NgcJtEH9NyS6TT6mPPJaG1EfDDZEHO/TyS1iG3xanOARJdJPnItNWTFFGQhdQPVQYHJ
         uyb8jLasIBzBxbHYPGUriitMh2OBlgyuTs+1YhK4FhJYgXFKJsFLuEupjDII/LEk/pTc
         qtq4/NxJRHq2cdf5lmEcNTdFAevHMzWzbdXqbH2l+OMPPeR/XbZZhb7pNSBf/W6RQY2D
         LF4ARpil++3+yPkxo4Oqx82jOpjlnI8ILQB7ncS+01XIqjrdlmsTU/ru2Czw/mm1kffu
         VVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760763545; x=1761368345;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BTnADxnliDwJr4QQrE9mp0ZGSL+EyIzby9+Lko3kFFM=;
        b=ujOSj77LZENX1zpyJ2Kae0+hkM/qoebfyj/GltvzV7lbe7euDSY3C9uvb7hkDXmvYw
         tEZfMpRlwpSeGdaoiOnOFQlwe6oLpMzexfbsrQg4HpNeF1BrL3Bpx2YnxobxPtGTEGo/
         3xNDmCJVdsGriCt6NKtT861eWyT2d9A+l+j0t57WwSqKSoCMTAiagK5AfvPCw3ozz0G4
         t8k4okY9/UP4zP0jVsZfwhSgd/0ykhhRD/+XTiuPRg/Yxz7m2CI7bIAX2uc1GWroiQyA
         Rn+4z+865nS58q75mcLeUBnyLg/z3pqJiFm9JCMpApuHufkmjS5hIjkv2+/BokPIN2Im
         RcSA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ4ThlOfWerX1saT6hjR1cyMV7rJV0VMdsHjrUuMjJDMhzdPVFZaZv5gbLOumpPaYh/WOrJQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzUkAhe3esImMaajmqjp+IvKlIytvIUCumImnj7vwgt7C+MPCj
	cjSvdK0AKPMNtG66UvTsyNp+Eg7tPj91dx8EIgkSDk+l+SytnLjrGSfvvTicaz2emGw=
X-Gm-Gg: ASbGncsn2SEMBiasshIbA7UGF8Vz/+KQXUJV16j2GAjpTGwaHuy04KnnHuf8zkf2yHC
	QRuhCun7+SOmEgh9X15aHmm8O8HltIX9KOMKmNMKAk1wRDi+H5B8vzHtYwT5caHgnrOrflvzjkI
	JWqdJvgsoetm4/y6pqE5ubAMVeKweIaae9/HSSysxcKPKpNaPjqRBL6ycifAXKWFj/nku3NwrH/
	sCjw9vveiOYwI4HUuYTI1aERRL9QCRrAJZl3MCitjRzrdDw3beh/taOUHCa9oXClE6HIc0qxwgf
	NapYKHgHonuJ8zRQt4rH9QDWuxZXRwsIdHCGaFdAiiRq35okvUj4KngXwayXESDWOcxvxrxas9u
	Nk41chlS73e5vQh4KsHDtlZZIsg/UHPG0Np0uAQH0h+kzY/MXK+KaItRFwww+KyuT2jPZuw==
X-Google-Smtp-Source: AGHT+IFfbJQT6MPDx2bOhory6uprG9vhy//N+UbvZ8HDVSsJQh2R2lcP9r4q5HVCGS8RCeT+KoIfVg==
X-Received: by 2002:a17:903:120b:b0:27e:f03e:c6b7 with SMTP id d9443c01a7336-290919dc114mr118191275ad.10.1760763544616;
        Fri, 17 Oct 2025 21:59:04 -0700 (PDT)
Received: from 15dd6324cc71 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fd9e8sm12831395ad.85.2025.10.17.21.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 21:59:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build) call to
 '__compiletime_assert_1168' declared with 'error' attribut...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 18 Oct 2025 04:59:03 -0000
Message-ID: <176076354332.3469.14276561602723175508@15dd6324cc71>





Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 call to '__compiletime_assert_1168' declared with 'error' attribute: clamp() low limit -7 greater than high limit 15 in drivers/net/wireless/ralink/rt2x00/rt2800lib.o (drivers/net/wireless/ralink/rt2x00/rt2800lib.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:4327def67a111c2ff8dc84e7ed537c3afc889659
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  a32db271d59d9f35f3a937ac27fcc2db1e029cdc



Log excerpt:
=====================================================
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3980:10: error: call to '__compiletime_assert_1168' declared with 'error' attribute: clamp() low limit -7 greater than high limit 15
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
<scratch space>:33:1: note: expanded from here
   33 | __compiletime_assert_1168
      | ^
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3980:10: error: call to '__compiletime_assert_1168' declared with 'error' attribute: clamp() low limit -7 greater than high limit 15
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
<scratch space>:33:1: note: expanded from here
   33 | __compiletime_assert_1168
      | ^
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3980:10: error: call to '__compiletime_assert_1168' declared with 'error' attribute: clamp() low limit -7 greater than high limit 15
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
<scratch space>:33:1: note: expanded from here
   33 | __compiletime_assert_1168
      | ^
  CC [M]  drivers/net/ethernet/sfc/mcdi.o
  CC [M]  drivers/net/wireless/ralink/rt2x00/rt2500usb.o
  CC [M]  drivers/mmc/host/sdhci-xenon-phy.o
  CC [M]  drivers/net/wireless/ralink/rt2x00/rt73usb.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.o
  CC [M]  drivers/media/usb/dvb-usb/usb-urb.o
  CC [M]  drivers/media/usb/dvb-usb-v2/anysee.o
  LD [M]  drivers/mmc/host/armmmci.o
  LD [M]  drivers/mmc/host/sdhci-pci.o
  LD [M]  drivers/mmc/host/thunderx-mmc.o
  LD [M]  drivers/mmc/host/meson-mx-sdhc.o
  LD [M]  drivers/mmc/host/sdhci-xenon-driver.o
  CC [M]  drivers/mmc/core/core.o
  CC [M]  drivers/net/ethernet/sfc/mcdi_port.o
  CC [M]  drivers/net/wireless/ralink/rt2x00/rt2800usb.o
  CC [M]  drivers/media/usb/dvb-usb/vp7045.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2/usb_mac.o
  CC [M]  drivers/media/usb/dvb-usb-v2/au6610.o
  LD [M]  drivers/net/wireless/ralink/rt2x00/rt2x00lib.o
  CC [M]  drivers/media/usb/dvb-usb-v2/az6007.o
  CC [M]  drivers/net/ethernet/sfc/mcdi_port_common.o
3 errors generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig on (arm64):
- compiler: clang-17
- config: https://files.kernelci.org/kbuild-clang-17-arm64-allmodconfig-68f2e7bd5621556c1f205613/.config
- dashboard: https://d.kernelci.org/build/maestro:68f2e7bd5621556c1f205613


#kernelci issue maestro:4327def67a111c2ff8dc84e7ed537c3afc889659

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

