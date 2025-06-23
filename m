Return-Path: <stable+bounces-155358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97440AE3EC6
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360D7188E750
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 11:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9827A24293F;
	Mon, 23 Jun 2025 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="eV6LwuSo"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C0424113C
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679948; cv=none; b=F+8Wm/qJGn60j14XxwdD48pwGNl5HV6IJNq3haQZfQIWBNOqEJB6ZD/8blXxc/YCYa2RduEyUPbkEw8/w/8nUmdzHSTbc+wAO511Dy+WfQUp9DBjfZiGHXCKv5ikyU3VfOfWS3X+9xS9iW9z/yqj7gZoEily6FxC8g9Zu50o5dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679948; c=relaxed/simple;
	bh=jKPWaKnKp9zc5QltxRymGMemgPL/C0QL6a7l3d5UPyo=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=RbAWN8kMaBA8CzXgOb9ZitF+GW3l8Sh/tqC0NDiSUEseDrn1YWzrkvFIKZjARzTAvdQay45ISUoVB9SCdfPiCI5BhH+D2zYtfcYT4ebTsMr6bGUpts7FijZUpagSfHaMRzA0Swtl9itG1iFhFg/EOL32okwQW9CPOSQSrFVkRAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=eV6LwuSo; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e82314f9a51so2876768276.0
        for <stable@vger.kernel.org>; Mon, 23 Jun 2025 04:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1750679945; x=1751284745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTM5R4TKkKidr+OVdEAk0To4McFFRFacaIO49nT7dI8=;
        b=eV6LwuSo78Kgv1ihfOBo8U80LvlnBLaGxpbFq+aAaCSNKVvzp3Sh3mfjFaX9NORh+K
         xvzononNet28iMQWOrbbAcqDipZ7hSTC42kLYg1BTH0N1QUVBrTE3ZbgXTSX5/RzhzYy
         wHyRnZoSidUkfJo/u7UbfHNf+DI9vKfzkPTpGFqEIsZ/NFtb1ktnyFtAAmGNFWa8NvEW
         DoSI/uYjLS0JL1pHLLXCWuylDaY016C/6hKuAkeTg4rjP1SY0ahwAnYrLBSt5VnSbS6H
         F7w+N4ASlFJtZyrJN4a1pRr0xYhYSqRcYig/9IwlALOpfV/Swzam6qc6lH58DeB1hyJ5
         +MLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750679945; x=1751284745;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTM5R4TKkKidr+OVdEAk0To4McFFRFacaIO49nT7dI8=;
        b=h6ScbcENE/g/X/zWpUhLGsE/RlXz6DiPbTDUOGfcBhdA1zbDbUdRMazt/6G9CVfUlW
         TiHrxn3S4HPwZ+7cX5Gww35F0Tf/4ZVdGgE8/sdXOWS0bqW3zRQf+xsAryufce9h+NuF
         PuMGdZekz/MQDHnqtbPeKBqpEZkU7e8INMkqf+HNAVkw7HRCJn9wuEhZTm6IiTAmfS80
         fsOYEpFUFAauSf7t++mAQEUj1ZCcFzPDNnblz8uJxrvkeHS8unZmKv+o4fGrm0AboZja
         hQHHGhbRhSMM8+gR07AKXBstNa0JQadoPKNN8fOmjULQtwYz46AuDeA+csZFaQuoFXBU
         kTMg==
X-Forwarded-Encrypted: i=1; AJvYcCXqU7PcWlnPd6A0Q5gOhYFOBPs29Ldce8DXZog3SET243I751bKHvQUkNYdnSxrqElMbl366XA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsANsvRthSa3cuhUgTZsH5V+6jLmmjoxitBaShk3ub4mjrkMP7
	9+9kiO5TTz7bScgwakHEPfAv9YjYfUFcS5VUYl+RwVfLajc6Fatp3IWUDb0d7C+zhfsCLpRXCR8
	+0ktSFhfmQbmHkDxXqy+zaQ7obS3Cnsa8GHszCE4hWw==
