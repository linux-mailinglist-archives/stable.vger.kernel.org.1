Return-Path: <stable+bounces-186157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9111DBE3D02
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E74534EE89B
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B072233CE8D;
	Thu, 16 Oct 2025 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4Oe2iHc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D511D5CE8
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622856; cv=none; b=VRRbvyLICYHuA/mwAeIHNCgNgZJ+kF4XAqI4pdXZPkW7ElhWa3RAI+LCOfc5GMRZpxR49yyL0ba3g+0ef/W5htdGN2yqmbrAlMkO/HtpMPvYMlxiHciwvFtQdBjQBcPWsKN5F3yVCBErJuOyK1CpvfRw+cscZ9L8s17oQBnlr+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622856; c=relaxed/simple;
	bh=px44yQC28cVkiVhK6VwibUF5tTDEJnoTDY6kEn/NtQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hMoaWr6G/FzAZD0Ixg6ZJtKDS73FqZxg+QUNIx65rFKNwcQybfqW5zKQIELAWdJumxymgv7Rw9OvswbOju9FDRmNN731agwrvP25NzNNLT+KE5ed0YFkw9S8BFYxUnIybHmha05ZgxQ2Z/NIw37etZRUgLsHuOLlFkjM/gpAeME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4Oe2iHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60725C116B1;
	Thu, 16 Oct 2025 13:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760622855;
	bh=px44yQC28cVkiVhK6VwibUF5tTDEJnoTDY6kEn/NtQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b4Oe2iHcWWfdS2MsUhLsz+pTgK8AAA9iVaFfj4yZudIBqIUKAdnIGwqWUHYDzotAw
	 P5cwi7PeNlt2RTwyK6MJYJAEOMx0bqR3gkAAMbOJ5l6So0b82WlREhIlMmyHVvy8ym
	 EE1yztss5kqT3goNmiRdGsv3L1cSfafsxXf6Jz5WyY3uaJEYN1Z7FxxA88UgdtsvsF
	 uMdRVwpLk4Gr3hk5jw7471EISAtFmSD1azf43uAjUr8zE5R9WP8yIENC4DFQt9O6l2
	 a8t0hKUbR21AIwlpkii5TZHLEwga2VwKRYWY90WRC5gouATkm24FydDhG4A8toph9j
	 yoF5d3wUxWLbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] ACPI: battery: initialize mutexes through devm_ APIs
Date: Thu, 16 Oct 2025 09:54:10 -0400
Message-ID: <20251016135412.3299634-2-sashal@kernel.org>
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
index 888664da286d9..1d3bef269907c 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1210,8 +1210,8 @@ static int acpi_battery_add(struct acpi_device *device)
 	strcpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
 	device->driver_data = battery;
-	mutex_init(&battery->lock);
-	mutex_init(&battery->sysfs_lock);
+	devm_mutex_init(&device->dev, &battery->lock);
+	devm_mutex_init(&device->dev, &battery->sysfs_lock);
 	if (acpi_has_method(battery->device->handle, "_BIX"))
 		set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
 
@@ -1239,8 +1239,6 @@ static int acpi_battery_add(struct acpi_device *device)
 	unregister_pm_notifier(&battery->pm_nb);
 fail:
 	sysfs_remove_battery(battery);
-	mutex_destroy(&battery->lock);
-	mutex_destroy(&battery->sysfs_lock);
 
 	return result;
 }
@@ -1260,9 +1258,6 @@ static void acpi_battery_remove(struct acpi_device *device)
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


