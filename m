Return-Path: <stable+bounces-78518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8780998BED6
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB021F22E75
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76241C57A9;
	Tue,  1 Oct 2024 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WC52dXkS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E901BF810
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791377; cv=none; b=N7biFnWiyQFPHgfWirfHDKEnflBgJQppfnOpKNWchdQ+k5Y1H/EPH1Fsckv2Qj2cd+2dD5tlWaNOXeRSNZuXaOZbQkpAeuOPgtWJBtzSSyMQTEL7u7zruEjO5/QV4iN+cyTQG4n5oaFZgcRwOjwy92Gb1Fkoq3fSdlVwSKswca8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791377; c=relaxed/simple;
	bh=UBxbYN8NOZvsV/m2qBxbWa0IY+Pv/AmbK9Dpkik5qRs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ozB0RSQ5ay8uusGUw46Iw60EDVbmkaa7iqc1ZIv1JpD8d/gANB1rljc7Hwtdw7nDsCUCaYdA2yPmPMTKqCsqdzA1UMoKrh7zRWwuklUcQU2J90JLlk43Tp/w0mzvTiAWCw3tbc4pDWx71KnP4tnSoBqILj0z9x5sDtSGjMpFYIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WC52dXkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0412C4CEC7;
	Tue,  1 Oct 2024 14:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727791377;
	bh=UBxbYN8NOZvsV/m2qBxbWa0IY+Pv/AmbK9Dpkik5qRs=;
	h=Subject:To:Cc:From:Date:From;
	b=WC52dXkSNPWpcPlMW5JKKHQEXrVx1MsB0RFVHFtJFKofAqQ69HcOjANjUH7F9uuqu
	 MKKjPjHjVIdQqDujYTlYSmIE9drq6wVqJRyjtgWCWyUmGgPAlS9vu1yWJ6jeY0RmV+
	 RU8UWxu+tbt27Kou92lFHPKBNzISjdhX/tEkOHiE=
Subject: FAILED: patch "[PATCH] cpuidle: riscv-sbi: Use scoped device node handling to fix" failed to apply to 6.1-stable tree
To: krzysztof.kozlowski@linaro.org,anup@brainfault.org,rafael.j.wysocki@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 16:02:54 +0200
Message-ID: <2024100154-maternity-snowfield-cbf4@gregkh>
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
git cherry-pick -x a309320ddbac6b1583224fcb6bacd424bcf8637f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100154-maternity-snowfield-cbf4@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

a309320ddbac ("cpuidle: riscv-sbi: Use scoped device node handling to fix missing of_node_put")
24760e43c6a6 ("cpuidle: Adjust includes to remove of_device.h")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a309320ddbac6b1583224fcb6bacd424bcf8637f Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 20 Aug 2024 11:40:22 +0200
Subject: [PATCH] cpuidle: riscv-sbi: Use scoped device node handling to fix
 missing of_node_put

Two return statements in sbi_cpuidle_dt_init_states() did not drop the
OF node reference count.  Solve the issue and simplify entire error
handling with scoped/cleanup.h.

Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Anup Patel <anup@brainfault.org>
Link: https://patch.msgid.link/20240820094023.61155-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index a6e123dfe394..5bb3401220d2 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) "cpuidle-riscv-sbi: " fmt
 
+#include <linux/cleanup.h>
 #include <linux/cpuhotplug.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
@@ -236,19 +237,16 @@ static int sbi_cpuidle_dt_init_states(struct device *dev,
 {
 	struct sbi_cpuidle_data *data = per_cpu_ptr(&sbi_cpuidle_data, cpu);
 	struct device_node *state_node;
-	struct device_node *cpu_node;
 	u32 *states;
 	int i, ret;
 
-	cpu_node = of_cpu_device_node_get(cpu);
+	struct device_node *cpu_node __free(device_node) = of_cpu_device_node_get(cpu);
 	if (!cpu_node)
 		return -ENODEV;
 
 	states = devm_kcalloc(dev, state_count, sizeof(*states), GFP_KERNEL);
-	if (!states) {
-		ret = -ENOMEM;
-		goto fail;
-	}
+	if (!states)
+		return -ENOMEM;
 
 	/* Parse SBI specific details from state DT nodes */
 	for (i = 1; i < state_count; i++) {
@@ -264,10 +262,8 @@ static int sbi_cpuidle_dt_init_states(struct device *dev,
 
 		pr_debug("sbi-state %#x index %d\n", states[i], i);
 	}
-	if (i != state_count) {
-		ret = -ENODEV;
-		goto fail;
-	}
+	if (i != state_count)
+		return -ENODEV;
 
 	/* Initialize optional data, used for the hierarchical topology. */
 	ret = sbi_dt_cpu_init_topology(drv, data, state_count, cpu);
@@ -277,10 +273,7 @@ static int sbi_cpuidle_dt_init_states(struct device *dev,
 	/* Store states in the per-cpu struct. */
 	data->states = states;
 
-fail:
-	of_node_put(cpu_node);
-
-	return ret;
+	return 0;
 }
 
 static void sbi_cpuidle_deinit_cpu(int cpu)


