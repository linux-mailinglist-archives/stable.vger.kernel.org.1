Return-Path: <stable+bounces-254420-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPh6KsjnFWqXegcAu9opvQ
	(envelope-from <stable+bounces-254420-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:34:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2CC5DB66A
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31C2130118E9
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 18:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F1242317C;
	Tue, 26 May 2026 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="GYOqmIBW"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D268274670;
	Tue, 26 May 2026 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779820443; cv=pass; b=kTrn+c5x8yJOzr+vyWJlYnb8kxJ8OxZTiX4ur3dw4ke0t3nmwOGB02uYunz4irguOdpvH+l6+FTX4X4NHnXv8JnQWB7ta98BTC1OxOO48eiEv7xQWe6MCMezJbQgNkQmrsT8NoEP0xW9/2SSHpvWI9bvKMJ9WSghNtuVqt5m97U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779820443; c=relaxed/simple;
	bh=a42bEj4BPedTC4K4wJ7Psyc3lisaBUcp7A4pVwQ25HI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W9T1IXl4R9XB9osxib++vimJ0BhOJGELCg98078wg6RLfesO5eymI+PFcjI3cfP3r38Lov8mcrmIDeiBF+HD6QDqm8tLtrSTGIrs0Cv7vcy6JN73HjBzfEZPxl7Ju4omQvlKmU6zsfjcJd/fsy8DOv5rGFOIwrKP2jqV0PdtwHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=GYOqmIBW; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1779820432; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=F6t5SVYemoTpG2bJyVr7uSO4VSRDToiYBFI4gLjInAuNtUQKq/zvaChUA9XSEyN2N45i05UgxOuXMAKz+jkRWkHrSALDxerFrVAEsHkqAjOPnbjT8GvykI9Xl66Lwe9JNfYm4xf4e3Q4jmhrX0pgK2Uz5BHJgT3HxUFimVgPY4c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779820432; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eaikGadZPM1Qgx8PCRgB0wgBMW7yI8+qqFaAHygEo60=; 
	b=kjWtOpuT6dstJa2AyQOFEezZhG+vObBup2WHvPFZoR5UgrFcSYfjwNWrzS7RJZZfUe30IeQ/ZaZZvbGTeRYfNDSZY+xOIs0sJNuBQ6jT2Zg+S986nAfbqMZ123rdqtRO3VI7VQbRpusNVknFO60fePyuWuFwqDCSqZmpTFe26GY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779820432;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=eaikGadZPM1Qgx8PCRgB0wgBMW7yI8+qqFaAHygEo60=;
	b=GYOqmIBWrJ9krmBttyDE1H/k5NRXyUVaeDHtjE/WRDoCc7PtAw+PRD/ZW+KqZW7q
	B45WvPsWdUfansrBgcVRk+duGOuiukczqQHHZAV7RWBJ2h4KIHD151CiR/K6LY/EISC
	Awgv7sY+l96dUv09ww3zE7Ujyaaf1xWPE2wxG90FsgRb1IMAW54z7teq862VTECTY0W
	7BL+T726tFku/8M+6WnVoad7B2hGZNkf9f0K44wyyu74XY3qxS8gU/Mb9rJu8rgiB54
	ik0l/Z/YlRai+dJ0jpp/VCFg0V/n23e6ZT/WrDXt/iiQIfEI16g/8VubQBLjHLyxtwo
	jfGH/pNcig==
Received: by mx.zohomail.com with SMTPS id 1779820431845756.9517239776911;
	Tue, 26 May 2026 11:33:51 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Wed, 27 May 2026 02:31:31 +0800
Subject: [PATCH 1/2] ACPI: battery: Synchronize get_property() callback
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260527-b4-acpi-battery-notification-v1-1-2303bed8ec0b@rong.moe>
References: <20260527-b4-acpi-battery-notification-v1-0-2303bed8ec0b@rong.moe>
In-Reply-To: <20260527-b4-acpi-battery-notification-v1-0-2303bed8ec0b@rong.moe>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jeffrey_W=C3=A4lti?= <jeffrey@waelti.dev>, stable@vger.kernel.org, 
 Rick <rickk1166@gmail.com>, Rong Zhang <i@rong.moe>
X-Mailer: b4 0.16-dev-d5d98
X-ZohoMailClient: External
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[rong.moe,none];
	R_DKIM_ALLOW(-0.20)[rong.moe:s=zmail2048];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,waelti.dev,gmail.com,rong.moe];
	TAGGED_FROM(0.00)[bounces-254420-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rong.moe:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i@rong.moe,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rong.moe:email,rong.moe:mid,rong.moe:dkim,waelti.dev:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BC2CC5DB66A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The acpi_battery_get_property() callback calls acpi_battery_get_state()
without battery->update_lock held, which could lead to race conditions,
e.g., when multiple tasks read power supply properties simultaneously,
or when other synchronized methods are called during its execution.

Moreover, some devices' _BST method relies on a heavily shared ACPI
mutex which protects EC accesses, so it cannot tolerate too much
pressure or else other methods will time out. The lack of
synchronization sometimes nullifies the cache mechanism of
acpi_battery_get_state() when multiple processes read power supply
properties simultaneously, which usually happens after a uevent.
Normally, emitting a uevent implies that the cache must have been
refreshed due to power_supply_uevent() reading all properties, so the
mentioned processes should have seen cache hits. Unfortunately, these
fragile devices' power_supply_ext properties are somehow slow to read
after battery events, resulting in cache expiration before
power_supply_uevent() finishes. Hence, once the uevent reaches
userspace, the _BST method will be executed multiple times within a
short period due to userspace processes reading all properties again.
The coincidence causes lock starvation, resulting in a catastrophic
situation that a lot of ACPI methods fail to acquire the shared ACPI
mutex due to timeout and return garbage data thanks to the firmware's
poorly designed error paths.

Protect acpi_battery_get_property() with update_lock to synchronize it.
The helper function acpi_battery_handle_discharging() for quirky devices
has to be inlined due to the change, as the mutex must be unlocked
before calling the expensive power_supply_is_system_supplied() helper
function.

Tested-by: Jeffrey Wälti <jeffrey@waelti.dev>
Fixes: 399dbcadc01e ("ACPI: battery: Add synchronization between interface updates")
Cc: stable@vger.kernel.org
Reported-by: Rick <rickk1166@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221065
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/acpi/battery.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b82dd67d98c9..5f06841b48a1 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -180,20 +180,6 @@ static bool acpi_battery_is_degraded(struct acpi_battery *battery)
 		battery->full_charge_capacity < battery->design_capacity;
 }
 
