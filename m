Return-Path: <stable+bounces-108218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F14A098D6
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 18:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B3B3A901A
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 17:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F0B211A06;
	Fri, 10 Jan 2025 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bOObtiLH"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013BE19ABCE;
	Fri, 10 Jan 2025 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736531252; cv=none; b=EG03fhV1I/7syuK30t/taBiZ+lh/ZEQ4GGaFpsj415syJ7V6AHOXGg04ugniHD3ljT+3Mp/9IDrqGqIFi5o7kHPKkwxhmSa5qByBC5YBddrt2SgBjKxVPipG40zOWj0Wtaf6ZDiuymTZTSNEhrLCUla8omOsMDum0rj1axRz9PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736531252; c=relaxed/simple;
	bh=LjAbepbJVzDrU+WVTFonPKqM6HTceeVXq8kjeEJaIxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MMzf8vMVcmLBECBqF/1c/3dMvFk52syykpmwNEEUPEjHncsS+oeT1QzycMKCmIzgz91NuNpFcrLeuq9pMR0cZccmBeflny0YetyoYYVWEez5xxlSLTp/xC+SZushYLJZdqOjCD5EZA8EjmG45OtpkpW+A1loPvTl4l+QBfswHoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=bOObtiLH; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 50AHkdKd1250845
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 10 Jan 2025 09:46:43 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 50AHkdKd1250845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024121701; t=1736531204;
	bh=Jevol05xzykbJGcy4k2i9hf8jt+kjRPWaG1xxof37lU=;
	h=From:To:Cc:Subject:Date:From;
	b=bOObtiLH1uD0gMeXIqryhwXRk/zICyq2i2kl8mA0WEIAzPHDmJQH4AM8zJqRwUbkc
	 iQ4sirg+F4NFYSEsdoLQ/9Mj2+dHQ+3/nt8fA2h5KC30+eOIAmeVDmEBXWVu7JbXMW
	 Lv2H3At7xUFGql5OqmZ9YLUq9P2P6AXlKZMHWGcgP5QQwptGEgWg4NpJUiT2d7QJQF
	 3Ukh2xQP2nIOsU6nWzqXXRSVSQ9kP/nkkuK3ajcpmWQa5CkCiDwfRqB6O8t6FzrDij
	 jdYbK1tPHNbf5vsjWOPkvnCkl10EScGSpMNslyUIpeH/f2hxsW5AgZGXvvsXpxoSF1
	 HANBmhFkonGPQ==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        andrew.cooper3@citrix.com
Subject: [PATCH v2 1/1] x86/fred: Fix the FRED RSP0 MSR out of sync with its per-CPU cache
Date: Fri, 10 Jan 2025 09:46:39 -0800
Message-ID: <20250110174639.1250829-1-xin@zytor.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FRED RSP0 MSR is only used for delivering events when running
userspace.  Linux leverages this property to reduce expensive MSR
writes and optimize context switches.  The kernel only writes the
MSR when about to run userspace *and* when the MSR has actually
changed since the last time userspace ran.

This optimization is implemented by maintaining a per-CPU cache of
FRED RSP0 and then checking that against the value for the top of
current task stack before running userspace.

However cpu_init_fred_exceptions() writes the MSR without updating
the per-CPU cache.  This means that the kernel might return to
userspace with MSR_IA32_FRED_RSP0==0 when it needed to point to the
top of current task stack.  This would induce a double fault (#DF),
which is bad.

A context switch after cpu_init_fred_exceptions() can paper over
the issue since it updates the cached value.  That evidently
happens most of the time explaining how this bug got through.

Fix the bug through resynchronizing the FRED RSP0 MSR with its
per-CPU cache in cpu_init_fred_exceptions().

Fixes: fe85ee391966 ("x86/entry: Set FRED RSP0 on return to userspace instead of context switch")
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/fred.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fred.c b/arch/x86/kernel/fred.c
index 8d32c3f48abc..5e2cd1004980 100644
--- a/arch/x86/kernel/fred.c
+++ b/arch/x86/kernel/fred.c
@@ -50,7 +50,13 @@ void cpu_init_fred_exceptions(void)
 	       FRED_CONFIG_ENTRYPOINT(asm_fred_entrypoint_user));
 
 	wrmsrl(MSR_IA32_FRED_STKLVLS, 0);
-	wrmsrl(MSR_IA32_FRED_RSP0, 0);
+
+	/*
+	 * Ater a CPU offline/online cycle, the FRED RSP0 MSR should be
+	 * resynchronized with its per-CPU cache.
+	 */
+	wrmsrl(MSR_IA32_FRED_RSP0, __this_cpu_read(fred_rsp0));
+
 	wrmsrl(MSR_IA32_FRED_RSP1, 0);
 	wrmsrl(MSR_IA32_FRED_RSP2, 0);
 	wrmsrl(MSR_IA32_FRED_RSP3, 0);

base-commit: 59011effc84d7b167f4b6542bd05c7aff1b7574a
-- 
2.47.1


