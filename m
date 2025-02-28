Return-Path: <stable+bounces-119906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EF1A49327
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 09:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 327DE7AA3D3
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 08:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA6122FF39;
	Fri, 28 Feb 2025 08:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ixrgbioJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BF122D781
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 08:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730547; cv=none; b=qha/IY31lTroVYnR2Ctr8awlf7HD250Zi4v9Z2tnrswQPgN/WFUCNrtXn3qJQSTk5p/6VTCsthgumR4AkFETLXGl/K8gu3zF7fsZ3R48zVJhe4o+/cPEj6v3FkKJ93IXUNO4kmtU7k36M60hyDotmi/jEDWzVP3sXZn125zwvO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730547; c=relaxed/simple;
	bh=qMH7NY9qUyX49C8h+cybpT/sAj/hYlKmgWescbKcH8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6C1XGmhBX/ftaxMZ/T3uUkAHNNWGXp1Oijq9VQtwcjpgvSXD1qxFQtz2knf56NB73jZPjCeYakAFXyJynqDXVd5bx5su+hYquFzi2A/eV7Cr5lSKfcT6wizBeodZntfXJMzpFtpjfNh10IClHURKlinTGG3jRO11pWWlbsfdig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ixrgbioJ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-472242b0da5so17411971cf.1
        for <stable@vger.kernel.org>; Fri, 28 Feb 2025 00:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740730544; x=1741335344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXT7nzvg4rPeVzZow+KgzQx09AWF3AWzdNW7XNPrlKQ=;
        b=ixrgbioJMKUXL4tcRUzu2L7GZkllmL1P7x6VSSnHJ01DI1t+5HrdUqN1nDyYV0irsc
         N8mSMnG+v9SJUpFjYtjEOWdm7J2fdy/IJlwcu1Qx+ZsEgeklteDHbEMDsB0n8TcpE1O6
         F0aybyPJBbcLtezrpU9f7igArgamF+/9X/GpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740730544; x=1741335344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXT7nzvg4rPeVzZow+KgzQx09AWF3AWzdNW7XNPrlKQ=;
        b=NTGaaVvuz3qIJD2U6Kl7QrBNWeE3rSnERNMZG/GnqESkRI6ul8p3O0Qdg3nj0OOz2v
         8YLqnNEFlpBSKt8/trNcPEDkh/gVgbRmUQeyH4px8rHgnI4+P80ZUNZzAdgNl65EnViz
         hOHBCZDpAf6OzRNpZHW2NOGFKZWMmD/C54ejENWLWssF+FOflsEkp+yw/VEOemJy8ofX
         kyQ5k8ip+lJEXPUA/KMGruz6+lwwZrHp3iaCENnyuyG8n3p783FEiFADlSsyIES5Fg9I
         j9UivcHl+dnJJjL/ZrCX/qCPeNewbsD66ylZFKY0DOPfUlBl8egnysCc2udmr3B+kaCT
         x4uA==
X-Gm-Message-State: AOJu0Yy0kC8IUOUE0bhEPvh3ZzODsXLqF25ilz84tvK2BU3FkWKmkdhg
	0qrMhN6FGdjQAUnEDjEUs17dlRLuGvLE8RiBbpBVQWn/FYA6vGd9+p93Nhaq7lxNcBqsscws2VK
	oqw==
X-Gm-Gg: ASbGncvRPggBan7XSMl3Js7frtAvC1yF7qRbI3qHd4dhLJSsngIdRcvR+m5hnYYBUEF
	ffniHutmMs0vbbXYFg8uy+LnGCUAqI+7cL9dUjXWMyELiLaphQacn6u/KGA9jzZspPZJ4Az2YYr
	71dpu/QP1nlrxTJsku+kx4n3fLlSNs4bmkfmIPB5RxbGaf0vAdou3xRhSfxPY3v1Mhb+NKTlzeU
	PqNcfoDQXk6ySPKuINBC373rcAXomuYBuxuWF1pYzr72ylb4lpqfvLNUBIWzKplMaXmTHCxWL6z
	PGnezuVQT2USzcVr9MRfMElkqa7ng9PhpkwPZDX4QZc3Ch2W01bVOZDEp2C22Wy7bRG7npbXlwP
	ZFy1V7T7M
X-Google-Smtp-Source: AGHT+IEBNT96q9bCYZ8rXEpMwegiRPFZjjK3B3mnsYyBaewerFgF+UJyCTCSbT0Ihwi8Tst5rf39Bw==
X-Received: by 2002:ac8:5d53:0:b0:471:fdf5:3cd7 with SMTP id d75a77b69052e-474bc0ee7eemr25707311cf.37.1740730544350;
        Fri, 28 Feb 2025 00:15:44 -0800 (PST)
Received: from denia.c.googlers.com.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4746b4f944dsm22191531cf.29.2025.02.28.00.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 00:15:42 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.15.y] media: uvcvideo: Only save async fh if success
Date: Fri, 28 Feb 2025 08:15:38 +0000
Message-ID: <20250228081538.2678441-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <2025021007-retail-context-6f8b@gregkh>
References: <2025021007-retail-context-6f8b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now we keep a reference to the active fh for any call to uvc_ctrl_set,
regardless if it is an actual set or if it is a just a try or if the
device refused the operation.

We should only keep the file handle if the device actually accepted
applying the operation.

Cc: stable@vger.kernel.org
Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Suggested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Link: https://lore.kernel.org/r/20241203-uvc-fix-async-v6-1-26c867231118@chromium.org
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
(cherry picked from commit d9fecd096f67a4469536e040a8a10bbfb665918b)
---
 drivers/media/usb/uvc/uvc_ctrl.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 050d33426582..9b8e7e31cf59 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1647,7 +1647,9 @@ int uvc_ctrl_begin(struct uvc_video_chain *chain)
 }
 
 static int uvc_ctrl_commit_entity(struct uvc_device *dev,
-	struct uvc_entity *entity, int rollback)
+				  struct uvc_fh *handle,
+				  struct uvc_entity *entity,
+				  int rollback)
 {
 	struct uvc_control *ctrl;
 	unsigned int i;
@@ -1691,6 +1693,10 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 
 		if (ret < 0)
 			return ret;
+
+		if (!rollback && handle &&
+		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
+			ctrl->handle = handle;
 	}
 
 	return 0;
@@ -1706,7 +1712,8 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 
 	/* Find the control. */
 	list_for_each_entry(entity, &chain->entities, chain) {
-		ret = uvc_ctrl_commit_entity(chain->dev, entity, rollback);
+		ret = uvc_ctrl_commit_entity(chain->dev, handle, entity,
+					     rollback);
 		if (ret < 0)
 			goto done;
 	}
@@ -1836,9 +1843,6 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 	mapping->set(mapping, value,
 		uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
-		ctrl->handle = handle;
-
 	ctrl->dirty = 1;
 	ctrl->modified = 1;
 	return 0;
@@ -2167,7 +2171,7 @@ int uvc_ctrl_restore_values(struct uvc_device *dev)
 			ctrl->dirty = 1;
 		}
 
-		ret = uvc_ctrl_commit_entity(dev, entity, 0);
+		ret = uvc_ctrl_commit_entity(dev, NULL, entity, 0);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.48.1.711.g2feabab25a-goog


