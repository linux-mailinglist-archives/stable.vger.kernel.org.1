Return-Path: <stable+bounces-128843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CB4A7F7B9
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFCD43BE51B
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 08:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EB2263C8E;
	Tue,  8 Apr 2025 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yv0XL70v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3DE2594
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744100445; cv=none; b=tgU6ydXPo/vZ6n0YaSxtrNE0AKkYB5dZjfltE3bX5vyeCwng+Rwx8ZmGiKXUZ84BZQ7PKMbxqKt8vf4odLnUVng21FbSvDpU/eQLpQhbk45kB9R5Vf4wMhlU/eTYs50RSdFkGTg10dwFc2Qgeipme95E08eGqE+FZwzuSXqQyEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744100445; c=relaxed/simple;
	bh=r5X0my1lXKrrn6gaMeTJMlkN+ZSguONTUwBUc9fToCE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S2jJRLWbHQB4T3J4Sukaq9OevPVas1eY2jYF8M7cd6l2SYxgT+cHKIK+VEHVqji/y7U3eu811It5h2dk4oL5XdKoNE4DXCZ5KtFa6M5GbyC4OSSIzkhKKT4F3bsy4k9NugIts4bPRCqszBkZtI2x5pAx1rSMvZDIysFz6w78fwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yv0XL70v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B04C4CEE5;
	Tue,  8 Apr 2025 08:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744100445;
	bh=r5X0my1lXKrrn6gaMeTJMlkN+ZSguONTUwBUc9fToCE=;
	h=Subject:To:Cc:From:Date:From;
	b=yv0XL70vmnuzdRhXTTIXyE8GaXEqJBCa2HRK3RCILmhr0EIMRAHO8+STyOaPlcBe4
	 9pUFf+RQGDRN5Vh+bQlRK9bmHw+2wnvo+XqY330T/L2EWruFhuF4kEeMkWNFJQnuoX
	 o0kmZ16ZyWSgEQAsM8HB26vQTl49y0g0ia07WkfQ=
Subject: FAILED: patch "[PATCH] ACPI: x86: Extend Lenovo Yoga Tab 3 quirk with skip GPIO" failed to apply to 6.1-stable tree
To: hdegoede@redhat.com,pipacsba@gmail.com,rafael.j.wysocki@intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Apr 2025 10:19:12 +0200
Message-ID: <2025040812-alumni-tightness-cb66@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2fa87c71d2adb4b82c105f9191e6120340feff00
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040812-alumni-tightness-cb66@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2fa87c71d2adb4b82c105f9191e6120340feff00 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 25 Mar 2025 22:04:50 +0100
Subject: [PATCH] ACPI: x86: Extend Lenovo Yoga Tab 3 quirk with skip GPIO
 event-handlers

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

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 068c1612660b..4ee30c2897a2 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -374,7 +374,8 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "Blade3-10A-001"),
 		},
 		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
-					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
+					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY |
+					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
 	},
 	{
 		/* Medion Lifetab S10346 */


