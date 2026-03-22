Return-Path: <stable+bounces-227863-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHZfLfZowGlkHgQAu9opvQ
	(envelope-from <stable+bounces-227863-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 23:11:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5FB2EAF92
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 23:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB253300D323
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 22:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AD437D13E;
	Sun, 22 Mar 2026 22:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b="HHdBm2Wg"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBD7372B53
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 22:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774217400; cv=none; b=cKueDs3h+/+UD/l7EhRB0xXXZMg6CghBb8qjIpsw2sF1OIpnzpN8NCAJ056A0SIpLS3loS/cFPREevxdJQ/Vtfy6z1Z74JE6LKkTqOze7WOlcLA3q0hLkl47Vly+67NK99UVDYvsmK5ui6yKqF15iJu3/bezoptzsKIk7Dqn+7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774217400; c=relaxed/simple;
	bh=7wFkGd6VA37qdOsrbmByN9HQYNCM6sLyLCW7T70qvJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxzOF5Pbi3jOpB/vta9tCEWQHC/Sr6W027toxe8xGl5+TrVE8U6qeCGrVmJIWq+ef7xJAI9a89ibKpc5pIo+onsm2T5qEYPlvUh/AMuQN8MxhqAMXo/Rq9S/Ez2HGyFRkptpONq4/+yGBikCXrd2G7jfTRgIpmjLhVOK5hygIc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com; spf=pass smtp.mailfrom=jphein.com; dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b=HHdBm2Wg; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jphein.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso2095532eec.1
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 15:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jphein.com; s=google; t=1774217398; x=1774822198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWjML3pDjgXrTqMQEMMGGoK2UUmjpDjeGQXYnhY9w1Y=;
        b=HHdBm2WgcSeMcWN3yng6TT3UtLAA6elpR4FpFPP2DA4tORBrVvX/aMHC7M9fqIUz3F
         wzyfSnj9kQ+7JHNi0A4J1tPDDc8dzLvGVuVC14gsbBA598MZRLT73SqsAzUFYEFB/uW3
         tgtGZn5EqgvcdyDpBxXY+XVcQfbPCoVVDxTSsYNTwl3sv+Li4K5bfqsyHCph5D7ZkEMy
         AI0xkG9Dg3b/FW+1S2AEZVvuLZ/Q4petdXzVsiqNh+zMaGYhi2QaNmKl4azjqYu9NrKp
         YUgl5kIsX3IOoeTPMzTUOpMEi1VeQ5NYkv+RnTdijwIVT48q3ilBa/l8o7Lj+y4fFPCc
         evZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774217398; x=1774822198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QWjML3pDjgXrTqMQEMMGGoK2UUmjpDjeGQXYnhY9w1Y=;
        b=K92ZMrrBnB4uqzpshH1Flld0doSSNIq0ZzghTS6BceWyqFQU+B3vySqLaG4mPJdTeL
         6D7BmRqzwV7rq/rNon383d3XgXu5YtAjBSYmt4HEOelkx/pDKmSJwPL/jthNKuskaD/8
         iHtbLGQUrXvdumOzx4A6TjmSC54bT50XcKHr9kTygQ85/usFBoIwqsFse8DvMp+JRV9S
         sPcgihuIWU+R0pxPVta/um09XuK5y9FEWRB845EuCcbV231rkoTN7n1HOckj6f364i6h
         KlIm/kK2jJAEbaaEDoTF/DPPYOgwyu+b6HH7uL9+p+mYWg3JBDo+W/7FlsP7WXPEHZrw
         pULg==
X-Forwarded-Encrypted: i=1; AJvYcCVF29sI6rzDhh5DxOHwfgVVikun6yq0Sw2M/loyQ2wpKbQ0l1r3x04wWAsNx5/CDIBuG/EyumU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfId0jckleVjRkL/VhtpdgvOQxv0Bmiei35EOcSmt35RN091Ka
	Oi92VAZ7bQjpoR/NuDd3ixW/Yo7qJ4Ap0UPnV8s1yJyvltNHRIyOD6YExU5Ff5V2ASL+zKUN7xe
	abdA=
X-Gm-Gg: ATEYQzzPaIpaKODs70+tYymFnjwnH6b8a94A0Y+Y56WmV6MD6oR2IVE/l8LYxUso/dk
	vHCgaiJQjXktm++KbEaOoflibn51uBgGkz+8rG2+vIelp1wURb5Ik+3b4LEYEhcNusOSTXlB8jc
	qj+mCUgv/7lB85+cffKEajU+Hp4gAqIKL0wOCnTqoAcYtpmtKV590dcygs/V+LduwXK54sDEpE1
	tLo68iP8pTr3egfJQekZhK5nP0We6l3vexFvO6/KaS2rMUCqGfaQ0VvpQXYYgkfcFgGW/M0fsyS
	V+3B7+4ltQd3NNScHR/kxkjI+NjQH5X7RJTtcg1GGNIl6XtbRYG9/4Sr/0BqTTDRNBj1Gbf9P0f
	L6XbVzhzf3zWfnVkA3hKIuv7bIo65LOFmxM2MWG+gdBBWzdXenHIN7gFbNFItVyiHrSmIwK0g0L
	FWxaTwWDPg
X-Received: by 2002:a05:7022:5f04:b0:128:e693:b61c with SMTP id a92af1059eb24-12a726b29dcmr2149405c88.27.1774217397835;
        Sun, 22 Mar 2026 15:09:57 -0700 (PDT)
Received: from katana.lan ([108.74.4.89])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a7330d1c5sm7707766c88.0.2026.03.22.15.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 15:09:57 -0700 (PDT)
From: JP Hein <jp@jphein.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-media@vger.kernel.org,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	JP Hein <jp@jphein.com>
Subject: [PATCH v3 3/3] media: uvcvideo: add quirks for Razer Kiyo Pro webcam
Date: Sun, 22 Mar 2026 15:09:40 -0700
Message-ID: <20260322220940.1462189-4-jp@jphein.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260322220940.1462189-1-jp@jphein.com>
References: <20260322220940.1462189-1-jp@jphein.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[jphein.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[jphein.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227863-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jp@jphein.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[launchpad.net:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,jphein.com:dkim,jphein.com:email,jphein.com:mid]
X-Rspamd-Queue-Id: 1C5FB2EAF92
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
index XXXXXXX..XXXXXXX 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2920,5 +2920,22 @@ static const struct usb_device_id uvc_ids[] = {
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

