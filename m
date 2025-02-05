Return-Path: <stable+bounces-112485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70712A28CEC
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7EC3A7B93
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 13:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EAF14A4E9;
	Wed,  5 Feb 2025 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wqJkWiW1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F171519AA;
	Wed,  5 Feb 2025 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763727; cv=none; b=SM44NJbrlb9eTjqVBP0dWZf4uXavUVMnG9cF418w/hZpV3wfpmbSQq5tG6sGCfQrj9mWFSHUxqVN770NyOJLpP+B6MsxFNdvnaQ/ogZbXPIKkpDsM74FXlONsC6CykeQQQqF+rH2yAnPhjr69v8L+C2JTjfAPKfyqcqe+flNFnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763727; c=relaxed/simple;
	bh=AAy9Tz6yq+by6criQkW4neTnm+5mJ6+A03S0SzOo2qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iy4Y445knSb8NRdPvhTwmzt8RpHWboCri0o4jLcqwxiizRWvsOAApGSf59YTThI7hxb5FsGSuBR+G6s2G1U5cKx6c88YSG432Km/Fh3fA0YfgZ9ri3gsn9ixrXZkuLUH3t9KZWEOyzMbyzlsIW8vhC0VzOZXFxWQ5YxcrUOKMmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wqJkWiW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25888C4CED1;
	Wed,  5 Feb 2025 13:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738763727;
	bh=AAy9Tz6yq+by6criQkW4neTnm+5mJ6+A03S0SzOo2qI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wqJkWiW1Y90mAYAqO0QItJedA/SpaH6JxUVxilwRoAlS5XpXfDI9viUIMVc5lGhVd
	 nmysQf+DcVZHKCwH9VR2gRgvR4T9opNKZqHbjCQUoRzBYVF7mINFnDFRHJUf1G7kTV
	 F7V00syOFnjmysoU57kXPKHTF+t8JqAC7LyYi07U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Terry Tritton <terry.tritton@linaro.org>,
	Aseda Aboagye <aaboagye@chromium.org>,
	Carlos Llamas <cmllamas@google.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 100/393] HID: fix generic desktop D-Pad controls
Date: Wed,  5 Feb 2025 14:40:19 +0100
Message-ID: <20250205134424.120351548@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Terry Tritton <terry.tritton@linaro.org>

[ Upstream commit 80818fdc068eaab729bb793d790ae9fd053f7053 ]

The addition of the "System Do Not Disturb" event code caused the Generic
Desktop D-Pad configuration to be skipped. This commit allows both to be
configured without conflicting with each other.

Fixes: 22d6d060ac77 ("input: Add support for "Do Not Disturb"")
Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
Reviewed-by: Aseda Aboagye <aaboagye@chromium.org>
Reviewed-by: Carlos Llamas <cmllamas@google.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-input.c | 37 +++++++++++++++++--------------------
 include/linux/hid.h     |  1 +
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index fda9dce3da998..9d80635a91ebd 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -810,10 +810,23 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			break;
 		}
 
-		if ((usage->hid & 0xf0) == 0x90) { /* SystemControl*/
-			switch (usage->hid & 0xf) {
-			case 0xb: map_key_clear(KEY_DO_NOT_DISTURB); break;
-			default: goto ignore;
+		if ((usage->hid & 0xf0) == 0x90) { /* SystemControl & D-pad */
+			switch (usage->hid) {
+			case HID_GD_UP:	   usage->hat_dir = 1; break;
+			case HID_GD_DOWN:  usage->hat_dir = 5; break;
+			case HID_GD_RIGHT: usage->hat_dir = 3; break;
+			case HID_GD_LEFT:  usage->hat_dir = 7; break;
+			case HID_GD_DO_NOT_DISTURB:
+				map_key_clear(KEY_DO_NOT_DISTURB); break;
+			default: goto unknown;
+			}
+
+			if (usage->hid <= HID_GD_LEFT) {
+				if (field->dpad) {
+					map_abs(field->dpad);
+					goto ignore;
+				}
+				map_abs(ABS_HAT0X);
 			}
 			break;
 		}
@@ -844,22 +857,6 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		if (field->application == HID_GD_SYSTEM_CONTROL)
 			goto ignore;
 
-		if ((usage->hid & 0xf0) == 0x90) {	/* D-pad */
-			switch (usage->hid) {
-			case HID_GD_UP:	   usage->hat_dir = 1; break;
-			case HID_GD_DOWN:  usage->hat_dir = 5; break;
-			case HID_GD_RIGHT: usage->hat_dir = 3; break;
-			case HID_GD_LEFT:  usage->hat_dir = 7; break;
-			default: goto unknown;
-			}
-			if (field->dpad) {
-				map_abs(field->dpad);
-				goto ignore;
-			}
-			map_abs(ABS_HAT0X);
-			break;
-		}
-
 		switch (usage->hid) {
 		/* These usage IDs map directly to the usage codes. */
 		case HID_GD_X: case HID_GD_Y: case HID_GD_Z:
diff --git a/include/linux/hid.h b/include/linux/hid.h
index af55a25db91b0..774cb25dec34c 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -218,6 +218,7 @@ struct hid_item {
 #define HID_GD_DOWN		0x00010091
 #define HID_GD_RIGHT		0x00010092
 #define HID_GD_LEFT		0x00010093
+#define HID_GD_DO_NOT_DISTURB	0x0001009b
 /* Microsoft Win8 Wireless Radio Controls CA usage codes */
 #define HID_GD_RFKILL_BTN	0x000100c6
 #define HID_GD_RFKILL_LED	0x000100c7
-- 
2.39.5




