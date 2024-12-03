Return-Path: <stable+bounces-98173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D820D9E2EE0
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 23:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74855B327FA
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 21:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061A520ADFF;
	Tue,  3 Dec 2024 21:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e+E6Nm1h"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4181B20A5E8
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733260823; cv=none; b=FU59rhEabbCXpMor4HZT1x/y2uLEprP2VXSMGdpShNZcx2GYW/1cYc8Ip9Z584ohPjagYkLDiFS2sCBiVfBumL1mlbqPRdLezFtvN4xtgbWeK4Ym0V/wrsWqI7PIcD+Yj0+vND2Z1H8sB1BvBsP/Mgb7wfHhvXBRlSk5PZezIlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733260823; c=relaxed/simple;
	bh=l4/lhwctK3kBC3s2JyaOOWF9ukBbTcldFztSXBtwWD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cGzvyVOqSnxQAv11AXz+/4iFf+JR1Rm9H2SqVrnl3c2eKAuVqasR5E6n/qBqhQlve5uwN1ZdH3prP5WsSqzsaAtX4TKyBdNNtEUa49T3e05iiHAWsZtZNH5eaLbvNPjmNunWIaerQXfReTeaI9xxtpI0eOTrit0v1IEVJjv98hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e+E6Nm1h; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4af122fb98aso1496137137.1
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 13:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733260821; x=1733865621; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nL4Atu/0WT3Bi8AnR4uXCq5U/XlhAxlSF0B4ijqZik8=;
        b=e+E6Nm1hFjwqcRGOb8qFT7tP30MVCZ5B+SM3iPDu9n3QNPvXzjxd1FrRbPpgbWkJ2+
         UQRcB7vnhSiW8iDNOGfhOXGnvMlywv8romtCbY4/Sxd7jBX8CozCRYEuXKIjGLuPIjg+
         T91RF4uUsqLpE+A9X3QSjA8e/9zqooMdpCNlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733260821; x=1733865621;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nL4Atu/0WT3Bi8AnR4uXCq5U/XlhAxlSF0B4ijqZik8=;
        b=YzbH1ZFWc2puNB0eSGRKa+/h/O7KEA6JKS0L8elV6zh3INTKK2jj9K33Ovek7EHP6U
         XssI9ri+8ft9OmFNqRtMN568QFzwjLz5rcDzomU9FiiPd9EQ6NodYWz+vgHruDIod6mK
         uBOXRB4vt1FqPEHiF6166jon/xtKHwVloXqjIxUXWb2w9u3oPIWTTgtZH0vuQspzz9J6
         VdtZu45xHhijLdSRDiLHmaZTwPYVl5m02fzE8HzrZIm/bCYg2aHQnaVPAENPs/q2Wuu6
         Sx5/1KuGrzI1vjuC4sBv6K8NqEnY+c5uUKy3nLAXzkRjqacB2OBqGNGNGy3JY3VZnBhp
         Ik8A==
X-Forwarded-Encrypted: i=1; AJvYcCWCxeCsJh1RbaJ/wfRUKboAjdnsmreppB+4iRgCKrzvwIyNwVQDy5XcoT+0J7C0f2phAh8+DyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7koRNWkpvI2j/L4hCrJq8z+iosTJLh71mbu+AbXEyk0LBUZlh
	dgKqeSCOrKdkj70wCKZ7YZr7viTbmH4qrMah5yVR2o3J5w52fsuBTHyUF081rg==
X-Gm-Gg: ASbGnctCwS56jJf4s92JgGd6FCrgqa9bGu0f4uKxUwbE+dxY4Vi0PwamsbLMIpHk7WF
	X6qbQPOicTw3C9/VVLlkSw9DWm9i1Bt+tSETCYmA0VTQt6IiTLe7mcVqN5lyZIx3HEmBtu8TEff
	CdoElYnN/mAyoSXKXdla0FTGGYAKsKKO/nawOdwFnP/9cnvAim6GYTXGGZEYn2AoQaV2nXvpRXN
	Ep/W1dvg1+xrBBYQZIKp5rUZWw45aBTAc7nl7i5r571MUQgH6U+4wlSu4A9XhQwPAMcuf1bSNNx
	ubzJX4awcuhF+l7Ow/EFIRNt
X-Google-Smtp-Source: AGHT+IFDq/YyaSDjFBUXsfLRGsjk8UOE+Mft2rZWydxkoxjhSW9PDslAnWq3gxZr/nwtXjYBEcitrw==
X-Received: by 2002:a05:6102:e0f:b0:4af:4c4d:c8e8 with SMTP id ada2fe7eead31-4afa4fb9017mr3596621137.7.1733260821288;
        Tue, 03 Dec 2024 13:20:21 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85b82a89d5csm2140364241.8.2024.12.03.13.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 13:20:20 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 03 Dec 2024 21:20:09 +0000
Subject: [PATCH v6 2/5] media: uvcvideo: Remove redundant NULL assignment
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-uvc-fix-async-v6-2-26c867231118@chromium.org>
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

ctrl->handle will only be different than NULL for controls that have
mappings. This is because that assignment is only done inside
uvc_ctrl_set() for mapped controls.

Cc: stable@vger.kernel.org
Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 9a80a7d8e73a..42b0a0cdc51c 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1640,10 +1640,8 @@ bool uvc_ctrl_status_event_async(struct urb *urb, struct uvc_video_chain *chain,
 	struct uvc_device *dev = chain->dev;
 	struct uvc_ctrl_work *w = &dev->async_ctrl;
 
-	if (list_empty(&ctrl->info.mappings)) {
-		ctrl->handle = NULL;
+	if (list_empty(&ctrl->info.mappings))
 		return false;
-	}
 
 	w->data = data;
 	w->urb = urb;

-- 
2.47.0.338.g60cca15819-goog


