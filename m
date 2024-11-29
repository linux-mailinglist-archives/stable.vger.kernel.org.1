Return-Path: <stable+bounces-95845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F729DECEB
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 22:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30FD816391C
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 21:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069251A4E77;
	Fri, 29 Nov 2024 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NaYQzduX"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E10E1A0724
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732915830; cv=none; b=TnPK0ijsThyy4JyT97NE6bHNePiIUiMFeumWCFNJwimsKxCXLi+mwP0s4a5LatUNipZicOvNAQWE4G+wY4Mksr1BQNsxS8gx3lAZ0r0GbBUJMIu4d6kL48O/VYVB9ZAstLjF64qO30cYiNZR9lk2EhAxeROou7RyRTNLWKMAW/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732915830; c=relaxed/simple;
	bh=KDAOGjpXXULpZa75pLl+o8CodfY7IbmICZMYyev2FdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ozSKlbrDJNyHnN24HIgllH16yCacEVBlQlCw1k3mFi5Avlc1dR63Tprr3XSqsKqYco7EIaeJ+jGNV0FmrWuuldU1HnXB0hOoAHUcfP27VNlyIdVHkeefE0cuiZcyCCl2K3p/NFqWgoErraQUXwWWGNkj2JMAa4O9mJeRNCwAliw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NaYQzduX; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-514734208e4so636356e0c.3
        for <stable@vger.kernel.org>; Fri, 29 Nov 2024 13:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732915828; x=1733520628; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DsG2Wx3W9iEMxWqh3g5yUw4V+bP3sc1QbSYtLT8mhKI=;
        b=NaYQzduXureuKtm8f+lz5Tvdh8IrdFxPr0YwAuFJoGNwuSH8Ir9lT11NE6ebrCz2Ts
         fiPUI+u6GObFm7qjuU93nToWOIdY0h/XCX5cXLy6aSp5P50Y2lPYeGdOzNlr1+Ele2oO
         CBQh2d6L7tT7z8CASI8UN6BAoIt4cfTHd3tJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732915828; x=1733520628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsG2Wx3W9iEMxWqh3g5yUw4V+bP3sc1QbSYtLT8mhKI=;
        b=wQWSLBDQJ76HMfKbYOzYFGeqUmsoIVfldhJBZhJoGNGO0vtZbifctNidvnwHQM7zqk
         x7NzNRBSRCQevCuHpJUaBJes+bTynB0xZwfsZ+my8eAWLpF6IEIMM6PROqKuwbtSm/nW
         i3cbN3aLIebjRNfm88yschkPto3Y/eP8r0K5DnA+82R8rjSvHLdewBhuPGa61KYivCTH
         Lu1mCOuijcJIjQWIclQzVO5S4iFOcwbBoxHWCiG9bxbsAa9EdDc5hmdhUPCvHAm/McUP
         sVOqz5Gvbr/BQME1Upbd1H6xlEBH36yaO422w5wfklCv0IA/fET/TvrCuB0ugXbYRijv
         hd2w==
X-Forwarded-Encrypted: i=1; AJvYcCWRdNBeIi66hLub4c44vZh+KR9+IxALuNCgpqbaQ5N4CcU3xZr3Pq+1KyacOXGRGUhuISKdRKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMAx+ci+xmbPfmbet1NY7arlq1WLP8AZrf+zlbBTjM5JPlRKZf
	RmXlgg6U+482NbX8GCOqSc1+AHO2KIp+kcz5WgMj6tXxBySX2dFkJ7qeXWpvnw==
X-Gm-Gg: ASbGncsdsMlNpx3eofMGiRZbPPiqq2LtpC6KhonuIurpedbYUzR6jLtEHNwVpILYjkl
	oC2tGrQKFQ2tfi0hnqDQrk8wHMy/cYoWnJCDGvkydIbMgBf1do5StWIgv25lgFWkdiCtICYk6kp
	YKCngc4XnegVIlWwcnwkgW5e9n2q9e/eZPK8Ue2ONFbgqsHL+uuKYchjvbDBx1lZ9q2n9Yk/0YH
	2gGM6WQp1L9NOMmu6yPa+AAn0VxzLFw8UQXUgzbxcYwARhlulKzPuxOgGH7gm0QMwtamfV/3fiS
	96Hqnol6gHB+fv1O1HlgxuOU
X-Google-Smtp-Source: AGHT+IH/h19gXrwsr/4Bm2brThGr7h969wtQPyxlHGBXmx03EjgzxndUgkQD4dm85b4dZ4/o0JrBRw==
X-Received: by 2002:a05:6122:208f:b0:515:3bb5:5622 with SMTP id 71dfb90a1353d-51556a15ed7mr15838902e0c.12.1732915828303;
        Fri, 29 Nov 2024 13:30:28 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5156d0c1b7asm607254e0c.36.2024.11.29.13.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 13:30:27 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 21:30:15 +0000
Subject: [PATCH v4 1/4] media: uvcvideo: Do not replace the handler of an
 async ctrl
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-uvc-fix-async-v4-1-f23784dba80f@chromium.org>
References: <20241129-uvc-fix-async-v4-0-f23784dba80f@chromium.org>
In-Reply-To: <20241129-uvc-fix-async-v4-0-f23784dba80f@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

ctrl->handle was used to keep a reference to the last fh that changed an
asynchronous control.

But what we need instead, is to keep a reference to the originator of an
uncompleted operation.

We use that handle to filter control events. Under some situations, the
originator of an event shall not be notified.

In the current implementation, we unconditionally replace the handle
pointer, which can result in an invalid notification to the real
originator of the operation.

Lets fix that.

Cc: stable@vger.kernel.org
Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 2 +-
 drivers/media/usb/uvc/uvcvideo.h | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 4fe26e82e3d1..88ef8fdc2be2 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2046,7 +2046,7 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 	mapping->set(mapping, value,
 		uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
+	if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS && !ctrl->handle)
 		ctrl->handle = handle;
 
 	ctrl->dirty = 1;
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 07f9921d83f2..ce688b80e986 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -150,7 +150,10 @@ struct uvc_control {
 
 	u8 *uvc_data;
 
-	struct uvc_fh *handle;	/* File handle that last changed the control. */
+	struct uvc_fh *handle;	/*
+				 * File handle that initially changed the
+				 * async control.
+				 */
 };
 
 /*

-- 
2.47.0.338.g60cca15819-goog


