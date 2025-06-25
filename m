Return-Path: <stable+bounces-158544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E44E7AE8310
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773324A4F22
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 12:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3EC25D1E0;
	Wed, 25 Jun 2025 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EkG21x0e"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ABB2609C3
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855545; cv=none; b=uO7K8TtoIhIXu9s08f/zU2kR3Liv+XC3Nzje4co9bw61hxx4qmdvDw91z17ogVbeBiHGInub2ObYIj3AvwqNXMHYmZBNl+36iXQFTF0d4MwDUM1gQxRFS6pEgserkGsszXnkzsgVu3Q2DrtMtOQISv0DORZTrME+21/CviKkgHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855545; c=relaxed/simple;
	bh=rAhctzVIyvsQCL05FVX1YVNWlc5Go4yHnKzvw9H3Ckk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1+E75ypEyaIycHhCMXdxcxmu416iLF0m9N1uVdwrQYdidMHClJtlm8GlsYK8vcm3nhC3ka5S0ShVeBB+VB3bnNT5VoXMk6OxFNUcEj7HtrKqQL0QLTL1dUGq7nE475ZBizNQalkzLyVJXw78aIL0ibMFdz0ER2Wd6ZtL8jljmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EkG21x0e; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55351af2fc6so6701605e87.0
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 05:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750855541; x=1751460341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGBx5gs9oO8b/yGeNgJaAhyuGeE+GfAbBFnFuBSdJh4=;
        b=EkG21x0ejnn0ReZR4kbjV5BaNPg0G99gtRT0IpgwyQCwe+016CSomqitCebrQvKsON
         ZBXw+qucrQSuUL6nyAdiQxqocemSDYtGzit5E2jCsshm0kTBmgJHJNBRQv0XsgElNB0Y
         IG4Px27W0XgFo9UoVbFG7jHFPdzIUDNLOdzq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855541; x=1751460341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGBx5gs9oO8b/yGeNgJaAhyuGeE+GfAbBFnFuBSdJh4=;
        b=a8YcLP8xN68BtxOWK8AVf24LoqCth+JH5Q8mojuQmzCUOk1lgb6WZInN0m2of6+Ni1
         zfrOpiJxYRYlrHu9KGD8dTUUA4mWaOqz37N0uVX7mFeu8jxnAdIOPj/bt849m/YpFG9G
         94FAK/R6bp/ogwFVT3g4496N/H67WochxnYbs1RPZtWyG1JjjgZMyICgPsWjkLh4taSD
         pkUI47CxxmnjhD/Ope3kbctZrvKs/zEF+IqZMfU/Oz4sMqUgU8uvaLVbxWNtdStJcTxk
         vGj9DKCNpX4mvcCBPSCiKkzWhkOjM2lAu3b0H01ZqyfWo3Lr8QW9ZXo+we7ut06tUqlH
         i5eg==
X-Gm-Message-State: AOJu0YyfOfJktzeLS8LN6HRIhiHexBIFGbPfYIQV3SOq/OMhDyOutJhj
	U3M3c2WlXU4uSj6/lL5i4KMpVxUL8x06XrW4Y7moQ0HSVT1b9PhLWR17ZGPV+2joih3P4lNQN/K
	iLXE=
X-Gm-Gg: ASbGnct6S6VP3vwYb7m9uZ+TiQnWsI/eKkU3HpWZlGJPzMCGB4ZXPcGgdqNcXhTHk92
	yfQRovOOOseyJHFKlaWQXnGOTUR2o/Hll38+U9D+FNWxWqQZQGntYDLTOQXwDjGoqhHwgPbrt4u
	OI0Vs/7CSofN8V/pjdWGLXGN8SVk6TprjqtVoQCvE9figdwhz0DBF2jpxDWtDORBV4/+bOUBckk
	dbhYxvzYoF49Em6Qt0+dIL1I1gflBuuRC+U9Q0riWLp72LQISZaXgPTt+XnZVYrR1/zgdUgFC/W
	5WdS7Y9P1pq2K6LW06Wj6Wl4KBdEo58i549YUSlbxJKgvol0M8/m4J240jRqDw7HYoXa6YM7awg
	1AmvjdNS9Z49QSsfHR3h2AxLc4F0vJIXRCE54nnn4RGBd7xs=
X-Google-Smtp-Source: AGHT+IHFttFHpUZXjXy2RfdANErr4bS+uAsvdKuf4bx9M/Y71YHt1u/LQd1W3EfRg82uHgSMEbhdFg==
X-Received: by 2002:a05:6512:acd:b0:553:398f:7730 with SMTP id 2adb3069b0e04-554fdc75976mr982732e87.0.1750855540759;
        Wed, 25 Jun 2025 05:45:40 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41c4448sm2196328e87.187.2025.06.25.05.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:45:40 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	stable@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.6.y 1/3] media: uvcvideo: Return the number of processed controls
Date: Wed, 25 Jun 2025 12:45:33 +0000
Message-ID: <20250625124535.538621-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <2025062015-vessel-facility-967c@gregkh>
References: <2025062015-vessel-facility-967c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we let know our callers that we have not done anything, they will be
able to optimize their decisions.

Cc: stable@kernel.org
Fixes: b4012002f3a3 ("[media] uvcvideo: Add support for control events")
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Message-ID: <20250224-uvc-data-backup-v2-1-de993ed9823b@chromium.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
(cherry picked from commit ba4fafb02ad6a4eb2e00f861893b5db42ba54369)
---
 drivers/media/usb/uvc/uvc_ctrl.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 5926a9dfb0b1..36acc7eeff08 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1783,12 +1783,17 @@ int uvc_ctrl_begin(struct uvc_video_chain *chain)
 	return mutex_lock_interruptible(&chain->ctrl_mutex) ? -ERESTARTSYS : 0;
 }
 
+/*
+ * Returns the number of uvc controls that have been correctly set, or a
+ * negative number if there has been an error.
+ */
 static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 				  struct uvc_fh *handle,
 				  struct uvc_entity *entity,
 				  int rollback,
 				  struct uvc_control **err_ctrl)
 {
+	unsigned int processed_ctrls = 0;
 	struct uvc_control *ctrl;
 	unsigned int i;
 	int ret;
@@ -1823,6 +1828,9 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 		else
 			ret = 0;
 
+		if (!ret)
+			processed_ctrls++;
+
 		if (rollback || ret < 0)
 			memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
 			       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_BACKUP),
@@ -1841,7 +1849,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 			uvc_ctrl_set_handle(handle, ctrl, handle);
 	}
 
-	return 0;
+	return processed_ctrls;
 }
 
 static int uvc_ctrl_find_ctrl_idx(struct uvc_entity *entity,
@@ -1888,6 +1896,7 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 
 	if (!rollback)
 		uvc_ctrl_send_events(handle, ctrls->controls, ctrls->count);
+	ret = 0;
 done:
 	mutex_unlock(&chain->ctrl_mutex);
 	return ret;
-- 
2.50.0.727.gbf7dc18ff4-goog


