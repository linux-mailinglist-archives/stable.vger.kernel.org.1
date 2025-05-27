Return-Path: <stable+bounces-147127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90604AC5641
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1531BA70FF
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB7F279782;
	Tue, 27 May 2025 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KQal6Nwy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0DA1E89C;
	Tue, 27 May 2025 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748366372; cv=none; b=EV/oMc6edUw0ALkq52LJJot9KADGWAdSgQpSvw2qj82uUyoC+SHXHwu8vA2d71ebHQ+VZy2FgBVY2OEnu3jkvCCXErHsfwF+bsOKB25FQuL91y6jIQDcuND298yANLRxL0woNNz3yvRLpfyEaCl/Pz4EV/tpCBgp053u9md5qI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748366372; c=relaxed/simple;
	bh=87/iFQuXzZ7dV3eqyc3FsG97m+u5ru0Fcc/Xr03lw4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idzOoJ6Rd+Xj4K3lyCI7uKxWrfJwApcR6GCjvd94enXzdDcaE64Xfa8s6GYPKvDDtEjHGu4wh9KYthizYNNkbhUCBo/iyUuR2Gdp+KEKiwIEMJsSIIO31SI1oj5Yf8HKl4X+mVdmY+tugUEMcA7GdG02UFzzeSUS3I8xARxXhf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KQal6Nwy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83E8C4CEE9;
	Tue, 27 May 2025 17:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748366372;
	bh=87/iFQuXzZ7dV3eqyc3FsG97m+u5ru0Fcc/Xr03lw4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQal6NwyXOVyOVvd2ADa14251DmjO6iqroXJ7OMRuGxqieX7ihBP93tJXnnDXOaNa
	 I++lSXdHdvJJMAGp9Mdc+gHR05PcogHCb+lwAS3fFXAKvJ/L+D4ppXYpdh4a1Y6qP4
	 GkAxX2z/X1ULaWCbmSP/BWAWeEBNCSPQjjNwWFYM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xi Pardee <xi.pardee@intel.com>,
	Todd Brandt <todd.e.brandt@intel.com>,
	"H. Peter Anvin (Intel)" <hpa@zytor.com>,
	"Xin Li (Intel)" <xin@zytor.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Juergen Gross <jgross@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 045/783] x86/fred: Fix system hang during S4 resume with FRED enabled
Date: Tue, 27 May 2025 18:17:22 +0200
Message-ID: <20250527162514.966932947@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Li (Intel) <xin@zytor.com>

[ Upstream commit e5f1e8af9c9e151ecd665f6d2e36fb25fec3b110 ]

Upon a wakeup from S4, the restore kernel starts and initializes the
FRED MSRs as needed from its perspective.  It then loads a hibernation
image, including the image kernel, and attempts to load image pages
directly into their original page frames used before hibernation unless
those frames are currently in use.  Once all pages are moved to their
original locations, it jumps to a "trampoline" page in the image kernel.

At this point, the image kernel takes control, but the FRED MSRs still
contain values set by the restore kernel, which may differ from those
set by the image kernel before hibernation.  Therefore, the image kernel
must ensure the FRED MSRs have the same values as before hibernation.
Since these values depend only on the location of the kernel text and
data, they can be recomputed from scratch.

Reported-by: Xi Pardee <xi.pardee@intel.com>
Reported-by: Todd Brandt <todd.e.brandt@intel.com>
Tested-by: Todd Brandt <todd.e.brandt@intel.com>
Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250401075728.3626147-1-xin@zytor.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/power/cpu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 63230ff8cf4f0..08e76a5ca1553 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -27,6 +27,7 @@
 #include <asm/mmu_context.h>
 #include <asm/cpu_device_id.h>
 #include <asm/microcode.h>
+#include <asm/fred.h>
 
 #ifdef CONFIG_X86_32
 __visible unsigned long saved_context_ebx;
@@ -231,6 +232,19 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	 */
 #ifdef CONFIG_X86_64
 	wrmsrl(MSR_GS_BASE, ctxt->kernelmode_gs_base);
+
+	/*
+	 * Reinitialize FRED to ensure the FRED MSRs contain the same values
+	 * as before hibernation.
+	 *
+	 * Note, the setup of FRED RSPs requires access to percpu data
+	 * structures.  Therefore, FRED reinitialization can only occur after
+	 * the percpu access pointer (i.e., MSR_GS_BASE) is restored.
+	 */
+	if (ctxt->cr4 & X86_CR4_FRED) {
+		cpu_init_fred_exceptions();
+		cpu_init_fred_rsps();
+	}
 #else
 	loadsegment(fs, __KERNEL_PERCPU);
 #endif
-- 
2.39.5




