Return-Path: <stable+bounces-187804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA8EBEC645
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 04:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B849C4EAB07
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E50275105;
	Sat, 18 Oct 2025 02:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="kKipXA58"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9803770B
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 02:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760756348; cv=none; b=G/hBFgrRNZVQkOh0sSmFiyWTXyMDqyMvIH/7M4HH/ydaRagdhUJFHEc4+aDr3xZ7yBp/5V6d5c7kIgjR2oQTmVXhityKR8pk1pHq6WYnTvkkdQh6ZWuOGQpvEzT9LAc/Kl/pxYb76EzW6c6MvFoEuyMCyzltQKUnV3d2Sl0JS9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760756348; c=relaxed/simple;
	bh=KlwR+x4sH15K2xq9XqAHIQei8RAJo+1mRrCrHpKme74=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=kXwb6FbcvGpP6lweZ5WSoC5+JC3y4fEd4Og3Tqwgfo9aXCGzDHxCbDOeCOpnrHkU+3ZXLzGMKyiPlJJ03U3icdtHFnp/C6llpug1dEW6zCzVkR9WvYcTemx7vA/70iEr08z7/QSIGYDfsVj3v573xH7pDrabT2wZ8VZguHQAgHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=kKipXA58; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b6093f8f71dso1726344a12.3
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 19:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1760756346; x=1761361146; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OI6EOvjnQawY4iTILbjvax+Unopm95YPKwmsnsi9zR4=;
        b=kKipXA58ct2KtMGslZeniivVTTejxXstO70NiXyEpwtY+l2/ApI9XMBLgOefDdF5eT
         tFh2Ds4Zy5A8g61sgLk7sM6hd6YcmhvajkNriHf/tLtkU67jLgyE17MrJr9F7O+7FBtm
         RVs3FTbYxoOWzIROOE3/+gXRAaPxM2I6HFu/oqkhlkVI9SlRBhFWxg/gOwTbWP9Gx3VZ
         r3FBUUtO0WcHBnotR+SdArDtw7c4tPS0ku2zALvNYV1hBIC0ZbLsyF8n+LMtVaSattzK
         b3lhhP/zy4vh6xMla4tQ9RR5jbApuk4T0GSZyU7lWYhito5CI90iXq1Ble9pUVzpILZx
         EgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760756346; x=1761361146;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OI6EOvjnQawY4iTILbjvax+Unopm95YPKwmsnsi9zR4=;
        b=QU0lB4H3N4QZ50WiVEXa11MtLR9fU1rx67uBeguOrQjSDGZbhDxIH0RbageK+F+JBB
         mK/81Q1KXhlADraWmI3Y2PJOWorGjhyUQc5UA2fRj8gQq1Uffqa+IzKA7uc6E2Gm2ZSa
         9jWa4P+nwsdTQ3adwBx2j97/IGilt1Qkgav5igYb/GrwyyKssj1Y2IjKWnRLrdUy8F9c
         rHc/dKGRiRy2Rb9xaImDqQNKJxB9HkysbjhQB/gajDDW9kjOlbxjXGnwxHLTksh1cTe3
         +rDH5PXqhO8Zs5ky4MpU7klqSYWVMvfTwDOCYG1BL7u9AoVFJ1zojns5quOk+ZBMkmEI
         v80Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcCRWCuMM8DsW0vzHduHaKyDgrnWKKDInDjnfMPbI2FlEISyX1X6x72BJLDqYiwL+bgL1JULA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfDKfqQwyCoDSLqsmUJCbl7b6mvx9Fb2YpSb507FCkhKPi/M+R
	y/0nGO8AxluQ5erb86yna/2c7KC6Kd20/OxSRmBU/RQgSPjOaDwo+5VIskWjrNvecsM=
X-Gm-Gg: ASbGnctbvsQzXg63zKgHtRzZvUrM02tmJ1BmwvyDyNilnVJ9YHjWlx47KgFH5nty3zx
	gdG03rggOb+tP6ALrfuCZEDd21LMFA97YLmV1OlXwqIx3pp1hpm9OppA1DTWZDgqXLvY6hWKw6L
	ppdZGrt4GcFeMwAjnQCZ0VX92IUl9i8lqqdowfotC9iH0p5Tfjbqj9qT2BNd/idsK82FR7d1Tdm
	U5d/4uipG+3HbD3Y6tvLM2nggkZqoVjvIJCrNoqxZOJr/ldQu7XUJrBviIHFspFUqihgbHCk3ZT
	3qSO6kTYn7tLTIzjzImCgoVOID8xu1T2cltGhBPs02nGIF9UfX/l7SX6TJwHM+F1I1OcOKRvZ+O
	E2ZhiOtt4C42w49qFj71mM8Qax9/PVeX/253QvCnorxOOkHxwImK3XTbSOIQykTBB6tWhJhOWcT
	s+V99X
