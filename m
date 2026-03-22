Return-Path: <stable+bounces-227814-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI06ETVlv2lJ4QMAu9opvQ
	(envelope-from <stable+bounces-227814-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 04:42:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA23B2E8265
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 04:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E344230209D8
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 03:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BC937FF41;
	Sun, 22 Mar 2026 03:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b="Uy7gR8Ew"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4374B37FF64
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 03:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774150913; cv=none; b=M2ZeRrVvVmpG/PPw9MxYGIoIm2hodnLQoIR1LwvmmSAWeL0TBRex54ykEyWIurdDxxxEhpELyYHpi18oCa/xtucrRqQBLUacBzKvr7OebMq4iIz1wGg2McAmOiPA1pm2CsCVZ7+yN+2g3U2g0jRp6dbrcYlTg6OPSHHT5BqSQ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774150913; c=relaxed/simple;
	bh=f40iPRYm5U2gOyJUY6EAVOFQmR5PmoEAY+zzqQV2+M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0ru2RJmr+ZDv/Z2+MJOXeqPzh5x9sHlDna1dPbxjhGCpUa0wL0IF3RTkh/j9f/pl49y5QqK2MO+btQHxZSQxCIGFkh1aVXMYUemFMHNEATdoCNkfEjAaRKYqy4JOcyeVF3SiNVjrqmBSsXWIKN9xiEVmr7/twMkpZZ9tWXXykw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com; spf=pass smtp.mailfrom=jphein.com; dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b=Uy7gR8Ew; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jphein.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ba895adfeaso3533521eec.0
        for <stable@vger.kernel.org>; Sat, 21 Mar 2026 20:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jphein.com; s=google; t=1774150911; x=1774755711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QN721lRtWmbi9bOhPWGdYKhIZ/wWA3W0RLJU7AVYzQs=;
        b=Uy7gR8EwefPT62ZHjwl3TFLDTRueGmLqEcML2pajNVhRi5vASbOPq/Uzfk4BtSkT7L
         YjX4FKHPWEQpHBdnp+Ap8EI6lFgjN7LMO4FT3LspUVhaPszz0d4ML4wYIj1iYwOph9mf
         PmfRYj6RJvH9PTaDG10pD6lIH0Zc2xfLWHxfrNUJC2a03sdhP3jvhb7hH2LqOYwDb9Rk
         iOvEvaV140ZouBEEfK/Yt/wCg5STpkiur+oIxJvH752ah3thCdUTZpSqxFMLQYs7WEzp
         uB/ubM2evrkUZSpzvRdUSvEWLYVx4Y7xWEk+M1Jqrstir5BUwSrdq9hPXSupyxWFlCJM
         OvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774150911; x=1774755711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QN721lRtWmbi9bOhPWGdYKhIZ/wWA3W0RLJU7AVYzQs=;
        b=WjxJa+/HtoFswQBVw6swO7PoCWw5x/fpAehVLc3FNX9ER+naMsWvDBEgQufB7VXp8D
         d1XFA7jWR/8pJqiijeKter+OHIN0v7TGaf248BXkkiV/w7SyWRk2Y5smrGOxlpc0Hp6f
         0WtVu78g/nLwh3q/xM0X5gb8qozqfXbeqMqe9kuTX69yMzgHQN05nqetukbgjfFBhwoD
         VWawzTrkgzAmBc6Zl4OvcnwbAFNDlvsxgbaqSUsR0a4bqTFehhtL3QwAw3EX1T0/4c6D
         dTdOEIOvGSw2VsmNViC6DBrQS8MHhR9TMW33xEPTrrNV4R4SkcNA0vyibxcAhBRGnaYh
         nXFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrUBBM2l1wCn2KsNrenbynBKTn9MlU1KKRlCVBXmcjLah6A278EefoPAzU8OlOMSlp8yumzM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOVL2Sp9OuTZGsqVmBteqmCGO67SYg/69t6bSlc2bkIyuRXgya
	MLSBl5xRmUeIRH/milfLCRgVOvdhswMPD+lb37ukVnQjjG9ml7CQg5qTKQGsJMWxcw==
X-Gm-Gg: ATEYQzwvn1jBVWijAcfvhR61YHMQNSrXASabkIAVCmcr0z2k/HE8dsBhSulLp7YHxiW
	1qqe6PoLSaclhtHHoZfdls4KgCRBSzhqOOr3g30du+SYG76xPoFghgn44YF1Ty52QFq0QiBXMow
	xzsfLVHkJ91gMO+Z8xgaDCv7+ylxK/XWdBS+fGDTI6fB35KGgHSRRgKPJQdsz7CY1NSN8HBLtIC
	2TXnYsblUJNbLxb6hm2Le2rdARqzla9E2PYyJcrSyVIPIhlsZ25+C600ykn22z6Q3fLaUkxcE3k
	kSwT/4lF7qv5AfwAwwnO86r2//XdnhAcD7nHS2HMgvAKA23JpW0yHnWGrZ5mdpbH2ZQGA8gnLdH
	2DqnV8UgXbx3aIqXhAHpJ6puUBx7m+W9qiHQA3Pp1TVw9NwV3g0SDLfhes1b60I3htAZSZIr8Ri
	cvKGFmbB4f
X-Received: by 2002:a05:7300:6dac:b0:2ba:6854:8d4d with SMTP id 5a478bee46e88-2c109752e05mr3936274eec.20.1774150911255;
        Sat, 21 Mar 2026 20:41:51 -0700 (PDT)
Received: from katana.lan ([108.74.4.89])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b1961a2sm8989451eec.12.2026.03.21.20.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 20:41:50 -0700 (PDT)
From: JP Hein <jp@jphein.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-media@vger.kernel.org,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	JP Hein <jp@jphein.com>
Subject: [PATCH 3/3] media: uvcvideo: add quirks for Razer Kiyo Pro webcam
Date: Sat, 21 Mar 2026 20:40:14 -0700
Message-ID: <20260322034015.3629056-5-jp@jphein.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260322034015.3629056-1-jp@jphein.com>
References: <20260322034015.3629056-1-jp@jphein.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[jphein.com,reject];
	R_DKIM_ALLOW(-0.20)[jphein.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[jphein.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227814-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jp@jphein.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,launchpad.net:url,jphein.com:dkim,jphein.com:email,jphein.com:mid]
X-Rspamd-Queue-Id: AA23B2E8265
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
+	 * Razer Kiyo Pro — firmware crashes under rapid control transfers
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

