Return-Path: <stable+bounces-169403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9066DB24BA3
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 16:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF1E3A7CDC
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 14:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F98A2EB5C4;
	Wed, 13 Aug 2025 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nT8lzQ+R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511312E92BE
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755094231; cv=none; b=KSXnkp244osbtn+gHMurf1HyIB5NAuTB9jrR0XP0O99K8opiq/zXRMvdBK5hTPGaSBvF2YDuoYaxH5QRlU3gv5xFLVoTFNk3fJfGxmGz10cPPooyso6/wvVBNJGbFGzM+JLtjPvdW3rIgqZEpqHn7NetjoL2z/wh78sW3yzsqPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755094231; c=relaxed/simple;
	bh=UBm6XyBTqgkWoieGyTayfLKeLtUgMmvF9UMniVYtyIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pH3JCp7RMgZ9f6WTNEhWIKxKu5hVpsm4phpz/wgYbupLYNk2fdtLuVI7/p1jMrgPAo1oJm4AbW75R8M9GiAEyfeLsVnnByKvhP7yXLLyM00HYefkHMN47rVWA+X0WHqx1Gk/JYHsPzH/l1iZ6M4ai5jp2+tFElsl++kqNCQ/PQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nT8lzQ+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4844FC4CEEB;
	Wed, 13 Aug 2025 14:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755094230;
	bh=UBm6XyBTqgkWoieGyTayfLKeLtUgMmvF9UMniVYtyIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nT8lzQ+RQjGQdoe4J4NNw9k53c44IINqzHj6zils71f5xXWLDsf+pvKRLS/1UJAqV
	 vQlsEB6OYX1ulny5LXJ+RuI535+ARcVTXOE8W513WwEm9woJb1go4G7mE7pgAzzUAz
	 I77mBcOBf++tCgboW1O5PUHQ6jTK8W6dp18JYkc6sSK7C2CWwKeQcrfT3EStBWXdkd
	 ACaBanSWJPUHrz7zPCJHdVXi4YO2nU7/+HBOJp47RtAo725hfu6TML1FF6h4TqV6PB
	 aQPn+gmw3AIln46jIlSoKnPjbmakJXeI0hK3DahWVMxKasXf3g+K+uE/yCo0+LZPBp
	 uGyNG4u47lf0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Geoffrey D. Bennett" <g@b4.vu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ALSA: scarlett2: Add retry on -EPROTO from scarlett2_usb_tx()
Date: Wed, 13 Aug 2025 10:10:27 -0400
Message-Id: <20250813141027.2043326-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025081243-disaster-wrinkly-bdc6@gregkh>
References: <2025081243-disaster-wrinkly-bdc6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Geoffrey D. Bennett" <g@b4.vu>

[ Upstream commit 8a15ca0ca51399b652b1bbb23b590b220cf03d62 ]

During communication with Focusrite Scarlett Gen 2/3/4 USB audio
interfaces, -EPROTO is sometimes returned from scarlett2_usb_tx(),
snd_usb_ctl_msg() which can cause initialisation and control
operations to fail intermittently.

This patch adds up to 5 retries in scarlett2_usb(), with a delay
starting at 5ms and doubling each time. This follows the same approach
as the fix for usb_set_interface() in endpoint.c (commit f406005e162b
("ALSA: usb-audio: Add retry on -EPROTO from usb_set_interface()")),
which resolved similar -EPROTO issues during device initialisation,
and is the same approach as in fcp.c:fcp_usb().

Fixes: 9e4d5c1be21f ("ALSA: usb-audio: Scarlett Gen 2 mixer interface")
Closes: https://github.com/geoffreybennett/linux-fcp/issues/41
Cc: stable@vger.kernel.org
Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
Link: https://patch.msgid.link/aIdDO6ld50WQwNim@m.b4.vu
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ Applied patch to the older file name mixer_scarlett_gen2.c instead of mixer_scarlett2.c. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_scarlett_gen2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index 0a9025e3c867..0aa5957cd9f9 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -125,6 +125,7 @@
 #include <linux/slab.h>
 #include <linux/usb.h>
 #include <linux/moduleparam.h>
+#include <linux/delay.h>
 
 #include <sound/control.h>
 #include <sound/tlv.h>
@@ -1064,6 +1065,8 @@ static int scarlett2_usb(
 	u16 req_buf_size = sizeof(struct scarlett2_usb_packet) + req_size;
 	u16 resp_buf_size = sizeof(struct scarlett2_usb_packet) + resp_size;
 	struct scarlett2_usb_packet *req, *resp = NULL;
+	int retries = 0;
+	const int max_retries = 5;
 	int err;
 
 	req = kmalloc(req_buf_size, GFP_KERNEL);
@@ -1087,10 +1090,15 @@ static int scarlett2_usb(
 	if (req_size)
 		memcpy(req->data, req_data, req_size);
 
+retry:
 	err = scarlett2_usb_tx(dev, private->bInterfaceNumber,
 			       req, req_buf_size);
 
 	if (err != req_buf_size) {
+		if (err == -EPROTO && ++retries <= max_retries) {
+			msleep(5 * (1 << (retries - 1)));
+			goto retry;
+		}
 		usb_audio_err(
 			mixer->chip,
 			"Scarlett Gen 2/3 USB request result cmd %x was %d\n",
-- 
2.39.5


