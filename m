Return-Path: <stable+bounces-181769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9AABA3C90
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 15:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21CDD17C05B
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 13:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3812F9C2D;
	Fri, 26 Sep 2025 13:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W3fnMtY7"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136BD2F616C
	for <stable@vger.kernel.org>; Fri, 26 Sep 2025 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892296; cv=none; b=LT+k8HTHvnkeL02HriWf9KPfS9RDS1u1gKKSvnIQv1RMgfKr6PBAvc9cODkuU38ecvYyzwCa5h333eB8J05BWqgR+iRiRWfICZp2kHR3/HVRKoxFYhzVP8Mv1ljw2PdQUpnmli3VayknnrDi7nOXNC2GFKRGrvXA8Q2LUmUUanc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892296; c=relaxed/simple;
	bh=HOaXKeMMBeof7Hx+tzoNDTO3vGlaHvg7CjV+p573b/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kwI3//DT07wTtKTZpf9zi3TdjEh94vbmUX9FlPSEBLmPapttFpjHlgGs4sqHX9TQtljQUgWs+S8OGlPCiriGDRSTSnxyaLPhkRbRGdT1eN1SDuhYbzH1nOjeGbLpslX0t9guk9wO0OjL0dMl02PKLa55nmPd/ZYfuJkQxBwseuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W3fnMtY7; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57e36125e8aso1939387e87.2
        for <stable@vger.kernel.org>; Fri, 26 Sep 2025 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758892291; x=1759497091; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zavqbvAJpl+vVyZ8ZvtBFYz19hBaBOc/P6wczkVBqDY=;
        b=W3fnMtY7RjqTLLDo7fzH9PJwwFjlLgWOiWVpSz3GM1AcM9VAqRpDxKfOEdmKVo4S2I
         XBdaLHBPk4EAGufl1mBMbGd292pNFTULimhrWJkJMQQgXTCgMozzhgjL+Qz66suCxhmd
         lahvQdfpNYueP2CVJHkP2abV3KmqPkBb2i+VY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758892291; x=1759497091;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zavqbvAJpl+vVyZ8ZvtBFYz19hBaBOc/P6wczkVBqDY=;
        b=GG8R3s1mELyovm/L0BzUWS4hL9q7gbYECc+URpEsW+pg9Pj8Ap1SzzH/xLi9ahA+4j
         tmVd63dPbyxovQmAcYykqP2SrGSUq7LYsWMrnuO1M1/Gz30W/KgWDEdz6w4mACX/sfKb
         LAT1SsGUrKAkoS3NAWXzAqmKPYW+7DYGYHm8Pedu2uScWwmkrdLbZ5TNLDNlD0m2c8u5
         4PMz8dvDsGSB7fJc8X7p8ZCnfdHmBPjv+86nmarIrwPy3iR5KWYXKPRHT2PUE4IsyfOh
         RLqfdAaSC8iP6RqRBbym5kG5WgYHUoZTDlLSiw2p/7EHAWCSJH8WdcqCkSZucvKp/QFO
         gAKw==
X-Forwarded-Encrypted: i=1; AJvYcCUT4K/58U9febDeBSX09HTbDhmo5aaXX0vs9xFRF1c6esaqPSMpfDJOzoMd6MLXxAl/JEsiGUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHkeRwMfdW3eTrhYnkaWKQwJCAL34QQi0fg8KrLw0pSjrrsSvm
	2LNLP1zaW4iBfUWiAHsz4hxLDOXMkvffiB+Q/mEP2v+6TTwGLEQnCrpRyKcVjjuLNQ==
X-Gm-Gg: ASbGncua91d8rLbViQkAYhWx268aeNatAYh7T0lLxGXip9HC8V9tJacuRQPQSqXc9wQ
	6KJ31mwv3GKU16GtafuZD0CW54xbAgBhSQidBcVIWicwqUCAb/ZbrXr2C1/95wiZxB0xPNpH6B9
	ayQnhNkfBPY3Cx9ManyRoObZxhmdGaTcrUSgGYDLoQlQo5k9we0oyTk6PD65AN6KzI/saY4Gpyp
	idg6ooOIQSgrarpfbog6l5VoEM8xL1meQoE21v0KKx8l2xD8+HtEPpTTSu23MdsNH/84xVDMCUh
	TKb+sETWieKkf9iDuANftujxKbNvAI1NtiRFINBhrLZ3b72Vqrhp0nWe23UCxLEyOtANZcDl/UW
	mxaRXsP2Wx/uSLgZZs/82LrmAq8psGCAegIu4EF9ozS0t5C3myHybs4c+YszeYy3FhtVD4LEmbp
	RtqHq+YmyyPl9j
X-Google-Smtp-Source: AGHT+IGYNymib7YkYpDINQtE5FTKayVP9W8HaNUBBncx14Dot8LXrbwZoz7D11yG6qpiPKpfo0xmbQ==
X-Received: by 2002:a05:6512:b27:b0:55f:435e:36bd with SMTP id 2adb3069b0e04-582cd97cc3dmr2187251e87.0.1758892290687;
        Fri, 26 Sep 2025 06:11:30 -0700 (PDT)
Received: from ribalda.c.googlers.com (64.153.228.35.bc.googleusercontent.com. [35.228.153.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58527c6b014sm123872e87.43.2025.09.26.06.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:11:30 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 26 Sep 2025 13:11:26 +0000
Subject: [PATCH v3 02/12] media: uvcvideo: Set a function for
 UVC_EXT_GPIO_UNIT
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-uvc-orientation-v3-2-6dc2fa5b4220@chromium.org>
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

All media entities need a proper function. Otherwise a warning is shown
in dmesg:
uvcvideo 1-1:1.0: Entity type for entity GPIO was not initialized!

Please note that changes in virtual entities will not be considered a
uAPI change.

Cc: stable@vger.kernel.org
Fixes: 2886477ff987 ("media: uvcvideo: Implement UVC_EXT_GPIO_UNIT")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_entity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
index 3823ac9c8045b3ad8530372fd38983aaafbd775d..ee1007add243036f68b7014ca621813e461fa73d 100644
--- a/drivers/media/usb/uvc/uvc_entity.c
+++ b/drivers/media/usb/uvc/uvc_entity.c
@@ -85,6 +85,7 @@ static int uvc_mc_init_entity(struct uvc_video_chain *chain,
 			break;
 		case UVC_VC_PROCESSING_UNIT:
 		case UVC_VC_EXTENSION_UNIT:
+		case UVC_EXT_GPIO_UNIT:
 			/* For lack of a better option. */
 			function = MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER;
 			break;
@@ -105,7 +106,6 @@ static int uvc_mc_init_entity(struct uvc_video_chain *chain,
 		case UVC_OTT_DISPLAY:
 		case UVC_OTT_MEDIA_TRANSPORT_OUTPUT:
 		case UVC_EXTERNAL_VENDOR_SPECIFIC:
-		case UVC_EXT_GPIO_UNIT:
 		default:
 			function = MEDIA_ENT_F_V4L2_SUBDEV_UNKNOWN;
 			break;

-- 
2.51.0.536.g15c5d4f767-goog


