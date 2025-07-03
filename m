Return-Path: <stable+bounces-159880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72284AF7B4D
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51801894113
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCBC2EF66B;
	Thu,  3 Jul 2025 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c9OJ+pHb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7872F0020;
	Thu,  3 Jul 2025 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555648; cv=none; b=DPgcL43fAfbQctlZZx10TC6FHrvm1kZHfWZTieA7JxaxkMI0ofi0VNIXZw534Fs9naz3IlYin3ujRHiwM0SDZD5m98CSjO9IQxq/I/MJGafOMA9JgBLJhDbbmzD1uN6JAnwq07tiIayyGcEJb4U6waJaT/tQqTbqe/18w+9pBJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555648; c=relaxed/simple;
	bh=5UEG80ac3nk9QOPLFbz/leCJ9PQAj9StoUBJy9VxVC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orqxRb1j6+kV1z0G6rtJ2jHzb/C/YQVtiWHDEhrMc6WIZnRhfdaW9lZHQq94MJBAx3bYWsTrC/lsnFK1lN0KtFFvmEXBa0Vd3wWsMHiSYRjslk+H9NAeeIZmMgbzOzUlXVwO3suOp3oIOjakKHIIM6AlHdNbaV/cfraX3dgTFSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c9OJ+pHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3AC2C4CEE3;
	Thu,  3 Jul 2025 15:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751555648;
	bh=5UEG80ac3nk9QOPLFbz/leCJ9PQAj9StoUBJy9VxVC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c9OJ+pHbLXFTw+kAshqhbksm7WodxiFk9oXAouwYJVgXCqRL3datBQPgyjgv0ycTd
	 pnoL7Sh35Qtvh7FuNMhxuY+tBQmkmq53b06Yu6BQTIDmU9IrAyLNMQKEuH6oQVshO+
	 OLcQ2sjd1UIhysKsE/KOQ/JtRv4A8gzQ3UP08Otc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Youngjun Lee <yjjuny.lee@samsung.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 079/139] ALSA: usb-audio: Fix out-of-bounds read in snd_usb_get_audioformat_uac3()
Date: Thu,  3 Jul 2025 16:42:22 +0200
Message-ID: <20250703143944.253586567@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143941.182414597@linuxfoundation.org>
References: <20250703143941.182414597@linuxfoundation.org>
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

From: Youngjun Lee <yjjuny.lee@samsung.com>

[ Upstream commit fb4e2a6e8f28a3c0ad382e363aeb9cd822007b8a ]

In snd_usb_get_audioformat_uac3(), the length value returned from
snd_usb_ctl_msg() is used directly for memory allocation without
validation. This length is controlled by the USB device.

The allocated buffer is cast to a uac3_cluster_header_descriptor
and its fields are accessed without verifying that the buffer
is large enough. If the device returns a smaller than expected
length, this leads to an out-of-bounds read.

Add a length check to ensure the buffer is large enough for
uac3_cluster_header_descriptor.

Signed-off-by: Youngjun Lee <yjjuny.lee@samsung.com>
Fixes: 9a2fe9b801f5 ("ALSA: usb: initial USB Audio Device Class 3.0 support")
Link: https://patch.msgid.link/20250623-uac3-oob-fix-v1-1-527303eaf40a@samsung.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/stream.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index e14c725acebf2..0f1558ef85553 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -982,6 +982,8 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 	 * and request Cluster Descriptor
 	 */
 	wLength = le16_to_cpu(hc_header.wLength);
+	if (wLength < sizeof(cluster))
+		return NULL;
 	cluster = kzalloc(wLength, GFP_KERNEL);
 	if (!cluster)
 		return ERR_PTR(-ENOMEM);
-- 
2.39.5




