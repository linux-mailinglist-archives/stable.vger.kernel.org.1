Return-Path: <stable+bounces-124413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2299BA60C09
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 09:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A5B18966B2
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 08:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B831C863D;
	Fri, 14 Mar 2025 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIsMQEFZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FA418FDDB;
	Fri, 14 Mar 2025 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741942134; cv=none; b=gje7dtR5YboYP5COq1WhcLGSJXB/PrIhrvqZt7t/l/C90K/rEzC9GW8DsjUfbvud271e0RPPncQz7UTMqWSJTn6M4fQuzqThiquwyH1q90Rw0aymMbkgPA2foZHdL6yLQT7ckwM8F8I8GJ4ak3O+FyTmHRoa4fTb8IV6c+avjuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741942134; c=relaxed/simple;
	bh=izFKGd6NIgePdak/hVqrXszrqeizjfGI2wWT42fp3+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iX3u4K7ClMalXZeeF1WYRq+hLYGE3NqrFjfyxgqmZ+m5UHUgCSw0Y89ZwU5eB2DJwAo0rCZuB4JESWqtRQbgC4urjiV6+VR2bGM22om1fnYTmOWtWAUXVk5iG/j1+QTly7rFpKXGEZE/BaxJAmPsEQcwzbG10PX95OIIpHab06U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIsMQEFZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2254e0b4b79so49620985ad.2;
        Fri, 14 Mar 2025 01:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741942132; x=1742546932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToBMldha4NXdM4Yn/DOmK+H4G7j9iFfVU8ytUf5bV8g=;
        b=fIsMQEFZfFqH9vpdFonz2A4aNgM7NflopAisHHVDRuivtHUqhWMg6QxmZHSgAMXSKM
         +ezCZGAvtKYnfYqOaghSylDeEjnOZKPhGaRi+3ac9IPaIFXgpfa1UvMW+7HLniqLy8o2
         3rJiDrgRa3qRsmJRKc1GIpSUB/Rm4CKAQsaIRIsBQ18Xh0CzH8QNvjxWMeqxvheeRcKV
         3oYQVJAo43Sp5AKmLCnmkK2iw+ZKU0RhrEt/c/8a413nj7+dcnOda3M5/UC3su5nR74r
         +17BjuUThrIfC6+2mo3Pm9s7Dg9qy6LnkNqrDG+dTyNtX0ufx97FmLGcei/6pPgf8ipl
         qd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741942132; x=1742546932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToBMldha4NXdM4Yn/DOmK+H4G7j9iFfVU8ytUf5bV8g=;
        b=ekiPW31roY1pZJAxHT9UYxgfUKfGGEHjeXlyEo2FPhI+O63DpuFglFNEAJodghg7MR
         LN0XtzKOflJCIrUcqiexehCbPn/QMKqd/iU3AEYExeTpPfacCOPodVae7/ZjWiXzjOxD
         R3Qayk7+215W1WJEfw4jUJzMlM/3Y+yq1EQI3SmIcfd83PeTtpPf69e0L1X0klX202xS
         jSObPRbMle/L5y3GJgI4R9/iWGJhsWnwtgvY1JbcVqCZm8Q+Ne8qi0u/EOJHC3V3dwBA
         x+DDsW47U5gAJ7cGbv7AkKc7FXxOaqASw8wPKUhL/igAHXX02Z0xjTrhkmmhuYQYlX56
         mnfg==
X-Forwarded-Encrypted: i=1; AJvYcCXJA0f1gbqcYcI86azqEr32tq644FCfl4ecYjeYbZ3FenDyHmw8mAM3MJh/w5UUmsSMp8bKmzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR2jqDehpor/gpTpQ2Nne3XZzv5eNfVjY00H1Ktp8LOri+muKj
	Usa/Xt9pbTsw3xsy7OD1kx7/KoSNr46IBf1D9jly1CTnktVgcao1rsVFVQ==
X-Gm-Gg: ASbGncusvdimbhv+5Gee6opU66A+4nCCikxoSvOw1NeC8qRr6DfRdHWIO5nvlvKGrh1
	3qVWTFSFP1HLSwQDXA02XUYmGcGuc6LZF1y9XUIE4Op9EcqSNbh/w1cjbcZt7nlRInUioJIKfKt
	oz6kU1KBxn/1Vy9sroFaZTF5klCJWiJj832FbvI8mkutNVbJiaYfq8SfkGVHvOHlbDYY6aoUxRi
	kMTK5il/VtOMpZhgjO1Y6NGkPrw+VMCVrswP26CudfMCRXSxdisiRli2AphwgzrYTuz2jFOi5U2
	7ZgVIB/PPaCguO4lxrcCvBXyU4t9G7dzmkG/byjdcQkSqWDHYEHVpv2igMidJgkz3eJOkuY7o/M
	lU7OxvSEys+hr9s315S5FcaAm1f1kjQ==
