Return-Path: <stable+bounces-16002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D95683E65D
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB921C23768
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FE45B5A1;
	Fri, 26 Jan 2024 23:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1Oah/1H6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0F05B5A4
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310844; cv=none; b=GKNf/wHfAUDsm/JUq9BfQijaZ3GHLj41FmJbmmPD+wAJfk3pZRYxbh92oTGA0/2WH4m0vh0gISoCHM/Y9HnYoVVwP8+66tDvv3u/2Vh5euDRnxep8Y4A6UxKCW89T7DV/itbZJhpM1IjKrqncDiZRR5YKwpzmtNkqgtZ/hR7zG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310844; c=relaxed/simple;
	bh=r+22Bj67DaWYxXTqEt6to3xX2gAQfFbuAYwiuQpIrmw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XNffVdD84YTVY3saDXI7YGsaMqdDrTyTsEZFcFdk4j1WMDmATl+nzvu+kgJtlDWdFBTLcNbxgfBhGbfB+GefQX8IhuyJmSpi9pgnPuNIVNN3bKbZd6nx9M4oAi19uxotDNjQEazrjY40Xg3yvFQKeBW2Y6i6hR/pzdAUl40xpHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1Oah/1H6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBA8C433C7;
	Fri, 26 Jan 2024 23:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706310844;
	bh=r+22Bj67DaWYxXTqEt6to3xX2gAQfFbuAYwiuQpIrmw=;
	h=Subject:To:Cc:From:Date:From;
	b=1Oah/1H6Cp7jJByJ94QOwpEgcA9Aer5i5vVhNXC+FsMHGDCWEpyyCTQ4VLz55vFr5
	 4ECDNdwJqPLTYKxKNNI5SEkO8rGBfyzwdkexWgZgQy63WaGC5qqSu3OO2dv2yPLgCn
	 T5bBTW9Jw0V4j8if5t2TgAM4KMioCrCaREq/Tm1A=
Subject: FAILED: patch "[PATCH] arm64: errata: Add Cortex-A510 speculative unprivileged load" failed to apply to 6.1-stable tree
To: robh@kernel.org,mark.rutland@arm.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 15:14:03 -0800
Message-ID: <2024012602-carbon-unsworn-d737@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f827bcdafa2a2ac21c91e47f587e8d0c76195409
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012602-carbon-unsworn-d737@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

f827bcdafa2a ("arm64: errata: Add Cortex-A510 speculative unprivileged load workaround")
546b7cde9b1d ("arm64: Rename ARM64_WORKAROUND_2966298")
471470bc7052 ("arm64: errata: Add Cortex-A520 speculative unprivileged load workaround")
cce8365fc47b ("arm64: errata: Group all Cortex-A510 errata together")
6df696cd9bc1 ("arm64: errata: Mitigate Ampere1 erratum AC03_CPU_38 at stage-2")
52b603628a2c ("Merge branch kvm-arm64/parallel-access-faults into kvmarm/next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f827bcdafa2a2ac21c91e47f587e8d0c76195409 Mon Sep 17 00:00:00 2001
From: Rob Herring <robh@kernel.org>
Date: Wed, 10 Jan 2024 11:29:21 -0600
Subject: [PATCH] arm64: errata: Add Cortex-A510 speculative unprivileged load
 workaround

Implement the workaround for ARM Cortex-A510 erratum 3117295. On an
affected Cortex-A510 core, a speculatively executed unprivileged load
might leak data from a privileged load via a cache side channel. The
issue only exists for loads within a translation regime with the same
translation (e.g. same ASID and VMID). Therefore, the issue only affects
the return to EL0.

The erratum and workaround are the same as ARM Cortex-A520 erratum
2966298, so reuse the existing workaround.

Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20240110-arm-errata-a510-v1-2-d02bc51aeeee@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index f47f63bcf67c..7acd64c61f50 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -71,6 +71,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #2658417        | ARM64_ERRATUM_2658417       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A510     | #3117295        | ARM64_ERRATUM_3117295       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A520     | #2966298        | ARM64_ERRATUM_2966298       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A53      | #826319         | ARM64_ERRATUM_826319        |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 96f31e235a1a..bfd275249366 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1054,6 +1054,20 @@ config ARM64_ERRATUM_2966298
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_3117295
+	bool "Cortex-A510: 3117295: workaround for speculatively executed unprivileged load"
+	select ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
+	default y
+	help
+	  This option adds the workaround for ARM Cortex-A510 erratum 3117295.
+
+	  On an affected Cortex-A510 core, a speculatively executed unprivileged
+	  load might leak data from a privileged level via a cache side channel.
+
+	  Work around this problem by executing a TLBI before returning to EL0.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index cb5e0622168d..967c7c7a4e7d 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -416,6 +416,19 @@ static struct midr_range broken_aarch32_aes[] = {
 };
 #endif /* CONFIG_ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE */
 
+#ifdef CONFIG_ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
+static const struct midr_range erratum_spec_unpriv_load_list[] = {
+#ifdef CONFIG_ARM64_ERRATUM_3117295
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A510),
+#endif
+#ifdef CONFIG_ARM64_ERRATUM_2966298
+	/* Cortex-A520 r0p0 to r0p1 */
+	MIDR_REV_RANGE(MIDR_CORTEX_A520, 0, 0, 1),
+#endif
+	{},
+};
+#endif
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
 	{
@@ -715,10 +728,10 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #endif
 #ifdef CONFIG_ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
 	{
-		.desc = "ARM erratum 2966298",
+		.desc = "ARM errata 2966298, 3117295",
 		.capability = ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD,
 		/* Cortex-A520 r0p0 - r0p1 */
-		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A520, 0, 0, 1),
+		ERRATA_MIDR_RANGE_LIST(erratum_spec_unpriv_load_list),
 	},
 #endif
 #ifdef CONFIG_AMPERE_ERRATUM_AC03_CPU_38


