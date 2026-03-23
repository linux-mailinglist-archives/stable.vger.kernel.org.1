Return-Path: <stable+bounces-227974-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOkMJFM6wWn2RgQAu9opvQ
	(envelope-from <stable+bounces-227974-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:04:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8692F2731
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C669D3014A1E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9138C1D5178;
	Mon, 23 Mar 2026 13:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="geSBPm+J"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD921D45E8
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271001; cv=none; b=jG0XgDUyei7eHoo8TsX+2ng0WRlzXGDx29YIu6F1fyL/enICDCqcZbGbvT43p7U06aALVpzMGrOH7DcXnIlm4/Xu7BjvgSk0+b35BjuxqyrrLh8Rbd+Nz7pS86h+GA3gSh7KZjGdOPJyJBDWvMdtZ0rfJM4r8mYoBfEnBdc/EAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271001; c=relaxed/simple;
	bh=rm8yRXyKEMtcqCElasHXW+eehwQwuzwxvRFVsv2V3QE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Aa2GhOnBqiydq8LJwg9bkdcx65FOnQEYqa5DlWDRmK0MrOT1zbclmtFZ4AnvKqzBqoAZ3uNe9SS2AnsXjSKHruI8z4WHhFgwIREgio6noMPctaQrfNAY9eUaufw+DNTzSgMf/iO2iI0ija6TxTW0llLlC+ukZYSwjYghLmrodVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=geSBPm+J; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a10d130b37so3229305e87.0
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 06:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774270998; x=1774875798; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rum/8YcSfFzn+mIlRZrRd8RBJkU4CF1JIzKByDx2Qcc=;
        b=geSBPm+J+umm9t+vd3JeuXnuQm6SBGqG34cLEXmjfgejaCv8hbzsBPXZ3wGyoi5vX8
         4VUWKD0FRWyoXGi22Sfd1QHqOiThegLN4tz6W8KKfQQ44qRcwEwEkV8FF0JOUH1hRJ2T
         2dcpItemcmDk5kqA7zZhkXEHvoQDklBzTYxWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774270998; x=1774875798;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rum/8YcSfFzn+mIlRZrRd8RBJkU4CF1JIzKByDx2Qcc=;
        b=ADsyYpEpmmxa6NpfIRDmWF/uFXpBRUuFdtIVHb6QuqGW7Eyfj4E3Sz5UkB7oQe7wjQ
         yXPc8FCrtld7ei5N/My6zWDwpnuqWk9cxbF4jhqsskDOeVG1XjYgZ079lQcUrOPWmM2O
         E7uO/dxLSBXCsSsacQkY7V0ZuzS5znCxMxe8UyJCijsksF0S9q9IlWMxJIccd+rx/nZf
         /xryXSU8JPS5Y/wKPajCiGKy32YUGcjA9U6iglr9/2J/uKzVbps24mjQ04p7WtSTDL6+
         pOwonB3d9u5jlLOm8oljkXZgam3hxSXMt/OaJIMGJEBM1htzj8JVw8U/BNPOKAM/+bgq
         mq8w==
X-Forwarded-Encrypted: i=1; AJvYcCXuIEk7U5JZW0ValdyucQ3apZBF/bxPtlAq7UlXwVzACH26wbuyfT3VrIxnZutVValHqQEtaIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNM/Gpc+pNomgpVp3dpTvJvlXQlCvO/HGWKoTD5OC3GMRn/Oos
	qZ2jwOpzWJyrJYBmY6np9YqcY+TUm+ed0mCc43bcot4oUwJZlmDMRW6c2hMQSWIR2w==
X-Gm-Gg: ATEYQzxHvYUD3sVjToAzazYEofWlckBpxAmMab9Xj7dh4Wh8eo6vRqw6YT4Xa/ufhsQ
	EGIaJ2JLzdbZ8R2sWI3WNErxkFCMkU5gs6Ormxhveff26Ty14d0Wt4ZdNSOCaRom5mQ1EbkNwfp
	JuhCBSpzjk+DmiyrJVrVE8tdk7ogNZovCER1X3IhiHW370SyiUnITH7iSpcvrMFARWP0cFwXPIP
	R2uIeRQhzQaxcAXOrkT1kGtKprE1GT5DnQtXxHH0rtIRd4jtpTDHa4PLeMpOSxf3LzTV7ybQ4qH
	J8BPLz36waZbBqRBgnjhCjQs7B/wP5HstCzktyDDSD6rWc7fx+z0jmy5rufTmkEGOLKQyTPByc6
	e+MqGOcjk1talgLEj/musWRgK2cvVVcaUO5yR96alQd07s3ffTWMdAMzV9D6tg7rRdBJRoZGwwR
	lHGEP6gDihHp9rIHXSDrAhxHSZpnISTYk6Ru/K+pV8Z7SpYBI04aKzT6ttnYqqu1PRuiqiwYXYk
	Fqp/VU3ubPoo44RDg==
X-Received: by 2002:ac2:4e01:0:b0:5a1:5994:2773 with SMTP id 2adb3069b0e04-5a2855efc89mr3443970e87.14.1774270997925;
        Mon, 23 Mar 2026 06:03:17 -0700 (PDT)
Received: from ribalda.c.googlers.com (252.116.88.34.bc.googleusercontent.com. [34.88.116.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a28530bd55sm2534556e87.72.2026.03.23.06.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 06:03:15 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 23 Mar 2026 13:03:03 +0000
Subject: [PATCH] media: uvcvideo: Undup use uvc_endpoint_max_bpi() code
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-uvc-backport-bpi-v1-1-5b62c6798ccf@chromium.org>
X-B4-Tracking: v=1; b=H4sIAAY6wWkC/x3MQQqAIBBA0avIrBtIDZOuEi3KphoCFa0IorsnL
 d/i/wcyJaYMnXgg0cWZgy+QlQC3jX4l5LkYVK1MrZXG83I4jW6PIR04RUZjtbG0yEa2GkoWEy1
 8/8t+eN8P4ra/Q2IAAAA=
X-Change-ID: 20260323-uvc-backport-bpi-68368ef14173
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227974-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[chromium.org:query timed out];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ideasonboard.com:email]
X-Rspamd-Queue-Id: 6F8692F2731
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[ Upstream commit 5b9c75c794ce041e6e00789efef75d71915c4f4c ]

Replace manual decoding of psize in uvc_parse_streaming(), with the code
from uvc_endpoint_max_bpi(). It also handles usb3 devices.

Cc: stable@vger.kernel.org # v5.4+
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
The commit: 9764401bf6f8 ("media: uvcvideo: Fix bandwidth issue for Alcor
camera"), which has been backported to 5.4+, depends on this patch.

Without it, cameras connected to USB3.0 will stop working properly,
because the bandwidth quirk will be applied wrongly.

Please help adding this patch to 5.4, 5.10 and 5.15.

Thanks!
---
 drivers/media/usb/uvc/uvc_driver.c | 4 +---
 drivers/media/usb/uvc/uvc_video.c  | 3 +--
 drivers/media/usb/uvc/uvcvideo.h   | 1 +
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 858fc5b26a5e..4ee187a503b8 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1007,9 +1007,7 @@ static int uvc_parse_streaming(struct uvc_device *dev,
 				streaming->header.bEndpointAddress);
 		if (ep == NULL)
 			continue;
-
-		psize = le16_to_cpu(ep->desc.wMaxPacketSize);
-		psize = (psize & 0x07ff) * (1 + ((psize >> 11) & 3));
+		psize = uvc_endpoint_max_bpi(dev->udev, ep);
 		if (psize > streaming->maxpsize)
 			streaming->maxpsize = psize;
 	}
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index f868a13280a1..fb69d534e299 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1797,8 +1797,7 @@ static void uvc_video_stop_transfer(struct uvc_streaming *stream,
 /*
  * Compute the maximum number of bytes per interval for an endpoint.
  */
-static unsigned int uvc_endpoint_max_bpi(struct usb_device *dev,
-					 struct usb_host_endpoint *ep)
+u16 uvc_endpoint_max_bpi(struct usb_device *dev, struct usb_host_endpoint *ep)
 {
 	u16 psize;
 	u16 mult;
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 95af1591f105..f5bc9fa2c385 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -920,6 +920,7 @@ void uvc_simplify_fraction(u32 *numerator, u32 *denominator,
 u32 uvc_fraction_to_interval(u32 numerator, u32 denominator);
 struct usb_host_endpoint *uvc_find_endpoint(struct usb_host_interface *alts,
 					    u8 epaddr);
+u16 uvc_endpoint_max_bpi(struct usb_device *dev, struct usb_host_endpoint *ep);
 
 /* Quirks support */
 void uvc_video_decode_isight(struct uvc_urb *uvc_urb,

---
base-commit: 91d48252ad4b17577cf8cc8d3e1353402e4da8f1
change-id: 20260323-uvc-backport-bpi-68368ef14173

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