X-Google-Smtp-Source: AGHT+IHNO30cGGLGuV0WLrMnJ/Sw+C7qW79wTrVUmizif/e7ihpkQc6O9ilMkMKWsarELvo9s7M3+w==
X-Received: by 2002:a05:6a00:2389:b0:736:ab21:8a69 with SMTP id d2e1a72fcca58-7372225a7eamr2482874b3a.0.1741942132421;
        Fri, 14 Mar 2025 01:48:52 -0700 (PDT)
Received: from suda-ws01.. (p1201013-ipoe.ipoe.ocn.ne.jp. [122.26.46.12])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711551245sm2601955b3a.57.2025.03.14.01.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 01:48:52 -0700 (PDT)
From: Akihiro Suda <suda.gitsendemail@gmail.com>
X-Google-Original-From: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	stable@vger.kernel.org,
	suda.kyoto@gmail.com,
	regressions@lists.linux.dev,
	aruna.ramakrishna@oracle.com,
	tglx@linutronix.de,
	Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
Subject: [PATCH] x86/pkeys: Disable PKU when XFEATURE_PKRU is missing
Date: Fri, 14 Mar 2025 17:48:18 +0900
Message-ID: <20250314084818.2826-1-akihiro.suda.cz@hco.ntt.co.jp>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <CAG8fp8S92hXFxMKQtMBkGqk1sWGu7pdHYDowsYbmurt0BGjfww@mail.gmail.com>
References: <CAG8fp8S92hXFxMKQtMBkGqk1sWGu7pdHYDowsYbmurt0BGjfww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even when X86_FEATURE_PKU and X86_FEATURE_OSPKE are available,
XFEATURE_PKRU can be missing.
In such a case, pkeys has to be disabled to avoid hanging up.

  WARNING: CPU: 0 PID: 1 at arch/x86/kernel/fpu/xstate.c:1003 get_xsave_addr_user+0x28/0x40
  (...)
  Call Trace:
   <TASK>
   ? get_xsave_addr_user+0x28/0x40
   ? __warn.cold+0x8e/0xea
   ? get_xsave_addr_user+0x28/0x40
   ? report_bug+0xff/0x140
   ? handle_bug+0x3b/0x70
   ? exc_invalid_op+0x17/0x70
   ? asm_exc_invalid_op+0x1a/0x20
   ? get_xsave_addr_user+0x28/0x40
   copy_fpstate_to_sigframe+0x1be/0x380
   ? __put_user_8+0x11/0x20
   get_sigframe+0xf1/0x280
   x64_setup_rt_frame+0x67/0x2c0
   arch_do_signal_or_restart+0x1b3/0x240
   syscall_exit_to_user_mode+0xb0/0x130
   do_syscall_64+0xab/0x1a0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

This fix is known to be needed on Apple Virtualization.
Tested with macOS 13.5.2 running on MacBook Pro 2020 with
Intel(R) Core(TM) i7-1068NG7 CPU @ 2.30GHz.

Fixes: 70044df250d0 ("x86/pkeys: Update PKRU to enable all pkeys before XSAVE")
Link: https://lore.kernel.org/regressions/CAG8fp8QvH71Wi_y7b7tgFp7knK38rfrF7rRHh-gFKqeS0gxY6Q@mail.gmail.com/T/#u
Link: https://github.com/lima-vm/lima/issues/3334

Signed-off-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
---
 arch/x86/kernel/cpu/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index e9464fe411ac..4c2c268af214 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -517,7 +517,8 @@ static bool pku_disabled;
 static __always_inline void setup_pku(struct cpuinfo_x86 *c)
 {
 	if (c == &boot_cpu_data) {
-		if (pku_disabled || !cpu_feature_enabled(X86_FEATURE_PKU))
+		if (pku_disabled || !cpu_feature_enabled(X86_FEATURE_PKU) ||
+		    !cpu_has_xfeatures(XFEATURE_PKRU, NULL))
 			return;
 		/*
 		 * Setting CR4.PKE will cause the X86_FEATURE_OSPKE cpuid
-- 
2.45.2


