Return-Path: <stable+bounces-221055-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDTsJXxNo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221055-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:18:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CD81C82B6
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6C5731FE7D9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB744C0405;
	Sat, 28 Feb 2026 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbOi2hmz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F96247CC8F;
	Sat, 28 Feb 2026 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301399; cv=none; b=EwgVKzsG4clDupKibm9C5MXFl2+i2F1/0RHGsUeQJSfMPEXwUs/mBkpeOHx6Cax/tbTK8N9tSsI31+MUgVe+ead8hN2uWGUbXuqnsYiDIYeMtF3HVQ3+7rYNO9N0bgwEqpbCs4UePvBNY7M/288b1n2WDNdEWQF5jFoU6KtnwlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301399; c=relaxed/simple;
	bh=wy+9C6HkEMy+Plt9bFUgURSkZS2Cy297b2bowbpBP6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYba8C4izRpROG5Y6nCBPgM+HRBx9Uyf6JF91clsN2rbtkLSmFFxbhQyk41aTiDrDCkHsvQBr/JFlpbvQ0/23L9v0sOEyrs+/pv402HPdOEaZEvs1U547YLAvh4qZuwx96n+cRc3QL+vnPgzeo6YHKf8KpomJ5Di+au30506wIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbOi2hmz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B48C19423;
	Sat, 28 Feb 2026 17:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301398;
	bh=wy+9C6HkEMy+Plt9bFUgURSkZS2Cy297b2bowbpBP6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SbOi2hmzjSjefsQhikWsefB5Q08OtiVP3hyMBKJjuALVj/JkaDgNZ11N0ym37YNkK
	 a6tRe7H8C1y40uH9vpILYxEweZ6FhBrjMQUwOYYRTqI8uwG58ZctqaxzbEm4J75jMv
	 40eF86P3vVc0PEvl6f/P23B9buOCrlM/4qhVLXX3qHpIDf11rTbQaS68UqUgCFTrcN
	 gKXHbHEMiEgfPQqK8A74sP6Efbqv2vKGwTidk9SG+HId2E0PwzG126TleExcW+P7a0
	 JHQKMNj/tts6Obv5pWxsVWmnFmlISXaDO962CahhS4Pu5YTVixvIX4HHYYVekpwWnb
	 +trR7GIF3kJXw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Michal Pecio <michal.pecio@gmail.com>,
	stable@vger.kernel.org,
	Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 587/752] media: uvcvideo: Return queued buffers on start_streaming() failure
Date: Sat, 28 Feb 2026 12:44:58 -0500
Message-ID: <20260228174750.1542406-587-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,chromium.org,ideasonboard.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221055-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ideasonboard.com:email,chromium.org:email]
X-Rspamd-Queue-Id: 30CD81C82B6
X-Rspamd-Action: no action

From: Michal Pecio <michal.pecio@gmail.com>

[ Upstream commit 4cf3b6fd54ebb1ebc977bdc47fb6cfcf9a471a22 ]

Return buffers if streaming fails to start due to uvc_pm_get() error.

This bug may be responsible for a warning I got running

    while :; do yavta -c3 /dev/video0; done

on an xHCI controller which failed under this workload.
I had no luck reproducing this warning again to confirm.

xhci_hcd 0000:09:00.0: HC died; cleaning up
usb 13-2: USB disconnect, device number 2
WARNING: CPU: 2 PID: 29386 at drivers/media/common/videobuf2/videobuf2-core.c:1803 vb2_start_streaming+0xac/0x120

Fixes: 7dd56c47784a ("media: uvcvideo: Remove stream->is_streaming field")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://patch.msgid.link/20251015133642.3dede646.michal.pecio@gmail.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/uvc/uvc_queue.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
index 790184c9843d2..e838c6c1893a6 100644
--- a/drivers/media/usb/uvc/uvc_queue.c
+++ b/drivers/media/usb/uvc/uvc_queue.c
@@ -177,18 +177,20 @@ static int uvc_start_streaming_video(struct vb2_queue *vq, unsigned int count)
 
 	ret = uvc_pm_get(stream->dev);
 	if (ret)
-		return ret;
+		goto err_buffers;
 
 	queue->buf_used = 0;
 
 	ret = uvc_video_start_streaming(stream);
-	if (ret == 0)
-		return 0;
+	if (ret)
+		goto err_pm;
 
-	uvc_pm_put(stream->dev);
+	return 0;
 
+err_pm:
+	uvc_pm_put(stream->dev);
+err_buffers:
 	uvc_queue_return_buffers(queue, UVC_BUF_STATE_QUEUED);
-
 	return ret;
 }
 
-- 
2.51.0


