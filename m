Return-Path: <stable+bounces-61051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0631393A6A7
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 20:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4121F22768
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 18:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93352158A29;
	Tue, 23 Jul 2024 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kk4Mwair"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFD915821A;
	Tue, 23 Jul 2024 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759831; cv=none; b=Ps0Eni0jJp2dYgewSNmk82S6l297aBSeHLMjnCd1W8opHBTQSIBHCw0P3cUR04BWwBh0G9c+R5v6b8xahKd+4e/EnXP2UdHy+ebgsDPF90S30fGolTN0q5S6cItrScFTSJhqHCArjTniNhCxQZe4XTu9A/G5tn6nFZHqGJ/zlRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759831; c=relaxed/simple;
	bh=pIOBUbZo5P7hij8loUdi1MxDWi2eIRvFzyPwtZokPB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o0bugu9HvYKYtPXczNYPK/LcBKdCE14h9ezvYQm7PmXETmeCfFWP922XwXZWlYsHI4Amq5ssWm7v1ujFSZSPe/RBvXAjDD6M18BRL2dC0U9+08LRCPfkUxVBvW5vkCaDmvu4V2mPA3K+2q5071C1nKecKEt8aDgLWplqyRJsfgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kk4Mwair; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E21C4AF0A;
	Tue, 23 Jul 2024 18:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721759831;
	bh=pIOBUbZo5P7hij8loUdi1MxDWi2eIRvFzyPwtZokPB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kk4MwairccTPbOnI8646GseT2mtswCDsbA6zatcuf+M+vmkUqQfNXgxOFZF2w66Rb
	 vyr1YuIYzFPpIxrUDJfKSkyjJtyKd1jCSl+pwlNhMeo0ROp/NRchqFN0/1b5xts/7s
	 +PZ06rWGHK1Yzq7DsHm5DUCL1ZQ7F7a/I/dOe2BQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rajas Paranjpe <paranjperajas@gmail.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 013/163] ACPI: AC: Properly notify powermanagement core about changes
Date: Tue, 23 Jul 2024 20:22:22 +0200
Message-ID: <20240723180143.982832485@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723180143.461739294@linuxfoundation.org>
References: <20240723180143.461739294@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit ac62f52138f752d6c74adc6321e4996d84caf5bb ]

The powermanagement core does various actions when a powersupply changes.
It calls into notifiers, LED triggers, other power supplies and emits an uevent.

To make sure that all these actions happen properly call power_supply_changed().

Reported-by: Rajas Paranjpe <paranjperajas@gmail.com>
Closes: https://github.com/MrChromebox/firmware/issues/420#issuecomment-2132251318
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ac.c  | 4 ++--
 drivers/acpi/sbs.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 2d4a35e6dd18d..09a87fa222c78 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -145,7 +145,7 @@ static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 						  dev_name(&adev->dev), event,
 						  (u32) ac->state);
 		acpi_notifier_call_chain(adev, event, (u32) ac->state);
-		kobject_uevent(&ac->charger->dev.kobj, KOBJ_CHANGE);
+		power_supply_changed(ac->charger);
 	}
 }
 
@@ -268,7 +268,7 @@ static int acpi_ac_resume(struct device *dev)
 	if (acpi_ac_get_state(ac))
 		return 0;
 	if (old_state != ac->state)
-		kobject_uevent(&ac->charger->dev.kobj, KOBJ_CHANGE);
+		power_supply_changed(ac->charger);
 
 	return 0;
 }
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 94e3c000df2e1..dc8164b182dcc 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -610,7 +610,7 @@ static void acpi_sbs_callback(void *context)
 	if (sbs->charger_exists) {
 		acpi_ac_get_present(sbs);
 		if (sbs->charger_present != saved_charger_state)
-			kobject_uevent(&sbs->charger->dev.kobj, KOBJ_CHANGE);
+			power_supply_changed(sbs->charger);
 	}
 
 	if (sbs->manager_present) {
@@ -622,7 +622,7 @@ static void acpi_sbs_callback(void *context)
 			acpi_battery_read(bat);
 			if (saved_battery_state == bat->present)
 				continue;
-			kobject_uevent(&bat->bat->dev.kobj, KOBJ_CHANGE);
+			power_supply_changed(bat->bat);
 		}
 	}
 }
-- 
2.43.0




