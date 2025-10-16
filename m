Return-Path: <stable+bounces-186151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCCDBE3B9F
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64D894EDE5B
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35A7339B20;
	Thu, 16 Oct 2025 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ikyr5ssP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D1131196D
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621681; cv=none; b=p2uAyb3P0FmrvYojyjOvIc77CCKET1SYpGIlir5iIvzgria3Kq9SCRyCggL9Saj2trcOZEf11jOKJu3WYDDARoCSf7hrXtwva+WKZAYLUu57EMBE3WJND2NOgQhI1/ev5BpAU0ylk/hGphZ1yS7pOmYW0wnZOllP3iRYthTxkls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621681; c=relaxed/simple;
	bh=sJRpGeLl1MKwWrGGazILiHj+p6A3jlKRMicqaZC+YQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KmOE2PKX/dBiO/2R/SL3p5HuMb6uWSUiPEVPJNTM3jqD2nQeTXr+1XS13aiAFn2p6p+hVARf0u6crFNQ9oGc7CT954heJkiyLKbUFIsoFHmgOsHjX6rT1juyXWBo+bTX+us4OYpyI9rToQUeWFs/mV+ikpneELMQdifXjKVEgHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ikyr5ssP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645D9C4CEF1;
	Thu, 16 Oct 2025 13:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760621681;
	bh=sJRpGeLl1MKwWrGGazILiHj+p6A3jlKRMicqaZC+YQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ikyr5ssPqA7Jngam324uHL91ZGTKtBBfTYaypnv3QOwBcUOZeno6lpCqZmJzls06H
	 UYp1q8yASsrTFNApVMImSxln1a5B0anSySZWZUvj5F/GMrIbYo1nn3QptJnQuUOWSD
	 P0CQJbeZXN2NgszByR5hwuorSgMqPTMypc+hQxddxXNRjmmjJXB19JM5LM6t5wQ2qd
	 sGQaYa42dPNNLiG74pith4YeYa6Oaynk/STEGox2Lx4j++ApbekF6qOWAlU7TT2XoE
	 Dy7LSdSghFOiUN973x9QL1SHKsK4XvDbKBUfAmn77+Bf3PYJRCcgYbZaKyD7wBoTqN
	 00z7brwo9LhNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] ACPI: battery: allocate driver data through devm_ APIs
Date: Thu, 16 Oct 2025 09:34:35 -0400
Message-ID: <20251016133438.3296275-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101634-factsheet-preplan-069e@gregkh>
References: <2025101634-factsheet-preplan-069e@gregkh>
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
index 65fa3444367a1..c6e29e377b9ca 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1218,7 +1218,7 @@ static int acpi_battery_add(struct acpi_device *device)
 	if (device->dep_unmet)
 		return -EPROBE_DEFER;
 
-	battery = kzalloc(sizeof(struct acpi_battery), GFP_KERNEL);
+	battery = devm_kzalloc(&device->dev, sizeof(*battery), GFP_KERNEL);
 	if (!battery)
 		return -ENOMEM;
 	battery->device = device;
@@ -1256,7 +1256,6 @@ static int acpi_battery_add(struct acpi_device *device)
 	sysfs_remove_battery(battery);
 	mutex_destroy(&battery->lock);
 	mutex_destroy(&battery->sysfs_lock);
-	kfree(battery);
 
 	return result;
 }
@@ -1279,7 +1278,6 @@ static void acpi_battery_remove(struct acpi_device *device)
 
 	mutex_destroy(&battery->lock);
 	mutex_destroy(&battery->sysfs_lock);
-	kfree(battery);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.51.0


