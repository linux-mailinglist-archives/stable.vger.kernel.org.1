Return-Path: <stable+bounces-192058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26049C29035
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 15:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4BE1188DB2A
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 14:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5AC13957E;
	Sun,  2 Nov 2025 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xu+BAiPY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2DA34D3BD
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762093550; cv=none; b=bFVRJwqXluvIN4DDjuwkGAsEr5CeZN6MuhFDv/Mkr5Z1Vjp/4SecGFp2HrjRCEVcIbsEHyXv1aZD0+sYcnPH/uoGKZH21ZJ2BhyLIxFEhJN49EObLhCSeLTCtSu6YglyxJ6857M9mwrMPxPwrM69jfcbw7va+W4M9pn6xqQ7sUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762093550; c=relaxed/simple;
	bh=+oQBjjta/yq1LbJMtnnjGu1jYP5Xn5GqB2qZjG0OqL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIB/7uUsGALC+dHa0NmnSMD8VhUcwVMZMUeIWugUgDxBuf251bS7slyMIsNiN0Dh8Y3BN12HZbVOy0dSDPqRNOSkMi+i2D8qR2Jcd/ywUqTmuXG2zfElvu58c+yKP5uHvczJ4LzLIE1UF/H15URV+f3Sn4oC27lVIn0eRa3881Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xu+BAiPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3ECC4CEF7;
	Sun,  2 Nov 2025 14:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762093550;
	bh=+oQBjjta/yq1LbJMtnnjGu1jYP5Xn5GqB2qZjG0OqL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xu+BAiPYSiZFod+eWk5OGPf6RJ0kWQX5GKN6ka3HqWlC6LD3FZQwfBFGs8uAvn4Uv
	 D5Fta9b6E6OPxDAp1ITVUNK5n5urrUBajxCGME1h8lIskXEwLqDvuUYDl6L6IzcLIh
	 tUUPQcR9xZmZu+/21l8p/Y+IxDqTcZIu0Bc5tmht+I4ww+eOlx9CId3MjLkXvPcPCc
	 weHPnFPmnr0nrIq6eXpNT5uydHPlu09CoK3k6AVPLB9VXeGErz5TY+GLfbrrCC7rXe
	 ThnYxXuViY66kJfoEBS8M8cJK9/X+BeFCX5nZjgz2GoOYy7bi7o/9mAPJARFrA7rV9
	 CW2PV2Y59RASg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 1/2] PM: hibernate: Combine return paths in power_down()
Date: Sun,  2 Nov 2025 09:25:45 -0500
Message-ID: <20251102142546.3442128-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110200-aflame-kisser-6334@gregkh>
References: <2025110200-aflame-kisser-6334@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 1f5bcfe91ffce71bdd1022648b9d501d46d20c09 ]

To avoid code duplication and improve clarity, combine the code
paths in power_down() leading to a return from that function.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Link: https://patch.msgid.link/3571055.QJadu78ljV@rafael.j.wysocki
[ rjw: Changed the new label name to "exit" ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 35e4a69b2003 ("PM: sleep: Allow pm_restrict_gfp_mask() stacking")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/power/hibernate.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 728328c51b649..14e85ff235512 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -708,21 +708,11 @@ static void power_down(void)
 	if (hibernation_mode == HIBERNATION_SUSPEND) {
 		pm_restore_gfp_mask();
 		error = suspend_devices_and_enter(mem_sleep_current);
-		if (error) {
-			hibernation_mode = hibernation_ops ?
-						HIBERNATION_PLATFORM :
-						HIBERNATION_SHUTDOWN;
-		} else {
-			/* Match pm_restore_gfp_mask() call in hibernate() */
-			pm_restrict_gfp_mask();
-
-			/* Restore swap signature. */
-			error = swsusp_unmark();
-			if (error)
-				pr_err("Swap will be unusable! Try swapon -a.\n");
+		if (!error)
+			goto exit;
 
-			return;
-		}
+		hibernation_mode = hibernation_ops ? HIBERNATION_PLATFORM :
+						     HIBERNATION_SHUTDOWN;
 	}
 #endif
 
@@ -733,12 +723,9 @@ static void power_down(void)
 	case HIBERNATION_PLATFORM:
 		error = hibernation_platform_enter();
 		if (error == -EAGAIN || error == -EBUSY) {
-			/* Match pm_restore_gfp_mask() in hibernate(). */
-			pm_restrict_gfp_mask();
-			swsusp_unmark();
 			events_check_enabled = false;
 			pr_info("Wakeup event detected during hibernation, rolling back.\n");
-			return;
+			goto exit;
 		}
 		fallthrough;
 	case HIBERNATION_SHUTDOWN:
@@ -757,6 +744,15 @@ static void power_down(void)
 	pr_crit("Power down manually\n");
 	while (1)
 		cpu_relax();
+
+exit:
+	/* Match the pm_restore_gfp_mask() call in hibernate(). */
+	pm_restrict_gfp_mask();
+
+	/* Restore swap signature. */
+	error = swsusp_unmark();
+	if (error)
+		pr_err("Swap will be unusable! Try swapon -a.\n");
 }
 
 static int load_image_and_restore(void)
-- 
2.51.0


