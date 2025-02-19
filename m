Return-Path: <stable+bounces-117693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDB3A3B732
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9398D7A6C60
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580201C7B62;
	Wed, 19 Feb 2025 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gYX/wXPZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167461C4A06;
	Wed, 19 Feb 2025 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956075; cv=none; b=F+YYAVU/bwUuKuhVdgTKvomWa5cIb7Dtza9ah5ZtlaCEvF89eFV9yJYZdCiUNIgBFT62ZDhqso+bZAvCuQFR5iWHPJlnFirrPHvynDni8Dy4my/oBs1ttq/YbSauN7kZ9FOJSbN69N5nL837SU3yyEEogztklDG/yV9w5Rqa+e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956075; c=relaxed/simple;
	bh=EmCX4x5DFV/DC21EDjs+Fp1JpGwgiUrKZ8kw4YqQ26A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKjtBzscyntlyAfL0nouKx6jZP3D09uiuVWMtawsRlKC0SjTq4t4vMHoPdcHiewxpimV85ZKFXc70UqX1G3Nt0oSoh0o6QOeBYDgWGC8GK6EQWBOVgEDC27dV+xCH3wcdkr+eCU1t25KMiJBRM4oTcs11l+McSmqLf8xu+tt9UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gYX/wXPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9C1C4CED1;
	Wed, 19 Feb 2025 09:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739956074;
	bh=EmCX4x5DFV/DC21EDjs+Fp1JpGwgiUrKZ8kw4YqQ26A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gYX/wXPZWWnM673AVGEtCpD6C5rZS359TUAa2LWoZouAVtUuOSBvjayJ6KAi1xaRr
	 i9aZ2iffU25ZxQUw3niX3b5fta6XLjtF6SCdo4LySk4CkbhnaMkuX25HobLpLDPwtq
	 px1ZZAnhBmvg4oE18Hq4wwhy/3bs66sc1/Gxn+Zg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 056/578] ACPI: fan: cleanup resources in the error path of .probe()
Date: Wed, 19 Feb 2025 09:21:00 +0100
Message-ID: <20250219082655.094358512@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>

[ Upstream commit c759bc8e9046f9812238f506d70f07d3ea4206d4 ]

Call thermal_cooling_device_unregister() and sysfs_remove_link() in the
error path of acpi_fan_probe() to fix possible memory leak.

This bug was found by an experimental static analysis tool that I am
developing.

Fixes: 05a83d972293 ("ACPI: register ACPI Fan as generic thermal cooling device")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Link: https://patch.msgid.link/20241211032812.210164-1-joe@pf.is.s.u-tokyo.ac.jp
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/fan_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 52a0b303b70aa..36907331a6691 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -366,19 +366,25 @@ static int acpi_fan_probe(struct platform_device *pdev)
 	result = sysfs_create_link(&pdev->dev.kobj,
 				   &cdev->device.kobj,
 				   "thermal_cooling");
-	if (result)
+	if (result) {
 		dev_err(&pdev->dev, "Failed to create sysfs link 'thermal_cooling'\n");
+		goto err_unregister;
+	}
 
 	result = sysfs_create_link(&cdev->device.kobj,
 				   &pdev->dev.kobj,
 				   "device");
 	if (result) {
 		dev_err(&pdev->dev, "Failed to create sysfs link 'device'\n");
-		goto err_end;
+		goto err_remove_link;
 	}
 
 	return 0;
 
+err_remove_link:
+	sysfs_remove_link(&pdev->dev.kobj, "thermal_cooling");
+err_unregister:
+	thermal_cooling_device_unregister(cdev);
 err_end:
 	if (fan->acpi4)
 		acpi_fan_delete_attributes(device);
-- 
2.39.5




