Return-Path: <stable+bounces-58824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 142C192C073
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C971C20912
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461301CB30C;
	Tue,  9 Jul 2024 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVmpcejF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D6A1CB302;
	Tue,  9 Jul 2024 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542195; cv=none; b=Xpc9Pa2y/oLrUsvpHKhPekMbdeBH6Y1xqZtghQcXPMYPtrqsJSsqAe3hs7VxYSgk+MfyYidf3RcVjmv4+kyT68XEUu5RRRXimJ7aHROF9eGeD69WEKFW4M9kKpqYYpqGKGPSJuQNuIf0yx9aJwUaOp26ytVkf7Qo/xJd2oNmlmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542195; c=relaxed/simple;
	bh=g/iSBAHh91pkOCmMw11XZTHJhmkdyj/GQupiG5JC6rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUAswT0ehodXukPrdkb0oy9ecMuuA9HH9KhtsU2fiWQ5WBu7QY4IgBBKv78Fy98s+SnXjzZBNiE8hhoKWOLAJfmANspjm8XUWAIYtZS07fvWf7KGObfBTL3yrtfrUT+XSL/Pr21uIotPmJ0e1s/kh23BT/t5v2D6e5JTfa4QX5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVmpcejF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37341C3277B;
	Tue,  9 Jul 2024 16:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542194;
	bh=g/iSBAHh91pkOCmMw11XZTHJhmkdyj/GQupiG5JC6rQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KVmpcejFRGb6/ScmfoeRvdR47dSKqOsHhLXiThIZs6Ylqbp3z0Vc6CURDEMjxh+EY
	 Svnqbd98Yx0onqxrW25XzOTfKpXtjViTxO0JDKvbCjzZMCRF/OQW79/Dha+1L6xfDt
	 o/kXvDSub4+aY6xRTaml70+hPgpmvb4l72+2PVSsLhDGEvsqCBEHP+gvMgGEPGR3rt
	 l/e/ZwS083Cb8uiJF1NFjCu3oN4DwskWDGQ3qbmIQLp8d6hCNrJDxPZy0F4XqmtX1P
	 uWIvWKO1/auvHiXTSaPU07kPRNjyQinB8QeLeyDCZpgqBb3ArRG2lTOkiIj+IDOncl
	 poeMmc6LpYs5Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	Agathe Boutmy <agathe@boutmy.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 22/33] platform/x86: wireless-hotkey: Add support for LG Airplane Button
Date: Tue,  9 Jul 2024 12:21:48 -0400
Message-ID: <20240709162224.31148-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162224.31148-1-sashal@kernel.org>
References: <20240709162224.31148-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.38
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


