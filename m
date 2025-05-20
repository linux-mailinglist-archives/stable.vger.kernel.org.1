Return-Path: <stable+bounces-145414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DD9ABDBCD
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414328C7D76
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6D6247282;
	Tue, 20 May 2025 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d8b8iODB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973161FBE9E;
	Tue, 20 May 2025 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750110; cv=none; b=fV+zGMMANv8fRieAx884O7H1HqffIDeMewmnpvuyHvAtB0REilseaZpefeEj+LQITI+1GaJfSb5da/3Y4cuNuM8gqaE5rs4G/IGiibPbPWOXpaBwZc99pq+6D0Uck+zVNZqtdeCWUXqt5gQQbcwCyc/r1qKVnGqvvVSpvRVxml8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750110; c=relaxed/simple;
	bh=KigC5bVxapeRUaaXvl/6FVw1lnmW+eieccB5utwAUDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QngJMjR13YaItYuj4L3dbrzxeTbda11F9keRj0c79eNo/DOD7hBOher10Zcc3n+WvFsWl/SeWQfgA91Yp1rOkMSJ4p1yem7fOMyiEAP4VZyS/v6FlaG8/Fn4cQTigytsN1T1JXaRyLxEYUlaleA3/a+ltbzJWpOfzosMqpynRGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d8b8iODB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28308C4CEE9;
	Tue, 20 May 2025 14:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747750110;
	bh=KigC5bVxapeRUaaXvl/6FVw1lnmW+eieccB5utwAUDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d8b8iODBEyMYLObTW7dyWfFBv/SRCZVHmUdSQrkxzYc5gaTTMjrcmAWt4A9JBVX+U
	 ByJu7Z7wjTQG8M8yCBHzMwGxSlYb9ZdTzhdkVAxb6XGzrZ/Gk3LnvJTl88P8ERk3CV
	 wW1BrF2ggvMX8Vn3Cupa/RlF2GYK+6FsoHBBCnj0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 046/143] ALSA: ump: Fix a typo of snd_ump_stream_msg_device_info
Date: Tue, 20 May 2025 15:50:01 +0200
Message-ID: <20250520125811.860040065@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125810.036375422@linuxfoundation.org>
References: <20250520125810.036375422@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit dd33993a9721ab1dae38bd37c9f665987d554239 ]

s/devince/device/

It's used only internally, so no any behavior changes.

Fixes: 37e0e14128e0 ("ALSA: ump: Support UMP Endpoint and Function Block parsing")
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/20250511141147.10246-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_midi2.c | 2 +-
 include/sound/ump_msg.h               | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_midi2.c b/drivers/usb/gadget/function/f_midi2.c
index 8c9d0074db588..0c45936f51b3d 100644
--- a/drivers/usb/gadget/function/f_midi2.c
+++ b/drivers/usb/gadget/function/f_midi2.c
@@ -475,7 +475,7 @@ static void reply_ump_stream_ep_info(struct f_midi2_ep *ep)
 /* reply a UMP EP device info */
 static void reply_ump_stream_ep_device(struct f_midi2_ep *ep)
 {
-	struct snd_ump_stream_msg_devince_info rep = {
+	struct snd_ump_stream_msg_device_info rep = {
 		.type = UMP_MSG_TYPE_STREAM,
 		.status = UMP_STREAM_MSG_STATUS_DEVICE_INFO,
 		.manufacture_id = ep->info.manufacturer,
diff --git a/include/sound/ump_msg.h b/include/sound/ump_msg.h
index 72f60ddfea753..9556b4755a1ed 100644
--- a/include/sound/ump_msg.h
+++ b/include/sound/ump_msg.h
@@ -604,7 +604,7 @@ struct snd_ump_stream_msg_ep_info {
 } __packed;
 
 /* UMP Stream Message: Device Info Notification (128bit) */
-struct snd_ump_stream_msg_devince_info {
+struct snd_ump_stream_msg_device_info {
 #ifdef __BIG_ENDIAN_BITFIELD
 	/* 0 */
 	u32 type:4;
@@ -754,7 +754,7 @@ struct snd_ump_stream_msg_fb_name {
 union snd_ump_stream_msg {
 	struct snd_ump_stream_msg_ep_discovery ep_discovery;
 	struct snd_ump_stream_msg_ep_info ep_info;
-	struct snd_ump_stream_msg_devince_info device_info;
+	struct snd_ump_stream_msg_device_info device_info;
 	struct snd_ump_stream_msg_stream_cfg stream_cfg;
 	struct snd_ump_stream_msg_fb_discovery fb_discovery;
 	struct snd_ump_stream_msg_fb_info fb_info;
-- 
2.39.5




