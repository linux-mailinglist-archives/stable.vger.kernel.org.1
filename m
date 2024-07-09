Return-Path: <stable+bounces-58790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBAC92C004
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3B41C2368B
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92301AE0AF;
	Tue,  9 Jul 2024 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vdd3Wi16"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D3D1AE0A1;
	Tue,  9 Jul 2024 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542071; cv=none; b=Fk7mZ+pDY3UfuGNVfRHxqzaHkz/XVn4DopCsO6lHgnV/i+ol2b+onMGpxOvOWUrXqsCbhtCY7NmReVtAV0W5udWfVqXPFT0oreiIYHY9uYzelnVv8YhgXsom0Wvs3tTMVQrj1EMLl0W/8r8a0V9M5/SUYmvog1HiwE+HahgDBR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542071; c=relaxed/simple;
	bh=Frt0GamFkybP5R2Lfx6FSNEZioKPRhJeXp8EH1lCfeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avMqIbc+EwwcO1Qm8wSW7Y1u8+XvrXckXCFvQXIifcu+LNYbsIrVg2LjA4eK6H3m1EAnmb3tJGq+ToTtBle36CyLKh2snrLJchk2svsl8pSfj+4HlOwcqllHE5PEE2yYegh/r8v2R1CQ1LpHm2SdTx80LGtnaAURrA0sdH5NGBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vdd3Wi16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C403C3277B;
	Tue,  9 Jul 2024 16:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542071;
	bh=Frt0GamFkybP5R2Lfx6FSNEZioKPRhJeXp8EH1lCfeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vdd3Wi16YfRt0YOLnXyCCFtO4iZfUAW8IcnId+VR7OW2T98g4k3qN5dFbPLTkzasH
	 GYynTdTdTOE46HaksJuwOgZRW2XDPHZteVCT/b+3FwxpzDEcDHWq3W1LlWMvlj/Z0n
	 dNk6DzpQzrRj77gR57yTBkmYuvZDzw5tleEqxS6Xxll1jGKsqVGYMScYQOQ/so+ChG
	 H4mUxJCBUW5Fn36eaaa26nQcPxD5WSq8FJS76Lj81ZLF/itxREBEDumxghAPHLT5MA
	 fFSXM2O9nE8vOC0ze9xPpeeArSLm1Dci6wvCNI6oZngbu6r32nb/CG3RCWpmyeUjkM
	 g92UbLU6Rtz6Q==
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
Subject: [PATCH AUTOSEL 6.9 28/40] platform/x86: lg-laptop: Remove LGEX0815 hotkey handling
Date: Tue,  9 Jul 2024 12:19:08 -0400
Message-ID: <20240709162007.30160-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162007.30160-1-sashal@kernel.org>
References: <20240709162007.30160-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.8
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
index e714ee6298dda..5d4df782ce8e1 100644
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


