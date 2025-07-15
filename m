Return-Path: <stable+bounces-162452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 873CAB05E02
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549414A086F
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915EA2E8884;
	Tue, 15 Jul 2025 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kwoG0VC/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF462E339B;
	Tue, 15 Jul 2025 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586592; cv=none; b=uDrU5WPUFDugmRQs1Gok/vBjpfPXHBY02nQR3an8Qq8k6o6LblnQ3cHHvMyd6IBcAU/whl3cDVEe+rnBhxkiDTtbzCicnaKwoAOxZnqN3mYafaipvu5OvhEs2a88Zh/2U7FqPusQXG+euOrMyd7Z53j2kwCn2jTGYsIufYdTbTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586592; c=relaxed/simple;
	bh=V0oE5t0O/P5yvLIwTKJPfrYDJisbQ4JVEpQOcoP3dyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOHIdx4QIbKHd7DICzA70VHnYCaUcz4KUeiYOGjhlhFFVT4NwQh69xSNL9lb4bw/lE4rYkgjOd6npaAIGEiiCg67FZf7G3bvWp4gXShB65ZwkAVF22JEI/iEH3lm1jQ9/1ogf1wM7SJgg70nnQ4MxowsCoWjIbPwN3wXuFWOwkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kwoG0VC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F75C4CEE3;
	Tue, 15 Jul 2025 13:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586591;
	bh=V0oE5t0O/P5yvLIwTKJPfrYDJisbQ4JVEpQOcoP3dyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kwoG0VC/SV1yKWml+23tgiQ94gCYWRMMdxFVaClkqLYgBm9jNRAS/VvixlL6xja37
	 /EEmu9kdd5PicfZtmE+PR1zYYUl29Y2PRq3bapsjuytHMfndtRDTuixzWm1y6xXfUZ
	 nF6HIVfnKB7A5sP9+MU7UQSf9Orum4dZgnL4Krks=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Schwartz <matthew.schwartz@linux.dev>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.4 123/148] Revert "ACPI: battery: negate current when discharging"
Date: Tue, 15 Jul 2025 15:14:05 +0200
Message-ID: <20250715130805.224395958@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130800.293690950@linuxfoundation.org>
References: <20250715130800.293690950@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit de1675de39aa945bad5937d1fde4df3682670639 upstream.

Revert commit 234f71555019 ("ACPI: battery: negate current when
discharging") breaks not one but several userspace implementations
of battery monitoring: Steam and MangoHud. Perhaps it breaks more,
but those are the two that have been tested.

Reported-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Closes: https://lore.kernel.org/linux-acpi/87C1B2AF-D430-4568-B620-14B941A8ABA4@linux.dev/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/battery.c |   19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -266,23 +266,10 @@ static int acpi_battery_get_property(str
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 	case POWER_SUPPLY_PROP_POWER_NOW:
-		if (battery->rate_now == ACPI_BATTERY_VALUE_UNKNOWN) {
+		if (battery->rate_now == ACPI_BATTERY_VALUE_UNKNOWN)
 			ret = -ENODEV;
-			break;
-		}
-
-		val->intval = battery->rate_now * 1000;
-		/*
-		 * When discharging, the current should be reported as a
-		 * negative number as per the power supply class interface
-		 * definition.
-		 */
-		if (psp == POWER_SUPPLY_PROP_CURRENT_NOW &&
-		    (battery->state & ACPI_BATTERY_STATE_DISCHARGING) &&
-		    acpi_battery_handle_discharging(battery)
-				== POWER_SUPPLY_STATUS_DISCHARGING)
-			val->intval = -val->intval;
-
+		else
+			val->intval = battery->rate_now * 1000;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:



