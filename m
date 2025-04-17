Return-Path: <stable+bounces-133864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC6CA92807
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350A8164E5B
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CF42620C4;
	Thu, 17 Apr 2025 18:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B4Qk3Cmd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E65256C7C;
	Thu, 17 Apr 2025 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914379; cv=none; b=bm6QgmBFejjdaXzLMbF+SZYMrmRio/mmzOIGU/JKbDaPpbxpFxI1oIHBDZ0y6uqOaAYYYvv2hWrpW7K0M1xO9kRqQp2LTQCeRPpa+5Y7yMPej/F9OLyEXpKa1CZJGtHCYTCdezegEjCsT8RFp7w7HWrisDYwE5P6XiqUuX4VFaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914379; c=relaxed/simple;
	bh=1lvlLXI/IFouDx2VNGj6I9P1TI1l5WMYuApVJAfFvjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1ah4M7opG2SM/A7/7RGKfROTsGG6Fa7FPwuMvrq+qHsLaV7VckdeVi8bSyUbx8l1qbp9LGUXC9XTOdN5IUPe+L9Z7OtHMG0yQK/gFfOu2dZBU3kejzQ+UD4DNnAhHp4rKZyMpChXOrFqVc/1jtc/bWL/xkCA1CLOs0yLkWGFhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B4Qk3Cmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308FDC4CEE4;
	Thu, 17 Apr 2025 18:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914378;
	bh=1lvlLXI/IFouDx2VNGj6I9P1TI1l5WMYuApVJAfFvjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B4Qk3Cmdhm2tJWzQkcZtF5JHRhRMAexoI/1E+oNGfJ0VpBt8eyKc3nxPvvfb1dPPe
	 zk9YBgWTcUu4COEdjt7FjL7/9LLq//qjs72wvrLNjfIj/wnhXjI5S8B9J0ks7akm27
	 skquHOAgmB8nufEuZ0aASsupCi+ibydXMNJX4Yto=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>,
	Paul Dino Jones <paul@spacefreak18.xyz>,
	=?UTF-8?q?Crist=C3=B3ferson=20Bueno?= <cbueno81@gmail.com>,
	Pablo Cisneros <patchkez@protonmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 178/414] HID: pidff: Define values used in pidff_find_special_fields
Date: Thu, 17 Apr 2025 19:48:56 +0200
Message-ID: <20250417175118.603929254@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>

[ Upstream commit 1c12f136891cf4d2d4e6aa202d671a9d2171a716 ]

Makes it clear where did these values came from

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Reviewed-by: Michał Kopeć <michal@nozomi.space>
Reviewed-by: Paul Dino Jones <paul@spacefreak18.xyz>
Tested-by: Paul Dino Jones <paul@spacefreak18.xyz>
Tested-by: Cristóferson Bueno <cbueno81@gmail.com>
Tested-by: Pablo Cisneros <patchkez@protonmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/usbhid/hid-pidff.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 42c951a1d65bf..bd913d57e4d75 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -48,6 +48,14 @@ static const u8 pidff_reports[] = {
 /* device_control is really 0x95, but 0x96 specified as it is the usage of
 the only field in that report */
 
+/* PID special fields */
+
+#define PID_EFFECT_TYPE			0x25
+#define PID_DIRECTION			0x57
+#define PID_EFFECT_OPERATION_ARRAY	0x78
+#define PID_BLOCK_LOAD_STATUS		0x8b
+#define PID_DEVICE_CONTROL_ARRAY	0x96
+
 /* Value usage tables used to put fields and values into arrays */
 
 #define PID_EFFECT_BLOCK_INDEX	0
@@ -1056,23 +1064,24 @@ static int pidff_find_special_fields(struct pidff_device *pidff)
 
 	pidff->create_new_effect_type =
 		pidff_find_special_field(pidff->reports[PID_CREATE_NEW_EFFECT],
-					 0x25, 1);
+					 PID_EFFECT_TYPE, 1);
 	pidff->set_effect_type =
 		pidff_find_special_field(pidff->reports[PID_SET_EFFECT],
-					 0x25, 1);
+					 PID_EFFECT_TYPE, 1);
 	pidff->effect_direction =
 		pidff_find_special_field(pidff->reports[PID_SET_EFFECT],
-					 0x57, 0);
+					 PID_DIRECTION, 0);
 	pidff->device_control =
 		pidff_find_special_field(pidff->reports[PID_DEVICE_CONTROL],
-			0x96, !(pidff->quirks & HID_PIDFF_QUIRK_PERMISSIVE_CONTROL));
+			PID_DEVICE_CONTROL_ARRAY,
+			!(pidff->quirks & HID_PIDFF_QUIRK_PERMISSIVE_CONTROL));
 
 	pidff->block_load_status =
 		pidff_find_special_field(pidff->reports[PID_BLOCK_LOAD],
-					 0x8b, 1);
+					 PID_BLOCK_LOAD_STATUS, 1);
 	pidff->effect_operation_status =
 		pidff_find_special_field(pidff->reports[PID_EFFECT_OPERATION],
-					 0x78, 1);
+					 PID_EFFECT_OPERATION_ARRAY, 1);
 
 	hid_dbg(pidff->hid, "search done\n");
 
-- 
2.39.5




