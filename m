Return-Path: <stable+bounces-140458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D0AAAA8EE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED5F16D206
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E05356E7F;
	Mon,  5 May 2025 22:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtMlgndr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB66356E6A;
	Mon,  5 May 2025 22:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484907; cv=none; b=HFg15e9jBkUdayYqjhdCZim/rUXTejgRH1A/2b1Dq3aFrCs4VDNOvipYZVoBhcEatgfdOijbTqWTuVt5foLaRmo/n2I/88wHGrZi0kwOAmztU1mlpQQj4Amv7FzkYrdqryLSd1ahDpDXOk80c91Npbr9VzYRlcNJklEyez8mbQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484907; c=relaxed/simple;
	bh=SAzwkYzHl0qogUYngMoD0kKBz8blmKMBm3R/a5OsOGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BIpAOHAqXCy0lNaGPAjdm1FEDWbLI/TPHcASbBcnZS30XeZggoIut1XUbDRjHOFBgPj04QB/h51p2Kg5ib1o+QGIy4vmIx/ngjThd+utH2T5zKGv0oetMIWnJRHj7bqzE+7TD4/OsY6th7h9MdcbPKARLbtTT38djXIUkNmIhvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtMlgndr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566FEC4CEEF;
	Mon,  5 May 2025 22:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484907;
	bh=SAzwkYzHl0qogUYngMoD0kKBz8blmKMBm3R/a5OsOGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HtMlgndrVsiVk1p4giCfDvj9QCPxB0krmisW2h9/HrXiI1di2DJKZz/F/zaQWIIKr
	 FUp4+/TXl3nzrz6I7Z+op25QG/w87yLpbzIE5Az2A0BxvpT19MVN+N/LkpH0mZ1X1V
	 81rQ8NDww6yM3o76Iz97Fk6aymETAN3EqcDO/DT5n/+PUecUijLcRU05Iq85TIdbnJ
	 KK8lAbgdzNZcc9CjTX9nQdicC+3le1iI3yS2d4YQ4vvictOKGoZ9vIiRVgBo2fBm9s
	 YcWaQx3BkSl2awqLLTDH/o6An5JChisKLUpv+I+cJDdRHd537Q41ba+WC4ctUri1SJ
	 wLJ/e8+0qERag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sohil Mehta <sohil.mehta@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de
Subject: [PATCH AUTOSEL 6.12 068/486] x86/microcode: Update the Intel processor flag scan check
Date: Mon,  5 May 2025 18:32:24 -0400
Message-Id: <20250505223922.2682012-68-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Sohil Mehta <sohil.mehta@intel.com>

[ Upstream commit 7e6b0a2e4152f4046af95eeb46f8b4f9b2a7398d ]

The Family model check to read the processor flag MSR is misleading and
potentially incorrect. It doesn't consider Family while comparing the
model number. The original check did have a Family number but it got
lost/moved during refactoring.

intel_collect_cpu_info() is called through multiple paths such as early
initialization, CPU hotplug as well as IFS image load. Some of these
flows would be error prone due to the ambiguous check.

Correct the processor flag scan check to use a Family number and update
it to a VFM based one to make it more readable.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20250219184133.816753-4-sohil.mehta@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/intel-family.h   | 1 +
 arch/x86/kernel/cpu/microcode/intel.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 62d8b9448dc5c..c6198fbcc1d77 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -46,6 +46,7 @@
 #define INTEL_ANY			IFM(X86_FAMILY_ANY, X86_MODEL_ANY)
 
 #define INTEL_PENTIUM_PRO		IFM(6, 0x01)
+#define INTEL_PENTIUM_III_DESCHUTES	IFM(6, 0x05)
 
 #define INTEL_CORE_YONAH		IFM(6, 0x0E)
 
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 815fa67356a2d..cf635414ca6ab 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -74,7 +74,7 @@ void intel_collect_cpu_info(struct cpu_signature *sig)
 	sig->pf = 0;
 	sig->rev = intel_get_microcode_revision();
 
-	if (x86_model(sig->sig) >= 5 || x86_family(sig->sig) > 6) {
+	if (IFM(x86_family(sig->sig), x86_model(sig->sig)) >= INTEL_PENTIUM_III_DESCHUTES) {
 		unsigned int val[2];
 
 		/* get processor flags from MSR 0x17 */
-- 
2.39.5


