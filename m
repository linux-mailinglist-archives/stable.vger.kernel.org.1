Return-Path: <stable+bounces-186075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BD8BE37FA
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E52ED358C26
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C06B3314C5;
	Thu, 16 Oct 2025 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gRY0dsA9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEB63314C3
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619123; cv=none; b=EKBntzdKfvoiP2UjEUGHdpnptSdPyPi2nYeRw7phB/MNktFIUGCVXvAeFeqG36s5QWcTg1ryLY9R1sBoo3dM8/qnp1l+VsT55oyQIsvK6NoIKSxe44LTglznNDcX99KP58YYY5/upwasRhrN1uggbC4xlB1pvjWxQQA8YBeQOSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619123; c=relaxed/simple;
	bh=4shTQhqHJyyuV3Nci2sUcFXgl6qcI8rpoVnMgQQO8BY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=O6exUjOWXVTJJnUlKf+7P0PLKZtS67RLgWKuMSQGgGW15ufCUuaYWa6PgcaoleERxZKhbIj1bnVDBNBTV6laAJiO4W2dVkxH/TQaQxDgYfPGFNLZ5k/qnQ+nnIfaWT4q21yyrvaIhIf+GDkPHUNo6ztfnzYsJC3By3uwsSuoZSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gRY0dsA9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C78C4CEFE;
	Thu, 16 Oct 2025 12:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760619122;
	bh=4shTQhqHJyyuV3Nci2sUcFXgl6qcI8rpoVnMgQQO8BY=;
	h=Subject:To:Cc:From:Date:From;
	b=gRY0dsA9rcS2eecS4S+qHSyVVinA/Y9Ho+kF+xVkCua+1ArC6sFXJvSiVh1cCPD8x
	 DOmsEDbfKtyOXVAeNALNSyyGga34TGBk9912VQysZvINqS8X9ZFZe9WEArDY/2KaPm
	 sdjcHCDo5EW7BNgQAlUUIy2d/YcIZx4DQUByQzUE=
Subject: FAILED: patch "[PATCH] PM: EM: Fix late boot with holes in CPU topology" failed to apply to 6.12-stable tree
To: christian.loehle@arm.com,kenneth.crudup@gmail.com,rafael.j.wysocki@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:51:16 +0200
Message-ID: <2025101616-gigahertz-profane-b22c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1ebe8f7e782523e62cd1fa8237f7afba5d1dae83
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101616-gigahertz-profane-b22c@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1ebe8f7e782523e62cd1fa8237f7afba5d1dae83 Mon Sep 17 00:00:00 2001
From: Christian Loehle <christian.loehle@arm.com>
Date: Sun, 31 Aug 2025 22:43:57 +0100
Subject: [PATCH] PM: EM: Fix late boot with holes in CPU topology

Commit e3f1164fc9ee ("PM: EM: Support late CPUs booting and capacity
adjustment") added a mechanism to handle CPUs that come up late by
retrying when any of the `cpufreq_cpu_get()` call fails.

However, if there are holes in the CPU topology (offline CPUs, e.g.
nosmt), the first missing CPU causes the loop to break, preventing
subsequent online CPUs from being updated.

Instead of aborting on the first missing CPU policy, loop through all
and retry if any were missing.

Fixes: e3f1164fc9ee ("PM: EM: Support late CPUs booting and capacity adjustment")
Suggested-by: Kenneth Crudup <kenneth.crudup@gmail.com>
Reported-by: Kenneth Crudup <kenneth.crudup@gmail.com>
Link: https://lore.kernel.org/linux-pm/40212796-734c-4140-8a85-854f72b8144d@panix.com/
Cc: 6.9+ <stable@vger.kernel.org> # 6.9+
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/20250831214357.2020076-1-christian.loehle@arm.com
[ rjw: Drop the new pr_debug() message which is not very useful ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 8df55397414a..5f17d2e8e954 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -799,7 +799,7 @@ void em_adjust_cpu_capacity(unsigned int cpu)
 static void em_check_capacity_update(void)
 {
 	cpumask_var_t cpu_done_mask;
-	int cpu;
+	int cpu, failed_cpus = 0;
 
 	if (!zalloc_cpumask_var(&cpu_done_mask, GFP_KERNEL)) {
 		pr_warn("no free memory\n");
@@ -817,10 +817,8 @@ static void em_check_capacity_update(void)
 
 		policy = cpufreq_cpu_get(cpu);
 		if (!policy) {
-			pr_debug("Accessing cpu%d policy failed\n", cpu);
-			schedule_delayed_work(&em_update_work,
-					      msecs_to_jiffies(1000));
-			break;
+			failed_cpus++;
+			continue;
 		}
 		cpufreq_cpu_put(policy);
 
@@ -835,6 +833,9 @@ static void em_check_capacity_update(void)
 		em_adjust_new_capacity(cpu, dev, pd);
 	}
 
+	if (failed_cpus)
+		schedule_delayed_work(&em_update_work, msecs_to_jiffies(1000));
+
 	free_cpumask_var(cpu_done_mask);
 }
 


