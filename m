Return-Path: <stable+bounces-132647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD26A88888
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 18:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C061898E3A
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 16:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE1727B517;
	Mon, 14 Apr 2025 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1SAxpV7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EBB1F3D54;
	Mon, 14 Apr 2025 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647896; cv=none; b=hyaenA1nLlAFzFvj19rYZU2g6yqSHwSc93EFQ59Ec77jPtslNAJXWFnd7RAb6rJtwiGFWGCL1dzYjeicLVbgjhc+IBlOMhhVBYvUAePedwV47v9KUrHCIiDfqPzagj3zGYC9+L3QfkLIZSsjRKqdtTL40GzRuMFi0c5AbGXRzFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647896; c=relaxed/simple;
	bh=2pybt9whcJe1DTT9ZhBv8dgoA7R0JIG7/tYieKpSONU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O8M9qnR847wjHJ5V99Id3DmULhQSNhI2dc7Ib8RaUywMsu+Fh39sdhinMTrrmQO2yGau2x6upHGj0GI718KTpNeK9aFUXCwx/N7CjJv33izPpWH2CFVqKVWN+9U+6NY7CzdyjzO79/1siKuxNfkViIyVhVcMAG1hZ028tc8Wa50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1SAxpV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0546C4CEE2;
	Mon, 14 Apr 2025 16:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744647895;
	bh=2pybt9whcJe1DTT9ZhBv8dgoA7R0JIG7/tYieKpSONU=;
	h=From:To:Cc:Subject:Date:From;
	b=s1SAxpV7iEXuYLHsO4jnBvGrGgpxZSzmIWm+PAyWjvJI5LpB1LTs1lvttP6lcIBK+
	 BBT/QnGa0EWHVzG8gBMadvdxExyr0AfQGOQlTYG2KisfZC9Zaum4xObFgLAeqvJaKL
	 igcXWGZEqi5XWRoLa/0nZb++0H83g6DlEGXYcuWKVwTEVwppSf2OEp1UuQE1T34zq+
	 XhuIJKUmrTzTkegbnjtaqMRSopIXGWWH2PiQeDHBic3tXZX5oqMG0Qrho+pFDszMoE
	 RKanf2odepeGz28jdhnanLrTtzXkkdo5lI8pwhSeA78PVSyR/AkJWVMV4A0G0YPisi
	 x2Is7+nGSBqzg==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	Shyam-sundar.S-k@amd.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: stable@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86/amd: pmc: Require at least 2.5 seconds between HW sleep cycles
Date: Mon, 14 Apr 2025 11:24:00 -0500
Message-ID: <20250414162446.3853194-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

When an APU exits HW sleep with no active wake sources the Linux kernel will
rapidly assert that the APU can enter back into HW sleep. This happens in a
few ms. Contrasting this to Windows, Windows can take 10s of seconds to
enter back into the resiliency phase for Modern Standby.

For some situations this can be problematic because it can cause leakage
from VDDCR_SOC to VDD_MISC and force VDD_MISC outside of the electrical
design guide specifications. On some designs this will trip the over
voltage protection feature (OVP) of the voltage regulator module, but it
could cause APU damage as well.

To prevent this risk, add an explicit sleep call so that future attempts
to enter into HW sleep will have enough time to settle. This will occur
while the screen is dark and only on cases that the APU should enter HW
sleep again, so it shouldn't be noticeable to any user.

Cc: stable@vger.kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc/pmc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index d789d6cab7948..0329fafe14ebc 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -644,10 +644,9 @@ static void amd_pmc_s2idle_check(void)
 	struct smu_metrics table;
 	int rc;
 
-	/* CZN: Ensure that future s0i3 entry attempts at least 10ms passed */
-	if (pdev->cpu_id == AMD_CPU_ID_CZN && !get_metrics_table(pdev, &table) &&
-	    table.s0i3_last_entry_status)
-		usleep_range(10000, 20000);
+	/* Avoid triggering OVP */
+	if (!get_metrics_table(pdev, &table) && table.s0i3_last_entry_status)
+		msleep(2500);
 
 	/* Dump the IdleMask before we add to the STB */
 	amd_pmc_idlemask_read(pdev, pdev->dev, NULL);
-- 
2.43.0


