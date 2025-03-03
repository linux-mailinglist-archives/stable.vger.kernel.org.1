Return-Path: <stable+bounces-120138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29343A4C80D
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC641660FA
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271DA25FA0A;
	Mon,  3 Mar 2025 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OihDpf3L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D999025FA01;
	Mon,  3 Mar 2025 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019484; cv=none; b=YPUrOsyKOL2q4OzlR2v1t27334592+8C7jkCD3aRGpCgLOIHpDCPXIUJLcFgWyB819MxbT2QRduu9edoQ5BIPG/Awn8mSU7D1vdkkqwaOzmQGjGes2M8d6/Hug32eOSww58T8lwUY0wnPcnGuc0Vf+8oSNpR9wFa/pIlE/KG+2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019484; c=relaxed/simple;
	bh=OvxI80eDQq4QrcWM6Vu0sKdb8azeLmF5CheMPPqK1x0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CPqt6+RHRh2X6ubPUHpYgpKSCHxE3R6G7frKjhtuQ9xr/58argoVViUaAgHMHqT6nvLZTzyq/jriOndQWj1RL+d541Gl5ropAkO3u9UXsOP94GejJ3XWyec7JD7rOqvu2eht0MRBCuPFJzIAAQ5g+MkDytwT6bUJ8QHxZEzvhVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OihDpf3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8204FC4CED6;
	Mon,  3 Mar 2025 16:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019484;
	bh=OvxI80eDQq4QrcWM6Vu0sKdb8azeLmF5CheMPPqK1x0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OihDpf3LhGW2mCrPd3q7B2WLZs/UkYy79m1w0VqxbKo5jsEQ/oTmGvlCZMQ4R7pbH
	 aoSlM47QNt69Is78SWYiTevIQ9PwVGEnmiaWinbacdwzU0an9w1XQoUL/SDwzJD05v
	 JvQXF+FnhhIL9XplSnZi87G7azkM+j4Z18szubws/PaG6SjtzsntrNgg7TYvjbNEnG
	 fO9OUV2gTRZFt1gluF4AstcjPVpwMbm78sRcreOfEImFNHAe1CkQcNnTfDYtb2vd+2
	 WtCYZGeNiFVXSUfySyM2GllLK8seQuFz3TKNV5Uc+7IM+apDNAl2eZfJPi7Dexl54+
	 onArIvWJU+okQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	jacob.jun.pan@linux.intel.com
Subject: [PATCH AUTOSEL 6.6 07/11] x86/irq: Define trace events conditionally
Date: Mon,  3 Mar 2025 11:31:05 -0500
Message-Id: <20250303163109.3763880-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163109.3763880-1-sashal@kernel.org>
References: <20250303163109.3763880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.80
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 9de7695925d5d2d2085681ba935857246eb2817d ]

When both of X86_LOCAL_APIC and X86_THERMAL_VECTOR are disabled,
the irq tracing produces a W=1 build warning for the tracing
definitions:

  In file included from include/trace/trace_events.h:27,
                 from include/trace/define_trace.h:113,
                 from arch/x86/include/asm/trace/irq_vectors.h:383,
                 from arch/x86/kernel/irq.c:29:
  include/trace/stages/init.h:2:23: error: 'str__irq_vectors__trace_system_name' defined but not used [-Werror=unused-const-variable=]

Make the tracepoints conditional on the same symbosl that guard
their usage.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250225213236.3141752-1-arnd@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/irq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 11761c1245453..6573678c4bf4b 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -23,8 +23,10 @@
 #include <asm/traps.h>
 #include <asm/thermal.h>
 
+#if defined(CONFIG_X86_LOCAL_APIC) || defined(CONFIG_X86_THERMAL_VECTOR)
 #define CREATE_TRACE_POINTS
 #include <asm/trace/irq_vectors.h>
+#endif
 
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
-- 
2.39.5


