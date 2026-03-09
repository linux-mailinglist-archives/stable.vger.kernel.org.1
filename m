Return-Path: <stable+bounces-223683-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFgSFgLhrmnsJgIAu9opvQ
	(envelope-from <stable+bounces-223683-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 16:02:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D64C023B300
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 16:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4AE09301980C
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 15:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6534F3D7D6F;
	Mon,  9 Mar 2026 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I6lw2OOm"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23E93D6CB0
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 15:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068523; cv=none; b=W9sVXegDzMLzA8+w83X5o2rR8oGYWotqvworFV/pFZzLZ/QRv95nvqguDAN+iX/cfW4IWnF6Ms14EpUJWcmxgrqx+ar3lzVMb3LIRQDdnlx6+thxtI4zMYOQHD266tV2p7qmmLVO157sAIxkIEu9rBvKbbNMLAM33tuMlwy1hlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068523; c=relaxed/simple;
	bh=CCo9MsLBz35ddFk/kftRSVSKC9JPYu1XSXPfUzfG2uU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qtVL8RBZI2KuJduU+s0inpEMKNEFzcMBB81bsEco0lRR8mMM4DqZzTYoMmCSzMLveLGZjibuGKg9S5CEwrM3jMk07bWOLtaIpklAP5QDAM69IAHF7tIUqMCv30FQhK9HgLPf3cuWnjn6Z8AZ3XiabGC9J2vV1EThWbKSHFEgZDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I6lw2OOm; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a10d130b37so4536271e87.0
        for <stable@vger.kernel.org>; Mon, 09 Mar 2026 08:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773068520; x=1773673320; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6YS8feCy/AcjUOl+x13VpxVJ8Kgr7ClPZ1jb91K/I0=;
        b=I6lw2OOmWOLWIpm5yencf3ula5osWOB1yuNlNXKgtu2FJFE+y9+8UIstk/3h5b7LJv
         o7ob/WsLIWXPEColFZ1Z4YR7OkQn4I1X8VuRwv95Xnxml6jVzycCmYrS4vy7Y/E1qRF4
         Rjct6k0/roCGnxoXOzddB0hQOyY85V/hbtmzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773068520; x=1773673320;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f6YS8feCy/AcjUOl+x13VpxVJ8Kgr7ClPZ1jb91K/I0=;
        b=Hu+TMhehP+4oA38NNeh+YmGRzv00O3mNHawBRASBUhKDIum+Q+Q5h86tDPIrBYTD0U
         Zh1E7ddLGYBij5tV8ubf3jvODu5JunkrdP2T6pleH8ST/KA4hOCqI8XFAuxmPh7owBVI
         SRkLMB4+0UMQ+mAPuAjmh12wR9VXuBlmpmg93M1jsyhpReyzzBbcgaBEPStVi7AiKMV8
         fHR4KX14ZGETBf3Yj1uVQ1wuzMZqX8/67x0GwqI5rHLz3KUOGV1TliJ+vn5I0phiuuMY
         UfqbQtlsaGW2Rsik+Q2W2ObNDOaYmQZuG8cdcjduDdi7tUbZwgd9DdYMzcHSZ0TKMDSp
         Syuw==
X-Forwarded-Encrypted: i=1; AJvYcCVI7PtqzJ6jQ1Qfhj2jT734sclLwbQrACiz1JU5mtGV/zkSR1FG/FleWxOu4KGYOP6QcUsnBas=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqEhzW6ceRXAMcOEcPxB+5QRa7R48GkhlPuLYlBPNnzA8ltM4j
	zxfW7HS9iIb8FboxD2KGNPWo7sW7+ZsUIRcajz/zxqfdv5eOxBLB3cIheeU2GA0AYg==
X-Gm-Gg: ATEYQzz/FOiUpE9n/bpoWARzaL0yhscA2+H1H9gXyboNsGo1ocLi5B+52kaTwkstErp
	L7Rs8Xyq8xigUH6GAJTxyduTDbh73Dc2d413cdMdZWw8R3Uq318x9lJ/CKEmQB9juSqbP5gPOk3
	1r3tVCsVvWmqbhdlNnV6TnluIyvUcmjc0Fl3B9NmVLCQFx+BRctqYcB2yKWdFefdoCiACpCPZ2t
	T5GD/gWR+q2rlbaXVJCsHuNhzUWHddsSOD2kJgVit7rdeazBmS93jdTR3rzEAYrUNO7MAquriS9
	QWUBFX4/KArQBKdMNNEXjGZil4EcXpxdxKOsLYIXnv/tDeqDkRKfEjCnEVYm0XUthASFZTrlPyG
	jVkaOZCHtPd2+SD4Y6z/ZlRD5yi7rQpPaDbguxcPXXHMVfc6yRIe/ntbxpN1yofoz3gptIwT5i6
	Wqx0ZsGM+DII5afzCnKhemqe25f6Epc3r+hqOLVx65Zf2jTgXLNCNKjiTLfmTWYCC8gaujP3kzb
	A==
X-Received: by 2002:a05:6512:308b:b0:5a1:1941:18ad with SMTP id 2adb3069b0e04-5a131e381d3mr5383026e87.0.1773068519891;
        Mon, 09 Mar 2026 08:01:59 -0700 (PDT)
Received: from ribalda.c.googlers.com (27.69.88.34.bc.googleusercontent.com. [34.88.69.27])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d08cc0dsm2138003e87.80.2026.03.09.08.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:01:58 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 09 Mar 2026 15:01:54 +0000
Subject: [PATCH 1/3] media: uvcvideo: Enable VB2_DMABUF for metadata stream
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-uvc-metadata-dmabuf-v1-1-fc8b87bd29c5@chromium.org>
References: <20260309-uvc-metadata-dmabuf-v1-0-fc8b87bd29c5@chromium.org>
In-Reply-To: <20260309-uvc-metadata-dmabuf-v1-0-fc8b87bd29c5@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yunke Cao <yunkec@google.com>, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: D64C023B300
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223683-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.935];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

The UVC driver has two video streams, one for the frames and another one
for the metadata. Both streams share most of the codebase, but only the
data stream declares support for DMABUF transfer mode.

I have tried the DMABUF transfer mode with CONFIG_DMABUF_HEAPS_SYSTEM
and the frames looked correct.

This patch announces the support for DMABUF for the metadata stream.
This is useful for apps/HALs that only want to support DMABUF.

Cc: stable@vger.kernel.org
Fixes: 088ead2552458 ("media: uvcvideo: Add a metadata device node")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_queue.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
index 8b8f44b4a045..0eddd4f872ca 100644
--- a/drivers/media/usb/uvc/uvc_queue.c
+++ b/drivers/media/usb/uvc/uvc_queue.c
@@ -243,7 +243,7 @@ int uvc_queue_init(struct uvc_video_queue *queue, enum v4l2_buf_type type)
 	int ret;
 
 	queue->queue.type = type;
-	queue->queue.io_modes = VB2_MMAP | VB2_USERPTR;
+	queue->queue.io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
 	queue->queue.drv_priv = queue;
 	queue->queue.buf_struct_size = sizeof(struct uvc_buffer);
 	queue->queue.mem_ops = &vb2_vmalloc_memops;
@@ -256,7 +256,6 @@ int uvc_queue_init(struct uvc_video_queue *queue, enum v4l2_buf_type type)
 		queue->queue.ops = &uvc_meta_queue_qops;
 		break;
 	default:
-		queue->queue.io_modes |= VB2_DMABUF;
 		queue->queue.ops = &uvc_queue_qops;
 		break;
 	}

-- 
2.53.0.473.g4a7958ca14-goog


