Return-Path: <stable+bounces-58871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB53B92C12A
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A144B27019
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D55218EA7C;
	Tue,  9 Jul 2024 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1lCvI0U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA5618EA75;
	Tue,  9 Jul 2024 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542340; cv=none; b=pZ75+NLaes3D/uo5/FZ04pJ8wlEOqZrW2uQJNQDSDZcOV1vyqOTJSdunNivBC1DqpEQZB43H7FfllgWQCR4IX8P1jsZE09uTflYQqSp8Ufi+3c6HeZxifs0Hnl4F7FFyKbzkkn9Hd8rzc8alP01zgpQ2z73Otl2dl6N961BfeiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542340; c=relaxed/simple;
	bh=LZZ17XDgV2Kao0BzvMIQ+DMGGJBWRkYanADGIMTYtrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OeeakTmflx4LaK4wRsRL9j5iIOtAhKOU7vWACx4gUom0xrhIZ+CjAtYZ4pO/tVJBUCUPilKgxRKnM5yr6OrjciNRC513jmxrmZvanij1q6w1yI3nFadRVdF/uvHa7TwvnPHI6ExHTr4+H9X62TES+oxGvBrCdr6FxNePVKIjbiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1lCvI0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CB0C3277B;
	Tue,  9 Jul 2024 16:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542339;
	bh=LZZ17XDgV2Kao0BzvMIQ+DMGGJBWRkYanADGIMTYtrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K1lCvI0UXB3BHGINkZgJuY2WkO7V7IQRF3klZHgbbEKA1TvhT3AHILf38dNa2VWT3
	 3+5PcmFmNv+9mBtRoC7M3CfPOIEFpqKtdGlkj1ZHRstLCLl4ujy9xSdhAA4ADKdN6x
	 TOWmtz/XHrLmdxdP7WX8ofW0N6fd6KZ16k70XGrv2JVUTS9E0cgBVfMsN7U2gtD43s
	 CKRu8fKIo+haL9UuXb/wGFT2XnzUOiFLwQLNZAe33bZEsm9/Iv9k593ICXGilnfIJP
	 Yc/C3A9/SqiiuBhXTGsqw7SX9YW8pl2UFjogi5Q3iDR+zHGZhBs/DJph9Jr1Ci3lsG
	 BB+Koi/tfykbw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	Agathe Boutmy <agathe@boutmy.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 09/17] platform/x86: wireless-hotkey: Add support for LG Airplane Button
Date: Tue,  9 Jul 2024 12:24:53 -0400
Message-ID: <20240709162517.32584-9-sashal@kernel.org>
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

[ Upstream commit 151e78a0b89ee6dec93382dbdf5b1ef83f9c4716 ]

The LGEX0815 ACPI device is used by the "LG Airplane Mode Button"
Windows driver for handling rfkill requests. When the ACPI device
receives an 0x80 ACPI notification, an rfkill event is to be
send to userspace.

Add support for the LGEX0815 ACPI device to the driver.

Tested-by: Agathe Boutmy <agathe@boutmy.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20240606233540.9774-2-W_Armin@gmx.de
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/wireless-hotkey.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/wireless-hotkey.c b/drivers/platform/x86/wireless-hotkey.c
index 11c60a2734468..61ae722643e5a 100644
--- a/drivers/platform/x86/wireless-hotkey.c
+++ b/drivers/platform/x86/wireless-hotkey.c
@@ -19,6 +19,7 @@ MODULE_AUTHOR("Alex Hung");
 MODULE_ALIAS("acpi*:HPQ6001:*");
 MODULE_ALIAS("acpi*:WSTADEF:*");
 MODULE_ALIAS("acpi*:AMDI0051:*");
+MODULE_ALIAS("acpi*:LGEX0815:*");
 
 static struct input_dev *wl_input_dev;
 
@@ -26,6 +27,7 @@ static const struct acpi_device_id wl_ids[] = {
 	{"HPQ6001", 0},
 	{"WSTADEF", 0},
 	{"AMDI0051", 0},
+	{"LGEX0815", 0},
 	{"", 0},
 };
 
-- 
2.43.0


