Return-Path: <stable+bounces-58902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BE092C15F
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601AE1F22F28
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6F91B30C7;
	Tue,  9 Jul 2024 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3mHz2Fu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9C91B30BF;
	Tue,  9 Jul 2024 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542434; cv=none; b=Ywx3kWc86Fmxdsm9JKnyPywtCKlkcF+dejHw8i9MGO7p4Gsz6U8hO4TKRokPLk7sDbr3LI8QaYuBtYmimB5O9VKFrbBU2Px3dJDDj4OFIqYWN+G8BoCfGlnsTxdZrYaSMOX1t9bSHY81osqfC0txs1dHlzrfnBuR6wvZQeapJF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542434; c=relaxed/simple;
	bh=SvSyKgJcLYmq1DNdF22/fal9rcm9rxHea1jkP8LXxYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZPvD0aPvKn6lxaalePi9hI+sTVXGKs3R058MGtKpKhfYaHYojE9ZvG+Gh6NHjhcenV95T4DT3s8Z3mXJWtQiDsnaIQnVIRccNyMwsHYBZVTOv5YtQfuIcYUYvzI6DthZAldeBY4m5fS+r4rq9KiIXsUf3jckxHYSzMHu5gSjAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3mHz2Fu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4E2C32782;
	Tue,  9 Jul 2024 16:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542434;
	bh=SvSyKgJcLYmq1DNdF22/fal9rcm9rxHea1jkP8LXxYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J3mHz2FuuiQDMg79CJK26lIjnodCo7zMO4Sw7Od8GLwWcOPgwPfteGR7s4YTgLHzJ
	 wUnolLOTTzke53Mjne5bNK2uJW5gytJ2M4XoPU/NplK0gaCAaXqnVRJfct0oCwa3I7
	 yAq5u9ePRXdn0gArbg2UMq3Lv6fpfSkK3FgsS4/pbA5dF64iIzcDTx2Bcf1wVLRk60
	 kaI6FuvixuJZYZNEGiwB3J3eUTUJ+t5Ep048KM9jW3hTPZLdge1IlX/lBFpWwTmLyt
	 Tyg/Da5G4wwEw/9XougaNsuvcSUBXfq0T/7jPRNSwPbutGnOcMbNSskl72rQb1yooN
	 oTpUPA1e0xfHA==
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
Subject: [PATCH AUTOSEL 5.4 09/11] platform/x86: lg-laptop: Change ACPI device id
Date: Tue,  9 Jul 2024 12:26:42 -0400
Message-ID: <20240709162654.33343-9-sashal@kernel.org>
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

[ Upstream commit 58a54f27a0dac81f7fd3514be01012635219a53c ]

The LGEX0815 ACPI device id is used for handling hotkey events, but
this functionality is already handled by the wireless-hotkey driver.

The LGEX0820 ACPI device id however is used to manage various
platform features using the WMAB/WMBB ACPI methods. Use this ACPI
device id to avoid blocking the wireless-hotkey driver from probing.

Tested-by: Agathe Boutmy <agathe@boutmy.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20240606233540.9774-4-W_Armin@gmx.de
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/lg-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index 27c456b517850..ff7ed8882aacb 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -653,7 +653,7 @@ static int acpi_remove(struct acpi_device *device)
 }
 
 static const struct acpi_device_id device_ids[] = {
-	{"LGEX0815", 0},
+	{"LGEX0820", 0},
 	{"", 0}
 };
 MODULE_DEVICE_TABLE(acpi, device_ids);
-- 
2.43.0


