Return-Path: <stable+bounces-227869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHylJElywGmDHwQAu9opvQ
	(envelope-from <stable+bounces-227869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 23:50:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E39A2EB11E
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 23:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55A303008531
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 22:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE39E37E300;
	Sun, 22 Mar 2026 22:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b="Caxnpioc"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C27F1E7C03
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774219845; cv=none; b=K75yzazAHQQ0WyDL3yJ3Vp14acsnJe/d6rJtlNrHHRiFHy3G0Eag79m2Ixtw4SZTGlzF9bOv29IC7vm5gRjBGJDpyK8N9vtsDQobG1ZkLhf2YqnoTTAhqlB70+gBkoFNigN616MVHagoSlreyr+h7G8i+gLlX9z5iOOaBJfwnb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774219845; c=relaxed/simple;
	bh=I/Eif1ZRTDEQrnMNfjbO5VHLbe1G0lSEoJ2HP69/lqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eil+JbOcW66IFnrPkWbYW7v0XjVUU9i0gGXHWcmCfjLK129nf3snPiTu6yTRFVdvFjvBRm0fkSjiG5XtFekoksAkjLEAUbluebxR2Yj7o6NAONQxnOAWP/GM4FzVawPYElo4C5YpJjESLe8fWGuwmF7TV3dLDRMhkvMgtSYWHVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com; spf=pass smtp.mailfrom=jphein.com; dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b=Caxnpioc; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jphein.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b4520f6b32so4453390eec.0
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 15:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jphein.com; s=google; t=1774219843; x=1774824643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDFymdpKeXfGYj2x1HV3pjSU2EJtPwV7qvFYD8NzPH0=;
        b=CaxnpiocB0mbj1KFiV/Pp7NWeGAUCpoUg+0HgwWHlVl8GdVvjP/V6kX6cq25kAnoZW
         VL48JpZo55XQwl5WLh8tP38Zm5Jzofyx50bKh4EZOLXGBgaR0mhDFsDxoOI8HLiQZsDE
         T2NoBFdYLautL+VXO2wXUImotp0X9HkyPkgbH9RperdcbRtqUlepi3e+c93pjk+5EqRf
         LNNZzFQX9Zt42QtK1kdDtwDzlILhxJ9bvY8X4pFfPAlZJevNRLfleBZtDhCcMrX//3uA
         hW9+JHWbTDIOMusrIH8Tic7tOt1ZKb+dDEscRzWP5JNHkx2cB4xzGEuzyMiz9tSOXLqU
         97Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774219843; x=1774824643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EDFymdpKeXfGYj2x1HV3pjSU2EJtPwV7qvFYD8NzPH0=;
        b=RLYWuo0RGFGXRTn+jwhDIyQ+MuwdOu5Nyatt40xMk6priYbgeLpqy4Ad53ZECM/iqE
         WUgmFXBMpQ2cqG5wthKZDwarmMNPLIQs7Ngb+YBbrGVLMiEcnBl60cHaBw3fDjDKZjt2
         e+Yz0Ph/G5LyupdKDeLfY2qUzgJO94wJeo6pYWIrDQHpIu6DzZd9mZE6HfKm9qkeWw9r
         zMg5nKccmOkqMx5AXzqOu0Q3sJqlWvq9ON+AwnmN090NFHkgr3jAx7CY7OR2JH/VRPwS
         MDXdx4RDtCmE+RVn9EFafxtEv2B9ML2Q29Mbe6iQEoVtH73+JpWTDSDYrKuItk57Aq45
         cXYg==
X-Forwarded-Encrypted: i=1; AJvYcCUA1jZSat881pGNffJM+w+utIwPXhk2fH6AoRbAYJaWKE0iAQG752Y2F/fDjjSRnTHHJX0S1q4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5AcXgH/8JxNap50zmiqmtYGQezjLs8updcg69AT8orjxkSkoP
	dfqToJueHYAEkCW1hwYckdIyrNV+zdvBD5GYp8vCgHHEVxC8RSwmCeznc1wXpDG8Cw==
X-Gm-Gg: ATEYQzyR0UgGHt8kAYw6rFPfmgzOBdbz4H+Bljv1/WNsqFAhRHHnpzOAMClyY1+9w8/
	hQRJAt8/xA0cGRvfcuYmLtxwGvCYQi3yNj+p+4aVDBzJrqdoFHrd4j2EjVjh/bW3/WiSFn7r0v6
	YR90Uc4Qb/4Sqzdui/MipNeuTam7ysXQS3xCkhqDrK2POM8t5YJep5QSZZpC9HyI40q/GibH1bP
	/fN1BTaZXyC9R3pf0szuVDiVRNrtctmgg6GANbXN8fS76JBKVQs+YoK7myjAr3yz1kWBIBwQStZ
	2NgX3qIUbUX9iRC+49Ohgda2L22AJVk7MTTVDvU5el1rOAS3g7AktAwzt962njrhBX43xd/n9UB
	h+S1rqsvdA8A+pS38UdozDLeVm0pNV6o/AZ8INc0fff8fwkCSqpLroefnxBBIQ4fW4ckr7N4OEj
	nTx65hLQ6u
X-Received: by 2002:a05:7301:1003:b0:2c0:c482:7e4 with SMTP id 5a478bee46e88-2c109563c7fmr4287186eec.3.1774219843360;
        Sun, 22 Mar 2026 15:50:43 -0700 (PDT)
Received: from katana.lan ([108.74.4.89])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b31ebd5sm10928052eec.27.2026.03.22.15.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 15:50:42 -0700 (PDT)
From: JP Hein <jp@jphein.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-media@vger.kernel.org,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	JP Hein <jp@jphein.com>
Subject: [PATCH v4 3/3] media: uvcvideo: add quirks for Razer Kiyo Pro webcam
Date: Sun, 22 Mar 2026 15:50:12 -0700
Message-ID: <20260322225012.1817920-4-jp@jphein.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260322225012.1817920-1-jp@jphein.com>
References: <20260322225012.1817920-1-jp@jphein.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[jphein.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[jphein.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jp@jphein.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227869-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[jphein.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3E39A2EB11E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Razer Kiyo Pro (1532:0e05) is a USB 3.0 webcam whose firmware has
two failure modes that cascade into full xHCI host controller death,
disconnecting every USB device on the bus:

  1. LPM/autosuspend resume: the device fails to reinitialize its UVC
     endpoints on resume, producing EPIPE on SET_CUR. The stalled
     endpoint triggers an xHCI stop-endpoint timeout.

  2. Rapid control transfers: sustained rapid SET_CUR operations
     (hundreds over several seconds) overwhelm the firmware.

Add the device to the UVC driver table with:

  - UVC_QUIRK_CTRL_THROTTLE: rate-limit SET_CUR (50ms interval) and
    skip error-code queries after EPIPE to prevent crash trigger #2.

  - UVC_QUIRK_DISABLE_AUTOSUSPEND: prevent USB autosuspend transitions
    that trigger crash #1. Same approach as Insta360 Link.

  - UVC_QUIRK_NO_RESET_RESUME: avoid the fragile reset-during-resume
    path. Same approach as Logitech Rally Bar.

Cc: stable@vger.kernel.org
Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2061177
Signed-off-by: JP Hein <jp@jphein.com>
---
 drivers/media/usb/uvc/uvc_driver.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index b0ca81d92..e8b4de942 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2920,6 +2920,23 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= (kernel_ulong_t)&uvc_quirk_probe_minmax },
+
+	/*
+	 * Razer Kiyo Pro -- firmware crashes under rapid control transfers
+	 * and on LPM/autosuspend resume, cascading into xHCI controller
+	 * death that disconnects all USB devices on the bus.
+	 */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x1532,
+	  .idProduct		= 0x0e05,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_CTRL_THROTTLE
+					| UVC_QUIRK_DISABLE_AUTOSUSPEND
+					| UVC_QUIRK_NO_RESET_RESUME) },
+
 	/* Kurokesu C1 PRO */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
-- 
2.43.0


