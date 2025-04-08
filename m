Return-Path: <stable+bounces-129834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4086FA80168
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A763F1889E55
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51C9267391;
	Tue,  8 Apr 2025 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V4dm9UQs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7311022257E;
	Tue,  8 Apr 2025 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112101; cv=none; b=r6f1Gd+QDdjG1LAJBLg2TIfRpSeq8g+Ht42a5CyH7Ub/YKZx8ztGKo1StobFlDo0rQbfPATOm8Ny1g3WJmwtv2myX3D4DwPl34Q0EwNzDEhouQSHQImAbLA42bQ1MqzCdWlMukOSksQkdUZh+CiJ5RvMFd3lSWFKc7MSDIMBXk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112101; c=relaxed/simple;
	bh=xnqZ8Na1MvIe310mvKsFtAXfEuLXGI9Blo89Rh6t3vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcmA+BZGrpb6PFhEds9o+/LyW4DA//oeFS0ZisCHslqQvRB/I8UhlRqoywBTzNeiJN+2ojiwKv8gIPxnYW+ZnHvQBOO71PWFdf/E9StiFUXqbUPrj5wdIFyDrzkxOw1kRW0j9wCpW6U6LbG6dG+8r9fl47aiHOIlB8oP3EW7cn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V4dm9UQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A8DC4CEE5;
	Tue,  8 Apr 2025 11:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112101;
	bh=xnqZ8Na1MvIe310mvKsFtAXfEuLXGI9Blo89Rh6t3vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V4dm9UQsVb5RbmbqEas7sotvIKf2DNHqtXpGw8gMGHu/EQLmPgCHiGmWAiVI2J4hm
	 ZkqxLMc2YbQLSv43245mOvOKe90SH63B2q1RzqqF6sImIQPIH1/r4kVnMS7MmFHx28
	 s5+EYMjSqUjougxXS2yklLx4THNtElVdOD3xIXPU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Agoston Lorincz <pipacsba@gmail.com>,
	All applicable <stable@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.14 674/731] ACPI: x86: Extend Lenovo Yoga Tab 3 quirk with skip GPIO event-handlers
Date: Tue,  8 Apr 2025 12:49:31 +0200
Message-ID: <20250408104929.945756575@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 2fa87c71d2adb4b82c105f9191e6120340feff00 upstream.

Depending on the secureboot signature on EFI\BOOT\BOOTX86.EFI the
Lenovo Yoga Tab 3 UEFI will switch its OSID ACPI variable between
1 (Windows) and 4 (Android(GMIN)).

In Windows mode a GPIO event handler gets installed for GPO1 pin 5,
causing Linux' x86-android-tables code which deals with the general
brokenness of this device's ACPI tables to fail to probe with:

[   17.853705] x86_android_tablets: error -16 getting GPIO INT33FF:01 5
[   17.859623] x86_android_tablets x86_android_tablets: probe with driver

which renders sound, the touchscreen, charging-management,
battery-monitoring and more non functional.

Add ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS to the existing quirks for this
device to fix this.

Reported-by: Agoston Lorincz <pipacsba@gmail.com>
Closes: https://lore.kernel.org/platform-driver-x86/CAMEzqD+DNXrAvUOHviB2O2bjtcbmo3xH=kunKr4nubuMLbb_0A@mail.gmail.com/
Cc: All applicable <stable@kernel.org>
Fixes: fe820db35275 ("ACPI: x86: Add skip i2c clients quirk for Lenovo Yoga Tab 3 Pro (YT3-X90F)")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patch.msgid.link/20250325210450.358506-1-hdegoede@redhat.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/x86/utils.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -374,7 +374,8 @@ static const struct dmi_system_id acpi_q
 			DMI_MATCH(DMI_PRODUCT_VERSION, "Blade3-10A-001"),
 		},
 		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
-					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
+					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY |
+					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
 	},
 	{
 		/* Medion Lifetab S10346 */



