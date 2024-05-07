Return-Path: <stable+bounces-43249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420078BF091
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AABE9B2105D
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023EC7C0B7;
	Tue,  7 May 2024 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0i5TACS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B125C134735;
	Tue,  7 May 2024 23:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122805; cv=none; b=cL1NJoRrEb1pQr7+5koo17CjV8hlA10Z6AHdm/TsFv4PX2SpYeTcyXQZGaGPPD2p4aKT1wwbt1PqDbyMABWemawXVnlBf5nTj27veB3nai4l2Og2FoJwwjyYZxPb3d30D4j8fhOsx4NoqrRnKhPejRY5E/HdYo5WwWsBqr3TFhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122805; c=relaxed/simple;
	bh=CftoOuFlniFGqgAyMnAyQDmZGd/aDIrkcRVcyNfegnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0DLYeFBvqkvWdhX3QKWpi2ZtLAyOH4jWYnrJaepB+ssi9sbHWA2vL7lGrjt8sQwNY8WLpC+YIR+sgMEwmGA4nW+sz7m9JVX32Nj1gfC0lgs+3bi2KeYQDGPeFOmrhUWd+9+RcFws1bU5N3dbYp74SR8o5QcWA9i4b0r177Gp+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0i5TACS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986ACC4AF17;
	Tue,  7 May 2024 23:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122805;
	bh=CftoOuFlniFGqgAyMnAyQDmZGd/aDIrkcRVcyNfegnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O0i5TACSELPyLsd3LeCcvbB2c+AsNZO3wYkMJE4i3ZURIJNjbSOZtaJ4EInn2r9GC
	 kZvZzrOFRslKO3cZskGcYxeurNmi3fcxtjY9owOCebucy8IdZ9Ewa3Y6xkJJyoMto7
	 dSBi4L26rBYkcHi9fs0SyRPS1oLkeMzgrfkXqAuIlDMUfUuvSucLC4UNb0ImV2LsQD
	 bSSw3PDvv7ye0qwtM8jNP210u3ktcI5B4Y+VhATFWn7rR0GQXeq1DnsiIEEOmOhb1a
	 pKdPdpg7EqNpGMqhcq309vxRcB4fPucarlxauPxEpL+tdO52MpnJNA0zClF82MQVJa
	 QFQBoIQKQJVcA==
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
Subject: [PATCH AUTOSEL 6.6 15/19] cpu: Ignore "mitigations" kernel parameter if CPU_MITIGATIONS=n
Date: Tue,  7 May 2024 18:58:37 -0400
Message-ID: <20240507225910.390914-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225910.390914-1-sashal@kernel.org>
References: <20240507225910.390914-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
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
index 66dfc348043d6..8d2f9ed3f1076 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3323,6 +3323,9 @@
 			arch-independent options, each of which is an
 			aggregation of existing arch-specific options.
 
+			Note, "mitigations" is supported if and only if the
+			kernel was built with CPU_MITIGATIONS=y.
+
 			off
 				Disable all optional CPU mitigations.  This
 				improves system performance, but it may also
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be9248e5cb71b..82d12c93feabe 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2428,9 +2428,13 @@ menuconfig CPU_MITIGATIONS
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
index e990c180282e7..a7d91a167a8b6 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -214,7 +214,18 @@ void cpuhp_report_idle_dead(void);
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
index 2dd2fd300e916..4f453226fcf48 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3197,6 +3197,7 @@ void __init boot_cpu_hotplug_init(void)
 	this_cpu_write(cpuhp_state.target, CPUHP_ONLINE);
 }
 
+#ifdef CONFIG_CPU_MITIGATIONS
 /*
  * These are used for a global "mitigations=" cmdline option for toggling
  * optional CPU mitigations.
@@ -3207,9 +3208,7 @@ enum cpu_mitigations {
 	CPU_MITIGATIONS_AUTO_NOSMT,
 };
 
-static enum cpu_mitigations cpu_mitigations __ro_after_init =
-	IS_ENABLED(CONFIG_CPU_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
-					     CPU_MITIGATIONS_OFF;
+static enum cpu_mitigations cpu_mitigations __ro_after_init = CPU_MITIGATIONS_AUTO;
 
 static int __init mitigations_parse_cmdline(char *arg)
 {
@@ -3225,7 +3224,6 @@ static int __init mitigations_parse_cmdline(char *arg)
 
 	return 0;
 }
-early_param("mitigations", mitigations_parse_cmdline);
 
 /* mitigations=off */
 bool cpu_mitigations_off(void)
@@ -3240,3 +3238,11 @@ bool cpu_mitigations_auto_nosmt(void)
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


