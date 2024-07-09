Return-Path: <stable+bounces-58789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B740092C001
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85D61C235DE
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76901AE086;
	Tue,  9 Jul 2024 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7JwsFmU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A142819DF8B;
	Tue,  9 Jul 2024 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542069; cv=none; b=QEu6CHAmnZHyklkXyffLkex2LJtjCrUKPHTqsnMa3ZFrMoTOgdQCLW1orLDc2M2A4WAXAmWiLkXF14Cm2/5VNKWkAX6MwtgITVXxuxujYodG/hhAsy601r6He/Da3lVZa/A0NCjR5ToSodWFOMDlt+3wbp+gz5Q+5NZTENe/ess=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542069; c=relaxed/simple;
	bh=g/iSBAHh91pkOCmMw11XZTHJhmkdyj/GQupiG5JC6rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QFKF5QSQJGesLcDhFeYJ2muqrMo4HUWXjqFNXaVIUxCDXbgoVFW9omjIRyY9gKXudRHOfCY9HQYXfBzFuSA46kyLOfxLFQrD64nXFgKtBwZEdZDGFpUrTmamoEfNcGYIb4OdBb6/PidKBxXKqJ9/5YXcFIR/jBIAtESHPISe9G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7JwsFmU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C05CC32782;
	Tue,  9 Jul 2024 16:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542069;
	bh=g/iSBAHh91pkOCmMw11XZTHJhmkdyj/GQupiG5JC6rQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A7JwsFmU7Gw0C+Z7ICORVQO4GLaUXRdITtY5JnzcgYEbP/pod4RcA37sgoghZImBU
	 2045HF+wg2xdmy7GxxJx3U3OJKwcqdcoVAcdBGZGpWvS5KT4Lv8ADOAgiSli1hJEbT
	 tC9rp9vkij/JmjWhzAh9Id2sRl5RL9F7Gv3luuMbr7fIIvVEisapkX91E1PYB2WMdZ
	 1W5CrmHwLr7kjuUnZU396hhfQuk2Ssa6hmiaBRofutWYYUmxxilbD3Ux+6YPx0S7h4
	 ybjkS+d9l5MgxSHs1JaOs2ZX97zwg/YFKGQaz333EXEVsT4YK09x4IRNvFtAbr0DtW
	 VvOPoK0dNZLFA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	Agathe Boutmy <agathe@boutmy.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 27/40] platform/x86: wireless-hotkey: Add support for LG Airplane Button
Date: Tue,  9 Jul 2024 12:19:07 -0400
Message-ID: <20240709162007.30160-27-sashal@kernel.org>
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
index 4422863f47bbe..01feb6e6787f2 100644
--- a/drivers/platform/x86/wireless-hotkey.c
+++ b/drivers/platform/x86/wireless-hotkey.c
@@ -19,6 +19,7 @@ MODULE_AUTHOR("Alex Hung");
 MODULE_ALIAS("acpi*:HPQ6001:*");
 MODULE_ALIAS("acpi*:WSTADEF:*");
 MODULE_ALIAS("acpi*:AMDI0051:*");
+MODULE_ALIAS("acpi*:LGEX0815:*");
 
 struct wl_button {
 	struct input_dev *input_dev;
@@ -29,6 +30,7 @@ static const struct acpi_device_id wl_ids[] = {
 	{"HPQ6001", 0},
 	{"WSTADEF", 0},
 	{"AMDI0051", 0},
+	{"LGEX0815", 0},
 	{"", 0},
 };
 
-- 
2.43.0


