Return-Path: <stable+bounces-186159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C69EBE3D0E
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D8584F903D
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EAE33CE9E;
	Thu, 16 Oct 2025 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HixPkV1Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F9A33CE90
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622858; cv=none; b=tibWUZaVFjWULflNNHqyXmU7GZSWsXmX8JRQ5Av0H73HhBSpyP1DBK8TQo24Y7agzMd6dYU3dzotSZ2MszmJ08pOx4LkU1csrRQM6pSFLttHMIgmcpCOoedsUYJoooJVdXbX/Not7I+i0YxYKcmFwwDj6e2TgETRZmx97zIrNf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622858; c=relaxed/simple;
	bh=GK+tBpJ0X+pBXD4hl38vMO9ylVCKVh/61DpkK0pWuXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ekjwXpuWc7tAKcrzV1ih5w3t47yZXKg00hkSTz3M4+tzpvgP3yQS3ldfzacfXC6WB8EGWinRwnoxtHKgAc9WLwNaObFzl/0sXTTv+QPM7gH/7ShcmUwI2C9/CpQZFgLOBLQH6kEcox3TEPvkAJCm6Tvs+IpswJCzzC+g3LvVt9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HixPkV1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E0FC4CEF1;
	Thu, 16 Oct 2025 13:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760622856;
	bh=GK+tBpJ0X+pBXD4hl38vMO9ylVCKVh/61DpkK0pWuXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HixPkV1YxuiED1vpK1BWUeCSNPk9/tYTmP6gMJvjC0KUjLsztdhizqcEVm5Iajph+
	 GG+oS7dt3US6e4jkHF/efK0V+0GS3pjzxLPSO+gciFTb4FsyJGWKixz2ryJ7dc2SI4
	 aNJckuPzd/fBDIARi/NlXpI9YV0CQoTHB5qWFwyDnQDXYX04UPtGVMrvFSIS0uEL1b
	 JOvl3EuVmPpKOSciPRV+BMBIoOiziDhAeInNiWeL0VTjrKjuXSxowfCcyLeGQKOYIK
	 RusHoq/m5TqC5lRljbPqJZBtJXMdlwzvzUFOHgYaSmOjTjRv5hO0ij8pgPERf+41Bw
	 P2bNXOtWGUHfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] ACPI: battery: Check for error code from devm_mutex_init() call
Date: Thu, 16 Oct 2025 09:54:11 -0400
Message-ID: <20251016135412.3299634-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016135412.3299634-1-sashal@kernel.org>
References: <2025101635-disaster-pasture-f32d@gregkh>
 <20251016135412.3299634-1-sashal@kernel.org>
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
index 1d3bef269907c..b1aa44f5a6a00 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1210,8 +1210,14 @@ static int acpi_battery_add(struct acpi_device *device)
 	strcpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
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


