Return-Path: <stable+bounces-120125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BF5A4C810
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D854D7A581C
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF96250C0C;
	Mon,  3 Mar 2025 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fryK8eX5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DA6217707;
	Mon,  3 Mar 2025 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019456; cv=none; b=bBuQz3pQLq5t8HW8P0zodgq2gPkdSMKSjB950eQkptzm7RpFQW+56OrTAjNZWkpnI5kzN8W199xWfs2wgef3OoCvJDpTVYPKL6s2s0vEjz6hPqAV4tau6rtgXRwV0HvA+ajMRQhy+YSAzOOFYLZArIyMM6USIKvLfsrXGUrkQUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019456; c=relaxed/simple;
	bh=Ay/35eyEnivoB/7i3ruOhodKTg7omOLifwrB/+6vLd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YjVRb2jbYFTm6AqAFs2rbp7skAqT2CEN+OoWrzJqtD2PEQNZWUKrKEcF9Nnj6xfpgjmzYdLIKT6Fkqam9l1X1o8LxlQiSF4fN+C4acWoitvI9Pevhuji+XPwhf+sI0Zozb3Y+o+4MrfHcSIEjFHpAIp7yUDnI7jpiwIP2D5GY6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fryK8eX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9B0C4CEEA;
	Mon,  3 Mar 2025 16:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019456;
	bh=Ay/35eyEnivoB/7i3ruOhodKTg7omOLifwrB/+6vLd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fryK8eX5wt1TxNlEV0ikzx9GbLTotZzoFV5CgvZofW6QD8s3QEgqVxdit6evV/NJl
	 US4+7/yEoOG0HKxkk7vldao72lenr+Q26B1HYaDh7dIxYmcEDRAOJsfkks/Xf4OQLM
	 N9pzAYp0n1jp1/kve1w1jGtTDlvgJVDCrPX7ZnNLSnmlgZoMzMowG/8PxPag6tVeZq
	 DGlEjDqxKT3ZdhdX/5lffjBU0ojA/66Bfgejm73wYDTC1K8h+lN8qI06AnbmAsIv4k
	 grZg241MbP2tQEKE2gHLevlE10p2UrKHbTatKBzlc1U+sTY71MWFoPKr3YmGkiKGjx
	 JHtD5Hu+ynmxw==
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
Subject: [PATCH AUTOSEL 6.12 11/17] x86/irq: Define trace events conditionally
Date: Mon,  3 Mar 2025 11:30:23 -0500
Message-Id: <20250303163031.3763651-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163031.3763651-1-sashal@kernel.org>
References: <20250303163031.3763651-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.17
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
index 385e3a5fc3045..feca4f20b06aa 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -25,8 +25,10 @@
 #include <asm/posted_intr.h>
 #include <asm/irq_remapping.h>
 
+#if defined(CONFIG_X86_LOCAL_APIC) || defined(CONFIG_X86_THERMAL_VECTOR)
 #define CREATE_TRACE_POINTS
 #include <asm/trace/irq_vectors.h>
+#endif
 
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
-- 
2.39.5


