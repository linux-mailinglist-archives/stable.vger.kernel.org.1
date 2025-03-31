Return-Path: <stable+bounces-127068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8B8A76825
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 16:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC48188CBA4
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6EA218E96;
	Mon, 31 Mar 2025 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoH+6cMZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29C42185B1;
	Mon, 31 Mar 2025 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431667; cv=none; b=XjgPRBMqIDTSXdownlt3u9M9IRXyZEUL0XesswsCNnHhDgreC1H1AePECu475aVbu0EbKHN9qUQFJ8i4G/OnSwb+7V1rktpls39o2kux8HZAtpJtATFz+GNZdqlHoSbshIf4WRt6SoMJj3EsL0hK4SPfviZ/BJfGEqw49iWJ8iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431667; c=relaxed/simple;
	bh=DIQizwHmfCEk4AJXRdolmNYd1M44sWCcLNHDmneyAT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pDBNy5sUvHe4IW+vdEwXdM18gpcxqZZgyN7ooDgyrzPrQCm25q8CvHkI39JyRuICISW9U805rgUscp+6BiwMZp/iEzriiZI1Qk2kGdAIHDnTfQ+X0WZSpuIxPXLAwqBRPzveOgdkTCAg1mx3FY4FGQu3Qyg+18Z8Mo0NFHios+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoH+6cMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02D3C4CEE4;
	Mon, 31 Mar 2025 14:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431666;
	bh=DIQizwHmfCEk4AJXRdolmNYd1M44sWCcLNHDmneyAT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AoH+6cMZV/E7xF5SOGVpISm9bUb43RmHyW58fmwjiNv83ArRppjC2/TGXuWJRLMyz
	 OM0sVQ6UgEKT8VQSKsx82RR2utlhusXj3AcQK7v1rNP16kLJxe6usV+TpvZcBpZs+T
	 eFu8EdK9t3AI46h8V8cUUaEFiLXsTuKguLM+u095oBEti/o3g6RM6W/EYYTMMmASfi
	 zNqqdOKpZdRctmieeJM8O/pZ8TuGwtaE8xvUkLM4RrOhrQBm4ZDO4RqjCU4N1c0hXb
	 Bh8YaRkYZuanQfwdhB/00ut4G7NXQid+NYNMO+1Dkx111GaqDPKnwyiQo3auO1lID3
	 0xdJmTXHQ87bQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Xin Li (Intel)" <xin@zytor.com>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Subject: [PATCH AUTOSEL 6.14 06/18] x86/ia32: Leave NULL selector values 0~3 unchanged
Date: Mon, 31 Mar 2025 10:33:56 -0400
Message-Id: <20250331143409.1682789-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143409.1682789-1-sashal@kernel.org>
References: <20250331143409.1682789-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: "Xin Li (Intel)" <xin@zytor.com>

[ Upstream commit ad546940b5991d3e141238cd80a6d1894b767184 ]

The first GDT descriptor is reserved as 'NULL descriptor'.  As bits 0
and 1 of a segment selector, i.e., the RPL bits, are NOT used to index
GDT, selector values 0~3 all point to the NULL descriptor, thus values
0, 1, 2 and 3 are all valid NULL selector values.

When a NULL selector value is to be loaded into a segment register,
reload_segments() sets its RPL bits.  Later IRET zeros ES, FS, GS, and
DS segment registers if any of them is found to have any nonzero NULL
selector value.  The two operations offset each other to actually effect
a nop.

Besides, zeroing of RPL in NULL selector values is an information leak
in pre-FRED systems as userspace can spot any interrupt/exception by
loading a nonzero NULL selector, and waiting for it to become zero.
But there is nothing software can do to prevent it before FRED.

ERETU, the only legit instruction to return to userspace from kernel
under FRED, by design does NOT zero any segment register to avoid this
problem behavior.

As such, leave NULL selector values 0~3 unchanged and close the leak.

