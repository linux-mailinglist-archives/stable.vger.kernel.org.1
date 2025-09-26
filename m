Return-Path: <stable+bounces-181768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64875BA3C78
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 15:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1A017659B
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 13:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5488B2F90D5;
	Fri, 26 Sep 2025 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fbfy3VJj"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333BB2F60A1
	for <stable@vger.kernel.org>; Fri, 26 Sep 2025 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892295; cv=none; b=GWLDYZrVBeJH9DbpGXe85u8vefr3763PzQZopEt38yXNdkrfJFUfuJQXqxiUBw/rc8D9lr+R8On8CahH1Q8XCicQfqs35rsOTEGfOvCSxmKBC4O1TbVCbSGJZizyIbuX/uXLfx78KnGUONSztTPiCACZIqXEjSGG29VLRL0KWKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892295; c=relaxed/simple;
	bh=fN1yQSZa9dGNYApiBN9DJ0yzGqYY3io2zaEeifTv+AY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NsLt8+1qVmptgBUhQDUYKlPNjplwAvgYdui+N9Suvy4P6PI7VanYpkPkAgpcSVSKLU56M1KsAR7iaRU3ZrOUPaBzvhaJry0DcA5DR3JWCsDCd6HDSr/eKfsxq4cD+ruk/2mL/CQ9aX9GgGNx4IcrWFk9e88QQiR0KLU464/vLmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fbfy3VJj; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55ce508d4d6so1859812e87.0
        for <stable@vger.kernel.org>; Fri, 26 Sep 2025 06:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758892290; x=1759497090; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nuHd6eGYommvO3UskpqEqtJdP8+N3udV7UPBSp5lsjc=;
        b=fbfy3VJjC1yaYytPKZzTYRVoy+OCnUkOEtEIUZ3x3cYqigUyyXha5Va4UzDiOILmAI
         z/9bf24ITk1PxUsoK1WCTsDg7wY0GXAeUPCKIViGPcEP9BCiaDJ+LwEYvb6cDV8LIwkb
         D5w2rHp5jiXapkSCe1hEBuefH3fRV5/UiEHiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758892290; x=1759497090;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuHd6eGYommvO3UskpqEqtJdP8+N3udV7UPBSp5lsjc=;
        b=TdguqpT3C/DdhPTK4KZeanewLSMerWQpqwgMMWLtXZhq7buErH5NqF7sICgUcFSEtr
         hn+44u3KfN2slTAPAg1O6QRcfAOoDOifXCH7UVoWW6r3qIDjJvxLMNOFzzmaPSzdBFjA
         HV4DywtEIVkq/RFsPbi3F47533kO2eDn5ShJ2Zf7V7HQBP4ZvhX5AWf+ma8LLTIjuCdz
         uj2g7ppGPPA/Lyfx6zzeZ3trNmzO4fT1FEBrG8Qr2DtwUh2WS2I8C6UNQbs3Ipapsoje
         2XF4A9KTrJndpJ3AXMeoYBpSwkKQBT51JKmmlNzntglL4WxezYDDRJrA+PB/rBdZQzFZ
         5e9g==
X-Forwarded-Encrypted: i=1; AJvYcCUrYvpNC1JihRS0cZy++CuOs5CFuL01SWQOwdpODuTB4sKw3XNji9KkESN0Fbmb05H0NvBxeYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4m+SEvTh2/GP2z9zPiMaYoBOszc6fQNHzxcDZpetDrIfgAT3t
	cT78cSkIqpNPGJ3aHaSFG3DN/XqHVgFVnfDU3eH9PyWPCcvhn+FL8kCLCv4KLG5tIQ==
X-Gm-Gg: ASbGnctyB0FwCIiKWrbjUTC0bPFlEbBwSnv8TUbURBcTddHMmvkv5AMqH5rWgkWX+2U
	7v9zfd144gdlHff4/oroSY8qPdEiA5ogY805fC5XPGhGVfwXFv9I9LFOtV5nwE+fEXFc3zqC9rz
	C8JxvZw4R6WMdTseMHFWs5//mOMCuS5NSjBHmLP1OXMMEckCtEfz3UXCDK9dsuHM+hWN4VK8hv8
	OVPP4YhsSeEfl3qUxoqj+sKwXrQqq9vyPtQLVCdPp2GAdJj5MMtIHJkAEBLslsOp7a+tBPWy4Xj
	N7gD5l2euJATo177KGaeg2FOtUfZj0tgMXWv7n0tsX/17jAqvGmYQJvs9Juic88JAJKr+CwYtyq
	CiXWQyv7n5+VrmyGcV/3Heg2O7bYkYFNOFe6rRPvi57wEQAKKbYQnU+R+i9PaAk+h+ZFLTjWmSF
	eGBvN5AUTnIScnIMiWPNf71cI=
X-Google-Smtp-Source: AGHT+IGBibbMbWnp4wsYYpcAZc4iOvKmHvOhd0/KxBOtu8sk83ypjF+oQ0w3P1LE9KQVYZ/8hnbPDg==
X-Received: by 2002:a05:6512:61b1:b0:57c:2474:3743 with SMTP id 2adb3069b0e04-582d2f24dbfmr2344139e87.32.1758892290146;
        Fri, 26 Sep 2025 06:11:30 -0700 (PDT)
Received: from ribalda.c.googlers.com (64.153.228.35.bc.googleusercontent.com. [35.228.153.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58527c6b014sm123872e87.43.2025.09.26.06.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:11:29 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 26 Sep 2025 13:11:25 +0000
Subject: [PATCH v3 01/12] media: uvcvideo: Always set default_value
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-uvc-orientation-v3-1-6dc2fa5b4220@chromium.org>
References: <20250926-uvc-orientation-v3-0-6dc2fa5b4220@chromium.org>
In-Reply-To: <20250926-uvc-orientation-v3-0-6dc2fa5b4220@chromium.org>
To: Hans de Goede <hansg@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

If the control does not support GET_DEF, the field default_value will be
left uninitialized during queryctrl.

Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
Cc: stable@vger.kernel.org
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 2905505c240c060e5034ea12d33b59d5702f2e1f..a869257e9b7c07eaa7d725d107bd1cb57d3c7377 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1542,10 +1542,11 @@ static int __uvc_queryctrl_boundaries(struct uvc_video_chain *chain,
 			return ret;
 	}
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_DEF) {
+	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_DEF)
 		v4l2_ctrl->default_value = uvc_mapping_get_s32(mapping,
 				UVC_GET_DEF, uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF));
-	}
+	else
+		v4l2_ctrl->default_value = 0;
 
 	switch (mapping->v4l2_type) {
 	case V4L2_CTRL_TYPE_MENU:

-- 
2.51.0.536.g15c5d4f767-goog


