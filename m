Return-Path: <stable+bounces-158547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6612CAE8361
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43CBC4A7057
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 12:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACCA261365;
	Wed, 25 Jun 2025 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W1jzIXTd"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ED225B30D
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855942; cv=none; b=UEaaTqdeRX51w7MUrMQm2TLxx5G/YYF/sRC4mo1F24hw+9WLrL75kCHbw+v/mbcEF/Tnc0LAaK7GjcfOfHV2RSKbLgR3isgTUsoxaR8glcazWxb1ryqvfEyqfdvCtxCEk5OhyXM+WHE07vg4q27t3mDDmvuqQrIvRTia3b2stAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855942; c=relaxed/simple;
	bh=Y4HG6x7O/wItcpx9MlNFE+XLgeIbbBEi3MxnJwEYbHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dgh7MkLYtvwrpFdmc4mCaKAV7Zv7yxPADFrSCxyIliatdoF6e6svZlmOiOBjCw8Z12JvYqW6jsVtgBoq7mvBYk57A0+ylqdPDh6pu+o/eS5uXkkJIbUxJwkzs1xS1EQLk0zUOf5DQ6jPAtd9TSHCLKtyLjj6GxZPCN1pPQUydDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W1jzIXTd; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32ac52f78c1so14309411fa.3
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 05:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750855939; x=1751460739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhUCV8NJF93Vdw/Z/5ds9i2JWn3i+Spb5OiJUPprZkM=;
        b=W1jzIXTdmd9sohxW/zdeLaK67mlvQ6LjQYJayZhtyaqmrtGIISWjk5EBOEjKnTWAP5
         lSaWPsxvMMNwco0a5hRe1B2bBkAIMxeYR2CaZUSe2wH40XS1grePmgcB4WbqSO5iTDqf
         nf5AMcGy1SIBaVYr7AXz2AugmLoCTUPGc1Zis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855939; x=1751460739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhUCV8NJF93Vdw/Z/5ds9i2JWn3i+Spb5OiJUPprZkM=;
        b=uiOBs38gHQ66kmecUfzQS8ioSnmiiJ9PCZ7QveXCrEkZihQ83QYLPA22r/2K8Uxgju
         SEhIYEWR0mMeQTN8FE6bFELfLQjMM+laSeG3HiwomOHuGdwBDEj37wCVKDglvnrce0HT
         bOrldSEWEU9I0+X5r/A6Rr6CrKkZN272QnIA2x5jOkUkf1r4ETNcJXjKUSK+9B1Ijk/D
         A3Tbae8vb/IKgo5n1nO1U0mmc1VR9yt2h8GD+fqt7yv7E0lxqLsVgVrRkjHBtUufbYpK
         +16kyv/IIbTJCBBYsnr5n5lP31rb7yjFPriELqC5sP4tw3jPLRwjPjBQQKFbPy27Tvuo
         4KFA==
X-Gm-Message-State: AOJu0YygleJMXCKaCgkX8J3AcCaC+tvvXbmu0gh3zPuq+8CAMJS/OllV
	Knjc81tTKh1TTl1NdbVAkLdBeBe5ZB0XydkeKWEsr9JFMYBtV8NcEiuWNsa/xK/cwTwuvCO1oB1
	n9Qw=
X-Gm-Gg: ASbGncsBI6OsNNvRNTgcRWM1ge+9mxEYILxHZEFhTtp4W1meOYAXZp5uKdj0QZC+cMf
	J3kPAxbfgcBRM9/4JNH9q45q1DvVeXxjTNac36Jr2zofFICA7E3wgPvTWviBWakLkGTT5X7o96M
	0hos8A3Sx5fQDD/VhUUXSkC6OQlOTSUF0q4jtgVhdpVtJx/Cx0Ok008p7VUG/scGqxbNDcS7fQR
	WTDZ0CFsfiuIOYJAHe25o5nJ/OTdVA/gzCBEkUcCo01ED/dEzLcapOgjB+Fdm1HRUpXGOJkMpbh
	CG2SwPThqnj12QvmCnLoE1YEYiohkjWX+sYLLts01OiDDuH10UuaSLj8hkITBxLC+mm321x5bOl
	a5LeP3Aa340YWMJ8zVEsgsFpYJRwGVd5HGxQBv1NiGEvEouo=
X-Google-Smtp-Source: AGHT+IHo4YJMi7SmlS7GRz6oF2B5yeECbRZxCinLomXb1MUfSrMmFV2kkDLnXt7e9wiDAd/RgwzVqw==
X-Received: by 2002:a2e:8847:0:b0:32b:5e32:d2a5 with SMTP id 38308e7fff4ca-32cc65784d0mr7181531fa.30.1750855938735;
        Wed, 25 Jun 2025 05:52:18 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980a3668sm19795981fa.57.2025.06.25.05.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:52:18 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	stable@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.1.y 1/3] media: uvcvideo: Return the number of processed controls
Date: Wed, 25 Jun 2025 12:52:05 +0000
Message-ID: <20250625125207.566757-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <2025062015-vocalist-panning-1ddc@gregkh>
References: <2025062015-vocalist-panning-1ddc@gregkh>
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
index 69f9f451ab40..47e3e5e5c670 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1734,12 +1734,17 @@ int uvc_ctrl_begin(struct uvc_video_chain *chain)
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
@@ -1774,6 +1779,9 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 		else
 			ret = 0;
 
+		if (!ret)
+			processed_ctrls++;
+
 		if (rollback || ret < 0)
 			memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
 			       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_BACKUP),
@@ -1792,7 +1800,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 			uvc_ctrl_set_handle(handle, ctrl, handle);
 	}
 
-	return 0;
+	return processed_ctrls;
 }
 
 static int uvc_ctrl_find_ctrl_idx(struct uvc_entity *entity,
@@ -1839,6 +1847,7 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 
 	if (!rollback)
 		uvc_ctrl_send_events(handle, ctrls->controls, ctrls->count);
+	ret = 0;
 done:
 	mutex_unlock(&chain->ctrl_mutex);
 	return ret;
-- 
2.50.0.727.gbf7dc18ff4-goog


