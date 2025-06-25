Return-Path: <stable+bounces-158545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C98AE830F
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3DA37B43B3
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 12:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DD12620CF;
	Wed, 25 Jun 2025 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gCWKdAFo"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7C62609F6
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855545; cv=none; b=fASJ3QsnesWK87+OnqFSHdpnr1pHMWOo6g4ZcrJUzijf3IzAyhsl1wJOjje8MVQVveD4TkOLJWZn15qgIAxd+aI59mzHYZTp3z/jU838idN6keFfzdzJXF7Op1sfRCLw36KprfbXzxZqgTWZY2/kiWb+ezAYgVMvAHVk/GuV9FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855545; c=relaxed/simple;
	bh=kEdNhB5G7cclDbu/ywgbfBanNDt5JhShRRvGUHubFGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuXiQqfcrCHLiwmjLJ/5zKZHJOcPQidM0y3z6s12p0tJCEex/6NDrnp98E6FAmUGU0LC5z7ECPFZ6E2BjR1QBUEmJmAz9gMXOd7gXyUSvEWv7tqO7qobMgzfUTmkq4vkavRNbfHpZlY4zwPKlffAKL/GdTB46GnPr3U8sgNHk4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gCWKdAFo; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-555024588b1so14537e87.1
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 05:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750855541; x=1751460341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shjoDt1kika5kkcIVuSNterr5Qh4wtDEuuNtbgFkMR4=;
        b=gCWKdAFoLlxTTeTexDSAwL/+w+2dN+MFi2iv2V6xy+UWhRCr9V2wCmyHJXNelsYc45
         VwHEly9BEmQT4aiNDNc/jx0QR7bOg6VebKOt3JrpgFFyPXEab/UcXa7BtodB+VqHECRj
         U5jNMlYf4OdT4EF0qpKZSCizhX+YlXlU91mG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855541; x=1751460341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shjoDt1kika5kkcIVuSNterr5Qh4wtDEuuNtbgFkMR4=;
        b=mWHIFRtgewjv6rTsfpWk766xn/wXMC4zktDQYTqlwgFiauMWWH0GLFeiBjeQq/Detv
         kmWImkoR8cHZT0VEd3Gb9TR0MID5gln2pEsvenJcmh/gSQTl8PFlfR3l7HeiCeIkrFsF
         wUel+MmOcmoN2OmD613HyzHcUHlgF6R2fo3JCVTS48wd7NIN7qzl2bb7khT3CsoUG7KP
         8Q4MP0Xi7h2HlqC0ot+oKhJ4LL3vgVDs057szb007VucIsYZqjwJaB2OdM4+mMLybNqs
         nTuUpWgNXxsGmVPFSI1a/Ufcz90onpPAOF5I/Fv34HbemQqlo4aix2Nugrb727znm7gZ
         RStQ==
X-Gm-Message-State: AOJu0Yz/1mAjrRbP74zaZCvg7OcIXySGnZLElbBemIi4Ogio/e2j2HK+
	HFLKHlRQbg1+HRWpZOPqdJt/BIRrNBwx87a1NqGx1T8MvQWZu/OnHW312F08Je96keCZ0pMqnKk
	+8fI=
X-Gm-Gg: ASbGncvFb7jF/hNPMjEKAgRq11/KZ8KipHw0Vo2QlQjiS+OIxOe9TgHCuK4qirQ+4p+
	6uLaGUCEXZ3/+nlw0hsGMCnfkEevUP/pjKE8eXSnShSGIEHzQ3GDLw9igbyEfzN2LnZ12aYLQ+W
	xpl7mhlnuZVH6UYg28WItDa1+2PKAKrIhra7nOswcsMhjrTlCVqkYKbYHj37TD9i+ycg1qCLRSq
	i3MK9ZutECiB9HL5txzz5Up7DC+cRaJpHIrOrM85oBmaE6WGuDnXJGqh+Xp2c5B7I7rGTokQSWC
	UcCyNyZfrEAhTE+CyHi+zPorc2FL2G7JZzIxwIuAg9ppdsEsFbUkwiWW9rcLNbfCqL35f69VlnX
	iW2VAKBasReeD+flYueI1Fy9g2r8BoAZSOOu2mNoia3Z5zzE=
X-Google-Smtp-Source: AGHT+IH5hURfOt09dem+kNXA3ZY62B2s0ji+C80zHl+2iKT1SsyQcOvcua853JRNxaO+/gecrvrlfg==
X-Received: by 2002:a05:6512:e8c:b0:553:3945:82ac with SMTP id 2adb3069b0e04-554fdd1d71amr947775e87.29.1750855541108;
        Wed, 25 Jun 2025 05:45:41 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41c4448sm2196328e87.187.2025.06.25.05.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:45:40 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	stable@kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.6.y 2/3] media: uvcvideo: Send control events for partial succeeds
Date: Wed, 25 Jun 2025 12:45:34 +0000
Message-ID: <20250625124535.538621-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625124535.538621-1-ribalda@chromium.org>
References: <2025062015-vessel-facility-967c@gregkh>
 <20250625124535.538621-1-ribalda@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Today, when we are applying a change to entities A, B. If A succeeds and B
fails the events for A are not sent.

This change changes the code so the events for A are send right after
they happen.

Cc: stable@kernel.org
Fixes: b4012002f3a3 ("[media] uvcvideo: Add support for control events")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Message-ID: <20250224-uvc-data-backup-v2-2-de993ed9823b@chromium.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
(cherry picked from commit 5c791467aea6277430da5f089b9b6c2a9d8a4af7)
---
 drivers/media/usb/uvc/uvc_ctrl.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 36acc7eeff08..59e21746f550 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1642,7 +1642,9 @@ static bool uvc_ctrl_xctrls_has_control(const struct v4l2_ext_control *xctrls,
 }
 
 static void uvc_ctrl_send_events(struct uvc_fh *handle,
-	const struct v4l2_ext_control *xctrls, unsigned int xctrls_count)
+				 struct uvc_entity *entity,
+				 const struct v4l2_ext_control *xctrls,
+				 unsigned int xctrls_count)
 {
 	struct uvc_control_mapping *mapping;
 	struct uvc_control *ctrl;
@@ -1653,6 +1655,9 @@ static void uvc_ctrl_send_events(struct uvc_fh *handle,
 		u32 changes = V4L2_EVENT_CTRL_CH_VALUE;
 
 		ctrl = uvc_find_control(handle->chain, xctrls[i].id, &mapping);
+		if (ctrl->entity != entity)
+			continue;
+
 		if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
 			/* Notification will be sent from an Interrupt event. */
 			continue;
@@ -1891,11 +1896,12 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 					uvc_ctrl_find_ctrl_idx(entity, ctrls,
 							       err_ctrl);
 			goto done;
+		} else if (ret > 0 && !rollback) {
+			uvc_ctrl_send_events(handle, entity,
+					     ctrls->controls, ctrls->count);
 		}
 	}
 
-	if (!rollback)
-		uvc_ctrl_send_events(handle, ctrls->controls, ctrls->count);
 	ret = 0;
 done:
 	mutex_unlock(&chain->ctrl_mutex);
-- 
2.50.0.727.gbf7dc18ff4-goog


