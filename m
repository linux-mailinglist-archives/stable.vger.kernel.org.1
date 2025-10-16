Return-Path: <stable+bounces-186153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3540BBE3BA7
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CBDEA3590A5
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55165339B56;
	Thu, 16 Oct 2025 13:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxBpPCkR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156BA339B4D
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621683; cv=none; b=VG4zPzTnAbT1UBOYPmMtTBK+bqYEWKHACZTzSSDbRJ7Q9Ljv8/SQbtMNLv8h8gLvRYGjwenGjOZApA2LSZ8HhOzNSqDanFkxDFRFJl+jGi8fy31Sxw8w3iYtiW/HIng58Vja0SQxxc/o3HDkvIx/51MX1CGRxjW/xacg1hJ50rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621683; c=relaxed/simple;
	bh=ym26YEpHVFqT2WrCcFMqIaNg3HOLfmXWAgWlCk4O05g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XsES3BUdhyk54TVNVG6JnK8USkJ/abiYMC/3C3g2L4ci3h7QUXMRgzYstlL5fr3zEoe3gZ4yNpL4RIS1ub8pJGbKpELzV1nnFXjgRIMVG8b4EY/K0gDUUkQcL+85/iQAAZ9mO/Xef0pHMdrujhk/y2ukScF/ORW4DMqKyzfYd0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxBpPCkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E669C4CEF1;
	Thu, 16 Oct 2025 13:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760621682;
	bh=ym26YEpHVFqT2WrCcFMqIaNg3HOLfmXWAgWlCk4O05g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AxBpPCkRdCpBytozKCkFAkN03F7BMz446tKQMNdMgBlMlhNr0hNGHRAvKesQ/CKiI
	 gd6XsOl6oJ83sFIgIfga8FBWSpnQHoeepmmhbzj5aIxKkSM25k6LK+Rv0owxPYAeNQ
	 HJBsnbJnkt317LRtSYAIAvf/iJterrat1AGHdgtbYYxBBY8hW2s6J2+baelHvqYoiw
	 Xg2iAp+Tu24KWQvNwyh2qXxpKliINspYoc3TIWcABQ+Z3vppc6q7EOF9SEhLwW2IEK
	 L5H0Dk+VmgNsKnx6L8NLuAuH6f9/1e/qOUOevYomcydXIDfXrQaS3btgmR0Ov3nZHq
	 p+2Y/eRtneMGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] ACPI: battery: Check for error code from devm_mutex_init() call
Date: Thu, 16 Oct 2025 09:34:37 -0400
Message-ID: <20251016133438.3296275-3-sashal@kernel.org>
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 815daedc318b2f9f1b956d0631377619a0d69d96 ]

Even if it's not critical, the avoidance of checking the error code
from devm_mutex_init() call today diminishes the point of using devm
variant of it. Tomorrow it may even leak something. Add the missed
check.

Fixes: 0710c1ce5045 ("ACPI: battery: initialize mutexes through devm_ APIs")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://patch.msgid.link/20241030162754.2110946-1-andriy.shevchenko@linux.intel.com
[ rjw: Added 2 empty code lines ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 399dbcadc01e ("ACPI: battery: Add synchronization between interface updates")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/battery.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 1a10eeddedac1..8d3e44f0caf44 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1225,8 +1225,14 @@ static int acpi_battery_add(struct acpi_device *device)
 	strscpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_NAME);
 	strscpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
 	device->driver_data = battery;
-	devm_mutex_init(&device->dev, &battery->lock);
-	devm_mutex_init(&device->dev, &battery->sysfs_lock);
+	result = devm_mutex_init(&device->dev, &battery->lock);
+	if (result)
+		return result;
+
+	result = devm_mutex_init(&device->dev, &battery->sysfs_lock);
+	if (result)
+		return result;
+
 	if (acpi_has_method(battery->device->handle, "_BIX"))
 		set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
 
-- 
2.51.0


