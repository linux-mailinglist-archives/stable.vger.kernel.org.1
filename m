Return-Path: <stable+bounces-193574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F04C4A7BF
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10D91884C13
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE93926561D;
	Tue, 11 Nov 2025 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r/UtQWYP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC71263F28;
	Tue, 11 Nov 2025 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823505; cv=none; b=XR7eG4QQWTyX01DkCcxuewcxLV7MjW0P6kfUFQhKy4ZXFEMA3RtBsVAnYNFndJfLPqeYi6HxY6UQ1s7vGHrplGiSqoPFTi23KOIhOoWjjCfZEKQEI6Y7Z55Q99m3nNoQ0lq/Ktki5DEncqXJ6zJ/UdOKF3DaGWcxWHhG314DLVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823505; c=relaxed/simple;
	bh=178JY0U8NHxp/XHtIUV4aM2ad0RLDf37vzKxhqkhNWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=teIWPt8dRtBl5ooyyWQbtLi7CQVTMCMz2nLhutX+D54MBNwRaozY30FUDFHH7+3JgPe2kWvbEqPf6IgGYrmUxz3T5k2ho2vHw+L1316pVzd7iGt73yqBs1PyKhYqw34LAW6/I001SPc710ukwm1bRa7/vhFGYVJZ7HXWGyLBf58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r/UtQWYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D71FC113D0;
	Tue, 11 Nov 2025 01:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762823505;
	bh=178JY0U8NHxp/XHtIUV4aM2ad0RLDf37vzKxhqkhNWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r/UtQWYPgMCyDKtw4k6Vf4HQ3cQsoyJ9MHkToJCsKeuxbrVxpYyKhL+CeeNLM8wEF
	 ZMyk5fyw55gqSFu1BVXfWooTGgBymo/OK+V/l+BMT02vbstJJMMyBpm1bjDphVSPH5
	 zKR6xRHlF0Nn5cLnfCVEM1bGb5WbcEn1O8DYpOTI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 313/849] HID: pidff: PERMISSIVE_CONTROL quirk autodetection
Date: Tue, 11 Nov 2025 09:38:03 +0900
Message-ID: <20251111004543.979656481@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
User-Agent: quilt/0.69
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>

[ Upstream commit c2dc9f0b368c08c34674311cf78407718d5715a7 ]

Fixes force feedback for devices built with MMOS firmware and many more
not yet detected devices.

Update quirks mask debug message to always contain all 32 bits of data.

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/usbhid/hid-pidff.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index c6b4f61e535d5..711eefff853bb 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -1151,8 +1151,16 @@ static int pidff_find_special_fields(struct pidff_device *pidff)
 					 PID_DIRECTION, 0);
 	pidff->device_control =
 		pidff_find_special_field(pidff->reports[PID_DEVICE_CONTROL],
-			PID_DEVICE_CONTROL_ARRAY,
-			!(pidff->quirks & HID_PIDFF_QUIRK_PERMISSIVE_CONTROL));
+			PID_DEVICE_CONTROL_ARRAY, 1);
+
+	/* Detect and set permissive control quirk */
+	if (!pidff->device_control) {
+		pr_debug("Setting PERMISSIVE_CONTROL quirk\n");
+		pidff->quirks |= HID_PIDFF_QUIRK_PERMISSIVE_CONTROL;
+		pidff->device_control = pidff_find_special_field(
+			pidff->reports[PID_DEVICE_CONTROL],
+			PID_DEVICE_CONTROL_ARRAY, 0);
+	}
 
 	pidff->block_load_status =
 		pidff_find_special_field(pidff->reports[PID_BLOCK_LOAD],
@@ -1492,7 +1500,7 @@ int hid_pidff_init_with_quirks(struct hid_device *hid, u32 initial_quirks)
 	ff->playback = pidff_playback;
 
 	hid_info(dev, "Force feedback for USB HID PID devices by Anssi Hannula <anssi.hannula@gmail.com>\n");
-	hid_dbg(dev, "Active quirks mask: 0x%x\n", pidff->quirks);
+	hid_dbg(dev, "Active quirks mask: 0x%08x\n", pidff->quirks);
 
 	hid_device_io_stop(hid);
 
-- 
2.51.0




