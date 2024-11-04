Return-Path: <stable+bounces-89715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C3E9BB93F
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 16:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603E01F22CFC
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 15:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89371C07CD;
	Mon,  4 Nov 2024 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lan3FGje"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BCD1BC07E
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730735018; cv=none; b=hnnLtvzgdoOQhdSTfvPYpzl5RlFNMPVekjEZQYAMHRby/uPWl5EL5qvH4QsoJfadIPq58scBcQJpLpb+ivd8YxiWTU3wzXFJmmp+PA/QyNWAo4l8nU7aqLRVQKmY4nb2XZ72rpMWmUUVjSy88mDH3wHGsV3OMNdsRvewVNkNiZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730735018; c=relaxed/simple;
	bh=fp0YEPYwGjJLAhpgB+UUosfugQrJWX9Urb1XcuSwqvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D8CY2xwZgLJWdEQpdXa3x84WaFzZDUKn//lxThwx+km8Yo9AOzy8SimcyHZ2DxjwKTthGDYU4DTHnrO4mltt9cFu2L/spYNsvHrByFOHHUb7JHkZP++BdSKlwGEjrW3Yx7M+n6SXdXPSEScJP609z2WC9W+bxJwTWTwAtrM6qsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Lan3FGje; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso561511166b.3
        for <stable@vger.kernel.org>; Mon, 04 Nov 2024 07:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730735015; x=1731339815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WIkerbplFMR1RplSxBpHFK5IGgrO9YeD2ArdYO9Rppo=;
        b=Lan3FGjeHqj/UNCGg86yiWCfMY7SNfS2Zy2QRqJ8pA3gcjhCeSC/b/+8c+MANilB7B
         0BWtE0wF8NhL3J99XCY22CVXpyZrZ3sdyuNNvszow736oD24bQfrB71J+7GUIzruV1+b
         tB9PNmEvJttk+uL7fRHac5s8+rr7hbcD6g8eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730735015; x=1731339815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WIkerbplFMR1RplSxBpHFK5IGgrO9YeD2ArdYO9Rppo=;
        b=SrCbReIcTxLV7twg7io4xOOVSkBIt1lz8N3fSOopfCKl5eKlJtJ2a93QXO6BDJyfpT
         Cypbg5YVmal9I24bSvbwx9Qj+fpGGEoKyfzD5/9Z7XlwKGRT+uEocXjnfFeorvpdr9s5
         r2y/9CVjT2QuimTep6eilf51VCR9DcjTHFJq1DJ5Rm/SejGhE6Nc3vUpmLmzZT6bD1wq
         eIqu08qeq1u4LdwRCeAh9yfPYsyy6vnj1wuShGEgkLU/vNVvXr8s3pPTmR9rjr3s8R2Z
         hFeGirViS3/rhyuvzMbfLYByjbuWDaOgssKRoOTS0oEg4auvkSoAVroXXBOY7L1CDK8G
         3Wew==
X-Forwarded-Encrypted: i=1; AJvYcCWm5nxeOgCwq9ZKgQOtnPiPHQzc1VQCrT3yW0LMfHWbNt6njjltlVh2gMhW4vGM6HdPNi2sPs4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz61OGJH8kUjkeUHbvoiM4Muxz65bLChFw3OgDTRLOWIKZEwHZm
	zodSXOkpQGqG5KjAU4U3+oPVKMRd2FeGoR1hJfts0on/bs/mDv+L6uHy1/WB
X-Google-Smtp-Source: AGHT+IGy/uj9RNWEnEbEX3eDDHGESv3IAzwMLj2fK+/jHp8/V1k2EhfogN4oCQNK4S64k1Vz0bazYQ==
X-Received: by 2002:a17:907:e8d:b0:a9a:1437:3175 with SMTP id a640c23a62f3a-a9e50b56a1emr1553396366b.51.1730735015026;
        Mon, 04 Nov 2024 07:43:35 -0800 (PST)
Received: from ukaszb-ng.c.googlers.com.com (103.45.147.34.bc.googleusercontent.com. [34.147.45.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56643609sm564173266b.155.2024.11.04.07.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 07:43:34 -0800 (PST)
From: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] usb: typec: ucsi: Fix completion notifications
Date: Mon,  4 Nov 2024 15:42:52 +0000
Message-ID: <20241104154252.1463188-1-ukaszb@chromium.org>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

OPM                         PPM                         LPM
 |        1.send cmd         |                           |
 |-------------------------->|                           |
 |                           |--                         |
 |                           |  | 2.set busy bit in CCI  |
 |                           |<-                         |
 |      3.notify the OPM     |                           |
 |<--------------------------|                           |
 |                           | 4.send cmd to be executed |
 |                           |-------------------------->|
 |                           |                           |
 |                           |      5.cmd completed      |
 |                           |<--------------------------|
 |                           |                           |
 |                           |--                         |
 |                           |  | 6.set cmd completed    |
 |                           |<-       bit in CCI        |
 |                           |                           |
 |   7.handle notification   |                           |
 |   from point 3, read CCI  |                           |
 |<--------------------------|                           |
 |                           |                           |
 |     8.notify the OPM      |                           |
 |<--------------------------|                           |
 |                           |                           |

When the PPM receives command from the OPM (p.1) it sets the busy bit
in the CCI (p.2), sends notification to the OPM (p.3) and forwards the
command to be executed by the LPM (p.4). When the PPM receives command
completion from the LPM (p.5) it sets command completion bit in the CCI
(p.6) and sends notification to the OPM (p.8). If command execution by
the LPM is fast enough then when the OPM starts handling the notification
from p.3 in p.7 and reads the CCI value it will see command completion bit
and will call complete(). Then complete() might be called again when the
OPM handles notification from p.8.

This fix replaces test_bit() with test_and_clear_bit()
in ucsi_notify_common() in order to call complete() only
once per request.

Fixes: 584e8df58942 ("usb: typec: ucsi: extract common code for command handling")
Cc: stable@vger.kernel.org
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index e0f3925e401b..7a9b987ea80c 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -46,11 +46,11 @@ void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
 		ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
 
 	if (cci & UCSI_CCI_ACK_COMPLETE &&
-	    test_bit(ACK_PENDING, &ucsi->flags))
+	    test_and_clear_bit(ACK_PENDING, &ucsi->flags))
 		complete(&ucsi->complete);
 
 	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
-	    test_bit(COMMAND_PENDING, &ucsi->flags))
+	    test_and_clear_bit(COMMAND_PENDING, &ucsi->flags))
 		complete(&ucsi->complete);
 }
 EXPORT_SYMBOL_GPL(ucsi_notify_common);
-- 
2.47.0.199.ga7371fff76-goog


