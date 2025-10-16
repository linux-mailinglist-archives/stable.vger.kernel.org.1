Return-Path: <stable+bounces-186152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D48BE3BAD
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A18858207D
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B1A339B45;
	Thu, 16 Oct 2025 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcsMhdpX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447C7339B36
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621682; cv=none; b=swKTjAwXMO4TxypJELAhhXHp2X8oyHxsJJY1FTY1aHZMc+BA9IyzWpWMfzLhoSTb4N7r8H/HcZrlV6fg9la1XX1SqbeHZE+UuGuvaMSVaiUM7dRrgFHkkapT0QGV3ygW34Tga+MULoeG2ZzXl/gQ8TL8HoZ+HtWR+V49XH22dDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621682; c=relaxed/simple;
	bh=vgpfVcZUNYtHAAC2i0ChJWWItTzGG9ED+9hLtKwX9YY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JN6Xzh9W0L6mJ9FGY895cqqOC4oPHzs/oU/lmijRmzEA1IqniYA68ypor1iGJPjV67NszJQ1UI+2odUaTlvd78TCSMg+jOWC/jgHEDDqwC+N0S8zYfr/aNktXOFMIFgwYIXo02a38ZfjzUW7M4Nzy3rbXAMOheRLYGoTrPAHGnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcsMhdpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A25CC113D0;
	Thu, 16 Oct 2025 13:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760621681;
	bh=vgpfVcZUNYtHAAC2i0ChJWWItTzGG9ED+9hLtKwX9YY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DcsMhdpXN76nxQC6+2bROJPxRPeCCME+ydGacI75fqhzlPinrgl2LOkzpkilWtMPo
	 x2bgLEWkaVe5pqtPmyTTPj5RwzhCRCEqXXtEZ0uRclUL/2vOrE0/FRs3NLQqeusRki
	 C4LVN4oJMd3+kVtKUsuhOxKdhyRHVRIhI5e0l3aTnwXkGyNRzMJKN7ssWirGUFYug6
	 fmveITCsLpo6asfMHdSL+2a2PPXpSCssYxpMc0OFiGKk7TGzU2KakxU6xAC51HelI+
	 lBTx3b3nb9wK5ULh2uLzkMy4f28p0pm+O+q9Hc5vEx6UcJyeXQRaOuXdvC1eOFVgDG
	 3NBvT3KLySp7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] ACPI: battery: initialize mutexes through devm_ APIs
Date: Thu, 16 Oct 2025 09:34:36 -0400
Message-ID: <20251016133438.3296275-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016133438.3296275-1-sashal@kernel.org>
References: <2025101634-factsheet-preplan-069e@gregkh>
 <20251016133438.3296275-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit 0710c1ce50455ed0db91bffa0eebbaa4f69b1773 ]

Simplify the cleanup logic a bit.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://patch.msgid.link/20240904-acpi-battery-cleanups-v1-3-a3bf74f22d40@weissschuh.net
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 399dbcadc01e ("ACPI: battery: Add synchronization between interface updates")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/battery.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index c6e29e377b9ca..1a10eeddedac1 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1225,8 +1225,8 @@ static int acpi_battery_add(struct acpi_device *device)
 	strscpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_NAME);
 	strscpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
 	device->driver_data = battery;
-	mutex_init(&battery->lock);
-	mutex_init(&battery->sysfs_lock);
+	devm_mutex_init(&device->dev, &battery->lock);
+	devm_mutex_init(&device->dev, &battery->sysfs_lock);
 	if (acpi_has_method(battery->device->handle, "_BIX"))
 		set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
 
@@ -1254,8 +1254,6 @@ static int acpi_battery_add(struct acpi_device *device)
 	unregister_pm_notifier(&battery->pm_nb);
 fail:
 	sysfs_remove_battery(battery);
-	mutex_destroy(&battery->lock);
-	mutex_destroy(&battery->sysfs_lock);
 
 	return result;
 }
@@ -1275,9 +1273,6 @@ static void acpi_battery_remove(struct acpi_device *device)
 	device_init_wakeup(&device->dev, 0);
 	unregister_pm_notifier(&battery->pm_nb);
 	sysfs_remove_battery(battery);
-
-	mutex_destroy(&battery->lock);
-	mutex_destroy(&battery->sysfs_lock);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.51.0


