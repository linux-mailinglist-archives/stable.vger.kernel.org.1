Return-Path: <stable+bounces-186156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 048E7BE3CFC
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C34C34E6351
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7FF3376A5;
	Thu, 16 Oct 2025 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1R7LDGc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD1B1D5CE8
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622855; cv=none; b=N49B7PiW0X/+E9XNAEEa2R1ARe+FtkNkYe5obIDk7yk2D3koEiXzHtKP5C2DrFAN3mrpWvDdlX1+Rd4nmm9S1tuneJskvKIrPH+0pVL/0iNhNQD8c1bmscU6rRzf+87eHXnwqwO5FJV9eFSnN1kcbVTkuV0jpD91UJqV5iw45n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622855; c=relaxed/simple;
	bh=8DY2h0oG9JUGsUT1CZi4fGqj6D/q80AlIkXD2RW7BYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZNVyf7IWuWiKv9gZ6OaWQs0kWosqkQoDMCoqehLrs3J/hmm18q7zSI+P06jXc+rv5NWzQ6aH4GJQyu78N1RrhkAD+/9JW45MGzFrbvZXVRKCLrqdZtXt9dI2DIKYTnh2SP4AaBdjj0HxKmLTXcpGatQFWes6NkCtrqKTJu0sHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1R7LDGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D73EC4CEF1;
	Thu, 16 Oct 2025 13:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760622855;
	bh=8DY2h0oG9JUGsUT1CZi4fGqj6D/q80AlIkXD2RW7BYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U1R7LDGcHUlUjtv+jXhaAvEOfLEQi7f1vdrhIKeYFrDSdnMAIXDvKFOkTLaKPqLeP
	 u2VYZMp42YEXlQvGk9xFCXoIraT8+96I+RXTuNib64tEqW9GUGnHyOW3alJkgQ10n7
	 lnhgFQlZ+OWRiKATLA2OrePaV0OhX2CwA40T2FDzmwg2l2PB27Pq5vlsrLyNIpmWJO
	 xFL4+saJft9jHsNbvTBYsKP3Ipz+edCBdPnPeEIVf6wdNZYHzdKhGazzFgHl8NzDqs
	 HXh8aUKLYZcKCMuZBuwkhUXVMKeUuoQpEuS0kEYl7RRDdm9KqHW5ySK99ZoCC0MIuq
	 AUQHuBBls74aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] ACPI: battery: allocate driver data through devm_ APIs
Date: Thu, 16 Oct 2025 09:54:09 -0400
Message-ID: <20251016135412.3299634-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101635-disaster-pasture-f32d@gregkh>
References: <2025101635-disaster-pasture-f32d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit 909dfc60692331e1599d5e28a8f08a611f353aef ]

Simplify the cleanup logic a bit.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://patch.msgid.link/20240904-acpi-battery-cleanups-v1-2-a3bf74f22d40@weissschuh.net
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 399dbcadc01e ("ACPI: battery: Add synchronization between interface updates")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/battery.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index e3cbaf3c3bbc1..888664da286d9 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1203,7 +1203,7 @@ static int acpi_battery_add(struct acpi_device *device)
 	if (device->dep_unmet)
 		return -EPROBE_DEFER;
 
-	battery = kzalloc(sizeof(struct acpi_battery), GFP_KERNEL);
+	battery = devm_kzalloc(&device->dev, sizeof(*battery), GFP_KERNEL);
 	if (!battery)
 		return -ENOMEM;
 	battery->device = device;
@@ -1241,7 +1241,6 @@ static int acpi_battery_add(struct acpi_device *device)
 	sysfs_remove_battery(battery);
 	mutex_destroy(&battery->lock);
 	mutex_destroy(&battery->sysfs_lock);
-	kfree(battery);
 
 	return result;
 }
@@ -1264,7 +1263,6 @@ static void acpi_battery_remove(struct acpi_device *device)
 
 	mutex_destroy(&battery->lock);
 	mutex_destroy(&battery->sysfs_lock);
-	kfree(battery);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.51.0


