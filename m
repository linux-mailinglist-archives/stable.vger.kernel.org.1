Return-Path: <stable+bounces-36670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E6589C12C
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6312822A3
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAB880022;
	Mon,  8 Apr 2024 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NnQtuTE+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685BD7F465;
	Mon,  8 Apr 2024 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582002; cv=none; b=dJLttpGQ5ZtGGU3nB1k1dMO/bVDfwsr8hffNVhYzOGFiotoLN/BIxgoroXZ7usBzxseN2ZSVAAEhD/Mha76Kl9XfXhpOouiORs76ewFQ6r1ypG2hlCGbX6uKsWgFrj5MWao5MzVGhDqrGSyEzjutKm8X3sDBOgpItk8hKuVVaBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582002; c=relaxed/simple;
	bh=YD5BdHhtkEKWmJZL9dA3yA95O14zqLb5pDXljkO8suQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnmc4WrtFZB40KMkWG6TiEicjLE2mnRSTr2KNjPdO0x8YDjkHwebCv5Zpf65sGS6ZI0OtF8gVGhq0y7r7chH5OrIFx8gGPsxCzeBa3AesS3W+visEb8IZ7qCdB4L1gweY+ZK27iVdeWW/E/+fXpE29/BBX/eXEl11hNbf9iyvOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NnQtuTE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1368C433F1;
	Mon,  8 Apr 2024 13:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712582002;
	bh=YD5BdHhtkEKWmJZL9dA3yA95O14zqLb5pDXljkO8suQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NnQtuTE+IqeSxR7PAtU3WAkVIQWAsgU1Wt3WfzlIfA/vjgOH5rNknZTVT1QVRctH6
	 LUE2RZeWh13K+x9GnFu3llzpI5JQpSWyqgMz/BLp+q52FxMZoxycLTPa0DweTieGMv
	 71Al0FVzWDiGWglrhDcl1JN5qK6IycLGiA0ejSXk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 056/252] x86/CPU/AMD: Add ZenX generations flags
Date: Mon,  8 Apr 2024 14:55:55 +0200
Message-ID: <20240408125308.379814028@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
References: <20240408125306.643546457@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov (AMD) <bp@alien8.de>

[ Upstream commit 30fa92832f405d5ac9f263e99f62445fa3084008 ]

Add X86_FEATURE flags for each Zen generation. They should be used from
now on instead of checking f/m/s.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/r/20231120104152.13740-2-bp@alien8.de
Stable-dep-of: c7b2edd8377b ("perf/x86/amd/core: Update and fix stalled-cycles-* events for Zen 2 and later")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/cpufeatures.h |  5 ++-
 arch/x86/kernel/cpu/amd.c          | 70 +++++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index bd33f6366c80d..1f9db287165ac 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -218,7 +218,7 @@
 #define X86_FEATURE_IBRS		( 7*32+25) /* Indirect Branch Restricted Speculation */
 #define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
-#define X86_FEATURE_ZEN			(7*32+28) /* "" CPU based on Zen microarchitecture */
+#define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU based on Zen microarchitecture */
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
 #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
 #define X86_FEATURE_MSR_IA32_FEAT_CTL	( 7*32+31) /* "" MSR IA32_FEAT_CTL configured */
@@ -312,6 +312,9 @@
 #define X86_FEATURE_SRSO_ALIAS		(11*32+25) /* "" AMD BTB untrain RETs through aliasing */
 #define X86_FEATURE_IBPB_ON_VMEXIT	(11*32+26) /* "" Issue an IBPB only on VMEXIT */
 #define X86_FEATURE_APIC_MSRS_FENCE	(11*32+27) /* "" IA32_TSC_DEADLINE and X2APIC MSRs need fencing */
+#define X86_FEATURE_ZEN2		(11*32+28) /* "" CPU based on Zen2 microarchitecture */
+#define X86_FEATURE_ZEN3		(11*32+29) /* "" CPU based on Zen3 microarchitecture */
+#define X86_FEATURE_ZEN4		(11*32+30) /* "" CPU based on Zen4 microarchitecture */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 031bca974fbf3..5391385707b3f 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -620,6 +620,49 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 	}
 
 	resctrl_cpu_detect(c);
+
+	/* Figure out Zen generations: */
+	switch (c->x86) {
+	case 0x17: {
+		switch (c->x86_model) {
+		case 0x00 ... 0x2f:
+		case 0x50 ... 0x5f:
+			setup_force_cpu_cap(X86_FEATURE_ZEN);
+			break;
+		case 0x30 ... 0x4f:
+		case 0x60 ... 0x7f:
+		case 0x90 ... 0x91:
+		case 0xa0 ... 0xaf:
+			setup_force_cpu_cap(X86_FEATURE_ZEN2);
+			break;
+		default:
+			goto warn;
+		}
+		break;
+	}
+	case 0x19: {
+		switch (c->x86_model) {
+		case 0x00 ... 0x0f:
+		case 0x20 ... 0x5f:
+			setup_force_cpu_cap(X86_FEATURE_ZEN3);
+			break;
+		case 0x10 ... 0x1f:
+		case 0x60 ... 0xaf:
+			setup_force_cpu_cap(X86_FEATURE_ZEN4);
+			break;
+		default:
+			goto warn;
+		}
+		break;
+	}
+	default:
+		break;
+	}
+
+	return;
+
+warn:
+	WARN_ONCE(1, "Family 0x%x, model: 0x%x??\n", c->x86, c->x86_model);
 }
 
 static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
@@ -978,8 +1021,6 @@ void init_spectral_chicken(struct cpuinfo_x86 *c)
 
 static void init_amd_zn(struct cpuinfo_x86 *c)
 {
-	set_cpu_cap(c, X86_FEATURE_ZEN);
-
 #ifdef CONFIG_NUMA
 	node_reclaim_distance = 32;
 #endif
@@ -1042,6 +1083,22 @@ static void zenbleed_check(struct cpuinfo_x86 *c)
 	}
 }
 
+static void init_amd_zen(struct cpuinfo_x86 *c)
+{
+}
+
+static void init_amd_zen2(struct cpuinfo_x86 *c)
+{
+}
+
+static void init_amd_zen3(struct cpuinfo_x86 *c)
+{
+}
+
+static void init_amd_zen4(struct cpuinfo_x86 *c)
+{
+}
+
 static void init_amd(struct cpuinfo_x86 *c)
 {
 	early_init_amd(c);
@@ -1080,6 +1137,15 @@ static void init_amd(struct cpuinfo_x86 *c)
 	case 0x19: init_amd_zn(c); break;
 	}
 
+	if (boot_cpu_has(X86_FEATURE_ZEN))
+		init_amd_zen(c);
+	else if (boot_cpu_has(X86_FEATURE_ZEN2))
+		init_amd_zen2(c);
+	else if (boot_cpu_has(X86_FEATURE_ZEN3))
+		init_amd_zen3(c);
+	else if (boot_cpu_has(X86_FEATURE_ZEN4))
+		init_amd_zen4(c);
+
 	/*
 	 * Enable workaround for FXSAVE leak on CPUs
 	 * without a XSaveErPtr feature
-- 
2.43.0




