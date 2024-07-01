Return-Path: <stable+bounces-56242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5188591E24D
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 16:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063201F26200
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 14:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8B9160887;
	Mon,  1 Jul 2024 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uFVSnvkQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96B58C1D
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843825; cv=none; b=uNQJTxi0QpNSYnGQy/bhKqmRcC9cGVbKU8Q3ecssMjSaP8FYd4tSe2Arek5uH+uBoFx/nQzkcKc5icjSg+ZCo1U9KZanWAJtISPvYZjfAkOTJ9BXPJZbFjsq53M3TDw/1i5c6xdIuyLWoukfWHSj2G3ae4oGv+XPawkfB/MjULE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843825; c=relaxed/simple;
	bh=atsC9T3qnZnZzhkjMOYaimvHMST1yuc3+Pf2Ohbb8zU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HUpE1kI+fih1/UJAGcNIK2R5bhFdjbZ/VDaq3l9Z5Wi32T+Jski+er0RAq56sT9X6ILmoqH0FXLfG7b1MJecn75vwymytnjz8GETZtR3r5q5loQH9qJFuD23EDezyG4HlHy+ZTvF0SxoUj/dssSURhZKNNGxQ2xHjpgcZxzcvAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uFVSnvkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53B0C116B1;
	Mon,  1 Jul 2024 14:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719843825;
	bh=atsC9T3qnZnZzhkjMOYaimvHMST1yuc3+Pf2Ohbb8zU=;
	h=Subject:To:Cc:From:Date:From;
	b=uFVSnvkQNH4pDT6MMfY2mgrCU7hZMYKTAq2asHIRCRsKVJjfKwdEqciELu2eHDJM8
	 2kmZNhuax2TQqnMm5L9FpMoiz0EDL8PorVXaHkCdsTIaJsp1xxbpOeBuOpOvrNt3Fv
	 EA9MK5W8r3z0aaXQY7zFwtFxhdHd+Zlxg60esBS8=
Subject: FAILED: patch "[PATCH] cpu/hotplug: Fix dynstate assignment in" failed to apply to 5.10-stable tree
To: ytcoode@gmail.com,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Jul 2024 16:23:42 +0200
Message-ID: <2024070141-platinum-unpaired-2fe6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 932d8476399f622aa0767a4a0a9e78e5341dc0e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070141-platinum-unpaired-2fe6@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

932d8476399f ("cpu/hotplug: Fix dynstate assignment in __cpuhp_setup_state_cpuslocked()")
11bc021d1fba ("cpu/hotplug: Eliminate all kernel-doc warnings")

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


