Return-Path: <stable+bounces-98172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962BE9E2E65
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 22:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9135B31355
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 21:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E3220ADE0;
	Tue,  3 Dec 2024 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gUrKRpxU"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECD820A5E8
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733260821; cv=none; b=u6n88wDOdFgI7VgUDf39+y9QsPUcJ+Kx6g4jgzanY5n7F39azBpLdfG5FPCY6V6GCnxhFeRyDiH8nyAb5YRFcN9fLUzE23Q5CteXDE7ACWC7y+HPGL1JU+IkpqH7sV2jtSDjwS5ZjZOcUz6bg4Ck48C/zfgpq6G71FFrs01Sbng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733260821; c=relaxed/simple;
	bh=7mCRueWRTLrrGtLhTrWTfJrRJJeyxio72U+xB2LFHbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LxUWl2RbuAFCcOf8TkegGVJN7kVmJFIUaIBm5DQagUNOU+0jVN9kW89Ymf78O4PtQEpHWW2yYgnM3xVjbNqHkKvBAiUv9CxhnCh5CxRnAoWG5o5eoXp+6/JQ6QURrUofL8sUQJx/mr2kVWxwbGy/Y4nmaDN1vVEvtQmML/uN6W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gUrKRpxU; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4af60a0478fso106797137.1
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 13:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733260819; x=1733865619; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nOOe/WRZagmMi60fK6VqlpT1825okMetV6N8Itrt7Mc=;
        b=gUrKRpxU6EkNh4vHEcfwnmHu/m5hvanTzMo9A1zIUfBYmGDA+S6xLJX3/Ku9+lWBmG
         z04PkCjd7l0drl9qQ0ZbEtHw0E5BfBOfVU0zx6NpY2/RWOmfk8ggkMQUja5VFqkM0L3P
         +afi/E48bmAE8OT1ag/ZlWFhUo2v8b5SVYbVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733260819; x=1733865619;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOOe/WRZagmMi60fK6VqlpT1825okMetV6N8Itrt7Mc=;
        b=sTbcTe4BILMFJHRowt9vUxNRbuBrO9ghssSs+Gr9LtwLxcsXxUesgaN0uah91sB5YT
         //oQH2OLSeJhVRFdN76qPcbttbILbyw+P2XCRSv5J3vePPFPyg+Hwa4urbH7x1Pfm8pq
         hyLmTukYOJBLLO3wnELIfTtmcaR2mXS9Q9yQheGc+PXn+EZrHHfZ2ul2wbX5IrYcOoP3
         /ioauTv0fqflIzZNjaurv9uDtWhvgHfw1lOQZRWH+d/Zb5MoUfCLZ1310TeTvvFRhKIw
         nAnZo7bggrpHbbIT0XXmqnBD139niEAM9dRZgIm7SZLNvBXTahDhgS1iUsXpeZsWHEfx
         ypZA==
X-Forwarded-Encrypted: i=1; AJvYcCUXOa3AlASY7y4WUlXb6jRfpL3RO11FqUQr5wSfOo5UhwxyKfU676dQdatU3AitIRMbKXOBbmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVkaIQPUSvrB5TT6ygDrq566waj2G8+LvfqXSiCpwD0k0dq0yP
	Mmrflm9ILtcEnW/GQFlxVd8wdSwrhKmG2g+HdTj8PkHIe95IW6tOwV97NG8AAA==
X-Gm-Gg: ASbGncuL69nlSVad7S9dr5ph7XU7LbzVQfIOUk0s6XJqnepCmQDbzNSzYzkhCWakL5N
	7YObFsO0XGYpXOfkAg6IIXtaGrzMnLgTMIyP3IU41XP2xBCnfQ19yC1JXlSi/m8QN6KusnMaT2W
	87c3llhk7DpaqYrY8Jw7Mz+ICDSkQlHS+SVCWkHax58XRl2tiTEpdm2NoN/khYbaBcY+gsdoTim
	6cyYUbXYaJwDhc3ooRHfzcEU9UOVit9j4/2k8h1hLCBKhKcDQ+UYF0CyTe9WiT0V+m88rlPFGE4
	lftwKWKHeY+IMgzlvcxLoLzb
X-Google-Smtp-Source: AGHT+IHiizhG1r48NiSLYamAD0KEtJnCWIjp3L1I6RSZUBOGagQM6jryT2Os08sSfMtFWidXsF8z6Q==
X-Received: by 2002:a05:6102:2a7a:b0:4af:5634:d26f with SMTP id ada2fe7eead31-4af5634d73dmr23535275137.13.1733260819058;
        Tue, 03 Dec 2024 13:20:19 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85b82a89d5csm2140364241.8.2024.12.03.13.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 13:20:17 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 03 Dec 2024 21:20:08 +0000
Subject: [PATCH v6 1/5] media: uvcvideo: Only save async fh if success
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-uvc-fix-async-v6-1-26c867231118@chromium.org>
References: <20241203-uvc-fix-async-v6-0-26c867231118@chromium.org>
In-Reply-To: <20241203-uvc-fix-async-v6-0-26c867231118@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

Now we keep a reference to the active fh for any call to uvc_ctrl_set,
regardless if it is an actual set or if it is a just a try or if the
device refused the operation.

We should only keep the file handle if the device actually accepted
applying the operation.

Cc: stable@vger.kernel.org
Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Suggested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 4fe26e82e3d1..9a80a7d8e73a 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1811,7 +1811,10 @@ int uvc_ctrl_begin(struct uvc_video_chain *chain)
 }
 
 static int uvc_ctrl_commit_entity(struct uvc_device *dev,
-	struct uvc_entity *entity, int rollback, struct uvc_control **err_ctrl)
+				  struct uvc_fh *handle,
+				  struct uvc_entity *entity,
+				  int rollback,
+				  struct uvc_control **err_ctrl)
 {
 	struct uvc_control *ctrl;
 	unsigned int i;
@@ -1859,6 +1862,10 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 				*err_ctrl = ctrl;
 			return ret;
 		}
+
+		if (!rollback && handle &&
+		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
+			ctrl->handle = handle;
 	}
 
 	return 0;
@@ -1895,8 +1902,8 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 
 	/* Find the control. */
 	list_for_each_entry(entity, &chain->entities, chain) {
-		ret = uvc_ctrl_commit_entity(chain->dev, entity, rollback,
-					     &err_ctrl);
+		ret = uvc_ctrl_commit_entity(chain->dev, handle, entity,
+					     rollback, &err_ctrl);
 		if (ret < 0) {
 			if (ctrls)
 				ctrls->error_idx =
@@ -2046,9 +2053,6 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 	mapping->set(mapping, value,
 		uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
-		ctrl->handle = handle;
-
 	ctrl->dirty = 1;
 	ctrl->modified = 1;
 	return 0;
@@ -2377,7 +2381,7 @@ int uvc_ctrl_restore_values(struct uvc_device *dev)
 			ctrl->dirty = 1;
 		}
 
-		ret = uvc_ctrl_commit_entity(dev, entity, 0, NULL);
+		ret = uvc_ctrl_commit_entity(dev, NULL, entity, 0, NULL);
 		if (ret < 0)
 			return ret;
 	}

-- 
2.47.0.338.g60cca15819-goog