X-Google-Smtp-Source: AGHT+IHrh+1DKjcPTO0zrfDc7mHaUwyhjkHUxkCKeNgGqomztW3uvi39ZueJo4x4LfSQG6HiUgTeAw==
X-Received: by 2002:a17:903:94d:b0:266:9c1a:6def with SMTP id d9443c01a7336-290c9bea18dmr72836795ad.0.1760756346056;
        Fri, 17 Oct 2025 19:59:06 -0700 (PDT)
Received: from 15dd6324cc71 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebd068sm10370415ad.12.2025.10.17.19.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 19:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-5=2E10=2Ey=3A_=28build=29_in_expa?=
 =?utf-8?q?nsion_of_macro_=E2=80=98clamp=5Ft=E2=80=99_in_drivers/net/wireles?=
 =?utf-8?q?s/ralink/rt2=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 18 Oct 2025 02:59:05 -0000
Message-ID: <176075634485.3430.12892426508442948824@15dd6324cc71>





Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 in expansion of macro ‘clamp_t’ in drivers/net/wireless/ralink/rt2x00/rt2800lib.o (drivers/net/wireless/ralink/rt2x00/rt2800lib.c) [logspec:kbuild,kbuild.compiler.note]
---

- dashboard: https://d.kernelci.org/i/maestro:c03efd07fc01bc2d01554b8abdc3ecef088683b6
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  a32db271d59d9f35f3a937ac27fcc2db1e029cdc



Log excerpt:
=====================================================
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3980:24: note: in expansion of macro ‘clamp_t’
 3980 |                 return clamp_t(char, txpower, MIN_A_TXPOWER, MAX_A_TXPOWER);
      |                        ^~~~~~~
In function ‘rt2800_txpower_to_dev’,
    inlined from ‘rt2800_config_channel’ at drivers/net/wireless/ralink/rt2x00/rt2800lib.c:4024:25,
    inlined from ‘rt2800_config’ at drivers/net/wireless/ralink/rt2x00/rt2800lib.c:5560:3:
././include/linux/compiler_types.h:309:45: error: call to ‘__compiletime_assert_1041’ declared with attribute error: clamp() low limit -7 greater than high limit 15
  309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                             ^
././include/linux/compiler_types.h:290:25: note: in definition of macro ‘__compiletime_assert’
  290 |                         prefix ## suffix();                             \
      |                         ^~~~~~
././include/linux/compiler_types.h:309:9: note: in expansion of macro ‘_compiletime_assert’
  309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/minmax.h:188:9: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
  188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
      |         ^~~~~~~~~~~~~~~~
./include/linux/minmax.h:195:9: note: in expansion of macro ‘__clamp_once’
  195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
      |         ^~~~~~~~~~~~
./include/linux/minmax.h:218:36: note: in expansion of macro ‘__careful_clamp’
  218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
      |                                    ^~~~~~~~~~~~~~~
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3980:24: note: in expansion of macro ‘clamp_t’
 3980 |                 return clamp_t(char, txpower, MIN_A_TXPOWER, MAX_A_TXPOWER);
      |                        ^~~~~~~
In function ‘rt2800_txpower_to_dev’,
    inlined from ‘rt2800_config_channel’ at drivers/net/wireless/ralink/rt2x00/rt2800lib.c:4028:4,
    inlined from ‘rt2800_config’ at drivers/net/wireless/ralink/rt2x00/rt2800lib.c:5560:3:
././include/linux/compiler_types.h:309:45: error: call to ‘__compiletime_assert_1041’ declared with attribute error: clamp() low limit -7 greater than high limit 15
  309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                             ^
././include/linux/compiler_types.h:290:25: note: in definition of macro ‘__compiletime_assert’
  290 |                         prefix ## suffix();                             \
      |                         ^~~~~~
././include/linux/compiler_types.h:309:9: note: in expansion of macro ‘_compiletime_assert’
  309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/minmax.h:188:9: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
  188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
      |         ^~~~~~~~~~~~~~~~
./include/linux/minmax.h:195:9: note: in expansion of macro ‘__clamp_once’
  195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
      |         ^~~~~~~~~~~~
./include/linux/minmax.h:218:36: note: in expansion of macro ‘__careful_clamp’
  218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
      |                                    ^~~~~~~~~~~~~~~
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3980:24: note: in expansion of macro ‘clamp_t’
 3980 |                 return clamp_t(char, txpower, MIN_A_TXPOWER, MAX_A_TXPOWER);
      |                        ^~~~~~~
  CC [M]  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.o
  CC [M]  drivers/media/cec/platform/s5p/s5p_cec.o
  CC [M]  drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv50.o

=====================================================


# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-12
- config: https://files.kernelci.org/kbuild-gcc-12-arm-68f2e7db5621556c1f20565d/.config
- dashboard: https://d.kernelci.org/build/maestro:68f2e7db5621556c1f20565d


#kernelci issue maestro:c03efd07fc01bc2d01554b8abdc3ecef088683b6

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

