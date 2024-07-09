Return-Path: <stable+bounces-58901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F02D592C15D
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB061C21FED
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910081B30A8;
	Tue,  9 Jul 2024 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGvRHEZe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE511ACA05;
	Tue,  9 Jul 2024 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542433; cv=none; b=VK60qPWSNVb91M2F1dbalQbnVKdoe9Ti2422fBOz5oIuDiWlElA4QL2KVPAkAQyybFU18xr4oKLlM5RV397LV9HsICs5F+OaaVEGXAp5WGV3qM0NYTTtVEzWkhNtDBCDRlxv1AG8XtRB8yMYdwJZmTF8cXFnyc6JAdLKbmx4w6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542433; c=relaxed/simple;
	bh=5VDFUmzKTnMHCF3ZvIqqg15JyQ/B7y7r2t3ijMGBr64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIJr6eap7IStYVH/e9C7b5ZPkEioSQnYNatH70Wgw+VlniqpHDe4mPQsgLsFQJJfcYqNrS1XRsGMHgm88uVDWXtDEKGjZwq3CX2ASZVRA7wSmZg5WCZPkfgV52S6Zl616BwKPPZclmTt9m15xOTsAPwcn16Kj7crPGz0rBfKo3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGvRHEZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DFDC32786;
	Tue,  9 Jul 2024 16:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542432;
	bh=5VDFUmzKTnMHCF3ZvIqqg15JyQ/B7y7r2t3ijMGBr64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HGvRHEZeSkUOQ1edz1v0CFo9fczBOSU1LZfKmJW8TIVMyKydtFjXgBXMzA76v2z11
	 BiVIgTWhWQw+K9+kUytS6d576fynVswaBAJ5AhS03GjKoUEr/V/UyaEFykV70YNgcl
	 2Oq9TRP8GrEvZrsgcwcgzJH7ioJxU14h9e0h4fEuCNFsho+OxYp6MetxN19PFsGusa
	 MlsFlUnyL13iRLAJkCy6yurayNPqx0jayjtbbRLCtKdKUZIx4luuTP4m1GR7CFWFpN
	 LnT7BKlnj9vdsbWK0ScLRfycrWx1XTW6csVHJJJ/9Al3EqYdMalxrVRV+CReqTe7Bs
	 hDqrxp7pafLNQ==
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
Subject: [PATCH AUTOSEL 5.4 08/11] platform/x86: lg-laptop: Remove LGEX0815 hotkey handling
Date: Tue,  9 Jul 2024 12:26:41 -0400
Message-ID: <20240709162654.33343-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162654.33343-1-sashal@kernel.org>
References: <20240709162654.33343-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.279
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
index c0bb1f864dfeb..27c456b517850 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -79,7 +79,6 @@ static const struct key_entry wmi_keymap[] = {
 					  * this key both sends an event and
 					  * changes backlight level.
 					  */
-	{KE_KEY, 0x80, {KEY_RFKILL} },
 	{KE_END, 0}
 };
 
@@ -261,14 +260,7 @@ static void wmi_input_setup(void)
 
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


