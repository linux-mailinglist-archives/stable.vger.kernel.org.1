Return-Path: <stable+bounces-58851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB77B92C0BC
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16071F248DD
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896A63DAC09;
	Tue,  9 Jul 2024 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmG7zhDV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463093DABFF;
	Tue,  9 Jul 2024 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542275; cv=none; b=KT0nByhQ4EJdARPk+Rl0d5Cpa9W+Lh8vMKdMkx7MSlXOaTQF7ivtpvQNVoP2/MNNiXvnTCdJMwWJ9GRkkHWTOtKEF7Y6B5ToQ2VxcJBKizZAjOMjGJZp4yORoJYkJeI6ikM3KeWZL+2tSN0+iwm2WFwgbADGYIsuCFKjzPsoYyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542275; c=relaxed/simple;
	bh=LZZ17XDgV2Kao0BzvMIQ+DMGGJBWRkYanADGIMTYtrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NTZnPuw4+q+jEAj39zYIEotaDeFMRjAbVtU2zyJ2QJWDTL9jRbXDhmMVLJPsL8BSOidS/7icrdYxKkYcWyabYjOs9t8FhmVHcNOzvNm1DDPjsCcH/nNhzqgHR1hG12Ewv/uXYKevLw4lQVtqZ1i2t3zewLBWM5vuFkgy0tZwtv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmG7zhDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E718C4AF07;
	Tue,  9 Jul 2024 16:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542275;
	bh=LZZ17XDgV2Kao0BzvMIQ+DMGGJBWRkYanADGIMTYtrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PmG7zhDVD6PRSfwuProDpcOO2g8Wt4nhKPULCihHznKjTuOZYOCpCtUvdWbE8sDV7
	 JwqJzJjK0qHICxfWJGtPiHsLT5Wl6i1hsa0AqmlB8dKLkQKZh4xp1MKwEdY9dvtwHX
	 YAEclL9Mum8XLQrkIEqG7hJ7xPxayv/q+6D/qzUsVg9N1Xd/d6q0B3PCWYjgAUQRLP
	 lOQoIo9kOIcYcKUgfgFOwvKqzBapSbYzpKifiyJAdQSVXRPGMl851DdyqaRR6JYODA
	 z+kYuTiCUMk7aGdXMQSU+bCODfZfibeKOmyZMQSgVLeSzK8vnYO+H1zmfApvUBq/qM
	 Pra5nR2gTJRHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	Agathe Boutmy <agathe@boutmy.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 16/27] platform/x86: wireless-hotkey: Add support for LG Airplane Button
Date: Tue,  9 Jul 2024 12:23:30 -0400
Message-ID: <20240709162401.31946-16-sashal@kernel.org>
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


