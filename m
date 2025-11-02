Return-Path: <stable+bounces-192059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B309EC29038
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 15:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37E6188DA3F
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 14:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA2A7261B;
	Sun,  2 Nov 2025 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZjOXkfR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B6E1F3D56
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762093551; cv=none; b=nDo1071SK4RN3h/yehIG7EHwapIBlX05hjo0PsnVXDT9ztB6AGW0odS3vPHzSUGAd1d20/Bts3j45xDf1tX3/PdW1Thigy8NkU/4ygQk73Oa+ZA/zpvijCwqfUXDxE1aMxu0x12u1j3grVj0Z1K4tC2DLVYcuK4DSJaY+yFePE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762093551; c=relaxed/simple;
	bh=9sR8LSlQXMNHy64ee3MUJ2/ow3fdVoHWOqNeGw8fhVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3TR+7puEb7SwoRpiGvscKqAp9/lPbTGYDfsb0zZYnh7yrNejpIWdLSr3FYQFk3mqVoO9TdqPtOFGOIJxMpnbcW33ZRCARYMQqxin8zpDy6TFoxEKhV59aKsLQJJFX2d5c91Osp9VoLksbC2LNAXGv2LrxpOm3skeQt9TcOW8Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZjOXkfR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567AAC4CEFD;
	Sun,  2 Nov 2025 14:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762093551;
	bh=9sR8LSlQXMNHy64ee3MUJ2/ow3fdVoHWOqNeGw8fhVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MZjOXkfRLM0iCbH46X9ktVQmWfS6mDvEBRbYTTQZhJ+y3cIWqjyhn0Rb0xroT5yn0
	 FDmnbDh1ZdJUmuCeI/1coHjTgeFq4Iqs3VZOETpj6Iiannh+BSV7jLCY5iy5cQ8mbN
	 zQ4UFCiVN1DRiVwAPPjxRf6iIJaF5upVp8Ky0SmzDZWO1QGhuSIxZNqdUSNvhTGrSd
	 wDDkdYSQ01LD3ePw6JHDmSsRxEz3T7Chexj51fuSLGLLf05f/s2ySI8EijD4zAJ0A9
	 kiIkIBPOFUYVxhdSfPIw0Orh91xfe8yoL0LUSFJHPcLfDpyriNuyYuPlnHQkBjhpI5
	 JT+gRifFru9sA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Askar Safin <safinaskar@gmail.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 2/2] PM: sleep: Allow pm_restrict_gfp_mask() stacking
Date: Sun,  2 Nov 2025 09:25:46 -0500
Message-ID: <20251102142546.3442128-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251102142546.3442128-1-sashal@kernel.org>
References: <2025110200-aflame-kisser-6334@gregkh>
 <20251102142546.3442128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 35e4a69b2003f20a69e7d19ae96ab1eef1aa8e8d ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/power/hibernate.c |  4 ----
 kernel/power/main.c      | 22 +++++++++++++++++-----
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 14e85ff235512..53166ef86ba46 100644
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
index 3cf2d7e72567e..549f51ca3a1e6 100644
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
-- 
2.51.0


