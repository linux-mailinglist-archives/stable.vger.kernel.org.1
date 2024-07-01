Return-Path: <stable+bounces-56244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BBA91E24F
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 16:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686F01F26278
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 14:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A0C161337;
	Mon,  1 Jul 2024 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NyJl3qyX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8808C1D
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843837; cv=none; b=Uq7EITLwt09EyozYiaTAOfrXQrG6AOvPv6F+Y88P9eh+6BQ9HNhPsBVjDYSC8f8NvZbICuBQwULrlUkA9kWyRZA7ae7iRvPhPJrAn+CF93lxuM+D8AOqF06iSTzJ30zoe1dRsrc9SoUzFVpfHAhTN/pQ4mpPOidrspZPZizzQ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843837; c=relaxed/simple;
	bh=eAqsaq52aZy7QU4CG9Rh1mzQUpPXIuLLS53jU+/mazU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mbHh4iRf/NiAkkJh2TlwZ+nK/H+rxOueESH8eacbne6L8M2ukmeQBzcATZCtDtKth9yLouBZ3jl473FNwbqJ1KV9Wr+jEiyXe8rO0pUz8h9roP6TkXryb8/CzZdoih0jaMEWGVNMbYjwx42OdOo9bqR2G8FQKNyn5UK2E70VAgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NyJl3qyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F75C116B1;
	Mon,  1 Jul 2024 14:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719843837;
	bh=eAqsaq52aZy7QU4CG9Rh1mzQUpPXIuLLS53jU+/mazU=;
	h=Subject:To:Cc:From:Date:From;
	b=NyJl3qyXaBXSEiwp1SgxBAToIahCMNV8HnMgujO2oeguRkoaMLqDwI5zziXiI88OQ
	 xgIdNGmKF+YPYj/t+XzSFbC7iVV2MSMAIfIPysc7KoYN4nfwCvFaihhImYCHyID9xW
	 taHN0/E1bzDM1/B4MlVCJ4vBmMhes0RSHeNovacQ=
Subject: FAILED: patch "[PATCH] cpu/hotplug: Fix dynstate assignment in" failed to apply to 4.19-stable tree
To: ytcoode@gmail.com,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Jul 2024 16:23:43 +0200
Message-ID: <2024070143-petunia-runaround-2e19@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 932d8476399f622aa0767a4a0a9e78e5341dc0e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070143-petunia-runaround-2e19@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

932d8476399f ("cpu/hotplug: Fix dynstate assignment in __cpuhp_setup_state_cpuslocked()")
11bc021d1fba ("cpu/hotplug: Eliminate all kernel-doc warnings")
33c3736ec888 ("cpu/hotplug: Hide cpu_up/down()")
b99a26593b51 ("cpu/hotplug: Move bringup of secondary CPUs out of smp_init()")
d720f9860439 ("cpu/hotplug: Provide bringup_hibernate_cpu()")
0441a5597c5d ("cpu/hotplug: Create a new function to shutdown nonboot cpus")
93ef1429e556 ("cpu/hotplug: Add new {add,remove}_cpu() functions")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 932d8476399f622aa0767a4a0a9e78e5341dc0e1 Mon Sep 17 00:00:00 2001
From: Yuntao Wang <ytcoode@gmail.com>
Date: Wed, 15 May 2024 21:45:54 +0800
Subject: [PATCH] cpu/hotplug: Fix dynstate assignment in
 __cpuhp_setup_state_cpuslocked()

Commit 4205e4786d0b ("cpu/hotplug: Provide dynamic range for prepare
stage") added a dynamic range for the prepare states, but did not handle
the assignment of the dynstate variable in __cpuhp_setup_state_cpuslocked().

This causes the corresponding startup callback not to be invoked when
calling __cpuhp_setup_state_cpuslocked() with the CPUHP_BP_PREPARE_DYN
parameter, even though it should be.

Currently, the users of __cpuhp_setup_state_cpuslocked(), for one reason or
another, have not triggered this bug.

Fixes: 4205e4786d0b ("cpu/hotplug: Provide dynamic range for prepare stage")
Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240515134554.427071-1-ytcoode@gmail.com

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 563877d6c28b..74cfdb66a9bd 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2446,7 +2446,7 @@ EXPORT_SYMBOL_GPL(__cpuhp_state_add_instance);
  * The caller needs to hold cpus read locked while calling this function.
  * Return:
  *   On success:
- *      Positive state number if @state is CPUHP_AP_ONLINE_DYN;
+ *      Positive state number if @state is CPUHP_AP_ONLINE_DYN or CPUHP_BP_PREPARE_DYN;
  *      0 for all other states
  *   On failure: proper (negative) error code
  */
@@ -2469,7 +2469,7 @@ int __cpuhp_setup_state_cpuslocked(enum cpuhp_state state,
 	ret = cpuhp_store_callbacks(state, name, startup, teardown,
 				    multi_instance);
 
-	dynstate = state == CPUHP_AP_ONLINE_DYN;
+	dynstate = state == CPUHP_AP_ONLINE_DYN || state == CPUHP_BP_PREPARE_DYN;
 	if (ret > 0 && dynstate) {
 		state = ret;
 		ret = 0;
@@ -2500,8 +2500,8 @@ int __cpuhp_setup_state_cpuslocked(enum cpuhp_state state,
 out:
 	mutex_unlock(&cpuhp_state_mutex);
 	/*
-	 * If the requested state is CPUHP_AP_ONLINE_DYN, return the
-	 * dynamically allocated state in case of success.
+	 * If the requested state is CPUHP_AP_ONLINE_DYN or CPUHP_BP_PREPARE_DYN,
+	 * return the dynamically allocated state in case of success.
 	 */
 	if (!ret && dynstate)
 		return state;


