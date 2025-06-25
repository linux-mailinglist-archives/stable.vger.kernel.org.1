Return-Path: <stable+bounces-158538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AEBAE82C6
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A3E16C685
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 12:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6419325F7A9;
	Wed, 25 Jun 2025 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fql07i/R"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B59B258CD3
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854744; cv=none; b=FOR/C1Rx9Ldx01Ge1Unec+O7kbabH88EOuu7ZKCYmZ4j/0jksXGH/V04YwiXCasW9vHhOcIyOZQu7+FXV103UY5KXW8odhcgoBhIb33m1NLWjFijAWRStnGwS/G/nV2tgGdfI6kpcNa9OMzytnWMY8aA0trtSJnYoK2HvkpbH7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854744; c=relaxed/simple;
	bh=wrQGgQG18pFM/1GEymYZS2OYNzaasIsV2AF1V2yCcyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNiQNtMzE/Jdu9TBON6tyCM10HLpF8sSisxSxYws7CTeNOSnPXKdksD2h4nqWaSNZu+MYmPUn8OW30VjyRtohgRLRXHPnl6X4eAPGJCVvmxBZff6IHRQv815OEgzGaXQYD5fvqwKKX09B92oYFalaChKg5+TJTJACb+PpdrH+BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Fql07i/R; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-553b9eb2299so834749e87.0
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 05:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750854740; x=1751459540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Es36ifZMVhwotmSQEluOCHcaWfnp1GrdlIQ33DXs/z4=;
        b=Fql07i/Rcq1A/KtQ1DbrcJkOo5f2KAFQWoF9T0ujMj070yIwBLYNG+2F2jRWWT1YIJ
         aJyTzjxNrFSPsOFHkYCYIiMnkiFy90pxDoBpLt2Ab0fxGDaVtJ3f2rXf2wqVaQqVVnw9
         sUAGkkL5VuzKmz277xjLkzOZ7gLoB0HwlcLcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750854740; x=1751459540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Es36ifZMVhwotmSQEluOCHcaWfnp1GrdlIQ33DXs/z4=;
        b=BnpyAW53yAHe8KDcSYLQix0N0BXfsCp0yf0gwAMZSQq4wOhS4rgC2kYihvPcjJzuBf
         CQvHxRDdLI8qdH10KJs6nF0yCnpFqmQoEcb4qUNTVaAJoiuRVVUw6ReDHwNeYmTxY9Zq
         hcWQgrK60OFUucTtngz0JSphpV2kjQEy3B5jp+ygSLtAHZZv34VFv38RY1N3p4DtMs63
         ZUw3jc2gMyKrG17Hrgjty7SD7RYqvzPM/S61/meupuq812ezeJfi86Qe9g8AKtGGqTl7
         45jZxgQuvlRE91QLkiTcT9bXtBqFcDzf8SixMOv2L4rwWiwW8CnkFCgTxEOKloWCjT39
         ZPVA==
X-Gm-Message-State: AOJu0YwwsquJkGu3ToQ4CrCYBXDRgdd+ZpB+JJMfCB0d09TdD0tpW4VH
	OIqmsAoab1iqT/5vk+sXBFE6+DpUhu+WxOCL44fjgTMLLgFfMeuYU4zO1qaAPj3Frvcr1ygq0w9
	7iKQ=
X-Gm-Gg: ASbGncunE1gOc6GC4VWY+4Hmj6uaMTvnWDecTeb7h2gPCB7pByzCY1dLZ7LavUdGmvn
	SFtf6KfJGrAORxE56qRTaQDzIo7d5Dcz4wJm1R3qeCh4PhQhCNNJ5im3cj2y/ur+xuOt/+cb0sk
	3XI0TuJW0hWEj7sCRE/UiiCeh5E373o5VJLBjaDyKhuny69cUQG0aIbaP+oNThL2hICHzJdotn4
	vACXgejMaUelX/Y6I8+1+c7ZeOWiDFbMWdUNexHzWgJO4h/RRnlmtj3+FxqruK0tfdGEnDYB1Yw
	LeBQ78tSSMd2/XSAm/JPbbOS99vX6Ast8ZuU7EbX6dLQj1sFppfYsOKlPcorVTMeY4TFOIYIuVR
	qpjqEijGvi0UfZLH16vJUkWufnujp6WnsiZScEcAtboQ8nlg=
X-Google-Smtp-Source: AGHT+IFnZ1j4QWIjp2F/OiC+/84J8b4ri+99NtJX1zaeL4uPYkzVDqNJtas6SOub9KUvATXqWFJbmA==
X-Received: by 2002:a05:6512:2316:b0:554:e7ce:97f8 with SMTP id 2adb3069b0e04-554fdcdc1e1mr728514e87.15.1750854740332;
        Wed, 25 Jun 2025 05:32:20 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ea7f7cf0sm1830850e87.237.2025.06.25.05.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:32:20 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	stable@kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.15.y 2/3] media: uvcvideo: Send control events for partial succeeds
Date: Wed, 25 Jun 2025 12:32:15 +0000
Message-ID: <20250625123216.514435-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625123216.514435-1-ribalda@chromium.org>
References: <2025062014-prideful-exemplary-1838@gregkh>
 <20250625123216.514435-1-ribalda@chromium.org>
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
index 0a01c8b3625b..bc7e2005fc6c 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1943,7 +1943,9 @@ static bool uvc_ctrl_xctrls_has_control(const struct v4l2_ext_control *xctrls,
 }
 
 static void uvc_ctrl_send_events(struct uvc_fh *handle,
-	const struct v4l2_ext_control *xctrls, unsigned int xctrls_count)
+				 struct uvc_entity *entity,
+				 const struct v4l2_ext_control *xctrls,
+				 unsigned int xctrls_count)
 {
 	struct uvc_control_mapping *mapping;
 	struct uvc_control *ctrl;
@@ -1955,6 +1957,9 @@ static void uvc_ctrl_send_events(struct uvc_fh *handle,
 		s32 value;
 
 		ctrl = uvc_find_control(handle->chain, xctrls[i].id, &mapping);
+		if (ctrl->entity != entity)
+			continue;
+
 		if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
 			/* Notification will be sent from an Interrupt event. */
 			continue;
@@ -2198,11 +2203,12 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
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


