Return-Path: <stable+bounces-119829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E54A47B81
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 12:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5C2188B1D7
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 11:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476CF22FF4F;
	Thu, 27 Feb 2025 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWmqJm0y"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4835A22B5B5;
	Thu, 27 Feb 2025 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654543; cv=none; b=pO2gW5NkGtfLTo0e7j2Txmjv7888pOk9JzSFjitlube8t/swo9OX1B9jp+bk9gOrC2H+oPMGRjDtf8qVUbCqqKRlckx60K3ey4IWQbrBdcsU9SzkIXLqSZdSCKKLFDpLacpZaq2WZaimCVlpIUfEzt6TCyD+8iz/mlnnzdaFA2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654543; c=relaxed/simple;
	bh=azCr+1OcqH2HsVt4DrcDOYqUvo77//LdjBUzlv6RrUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+zXIZzp/lagMzqoZk6ipC+B9HOL3uHixMDk26YdrYhkiQEQfyNSm1WWynDft2G0FcIjPfBYmFOGNwR5G/22Hp1DRViZyapGb1tUqiXPhkYbSWHYC/pElu/z9NWU1VtIjfwi24IZ7QBN798BKr7YI08U/xukErlLvkBvbLOoBs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWmqJm0y; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-390d98ae34dso576672f8f.3;
        Thu, 27 Feb 2025 03:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740654539; x=1741259339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wg7mGlmOjQ3afyEBy88Ju9xfyq131NWRpH39XoWPJc=;
        b=lWmqJm0y4qUmQ1O2KoyXIwvA1hP21CqmUlepoH5OASC/9W7LHNpRlUNXfyexyx8chY
         +baC0+VwHlYyXZonJWbM7+yvQ1h2Fwx7RrUMdSKIFHKSNZsqu3zzkgxqlcb8XQ/VOiEN
         glgO/BwWsHiJEk5OJ49dBlI8vz8KP2Ow1UdN/JptrZYt3z2GPr9qOGuzFCNABz5O0bo7
         WscB3XFIXryZxf4jSCH0dNDCEneU6jZNx8ah/h3uRG6eCYfxQU6vAySSNibDN9qVIqeK
         Z3afKW/Svwb/PnqJS1hbcPl9tVDJDhkPiFZMRLG2HyDZ5HTcKJ+cY9wm9crticzHudgN
         XRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740654539; x=1741259339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wg7mGlmOjQ3afyEBy88Ju9xfyq131NWRpH39XoWPJc=;
        b=DEBNqwCYKmcXrP7fFWDO3JKY/7n+EcypE/xs2kJ9uldLM+sZXp1c8GE+BYrsGuvRaz
         qPbwnxJcuNfhU+Gxe93J2BEND1HbZgUdhrGx+7p30rs8ISqUJpLdeOmS0K++7efBPWbf
         OfDqyMhkty9hEeZNe9CyUgeFbn3dZzlI2EU8zTs9gcpO164AnUGXI0bivON04aQcK8F8
         ZVA8EZhFyOuNRX+lVfh8MuRgifx0ZlFfjPtEhzSvVcZmp94M0zILXVYwXGRNXFXGAKIa
         AG65hbXD2K5FKsQgJIUsRkXbPjJs0Njpx/NhoooB8ItOGy60i7czkEC8l5zLHaQVoT7A
         Z3hA==
X-Forwarded-Encrypted: i=1; AJvYcCUzcMOfXtBoShpxGwfVXlMA9NNltyXarhXwmmQf04RELyJFbLzdQv3sn8cGqMla+DOUOLLiezk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylUWmtVs83FWYE7XSFFruYcX7ZLroLsLvNJxFI9YsZcLRZflao
	orb1kKSUQYR5LdII4Lz3DuW2MzJJwRsMsUMMJK3jMbw2K4Fkxx6O
X-Gm-Gg: ASbGncut2mIcbwfhcz99HE0xz7BLvW+gxJ92pG140b+8uegsr6wipA3C4YqBj+699ig
	U3vzMnoLl9vW2jLFMXo3ViYJPLDo+2e8CUTzvpOZ5NVdIw7NGFslL3bay80q+g3sRjcYK0HZR0v
	6DPAUXPaiA36OeVeRsGJWloRkUYvPpb8u3M4W1DHjhG6EDk5EIl7bwH8u8Gvxf8AL70vL3HgT1H
	ZW7pF/+YLuCQjvD46KWoorc4Nl8srWl7uRUA0i9N9oOl1iGZTVREUQz1vC8fcCfhIN1PWm2myt5
	9ZojKu/6lt/QxR5u8BE3CWWeSqemyGVFjkRV70p/nSXJlWK0yeh7+cW8x+OZkMrSuKbfoJxzdQ7
	au4XfmMaCjeQ6GojGZvg=
X-Google-Smtp-Source: AGHT+IFhqo8xzQtbDiKaWSYtge3Lg3gnbWKcQ7l0CNMZAfmfje7C0hktd2/69Pm5A5BD8E11WGfuLQ==
X-Received: by 2002:a05:6000:1545:b0:38d:df05:4f5 with SMTP id ffacd0b85a97d-390d4f8b4f9mr4930618f8f.42.1740654539268;
        Thu, 27 Feb 2025 03:08:59 -0800 (PST)
Received: from labdl-itc-sw06.tmt.telital.com (static-82-85-31-68.clienti.tiscali.it. [82.85.31.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a28b285sm18961665e9.33.2025.02.27.03.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 03:08:58 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] USB: serial: option: fix Telit Cinterion FE990A name
Date: Thu, 27 Feb 2025 12:06:54 +0100
Message-ID: <20250227110655.3647028-3-fabio.porcedda@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227110655.3647028-1-fabio.porcedda@gmail.com>
References: <20250227110655.3647028-1-fabio.porcedda@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The correct name for FE990 is FE990A so use it in order to avoid
confusion with FE990B.

Cc: stable@vger.kernel.org
Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 drivers/usb/serial/option.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 8660f7a89b01..c52d6a2146ff 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1368,13 +1368,13 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(0) | RSVD(1) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1075, 0xff),	/* Telit FN990A (PCIe) */
 	  .driver_info = RSVD(0) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1080, 0xff),	/* Telit FE990 (rmnet) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1080, 0xff),	/* Telit FE990A (rmnet) */
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1081, 0xff),	/* Telit FE990 (MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1081, 0xff),	/* Telit FE990A (MBIM) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1082, 0xff),	/* Telit FE990 (RNDIS) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1082, 0xff),	/* Telit FE990A (RNDIS) */
 	  .driver_info = NCTRL(2) | RSVD(3) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1083, 0xff),	/* Telit FE990 (ECM) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1083, 0xff),	/* Telit FE990A (ECM) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a0, 0xff),	/* Telit FN20C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(3) },
-- 
2.48.1


