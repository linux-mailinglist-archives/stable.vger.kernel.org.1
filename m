Return-Path: <stable+bounces-81528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2ED99406B
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 10:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A913B2193C
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 08:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3629E1FA25C;
	Tue,  8 Oct 2024 07:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WfXFAQf5"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873E11F9A92
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 07:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728371183; cv=none; b=oLf5tSUilJ0m95IOjLKgKfPp0yKxXwgrJn9d+q2Z0dfr6ZgEDpSTZTd4+cs8kUeBiPMAWuHwP2fGPe3pjDxPnKiBGNEY51Qwf+FQ7PcAqbqhPoIeYhyuy+xlSzVHUsV+tVgE3nLSHSqf2U7PxLV3WStPL2vj0ds1OnLpQneV68U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728371183; c=relaxed/simple;
	bh=t1pAvWaDC2XezFxZD6bG6re3WWY632E7aLxyVqoDOEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SWan9VQLUmlCAiGgrg7FnKw8tYzfxe7+t7/rph4HckkjrQNZ7SOicJfWhdv1mogyLAxAenj35mIokoF+1rZ3Of0YTdeF/lNZ9eE/xBDoDuvbBgYshmnlm8gk0vbo9yva3XTvoELsvgNGs4tO3OpAhUxUfwtJvogx5XqHjZKwRl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WfXFAQf5; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-45f05f87ca5so383641cf.2
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 00:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728371179; x=1728975979; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jyYD6ArZVK45+VLwWpocZkjfjByfwzgnW1gPt6FS3DU=;
        b=WfXFAQf5MGJmroMzcHLYSZ/H/rnSfbJjzfb/qp5UUYvI4TL3bClGlIdCGkAL3otqLL
         s5KKw6IUctZOVa0RIiubE1Sy4Rwzxipgeev35ixIt/n7sEqEzXKugEngAkBqS2NuG+Ez
         oMRoM6HGEO61aMq4lB3iqutp1DlDZSjNOrodo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728371179; x=1728975979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyYD6ArZVK45+VLwWpocZkjfjByfwzgnW1gPt6FS3DU=;
        b=jP0x2W+T7PDjlaxN3ray/Fi8IncoIgpBO+FFn2iZimYLNPF1rIDh58cfl2DVdP6zB+
         1UfZNFEjLFsor8vCSlW+RX/RLpGyqCLaDvcQnWGPsSo/dTA1WjW8/R9PdFtSnrVRsfyX
         NSOz9vrjVpVAiymt0O24Kdd2U3ECI3FTMXjqToSm/H/30/9/On1TLFB2lVmg5SzdQP7j
         SH7mcfqK6u6BWSpixZvvzcnBRBqek6s4foCZmsdWAZJMDMN3XCWqAJUZhesaQixuJgM4
         ftKMNRp4ekf8eDFqfspk97CuiHzztaXoNhNo+YhGzg3jW7+Qq2m4uPINebIPLhuOb9kN
         JP5w==
X-Forwarded-Encrypted: i=1; AJvYcCV2UsfOV9kza0BFS2qMX564bENqU6E2sc2MmEj36wViov94hIqwkZ5flwujqDUcYa9/P20ek8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdan7/przCQ9RkBB6Lvp7AA9XRL1eg0p+sJMw+uJCqogwUDFAB
	2tDTS2ZgBgzz8wvpFZEPTAQnuVitFmqTmSR9Z61kaSYN1Hf7YaVdkN82a9+sIw==
X-Google-Smtp-Source: AGHT+IHAXauuu8Lhecqd4BHK9YWDTOCb8kDvv55sLtE3EDVAYcD3iHT0tlmCSPXjU48F5uQjczxp0w==
X-Received: by 2002:a05:622a:19a9:b0:458:2b7b:c453 with SMTP id d75a77b69052e-45d9ba2f097mr224135731cf.4.1728371179383;
        Tue, 08 Oct 2024 00:06:19 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da764043esm33801921cf.88.2024.10.08.00.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 00:06:17 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 08 Oct 2024 07:06:14 +0000
Subject: [PATCH 1/3] media: uvcvideo: Support partial control reads
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-uvc-readless-v1-1-042ac4581f44@chromium.org>
References: <20241008-uvc-readless-v1-0-042ac4581f44@chromium.org>
In-Reply-To: <20241008-uvc-readless-v1-0-042ac4581f44@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
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
 drivers/media/usb/uvc/uvc_video.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index cd9c29532fb0..853dfb7b5f7b 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -79,11 +79,16 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 	if (likely(ret == size))
 		return 0;
 
+	if (ret > 0 && ret < size) {
+		memset(data + ret, 0, size - ret);
+		return 0;
+	}
+
 	if (ret != -EPIPE) {
 		dev_err(&dev->udev->dev,
 			"Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
 			uvc_query_name(query), cs, unit, ret, size);
-		return ret < 0 ? ret : -EPIPE;
+		return ret ? ret : -EPIPE;
 	}
 
 	/* Reuse data[0] to request the error code. */

-- 
2.47.0.rc0.187.ge670bccf7e-goog


