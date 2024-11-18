Return-Path: <stable+bounces-93818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2EE9D16E8
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 18:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3592282458
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 17:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAF71C2337;
	Mon, 18 Nov 2024 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YiLfh2xF"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ED71C07E5
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731950220; cv=none; b=fzvZRAnmDF4cTF+VLtIt7scZ2ZAxB/EdOSiD6lM3LgsMefhjJa/lsoLOwBJYIqf0FB5H7u4fgF2aJmcYtdxURuObU7K1nbC8WptJl8OycAmEizAsCf5SM+Q9YofgXY2xhg89DgEgpfMls2444NMssiUs4/VbOOW+8B2Z9sVi1lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731950220; c=relaxed/simple;
	bh=RCd8P7SWrd6FHi62rUrvFyQXQfEkY0e0c1mppU+Gugo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y/PfH1Esz7Ex1Ktz0pBDM/dz1VJvbor7jarCteRK9KzpPaM93b/THM/WCKA2ve0ZYxSODQCSfYdeqn4iKQTk9hmp8X5+3xYGuOR+theJA0n/uCQpjK+TmmOngh1/rY3dJPtJxYSHkisGoR/KHvYUkFNSzcepHdpvlsAz/5jwi54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YiLfh2xF; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6d41f721047so9322636d6.1
        for <stable@vger.kernel.org>; Mon, 18 Nov 2024 09:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731950217; x=1732555017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gNFvjcIFE/tMdInr/XwnZIB54kAM691O9hqiQzfdv8o=;
        b=YiLfh2xFyjqkwSgE7Rsby9ATobVbrDPk0+cSYRzta+TZYPMEaGc6iis2RS3HR3ot2A
         Fee773bV/p1ioeH53EoflQRQHYAYH0WnrjO+9HHTyK+C2WAkRP+KmKAzKH65HJujlx5B
         eMcDrWSHu+zpAZbJU1Ik+T1dF6ZIb6vgg7iBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731950217; x=1732555017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNFvjcIFE/tMdInr/XwnZIB54kAM691O9hqiQzfdv8o=;
        b=i7sIQg6v0ZaLN/PJ4pKNhAdbjNOzSFsW6EZIPNb70i6J1UsANFlTMSGZNIJAO1YPhe
         uniWKApo+7kt/R2IymRjFLpcIWlAOAjQ0uarxIT8K6BrnZmTPMyTgEP7GbvOfFz15VxT
         FTrrS/EKFcebO8BPCEEnmPy7DjLZo6b9gY+MNn6/pN/fqCgddkh5OVI3G6rIPRegsl60
         WRde/2ph6hFdGMRaRh56+AHHImRt4x97abQxLevK58UTgdfvI3IHNfD6CRkQbQoxvej+
         viMNMYgAAQycbVNnVrH3rRkpuLAw3JYWQJvgzespme0ISSY86OzKr/YlrCZAHPWOJFTW
         L1sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKYzqiruNp6FjDMO18sw6dNXLRJFuXxTxSkXydDNEDT0WDTQc2o9fBR9vjDN2SkpWBcJ1ZbX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrnbICDwmhuxAvBpY4n3DinK1D1QWie0Zp7iE8jkuy1kr+PP8U
	j4HHK+HKJJq3mSZSpU7C7D0hk+lzGHXCvNlBqQIMvC8UtxnYtrTED8rZh4bfwYowPXE8dLNDGzE
	=
X-Google-Smtp-Source: AGHT+IGOkU43Z9UJjXQsK/gUo0QuSRiC01AYZTqd+ZFfoEVojsBB8wlaF8j84jOLMRBqVEuwdeRqmQ==
X-Received: by 2002:a05:6214:5001:b0:6d4:85f:ccac with SMTP id 6a1803df08f44-6d4085fce05mr160427536d6.13.1731950217630;
        Mon, 18 Nov 2024 09:16:57 -0800 (PST)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40dd733c3sm38255246d6.97.2024.11.18.09.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 09:16:56 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 18 Nov 2024 17:16:51 +0000
Subject: [PATCH v3 1/2] media: uvcvideo: Support partial control reads
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-uvc-readless-v3-1-d97c1a3084d0@chromium.org>
References: <20241118-uvc-readless-v3-0-d97c1a3084d0@chromium.org>
In-Reply-To: <20241118-uvc-readless-v3-0-d97c1a3084d0@chromium.org>
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
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index cd9c29532fb0..e165850397a0 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -76,8 +76,22 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 
 	ret = __uvc_query_ctrl(dev, query, unit, intfnum, cs, data, size,
 				UVC_CTRL_CONTROL_TIMEOUT);
-	if (likely(ret == size))
+	if (ret > 0) {
+		if (size == ret)
+			return 0;
+
+		/*
+		 * In UVC the data is represented in little-endian by default.
+		 * Some devices return shorter control packages that expected
+		 * if the return value can fit in less bytes.
+		 * Zero all the bytes that the device have not written.
+		 */
+		memset(data + ret, 0, size - ret);
+		dev_warn_once(&dev->udev->dev,
+			      "UVC non compliance: %s control %u on unit %u returned %d bytes when we expected %u.\n",
+			      uvc_query_name(query), cs, unit, ret, size);
 		return 0;
+	}
 
 	if (ret != -EPIPE) {
 		dev_err(&dev->udev->dev,

-- 
2.47.0.338.g60cca15819-goog


