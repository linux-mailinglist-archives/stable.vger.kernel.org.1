Return-Path: <stable+bounces-192023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35191C28F80
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 14:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D0AD4E3030
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 13:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A695D70824;
	Sun,  2 Nov 2025 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PKwOEm0X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A62A48
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762090563; cv=none; b=Sr3w8/u/kCeHWjkewsiFn8P6Mcs3NaR3QkHrDrKPz43x5fkegEVhXMq5MUPN/bwlQNrfMxahWZNC7l+6qtUtmSqSYDlL9CHdV9VF/xez0q3iePyl9f5fAZryFr/0U5DRCkOmN6OsYDRmVXd8LEeRSyVfU1ig1Dxfuzy22GiZXgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762090563; c=relaxed/simple;
	bh=6KCMGX1Q+bA5CPjO9JQIH8RivC47rOzFybqBwQmG6qY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M7g550UEY4k4NBdXQK+P1flrDjsvN14aECc1GJKqsHtZEfDww/dzhu4FD3ErhQSoJBMJ4GQ0vOOjW831bxmuEu1DgjqjQ4LxzPV2lJfqwM+CWWesrF+l4Bf4E2pRwmi4UBcXyJKXZWl3FpWJEhqSDTDDaFT94HJKZBLpUgS+fH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PKwOEm0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E818C4CEF7;
	Sun,  2 Nov 2025 13:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762090562;
	bh=6KCMGX1Q+bA5CPjO9JQIH8RivC47rOzFybqBwQmG6qY=;
	h=Subject:To:Cc:From:Date:From;
	b=PKwOEm0Xra5n6N05HLm6wh+g0xBKsVVIG2IfD1RgHt8yQQ0WcXYWZTgXEOfW+0tcA
	 hz+FaOQCvDxdJkR64KrucoQMKHtCVUT+NwgDanZKwgFT/tXmnaEvE49zZbeduKTcB7
	 +qK25bKIx5++ulkYmnudAbKg/S9/kfBDZJqFf7G0=
Subject: FAILED: patch "[PATCH] PM: sleep: Allow pm_restrict_gfp_mask() stacking" failed to apply to 6.17-stable tree
To: rafael.j.wysocki@intel.com,safinaskar@gmail.com,stable@vger.kernel.org,superm1@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 02 Nov 2025 22:36:00 +0900
Message-ID: <2025110200-aflame-kisser-6334@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.17-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
git checkout FETCH_HEAD
git cherry-pick -x 35e4a69b2003f20a69e7d19ae96ab1eef1aa8e8d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110200-aflame-kisser-6334@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 35e4a69b2003f20a69e7d19ae96ab1eef1aa8e8d Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Tue, 28 Oct 2025 21:52:31 +0100
Subject: [PATCH] PM: sleep: Allow pm_restrict_gfp_mask() stacking

Allow pm_restrict_gfp_mask() to be called many times in a row to avoid
issues with calling dpm_suspend_start() when the GFP mask has been
already restricted.

Only the first invocation of pm_restrict_gfp_mask() will actually
restrict the GFP mask and the subsequent calls will warn if there is
a mismatch between the expected allowed GFP mask and the actual one.

Moreover, if pm_restrict_gfp_mask() is called many times in a row,
pm_restore_gfp_mask() needs to be called matching number of times in
a row to actually restore the GFP mask.  Calling it when the GFP mask
has not been restricted will cause it to warn.

This is necessary for the GFP mask restriction starting in
hibernation_snapshot() to continue throughout the entire hibernation
flow until it completes or it is aborted (either by a wakeup event or
by an error).

Fixes: 449c9c02537a1 ("PM: hibernate: Restrict GFP mask in hibernation_snapshot()")
Fixes: 469d80a3712c ("PM: hibernate: Fix hybrid-sleep")
Reported-by: Askar Safin <safinaskar@gmail.com>
Closes: https://lore.kernel.org/linux-pm/20251025050812.421905-1-safinaskar@gmail.com/
Link: https://lore.kernel.org/linux-pm/20251028111730.2261404-1-safinaskar@gmail.com/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Tested-by: Mario Limonciello (AMD) <superm1@kernel.org>
Cc: 6.16+ <stable@vger.kernel.org> # 6.16+
Link: https://patch.msgid.link/5935682.DvuYhMxLoT@rafael.j.wysocki

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 14e85ff23551..53166ef86ba4 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -706,7 +706,6 @@ static void power_down(void)
 
 #ifdef CONFIG_SUSPEND
 	if (hibernation_mode == HIBERNATION_SUSPEND) {
-		pm_restore_gfp_mask();
 		error = suspend_devices_and_enter(mem_sleep_current);
 		if (!error)
 			goto exit;
@@ -746,9 +745,6 @@ static void power_down(void)
 		cpu_relax();
 
 exit:
-	/* Match the pm_restore_gfp_mask() call in hibernate(). */
-	pm_restrict_gfp_mask();
-
 	/* Restore swap signature. */
 	error = swsusp_unmark();
 	if (error)
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 3cf2d7e72567..549f51ca3a1e 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -31,23 +31,35 @@
  * held, unless the suspend/hibernate code is guaranteed not to run in parallel
  * with that modification).
  */
+static unsigned int saved_gfp_count;
 static gfp_t saved_gfp_mask;
 
 void pm_restore_gfp_mask(void)
 {
 	WARN_ON(!mutex_is_locked(&system_transition_mutex));
-	if (saved_gfp_mask) {
-		gfp_allowed_mask = saved_gfp_mask;
-		saved_gfp_mask = 0;
-	}
+
+	if (WARN_ON(!saved_gfp_count) || --saved_gfp_count)
+		return;
+
+	gfp_allowed_mask = saved_gfp_mask;
+	saved_gfp_mask = 0;
+
+	pm_pr_dbg("GFP mask restored\n");
 }
 
 void pm_restrict_gfp_mask(void)
 {
 	WARN_ON(!mutex_is_locked(&system_transition_mutex));
-	WARN_ON(saved_gfp_mask);
+
+	if (saved_gfp_count++) {
+		WARN_ON((saved_gfp_mask & ~(__GFP_IO | __GFP_FS)) != gfp_allowed_mask);
+		return;
+	}
+
 	saved_gfp_mask = gfp_allowed_mask;
 	gfp_allowed_mask &= ~(__GFP_IO | __GFP_FS);
+
+	pm_pr_dbg("GFP mask restricted\n");
 }
 
 unsigned int lock_system_sleep(void)


