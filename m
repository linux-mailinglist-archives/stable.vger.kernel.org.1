Return-Path: <stable+bounces-43227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1608BF055
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADC85B232AE
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ED212BF24;
	Tue,  7 May 2024 22:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UG5Yg7fN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C57A8060D;
	Tue,  7 May 2024 22:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122705; cv=none; b=Y7rLTIBI/NbfHbZD47qnHWlXMmQKEwReF+Ueu63tDnmH5esQGRbp5YAX2fs6dCt9gU2MJQ8KHKWK4a/p4Y8epUJjNPvYKlJDNRCBwpfOICoXouBIU3Z2SVMJdfQQN0V4JOxxtIdXszlhODgIiSvVClmBAa4b5L3Qhgw0xmNvmNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122705; c=relaxed/simple;
	bh=GV9fGJP89g5AslJ5zfrMFPFR094Dgndsw4GvTjbyES4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REtoUVZ5/dX89jUC6DoyJ0ds1hboxIpAvoJe0cc+JAX2zfeGyHniPNR+zJZDUzZj8K3/x6rXSUSt1zrGaCliSvvsStgzGTUoDy0BqdiGrtnBCzGGbL9YP8ONWNsNsFj41viV7YurwLU8QwwDqUDxOapoEC614t3r+RuJVdFRFL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UG5Yg7fN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547ABC3277B;
	Tue,  7 May 2024 22:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122705;
	bh=GV9fGJP89g5AslJ5zfrMFPFR094Dgndsw4GvTjbyES4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UG5Yg7fNvlo/bcL5RLmMY5mQJe/HsD6ZyhYpBMO2UTPxERqUgXONX32ZnR2u1mZ8T
	 nQg163OOMRaGHHSGSP/CKCaCYaZQ0sLMug21AZd6Mxu/Ara24NGoCBxmTDfZXcd0gK
	 HRu2SF4LGQvnEKOQ/LvAJ9zwKztRp+tgaNDr0XNQ3iRM7KdyoWy4Fdl0KSoFfvsiBH
	 ZASZk7GPvMjSYcb/BiPNgufAXq01scQqeT81Xck5HgFwdSKy/yWVBLng4RplT+MZen
	 AeOUNaf+idpvz4GCpKMhrZDsxls9KN/+XJTlWCE9fcMIUorGhxsuOpMP2dxtjlmW6Q
	 kFfZ5G0373MkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>,
	corbet@lwn.net,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	peterz@infradead.org,
	paulmck@kernel.org,
	jpoimboe@kernel.org,
	tj@kernel.org,
	xiongwei.song@windriver.com,
	linux-doc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 17/23] cpu: Ignore "mitigations" kernel parameter if CPU_MITIGATIONS=n
Date: Tue,  7 May 2024 18:56:43 -0400
Message-ID: <20240507225725.390306-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225725.390306-1-sashal@kernel.org>
References: <20240507225725.390306-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit ce0abef6a1d540acef85068e0e82bdf1fbeeb0e9 ]

Explicitly disallow enabling mitigations at runtime for kernels that were
built with CONFIG_CPU_MITIGATIONS=n, as some architectures may omit code
entirely if mitigations are disabled at compile time.

E.g. on x86, a large pile of Kconfigs are buried behind CPU_MITIGATIONS,
and trying to provide sane behavior for retroactively enabling mitigations
is extremely difficult, bordering on impossible.  E.g. page table isolation
and call depth tracking require build-time support, BHI mitigations will
still be off without additional kernel parameters, etc.

  [ bp: Touchups. ]

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240420000556.2645001-3-seanjc@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 arch/x86/Kconfig                                |  8 ++++++--
 include/linux/cpu.h                             | 11 +++++++++++
 kernel/cpu.c                                    | 14 ++++++++++----
 4 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31fdaf4fe9dd8..9bfc972af2403 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3399,6 +3399,9 @@
 			arch-independent options, each of which is an
 			aggregation of existing arch-specific options.
 
+			Note, "mitigations" is supported if and only if the
+			kernel was built with CPU_MITIGATIONS=y.
+
 			off
 				Disable all optional CPU mitigations.  This
 				improves system performance, but it may also
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6f49999a6b838..bfccf1213871b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2474,9 +2474,13 @@ menuconfig CPU_MITIGATIONS
 	help
 	  Say Y here to enable options which enable mitigations for hardware
 	  vulnerabilities (usually related to speculative execution).
+	  Mitigations can be disabled or restricted to SMT systems at runtime
+	  via the "mitigations" kernel parameter.
 
-	  If you say N, all mitigations will be disabled. You really
-	  should know what you are doing to say so.
+	  If you say N, all mitigations will be disabled.  This CANNOT be
+	  overridden at runtime.
+
+	  Say 'Y', unless you really know what you are doing.
 
 if CPU_MITIGATIONS
 
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 8654714421a0d..75f0344bd3b94 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -219,7 +219,18 @@ void cpuhp_report_idle_dead(void);
 static inline void cpuhp_report_idle_dead(void) { }
 #endif /* #ifdef CONFIG_HOTPLUG_CPU */
 
+#ifdef CONFIG_CPU_MITIGATIONS
 extern bool cpu_mitigations_off(void);
 extern bool cpu_mitigations_auto_nosmt(void);
+#else
+static inline bool cpu_mitigations_off(void)
+{
+	return true;
+}
+static inline bool cpu_mitigations_auto_nosmt(void)
+{
+	return false;
+}
+#endif
 
 #endif /* _LINUX_CPU_H_ */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index f8a0406ce8ba5..bac70ea54e349 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3196,6 +3196,7 @@ void __init boot_cpu_hotplug_init(void)
 	this_cpu_write(cpuhp_state.target, CPUHP_ONLINE);
 }
 
+#ifdef CONFIG_CPU_MITIGATIONS
 /*
  * These are used for a global "mitigations=" cmdline option for toggling
  * optional CPU mitigations.
@@ -3206,9 +3207,7 @@ enum cpu_mitigations {
 	CPU_MITIGATIONS_AUTO_NOSMT,
 };
 
-static enum cpu_mitigations cpu_mitigations __ro_after_init =
-	IS_ENABLED(CONFIG_CPU_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
-					     CPU_MITIGATIONS_OFF;
+static enum cpu_mitigations cpu_mitigations __ro_after_init = CPU_MITIGATIONS_AUTO;
 
 static int __init mitigations_parse_cmdline(char *arg)
 {
@@ -3224,7 +3223,6 @@ static int __init mitigations_parse_cmdline(char *arg)
 
 	return 0;
 }
-early_param("mitigations", mitigations_parse_cmdline);
 
 /* mitigations=off */
 bool cpu_mitigations_off(void)
@@ -3239,3 +3237,11 @@ bool cpu_mitigations_auto_nosmt(void)
 	return cpu_mitigations == CPU_MITIGATIONS_AUTO_NOSMT;
 }
 EXPORT_SYMBOL_GPL(cpu_mitigations_auto_nosmt);
+#else
+static int __init mitigations_parse_cmdline(char *arg)
+{
+	pr_crit("Kernel compiled without mitigations, ignoring 'mitigations'; system may still be vulnerable\n");
+	return 0;
+}
+#endif
+early_param("mitigations", mitigations_parse_cmdline);
-- 
2.43.0