X-Gm-Gg: ASbGncv4YMIXSf3h6qYqR1qlR7sNBy5o9svCSqLWFjw7ZmcUxcH//ppoCYTYmXHR1Vo
	5Cwnd+4m78a5saX98S/uPSgy0ZL2pMR8tLtPwrtejYVXzxdffpl/qIESTLrEjRyl66A5/nt9oHL
	LM0kaCmFdkUZmc+2yiiswKbNmjpB/E20UhrSrtgTnZWA==
X-Google-Smtp-Source: AGHT+IGvluLAyP9N4Wm0IrVm/o5sfyHh9S6QfsHoA7Udk57PW4XvA6h3qYt9Z9X5X2IPf04pG6KX5FOiqe2eHd2URhE=
X-Received: by 2002:a05:6902:2b04:b0:e81:52ff:857 with SMTP id
 3f1490d57ef6-e842bc98476mr15474495276.18.1750679945518; Mon, 23 Jun 2025
 04:59:05 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Jun 2025 07:59:04 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 23 Jun 2025 07:59:04 -0400
X-Gm-Features: AX0GCFuHysYACjboKzTQK-ngcltoTQIQgRWAjSzQ_Vb-ZTGWIspjlOXYe19dSmQ
Message-ID: <CACo-S-3dCWWtnp1XCkWWo1K2LmHbf0vwVycJks0pgaUAwxLWnQ@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build) call to
 '__compiletime_assert_669' declared with 'error' attribute...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 call to '__compiletime_assert_669' declared with 'error' attribute:
BUILD_BUG_ON failed: NFP_BPF_SCALAR_VALUE != SCALAR_VALUE ||
NFP_BPF_MAP_VALUE != PTR_TO_MAP_VALUE || NFP_BPF_STACK != PTR_TO_STACK
|| NFP_BPF_PACKET_DATA != PTR_TO_PACKET in
drivers/net/ethernet/netronome/nfp/bpf/verifier.o
(drivers/net/ethernet/netronome/nfp/bpf/verifier.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:a443657e962cc5696a4fadb99408418d06ed31b4
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  dd859e40a92ee19d6b87baa7c8278804c20c4781


Log excerpt:
=====================================================
drivers/net/ethernet/netronome/nfp/bpf/verifier.c:234:3: error: call
to '__compiletime_assert_669' declared with 'error' attribute:
BUILD_BUG_ON failed: NFP_BPF_SCALAR_VALUE != SCALAR_VALUE ||
NFP_BPF_MAP_VALUE != PTR_TO_MAP_VALUE || NFP_BPF_STACK != PTR_TO_STACK
|| NFP_BPF_PACKET_DATA != PTR_TO_PACKET
  234 |                 BUILD_BUG_ON(NFP_BPF_SCALAR_VALUE != SCALAR_VALUE ||
      |                 ^
./include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
   50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
      |         ^
./include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^
././include/linux/compiler_types.h:309:2: note: expanded from macro
'compiletime_assert'
  309 |         _compiletime_assert(condition, msg,
__compiletime_assert_, __COUNTER__)
      |         ^
././include/linux/compiler_types.h:297:2: note: expanded from macro
'_compiletime_assert'
  297 |         __compiletime_assert(condition, msg, prefix, suffix)
      |         ^
././include/linux/compiler_types.h:290:4: note: expanded from macro
'__compiletime_assert'
  290 |                         prefix ## suffix();
         \
      |                         ^
<scratch space>:5:1: note: expanded from here
    5 | __compiletime_assert_669
      | ^
  CC [M]  drivers/net/wireless/zydas/zd1211rw/zd_rf_rf2959.o
  CC [M]  drivers/mmc/host/vub300.o
1 error generated.

=====================================================


# Builds where the incident occurred:

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:6859285f5c2cf25042d0f80e


#kernelci issue maestro:a443657e962cc5696a4fadb99408418d06ed31b4

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

