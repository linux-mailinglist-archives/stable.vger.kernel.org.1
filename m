Return-Path: <stable+bounces-59331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C97B1931313
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 13:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EDBF1F22F63
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 11:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9A21891A2;
	Mon, 15 Jul 2024 11:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hP+rxDy9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C361465B8
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 11:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042924; cv=none; b=oiyRveuX4rQmenhT27T8zBz+eit60PTZ8IQq4wgUbNOVMqbqf/NbTVWS6Qzn3jAf2gGExf9Il/LUFU3DVm7LG5t0HeLcU+f5gOZYGN6oS3YEqyZ4e9VKFybbE1tvlkiVmGESOHu0Vs84Sx/A+muAUdzvXTNFiWcASVz4Xp2TSaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042924; c=relaxed/simple;
	bh=itE98nJMROx3WyHL/jQbBpYp2cg+qaXIMGaMEWG+uzo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NkwUM959mcZSj+vzwDXCLvlQCc8Uvrk9tv3Xw2hBldMNKz4yumwzcDVLVTfuDho2692bBhIPeLJFLPdCmrUKUiHnpAwHIQxQNpwE02vw/ltzqmnWNMdJnU3L4h/18+Mijfx4cZi9Obv95HRBGffL6Cep5/ncG9NtWEcrYbrRKNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hP+rxDy9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D93C32782;
	Mon, 15 Jul 2024 11:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721042923;
	bh=itE98nJMROx3WyHL/jQbBpYp2cg+qaXIMGaMEWG+uzo=;
	h=Subject:To:Cc:From:Date:From;
	b=hP+rxDy9mq+T2Oc/V+2NwI+D4UfkYgCnU5imrbCiTDW2G/vUOWNv0N+OUuPdfNKg7
	 ojYUFiY6xg4nCytW+zIlvNyUpwq+iRT+izQUqaAyCK+gvd05AnqTYZOk7spGngvHW0
	 vo454V9vGMjziJ8qJox8PEPLKekSfuFo6E5/sB5A=
Subject: FAILED: patch "[PATCH] ACPI: processor_idle: Fix invalid comparison with insertion" failed to apply to 5.4-stable tree
To: visitorckw@gmail.com,belegdol@gmail.com,rafael.j.wysocki@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jul 2024 13:28:30 +0200
Message-ID: <2024071530-rambling-fable-98ea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 233323f9b9f828cd7cd5145ad811c1990b692542
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024071530-rambling-fable-98ea@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

233323f9b9f8 ("ACPI: processor_idle: Fix invalid comparison with insertion sort for latency")
0e6078c3c673 ("ACPI: processor idle: Use swap() instead of open coding it")
65ea8f2c6e23 ("ACPI: processor idle: Fix up C-state latency if not ordered")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 233323f9b9f828cd7cd5145ad811c1990b692542 Mon Sep 17 00:00:00 2001
From: Kuan-Wei Chiu <visitorckw@gmail.com>
Date: Tue, 2 Jul 2024 04:56:39 +0800
Subject: [PATCH] ACPI: processor_idle: Fix invalid comparison with insertion
 sort for latency

The acpi_cst_latency_cmp() comparison function currently used for
sorting C-state latencies does not satisfy transitivity, causing
incorrect sorting results.

Specifically, if there are two valid acpi_processor_cx elements A and B
and one invalid element C, it may occur that A < B, A = C, and B = C.
Sorting algorithms assume that if A < B and A = C, then C < B, leading
to incorrect ordering.

Given the small size of the array (<=8), we replace the library sort
function with a simple insertion sort that properly ignores invalid
elements and sorts valid ones based on latency. This change ensures
correct ordering of the C-state latencies.

Fixes: 65ea8f2c6e23 ("ACPI: processor idle: Fix up C-state latency if not ordered")
Reported-by: Julian Sikorski <belegdol@gmail.com>
Closes: https://lore.kernel.org/lkml/70674dc7-5586-4183-8953-8095567e73df@gmail.com
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Tested-by: Julian Sikorski <belegdol@gmail.com>
Cc: All applicable <stable@vger.kernel.org>
Link: https://patch.msgid.link/20240701205639.117194-1-visitorckw@gmail.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index bd6a7857ce05..831fa4a12159 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -16,7 +16,6 @@
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/sched.h>       /* need_resched() */
-#include <linux/sort.h>
 #include <linux/tick.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu.h>
@@ -386,25 +385,24 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
 	acpi_write_bit_register(ACPI_BITREG_BUS_MASTER_RLD, 1);
 }
 
-static int acpi_cst_latency_cmp(const void *a, const void *b)
+static void acpi_cst_latency_sort(struct acpi_processor_cx *states, size_t length)
 {
-	const struct acpi_processor_cx *x = a, *y = b;
+	int i, j, k;
 
-	if (!(x->valid && y->valid))
-		return 0;
-	if (x->latency > y->latency)
-		return 1;
-	if (x->latency < y->latency)
-		return -1;
-	return 0;
-}
-static void acpi_cst_latency_swap(void *a, void *b, int n)
-{
-	struct acpi_processor_cx *x = a, *y = b;
+	for (i = 1; i < length; i++) {
+		if (!states[i].valid)
+			continue;
 
-	if (!(x->valid && y->valid))
-		return;
-	swap(x->latency, y->latency);
+		for (j = i - 1, k = i; j >= 0; j--) {
+			if (!states[j].valid)
+				continue;
+
+			if (states[j].latency > states[k].latency)
+				swap(states[j].latency, states[k].latency);
+
+			k = j;
+		}
+	}
 }
 
 static int acpi_processor_power_verify(struct acpi_processor *pr)
@@ -449,10 +447,7 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
 
 	if (buggy_latency) {
 		pr_notice("FW issue: working around C-state latencies out of order\n");
-		sort(&pr->power.states[1], max_cstate,
-		     sizeof(struct acpi_processor_cx),
-		     acpi_cst_latency_cmp,
-		     acpi_cst_latency_swap);
+		acpi_cst_latency_sort(&pr->power.states[1], max_cstate);
 	}
 
 	lapic_timer_propagate_broadcast(pr);


