Return-Path: <stable+bounces-58872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A066992C0F7
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57770282F6B
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50D01A38D2;
	Tue,  9 Jul 2024 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndBRHmz8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD3D18EA9A;
	Tue,  9 Jul 2024 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542341; cv=none; b=aFugSKuZSwdUmeKR1ka0qMJiIuSWP0LtMs8Bo+SpU7EF1GB/XhR8draOPMT+b4c79TFFuh0dGFX7y3OR/bcs3D4DuUV1gXwF2wWwQf2fCMRM6KwPRncNlnLFWpEb+xxxnsyyMcKut5yIl0vxKnYkmhUAsCMCexxkiTRPKb/TKcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542341; c=relaxed/simple;
	bh=0Mm/RRD2TDFE93S7oycs6pxQPz/C0riIGqpqiXCPZpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZx+RSQoZHA4GY3CXOeOm8L91IOvI2petZJ2QV+6D4A8zony8bU8058VbpLykiuwoIQA7UfcEv6fDzYisTfL6KfxJ1f8eSCzeNlJYLnmRVGOu/641qXl5LNyWXME8biLhSoAHzniqe7yRVD4GLkuiLt+3YreyYU5WnX2ewsFIYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndBRHmz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E4EC3277B;
	Tue,  9 Jul 2024 16:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542341;
	bh=0Mm/RRD2TDFE93S7oycs6pxQPz/C0riIGqpqiXCPZpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ndBRHmz8c2VhNK8SWsIPjnK9NFrktEt8cVXpAOnHrdfdLFWrQIS56wTCAZPZ6AH4C
	 RSNtYH8ioPhOuB54R86zMOE4FNGu8mBEUlrhZfLGffWWVRwrdsb/+8schh2j1S6QNQ
	 o4W0EfZd8Nyr3bpT6YvM1VP5GTNAHqPP2+SRPupUXO8xlk6NC7W48asVjRM6wZKMzU
	 rf5Kp87YexZam0rEM7I89x4UxaT9zqnR/lGYXkqBdR8kN+887eSYUpE9nkYaZzlQKv
	 8bu1Din/bjWi/Ouf4qtyTF0zpU2LrHCjN7BMkQIBmYV08nmS2inzN2W6HQpdtAOL+4
	 1tNkaW89hoUPw==
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
Subject: [PATCH AUTOSEL 5.15 10/17] platform/x86: lg-laptop: Remove LGEX0815 hotkey handling
Date: Tue,  9 Jul 2024 12:24:54 -0400
Message-ID: <20240709162517.32584-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162517.32584-1-sashal@kernel.org>
References: <20240709162517.32584-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.162
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
index 88b551caeaaf4..96960f96f775c 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -83,7 +83,6 @@ static const struct key_entry wmi_keymap[] = {
 					  * this key both sends an event and
 					  * changes backlight level.
 					  */
-	{KE_KEY, 0x80, {KEY_RFKILL} },
 	{KE_END, 0}
 };
 
@@ -271,14 +270,7 @@ static void wmi_input_setup(void)
 
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