Do the same on 32-bit kernel as well.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241126184529.1607334-1-xin@zytor.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/signal_32.c | 62 +++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index ef654530bf5a9..98123ff10506c 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -33,25 +33,55 @@
 #include <asm/smap.h>
 #include <asm/gsseg.h>
 
+/*
+ * The first GDT descriptor is reserved as 'NULL descriptor'.  As bits 0
+ * and 1 of a segment selector, i.e., the RPL bits, are NOT used to index
+ * GDT, selector values 0~3 all point to the NULL descriptor, thus values
+ * 0, 1, 2 and 3 are all valid NULL selector values.
+ *
+ * However IRET zeros ES, FS, GS, and DS segment registers if any of them
+ * is found to have any nonzero NULL selector value, which can be used by
+ * userspace in pre-FRED systems to spot any interrupt/exception by loading
+ * a nonzero NULL selector and waiting for it to become zero.  Before FRED
+ * there was nothing software could do to prevent such an information leak.
+ *
+ * ERETU, the only legit instruction to return to userspace from kernel
+ * under FRED, by design does NOT zero any segment register to avoid this
+ * problem behavior.
+ *
+ * As such, leave NULL selector values 0~3 unchanged.
+ */
+static inline u16 fixup_rpl(u16 sel)
+{
+	return sel <= 3 ? sel : sel | 3;
+}
+
 #ifdef CONFIG_IA32_EMULATION
 #include <asm/unistd_32_ia32.h>
 
 static inline void reload_segments(struct sigcontext_32 *sc)
 {
-	unsigned int cur;
+	u16 cur;
 
+	/*
+	 * Reload fs and gs if they have changed in the signal
+	 * handler.  This does not handle long fs/gs base changes in
+	 * the handler, but does not clobber them at least in the
+	 * normal case.
+	 */
 	savesegment(gs, cur);
-	if ((sc->gs | 0x03) != cur)
-		load_gs_index(sc->gs | 0x03);
+	if (fixup_rpl(sc->gs) != cur)
+		load_gs_index(fixup_rpl(sc->gs));
 	savesegment(fs, cur);
-	if ((sc->fs | 0x03) != cur)
-		loadsegment(fs, sc->fs | 0x03);
+	if (fixup_rpl(sc->fs) != cur)
+		loadsegment(fs, fixup_rpl(sc->fs));
+
 	savesegment(ds, cur);
-	if ((sc->ds | 0x03) != cur)
-		loadsegment(ds, sc->ds | 0x03);
+	if (fixup_rpl(sc->ds) != cur)
+		loadsegment(ds, fixup_rpl(sc->ds));
 	savesegment(es, cur);
-	if ((sc->es | 0x03) != cur)
-		loadsegment(es, sc->es | 0x03);
+	if (fixup_rpl(sc->es) != cur)
+		loadsegment(es, fixup_rpl(sc->es));
 }
 
 #define sigset32_t			compat_sigset_t
@@ -105,18 +135,12 @@ static bool ia32_restore_sigcontext(struct pt_regs *regs,
 	regs->orig_ax = -1;
 
 #ifdef CONFIG_IA32_EMULATION
-	/*
-	 * Reload fs and gs if they have changed in the signal
-	 * handler.  This does not handle long fs/gs base changes in
-	 * the handler, but does not clobber them at least in the
-	 * normal case.
-	 */
 	reload_segments(&sc);
 #else
-	loadsegment(gs, sc.gs);
-	regs->fs = sc.fs;
-	regs->es = sc.es;
-	regs->ds = sc.ds;
+	loadsegment(gs, fixup_rpl(sc.gs));
+	regs->fs = fixup_rpl(sc.fs);
+	regs->es = fixup_rpl(sc.es);
+	regs->ds = fixup_rpl(sc.ds);
 #endif
 
 	return fpu__restore_sig(compat_ptr(sc.fpstate), 1);
-- 
2.39.5


