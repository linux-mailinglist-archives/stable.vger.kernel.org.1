Return-Path: <stable+bounces-40873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279E88AF96A
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5983A1C24B1A
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CB81448ED;
	Tue, 23 Apr 2024 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oQAa8Tco"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055CF14389E;
	Tue, 23 Apr 2024 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908521; cv=none; b=GZJS4KwxXJbySir5Y4Ue8L5mETTl2KJiD5BwVo6CElD33Z0BXSOPVtzFvQiURTqe6gWpXiVRFTo7WlF3mtEJjlAE86HGYjOoSmmfZGEM2nItAexKLQIIV+zkQxIyW1sfowOHUZDX+6pNI/+DK3kDR8SjkcG77XR94IN+1/57iZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908521; c=relaxed/simple;
	bh=mj00SjtXrPKwfq3d8KpnvOBK6pXp02n/jX8bXk1Mma4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/PXtU8u88O4McbMv8uhw3sQp/372pAPSfoFpYephQPWbk6UOqRJvmZwHPHjzDwYhifYyTDOb/3Pe2t1ukVr8ru6AMJAumka4/ssuUylvdmiwjZObJKSf0vGktl4b+eApPiKRAD301zfakAndR6oIvToSSGp94hPp9eCNMRCXGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oQAa8Tco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7D1C3277B;
	Tue, 23 Apr 2024 21:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908520;
	bh=mj00SjtXrPKwfq3d8KpnvOBK6pXp02n/jX8bXk1Mma4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oQAa8TcoeYbRwTK6GlAiaWmACwyFR6/4141OPXAsKMPre/os/1FRjg6uI2Zwo7kLl
	 Y8140MGdAEgxupOEXlai6l2ygqsm2sSKFPJuaAm4gIvmIABiR+MaITk1D4bu7wjAfy
	 2/R4hfJxNm7I5FpiqconeQYBNyRSgQgIici2ZWdc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 085/158] x86/bugs: Fix BHI retpoline check
Date: Tue, 23 Apr 2024 14:38:27 -0700
Message-ID: <20240423213858.707765289@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213855.824778126@linuxfoundation.org>
References: <20240423213855.824778126@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit 69129794d94c544810e68b2b4eaa7e44063f9bf2 ]

Confusingly, X86_FEATURE_RETPOLINE doesn't mean retpolines are enabled,
as it also includes the original "AMD retpoline" which isn't a retpoline
at all.

Also replace cpu_feature_enabled() with boot_cpu_has() because this is
before alternatives are patched and cpu_feature_enabled()'s fallback
path is slower than plain old boot_cpu_has().

Fixes: ec9404e40e8f ("x86/bhi: Add BHI mitigation knob")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/ad3807424a3953f0323c011a643405619f2a4927.1712944776.git.jpoimboe@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index cbc8c88144e47..e7ceee008bd09 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1651,7 +1651,8 @@ static void __init bhi_select_mitigation(void)
 		return;
 
 	/* Retpoline mitigates against BHI unless the CPU has RRSBA behavior */
-	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
+	if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
+	    !boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE)) {
 		spec_ctrl_disable_kernel_rrsba();
 		if (rrsba_disabled)
 			return;
@@ -2803,11 +2804,13 @@ static const char *spectre_bhi_state(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_BHI))
 		return "; BHI: Not affected";
-	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_HW))
+	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_HW))
 		return "; BHI: BHI_DIS_S";
-	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP))
+	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP))
 		return "; BHI: SW loop, KVM: SW loop";
-	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) && rrsba_disabled)
+	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
+		 !boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE) &&
+		 rrsba_disabled)
 		return "; BHI: Retpoline";
 	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT))
 		return "; BHI: Vulnerable, KVM: SW loop";
-- 
2.43.0




