Return-Path: <stable+bounces-95620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BCF9DA787
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 13:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6D74161D9B
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 12:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2446B1FBEBF;
	Wed, 27 Nov 2024 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X5pAqEZf"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6662F1FBE88
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709701; cv=none; b=WO4bYrEhyXGh4v1cM98SQsG0/ye2eWuNtOiswYbDY7Tz8u0mJ40Cl1NiF6gspA17U29uP3/VaZqKLoG83zOR9ECOOfbce4wCoxBxOmc4PoBMr7C4oD15KGOl4u4h5Qb3OhbLSFEDxH/ROMq5IMPdNYt2s1GaWqYz0z5eMsmvkYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709701; c=relaxed/simple;
	bh=VcsvfSq12DS0fnYrIgZKD+Xjd35yhix6s3hD7aEJjAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YbtjoqIQu4DzKBOBCKzc0tdLMpbSTVOoTlvrcgoQApIz3LOSSk6Hp+BaRKhoqES/iBeeAU8XXRczTPPxlkOZIayibGa+jpANAmxLmaeXhHoIaxrMbAYYJAdOCjC0+euDxg9UEBWEQ+9JwGZGuXkr+YODX8U4iJHP5emj7nyICEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X5pAqEZf; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e388d853727so6146872276.1
        for <stable@vger.kernel.org>; Wed, 27 Nov 2024 04:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732709699; x=1733314499; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7nuXBj4+Zy+PgIyL5ZNHJXV9meQjmyhtl3lnhIKUIXQ=;
        b=X5pAqEZf+zMnnErlWNuJLro7DwZWjwm90MDDu+qimjLlhAqD3eNN/YTh60zN5b3fIE
         /1wLi+vhJarn5TqgvKjIA9JG6nmTvDqB24CRYDzg77tkElUi98gSnSaP+IyzC2kJc/Kr
         SKagbPKh5/ap8i9jcKQ8xySS0ZXLNkTSvrqUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732709699; x=1733314499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nuXBj4+Zy+PgIyL5ZNHJXV9meQjmyhtl3lnhIKUIXQ=;
        b=DqjSgu7Z17MbwvzYLsMxLgmFbXKXnEiTtAIVMZEkmDHvyWWxaXG8osOL6cgDR8QJDC
         MNUi7BBYTDlZ422JTKVkXjuRjdRfS2gTE9KrB2GIaK2jI7Xq6BGRlDprtZcfdNLLDSi1
         DlLbs44KbrKH6DgegaJntI494wNergkqPoDhfqbcxl8c+U0mX75O5/3924bJd7b1momQ
         ks9ZasMsimyz6MxCqRghjOpKwXDGcyzCz0DIEAPqCvW9DWDycDvsdYfpDcCLJiHW7jGu
         OO9zfcIDUGoAi8gtuuk2a1n8va5khG1Mn4dEIKqtQ78dXWXjNMknJOS2qMT0JxG5V0bZ
         Dlmw==
X-Forwarded-Encrypted: i=1; AJvYcCUpM2PaCOG+NGG/JhT2VigiB1jOXLJiYI0oLmz3CJf1QaPN3wlsTgHsQuiqspetKYfvHftdC+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGNXsmmLSe48Cn5CHD1KqDoGyypu8kppBEWCuBZH+z7ASUF9yB
	3PSTCyEKrItgteXURbjfGdpGubJTXIXBcz9Y7n0G0i7n0AIytFHveJOG88ATcwD0LGKg5ZKpx0o
	=
X-Gm-Gg: ASbGncuTWVSoYauBtNQW+Xq/ApCaD7znodmB92kp8k+tRGPyigVqS59Cknl//wjS9ZO
	+LlpcSVv0wm6APgE77o6fGs/2olvdXmxKDLFgGRgzZzxhZsx8YVHk79NoZ2tyLAb03/1g53I+oN
	KPIsQho2SqWUfI+N31Z8djmVLEfVk1jvoUFNHv+RIt6CdXaHn/usWHghDEp6LOhOJYd/r17BqSa
	96CFnfVP0UPYjjEvaMfAEW5BYOGkCxQaRzN98uQL3pu08c8+yKxW1qt4g/rAMz8UL0biFHqhDmC
	OkcJG8dtZCHFSn0DpXZc4UOo
X-Google-Smtp-Source: AGHT+IGLxdpsvDUuDyS/a7VxdrSBPvc4g30hV96tMr/MAEAPEAJCmKtRun3PxzyerPPec80HnLUxYg==
X-Received: by 2002:a05:6902:f81:b0:e38:9b5f:58a6 with SMTP id 3f1490d57ef6-e395b957461mr2580029276.46.1732709698809;
        Wed, 27 Nov 2024 04:14:58 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466be77cf7bsm371171cf.89.2024.11.27.04.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 04:14:58 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 27 Nov 2024 12:14:50 +0000
Subject: [PATCH v2 2/4] media: uvcvideo: Do not set an async control owned
 by other fh
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-uvc-fix-async-v2-2-510aab9570dd@chromium.org>
References: <20241127-uvc-fix-async-v2-0-510aab9570dd@chromium.org>
In-Reply-To: <20241127-uvc-fix-async-v2-0-510aab9570dd@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

If a file handle is waiting for a response from an async control, avoid
that other file handle operate with it.

Without this patch, the first file handle will never get the event
associated with that operation, which can lead to endless loops in
applications. Eg:
If an application A wants to change the zoom and to know when the
operation has completed:
it will open the video node, subscribe to the zoom event, change the
control and wait for zoom to finish.
If before the zoom operation finishes, another application B changes
the zoom, the first app A will loop forever.

Cc: stable@vger.kernel.org
Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index b6af4ff92cbd..3f8ae35cb3bc 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1955,6 +1955,10 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 	if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
 		return -EACCES;
 
+	/* Other file handle is waiting a response from this async control. */
+	if (ctrl->handle && ctrl->handle != handle)
+		return -EBUSY;
+
 	/* Clamp out of range values. */
 	switch (mapping->v4l2_type) {
 	case V4L2_CTRL_TYPE_INTEGER:

-- 
2.47.0.338.g60cca15819-goog


