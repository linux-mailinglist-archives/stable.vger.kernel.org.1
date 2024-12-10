Return-Path: <stable+bounces-100386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4379EACBD
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC4E188AB57
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F62F2343C1;
	Tue, 10 Dec 2024 09:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g0ZcH7lg"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF062343A7
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823764; cv=none; b=GqPRHRR4ONZROpe+gS5VTepreKhezZnT4zqPoVj1wDAkLMkRx/nrc5/6C8jg6bTidxXIBLIDxOg59WKFV6BrVRNrlrG9cx8iKEkM4sdOQ/THrdSKCFBDIsY8EOEZ7P9dYQ2/uMcleJ8dn+x1nMQqIg6+9vlDxG3aPC3P6qjYtWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823764; c=relaxed/simple;
	bh=rmwFzpOA42dIRXNsU2drW2dWyEvkHqz3gtgDji2Och0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HTnL7fkBJ+sP4hGTvAJu1TNjIfFlcPdRTJHpwMeeQg/FdxAE03a3grPpgGyytRwQSYLdXYi3ul0CxcEnMFfzO/CjtaMtcxtxjou+6odFfxEipsfiPNFOmYTUeDKwl3dzhpmtcOGASn8rzAA5FoB/W3i7NPmInpb6X7EYpBeHyBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g0ZcH7lg; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-467838e75ffso1367551cf.3
        for <stable@vger.kernel.org>; Tue, 10 Dec 2024 01:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733823762; x=1734428562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mgd78hYMarmsibCfxN09wNv5VkU7Kl0GIxvAEFpsb+k=;
        b=g0ZcH7lgdUKw3HuKI6e6x0CocS+EEmi8/0aZiOK6E7N7SuqVCkgmDKlG39cWCCNTiY
         Hs7v7KP3GEXtVOPu8YpXPE+vSazCyN3b8EQJCpU7gDexXouh94cdpiH+qCS2iIDu+sh2
         RFSB1h7BgEI22lGPLYDMEAUL8VOTCC6aiU8T4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823762; x=1734428562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgd78hYMarmsibCfxN09wNv5VkU7Kl0GIxvAEFpsb+k=;
        b=a9mUwDHFLsDaD5tAUCbqnHu5k1reYFSOtYVNkDIYC7+NIhzNK7Osa/OINjsywtVd86
         aHF9er7NGaG8zbvTY2aOz0225nSqOlNRBaVhdRoJQ2x8XSwj5qOZ78y+HQELmRnTnGwb
         MYOYm3xFCQsGxG5kQqQMl8Cz+FQ40rPBwP2Ke+J3q2IKhKfN0epr08/GtRrymC/fPSnB
         GGePMgOl4NkH6oDoeRchil2EQLFgrkl/Knr1pn0WpCMSRwZiH6KqvnrjTKLpNkLT+a1p
         G0Cx96lWsfkrEC7s2o1CF1Dmydc55MExxzddyrai1cvvhn5ZoLBzFhQtBpEn6o+WMUbx
         dvGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGI7+hgMEggiWkTswUkQ4DoTr98aLE+XBlywsD7j5MMDGQi3MMPSiboNE6WL0C08ChWjM2DSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywci0rhHft6SpFV/1qd/EnZa4G6H1QxCdFnURkcQzpCVtLf03Kx
	jSNoUYZrmI1+fXt+UFj09NAVz/gPYZjl6sGp05/zUrc36N6sR1cjFP6dYZXCtA==
X-Gm-Gg: ASbGncuD3H6ypMP7Z064FExemB51xnNQ0l6DazFSfw13G0fIS56EkeAp2GZ8ktMT+h/
	EBZzHJbeNJaLGrQDUCHk2RaQ4vWErq6U+JtELKuWxc7TGZtYhvXYlFMbkul0DTSVoxpLvIH2qV0
	3r/n9MmvAH8KilOp8fDho3yz2ZTTxzYiL6IImlBTYALXsjM2kvXPZ1VpWF2pYz/aTzMHflwDm1h
	f9kGr1mRqOlugigdkvyXpwCbNudEKY3ZHtnlWrbzehMYHQNQ4eahpOQA/wgT7g4haz8SvLQ2K6a
	YO/scqL+fwwYCeFfMkJDx15IBEKW
X-Google-Smtp-Source: AGHT+IEoHdjAOUrtfazsH3n6Y31nFhgn307yyWvBWJlDV472zk6B1DrShdvegUY+dN1ioRJHlGD/zg==
X-Received: by 2002:a05:6214:c25:b0:6d1:7433:3670 with SMTP id 6a1803df08f44-6d91e2d3799mr68330476d6.4.1733823762206;
        Tue, 10 Dec 2024 01:42:42 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d92f7c2bc1sm773326d6.83.2024.12.10.01.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:42:41 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 09:42:37 +0000
Subject: [PATCH v16 01/18] media: uvcvideo: Fix event flags in
 uvc_ctrl_send_events
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-uvc-roi-v16-1-e8201f7e8e57@chromium.org>
References: <20241210-uvc-roi-v16-0-e8201f7e8e57@chromium.org>
In-Reply-To: <20241210-uvc-roi-v16-0-e8201f7e8e57@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org, Yunke Cao <yunkec@google.com>
X-Mailer: b4 0.13.0

If there is an event that needs the V4L2_EVENT_CTRL_CH_FLAGS flag, all
the following events will have that flag, regardless if they need it or
not.

This is because we keep using the same variable all the time and we do
not reset its original value.

Cc: stable@vger.kernel.org
Fixes: 805e9b4a06bf ("[media] uvcvideo: Send control change events for slave ctrls when the master changes")
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Yunke Cao <yunkec@google.com>
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


