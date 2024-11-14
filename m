Return-Path: <stable+bounces-93056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313179C9226
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 20:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00AFBB23E70
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 19:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE0A1A3047;
	Thu, 14 Nov 2024 19:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FNTxAIjg"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284B419D07C
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731611449; cv=none; b=kqloHSDhHlnGKQX9qkxlS+G5ViLm731NLVpf/Htnr39Fld2vo5bh9RAN4aCyqHvFeQxSzt3hKFFFQxm+ZZ9N6BghhuSx8yr/HJ7/7VBLbP4PakFkqgp6djIM7H72DVjBwrJIhMzQq0K9EEkctkPRkMwk/8gQXkRqsjLQqwbAeSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731611449; c=relaxed/simple;
	bh=SC8L6uuUf+/qQ8Ex1Sbi6Yirs91l4EQxu1/mHdLrT3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AmUihFy/k5bZROIPceFMe8yLjuuhRUR6rZBIv9hhAiLXPGj/k471W/RbSwRYmBjpbEntSrwotQcuVy4ls8IUivBsghU9RGtSp+cKGnpDLoMDeewF9cE3/tOFPlADk9YFlujgI+bEKZqKYQnD6ytCcxHLQ/RtgNU/pevoZU4od3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FNTxAIjg; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cc1b20ce54so6235286d6.0
        for <stable@vger.kernel.org>; Thu, 14 Nov 2024 11:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731611446; x=1732216246; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g3mKyz8dYUWXDVhEiyfGTODSac7INNAwm9mfRIbHOA8=;
        b=FNTxAIjg+AKMOAkmRibmn0/OK/f/baVvp9f4agC+dyHYJbjbXK5zv1OzAJ+fq1Qd6N
         mo//d+fWUNdUaRr5iXKX0vRUCTGeca4QEZekiE9OVxvqjsKSuqy4pWDCarrmAHZoCBZr
         TfsVzdewDr3Q37NLZ7qFRuesouMnk/cOmxJG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731611446; x=1732216246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3mKyz8dYUWXDVhEiyfGTODSac7INNAwm9mfRIbHOA8=;
        b=jq20YskL3bf+GUO/E6V6FCz6uyZ9uyJZoPH61ncFqz2+7q/JNE2dQNIhnNHYgLLaeQ
         bU9hCW2L/UdKpfgPxBNvkg91ZXDvbysuWC7BVkCQ22NuIh6a2c9HE2ffdBu1PZr3SNNr
         2X6MfoBGE6+mq6mvqsv+z/Qzlde5fmokbG+iQyBv5PoKutSFk2q84909/poY0epgmPQf
         zAFF+LQlgOGtRiAyK5NvJThYqNq0qSzVZR3PFtJclMWVfDMJp3M0Pd8/SiDM9QyI24rv
         RFWJnDy1w2uSlW/aEu7yzvcjiyFVUBhWaxauDRw38PzSGmx8TzGtmwjB+gvFozJAArV8
         jQKA==
X-Forwarded-Encrypted: i=1; AJvYcCXpQQg9LvCS4rf4IrYfHT6uJ40XknUQGutOUIVdylDHt6h+de1N2ok7A/BS0a/6c+5yet7DfwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO59zsU1N/cRotu93vREM65GXZ+evbuqwPM+oOKmC+/IgW2+M5
	Uv6JSu4r6EN4fwfXHAvAfCEhh6xRhMrJguze8CvIHi5ebRxLwR+d8mNUWjdwPA==
X-Google-Smtp-Source: AGHT+IFboiersPw9AuVt765dOS55ZVKctVly2CX95Gh3rA/va9J1s5reVsHiqKvLb+PaK3c6MG2r2A==
X-Received: by 2002:a0c:fb09:0:b0:6d3:f904:5359 with SMTP id 6a1803df08f44-6d3f90454f5mr10161666d6.33.1731611446042;
        Thu, 14 Nov 2024 11:10:46 -0800 (PST)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3ee7cc7e1sm8857766d6.53.2024.11.14.11.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:10:45 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 14 Nov 2024 19:10:30 +0000
Subject: [PATCH v15 01/19] media: uvcvideo: Fix event flags in
 uvc_ctrl_send_events
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-uvc-roi-v15-1-64cfeb56b6f8@chromium.org>
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
In-Reply-To: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>, Ricardo Ribalda <ribalda@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0

If there is an event that needs the V4L2_EVENT_CTRL_CH_FLAGS flag, all
the following events will have that flag, regardless if they need it or
not.

This is because we keep using the same variable all the time and we do
not reset its original value.

Cc: stable@vger.kernel.org
Fixes: 805e9b4a06bf ("[media] uvcvideo: Send control change events for slave ctrls when the master changes")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 4fe26e82e3d1..bab9fdac98e6 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1673,13 +1673,13 @@ static void uvc_ctrl_send_events(struct uvc_fh *handle,
 {
 	struct uvc_control_mapping *mapping;
 	struct uvc_control *ctrl;
-	u32 changes = V4L2_EVENT_CTRL_CH_VALUE;
 	unsigned int i;
 	unsigned int j;
 
 	for (i = 0; i < xctrls_count; ++i) {
-		ctrl = uvc_find_control(handle->chain, xctrls[i].id, &mapping);
+		u32 changes = V4L2_EVENT_CTRL_CH_VALUE;
 
+		ctrl = uvc_find_control(handle->chain, xctrls[i].id, &mapping);
 		if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
 			/* Notification will be sent from an Interrupt event. */
 			continue;

-- 
2.47.0.338.g60cca15819-goog


