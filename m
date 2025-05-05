Return-Path: <stable+bounces-140192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF51AAA5F5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B5917E1F3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8FD31CA50;
	Mon,  5 May 2025 22:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8lttG8p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CA031CA4B;
	Mon,  5 May 2025 22:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484308; cv=none; b=ufBcG5nF8UATcKLIXi/kQWavrP/hP/wK+2E8epYe0Gmc1t8S9j5KeVo2s6BXtfdJ3yk4pyd52iDn1SxhZ9LxozVBuT5GIies8YzYgpU+E7Ok8vh5WBIP11ADKDM+sfYg1clZpRZrloAx/bfWQtwKmvMVM6zte4H1zq57S+t6KRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484308; c=relaxed/simple;
	bh=MqjhplFZaDPteVIP+B5ZT8pn4nN4B99lZevRAF32rok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sZiEuu7VegcOv8H5lBVjITzufXv/8H4EaYPDErsPYETj0yXGqeLe8bj1pCaGbOuL1KcGDTM9CzgWnNsSUrRziaZP8qwksR3yNW9xJVn8+aM+XBwy/2bcLnBOWDUiwoEdxvwATRH4wS+V5ezMhM8AXrwI2DG7ytZvsQs0JK6AujU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8lttG8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E72CC4CEE4;
	Mon,  5 May 2025 22:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484308;
	bh=MqjhplFZaDPteVIP+B5ZT8pn4nN4B99lZevRAF32rok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k8lttG8pq90RSAcThLgz/O3PqVSzaejw6ie4eADP3EGvFkUOynALW2cRq0Cz/fA0S
	 YcxYUl2zmDQy2eBvtqdBqsWZWX5GyMTHakt7bI1xg/H+ysh5P31wG+eFsMew+KYDcv
	 4aLCdlpNr9r3cY5bCyFswePwoGVPWmlyURQMuIsw65lCeILsEfU6wdM22xBOGhRzbA
	 nQnyaXBWGW+RG+BFmTNLFMTMh8SxWLB5mk0K14xGQCBuO5wkIhKANVNRbBKg3l4DqP
	 iQzN/DqCcA9lmYvrnI2yVTcG+QhjN1CpMTlTl4AeXsgvCNJ3SO4nRZWBKLfkKju/+p
	 iR7joOUijn34Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	jpoimboe@kernel.org,
	gautham.shenoy@amd.com,
	patryk.wlazlyn@linux.intel.com,
	brgerst@gmail.com,
	kprateek.nayak@amd.com,
	sohil.mehta@intel.com
Subject: [PATCH AUTOSEL 6.14 445/642] x86/boot: Mark start_secondary() with __noendbr
Date: Mon,  5 May 2025 18:11:01 -0400
Message-Id: <20250505221419.2672473-445-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 93f16a1ab78ca56e3cd997d1ea54c214774781ac ]

The handoff between the boot stubs and start_secondary() are before IBT is
enabled and is definitely not subject to kCFI. As such, suppress all that for
this function.

Notably when the ENDBR poison would become fatal (ud1 instead of nop) this will
trigger a tripple fault because we haven't set up the IDT to handle #UD yet.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lore.kernel.org/r/20250207122546.509520369@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/smpboot.c | 3 ++-
 include/linux/objtool.h   | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 3d5069ee297bf..463634b138bbb 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -229,7 +229,7 @@ static void ap_calibrate_delay(void)
 /*
  * Activate a secondary processor.
  */
-static void notrace start_secondary(void *unused)
+static void notrace __noendbr start_secondary(void *unused)
 {
 	/*
 	 * Don't put *anything* except direct CPU state initialization
@@ -314,6 +314,7 @@ static void notrace start_secondary(void *unused)
 	wmb();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
+ANNOTATE_NOENDBR_SYM(start_secondary);
 
 /*
  * The bootstrap kernel entry code has set these up. Save them for
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index c722a921165ba..3ca965a2ddc80 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -128,7 +128,7 @@
 #define UNWIND_HINT(type, sp_reg, sp_offset, signal) "\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
 #define STACK_FRAME_NON_STANDARD_FP(func)
-#define __ASM_ANNOTATE(label, type)
+#define __ASM_ANNOTATE(label, type) ""
 #define ASM_ANNOTATE(type)
 #else
 .macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 signal=0
@@ -147,6 +147,8 @@
  * these relocations will never be used for indirect calls.
  */
 #define ANNOTATE_NOENDBR		ASM_ANNOTATE(ANNOTYPE_NOENDBR)
+#define ANNOTATE_NOENDBR_SYM(sym)	asm(__ASM_ANNOTATE(sym, ANNOTYPE_NOENDBR))
+
 /*
  * This should be used immediately before an indirect jump/call. It tells
  * objtool the subsequent indirect jump/call is vouched safe for retpoline
-- 
2.39.5


