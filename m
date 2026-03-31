Return-Path: <stable+bounces-231303-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEo6N4wXy2lrDwYAu9opvQ
	(envelope-from <stable+bounces-231303-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 02:38:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E732E362B7A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 02:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 79B6B301A1DF
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 00:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C3327A92E;
	Tue, 31 Mar 2026 00:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b="R+qyK77g"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132FE2C0F75
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 00:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774917494; cv=none; b=j08yjCIjipEnWQvzEBO+JwIaZJzYzyLTiq75Jy+VdS2fuRGu2l3LEhA4jRFgxiy5A7nCkpm6+zn0ZmxX2isB5isY7xmKhKkluBYYV9WHy5PUj72YxSiNm7cJfru3AYFDzsEwsuxfg2KR5qYLwTY5JT8BdKRQE9+WNwmlsKGrUJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774917494; c=relaxed/simple;
	bh=I/Eif1ZRTDEQrnMNfjbO5VHLbe1G0lSEoJ2HP69/lqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0gwI//sWHbWBHiKPABsUiJIJC5OMct3TnJhBKYdfMd8oO2krGjSU50nFFhpkpN3zCoFJV+VMMl/rLA3YLryEMWpUm1SmhwgPRQe0QHax0siDAj7xnQUlUuUiimkxzsYGk5bxWBWXU+Jc8UtvMgi4vsZxZqjYuCcey97ADfKEj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com; spf=pass smtp.mailfrom=jphein.com; dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b=R+qyK77g; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jphein.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1271195d2a7so2318405c88.0
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 17:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jphein.com; s=google; t=1774917492; x=1775522292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDFymdpKeXfGYj2x1HV3pjSU2EJtPwV7qvFYD8NzPH0=;
        b=R+qyK77geQ2gbFIKiUkXOILkT3qEvYDYid5CXTKI7g0DeDhiohTbaPn8Qm2IUu+rSy
         XdHRB1q/k7otYUyWAu3GWWx4EfcmtGZsy59XMfV/kLcZs4snPDK2jqzEO/W4c0vczwSk
         zRQLp1/w3yI8jv8GeRC3kjfjvIaJC4zIe3xLQVfr1F5tNMYrrUQdtdkB2BWfUZdqPo6t
         PRkPi+Jj8d0+0kILnYAgTrQ7i1/0cxsk7/yE2lcs9k3Z22cN2SnwE4EAk1P/rrorvuZH
         GTs+0IyF+1IZBvz724lfzQKKulyI97l+NT3UXIGlu+/p1QO74uVe3N0JkB2ckEME7FPr
         QwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774917492; x=1775522292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EDFymdpKeXfGYj2x1HV3pjSU2EJtPwV7qvFYD8NzPH0=;
        b=dAFMyoD6LaagrgqSzymZxctNYKla1oKujHlbeGSE3ZsNBj2MSvcFvPobXgGd9AJ9eq
         Xtf02jnsy7iwbtueMHipNyTIOSyWJtW89/UfQpDMC63IheZb04lklUi2jUpH565ZElFi
         X/4VLPiEaMZfAwPoZzJkQcHAgjFJ91z9msrfUucbfTFrB4sxgMDNUz6Nh3WEHLCZQV8f
         hCckDpdLApVDO9fIS2Bzerg7Fii9GQRgEcClnWoyk67gj515yPZPJ9GxLL2wEBeuresO
         iTg817F5EZ+jEK0hUqNZBn347TlPFbn6oJ7bjfti6XNIP5K585B9vt2OS9LeKdzBkCcr
         wm7g==
X-Forwarded-Encrypted: i=1; AJvYcCXRAslowYPQNBCYZDJ6Kv9qFlOmNeXxQxBZpDNc5f3lRn1aCSAUtEr9wSKav4bcOcnizWIq9sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSBcVxyaxbUybHywgsuyZMqewzpsqSjL6ZG5A1BPDUzmexCbCr
	vL4LOW29/v0dwgTat5FL/pcgbRHsWXp3M9hxppnQ/ILzSWFggtQ9YR/TdVYCwkhH/g==
X-Gm-Gg: ATEYQzyKHce7wRPYnj/hBZZ2fb3IZ4nTUTJtP1XPM3/4hjST1qhfqvb2uoogC2QkIH6
	L6RGTSZpIPu07fJ3Hp8PNS3vK/36y50HK6ogBgXdW4CaBeq0Kuk/ih+VG/XBTBJKejTz0Fat4sa
	OXFe7PXjH0l5uvE9U2qi6NvccBXeQTBz2RHkYNsPxOBP/S5Q8OLy/Xhn4pyVFD5QEwl2W1SeWdF
	OuiSEYVTe6aunaIhi6+VUaxfgikZKGMzQJLiEewTTYiu/cEjF4n9+bALjwVx8L4FqeHlfIT7jip
	ncCPoEds5gM6AquK1vziCF8j4+GHNk6HVgr1c3JSL6xY8LGgJb9XbRRQtYq7Jr44GPYrOseEEMh
	WzF2TaUYQKm0UA+5OvEwC0Ff0LeL7XWlijHEK7ii9niBC7E6GILeBFxZSEmwW+ND5tAs7sZ9Gmr
	flu1KzFAKrkA==
X-Received: by 2002:a05:7022:4589:b0:127:1492:e370 with SMTP id a92af1059eb24-12ab284c058mr8507096c88.5.1774917492054;
        Mon, 30 Mar 2026 17:38:12 -0700 (PDT)
Received: from katana.lan ([108.74.4.89])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab9864810sm9343057c88.12.2026.03.30.17.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 17:38:11 -0700 (PDT)
From: JP Hein <jp@jphein.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-media@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Ricardo Ribalda <ribalda@chromium.org>,
	Michal Pecio <michal.pecio@gmail.com>,
	JP Hein <jp@jphein.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 3/3] media: uvcvideo: add quirks for Razer Kiyo Pro webcam
Date: Mon, 30 Mar 2026 17:38:06 -0700
Message-ID: <20260331003806.212565-4-jp@jphein.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331003806.212565-1-jp@jphein.com>
References: <20260331003806.212565-1-jp@jphein.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jphein.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[jphein.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,chromium.org,gmail.com,jphein.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231303-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[jp@jphein.com,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[jphein.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,jphein.com:dkim,jphein.com:email,jphein.com:mid]
X-Rspamd-Queue-Id: E732E362B7A
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


