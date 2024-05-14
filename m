Return-Path: <stable+bounces-44099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CF88C513C
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A7228168C
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BC812FB14;
	Tue, 14 May 2024 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FU7lSZv6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5032ED531;
	Tue, 14 May 2024 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684219; cv=none; b=U8rHwUUXJskp5xVgELkfWPQLg9MhQ0P1p9SKwqEYCj8VaP6MPBSxXDdw6FpmomZoWyEP3hkbvVt6KfBqlkxeJZvbSHiE0RJHSMowrflWX7mAdm2ivRbgqgbwrCbY6Sp7h5EivanObjakXNXdC1sE7HJx+f3cAMvnnWG2hRFkgnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684219; c=relaxed/simple;
	bh=CU+ujsvZGOxKMup0M6CkuXXNMFnbtflcsH789eE7ySA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nhvw/iErAJH00krYQwc6fMXGN7qb6LBW85g5Y2/thn1h0WW6am0b8If7OfxuUcR004gDiLuemcRpa3w4Z04ybIgP8Fv9X9sfJArNRkPwwIaNcLQnnCwZk6wKNR3TkhHjas4olFEcGz8ozCTfMbHNGVbIvvqtAFv3xyvJjRZzDXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FU7lSZv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F29C2BD10;
	Tue, 14 May 2024 10:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715684218;
	bh=CU+ujsvZGOxKMup0M6CkuXXNMFnbtflcsH789eE7ySA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FU7lSZv6DrPzG0uSscarswWezUjn8llNnY6m8kni6YtIZ43vSB6ipHuIOjPpiVnyi
	 rvpe/UEdUli4/JLbpy7FVpBUb4MALiOJ5sd9kS2aH47v4Ep4Aop64gPejzrkTjDEbG
	 pqld4/iE1Ch3jKqN693N/EQ1D004Wofi21SThsT0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Johan Hovold <johan+linaro@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.8 320/336] regulator: core: fix debugfs creation regression
Date: Tue, 14 May 2024 12:18:44 +0200
Message-ID: <20240514101050.703839524@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan+linaro@kernel.org>

commit 2a4b49bb58123bad6ec0e07b02845f74c23d5e04 upstream.

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
Link: https://lore.kernel.org/r/20240509133304.8883-1-johan+linaro@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/regulator/core.c |   27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1911,19 +1911,24 @@ static struct regulator *create_regulato
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



