Return-Path: <stable+bounces-158564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C12ADAE8522
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 15:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A22189BA04
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 13:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25D22638BF;
	Wed, 25 Jun 2025 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nBAyUDug"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E337F262FDE
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750859318; cv=none; b=fyHcbH5ZAEbFkde81H4T6FGFFr9xdRujo0dVIayCXZUp3FExJ5yqGoZwyIC4hlXhtHM7saqd6psNRtrhXZ9n6X9dAF1DbBPraFbn0B33nL3wRzDR5WsySwd/kcJhd7DBXcUoMz1ATidnCz7o6n+GJiG0IzZg4ALXkE9xg53yagc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750859318; c=relaxed/simple;
	bh=NUcP80Ryq4MrBL2u+COepKHiCTjluelRFZoL3yn0wr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6H7LZXJt7Hbaht6KZfgUj/CRQF8fEmKh19J2oUFfAmpntdatPYBXZ5UB0Di26YiV57MhvuAK0CthXJPavEPFvTVQuxRXFnJrkhr0MjL5tc3/uhVxVxdID2aoGlHWa9/wS7V0rf28Ijn819agdtD02SsPouSZdGJiTpKt7foxBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nBAyUDug; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-553dceb342fso1420431e87.0
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 06:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750859315; x=1751464115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCYmW4ifwEvRpiStPNcPibHQnvJPHtVypD6H+91Pl/k=;
        b=nBAyUDug1CyYfJy+sPUezTYlRgMjvkOWWFw1tJS0VC/PZxS+6HULAd5IbGoQr2UGV9
         hdiOEY3t0BGxI+j4efah3DkYTcClJnZZ5nuf+1JkxGcPCRTPSZDZlQjlwn5NfRd/nDKE
         +PAqjlKqLA/FZsBcJuXkXAT++dUtsrZmTuVus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750859315; x=1751464115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCYmW4ifwEvRpiStPNcPibHQnvJPHtVypD6H+91Pl/k=;
        b=YV+Zy72rydX+LfVseTNNwMUOWxNo/RcaooJOd1lfAyYyzwzRbPIW6h0TVn6FsyhN5G
         Q/s6CVqjitg5DeTyX4LCRXkunDeFUvuuxN6KcUN/68/I1tTJNRMQhzmJHAEHooUbBRtz
         S4vz3ZD/j92fU+zvwDltO0DdesS7Y22+0X3xV0mLuQCuHMi2yJ5aDdP/Tz2tQt9IOQT8
         +A0m8NPPkmMQT2G4wIIXlY+8+nJ42gZnN7kEYNPYEME9tPNTSAVRruA8mh/JISeOJmxX
         T3K53APWRJlrSCvRi5wSCtMuNuPutk6wcrx8zlijG+cDHxLtu3OkpLeXZUxfMSjkl/6O
         sr3w==
X-Gm-Message-State: AOJu0YxFMHsG8eCR5BYHD23a9dJdRiFU1U3OkujMPoub12i2hQ9MDq6N
	m6V9I+6i3jI/nOKei4PAafo1e4SZfFDxuruMQUxE2f7Z6gzgCxiwwIFtEXAczo0SIGTeRw5XfqU
	76OQ=
X-Gm-Gg: ASbGnctT3ENN77kaN/DgOwSm5mvXAOJr6fBUBHXqtydlfbdn79MW81mhm5o72t+HJ7g
	0yiQvTXk1k0bpvqL+cwBMujcq098Yfzl/jbOB7pFHXIP0T+sAxCfSoeWYelqSMXBuZyWLX7NE/r
	5vbwRisPUcJX7a4+Bn9Acn32ydZagVRHWmoGOtBtfUF1IH6I/ZFjCFiVPlRg6xNNwvJ2MvPQ3GF
	lxddzZycZB4vcygvfnfZ6UfvNU9h1PnqsA/+JE/SyEp+c6PQZEOYfI368fKx1Do2S0nwS+rKPr7
	U5XGF/Na7JRLG+QnnAYoMbT7U5WDMxJGyley5odSJQVyIKeFkxCmyV1T79JB1tDB5AtxEqYyfNx
	bZtJau4q65JbvK8fGPaBP1rcPVG09OJM+CurbiC7+y1vM7ts=
X-Google-Smtp-Source: AGHT+IG+WI2+CgEquOxzRGqQKTYYB+VaiUQQDPShGelk/1AirQnO4cqX8MjiV9H3qfvC7wDE+2HaZA==
X-Received: by 2002:a05:6512:2521:b0:553:aea0:6ee4 with SMTP id 2adb3069b0e04-554fdcf87b9mr1004971e87.16.1750859314817;
        Wed, 25 Jun 2025 06:48:34 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41cc3e0sm2210916e87.211.2025.06.25.06.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:48:34 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	stable@kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 5.4.y 2/3] media: uvcvideo: Send control events for partial succeeds
Date: Wed, 25 Jun 2025 13:48:30 +0000
Message-ID: <20250625134831.690170-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625134831.690170-1-ribalda@chromium.org>
References: <2025062016-colonist-judo-4d84@gregkh>
 <20250625134831.690170-1-ribalda@chromium.org>
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
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 0db6bbadc593..2dac0eeed55b 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1429,7 +1429,9 @@ static bool uvc_ctrl_xctrls_has_control(const struct v4l2_ext_control *xctrls,
 }
 
 static void uvc_ctrl_send_events(struct uvc_fh *handle,
-	const struct v4l2_ext_control *xctrls, unsigned int xctrls_count)
+				 struct uvc_entity *entity,
+				 const struct v4l2_ext_control *xctrls,
+				 unsigned int xctrls_count)
 {
 	struct uvc_control_mapping *mapping;
 	struct uvc_control *ctrl;
@@ -1440,6 +1442,9 @@ static void uvc_ctrl_send_events(struct uvc_fh *handle,
 		u32 changes = V4L2_EVENT_CTRL_CH_VALUE;
 
 		ctrl = uvc_find_control(handle->chain, xctrls[i].id, &mapping);
+		if (ctrl->entity != entity)
+			continue;
+
 		if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
 			/* Notification will be sent from an Interrupt event. */
 			continue;
@@ -1638,10 +1643,11 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 					     rollback);
 		if (ret < 0)
 			goto done;
+		else if (ret > 0 && !rollback)
+			uvc_ctrl_send_events(handle, entity, xctrls,
+					     xctrls_count);
 	}
 
-	if (!rollback)
-		uvc_ctrl_send_events(handle, xctrls, xctrls_count);
 	ret = 0;
 done:
 	mutex_unlock(&chain->ctrl_mutex);
-- 
2.50.0.727.gbf7dc18ff4-goog


