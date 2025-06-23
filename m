Return-Path: <stable+bounces-155357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F964AE3EC5
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1389188E4D0
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 11:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8792F242D6A;
	Mon, 23 Jun 2025 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ofNPe+5k"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884CA221F1E
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679948; cv=none; b=j9XBTwU6wtVTpMX5GIfuTG/becEr33t9xypUCa3f+wgryCl/9x/MsyFsxek4Bwqty5rlP+9wKWI+yzJ9OSY2ZfVTNsxVcUmZnS1suj+EqZam55ub11l8mvxBX3vNgdhWrdaxkqGK+bXVKRBWV2iIv0WhG6KQY3DGllKfY9AauW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679948; c=relaxed/simple;
	bh=SBfcbTYGZwE6PlRQwdyWY+/E8BLFJDCvslWR7kXqdSo=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=LmuunTyM9Wme1sA9a5VhPPLe/f7ovDyX4n0prWW5Epf2MS0kMT1gj5vrtwKIVJUTl6bFFY7H1P1wAROVsFSOHBz5Dr20AsD4QQdcsCq84Hcd5QXwSuoKeThZ2kE5us8BnB/0vrmQIq/1hxjJ2CQASytaHQJSKX/Sg5iO0R4+gW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ofNPe+5k; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e81749142b3so3457341276.3
        for <stable@vger.kernel.org>; Mon, 23 Jun 2025 04:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1750679945; x=1751284745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RslxvTXkIQ41JDGd0RkkMvh0uu+A1zcB6UC/xkuq7vs=;
        b=ofNPe+5k2oqTJQ1FXbkJI8iVbJCz/BzDWr0XFwSd2auFDVvjQ+FDAqlw+8hgpkUWs/
         O+ipKRIdVZiCPPlBWJ0a4dEKDbGqReJqiyOQZsTBACU/BgloV/yRJ2e3yHFfeqKRXPsS
         nS+89ehe8jkl6dfsxbEAAAykuwixYA2LXS70gumyOrpecZJjmpIfHscRgyxfHgYzxeY1
         TB63mOTkoRryXZjPekGJMX2x7s8MZT+w5CatIwNHM9GU1mHlQciMO9gYBNRYLySVZEf6
         CyHdot6nbnuFabV/iEUyvx1ssop0pE9uvLNKXUjqsAXjxTapv3OAebdWTYw9+3X4p0W8
         7wkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750679945; x=1751284745;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RslxvTXkIQ41JDGd0RkkMvh0uu+A1zcB6UC/xkuq7vs=;
        b=N0aLA+LNtklkEF32zIXfXGi4ylmnveRO5FYnJL9llsXwm+dr7shM0qxXOaNi00rDpD
         UhAlhQeVXvu42ISsqrzZkW0k5zKghLY1h2DqM1mNd66wJdsajmtNe+ssNLHEcVEHdPJn
         VbIG2OHe3/BfaKjg8Wh+MK2OEl+x1Nt8JcuJ9YIE0xMvMw9IWEaUS3O0PjQQJn+xWna3
         808ggO7JVz5zH7SvCiAoFPtriCMcJJFvFxhcsvoF4V1a0ei9/1kbSkmEJol3j8iCnNrP
         3LPqhzcTkj8XBrUF/qI70xGG0vLMxn5jA5ZtI+6LohUSHDycLqL6Z3nb8WPjIi6yAaYO
         x+RA==
X-Forwarded-Encrypted: i=1; AJvYcCWD7BabxFXN/9s9miuHEAjlLfV8HeP5AJjhsfI6Mcs3QpXgT7oqovpNvWSJ3T/wgF0FKFwU/V8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3RQgpE5NH+CZNlHPj/BpEsz0ZA9kgR1S9QKSkLrpaTSxrogVk
	gL7zkLGHaq/F9bhopcxCxUG6gD2HWagZoZ1VvYeRYanV3z0oD4xpYrBQXoua+UvrTIkn8Wzj6Uc
	58hGNP5CHGUaY6I0jBcntoax7wt5BBl2wmBBAMML6lw==
X-Gm-Gg: ASbGncuHFgpnD8EYP4gd4D3hodrJoWqaArZaugoPr2jT7mxks0HzhhEMbaboDmSTKtg
	u7K00GniNAc1+xoumYRYSWN1eOb8Ke3BAoeor71Npoa9gDnKbBtGwmftsKgN1wi0LhV9V5mlfq6
	tmcBtqqLQCFA6lWXN9Kmz3E3BbRw3irgD7AP/QRtsnHg==
X-Google-Smtp-Source: AGHT+IEPxrA8TD2L6IfW1cY5qKycvAsWAIUA5Qz7I0oB0ABms/qBjWIsY/vPjMMqIY1J5SPhgYoaCK9RPByZmpKz3/w=
X-Received: by 2002:a05:6902:108e:b0:e85:ed6b:4981 with SMTP id
 3f1490d57ef6-e85ed6b4a78mr762494276.23.1750679945405; Mon, 23 Jun 2025
 04:59:05 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Jun 2025 07:59:03 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 23 Jun 2025 07:59:03 -0400
X-Gm-Features: AX0GCFvJgUErwaEUH23cQM4XZ__5ye799h6sIkSMLGGcA4UqQPvLr2X0BGid-U8
Message-ID: <CACo-S-3Taw67OWu80hjL5b5pXf2jUH5FxYgOhy57VThOamhJyQ@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build) call to
 '__compiletime_assert_730' declared with 'error' attribute...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 call to '__compiletime_assert_730' declared with 'error' attribute:
BUILD_BUG_ON failed: NFP_BPF_SCALAR_VALUE != SCALAR_VALUE ||
NFP_BPF_MAP_VALUE != PTR_TO_MAP_VALUE || NFP_BPF_STACK != PTR_TO_STACK
|| NFP_BPF_PACKET_DATA != PTR_TO_PACKET in
drivers/net/ethernet/netronome/nfp/bpf/verifier.o
(drivers/net/ethernet/netronome/nfp/bpf/verifier.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:c9be1e56d1a9e040b3bd8a197186766f617e4e08
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  dd859e40a92ee19d6b87baa7c8278804c20c4781


Log excerpt:
=====================================================
drivers/net/ethernet/netronome/nfp/bpf/verifier.c:234:3: error: call
to '__compiletime_assert_730' declared with 'error' attribute:
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
<scratch space>:2:1: note: expanded from here
    2 | __compiletime_assert_730
      | ^
  CC [M]  drivers/net/wireless/realtek/rtlwifi/efuse.o
1 error generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:685928155c2cf25042d0f643


#kernelci issue maestro:c9be1e56d1a9e040b3bd8a197186766f617e4e08

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

