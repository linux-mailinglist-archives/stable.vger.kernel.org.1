Return-Path: <stable+bounces-95594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAE19DA352
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 08:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC719B25FED
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 07:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B239B185B62;
	Wed, 27 Nov 2024 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ob9aMd2W"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41381547C0
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 07:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732693585; cv=none; b=Y+CSkDhSnR0ci+YTp5cN+/TzQgEw6OeL+PKGwmvHkvrfnYKkntVdDgfyRQsLd9Q5kX7SdVW2GSZzTVImC0agJwdBsinN9Wh5YvGCzSWMSZ6JgWfHD001lNZ3hhfaeGgGhHP+xYBy84uxwoyIDXQjRnpr9ox0F4LSffJS0StIoXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732693585; c=relaxed/simple;
	bh=P7cJDdqJWrLuL8K2uEZRvjaoWn4MVm6+xAAkGWyiVYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AfP6SUKyIZGRiuBJZZsV30xm2Ho7xKe4EbOzepuRf84jxg1vYQGcJzwM5rR8ZsCyAgQ8Bn1N0I2E0r3OdgnGc2/O20ZLVYIO5j7JG8rbpF+2I2PncmhvEHrVE3IhJt2Ia4FhsBVkCBLZpovaSvrroYIsfvLOMxZJ2/pEmxI+slU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ob9aMd2W; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-466847440a6so24079101cf.2
        for <stable@vger.kernel.org>; Tue, 26 Nov 2024 23:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732693581; x=1733298381; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HKrUO2mKilVMnb8uGrp8DPUwicBtZJtjKmdkARmt5l4=;
        b=ob9aMd2WGwHgFzxBQK5Pw0cyNcdvykqiYRNd8WSqBf9QMq/utIA1p1SlM1PQiwpR2T
         Qy3UPxY0TAZKFOmkra9zg3NU/ulQTTjP9BEmKwzaLtmjNXY923JoHIk4ccytcZpn2YNX
         BEaZhPNeNCvZcdc3CTAlWd28JrBIL+InP6DCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732693581; x=1733298381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKrUO2mKilVMnb8uGrp8DPUwicBtZJtjKmdkARmt5l4=;
        b=GyR1SQBgmYrKFTV84Fc8t1I3uOtv5F98QzHY2zHudoicANNQO9TmP0FU+bbpt8h/DL
         RRamvJ3+VNbSxMQHGNGqAisCjPjve2r/rMnc2aQQprdngWwtPEvevN7kpA6Jyj+4dF/J
         ygipfmCSrRioje3qKvZxnSaGn6Ez6TKjcDOjF0HCHDWFHmZJrY5hsnoeXILzCtbHgkCw
         wjuNl3znKqLW52cZIpO1m0BiqWOpcCxNxBxu7T9WXUtfC2vWFEyg6BoyH1xpSX4+DdUC
         G0d9ByrYgA6FGgFFWihMDynuhuaFNoxi1H75iD3RNTh7BisAwxwlgkZiF+6gQWI8YVcs
         0+qA==
X-Forwarded-Encrypted: i=1; AJvYcCXvWy5OmEkIZsbkqd68h6mcH9PN4VJJDJwZp24H2ntGbrDJKuY7sC0kWmIhWGoT4NJeO1kbDB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/zxLVyzi+wF4XKKWvVc3LVF0jzu6NQLyESTBjXei1cWnDwfZm
	XwE7iVisVO2LUKIiqK2QBb1WYFwpj+6DHh09ZSDNiKjlELApvSRqGF8VqQfTRw==
X-Gm-Gg: ASbGncu23aTtk3Om1PtCkqrM6yvhuVBGe/XDHxOStL0/p+LgwA3JJoCUgr6fFxTP8P5
	28JL6DwYsmeXQN9fw2kcDY8+9AY5ENtyatX97M8mQCAB0Ph2ij2SnGITQsCXewmJwU4P5irujBY
	AIhCeh+mJNNE1IudfMChrv7cvjKlsSH34hISf6Fh6tqrIk5HPoWquDZTQMamZU3eZRLSSeDYGGO
	pNfjic4jhVWWiooKWNfrw2wJ7nKru4z80ZMTGvpGKPh8uJbbuBBX3m7OOwFgX9jUjsPJxVhl6oC
	RJNQ9igAHXRPvdqtVjaMHGJX
X-Google-Smtp-Source: AGHT+IHjZqETEPShgvU8rMJKDjffubDyJxiF4XR9EMU6bbMMSHIwCT/IdCc48x4fk/k07H62yBxdcA==
X-Received: by 2002:ad4:5766:0:b0:6cb:ce4c:1cc1 with SMTP id 6a1803df08f44-6d864d1f41dmr29507186d6.20.1732693581473;
        Tue, 26 Nov 2024 23:46:21 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a97b1asm63750386d6.40.2024.11.26.23.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 23:46:20 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 27 Nov 2024 07:46:10 +0000
Subject: [PATCH 1/2] media: uvcvideo: Do not set an async control owned by
 other fh
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-uvc-fix-async-v1-1-eb8722531b8c@chromium.org>
References: <20241127-uvc-fix-async-v1-0-eb8722531b8c@chromium.org>
In-Reply-To: <20241127-uvc-fix-async-v1-0-eb8722531b8c@chromium.org>
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
associated to that operation.

Cc: stable@vger.kernel.org
Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 4fe26e82e3d1..5d3a28edf7f0 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1950,6 +1950,10 @@ int uvc_ctrl_set(struct uvc_fh *handle,
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


