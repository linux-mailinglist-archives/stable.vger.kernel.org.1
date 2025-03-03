Return-Path: <stable+bounces-120157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D6EA4C84B
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF24F1895C5E
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75CC265CA7;
	Mon,  3 Mar 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFU2cpAa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C64269AEF;
	Mon,  3 Mar 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019526; cv=none; b=LLmXzmmGMqT6YVKoqGSBB+c8loeAJEKrdf8BETyAbWyrE60phWE7V3yDLOGvkHkFVoWNQZQ+c03B2ZK9HxBdPqKaiwT6jG2TgIt3bBF2VAlE8IUcWmiQ90LWzkzoiD3Ty6+SO3lnl4e0lhURgAH9eyNB4YLqSsg4AIJJMObNpV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019526; c=relaxed/simple;
	bh=Gf4L9Kb1Z9un25PwqurLSNnkgPyzqTlm1uCTOa5d+Ps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IN9GmYmikkavTRF8w53wjtmjZDnags0tAwUPEBxSdwb9A/wrT+2ed9U1gQlf4R1KTm9xIyR9gxArgfz4iLv/USXTpuGWZFpr5XzUWEJKxIOg9hWNNvYWDYSpa9lPr7g+AKdEJ0vC+Q2uWl7jrsqVUDncub/Pj6M5687th9eHvHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFU2cpAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4E3C4CEEA;
	Mon,  3 Mar 2025 16:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019525;
	bh=Gf4L9Kb1Z9un25PwqurLSNnkgPyzqTlm1uCTOa5d+Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TFU2cpAawMXBEDLJAyDAtcgO2ak8ZhlzcFnOFnjAFENiCoGNBDaXFE/ke/dLOAoG/
	 ZIEWRexdCOHiMq/jMnQBARagOWWee2HYwzM3NfdP033U8CxLSu5wUNqD+ydeYIP5mG
	 zepnbRyK0Mbu7GFeZVt9X7l+mcFJStI4ZURWWEAfmCETFrcuQdh7iTi5r7k7JnLKd4
	 26ItM/EsDDsHSeqB3nQAqRNwfrfVTWTiBns6wBsEZCH3rfyyByviZD721tfdWD5Qnp
	 sdks7CG+NZhkqLpnX3iCg0eSRXC8+LMxo2O7SYQi/J2/9XcVbd8z/nzlX4Ynlx1MFr
	 F8IbM3GR5xGqg==
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
Subject: [PATCH AUTOSEL 5.15 6/9] x86/irq: Define trace events conditionally
Date: Mon,  3 Mar 2025 11:31:49 -0500
Message-Id: <20250303163152.3764156-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163152.3764156-1-sashal@kernel.org>
References: <20250303163152.3764156-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.178
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
index 766ffe3ba3137..439fdb3f5fdf1 100644
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


