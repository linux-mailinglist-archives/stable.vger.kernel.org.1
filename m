Return-Path: <stable+bounces-120108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D44CA4C75E
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C96F3A4F5A
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B47230BF1;
	Mon,  3 Mar 2025 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fmm3vb0K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502C7230BDB;
	Mon,  3 Mar 2025 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019416; cv=none; b=Vrr7gxeFcRVGLlpgsa8fiKfLBJemfNSzYiwAZxy2mV0O2W8ChY3OPAS38o1UOuu+Do3me3BpgWF6b8sWNEBgvlrs8X3rzqgNi4XYnkzQ/FXO0fsMsBMI3Sd+OHTGIdEsABsyXDGWjwJcfbhSFh5S7NcR2aZoyQ6O4lQPpNfLWLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019416; c=relaxed/simple;
	bh=Ay/35eyEnivoB/7i3ruOhodKTg7omOLifwrB/+6vLd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tSO17V7gTvadz8BAjyldO1b3ISyJtjxR/tPGVivK/vZHhGMVZAosLAf5va+cnVpJyinfDt9uHuM/1OUUf9PRwsS/OoTyRqMTzSuoLjBBnCfHw0vzFteBzc8X/74LmUUbPr+LZGS1LYzFBf3lgAlnA2me4vSqQbnLxu1Jmfa2j5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fmm3vb0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DA0C4CEE6;
	Mon,  3 Mar 2025 16:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019416;
	bh=Ay/35eyEnivoB/7i3ruOhodKTg7omOLifwrB/+6vLd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fmm3vb0K39fOllcdmrH0jHeAmd5OKgh7jhxSdqqYsJ+bZ374Iu+cOXcxmxKO05bRm
	 R8Hi+OT+ybnBbUVeYRttlbPbFzRTHTi0HToj7JkUT+wPBpOisrYWOgxaueatD/O4XW
	 29PYc3FszhpIc5UtO3UnKoBkIQCqVZcnY31ZXlewAp0cPbwXpxZswKJegA+ZAujWt8
	 bsCDgtBu8q+I222ySU497SLsGNkt6R43kTO7Kwgk+EB/SSJC+VbPTVcNaui3N9gCTk
	 HVaRxe2KnRlUhzzb9SUqZ8toX3Fq58spZ1zXP8sk8XWg9ohHKcVLxiYphYs2SOVhga
	 kKxE5v7fChWSA==
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
Subject: [PATCH AUTOSEL 6.13 11/17] x86/irq: Define trace events conditionally
Date: Mon,  3 Mar 2025 11:29:43 -0500
Message-Id: <20250303162951.3763346-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303162951.3763346-1-sashal@kernel.org>
References: <20250303162951.3763346-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.5
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


