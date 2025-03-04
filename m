Return-Path: <stable+bounces-120220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5449BA4D7E1
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 10:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A1318842DF
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 09:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13B61FCF74;
	Tue,  4 Mar 2025 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nazYvmiM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93381FCD0F;
	Tue,  4 Mar 2025 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080106; cv=none; b=ql0x+FkJeFA4XtroZGaI2tE+ZaDga8gP6wEIdhEqwtm4M5uzIM2Uh8JPbDmpPQMm7iCwmk9FrKAGsivTjtR94WsxOjxiPBrN3n/HeMb3oRXUrsYbQbLhtCe/heSOi/ceBX6Fbe620sjcCY1844xJxU98h/0nkKSyQSUgBNfjrQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080106; c=relaxed/simple;
	bh=azCr+1OcqH2HsVt4DrcDOYqUvo77//LdjBUzlv6RrUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcE0yI6vMVrSZoNQZzeBmraAcGc+3tm7+oq2ciRXh+TatwJgOr3lcWuFYDWyyLxl/kUcwKe1npEDVdigcLP3kS4i+SLg+9NfCBFp1BPybdvuEU3R1ujlhAqJ48D4hdkzy6alJvfuq9HE6ROaRefWjthDbVcyK2rCHBCuVLDB478=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nazYvmiM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4399a1eada3so48929515e9.2;
        Tue, 04 Mar 2025 01:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741080103; x=1741684903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wg7mGlmOjQ3afyEBy88Ju9xfyq131NWRpH39XoWPJc=;
        b=nazYvmiMyJU6vu0eIz7qekvaBlTFu/R2E8F2VMv5RvOexT/G1VOb7a8gZ8IPKMJLiO
         nUrE21IceYTX7iUEu1envAcFRT1yAwSVMiyzTz5eyqrG1ncssA/RwNCrIm90XbmV9XUU
         8ChuKt4llHE03KKqZOPyQviW9GW3B8dBVrZavfn8YCGGU8g1RpR1bo//jtqzwvQLxPqT
         i6uZmLPl6Qe4d6koQkSIBtEZkb6PBD5GWh0zYwcfXV6eK+Lv8jHINxMmNOdLQJik/IDw
         VUOf23tAFImSnpHO/nFPaHomvpefd/715JEA0efq5C11CLyqJ1f/pYqfhkAy8MkHe5u+
         fCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741080103; x=1741684903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wg7mGlmOjQ3afyEBy88Ju9xfyq131NWRpH39XoWPJc=;
        b=fu6C+CLG6wNn+twCaUR8jWeyNr2mSeB6l0IgDO33KuBc7lWJchcqIvOu++bHpLp8Wi
         2nADcVQY8wfo+PdQvsDlWgq+S1HNnWrpRE6hTUG+eLNPBXgwgZgEt9feNLAlVLf5wOsq
         P3wsLOQkUdpMoBwkUnwvM5AOFkiHUBZRSfYv5g+zRp0H56JM1ZfyVA+CUwWeTEtLXuRj
         RIA6tmAXh70HunE3e/zejBJvgndFzQpBMvcfnF8Vn8cprB7P88GECJYBHq/r/H8im2Nj
         BEpAbVu15QWHi29u7HAa/Y5lw6kZHx+b2ZeVp247WGGgrUrDgnz5slSo185l5SBVwR52
         DRJg==
X-Forwarded-Encrypted: i=1; AJvYcCWimuWMSxnMRe4KzQAPXhulqjzDJt6ElBBqaf7MndWdokXT4z6ONXnfWcywftrViqLaK7efwrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydmvyhei4+f4t0WifjeMsjHkgAcEkR15rO7XsxMtnd+xLluyC+
	QGUz3x+sa/4kqWLWyMjyPQ8Ky6fyz/iHWsWsTIX/p5sQ6ZhiOBbS
X-Gm-Gg: ASbGncs7amxcu4c/9uOal8RTJNG2ZmnH00JR6lm+HGgzxLWs4XE6m/IDpraiso2jLq4
	7CC/m2I0t1EP0YQaUyRSyCHgTKTIWQ6MPbdxkgeAerDlg5WcBCNMwwmArTAwXzKCIXmfrX77mxW
	JpnpK9KzbZGDUsleSGZ5obJM5979q5fb2KQs3CC+ZJR14cOlSf1XKBiI23oQViG4KDvB1z1jy7u
	OEyh/LK+wjx0UJZVyl8pstPV7XIBL7lr3BV+48qkOG6bnsz+CxSKj/j5LQbkMBt571QEegAfvve
	pRl6BBBledz6iIXECGq7LXTorJ2UjOFrjaBruYlB1gB/sJ9ymEZld/3w0fs0AubWZXHMv8B0D/S
	mS1Nr2cyvgOFhw+RzmqsGwpkVOxVKkOqx1di7qQ==
X-Google-Smtp-Source: AGHT+IE1M+YgIQncyQrpF7ZboZiN0a2YrZRHwPt5Qu26mVPYI1jvZ+mdSR3yrzguHUKHfCRH5OgP6Q==
X-Received: by 2002:a05:600c:4f46:b0:439:9828:c434 with SMTP id 5b1f17b1804b1-43ba697ea88mr124363535e9.20.1741080103158;
        Tue, 04 Mar 2025 01:21:43 -0800 (PST)
Received: from labdl-itc-sw06.tmt.telital.com (static-82-85-31-68.clienti.tiscali.it. [82.85.31.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b6ddesm17069325f8f.41.2025.03.04.01.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 01:21:42 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH V2 2/2] USB: serial: option: fix Telit Cinterion FE990A name
Date: Tue,  4 Mar 2025 10:19:39 +0100
Message-ID: <20250304091939.52318-3-fabio.porcedda@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304091939.52318-1-fabio.porcedda@gmail.com>
References: <20250304091939.52318-1-fabio.porcedda@gmail.com>
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


