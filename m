Return-Path: <stable+bounces-58852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8198592C0C0
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B03328539C
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7E017B02E;
	Tue,  9 Jul 2024 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXBiomHT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7AC17B024;
	Tue,  9 Jul 2024 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542276; cv=none; b=AvJ2mmqK6+/mHE7QgK5VzhjCH5vUBicnPwTGIbJNV3jpUgLvFvBjl/1DFNwzKCo68KYje0Fhs6T6Qk6gnGQ5CFodwcTZReLCOlNzH19FhQhObGy2TEUSG4LidBl6cbyI1Sko16/OuiiT5vqRns6hsl3t3WHTrFHx452thNF19R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542276; c=relaxed/simple;
	bh=2thuxLIG58QD3tl9afJ7P4pjopLNj/nX0/INAE9ZgTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+utmHl9WUnuA1okxE3+1ysrOq9ePxEzw6Ri0wxiy8FlMh8oJZ9FjfBjh2CsPXYYFxAeCBQIUDPpZ4kV0p0K3Ewdh45Q6JxUBS6hBhLylI/Ig//izTVq5CYk7zhlVbT4YKj1O1xG/n4qTjwsTjHWX5zSfw1dzR5kHhLMbvw+3LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXBiomHT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CE1C4AF0A;
	Tue,  9 Jul 2024 16:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542276;
	bh=2thuxLIG58QD3tl9afJ7P4pjopLNj/nX0/INAE9ZgTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oXBiomHThy7sf/y4MTPAPHmo90Y3fV9sjyr5EcP/NCtVRCRnbVlLf3c5nw4oXGTwS
	 ulqq1OS1R3V6epTjALz61Akp6e7reRzIYd3NwVUvIM0pmEpfGbFX96FguN+F0/AeX3
	 ctbakOSn9+3wjP8ZWTcr/oPqXXF463pkp0fRePl67AzNizOVqm0TyOu8gX0/LYJBcS
	 AXDKZRWn8zK0Sht0tRbD3I9yhh0fkL4TbeEqfMYGzXDRWX58y4Z8qWMT8ihsfvPMhh
	 VEC4HY8y9mkxrTh1tlvxbJgcgO9JzAIe50E2GejvP2fwspE0xkBrHX1q8ZslLfkiM3
	 7bLKKPCNKjDOA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	Agathe Boutmy <agathe@boutmy.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	matan@svgalib.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 17/27] platform/x86: lg-laptop: Remove LGEX0815 hotkey handling
Date: Tue,  9 Jul 2024 12:23:31 -0400
Message-ID: <20240709162401.31946-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162401.31946-1-sashal@kernel.org>
References: <20240709162401.31946-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.97
Content-Transfer-Encoding: 8bit

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit 413c204595ca98a4f33414a948c18d7314087342 ]

The rfkill hotkey handling is already provided by the wireless-hotkey
driver. Remove the now unnecessary rfkill hotkey handling to avoid
duplicating functionality.

The ACPI notify handler still prints debugging information when
receiving ACPI notifications to aid in reverse-engineering.

Tested-by: Agathe Boutmy <agathe@boutmy.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20240606233540.9774-3-W_Armin@gmx.de
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/lg-laptop.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index 332868b140ed5..aa063c3c935b5 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -84,7 +84,6 @@ static const struct key_entry wmi_keymap[] = {
 					  * this key both sends an event and
 					  * changes backlight level.
 					  */
-	{KE_KEY, 0x80, {KEY_RFKILL} },
 	{KE_END, 0}
 };
 
@@ -272,14 +271,7 @@ static void wmi_input_setup(void)
 
 static void acpi_notify(struct acpi_device *device, u32 event)
 {
-	struct key_entry *key;
-
 	acpi_handle_debug(device->handle, "notify: %d\n", event);
-	if (inited & INIT_SPARSE_KEYMAP) {
-		key = sparse_keymap_entry_from_scancode(wmi_input_dev, 0x80);
-		if (key && key->type == KE_KEY)
-			sparse_keymap_report_entry(wmi_input_dev, key, 1, true);
-	}
 }
 
 static ssize_t fan_mode_store(struct device *dev,
-- 
2.43.0


