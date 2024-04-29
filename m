Return-Path: <stable+bounces-41676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7390B8B5728
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED4E28700C
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311A24D5AC;
	Mon, 29 Apr 2024 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oMmtwxYO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7597611D
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714391566; cv=none; b=toN4ERAOQhbfpba8tM5kZh5nrVkYaK15H0wUluPCbZyg+Xg7REncvFBikZlvwS+yZw2gJlKSWrdzpJIfVyHRv+ysYBi256NJKc96mHGJIOrMM1tKqFTAanh6WyhDvzdtgAov+1KTT9L1uCfFAOU7n0lszUj48NCo4c33/qgaFyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714391566; c=relaxed/simple;
	bh=CTLoXYCU9ER3hIxs0I3Qx9Mq6D0WZQbuegzYgsdETEE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jOzjypELUI3dMuJAw/0Q7pPfGclgR9GIZWpWKoFOS6nCOMZ9dN2AocfHcjpPNdj6PJrd49gWLzEQdrLbKfkXMGE6P4+mq+XiTvnT2SZWK4mTYPoorksJOVty4kDj8B0I3TYhaahkUY3uC9vZLhcPmPiXL9BMKUq3njrjPRHaafg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oMmtwxYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7D7C4AF19;
	Mon, 29 Apr 2024 11:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714391565;
	bh=CTLoXYCU9ER3hIxs0I3Qx9Mq6D0WZQbuegzYgsdETEE=;
	h=Subject:To:Cc:From:Date:From;
	b=oMmtwxYO/WWPmkRdK+SjMJ1x7c3djhY7eU6SLPYT6aAtpoex0mCMTr5vK0eyArmgz
	 ud4NbClUqDRKh98qAosbpEHkU4wA/m0kcXAHk8fwQB/H2CdtNgBbMUrPYJ1LUPzMO4
	 tVJPVZGxHG9N959DqqilLcbUN3WLpa11VKYfdm8k=
Subject: FAILED: patch "[PATCH] ACPI: CPPC: Fix bit_offset shift in MASK_VAL() macro" failed to apply to 5.15-stable tree
To: jarredwhite@linux.microsoft.com,rafael.j.wysocki@intel.com,stable@vger.kernel.org,vanshikonda@os.amperecomputing.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 13:52:42 +0200
Message-ID: <2024042941-fleshed-collide-d77b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 05d92ee782eeb7b939bdd0189e6efcab9195bf95
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042941-fleshed-collide-d77b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

05d92ee782ee ("ACPI: CPPC: Fix bit_offset shift in MASK_VAL() macro")
2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
0651ab90e4ad ("ACPI: CPPC: Check _OSC for flexible address space")
c42fa24b4475 ("ACPI: bus: Avoid using CPPC if not supported by firmware")
2ca8e6285250 ("Revert "ACPI: Pass the same capabilities to the _OSC regardless of the query flag"")
f684b1075128 ("ACPI: CPPC: Drop redundant local variable from cpc_read()")
5f51c7ce1dc3 ("ACPI: CPPC: Fix up I/O port access in cpc_read()")
a2c8f92bea5f ("ACPI: CPPC: Implement support for SystemIO registers")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 05d92ee782eeb7b939bdd0189e6efcab9195bf95 Mon Sep 17 00:00:00 2001
From: Jarred White <jarredwhite@linux.microsoft.com>
Date: Mon, 8 Apr 2024 22:23:09 -0700
Subject: [PATCH] ACPI: CPPC: Fix bit_offset shift in MASK_VAL() macro

Commit 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for
system memory accesses") neglected to properly wrap the bit_offset shift
when it comes to applying the mask. This may cause incorrect values to be
read and may cause the cpufreq module not be loaded.

[   11.059751] cpu_capacity: CPU0 missing/invalid highest performance.
[   11.066005] cpu_capacity: partial information: fallback to 1024 for all CPUs

Also, corrected the bitmask generation in GENMASK (extra bit being added).

Fixes: 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
Signed-off-by: Jarred White <jarredwhite@linux.microsoft.com>
Cc: 5.15+ <stable@vger.kernel.org> # 5.15+
Reviewed-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 4bfbe55553f4..00a30ca35e78 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -170,8 +170,8 @@ show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
 #define GET_BIT_WIDTH(reg) ((reg)->access_width ? (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
 
 /* Shift and apply the mask for CPC reads/writes */
-#define MASK_VAL(reg, val) ((val) >> ((reg)->bit_offset & 			\
-					GENMASK(((reg)->bit_width), 0)))
+#define MASK_VAL(reg, val) (((val) >> (reg)->bit_offset) & 			\
+					GENMASK(((reg)->bit_width) - 1, 0))
 
 static ssize_t show_feedback_ctrs(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)


