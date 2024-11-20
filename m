Return-Path: <stable+bounces-94439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 364469D3EFA
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 16:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05FC28415D
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558CE1BC086;
	Wed, 20 Nov 2024 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U5u/ebRg"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5F91A4F19
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732116390; cv=none; b=W+isCHw9NRf3H1msB1MDyqk+GL60zUjn+fgCOWG+qazL2FbRme334fw2X6Vk8x6VC33nlGujdDLzHZT962V9X2rfQxWOMTKxSzqWk4aXfyIkfrQ0I2+A0+niFubxQ2SUgkY5iAjc9C/ExTQERl4OAad9cq2JTrXqZ/qawg1/CD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732116390; c=relaxed/simple;
	bh=28TVCm8cQpV09q+k2GaQ8E5UnNRGHov9tfjPf83ZwiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n30y+2sV/Rvqbva+gKTqlBZgpBaY+KuvmK1TmlDxGR0b0+dCqWUx9fT2v2hfQDAgE109YcFski9IX2sxKS47+6Z84llPkGIK0nUjkMW0S0vtQgamy16jH5+Fe5Eq7yD1nMug8Xl7Z0YBlYSMBBwvyNcxxAuClylBEN3XrPYShnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U5u/ebRg; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b154f71885so364555485a.0
        for <stable@vger.kernel.org>; Wed, 20 Nov 2024 07:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732116386; x=1732721186; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nf6P9DIRJxG3HHqSkmc5bDC2kbomtLiZlCyebQwPqCM=;
        b=U5u/ebRgFnVQX6SRR3Aj1ayyV9xBU2oWAFvFdSEPQ25dHMaX0MeUYZkAKCHIBL9QR/
         9GR4e1ObbBHBZGj/LMsgUAAXdr1DEmpJmZ+Tl43ClrAVXmsl0aML89pBxeNgdZTzjWDA
         XXI79BG03+mYzTGDJwFUM+Y1P12dLUjqIjjc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732116386; x=1732721186;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nf6P9DIRJxG3HHqSkmc5bDC2kbomtLiZlCyebQwPqCM=;
        b=qd5jjuakQ++8IRbPjg50Yt8Dq3hKSl28KquwOeMzloqZ/wQOB3rPDt4shzPPPgzeAK
         Y+B2A5t6KfkmeWNkc8cFhFc3DJG9UsnGSsuvZ1T6EQmR34QZ0Tn8JVar2x2U9inSCP2q
         3J56otEMRuSMMvb8bCtwWZuKwHLPy1CMj3ZNJasNa7yS6EzKMn3+6LkQ3+1fHVR4wZmj
         a4cjvitW6dd3/fAQwzKUw47Ou+U40b4Nav9t7Qwh8EmU9TNRjREZ7PH/p7XiOk70bivs
         altmI8TvWaSJHNrwwnHbxUkpayoN412hJ8D8OTpV6IV/tBSKYIvnNyZKVPGNQHBjTXrB
         kq7w==
X-Forwarded-Encrypted: i=1; AJvYcCV87jRY2JawqETsUr2gSSfUPgbjq97NOvI+5MjQPZGiyng+oySTgezncVLCcoMTOL12ikxoDdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDJs5H+TUX+keqQQNQSvL7d8EcJ6pyiR33e08uEebHu7dGdLTC
	CrH9RWqy1NPK8tQdqQAT/DNPQQo/m1/+KPK8uw7FnknyEdQeDFojXblwI/cC0Q==
X-Google-Smtp-Source: AGHT+IFyIx3n9LVvSDGLaLi6PI8d2RhkUZLVsQYek4SUEz4fUio+9uekQYCj+qGy8K8NAK6KGh5juA==
X-Received: by 2002:a05:620a:2486:b0:7b1:4fab:4418 with SMTP id af79cd13be357-7b42ee8297dmr350405785a.49.1732116386367;
        Wed, 20 Nov 2024 07:26:26 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46467fd76e2sm11207321cf.12.2024.11.20.07.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 07:26:25 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 20 Nov 2024 15:26:19 +0000
Subject: [PATCH v4 1/2] media: uvcvideo: Support partial control reads
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-uvc-readless-v4-1-4672dbef3d46@chromium.org>
References: <20241120-uvc-readless-v4-0-4672dbef3d46@chromium.org>
In-Reply-To: <20241120-uvc-readless-v4-0-4672dbef3d46@chromium.org>
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
 drivers/media/usb/uvc/uvc_video.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index cd9c29532fb0..482c4ceceaac 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -79,6 +79,22 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 	if (likely(ret == size))
 		return 0;
 
+	/*
+	 * In UVC the data is usually represented in little-endian.
+	 * Some devices return shorter USB control packets that expected if the
+	 * returned value can fit in less bytes. Zero all the bytes that the
+	 * device have not written.
+	 * We exclude UVC_GET_INFO from the quirk. UVC_GET_LEN does not need to
+	 * be excluded because its size is always 1.
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


