Return-Path: <stable+bounces-81429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94539934A7
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A74282EFF
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC2B1DD889;
	Mon,  7 Oct 2024 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qk+DdKcG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E97A1DD86A
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321415; cv=none; b=fuBYpf6qSPXKdtkRxqHIPFH/EeH1MSJbYu4MyX1A4n+a8vItvHCGYpnprze7ffPLOHEzx/P2EuE8jWqYfDS3QLy8Gc2WLsv3H44Rz1b1jEt4/uy4kjGE43P52X97s/2+LlA9kkYAvkgeosQPTinu3hfUg0Y1DQzvdh4PbLncXXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321415; c=relaxed/simple;
	bh=iZjgImHBbOvORjW2ShrTmKvhwJeN1dYngXkQY+7RGds=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Tp8gPNywJeb4LxXPvHHAtVHQGuTAMCn2+AYz3NMi7hDTFz9PEaLH9a/f8oDpSvcdtpXC4VcpoeybTQApmUh8h65k/zTSPK9VH55+oajCRSmUZKQwP0NWN2hSoGMFUHXc5YbeQoWumLAb1s3tIjI34fK437Djp8qsv+mK47ZBbFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qk+DdKcG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC5AC4CEC7;
	Mon,  7 Oct 2024 17:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728321414;
	bh=iZjgImHBbOvORjW2ShrTmKvhwJeN1dYngXkQY+7RGds=;
	h=Subject:To:Cc:From:Date:From;
	b=qk+DdKcGZEpvWlYfx9P01liyxB+uI5nQ2ePIIp5cFJTB+mLMev8nrj7hGMzUgoDjI
	 6b0vMhJMmuHoW2dU3Q5jRQxu3VYyW3uJ3XWeNghWqsDU9Rm7pNfKOG75RtzfvcpAIT
	 UXFM49/rl6tNjfvBvWsdg+zT395XcBJOMlRDKqkM=
Subject: FAILED: patch "[PATCH] ACPI: battery: Fix possible crash when unregistering a" failed to apply to 5.4-stable tree
To: W_Armin@gmx.de,rafael.j.wysocki@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 19:16:30 +0200
Message-ID: <2024100729-scanning-delegator-9af9@gregkh>
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
git cherry-pick -x 76959aff14a0012ad6b984ec7686d163deccdc16
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100729-scanning-delegator-9af9@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

76959aff14a0 ("ACPI: battery: Fix possible crash when unregistering a battery hook")
86309cbed261 ("ACPI: battery: Simplify battery hook locking")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 76959aff14a0012ad6b984ec7686d163deccdc16 Mon Sep 17 00:00:00 2001
From: Armin Wolf <W_Armin@gmx.de>
Date: Tue, 1 Oct 2024 23:28:34 +0200
Subject: [PATCH] ACPI: battery: Fix possible crash when unregistering a
 battery hook

When a battery hook returns an error when adding a new battery, then
the battery hook is automatically unregistered.
However the battery hook provider cannot know that, so it will later
call battery_hook_unregister() on the already unregistered battery
hook, resulting in a crash.

Fix this by using the list head to mark already unregistered battery
hooks as already being unregistered so that they can be ignored by
battery_hook_unregister().

Fixes: fa93854f7a7e ("battery: Add the battery hooking API")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Link: https://patch.msgid.link/20241001212835.341788-3-W_Armin@gmx.de
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index dda59ee5a11e..1c45ff6dbb83 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -715,7 +715,7 @@ static void battery_hook_unregister_unlocked(struct acpi_battery_hook *hook)
 		if (!hook->remove_battery(battery->bat, hook))
 			power_supply_changed(battery->bat);
 	}
-	list_del(&hook->list);
+	list_del_init(&hook->list);
 
 	pr_info("extension unregistered: %s\n", hook->name);
 }
@@ -723,7 +723,14 @@ static void battery_hook_unregister_unlocked(struct acpi_battery_hook *hook)
 void battery_hook_unregister(struct acpi_battery_hook *hook)
 {
 	mutex_lock(&hook_mutex);
-	battery_hook_unregister_unlocked(hook);
+	/*
+	 * Ignore already unregistered battery hooks. This might happen
+	 * if a battery hook was previously unloaded due to an error when
+	 * adding a new battery.
+	 */
+	if (!list_empty(&hook->list))
+		battery_hook_unregister_unlocked(hook);
+
 	mutex_unlock(&hook_mutex);
 }
 EXPORT_SYMBOL_GPL(battery_hook_unregister);
@@ -733,7 +740,6 @@ void battery_hook_register(struct acpi_battery_hook *hook)
 	struct acpi_battery *battery;
 
 	mutex_lock(&hook_mutex);
-	INIT_LIST_HEAD(&hook->list);
 	list_add(&hook->list, &battery_hook_list);
 	/*
 	 * Now that the driver is registered, we need


