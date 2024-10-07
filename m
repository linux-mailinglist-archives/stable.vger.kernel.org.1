Return-Path: <stable+bounces-81425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4C09934A1
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3291C2362C
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173AA1DD55F;
	Mon,  7 Oct 2024 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kyrpNaZ7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCFB18D642
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321400; cv=none; b=RWR9vrYB60P76BcQXkrBCX3CXftz61CX9z3HhamCL+ysyGrOqLES0JxrNBCcgHixORcQMe9pBqZYWqb/Spu6umvo2mWO94U7g6bbJBXHYYHyjRH5XaxvkILuLm5wxuPa6o7j0vYr+5ggWGpoEccbw93W2XkJ2FqS0Z/WOpc8rvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321400; c=relaxed/simple;
	bh=r1fjL9wCVUsV4UL6lXjm6hxjbijvIGU+JPjMKa6yxTA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NwgpAG9wL5C0akkxrbOJ6ERfKEnpSmIfmunlOB1tPDbzw2QW7dYBc4uWinzXawhI98vHqcmMgGpjCn1mUixnUh0aPeH/ubshpgBa+GqxemWpiNsjv9i3ZW8DorCkQGnGbZm+fXlcnKAZzy+p9TCXGeTHYv0gKv7Ly2TbbyJhurc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kyrpNaZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FADC4CEC6;
	Mon,  7 Oct 2024 17:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728321400;
	bh=r1fjL9wCVUsV4UL6lXjm6hxjbijvIGU+JPjMKa6yxTA=;
	h=Subject:To:Cc:From:Date:From;
	b=kyrpNaZ7OlMzyDE5cF50U/nseQuLkZ7plu3JIhlQPYk7Zush1ZuoDO+8QCVhS8BzI
	 33KBM9V3CtqRng/nopx6s81NmNFft2GG3njbRgjoIYjHrJFHAaEa72gopgmPR03CCp
	 qoDkLMOapRzoJxyy3B/98eK3jhB4viG7VSCkGnOg=
Subject: FAILED: patch "[PATCH] ACPI: battery: Fix possible crash when unregistering a" failed to apply to 6.6-stable tree
To: W_Armin@gmx.de,rafael.j.wysocki@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 19:16:27 +0200
Message-ID: <2024100726-skeleton-decal-096d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 76959aff14a0012ad6b984ec7686d163deccdc16
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100726-skeleton-decal-096d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


