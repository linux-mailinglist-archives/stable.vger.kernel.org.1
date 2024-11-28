Return-Path: <stable+bounces-95757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD769DBD17
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 21:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8144B281D6E
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 20:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDFB1C4606;
	Thu, 28 Nov 2024 20:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hH89A8WH"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739EC1C3301
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 20:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732827262; cv=none; b=G7kJOE+r2mdSdnB9TJBazeynP6ZBB3nyPqRXqrhkrQtZOD6z8crJOfL/cgfQkTmn4eYCBLF0/zAmdMiOtPhtFzE+1awHZOw6RS4IFS208ICuPE3OvBjw1C6Rsa3DXRRFuajf89G+FQITMGUPMnXB8qtB5XdiSgr8g4syToAWODA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732827262; c=relaxed/simple;
	bh=H2sUBB+fsICTdnFjz8Lj6jJqXgJsJGlzoShvTjrlPXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ma/AW4GeKnl1jUsWaYtUJIrKxJqruTvQmv0R2SHqiYsEApxR6l3BJTpv1Opz3ufvUQ4LN5G5uFmZyYdAwrreqtseR9qIvq2ExHV3wiASwSjOGEDcTanMXg0tzWV8DK7ea6aBQgyzDghGS/lRk/+tkw0Jme0QiFoeSxZQFyb37oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hH89A8WH; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46684744070so9423911cf.1
        for <stable@vger.kernel.org>; Thu, 28 Nov 2024 12:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732827259; x=1733432059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4fn8wn/VKVd1lfp+Uuux+ZckEB87hkFaLSp4OUxjOQ=;
        b=hH89A8WHUG40tV201+z2UytElqO0LZFfvRmZ+eqK5zNiTc7jsWhaBu9sU8m9g4ALLQ
         4DDEss1NpXkE0+pYMyPRqEmPQGtL3G7yHltYR+KWtUDAxevdE+3tpbovp2PKQRMlDFpf
         GwNmOBQK3PhDGWkfz54onmfCP2YYkzukF00io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732827259; x=1733432059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4fn8wn/VKVd1lfp+Uuux+ZckEB87hkFaLSp4OUxjOQ=;
        b=W13Fbr6XmRXm0PhCWSN7xJgKI0At2wW0D5AZI4SZ8PzmYsf/pKeQ9ixKdWNa+WMIa3
         E/R+hZIdqcD2ih/nqj3ZNhKnmGCZ5Mhglof/GVUvjMZWWXkRAtTE8Ous50/cqUT5wLgG
         TDsRYmF7E1TiL+ld6BkHNyzz9nYASFO0/DZlQosGN/SWpStibQJ7n7hyB3+AOBWRPpe7
         npTSyaVeHbjtsBrwbYr/BEaqkgP3OaVito6Mmt0PKkJoUsB2Kdfezouu6YtSolMqfFCF
         SD+qUOcDcwz/ps9FD/76ExrbEoNTj9HiJYjmMkxIBmxLq6MGGP3Xx6381re4w+PsOwZh
         PXGg==
X-Forwarded-Encrypted: i=1; AJvYcCXJlgVvuqTFT+GfKloLSO2MBOtJQ5SSKBaNxRrYk4RBk8Q+ZRhDMXFE1Hl2Z9MoRpbdmO/MivE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOms6ChVlNrwJcWcRYRmF5FKBD32NQVzt0UDAVegY2YzURPdFx
	2nRThf3rySJb9JtNOWwN/+4VQtKP01nkKPcgGLJPnPXi3psnSpNJB75BOeywXbfRX0A3A1Xcoj8
	=
X-Gm-Gg: ASbGncvUXnQk+e7PgBeynkuT4Yk9N4Q2YRh9IbFgM4EfszcR89eOrNsyULD3tkpyyP/
	8MnDZx+3QX+riTjg8BITAT4/qsnSacCiHdQi1GUkracfIdYwcVeGBBsRxe+5oXa8XE9bXC02+aL
	nZe/NrrYrv+eiFwg6HJ5b1gM4VSORqghvFguXLtHoUNTHZr7IYlMDuidyiufgbHfBpH/5JoJ/Xe
	2leHXri1VMbR1eelIVQ1GeD/9vgck1jLHu3ye9djI0NnIbM3rVh81diXsuL7M77W8shQN+Ymdpr
	iQN7CBAqmiYlB5UtL0eAQRHw
X-Google-Smtp-Source: AGHT+IGsQPPcE1Y6kRMFJwvkPvXDD4RZbAEeird+u3mx85igV+v5RYgUf1lgiIsUgpYQjUBWW7Ft1Q==
X-Received: by 2002:ac8:5d94:0:b0:464:c8f2:e553 with SMTP id d75a77b69052e-466b36549f8mr88277511cf.42.1732827259063;
        Thu, 28 Nov 2024 12:54:19 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c407e6acsm9923421cf.52.2024.11.28.12.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 12:54:17 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 28 Nov 2024 20:53:41 +0000
Subject: [PATCH v5 1/2] media: uvcvideo: Support partial control reads
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-uvc-readless-v5-1-cf16ed282af8@chromium.org>
References: <20241128-uvc-readless-v5-0-cf16ed282af8@chromium.org>
In-Reply-To: <20241128-uvc-readless-v5-0-cf16ed282af8@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

Some cameras, like the ELMO MX-P3, do not return all the bytes
requested from a control if it can fit in less bytes.
Eg: Returning 0xab instead of 0x00ab.
usb 3-9: Failed to query (GET_DEF) UVC control 3 on unit 2: 1 (exp. 2).

Extend the returned value from the camera and return it.

Cc: stable@vger.kernel.org
Fixes: a763b9fb58be ("media: uvcvideo: Do not return positive errors in uvc_query_ctrl()")
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index cd9c29532fb0..67f714bca417 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -79,6 +79,27 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 	if (likely(ret == size))
 		return 0;
 
+	/*
+	 * Some devices return shorter USB control packets than expected if the
+	 * returned value can fit in less bytes. Zero all the bytes that the
+	 * device has not written.
+	 *
+	 * This quirk is applied to all controls, regardless of their data type.
+	 * Most controls are little-endian integers, in which case the missing
+	 * bytes become 0 MSBs. For other data types, a different heuristic
+	 * could be implemented if a device is found needing it.
+	 *
+	 * We exclude UVC_GET_INFO from the quirk. UVC_GET_LEN does not need
+	 * to be excluded because its size is always 1.
+	 */
+	if (ret > 0 && query != UVC_GET_INFO) {
+		memset(data + ret, 0, size - ret);
+		dev_warn_once(&dev->udev->dev,
+			      "UVC non compliance: %s control %u on unit %u returned %d bytes when we expected %u.\n",
+			      uvc_query_name(query), cs, unit, ret, size);
+		return 0;
+	}
+
 	if (ret != -EPIPE) {
 		dev_err(&dev->udev->dev,
 			"Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",

-- 
2.47.0.338.g60cca15819-goog


