Return-Path: <stable+bounces-43501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA6A8C106F
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 15:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F148DB23ACE
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 13:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A611527A3;
	Thu,  9 May 2024 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujzz7B1i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBA814A62A;
	Thu,  9 May 2024 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715261643; cv=none; b=WjCgWYCPILHoTdgOSHYEJTRgf+eVJZJRolgRqbizb4b7CDFfX57pmQbozfBKAtTNyDhVlhaKU9eTk72O4d6ZcEy33Zdu0BQLALrkC6DE5asDQfDQ3VnFilAEV+IRVSR+ZOnGh2mvYJO8X23zYc0KvM5BOGYS/btBSIc9uPIlFqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715261643; c=relaxed/simple;
	bh=2+YHYFlsCfhJDdkXDf1ER0vd6Y27waqfJtG7Kf2YXBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AYtAMeiHSjg4S/ma0novLnBr0z3ySryHjYe9db2ujrixAX/TJjsW8yPtt1AcX0L2M41v9PB6BtR52NinY8va7nVkjdw4yrtNuWAvPg5rjweZlr8MOED4dvIiyS/vhqfkzzLNDuqhxbvtyKIDzWCpDDGvKWGnYcoyKvIjuqB+k9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujzz7B1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F104C116B1;
	Thu,  9 May 2024 13:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715261643;
	bh=2+YHYFlsCfhJDdkXDf1ER0vd6Y27waqfJtG7Kf2YXBo=;
	h=From:To:Cc:Subject:Date:From;
	b=ujzz7B1i+33eE8tAYa7zkh51+XgGAs/n39T/ILyKsvJwAIofrrPBIaQHDjrFROHOc
	 tnYWwWBeVd56IS9J06SiiOSuaAwPc+HKff8RXp07BmRkYBeXxMMYwYWaPLWge8R6BO
	 Tp/xDL0EFFPMRXT1TSEUwu9OZG5+0/lMeb/ZdoW6yCzcIfmLatL+rTNcURF7DhcdQT
	 ADvte6L8om6PgP5bP6t8N3w4CB6AOXA9JfqEpM9UzGm4Xway828Zj7zQMNU7gJpj2E
	 NPFfkVilMGvrKU92Cgooqjmutj/WizB/SFBrKTYI33YytbAz8vk5zUZ5z1AxXEdCKG
	 OnUzgndFe/eVg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1s53uR-000000002Ko-0fMi;
	Thu, 09 May 2024 15:34:07 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] regulator: core: fix debugfs creation regression
Date: Thu,  9 May 2024 15:33:04 +0200
Message-ID: <20240509133304.8883-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

regulator_get() may sometimes be called more than once for the same
consumer device, something which before commit dbe954d8f163 ("regulator:
core: Avoid debugfs: Directory ...  already present! error") resulted in
errors being logged.

A couple of recent commits broke the handling of such cases so that
attributes are now erroneously created in the debugfs root directory the
second time a regulator is requested and the log is filled with errors
like:

	debugfs: File 'uA_load' in directory '/' already present!
	debugfs: File 'min_uV' in directory '/' already present!
	debugfs: File 'max_uV' in directory '/' already present!
	debugfs: File 'constraint_flags' in directory '/' already present!

on any further calls.

Fixes: 2715bb11cfff ("regulator: core: Fix more error checking for debugfs_create_dir()")
Fixes: 08880713ceec ("regulator: core: Streamline debugfs operations")
Cc: stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/regulator/core.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index dabac9772741..2c33653ffdea 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1911,19 +1911,24 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 		}
 	}
 
-	if (err != -EEXIST)
+	if (err != -EEXIST) {
 		regulator->debugfs = debugfs_create_dir(supply_name, rdev->debugfs);
-	if (IS_ERR(regulator->debugfs))
-		rdev_dbg(rdev, "Failed to create debugfs directory\n");
+		if (IS_ERR(regulator->debugfs)) {
+			rdev_dbg(rdev, "Failed to create debugfs directory\n");
+			regulator->debugfs = NULL;
+		}
+	}
 
-	debugfs_create_u32("uA_load", 0444, regulator->debugfs,
-			   &regulator->uA_load);
-	debugfs_create_u32("min_uV", 0444, regulator->debugfs,
-			   &regulator->voltage[PM_SUSPEND_ON].min_uV);
-	debugfs_create_u32("max_uV", 0444, regulator->debugfs,
-			   &regulator->voltage[PM_SUSPEND_ON].max_uV);
-	debugfs_create_file("constraint_flags", 0444, regulator->debugfs,
-			    regulator, &constraint_flags_fops);
+	if (regulator->debugfs) {
+		debugfs_create_u32("uA_load", 0444, regulator->debugfs,
+				   &regulator->uA_load);
+		debugfs_create_u32("min_uV", 0444, regulator->debugfs,
+				   &regulator->voltage[PM_SUSPEND_ON].min_uV);
+		debugfs_create_u32("max_uV", 0444, regulator->debugfs,
+				   &regulator->voltage[PM_SUSPEND_ON].max_uV);
+		debugfs_create_file("constraint_flags", 0444, regulator->debugfs,
+				    regulator, &constraint_flags_fops);
+	}
 
 	/*
 	 * Check now if the regulator is an always on regulator - if
-- 
2.43.2


