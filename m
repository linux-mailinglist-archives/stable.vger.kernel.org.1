Return-Path: <stable+bounces-103594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 998249EF8C6
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36861894FB1
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8357D222D67;
	Thu, 12 Dec 2024 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I5gr61B+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408B9216E2D;
	Thu, 12 Dec 2024 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025036; cv=none; b=ZlkB/UMtc+19QMQqpZeeDgKjUIsBpcxNQlKboG6l3zrr7F0p5EvuuNDd+4hsOb3Ywg8ZeCV5If6Vmeku9J83rlRmTkroqElOy7ip0G/T2d4blBeS191cvgrywKh7YOykAdrkt13aGDb9cIyRKVMF3ayse2OxFLUCMeiCjsgdutI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025036; c=relaxed/simple;
	bh=QpSIIDOt1sudgxpbQP4aWdYTpZfvVeFDvriDbBZvQ4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKqBVz7wfbe+foECh+RbjREO27dviNCjhbmPi3XlJridFfLr/9wo+2QdVCRqfPBNVrIDUOVJpC8rHtw+aN04lNJi9kaYK4V9fqV2xUP/aqSZ4rAF1g7V+CfjUIsas4liy06qvxljnkTzEsS8Gc5dcMIPG9gIMM8oZKLJU6EXaog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I5gr61B+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF81C4CECE;
	Thu, 12 Dec 2024 17:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734025036;
	bh=QpSIIDOt1sudgxpbQP4aWdYTpZfvVeFDvriDbBZvQ4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I5gr61B+QDQEu0FA81F4c7rbRp4oN+cl4wUFUGXyWWGP/gY65u406rhiSplXg+SO4
	 +QMFMSIO0qVbRWqhY5yKmSI7JTtR1548Y2TDJK31PhvqlcqUWOIiVkkIG7jbC1DKot
	 R585jnCpbcO4cYxxnC/Pxpoy0TVflw8+oWQV/q98=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Palmer <daniel@0x0f.com>,
	Finn Thain <fthain@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 034/321] m68k: mvme147: Reinstate early console
Date: Thu, 12 Dec 2024 15:59:12 +0100
Message-ID: <20241212144231.352095931@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144229.291682835@linuxfoundation.org>
References: <20241212144229.291682835@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Palmer <daniel@0x0f.com>

[ Upstream commit 077b33b9e2833ff25050d986178a2c4c4036cbac ]

Commit a38eaa07a0ce ("m68k/mvme147: config.c - Remove unused
functions"), removed the console functionality for the mvme147 instead
of wiring it up to an early console.  Put the console write function
back and wire it up like mvme16x does so it's possible to see Linux boot
on this fine hardware once more.

Fixes: a38eaa07a0ce ("m68k/mvme147: config.c - Remove unused functions")
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Co-developed-by: Finn Thain <fthain@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/a82e8f0068a8722996a0ccfe666abb5e0a5c120d.1730850684.git.fthain@linux-m68k.org
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/m68k/kernel/early_printk.c |  5 ++++-
 arch/m68k/mvme147/config.c      | 30 ++++++++++++++++++++++++++++++
 arch/m68k/mvme147/mvme147.h     |  6 ++++++
 3 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 arch/m68k/mvme147/mvme147.h

diff --git a/arch/m68k/kernel/early_printk.c b/arch/m68k/kernel/early_printk.c
index 3cc944df04f65..f11ef9f1f56fc 100644
--- a/arch/m68k/kernel/early_printk.c
+++ b/arch/m68k/kernel/early_printk.c
@@ -13,6 +13,7 @@
 #include <asm/setup.h>
 
 
+#include "../mvme147/mvme147.h"
 #include "../mvme16x/mvme16x.h"
 
 asmlinkage void __init debug_cons_nputs(const char *s, unsigned n);
@@ -22,7 +23,9 @@ static void __ref debug_cons_write(struct console *c,
 {
 #if !(defined(CONFIG_SUN3) || defined(CONFIG_M68000) || \
       defined(CONFIG_COLDFIRE))
-	if (MACH_IS_MVME16x)
+	if (MACH_IS_MVME147)
+		mvme147_scc_write(c, s, n);
+	else if (MACH_IS_MVME16x)
 		mvme16x_cons_write(c, s, n);
 	else
 		debug_cons_nputs(s, n);
diff --git a/arch/m68k/mvme147/config.c b/arch/m68k/mvme147/config.c
index 245376630c3de..8829ad3d25e0f 100644
--- a/arch/m68k/mvme147/config.c
+++ b/arch/m68k/mvme147/config.c
@@ -36,6 +36,7 @@
 #include <asm/machdep.h>
 #include <asm/mvme147hw.h>
 
+#include "mvme147.h"
 
 static void mvme147_get_model(char *model);
 extern void mvme147_sched_init(irq_handler_t handler);
@@ -189,3 +190,32 @@ int mvme147_hwclk(int op, struct rtc_time *t)
 	}
 	return 0;
 }
+
+static void scc_delay(void)
+{
+	__asm__ __volatile__ ("nop; nop;");
+}
+
+static void scc_write(char ch)
+{
+	do {
+		scc_delay();
+	} while (!(in_8(M147_SCC_A_ADDR) & BIT(2)));
+	scc_delay();
+	out_8(M147_SCC_A_ADDR, 8);
+	scc_delay();
+	out_8(M147_SCC_A_ADDR, ch);
+}
+
+void mvme147_scc_write(struct console *co, const char *str, unsigned int count)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	while (count--)	{
+		if (*str == '\n')
+			scc_write('\r');
+		scc_write(*str++);
+	}
+	local_irq_restore(flags);
+}
diff --git a/arch/m68k/mvme147/mvme147.h b/arch/m68k/mvme147/mvme147.h
new file mode 100644
index 0000000000000..140bc98b0102a
--- /dev/null
+++ b/arch/m68k/mvme147/mvme147.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+struct console;
+
+/* config.c */
+void mvme147_scc_write(struct console *co, const char *str, unsigned int count);
-- 
2.43.0




