Return-Path: <stable+bounces-120170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 340A9A4C892
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 18:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17AA3A2CEC
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5E1279356;
	Mon,  3 Mar 2025 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqF6aKRJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01F0279352;
	Mon,  3 Mar 2025 16:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019553; cv=none; b=FT111Beb7DZAMnDf7gCI/pL3vvY3ITtdxOlwL8s0PlVz2odIfmlJMnsVQ1rWEvVqLDA10HRoabwzffAEjl7l5KfLBqbdtqXMtXdIgPSONiUBp1Q5vS5a/KkOSonmLrcIVS952iSkVoJgsC/fO3NXXdM55X/QOuylbo5luBygjB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019553; c=relaxed/simple;
	bh=QKiB6LLUlEArkf5XKrrTy7lD3zfVRbZMGrRPEWjaESY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I2M45MPtQwTO1N88JAzimoEQEdKmdXgmkHK3PO2X1xsygZy3ljl8aXSoT7eI7lHKpTsqarkDbXzSPwTcFCfjwqi55jYSJPT1XYRXfMPdKQa7m4qwxpowxM+UvmH8hmCHtXoSByLduR8fKk7JqB2LVjC0nNOQGyON7ngVsCrgQv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqF6aKRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711A4C4CED6;
	Mon,  3 Mar 2025 16:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019553;
	bh=QKiB6LLUlEArkf5XKrrTy7lD3zfVRbZMGrRPEWjaESY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oqF6aKRJf71JMcyt4lvrqi0BstXU6SNCGaqk7qL5TIyOkhLeFR1aBLXPlgGecrz4u
	 5a6Sjkdp8nW2snhX7X0Kfr2wvTsYRRRa5t0/Ag+3z8S/2eOCaEbn5ExkSw7ZP+Ww7E
	 Ke7rtT155DdhFGepEprt2Lqlf2nlojO+uohjcgL4PDXP6+CEI6S0XG9uRKJ64fQcaE
	 jieb4s1RLSNVrMPW9C0oBOYJ3o0l1jcWl+AmkVlOElU8DZ2naQupFDwjYBF1QGg4h9
	 KLOJOryV0MqOiZtfjxI6s4/8w/ToWh+V2kVtYAaASEEXtObQo7YfK3uiukTTnfTqrH
	 Vdo3ty/EPK1PA==
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
Subject: [PATCH AUTOSEL 5.4 2/4] x86/irq: Define trace events conditionally
Date: Mon,  3 Mar 2025 11:32:25 -0500
Message-Id: <20250303163228.3764394-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163228.3764394-1-sashal@kernel.org>
References: <20250303163228.3764394-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.290
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
index 7dfd0185767cc..76600d8f69376 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -20,8 +20,10 @@
 #include <asm/hw_irq.h>
 #include <asm/desc.h>
 
+#if defined(CONFIG_X86_LOCAL_APIC) || defined(CONFIG_X86_THERMAL_VECTOR)
 #define CREATE_TRACE_POINTS
 #include <asm/trace/irq_vectors.h>
+#endif
 
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
-- 
2.39.5