-static int acpi_battery_handle_discharging(struct acpi_battery *battery)
-{
-	/*
-	 * Some devices wrongly report discharging if the battery's charge level
-	 * was above the device's start charging threshold atm the AC adapter
-	 * was plugged in and the device thus did not start a new charge cycle.
-	 */
-	if ((battery_ac_is_broken || power_supply_is_system_supplied()) &&
-	    battery->rate_now == 0)
-		return POWER_SUPPLY_STATUS_NOT_CHARGING;
-
-	return POWER_SUPPLY_STATUS_DISCHARGING;
-}
-
 static int acpi_battery_get_property(struct power_supply *psy,
 				     enum power_supply_property psp,
 				     union power_supply_propval *val)
@@ -201,15 +187,35 @@ static int acpi_battery_get_property(struct power_supply *psy,
 	int full_capacity = ACPI_BATTERY_VALUE_UNKNOWN, ret = 0;
 	struct acpi_battery *battery = to_acpi_battery(psy);
 
+	mutex_lock(&battery->update_lock);
+
 	if (acpi_battery_present(battery)) {
 		/* run battery update only if it is present */
 		acpi_battery_get_state(battery);
-	} else if (psp != POWER_SUPPLY_PROP_PRESENT)
+	} else if (psp != POWER_SUPPLY_PROP_PRESENT) {
+		mutex_unlock(&battery->update_lock);
 		return -ENODEV;
+	}
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
+		/*
+		 * Some devices wrongly report discharging if the battery's charge level
+		 * was above the device's start charging threshold atm the AC adapter
+		 * was plugged in and the device thus did not start a new charge cycle.
+		 */
 		if (battery->state & ACPI_BATTERY_STATE_DISCHARGING)
-			val->intval = acpi_battery_handle_discharging(battery);
+			if (battery->rate_now != 0) {
+				val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+			} else if (battery_ac_is_broken) {
+				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			} else {
+				mutex_unlock(&battery->update_lock);
+
+				val->intval = power_supply_is_system_supplied()
+					? POWER_SUPPLY_STATUS_NOT_CHARGING
+					: POWER_SUPPLY_STATUS_DISCHARGING;
+				return 0;
+			}
 		else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
 			/* Validate the status by checking the current. */
 			if (battery->rate_now != ACPI_BATTERY_VALUE_UNKNOWN &&
@@ -311,6 +317,8 @@ static int acpi_battery_get_property(struct power_supply *psy,
 	default:
 		ret = -EINVAL;
 	}
+
+	mutex_unlock(&battery->update_lock);
 	return ret;
 }
 

-- 
2.53.0


